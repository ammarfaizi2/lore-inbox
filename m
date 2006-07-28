Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932621AbWG1KiP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932621AbWG1KiP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 06:38:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932626AbWG1KiP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 06:38:15 -0400
Received: from wx-out-0102.google.com ([66.249.82.204]:56082 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932621AbWG1KiO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 06:38:14 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=googlemail.com;
        h=received:date:x-x-sender:to:cc:subject:in-reply-to:message-id:references:mime-version:content-type:from;
        b=mdfF+vuZiaI0KKDOAXA/7mUJDlhJuQ/iGfa1nz5FGbfZd6QUg8Svry4NCwvj/gocDgRvsUfpNSywEYdbmhlS5Y3CWLOeisEeVVxMTTyx+vVRnFx0/8cpgJnrAdRrPcMX3lW21xp2pYnL2qe2qRuKIwA5MGKkAGSCpxK5s5XnyaE=
Date: Fri, 28 Jul 2006 12:38:33 +0100 (BST)
X-X-Sender: simlo@localhost.localdomain
To: "Paul E. McKenney" <paulmck@us.ibm.com>
cc: linux-kernel@vger.kernel.org, tglx@linutronix.de, rostedt@goodmis.org,
       dipankar@in.ibm.com, billh@gnuppy.monkey.org,
       nielsen.esben@googlemail.com, mingo@elte.hu, tytso@us.ibm.com,
       dvhltc@us.ibm.com
Subject: Re: [RFC, PATCH, -rt] Early prototype RCU priority-boost patch
In-Reply-To: <20060728001918.GA2634@us.ibm.com>
Message-ID: <Pine.LNX.4.64.0607281222580.10047@localhost.localdomain>
References: <20060728001918.GA2634@us.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
From: Esben Nielsen <nielsen.esben@googlemail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
  I have considered an idea to make this work with the PI: Add the ability 
to at a waiter not refering to a lock to the PI list. I think a few 
subsystems can use that if they temporarely want to boost a task in a 
consistend way (HR-timers is one). After a little renaming getting the 
boosting part seperated out of rt_mutex_waiter:

  struct prio_booster {
 	struct plist_node	booster_list_entry;
  };

  void add_prio_booster(struct task_struct *, struct prio_booster *booster);
  void remove_prio_booster(struct task_struct *, struct prio_booster 
*booster);
  void change_prio_booster(struct task_struct *, struct prio_booster 
*booster, int new_prio);

(these functions takes care of doing/triggering a lock chain traversal if 
needed) and change

  struct rt_mutext_waiter {
     ...
     struct prio_booster booster;
     ...
  };

There are issues with lock orderings between task->pi_lock (which should 
be renamed to task->prio_lock) and rq->lock. The lock ordering probably 
have to be reversed, thus integrating the boosting system directly into 
the scheduler instead of into rtmutex-subsystem.

Esben

On Thu, 27 Jul 2006, Paul E. McKenney wrote:

> Hello!
>
> This is a very crude not-for-inclusion patch that boosts priority of
> RCU read-side critical sections, but only when they are preempted, and
> only to the highest non-RT priority.  The rcu_read_unlock() primitive
> does the unboosting.  There are a large number of things that this patch
> does -not- do, including:
>
> o	Boost RCU read-side critical sections to the highest possible
> 	priority.  One might wish to do this in OOM situations.  Or
> 	if the grace period is extending too long.  I played with this
> 	a bit some months back, see:
>
> 		http://www.rdrop.com/users/paulmck/patches/RCUboost-20.patch
>
> 	to see what I was thinking.  Or similarly-numbered patches,
> 	see http://www.rdrop.com/users/paulmck/patches for the full
> 	list.  Lots of subtly broken approaches for those who are
> 	interested in subtle breakage.
>
> 	One must carefully resolve races between boosting and the
> 	to-be-boosted task slipping out of its RCU read-side critical
> 	section.  My thought has been to grab the to-be-boosted task
> 	by the throat, and only boost it if it is (1) still in an
> 	RCU read-side critical section and (2) not running.  If you
> 	try boosting a thread that is already running, the races between
> 	boosting and rcu_read_unlock() are insanely complex, particularly
> 	for implementations of rcu_read_unlock() that don't use atomic
> 	instructions or memory barriers.  ;-)
>
> 	Much better to either have the thread boost itself or to make
> 	sure the thread is not running if having someone else boost it.
>
> o	Boost RCU read-side critical sections that must block waiting
> 	for a non-raw spinlock.  The URL noted above shows one approach
> 	I was messing with some time back.
>
> o	Boost RCU read-side critical sections based on the priority of
> 	tasks doing synchronize_rcu() and call_rcu().  (This was something
> 	Steve Rostedt suggested at OLS.)  One thing at a time!  ;-)
>
> o	Implementing preemption thresholding, as suggested by Bill Huey.
> 	I am taking the coward's way out on this for the moment in order
> 	to improve the odds of getting something useful done (as opposed
> 	to getting something potentially even more useful only half done).
>
> Anyway, the following patch compiles and passes lightweight "smoke" tests.
> It almost certainly has fatal flaws -- for, example, I don't see how it
> would handle yet another task doing a lock-based priority boost between
> the time the task is RCU-boosted and the time it de-boosts itself in
> rcu_read_unlock().
>
> Again, not for inclusion in its present form, but any enlightenment would
> be greatly appreciated.
>
> (Thomas, you did ask for this!!!)
>
> 							Thanx, Paul
>
> Signed-off-by: Paul E. McKenney <paulmck@us.ibm.com> (but not for inclusion)
> ---
>
> include/linux/init_task.h |    1 +
> include/linux/rcupdate.h  |    2 ++
> include/linux/sched.h     |    3 +++
> kernel/rcupreempt.c       |   11 +++++++++++
> kernel/sched.c            |    8 ++++++++
> 5 files changed, 25 insertions(+)
>
> diff -urpNa -X dontdiff linux-2.6.17-rt7/include/linux/init_task.h linux-2.6.17-rt7-rcubp/include/linux/init_task.h
> --- linux-2.6.17-rt7/include/linux/init_task.h	2006-07-27 14:29:55.000000000 -0700
> +++ linux-2.6.17-rt7-rcubp/include/linux/init_task.h	2006-07-27 14:34:20.000000000 -0700
> @@ -89,6 +89,7 @@ extern struct group_info init_groups;
> 	.prio		= MAX_PRIO-20,					\
> 	.static_prio	= MAX_PRIO-20,					\
> 	.normal_prio	= MAX_PRIO-20,					\
> +	.rcu_prio	= MAX_PRIO,					\
> 	.policy		= SCHED_NORMAL,					\
> 	.cpus_allowed	= CPU_MASK_ALL,					\
> 	.mm		= NULL,						\
> diff -urpNa -X dontdiff linux-2.6.17-rt7/include/linux/rcupdate.h linux-2.6.17-rt7-rcubp/include/linux/rcupdate.h
> --- linux-2.6.17-rt7/include/linux/rcupdate.h	2006-07-27 14:29:55.000000000 -0700
> +++ linux-2.6.17-rt7-rcubp/include/linux/rcupdate.h	2006-07-27 14:34:20.000000000 -0700
> @@ -175,6 +175,8 @@ extern int rcu_needs_cpu(int cpu);
>
> #else /* #ifndef CONFIG_PREEMPT_RCU */
>
> +#define RCU_PREEMPT_BOOST_PRIO MAX_USER_RT_PRIO  /* Initial boost level. */
> +
> #define rcu_qsctr_inc(cpu)
> #define rcu_bh_qsctr_inc(cpu)
> #define call_rcu_bh(head, rcu) call_rcu(head, rcu)
> diff -urpNa -X dontdiff linux-2.6.17-rt7/include/linux/sched.h linux-2.6.17-rt7-rcubp/include/linux/sched.h
> --- linux-2.6.17-rt7/include/linux/sched.h	2006-07-27 14:29:55.000000000 -0700
> +++ linux-2.6.17-rt7-rcubp/include/linux/sched.h	2006-07-27 14:34:20.000000000 -0700
> @@ -851,6 +851,9 @@ struct task_struct {
> 	int oncpu;
> #endif
> 	int prio, static_prio, normal_prio;
> +#ifdef CONFIG_PREEMPT_RCU
> +	int rcu_prio;
> +#endif
> 	struct list_head run_list;
> 	prio_array_t *array;
>
> diff -urpNa -X dontdiff linux-2.6.17-rt7/kernel/rcupreempt.c linux-2.6.17-rt7-rcubp/kernel/rcupreempt.c
> --- linux-2.6.17-rt7/kernel/rcupreempt.c	2006-07-27 14:29:55.000000000 -0700
> +++ linux-2.6.17-rt7-rcubp/kernel/rcupreempt.c	2006-07-27 14:34:20.000000000 -0700
> @@ -147,6 +147,17 @@ rcu_read_lock(void)
> 			atomic_inc(current->rcu_flipctr2);
> 			smp_mb__after_atomic_inc();  /* might optimize out... */
> 		}
> +		if (unlikely(current->rcu_prio <= RCU_PREEMPT_BOOST_PRIO)) {
> +			int new_prio = MAX_PRIO;
> +
> +			current->rcu_prio = MAX_PRIO;
> +			if (new_prio > current->static_prio)
> +				new_prio = current->static_prio;
> +			if (new_prio > current->normal_prio)
> +				new_prio = current->normal_prio;
> +			/* How to account for lock-based prio boost? */
> +			rt_mutex_setprio(current, new_prio);
> +		}
> 	}
> 	trace_special((unsigned long) current->rcu_flipctr1,
> 		      (unsigned long) current->rcu_flipctr2,
> diff -urpNa -X dontdiff linux-2.6.17-rt7/kernel/sched.c linux-2.6.17-rt7-rcubp/kernel/sched.c
> --- linux-2.6.17-rt7/kernel/sched.c	2006-07-27 14:29:55.000000000 -0700
> +++ linux-2.6.17-rt7-rcubp/kernel/sched.c	2006-07-27 14:58:40.000000000 -0700
> @@ -3685,6 +3685,14 @@ asmlinkage void __sched preempt_schedule
> 		return;
>
> need_resched:
> +#ifdef CONFIG_PREEMPT_RT
> +	if (unlikely(current->rcu_read_lock_nesting > 0) &&
> +	    (current->rcu_prio > RCU_PREEMPT_BOOST_PRIO)) {
> +		current->rcu_prio = RCU_PREEMPT_BOOST_PRIO;
> +		if (current->rcu_prio < current->prio)
> +			rt_mutex_setprio(current, current->rcu_prio);
> +	}
> +#endif
> 	local_irq_disable();
> 	add_preempt_count(PREEMPT_ACTIVE);
> 	/*
>
