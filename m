Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261222AbUJ3PBN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261222AbUJ3PBN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 11:01:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261193AbUJ3OwL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 10:52:11 -0400
Received: from mail11.syd.optusnet.com.au ([211.29.132.192]:15578 "EHLO
	mail11.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261220AbUJ3Ol7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 10:41:59 -0400
Message-ID: <4183A827.70900@kolivas.org>
Date: Sun, 31 Oct 2004 00:41:43 +1000
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
Subject: [PATCH][plugsched 27/28] Make new timekeeping private
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigCB5C643439C7630C4E8F958E"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigCB5C643439C7630C4E8F958E
Content-Type: multipart/mixed;
 boundary="------------080409020101030106060604"

This is a multi-part message in MIME format.
--------------080409020101030106060604
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Make new timekeeping private


--------------080409020101030106060604
Content-Type: text/x-patch;
 name="privatise_timekeeping.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="privatise_timekeeping.diff"

Timekeeping is runqueue design dependant so privatise those functions.

Signed-off-by: Con Kolivas <kernel@kolivas.org>

Index: linux-2.6.10-rc1-mm2-plugsched1/include/linux/scheduler.h
===================================================================
--- linux-2.6.10-rc1-mm2-plugsched1.orig/include/linux/scheduler.h	2004-10-30 00:20:12.649569607 +1000
+++ linux-2.6.10-rc1-mm2-plugsched1/include/linux/scheduler.h	2004-10-30 00:20:15.476117429 +1000
@@ -10,6 +10,9 @@
  */
 struct sched_drv
 {
+	void (*account_steal_time)(struct task_struct *, cputime_t);
+	void (*account_system_time)(struct task_struct *, int, cputime_t);
+	void (*account_user_time)(struct task_struct *, cputime_t);
 	char cpusched_name[SCHED_NAME_MAX];
 	int (*rt_task)(task_t *);
 	void (*wait_for_completion)(struct completion *);
Index: linux-2.6.10-rc1-mm2-plugsched1/kernel/sched.c
===================================================================
--- linux-2.6.10-rc1-mm2-plugsched1.orig/kernel/sched.c	2004-10-30 00:20:12.651569288 +1000
+++ linux-2.6.10-rc1-mm2-plugsched1/kernel/sched.c	2004-10-30 00:20:15.477117269 +1000
@@ -2279,7 +2279,7 @@ static void check_rlimit(struct task_str
  * @hardirq_offset: the offset to subtract from hardirq_count()
  * @cputime: the cpu time spent in user space since the last update
  */
-void account_user_time(struct task_struct *p, cputime_t cputime)
+static void ingo_account_user_time(struct task_struct *p, cputime_t cputime)
 {
 	struct cpu_usage_stat *cpustat = &kstat_this_cpu.cpustat;
 	cputime64_t tmp;
@@ -2306,7 +2306,7 @@ void account_user_time(struct task_struc
  * @hardirq_offset: the offset to subtract from hardirq_count()
  * @cputime: the cpu time spent in kernel space since the last update
  */
-void account_system_time(struct task_struct *p, int hardirq_offset,
+static void ingo_account_system_time(struct task_struct *p, int hardirq_offset,
 			 cputime_t cputime)
 {
 	struct cpu_usage_stat *cpustat = &kstat_this_cpu.cpustat;
@@ -2339,7 +2339,7 @@ void account_system_time(struct task_str
  * @p: the process from which the cpu time has been stolen
  * @steal: the cpu time spent in involuntary wait
  */
-void account_steal_time(struct task_struct *p, cputime_t steal)
+static void ingo_account_steal_time(struct task_struct *p, cputime_t steal)
 {
 	struct cpu_usage_stat *cpustat = &kstat_this_cpu.cpustat;
 	cputime64_t steal64 = cputime_to_cputime64(steal);
@@ -4085,6 +4085,9 @@ void destroy_sched_domain_sysctl()
 #endif
 
 struct sched_drv ingo_sched_drv = {
+	.account_steal_time	= ingo_account_steal_time,
+	.account_system_time	= ingo_account_system_time,
+	.account_user_time	= ingo_account_user_time,
 	.cpusched_name		= "ingosched",
 	.rt_task		= ingo_rt_task,
 	.wait_for_completion	= ingo_wait_for_completion,
Index: linux-2.6.10-rc1-mm2-plugsched1/kernel/scheduler.c
===================================================================
--- linux-2.6.10-rc1-mm2-plugsched1.orig/kernel/scheduler.c	2004-10-30 00:20:12.652569128 +1000
+++ linux-2.6.10-rc1-mm2-plugsched1/kernel/scheduler.c	2004-10-30 00:20:15.479116949 +1000
@@ -993,6 +993,22 @@ static int __init scheduler_setup(char *
 
 __setup ("cpusched=", scheduler_setup);
 
+void account_steal_time(struct task_struct *p, cputime_t steal)
+{
+	scheduler->account_steal_time(p, steal);
+}
+
+void account_system_time(struct task_struct *p, int hardirq_offset,
+			 cputime_t cputime)
+{
+	scheduler->account_system_time(p, hardirq_offset, cputime);
+}
+
+void account_user_time(struct task_struct *p, cputime_t cputime)
+{
+	scheduler->account_user_time(p, cputime);
+}
+
 void fastcall __sched wait_for_completion(struct completion *x)
 {
 	scheduler->wait_for_completion(x);


--------------080409020101030106060604--

--------------enigCB5C643439C7630C4E8F958E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBg6gnZUg7+tp6mRURAhP9AJ0csgsC3IvaISNUg20gEGmOgRcrTACfUBpy
6MYhkcj8QgLBe5BCiQo42Kg=
=xvpP
-----END PGP SIGNATURE-----

--------------enigCB5C643439C7630C4E8F958E--
