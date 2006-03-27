Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751271AbWC0Vw3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751271AbWC0Vw3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Mar 2006 16:52:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751474AbWC0Vw3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Mar 2006 16:52:29 -0500
Received: from fmr21.intel.com ([143.183.121.13]:61620 "EHLO
	scsfmr001.sc.intel.com") by vger.kernel.org with ESMTP
	id S1751271AbWC0Vw3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Mar 2006 16:52:29 -0500
Date: Mon, 27 Mar 2006 13:52:04 -0800
From: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
To: Peter Williams <pwil3058@bigpond.net.au>
Cc: Andrew Morton <akpm@osdl.org>,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       Mike Galbraith <efault@gmx.de>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Ingo Molnar <mingo@elte.hu>,
       "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       Con Kolivas <kernel@kolivas.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched: prevent high load weight tasks suppressing balancing
Message-ID: <20060327135204.B12364@unix-os.sc.intel.com>
References: <4427873A.4010601@bigpond.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <4427873A.4010601@bigpond.net.au>; from pwil3058@bigpond.net.au on Mon, Mar 27, 2006 at 05:33:30PM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This breaks HT and MC optimizations.. Consider a DP system with each
physical processor having two HT logical threads.. if there are two 
runnable processes running on package-0, with this patch scheduler 
will never move one of those processes to package-1..

thanks,
suresh

On Mon, Mar 27, 2006 at 05:33:30PM +1100, Peter Williams wrote:
> Problem:
> 
> On systems with more than 2 CPUs it is possible for a single task with a 
> high smpnice load weight to suppress load balancing on other CPUs (to 
> the one that it's running on) if it is the only runnable task on its 
> CPU. E.g. consider a 4-way system (simple SMP system with no HT and 
> cores) scenario where a high priority task (nice-20) is running on P0 
> and two normal priority tasks running on P1. load balance with smp nice 
> code will never be able to detect an imbalance and hence will never move 
> one of the normal priority tasks on P1 to idle cpus P2 or P3 as P0 will 
> always be identified as the busiest CPU but it has no tasks that can be 
> moved.
> 
> Solution:
> 
> Make sure that only CPUs with tasks that can be moved get selected as 
> the busiest queue.  This involves ensuring that find_busiest_group() 
> only considers groups that have at least one CPU with more than one task 
> running as candidates for the busiest group and that 
> find_busiest_queue() only considers CPUs that have more than one task 
> running as candidates for the busiest run queue.
> 
> One effect of this is that load balancing will be abandoned earlier in 
> the sequence (i.e. before the double run queue locks are taken prior to 
> calling move_tasks() rather than in move_tasks() itself) when there are 
> no tasks that can be moved than would be the case without this patch.
> 
> Signed-off-by: Peter Williams <pwil3058@bigpond.com.au>
> 
> Peter
> PS This doesn't take into account tasks that can't be moved because they 
> are pinned to a particular CPU.  At this stage, I don't think that it's 
> worth the effort to make the changes that would enable this.
> -- 
> Peter Williams                                   pwil3058@bigpond.net.au
> 
> "Learning, n. The kind of ignorance distinguishing the studious."
>   -- Ambrose Bierce

> Index: MM-2.6.X/kernel/sched.c
> ===================================================================
> --- MM-2.6.X.orig/kernel/sched.c	2006-03-27 16:00:12.000000000 +1100
> +++ MM-2.6.X/kernel/sched.c	2006-03-27 17:02:53.000000000 +1100
> @@ -2115,6 +2115,7 @@ find_busiest_group(struct sched_domain *
>  		int local_group;
>  		int i;
>  		unsigned long sum_nr_running, sum_weighted_load;
> +		unsigned int nr_loaded_cpus = 0; /* where nr_running > 1 */
>  
>  		local_group = cpu_isset(this_cpu, group->cpumask);
>  
> @@ -2135,6 +2136,8 @@ find_busiest_group(struct sched_domain *
>  
>  			avg_load += load;
>  			sum_nr_running += rq->nr_running;
> +			if (rq->nr_running > 1)
> +				++nr_loaded_cpus;
>  			sum_weighted_load += rq->raw_weighted_load;
>  		}
>  
> @@ -2149,7 +2152,7 @@ find_busiest_group(struct sched_domain *
>  			this = group;
>  			this_nr_running = sum_nr_running;
>  			this_load_per_task = sum_weighted_load;
> -		} else if (avg_load > max_load) {
> +		} else if (avg_load > max_load && nr_loaded_cpus) {
>  			max_load = avg_load;
>  			busiest = group;
>  			busiest_nr_running = sum_nr_running;
> @@ -2158,7 +2161,7 @@ find_busiest_group(struct sched_domain *
>  		group = group->next;
>  	} while (group != sd->groups);
>  
> -	if (!busiest || this_load >= max_load || busiest_nr_running <= 1)
> +	if (!busiest || this_load >= max_load)
>  		goto out_balanced;
>  
>  	avg_load = (SCHED_LOAD_SCALE * total_load) / total_pwr;
> @@ -2260,16 +2263,16 @@ out_balanced:
>  static runqueue_t *find_busiest_queue(struct sched_group *group,
>  	enum idle_type idle)
>  {
> -	unsigned long load, max_load = 0;
> -	runqueue_t *busiest = NULL;
> +	unsigned long max_load = 0;
> +	runqueue_t *busiest = NULL, *rqi;
>  	int i;
>  
>  	for_each_cpu_mask(i, group->cpumask) {
> -		load = weighted_cpuload(i);
> +		rqi = cpu_rq(i);
>  
> -		if (load > max_load) {
> -			max_load = load;
> -			busiest = cpu_rq(i);
> +		if (rqi->raw_weighted_load > max_load && rqi->nr_running > 1) {
> +			max_load = rqi->raw_weighted_load;
> +			busiest = rqi;
>  		}
>  	}
>  

