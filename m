Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261250AbTESIYC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 04:24:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261269AbTESIYC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 04:24:02 -0400
Received: from mx2.elte.hu ([157.181.151.9]:15851 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id S261250AbTESIYA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 04:24:00 -0400
Date: Mon, 19 May 2003 10:35:14 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [patch] sched-sync-2.5.69-A0
Message-ID: <Pine.LNX.4.44.0305191027420.4382-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


the attached patch fixes the scheduler's sync-wakeup code to be consistent
on UP as well.

Right now there's a behavioral difference between an UP kernel and an SMP
kernel running on a UP box: sync wakeups (which are only activated on SMP)  
can cause a wakeup of a higher prio task, without preemption. On UP
kernels this does not happen. This difference in wakeup behavior is bad.

This patch activates sync wakeups on UP as well - in the cases sync
wakeups are done the waker knows that it will schedule away soon, so this
'delay preemption' decision is correct on UP as well.

The patch compiles & boots fine on both UP and SMP.

	Ingo

--- linux/include/linux/wait.h.orig	
+++ linux/include/linux/wait.h	
@@ -111,15 +111,12 @@ extern void FASTCALL(__wake_up_sync(wait
 #define wake_up(x)			__wake_up((x),TASK_UNINTERRUPTIBLE | TASK_INTERRUPTIBLE, 1)
 #define wake_up_nr(x, nr)		__wake_up((x),TASK_UNINTERRUPTIBLE | TASK_INTERRUPTIBLE, nr)
 #define wake_up_all(x)			__wake_up((x),TASK_UNINTERRUPTIBLE | TASK_INTERRUPTIBLE, 0)
+#define wake_up_all_sync(x)			__wake_up_sync((x),TASK_UNINTERRUPTIBLE | TASK_INTERRUPTIBLE, 0)
 #define wake_up_interruptible(x)	__wake_up((x),TASK_INTERRUPTIBLE, 1)
 #define wake_up_interruptible_nr(x, nr)	__wake_up((x),TASK_INTERRUPTIBLE, nr)
 #define wake_up_interruptible_all(x)	__wake_up((x),TASK_INTERRUPTIBLE, 0)
 #define	wake_up_locked(x)		__wake_up_locked((x), TASK_UNINTERRUPTIBLE | TASK_INTERRUPTIBLE)
-#ifdef CONFIG_SMP
 #define wake_up_interruptible_sync(x)   __wake_up_sync((x),TASK_INTERRUPTIBLE, 1)
-#else
-#define wake_up_interruptible_sync(x)   __wake_up((x),TASK_INTERRUPTIBLE, 1)
-#endif
 
 #define __wait_event(wq, condition) 					\
 do {									\
--- linux/kernel/sched.c.orig	
+++ linux/kernel/sched.c	
@@ -1414,8 +1414,6 @@ void __wake_up_locked(wait_queue_head_t 
 	__wake_up_common(q, mode, 1, 0);
 }
 
-#ifdef CONFIG_SMP
-
 /**
  * __wake_up - sync- wake up threads blocked on a waitqueue.
  * @q: the waitqueue
@@ -1426,6 +1424,8 @@ void __wake_up_locked(wait_queue_head_t 
  * away soon, so while the target thread will be woken up, it will not
  * be migrated to another CPU - ie. the two threads are 'synchronized'
  * with each other. This can prevent needless bouncing between CPUs.
+ *
+ * On UP it can prevent extra preemption.
  */
 void __wake_up_sync(wait_queue_head_t *q, unsigned int mode, int nr_exclusive)
 {
@@ -1442,8 +1442,6 @@ void __wake_up_sync(wait_queue_head_t *q
 	spin_unlock_irqrestore(&q->lock, flags);
 }
 
-#endif
-
 void complete(struct completion *x)
 {
 	unsigned long flags;

