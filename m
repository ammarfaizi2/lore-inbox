Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261236AbUJ3Ovl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261236AbUJ3Ovl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 10:51:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261237AbUJ3OuH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 10:50:07 -0400
Received: from mail20.syd.optusnet.com.au ([211.29.132.201]:17035 "EHLO
	mail20.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261194AbUJ3OiT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 10:38:19 -0400
Message-ID: <4183A74B.7060507@kolivas.org>
Date: Sun, 31 Oct 2004 00:38:03 +1000
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
Subject: [PATCH][plugsched 8/28] Make conditional reschedule public
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig0E965AAB8D3DD08DF955799E"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig0E965AAB8D3DD08DF955799E
Content-Type: multipart/mixed;
 boundary="------------010409080103050609090101"

This is a multi-part message in MIME format.
--------------010409080103050609090101
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Make conditional reschedule public


--------------010409080103050609090101
Content-Type: text/x-patch;
 name="publicise_cond_resched.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="publicise_cond_resched.diff"

Move the conditional reschedule entries into the common code.

Signed-off-by: Con Kolivas <kernel@kolivas.org>


Index: linux-2.6.10-rc1-mm2-plugsched1/kernel/sched.c
===================================================================
--- linux-2.6.10-rc1-mm2-plugsched1.orig/kernel/sched.c	2004-10-29 21:46:58.463065654 +1000
+++ linux-2.6.10-rc1-mm2-plugsched1/kernel/sched.c	2004-10-29 21:47:01.213636390 +1000
@@ -3162,72 +3162,6 @@ static long ingo_sys_sched_yield(void)
 	return 0;
 }
 
-static inline void __cond_resched(void)
-{
-	do {
-		add_preempt_count(PREEMPT_ACTIVE);
-		schedule();
-		sub_preempt_count(PREEMPT_ACTIVE);
-	} while (need_resched());
-}
-
-int __sched cond_resched(void)
-{
-	if (need_resched()) {
-		__cond_resched();
-		return 1;
-	}
-	return 0;
-}
-
-EXPORT_SYMBOL(cond_resched);
-
-/*
- * cond_resched_lock() - if a reschedule is pending, drop the given lock,
- * call schedule, and on return reacquire the lock.
- *
- * This works OK both with and without CONFIG_PREEMPT.  We do strange low-level
- * operations here to prevent schedule() from being called twice (once via
- * spin_unlock(), once by hand).
- */
-int cond_resched_lock(spinlock_t * lock)
-{
-#if defined(CONFIG_SMP) && defined(CONFIG_PREEMPT)
-	if (lock->break_lock) {
-		lock->break_lock = 0;
-		spin_unlock(lock);
-		cpu_relax();
-		spin_lock(lock);
-	}
-#endif
-	if (need_resched()) {
-		_raw_spin_unlock(lock);
-		preempt_enable_no_resched();
-		__cond_resched();
-		spin_lock(lock);
-		return 1;
-	}
-	return 0;
-}
-
-EXPORT_SYMBOL(cond_resched_lock);
-
-int __sched cond_resched_softirq(void)
-{
-	BUG_ON(!in_softirq());
-
-	if (need_resched()) {
-		__local_bh_enable();
-		__cond_resched();
-		local_bh_disable();
-		return 1;
-	}
-	return 0;
-}
-
-EXPORT_SYMBOL(cond_resched_softirq);
-
-
 /**
  * yield - yield the current processor to other threads.
  *
Index: linux-2.6.10-rc1-mm2-plugsched1/kernel/scheduler.c
===================================================================
--- linux-2.6.10-rc1-mm2-plugsched1.orig/kernel/scheduler.c	2004-10-29 21:46:58.465065342 +1000
+++ linux-2.6.10-rc1-mm2-plugsched1/kernel/scheduler.c	2004-10-29 21:47:01.214636234 +1000
@@ -556,6 +556,71 @@ asmlinkage long sys_sched_get_priority_m
 	return ret;
 }
 
+static inline void __cond_resched(void)
+{
+	do {
+		add_preempt_count(PREEMPT_ACTIVE);
+		schedule();
+		sub_preempt_count(PREEMPT_ACTIVE);
+	} while (need_resched());
+}
+
+int __sched cond_resched(void)
+{
+	if (need_resched()) {
+		__cond_resched();
+		return 1;
+	}
+	return 0;
+}
+
+EXPORT_SYMBOL(cond_resched);
+
+/*
+ * cond_resched_lock() - if a reschedule is pending, drop the given lock,
+ * call schedule, and on return reacquire the lock.
+ *
+ * This works OK both with and without CONFIG_PREEMPT.  We do strange low-level
+ * operations here to prevent schedule() from being called twice (once via
+ * spin_unlock(), once by hand).
+ */
+int cond_resched_lock(spinlock_t * lock)
+{
+#if defined(CONFIG_SMP) && defined(CONFIG_PREEMPT)
+	if (lock->break_lock) {
+		lock->break_lock = 0;
+		spin_unlock(lock);
+		cpu_relax();
+		spin_lock(lock);
+	}
+#endif
+	if (need_resched()) {
+		_raw_spin_unlock(lock);
+		preempt_enable_no_resched();
+		__cond_resched();
+		spin_lock(lock);
+		return 1;
+	}
+	return 0;
+}
+
+EXPORT_SYMBOL(cond_resched_lock);
+
+int __sched cond_resched_softirq(void)
+{
+	BUG_ON(!in_softirq());
+
+	if (need_resched()) {
+		__local_bh_enable();
+		__cond_resched();
+		local_bh_disable();
+		return 1;
+	}
+	return 0;
+}
+
+EXPORT_SYMBOL(cond_resched_softirq);
+
 extern struct sched_drv ingo_sched_drv;
 static const struct sched_drv *scheduler = &ingo_sched_drv;
 


--------------010409080103050609090101--

--------------enig0E965AAB8D3DD08DF955799E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBg6dLZUg7+tp6mRURAljhAJ9awy3y86CAdMKq2QRLuulxY+iFFgCglO3y
P3Y8WeFt2zoNWtqHArmXIro=
=jaOa
-----END PGP SIGNATURE-----

--------------enig0E965AAB8D3DD08DF955799E--
