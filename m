Return-Path: <linux-kernel-owner+willy=40w.ods.org-S277145AbUKAQg7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S277145AbUKAQg7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 11:36:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S277049AbUKAQgf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 11:36:35 -0500
Received: from yacht.ocn.ne.jp ([222.146.40.168]:56296 "EHLO
	smtp.yacht.ocn.ne.jp") by vger.kernel.org with ESMTP
	id S270313AbUKAQb0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 11:31:26 -0500
From: Akinobu Mita <amgta@yacht.ocn.ne.jp>
To: Andrew Morton <akpm@osdl.org>, William Lee Irwin III <wli@holomorphy.com>
Subject: subj: [PATHC] user-defined profiling 
Date: Tue, 2 Nov 2004 01:33:53 +0900
User-Agent: KMail/1.5.4
Cc: <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411020133.53562.amgta@yacht.ocn.ne.jp>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This patch provides support for user-defined profiling. It is
inspired by scheduler profiling.

If you put the following code into interesting function

	profile_hit(USR_PROFILNG, __buildin_return_address(0));

and boot with profile=user then the readprofile shows which functions
called it, and how many times.

Furthermore I much prefer to insert the user-defined profile point
with Kprobe. This is why the profile_hits() was exported.

Please apply.

Signed-off-by Akinobu Mita <amgta@yacht.ocn.ne.jp>


--- 2.6-mm/Documentation/kernel-parameters.txt.orig	2004-11-02 01:17:50.491934664 +0900
+++ 2.6-mm/Documentation/kernel-parameters.txt	2004-11-02 01:18:47.552260176 +0900
@@ -1002,8 +1002,9 @@ running once the system is up.
 			Ranges are in pairs (memory base and size).
 
 	profile=	[KNL] Enable kernel profiling via /proc/profile
-			{ schedule | <number> }
+			{ schedule | user| <number> }
 			(param: schedule - profile schedule points}
+			(param: user - profile user-defined points}
 			(param: profile step/bucket size as a power of 2 for
 				statistical time based profiling)
 
--- 2.6-mm/include/linux/profile.h.orig	2004-11-02 01:18:40.740295752 +0900
+++ 2.6-mm/include/linux/profile.h	2004-11-02 01:18:47.538262304 +0900
@@ -11,6 +11,7 @@
 
 #define CPU_PROFILING	1
 #define SCHED_PROFILING	2
+#define USR_PROFILING	3
 
 struct proc_dir_entry;
 struct pt_regs;
--- 2.6-mm/kernel/profile.c.orig	2004-11-02 01:18:27.490310056 +0900
+++ 2.6-mm/kernel/profile.c	2004-11-02 01:18:47.550260480 +0900
@@ -47,18 +47,26 @@ static DECLARE_MUTEX(profile_flip_mutex)
 static int __init profile_setup(char * str)
 {
 	int par;
+	char *desc;
 
 	if (!strncmp(str, "schedule", 8)) {
 		prof_on = SCHED_PROFILING;
-		printk(KERN_INFO "kernel schedule profiling enabled\n");
-		if (str[7] == ',')
-			str += 8;
+		desc = "schedule";
+		str += 8;
+	} else if (!strncmp(str, "user", 4)) {
+		prof_on = USR_PROFILING;
+		desc = "user-defined";
+		str += 4;
+
+	} else {
+		prof_on = CPU_PROFILING;
+		desc = "";
 	}
+
 	if (get_option(&str,&par)) {
 		prof_shift = par;
-		prof_on = CPU_PROFILING;
-		printk(KERN_INFO "kernel profiling enabled (shift: %ld)\n",
-			prof_shift);
+		printk(KERN_INFO "kernel %s profiling enabled (shift: %ld)\n",
+			desc, prof_shift);
 	}
 	return 1;
 }
@@ -392,6 +400,8 @@ void profile_hit(int type, void *__pc)
 }
 #endif /* !CONFIG_SMP */
 
+EXPORT_SYMBOL_GPL(profile_hit);
+
 void profile_tick(int type, struct pt_regs *regs)
 {
 	if (type == CPU_PROFILING)




