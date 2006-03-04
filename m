Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750841AbWCDCdv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750841AbWCDCdv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 21:33:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751274AbWCDCdv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 21:33:51 -0500
Received: from omta05ps.mx.bigpond.com ([144.140.83.195]:3182 "EHLO
	omta05ps.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S1750841AbWCDCdv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 21:33:51 -0500
Message-ID: <4408FC8B.4050802@bigpond.net.au>
Date: Sat, 04 Mar 2006 13:33:47 +1100
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mike Galbraith <efault@gmx.de>
CC: lkml <linux-kernel@vger.kernel.org>, mingo@elte.hu, kernel@kolivas.org,
       nickpiggin@yahoo.com.au, "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [patch 2.6.16-rc5-mm2]  sched_cleanup-V17 - task throttling patch
 1 of 2
References: <1140183903.14128.77.camel@homer>	 <1140812981.8713.35.camel@homer>  <20060224141505.41b1a627.akpm@osdl.org>	 <1140834190.7641.25.camel@homer> <1141382609.8768.57.camel@homer>
In-Reply-To: <1141382609.8768.57.camel@homer>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta05ps.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Sat, 4 Mar 2006 02:33:47 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Galbraith wrote:
> Greetings,
> 
> Below, please find part 1 of my latest task throttling effort.  I've
> very nearly completely reworked it from top to bottom, and broken it
> down into separate cleanup and a throttling diffs.
> 
> Main things that this diff does:
> 
> 1. Closes a generic hole in the scheduler design:  due to timeslice
> sample rate of HZ, tasks can and do steal time from each other.
> Generally this is no big deal, because statistics more or less even
> things out, but tasks with a high scheduling frequency and a low
> execution duration can steal considerable time.  No longer.
> 
> 2. Removes overhead from the fast path.  There's no need to do division
> in the fast path, it's cheaper to do it at timeslice refresh time, where
> it accomplishes the same thing at a fraction of the cost.  Trades a
> subtraction for a division, and removes the obsoleted bits that led to
> the division.
> 
> I have verified that the testcase sent in by David Mosberg ages ago, and
> which was the prime motivator for going to nanosecond timings in the
> scheduler in the first place, is not broken by the above changes.
> 
> 3. Removes the disparity in the handling of dynamic priority for kernel
> threads verses user-land tasks.
> 
> 4. Fixes a boot-time buglet where the TSC isn't synchronized yet,
> resulting in recalc_task_prio() being called with now < p->timestamp.
> If you place a WARN_ON there, the box won't even boot.  With this fix,
> you'll get one warning, and then all goes fine.
>  
> 5. Fixes a couple of would-be bugs if anyone ever decided to use
> TASK_NONINTERACTIVE thing along with TASK_UNINTERRUPTIBLE.
> 
> 6. Removes sleep_avg multiplier.  Back when we had 10s of dynamic range,
> this was needed to help get interactive tasks up to speed.  The 10 time
> speedup meant that a 1s sleep put us at max priority.  Worked great.  As
> we speak however, we have _1_ second of dynamic range, and this gets
> compressed to 100ms by the multiplier.  This is very bad, and to see how
> bad, just try a very modest parallel kernel compile in a relatively slow
> NFS mounted filesystem.  In heavy testing, I can find no detriment to
> removing this anachronism.
> 
> 7. Assorted cleanups to the interactivity logic.
> 
> 8. Whatever I forgot to mention ;-)
> 
> Comments?
> 
> 	-Mike
> 
> Signed-off-by Mike Galbraith <efault@gmx.de>
> 
>  include/linux/sched.h |    3 -
>  kernel/sched.c        |  136 +++++++++++++++++++++++++++++---------------------
>  2 files changed, 82 insertions(+), 57 deletions(-)
> 
> --- linux-2.6.16-rc5-mm2/include/linux/sched.h.org	2006-03-01 15:06:22.000000000 +0100
> +++ linux-2.6.16-rc5-mm2/include/linux/sched.h	2006-03-02 08:33:12.000000000 +0100
> @@ -720,7 +720,8 @@
>  
>  	unsigned long policy;
>  	cpumask_t cpus_allowed;
> -	unsigned int time_slice, first_time_slice;
> +	int time_slice;

Can you guarantee that int is big enough to hold a time slice in 
nanoseconds on all systems?  I think that you'll need more than 16 bits.

> +	unsigned int first_time_slice;
>  
>  #ifdef CONFIG_SCHEDSTATS
>  	struct sched_info sched_info;
> --- linux-2.6.16-rc5-mm2/kernel/sched.c.org	2006-03-01 15:05:56.000000000 +0100
> +++ linux-2.6.16-rc5-mm2/kernel/sched.c	2006-03-02 10:05:47.000000000 +0100
> @@ -99,6 +99,10 @@
>  #define MAX_SLEEP_AVG		(DEF_TIMESLICE * MAX_BONUS)
>  #define STARVATION_LIMIT	(MAX_SLEEP_AVG)
>  #define NS_MAX_SLEEP_AVG	(JIFFIES_TO_NS(MAX_SLEEP_AVG))
> +#define NS_MAX_SLEEP_AVG_PCNT	(NS_MAX_SLEEP_AVG / 100)
> +#define PCNT_PER_DYNPRIO	(100 / MAX_BONUS)
> +#define NS_PER_DYNPRIO		(PCNT_PER_DYNPRIO * NS_MAX_SLEEP_AVG_PCNT)
> +#define NS_TICK			(JIFFIES_TO_NS(1))
>  
>  /*
>   * If a task is 'interactive' then we reinsert it in the active
> @@ -153,9 +157,25 @@
>  #define TASK_INTERACTIVE(p) \
>  	((p)->prio <= (p)->static_prio - DELTA(p))
>  
> -#define INTERACTIVE_SLEEP(p) \
> -	(JIFFIES_TO_NS(MAX_SLEEP_AVG * \
> -		(MAX_BONUS / 2 + DELTA((p)) + 1) / MAX_BONUS - 1))
> +#define SLEEP_AVG_DIVISOR(p) (1 + CURRENT_BONUS(p))
> +
> +#define INTERACTIVE_SLEEP_AVG(p) \
> +	(min(JIFFIES_TO_NS(MAX_SLEEP_AVG * (MAX_BONUS / 2 + DELTA(p)) / \
> +	MAX_BONUS), NS_MAX_SLEEP_AVG))
> +
> +/*
> + * Returns whether a task has been asleep long enough to be considered idle.
> + * The metric is whether this quantity of sleep would promote the task more
> + * than one priority beyond marginally interactive.
> + */
> +static int task_interactive_idle(task_t *p, unsigned long sleep_time)
> +{
> +	unsigned long ceiling = (CURRENT_BONUS(p) + 2) * NS_PER_DYNPRIO;
> +
> +	if (p->sleep_avg + sleep_time < ceiling)
> +		return 0;
> +	return p->sleep_avg + sleep_time >= INTERACTIVE_SLEEP_AVG(p);
> +}
>  
>  #define TASK_PREEMPTS_CURR(p, rq) \
>  	((p)->prio < (rq)->curr->prio)
> @@ -182,7 +202,7 @@
>  
>  static inline unsigned int task_timeslice(task_t *p)
>  {
> -	return static_prio_timeslice(p->static_prio);
> +	return JIFFIES_TO_NS(static_prio_timeslice(p->static_prio));
>  }
>  
>  #define task_hot(p, now, sd) ((long long) ((now) - (p)->last_ran)	\
> @@ -240,6 +260,7 @@
>  
>  	unsigned long expired_timestamp;
>  	unsigned long long timestamp_last_tick;
> +	unsigned long long timestamp_last_switch;
>  	task_t *curr, *idle;
>  	struct mm_struct *prev_mm;
>  	prio_array_t *active, *expired, arrays[2];
> @@ -777,6 +798,9 @@
>  	unsigned long long __sleep_time = now - p->timestamp;
>  	unsigned long sleep_time;
>  
> +	if (unlikely(now < p->timestamp))
> +		__sleep_time = 0ULL;
> +
>  	if (unlikely(p->policy == SCHED_BATCH))
>  		sleep_time = 0;
>  	else {
> @@ -788,32 +812,32 @@
>  
>  	if (likely(sleep_time > 0)) {
>  		/*
> -		 * User tasks that sleep a long time are categorised as
> -		 * idle. They will only have their sleep_avg increased to a
> +		 * Tasks that sleep a long time are categorised as idle.
> +		 * They will only have their sleep_avg increased to a
>  		 * level that makes them just interactive priority to stay
>  		 * active yet prevent them suddenly becoming cpu hogs and
>  		 * starving other processes.
>  		 */
> -		if (p->mm && sleep_time > INTERACTIVE_SLEEP(p)) {
> -				unsigned long ceiling;
> -
> -				ceiling = JIFFIES_TO_NS(MAX_SLEEP_AVG -
> -					DEF_TIMESLICE);
> -				if (p->sleep_avg < ceiling)
> -					p->sleep_avg = ceiling;
> -		} else {
> +		if (task_interactive_idle(p, sleep_time)) {
> +			unsigned long ceiling = INTERACTIVE_SLEEP_AVG(p);
>  
>  			/*
> -			 * The lower the sleep avg a task has the more
> -			 * rapidly it will rise with sleep time. This enables
> -			 * tasks to rapidly recover to a low latency priority.
> -			 * If a task was sleeping with the noninteractive
> -			 * label do not apply this non-linear boost
> +			 * Promote previously interactive task.
>  			 */
> -			if (p->sleep_type != SLEEP_NONINTERACTIVE || !p->mm)
> -				sleep_time *=
> -					(MAX_BONUS - CURRENT_BONUS(p)) ? : 1;
> +			if (p->sleep_avg > ceiling) {
> +				ceiling = p->sleep_avg / NS_PER_DYNPRIO;
> +				if (ceiling < MAX_BONUS)
> +					ceiling++;
> +				ceiling *= NS_PER_DYNPRIO;
> +			} else {
> +				ceiling += p->time_slice >> 2;
> +				if (ceiling > NS_MAX_SLEEP_AVG)
> +					ceiling = NS_MAX_SLEEP_AVG;
> +			}
>  
> +			if (p->sleep_avg < ceiling)
> +				p->sleep_avg = ceiling;
> +		} else {
>  			/*
>  			 * This code gives a bonus to interactive tasks.
>  			 *
> @@ -1367,7 +1391,8 @@
>  
>  out_activate:
>  #endif /* CONFIG_SMP */
> -	if (old_state == TASK_UNINTERRUPTIBLE) {
> +
> +	if (old_state & TASK_UNINTERRUPTIBLE) {
>  		rq->nr_uninterruptible--;
>  		/*
>  		 * Tasks waking from uninterruptible sleep are likely
> @@ -1461,6 +1486,8 @@
>  	 */
>  	local_irq_disable();
>  	p->time_slice = (current->time_slice + 1) >> 1;
> +	if (unlikely(p->time_slice < NS_TICK))
> +		p->time_slice = NS_TICK;
>  	/*
>  	 * The remainder of the first timeslice might be recovered by
>  	 * the parent if the child exits early enough.
> @@ -1468,13 +1495,12 @@
>  	p->first_time_slice = 1;
>  	current->time_slice >>= 1;
>  	p->timestamp = sched_clock();
> -	if (unlikely(!current->time_slice)) {
> +	if (unlikely(current->time_slice < NS_TICK)) {
>  		/*
>  		 * This case is rare, it happens when the parent has only
>  		 * a single jiffy left from its timeslice. Taking the
>  		 * runqueue lock is not a problem.
>  		 */
> -		current->time_slice = 1;
>  		scheduler_tick();
>  	}
>  	local_irq_enable();
> @@ -2586,6 +2612,7 @@
>  {
>  	unsigned long long last = max(p->timestamp, rq->timestamp_last_tick);
>  	p->sched_time += now - last;
> +	p->time_slice -= now - last;
>  }
>  
>  /*
> @@ -2735,8 +2762,8 @@
>  		 * RR tasks need a special form of timeslice management.
>  		 * FIFO tasks have no timeslices.
>  		 */
> -		if ((p->policy == SCHED_RR) && !--p->time_slice) {
> -			p->time_slice = task_timeslice(p);
> +		if ((p->policy == SCHED_RR) && p->time_slice < NS_TICK) {
> +			p->time_slice += task_timeslice(p);
>  			p->first_time_slice = 0;
>  			set_tsk_need_resched(p);
>  
> @@ -2745,11 +2772,21 @@
>  		}
>  		goto out_unlock;
>  	}
> -	if (!--p->time_slice) {
> +	if (p->time_slice < NS_TICK) {
> +		int time_slice = task_timeslice(p);
> +		int run_time = time_slice - p->time_slice;
>  		dequeue_task(p, rq->active);
>  		set_tsk_need_resched(p);
> +		p->time_slice += time_slice;
> +		/*
> +		 * Tasks are charged proportionately less run_time at high
> +		 * sleep_avg to delay them losing their interactive status
> +		 */
> +		run_time /= SLEEP_AVG_DIVISOR(p);
> +		p->sleep_avg -= run_time;
> +		if ((long)p->sleep_avg < 0)
> +			p->sleep_avg = 0;
>  		p->prio = effective_prio(p);
> -		p->time_slice = task_timeslice(p);
>  		p->first_time_slice = 0;
>  
>  		if (!rq->expired_timestamp)
> @@ -2777,13 +2814,17 @@
>  		 * This only applies to tasks in the interactive
>  		 * delta range with at least TIMESLICE_GRANULARITY to requeue.
>  		 */
> -		if (TASK_INTERACTIVE(p) && !((task_timeslice(p) -
> -			p->time_slice) % TIMESLICE_GRANULARITY(p)) &&
> -			(p->time_slice >= TIMESLICE_GRANULARITY(p)) &&
> -			(p->array == rq->active)) {
> +		if (p->array == rq->active) {
> +			unsigned long runtime, period;
>  
> -			requeue_task(p, rq->active);
> -			set_tsk_need_resched(p);
> +			runtime = now - rq->timestamp_last_switch;
> +			period = JIFFIES_TO_NS(TIMESLICE_GRANULARITY(p));
> +
> +			if (runtime >= period && p->time_slice >> 1 >= period) {
> +				requeue_task(p, rq->active);
> +				set_tsk_need_resched(p);
> +				rq->timestamp_last_switch = now;
> +			}
>  		}
>  	}
>  out_unlock:
> @@ -2851,7 +2892,8 @@
>   */
>  static inline unsigned long smt_slice(task_t *p, struct sched_domain *sd)
>  {
> -	return p->time_slice * (100 - sd->per_cpu_gain) / 100;
> +	int time_slice = NS_TO_JIFFIES(p->time_slice) ? : 1;
> +	return time_slice * (100 - sd->per_cpu_gain) / 100;
>  }
>  
>  static int dependent_sleeper(int this_cpu, runqueue_t *this_rq)
> @@ -3014,7 +3056,6 @@
>  	prio_array_t *array;
>  	struct list_head *queue;
>  	unsigned long long now;
> -	unsigned long run_time;
>  	int cpu, idx, new_prio;
>  
>  	/*
> @@ -3050,19 +3091,6 @@
>  
>  	schedstat_inc(rq, sched_cnt);
>  	now = sched_clock();
> -	if (likely((long long)(now - prev->timestamp) < NS_MAX_SLEEP_AVG)) {
> -		run_time = now - prev->timestamp;
> -		if (unlikely((long long)(now - prev->timestamp) < 0))
> -			run_time = 0;
> -	} else
> -		run_time = NS_MAX_SLEEP_AVG;
> -
> -	/*
> -	 * Tasks charged proportionately less run_time at high sleep_avg to
> -	 * delay them losing their interactive status
> -	 */
> -	run_time /= (CURRENT_BONUS(prev) ? : 1);
> -
>  	spin_lock_irq(&rq->lock);
>  
>  	if (unlikely(prev->flags & PF_DEAD))
> @@ -3075,7 +3103,7 @@
>  				unlikely(signal_pending(prev))))
>  			prev->state = TASK_RUNNING;
>  		else {
> -			if (prev->state == TASK_UNINTERRUPTIBLE)
> +			if (prev->state & TASK_UNINTERRUPTIBLE)
>  				rq->nr_uninterruptible++;
>  			deactivate_task(prev, rq);
>  		}
> @@ -3136,7 +3164,6 @@
>  		if (next->sleep_type == SLEEP_INTERACTIVE)
>  			delta = delta * (ON_RUNQUEUE_WEIGHT * 128 / 100) / 128;
>  
> -		array = next->array;
>  		new_prio = recalc_task_prio(next, next->timestamp + delta);
>  
>  		if (unlikely(next->prio != new_prio)) {
> @@ -3156,14 +3183,11 @@
>  
>  	update_cpu_clock(prev, rq, now);
>  
> -	prev->sleep_avg -= run_time;
> -	if ((long)prev->sleep_avg <= 0)
> -		prev->sleep_avg = 0;
>  	prev->timestamp = prev->last_ran = now;
>  
>  	sched_info_switch(prev, next);
>  	if (likely(prev != next)) {
> -		next->timestamp = now;
> +		next->timestamp = rq->timestamp_last_switch = now;
>  		rq->nr_switches++;
>  		rq->curr = next;
>  		++*switch_count;
> 


-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
