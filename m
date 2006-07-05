Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932368AbWGEAoY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932368AbWGEAoY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 20:44:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932369AbWGEAoY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 20:44:24 -0400
Received: from mail27.syd.optusnet.com.au ([211.29.133.168]:53966 "EHLO
	mail27.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S932368AbWGEAoX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 20:44:23 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Peter Williams <pwil3058@bigpond.net.au>
Subject: Re: [PATCH] sched: Add SCHED_BGND (background) scheduling policy
Date: Wed, 5 Jul 2006 10:44:04 +1000
User-Agent: KMail/1.9.3
Cc: Andrew Morton <akpm@osdl.org>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>
References: <20060704233521.8744.45368.sendpatchset@heathwren.pw.nest>
In-Reply-To: <20060704233521.8744.45368.sendpatchset@heathwren.pw.nest>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607051044.05257.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

some quick comments within code below.

On Wednesday 05 July 2006 09:35, Peter Williams wrote:
> ---
>  include/linux/init_task.h |    6 -
>  include/linux/sched.h     |   11 ++
>  kernel/fork.c             |    1
>  kernel/mutex.c            |   28 ++++++-
>  kernel/sched.c            |  183
> ++++++++++++++++++++++++++++++++++++++-------- 5 files changed, 192
> insertions(+), 37 deletions(-)
>
> Index: MM-2.6.17-mm6/include/linux/init_task.h
> ===================================================================
> --- MM-2.6.17-mm6.orig/include/linux/init_task.h	2006-07-04
> 14:37:42.000000000 +1000 +++
> MM-2.6.17-mm6/include/linux/init_task.h	2006-07-04 14:38:12.000000000 +1000
> @@ -99,9 +99,9 @@ extern struct group_info init_groups;
>  	.usage		= ATOMIC_INIT(2),				\
>  	.flags		= 0,						\
>  	.lock_depth	= -1,						\
> -	.prio		= MAX_PRIO-20,					\
> -	.static_prio	= MAX_PRIO-20,					\
> -	.normal_prio	= MAX_PRIO-20,					\
> +	.prio		= MAX_RT_PRIO+20,				\
> +	.static_prio	= MAX_RT_PRIO+20,				\
> +	.normal_prio	= MAX_RT_PRIO+20,				\
>  	.policy		= SCHED_NORMAL,					\
>  	.cpus_allowed	= CPU_MASK_ALL,					\
>  	.mm		= NULL,						\
> Index: MM-2.6.17-mm6/include/linux/sched.h
> ===================================================================
> --- MM-2.6.17-mm6.orig/include/linux/sched.h	2006-07-04 14:37:43.000000000
> +1000 +++ MM-2.6.17-mm6/include/linux/sched.h	2006-07-04 14:38:12.000000000
> +1000 @@ -34,6 +34,8 @@
>  #define SCHED_FIFO		1
>  #define SCHED_RR		2
>  #define SCHED_BATCH		3
> +/* Scheduler class for background tasks */
> +#define SCHED_BGND		4
>
>  #ifdef __KERNEL__
>
> @@ -503,13 +505,16 @@ struct signal_struct {
>  #define MAX_USER_RT_PRIO	100
>  #define MAX_RT_PRIO		MAX_USER_RT_PRIO
>
> -#define MAX_PRIO		(MAX_RT_PRIO + 40)
> +#define BGND_PRIO		(MAX_RT_PRIO + 40)
> +/* add another slot for SCHED_BGND tasks */
> +#define MAX_PRIO		(BGND_PRIO + 1)
>
>  #define rt_prio(prio)		unlikely((prio) < MAX_RT_PRIO)
>  #define rt_task(p)		rt_prio((p)->prio)
>  #define batch_task(p)		(unlikely((p)->policy == SCHED_BATCH))
>  #define has_rt_policy(p) \
> -	unlikely((p)->policy != SCHED_NORMAL && (p)->policy != SCHED_BATCH)
> +	unlikely((p)->policy != SCHED_NORMAL && (p)->policy < SCHED_BATCH)

idleprio tasks should be able to get rt_policy as well

> +#define bgnd_task(p)		(unlikely((p)->policy == SCHED_BGND))
>
>  /*
>   * Some day this will be a full-fledged user tracking system..
> @@ -810,6 +815,7 @@ struct task_struct {
>  	unsigned long sleep_avg;
>  	unsigned long long timestamp, last_ran;
>  	unsigned long long sched_time; /* sched_clock time spent running */
> +	unsigned int mutexes_held; /* for knowing when it's safe to repress
> SCHED_BGND tasks */ enum sleep_type sleep_type;
>
>  	unsigned long policy;
> @@ -1090,6 +1096,7 @@ static inline void put_task_struct(struc
>  #define PF_SWAPWRITE	0x00800000	/* Allowed to write to swap */
>  #define PF_SPREAD_PAGE	0x01000000	/* Spread page cache over cpuset */
>  #define PF_SPREAD_SLAB	0x02000000	/* Spread some slab caches over cpuset
> */ +#define PF_UIWAKE	0x08000000	/* Just woken from uninterrptible sleep */
> #define PF_MEMPOLICY	0x10000000	/* Non-default NUMA mempolicy */
>  #define PF_MUTEX_TESTER	0x20000000	/* Thread belongs to the rt mutex
> tester */
>
> Index: MM-2.6.17-mm6/kernel/sched.c
> ===================================================================
> --- MM-2.6.17-mm6.orig/kernel/sched.c	2006-07-04 14:37:43.000000000 +1000
> +++ MM-2.6.17-mm6/kernel/sched.c	2006-07-04 14:38:12.000000000 +1000
> @@ -59,7 +59,7 @@
>
>  /*
>   * Convert user-nice values [ -20 ... 0 ... 19 ]
> - * to static priority [ MAX_RT_PRIO..MAX_PRIO-1 ],
> + * to static priority [ MAX_RT_PRIO..BGND_PRIO-1 ],
>   * and back.
>   */
>  #define NICE_TO_PRIO(nice)	(MAX_RT_PRIO + (nice) + 20)
> @@ -73,7 +73,7 @@
>   */
>  #define USER_PRIO(p)		((p)-MAX_RT_PRIO)
>  #define TASK_USER_PRIO(p)	USER_PRIO((p)->static_prio)
> -#define MAX_USER_PRIO		(USER_PRIO(MAX_PRIO))
> +#define MAX_USER_PRIO		(USER_PRIO(BGND_PRIO))
>
>  /*
>   * Some helpers for converting nanosecond timing to jiffy resolution
> @@ -171,7 +171,7 @@
>   */
>
>  #define SCALE_PRIO(x, prio) \
> -	max(x * (MAX_PRIO - prio) / (MAX_USER_PRIO / 2), MIN_TIMESLICE)
> +	max(x * (BGND_PRIO - prio) / (MAX_USER_PRIO / 2), MIN_TIMESLICE)
>
>  static unsigned int static_prio_timeslice(int static_prio)
>  {
> @@ -186,6 +186,11 @@ static inline unsigned int task_timeslic
>  	return static_prio_timeslice(p->static_prio);
>  }
>
> +#define task_in_background(p) unlikely((p)->prio == BGND_PRIO)
> +#define safe_to_background(p) \
> +	(!((p)->mutexes_held || \
> +	   (p)->flags & (PF_FREEZE | PF_UIWAKE | PF_EXITING)))
> +
>  /*
>   * These are the runqueue data structures:
>   */
> @@ -715,13 +720,17 @@ static inline int __normal_prio(struct t
>  {
>  	int bonus, prio;
>
> +	/* Ensure that background tasks stay at BGND_PRIO */
> +	if (bgnd_task(p) && safe_to_background(p))
> +		return BGND_PRIO;
> +
>  	bonus = CURRENT_BONUS(p) - MAX_BONUS / 2;
>
>  	prio = p->static_prio - bonus;
>  	if (prio < MAX_RT_PRIO)
>  		prio = MAX_RT_PRIO;
> -	if (prio > MAX_PRIO-1)
> -		prio = MAX_PRIO-1;
> +	if (prio > BGND_PRIO-1)
> +		prio = BGND_PRIO-1;
>  	return prio;
>  }
>
> @@ -761,8 +770,18 @@ static void set_load_weight(struct task_
>  		else
>  #endif
>  			p->load_weight = RTPRIO_TO_LOAD_WEIGHT(p->rt_priority);
> -	} else
> -		p->load_weight = PRIO_TO_LOAD_WEIGHT(p->static_prio);
> +	} else {
> +		/*
> +		 * Reduce the probability of a task escaping the background
> +		 * due to load balancing leaving it on a lighly used CPU
> +		 * Can't use zero as that would kill load balancing when only
> +		 * background tasks are running.
> +		 */
> +		if (bgnd_task(p))
> +			p->load_weight = LOAD_WEIGHT(MIN_TIMESLICE / 2 ? : 1);

Why not just set it to 1 for all idleprio tasks? The granularity will be lost 
at anything lower anyway and it avoids a more complex calculation.

> +		else
> +			p->load_weight = PRIO_TO_LOAD_WEIGHT(p->static_prio);
> +	}
>  }
>
>  static inline void
> @@ -834,7 +853,10 @@ static void __activate_task(struct task_
>  {
>  	struct prio_array *target = rq->active;
>
> -	if (batch_task(p))
> +	/* Don't punish batch tasks just tasks actually in the background

An extra line here for multiline comments such as:
+	/*
+	 * Don't punish batch tasks just tasks actually in the background


> +	 * as anything else is counter productive from a system wide aspect
> +	 */
> +	if (task_in_background(p))
>  		target = rq->expired;
>  	enqueue_task(p, target);
>  	inc_nr_running(p, rq);
> @@ -942,6 +964,8 @@ static void activate_task(struct task_st
>  	if (!rt_task(p))
>  		p->prio = recalc_task_prio(p, now);
>
> +	p->flags &= ~PF_UIWAKE;
> +
>  	/*
>  	 * This checks to make sure it's not an uninterruptible task
>  	 * that is now waking up.
> @@ -1484,6 +1508,7 @@ out_activate:
>  		 * sleep_avg beyond just interactive state.
>  		 */
>  		p->sleep_type = SLEEP_NONINTERACTIVE;
> +		p->flags |= PF_UIWAKE;
>  	} else
>
>  	/*
> @@ -3024,6 +3049,48 @@ void scheduler_tick(void)
>  		}
>  		goto out_unlock;
>  	}
> +
> +	if (bgnd_task(p)) {
> +		/*
> +		 * Do this even if there's only one task on the queue as
> +		 * we want to set the priority low so that any waking tasks
> +		 * can preempt.
> +		 */
> +		if (task_in_background(p)) {
> +			/*
> +			 * Tasks currently in the background will be
> +			 * at BGND_PRIO priority and preemption
> +			 * should be enough to keep them in check provided we
> +			 * don't let them adversely effect tasks on the expired

ok I'm going to risk a lart and say "affect" ?

> +			 * array.
> +			 */
> +			if (!safe_to_background(p)) {
> +				dequeue_task(p, rq->active);
> +				p->prio = effective_prio(p);
> +				enqueue_task(p, rq->active);
> +			} else if (rq->expired->nr_active &&
> +				   rq->best_expired_prio < p->prio) {
> +				dequeue_task(p, rq->active);
> +				enqueue_task(p, rq->expired);
> +				set_tsk_need_resched(p);
> +				goto out_unlock;
> +			}
> +		}
> +		else if (safe_to_background(p)) {
> +			dequeue_task(p, rq->active);
> +			p->normal_prio = BGND_PRIO;
> +			/* this should be safe for PI purposes */
> +			p->prio = p->normal_prio;
> +			enqueue_task(p, rq->expired);
> +			/*
> +			 * think about making this conditional to reduce
> +			 * context switch rate
> +			 */
> +			set_tsk_need_resched(p);
> +			goto out_unlock;
> +		}
> +	}
> +
>  	if (!--p->time_slice) {
>  		dequeue_task(p, rq->active);
>  		set_tsk_need_resched(p);
> @@ -3033,6 +3100,11 @@ void scheduler_tick(void)
>
>  		if (!rq->expired_timestamp)
>  			rq->expired_timestamp = jiffies;
> +		/*
> +		 * No need to do anything special for background tasks here
> +		 * as TASK_INTERACTIVE() should fail when they're in the
> +		 * background.
> +		 */
>  		if (!TASK_INTERACTIVE(p) || expired_starving(rq)) {
>  			enqueue_task(p, rq->expired);
>  			if (p->static_prio < rq->best_expired_prio)
> @@ -3122,6 +3194,33 @@ smt_slice(struct task_struct *p, struct
>  }
>
>  /*
> + * task time slice for SMT dependent idle purposes
> + */
> +static unsigned int smt_timeslice(struct task_struct *p)
> +{
> +	if (task_in_background(p))
> +		return 0;
> +
> +	return task_timeslice(p);
> +}
> +
> +/*
> + * Is the thisp a higher priority task than thatp for SMT dependent idle
> + * purposes?
> + */
> +static int task_priority_gt(const struct task_struct *thisp,
> +			    const struct task_struct *thatp)
> +{
> +	if (task_in_background(thisp))
> +	    return !task_in_background(thatp);
> +
> +	if (task_in_background(thatp))
> +	    return 1;
> +
> +	return thisp->static_prio < thatp->static_prio;
> +}
> +
> +/*
>   * To minimise lock contention and not have to drop this_rq's runlock we
> only * trylock the sibling runqueues and bypass those runqueues if we fail
> to * acquire their lock. As we only trylock the normal locking order does
> not @@ -3180,9 +3279,9 @@ dependent_sleeper(int this_cpu, struct r
>  				(sd->per_cpu_gain * DEF_TIMESLICE / 100))
>  					ret = 1;
>  		} else {
> -			if (smt_curr->static_prio < p->static_prio &&
> +			if (task_priority_gt(smt_curr, p) &&
>  				!TASK_PREEMPTS_CURR(p, smt_rq) &&
> -				smt_slice(smt_curr, sd) > task_timeslice(p))
> +				smt_slice(smt_curr, sd) > smt_timeslice(p))
>  					ret = 1;
>  		}
>  unlock:
> @@ -3245,6 +3344,22 @@ static inline int interactive_sleep(enum
>  }
>
>  /*
> + * Switch the active and expired arrays.
> + */
> +static struct prio_array *switch_arrays(struct rq *rq, int
> best_active_prio) +{

In the fast path this should be inlined even if it is large.

> +	struct prio_array *array = rq->active;
> +
> +	schedstat_inc(rq, sched_switch);
> +	rq->active = rq->expired;
> +	rq->expired = array;
> +	rq->expired_timestamp = 0;
> +	rq->best_expired_prio = best_active_prio;
> +
> +	return rq->active;
> +}
> +
> +/*
>   * schedule() is the main scheduler function.
>   */
>  asmlinkage void __sched schedule(void)
> @@ -3332,23 +3447,25 @@ need_resched_nonpreemptible:
>  	}
>
>  	array = rq->active;
> -	if (unlikely(!array->nr_active)) {
> -		/*
> -		 * Switch the active and expired arrays.
> -		 */
> -		schedstat_inc(rq, sched_switch);
> -		rq->active = rq->expired;
> -		rq->expired = array;
> -		array = rq->active;
> -		rq->expired_timestamp = 0;
> -		rq->best_expired_prio = MAX_PRIO;
> -	}
> +	if (unlikely(!array->nr_active))
> +		array = switch_arrays(rq, MAX_PRIO);
>
>  	idx = sched_find_first_bit(array->bitmap);
> +get_next:
>  	queue = array->queue + idx;
>  	next = list_entry(queue->next, struct task_struct, run_list);
> +	/* very strict backgrounding */
> +	if (unlikely(task_in_background(next) && rq->expired->nr_active)) {
> +		int tmp = sched_find_first_bit(rq->expired->bitmap);
> +
> +		if (likely(tmp < idx)) {
> +			array = switch_arrays(rq, idx);
> +			idx = tmp;
> +			goto get_next;
> +		}
> +	}
>
> -	if (!rt_task(next) && interactive_sleep(next->sleep_type)) {
> +	if (!rt_task(next) && interactive_sleep(next->sleep_type) &&
> !bgnd_task(next)) { unsigned long long delta = now - next->timestamp;
>  		if (unlikely((long long)(now - next->timestamp) < 0))
>  			delta = 0;
> @@ -4052,7 +4169,8 @@ recheck:
>  	if (policy < 0)
>  		policy = oldpolicy = p->policy;
>  	else if (policy != SCHED_FIFO && policy != SCHED_RR &&
> -			policy != SCHED_NORMAL && policy != SCHED_BATCH)
> +			policy != SCHED_NORMAL && policy != SCHED_BATCH &&
> +			policy != SCHED_BGND)

how about a wrapper for all these policies? (see my sched_range patch)

>  		return -EINVAL;
>  	/*
>  	 * Valid priorities for SCHED_FIFO and SCHED_RR are
> @@ -4063,8 +4181,8 @@ recheck:
>  	    (p->mm && param->sched_priority > MAX_USER_RT_PRIO-1) ||
>  	    (!p->mm && param->sched_priority > MAX_RT_PRIO-1))
>  		return -EINVAL;
> -	if ((policy == SCHED_NORMAL || policy == SCHED_BATCH)
> -					!= (param->sched_priority == 0))
> +	if ((policy == SCHED_NORMAL || policy == SCHED_BATCH ||
> +	     policy == SCHED_BGND) != (param->sched_priority == 0))
>  		return -EINVAL;

same

>  	/*
> @@ -4072,15 +4190,20 @@ recheck:
>  	 */
>  	if (!capable(CAP_SYS_NICE)) {
>  		/*
> -		 * can't change policy, except between SCHED_NORMAL
> -		 * and SCHED_BATCH:
> +		 * can't change policy, except between SCHED_NORMAL,
> +		 * SCHED_BATCH or SCHED_BGND:
>  		 */
> -		if (((policy != SCHED_NORMAL && p->policy != SCHED_BATCH) &&
> -			(policy != SCHED_BATCH && p->policy != SCHED_NORMAL)) &&
> +		if (((policy != SCHED_NORMAL && p->policy != SCHED_BATCH &&
> +			    p->policy != SCHED_BGND) &&
> +		     (policy != SCHED_BATCH && p->policy != SCHED_NORMAL &&
> +			    p->policy != SCHED_BGND) &&
> +		     (policy != SCHED_BGND && p->policy != SCHED_NORMAL &&
> +			    p->policy != SCHED_BATCH)) &&

same

>  				!p->signal->rlim[RLIMIT_RTPRIO].rlim_cur)
>  			return -EPERM;
>  		/* can't increase priority */
> -		if ((policy != SCHED_NORMAL && policy != SCHED_BATCH) &&
> +		if ((policy != SCHED_NORMAL && policy != SCHED_BATCH &&
> +			    policy != SCHED_BGND) &&
>  		    param->sched_priority > p->rt_priority &&
>  		    param->sched_priority >
>  				p->signal->rlim[RLIMIT_RTPRIO].rlim_cur)
> Index: MM-2.6.17-mm6/kernel/mutex.c
> ===================================================================
> --- MM-2.6.17-mm6.orig/kernel/mutex.c	2006-07-04 14:37:43.000000000 +1000
> +++ MM-2.6.17-mm6/kernel/mutex.c	2006-07-04 14:38:12.000000000 +1000
> @@ -51,6 +51,16 @@ __mutex_init(struct mutex *lock, const c
>
>  EXPORT_SYMBOL(__mutex_init);
>
> +static inline void inc_mutex_count(void)
> +{
> +	current->mutexes_held++;
> +}
> +
> +static inline void dec_mutex_count(void)
> +{
> +	current->mutexes_held--;
> +}
> +
>  /*
>   * We split the mutex lock/unlock logic into separate fastpath and
>   * slowpath functions, to reduce the register pressure on the fastpath.
> @@ -89,6 +99,7 @@ void inline fastcall __sched mutex_lock(
>  	 * 'unlocked' into 'locked' state.
>  	 */
>  	__mutex_fastpath_lock(&lock->count, __mutex_lock_slowpath);
> +	inc_mutex_count();
>  }
>
>  EXPORT_SYMBOL(mutex_lock);
> @@ -114,6 +125,7 @@ void fastcall __sched mutex_unlock(struc
>  	 * into 'unlocked' state:
>  	 */
>  	__mutex_fastpath_unlock(&lock->count, __mutex_unlock_slowpath);
> +	dec_mutex_count();
>  }
>
>  EXPORT_SYMBOL(mutex_unlock);
> @@ -274,9 +286,16 @@ __mutex_lock_interruptible_slowpath(atom
>   */
>  int fastcall __sched mutex_lock_interruptible(struct mutex *lock)
>  {
> +	int ret;
> +
>  	might_sleep();
> -	return __mutex_fastpath_lock_retval
> +	ret = __mutex_fastpath_lock_retval
>  			(&lock->count, __mutex_lock_interruptible_slowpath);
> +
> +	if (likely(!ret))
> +		inc_mutex_count();
> +
> +	return ret;
>  }
>
>  EXPORT_SYMBOL(mutex_lock_interruptible);
> @@ -331,8 +350,13 @@ static inline int __mutex_trylock_slowpa
>   */
>  int fastcall __sched mutex_trylock(struct mutex *lock)
>  {
> -	return __mutex_fastpath_trylock(&lock->count,
> +	int ret = __mutex_fastpath_trylock(&lock->count,
>  					__mutex_trylock_slowpath);
> +
> +	if (likely(ret))
> +		inc_mutex_count();
> +
> +	return ret;
>  }
>
>  EXPORT_SYMBOL(mutex_trylock);
> Index: MM-2.6.17-mm6/kernel/fork.c
> ===================================================================
> --- MM-2.6.17-mm6.orig/kernel/fork.c	2006-07-04 14:37:43.000000000 +1000
> +++ MM-2.6.17-mm6/kernel/fork.c	2006-07-04 14:38:12.000000000 +1000
> @@ -1029,6 +1029,7 @@ static struct task_struct *copy_process(
>  	p->wchar = 0;		/* I/O counter: bytes written */
>  	p->syscr = 0;		/* I/O counter: read syscalls */
>  	p->syscw = 0;		/* I/O counter: write syscalls */
> +	p->mutexes_held = 0;
>  	acct_clear_integrals(p);
>
>   	p->it_virt_expires = cputime_zero;

-- 
-ck
