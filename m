Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261200AbUJ3PUc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261200AbUJ3PUc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 11:20:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261194AbUJ3PU1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 11:20:27 -0400
Received: from mail22.syd.optusnet.com.au ([211.29.133.160]:64192 "EHLO
	mail22.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261219AbUJ3OmM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 10:42:12 -0400
Message-ID: <4183A831.4020704@kolivas.org>
Date: Sun, 31 Oct 2004 00:41:53 +1000
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
Subject: [PATCH][plugsched 28/28] Make new sched_domains sysctls private
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig8C057B5761DF8C9BA6EFA7F4"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig8C057B5761DF8C9BA6EFA7F4
Content-Type: multipart/mixed;
 boundary="------------080106060605000709030005"

This is a multi-part message in MIME format.
--------------080106060605000709030005
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Make new sched_domains sysctls private


--------------080106060605000709030005
Content-Type: text/x-patch;
 name="privatise_domain_sysctls.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="privatise_domain_sysctls.diff"

Privatise the domain sysctl functions as they refer to runqueue structures
which may differ between schedulers.

Signed-off-by: Con Kolivas <kernel@kolivas.org>


Index: linux-2.6.10-rc1-mm2-plugsched1/include/linux/scheduler.h
===================================================================
--- linux-2.6.10-rc1-mm2-plugsched1.orig/include/linux/scheduler.h	2004-10-30 00:25:30.713684348 +1000
+++ linux-2.6.10-rc1-mm2-plugsched1/include/linux/scheduler.h	2004-10-30 00:28:48.232081876 +1000
@@ -10,6 +10,8 @@
  */
 struct sched_drv
 {
+	void (*init_sched_domain_sysctl)(void);
+	void (*destroy_sched_domain_sysctl)(void);
 	void (*account_steal_time)(struct task_struct *, cputime_t);
 	void (*account_system_time)(struct task_struct *, int, cputime_t);
 	void (*account_user_time)(struct task_struct *, cputime_t);
Index: linux-2.6.10-rc1-mm2-plugsched1/kernel/sched.c
===================================================================
--- linux-2.6.10-rc1-mm2-plugsched1.orig/kernel/sched.c	2004-10-30 00:25:30.715684028 +1000
+++ linux-2.6.10-rc1-mm2-plugsched1/kernel/sched.c	2004-10-30 00:25:31.031633479 +1000
@@ -4036,7 +4036,7 @@ static ctl_table *sd_alloc_ctl_cpu_table
 }
 
 static struct ctl_table_header *sd_sysctl_header;
-void init_sched_domain_sysctl()
+void ingo_init_sched_domain_sysctl(void)
 {
 	int i, cpu_num = num_online_cpus();
 	char buf[32];
@@ -4054,7 +4054,7 @@ void init_sched_domain_sysctl()
 	sd_sysctl_header = register_sysctl_table(sd_ctl_root, 0);
 }
 
-void destroy_sched_domain_sysctl()
+static void ingo_destroy_sched_domain_sysctl(void)
 {
 	int cpu, cpu_num = num_online_cpus();
 	struct sched_domain *sd;
@@ -4076,15 +4076,17 @@ void destroy_sched_domain_sysctl()
 	kfree(root);
 }
 #else
-void init_sched_domain_sysctl()
+static void ingo_init_sched_domain_sysctl()
 {
 }
-void destroy_sched_domain_sysctl()
+static void ingo_destroy_sched_domain_sysctl()
 {
 }
 #endif
 
 struct sched_drv ingo_sched_drv = {
+	.init_sched_domain_sysctl = ingo_init_sched_domain_sysctl,
+	.destroy_sched_domain_sysctl = ingo_destroy_sched_domain_sysctl,
 	.account_steal_time	= ingo_account_steal_time,
 	.account_system_time	= ingo_account_system_time,
 	.account_user_time	= ingo_account_user_time,
Index: linux-2.6.10-rc1-mm2-plugsched1/kernel/scheduler.c
===================================================================
--- linux-2.6.10-rc1-mm2-plugsched1.orig/kernel/scheduler.c	2004-10-30 00:26:06.424970765 +1000
+++ linux-2.6.10-rc1-mm2-plugsched1/kernel/scheduler.c	2004-10-30 00:29:12.255238106 +1000
@@ -993,6 +993,16 @@ static int __init scheduler_setup(char *
 
 __setup ("cpusched=", scheduler_setup);
 
+void init_sched_domain_sysctl(void)
+{
+	scheduler->init_sched_domain_sysctl();
+}
+
+void destroy_sched_domain_sysctl(void)
+{
+	scheduler->destroy_sched_domain_sysctl();
+}
+
 void account_steal_time(struct task_struct *p, cputime_t steal)
 {
 	scheduler->account_steal_time(p, steal);


--------------080106060605000709030005--

--------------enig8C057B5761DF8C9BA6EFA7F4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBg6gyZUg7+tp6mRURAnlKAJ4jk0BQ4ffkQXHgHfwKR8XyHAAYAACfebxF
6qtVhlWHNEd8EH/0Vg7dLEU=
=HxPw
-----END PGP SIGNATURE-----

--------------enig8C057B5761DF8C9BA6EFA7F4--
