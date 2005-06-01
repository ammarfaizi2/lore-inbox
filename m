Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261242AbVFAC7N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261242AbVFAC7N (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 22:59:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261246AbVFAC7N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 22:59:13 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:39162 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S261242AbVFAC5q
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 22:57:46 -0400
Subject: [PATCH] Abstracted Priority Inheritance for RT
From: Daniel Walker <dwalker@mvista.com>
Reply-To: dwalker@mvista.com
To: linux-kernel@vger.kernel.org
Cc: mingo@elte.hu, sdietrich@mvista.com, rostedt@goodmis.org,
       inaky.perez-gonzalez@intel.com
Content-Type: text/plain
Organization: MontaVista
Date: Tue, 31 May 2005 19:57:39 -0700
Message-Id: <1117594659.3798.18.camel@dhcp153.mvista.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I've abstracted priority inheritance from the RT patch. I created pi.h
and pi.c that can be used by other structures that need priority
inheritance. I also added a config option CONFIG_PRIORITY_INHERITANCE so
that PI can be turned off . This could also be made completely separate
from the RT patch.

I'm not sure if this is a draw back or not. It uses a callback structure
to notify when a task changes priority , and to obtain an owner
task_struct. While this works I'm not sure that it is the best method,
it seems somewhat slow. At the same time it may make it more flexible
for other structures to use.

While doing this I noticed that deadlock detect could be modified in the
same way. So that it would work for anything using the blocked_on field
of the task_struct. We could also have abstracted deadlock detect.

Daniel

Signed-off-by: Daniel Walker <dwalker@mvista.com>

Index: linux-2.6.11/include/linux/pi.h
===================================================================
--- linux-2.6.11.orig/include/linux/pi.h	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.11/include/linux/pi.h	2005-06-01 02:03:36.000000000 +0000
@@ -0,0 +1,126 @@
+/*
+ * Real-Time Preemption Support
+ *
+ * started by Ingo Molnar:
+ *
+ *  Copyright (C) 2004, 2005 Red Hat, Inc., Ingo Molnar <mingo@redhat.com>
+ *
+ *  Copyright (C) 2001-2005 MontaVista Software, Inc.
+ *  Daniel Walker <dwalker@mvista.com>
+ */
+
+#ifndef _LINUX_PI_H
+#define _LINUX_PI_H
+
+#include <linux/plist.h>
+
+struct rt_mutex_waiter;
+struct task_struct;
+
+/* 
+ * This is the PI call back structure. All APIs using Priority Inheritance
+ * must implement the functions in this callback structure. They must also 
+ * use the rt_mutex_waiter structure.
+ *
+ */
+struct rt_mutex_waiter_ops {
+
+	/* 
+	 * This function is used to get a struct task_struct for
+	 * the lock owner. 
+	 * @lock: The lock in question.
+	 */
+	struct task_struct * (*lock_owner)(void* lock);
+
+	/*
+	 * This function signals that the mutex waiter has changed
+	 * priorities.
+	 * @lock: The lock in question
+	 * @waiter: The waiter on the lock above
+	 */
+	void (*waiter_changed_prio) (void* lock, struct rt_mutex_waiter* waiter);
+
+};
+
+/*
+ * This is the control structure for tasks blocked on an
+ * mutex:
+ */
+struct rt_mutex_waiter {
+	void *lock;
+	struct plist     list;
+	struct plist     pi_list;
+	struct task_struct *task;
+
+	struct rt_mutex_waiter_ops * mutex_ops;
+
+	unsigned long eip;      // for debugging
+};
+
+#ifdef CONFIG_PRIORITY_INHERITANCE
+/*
+ * Unlock these on crash:
+ */
+extern void zap_pi_lock(void);
+
+/*
+ * Very expensive way to find out if a pi_waiter exists from a lock
+ */
+extern int pi_is_lock_waiter(void *lock, struct task_struct *owner);
+
+/*
+ * Very expensive way to find out if a waiter is a pi_waiter
+ */
+extern int pi_is_waiter(struct rt_mutex_waiter *waiter, struct task_struct *owner);
+
+
+/*
+ * Remove a waiter from the PI list, of old_owner
+ */
+extern void pi_remove_waiter(struct rt_mutex_waiter *waiter, struct task_struct *old_owner);
+
+/*
+ * Move PI waiters of this lock to the new owner:
+ */
+extern void
+pi_change_owner(void *lock, struct task_struct *old_owner,
+                   struct task_struct *new_owner);
+
+/*
+ * This functions should be called when a task no longer holds a
+ * lock. It will restore the task to it original priority, or
+ * to the next highest priority PI waiter.
+ *
+ * @lock: the lock that this task just finished with
+ * @old_owner: the task_struct for the old owner
+ *
+ */
+extern void pi_restore_task(void *lock, struct task_struct *old_owner);
+
+/*
+ * This function performs all nessesary PI when a new tasks blocks on a
+ * specific lock
+ *
+ * @waiter : The rt_mutex_waiter structure for the blocking task
+ * @task : The task structure for the blocking task
+ * @lock: The lock that the task is blocking on
+ * @eip : The instruction pointer of where the task blocked
+ * @all_tasks_pi: boolean value dispense with PI on non-RT tasks
+ *
+ */
+extern void
+pi_task_blocks_on_lock(struct rt_mutex_waiter *waiter, struct task_struct *task,
+                   void *lock, unsigned long eip, int all_tasks_pi);
+
+#else
+
+#define zap_pi_lock()	{ /* */ }
+#define pi_is_lock_waiter(lock, owner)	(0)
+#define pi_is_waiter(waiter, owner)	(0)
+#define pi_remove_waiter(waiter,old_owner)	{ /* */ }
+#define pi_change_owner(lock, old_owner, new_owner)	{ new_owner->blocked_on = NULL; }
+#define pi_restore_task(lock, old_owner)	{ /* */ }
+#define pi_task_blocks_on_lock(waiter, task, lock, eip, all_tasks_pi)	{ (task)->blocked_on = waiter; }
+
+#endif /* CONFIG_PRIORITY_INHERITANCE */ 
+#endif /* _LINUX_PI_H */
Index: linux-2.6.11/include/linux/rt_lock.h
===================================================================
--- linux-2.6.11.orig/include/linux/rt_lock.h	2005-05-27 22:04:12.000000000 +0000
+++ linux-2.6.11/include/linux/rt_lock.h	2005-05-27 22:05:21.000000000 +0000
@@ -13,6 +13,7 @@
 #include <linux/config.h>
 #include <linux/list.h>
 #include <linux/plist.h>
+#include <linux/pi.h>
 
 /*
  * These are the basic SMP spinlocks, allowing only a single CPU anywhere.
@@ -79,19 +80,6 @@ struct rt_mutex {
 # endif
 };
 
-/*
- * This is the control structure for tasks blocked on an
- * RT mutex:
- */
-struct rt_mutex_waiter {
-	struct rt_mutex *lock;
-	struct plist	 list;
-	struct plist	 pi_list;
-	struct task_struct *task;
-
-	unsigned long eip;	// for debugging
-};
-
 #ifdef CONFIG_RT_DEADLOCK_DETECT
 # define __RT_MUTEX_INITIALIZER(lockname) \
 	{ .wait_lock = RAW_SPIN_LOCK_UNLOCKED, \
Index: linux-2.6.11/kernel/rt.c
===================================================================
--- linux-2.6.11.orig/kernel/rt.c	2005-05-27 22:04:12.000000000 +0000
+++ linux-2.6.11/kernel/rt.c	2005-06-01 02:07:37.000000000 +0000
@@ -32,6 +32,7 @@
 #include <linux/syscalls.h>
 #include <linux/interrupt.h>
 #include <linux/plist.h>
+#include <linux/pi.h>
 
 /*
  * These flags are used for allowing of stealing of ownerships.
@@ -48,14 +49,6 @@
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
 /*
  * We need a global lock when we walk through the multi-process
@@ -155,12 +148,31 @@ do {						\
 
 #define TRACE_BUG_ON(c) do { if (c) TRACE_BUG(); } while (0)
 
+struct task_struct* rt_lock_owner (void* lock)
+{
+	return ((((struct rt_mutex*)lock)->owner));
+}
+
+void rt_waiter_changed_prio (void* lock, struct rt_mutex_waiter* w)
+{
+	struct rt_mutex *rt_lock = (struct rt_mutex*)lock;
+
+	plist_del(&w->list, &rt_lock->wait_list);
+	plist_init(&w->list, w->task->prio);
+	plist_add(&w->list, &rt_lock->wait_list);
+}
+
+static struct rt_mutex_waiter_ops rt_mutex_ops = {
+	rt_lock_owner,
+	rt_waiter_changed_prio,
+};
+
 /*
  * Unlock these on crash:
  */
 void zap_rt_locks(void)
 {
-	spin_lock_init(&pi_lock);
+	zap_pi_lock();
 #ifdef CONFIG_RT_DEADLOCK_DETECT
 	spin_lock_init(&trace_lock);
 #endif
@@ -453,11 +465,9 @@ restart:
 			printk("exiting task is not even the owner??\n");
 		goto restart;
 	}
-	spin_lock(&pi_lock);
 	plist_for_each(curr1, &task->pi_waiters) {
 		w = plist_entry(curr1, struct rt_mutex_waiter, pi_list);
 		TRACE_OFF();
-		spin_unlock(&pi_lock);
 		trace_unlock_irqrestore(&trace_lock, flags);
 
 		printk("hm, PI interest held at exit time? Task:\n");
@@ -465,7 +475,6 @@ restart:
 		printk_waiter(w);
 		return;
 	}
-	spin_unlock(&pi_lock);
 	trace_unlock_irqrestore(&trace_lock, flags);
 }
 
@@ -509,173 +518,6 @@ restart:
 
 #endif
 
-#if defined(ALL_TASKS_PI) && defined(CONFIG_RT_DEADLOCK_DETECT)
-
-static void
-check_pi_list_present(struct rt_mutex *lock, struct rt_mutex_waiter *waiter,
-		      struct task_struct *old_owner)
-{
-	struct rt_mutex_waiter *w;
-	struct plist *curr1;
-
-	TRACE_WARN_ON(plist_empty(&waiter->pi_list));
-	TRACE_WARN_ON(lock->owner);
-
-	plist_for_each(curr1, &old_owner->pi_waiters) {
-		w = plist_entry(curr1, struct rt_mutex_waiter, pi_list);
-		if (w == waiter)
-			goto ok;
-	}
-	TRACE_WARN_ON(1);
-ok:
-}
-
-static void
-check_pi_list_empty(struct rt_mutex *lock, struct task_struct *old_owner)
-{
-	struct rt_mutex_waiter *w;
-	struct plist *curr1;
-
-	plist_for_each(curr1, &old_owner->pi_waiters) {
-		w = plist_entry(curr1, struct rt_mutex_waiter, pi_list);
-		if (w->lock == lock) {
-			TRACE_OFF();
-			printk("hm, PI interest but no waiter? Old owner:\n");
-			printk_waiter(w);
-			printk("\n");
-			TRACE_WARN_ON(1);
-			return;
-		}
-	}
-}
-
-#else
-
-static inline void
-check_pi_list_present(struct rt_mutex *lock, struct rt_mutex_waiter *waiter,
-		      struct task_struct *old_owner)
-{
-}
-
-static inline void
-check_pi_list_empty(struct rt_mutex *lock, struct task_struct *old_owner)
-{
-}
-
-#endif
-
-/*
- * Move PI waiters of this lock to the new owner:
- */
-static void
-change_owner(struct rt_mutex *lock, struct task_struct *old_owner,
-		   struct task_struct *new_owner)
-{
-	struct plist *next1, *curr1;
-	struct rt_mutex_waiter *w;
-	int requeued = 0, sum = 0;
-
-	if (old_owner == new_owner)
-		return;
-
-	plist_for_each_safe(curr1, next1, &old_owner->pi_waiters) {
-		w = plist_entry(curr1, struct rt_mutex_waiter, pi_list);
-		if (w->lock == lock) {
-			plist_del(&w->pi_list, &old_owner->pi_waiters);
-			plist_init(&w->pi_list, w->task->prio);
-			plist_add(&w->pi_list, &new_owner->pi_waiters);
-			requeued++;
-		}
-		sum++;
-	}
-	trace_special(sum, requeued, 0);
-}
-
-int pi_walk, pi_null, pi_prio;
-
-static void pi_setprio(struct rt_mutex *lock, struct task_struct *p, int prio)
-{
-	if (unlikely(!p->pid)) {
-		pi_null++;
-		return;
-	}
-
-#ifdef CONFIG_RT_DEADLOCK_DETECT
-	pi_prio++;
-	if (p->policy != SCHED_NORMAL && prio > mutex_getprio(p)) {
-		TRACE_OFF();
-
-		printk("huh? (%d->%d??)\n", p->prio, prio);
-		printk("owner:\n");
-		printk_task(p);
-		printk("\ncurrent:\n");
-		printk_task(current);
-		printk("\nlock:\n");
-		printk_lock(lock, 1);
-		dump_stack();
-		local_irq_disable();
-	}
-#endif
-	/*
-	 * If the task is blocked on some other task then boost that
-	 * other task (or tasks) too:
-	 */
-	for (;;) {
-		struct rt_mutex_waiter *w = p->blocked_on;
-		int was_rt = rt_task(p);
-
-		mutex_setprio(p, prio);
-		if (!w)
-			break;
-		/*
-		 * If the task is blocked on a lock, and we just made
-		 * it RT, then register the task in the PI list and
-		 * requeue it to the wait list:
-		 */
-		lock = w->lock;
-		TRACE_BUG_ON(!lock);
-		TRACE_BUG_ON(!lock->owner);
-		if (rt_task(p) && plist_empty(&w->pi_list)) {
-			TRACE_BUG_ON(was_rt);
-			plist_init(&w->pi_list, prio);
-			plist_add(&w->pi_list, &lock->owner->pi_waiters);
-
-			plist_del(&w->list, &lock->wait_list);
-			plist_init(&w->list, prio);
-			plist_add(&w->list, &lock->wait_list);
-
-		}
-		/*
-		 * If the task is blocked on a lock, and we just restored
-		 * it from RT to non-RT then unregister the task from
-		 * the PI list and requeue it to the wait list.
-		 *
-		 * (TODO: this can be unfair to SCHED_NORMAL tasks if they
-		 *        get PI handled.)
-		 */
-		if (!rt_task(p) && !plist_empty(&w->pi_list)) {
-			TRACE_BUG_ON(!was_rt);
-			plist_del(&w->pi_list, &lock->owner->pi_waiters);
-			plist_del(&w->list, &lock->wait_list);
-			plist_init(&w->list, prio);
-			plist_add(&w->list, &lock->wait_list);
-
-		}
-
-		pi_walk++;
-
-		p = lock->owner;
-		TRACE_BUG_ON(!p);
-		/*
-		 * If the dependee is already higher-prio then
-		 * no need to boost it, and all further tasks down
-		 * the dependency chain are already boosted:
-		 */
-		if (p->prio <= prio)
-			break;
-	}
-}
-
 static void
 task_blocks_on_lock(struct rt_mutex_waiter *waiter, struct task_struct *task,
 		   struct rt_mutex *lock, unsigned long eip)
@@ -685,32 +527,18 @@ task_blocks_on_lock(struct rt_mutex_wait
 	/* mark the current thread as blocked on the lock */
 	waiter->eip = eip;
 #endif
-	task->blocked_on = waiter;
+
+	waiter->mutex_ops = &rt_mutex_ops;
 	waiter->lock = lock;
 	waiter->task = task;
-	plist_init(&waiter->pi_list, task->prio);
-	/*
-	 * Add SCHED_NORMAL tasks to the end of the waitqueue (FIFO):
-	 */
-#ifndef ALL_TASKS_PI
-	if (!rt_task(task)) {
-		plist_add(&waiter->list, &lock->wait_list);
-		return;
-	}
+	plist_init(&waiter->list, task->prio);
+	plist_add(&(waiter->list), &lock->wait_list);
+
+#ifdef ALL_TASKS_PI
+	pi_task_blocks_on_lock(waiter, task, lock, eip, 1);
+#else
+	pi_task_blocks_on_lock(waiter, task, lock, eip, 0);
 #endif
-	spin_lock(&pi_lock);
-	plist_add(&waiter->pi_list, &lock->owner->pi_waiters);
-	/*
-	 * Add RT tasks to the head:
-	 */
-	plist_add(&waiter->list, &lock->wait_list);
-	/*
-	 * If the waiter has higher priority than the owner
-	 * then temporarily boost the owner:
-	 */
-	if (task->prio < lock->owner->prio)
-		pi_setprio(lock, lock->owner, task->prio);
-	spin_unlock(&pi_lock);
 }
 
 /*
@@ -747,7 +575,7 @@ static void set_new_owner(struct rt_mute
 	if (new_owner)
 		trace_special_pid(new_owner->pid, new_owner->prio, 0);
 	if (old_owner)
-		change_owner(lock, old_owner, new_owner);
+		pi_change_owner(lock, old_owner, new_owner);
 	lock->owner = new_owner;
 	lock->owner_prio = new_owner->prio;
 #ifdef CONFIG_RT_DEADLOCK_DETECT
@@ -778,19 +606,17 @@ static inline struct task_struct * pick_
 	trace_special_pid(waiter->task->pid, waiter->task->prio, 0);
 
 #ifdef ALL_TASKS_PI
-	check_pi_list_present(lock, waiter, old_owner);
+	TRACE_WARN_ON(pi_is_waiter(waiter, old_owner));
 #endif
 	new_owner = waiter->task;
 	plist_del_init(&waiter->list, &lock->wait_list);
 
-	plist_del(&waiter->pi_list, &old_owner->pi_waiters);
-	plist_init(&waiter->pi_list, waiter->task->prio);
+	pi_remove_waiter(waiter, old_owner);
 
 	set_new_owner(lock, old_owner, new_owner, waiter->eip);
 	/* Don't touch waiter after ->task has been NULLed */
 	mb();
 	waiter->task = NULL;
-	new_owner->blocked_on = NULL;
 	TRACE_WARN_ON(save_state != lock->save_state);
 
 	return new_owner;
@@ -891,9 +717,7 @@ static int capture_lock(struct rt_mutex_
 		if (grab_lock(lock,task)) {
 			/* we got it back! */
 			struct task_struct *old_owner = lock->owner;
-			spin_lock(&pi_lock);
 			set_new_owner(lock, old_owner, task, waiter->eip);
-			spin_unlock(&pi_lock);
 			ret = 0;
 		} else {
 			/* Add ourselves back to the list */
@@ -930,9 +754,7 @@ static void __sched __down(struct rt_mut
 		/* granted */
 		struct task_struct *old_owner = lock->owner;
 		TRACE_WARN_ON(!plist_empty(&lock->wait_list) && !old_owner);
-		spin_lock(&pi_lock);
 		set_new_owner(lock, old_owner, task, eip);
-		spin_unlock(&pi_lock);
 		spin_unlock(&lock->wait_lock);
 		trace_unlock_irqrestore(&trace_lock, flags);
 
@@ -941,7 +763,6 @@ static void __sched __down(struct rt_mut
 
 	set_task_state(task, TASK_UNINTERRUPTIBLE);
 
-	plist_init(&waiter.list, task->prio);
 	task_blocks_on_lock(&waiter, task, lock, eip);
 
 	TRACE_BUG_ON(!irqs_disabled());
@@ -1027,16 +848,13 @@ static void __sched __down_mutex(struct 
 		/* granted */
 		struct task_struct *old_owner = lock->owner;
 		TRACE_WARN_ON(!plist_empty(&lock->wait_list) && !old_owner);
-		spin_lock(&pi_lock);
 		set_new_owner(lock, old_owner, task, eip);
-		spin_unlock(&pi_lock);
 		spin_unlock(&lock->wait_lock);
 		trace_unlock_irqrestore(&trace_lock, flags);
 
 		return;
 	}
 
-	plist_init(&waiter.list, task->prio);
 	task_blocks_on_lock(&waiter, task, lock, eip);
 
 	TRACE_BUG_ON(!irqs_disabled());
@@ -1167,9 +985,7 @@ static int __sched __down_interruptible(
 		/* granted */
 		struct task_struct *old_owner = lock->owner;
 		TRACE_WARN_ON(!plist_empty(&lock->wait_list) && !old_owner);
-		spin_lock(&pi_lock);
 		set_new_owner(lock, old_owner, task, eip);
-		spin_unlock(&pi_lock);
 		spin_unlock(&lock->wait_lock);
 		trace_unlock_irqrestore(&trace_lock, flags);
 
@@ -1178,7 +994,6 @@ static int __sched __down_interruptible(
 
 	set_task_state(task, TASK_INTERRUPTIBLE);
 
-	plist_init(&waiter.list, task->prio);
 	task_blocks_on_lock(&waiter, task, lock, eip);
 
 	TRACE_BUG_ON(!irqs_disabled());
@@ -1209,10 +1024,7 @@ wait_again:
 				 * (No big problem if our PI effect lingers
 				 *  a bit - owner will restore prio.)
 				 */
-				spin_lock(&pi_lock);
-				plist_del(&waiter.pi_list, &lock->owner->pi_waiters);
-				plist_init(&waiter.pi_list, waiter.task->prio);
-				spin_unlock(&pi_lock);
+				pi_remove_waiter(&waiter, lock->owner);
 				ret = -EINTR;
 			}
 			spin_unlock(&lock->wait_lock);
@@ -1260,9 +1072,7 @@ static int __down_trylock(struct rt_mute
 		/* granted */
 		struct task_struct *old_owner = lock->owner;
 		TRACE_WARN_ON(!plist_empty(&lock->wait_list) && !old_owner);
-		spin_lock(&pi_lock);
 		set_new_owner(lock, old_owner, task, eip);
-		spin_unlock(&pi_lock);
 		ret = 1;
 	}
 
@@ -1317,9 +1127,7 @@ static int down_read_trylock_mutex(struc
 static void __up_mutex(struct rt_mutex *lock, int save_state, unsigned long eip)
 {
 	struct task_struct *old_owner, *new_owner;
-	struct rt_mutex_waiter *w;
 	unsigned long flags;
-	int prio;
 
 	TRACE_WARN_ON(save_state != lock->save_state);
 
@@ -1332,31 +1140,24 @@ static void __up_mutex(struct rt_mutex *
 	TRACE_WARN_ON(list_empty(&lock->held_list));
 	list_del_init(&lock->held_list);
 #endif
-	spin_lock(&pi_lock);
 
 	old_owner = lock->owner;
 #ifdef ALL_TASKS_PI
-	if (plist_empty(&lock->wait_list))
-		check_pi_list_empty(lock, old_owner);
+	if (plist_empty(&lock->wait_list) && pi_is_lock_waiter(lock, old_owner)) {
+		TRACE_OFF();
+		printk("hm, PI interest but no waiter? Old owner:\n");
+		printk_waiter(w);
+		printk("\n");
+		TRACE_WARN_ON(1);
+	}
 #endif
 	lock->owner = NULL;
 	new_owner = NULL;
 	if (!plist_empty(&lock->wait_list))
 		new_owner = pick_new_owner(lock, old_owner, save_state, eip);
 
-	/*
-	 * If the owner got priority-boosted then restore it
-	 * to the previous priority (or to the next highest prio
-	 * waiter's priority):
-	 */
-	prio = mutex_getprio(old_owner);
-	if (!plist_empty(&old_owner->pi_waiters)) {
-		w = plist_entry(&old_owner->pi_waiters, struct rt_mutex_waiter, pi_list);
-		if (w->task->prio < prio)
-			prio = w->task->prio;
-	}
-	if (prio != old_owner->prio)
-		pi_setprio(lock, old_owner, prio);
+	/* Call into the PI code to fix up this tasks prio */
+	pi_restore_task(lock, old_owner);
 
 	if (new_owner) {
 		if (lock != &kernel_sem.lock) {
@@ -1368,7 +1169,6 @@ static void __up_mutex(struct rt_mutex *
 		else
 			wake_up_process(new_owner);
 	}
-	spin_unlock(&pi_lock);
 	spin_unlock(&lock->wait_lock);
 
 #ifdef PREEMPT_DIRECT
Index: linux-2.6.11/lib/Kconfig.RT
===================================================================
--- linux-2.6.11.orig/lib/Kconfig.RT	2005-05-27 22:04:12.000000000 +0000
+++ linux-2.6.11/lib/Kconfig.RT	2005-06-01 00:45:03.000000000 +0000
@@ -86,6 +86,18 @@ config PREEMPT
 	default y
 	depends on PREEMPT_DESKTOP || PREEMPT_RT
 
+config PRIORITY_INHERITANCE
+	bool "Priority Inheritance"
+	default n if !PREEMPT_RT 
+	help
+	  This option enables system wide priority inheritance. It will
+	  enable a high priority waiting task to transfer it's priority
+	  down to the task which is being waited on. This option will 
+	  mostly effect the operation of mutexes and semaphore , but
+	  could also effect other blocking objects in the kernel. The
+	  end result should be faster sleep times for high priority tasks,
+	  but will also increase locking overhead.
+
 config PREEMPT_SOFTIRQS
 	bool "Thread Softirqs"
 	default n
Index: linux-2.6.11/lib/Makefile
===================================================================
--- linux-2.6.11.orig/lib/Makefile	2005-05-27 22:04:12.000000000 +0000
+++ linux-2.6.11/lib/Makefile	2005-05-27 22:33:17.000000000 +0000
@@ -14,8 +14,7 @@ ifeq ($(CONFIG_DEBUG_KOBJECT),y)
 CFLAGS_kobject.o += -DDEBUG
 CFLAGS_kobject_uevent.o += -DDEBUG
 endif
-
-obj-$(CONFIG_PREEMPT_RT) += plist.o
+obj-$(CONFIG_PRIORITY_INHERITANCE) += pi.o
 obj-$(CONFIG_RWSEM_GENERIC_SPINLOCK) += rwsem-spinlock.o
 lib-$(CONFIG_RWSEM_XCHGADD_ALGORITHM) += rwsem.o
 lib-$(CONFIG_GENERIC_FIND_NEXT_BIT) += find_next_bit.o
Index: linux-2.6.11/lib/pi.c
===================================================================
--- linux-2.6.11.orig/lib/pi.c	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.11/lib/pi.c	2005-05-31 20:58:29.000000000 +0000
@@ -0,0 +1,261 @@
+/*
+ * kernel/pi.c
+ *
+ * Real-Time Preemption Support
+ *
+ *  Copyright (C) 2004, 2005 Red Hat, Inc., Ingo Molnar <mingo@redhat.com>
+ *
+ *  Copyright (C) 2001-2005 MontaVista Software, Inc.
+ *  Daniel Walker <dwalker@mvista.com>
+ *
+ */
+#include <linux/config.h>
+#include <linux/sched.h>
+#include <linux/delay.h>
+#include <linux/module.h>
+#include <linux/spinlock.h>
+#include <linux/kallsyms.h>
+#include <linux/syscalls.h>
+#include <linux/interrupt.h>
+#include <linux/pi.h>
+
+/*
+ * We need a global lock for priority inheritance handling.
+ * This is only for the slow path, but still, we might want
+ * to optimize it later to be more scalable.
+ */
+static __cacheline_aligned_in_smp raw_spinlock_t pi_lock =
+						RAW_SPIN_LOCK_UNLOCKED;
+
+
+/*
+ * Unlock these on crash:
+ */
+void zap_pi_lock(void)
+{
+	spin_lock_init(&pi_lock);
+}
+
+/*
+ * Remove a waiter from the PI list, of old_owner
+ */
+void pi_remove_waiter(struct rt_mutex_waiter *waiter, struct task_struct *old_owner)
+{
+	spin_lock(&pi_lock);
+        plist_del(&waiter->pi_list, &old_owner->pi_waiters);
+        plist_init(&waiter->pi_list, waiter->task->prio);
+	spin_unlock(&pi_lock);
+}
+
+/*
+ * Move PI waiters of this lock to the new owner:
+ */
+void
+pi_change_owner(void *lock, struct task_struct *old_owner,
+		   struct task_struct *new_owner)
+{
+	struct plist *next1, *curr1;
+	struct rt_mutex_waiter *w;
+	int requeued = 0, sum = 0;
+
+
+	if (old_owner == new_owner)
+		return;
+
+	spin_lock(&pi_lock);
+
+	plist_for_each_safe(curr1, next1, &old_owner->pi_waiters) {
+		w = plist_entry(curr1, struct rt_mutex_waiter, pi_list);
+		if (w->lock == lock) {
+			plist_del(&w->pi_list, &old_owner->pi_waiters);
+			plist_init(&w->pi_list, w->task->prio);
+			plist_add(&w->pi_list, &new_owner->pi_waiters);
+			requeued++;
+		}
+		sum++;
+	}
+
+	spin_unlock(&pi_lock);
+
+	new_owner->blocked_on = NULL;
+
+	trace_special(sum, requeued, 0);
+}
+
+
+int pi_walk, pi_null, pi_prio;
+
+static void pi_setprio(void *lock, struct task_struct *p, int prio)
+{
+
+	if (unlikely(!p->pid)) {
+		pi_null++;
+		return;
+	}
+
+	pi_prio++;
+
+	/*
+	 * If the task is blocked on some other task then boost that
+	 * other task (or tasks) too:
+	 */
+	for (;;) {
+		struct rt_mutex_waiter *w = p->blocked_on;
+		int was_rt = rt_task(p);
+		struct task_struct *lock_owner;
+
+		mutex_setprio(p, prio);
+		if (!w)
+			break;
+		/*
+		 * If the task is blocked on a lock, and we just made
+		 * it RT, then register the task in the PI list and
+		 * requeue it to the wait list:
+		 */
+		lock = w->lock;
+		lock_owner = w->mutex_ops->lock_owner(lock);
+		BUG_ON(!lock);
+		BUG_ON(!lock_owner);
+		if (rt_task(p) && plist_empty(&w->pi_list)) {
+			BUG_ON(was_rt);
+			plist_init(&w->pi_list, prio);
+			plist_add(&w->pi_list, &lock_owner->pi_waiters);
+
+			w->mutex_ops->waiter_changed_prio(lock, w);
+		}
+		/*
+		 * If the task is blocked on a lock, and we just restored
+		 * it from RT to non-RT then unregister the task from
+		 * the PI list and requeue it to the wait list.
+		 *
+		 * (TODO: this can be unfair to SCHED_NORMAL tasks if they
+		 *        get PI handled.)
+		 */
+		if (!rt_task(p) && !plist_empty(&w->pi_list)) {
+			BUG_ON(!was_rt);
+			plist_del(&w->pi_list, &lock_owner->pi_waiters);
+
+			w->mutex_ops->waiter_changed_prio(lock, w);
+
+		}
+
+		pi_walk++;
+
+		p = lock_owner;
+		BUG_ON(!p);
+		/*
+		 * If the dependee is already higher-prio then
+		 * no need to boost it, and all further tasks down
+		 * the dependency chain are already boosted:
+		 */
+		if (p->prio <= prio)
+			break;
+	}
+}
+
+/*
+ * Very expensive way to find out if a pi_waiter exists from a lock
+ */
+int pi_is_lock_waiter(void *lock, struct task_struct *owner)
+{
+	struct rt_mutex_waiter *w;
+	struct plist *curr1;
+
+	plist_for_each(curr1, &owner->pi_waiters) {
+		w = plist_entry(curr1, struct rt_mutex_waiter, pi_list);
+		if (w->lock == lock) {
+			return 1;
+		}
+	}
+	return 0;
+}
+
+/*
+ * Very expensive way to find out if a waiter is a pi_waiter 
+ */
+int pi_is_waiter(struct rt_mutex_waiter *waiter, struct task_struct *owner)
+{
+	struct rt_mutex_waiter *w;
+	struct plist *curr1;
+
+
+	plist_for_each(curr1, &owner->pi_waiters) {
+		w = plist_entry(curr1, struct rt_mutex_waiter, pi_list);
+		if (w == waiter)
+                        return 1;
+	}
+
+	return 0;
+}
+
+/*
+ * This functions should be called when a task no longer holds a
+ * lock. It will restore the task to it original priority, or
+ * to the next highest priority PI waiter.
+ *
+ * @lock: the lock that this task just finished with
+ * @old_owner: the task_struct for the old owner
+ *
+ */
+void pi_restore_task(void *lock, struct task_struct *old_owner)
+{
+	int prio;
+	struct rt_mutex_waiter *w;
+
+	spin_lock(&pi_lock);
+	/*
+	 * If the owner got priority-boosted then restore it
+	 * to the previous priority (or to the next highest prio
+	 * waiter's priority):
+	 */
+	prio = mutex_getprio(old_owner);
+	if (!plist_empty(&old_owner->pi_waiters)) {
+		w = plist_entry(&old_owner->pi_waiters, struct rt_mutex_waiter, pi_list);
+		if (w->task->prio < prio)
+		prio = w->task->prio;
+	}
+	if (prio != old_owner->prio)
+		pi_setprio(lock, old_owner, prio);
+
+	spin_unlock(&pi_lock);
+}
+
+/*
+ * This function performs all PI functions when a new tasks blocks on a
+ * specific lock
+ *
+ * @waiter : The rt_mutex_waiter structure for the blocking task
+ * @task : The task structure for the blocking task
+ * @lock: The lock that the task is blocking on
+ * @eip : The instruction pointer of where the task blocked
+ * @all_tasks_pi: boolean value dispense with PI on non-RT tasks 
+ *
+ */
+void
+pi_task_blocks_on_lock(struct rt_mutex_waiter *waiter, struct task_struct *task,
+		   void *lock, unsigned long eip, int all_tasks_pi)
+{
+	struct task_struct *lock_owner = waiter->mutex_ops->lock_owner(lock);
+	
+	task->blocked_on = waiter;
+
+	plist_init(&waiter->pi_list, task->prio);
+	/*
+	 * Some tasks don't need PI done on them. 
+	 */
+	if (!rt_task(task) && !all_tasks_pi) 
+		return;
+	
+	spin_lock(&pi_lock);
+	plist_add(&waiter->pi_list, &lock_owner->pi_waiters);
+	/*
+	 * If the waiter has higher priority than the owner
+	 * then temporarily boost the owner:
+	 */
+	if (task->prio < lock_owner->prio)
+		pi_setprio(lock, lock_owner, task->prio);
+
+	spin_unlock(&pi_lock);
+
+}
+




