Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261282AbUJ3PiP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261282AbUJ3PiP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 11:38:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261271AbUJ3PgI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 11:36:08 -0400
Received: from mail06.syd.optusnet.com.au ([211.29.132.187]:17865 "EHLO
	mail06.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261197AbUJ3Ojc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 10:39:32 -0400
Message-ID: <4183A790.7040409@kolivas.org>
Date: Sun, 31 Oct 2004 00:39:12 +1000
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Peter Williams <pwil3058@bigpond.net.au>,
       William Lee Irwin III <wli@holomorphy.com>,
       Alexander Nyberg <alexn@dsv.su.se>,
       Nick Piggin <nickpiggin@yahoo.com.au>
Subject: [PATCH][plugsched 13/28] Make wakeup functions public
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig705F7E65B0F1BAC27CB7E323"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig705F7E65B0F1BAC27CB7E323
Content-Type: multipart/mixed;
 boundary="------------050208060305010003060809"

This is a multi-part message in MIME format.
--------------050208060305010003060809
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Make wakeup functions public


--------------050208060305010003060809
Content-Type: text/x-patch;
 name="publicise_wakeups.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="publicise_wakeups.diff"

Move the common wakeup stuff to scheduler.c

wait_for_completion is design dependant; privatise that.

Signed-off-by: Con Kolivas <kernel@kolivas.org>


Index: linux-2.6.10-rc1-mm2-plugsched1/include/linux/scheduler.h
===================================================================
--- linux-2.6.10-rc1-mm2-plugsched1.orig/include/linux/scheduler.h	2004-10-29 21:47:05.007044378 +1000
+++ linux-2.6.10-rc1-mm2-plugsched1/include/linux/scheduler.h	2004-10-29 21:47:15.473410961 +1000
@@ -1,5 +1,6 @@
 struct sched_drv
 {
+	void (*wait_for_completion)(struct completion *);
 	void (*io_schedule)(void);
 	long (*io_schedule_timeout)(long);
 	void (*sched_idle_next)(void);
Index: linux-2.6.10-rc1-mm2-plugsched1/kernel/sched.c
===================================================================
--- linux-2.6.10-rc1-mm2-plugsched1.orig/kernel/sched.c	2004-10-29 21:47:10.884127180 +1000
+++ linux-2.6.10-rc1-mm2-plugsched1/kernel/sched.c	2004-10-29 21:47:38.395833609 +1000
@@ -1118,19 +1118,6 @@ out:
 	return success;
 }
 
-int fastcall wake_up_process(task_t * p)
-{
-	return try_to_wake_up(p, TASK_STOPPED | TASK_TRACED |
-		       		 TASK_INTERRUPTIBLE | TASK_UNINTERRUPTIBLE, 0);
-}
-
-EXPORT_SYMBOL(wake_up_process);
-
-int fastcall wake_up_state(task_t *p, unsigned int state)
-{
-	return try_to_wake_up(p, state, 0);
-}
-
 #ifdef CONFIG_SMP
 static int find_idlest_cpu(struct task_struct *p, int this_cpu,
 			   struct sched_domain *sd);
@@ -2776,121 +2763,7 @@ switch_tasks:
 		goto need_resched;
 }
 
-int default_wake_function(wait_queue_t *curr, unsigned mode, int sync, void *key)
-{
-	task_t *p = curr->task;
-	return try_to_wake_up(p, mode, sync);
-}
-
-EXPORT_SYMBOL(default_wake_function);
-
-/*
- * The core wakeup function.  Non-exclusive wakeups (nr_exclusive == 0) just
- * wake everything up.  If it's an exclusive wakeup (nr_exclusive == small +ve
- * number) then we wake all the non-exclusive tasks and one exclusive task.
- *
- * There are circumstances in which we can try to wake a task which has already
- * started to run but is not in state TASK_RUNNING.  try_to_wake_up() returns
- * zero in this (rare) case, and we handle it by continuing to scan the queue.
- */
-static void __wake_up_common(wait_queue_head_t *q, unsigned int mode,
-			     int nr_exclusive, int sync, void *key)
-{
-	struct list_head *tmp, *next;
-
-	list_for_each_safe(tmp, next, &q->task_list) {
-		wait_queue_t *curr;
-		unsigned flags;
-		curr = list_entry(tmp, wait_queue_t, task_list);
-		flags = curr->flags;
-		if (curr->func(curr, mode, sync, key) &&
-		    (flags & WQ_FLAG_EXCLUSIVE) &&
-		    !--nr_exclusive)
-			break;
-	}
-}
-
-/**
- * __wake_up - wake up threads blocked on a waitqueue.
- * @q: the waitqueue
- * @mode: which threads
- * @nr_exclusive: how many wake-one or wake-many threads to wake up
- */
-void fastcall __wake_up(wait_queue_head_t *q, unsigned int mode,
-				int nr_exclusive, void *key)
-{
-	unsigned long flags;
-
-	spin_lock_irqsave(&q->lock, flags);
-	__wake_up_common(q, mode, nr_exclusive, 0, key);
-	spin_unlock_irqrestore(&q->lock, flags);
-}
-
-EXPORT_SYMBOL(__wake_up);
-
-/*
- * Same as __wake_up but called with the spinlock in wait_queue_head_t held.
- */
-void fastcall __wake_up_locked(wait_queue_head_t *q, unsigned int mode)
-{
-	__wake_up_common(q, mode, 1, 0, NULL);
-}
-
-/**
- * __wake_up - sync- wake up threads blocked on a waitqueue.
- * @q: the waitqueue
- * @mode: which threads
- * @nr_exclusive: how many wake-one or wake-many threads to wake up
- *
- * The sync wakeup differs that the waker knows that it will schedule
- * away soon, so while the target thread will be woken up, it will not
- * be migrated to another CPU - ie. the two threads are 'synchronized'
- * with each other. This can prevent needless bouncing between CPUs.
- *
- * On UP it can prevent extra preemption.
- */
-void fastcall __wake_up_sync(wait_queue_head_t *q, unsigned int mode, int nr_exclusive)
-{
-	unsigned long flags;
-	int sync = 1;
-
-	if (unlikely(!q))
-		return;
-
-	if (unlikely(!nr_exclusive))
-		sync = 0;
-
-	spin_lock_irqsave(&q->lock, flags);
-	__wake_up_common(q, mode, nr_exclusive, sync, NULL);
-	spin_unlock_irqrestore(&q->lock, flags);
-}
-EXPORT_SYMBOL_GPL(__wake_up_sync);	/* For internal use only */
-
-void fastcall complete(struct completion *x)
-{
-	unsigned long flags;
-
-	spin_lock_irqsave(&x->wait.lock, flags);
-	x->done++;
-	__wake_up_common(&x->wait, TASK_UNINTERRUPTIBLE | TASK_INTERRUPTIBLE,
-			 1, 0, NULL);
-	spin_unlock_irqrestore(&x->wait.lock, flags);
-}
-EXPORT_SYMBOL(complete);
-
-void fastcall complete_all(struct completion *x)
-{
-	unsigned long flags;
-
-	spin_lock_irqsave(&x->wait.lock, flags);
-	x->done += UINT_MAX/2;
-	__wake_up_common(&x->wait, TASK_UNINTERRUPTIBLE | TASK_INTERRUPTIBLE,
-			 0, 0, NULL);
-	spin_unlock_irqrestore(&x->wait.lock, flags);
-}
-EXPORT_SYMBOL(complete_all);
-
-void fastcall __sched wait_for_completion(struct completion *x)
+static void __sched ingo_wait_for_completion(struct completion *x)
 {
 	might_sleep();
 	spin_lock_irq(&x->wait.lock);
@@ -4266,6 +4139,7 @@ void destroy_sched_domain_sysctl()
 #endif
 
 struct sched_drv ingo_sched_drv = {
+	.wait_for_completion	= ingo_wait_for_completion,
 	.io_schedule		= ingo_io_schedule,
 	.io_schedule_timeout	= ingo_io_schedule_timeout,
 	.set_oom_timeslice	= ingo_set_oom_timeslice,
Index: linux-2.6.10-rc1-mm2-plugsched1/kernel/scheduler.c
===================================================================
--- linux-2.6.10-rc1-mm2-plugsched1.orig/kernel/scheduler.c	2004-10-29 21:47:10.886126868 +1000
+++ linux-2.6.10-rc1-mm2-plugsched1/kernel/scheduler.c	2004-10-29 21:47:15.477410337 +1000
@@ -751,9 +751,140 @@ int in_sched_functions(unsigned long add
 		&& addr < (unsigned long)__sched_text_end);
 }
 
+int try_to_wake_up(task_t *task, unsigned state, int sync);
+
+int fastcall wake_up_state(task_t *p, unsigned int state)
+{
+	return try_to_wake_up(p, state, 0);
+}
+
+int fastcall wake_up_process(task_t * p)
+{
+	return try_to_wake_up(p, TASK_STOPPED | TASK_TRACED |
+		       		 TASK_INTERRUPTIBLE | TASK_UNINTERRUPTIBLE, 0);
+}
+EXPORT_SYMBOL(wake_up_process);
+
+/*
+ * The core wakeup function.  Non-exclusive wakeups (nr_exclusive == 0) just
+ * wake everything up.  If it's an exclusive wakeup (nr_exclusive == small +ve
+ * number) then we wake all the non-exclusive tasks and one exclusive task.
+ *
+ * There are circumstances in which we can try to wake a task which has already
+ * started to run but is not in state TASK_RUNNING.  try_to_wake_up() returns
+ * zero in this (rare) case, and we handle it by continuing to scan the queue.
+ */
+static void __wake_up_common(wait_queue_head_t *q, unsigned int mode,
+			     int nr_exclusive, int sync, void *key)
+{
+	struct list_head *tmp, *next;
+
+	list_for_each_safe(tmp, next, &q->task_list) {
+		wait_queue_t *curr;
+		unsigned flags;
+		curr = list_entry(tmp, wait_queue_t, task_list);
+		flags = curr->flags;
+		if (curr->func(curr, mode, sync, key) &&
+		    (flags & WQ_FLAG_EXCLUSIVE) &&
+		    !--nr_exclusive)
+			break;
+	}
+}
+
+/**
+ * __wake_up - wake up threads blocked on a waitqueue.
+ * @q: the waitqueue
+ * @mode: which threads
+ * @nr_exclusive: how many wake-one or wake-many threads to wake up
+ */
+void fastcall __wake_up(wait_queue_head_t *q, unsigned int mode,
+				int nr_exclusive, void *key)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&q->lock, flags);
+	__wake_up_common(q, mode, nr_exclusive, 0, key);
+	spin_unlock_irqrestore(&q->lock, flags);
+}
+EXPORT_SYMBOL(__wake_up);
+
+int default_wake_function(wait_queue_t *curr, unsigned mode, int sync, void *key)
+{
+	task_t *p = curr->task;
+	return try_to_wake_up(p, mode, sync);
+}
+EXPORT_SYMBOL(default_wake_function);
+
+/*
+ * Same as __wake_up but called with the spinlock in wait_queue_head_t held.
+ */
+void fastcall __wake_up_locked(wait_queue_head_t *q, unsigned int mode)
+{
+	__wake_up_common(q, mode, 1, 0, NULL);
+}
+
+/**
+ * __wake_up - sync- wake up threads blocked on a waitqueue.
+ * @q: the waitqueue
+ * @mode: which threads
+ * @nr_exclusive: how many wake-one or wake-many threads to wake up
+ *
+ * The sync wakeup differs that the waker knows that it will schedule
+ * away soon, so while the target thread will be woken up, it will not
+ * be migrated to another CPU - ie. the two threads are 'synchronized'
+ * with each other. This can prevent needless bouncing between CPUs.
+ *
+ * On UP it can prevent extra preemption.
+ */
+void fastcall __wake_up_sync(wait_queue_head_t *q, unsigned int mode, int nr_exclusive)
+{
+	unsigned long flags;
+	int sync = 1;
+
+	if (unlikely(!q))
+		return;
+
+	if (unlikely(!nr_exclusive))
+		sync = 0;
+
+	spin_lock_irqsave(&q->lock, flags);
+	__wake_up_common(q, mode, nr_exclusive, sync, NULL);
+	spin_unlock_irqrestore(&q->lock, flags);
+}
+EXPORT_SYMBOL_GPL(__wake_up_sync);	/* For internal use only */
+
+void fastcall complete(struct completion *x)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&x->wait.lock, flags);
+	x->done++;
+	__wake_up_common(&x->wait, TASK_UNINTERRUPTIBLE | TASK_INTERRUPTIBLE,
+			 1, 0, NULL);
+	spin_unlock_irqrestore(&x->wait.lock, flags);
+}
+EXPORT_SYMBOL(complete);
+
+void fastcall complete_all(struct completion *x)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&x->wait.lock, flags);
+	x->done += UINT_MAX/2;
+	__wake_up_common(&x->wait, TASK_UNINTERRUPTIBLE | TASK_INTERRUPTIBLE,
+			 0, 0, NULL);
+	spin_unlock_irqrestore(&x->wait.lock, flags);
+}
+EXPORT_SYMBOL(complete_all);
+
 extern struct sched_drv ingo_sched_drv;
 static const struct sched_drv *scheduler = &ingo_sched_drv;
 
+void fastcall __sched wait_for_completion(struct completion *x)
+{
+	scheduler->wait_for_completion(x);
+}
+
 void sched_idle_next(void)
 {
 	scheduler->sched_idle_next();


--------------050208060305010003060809--

--------------enig705F7E65B0F1BAC27CB7E323
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBg6eQZUg7+tp6mRURAhFZAJ99qq6eMSmtdInrdT8DEHgK0lmqmACeMC3u
qEo8Pe/7kuyTjVycRQSLHuE=
=MGx2
-----END PGP SIGNATURE-----

--------------enig705F7E65B0F1BAC27CB7E323--
