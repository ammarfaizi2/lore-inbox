Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261230AbUJ3PNA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261230AbUJ3PNA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 11:13:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261209AbUJ3Org
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 10:47:36 -0400
Received: from mail06.syd.optusnet.com.au ([211.29.132.187]:56007 "EHLO
	mail06.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261196AbUJ3Oi7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 10:38:59 -0400
Message-ID: <4183A76F.9060700@kolivas.org>
Date: Sun, 31 Oct 2004 00:38:39 +1000
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
Subject: [PATCH][plugsched 10/28] Make io_schedule private
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig474D0528315717AA03B2B1EC"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig474D0528315717AA03B2B1EC
Content-Type: multipart/mixed;
 boundary="------------020407040204090201030500"

This is a multi-part message in MIME format.
--------------020407040204090201030500
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Make io_schedule private



--------------020407040204090201030500
Content-Type: text/x-patch;
 name="export_iowait.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="export_iowait.diff"

Make io_schedule and friends private to each scheduler as well.

Signed-off-by: Con Kolivas <kernel@kolivas.org>


Index: linux-2.6.10-rc1-mm2-plugsched1/include/linux/sched.h
===================================================================
--- linux-2.6.10-rc1-mm2-plugsched1.orig/include/linux/sched.h	2004-10-29 21:45:07.558373818 +1000
+++ linux-2.6.10-rc1-mm2-plugsched1/include/linux/sched.h	2004-10-29 21:47:05.007044378 +1000
@@ -165,9 +165,6 @@ extern void show_regs(struct pt_regs *);
  */
 extern void show_stack(struct task_struct *task, unsigned long *sp);
 
-void io_schedule(void);
-long io_schedule_timeout(long timeout);
-
 extern void cpu_init (void);
 extern void trap_init(void);
 extern void update_process_times(int user);
@@ -179,6 +176,9 @@ extern unsigned long cache_decay_ticks;
 /* Is this address in the __sched functions? */
 extern int in_sched_functions(unsigned long addr);
 
+void __sched io_schedule(void);
+long __sched io_schedule_timeout(long timeout);
+
 #define	MAX_SCHEDULE_TIMEOUT	LONG_MAX
 extern signed long FASTCALL(schedule_timeout(signed long timeout));
 asmlinkage void schedule(void);
Index: linux-2.6.10-rc1-mm2-plugsched1/include/linux/scheduler.h
===================================================================
--- linux-2.6.10-rc1-mm2-plugsched1.orig/include/linux/scheduler.h	2004-10-29 21:45:07.559373662 +1000
+++ linux-2.6.10-rc1-mm2-plugsched1/include/linux/scheduler.h	2004-10-29 21:47:05.007044378 +1000
@@ -1,5 +1,7 @@
 struct sched_drv
 {
+	void (*io_schedule)(void);
+	long (*io_schedule_timeout)(long);
 	void (*sched_idle_next)(void);
 	void (*set_oom_timeslice)(task_t *);
 	unsigned long (*nr_running)(void);
Index: linux-2.6.10-rc1-mm2-plugsched1/kernel/sched.c
===================================================================
--- linux-2.6.10-rc1-mm2-plugsched1.orig/kernel/sched.c	2004-10-29 21:47:03.114339760 +1000
+++ linux-2.6.10-rc1-mm2-plugsched1/kernel/sched.c	2004-10-29 21:47:05.009044066 +1000
@@ -3169,7 +3169,7 @@ static long ingo_sys_sched_yield(void)
  * But don't do that if it is a deliberate, throttling IO wait (this task
  * has set its backing_dev_info: the queue against which it should throttle)
  */
-void __sched io_schedule(void)
+static void __sched ingo_io_schedule(void)
 {
 	struct runqueue *rq = &per_cpu(runqueues, _smp_processor_id());
 
@@ -3178,9 +3178,7 @@ void __sched io_schedule(void)
 	atomic_dec(&rq->nr_iowait);
 }
 
-EXPORT_SYMBOL(io_schedule);
-
-long __sched io_schedule_timeout(long timeout)
+static long __sched ingo_io_schedule_timeout(long timeout)
 {
 	struct runqueue *rq = &per_cpu(runqueues, _smp_processor_id());
 	long ret;
@@ -4384,6 +4382,8 @@ void destroy_sched_domain_sysctl()
 #endif
 
 struct sched_drv ingo_sched_drv = {
+	.io_schedule		= ingo_io_schedule,
+	.io_schedule_timeout	= ingo_io_schedule_timeout,
 	.set_oom_timeslice	= ingo_set_oom_timeslice,
 	.nr_running		= ingo_nr_running,
 	.nr_uninterruptible	= ingo_nr_uninterruptible,
Index: linux-2.6.10-rc1-mm2-plugsched1/kernel/scheduler.c
===================================================================
--- linux-2.6.10-rc1-mm2-plugsched1.orig/kernel/scheduler.c	2004-10-29 21:47:03.115339604 +1000
+++ linux-2.6.10-rc1-mm2-plugsched1/kernel/scheduler.c	2004-10-29 21:47:05.010043910 +1000
@@ -643,6 +643,17 @@ void sched_idle_next(void)
 	scheduler->sched_idle_next();
 }
 
+void __sched io_schedule(void)
+{
+	scheduler->io_schedule();
+}
+EXPORT_SYMBOL(io_schedule);
+
+long __sched io_schedule_timeout(long timeout)
+{
+	return scheduler->io_schedule_timeout(timeout);
+}
+
 unsigned long nr_running(void)
 {
 	return scheduler->nr_running();


--------------020407040204090201030500--

--------------enig474D0528315717AA03B2B1EC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBg6dvZUg7+tp6mRURAhA3AJwLmAr3hq/S/EXTOMRONxAn5KnNBwCfcD6p
GxCE7zKea7JtV1qPS67eEqw=
=fGCZ
-----END PGP SIGNATURE-----

--------------enig474D0528315717AA03B2B1EC--
