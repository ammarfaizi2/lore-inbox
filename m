Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261296AbUJ3Ppy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261296AbUJ3Ppy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 11:45:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261279AbUJ3Pim
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 11:38:42 -0400
Received: from mail20.syd.optusnet.com.au ([211.29.132.201]:33167 "EHLO
	mail20.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261187AbUJ3Oj7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 10:39:59 -0400
Message-ID: <4183A7B0.2010907@kolivas.org>
Date: Sun, 31 Oct 2004 00:39:44 +1000
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
Subject: [PATCH][plugsched 16/28] make rt_task private
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigBCEF6F77ACA9CBCA2F2AA77F"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigBCEF6F77ACA9CBCA2F2AA77F
Content-Type: multipart/mixed;
 boundary="------------070905060007080506020904"

This is a multi-part message in MIME format.
--------------070905060007080506020904
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

make rt_task private


--------------070905060007080506020904
Content-Type: text/x-patch;
 name="privatise_rt_task.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="privatise_rt_task.diff"

Scheduler designs may not identify real time tasks by their priority so
privatise the rt_task macro as a function.

Signed-off-by: Con Kolivas <kernel@kolivas.org>

Index: linux-2.6.10-rc1-mm2-plugsched1/include/linux/sched.h
===================================================================
--- linux-2.6.10-rc1-mm2-plugsched1.orig/include/linux/sched.h	2004-10-29 21:47:46.780525066 +1000
+++ linux-2.6.10-rc1-mm2-plugsched1/include/linux/sched.h	2004-10-29 21:47:49.047171325 +1000
@@ -345,7 +345,7 @@ struct signal_struct {
 
 #define MAX_PRIO		(MAX_RT_PRIO + 40)
 
-#define rt_task(p)		(unlikely((p)->prio < MAX_RT_PRIO))
+extern int rt_task(task_t *p);
 
 /*
  * Some day this will be a full-fledged user tracking system..
Index: linux-2.6.10-rc1-mm2-plugsched1/include/linux/scheduler.h
===================================================================
--- linux-2.6.10-rc1-mm2-plugsched1.orig/include/linux/scheduler.h	2004-10-29 21:47:15.473410961 +1000
+++ linux-2.6.10-rc1-mm2-plugsched1/include/linux/scheduler.h	2004-10-29 21:47:49.048171169 +1000
@@ -1,5 +1,6 @@
 struct sched_drv
 {
+	int (*rt_task)(task_t *);
 	void (*wait_for_completion)(struct completion *);
 	void (*io_schedule)(void);
 	long (*io_schedule_timeout)(long);
Index: linux-2.6.10-rc1-mm2-plugsched1/kernel/sched.c
===================================================================
--- linux-2.6.10-rc1-mm2-plugsched1.orig/kernel/sched.c	2004-10-29 21:47:38.395833609 +1000
+++ linux-2.6.10-rc1-mm2-plugsched1/kernel/sched.c	2004-10-29 21:47:49.050170857 +1000
@@ -292,6 +292,11 @@ static DEFINE_PER_CPU(struct runqueue, r
 #define task_rq(p)		cpu_rq(task_cpu(p))
 #define cpu_curr(cpu)		(cpu_rq(cpu)->curr)
 
+static int ingo_rt_task(task_t *p)
+{
+	return (unlikely((p)->prio < MAX_RT_PRIO));
+}
+
 /*
  * Default context-switch locking:
  */
@@ -4139,6 +4144,7 @@ void destroy_sched_domain_sysctl()
 #endif
 
 struct sched_drv ingo_sched_drv = {
+	.rt_task		= ingo_rt_task,
 	.wait_for_completion	= ingo_wait_for_completion,
 	.io_schedule		= ingo_io_schedule,
 	.io_schedule_timeout	= ingo_io_schedule_timeout,
Index: linux-2.6.10-rc1-mm2-plugsched1/kernel/scheduler.c
===================================================================
--- linux-2.6.10-rc1-mm2-plugsched1.orig/kernel/scheduler.c	2004-10-29 21:47:15.477410337 +1000
+++ linux-2.6.10-rc1-mm2-plugsched1/kernel/scheduler.c	2004-10-29 21:47:49.051170701 +1000
@@ -921,6 +921,11 @@ unsigned long nr_iowait(void)
 	return scheduler->nr_iowait();
 }
 
+int rt_task(task_t *task)
+{
+	return scheduler->rt_task(task);
+}
+
 int idle_cpu(int cpu)
 {
 	return scheduler->idle_cpu(cpu);


--------------070905060007080506020904--

--------------enigBCEF6F77ACA9CBCA2F2AA77F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBg6ewZUg7+tp6mRURAmyUAJ93sUwCuByiD2os1rnLhS5nIDCGRACfQt1L
PGMLjXOhBNtDJuEYmwxk7Io=
=1KQy
-----END PGP SIGNATURE-----

--------------enigBCEF6F77ACA9CBCA2F2AA77F--
