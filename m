Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265359AbUAADp6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Dec 2003 22:45:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265361AbUAADp6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Dec 2003 22:45:58 -0500
Received: from x35.xmailserver.org ([69.30.125.51]:60844 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S265359AbUAADpP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Dec 2003 22:45:15 -0500
X-AuthUser: davidel@xmailserver.org
Date: Wed, 31 Dec 2003 19:46:42 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mdolabs.com
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
cc: Linus Torvalds <torvalds@osdl.org>
Subject: [rfc/patch] wake_up_info() draft ...
Message-ID: <Pine.LNX.4.44.0312311907240.5831-100000@bigblue.dev.mdolabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


We currently have a nice wait/wake infrastructure to have processes to 
drop themselves inside wait queues waiting someone else to wake them up. 
The current bits do work fine but they are IMO missing of a powerful 
feature. That is, transmit to the waiters some information about the cause 
of the wake up. With this missing, waiters would then have to perform 
additional steps to acquire the requested informations. And this can 
involve grabbing lock/sems and calling functions like, for example, 
f_op->poll(). Adding such capability to the current infrastructure is both 
trivial and does not screw up the existing code, that can be (when 
necessary) ported gradually. The code will add a structure:

typedef struct wait_info_t;

struct __wait_info {
        void *data;
        int (*dup)(wait_info_t *, wait_info_t *);
        void (*dtor)(wait_info_t *);
};

to the wait queue item:

struct __wait_queue {
        unsigned int flags;
#define WQ_FLAG_EXCLUSIVE       0x01
        struct task_struct * task;
        wait_queue_func_t func;
        struct list_head task_list;
        wait_info_t info;
};

The wait info structure has a member "data" that can be anything from a 
pointer to an interger to a bitmask. Two functions can be provided to help 
managing more complex info data. The "dtor" is the (guess what) distructor 
of the info, while the "dup" is replicator of the structure itself. When 
the info structure does not require any special treatment, both "dtor" and 
"dup" will be simply NULL. A typicaly info-aware waiter will do something 
like:

wait_queue_t wait;
wait_info_t info;

init_waitqueue_entry(&wait, current);
add_wait_queue(&wait_list, &wait);

>> Usual Wait Loop

remove_wait_queue_info(&wait_list, &wait, &info);

>> Look up info

close_wait_info(&info);


The waker will instead do, for example, something like (in the most simple 
case):

wait_info_t info;

init_wait_info(&info);
info.data = (void *) POLLIN;

wake_up_info(&wait_list, &info);


The one below is a very first draft of the code. What do you think?



- Davide




--- linux-2.6.1-rc1-mm1/include/linux/wait.h.orig	2003-12-31 16:30:03.872807704 -0800
+++ linux-2.6.1-rc1-mm1/include/linux/wait.h	2003-12-31 19:05:42.196166768 -0800
@@ -16,16 +16,24 @@
 #include <linux/spinlock.h>
 #include <asm/system.h>
 
+typedef struct wait_info_t;
 typedef struct __wait_queue wait_queue_t;
 typedef int (*wait_queue_func_t)(wait_queue_t *wait, unsigned mode, int sync);
 extern int default_wake_function(wait_queue_t *wait, unsigned mode, int sync);
 
+struct __wait_info {
+	void *data;
+	int (*dup)(wait_info_t *, wait_info_t *);
+	void (*dtor)(wait_info_t *);
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
@@ -60,11 +69,34 @@
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
+		i->dtor(i);
+}
+
+static inline int dup_wait_info(wait_info_t *s, wait_info_t *d)
+{
+	close_wait_info(d);
+	if (s->dup)
+		return s->dup(s, d);
+	*d = *s;
+	return 0;
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
@@ -73,6 +105,7 @@
 	q->flags = 0;
 	q->task = NULL;
 	q->func = func;
+	init_wait_info(&q->info);
 }
 
 static inline int waitqueue_active(wait_queue_head_t *q)
@@ -92,6 +125,8 @@
 extern void FASTCALL(add_wait_queue(wait_queue_head_t *q, wait_queue_t * wait));
 extern void FASTCALL(add_wait_queue_exclusive(wait_queue_head_t *q, wait_queue_t * wait));
 extern void FASTCALL(remove_wait_queue(wait_queue_head_t *q, wait_queue_t * wait));
+extern void FASTCALL(remove_wait_queue_info(wait_queue_head_t *q, wait_queue_t * wait,
+					    wait_info_t *info));
 
 static inline void __add_wait_queue(wait_queue_head_t *head, wait_queue_t *new)
 {
@@ -111,11 +146,13 @@
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
@@ -126,6 +163,7 @@
 #define wake_up_interruptible_all(x)	__wake_up((x),TASK_INTERRUPTIBLE, 0)
 #define	wake_up_locked(x)		__wake_up_locked((x), TASK_UNINTERRUPTIBLE | TASK_INTERRUPTIBLE)
 #define wake_up_interruptible_sync(x)   __wake_up_sync((x),TASK_INTERRUPTIBLE, 1)
+#define wake_up_info(x, i)		__wake_up_info((x),TASK_UNINTERRUPTIBLE | TASK_INTERRUPTIBLE, 1, (i))
 
 #define __wait_event(wq, condition) 					\
 do {									\
--- linux-2.6.1-rc1-mm1/kernel/sched.c.orig	2003-12-31 16:47:52.374370776 -0800
+++ linux-2.6.1-rc1-mm1/kernel/sched.c	2003-12-31 19:04:38.614832600 -0800
@@ -1708,7 +1708,7 @@
  * zero in this (rare) case, and we handle it by continuing to scan the queue.
  */
 static void __wake_up_common(wait_queue_head_t *q, unsigned int mode,
-			     int nr_exclusive, int sync)
+			     int nr_exclusive, int sync, wait_info_t *info)
 {
 	struct list_head *tmp, *next;
 
@@ -1717,6 +1717,8 @@
 		unsigned flags;
 		curr = list_entry(tmp, wait_queue_t, task_list);
 		flags = curr->flags;
+		if (info)
+			dup_wait_info(info, &curr->info);
 		if (curr->func(curr, mode, sync) &&
 		    (flags & WQ_FLAG_EXCLUSIVE) &&
 		    !--nr_exclusive)
@@ -1735,7 +1737,7 @@
 	unsigned long flags;
 
 	spin_lock_irqsave(&q->lock, flags);
-	__wake_up_common(q, mode, nr_exclusive, 0);
+	__wake_up_common(q, mode, nr_exclusive, 0, NULL);
 	spin_unlock_irqrestore(&q->lock, flags);
 }
 
@@ -1746,7 +1748,7 @@
  */
 void __wake_up_locked(wait_queue_head_t *q, unsigned int mode)
 {
-	__wake_up_common(q, mode, 1, 0);
+	__wake_up_common(q, mode, 1, 0, NULL);
 }
 
 /**
@@ -1771,14 +1773,33 @@
 
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
@@ -1786,7 +1807,7 @@
 	spin_lock_irqsave(&x->wait.lock, flags);
 	x->done++;
 	__wake_up_common(&x->wait, TASK_UNINTERRUPTIBLE | TASK_INTERRUPTIBLE,
-			 1, 0);
+			 1, 0, NULL);
 	spin_unlock_irqrestore(&x->wait.lock, flags);
 }
 
@@ -1799,7 +1820,7 @@
 	spin_lock_irqsave(&x->wait.lock, flags);
 	x->done += UINT_MAX/2;
 	__wake_up_common(&x->wait, TASK_UNINTERRUPTIBLE | TASK_INTERRUPTIBLE,
-			 0, 0);
+			 0, 0, NULL);
 	spin_unlock_irqrestore(&x->wait.lock, flags);
 }
 
--- linux-2.6.1-rc1-mm1/kernel/fork.c.orig	2003-12-31 18:59:38.694427432 -0800
+++ linux-2.6.1-rc1-mm1/kernel/fork.c	2003-12-31 19:03:06.014909928 -0800
@@ -124,6 +124,19 @@
 
 EXPORT_SYMBOL(remove_wait_queue);
 
+void remove_wait_queue_info(wait_queue_head_t *q, wait_queue_t * wait,
+			    wait_info_t *info)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&q->lock, flags);
+	dup_wait_info(&wait->info, info);
+	__remove_wait_queue(q, wait);
+	spin_unlock_irqrestore(&q->lock, flags);
+}
+
+EXPORT_SYMBOL(remove_wait_queue_info);
+
 
 /*
  * Note: we use "set_current_state()" _after_ the wait-queue add,


