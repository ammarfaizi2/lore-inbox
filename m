Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261245AbVAVJww@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261245AbVAVJww (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jan 2005 04:52:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262685AbVAVJww
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jan 2005 04:52:52 -0500
Received: from yacht.ocn.ne.jp ([222.146.40.168]:38136 "EHLO
	smtp.yacht.ocn.ne.jp") by vger.kernel.org with ESMTP
	id S261245AbVAVJwY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jan 2005 04:52:24 -0500
From: Akinobu Mita <amgta@yacht.ocn.ne.jp>
To: <linux-kernel@vger.kernel.org>
Subject: [PATCH] oprofile: falling back on timer interrupt mode
Date: Sat, 22 Jan 2005 18:55:05 +0900
User-Agent: KMail/1.5.4
Cc: "Andrew Morton" <akpm@osdl.org>, Greg Banks <gnb@sgi.com>,
       John Levon <levon@movementarian.org>,
       Philippe Elie <phil.el@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501221855.05214.amgta@yacht.ocn.ne.jp>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

When some hardware setups or architectures do not allow OProfile to use
performance counters, OProfile operates in timer mode.

But, from 2.6.11-rc1, we need to specify the module parameter "timer=1"
to work on timer interrupt mode.  Furthermore we can easily get oops by
reading /dev/oprofile/cpu_type.

Signed-off-by: Akinobu Mita <amgta@yacht.ocn.ne.jp>

 arch/alpha/oprofile/common.c     |    6 ++++--
 arch/arm/oprofile/common.c       |    7 +++++--
 arch/arm/oprofile/init.c         |    8 ++++++--
 arch/i386/oprofile/init.c        |    4 +++-
 arch/ia64/oprofile/init.c        |    8 ++++++--
 arch/m32r/oprofile/init.c        |    3 ++-
 arch/parisc/oprofile/init.c      |    3 ++-
 arch/ppc64/oprofile/common.c     |    6 ++++--
 arch/s390/oprofile/init.c        |    3 ++-
 arch/sh/oprofile/op_model_null.c |    3 ++-
 arch/sparc64/oprofile/init.c     |    3 ++-
 drivers/oprofile/oprof.c         |    6 +++---
 include/linux/oprofile.h         |    2 +-
 13 files changed, 42 insertions(+), 20 deletions(-)


diff -rup 2.6-bk.orig/arch/alpha/oprofile/common.c 2.6-bk/arch/alpha/oprofile/common.c
--- 2.6-bk.orig/arch/alpha/oprofile/common.c	2005-01-15 16:01:59.000000000 +0900
+++ 2.6-bk/arch/alpha/oprofile/common.c	2005-01-15 16:16:16.000000000 +0900
@@ -138,7 +138,7 @@ op_axp_create_files(struct super_block *
 	return 0;
 }
 
-void __init
+int __init
 oprofile_arch_init(struct oprofile_operations *ops)
 {
 	struct op_axp_model *lmodel = NULL;
@@ -166,7 +166,7 @@ oprofile_arch_init(struct oprofile_opera
 	}
 
 	if (!lmodel)
-		return;
+		return -ENODEV;
 	model = lmodel;
 
 	ops->create_files = op_axp_create_files;
@@ -178,6 +178,8 @@ oprofile_arch_init(struct oprofile_opera
 
 	printk(KERN_INFO "oprofile: using %s performance monitoring.\n",
 	       lmodel->cpu_type);
+
+	return 0;
 }
 
 
diff -rup 2.6-bk.orig/arch/arm/oprofile/common.c 2.6-bk/arch/arm/oprofile/common.c
--- 2.6-bk.orig/arch/arm/oprofile/common.c	2005-01-15 16:02:03.000000000 +0900
+++ 2.6-bk/arch/arm/oprofile/common.c	2005-01-15 16:33:03.000000000 +0900
@@ -105,12 +105,13 @@ static void pmu_stop(void)
 	up(&pmu_sem);
 }
 
-void __init pmu_init(struct oprofile_operations *ops, struct op_arm_model_spec *spec)
+int __init
+pmu_init(struct oprofile_operations *ops, struct op_arm_model_spec *spec)
 {
 	init_MUTEX(&pmu_sem);
 
 	if (spec->init() < 0)
-		return;
+		return -ENODEV;
 
 	pmu_model = spec;
 	init_driverfs();
@@ -121,6 +122,8 @@ void __init pmu_init(struct oprofile_ope
 	ops->stop = pmu_stop;
 	ops->cpu_type = pmu_model->name;
 	printk(KERN_INFO "oprofile: using %s PMU\n", spec->name);
+
+	return 0;
 }
 
 void pmu_exit(void)
diff -rup 2.6-bk.orig/arch/arm/oprofile/init.c 2.6-bk/arch/arm/oprofile/init.c
--- 2.6-bk.orig/arch/arm/oprofile/init.c	2005-01-15 16:02:03.000000000 +0900
+++ 2.6-bk/arch/arm/oprofile/init.c	2005-01-15 16:33:42.000000000 +0900
@@ -12,11 +12,15 @@
 #include <linux/errno.h>
 #include "op_arm_model.h"
 
-void __init oprofile_arch_init(struct oprofile_operations *ops)
+int __init oprofile_arch_init(struct oprofile_operations *ops)
 {
+	int ret = -ENODEV;
+
 #ifdef CONFIG_CPU_XSCALE
-	pmu_init(ops, &op_xscale_spec);
+	ret = pmu_init(ops, &op_xscale_spec);
 #endif
+
+	return ret;
 }
 
 void oprofile_arch_exit(void)
diff -rup 2.6-bk.orig/arch/i386/oprofile/init.c 2.6-bk/arch/i386/oprofile/init.c
--- 2.6-bk.orig/arch/i386/oprofile/init.c	2005-01-15 16:01:39.000000000 +0900
+++ 2.6-bk/arch/i386/oprofile/init.c	2005-01-15 16:07:27.000000000 +0900
@@ -21,7 +21,7 @@ extern void nmi_exit(void);
 extern void x86_backtrace(struct pt_regs * const regs, unsigned int depth);
 
 
-void __init oprofile_arch_init(struct oprofile_operations * ops)
+int __init oprofile_arch_init(struct oprofile_operations * ops)
 {
 	int ret;
 
@@ -35,6 +35,8 @@ void __init oprofile_arch_init(struct op
 		ret = nmi_timer_init(ops);
 #endif
 	ops->backtrace = x86_backtrace;
+
+	return ret;
 }
 
 
diff -rup 2.6-bk.orig/arch/ia64/oprofile/init.c 2.6-bk/arch/ia64/oprofile/init.c
--- 2.6-bk.orig/arch/ia64/oprofile/init.c	2005-01-15 16:01:58.000000000 +0900
+++ 2.6-bk/arch/ia64/oprofile/init.c	2005-01-15 16:23:49.000000000 +0900
@@ -16,13 +16,17 @@ extern int perfmon_init(struct oprofile_
 extern void perfmon_exit(void);
 extern void ia64_backtrace(struct pt_regs * const regs, unsigned int depth);
 
-void __init oprofile_arch_init(struct oprofile_operations * ops)
+int __init oprofile_arch_init(struct oprofile_operations * ops)
 {
+	int ret = -ENODEV;
+
 #ifdef CONFIG_PERFMON
 	/* perfmon_init() can fail, but we have no way to report it */
-	perfmon_init(ops);
+	ret = perfmon_init(ops);
 #endif
 	ops->backtrace = ia64_backtrace;
+
+	return ret;
 }
 
 
diff -rup 2.6-bk.orig/arch/m32r/oprofile/init.c 2.6-bk/arch/m32r/oprofile/init.c
--- 2.6-bk.orig/arch/m32r/oprofile/init.c	2005-01-15 16:02:07.000000000 +0900
+++ 2.6-bk/arch/m32r/oprofile/init.c	2005-01-15 16:24:23.000000000 +0900
@@ -12,8 +12,9 @@
 #include <linux/errno.h>
 #include <linux/init.h>
 
-void __init oprofile_arch_init(struct oprofile_operations * ops)
+int __init oprofile_arch_init(struct oprofile_operations * ops)
 {
+	return -ENODEV;
 }
 
 void oprofile_arch_exit(void)
diff -rup 2.6-bk.orig/arch/parisc/oprofile/init.c 2.6-bk/arch/parisc/oprofile/init.c
--- 2.6-bk.orig/arch/parisc/oprofile/init.c	2005-01-15 16:02:04.000000000 +0900
+++ 2.6-bk/arch/parisc/oprofile/init.c	2005-01-15 16:24:59.000000000 +0900
@@ -12,8 +12,9 @@
 #include <linux/kernel.h>
 #include <linux/oprofile.h>
 
-void __init oprofile_arch_init(struct oprofile_operations * ops)
+int __init oprofile_arch_init(struct oprofile_operations * ops)
 {
+	return -ENODEV;
 }
 
 
diff -rup 2.6-bk.orig/arch/ppc64/oprofile/common.c 2.6-bk/arch/ppc64/oprofile/common.c
--- 2.6-bk.orig/arch/ppc64/oprofile/common.c	2005-01-15 16:02:00.000000000 +0900
+++ 2.6-bk/arch/ppc64/oprofile/common.c	2005-01-15 16:26:01.000000000 +0900
@@ -125,7 +125,7 @@ static int op_ppc64_create_files(struct 
 	return 0;
 }
 
-void __init oprofile_arch_init(struct oprofile_operations *ops)
+int __init oprofile_arch_init(struct oprofile_operations *ops)
 {
 	unsigned int pvr;
 
@@ -170,7 +170,7 @@ void __init oprofile_arch_init(struct op
 			break;
 
 		default:
-			return;
+			return -ENODEV;
 	}
 
 	ops->create_files = op_ppc64_create_files;
@@ -181,6 +181,8 @@ void __init oprofile_arch_init(struct op
 
 	printk(KERN_INFO "oprofile: using %s performance monitoring.\n",
 	       ops->cpu_type);
+
+	return 0;
 }
 
 void oprofile_arch_exit(void)
diff -rup 2.6-bk.orig/arch/s390/oprofile/init.c 2.6-bk/arch/s390/oprofile/init.c
--- 2.6-bk.orig/arch/s390/oprofile/init.c	2005-01-15 16:02:06.000000000 +0900
+++ 2.6-bk/arch/s390/oprofile/init.c	2005-01-15 16:26:19.000000000 +0900
@@ -12,8 +12,9 @@
 #include <linux/init.h>
 #include <linux/errno.h>
 
-void __init oprofile_arch_init(struct oprofile_operations* ops)
+int __init oprofile_arch_init(struct oprofile_operations* ops)
 {
+	return -ENODEV;
 }
 
 void oprofile_arch_exit(void)
diff -rup 2.6-bk.orig/arch/sh/oprofile/op_model_null.c 2.6-bk/arch/sh/oprofile/op_model_null.c
--- 2.6-bk.orig/arch/sh/oprofile/op_model_null.c	2005-01-15 16:01:52.000000000 +0900
+++ 2.6-bk/arch/sh/oprofile/op_model_null.c	2005-01-15 16:26:41.000000000 +0900
@@ -12,8 +12,9 @@
 #include <linux/init.h>
 #include <linux/errno.h>
 
-void __init oprofile_arch_init(struct oprofile_operations *ops)
+int __init oprofile_arch_init(struct oprofile_operations *ops)
 {
+	return -ENODEV;
 }
 
 void oprofile_arch_exit(void)
diff -rup 2.6-bk.orig/arch/sparc64/oprofile/init.c 2.6-bk/arch/sparc64/oprofile/init.c
--- 2.6-bk.orig/arch/sparc64/oprofile/init.c	2005-01-15 16:01:40.000000000 +0900
+++ 2.6-bk/arch/sparc64/oprofile/init.c	2005-01-15 16:27:14.000000000 +0900
@@ -12,8 +12,9 @@
 #include <linux/errno.h>
 #include <linux/init.h>
  
-void __init oprofile_arch_init(struct oprofile_operations * ops)
+int __init oprofile_arch_init(struct oprofile_operations * ops)
 {
+	return -ENODEV;
 }
 
 
diff -rup 2.6-bk.orig/drivers/oprofile/oprof.c 2.6-bk/drivers/oprofile/oprof.c
--- 2.6-bk.orig/drivers/oprofile/oprof.c	2005-01-15 16:02:50.000000000 +0900
+++ 2.6-bk/drivers/oprofile/oprof.c	2005-01-15 16:14:58.000000000 +0900
@@ -153,11 +153,11 @@ out:
 
 static int __init oprofile_init(void)
 {
-	int err = 0;
+	int err;
 
-	oprofile_arch_init(&oprofile_ops);
+	err = oprofile_arch_init(&oprofile_ops);
 
-	if (timer) {
+	if (err < 0 || timer) {
 		printk(KERN_INFO "oprofile: using timer interrupt.\n");
 		oprofile_timer_init(&oprofile_ops);
 	}
diff -rup 2.6-bk.orig/include/linux/oprofile.h 2.6-bk/include/linux/oprofile.h
--- 2.6-bk.orig/include/linux/oprofile.h	2005-01-15 16:03:21.000000000 +0900
+++ 2.6-bk/include/linux/oprofile.h	2005-01-15 16:06:27.000000000 +0900
@@ -48,7 +48,7 @@ struct oprofile_operations {
  *
  * If an error occurs, the fields should be left untouched.
  */
-void oprofile_arch_init(struct oprofile_operations * ops);
+int oprofile_arch_init(struct oprofile_operations * ops);
  
 /**
  * One-time exit/cleanup for the arch.





