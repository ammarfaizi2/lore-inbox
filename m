Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261492AbUKIKyf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261492AbUKIKyf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 05:54:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261477AbUKIKnb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 05:43:31 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:25495 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261487AbUKIKkW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 05:40:22 -0500
Subject: [PATCH 7/11] oprofile: update ppc for api changes
From: Greg Banks <gnb@melbourne.sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: OProfile List <oprofile-list@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-C2DW4+HLwegbYmDhyR9v"
Organization: Silicon Graphics Inc, Australian Software Group.
Message-Id: <1099996810.1985.793.camel@hole.melbourne.sgi.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Tue, 09 Nov 2004 21:40:10 +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-C2DW4+HLwegbYmDhyR9v
Content-Type: text/plain
Content-Transfer-Encoding: 7bit


-- 
Greg Banks, R&D Software Engineer, SGI Australian Software Group.
I don't speak for SGI.


--=-C2DW4+HLwegbYmDhyR9v
Content-Disposition: attachment; filename=oprofile-callgraph-ppc64
Content-Type: text/plain; name=oprofile-callgraph-ppc64; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

oprofile ppc64 arch updates, including some internal
API changes.

Signed-off-by: John Levon <levon@movementarian.org>
Signed-off-by: Greg Banks <gnb@melbourne.sgi.com>
---

 arch/ppc64/oprofile/common.c          |   33 +++++++++++++--------------------
 arch/ppc64/oprofile/op_model_power4.c |    3 +--
 arch/ppc64/oprofile/op_model_rs64.c   |    3 +--
 3 files changed, 15 insertions(+), 24 deletions(-)

Index: linux/arch/ppc64/oprofile/op_model_rs64.c
===================================================================
--- linux.orig/arch/ppc64/oprofile/op_model_rs64.c	2004-10-19 07:55:18.%N +1000
+++ linux/arch/ppc64/oprofile/op_model_rs64.c	2004-11-06 01:21:09.%N +1100
@@ -180,7 +180,6 @@ static void rs64_handle_interrupt(struct
 	int i;
 	unsigned long pc = mfspr(SPRN_SIAR);
 	int is_kernel = (pc >= KERNELBASE);
-	unsigned int cpu = smp_processor_id();
 
 	/* set the PMM bit (see comment below) */
 	mtmsrd(mfmsr() | MSR_PMM);
@@ -189,7 +188,7 @@ static void rs64_handle_interrupt(struct
 		val = ctr_read(i);
 		if (val < 0) {
 			if (ctr[i].enabled) {
-				oprofile_add_sample(pc, is_kernel, i, cpu);
+				oprofile_add_pc(pc, is_kernel, i);
 				ctr_write(i, reset_value[i]);
 			} else {
 				ctr_write(i, 0);
Index: linux/arch/ppc64/oprofile/common.c
===================================================================
--- linux.orig/arch/ppc64/oprofile/common.c	2004-11-06 01:11:47.%N +1100
+++ linux/arch/ppc64/oprofile/common.c	2004-11-06 01:21:09.%N +1100
@@ -125,16 +125,7 @@ static int op_ppc64_create_files(struct 
 	return 0;
 }
 
-static struct oprofile_operations oprof_ppc64_ops = {
-	.create_files	= op_ppc64_create_files,
-	.setup		= op_ppc64_setup,
-	.shutdown	= op_ppc64_shutdown,
-	.start		= op_ppc64_start,
-	.stop		= op_ppc64_stop,
-	.cpu_type	= NULL		/* To be filled in below. */
-};
-
-int __init oprofile_arch_init(struct oprofile_operations **ops)
+void __init oprofile_arch_init(struct oprofile_operations *ops)
 {
 	unsigned int pvr;
 
@@ -145,7 +136,7 @@ int __init oprofile_arch_init(struct opr
 		case PV_630p:
 			model = &op_model_rs64;
 			model->num_counters = 8;
-			oprof_ppc64_ops.cpu_type = "ppc64/power3";
+			ops->cpu_type = "ppc64/power3";
 			break;
 
 		case PV_NORTHSTAR:
@@ -154,40 +145,42 @@ int __init oprofile_arch_init(struct opr
 		case PV_SSTAR:
 			model = &op_model_rs64;
 			model->num_counters = 8;
-			oprof_ppc64_ops.cpu_type = "ppc64/rs64";
+			ops->cpu_type = "ppc64/rs64";
 			break;
 
 		case PV_POWER4:
 		case PV_POWER4p:
 			model = &op_model_power4;
 			model->num_counters = 8;
-			oprof_ppc64_ops.cpu_type = "ppc64/power4";
+			ops->cpu_type = "ppc64/power4";
 			break;
 
 		case PV_970:
 		case PV_970FX:
 			model = &op_model_power4;
 			model->num_counters = 8;
-			oprof_ppc64_ops.cpu_type = "ppc64/970";
+			ops->cpu_type = "ppc64/970";
 			break;
 
 		case PV_POWER5:
 		case PV_POWER5p:
 			model = &op_model_power4;
 			model->num_counters = 6;
-			oprof_ppc64_ops.cpu_type = "ppc64/power5";
+			ops->cpu_type = "ppc64/power5";
 			break;
 
 		default:
-			return -ENODEV;
+			return;
 	}
 
-	*ops = &oprof_ppc64_ops;
+	ops->create_files = op_ppc64_create_files;
+	ops->setup = op_ppc64_setup;
+	ops->shutdown = op_ppc64_shutdown;
+	ops->start = op_ppc64_start;
+	ops->stop = op_ppc64_stop;
 
 	printk(KERN_INFO "oprofile: using %s performance monitoring.\n",
-	       oprof_ppc64_ops.cpu_type);
-
-	return 0;
+	       ops->cpu_type);
 }
 
 void oprofile_arch_exit(void)
Index: linux/arch/ppc64/oprofile/op_model_power4.c
===================================================================
--- linux.orig/arch/ppc64/oprofile/op_model_power4.c	2004-11-06 01:11:47.%N +1100
+++ linux/arch/ppc64/oprofile/op_model_power4.c	2004-11-06 01:30:00.%N +1100
@@ -264,7 +264,6 @@ static void power4_handle_interrupt(stru
 	int is_kernel;
 	int val;
 	int i;
-	unsigned int cpu = smp_processor_id();
 	unsigned int mmcr0;
 
 	pc = get_pc(regs);
@@ -277,7 +276,7 @@ static void power4_handle_interrupt(stru
 		val = ctr_read(i);
 		if (val < 0) {
 			if (oprofile_running && ctr[i].enabled) {
-				oprofile_add_sample(pc, is_kernel, i, cpu);
+				oprofile_add_pc(pc, is_kernel, i);
 				ctr_write(i, reset_value[i]);
 			} else {
 				ctr_write(i, 0);

--=-C2DW4+HLwegbYmDhyR9v--

