Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750786AbWGWASd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750786AbWGWASd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jul 2006 20:18:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750864AbWGWASd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jul 2006 20:18:33 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:7399 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1750786AbWGWASL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jul 2006 20:18:11 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=googlemail.com;
        h=received:date:from:x-x-sender:to:subject:message-id:references:mime-version:content-type;
        b=Em2/ADeea+JfenxVvXjTkhwRfFfta3ZnGJKYXK8JhFkyLeZmcny1H4gJ+69ck5t/lhFI6KzYQsrUvm5r9dOrI0XHTaGRHdPppLBW0ZDq5OwJ2p2D7Kj2ep4myI+yO5tjrAN5XkhnAOHCki31L/ksXzzhu8YZyhr2z7FRWQCa+wo=
Date: Sun, 23 Jul 2006 02:18:35 +0100 (BST)
From: Esben Nielsen <nielsen.esben@googlemail.com>
X-X-Sender: simlo@localhost.localdomain
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
       Steven Rostedt <rostedt@goodmis.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: [patch 3/3] [-rt] Fixes the timeout-bug in the rtmutex/PI-futex.
Message-ID: <Pine.LNX.4.64.0607230217390.11861@localhost.localdomain>
References: <20060723005210.973833000@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes

1) The timeout bug in rtmutexes and PI futexes: When a task is blocked on a 
lock with timeout and times out it will not wakeup until the owner of the lock
is done. This is because the owner is boosted to the same priority as the 
blocked task and therefore has the CPU such the blocked task never gets around 
to de-boost it!

2) setscheduler() now does the PI walking - but defers the work to the blocked
task.

3) In general it makes sure that a task, which is boosting another has enough
priority to do the de-boosting no matter how complicated the lock structure is, 
or how many times the priorities have changed.

The idea behind the patch is simple:
If a task is boosting another it is scheduled in LIFO order and it will never
loose it's priority. This property lasts until it has left the lock operation
(successfully or not).

The needed priority to do the unboosting is stored in task->boosting_prio.
In the current patch this is always increasing (numerically decreasing) while
trying to take a lock. In a future it might be found safe to decrease
boosting_prio before finally leaving the lock operation.

  include/linux/rtmutex.h                               |    1
  include/linux/sched.h                                 |    7
  kernel/fork.c                                         |    1
  kernel/rtmutex.c                                      |  151 +++++++++++++-----
  kernel/rtmutex_common.h                               |    1
  kernel/sched.c                                        |   14 +
  scripts/rt-tester/t5-l4-pi-boost-deboost-setsched.tst |   42 +++--
  scripts/rt-tester/t5-l4-pi-boost-deboost.tst          |   12 -
  8 files changed, 167 insertions(+), 62 deletions(-)

Index: linux-2.6.17-rt7/kernel/rtmutex.c
===================================================================
--- linux-2.6.17-rt7.orig/kernel/rtmutex.c
+++ linux-2.6.17-rt7/kernel/rtmutex.c
@@ -121,7 +121,7 @@ static inline void init_lists(struct rt_
   * Return task->normal_prio when the waiter list is empty or when
   * the waiter is not allowed to do priority boosting
   */
-int rt_mutex_getprio(struct task_struct *task)
+static int rt_mutex_getprio_real(struct task_struct *task)
  {
  	if (likely(!task_has_pi_waiters(task)))
  		return task->normal_prio;
@@ -130,6 +130,11 @@ int rt_mutex_getprio(struct task_struct
  		   task->normal_prio);
  }

+int rt_mutex_getprio(struct task_struct *task)
+{
+	return min(rt_mutex_getprio_real(task), task->boosting_prio);
+}
+
  /*
   * Adjust the priority of a task, after its pi_waiters got modified.
   *
@@ -144,6 +149,20 @@ static void __rt_mutex_adjust_prio(struc
  }

  /*
+ * Adjust the priority of a task, after its pi_waiters got modified.
+ *
+ * This can be both boosting and unboosting.
+ */
+static void rt_mutex_adjust_prio(struct task_struct *task)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&task->pi_lock, flags);
+	__rt_mutex_adjust_prio(task);
+	spin_unlock_irqrestore(&task->pi_lock, flags);
+}
+
+/*
   * Adjust task priority (undo boosting). Called from the exit path of
   * rt_mutex_slowunlock() and rt_mutex_slowlock().
   *
@@ -152,11 +171,14 @@ static void __rt_mutex_adjust_prio(struc
   * of task. We do not use the spin_xx_mutex() variants here as we are
   * outside of the debug path.)
   */
-static void rt_mutex_adjust_prio(struct task_struct *task)
+static void rt_mutex_adjust_prio_final(struct task_struct *task,
+				       int old_sched_lifo)
  {
  	unsigned long flags;

  	spin_lock_irqsave(&task->pi_lock, flags);
+	task->boosting_prio = MAX_PRIO;
+	leave_sched_lifo_other(task, old_sched_lifo);
  	__rt_mutex_adjust_prio(task);
  	spin_unlock_irqrestore(&task->pi_lock, flags);
  }
@@ -232,7 +254,8 @@ static int rt_mutex_adjust_prio_chain(ta
  	 * When deadlock detection is off then we check, if further
  	 * priority adjustment is necessary.
  	 */
-	if (!detect_deadlock && waiter->list_entry.prio == task->prio)
+	if (!detect_deadlock &&
+	    waiter->list_entry.prio == rt_mutex_getprio_real(task))
  		goto out_unlock_pi;

  	lock = waiter->lock;
@@ -254,7 +277,9 @@ static int rt_mutex_adjust_prio_chain(ta

  	/* Requeue the waiter */
  	plist_del(&waiter->list_entry, &lock->wait_list);
-	waiter->list_entry.prio = task->prio;
+	waiter->list_entry.prio = rt_mutex_getprio_real(task);
+	task->boosting_prio = min(task->boosting_prio,
+				  waiter->list_entry.prio);
  	plist_add(&waiter->list_entry, &lock->wait_list);

  	/* Release the task */
@@ -300,6 +325,18 @@ static int rt_mutex_adjust_prio_chain(ta
  }

  /*
+ * Calls the rt_mutex_adjust_prio_chain() above
+ * whith unlocking and locking lock->wait_lock.
+ */
+static void rt_mutex_adjust_prio_chain_unlock(struct rt_mutex *lock)
+{
+	spin_unlock(&lock->wait_lock);
+	get_task_struct(current);
+	rt_mutex_adjust_prio_chain(current, 0, NULL, NULL __IP__);
+	spin_lock(&lock->wait_lock);
+}
+
+/*
   * Optimization: check if we can steal the lock from the
   * assigned pending owner [which might not have taken the
   * lock yet]:
@@ -309,6 +346,7 @@ static inline int try_to_steal_lock(stru
  	struct task_struct *pendowner = rt_mutex_owner(lock);
  	struct rt_mutex_waiter *next;
  	unsigned long flags;
+	int current_prio;

  	if (!rt_mutex_owner_pending(lock))
  		return 0;
@@ -316,8 +354,12 @@ static inline int try_to_steal_lock(stru
  	if (pendowner == current)
  		return 1;

+	spin_lock_irqsave(&current->pi_lock, flags);
+	current_prio = rt_mutex_getprio_real(current);
+	spin_unlock_irqrestore(&current->pi_lock, flags);
+
  	spin_lock_irqsave(&pendowner->pi_lock, flags);
-	if (current->prio >= pendowner->prio) {
+	if (current_prio >= rt_mutex_getprio_real(pendowner)) {
  		spin_unlock_irqrestore(&pendowner->pi_lock, flags);
  		return 0;
  	}
@@ -426,8 +468,8 @@ static int task_blocks_on_rt_mutex(struc
  	__rt_mutex_adjust_prio(current);
  	waiter->task = current;
  	waiter->lock = lock;
-	plist_node_init(&waiter->list_entry, current->prio);
-	plist_node_init(&waiter->pi_list_entry, current->prio);
+	plist_node_init(&waiter->list_entry, rt_mutex_getprio_real(current));
+	plist_node_init(&waiter->pi_list_entry, waiter->list_entry.prio);

  	/* Get the top priority waiter on the lock */
  	if (rt_mutex_has_waiters(lock))
@@ -435,7 +477,9 @@ static int task_blocks_on_rt_mutex(struc
  	plist_add(&waiter->list_entry, &lock->wait_list);

  	current->pi_blocked_on = waiter;
-
+	current->boosting_prio = min(current->boosting_prio,
+				     waiter->list_entry.prio);
+	enter_sched_lifo();
  	spin_unlock_irqrestore(&current->pi_lock, flags);

  	if (waiter == rt_mutex_top_waiter(lock)) {
@@ -499,7 +543,6 @@ static void wakeup_next_waiter(struct rt
  	plist_del(&waiter->pi_list_entry, &current->pi_waiters);
  	pendowner = waiter->task;
  	waiter->task = NULL;
-
  	rt_mutex_set_owner(lock, pendowner, RT_MUTEX_OWNER_PENDING);

  	spin_unlock_irqrestore(&current->pi_lock, flags);
@@ -518,6 +561,8 @@ static void wakeup_next_waiter(struct rt
  	WARN_ON(pendowner->pi_blocked_on->lock != lock);

  	pendowner->pi_blocked_on = NULL;
+	pendowner->boosting_prio = MAX_PRIO;
+	leave_sched_lifo_other(pendowner, waiter->old_sched_lifo);

  	if (rt_mutex_has_waiters(lock)) {
  		struct rt_mutex_waiter *next;
@@ -525,6 +570,7 @@ static void wakeup_next_waiter(struct rt
  		next = rt_mutex_top_waiter(lock);
  		plist_add(&next->pi_list_entry, &pendowner->pi_waiters);
  	}
+	__rt_mutex_adjust_prio(pendowner);
  	spin_unlock_irqrestore(&pendowner->pi_lock, flags);

  	if (savestate)
@@ -539,7 +585,8 @@ static void wakeup_next_waiter(struct rt
   * Must be called with lock->wait_lock held
   */
  static void remove_waiter(struct rt_mutex *lock,
-			  struct rt_mutex_waiter *waiter  __IP_DECL__)
+			  struct rt_mutex_waiter *waiter
+			  __IP_DECL__)
  {
  	int first = (waiter == rt_mutex_top_waiter(lock));
  	int boost = 0;
@@ -621,7 +668,8 @@ static void fastcall noinline __sched
  rt_lock_slowlock(struct rt_mutex *lock __IP_DECL__)
  {
  	struct rt_mutex_waiter waiter;
-	unsigned long saved_state, state;      ;
+	unsigned long saved_state, state;
+	int adjust_prio_final = 0;

  	debug_rt_mutex_init_waiter(&waiter);
  	waiter.task = NULL;
@@ -648,6 +696,7 @@ rt_lock_slowlock(struct rt_mutex *lock _
  	 * then we return with the saved state.
  	 */
  	saved_state = xchg(&current->state, TASK_UNINTERRUPTIBLE);
+	waiter.old_sched_lifo = get_sched_lifo();

  	for (;;) {
  		unsigned long saved_flags;
@@ -661,12 +710,17 @@ rt_lock_slowlock(struct rt_mutex *lock _
  		 * when we have been woken up by the previous owner
  		 * but the lock got stolen by an higher prio task.
  		 */
-		if (!waiter.task) {
+		if (!waiter.task)
  			task_blocks_on_rt_mutex(lock, &waiter, 0 __IP__);
  			/* Wakeup during boost ? */
-			if (unlikely(!waiter.task))
+		else
+			rt_mutex_adjust_prio_chain_unlock(lock);
+
+		/*
+		 * We got it while lock->wait_lock was unlocked ?
+		 */
+		if (unlikely(!waiter.task))
  				continue;
-		}

  		/*
  		 * Prevent schedule() to drop BKL, while waiting for
@@ -699,8 +753,10 @@ rt_lock_slowlock(struct rt_mutex *lock _
  	 * highest-prio waiter (due to SCHED_OTHER changing prio), then we
  	 * can end up with a non-NULL waiter.task:
  	 */
-	if (unlikely(waiter.task))
-		remove_waiter(lock, &waiter __IP__);
+	if (unlikely(waiter.task)) {
+		remove_waiter(lock, &waiter  __IP__);
+		adjust_prio_final = 1;
+	}
  	/*
  	 * try_to_take_rt_mutex() sets the waiter bit
  	 * unconditionally. We might have to fix that up:
@@ -709,7 +765,12 @@ rt_lock_slowlock(struct rt_mutex *lock _

  	spin_unlock(&lock->wait_lock);

+	if (adjust_prio_final)
+		rt_mutex_adjust_prio_final(current, waiter.old_sched_lifo);
+
  	debug_rt_mutex_free_waiter(&waiter);
+	BUG_ON(current->boosting_prio != MAX_PRIO);
+	BUG_ON(waiter.old_sched_lifo != get_sched_lifo());
  }

  /*
@@ -719,21 +780,16 @@ static void fastcall noinline __sched
  rt_lock_slowunlock(struct rt_mutex *lock)
  {
  	spin_lock(&lock->wait_lock);
-
  	debug_rt_mutex_unlock(lock);
-
  	rt_mutex_deadlock_account_unlock(current);
-
  	if (!rt_mutex_has_waiters(lock)) {
  		lock->owner = NULL;
  		spin_unlock(&lock->wait_lock);
  		return;
  	}
-
  	wakeup_next_waiter(lock, 1);
-
  	spin_unlock(&lock->wait_lock);
-
+	BUG_ON(current->boosting_prio != MAX_PRIO);
  	/* Undo pi boosting.when necessary */
  	rt_mutex_adjust_prio(current);
  }
@@ -795,6 +851,7 @@ rt_mutex_slowlock(struct rt_mutex *lock,
  {
  	int ret = 0, saved_lock_depth = -1;
  	struct rt_mutex_waiter waiter;
+	int adjust_prio_final = 0;

  	debug_rt_mutex_init_waiter(&waiter);
  	waiter.task = NULL;
@@ -817,6 +874,7 @@ rt_mutex_slowlock(struct rt_mutex *lock,
  		saved_lock_depth = rt_release_bkl(lock);

  	set_current_state(state);
+	waiter.old_sched_lifo = get_sched_lifo();

  	/* Setup the timer, when timeout != NULL */
  	if (unlikely(timeout))
@@ -848,21 +906,28 @@ rt_mutex_slowlock(struct rt_mutex *lock,
  		 * waiter.task is NULL the first time we come here and
  		 * when we have been woken up by the previous owner
  		 * but the lock got stolen by a higher prio task.
+		 *
+		 * If we get another kind of  wakeup but can't get the lock
+		 * we should try to adjust the priorities
  		 */
-		if (!waiter.task) {
+		if (!waiter.task)
  			ret = task_blocks_on_rt_mutex(lock, &waiter,
  						      detect_deadlock __IP__);
-			/*
-			 * If we got woken up by the owner then start loop
-			 * all over without going into schedule to try
-			 * to get the lock now:
-			 */
-			if (unlikely(!waiter.task))
-				continue;
+		else
+			rt_mutex_adjust_prio_chain_unlock(lock);
+
+
+		/*
+		 * If we got woken up by the owner then start loop
+		 * all over without going into schedule to try
+		 * to get the lock now:
+		 */
+		if (unlikely(!waiter.task))
+			continue;
+
+		if (unlikely(ret))
+			break;

-			if (unlikely(ret))
-				break;
-		}
  		saved_flags = current->flags & PF_NOSCHED;
  		current->flags &= ~PF_NOSCHED;

@@ -881,8 +946,13 @@ rt_mutex_slowlock(struct rt_mutex *lock,

  	set_current_state(TASK_RUNNING);

-	if (unlikely(waiter.task))
+	if (unlikely(waiter.task)) {
  		remove_waiter(lock, &waiter __IP__);
+		adjust_prio_final = 1;
+	}
+	else if (unlikely(ret))
+		adjust_prio_final = 1;
+

  	/*
  	 * try_to_take_rt_mutex() sets the waiter bit
@@ -892,17 +962,13 @@ rt_mutex_slowlock(struct rt_mutex *lock,

  	spin_unlock(&lock->wait_lock);

+	if (adjust_prio_final)
+		rt_mutex_adjust_prio_final(current, waiter.old_sched_lifo);
+
  	/* Remove pending timer: */
  	if (unlikely(timeout))
  		hrtimer_cancel(&timeout->timer);

-	/*
-	 * Readjust priority, when we did not get the lock. We might
-	 * have been the pending owner and boosted. Since we did not
-	 * take the lock, the PI boost has to go.
-	 */
-	if (unlikely(ret))
-		rt_mutex_adjust_prio(current);

  	/* Must we reaquire the BKL? */
  	if (unlikely(saved_lock_depth >= 0))
@@ -910,6 +976,8 @@ rt_mutex_slowlock(struct rt_mutex *lock,

  	debug_rt_mutex_free_waiter(&waiter);

+	BUG_ON(current->boosting_prio != MAX_PRIO);
+
  	return ret;
  }

@@ -962,6 +1030,7 @@ rt_mutex_slowunlock(struct rt_mutex *loc
  	spin_unlock(&lock->wait_lock);

  	/* Undo pi boosting if necessary: */
+	BUG_ON(current->boosting_prio != MAX_PRIO);
  	rt_mutex_adjust_prio(current);
  }

Index: linux-2.6.17-rt7/kernel/sched.c
===================================================================
--- linux-2.6.17-rt7.orig/kernel/sched.c
+++ linux-2.6.17-rt7/kernel/sched.c
@@ -657,7 +657,9 @@ int task_preempts(struct task_struct *p,
  	return p->sched_lifo;
  }

+#ifdef CONFIG_SMP
  static __cacheline_aligned_in_smp atomic_t rt_overload;
+#endif

  static inline void inc_rt_tasks(task_t *p, runqueue_t *rq)
  {
@@ -1492,10 +1494,11 @@ static inline int wake_idle(int cpu, tas
  static int try_to_wake_up(task_t *p, unsigned int state, int sync, int mutex)
  {
  	int cpu, this_cpu, success = 0;
-	runqueue_t *this_rq, *rq;
+	runqueue_t *rq;
  	unsigned long flags;
  	long old_state;
  #ifdef CONFIG_SMP
+	runqueue_t *this_rq;
  	unsigned long load, this_load;
  	struct sched_domain *sd, *this_sd = NULL;
  	int new_cpu;
@@ -4370,6 +4373,14 @@ int setscheduler(struct task_struct *p,
  			resched_task(rq->curr);
  	}
  	task_rq_unlock(rq, &flags);
+
+	/*
+	 * If the process is blocked on rt-mutex, it will now wake up and
+	 * reinsert itself into the wait list and boost the owner correctly
+	 */
+	if (p->pi_blocked_on)
+		wake_up_process_mutex(p);
+
  	spin_unlock_irqrestore(&p->pi_lock, fp);
  	return 0;
  }
@@ -7105,4 +7116,3 @@ void notrace preempt_enable_no_resched(v

  EXPORT_SYMBOL(preempt_enable_no_resched);
  #endif
-
Index: linux-2.6.17-rt7/include/linux/sched.h
===================================================================
--- linux-2.6.17-rt7.orig/include/linux/sched.h
+++ linux-2.6.17-rt7/include/linux/sched.h
@@ -995,6 +995,13 @@ struct task_struct {
  	struct plist_head pi_waiters;
  	/* Deadlock detection and priority inheritance handling */
  	struct rt_mutex_waiter *pi_blocked_on;
+
+	/*
+	 * Priority to which this task is boosting something. Don't lower the
+	 * priority below this before the boosting is resolved;
+	 */
+	int boosting_prio;
+
  # ifdef CONFIG_DEBUG_RT_MUTEXES
  	raw_spinlock_t held_list_lock;
  	struct list_head held_list_head;
Index: linux-2.6.17-rt7/scripts/rt-tester/t5-l4-pi-boost-deboost.tst
===================================================================
--- linux-2.6.17-rt7.orig/scripts/rt-tester/t5-l4-pi-boost-deboost.tst
+++ linux-2.6.17-rt7/scripts/rt-tester/t5-l4-pi-boost-deboost.tst
@@ -113,22 +113,22 @@ T: prioeq:		3:	84
  C: signal:		4: 	0
  W: unlocked:		4: 	3
  T: prioeq:		0: 	83
-T: prioeq:		1:	83
-T: prioeq:		2:	83
-T: prioeq:		3:	83
+T: prioeq:		1:	84
+T: prioeq:		2:	84
+T: prioeq:		3:	84

  # Signal T3
  C: signal:		3: 	0
  W: unlocked:		3: 	2
  T: prioeq:		0: 	82
-T: prioeq:		1:	82
-T: prioeq:		2:	82
+T: prioeq:		1:	84
+T: prioeq:		2:	84

  # Signal T2
  C: signal:		2: 	0
  W: unlocked:		2: 	1
  T: prioeq:		0: 	81
-T: prioeq:		1:	81
+T: prioeq:		1:	84

  # Signal T1
  C: signal:		1: 	0
Index: linux-2.6.17-rt7/kernel/fork.c
===================================================================
--- linux-2.6.17-rt7.orig/kernel/fork.c
+++ linux-2.6.17-rt7/kernel/fork.c
@@ -955,6 +955,7 @@ static inline void rt_mutex_init_task(st
  	spin_lock_init(&p->pi_lock);
  	plist_head_init(&p->pi_waiters, &p->pi_lock);
  	p->pi_blocked_on = NULL;
+	p->boosting_prio = MAX_PRIO;
  # ifdef CONFIG_DEBUG_RT_MUTEXES
  	spin_lock_init(&p->held_list_lock);
  	INIT_LIST_HEAD(&p->held_list_head);
Index: linux-2.6.17-rt7/include/linux/rtmutex.h
===================================================================
--- linux-2.6.17-rt7.orig/include/linux/rtmutex.h
+++ linux-2.6.17-rt7/include/linux/rtmutex.h
@@ -116,6 +116,7 @@ extern void rt_mutex_unlock(struct rt_mu
  # define INIT_RT_MUTEXES(tsk)						\
  	.pi_waiters	= PLIST_HEAD_INIT(tsk.pi_waiters, tsk.pi_lock),	\
  	.pi_lock	= RAW_SPIN_LOCK_UNLOCKED,			\
+        .boosting_prio  = MAX_PRIO                                      \
  	INIT_RT_MUTEX_DEBUG(tsk)
  #else
  # define INIT_RT_MUTEXES(tsk)
Index: linux-2.6.17-rt7/scripts/rt-tester/t5-l4-pi-boost-deboost-setsched.tst
===================================================================
--- linux-2.6.17-rt7.orig/scripts/rt-tester/t5-l4-pi-boost-deboost-setsched.tst
+++ linux-2.6.17-rt7/scripts/rt-tester/t5-l4-pi-boost-deboost-setsched.tst
@@ -107,10 +107,10 @@ T: prioeq:		3:	84
  # Reduce prio of T4
  C: schedfifo:		4: 	80
  T: prioeq:		0: 	83
-T: prioeq:		1:	83
-T: prioeq:		2:	83
-T: prioeq:		3:	83
-T: prioeq:		4:	80
+T: prioeq:		1:	84
+T: prioeq:		2:	84
+T: prioeq:		3:	84
+T: prioeq:		4:	84

  # Increase prio of T4
  C: schedfifo:		4: 	84
@@ -139,36 +139,46 @@ T: prioeq:		4:	84
  # Reduce prio of T3
  C: schedfifo:		3: 	83
  T: prioeq:		0: 	84
-T: prioeq:		1:	84
-T: prioeq:		2:	84
-T: prioeq:		3:	84
+T: prioeq:		1:	85
+T: prioeq:		2:	85
+T: prioeq:		3:	85
  T: prioeq:		4:	84

  # Signal T4
  C: signal:		4: 	0
  W: unlocked:		4: 	3
  T: prioeq:		0: 	83
-T: prioeq:		1:	83
-T: prioeq:		2:	83
-T: prioeq:		3:	83
+T: prioeq:		1:	85
+T: prioeq:		2:	85
+T: prioeq:		3:	85
+T: prioeq:              4:      84

  # Signal T3
  C: signal:		3: 	0
  W: unlocked:		3: 	2
  T: prioeq:		0: 	82
-T: prioeq:		1:	82
-T: prioeq:		2:	82
+T: prioeq:		1:	85
+T: prioeq:		2:	85
+T: prioeq:		3:	83
+T: prioeq:              4:      84

  # Signal T2
  C: signal:		2: 	0
  W: unlocked:		2: 	1
  T: prioeq:		0: 	81
-T: prioeq:		1:	81
+T: prioeq:		1:	85
+T: prioeq:		2:	82
+T: prioeq:		3:	83
+T: prioeq:              4:      84

  # Signal T1
  C: signal:		1: 	0
  W: unlocked:		1: 	0
  T: priolt:		0: 	1
+T: prioeq:		1:	81
+T: prioeq:		2:	82
+T: prioeq:		3:	83
+T: prioeq:              4:      84

  # Unlock and exit
  C: unlock:		3:	3
@@ -180,3 +190,9 @@ W: unlocked:		3:	3
  W: unlocked:		2:	2
  W: unlocked:		1:	1
  W: unlocked:		0:	0
+
+# Reset the -4 opcode from the signal
+C: reset:               1:      0
+C: reset:               2:      0
+C: reset:               3:      0
+C: reset:               4:      0
\ No newline at end of file
Index: linux-2.6.17-rt7/kernel/rtmutex_common.h
===================================================================
--- linux-2.6.17-rt7.orig/kernel/rtmutex_common.h
+++ linux-2.6.17-rt7/kernel/rtmutex_common.h
@@ -49,6 +49,7 @@ struct rt_mutex_waiter {
  	struct plist_node	pi_list_entry;
  	struct task_struct	*task;
  	struct rt_mutex		*lock;
+	int                     old_sched_lifo;
  #ifdef CONFIG_DEBUG_RT_MUTEXES
  	unsigned long		ip;
  	pid_t			deadlock_task_pid;

--
