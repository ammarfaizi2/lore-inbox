Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261183AbUJ3OjI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261183AbUJ3OjI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 10:39:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261197AbUJ3OjH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 10:39:07 -0400
Received: from mail07.syd.optusnet.com.au ([211.29.132.188]:23943 "EHLO
	mail07.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261183AbUJ3OhC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 10:37:02 -0400
Message-ID: <4183A700.2000308@kolivas.org>
Date: Sun, 31 Oct 2004 00:36:48 +1000
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Peter Williams <pwil3058@bigpond.net.au>,
       Alexander Nyberg <alexn@dsv.su.se>,
       William Lee Irwin III <wli@holomorphy.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>
Subject: [PATCH][plugsched 3/28] Make kick_process public
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig772710303A29B9EF7B086C58"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig772710303A29B9EF7B086C58
Content-Type: multipart/mixed;
 boundary="------------000001090405050102070001"

This is a multi-part message in MIME format.
--------------000001090405050102070001
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Make kick_process public


--------------000001090405050102070001
Content-Type: text/x-patch;
 name="publicise_kick_process.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="publicise_kick_process.diff"

kick_process is common code; move it to scheduler.c

Signed-off-by: Con Kolivas <kernel@kolivas.org>

Index: linux-2.6.10-rc1-mm2-plugsched1/kernel/sched.c
===================================================================
--- linux-2.6.10-rc1-mm2-plugsched1.orig/kernel/sched.c	2004-10-30 22:00:00.168344500 +1000
+++ linux-2.6.10-rc1-mm2-plugsched1/kernel/sched.c	2004-10-30 22:00:21.376964415 +1000
@@ -901,24 +901,6 @@ repeat:
 	task_rq_unlock(rq, &flags);
 }
 
-/***
- * kick_process - kick a running thread to enter/exit the kernel
- * @p: the to-be-kicked thread
- *
- * Cause a process which is running on another CPU to enter
- * kernel-mode, without any delay. (to get signals handled.)
- */
-void kick_process(task_t *p)
-{
-	int cpu;
-
-	preempt_disable();
-	cpu = task_cpu(p);
-	if ((cpu != smp_processor_id()) && task_curr(p))
-		smp_send_reschedule(cpu);
-	preempt_enable();
-}
-
 /*
  * Return a low guess at the load of a migration-source cpu.
  *
@@ -2618,38 +2600,6 @@ static inline int dependent_sleeper(int 
 }
 #endif
 
-#if defined(CONFIG_PREEMPT) && defined(CONFIG_DEBUG_PREEMPT)
-
-void fastcall add_preempt_count(int val)
-{
-	/*
-	 * Underflow?
-	 */
-	BUG_ON(((int)preempt_count() < 0));
-	preempt_count() += val;
-	/*
-	 * Spinlock count overflowing soon?
-	 */
-	BUG_ON((preempt_count() & PREEMPT_MASK) >= PREEMPT_MASK-10);
-}
-EXPORT_SYMBOL(add_preempt_count);
-
-void fastcall sub_preempt_count(int val)
-{
-	/*
-	 * Underflow?
-	 */
-	BUG_ON(val > preempt_count());
-	/*
-	 * Is the spinlock portion underflowing?
-	 */
-	BUG_ON((val < PREEMPT_MASK) && !(preempt_count() & PREEMPT_MASK));
-	preempt_count() -= val;
-}
-EXPORT_SYMBOL(sub_preempt_count);
-
-#endif
-
 /*
  * schedule() is the main scheduler function.
  */
@@ -2826,52 +2776,6 @@ switch_tasks:
 		goto need_resched;
 }
 
-#ifdef CONFIG_PREEMPT
-/*
- * this is is the entry point to schedule() from in-kernel preemption
- * off of preempt_enable.  Kernel preemptions off return from interrupt
- * occur there and call schedule directly.
- */
-asmlinkage void __sched preempt_schedule(void)
-{
-	struct thread_info *ti = current_thread_info();
-#ifdef CONFIG_PREEMPT_BKL
-	struct task_struct *task = current;
-	int saved_lock_depth;
-#endif
-	/*
-	 * If there is a non-zero preempt_count or interrupts are disabled,
-	 * we do not want to preempt the current task.  Just return..
-	 */
-	if (unlikely(ti->preempt_count || irqs_disabled()))
-		return;
-
-need_resched:
-	add_preempt_count(PREEMPT_ACTIVE);
-	/*
-	 * We keep the big kernel semaphore locked, but we
-	 * clear ->lock_depth so that schedule() doesnt
-	 * auto-release the semaphore:
-	 */
-#ifdef CONFIG_PREEMPT_BKL
-	saved_lock_depth = task->lock_depth;
-	task->lock_depth = -1;
-#endif
-	schedule();
-#ifdef CONFIG_PREEMPT_BKL
-	task->lock_depth = saved_lock_depth;
-#endif
-	sub_preempt_count(PREEMPT_ACTIVE);
-
-	/* we could miss a preemption opportunity between schedule and now */
-	barrier();
-	if (unlikely(test_thread_flag(TIF_NEED_RESCHED)))
-		goto need_resched;
-}
-
-EXPORT_SYMBOL(preempt_schedule);
-#endif /* CONFIG_PREEMPT */
-
 int default_wake_function(wait_queue_t *curr, unsigned mode, int sync, void *key)
 {
 	task_t *p = curr->task;
Index: linux-2.6.10-rc1-mm2-plugsched1/kernel/scheduler.c
===================================================================
--- linux-2.6.10-rc1-mm2-plugsched1.orig/kernel/scheduler.c	2004-10-30 21:59:47.308394011 +1000
+++ linux-2.6.10-rc1-mm2-plugsched1/kernel/scheduler.c	2004-10-30 22:00:21.377964256 +1000
@@ -43,6 +43,26 @@
 DEFINE_PER_CPU(struct kernel_stat, kstat);
 EXPORT_PER_CPU_SYMBOL(kstat);
 
+#ifdef CONFIG_SMP
+/***
+ * kick_process - kick a running thread to enter/exit the kernel
+ * @p: the to-be-kicked thread
+ *
+ * Cause a process which is running on another CPU to enter
+ * kernel-mode, without any delay. (to get signals handled.)
+ */
+void kick_process(task_t *p)
+{
+	int cpu;
+
+	preempt_disable();
+	cpu = task_cpu(p);
+	if ((cpu != smp_processor_id()) && task_curr(p))
+		smp_send_reschedule(cpu);
+	preempt_enable();
+}
+#endif
+
 extern struct sched_drv ingo_sched_drv;
 static const struct sched_drv *scheduler = &ingo_sched_drv;
 


--------------000001090405050102070001--

--------------enig772710303A29B9EF7B086C58
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBg6cAZUg7+tp6mRURAgmUAJ4+uaY9moJjp6N5iRkjvuwqv4yrmwCePja7
+js7+cEKS0fd8QVB06QhDrI=
=sxta
-----END PGP SIGNATURE-----

--------------enig772710303A29B9EF7B086C58--
