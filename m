Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261567AbVC3Vj5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261567AbVC3Vj5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 16:39:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262279AbVC3Vj4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 16:39:56 -0500
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:44683 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S261567AbVC3VjV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 16:39:21 -0500
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc1-V0.7.41-07
From: Steven Rostedt <rostedt@goodmis.org>
To: Esben Nielsen <simlo@phys.au.dk>
Cc: Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1112212608.3691.147.camel@localhost.localdomain>
References: <Pine.OSF.4.05.10503302042450.2022-100000@da410.phys.au.dk>
	 <1112212608.3691.147.camel@localhost.localdomain>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Wed, 30 Mar 2005 16:39:10 -0500
Message-Id: <1112218750.3691.165.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-03-30 at 14:56 -0500, Steven Rostedt wrote:

> Because of the stupid BKL, I'm going with a combination of your idea and
> my idea for the solution of pending owners.  I originally wanted the
> stealer of the lock to put the task that was robbed back on the list.
> But because of the BKL, you end up with a state that a task can be
> blocked by two locks at the same time. This causes hell with priority
> inheritance.
> 
> So finally, what I'm doing now is to have the lock still pick the
> pending owner, and that owner is not blocked on the lock. If another
> process comes along and steals the lock, the robbed task goes to a state
> as if it was just before calling __down*. So when it wakes up, it checks
> to see if it is the pending owner, and if not, then it tries to grab the
> lock again, if it doesn't get it, it just calls task_blocks_on_lock
> again.
> 
> This is the easiest solution so far, but I still like the stealer to put
> it back on the list.  But until we get rid of the BKL that wont happen.

Well, here it finally is. There's still things I don't like about it.
But it seems to work, and that's the important part.

I had to reluctantly add two items to the task_struct.  I was hoping to
avoid that. But because of race conditions it seemed to be the only way.

The two are:

pending_owner - probably should be pending_lock but it made sense with
the state of the code when I first created it.  This points to the lock
that the task is pending on.  I would have used the blocked_on->lock but
to test this, there existed a race condition between testing it and if
it wasn't the lock, then the task could continue and this waiter (being
on the stack) would be garbage. The chances that it would be garbage and
containing the same lock is extremely low, but the chance exists, and
talk about one hell of a debug to find it!

rt_flags - I would have just added the flag to flags, but since this was
protected by the lock and not by the task, I was afraid of a
read-modify-write from schedule screwing this flag up.

To get a lock, all the down functions call grab_lock. This function may
be optimized too, but right now it is easy to read. It performs a series
of tests to see if it can grab the lock, including if the lock is free,
and if not, can the current task steal it.

All sleeping down functions also call capture_lock, which tests to see
if the lock was stolen or not. If it was, then it tries to get it again,
and if it fails it just calls task_blocks_on_lock again.

It's a relatively simple patch, but it took a lot of pain since I was
trying very hard to have the stealer do the work. But the BKL proved to
be too much.

Also, Ingo, I hope you don't mind my little copyright notice :-)

-- Steve

Index: kernel/rt.c
===================================================================
--- kernel/rt.c	(revision 109)
+++ kernel/rt.c	(working copy)
@@ -17,6 +17,11 @@
  *  Copyright (c) 2001   David Howells (dhowells@redhat.com).
  *  - Derived partially from idea by Andrea Arcangeli <andrea@suse.de>
  *  - Derived also from comments by Linus
+ *
+ * Pending ownership of locks and ownership stealing:
+ *
+ *  Copyright (C) 2005, Kihon Technologies Inc., Steven Rostedt
+ *
  */
 #include <linux/config.h>
 #include <linux/sched.h>
@@ -28,6 +33,14 @@
 #include <linux/interrupt.h>
 
 /*
+ * These flags are used for allowing of stealing of ownerships.
+ */
+#define RT_PENDOWNER	1	/* pending owner on a lock */
+
+#define TASK_PENDING(task) \
+    ((task)->rt_flags & RT_PENDOWNER)
+
+/*
  * This flag is good for debugging the PI code - it makes all tasks
  * in the system fall under PI handling. Normally only SCHED_FIFO/RR
  * tasks are PI-handled:
@@ -791,6 +804,113 @@
 }
 
 /*
+ * Try to grab a lock, and if it is owned but the owner
+ * hasn't woken up yet, see if we can steal it.
+ *
+ * Return: 1 if task can grab lock.
+ *         0 if not.
+ */
+static int grab_lock(struct rt_mutex *lock, struct task_struct *task)
+{
+	struct task_struct *owner = lock->owner;
+
+	if (!owner)
+		return 1;
+	/*
+	 * The lock is owned, but now test to see if the owner
+	 * is still sleeping and hasn't woken up to get the lock.
+	 */
+
+	/* Test the simple case first, is it already running? */
+	if (!TASK_PENDING(owner))
+		return 0;
+		
+	/* The owner is pending on a lock, but is it this lock? */
+	if (owner->pending_owner != lock)
+		return 0;
+
+	/*
+	 * There's an owner, but it hasn't woken up to take the lock yet.
+	 * See if we should steal it from him.
+	 */
+	if (task->prio > owner->prio)
+		return 0;
+
+	/*
+	 * The BKL is a pain in the ass. Don't ever steal it
+
+	 */
+	if (lock == &kernel_sem.lock)
+		return 0;
+
+	/*
+	 * This task is of higher priority than the current pending
+	 * owner, so we may steal it.
+	 */
+	owner->rt_flags &= ~RT_PENDOWNER;
+	owner->pending_owner = NULL;
+
+#ifdef CONFIG_RT_DEADLOCK_DETECT
+	/*
+	 * This task will be taking the ownership away, and 
+	 * when it does, the lock can't be on the held list.
+	 */
+	if (lock->debug) {
+		TRACE_WARN_ON(list_empty(&lock->held_list));
+		list_del_init(&lock->held_list);
+	}
+#endif	
+	return 1;
+}
+
+/*
+ * Bring a task from pending ownership to owning a lock.
+ *
+ * Return 0 if we secured it, otherwise non-zero if it was 
+ *  stolen.
+ */
+static int capture_lock(struct rt_mutex_waiter *waiter, struct task_struct *task)
+{
+	struct rt_mutex *lock = waiter->lock;
+	unsigned long flags;
+	int ret = 0;
+
+	/*
+	 * The BKL is special, we always get it.
+	 */
+	if (lock == &kernel_sem.lock)
+		return 0;
+	
+	trace_lock_irqsave(&trace_lock, flags);
+	spin_lock(&lock->wait_lock);
+	
+	if (!(task->rt_flags & RT_PENDOWNER)) {
+		/* someone else stole it */
+		TRACE_BUG_ON(lock->owner == task);
+		if (grab_lock(lock,task)) {
+			/* we got it back! */
+			struct task_struct *old_owner = lock->owner;
+			spin_lock(&pi_lock);
+			set_new_owner(lock, old_owner, task, waiter->eip);
+			spin_unlock(&pi_lock);
+			ret = 0;
+		} else {
+			/* Add ourselves back to the list */
+			task_blocks_on_lock(waiter,task,lock,waiter->eip);
+			ret = 1;
+		}
+	} else {
+		task->rt_flags &= ~RT_PENDOWNER;
+		task->pending_owner = NULL;
+	}
+
+	spin_unlock(&lock->wait_lock);
+	trace_unlock_irqrestore(&trace_lock, flags);
+		
+	return ret;
+}
+
+/*
  * lock it semaphore-style: no worries about missed wakeups.
  */
 static void __sched __down(struct rt_mutex *lock, unsigned long eip)
@@ -805,11 +925,12 @@
 
 	init_lists(lock);
 
-	if (!lock->owner) {
+	if (grab_lock(lock,task)) {
 		/* granted */
-		TRACE_WARN_ON(!list_empty(&lock->wait_list));
+		struct task_struct *old_owner = lock->owner;
+		TRACE_WARN_ON(!list_empty(&lock->wait_list) && !old_owner);
 		spin_lock(&pi_lock);
-		set_new_owner(lock, NULL, task, eip);
+		set_new_owner(lock, old_owner, task, eip);
 		spin_unlock(&pi_lock);
 		spin_unlock(&lock->wait_lock);
 		trace_unlock_irqrestore(&trace_lock, flags);
@@ -834,6 +955,7 @@
 #endif
 		current->flags &= ~PF_NOSCHED;
 
+ wait_again:
 	/* wait to be given the lock */
 	for (;;) {
 		if (!waiter.task)
@@ -841,6 +963,14 @@
 		schedule();
 		set_task_state(task, TASK_UNINTERRUPTIBLE);
 	}
+	/*
+	 * Check to see if we didn't have ownership stolen.
+	 */
+	if (capture_lock(&waiter,task)) {
+		set_task_state(task, TASK_UNINTERRUPTIBLE);
+		goto wait_again;
+	}
+
 	current->flags |= nosched_flag;
 	task->state = TASK_RUNNING;
 }
@@ -894,11 +1024,12 @@
 
 	init_lists(lock);
 
-	if (!lock->owner) {
+	if (grab_lock(lock,task)) {
 		/* granted */
-		TRACE_WARN_ON(!list_empty(&lock->wait_list));
+		struct task_struct *old_owner = lock->owner;
+		TRACE_WARN_ON(!list_empty(&lock->wait_list) && !old_owner);
 		spin_lock(&pi_lock);
-		set_new_owner(lock, NULL, task, eip);
+		set_new_owner(lock, old_owner, task, eip);
 		spin_unlock(&pi_lock);
 		spin_unlock(&lock->wait_lock);
 		trace_unlock_irqrestore(&trace_lock, flags);
@@ -933,6 +1064,7 @@
 #endif
 		current->flags &= ~PF_NOSCHED;
 
+ wait_again:
 	/* wait to be given the lock */
 	for (;;) {
 		unsigned long saved_flags = current->flags & PF_NOSCHED;
@@ -949,6 +1081,16 @@
 			got_wakeup = 1;
 	}
 	/*
+	 * Check to see if we didn't have ownership stolen.
+	 */
+	if (capture_lock(&waiter,task)) {
+		state = xchg(&task->state, TASK_UNINTERRUPTIBLE);
+		if (state == TASK_RUNNING)
+			got_wakeup = 1;
+		goto wait_again;
+	}
+
+	/*
 	 * Only set the task's state to TASK_RUNNING if it got
 	 * a non-mutex wakeup. We keep the original state otherwise.
 	 * A mutex wakeup changes the task's state to TASK_RUNNING_MUTEX,
@@ -1024,11 +1166,12 @@
 
 	init_lists(lock);
 
-	if (!lock->owner) {
+	if (grab_lock(lock,task)) {
 		/* granted */
-		TRACE_WARN_ON(!list_empty(&lock->wait_list));
+		struct task_struct *old_owner = lock->owner;
+		TRACE_WARN_ON(!list_empty(&lock->wait_list) && !old_owner);
 		spin_lock(&pi_lock);
-		set_new_owner(lock, NULL, task, eip);
+		set_new_owner(lock, old_owner, task, eip);
 		spin_unlock(&pi_lock);
 		spin_unlock(&lock->wait_lock);
 		trace_unlock_irqrestore(&trace_lock, flags);
@@ -1054,6 +1197,7 @@
 		current->flags &= ~PF_NOSCHED;
 
 	ret = 0;
+ wait_again:
 	/* wait to be given the lock */
 	for (;;) {
 		if (signal_pending(current)) {
@@ -1084,6 +1228,16 @@
 		schedule();
 		set_task_state(task, TASK_INTERRUPTIBLE);
 	}
+	
+	/*
+	 * Check to see if we didn't have ownership stolen.
+	 */
+	if (ret) {
+		if (capture_lock(&waiter,task)) {
+			set_task_state(task, TASK_INTERRUPTIBLE);
+			goto wait_again;
+		}
+	}
 
 	task->state = TASK_RUNNING;
 	current->flags |= nosched_flag;
@@ -1112,11 +1266,12 @@
 
 	init_lists(lock);
 
-	if (!lock->owner) {
+	if (grab_lock(lock,task)) {
 		/* granted */
-		TRACE_WARN_ON(!list_empty(&lock->wait_list));
+		struct task_struct *old_owner = lock->owner;
+		TRACE_WARN_ON(!list_empty(&lock->wait_list) && !old_owner);
 		spin_lock(&pi_lock);
-		set_new_owner(lock, NULL, task, eip);
+		set_new_owner(lock, old_owner, task, eip);
 		spin_unlock(&pi_lock);
 		ret = 1;
 	}
@@ -1217,6 +1372,10 @@
 	if (prio != old_owner->prio)
 		pi_setprio(lock, old_owner, prio);
 	if (new_owner) {
+		if (lock != &kernel_sem.lock) {
+			new_owner->rt_flags |= RT_PENDOWNER;
+			new_owner->pending_owner = lock;
+		}
 		if (save_state)
 			wake_up_process_mutex(new_owner);
 		else
Index: include/linux/sched.h
===================================================================
--- include/linux/sched.h	(revision 109)
+++ include/linux/sched.h	(working copy)
@@ -831,6 +831,9 @@
 
 	/* RT deadlock detection and priority inheritance handling */
 	struct rt_mutex_waiter *blocked_on;
+	struct rt_mutex *pending_owner;
+	unsigned long rt_flags;
+	
 
 #ifdef CONFIG_RT_DEADLOCK_DETECT
 	void *last_kernel_lock;


