Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264353AbUABDbh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jan 2004 22:31:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264359AbUABDbh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jan 2004 22:31:37 -0500
Received: from x35.xmailserver.org ([69.30.125.51]:28544 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S264353AbUABDb2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jan 2004 22:31:28 -0500
X-AuthUser: davidel@xmailserver.org
Date: Thu, 1 Jan 2004 19:31:20 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mdolabs.com
To: Manfred Spraul <manfred@colorfullife.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [rfc/patch] wake_up_info() draft ...
In-Reply-To: <3FF4DD6B.2080705@colorfullife.com>
Message-ID: <Pine.LNX.4.44.0401011921250.1458-100000@bigblue.dev.mdolabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Jan 2004, Manfred Spraul wrote:

> Hi Davide,

Hi Manfred,


> I think the patch adds unnecessary bloat, and mandates one particular 
> use of the wait queue info interface.

why are you saying so?


> For example, why does remove_wait_queue_info copy the wakeup info 
> around? That's now how I would use it for fasync: I would send the 
> necessary signals directly from the wakeup handler, and 
> remove_wait_queue_info is called during sys_close handling, info discarded.

As I wrote inside the email, only info-aware waiters will do a 
remove_wait_queue_info(). Others will simply do remove_wait_queue() w/out 
modfications to existing code. The patch I sent (the second one actually) 
is running in my machine, and the changes I had to make are exactly what 
you see inside the patch. Zero modifications to existing code. The patch, 
as is, perfectly fit what you want to do. The waker sets info.data to the 
signal mask, and the waked does a remove_wait_queue_info() and gets the 
signal mask. In your case no dtor/dup are necessary.
This is the one that include John suggestions ...



- Davide



--- linux-2.6.1-rc1/include/linux/wait.h._orig	2004-01-01 14:38:45.569267672 -0800
+++ linux-2.6.1-rc1/include/linux/wait.h	2004-01-01 14:48:41.206717016 -0800
@@ -16,16 +16,24 @@
 #include <linux/spinlock.h>
 #include <asm/system.h>
 
+typedef struct __wait_info wait_info_t;
 typedef struct __wait_queue wait_queue_t;
 typedef int (*wait_queue_func_t)(wait_queue_t *wait, unsigned mode, int sync);
 extern int default_wake_function(wait_queue_t *wait, unsigned mode, int sync);
 
+struct __wait_info {
+	void *data;
+	void *(*dup)(void *);
+	void (*dtor)(void *);
+};
+
 struct __wait_queue {
 	unsigned int flags;
 #define WQ_FLAG_EXCLUSIVE	0x01
 	struct task_struct * task;
 	wait_queue_func_t func;
 	struct list_head task_list;
+	wait_info_t info;
 };
 
 struct __wait_queue_head {
@@ -42,6 +50,7 @@
 #define __WAITQUEUE_INITIALIZER(name, tsk) {				\
 	.task		= tsk,						\
 	.func		= default_wake_function,			\
+	.info		= { NULL, NULL, NULL },				\
 	.task_list	= { NULL, NULL } }
 
 #define DECLARE_WAITQUEUE(name, tsk)					\
@@ -60,11 +69,40 @@
 	INIT_LIST_HEAD(&q->task_list);
 }
 
+static inline void init_wait_info(wait_info_t *i)
+{
+	i->data = NULL;
+	i->dup = NULL;
+	i->dtor = NULL;
+}
+
+static inline void close_wait_info(wait_info_t *i)
+{
+	if (i->dtor)
+		i->dtor(i->data);
+	init_wait_info(i);
+}
+
+static inline void transfer_wait_info(wait_info_t *d, wait_info_t *s)
+{
+	if (d->dtor)
+		d->dtor(d->data);
+	*d = *s;
+}
+
+static inline void dup_wait_info(wait_info_t *d, wait_info_t *s)
+{
+	transfer_wait_info(d, s);
+	if (s->dup)
+		d->data = s->dup(s->data);
+}
+
 static inline void init_waitqueue_entry(wait_queue_t *q, struct task_struct *p)
 {
 	q->flags = 0;
 	q->task = p;
 	q->func = default_wake_function;
+	init_wait_info(&q->info);
 }
 
 static inline void init_waitqueue_func_entry(wait_queue_t *q,
@@ -73,6 +111,7 @@
 	q->flags = 0;
 	q->task = NULL;
 	q->func = func;
+	init_wait_info(&q->info);
 }
 
 static inline int waitqueue_active(wait_queue_head_t *q)
@@ -83,6 +122,10 @@
 extern void FASTCALL(add_wait_queue(wait_queue_head_t *q, wait_queue_t * wait));
 extern void FASTCALL(add_wait_queue_exclusive(wait_queue_head_t *q, wait_queue_t * wait));
 extern void FASTCALL(remove_wait_queue(wait_queue_head_t *q, wait_queue_t * wait));
+extern void FASTCALL(remove_wait_queue_info(wait_queue_head_t *q, wait_queue_t * wait,
+					    wait_info_t *info));
+extern void FASTCALL(geti_wait_queue_info(wait_queue_head_t *q, wait_queue_t * wait,
+					  wait_info_t *info));
 
 static inline void __add_wait_queue(wait_queue_head_t *head, wait_queue_t *new)
 {
@@ -102,11 +145,13 @@
 							wait_queue_t *old)
 {
 	list_del(&old->task_list);
+	close_wait_info(&old->info);
 }
 
 extern void FASTCALL(__wake_up(wait_queue_head_t *q, unsigned int mode, int nr));
 extern void FASTCALL(__wake_up_locked(wait_queue_head_t *q, unsigned int mode));
 extern void FASTCALL(__wake_up_sync(wait_queue_head_t *q, unsigned int mode, int nr));
+extern void FASTCALL(__wake_up_info(wait_queue_head_t *q, unsigned int mode, int nr, wait_info_t *info));
 
 #define wake_up(x)			__wake_up((x),TASK_UNINTERRUPTIBLE | TASK_INTERRUPTIBLE, 1)
 #define wake_up_nr(x, nr)		__wake_up((x),TASK_UNINTERRUPTIBLE | TASK_INTERRUPTIBLE, nr)
@@ -117,6 +162,8 @@
 #define wake_up_interruptible_all(x)	__wake_up((x),TASK_INTERRUPTIBLE, 0)
 #define	wake_up_locked(x)		__wake_up_locked((x), TASK_UNINTERRUPTIBLE | TASK_INTERRUPTIBLE)
 #define wake_up_interruptible_sync(x)   __wake_up_sync((x),TASK_INTERRUPTIBLE, 1)
+#define wake_up_info(x, i)		__wake_up_info((x),TASK_UNINTERRUPTIBLE | TASK_INTERRUPTIBLE, 1, (i))
+#define wake_up_all_info(x, i)		__wake_up_info((x),TASK_UNINTERRUPTIBLE | TASK_INTERRUPTIBLE, 0, (i))
 
 #define __wait_event(wq, condition) 					\
 do {									\
--- linux-2.6.1-rc1/kernel/fork.c._orig	2004-01-01 14:38:24.058537800 -0800
+++ linux-2.6.1-rc1/kernel/fork.c	2004-01-01 14:39:32.537127472 -0800
@@ -125,6 +125,32 @@
 
 EXPORT_SYMBOL(remove_wait_queue);
 
+void remove_wait_queue_info(wait_queue_head_t *q, wait_queue_t * wait,
+			    wait_info_t *info)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&q->lock, flags);
+	transfer_wait_info(info, &wait->info);
+	__remove_wait_queue(q, wait);
+	spin_unlock_irqrestore(&q->lock, flags);
+}
+
+EXPORT_SYMBOL(remove_wait_queue_info);
+
+void geti_wait_queue_info(wait_queue_head_t *q, wait_queue_t * wait,
+			  wait_info_t *info)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&q->lock, flags);
+	transfer_wait_info(info, &wait->info);
+	init_wait_info(&wait->info);
+	spin_unlock_irqrestore(&q->lock, flags);
+}
+
+EXPORT_SYMBOL(geti_wait_queue_info);
+
 
 /*
  * Note: we use "set_current_state()" _after_ the wait-queue add,
--- linux-2.6.1-rc1/kernel/sched.c._orig	2004-01-01 14:38:34.353972656 -0800
+++ linux-2.6.1-rc1/kernel/sched.c	2004-01-01 14:44:37.615748472 -0800
@@ -1649,7 +1649,8 @@
  * started to run but is not in state TASK_RUNNING.  try_to_wake_up() returns
  * zero in this (rare) case, and we handle it by continuing to scan the queue.
  */
-static void __wake_up_common(wait_queue_head_t *q, unsigned int mode, int nr_exclusive, int sync)
+static void __wake_up_common(wait_queue_head_t *q, unsigned int mode,
+			     int nr_exclusive, int sync, wait_info_t *info)
 {
 	struct list_head *tmp, *next;
 
@@ -1658,6 +1659,8 @@
 		unsigned flags;
 		curr = list_entry(tmp, wait_queue_t, task_list);
 		flags = curr->flags;
+		if (info)
+			dup_wait_info(&curr->info, info);
 		if (curr->func(curr, mode, sync) &&
 		    (flags & WQ_FLAG_EXCLUSIVE) &&
 		    !--nr_exclusive)
@@ -1676,7 +1679,7 @@
 	unsigned long flags;
 
 	spin_lock_irqsave(&q->lock, flags);
-	__wake_up_common(q, mode, nr_exclusive, 0);
+	__wake_up_common(q, mode, nr_exclusive, 0, NULL);
 	spin_unlock_irqrestore(&q->lock, flags);
 }
 
@@ -1687,7 +1690,7 @@
  */
 void __wake_up_locked(wait_queue_head_t *q, unsigned int mode)
 {
-	__wake_up_common(q, mode, 1, 0);
+	__wake_up_common(q, mode, 1, 0, NULL);
 }
 
 /**
@@ -1712,21 +1715,41 @@
 
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
+		    wait_info_t *info)
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
 
@@ -1738,7 +1761,8 @@
 
 	spin_lock_irqsave(&x->wait.lock, flags);
 	x->done += UINT_MAX/2;
-	__wake_up_common(&x->wait, TASK_UNINTERRUPTIBLE | TASK_INTERRUPTIBLE, 0, 0);
+	__wake_up_common(&x->wait, TASK_UNINTERRUPTIBLE | TASK_INTERRUPTIBLE,
+			 0, 0, NULL);
 	spin_unlock_irqrestore(&x->wait.lock, flags);
 }
 

