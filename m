Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932532AbWFVJJv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932532AbWFVJJv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 05:09:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932537AbWFVJJv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 05:09:51 -0400
Received: from www.osadl.org ([213.239.205.134]:63709 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S932532AbWFVJJv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 05:09:51 -0400
Message-Id: <20060622082812.607857000@cruncher.tec.linutronix.de>
References: <20060622082758.669511000@cruncher.tec.linutronix.de>
Date: Thu, 22 Jun 2006 09:08:39 -0000
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>
Subject: [patch 2/3] rtmutex: Propagate priority settings into PI lock chains
Content-Disposition: inline;
	filename=rt-mutex-propagate-pi-on-set-scheduler.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


When the priority of a task, which is blocked on a lock, changes we must
propagate this change into the PI lock chain. Therefor the chain walk
code is changed to get rid of the references to current to avoid false
positives in the deadlock detector, as setscheduler might be called by a 
task which holds the lock on which the task whose priority is changed is
blocked.
Also add some comments about the get/put_task_struct usage to avoid
confusion.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@elte.hu>

 include/linux/sched.h |    2 ++
 kernel/rtmutex.c      |   41 ++++++++++++++++++++++++++++++++++++-----
 kernel/sched.c        |    2 ++
 3 files changed, 40 insertions(+), 5 deletions(-)

Index: linux-2.6.17-mm/kernel/rtmutex.c
===================================================================
--- linux-2.6.17-mm.orig/kernel/rtmutex.c	2006-06-22 10:26:11.000000000 +0200
+++ linux-2.6.17-mm/kernel/rtmutex.c	2006-06-22 10:26:11.000000000 +0200
@@ -160,7 +160,8 @@
 static int rt_mutex_adjust_prio_chain(task_t *task,
 				      int deadlock_detect,
 				      struct rt_mutex *orig_lock,
-				      struct rt_mutex_waiter *orig_waiter)
+				      struct rt_mutex_waiter *orig_waiter,
+				      struct task_struct *top_task)
 {
 	struct rt_mutex *lock;
 	struct rt_mutex_waiter *waiter, *top_waiter = orig_waiter;
@@ -188,7 +189,7 @@
 			prev_max = max_lock_depth;
 			printk(KERN_WARNING "Maximum lock depth %d reached "
 			       "task: %s (%d)\n", max_lock_depth,
-			       current->comm, current->pid);
+			       top_task->comm, top_task->pid);
 		}
 		put_task_struct(task);
 
@@ -228,7 +229,7 @@
 	}
 
 	/* Deadlock detection */
-	if (lock == orig_lock || rt_mutex_owner(lock) == current) {
+	if (lock == orig_lock || rt_mutex_owner(lock) == top_task) {
 		debug_rt_mutex_deadlock(deadlock_detect, orig_waiter, lock);
 		spin_unlock(&lock->wait_lock);
 		ret = deadlock_detect ? -EDEADLK : 0;
@@ -431,6 +432,7 @@
 		__rt_mutex_adjust_prio(owner);
 		if (owner->pi_blocked_on) {
 			boost = 1;
+			/* gets dropped in rt_mutex_adjust_prio_chain()! */
 			get_task_struct(owner);
 		}
 		spin_unlock_irqrestore(&owner->pi_lock, flags);
@@ -439,6 +441,7 @@
 		spin_lock_irqsave(&owner->pi_lock, flags);
 		if (owner->pi_blocked_on) {
 			boost = 1;
+			/* gets dropped in rt_mutex_adjust_prio_chain()! */
 			get_task_struct(owner);
 		}
 		spin_unlock_irqrestore(&owner->pi_lock, flags);
@@ -448,7 +451,8 @@
 
 	spin_unlock(&lock->wait_lock);
 
-	res = rt_mutex_adjust_prio_chain(owner, detect_deadlock, lock, waiter);
+	res = rt_mutex_adjust_prio_chain(owner, detect_deadlock, lock, waiter,
+					 current);
 
 	spin_lock(&lock->wait_lock);
 
@@ -549,6 +553,7 @@
 
 		if (owner->pi_blocked_on) {
 			boost = 1;
+			/* gets dropped in rt_mutex_adjust_prio_chain()! */
 			get_task_struct(owner);
 		}
 		spin_unlock_irqrestore(&owner->pi_lock, flags);
@@ -561,12 +566,37 @@
 
 	spin_unlock(&lock->wait_lock);
 
-	rt_mutex_adjust_prio_chain(owner, 0, lock, NULL);
+	rt_mutex_adjust_prio_chain(owner, 0, lock, NULL, current);
 
 	spin_lock(&lock->wait_lock);
 }
 
 /*
+ * Recheck the pi chain, in case we got a priority setting
+ *
+ * Called from sched_setscheduler
+ */
+void rt_mutex_adjust_pi(struct task_struct *task)
+{
+	struct rt_mutex_waiter *waiter;
+	unsigned long flags;
+
+	spin_lock_irqsave(&task->pi_lock, flags);
+
+	waiter = task->pi_blocked_on;
+	if (!waiter || waiter->list_entry.prio == task->prio) {
+		spin_unlock_irqrestore(&task->pi_lock, flags);
+		return;
+	}
+
+	/* gets dropped in rt_mutex_adjust_prio_chain()! */
+	get_task_struct(task);
+	spin_unlock_irqrestore(&task->pi_lock, flags);
+
+	rt_mutex_adjust_prio_chain(task, 0, NULL, NULL, task);
+}
+
+/*
  * Slow path lock function:
  */
 static int __sched
@@ -633,6 +663,7 @@
 			if (unlikely(ret))
 				break;
 		}
+
 		spin_unlock(&lock->wait_lock);
 
 		debug_rt_mutex_print_deadlock(&waiter);
Index: linux-2.6.17-mm/include/linux/sched.h
===================================================================
--- linux-2.6.17-mm.orig/include/linux/sched.h	2006-06-22 10:26:11.000000000 +0200
+++ linux-2.6.17-mm/include/linux/sched.h	2006-06-22 10:26:11.000000000 +0200
@@ -1125,11 +1125,13 @@
 #ifdef CONFIG_RT_MUTEXES
 extern int rt_mutex_getprio(task_t *p);
 extern void rt_mutex_setprio(task_t *p, int prio);
+extern void rt_mutex_adjust_pi(task_t *p);
 #else
 static inline int rt_mutex_getprio(task_t *p)
 {
 	return p->normal_prio;
 }
+# define rt_mutex_adjust_pi(p)		do { } while (0)
 #endif
 
 extern void set_user_nice(task_t *p, long nice);
Index: linux-2.6.17-mm/kernel/sched.c
===================================================================
--- linux-2.6.17-mm.orig/kernel/sched.c	2006-06-22 10:26:11.000000000 +0200
+++ linux-2.6.17-mm/kernel/sched.c	2006-06-22 10:26:11.000000000 +0200
@@ -4119,6 +4119,8 @@
 	__task_rq_unlock(rq);
 	spin_unlock_irqrestore(&p->pi_lock, flags);
 
+	rt_mutex_adjust_pi(p);
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(sched_setscheduler);

--

