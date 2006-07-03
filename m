Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750769AbWGCKsR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750769AbWGCKsR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 06:48:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750790AbWGCKsR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 06:48:17 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:44610 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1750769AbWGCKsQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 06:48:16 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=googlemail.com;
        h=received:date:x-x-sender:to:cc:subject:in-reply-to:message-id:references:mime-version:content-type:from;
        b=OE2qLn9zNqYi5Q2Fkq+0CkbWHu0XgFH/K2jJGasNKxMJNHdoWWdQXKDWHyordWjqWzXdTuFVj5Nl9JcytEr8T1z8K6KWaRbfmu1h/aCjfNgR+6GI7PMs1THMKLfANC59RnmWFteplrnzLvm1EUNresxKHo/i9Q/kf5PCPrn+fas=
Date: Mon, 3 Jul 2006 12:48:23 +0100 (BST)
X-X-Sender: simlo@localhost.localdomain
To: Esben Nielsen <nielsen.esben@gogglemail.com>
cc: Thomas Gleixner <tglx@linutronix.de>,
       Esben Nielsen <nielsen.esben@googlemail.com>,
       Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@elte.hu>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: Why can't I set the priority of softirq-hrt? (Re: 2.6.17-rt1)
In-Reply-To: <Pine.LNX.4.64.0606230055390.13514@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0606301946280.18456@localhost.localdomain>
References: <Pine.LNX.4.64.0606230055390.13514@localhost.localdomain>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-272187579-1151927303=:10199"
From: Esben Nielsen <nielsen.esben@googlemail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-272187579-1151927303=:10199
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed



On Fri, 23 Jun 2006, Esben Nielsen wrote:

> On Thu, 22 Jun 2006, Thomas Gleixner wrote:
>
>>  On Thu, 2006-06-22 at 19:06 +0100, Esben Nielsen wrote:
>> > > 
>> > >  Thats a seperate issue. Though you are right.
>> > 
>> >  Why not use my original patch and solve both issues?
>> >  I have even updated it to avoid the double traversal. It also removes
>> >  one other traversal which shouldn't be needed. (I have not had time
>> >  to boot the kernel with it, though, but it does compile...:-)
>> 
>
> Let me comment on your last sentence first:
>
>>  We want an immidate propagation.
> There is no such thing as "immidiate". The most you can say is that when you 
> return from setscheduler() everything is taken care off. I agree - it has to 
> be like that. But I just want to add _effectively_ taken care off. I.e. when 
> the within the time setscheduler() has returned _and_ the the relevant 
> priorities have time to run things get fixed. No, the users should not have 
> to worry about the priorities hanging around, but the system can wait with 
> fixing them it is relavant.
>
>>  Simply because it does not solve following scenario:
>>
>>  High prio task is blocked on lock and boosts 3 other tasks. Now the
>>  higher prrio watchdog detects that the high prio task is stuck and
>>  lowers the priority. You can wake it up as long as you want, the boosted
>>  task is still busy looping.
>
> Yes, you are right. I have thought about how to fix it, but it will be rather 
> ugly. I'll try to see what I can do though, but I am afraid the patch might 
> get too big. :-(
>
> (
> The same problem may actually always have been present in another corner 
> situation:
>   A boosts B whichs is blocked interruptible on a lock a boosts C, which 
> again boosts D (etc.). A and B are signalled roughly at the same time. A 
> wakes up first a decrease the priority of B but not C, because the B runs on 
> another CPU, but with lower priority and fixes C. A then stops because C is
> fixed. but D still have the A's priority and preempts B, which should fix it, 
> but has it's low priority back.
> This situation is not bad because A has already been in the and therefore 
> the designer has to think that C D etc already got it's priority. That A is 
> later on interrupted shouldn't matter.
> )
>


I did get around to make something. Besides solving the problems already 
discussed it solves and obvious problem not yet discussed:

Let us say you have a RT and a non-RT task sharing a mutex on a UP 
machine.
1. The non-RT takes the mutex.
2. The RT  tries to lock on the mutex with a 10 ms timeout.
3. The non-RT task is boostet to the RT's prio.
4. The non-RT task runs for 20 ms.
5. The non-RT task unlocks the mutex and is deboosted.
6. Now the RT task wakes up - after 20 ms.

The problem is clear: The RT task never gets the CPU even when it is timed 
out because the non-RT has the same prio and is already running. The 
timeout signal sends the RT task into the scheduler after the boosted 
non-RT task because everything is scheduled in FIFO order.

Notice: I have not yet tested this because I haven't got around to get a 
glibc with support for PI futexes. Where do I download that by the way?

So what do my patch do:

1) A new priority attribute, boosting_prio, is added to the task struct. 
This priority is the maximum priority the task is boosting another to. 
Neither the PI code itself, nor setscheduler() will ever lower the 
priority below this point. boosting_prio is initialized MAX_PRIO and then 
raised (numerically lowered :-), never lowered, every time the task is 
boosting another until the task is leaving the lock() operation due to a 
signal or timeout or because it is woken up.

2) The scheduler is modified such that tasks with boosting_prio!=MAX_PRIO 
is scheduled in LIFO order rather than FIFO. In other words: Tasks which 
are inside a rtmutex/lock locking operation will get their priority raised 
by a half and preempt other tasks having the same prioriy.

The net effect of all this is that the priority debooting, which is 
needed when a task times out, is signalled or setscheduler() is called, 
while the task is in a lock operation, runs in the task context itself, 
and the task is ensured to be able to preempt any of the tasks it has boosted.
If the task gets the lock it will loose it will not be woken up in LIFO 
order, because it will stop boosting anything before being woken up.
An odd effect is that after setscheduler() is used to lower a task's 
priority, it stays at a seemingly high priority while it is still blocked, 
but the task actually running in the critical section has the correct low 
priority. This is because boosting_prio is always set back to MAX_RT when 
the task leaves the lock operation.

Missing:
task->boosting_prio is protected by task->pi_lock. However, the scheduler 
reads task->boosting_prio without having that lock. I do not know enough 
of memory barriers to be able to insert them correctly. And it might be 
that the implicicit memory barriers from the pi_lock and the runqueue lock 
might be enoguh for all actual ways through the code.

I used Thomas's patch for the rt-tester, slightly modified. This is 
supposed to be applied first, as you really ought to apply the test before 
fixing the problem, to at least see that your test catches the problem.
I have attached my slightly modified version, but Thomas's version might 
be ok, but the main patch might not applie cleanly to the rttester 
scripts.

Will try to inline the main patch here so we can discuss it. I hope the 
white spaces are ok.

Esben


Index: linux-2.6.17-rt4/kernel/rtmutex.c
===================================================================
--- linux-2.6.17-rt4.orig/kernel/rtmutex.c
+++ linux-2.6.17-rt4/kernel/rtmutex.c
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
@@ -152,11 +157,12 @@ static void __rt_mutex_adjust_prio(struc
   * of task. We do not use the spin_xx_mutex() variants here as we are
   * outside of the debug path.)
   */
-static void rt_mutex_adjust_prio(struct task_struct *task)
+static void rt_mutex_adjust_prio_final(struct task_struct *task)
  {
  	unsigned long flags;

  	spin_lock_irqsave(&task->pi_lock, flags);
+	task->boosting_prio = MAX_PRIO;
  	__rt_mutex_adjust_prio(task);
  	spin_unlock_irqrestore(&task->pi_lock, flags);
  }
@@ -232,7 +238,8 @@ static int rt_mutex_adjust_prio_chain(ta
  	 * When deadlock detection is off then we check, if further
  	 * priority adjustment is necessary.
  	 */
-	if (!detect_deadlock && waiter->list_entry.prio == task->prio)
+	if (!detect_deadlock &&
+	    waiter->list_entry.prio == rt_mutex_getprio_real(task))
  		goto out_unlock_pi;

  	lock = waiter->lock;
@@ -254,7 +261,9 @@ static int rt_mutex_adjust_prio_chain(ta

  	/* Requeue the waiter */
  	plist_del(&waiter->list_entry, &lock->wait_list);
-	waiter->list_entry.prio = task->prio;
+	waiter->list_entry.prio = rt_mutex_getprio_real(task);
+	task->boosting_prio = min(task->boosting_prio,
+				  waiter->list_entry.prio);
  	plist_add(&waiter->list_entry, &lock->wait_list);

  	/* Release the task */
@@ -300,6 +309,18 @@ static int rt_mutex_adjust_prio_chain(ta
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
@@ -309,6 +330,7 @@ static inline int try_to_steal_lock(stru
  	struct task_struct *pendowner = rt_mutex_owner(lock);
  	struct rt_mutex_waiter *next;
  	unsigned long flags;
+	int current_prio;

  	if (!rt_mutex_owner_pending(lock))
  		return 0;
@@ -316,8 +338,12 @@ static inline int try_to_steal_lock(stru
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
@@ -335,6 +361,7 @@ static inline int try_to_steal_lock(stru
  	/* No chain handling, pending owner is not blocked on anything: */
  	next = rt_mutex_top_waiter(lock);
  	plist_del(&next->pi_list_entry, &pendowner->pi_waiters);
+	pendowner->boosting_prio = MAX_PRIO;
  	__rt_mutex_adjust_prio(pendowner);
  	spin_unlock_irqrestore(&pendowner->pi_lock, flags);

@@ -426,8 +453,8 @@ static int task_blocks_on_rt_mutex(struc
  	__rt_mutex_adjust_prio(current);
  	waiter->task = current;
  	waiter->lock = lock;
-	plist_node_init(&waiter->list_entry, current->prio);
-	plist_node_init(&waiter->pi_list_entry, current->prio);
+	plist_node_init(&waiter->list_entry, rt_mutex_getprio_real(current));
+	plist_node_init(&waiter->pi_list_entry, waiter->list_entry.prio);

  	/* Get the top priority waiter on the lock */
  	if (rt_mutex_has_waiters(lock))
@@ -435,7 +462,8 @@ static int task_blocks_on_rt_mutex(struc
  	plist_add(&waiter->list_entry, &lock->wait_list);

  	current->pi_blocked_on = waiter;
-
+	current->boosting_prio = min(current->boosting_prio,
+				     waiter->list_entry.prio);
  	spin_unlock_irqrestore(&current->pi_lock, flags);

  	if (waiter == rt_mutex_top_waiter(lock)) {
@@ -499,7 +527,6 @@ static void wakeup_next_waiter(struct rt
  	plist_del(&waiter->pi_list_entry, &current->pi_waiters);
  	pendowner = waiter->task;
  	waiter->task = NULL;
-
  	rt_mutex_set_owner(lock, pendowner, RT_MUTEX_OWNER_PENDING);

  	spin_unlock_irqrestore(&current->pi_lock, flags);
@@ -518,6 +545,7 @@ static void wakeup_next_waiter(struct rt
  	WARN_ON(pendowner->pi_blocked_on->lock != lock);

  	pendowner->pi_blocked_on = NULL;
+	pendowner->boosting_prio = MAX_PRIO;

  	if (rt_mutex_has_waiters(lock)) {
  		struct rt_mutex_waiter *next;
@@ -525,6 +553,7 @@ static void wakeup_next_waiter(struct rt
  		next = rt_mutex_top_waiter(lock);
  		plist_add(&next->pi_list_entry, &pendowner->pi_waiters);
  	}
+	__rt_mutex_adjust_prio(pendowner);
  	spin_unlock_irqrestore(&pendowner->pi_lock, flags);

  	if (savestate)
@@ -539,7 +568,8 @@ static void wakeup_next_waiter(struct rt
   * Must be called with lock->wait_lock held
   */
  static void remove_waiter(struct rt_mutex *lock,
-			  struct rt_mutex_waiter *waiter  __IP_DECL__)
+			  struct rt_mutex_waiter *waiter
+			  __IP_DECL__)
  {
  	int first = (waiter == rt_mutex_top_waiter(lock));
  	int boost = 0;
@@ -621,7 +651,8 @@ static void fastcall noinline __sched
  rt_lock_slowlock(struct rt_mutex *lock __IP_DECL__)
  {
  	struct rt_mutex_waiter waiter;
-	unsigned long saved_state, state;      ;
+	unsigned long saved_state, state;
+	int adjust_prio_final = 0;

  	debug_rt_mutex_init_waiter(&waiter);
  	waiter.task = NULL;
@@ -661,12 +692,17 @@ rt_lock_slowlock(struct rt_mutex *lock _
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
@@ -699,8 +735,10 @@ rt_lock_slowlock(struct rt_mutex *lock _
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
@@ -709,7 +747,11 @@ rt_lock_slowlock(struct rt_mutex *lock _

  	spin_unlock(&lock->wait_lock);

+	if (adjust_prio_final)
+		rt_mutex_adjust_prio_final(current);
+
  	debug_rt_mutex_free_waiter(&waiter);
+	BUG_ON(current->boosting_prio != MAX_PRIO);
  }

  /*
@@ -735,7 +777,8 @@ rt_lock_slowunlock(struct rt_mutex *lock
  	spin_unlock(&lock->wait_lock);

  	/* Undo pi boosting.when necessary */
-	rt_mutex_adjust_prio(current);
+	rt_mutex_adjust_prio_final(current);
+	BUG_ON(current->boosting_prio != MAX_PRIO);
  }

  void __lockfunc rt_lock(struct rt_mutex *lock)
@@ -795,6 +838,7 @@ rt_mutex_slowlock(struct rt_mutex *lock,
  {
  	int ret = 0, saved_lock_depth = -1;
  	struct rt_mutex_waiter waiter;
+	int adjust_prio_final = 0;

  	debug_rt_mutex_init_waiter(&waiter);
  	waiter.task = NULL;
@@ -848,21 +892,28 @@ rt_mutex_slowlock(struct rt_mutex *lock,
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

@@ -881,8 +932,13 @@ rt_mutex_slowlock(struct rt_mutex *lock,

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
@@ -892,17 +948,13 @@ rt_mutex_slowlock(struct rt_mutex *lock,

  	spin_unlock(&lock->wait_lock);

+	if (adjust_prio_final)
+		rt_mutex_adjust_prio_final(current);
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
@@ -910,6 +962,8 @@ rt_mutex_slowlock(struct rt_mutex *lock,

  	debug_rt_mutex_free_waiter(&waiter);

+	BUG_ON(current->boosting_prio != MAX_PRIO);
+
  	return ret;
  }

@@ -962,7 +1016,8 @@ rt_mutex_slowunlock(struct rt_mutex *loc
  	spin_unlock(&lock->wait_lock);

  	/* Undo pi boosting if necessary: */
-	rt_mutex_adjust_prio(current);
+	rt_mutex_adjust_prio_final(current);
+	BUG_ON(current->boosting_prio != MAX_PRIO);
  }

  /*
Index: linux-2.6.17-rt4/kernel/sched.c
===================================================================
--- linux-2.6.17-rt4.orig/kernel/sched.c
+++ linux-2.6.17-rt4/kernel/sched.c
@@ -57,6 +57,8 @@

  #include <asm/unistd.h>

+#include "rtmutex_common.h"
+
  /*
   * Convert user-nice values [ -20 ... 0 ... 19 ]
   * to static priority [ MAX_RT_PRIO..MAX_PRIO-1 ],
@@ -162,9 +164,8 @@
  	(JIFFIES_TO_NS(MAX_SLEEP_AVG * \
  		(MAX_BONUS / 2 + DELTA((p)) + 1) / MAX_BONUS - 1))

-#define TASK_PREEMPTS_CURR(p, rq) \
-	((p)->prio < (rq)->curr->prio)
-
+#define TASK_PREEMPTS(p,q) task_preempts(p,q)
+#define TASK_PREEMPTS_CURR(p, rq) TASK_PREEMPTS(p, (rq)->curr)
  /*
   * task_timeslice() scales user-nice values [ -20 ... 0 ... 19 ]
   * to time slice values: [800ms ... 100ms ... 5ms]
@@ -399,6 +400,22 @@ static inline void finish_lock_switch(ru
  }
  #endif /* __ARCH_WANT_UNLOCKED_CTXSW */

+
+static inline int task_preempts(task_t *p, task_t *q)
+{
+	if (p->prio < q->prio)
+		return 1;
+
+#ifdef CONFIG_RT_MUTEXES
+	if (p->prio > q->prio)
+		return 0;
+
+	return p->boosting_prio != MAX_PRIO-1;
+#else
+	return 0;
+#endif
+}
+
  /*
   * task_rq_lock - lock the runqueue a given task resides on and disable
   * interrupts.  Note the ordering: we can safely lookup the task_rq without
@@ -646,7 +663,9 @@ static inline void sched_info_switch(tas
  #define sched_info_switch(t, next)	do { } while (0)
  #endif /* CONFIG_SCHEDSTATS */

+#ifdef CONFIG_SMP
  static __cacheline_aligned_in_smp atomic_t rt_overload;
+#endif

  static inline void inc_rt_tasks(task_t *p, runqueue_t *rq)
  {
@@ -710,7 +729,13 @@ static void enqueue_task(struct task_str
  		dump_stack();
  	}
  	sched_info_queued(p);
-	list_add_tail(&p->run_list, array->queue + p->prio);
+#ifdef CONFIG_RT_MUTEXES
+	if (p->boosting_prio != MAX_PRIO)
+		list_add(&p->run_list, array->queue + p->prio);
+	else
+#endif
+		list_add_tail(&p->run_list, array->queue + p->prio);
+
  	__set_bit(p->prio, array->bitmap);
  	array->nr_active++;
  	p->array = array;
@@ -723,7 +748,12 @@ static void enqueue_task(struct task_str
   */
  static void requeue_task(struct task_struct *p, prio_array_t *array)
  {
-	list_move_tail(&p->run_list, array->queue + p->prio);
+#ifdef CONFIG_RT_MUTEXES
+	if (p->boosting_prio != MAX_PRIO)
+		list_move(&p->run_list, array->queue + p->prio);
+	else
+#endif
+		list_move_tail(&p->run_list, array->queue + p->prio);
  }

  static inline void enqueue_task_head(struct task_struct *p, prio_array_t *array)
@@ -1313,7 +1343,7 @@ static void balance_rt_tasks(runqueue_t
  		 * Do we have an RT task that preempts
  		 * the to-be-scheduled task?
  		 */
-		if (p && (p->prio < next->prio)) {
+		if (p && TASK_PREEMPTS(p, next)) {
  			WARN_ON(p == src_rq->curr);
  			WARN_ON(!p->array);
  			schedstat_inc(this_rq, rto_pulled);
@@ -1473,10 +1503,11 @@ static inline int wake_idle(int cpu, tas
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
@@ -4351,6 +4382,14 @@ int setscheduler(struct task_struct *p,
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
@@ -7086,4 +7125,3 @@ void notrace preempt_enable_no_resched(v

  EXPORT_SYMBOL(preempt_enable_no_resched);
  #endif
-
Index: linux-2.6.17-rt4/include/linux/sched.h
===================================================================
--- linux-2.6.17-rt4.orig/include/linux/sched.h
+++ linux-2.6.17-rt4/include/linux/sched.h
@@ -994,6 +994,13 @@ struct task_struct {
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
Index: linux-2.6.17-rt4/scripts/rt-tester/t5-l4-pi-boost-deboost.tst
===================================================================
--- linux-2.6.17-rt4.orig/scripts/rt-tester/t5-l4-pi-boost-deboost.tst
+++ linux-2.6.17-rt4/scripts/rt-tester/t5-l4-pi-boost-deboost.tst
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
Index: linux-2.6.17-rt4/kernel/fork.c
===================================================================
--- linux-2.6.17-rt4.orig/kernel/fork.c
+++ linux-2.6.17-rt4/kernel/fork.c
@@ -955,6 +955,7 @@ static inline void rt_mutex_init_task(st
  	spin_lock_init(&p->pi_lock);
  	plist_head_init(&p->pi_waiters, &p->pi_lock);
  	p->pi_blocked_on = NULL;
+	p->boosting_prio = MAX_PRIO;
  # ifdef CONFIG_DEBUG_RT_MUTEXES
  	spin_lock_init(&p->held_list_lock);
  	INIT_LIST_HEAD(&p->held_list_head);
Index: linux-2.6.17-rt4/include/linux/rtmutex.h
===================================================================
--- linux-2.6.17-rt4.orig/include/linux/rtmutex.h
+++ linux-2.6.17-rt4/include/linux/rtmutex.h
@@ -116,6 +116,7 @@ extern void rt_mutex_unlock(struct rt_mu
  # define INIT_RT_MUTEXES(tsk)						\
  	.pi_waiters	= PLIST_HEAD_INIT(tsk.pi_waiters, tsk.pi_lock),	\
  	.pi_lock	= RAW_SPIN_LOCK_UNLOCKED,			\
+        .boosting_prio  = MAX_PRIO                                      \
  	INIT_RT_MUTEX_DEBUG(tsk)
  #else
  # define INIT_RT_MUTEXES(tsk)
Index: linux-2.6.17-rt4/scripts/rt-tester/t5-l4-pi-boost-deboost-setsched.tst
===================================================================
--- linux-2.6.17-rt4.orig/scripts/rt-tester/t5-l4-pi-boost-deboost-setsched.tst
+++ linux-2.6.17-rt4/scripts/rt-tester/t5-l4-pi-boost-deboost-setsched.tst
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
--8323328-272187579-1151927303=:10199
Content-Type: TEXT/PLAIN; charset=US-ASCII; name=rt-tester-setprio.patch
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.64.0607031248230.10199@localhost.localdomain>
Content-Description: 
Content-Disposition: attachment; filename=rt-tester-setprio.patch

TWFrZSB0ZXN0IHN1aXRlIHNldHNjaGVkdWxlciBjYWxscyBhc3luY2hyb25v
dXNseS4gUmVtb3ZlIHRoZSB3YWl0cyBpbiB0aGUgdGVzdA0KY2FzZXMgYW5k
IGFkZCBhIG5ldyB0ZXN0Y2FzZSB0byB2ZXJpZnkgdGhlIGNvcnJlY3RuZXNz
IG9mIHRoZSBzZXRzY2hlZHVsZXINCnByaW9yaXR5IHByb3BhZ2F0aW9uDQpU
aGlzIGlzIGJhc2VkIG9uIGFuZCBhbG1vc3QgaWRlbnRpY2FsIHRvIHRoZSBv
bmUgVGhvbWFzIEdsZWl4bmVyIHNlbnQgb3V0IA0KZWFybGllci4NCkluZGV4
OiBsaW51eC0yLjYuMTctcnQ0L2tlcm5lbC9ydG11dGV4LXRlc3Rlci5jDQo9
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09DQotLS0gbGludXgtMi42LjE3LXJ0NC5v
cmlnL2tlcm5lbC9ydG11dGV4LXRlc3Rlci5jDQorKysgbGludXgtMi42LjE3
LXJ0NC9rZXJuZWwvcnRtdXRleC10ZXN0ZXIuYw0KQEAgLTU1LDcgKzU1LDYg
QEAgZW51bSB0ZXN0X29wY29kZXMgew0KIA0KIHN0YXRpYyBpbnQgaGFuZGxl
X29wKHN0cnVjdCB0ZXN0X3RocmVhZF9kYXRhICp0ZCwgaW50IGxvY2t3YWtl
dXApDQogew0KLQlzdHJ1Y3Qgc2NoZWRfcGFyYW0gc2NoZWRwYXI7DQogCWlu
dCBpLCBpZCwgcmV0ID0gLUVJTlZBTDsNCiANCiAJc3dpdGNoKHRkLT5vcGNv
ZGUpIHsNCkBAIC02MywxNyArNjIsNiBAQCBzdGF0aWMgaW50IGhhbmRsZV9v
cChzdHJ1Y3QgdGVzdF90aHJlYWRfDQogCWNhc2UgUlRURVNUX05PUDoNCiAJ
CXJldHVybiAwOw0KIA0KLQljYXNlIFJUVEVTVF9TQ0hFRE9UOg0KLQkJc2No
ZWRwYXIuc2NoZWRfcHJpb3JpdHkgPSAwOw0KLQkJcmV0ID0gc2NoZWRfc2V0
c2NoZWR1bGVyKGN1cnJlbnQsIFNDSEVEX05PUk1BTCwgJnNjaGVkcGFyKTsN
Ci0JCWlmICghcmV0KQ0KLQkJCXNldF91c2VyX25pY2UoY3VycmVudCwgMCk7
DQotCQlyZXR1cm4gcmV0Ow0KLQ0KLQljYXNlIFJUVEVTVF9TQ0hFRFJUOg0K
LQkJc2NoZWRwYXIuc2NoZWRfcHJpb3JpdHkgPSB0ZC0+b3BkYXRhOw0KLQkJ
cmV0dXJuIHNjaGVkX3NldHNjaGVkdWxlcihjdXJyZW50LCBTQ0hFRF9GSUZP
LCAmc2NoZWRwYXIpOw0KLQ0KIAljYXNlIFJUVEVTVF9MT0NLQ09OVDoNCiAJ
CXRkLT5tdXRleGVzW3RkLT5vcGRhdGFdID0gMTsNCiAJCXRkLT5ldmVudCA9
IGF0b21pY19hZGRfcmV0dXJuKDEsICZydHRlc3RfZXZlbnQpOw0KQEAgLTMx
MCw5ICsyOTgsMTAgQEAgc3RhdGljIGludCB0ZXN0X2Z1bmModm9pZCAqZGF0
YSkNCiBzdGF0aWMgc3NpemVfdCBzeXNmc190ZXN0X2NvbW1hbmQoc3RydWN0
IHN5c19kZXZpY2UgKmRldiwgY29uc3QgY2hhciAqYnVmLA0KIAkJCQkgIHNp
emVfdCBjb3VudCkNCiB7DQorCXN0cnVjdCBzY2hlZF9wYXJhbSBzY2hlZHBh
cjsNCiAJc3RydWN0IHRlc3RfdGhyZWFkX2RhdGEgKnRkOw0KIAljaGFyIGNt
ZGJ1ZlszMl07DQotCWludCBvcCwgZGF0LCB0aWQ7DQorCWludCBvcCwgZGF0
LCB0aWQsIHJldDsNCiANCiAJdGQgPSBjb250YWluZXJfb2YoZGV2LCBzdHJ1
Y3QgdGVzdF90aHJlYWRfZGF0YSwgc3lzZGV2KTsNCiAJdGlkID0gdGQtPnN5
c2Rldi5pZDsNCkBAIC0zMzQsNiArMzIzLDIyIEBAIHN0YXRpYyBzc2l6ZV90
IHN5c2ZzX3Rlc3RfY29tbWFuZChzdHJ1Y3QNCiAJCXJldHVybiAtRUlOVkFM
Ow0KIA0KIAlzd2l0Y2ggKG9wKSB7DQorCWNhc2UgUlRURVNUX1NDSEVET1Q6
DQorCQlzY2hlZHBhci5zY2hlZF9wcmlvcml0eSA9IDA7DQorCQlyZXQgPSBz
Y2hlZF9zZXRzY2hlZHVsZXIodGhyZWFkc1t0aWRdLCBTQ0hFRF9OT1JNQUws
DQorCQkJCQkgJnNjaGVkcGFyKTsNCisJCWlmIChyZXQpDQorCQkJcmV0dXJu
IHJldDsNCisJCXNldF91c2VyX25pY2UoY3VycmVudCwgMCk7DQorCQlicmVh
azsNCisNCisJY2FzZSBSVFRFU1RfU0NIRURSVDoNCisJCXNjaGVkcGFyLnNj
aGVkX3ByaW9yaXR5ID0gZGF0Ow0KKwkJcmV0ID0gc2NoZWRfc2V0c2NoZWR1
bGVyKHRocmVhZHNbdGlkXSwgU0NIRURfRklGTywgJnNjaGVkcGFyKTsNCisJ
CWlmIChyZXQpDQorCQkJcmV0dXJuIHJldDsNCisJCWJyZWFrOw0KKw0KIAlj
YXNlIFJUVEVTVF9TSUdOQUw6DQogCQlzZW5kX3NpZyhTSUdIVVAsIHRocmVh
ZHNbdGlkXSwgMCk7DQogCQlicmVhazsNCkluZGV4OiBsaW51eC0yLjYuMTct
cnQ0L3NjcmlwdHMvcnQtdGVzdGVyL3Jlc2V0LXRlc3Rlci5weQ0KPT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PQ0KLS0tIC9kZXYvbnVsbA0KKysrIGxpbnV4LTIu
Ni4xNy1ydDQvc2NyaXB0cy9ydC10ZXN0ZXIvcmVzZXQtdGVzdGVyLnB5DQpA
QCAtMCwwICsxLDE4IEBADQorIyEvdXNyL2Jpbi9lbnYgcHl0aG9uDQorDQor
c3lzZnNwcmVmaXggPSAiL3N5cy9kZXZpY2VzL3N5c3RlbS9ydHRlc3QvcnR0
ZXN0Ig0KK3N0YXR1c2ZpbGUgPSAiL3N0YXR1cyINCitjb21tYW5kZmlsZSA9
ICIvY29tbWFuZCINCisNCitmb3IgaSBpbiByYW5nZSgwLDgpOg0KKyAgICBj
bWRzdHIgPSAiJXM6JXMiICUoIjk5IiwgIjAiKQ0KKyAgICBmbmFtZSA9ICIl
cyVkJXMiICUoc3lzZnNwcmVmaXgsIGksIGNvbW1hbmRmaWxlKQ0KKw0KKyAg
ICB0cnk6DQorICAgICAgICBmY21kID0gb3BlbihmbmFtZSwgJ3cnKQ0KKyAg
ICAgICAgZmNtZC53cml0ZShjbWRzdHIpDQorICAgICAgICBmY21kLmNsb3Nl
KCkNCisgICAgZXhjZXB0IEV4Y2VwdGlvbixleDoNCisgICAgICAgIHByaW50
IGkNCisgICAgICAgIHByaW50IGV4DQorDQpJbmRleDogbGludXgtMi42LjE3
LXJ0NC9zY3JpcHRzL3J0LXRlc3Rlci90Mi1sMS1zaWduYWwudHN0DQo9PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09DQotLS0gbGludXgtMi42LjE3LXJ0NC5vcmln
L3NjcmlwdHMvcnQtdGVzdGVyL3QyLWwxLXNpZ25hbC50c3QNCisrKyBsaW51
eC0yLjYuMTctcnQ0L3NjcmlwdHMvcnQtdGVzdGVyL3QyLWwxLXNpZ25hbC50
c3QNCkBAIC03NywzICs3Nyw2IEBAIFQ6IG9wY29kZWVxOgkJMToJLTQNCiAj
IFVubG9jayBhbmQgZXhpdA0KIEM6IHVubG9jazoJCTA6IAkwDQogVzogdW5s
b2NrZWQ6CQkwOiAJMA0KKw0KKyMgUmVzZXQgdGhlIC00IG9wY29kZSBmcm9t
IHRoZSBzaWduYWwNCitDOiByZXNldDogICAgICAgICAgICAgICAxOiAgICAg
IDANClwgTm8gbmV3bGluZSBhdCBlbmQgb2YgZmlsZQ0KSW5kZXg6IGxpbnV4
LTIuNi4xNy1ydDQvc2NyaXB0cy9ydC10ZXN0ZXIvdDMtbDEtcGktc2lnbmFs
LnRzdA0KPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PQ0KLS0tIGxpbnV4LTIuNi4x
Ny1ydDQub3JpZy9zY3JpcHRzL3J0LXRlc3Rlci90My1sMS1waS1zaWduYWwu
dHN0DQorKysgbGludXgtMi42LjE3LXJ0NC9zY3JpcHRzL3J0LXRlc3Rlci90
My1sMS1waS1zaWduYWwudHN0DQpAQCAtOTgsNCArOTgsNSBAQCBDOiB1bmxv
Y2s6CQkxOiAJMA0KIFc6IHVubG9ja2VkOgkJMTogCTANCiANCiANCi0NCisj
IFJlc2V0IHRoZSAtNCBvcGNvZGUgZnJvbSB0aGUgc2lnbmFsDQorQzogcmVz
ZXQ6ICAgICAgICAgICAgICAgMjogICAgICAwDQpcIE5vIG5ld2xpbmUgYXQg
ZW5kIG9mIGZpbGUNCkluZGV4OiBsaW51eC0yLjYuMTctcnQ0L3NjcmlwdHMv
cnQtdGVzdGVyL3Q0LWwyLXBpLWRlYm9vc3QudHN0DQo9PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09DQotLS0gbGludXgtMi42LjE3LXJ0NC5vcmlnL3NjcmlwdHMv
cnQtdGVzdGVyL3Q0LWwyLXBpLWRlYm9vc3QudHN0DQorKysgbGludXgtMi42
LjE3LXJ0NC9zY3JpcHRzL3J0LXRlc3Rlci90NC1sMi1waS1kZWJvb3N0LnRz
dA0KQEAgLTEyNSwzICsxMjUsNSBAQCBXOiB1bmxvY2tlZDoJCTI6CTENCiBD
OiB1bmxvY2s6CQkwOgkwDQogVzogdW5sb2NrZWQ6CQkwOgkwDQogDQorIyBS
ZXNldCB0aGUgLTQgb3Bjb2RlIGZyb20gdGhlIHNpZ25hbA0KK0M6IHJlc2V0
OiAgICAgICAgICAgICAgIDM6ICAgICAgMA0KXCBObyBuZXdsaW5lIGF0IGVu
ZCBvZiBmaWxlDQpJbmRleDogbGludXgtMi42LjE3LXJ0NC9zY3JpcHRzL3J0
LXRlc3Rlci90NS1sNC1waS1ib29zdC1kZWJvb3N0LXNldHNjaGVkLnRzdA0K
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PQ0KLS0tIC9kZXYvbnVsbA0KKysrIGxp
bnV4LTIuNi4xNy1ydDQvc2NyaXB0cy9ydC10ZXN0ZXIvdDUtbDQtcGktYm9v
c3QtZGVib29zdC1zZXRzY2hlZC50c3QNCkBAIC0wLDAgKzEsMTgyIEBADQor
Iw0KKyMgcnQtbXV0ZXggdGVzdA0KKyMNCisjIE9wOiBDKG9tbWFuZCkvVChl
c3QpL1coYWl0KQ0KKyMgfCAgb3Bjb2RlDQorIyB8ICB8ICAgICB0aHJlYWRp
ZDogMC03DQorIyB8ICB8ICAgICB8ICBvcGNvZGUgYXJndW1lbnQNCisjIHwg
IHwgICAgIHwgIHwNCisjIEM6IGxvY2s6IDA6IDANCisjDQorIyBDb21tYW5k
cw0KKyMNCisjIG9wY29kZQlvcGNvZGUgYXJndW1lbnQNCisjIHNjaGVkb3Ro
ZXIJbmljZSB2YWx1ZQ0KKyMgc2NoZWRmaWZvCXByaW9yaXR5DQorIyBsb2Nr
CQlsb2NrIG5yICgwLTcpDQorIyBsb2Nrbm93YWl0CWxvY2sgbnIgKDAtNykN
CisjIGxvY2tpbnQJbG9jayBuciAoMC03KQ0KKyMgbG9ja2ludG5vd2FpdAls
b2NrIG5yICgwLTcpDQorIyBsb2NrY29udAlsb2NrIG5yICgwLTcpDQorIyB1
bmxvY2sJbG9jayBuciAoMC03KQ0KKyMgbG9ja2JrbAlsb2NrIG5yICgwLTcp
DQorIyB1bmxvY2tia2wJbG9jayBuciAoMC03KQ0KKyMgc2lnbmFsCXRocmVh
ZCB0byBzaWduYWwgKDAtNykNCisjIHJlc2V0CQkwDQorIyByZXNldGV2ZW50
CTANCisjDQorIyBUZXN0cyAvIFdhaXQNCisjDQorIyBvcGNvZGUJb3Bjb2Rl
IGFyZ3VtZW50DQorIw0KKyMgcHJpb2VxCXByaW9yaXR5DQorIyBwcmlvbHQJ
cHJpb3JpdHkNCisjIHByaW9ndAlwcmlvcml0eQ0KKyMgbnByaW9lcQlub3Jt
YWwgcHJpb3JpdHkNCisjIG5wcmlvbHQJbm9ybWFsIHByaW9yaXR5DQorIyBu
cHJpb2d0CW5vcm1hbCBwcmlvcml0eQ0KKyMgbG9ja2VkCWxvY2sgbnIgKDAt
NykNCisjIGJsb2NrZWQJbG9jayBuciAoMC03KQ0KKyMgYmxvY2tlZHdha2UJ
bG9jayBuciAoMC03KQ0KKyMgdW5sb2NrZWQJbG9jayBuciAoMC03KQ0KKyMg
bG9ja2VkYmtsCWRvbnQgY2FyZQ0KKyMgYmxvY2tlZGJrbAlkb250IGNhcmUN
CisjIHVubG9ja2VkYmtsCWRvbnQgY2FyZQ0KKyMgb3Bjb2RlZXEJY29tbWFu
ZCBvcGNvZGUgb3IgbnVtYmVyDQorIyBvcGNvZGVsdAludW1iZXINCisjIG9w
Y29kZWd0CW51bWJlcg0KKyMgZXZlbnRlcQludW1iZXINCisjIGV2ZW50Z3QJ
bnVtYmVyDQorIyBldmVudGx0CW51bWJlcg0KKw0KKyMNCisjIDUgdGhyZWFk
cyA0IGxvY2sgUEkgLSBtb2RpZnkgcHJpb3JpdHkgb2YgYmxvY2tlZCB0aHJl
YWRzDQorIw0KK0M6IHJlc2V0ZXZlbnQ6CQkwOiAJMA0KK1c6IG9wY29kZWVx
OgkJMDogCTANCisNCisjIFNldCBzY2hlZHVsZXJzDQorQzogc2NoZWRvdGhl
cjoJCTA6IAkwDQorQzogc2NoZWRmaWZvOgkJMTogCTgxDQorQzogc2NoZWRm
aWZvOgkJMjogCTgyDQorQzogc2NoZWRmaWZvOgkJMzogCTgzDQorQzogc2No
ZWRmaWZvOgkJNDogCTg0DQorDQorIyBUMCBsb2NrIEwwDQorQzogbG9ja25v
d2FpdDoJCTA6IAkwDQorVzogbG9ja2VkOgkJMDogCTANCisNCisjIFQxIGxv
Y2sgTDENCitDOiBsb2Nrbm93YWl0OgkJMTogCTENCitXOiBsb2NrZWQ6CQkx
OiAJMQ0KKw0KKyMgVDEgbG9jayBMMA0KK0M6IGxvY2tpbnRub3dhaXQ6CTE6
IAkwDQorVzogYmxvY2tlZDoJCTE6IAkwDQorVDogcHJpb2VxOgkJMDogCTgx
DQorDQorIyBUMiBsb2NrIEwyDQorQzogbG9ja25vd2FpdDoJCTI6IAkyDQor
VzogbG9ja2VkOgkJMjogCTINCisNCisjIFQyIGxvY2sgTDENCitDOiBsb2Nr
aW50bm93YWl0OgkyOiAJMQ0KK1c6IGJsb2NrZWQ6CQkyOiAJMQ0KK1Q6IHBy
aW9lcToJCTA6IAk4Mg0KK1Q6IHByaW9lcToJCTE6CTgyDQorDQorIyBUMyBs
b2NrIEwzDQorQzogbG9ja25vd2FpdDoJCTM6IAkzDQorVzogbG9ja2VkOgkJ
MzogCTMNCisNCisjIFQzIGxvY2sgTDINCitDOiBsb2NraW50bm93YWl0Ogkz
OiAJMg0KK1c6IGJsb2NrZWQ6CQkzOiAJMg0KK1Q6IHByaW9lcToJCTA6IAk4
Mw0KK1Q6IHByaW9lcToJCTE6CTgzDQorVDogcHJpb2VxOgkJMjoJODMNCisN
CisjIFQ0IGxvY2sgTDMNCitDOiBsb2NraW50bm93YWl0Ogk0OgkzDQorVzog
YmxvY2tlZDoJCTQ6IAkzDQorVDogcHJpb2VxOgkJMDogCTg0DQorVDogcHJp
b2VxOgkJMToJODQNCitUOiBwcmlvZXE6CQkyOgk4NA0KK1Q6IHByaW9lcToJ
CTM6CTg0DQorDQorIyBSZWR1Y2UgcHJpbyBvZiBUNA0KK0M6IHNjaGVkZmlm
bzoJCTQ6IAk4MA0KK1Q6IHByaW9lcToJCTA6IAk4Mw0KK1Q6IHByaW9lcToJ
CTE6CTgzDQorVDogcHJpb2VxOgkJMjoJODMNCitUOiBwcmlvZXE6CQkzOgk4
Mw0KK1Q6IHByaW9lcToJCTQ6CTgwDQorDQorIyBJbmNyZWFzZSBwcmlvIG9m
IFQ0DQorQzogc2NoZWRmaWZvOgkJNDogCTg0DQorVDogcHJpb2VxOgkJMDog
CTg0DQorVDogcHJpb2VxOgkJMToJODQNCitUOiBwcmlvZXE6CQkyOgk4NA0K
K1Q6IHByaW9lcToJCTM6CTg0DQorVDogcHJpb2VxOgkJNDoJODQNCisNCisj
IFJlZHVjZSBwcmlvIG9mIFQzDQorQzogc2NoZWRmaWZvOgkJMzogCTgwDQor
VDogcHJpb2VxOgkJMDogCTg0DQorVDogcHJpb2VxOgkJMToJODQNCitUOiBw
cmlvZXE6CQkyOgk4NA0KK1Q6IHByaW9lcToJCTM6CTg0DQorVDogcHJpb2Vx
OgkJNDoJODQNCisNCisjIEluY3JlYXNlIHByaW8gb2YgVDMNCitDOiBzY2hl
ZGZpZm86CQkzOiAJODUNCitUOiBwcmlvZXE6CQkwOiAJODUNCitUOiBwcmlv
ZXE6CQkxOgk4NQ0KK1Q6IHByaW9lcToJCTI6CTg1DQorVDogcHJpb2VxOgkJ
MzoJODUNCitUOiBwcmlvZXE6CQk0Ogk4NA0KKw0KKyMgUmVkdWNlIHByaW8g
b2YgVDMNCitDOiBzY2hlZGZpZm86CQkzOiAJODMNCitUOiBwcmlvZXE6CQkw
OiAJODQNCitUOiBwcmlvZXE6CQkxOgk4NA0KK1Q6IHByaW9lcToJCTI6CTg0
DQorVDogcHJpb2VxOgkJMzoJODQNCitUOiBwcmlvZXE6CQk0Ogk4NA0KKw0K
KyMgU2lnbmFsIFQ0DQorQzogc2lnbmFsOgkJNDogCTANCitXOiB1bmxvY2tl
ZDoJCTQ6IAkzDQorVDogcHJpb2VxOgkJMDogCTgzDQorVDogcHJpb2VxOgkJ
MToJODMNCitUOiBwcmlvZXE6CQkyOgk4Mw0KK1Q6IHByaW9lcToJCTM6CTgz
DQorDQorIyBTaWduYWwgVDMNCitDOiBzaWduYWw6CQkzOiAJMA0KK1c6IHVu
bG9ja2VkOgkJMzogCTINCitUOiBwcmlvZXE6CQkwOiAJODINCitUOiBwcmlv
ZXE6CQkxOgk4Mg0KK1Q6IHByaW9lcToJCTI6CTgyDQorDQorIyBTaWduYWwg
VDINCitDOiBzaWduYWw6CQkyOiAJMA0KK1c6IHVubG9ja2VkOgkJMjogCTEN
CitUOiBwcmlvZXE6CQkwOiAJODENCitUOiBwcmlvZXE6CQkxOgk4MQ0KKw0K
KyMgU2lnbmFsIFQxDQorQzogc2lnbmFsOgkJMTogCTANCitXOiB1bmxvY2tl
ZDoJCTE6IAkwDQorVDogcHJpb2x0OgkJMDogCTENCisNCisjIFVubG9jayBh
bmQgZXhpdA0KK0M6IHVubG9jazoJCTM6CTMNCitDOiB1bmxvY2s6CQkyOgky
DQorQzogdW5sb2NrOgkJMToJMQ0KK0M6IHVubG9jazoJCTA6CTANCisNCitX
OiB1bmxvY2tlZDoJCTM6CTMNCitXOiB1bmxvY2tlZDoJCTI6CTINCitXOiB1
bmxvY2tlZDoJCTE6CTENCitXOiB1bmxvY2tlZDoJCTA6CTANCkluZGV4OiBs
aW51eC0yLjYuMTctcnQ0L3NjcmlwdHMvcnQtdGVzdGVyL3Q1LWw0LXBpLWJv
b3N0LWRlYm9vc3QudHN0DQo9PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09DQotLS0g
bGludXgtMi42LjE3LXJ0NC5vcmlnL3NjcmlwdHMvcnQtdGVzdGVyL3Q1LWw0
LXBpLWJvb3N0LWRlYm9vc3QudHN0DQorKysgbGludXgtMi42LjE3LXJ0NC9z
Y3JpcHRzL3J0LXRlc3Rlci90NS1sNC1waS1ib29zdC1kZWJvb3N0LnRzdA0K
QEAgLTE0NiwzICsxNDYsNSBAQCBXOiB1bmxvY2tlZDoJCTI6CTINCiBXOiB1
bmxvY2tlZDoJCTE6CTENCiBXOiB1bmxvY2tlZDoJCTA6CTANCiANCisjIFJl
c2V0IHRoZSAtNCBvcGNvZGUgZnJvbSB0aGUgc2lnbmFsDQorQzogcmVzZXQ6
ICAgICAgICAgICAgICAgNDogICAgICAwDQpcIE5vIG5ld2xpbmUgYXQgZW5k
IG9mIGZpbGUNCkluZGV4OiBsaW51eC0yLjYuMTctcnQ0L3NjcmlwdHMvcnQt
dGVzdGVyL2NoZWNrLWFsbC5zaA0KPT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQ0K
LS0tIGxpbnV4LTIuNi4xNy1ydDQub3JpZy9zY3JpcHRzL3J0LXRlc3Rlci9j
aGVjay1hbGwuc2gNCisrKyBsaW51eC0yLjYuMTctcnQ0L3NjcmlwdHMvcnQt
dGVzdGVyL2NoZWNrLWFsbC5zaA0KQEAgLTE4LDQgKzE4LDQgQEAgdGVzdGl0
IHQzLWwxLXBpLXN0ZWFsLnRzdA0KIHRlc3RpdCB0My1sMi1waS50c3QNCiB0
ZXN0aXQgdDQtbDItcGktZGVib29zdC50c3QNCiB0ZXN0aXQgdDUtbDQtcGkt
Ym9vc3QtZGVib29zdC50c3QNCi0NCit0ZXN0aXQgdDUtbDQtcGktYm9vc3Qt
ZGVib29zdC1zZXRzY2hlZC50c3QNClwgTm8gbmV3bGluZSBhdCBlbmQgb2Yg
ZmlsZQ0K

--8323328-272187579-1151927303=:10199--
