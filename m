Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751108AbVHYPIB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751108AbVHYPIB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 11:08:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751147AbVHYPIB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 11:08:01 -0400
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:39618 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751108AbVHYPH7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 11:07:59 -0400
Subject: Re: [RFC] RT-patch update to remove the global pi_lock
From: Steven Rostedt <rostedt@goodmis.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>,
       Sven-Thorsten Dietrich <sven@mvista.com>, Adrian Bunk <bunk@stusta.de>,
       george anzinger <george@mvista.com>, dwalker@mvista.com,
       Karsten Wiese <annabellesgarden@yahoo.de>
In-Reply-To: <1124981238.5350.6.camel@localhost.localdomain>
References: <1124295214.5764.163.camel@localhost.localdomain>
	 <20050817162324.GA24495@elte.hu>
	 <1124323379.5186.18.camel@localhost.localdomain>
	 <1124333050.5186.24.camel@localhost.localdomain>
	 <20050822075012.GB19386@elte.hu>
	 <1124704837.5208.22.camel@localhost.localdomain>
	 <20050822101632.GA28803@elte.hu>
	 <1124710309.5208.30.camel@localhost.localdomain>
	 <20050822113858.GA1160@elte.hu>
	 <1124715755.5647.4.camel@localhost.localdomain>
	 <20050822183355.GB13888@elte.hu>
	 <1124739657.5809.6.camel@localhost.localdomain>
	 <1124739895.5809.11.camel@localhost.localdomain>
	 <1124981238.5350.6.camel@localhost.localdomain>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Thu, 25 Aug 2005 11:06:53 -0400
Message-Id: <1124982413.5350.19.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-08-25 at 10:47 -0400, Steven Rostedt wrote:
> OK, here it is. Against 2.6.13-rc7-rt1. 

> @@ -1134,17 +1206,35 @@
>  		return 0;
>  
>  	trace_lock_irqsave(&trace_lock, flags, ti);
> +	/*
> +	 * We are no longer blocked on the lock, so we are considered a
> +	 * owner. So we must grab the lock->wait_lock first.
> +	 */
>  	__raw_spin_lock(&lock->wait_lock);
> +	__raw_spin_lock(&task->pi_lock);
>  
>  	if (!(task->rt_flags & RT_PENDOWNER)) {
> -		/* someone else stole it */
> +		/*
> +		 * Someone else stole it.
> +		 * We are grabbing a lock now, so we must release the
> +		 * locks again and retake them in the opposite order.
> +		 */
> +		__raw_spin_unlock(&task->pi_lock);
> +		__raw_spin_unlock(&lock->wait_lock);
> +
> +		__raw_spin_lock(&task->pi_lock);
> +		__raw_spin_lock(&lock->wait_lock);
> +

The above code is added to capture_lock, and I don't like it.  I was
thinking that since the locking order was to be:

P1 blocked_on L1 owned_by P2 blocked_on ... Ln-1 owned by Pn

So you always need to grab the process lock before grabbing the mutex
lock that it is blocked on, and always grab the mutex lock before
grabbing the process lock that owns it.

Here it is a little ambiguous.  The process use to own the lock, but
someone stole it.  When grabbing a lock, I always grab the process lock
first before grabbing the lock's lock, but this isn't necessary.  So if
you already have the two locks (mutex and process) as is the case above,
you don't need to unlock them and regrab them (although this doesn't
hurt, except for performance), because any race would have been with the
grabbing of these two locks in the first place.

Now, here's why it's safe.  The process that use to own the mutex and
had it stolen now is out of the chain.  The pi_lock and the wait_lock
here are not in any order.  So no one who is grabbing the process'
pi_lock should have owned the wait_lock and vice versa.

So here's an updated patch without this lock switching:

-- Steve

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>

Index: linux_realtime_goliath/kernel/rt.c
===================================================================
--- linux_realtime_goliath/kernel/rt.c	(revision 304)
+++ linux_realtime_goliath/kernel/rt.c	(working copy)
@@ -22,6 +22,9 @@
  *
  *  Copyright (C) 2005, Kihon Technologies Inc., Steven Rostedt
  *
+ *   (also by Steven Rostedt)
+ *    - Converted single pi_lock to individual task locks.
+ *
  */
 #include <linux/config.h>
 #include <linux/sched.h>
@@ -36,6 +39,26 @@
 #define CAPTURE_LOCK
 
 /*
+ * Lock order:
+ *
+ *  To keep from having a single lock for PI, each task and lock
+ *  has their own locking. The order is as follows:
+ *
+ * blocked task->pi_lock -> lock->wait_lock -> owner task->pi_lock.
+ * 
+ * This is safe since a owner task should never block on a lock that
+ * is owned by a blocking task.  Otherwise you would have a deadlock 
+ * in the normal system.
+ * The same goes for the locks. A lock held by one task, should not be
+ * taken by task that holds a lock that is blocking this lock's owner.
+ *
+ * A task that is about to grab a lock is first considered to be a 
+ * blocking task, even if the task successfully acquires the lock.
+ * This is because the taking of the locks happen before the
+ * task becomes the owner.
+ */
+
+/*
  * These flags are used for allowing of stealing of ownerships.
  */
 #define RT_PENDOWNER	1	/* pending owner on a lock */
@@ -83,14 +106,6 @@
  */
 //#define ALL_TASKS_PI
 
-/*
- * We need a global lock for priority inheritance handling.
- * This is only for the slow path, but still, we might want
- * to optimize it later to be more scalable.
- */
-static __cacheline_aligned_in_smp raw_spinlock_t pi_lock =
-						RAW_SPIN_LOCK_UNLOCKED;
-
 #ifdef CONFIG_RT_DEADLOCK_DETECT
 # define __EIP_DECL__ , unsigned long eip
 # define __EIP__ , eip
@@ -174,6 +189,8 @@
 	if (trace_on) {				\
 		trace_on = 0;			\
 		console_verbose();		\
+		if (spin_is_locked(&current->pi_lock)) \
+			__raw_spin_unlock(&current->pi_lock); \
 		spin_unlock(&trace_lock);	\
 	}					\
 } while (0)
@@ -228,7 +245,6 @@
  */
 void zap_rt_locks(void)
 {
-	spin_lock_init(&pi_lock);
 #ifdef CONFIG_RT_DEADLOCK_DETECT
 	spin_lock_init(&trace_lock);
 #endif
@@ -589,11 +605,11 @@
 			printk("exiting task is not even the owner??\n");
 		goto restart;
 	}
-	__raw_spin_lock(&pi_lock);
+	__raw_spin_lock(&task->pi_lock);
 	plist_for_each(curr1, &task->pi_waiters) {
 		w = plist_entry(curr1, struct rt_mutex_waiter, pi_list);
 		TRACE_OFF();
-		__raw_spin_unlock(&pi_lock);
+		__raw_spin_unlock(&task->pi_lock);
 		trace_unlock_irqrestore(&trace_lock, flags, ti);
 
 		printk("hm, PI interest held at exit time? Task:\n");
@@ -601,7 +617,7 @@
 		printk_waiter(w);
 		return;
 	}
-	__raw_spin_unlock(&pi_lock);
+	__raw_spin_unlock(&task->pi_lock);
 	trace_unlock_irqrestore(&trace_lock, flags, ti);
 }
 
@@ -674,6 +690,7 @@
 	struct rt_mutex_waiter *w;
 	struct plist *curr1;
 
+	__raw_spin_lock(&old_owner->task->pi_lock);
 	plist_for_each(curr1, &old_owner->task->pi_waiters) {
 		w = plist_entry(curr1, struct rt_mutex_waiter, pi_list);
 		if (w->lock == lock) {
@@ -682,9 +699,10 @@
 			printk_waiter(w);
 			printk("\n");
 			TRACE_WARN_ON(1);
-			return;
+			break;
 		}
 	}
+	__raw_spin_unlock(&old_owner->task->pi_lock);
 }
 
 #else
@@ -732,13 +750,24 @@
 
 int pi_walk, pi_null, pi_prio, pi_initialized;
 
-static void pi_setprio(struct rt_mutex *lock, struct task_struct *p, int prio)
+/*
+ * The lock->wait_lock and p->pi_lock must be held.
+ */
+static void pi_setprio(struct rt_mutex *lock, struct task_struct *task, int prio)
 {
+	struct rt_mutex *l = lock;
+	struct task_struct *p = task;
+	/*
+	 * We don't want to release the parameters locks.
+	 */
+
 	if (unlikely(!p->pid)) {
 		pi_null++;
 		return;
 	}
 
+	TRACE_BUG_ON_LOCKED(!spin_is_locked(&lock->wait_lock));
+	TRACE_BUG_ON_LOCKED(!spin_is_locked(&p->pi_lock));
 #ifdef CONFIG_RT_DEADLOCK_DETECT
 	pi_prio++;
 	if (p->policy != SCHED_NORMAL && prio > normal_prio(p)) {
@@ -759,7 +788,6 @@
 	 * If the task is blocked on some other task then boost that
 	 * other task (or tasks) too:
 	 */
-	__raw_spin_lock(&p->pi_lock);
 	for (;;) {
 		struct rt_mutex_waiter *w = p->blocked_on;
 #ifdef CONFIG_RT_DEADLOCK_DETECT
@@ -774,16 +802,27 @@
 		 * it RT, then register the task in the PI list and
 		 * requeue it to the wait list:
 		 */
-		lock = w->lock;
+
+		/*
+		 * Don't unlock the original lock->wait_lock
+		 */
+		if (l != lock)
+			__raw_spin_unlock(&l->wait_lock);
+		l = w->lock;
 		TRACE_BUG_ON_LOCKED(!lock);
-		TRACE_BUG_ON_LOCKED(!lock_owner(lock));
+
+		if (l != lock)
+			__raw_spin_lock(&l->wait_lock);
+
+		TRACE_BUG_ON_LOCKED(!lock_owner(l));
 		if (rt_task(p) && plist_empty(&w->pi_list)) {
+			TRACE_BUG_ON_LOCKED(was_rt);
 			plist_init(&w->pi_list, prio);
-			plist_add(&w->pi_list, &lock_owner(lock)->task->pi_waiters);
+			plist_add(&w->pi_list, &lock_owner(l)->task->pi_waiters);
 
-			plist_del(&w->list, &lock->wait_list);
+			plist_del(&w->list, &l->wait_list);
 			plist_init(&w->list, prio);
-			plist_add(&w->list, &lock->wait_list);
+			plist_add(&w->list, &l->wait_list);
 		}
 		/*
 		 * If the task is blocked on a lock, and we just restored
@@ -795,16 +834,18 @@
 		 */
 		if (!rt_task(p) && !plist_empty(&w->pi_list)) {
 			TRACE_BUG_ON_LOCKED(!was_rt);
-			plist_del(&w->pi_list, &lock_owner(lock)->task->pi_waiters);
-			plist_del(&w->list, &lock->wait_list);
+			plist_del(&w->pi_list, &lock_owner(l)->task->pi_waiters);
+			plist_del(&w->list, &l->wait_list);
 			plist_init(&w->list, prio);
-			plist_add(&w->list, &lock->wait_list);
+			plist_add(&w->list, &l->wait_list);
 		}
 
 		pi_walk++;
+		
+		if (p != task)
+			__raw_spin_unlock(&p->pi_lock);
 
-		__raw_spin_unlock(&p->pi_lock);
-		p = lock_owner(lock)->task;
+		p = lock_owner(l)->task;
 		TRACE_BUG_ON_LOCKED(!p);
 		__raw_spin_lock(&p->pi_lock);
 		/*
@@ -815,7 +856,10 @@
 		if (p->prio <= prio)
 			break;
 	}
-	__raw_spin_unlock(&p->pi_lock);
+	if (l != lock)
+		__raw_spin_unlock(&l->wait_lock);
+	if (p != task)
+		__raw_spin_unlock(&p->pi_lock);
 }
 
 /*
@@ -831,7 +875,9 @@
 	unsigned long flags;
 	int oldprio;
 
-	spin_lock_irqsave(&pi_lock, flags);
+	spin_lock_irqsave(&p->pi_lock,flags);
+	if (p->blocked_on)
+		spin_lock(&p->blocked_on->lock->wait_lock);
 
 	oldprio = p->normal_prio;
 	if (oldprio == prio)
@@ -858,10 +904,17 @@
 	else
 		mutex_setprio(p, prio);
  out:
-	spin_unlock_irqrestore(&pi_lock, flags);
+	if (p->blocked_on)
+		spin_unlock(&p->blocked_on->lock->wait_lock);
 
+	spin_unlock_irqrestore(&p->pi_lock, flags);
+
 }
 
+/*
+ * This is called with both the waiter->task->pi_lock and 
+ * lock->wait_lock held.
+ */
 static void
 task_blocks_on_lock(struct rt_mutex_waiter *waiter, struct thread_info *ti,
 		    struct rt_mutex *lock __EIP_DECL__)
@@ -872,7 +925,6 @@
 	/* mark the current thread as blocked on the lock */
 	waiter->eip = eip;
 #endif
-	__raw_spin_lock(&task->pi_lock);
 	task->blocked_on = waiter;
 	waiter->lock = lock;
 	waiter->ti = ti;
@@ -884,31 +936,24 @@
 	if (!rt_task(task)) {
 		plist_add(&waiter->list, &lock->wait_list);
 		set_lock_owner_pending(lock);
-		__raw_spin_unlock(&task->pi_lock);
 		return;
 	}
 #endif
-	__raw_spin_unlock(&task->pi_lock);
-	__raw_spin_lock(&pi_lock);
+	plist_add(&waiter->pi_list, &lock_owner(lock)->task->pi_waiters);
 	/*
-	 * We could have been added to the pi list from another task
-	 * doing a pi_setprio.
+	 * Add RT tasks to the head:
 	 */
-	if (likely(plist_empty(&waiter->pi_list))) {
-		plist_add(&waiter->pi_list, &lock_owner(lock)->task->pi_waiters);
-		/*
-		 * Add RT tasks to the head:
-		 */
-		plist_add(&waiter->list, &lock->wait_list);
-	}
+	plist_add(&waiter->list, &lock->wait_list);
 	set_lock_owner_pending(lock);
 	/*
 	 * If the waiter has higher priority than the owner
 	 * then temporarily boost the owner:
 	 */
-	if (task->prio < lock_owner(lock)->task->prio)
+	if (task->prio < lock_owner(lock)->task->prio) {
+		__raw_spin_lock(&lock_owner(lock)->task->pi_lock);
 		pi_setprio(lock, lock_owner(lock)->task, task->prio);
-	__raw_spin_unlock(&pi_lock);
+		__raw_spin_unlock(&lock_owner(lock)->task->pi_lock);
+	}
 }
 
 /*
@@ -942,6 +987,10 @@
 }
 EXPORT_SYMBOL(__init_rwsem);
 
+/*
+ * This must be called with both the old_owner and new_owner pi_locks held.
+ * As well as the lock->wait_lock.
+ */
 static inline
 void set_new_owner(struct rt_mutex *lock, struct thread_info *old_owner,
 			struct thread_info *new_owner __EIP_DECL__)
@@ -975,6 +1024,8 @@
 /*
  * handle the lock release when processes blocked on it that can now run
  * - the spinlock must be held by the caller
+ *
+ * The lock->wait_lock must be held, and the lock's owner->pi_lock must not.
  */
 static struct thread_info *
 pick_new_owner(struct rt_mutex *lock, struct thread_info *old_owner,
@@ -990,14 +1041,34 @@
 	 */
 	waiter = plist_first_entry(&lock->wait_list, struct rt_mutex_waiter, list);
 
+ try_again:
 	trace_special_pid(waiter->ti->task->pid, waiter->ti->task->prio, 0);
 
 #ifdef ALL_TASKS_PI
 	check_pi_list_present(lock, waiter, old_owner);
 #endif
 	new_owner = waiter->ti;
+	/*
+	 * The new owner is still blocked on this lock, so we
+	 * must release the lock->wait_lock before grabing 
+	 * the new_owner lock.
+	 */
+	__raw_spin_unlock(&lock->wait_lock);
+	__raw_spin_lock(&new_owner->task->pi_lock);
+	__raw_spin_lock(&lock->wait_lock);
+	/*
+	 * In this split second of releasing the lock, a high priority 
+	 * process could have come along and blocked as well.
+	 */
+	waiter = plist_first_entry(&lock->wait_list, struct rt_mutex_waiter, list);
+	if (unlikely(waiter->ti != new_owner)) {
+		__raw_spin_unlock(&new_owner->task->pi_lock);
+		goto try_again;
+	}
 	plist_del_init(&waiter->list, &lock->wait_list);
 
+	__raw_spin_lock(&old_owner->task->pi_lock);
+
 	plist_del(&waiter->pi_list, &old_owner->task->pi_waiters);
 	plist_init(&waiter->pi_list, waiter->ti->task->prio);
 
@@ -1008,6 +1079,9 @@
 	new_owner->task->blocked_on = NULL;
 	TRACE_WARN_ON(save_state != lock->save_state);
 
+	__raw_spin_unlock(&old_owner->task->pi_lock);
+	__raw_spin_unlock(&new_owner->task->pi_lock);
+
 	return new_owner;
 }
 
@@ -1060,9 +1134,7 @@
 	 * is still sleeping and hasn't woken up to get the lock.
 	 */
 
-	/* Test the simple case first, is it already running? */
-	if (!TASK_PENDING(owner))
-		return 0;
+	TRACE_BUG_ON_LOCKED(!owner);
 
 	/* The owner is pending on a lock, but is it this lock? */
 	if (owner->pending_owner != lock)
@@ -1134,17 +1206,27 @@
 		return 0;
 
 	trace_lock_irqsave(&trace_lock, flags, ti);
+	/*
+	 * We are no longer blocked on the lock, so we are considered a
+	 * owner. So we must grab the lock->wait_lock first.
+	 */
 	__raw_spin_lock(&lock->wait_lock);
+	__raw_spin_lock(&task->pi_lock);
 
 	if (!(task->rt_flags & RT_PENDOWNER)) {
-		/* someone else stole it */
+		/*
+		 * Someone else stole it.
+		 */
 		old_owner = lock_owner(lock);
 		TRACE_BUG_ON_LOCKED(old_owner == ti);
 		if (likely(!old_owner) || __grab_lock(lock, task, old_owner->task)) {
 			/* we got it back! */
-			__raw_spin_lock(&pi_lock);
-			set_new_owner(lock, old_owner, ti __W_EIP__(waiter));
-			__raw_spin_unlock(&pi_lock);
+			if (old_owner) {
+				__raw_spin_lock(&old_owner->task->pi_lock);
+				set_new_owner(lock, old_owner, ti __W_EIP__(waiter));
+				__raw_spin_unlock(&old_owner->task->pi_lock);
+			} else
+				set_new_owner(lock, old_owner, ti __W_EIP__(waiter));
 			ret = 0;
 		} else {
 			/* Add ourselves back to the list */
@@ -1159,6 +1241,7 @@
 	}
 
 	__raw_spin_unlock(&lock->wait_lock);
+	__raw_spin_unlock(&task->pi_lock);
 	trace_unlock_irqrestore(&trace_lock, flags, ti);
 
 	return ret;
@@ -1196,6 +1279,7 @@
 
 	trace_lock_irqsave(&trace_lock, flags, ti);
 	TRACE_BUG_ON_LOCKED(!raw_irqs_disabled());
+	__raw_spin_lock(&task->pi_lock);
 	__raw_spin_lock(&lock->wait_lock);
 	INIT_WAITER(&waiter);
 
@@ -1205,10 +1289,14 @@
 	if (likely(!old_owner) || __grab_lock(lock, task, old_owner->task)) {
 		/* granted */
 		TRACE_WARN_ON_LOCKED(!plist_empty(&lock->wait_list) && !old_owner);
-		__raw_spin_lock(&pi_lock);
-		set_new_owner(lock, old_owner, ti __EIP__);
-		__raw_spin_unlock(&pi_lock);
+		if (old_owner) {
+			__raw_spin_lock(&old_owner->task->pi_lock);
+			set_new_owner(lock, old_owner, ti __EIP__);
+			__raw_spin_unlock(&old_owner->task->pi_lock);
+		} else
+			set_new_owner(lock, old_owner, ti __EIP__);
 		__raw_spin_unlock(&lock->wait_lock);
+		__raw_spin_unlock(&task->pi_lock);
 		trace_unlock_irqrestore(&trace_lock, flags, ti);
 
 		FREE_WAITER(&waiter);
@@ -1223,6 +1311,7 @@
 	TRACE_BUG_ON_LOCKED(!raw_irqs_disabled());
 	/* we don't need to touch the lock struct anymore */
 	__raw_spin_unlock(&lock->wait_lock);
+	__raw_spin_unlock(&task->pi_lock);
 	trace_unlock_irqrestore(&trace_lock, flags, ti);
 
 	might_sleep();
@@ -1273,6 +1362,7 @@
 
 	trace_lock_irqsave(&trace_lock, flags, ti);
 	TRACE_BUG_ON_LOCKED(!raw_irqs_disabled());
+	__raw_spin_lock(&task->pi_lock);
 	__raw_spin_lock(&lock->wait_lock);
 	INIT_WAITER(&waiter);
 
@@ -1282,10 +1372,14 @@
 	if (likely(!old_owner) || __grab_lock(lock, task, old_owner->task)) {
 		/* granted */
 		TRACE_WARN_ON_LOCKED(!plist_empty(&lock->wait_list) && !old_owner);
-		__raw_spin_lock(&pi_lock);
-		set_new_owner(lock, old_owner, ti __EIP__);
-		__raw_spin_unlock(&pi_lock);
+		if (old_owner) {
+			__raw_spin_lock(&old_owner->task->pi_lock);
+			set_new_owner(lock, old_owner, ti __EIP__);
+			__raw_spin_unlock(&old_owner->task->pi_lock);
+		} else
+			set_new_owner(lock, old_owner, ti __EIP__);
 		__raw_spin_unlock(&lock->wait_lock);
+		__raw_spin_unlock(&task->pi_lock);
 		trace_unlock_irqrestore(&trace_lock, flags, ti);
 
 		FREE_WAITER(&waiter);
@@ -1306,6 +1400,7 @@
 
 	/* we don't need to touch the lock struct anymore */
 	__raw_spin_unlock(&lock->wait_lock);
+	__raw_spin_unlock(&task->pi_lock);
 	trace_unlock(&trace_lock, ti);
 
 	/*
@@ -1396,7 +1491,6 @@
 	TRACE_WARN_ON_LOCKED(list_empty(&lock->held_list));
 	list_del_init(&lock->held_list);
 #endif
-	__raw_spin_lock(&pi_lock);
 
 #ifdef ALL_TASKS_PI
 	if (plist_empty(&lock->wait_list))
@@ -1409,7 +1503,6 @@
 			__up_mutex_waiter_nosavestate(lock __EIP__);
 	} else
 		lock->owner = NULL;
-	__raw_spin_unlock(&pi_lock);
 	__raw_spin_unlock(&lock->wait_lock);
 #ifdef CONFIG_DEBUG_PREEMPT
 	if (current->lock_count < 0 || current->lock_count >= MAX_LOCK_STACK) {
@@ -1640,6 +1733,7 @@
 
 	trace_lock_irqsave(&trace_lock, flags, ti);
 	TRACE_BUG_ON_LOCKED(!raw_irqs_disabled());
+	__raw_spin_lock(&task->pi_lock);
 	__raw_spin_lock(&lock->wait_lock);
 	INIT_WAITER(&waiter);
 
@@ -1649,10 +1743,14 @@
 	if (likely(!old_owner) || __grab_lock(lock, task, old_owner->task)) {
 		/* granted */
 		TRACE_WARN_ON_LOCKED(!plist_empty(&lock->wait_list) && !old_owner);
-		__raw_spin_lock(&pi_lock);
-		set_new_owner(lock, old_owner, ti __EIP__);
-		__raw_spin_unlock(&pi_lock);
+		if (old_owner) {
+			__raw_spin_lock(&old_owner->task->pi_lock);
+			set_new_owner(lock, old_owner, ti __EIP__);
+			__raw_spin_unlock(&old_owner->task->pi_lock);
+		} else
+			set_new_owner(lock, old_owner, ti __EIP__);
 		__raw_spin_unlock(&lock->wait_lock);
+		__raw_spin_unlock(&task->pi_lock);
 		trace_unlock_irqrestore(&trace_lock, flags, ti);
 
 		FREE_WAITER(&waiter);
@@ -1667,6 +1765,7 @@
 	TRACE_BUG_ON_LOCKED(!raw_irqs_disabled());
 	/* we don't need to touch the lock struct anymore */
 	__raw_spin_unlock(&lock->wait_lock);
+	__raw_spin_unlock(&task->pi_lock);
 	trace_unlock_irqrestore(&trace_lock, flags, ti);
 
 	might_sleep();
@@ -1684,6 +1783,7 @@
 			 * didnt get the lock - else return success:
 			 */
 			trace_lock_irq(&trace_lock, ti);
+			__raw_spin_lock(&task->pi_lock);
 			__raw_spin_lock(&lock->wait_lock);
 			if (waiter.ti) {
 				plist_del_init(&waiter.list, &lock->wait_list);
@@ -1692,17 +1792,16 @@
 				 * (No big problem if our PI effect lingers
 				 *  a bit - owner will restore prio.)
 				 */
-				__raw_spin_lock(&pi_lock);
 				TRACE_WARN_ON_LOCKED(waiter.ti != ti);
 				TRACE_WARN_ON_LOCKED(current->blocked_on != &waiter);
 				plist_del(&waiter.pi_list, &task->pi_waiters);
 				plist_init(&waiter.pi_list, task->prio);
 				waiter.ti = NULL;
 				current->blocked_on = NULL;
-				__raw_spin_unlock(&pi_lock);
 				ret = -EINTR;
 			}
 			__raw_spin_unlock(&lock->wait_lock);
+			__raw_spin_unlock(&task->pi_lock);
 			trace_unlock_irq(&trace_lock, ti);
 			break;
 		}
@@ -1741,6 +1840,7 @@
 
 	trace_lock_irqsave(&trace_lock, flags, ti);
 	TRACE_BUG_ON_LOCKED(!raw_irqs_disabled());
+	__raw_spin_lock(&task->pi_lock);
 	__raw_spin_lock(&lock->wait_lock);
 
 	old_owner = lock_owner(lock);
@@ -1749,13 +1849,18 @@
 	if (likely(!old_owner) || __grab_lock(lock, task, old_owner->task)) {
 		/* granted */
 		TRACE_WARN_ON_LOCKED(!plist_empty(&lock->wait_list) && !old_owner);
-		__raw_spin_lock(&pi_lock);
-		set_new_owner(lock, old_owner, ti __EIP__);
-		__raw_spin_unlock(&pi_lock);
+		if (old_owner) {
+			__raw_spin_lock(&old_owner->task->pi_lock);
+			set_new_owner(lock, old_owner, ti __EIP__);
+			__raw_spin_unlock(&old_owner->task->pi_lock);
+		} else
+			set_new_owner(lock, old_owner, ti __EIP__);
+		__raw_spin_unlock(&lock->wait_lock);
+		__raw_spin_unlock(&task->pi_lock);
 		ret = 1;
 	}
-
 	__raw_spin_unlock(&lock->wait_lock);
+	__raw_spin_unlock(&task->pi_lock);
 	trace_unlock_irqrestore(&trace_lock, flags, ti);
 
 	return ret;
@@ -1817,6 +1922,7 @@
 	 * to the previous priority (or to the next highest prio
 	 * waiter's priority):
 	 */
+	__raw_spin_lock(&old_owner->pi_lock);
 	prio = old_owner->normal_prio;
 	if (unlikely(!plist_empty(&old_owner->pi_waiters))) {
 		w = plist_first_entry(&old_owner->pi_waiters, struct rt_mutex_waiter, pi_list);
@@ -1825,6 +1931,7 @@
 	}
 	if (unlikely(prio != old_owner->prio))
 		pi_setprio(lock, old_owner, prio);
+	__raw_spin_unlock(&old_owner->pi_lock);
 #ifdef CAPTURE_LOCK
 	if (lock != &kernel_sem.lock) {
 		new_owner->rt_flags |= RT_PENDOWNER;
@@ -1851,6 +1958,7 @@
 	 * to the previous priority (or to the next highest prio
 	 * waiter's priority):
 	 */
+	__raw_spin_lock(&old_owner->pi_lock);
 	prio = old_owner->normal_prio;
 	if (unlikely(!plist_empty(&old_owner->pi_waiters))) {
 		w = plist_first_entry(&old_owner->pi_waiters, struct rt_mutex_waiter, pi_list);
@@ -1859,6 +1967,7 @@
 	}
 	if (unlikely(prio != old_owner->prio))
 		pi_setprio(lock, old_owner, prio);
+	__raw_spin_unlock(&old_owner->pi_lock);
 #ifdef CAPTURE_LOCK
 	if (lock != &kernel_sem.lock) {
 		new_owner->rt_flags |= RT_PENDOWNER;



