Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750788AbWC0XGE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750788AbWC0XGE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Mar 2006 18:06:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750915AbWC0XGE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Mar 2006 18:06:04 -0500
Received: from lirs02.phys.au.dk ([130.225.28.43]:17339 "EHLO
	lirs02.phys.au.dk") by vger.kernel.org with ESMTP id S1750788AbWC0XGC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Mar 2006 18:06:02 -0500
Date: Tue, 28 Mar 2006 00:05:51 +0100 (MET)
From: Esben Nielsen <simlo@phys.au.dk>
To: Ingo Molnar <mingo@elte.hu>
cc: Thomas Gleixner <tglx@linutronix.de>, <linux-kernel@vger.kernel.org>
Subject: Re: PI patch against 2.6.16-rt9
In-Reply-To: <Pine.LNX.4.44L0.0603271501150.20599-100000@lifa03.phys.au.dk>
Message-ID: <Pine.LNX.4.44L0.0603280002430.25351-100000@lifa03.phys.au.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 27 Mar 2006, Esben Nielsen wrote:

> On Mon, 27 Mar 2006, Ingo Molnar wrote:
> [...]
> > nevertheless it _might_ work in practice, and it's certainly elegant and
> > thus tempting. Could you try to port your patch to -rt10? [you can skip
> > most of the conflicting rt7->rt10 deltas in rtmutex.c i think.]
> >
>
> I'll try to see what I can do. I am bit busy right now. We are packing to
> go to England for 4 months on Saturday. There are lot of practicalities
> we are still missing - but ofcourse PI code much more fun :-) Maybe I can
> "steal" some time tonight.
>

My girl friend will be angry for me not being to bed yet, but
I had to steal time to make this patch. I hope I managed to send it
without white-space damage or anything like it.

Esben


diff -upr linux-2.6.16-rt10/include/linux/rtmutex.h linux-2.6.16-rt10.pipatch/include/linux/rtmutex.h
--- linux-2.6.16-rt10/include/linux/rtmutex.h	2006-03-28 00:47:05.000000000 +0200
+++ linux-2.6.16-rt10.pipatch/include/linux/rtmutex.h	2006-03-27 18:40:08.000000000 +0200
@@ -107,8 +107,7 @@ extern void rt_mutex_unlock(struct rt_mu
 #ifdef CONFIG_RT_MUTEXES
 # define INIT_RT_MUTEXES(tsk)						\
 	.pi_waiters	= PLIST_HEAD_INIT(tsk.pi_waiters, tsk.pi_lock),	\
-	.pi_lock	= RAW_SPIN_LOCK_UNLOCKED,			\
-	.pi_lock_chain	= LIST_HEAD_INIT(tsk.pi_lock_chain),
+	.pi_lock	= RAW_SPIN_LOCK_UNLOCKED,
 #else
 # define INIT_RT_MUTEXES(tsk)
 #endif
diff -upr linux-2.6.16-rt10/include/linux/sched.h linux-2.6.16-rt10.pipatch/include/linux/sched.h
--- linux-2.6.16-rt10/include/linux/sched.h	2006-03-28 00:47:05.000000000 +0200
+++ linux-2.6.16-rt10.pipatch/include/linux/sched.h	2006-03-27 18:40:08.000000000 +0200
@@ -985,9 +985,6 @@ struct task_struct {
 	struct plist_head pi_waiters;
 	/* Deadlock detection and priority inheritance handling */
 	struct rt_mutex_waiter *pi_blocked_on;
-	/* PI locking helpers */
-	struct task_struct *pi_locked_by;
-	struct list_head pi_lock_chain;
 #endif

 #ifdef CONFIG_DEBUG_MUTEXES
diff -upr linux-2.6.16-rt10/include/linux/spinlock_api_smp.h linux-2.6.16-rt10.pipatch/include/linux/spinlock_api_smp.h
--- linux-2.6.16-rt10/include/linux/spinlock_api_smp.h	2006-03-28 00:47:05.000000000 +0200
+++ linux-2.6.16-rt10.pipatch/include/linux/spinlock_api_smp.h	2006-03-27 18:40:08.000000000 +0200
@@ -39,6 +39,7 @@ int __lockfunc _raw_read_trylock(raw_rwl
 int __lockfunc _raw_write_trylock(raw_rwlock_t *lock);
 int __lockfunc _raw_spin_trylock_irqsave(raw_spinlock_t *lock,
 					 unsigned long *flags);
+int __lockfunc _raw_spin_trylock_irq(raw_spinlock_t *lock);
 int __lockfunc _raw_spin_trylock_bh(raw_spinlock_t *lock);
 void __lockfunc _raw_spin_unlock(raw_spinlock_t *lock)		__releases(raw_spinlock_t);
 void __lockfunc _raw_spin_unlock_no_resched(raw_spinlock_t *lock) __releases(raw_spinlock_t);
diff -upr linux-2.6.16-rt10/include/linux/spinlock_api_up.h linux-2.6.16-rt10.pipatch/include/linux/spinlock_api_up.h
--- linux-2.6.16-rt10/include/linux/spinlock_api_up.h	2006-03-28 00:47:05.000000000 +0200
+++ linux-2.6.16-rt10.pipatch/include/linux/spinlock_api_up.h	2006-03-27 18:40:08.000000000 +0200
@@ -39,6 +39,9 @@
 #define __TRYLOCK_IRQSAVE(lock, flags) \
 	({ local_irq_save(*(flags)); __LOCK(lock); 1; })

+#define __TRYLOCK_IRQ(lock) \
+	({ raw_local_irq_disable(); __LOCK(lock); 1; })
+
 #define _raw_spin_trylock_irqsave(lock, flags)	__TRYLOCK_IRQSAVE(lock, flags)

 #define __UNLOCK(lock) \
@@ -75,6 +78,7 @@
 #define _raw_read_trylock_bh(lock)		({ __LOCK_BH(lock); 1; })
 #define _raw_write_trylock_bh(lock)		({ __LOCK_BH(lock); 1; })
 #define _raw_spin_trylock_irqsave(lock, flags)	__TRYLOCK_IRQSAVE(lock, flags)
+#define _raw_spin_trylock_irq(lock)	        __TRYLOCK_IRQ(lock)
 #define _raw_read_trylock_irqsave(lock, flags)	__TRYLOCK_IRQSAVE(lock, flags)
 #define _raw_read_trylock_irqsave(lock, flags)	__TRYLOCK_IRQSAVE(lock, flags)
 #define _raw_spin_unlock(lock)			__UNLOCK(lock)
diff -upr linux-2.6.16-rt10/include/linux/sysctl.h linux-2.6.16-rt10.pipatch/include/linux/sysctl.h
--- linux-2.6.16-rt10/include/linux/sysctl.h	2006-03-20 06:53:29.000000000 +0100
+++ linux-2.6.16-rt10.pipatch/include/linux/sysctl.h	2006-03-27 18:40:08.000000000 +0200
@@ -148,6 +148,7 @@ enum
 	KERN_SPIN_RETRY=70,	/* int: number of spinlock retries */
 	KERN_ACPI_VIDEO_FLAGS=71, /* int: flags for setting up video after ACPI sleep */
 	KERN_IA64_UNALIGNED=72, /* int: ia64 unaligned userland trap enable */
+	KERN_MAX_LOCK_DEPTH=73
 };


diff -upr linux-2.6.16-rt10/kernel/fork.c linux-2.6.16-rt10.pipatch/kernel/fork.c
--- linux-2.6.16-rt10/kernel/fork.c	2006-03-28 00:47:05.000000000 +0200
+++ linux-2.6.16-rt10.pipatch/kernel/fork.c	2006-03-27 18:40:08.000000000 +0200
@@ -947,8 +947,6 @@ static inline void rt_mutex_init_task(st
 	spin_lock_init(&p->pi_lock);
 	plist_head_init(&p->pi_waiters, &p->pi_lock);
 	p->pi_blocked_on = NULL;
-	p->pi_locked_by = NULL;
-	INIT_LIST_HEAD(&p->pi_lock_chain);
 #endif
 }

diff -upr linux-2.6.16-rt10/kernel/rtmutex-debug.c linux-2.6.16-rt10.pipatch/kernel/rtmutex-debug.c
--- linux-2.6.16-rt10/kernel/rtmutex-debug.c	2006-03-28 00:47:05.000000000 +0200
+++ linux-2.6.16-rt10.pipatch/kernel/rtmutex-debug.c	2006-03-27 18:40:08.000000000 +0200
@@ -398,9 +398,7 @@ restart:
 void notrace rt_mutex_debug_task_free(struct task_struct *tsk)
 {
 	WARN_ON(!plist_head_empty(&tsk->pi_waiters));
-	WARN_ON(!list_empty(&tsk->pi_lock_chain));
 	WARN_ON(tsk->pi_blocked_on);
-	WARN_ON(tsk->pi_locked_by);
 }

 /*
diff -upr linux-2.6.16-rt10/kernel/rtmutex.c linux-2.6.16-rt10.pipatch/kernel/rtmutex.c
--- linux-2.6.16-rt10/kernel/rtmutex.c	2006-03-28 00:47:05.000000000 +0200
+++ linux-2.6.16-rt10.pipatch/kernel/rtmutex.c	2006-03-28 00:11:24.000000000 +0200
@@ -160,204 +160,103 @@ static void rt_mutex_adjust_prio(struct
 	spin_unlock_irqrestore(&task->pi_lock, flags);
 }

-/*
- * PI-locking: we lock PI-dependencies opportunistically via trylock.
- *
- * In the overwhelming majority of cases the 'PI chain' is empty or at
- * most 1-2 entries long, for which the trylock is sufficient,
- * scalability-wise. The locking might look a bit scary, for which we
- * apologize in advance :-)
- *
- * If any of the trylocks fails then we back out, task the global
- * pi_conflicts_lock and take the locks again. This ensures deadlock-free
- * but still scalable locking in the dependency graph, combined with
- * the ability to reliably (and cheaply) detect user-space deadlocks.
- */
-static DEFINE_RAW_SPINLOCK(pi_conflicts_lock);

-/*
- * Lock the full boosting chain.
- *
- * If 'try' is set, we have to backout if we hit a owner who is
- * running its own pi chain operation. We go back and take the slow
- * path via the pi_conflicts_lock.
- *
- * We put all held locks into a list, via ->pi_lock_chain, and walk
- * this list at unlock_pi_chain() time.
- */
-static int lock_pi_chain(struct rt_mutex *act_lock,
-			 struct rt_mutex_waiter *waiter,
-			 struct list_head *lock_chain,
-			 int try, int detect_deadlock)
-{
-	struct task_struct *owner;
-	struct rt_mutex *nextlock, *lock = act_lock;
-	struct rt_mutex_waiter *nextwaiter;
-	int deadlock_detect;
+int max_lock_depth = 100;

-	/*
-	 * Debugging might turn deadlock detection on, unconditionally:
-	 */
-	deadlock_detect = debug_rt_mutex_detect_deadlock(detect_deadlock);
+/*
+ * Adjust the priority chain. Also used for deadlock detection.
+ * Decreases task's usage by one - may thus free the task.
+ * Returns 0 or -EDEADLK.
+ */
+static int rt_mutex_adjust_prio_chain(task_t *task,
+				      int deadlock_detect,
+				      struct rt_mutex_waiter *orig_waiter
+				      __IP_DECL__)
+{
+	struct rt_mutex *lock = orig_waiter->lock;
+	struct rt_mutex_waiter *waiter, *top_waiter;
+	task_t *owner;
+	unsigned long flags;

-	for (;;) {
-		owner = rt_mutex_owner(lock);
+	int detect_deadlock, ret = 0, depth = 0;

-		/* Check for circular dependencies */
-		if (unlikely(owner->pi_locked_by == current)) {
-			debug_rt_mutex_deadlock(detect_deadlock, waiter, lock);
-			return detect_deadlock ? -EDEADLK : 1;
-		}
+	detect_deadlock = debug_rt_mutex_detect_deadlock(deadlock_detect);

-		while (!spin_trylock(&owner->pi_lock)) {
-			/*
-			 * Owner runs its own chain. Go back and take
-			 * the slow path
-			 */
-			if (try && owner->pi_locked_by == owner)
-				return -EBUSY;
-			cpu_relax();
+	for (;;) {
+		depth++;
+		if(task==current || depth>max_lock_depth) {
+			debug_rt_mutex_deadlock(deadlock_detect,
+						orig_waiter, lock);
+
+			put_task_struct(task);
+
+			return deadlock_detect ? -EDEADLK : 0;
 		}
+	retry:
+		_raw_spin_lock(&task->pi_lock);
+		__rt_mutex_adjust_prio(task);
+		waiter = task->pi_blocked_on;
+		if( !waiter )
+			break;

-		BUG_ON(owner->pi_locked_by);
-		owner->pi_locked_by = current;
-		BUG_ON(!list_empty(&owner->pi_lock_chain));
-		list_add(&owner->pi_lock_chain, lock_chain);
-
-		/*
-		 * When the owner is blocked on a lock, try to take
-		 * the lock:
-		 */
-		nextwaiter = owner->pi_blocked_on;
-
-		/* End of chain? */
-		if (!nextwaiter)
-			return 1;
-
-		nextlock = nextwaiter->lock;
-
-		/* Check for circular dependencies: */
-		if (unlikely(nextlock == act_lock ||
-			     rt_mutex_owner(nextlock) == current)) {
-			debug_rt_mutex_deadlock(detect_deadlock, waiter,
-						nextlock);
-			list_del_init(&owner->pi_lock_chain);
-			owner->pi_locked_by = NULL;
-			spin_unlock(&owner->pi_lock);
-			return detect_deadlock ? -EDEADLK : 1;
-		}
+		if( !detect_deadlock &&
+		    waiter->list_entry.prio == task->prio &&
+		    waiter->pi_list_entry.prio == waiter->list_entry.prio )
+			break;

-		/* Try to get nextlock->wait_lock: */
-		if (unlikely(!spin_trylock(&nextlock->wait_lock))) {
-			list_del_init(&owner->pi_lock_chain);
-			owner->pi_locked_by = NULL;
-			spin_unlock(&owner->pi_lock);
+
+		lock = waiter->lock;
+		if( !spin_trylock_irqsave(&lock->wait_lock, flags) ) {
+			_raw_spin_unlock(&task->pi_lock);
 			cpu_relax();
-			continue;
+			goto retry;
 		}

-		lock = nextlock;
-
-		/*
-		 * If deadlock detection is done (or has to be done, as
-		 * for userspace locks), we have to walk the full chain
-		 * unconditionally.
-		 */
-		if (deadlock_detect)
-			continue;
+		top_waiter = rt_mutex_top_waiter(lock);

-		/*
-		 * Optimization: we only have to continue up to the point
-		 * where boosting/unboosting still has to be done:
-		 */
+		plist_del(&waiter->list_entry, &lock->wait_list);
+		waiter->list_entry.prio = task->prio;
+		plist_add(&waiter->list_entry, &lock->wait_list);
+
+		_raw_spin_unlock(&task->pi_lock);

-		/* Boost or unboost? */
-		if (waiter) {
-			/* If the top waiter has higher priority, stop: */
-			if (rt_mutex_top_waiter(lock)->list_entry.prio <=
-			    waiter->list_entry.prio)
-				return 1;
-		} else {
-			/* If nextwaiter is not the top waiter, stop: */
-			if (rt_mutex_top_waiter(lock) != nextwaiter)
-				return 1;
+		owner = rt_mutex_owner(lock);
+		BUG_ON(!owner);
+		BUG_ON(owner==task);
+		if(waiter == rt_mutex_top_waiter(lock)) {
+			_raw_spin_lock(&owner->pi_lock);
+			plist_del(&top_waiter->pi_list_entry,
+					  &owner->pi_waiters);
+
+			waiter->pi_list_entry.prio = waiter->list_entry.prio;
+			plist_add(&waiter->pi_list_entry, &owner->pi_waiters);
+			_raw_spin_unlock(&owner->pi_lock);
 		}
-	}
-}
-
-/*
- * Unlock the pi_chain:
- */
-static void unlock_pi_chain(struct list_head *lock_chain)
-{
-	struct task_struct *owner, *tmp;
-
-	list_for_each_entry_safe(owner, tmp, lock_chain, pi_lock_chain) {
-		struct rt_mutex_waiter *waiter = owner->pi_blocked_on;
-
-		list_del_init(&owner->pi_lock_chain);
-		BUG_ON(!owner->pi_locked_by);
-		owner->pi_locked_by = NULL;
-		if (waiter)
-			spin_unlock(&waiter->lock->wait_lock);
-		spin_unlock(&owner->pi_lock);
-	}
-}
-
-/*
- * Do the priority (un)boosting along the chain:
- */
-static void adjust_pi_chain(struct rt_mutex *lock,
-			    struct rt_mutex_waiter *waiter,
-			    struct rt_mutex_waiter *top_waiter,
-			    struct list_head *lock_chain)
-{
-	struct task_struct *owner = rt_mutex_owner(lock);
-	struct list_head *curr = lock_chain->prev;
-
-	for (;;) {
-		if (top_waiter)
-			plist_del(&top_waiter->pi_list_entry,
+		else if(top_waiter == waiter) {
+			/* waiter is no longer the frontmost waiter */
+			_raw_spin_lock(&owner->pi_lock);
+			plist_del(&waiter->pi_list_entry,
 				  &owner->pi_waiters);
-
-		if (waiter)
-			waiter->pi_list_entry.prio = waiter->task->prio;
-
-		if (rt_mutex_has_waiters(lock)) {
 			top_waiter = rt_mutex_top_waiter(lock);
-			plist_add(&top_waiter->pi_list_entry,
+			top_waiter->pi_list_entry.prio =
+			  top_waiter->list_entry.prio;
+			plist_add(&top_waiter->pi_list_entry,
 				  &owner->pi_waiters);
+			_raw_spin_unlock(&owner->pi_lock);
 		}

-		__rt_mutex_adjust_prio(owner);

-		waiter = owner->pi_blocked_on;
-		if (!waiter || curr->prev == lock_chain)
-			return;
+		get_task_struct(owner);

-		curr = curr->prev;
-		lock = waiter->lock;
-		owner = rt_mutex_owner(lock);
-		top_waiter = rt_mutex_top_waiter(lock);
+		spin_unlock_irqrestore(&lock->wait_lock,flags);

-		plist_del(&waiter->list_entry, &lock->wait_list);
-		waiter->list_entry.prio = waiter->task->prio;
-		plist_add(&waiter->list_entry, &lock->wait_list);
-
-		/*
-		 * We can stop here, if the waiter is/was not the top
-		 * priority waiter:
-		 */
-		if (top_waiter != waiter &&
-				waiter != rt_mutex_top_waiter(lock))
-			return;
-
-		/*
-		 * Note: waiter is not necessarily the new top
-		 * waiter!
-		 */
-		waiter = rt_mutex_top_waiter(lock);
+		put_task_struct(task);
+		task = owner;
 	}
+
+	_raw_spin_unlock(&task->pi_lock);
+	put_task_struct(task);
+	return ret;
 }

 /*
@@ -468,111 +367,63 @@ static int try_to_take_rt_mutex(struct r
 /*
  * Task blocks on lock.
  *
- * Prepare waiter and potentially propagate our priority into the pi chain.
+ * Prepare waiter and propagate pi chain
  *
  * This must be called with lock->wait_lock held.
- * return values: 1: waiter queued, 0: got the lock,
- *		  -EDEADLK: deadlock detected.
+ *
+ * Returns owner if it is needed to be boosted with adjust_prio_chain() if
+ * it is in itself blocked on a lock.
  */
-static int task_blocks_on_rt_mutex(struct rt_mutex *lock,
-				   struct rt_mutex_waiter *waiter,
-				   int detect_deadlock __IP_DECL__)
+static task_t *task_blocks_on_rt_mutex(struct rt_mutex *lock,
+				       struct rt_mutex_waiter *waiter,
+				       int detect_deadlock
+				       __IP_DECL__)
 {
 	struct rt_mutex_waiter *top_waiter = waiter;
-	LIST_HEAD(lock_chain);
-	int res = 1;
+	task_t *owner = rt_mutex_owner(lock);
+	task_t *res = NULL;

+	_raw_spin_lock(&current->pi_lock);
+	__rt_mutex_adjust_prio(current);
 	waiter->task = current;
 	waiter->lock = lock;
-	debug_rt_mutex_reset_waiter(waiter);
-
-	spin_lock(&current->pi_lock);
-	current->pi_locked_by = current;
 	plist_node_init(&waiter->list_entry, current->prio);
 	plist_node_init(&waiter->pi_list_entry, current->prio);

-	/* Get the top priority waiter of the lock: */
+	/* Get the top priority waiter on the lock */
 	if (rt_mutex_has_waiters(lock))
 		top_waiter = rt_mutex_top_waiter(lock);
 	plist_add(&waiter->list_entry, &lock->wait_list);

 	current->pi_blocked_on = waiter;

-	/*
-	 * Call adjust_prio_chain, when waiter is the new top waiter
-	 * or when deadlock detection is requested:
-	 */
-	if (waiter != rt_mutex_top_waiter(lock) &&
-	    !debug_rt_mutex_detect_deadlock(detect_deadlock))
-		goto out_unlock_pi;
-
-	/* Try to lock the full chain: */
-	res = lock_pi_chain(lock, waiter, &lock_chain, 1, detect_deadlock);
-
-	if (likely(res == 1))
-		adjust_pi_chain(lock, waiter, top_waiter, &lock_chain);
-
-	/* Common case: we managed to lock it: */
-	if (res != -EBUSY)
-		goto out_unlock_chain_pi;
+	_raw_spin_unlock(&current->pi_lock);

-	/* Rare case: we hit some other task running a pi chain operation: */
-	unlock_pi_chain(&lock_chain);
-
-	plist_del(&waiter->list_entry, &lock->wait_list);
-	current->pi_blocked_on = NULL;
-	current->pi_locked_by = NULL;
-	spin_unlock(&current->pi_lock);
-	fixup_rt_mutex_waiters(lock);
-
-	spin_unlock(&lock->wait_lock);
-
-	/*
-	 * Here we have dropped all locks, and take the global
-	 * pi_conflicts_lock. We have to redo all the work, no
-	 * previous information about the lock is valid anymore:
-	 */
-	spin_lock(&pi_conflicts_lock);
+	if (waiter == rt_mutex_top_waiter(lock)) {
+		_raw_spin_lock(&owner->pi_lock);
+		plist_del(&top_waiter->pi_list_entry, &owner->pi_waiters);
+		plist_add(&waiter->pi_list_entry, &owner->pi_waiters);
+
+		__rt_mutex_adjust_prio(owner);
+		if(owner->pi_blocked_on) {
+			/* Nested locks. We do the boosting of the next
+			   tasks just before going to sleep in schedule */
+			res = owner;
+			get_task_struct(owner);
+		}

-	spin_lock(&lock->wait_lock);
-	if (try_to_take_rt_mutex(lock __IP__)) {
-		/*
-		 * Rare race: against all odds we got the lock.
-		 */
-		res = 0;
-		goto out;
+		_raw_spin_unlock(&owner->pi_lock);
+	}
+	else if( debug_rt_mutex_detect_deadlock(detect_deadlock) ) {
+		_raw_spin_lock(&owner->pi_lock);
+		if(owner->pi_blocked_on) {
+			res = owner;
+			get_task_struct(owner);
+		}
+		_raw_spin_unlock(&owner->pi_lock);
 	}

-	WARN_ON(!rt_mutex_owner(lock) || rt_mutex_owner(lock) == current);
-
-	spin_lock(&current->pi_lock);
-	current->pi_locked_by = current;
-
-	plist_node_init(&waiter->list_entry, current->prio);
-	plist_node_init(&waiter->pi_list_entry, current->prio);
-
-	/* Get the top priority waiter of the lock: */
-	if (rt_mutex_has_waiters(lock))
-		top_waiter = rt_mutex_top_waiter(lock);
-	plist_add(&waiter->list_entry, &lock->wait_list);
-
-	current->pi_blocked_on = waiter;
-
-	/* Lock the full chain: */
-	res = lock_pi_chain(lock, waiter, &lock_chain, 0, detect_deadlock);
-
-	/* Drop the conflicts lock before adjusting: */
-	spin_unlock(&pi_conflicts_lock);
-
-	if (likely(res == 1))
-		adjust_pi_chain(lock, waiter, top_waiter, &lock_chain);

- out_unlock_chain_pi:
-	unlock_pi_chain(&lock_chain);
- out_unlock_pi:
-	current->pi_locked_by = NULL;
-	spin_unlock(&current->pi_lock);
- out:
 	return res;
 }

@@ -639,87 +490,49 @@ static void wakeup_next_waiter(struct rt
 /*
  * Remove a waiter from a lock
  *
- * Must be called with lock->wait_lock held.
+ * Must be called with lock->wait_lock held
  */
-static int remove_waiter(struct rt_mutex *lock,
-			 struct rt_mutex_waiter *waiter __IP_DECL__)
+static task_t *remove_waiter(struct rt_mutex *lock,
+			  struct rt_mutex_waiter *waiter  __IP_DECL__)
 {
-	struct rt_mutex_waiter *next_waiter = NULL,
-				*top_waiter = rt_mutex_top_waiter(lock);
-	LIST_HEAD(lock_chain);
-	int res;
+	int first = (waiter == rt_mutex_top_waiter(lock));
+	task_t *res = NULL;

 	plist_del(&waiter->list_entry, &lock->wait_list);

-	spin_lock(&current->pi_lock);
-
-	if (waiter != top_waiter || rt_mutex_owner(lock) == current)
-		goto out;
-
-	current->pi_locked_by = current;

-	if (rt_mutex_has_waiters(lock))
-		next_waiter = rt_mutex_top_waiter(lock);
+	if (first && rt_mutex_owner(lock) != current) {
+		task_t *owner = rt_mutex_owner(lock);

-	/* Try to lock the full chain: */
-	res = lock_pi_chain(lock, next_waiter, &lock_chain, 1, 0);
+		_raw_spin_lock(&owner->pi_lock);

-	if (likely(res != -EBUSY)) {
-		adjust_pi_chain(lock, next_waiter, waiter, &lock_chain);
-		goto out_unlock;
-	}
+		plist_del(&waiter->pi_list_entry, &owner->pi_waiters);

-	/* We hit some other task running a pi chain operation: */
-	unlock_pi_chain(&lock_chain);
-	plist_add(&waiter->list_entry, &lock->wait_list);
-	current->pi_blocked_on = waiter;
-	current->pi_locked_by = NULL;
-	spin_unlock(&current->pi_lock);
-	spin_unlock(&lock->wait_lock);
-
-	spin_lock(&pi_conflicts_lock);
+		if (rt_mutex_has_waiters(lock)) {
+			struct rt_mutex_waiter *next;

-	spin_lock(&lock->wait_lock);
+			next = rt_mutex_top_waiter(lock);
+			plist_add(&next->pi_list_entry, &owner->pi_waiters);
+		}

-	spin_lock(&current->pi_lock);
-	current->pi_locked_by = current;

-	/* We might have been woken up: */
-	if (!waiter->task) {
-		spin_unlock(&pi_conflicts_lock);
-		goto out;
+		__rt_mutex_adjust_prio(owner);
+		if(owner->pi_blocked_on) {
+			/* Owner is blocked on something - we have
+			   to (un)boost throughout the lock chain but
+			   we have to wait until we have dropped all locks */
+			res = owner;
+			get_task_struct(owner);
+		}
+		_raw_spin_unlock(&owner->pi_lock);
 	}

-	top_waiter = rt_mutex_top_waiter(lock);
-
-	plist_del(&waiter->list_entry, &lock->wait_list);
-
-	if (waiter != top_waiter || rt_mutex_owner(lock) == current)
-		goto out;
-
-	/* Get the top priority waiter of the lock: */
-	if (rt_mutex_has_waiters(lock))
-		next_waiter = rt_mutex_top_waiter(lock);
-
-	/* Lock the full chain: */
-	lock_pi_chain(lock, next_waiter, &lock_chain, 0, 0);
-
-	/* Drop the conflicts lock: */
-	spin_unlock(&pi_conflicts_lock);
-
-	adjust_pi_chain(lock, next_waiter, waiter, &lock_chain);
+	WARN_ON(!plist_node_empty(&waiter->pi_list_entry));

- out_unlock:
-	unlock_pi_chain(&lock_chain);
- out:
 	current->pi_blocked_on = NULL;
 	waiter->task = NULL;
-	current->pi_locked_by = NULL;
-	spin_unlock(&current->pi_lock);

-	WARN_ON(!plist_node_empty(&waiter->pi_list_entry));
-
-	return 0;
+	return res;
 }

 #ifdef CONFIG_PREEMPT_RT
@@ -759,6 +572,7 @@ rt_lock_slowlock(struct rt_mutex *lock _
 {
 	struct rt_mutex_waiter waiter;
 	unsigned long saved_state, state, flags;
+	task_t *owner;

 	debug_rt_mutex_init_waiter(&waiter);
 	waiter.task = NULL;
@@ -788,7 +602,7 @@ rt_lock_slowlock(struct rt_mutex *lock _

 	for (;;) {
 		unsigned long saved_flags;
-		int ret, saved_lock_depth = current->lock_depth;
+		int saved_lock_depth = current->lock_depth;

 		/* Try to acquire the lock */
 		if (try_to_take_rt_mutex(lock __IP__))
@@ -798,12 +612,25 @@ rt_lock_slowlock(struct rt_mutex *lock _
 		 * when we have been woken up by the previous owner
 		 * but the lock got stolen by an higher prio task.
 		 */
-		if (!waiter.task) {
-			ret = task_blocks_on_rt_mutex(lock, &waiter, 0 __IP__);
-			/* got the lock or deadlock: */
-			if (ret == 0 || ret == -EDEADLK)
-				break;
+		if (!waiter.task)
+			owner = task_blocks_on_rt_mutex(lock, &waiter, 0
+							__IP__);
+		else
+			owner = NULL;
+
+		if (unlikely(owner)) {
+			spin_unlock_irqrestore(&lock->wait_lock,flags);
+			rt_mutex_adjust_prio_chain(owner, 0, &waiter __IP__);
+			owner = NULL;
+			spin_lock_irqsave(&lock->wait_lock,flags);
+			if(unlikely(!waiter.task))
+				continue; /* We got woken up by the owner
+					   * Start loop all over without
+					   * going into schedule to try
+					   * to get the lock now
+					   */
 		}
+

 		/*
 		 * Prevent schedule() to drop BKL, while waiting for
@@ -838,7 +665,9 @@ rt_lock_slowlock(struct rt_mutex *lock _
 	 * can end up with a non-NULL waiter.task:
 	 */
 	if (unlikely(waiter.task))
-		remove_waiter(lock, &waiter __IP__);
+		owner = remove_waiter(lock, &waiter __IP__);
+	else
+		owner = NULL;
 	/*
 	 * try_to_take_rt_mutex() sets the waiter bit
 	 * unconditionally. We might have to fix that up:
@@ -847,6 +676,9 @@ rt_lock_slowlock(struct rt_mutex *lock _

 	spin_unlock_irqrestore(&lock->wait_lock, flags);

+	if (unlikely(owner))
+		rt_mutex_adjust_prio_chain(owner, 0, &waiter __IP__);
+
 	debug_rt_mutex_free_waiter(&waiter);
 }

@@ -936,6 +768,7 @@ rt_mutex_slowlock(struct rt_mutex *lock,
 	struct rt_mutex_waiter waiter;
 	int ret = 0, saved_lock_depth = -1;
 	unsigned long flags;
+	task_t *owner;

 	debug_rt_mutex_init_waiter(&waiter);
 	waiter.task = NULL;
@@ -950,8 +783,6 @@ rt_mutex_slowlock(struct rt_mutex *lock,
 		return 0;
 	}

-	BUG_ON(rt_mutex_owner(lock) == current);
-
 	/*
 	 * We drop BKL here before we go into the wait loop to avoid a
 	 * possible deadlock in the scheduler.
@@ -992,15 +823,31 @@ rt_mutex_slowlock(struct rt_mutex *lock,
 		 * when we have been woken up by the previous owner
 		 * but the lock got stolen by an higher prio task.
 		 */
-		if (!waiter.task) {
-			ret = task_blocks_on_rt_mutex(lock, &waiter,
+		if (!waiter.task)
+			owner = task_blocks_on_rt_mutex(lock, &waiter,
 						      detect_deadlock __IP__);
-			/* got the lock or deadlock: */
-			if (ret == 0 || ret == -EDEADLK)
+		else
+			owner = NULL;
+
+		if (unlikely(owner)) {
+			spin_unlock_irqrestore(&lock->wait_lock,flags);
+			ret = rt_mutex_adjust_prio_chain(owner,
+							 detect_deadlock,
+							 &waiter __IP__);
+			owner = NULL;
+			spin_lock_irqsave(&lock->wait_lock,flags);
+
+			if (unlikely(ret))
 				break;
-			ret = 0;
-		}

+			if (unlikely(!waiter.task))
+			    continue; /* We got woken up by the owner
+					   * Start loop all over without
+					   * going into schedule to try
+					   * to get the lock now
+					   */
+		}
+
 		saved_flags = current->flags & PF_NOSCHED;
 		current->flags &= ~PF_NOSCHED;

@@ -1019,8 +866,10 @@ rt_mutex_slowlock(struct rt_mutex *lock,

 	set_current_state(TASK_RUNNING);

-	if (unlikely(waiter.task))
-		remove_waiter(lock, &waiter __IP__);
+	if (unlikely(waiter.task))
+		owner = remove_waiter(lock, &waiter __IP__);
+	else
+		owner = NULL;

 	/*
 	 * try_to_take_rt_mutex() sets the waiter bit
@@ -1030,6 +879,9 @@ rt_mutex_slowlock(struct rt_mutex *lock,

 	spin_unlock_irqrestore(&lock->wait_lock, flags);

+	if (unlikely(owner))
+		rt_mutex_adjust_prio_chain(owner, 0, &waiter __IP__);
+
 	/* Remove pending timer: */
 	if (unlikely(timeout && timeout->task))
 		hrtimer_cancel(&timeout->timer);
Only in linux-2.6.16-rt10.pipatch/kernel: rtmutex.c.orig
Only in linux-2.6.16-rt10.pipatch/kernel: rtmutex.c.rej
Only in linux-2.6.16-rt10.pipatch/kernel: rtmutex.c~
diff -upr linux-2.6.16-rt10/kernel/sysctl.c linux-2.6.16-rt10.pipatch/kernel/sysctl.c
--- linux-2.6.16-rt10/kernel/sysctl.c	2006-03-28 00:47:05.000000000 +0200
+++ linux-2.6.16-rt10.pipatch/kernel/sysctl.c	2006-03-27 18:40:08.000000000 +0200
@@ -132,6 +132,10 @@ extern int acct_parm[];
 extern int no_unaligned_warning;
 #endif

+#ifdef CONFIG_RT_MUTEXES
+extern int max_lock_depth;
+#endif
+
 static int parse_table(int __user *, int, void __user *, size_t __user *, void __user *, size_t,
 		       ctl_table *, void **);
 static int proc_doutsstring(ctl_table *table, int write, struct file *filp,
@@ -827,6 +831,17 @@ static ctl_table kern_table[] = {
 		.proc_handler	= &proc_dointvec,
 	},
 #endif
+#ifdef CONFIG_RT_MUTEXES
+	{
+		.ctl_name	= KERN_MAX_LOCK_DEPTH,
+		.procname	= "max_lock_depth",
+		.data		= &max_lock_depth,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= &proc_dointvec,
+	},
+#endif
+
 	{ .ctl_name = 0 }
 };

diff -upr linux-2.6.16-rt10/scripts/rt-tester/t3-l1-pi-signal.tst linux-2.6.16-rt10.pipatch/scripts/rt-tester/t3-l1-pi-signal.tst
--- linux-2.6.16-rt10/scripts/rt-tester/t3-l1-pi-signal.tst	2006-03-28 00:47:05.000000000 +0200
+++ linux-2.6.16-rt10.pipatch/scripts/rt-tester/t3-l1-pi-signal.tst	2006-03-27 18:40:08.000000000 +0200
@@ -69,15 +69,18 @@ W: locked:		0: 	0
 C: locknowait:		1: 	0
 W: blocked:		1: 	0
 T: prioeq:		0:	80
+T: prioeq:		1:	80

 # T2 lock L0 interruptible, no wait in the wakeup path
 C: lockintnowait:	2:	0
 W: blocked:		2: 	0
 T: prioeq:		0:	81
+T: prioeq:		1:	80

 # Interrupt T2
 C: signal:		2:	2
 W: unlocked:		2:	0
+T: prioeq:		1:	80
 T: prioeq:		0:	80

 T: locked:		0:	0

> Esben
>
> > 	Ingo
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> >
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

