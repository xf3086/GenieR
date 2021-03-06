#' Extraction of  sampling and coalescent times from a phylogenetic tree.
#'
#' \code{heterochronous.gp.stat} extracts sampling and coalescent times from a phylogenetic tree.
#'
#' @param phy A phylogenetic tree, which is an object of class "phylo".
#'
#'
#' @return Alist of sampling times, coalescent times, total linages.
#'
#' @references Palacios JA and Minin VN. Integrated nested Laplace approximation for Bayesian nonparametric phylodynamics, in Proceedings of the Twenty-Eighth Conference on Uncertainty in Artificial Intelligence, 2012.
#'
#' @examples
#' library(ape)
#' t1=rcoal(20)
#' heterochronous.gp.stat(t1)
#'
#'@author Fei Xiang (\email{xf3087@@gmail.com})
#'
#'
#' @export




heterochronous.gp.stat <- function(phy){
  b.s.times = branching.sampling.times(phy)
  int.ind = which(as.numeric(names(b.s.times)) < 0)
  tip.ind = which(as.numeric(names(b.s.times)) > 0)
  num.tips = length(tip.ind)
  num.coal.events = length(int.ind)
  sampl.suf.stat = rep(NA, num.coal.events)
  coal.interval = rep(NA, num.coal.events)
  coal.lineages = rep(NA, num.coal.events)
  sorted.coal.times = sort(b.s.times[int.ind])
  names(sorted.coal.times) = NULL
  #unique.sampling.times = sort(unique(b.s.times[tip.ind]))
  sampling.times = sort((b.s.times[tip.ind]))
  for (i in 2:length(sampling.times)){
    if ((sampling.times[i]-sampling.times[i-1])<1e-6){
      sampling.times[i]<-sampling.times[i-1]}
  }
  unique.sampling.times<-unique(sampling.times)
  sampled.lineages = NULL
  for (sample.time in unique.sampling.times){
    sampled.lineages = c(sampled.lineages,
                         sum(sampling.times == sample.time))
  }
  return(list(coal.times=sorted.coal.times, sample.times = unique.sampling.times, sampled.lineages=sampled.lineages))
}


