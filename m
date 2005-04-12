Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262624AbVDMCLj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262624AbVDMCLj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 22:11:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262173AbVDLTt4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 15:49:56 -0400
Received: from fire.osdl.org ([65.172.181.4]:62152 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262172AbVDLKcB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 06:32:01 -0400
Message-Id: <200504121031.j3CAVUU3005328@shell0.pdx.osdl.net>
Subject: [patch 051/198] ppc64: Detect altivec via firmware on unknown CPUs
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, benh@kernel.crashing.org
From: akpm@osdl.org
Date: Tue, 12 Apr 2005 03:31:23 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Benjamin Herrenschmidt <benh@kernel.crashing.org>

This patch adds detection of the Altivec capability of the CPU via the
firmware in addition to the cpu table.  This allows newer CPUs that aren't
in the table to still have working altivec support in the kernel.

It also fixes a problem where if a CPU isn't recognized as having altivec
features, and takes an altivec unavailable exception due to userland
issuing altivec instructions, the kernel would happily enable it and
context switch the registers ...  but not all of them (it would basically
forget vrsave).  With this patch, the kernel will refuse to enable altivec
when the feature isn't detected for the CPU (SIGILL).

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/arch/ppc64/kernel/head.S  |    2 ++
 25-akpm/arch/ppc64/kernel/prom.c  |   19 ++++++++++++++++++-
 25-akpm/arch/ppc64/kernel/traps.c |    2 --
 3 files changed, 20 insertions(+), 3 deletions(-)

diff -puN arch/ppc64/kernel/head.S~ppc64-detect-altivec-via-firmware-on-unknown-cpus arch/ppc64/kernel/head.S
--- 25/arch/ppc64/kernel/head.S~ppc64-detect-altivec-via-firmware-on-unknown-cpus	2005-04-12 03:21:15.707748960 -0700
+++ 25-akpm/arch/ppc64/kernel/head.S	2005-04-12 03:21:15.714747896 -0700
@@ -922,7 +922,9 @@ fp_unavailable_common:
 altivec_unavailable_common:
 	EXCEPTION_PROLOG_COMMON(0xf20, PACA_EXGEN)
 #ifdef CONFIG_ALTIVEC
+BEGIN_FTR_SECTION
 	bne	.load_up_altivec	/* if from user, just load it up */
+END_FTR_SECTION_IFSET(CPU_FTR_ALTIVEC)
 #endif
 	bl	.save_nvgprs
 	addi	r3,r1,STACK_FRAME_OVERHEAD
diff -puN arch/ppc64/kernel/prom.c~ppc64-detect-altivec-via-firmware-on-unknown-cpus arch/ppc64/kernel/prom.c
--- 25/arch/ppc64/kernel/prom.c~ppc64-detect-altivec-via-firmware-on-unknown-cpus	2005-04-12 03:21:15.708748808 -0700
+++ 25-akpm/arch/ppc64/kernel/prom.c	2005-04-12 03:21:15.715747744 -0700
@@ -885,6 +885,7 @@ static int __init early_init_dt_scan_cpu
 					  const char *full_path, void *data)
 {
 	char *type = get_flat_dt_prop(node, "device_type", NULL);
+	u32 *prop;
 
 	/* We are scanning "cpu" nodes only */
 	if (type == NULL || strcmp(type, "cpu") != 0)
@@ -916,6 +917,20 @@ static int __init early_init_dt_scan_cpu
 		}
 	}
 
+	/* Check if we have a VMX and eventually update CPU features */
+	prop = (u32 *)get_flat_dt_prop(node, "ibm,vmx", NULL);
+	if (prop && (*prop) > 0) {
+		cur_cpu_spec->cpu_features |= CPU_FTR_ALTIVEC;
+		cur_cpu_spec->cpu_user_features |= PPC_FEATURE_HAS_ALTIVEC;
+	}
+
+	/* Same goes for Apple's "altivec" property */
+	prop = (u32 *)get_flat_dt_prop(node, "altivec", NULL);
+	if (prop) {
+		cur_cpu_spec->cpu_features |= CPU_FTR_ALTIVEC;
+		cur_cpu_spec->cpu_user_features |= PPC_FEATURE_HAS_ALTIVEC;
+	}
+
 	return 0;
 }
 
@@ -1104,7 +1119,9 @@ void __init early_init_devtree(void *par
 
 	DBG("Scanning CPUs ...\n");
 
-	/* Retreive hash table size from flattened tree */
+	/* Retreive hash table size from flattened tree plus other
+	 * CPU related informations (altivec support, boot CPU ID, ...)
+	 */
 	scan_flat_dt(early_init_dt_scan_cpus, NULL);
 
 	/* If hash size wasn't obtained above, we calculate it now based on
diff -puN arch/ppc64/kernel/traps.c~ppc64-detect-altivec-via-firmware-on-unknown-cpus arch/ppc64/kernel/traps.c
--- 25/arch/ppc64/kernel/traps.c~ppc64-detect-altivec-via-firmware-on-unknown-cpus	2005-04-12 03:21:15.710748504 -0700
+++ 25-akpm/arch/ppc64/kernel/traps.c	2005-04-12 03:21:15.716747592 -0700
@@ -450,14 +450,12 @@ void kernel_fp_unavailable_exception(str
 
 void altivec_unavailable_exception(struct pt_regs *regs)
 {
-#ifndef CONFIG_ALTIVEC
 	if (user_mode(regs)) {
 		/* A user program has executed an altivec instruction,
 		   but this kernel doesn't support altivec. */
 		_exception(SIGILL, regs, ILL_ILLOPC, regs->nip);
 		return;
 	}
-#endif
 	printk(KERN_EMERG "Unrecoverable VMX/Altivec Unavailable Exception "
 			  "%lx at %lx\n", regs->trap, regs->nip);
 	die("Unrecoverable VMX/Altivec Unavailable Exception", regs, SIGABRT);
_
