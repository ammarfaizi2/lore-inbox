Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751027AbWIHRvP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751027AbWIHRvP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Sep 2006 13:51:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751040AbWIHRvP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Sep 2006 13:51:15 -0400
Received: from mga07.intel.com ([143.182.124.22]:9538 "EHLO
	azsmga101.ch.intel.com") by vger.kernel.org with ESMTP
	id S1750958AbWIHRvO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Sep 2006 13:51:14 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,134,1157353200"; 
   d="scan'208"; a="113806242:sNHT1662452218"
Date: Fri, 8 Sep 2006 10:35:29 -0700
From: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
To: Christoph Lameter <clameter@sgi.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, npiggin@suse.de,
       mingo@elte.hu
Subject: Re: [PATCH] Fix longstanding load balancing bug in the scheduler.
Message-ID: <20060908103529.A9121@unix-os.sc.intel.com>
References: <Pine.LNX.4.64.0609061634240.13322@schroedinger.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.64.0609061634240.13322@schroedinger.engr.sgi.com>; from clameter@sgi.com on Wed, Sep 06, 2006 at 04:38:33PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 06, 2006 at 04:38:33PM -0700, Christoph Lameter wrote:
> +int cpu_of(struct rq *rq)
> +{
> +#ifdef CONFIG_SMP
> +	return rq->cpu;
> +#else
> +	return 0;
> +#endif
> +}

Is there a reason why this is not made inline?

>  static struct sched_group *
>  find_busiest_group(struct sched_domain *sd, int this_cpu,
> -		   unsigned long *imbalance, enum idle_type idle, int
> *sd_idle)
> +		   unsigned long *imbalance, enum idle_type idle, int
> *sd_idle,
> +		   cpumask_t *cpus)
>  {
>  	struct sched_group *busiest = NULL, *this = NULL, *group =
> sd->groups;
>  	unsigned long max_load, avg_load, total_load, this_load,
> total_pwr;
> @@ -2243,7 +2254,12 @@
>  		sum_weighted_load = sum_nr_running = avg_load = 0;
>  
>  		for_each_cpu_mask(i, group->cpumask) {
> -			struct rq *rq = cpu_rq(i);
> +			struct rq *rq;
> +
> +			if (!cpu_isset(i, *cpus))
> +				continue;

In normal conditions can we make this "cpus" argument NULL and only set/use it
when we run into pinned condition? That will atleast avoid unnecessary memory
test bit operations in the normal case.

thanks,
suresh
