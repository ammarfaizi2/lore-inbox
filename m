Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262020AbVBJEyu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262020AbVBJEyu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Feb 2005 23:54:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262021AbVBJEyu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Feb 2005 23:54:50 -0500
Received: from fsmlabs.com ([168.103.115.128]:30915 "EHLO fsmlabs.com")
	by vger.kernel.org with ESMTP id S262020AbVBJEyo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Feb 2005 23:54:44 -0500
Date: Wed, 9 Feb 2005 21:55:21 -0700 (MST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Linux Kernel <linux-kernel@vger.kernel.org>
cc: Andrew Morton <akpm@osdl.org>, John Levon <levon@movementarian.org>,
       Richard Purdie <rpurdie@rpsys.net>
Subject: [PATCH] OProfile: ARM/XScale1 PMU support fix
Message-ID: <Pine.LNX.4.61.0502092140010.26742@montezuma.fsmlabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard Purdie provided a patch to fix support for XScale1 processors 
(this is the PMU version i never had access to initially), we weren't 
clearing the overflow flags after an overflow interrupt had triggered 
resulting in no additional interrupts occuring. Additionally i've added 
basic power management support.

Signed-off-by: Zwane Mwaikambo <zwane@arm.linux.org.uk>

===== arch/arm/oprofile/op_arm_model.h 1.1 vs edited =====
--- 1.1/arch/arm/oprofile/op_arm_model.h	2004-04-12 11:55:34 -06:00
+++ edited/arch/arm/oprofile/op_arm_model.h	2005-02-08 23:02:20 -07:00
@@ -24,6 +24,6 @@ struct op_arm_model_spec {
 extern struct op_arm_model_spec op_xscale_spec;
 #endif
 
-extern int pmu_init(struct oprofile_operations **ops, struct op_arm_model_spec *spec);
+extern int __init pmu_init(struct oprofile_operations *ops, struct op_arm_model_spec *spec);
 extern void pmu_exit(void);
 #endif /* OP_ARM_MODEL_H */
===== arch/arm/oprofile/common.c 1.3 vs edited =====
--- 1.3/arch/arm/oprofile/common.c	2005-01-25 14:43:48 -07:00
+++ edited/arch/arm/oprofile/common.c	2005-02-08 23:00:50 -07:00
@@ -11,6 +11,7 @@
 #include <linux/oprofile.h>
 #include <linux/errno.h>
 #include <asm/semaphore.h>
+#include <linux/sysdev.h>
 
 #include "op_counter.h"
 #include "op_arm_model.h"
@@ -25,6 +26,26 @@ static void pmu_stop(void);
 static int pmu_create_files(struct super_block *, struct dentry *);
 
 #ifdef CONFIG_PM
+static int pmu_suspend(struct sys_device *dev, u32 state)
+{
+	if (pmu_enabled)
+		pmu_stop();
+	return 0;
+}
+
+static int pmu_resume(struct sys_device *dev)
+{
+	if (pmu_enabled)
+		pmu_start();
+	return 0;
+}
+
+static struct sysdev_class oprofile_sysclass = {
+	set_kset_name("oprofile"),
+	.resume		= pmu_resume,
+	.suspend	= pmu_suspend,
+};
+
 static struct sys_device device_oprofile = {
 	.id		= 0,
 	.cls		= &oprofile_sysclass,
@@ -35,14 +56,14 @@ static int __init init_driverfs(void)
 	int ret;
 
 	if (!(ret = sysdev_class_register(&oprofile_sysclass)))
-		ret = sys_device_register(&device_oprofile);
+		ret = sysdev_register(&device_oprofile);
 
 	return ret;
 }
 
-static void __exit exit_driverfs(void)
+static void  exit_driverfs(void)
 {
-	sys_device_unregister(&device_oprofile);
+	sysdev_unregister(&device_oprofile);
 	sysdev_class_unregister(&oprofile_sysclass);
 }
 #else
@@ -105,8 +126,7 @@ static void pmu_stop(void)
 	up(&pmu_sem);
 }
 
-int __init
-pmu_init(struct oprofile_operations *ops, struct op_arm_model_spec *spec)
+int __init pmu_init(struct oprofile_operations *ops, struct op_arm_model_spec *spec)
 {
 	init_MUTEX(&pmu_sem);
 
===== arch/arm/oprofile/op_model_xscale.c 1.7 vs edited =====
--- 1.7/arch/arm/oprofile/op_model_xscale.c	2005-01-04 19:48:24 -07:00
+++ edited/arch/arm/oprofile/op_model_xscale.c	2005-02-09 21:50:49 -07:00
@@ -42,6 +42,9 @@
 #ifdef CONFIG_ARCH_IOP331
 #define XSCALE_PMU_IRQ  IRQ_IOP331_CORE_PMU
 #endif
+#ifdef CONFIG_ARCH_PXA
+#define XSCALE_PMU_IRQ  IRQ_PMU
+#endif
 
 /*
  * Different types of events that can be counted by the XScale PMU
@@ -305,9 +308,9 @@ static void inline __xsc1_check_ctrs(voi
 	/*       Overflow bit gets cleared. There's no workaround.	 */
 	/*	 Fixed in B stepping or later			 	 */
 
-	pmnc &= ~(PMU_ENABLE | pmu->cnt_ovf[PMN0] | pmu->cnt_ovf[PMN1] |
-		pmu->cnt_ovf[CCNT]);
-	write_pmnc(pmnc);
+	/* Write the value back to clear the overflow flags. Overflow */
+	/* flags remain in pmnc for use below */
+	write_pmnc(pmnc & ~PMU_ENABLE);
 
 	for (i = CCNT; i <= PMN1; i++) {
 		if (!(pmu->int_mask[i] & pmu->int_enable))
