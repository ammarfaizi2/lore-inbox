Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263200AbVCJVaS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263200AbVCJVaS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 16:30:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263183AbVCJV2K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 16:28:10 -0500
Received: from host-65-117-135-105.timesys.com ([65.117.135.105]:25730 "EHLO
	yoda.timesys") by vger.kernel.org with ESMTP id S263151AbVCJVVT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 16:21:19 -0500
Date: Thu, 10 Mar 2005 16:21:16 -0500
To: mingo@elte.hu
Cc: linux-kernel@vger.kernel.org, manas.saksena@timesys.com
Subject: [PATCH] realtime-preempt: update inherited priorities on setscheduler
Message-ID: <20050310212116.GA2420@yoda.timesys>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
From: Scott Wood <scott@gw.timesys.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following patch (against realtime-preempt v0.7.39-02) makes
setscheduler calls behave properly with respect to priority
inheritance.  If a task's priority is raised, it will be propagated
to tasks on which it is blocked.  If it is lowered, it will check
whether there's a higher priority that could be inherited, and
whether priorities that had been inherited from the changing task
need to be changed.

It also prevents the scheduler from overwriting the RT priority
(which may be inherited) with the base priority in places where
recalculation of non-RT priority is done.

Adjusting the priority inheritance chain on setscheduler is important
for dynamic priority schemes, where the proper functioning of the
system may depend on setscheduler taking effect within a bounded
amount of time.

For the same reason, it'd also be best to revoke an inheritance as
soon as the lender aborts a down_interruptible(), but this patch does
not address that issue.

Signed-off-by: Scott Wood <scott.wood@timesys.com>

--- rttmp/include/linux/sched.h.ORIG	2005-02-25 16:19:50.000000000 -0500
+++ rttmp/include/linux/sched.h	2005-03-09 19:28:03.000000000 -0500
@@ -945,6 +945,10 @@
 extern void mutex_setprio(task_t *p, int prio);
 extern int mutex_getprio(task_t *p);
 
+void mutex_recalc_pi(task_t *p, int force_first_iteration);
+void mutex_lock_pi(unsigned long *flags);
+void mutex_unlock_pi(unsigned long *flags);
+
 void yield(void);
 
 /*
--- rttmp/kernel/sched.c.ORIG	2005-02-25 16:19:43.000000000 -0500
+++ rttmp/kernel/sched.c	2005-03-09 19:28:04.000000000 -0500
@@ -784,7 +784,11 @@
 		}
 	}
 
-	p->prio = effective_prio(p);
+	/* Don't overwrite an inherited RT priority with the static
+	   RT priority. */
+
+	if (!rt_task(p))
+		p->prio = effective_prio(p);
 }
 
 /*
@@ -3836,6 +3840,10 @@
 	prio_array_t *array;
 	unsigned long flags;
 	runqueue_t *rq;
+#ifdef CONFIG_PREEMPT_RT
+	unsigned long pi_flags;
+	unsigned long old_mutex_prio;
+#endif
 
 recheck:
 	/* double check policy once rq lock held */
@@ -3868,11 +3876,19 @@
 	 * To be able to change p->policy safely, the apropriate
 	 * runqueue lock must be held.
 	 */
+#ifdef CONFIG_PREEMPT_RT
+	mutex_lock_pi(&pi_flags);
+	old_mutex_prio = mutex_getprio(p);
+#endif
+
 	rq = task_rq_lock(p, &flags);
 	/* recheck policy now with rq lock held */
 	if (unlikely(oldpolicy != -1 && oldpolicy != p->policy)) {
 		policy = oldpolicy = -1;
 		task_rq_unlock(rq, &flags);
+#ifdef CONFIG_PREEMPT_RT
+		mutex_unlock_pi(&pi_flags);
+#endif
 		goto recheck;
 	}
 	array = p->array;
@@ -3894,6 +3910,29 @@
 			resched_task(rq->curr);
 	}
 	task_rq_unlock(rq, &flags);
+	
+#ifdef CONFIG_PREEMPT_RT
+	/* If the task's priority decreased, it may be able to inherit a
+	   higher priority.  With either an increase or a decrease, any task
+	   inheriting from this task needs to be adjusted.
+	   
+	   This must be done without allowing preemption between the actual
+	   priority change and the PI code, in case a thread is calling
+	   setscheduler on itself.  In this case, if the new priority is lower
+	   than what will keep the thread running, but it could inherit a
+	   higher priority due to a held lock, disabling preemption will allow
+	   it to continue the PI re-evaluation without being immediately
+	   kicked off of the CPU.
+
+	   Additionally, pi_lock is held to keep any changes to
+	   p->prio from happening in parallel to any PI operations. */
+
+	if (old_mutex_prio != mutex_getprio(p))
+		mutex_recalc_pi(p, 1);
+
+	mutex_unlock_pi(&pi_flags);
+#endif
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(sched_setscheduler);
--- rttmp/kernel/rt.c.ORIG	2005-02-25 16:19:46.000000000 -0500
+++ rttmp/kernel/rt.c	2005-03-10 14:16:24.000000000 -0500
@@ -527,16 +527,14 @@
 
 int pi_walk, pi_null, pi_prio;
 
-static void pi_setprio(struct rt_mutex *lock, struct task_struct *p, int prio)
-{
-	if (unlikely(!p->pid)) {
-		pi_null++;
-		return;
-	}
-
 #ifdef CONFIG_RT_DEADLOCK_DETECT
+static void pi_setprio_check(struct task_struct *p, int prio)
+{
 	pi_prio++;
 	if (p->policy != SCHED_NORMAL && prio > mutex_getprio(p)) {
+		struct rt_mutex_waiter *w = p->blocked_on;
+		struct rt_mutex *lock = w->lock;
+
 		TRACE_OFF();
 
 		printk("huh? (%d->%d??)\n", p->prio, prio);
@@ -549,7 +547,55 @@
 		dump_stack();
 		local_irq_disable();
 	}
+}
+#else
+static inline void pi_setprio_check(struct task_struct *p, int prio)
+{
+}
 #endif
+
+static void pi_walk_common(task_t *p, struct rt_mutex_waiter *w, int was_rt)
+{
+	/*
+	 * If the task is blocked on a lock, and we just made
+	 * it RT, then register the task in the PI list and
+	 * requeue it to the head of the wait list:
+	 */
+	struct rt_mutex *lock = w->lock;
+	TRACE_BUG_ON(!lock);
+	TRACE_BUG_ON(!lock->owner);
+	if (rt_task(p) && list_empty(&w->pi_list)) {
+		TRACE_BUG_ON(was_rt);
+		list_add_tail(&w->pi_list, &lock->owner->pi_waiters);
+		list_del(&w->list);
+		list_add(&w->list, &lock->wait_list);
+	}
+	/*
+	 * If the task is blocked on a lock, and we just restored
+	 * it from RT to non-RT then unregister the task from
+	 * the PI list and requeue it to the tail of the wait
+	 * list:
+	 *
+	 * (TODO: this can be unfair to SCHED_NORMAL tasks if they
+	 *        get PI handled.)
+	 */
+	if (!rt_task(p) && !list_empty(&w->pi_list)) {
+		TRACE_BUG_ON(!was_rt);
+		list_del_init(&w->pi_list);
+		list_del(&w->list);
+		list_add_tail(&w->list, &lock->wait_list);
+	}
+
+	pi_walk++;
+}
+
+static void pi_setprio(struct task_struct *p, int prio)
+{
+	if (unlikely(!p->pid)) {
+		pi_null++;
+		return;
+	}
+
 	/*
 	 * If the task is blocked on some other task then boost that
 	 * other task (or tasks) too:
@@ -558,43 +604,17 @@
 		struct rt_mutex_waiter *w = p->blocked_on;
 		int was_rt = rt_task(p);
 
+		pi_setprio_check(p, prio);
+
 		mutex_setprio(p, prio);
 		if (!w)
 			break;
-		/*
-		 * If the task is blocked on a lock, and we just made
-		 * it RT, then register the task in the PI list and
-		 * requeue it to the head of the wait list:
-		 */
-		lock = w->lock;
-		TRACE_BUG_ON(!lock);
-		TRACE_BUG_ON(!lock->owner);
-		if (rt_task(p) && list_empty(&w->pi_list)) {
-			TRACE_BUG_ON(was_rt);
-			list_add_tail(&w->pi_list, &lock->owner->pi_waiters);
-			list_del(&w->list);
-			list_add(&w->list, &lock->wait_list);
-		}
-		/*
-		 * If the task is blocked on a lock, and we just restored
-		 * it from RT to non-RT then unregister the task from
-		 * the PI list and requeue it to the tail of the wait
-		 * list:
-		 *
-		 * (TODO: this can be unfair to SCHED_NORMAL tasks if they
-		 *        get PI handled.)
-		 */
-		if (!rt_task(p) && !list_empty(&w->pi_list)) {
-			TRACE_BUG_ON(!was_rt);
-			list_del(&w->pi_list);
-			list_del(&w->list);
-			list_add_tail(&w->list, &lock->wait_list);
-		}
 
-		pi_walk++;
+ 		pi_walk_common(p, w, was_rt);
 
-		p = lock->owner;
+		p = w->lock->owner;
 		TRACE_BUG_ON(!p);
+		
 		/*
 		 * If the dependee is already higher-prio then
 		 * no need to boost it, and all further tasks down
@@ -605,6 +625,55 @@
 	}
 }
 
+void mutex_recalc_pi(struct task_struct *p, int force_first_iteration)
+{
+	if (unlikely(!p->pid)) {
+		pi_null++;
+		return;
+	}
+
+	for (;;) {
+		struct rt_mutex_waiter *w = p->blocked_on;
+		int was_rt = rt_task(p);
+		int prio = mutex_getprio(p);
+		struct list_head *curr;
+		
+		/* It might be better to maintain a sorted list so that
+		   that recalculating priorities isn't O(n^2)...  Now that
+		   there's a setscheduler hook, this could be done. */
+		
+		list_for_each(curr, &p->pi_waiters) {
+			struct rt_mutex_waiter *tmpw;
+			tmpw = list_entry(curr, struct rt_mutex_waiter, pi_list);
+			if (tmpw->task->prio < prio)
+				prio = tmpw->task->prio;
+			trace_special_pid(tmpw->task->pid, tmpw->task->prio, 0);
+		}
+
+		/* The caller can request that the first iteration be forced
+		   even if the priorities are equal.  This is done so that
+		   priority changes in sched_setscheduler() are reflected
+		   in the inheritance chain, even if an additional priority
+		   change is not required. */
+
+		if (p->prio == prio && !force_first_iteration)
+			break;
+		
+		force_first_iteration = 0;
+
+		pi_setprio_check(p, prio);
+		
+		mutex_setprio(p, prio);
+		if (!w)
+			break;
+
+ 		pi_walk_common(p, w, was_rt);
+
+		p = w->lock->owner;
+		TRACE_BUG_ON(!p);
+	}
+}
+
 static void
 task_blocks_on_lock(struct rt_mutex_waiter *waiter, struct task_struct *task,
 		   struct rt_mutex *lock, unsigned long eip)
@@ -639,7 +708,7 @@
 	 * then temporarily boost the owner:
 	 */
 	if (task->prio < lock->owner->prio)
-		pi_setprio(lock, lock->owner, task->prio);
+		pi_setprio(lock->owner, task->prio);
 	spin_unlock(&pi_lock);
 }
 
@@ -1132,16 +1201,26 @@
 	return __down_trylock(&rwsem->lock, CALLER_ADDR0);
 }
 
+void mutex_lock_pi(unsigned long *flags)
+{
+	trace_lock_irqsave(&trace_lock, *flags);
+	TRACE_BUG_ON(!irqs_disabled());
+	spin_lock(&pi_lock);
+}
+
+void mutex_unlock_pi(unsigned long *flags)
+{
+	spin_unlock(&pi_lock);
+	trace_unlock_irqrestore(&trace_lock, *flags);
+}
+
 /*
  * release the lock:
  */
 static void __up_mutex(struct rt_mutex *lock, int save_state, unsigned long eip)
 {
 	struct task_struct *old_owner, *new_owner;
-	struct rt_mutex_waiter *w;
-	struct list_head *curr;
 	unsigned long flags;
-	int prio;
 
 	TRACE_WARN_ON(save_state != lock->save_state);
 
@@ -1168,20 +1247,8 @@
 	if (!list_empty(&lock->wait_list))
 		new_owner = pick_new_owner(lock, old_owner, save_state, eip);
 
-	/*
-	 * If the owner got priority-boosted then restore it
-	 * to the previous priority (or to the next highest prio
-	 * waiter's priority):
-	 */
-	prio = mutex_getprio(old_owner);
-	list_for_each(curr, &old_owner->pi_waiters) {
-		w = list_entry(curr, struct rt_mutex_waiter, pi_list);
-		if (w->task->prio < prio)
-			prio = w->task->prio;
-		trace_special_pid(w->task->pid, w->task->prio, 0);
-	}
-	if (prio != old_owner->prio)
-		pi_setprio(lock, old_owner, prio);
+	mutex_recalc_pi(old_owner, 0);
+
 	if (new_owner) {
 		if (save_state)
 			wake_up_process_mutex(new_owner);
