Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261494AbUKIKpm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261494AbUKIKpm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 05:45:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261482AbUKIKoV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 05:44:21 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:38869 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261484AbUKIKkA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 05:40:00 -0500
Subject: [PATCH 6/11] oprofile: update arm for api changes
From: Greg Banks <gnb@melbourne.sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: OProfile List <oprofile-list@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-PVQdOZQDa4aqSR5msk2K"
Organization: Silicon Graphics Inc, Australian Software Group.
Message-Id: <1099996785.1985.791.camel@hole.melbourne.sgi.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Tue, 09 Nov 2004 21:39:45 +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-PVQdOZQDa4aqSR5msk2K
Content-Type: text/plain
Content-Transfer-Encoding: 7bit


-- 
Greg Banks, R&D Software Engineer, SGI Australian Software Group.
I don't speak for SGI.


--=-PVQdOZQDa4aqSR5msk2K
Content-Disposition: attachment; filename=oprofile-callgraph-arm
Content-Type: text/plain; name=oprofile-callgraph-arm; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

oprofile arm arch updates, including some internal
API changes.

Signed-off-by: John Levon <levon@movementarian.org>
Signed-off-by: Greg Banks <gnb@melbourne.sgi.com>
---

 arch/arm/oprofile/common.c          |   21 ++++++++-------------
 arch/arm/oprofile/init.c            |    7 ++-----
 arch/arm/oprofile/op_model_xscale.c |    5 ++---
 3 files changed, 12 insertions(+), 21 deletions(-)

Index: linux/arch/arm/oprofile/init.c
===================================================================
--- linux.orig/arch/arm/oprofile/init.c	2004-10-19 07:53:45.%N +1000
+++ linux/arch/arm/oprofile/init.c	2004-11-06 01:20:07.%N +1100
@@ -12,14 +12,11 @@
 #include <linux/errno.h>
 #include "op_arm_model.h"
 
-int __init oprofile_arch_init(struct oprofile_operations **ops)
+void __init oprofile_arch_init(struct oprofile_operations *ops)
 {
-	int ret = -ENODEV;
-
 #ifdef CONFIG_CPU_XSCALE
-	ret = pmu_init(ops, &op_xscale_spec);
+	pmu_init(ops, &op_xscale_spec);
 #endif
-	return ret;
 }
 
 void oprofile_arch_exit(void)
Index: linux/arch/arm/oprofile/op_model_xscale.c
===================================================================
--- linux.orig/arch/arm/oprofile/op_model_xscale.c	2004-10-19 07:54:31.%N +1000
+++ linux/arch/arm/oprofile/op_model_xscale.c	2004-11-06 01:20:07.%N +1100
@@ -343,8 +343,7 @@ static void inline __xsc2_check_ctrs(voi
 
 static irqreturn_t xscale_pmu_interrupt(int irq, void *arg, struct pt_regs *regs)
 {
-	unsigned long pc = profile_pc(regs);
-	int i, is_kernel = !user_mode(regs);
+	int i;
 	u32 pmnc;
 
 	if (pmu->id == PMU_XSC1)
@@ -357,7 +356,7 @@ static irqreturn_t xscale_pmu_interrupt(
 			continue;
 
 		write_counter(i, -(u32)results[i].reset_counter);
-		oprofile_add_sample(pc, is_kernel, i, smp_processor_id());
+		oprofile_add_sample(regs, i);
 		results[i].ovf--;
 	}
 
Index: linux/arch/arm/oprofile/common.c
===================================================================
--- linux.orig/arch/arm/oprofile/common.c	2004-10-19 07:55:07.%N +1000
+++ linux/arch/arm/oprofile/common.c	2004-11-06 01:20:07.%N +1100
@@ -24,14 +24,6 @@ static int pmu_setup(void);
 static void pmu_stop(void);
 static int pmu_create_files(struct super_block *, struct dentry *);
 
-static struct oprofile_operations pmu_ops = {
-	.create_files	= pmu_create_files,
-	.setup		= pmu_setup,
-	.shutdown	= pmu_stop,
-	.start		= pmu_start,
-	.stop		= pmu_stop,
-};
-
 #ifdef CONFIG_PM
 static struct sys_device device_oprofile = {
 	.id		= 0,
@@ -113,19 +105,22 @@ static void pmu_stop(void)
 	up(&pmu_sem);
 }
 
-int __init pmu_init(struct oprofile_operations **ops, struct op_arm_model_spec *spec)
+void __init pmu_init(struct oprofile_operations *ops, struct op_arm_model_spec *spec)
 {
 	init_MUTEX(&pmu_sem);
 
 	if (spec->init() < 0)
-		return -ENODEV;
+		return;
 
 	pmu_model = spec;
 	init_driverfs();
-	*ops = &pmu_ops;
-	pmu_ops.cpu_type = pmu_model->name;
+	ops->create_files = pmu_create_files;
+	ops->setup = pmu_setup;
+	ops->shutdown = pmu_stop;
+	ops->start = pmu_start;
+	ops->stop = pmu_stop;
+	ops->cpu_type = pmu_model->name;
 	printk(KERN_INFO "oprofile: using %s PMU\n", spec->name);
-	return 0;
 }
 
 void pmu_exit(void)

--=-PVQdOZQDa4aqSR5msk2K--

