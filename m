Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751320AbWDTFT4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751320AbWDTFT4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 01:19:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751324AbWDTFT4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 01:19:56 -0400
Received: from omta04ps.mx.bigpond.com ([144.140.83.156]:12647 "EHLO
	omta04ps.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S1751320AbWDTFTz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 01:19:55 -0400
Message-ID: <444719F8.2050602@bigpond.net.au>
Date: Thu, 20 Apr 2006 15:19:52 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
CC: akpm@osdl.org, Mike Galbraith <efault@gmx.de>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Ingo Molnar <mingo@elte.hu>,
       Con Kolivas <kernel@kolivas.org>,
       "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] smpnice: don't consider sched groups which are lightly
 loaded for balancing
References: <20060328112521.A27574@unix-os.sc.intel.com> <4429BC61.7020201@bigpond.net.au> <20060328185202.A1135@unix-os.sc.intel.com> <442A0235.1060305@bigpond.net.au> <20060329145242.A11376@unix-os.sc.intel.com> <442B1AE8.5030005@bigpond.net.au> <20060329165052.C11376@unix-os.sc.intel.com> <442B3111.5030808@bigpond.net.au> <20060401204824.A8662@unix-os.sc.intel.com> <442F7871.4030405@bigpond.net.au> <20060419182444.A5081@unix-os.sc.intel.com>
In-Reply-To: <20060419182444.A5081@unix-os.sc.intel.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta04ps.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Thu, 20 Apr 2006 05:19:53 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Siddha, Suresh B wrote:
> with smpnice, sched groups with highest priority tasks can mask the 
> imbalance between the other sched groups with in the same domain. 
> This patch fixes some of the listed down scenarios by not considering 
> the sched groups which are lightly loaded. 
> 
> a) on a simple 4-way MP system, if we have one high priority and 4 normal
> priority tasks, with smpnice we would like to see the high priority task
> scheduled on one cpu, two other cpus getting one normal task each and the
> fourth cpu getting the remaining two normal tasks. but with current smpnice
> extra normal priority task keeps jumping from one cpu to another cpu having
> the normal priority task.  This is because of the busiest_has_loaded_cpus, 
> nr_loaded_cpus logic.. We are not including the cpu with high priority 
> task in max_load calculations but including that in total and avg_load 
> calcuations.. leading to max_load < avg_load and load balance between 
> cpus running normal priority tasks(2 Vs 1) will always show imbalanace 
> as one normal priority and the extra normal priority task will keep moving 
> from one cpu to another cpu having normal priority task..
> 
> b) 4-way system with HT (8 logical processors). Package-P0 T0 has a highest 
> priority task, T1 is idle. Package-P1 Both T0 and T1 have 1 normal priority 
> task each..  P2 and P3 are idle.  With this patch, one of the normal priority 
> tasks on P1 will be moved to P2 or P3..
> 
> c) With the current weighted smp nice calculations, it doesn't always make 
> sense to look at the highest weighted runqueue in the busy group..
> Consider a load balance scenario on a DP with HT system, with Package-0 
> containing one high priority and one low priority, Package-1 containing 
> one low priority(with other thread being idle)..  Package-1 thinks that it 
> need to take the low priority thread from Package-0. And find_busiest_queue() 
> returns the cpu thread with highest priority task.. And ultimately(with help 
> of active load balance) we move high priority task to Package-1. And same 
> continues with Package-0 now, moving high priority task from package-1 to 
> package-0..  Even without the presence of active load balance, load balance 
> will fail to balance the above scenario..  Fix find_busiest_queue to use 
> "imbalance" when it is lightly loaded.

Looks neater than the original code.

Some comments in line below (including inside the patch).

> 
> To fix all the scenarios, we probably need another look at the smpnice 
> balancing patches..

I think that you should only describe the problem(s) that the patch 
fixes as this has to go into the Change Log and the ones it doesn't fix 
are of no interest there.

> 
> This patch doesn't fix this issue for example:
> 4-way simple MP system. P0 containing two high priority tasks, P1 containing
> one high priority and two normal priority tasks, one high priotity task
> each on P2, P3. Current load balance doesn't detect/fix the
> imbalance by moving one of the normal priority task running on P1 to P2 or P3.

Is this always the case or just a possibility?  Please describe the hole 
it slips through (and please do that every time you provide a scenario).

> 
> Signed-off-by: Suresh Siddha <suresh.b.siddha@intel.com>
> 
> --- linux-2.6.17-rc1/kernel/sched.c	2006-04-13 11:38:16.897333112 -0700
> +++ linux~/kernel/sched.c	2006-04-19 16:19:01.294816528 -0700
> @@ -2145,7 +2145,6 @@ find_busiest_group(struct sched_domain *
>  	unsigned long max_pull;
>  	unsigned long busiest_load_per_task, busiest_nr_running;
>  	unsigned long this_load_per_task, this_nr_running;
> -	unsigned int busiest_has_loaded_cpus = idle == NEWLY_IDLE;
>  	int load_idx;
>  
>  	max_load = this_load = total_load = total_pwr = 0;
> @@ -2200,15 +2199,8 @@ find_busiest_group(struct sched_domain *
>  			this = group;
>  			this_nr_running = sum_nr_running;
>  			this_load_per_task = sum_weighted_load;
> -		} else if (nr_loaded_cpus) {
> -			if (avg_load > max_load || !busiest_has_loaded_cpus) {
> -				max_load = avg_load;
> -				busiest = group;
> -				busiest_nr_running = sum_nr_running;
> -				busiest_load_per_task = sum_weighted_load;
> -				busiest_has_loaded_cpus = 1;
> -			}
> -		} else if (!busiest_has_loaded_cpus && avg_load > max_load) {
> +		} else if (avg_load > max_load && 

White space at the end of this line (will upset Andrew).

> +			   sum_nr_running > group->cpu_power / SCHED_LOAD_SCALE) {
>  			max_load = avg_load;
>  			busiest = group;
>  			busiest_nr_running = sum_nr_running;
> @@ -2241,6 +2233,16 @@ find_busiest_group(struct sched_domain *
>  	if (max_load <= busiest_load_per_task)
>  		goto out_balanced;
>  
> +	/*
> +	 * In the presence of smp nice balancing, certain scenarios can have
> +	 * max load less than avg load(as we skip the groups at or below
> +	 * its cpu_power, while calculating max_load..) 

Ditto.

> +	 */
> +	if (max_load < avg_load) {
> +		*imbalance = 0;
> +		goto small_imbalance;
> +	}
> +
>  	/* Don't want to pull so many tasks that a group would go idle */
>  	max_pull = min(max_load - avg_load, max_load - busiest_load_per_task);
>  
> @@ -2255,6 +2257,7 @@ find_busiest_group(struct sched_domain *
>  	 * a think about bumping its value to force at least one task to be
>  	 * moved
>  	 */
> +small_imbalance:
>  	if (*imbalance < busiest_load_per_task) {

I think small_imbalance be moved to here and save an unnecessary 
comparison. The only time busiest_load_per_task should be zero and the 
above expression fail when imbalance is zero is if the only tasks 
running in "busiest" were the migration tasks.

>  		unsigned long pwr_now = 0, pwr_move = 0;
>  		unsigned long tmp;
> @@ -2318,23 +2321,19 @@ out_balanced:
>   * find_busiest_queue - find the busiest runqueue among the cpus in group.
>   */
>  static runqueue_t *find_busiest_queue(struct sched_group *group,
> -	enum idle_type idle)
> +	enum idle_type idle, unsigned long imbalance)
>  {
>  	unsigned long max_load = 0;
>  	runqueue_t *busiest = NULL, *rqi;
> -	unsigned int busiest_is_loaded = idle == NEWLY_IDLE;
>  	int i;
>  
>  	for_each_cpu_mask(i, group->cpumask) {
>  		rqi = cpu_rq(i);
>  
> -		if (rqi->nr_running > 1) {
> -			if (rqi->raw_weighted_load > max_load || !busiest_is_loaded) {
> -				max_load = rqi->raw_weighted_load;
> -				busiest = rqi;
> -				busiest_is_loaded = 1;
> -			}
> -		} else if (!busiest_is_loaded && rqi->raw_weighted_load > max_load) {
> +		if (rqi->nr_running == 1 && rqi->raw_weighted_load > imbalance)
> +			continue;
> +
> +		if (rqi->raw_weighted_load > max_load) {
>  			max_load = rqi->raw_weighted_load;
>  			busiest = rqi;
>  		}
> @@ -2377,7 +2376,7 @@ static int load_balance(int this_cpu, ru
>  		goto out_balanced;
>  	}
>  
> -	busiest = find_busiest_queue(group, idle);
> +	busiest = find_busiest_queue(group, idle, imbalance);
>  	if (!busiest) {
>  		schedstat_inc(sd, lb_nobusyq[idle]);
>  		goto out_balanced;
> @@ -2501,7 +2500,7 @@ static int load_balance_newidle(int this
>  		goto out_balanced;
>  	}
>  
> -	busiest = find_busiest_queue(group, NEWLY_IDLE);
> +	busiest = find_busiest_queue(group, NEWLY_IDLE, imbalance);
>  	if (!busiest) {
>  		schedstat_inc(sd, lb_nobusyq[NEWLY_IDLE]);
>  		goto out_balanced;


-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
