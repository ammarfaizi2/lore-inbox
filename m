Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932223AbWFUQYg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932223AbWFUQYg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 12:24:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932236AbWFUQYf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 12:24:35 -0400
Received: from www.osadl.org ([213.239.205.134]:10705 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S932229AbWFUQYe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 12:24:34 -0400
Subject: Re: Why can't I set the priority of softirq-hrt? (Re: 2.6.17-rt1)
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Esben Nielsen <nielsen.esben@googlemail.com>
Cc: Esben Nielsen <nielsen.esben@gogglemail.com>,
       Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0606211638560.6572@localhost.localdomain>
References: <20060618070641.GA6759@elte.hu>
	 <Pine.LNX.4.64.0606201656230.11643@localhost.localdomain>
	 <1150816429.6780.222.camel@localhost.localdomain>
	 <Pine.LNX.4.64.0606201725550.11643@localhost.localdomain>
	 <Pine.LNX.4.58.0606201229310.729@gandalf.stny.rr.com>
	 <Pine.LNX.4.64.0606201903030.11643@localhost.localdomain>
	 <1150824092.6780.255.camel@localhost.localdomain>
	 <Pine.LNX.4.64.0606202217160.11643@localhost.localdomain>
	 <Pine.LNX.4.58.0606210418160.29673@gandalf.stny.rr.com>
	 <Pine.LNX.4.64.0606211204220.10723@localhost.localdomain>
	 <Pine.LNX.4.64.0606211638560.6572@localhost.localdomain>
Content-Type: text/plain
Date: Wed, 21 Jun 2006 18:26:04 +0200
Message-Id: <1150907165.25491.4.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-06-21 at 16:43 +0100, Esben Nielsen wrote:
> What about the patch below. It compiles and my UP labtop runs fine, but I 
> haven't otherwise tested it.  My labtop runs RTExec without hichups 
> until now.

NAK, it puts the burden into the lock path and also does a remove / add
which results in walking the chain twice.

Find an version against the code in -mm below. Not too much tested yet.

	tglx

Index: linux-2.6.17-rc6-mm/kernel/rtmutex.c
===================================================================
--- linux-2.6.17-rc6-mm.orig/kernel/rtmutex.c	2006-06-21 13:34:34.000000000 +0200
+++ linux-2.6.17-rc6-mm/kernel/rtmutex.c	2006-06-21 15:45:21.000000000 +0200
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
@@ -448,7 +449,8 @@
 
 	spin_unlock(&lock->wait_lock);
 
-	res = rt_mutex_adjust_prio_chain(owner, detect_deadlock, lock, waiter);
+	res = rt_mutex_adjust_prio_chain(owner, detect_deadlock, lock, waiter,
+					 current);
 
 	spin_lock(&lock->wait_lock);
 
@@ -561,12 +563,35 @@
 
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
+	struct rt_mutex_waiter *waiter = task->pi_blocked_on;
+	unsigned long flags;
+
+	spin_lock_irqsave(&task->pi_lock, flags);
+
+	if (!waiter || waiter->list_entry.prio == task->prio) {
+		spin_unlock_irqrestore(&task->pi_lock, flags);
+		return;
+	}
+
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
@@ -633,6 +658,7 @@
 			if (unlikely(ret))
 				break;
 		}
+
 		spin_unlock(&lock->wait_lock);
 
 		debug_rt_mutex_print_deadlock(&waiter);
Index: linux-2.6.17-rc6-mm/kernel/sched.c
===================================================================
--- linux-2.6.17-rc6-mm.orig/kernel/sched.c	2006-06-21 13:34:34.000000000 +0200
+++ linux-2.6.17-rc6-mm/kernel/sched.c	2006-06-21 18:21:16.000000000 +0200
@@ -4028,8 +4028,7 @@
 int sched_setscheduler(struct task_struct *p, int policy,
 		       struct sched_param *param)
 {
-	int retval;
-	int oldprio, oldpolicy = -1;
+	int retval, oldprio, oldpolicy = -1;
 	prio_array_t *array;
 	unsigned long flags;
 	runqueue_t *rq;
@@ -4119,6 +4118,8 @@
 	__task_rq_unlock(rq);
 	spin_unlock_irqrestore(&p->pi_lock, flags);
 
+	rt_mutex_adjust_pi(p);
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(sched_setscheduler);
Index: linux-2.6.17-rc6-mm/include/linux/sched.h
===================================================================
--- linux-2.6.17-rc6-mm.orig/include/linux/sched.h	2006-06-21 13:37:21.000000000 +0200
+++ linux-2.6.17-rc6-mm/include/linux/sched.h	2006-06-21 15:43:23.000000000 +0200
@@ -1123,11 +1123,13 @@
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


