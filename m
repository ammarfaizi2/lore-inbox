Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261411AbUAEUR2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 15:17:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261368AbUAEUR2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 15:17:28 -0500
Received: from x35.xmailserver.org ([69.30.125.51]:41913 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S261411AbUAEURP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 15:17:15 -0500
X-AuthUser: davidel@xmailserver.org
Date: Mon, 5 Jan 2004 12:16:52 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mdolabs.com
To: John Gardiner Myers <jgmyers@speakeasy.net>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch/revised] wake_up_info() ...
In-Reply-To: <Pine.LNX.4.44.0401051133270.17134-100000@bigblue.dev.mdolabs.com>
Message-ID: <Pine.LNX.4.44.0401051215190.17134-100000@bigblue.dev.mdolabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Jan 2004, Davide Libenzi wrote:

> On Mon, 5 Jan 2004, John Gardiner Myers wrote:
> 
> > It would seem better if info were a void *, to permit sending more than 
> > a single unsigned long.
> 
> It's fine for me. Linus, Manfred?

This is the "void *" version. I slightly prefer the "void *" one.



- Davide




--- linux-2.5/fs/eventpoll.c._orig	2004-01-05 10:43:55.079273352 -0800
+++ linux-2.5/fs/eventpoll.c	2004-01-05 11:36:35.986742376 -0800
@@ -306,7 +306,8 @@
 static void ep_unregister_pollwait(struct eventpoll *ep, struct epitem *epi);
 static int ep_unlink(struct eventpoll *ep, struct epitem *epi);
 static int ep_remove(struct eventpoll *ep, struct epitem *epi);
-static int ep_poll_callback(wait_queue_t *wait, unsigned mode, int sync);
+static int ep_poll_callback(wait_queue_t *wait, unsigned mode, int sync,
+			    void *info);
 static int ep_eventpoll_close(struct inode *inode, struct file *file);
 static unsigned int ep_eventpoll_poll(struct file *file, poll_table *wait);
 static int ep_collect_ready_items(struct eventpoll *ep,
@@ -1293,7 +1294,8 @@
  * machanism. It is called by the stored file descriptors when they
  * have events to report.
  */
-static int ep_poll_callback(wait_queue_t *wait, unsigned mode, int sync)
+static int ep_poll_callback(wait_queue_t *wait, unsigned mode, int sync,
+			    void *info)
 {
 	int pwake = 0;
 	unsigned long flags;
--- linux-2.5/include/linux/wait.h._orig	2004-01-05 09:22:33.802340240 -0800
+++ linux-2.5/include/linux/wait.h	2004-01-05 11:37:39.331112568 -0800
@@ -17,8 +17,10 @@
 #include <asm/system.h>
 
 typedef struct __wait_queue wait_queue_t;
-typedef int (*wait_queue_func_t)(wait_queue_t *wait, unsigned mode, int sync);
-extern int default_wake_function(wait_queue_t *wait, unsigned mode, int sync);
+typedef int (*wait_queue_func_t)(wait_queue_t *wait, unsigned mode, int sync,
+				 void *info);
+extern int default_wake_function(wait_queue_t *wait, unsigned mode, int sync,
+				 void *info);
 
 struct __wait_queue {
 	unsigned int flags;
@@ -107,6 +109,8 @@
 extern void FASTCALL(__wake_up(wait_queue_head_t *q, unsigned int mode, int nr));
 extern void FASTCALL(__wake_up_locked(wait_queue_head_t *q, unsigned int mode));
 extern void FASTCALL(__wake_up_sync(wait_queue_head_t *q, unsigned int mode, int nr));
+extern void FASTCALL(__wake_up_info(wait_queue_head_t *q, unsigned int mode, int nr,
+				    void *info));
 
 #define wake_up(x)			__wake_up((x),TASK_UNINTERRUPTIBLE | TASK_INTERRUPTIBLE, 1)
 #define wake_up_nr(x, nr)		__wake_up((x),TASK_UNINTERRUPTIBLE | TASK_INTERRUPTIBLE, nr)
@@ -117,6 +121,8 @@
 #define wake_up_interruptible_all(x)	__wake_up((x),TASK_INTERRUPTIBLE, 0)
 #define	wake_up_locked(x)		__wake_up_locked((x), TASK_UNINTERRUPTIBLE | TASK_INTERRUPTIBLE)
 #define wake_up_interruptible_sync(x)   __wake_up_sync((x),TASK_INTERRUPTIBLE, 1)
+#define wake_up_info(x, i)		__wake_up_info((x),TASK_UNINTERRUPTIBLE | TASK_INTERRUPTIBLE, 1, (i))
+#define wake_up_all_info(x, i)		__wake_up_info((x),TASK_UNINTERRUPTIBLE | TASK_INTERRUPTIBLE, 0, (i))
 
 #define __wait_event(wq, condition) 					\
 do {									\
@@ -240,7 +246,8 @@
 void FASTCALL(prepare_to_wait_exclusive(wait_queue_head_t *q,
 				wait_queue_t *wait, int state));
 void FASTCALL(finish_wait(wait_queue_head_t *q, wait_queue_t *wait));
-int autoremove_wake_function(wait_queue_t *wait, unsigned mode, int sync);
+int autoremove_wake_function(wait_queue_t *wait, unsigned mode, int sync,
+			     void *info);
 
 #define DEFINE_WAIT(name)						\
 	wait_queue_t name = {						\
--- linux-2.5/kernel/sched.c._orig	2004-01-05 09:22:34.609217576 -0800
+++ linux-2.5/kernel/sched.c	2004-01-05 11:40:03.893135800 -0800
@@ -1632,7 +1632,8 @@
 EXPORT_SYMBOL(preempt_schedule);
 #endif /* CONFIG_PREEMPT */
 
-int default_wake_function(wait_queue_t *curr, unsigned mode, int sync)
+int default_wake_function(wait_queue_t *curr, unsigned mode, int sync,
+			  void *info)
 {
 	task_t *p = curr->task;
 	return try_to_wake_up(p, mode, sync);
@@ -1649,7 +1650,8 @@
  * started to run but is not in state TASK_RUNNING.  try_to_wake_up() returns
  * zero in this (rare) case, and we handle it by continuing to scan the queue.
  */
-static void __wake_up_common(wait_queue_head_t *q, unsigned int mode, int nr_exclusive, int sync)
+static void __wake_up_common(wait_queue_head_t *q, unsigned int mode,
+			     int nr_exclusive, int sync, void *info)
 {
 	struct list_head *tmp, *next;
 
@@ -1658,7 +1660,7 @@
 		unsigned flags;
 		curr = list_entry(tmp, wait_queue_t, task_list);
 		flags = curr->flags;
-		if (curr->func(curr, mode, sync) &&
+		if (curr->func(curr, mode, sync, info) &&
 		    (flags & WQ_FLAG_EXCLUSIVE) &&
 		    !--nr_exclusive)
 			break;
@@ -1676,7 +1678,7 @@
 	unsigned long flags;
 
 	spin_lock_irqsave(&q->lock, flags);
-	__wake_up_common(q, mode, nr_exclusive, 0);
+	__wake_up_common(q, mode, nr_exclusive, 0, NULL);
 	spin_unlock_irqrestore(&q->lock, flags);
 }
 
@@ -1687,7 +1689,7 @@
  */
 void __wake_up_locked(wait_queue_head_t *q, unsigned int mode)
 {
-	__wake_up_common(q, mode, 1, 0);
+	__wake_up_common(q, mode, 1, 0, NULL);
 }
 
 /**
@@ -1712,21 +1714,41 @@
 
 	spin_lock_irqsave(&q->lock, flags);
 	if (likely(nr_exclusive))
-		__wake_up_common(q, mode, nr_exclusive, 1);
+		__wake_up_common(q, mode, nr_exclusive, 1, NULL);
 	else
-		__wake_up_common(q, mode, nr_exclusive, 0);
+		__wake_up_common(q, mode, nr_exclusive, 0, NULL);
 	spin_unlock_irqrestore(&q->lock, flags);
 }
 
 EXPORT_SYMBOL_GPL(__wake_up_sync);	/* For internal use only */
 
+/**
+ * __wake_up_info - wake up threads blocked on a waitqueue by passing an information token.
+ * @q: the waitqueue
+ * @mode: which threads
+ * @nr_exclusive: how many wake-one or wake-many threads to wake up
+ * @info: information token passed to waiters
+ */
+void __wake_up_info(wait_queue_head_t *q, unsigned int mode, int nr_exclusive,
+		    void *info)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&q->lock, flags);
+	__wake_up_common(q, mode, nr_exclusive, 0, info);
+	spin_unlock_irqrestore(&q->lock, flags);
+}
+
+EXPORT_SYMBOL(__wake_up_info);
+
 void complete(struct completion *x)
 {
 	unsigned long flags;
 
 	spin_lock_irqsave(&x->wait.lock, flags);
 	x->done++;
-	__wake_up_common(&x->wait, TASK_UNINTERRUPTIBLE | TASK_INTERRUPTIBLE, 1, 0);
+	__wake_up_common(&x->wait, TASK_UNINTERRUPTIBLE | TASK_INTERRUPTIBLE,
+			 1, 0, NULL);
 	spin_unlock_irqrestore(&x->wait.lock, flags);
 }
 
@@ -1738,7 +1760,8 @@
 
 	spin_lock_irqsave(&x->wait.lock, flags);
 	x->done += UINT_MAX/2;
-	__wake_up_common(&x->wait, TASK_UNINTERRUPTIBLE | TASK_INTERRUPTIBLE, 0, 0);
+	__wake_up_common(&x->wait, TASK_UNINTERRUPTIBLE | TASK_INTERRUPTIBLE,
+			 0, 0, NULL);
 	spin_unlock_irqrestore(&x->wait.lock, flags);
 }
 
--- linux-2.5/kernel/fork.c._orig	2004-01-05 10:27:49.078127848 -0800
+++ linux-2.5/kernel/fork.c	2004-01-05 11:38:14.161817496 -0800
@@ -194,9 +194,10 @@
 
 EXPORT_SYMBOL(finish_wait);
 
-int autoremove_wake_function(wait_queue_t *wait, unsigned mode, int sync)
+int autoremove_wake_function(wait_queue_t *wait, unsigned mode, int sync,
+			     void *info)
 {
-	int ret = default_wake_function(wait, mode, sync);
+	int ret = default_wake_function(wait, mode, sync, info);
 
 	if (ret)
 		list_del_init(&wait->task_list);

