Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261225AbUJ3Onz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261225AbUJ3Onz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 10:43:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261209AbUJ3OkZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 10:40:25 -0400
Received: from mail11.syd.optusnet.com.au ([211.29.132.192]:55500 "EHLO
	mail11.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261188AbUJ3OhS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 10:37:18 -0400
Message-ID: <4183A70D.10109@kolivas.org>
Date: Sun, 31 Oct 2004 00:37:01 +1000
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       William Lee Irwin III <wli@holomorphy.com>,
       Alexander Nyberg <alexn@dsv.su.se>,
       Peter Williams <pwil3058@bigpond.net.au>,
       Nick Piggin <nickpiggin@yahoo.com.au>
Subject: [PATCH][plugsched 4/28] Make preempt functions public
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig6BB38CE2DA9D1314C6CC0341"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig6BB38CE2DA9D1314C6CC0341
Content-Type: multipart/mixed;
 boundary="------------050102050306060701020903"

This is a multi-part message in MIME format.
--------------050102050306060701020903
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Make preempt functions public



--------------050102050306060701020903
Content-Type: text/x-patch;
 name="publicise_preemptstuff.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="publicise_preemptstuff.diff"

Preempt functions are common and go in scheduler.c

Signed-off-by: Con Kolivas <kernel@kolivas.org>

Index: linux-2.6.10-rc1-mm2-plugsched1/kernel/scheduler.c
===================================================================
--- linux-2.6.10-rc1-mm2-plugsched1.orig/kernel/scheduler.c	2004-10-29 21:45:10.306944867 +1000
+++ linux-2.6.10-rc1-mm2-plugsched1/kernel/scheduler.c	2004-10-29 21:46:33.969888143 +1000
@@ -63,6 +63,84 @@ void kick_process(task_t *p)
 }
 #endif
 
+#ifdef CONFIG_PREEMPT
+#ifdef CONFIG_DEBUG_PREEMPT
+
+void fastcall add_preempt_count(int val)
+{
+	/*
+	 * Underflow?
+	 */
+	BUG_ON(((int)preempt_count() < 0));
+	preempt_count() += val;
+	/*
+	 * Spinlock count overflowing soon?
+	 */
+	BUG_ON((preempt_count() & PREEMPT_MASK) >= PREEMPT_MASK-10);
+}
+EXPORT_SYMBOL(add_preempt_count);
+
+void fastcall sub_preempt_count(int val)
+{
+	/*
+	 * Underflow?
+	 */
+	BUG_ON(val > preempt_count());
+	/*
+	 * Is the spinlock portion underflowing?
+	 */
+	BUG_ON((val < PREEMPT_MASK) && !(preempt_count() & PREEMPT_MASK));
+	preempt_count() -= val;
+}
+EXPORT_SYMBOL(sub_preempt_count);
+
+#endif
+
+/*
+ * this is is the entry point to schedule() from in-kernel preemption
+ * off of preempt_enable.  Kernel preemptions off return from interrupt
+ * occur there and call schedule directly.
+ */
+asmlinkage void __sched preempt_schedule(void)
+{
+	struct thread_info *ti = current_thread_info();
+#ifdef CONFIG_PREEMPT_BKL
+	struct task_struct *task = current;
+	int saved_lock_depth;
+#endif
+	/*
+	 * If there is a non-zero preempt_count or interrupts are disabled,
+	 * we do not want to preempt the current task.  Just return..
+	 */
+	if (unlikely(ti->preempt_count || irqs_disabled()))
+		return;
+
+need_resched:
+	add_preempt_count(PREEMPT_ACTIVE);
+	/*
+	 * We keep the big kernel semaphore locked, but we
+	 * clear ->lock_depth so that schedule() doesnt
+	 * auto-release the semaphore:
+	 */
+#ifdef CONFIG_PREEMPT_BKL
+	saved_lock_depth = task->lock_depth;
+	task->lock_depth = -1;
+#endif
+	schedule();
+#ifdef CONFIG_PREEMPT_BKL
+	task->lock_depth = saved_lock_depth;
+#endif
+	sub_preempt_count(PREEMPT_ACTIVE);
+
+	/* we could miss a preemption opportunity between schedule and now */
+	barrier();
+	if (unlikely(test_thread_flag(TIF_NEED_RESCHED)))
+		goto need_resched;
+}
+
+EXPORT_SYMBOL(preempt_schedule);
+#endif /* CONFIG_PREEMPT */
+
 extern struct sched_drv ingo_sched_drv;
 static const struct sched_drv *scheduler = &ingo_sched_drv;
 



--------------050102050306060701020903--

--------------enig6BB38CE2DA9D1314C6CC0341
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBg6cNZUg7+tp6mRURAr5vAJwMVzZQPGqnkVZTyBC/7KUd6iQgWACfbnnL
7XvaczV0YrvFoJTpZxECGwg=
=bv1l
-----END PGP SIGNATURE-----

--------------enig6BB38CE2DA9D1314C6CC0341--
