Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161730AbWKOVcy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161730AbWKOVcy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 16:32:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161731AbWKOVcy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 16:32:54 -0500
Received: from gundega.hpl.hp.com ([192.6.19.190]:21497 "EHLO
	gundega.hpl.hp.com") by vger.kernel.org with ESMTP id S1161730AbWKOVcx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 16:32:53 -0500
Date: Wed, 15 Nov 2006 13:32:41 -0800
From: Stephane Eranian <eranian@hpl.hp.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, Stephane Eranian <eranian@hpl.hp.com>
Subject: [PATCH] i386 add Intel PEBS and BTS cpufeature bits and detection
Message-ID: <20061115213241.GC17238@frankl.hpl.hp.com>
Reply-To: eranian@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: eranian@hpl.hp.com
X-HPL-MailScanner: Found to be clean
X-HPL-MailScanner-From: eranian@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Here is a small patch that adds two cpufeature bits to represent
Intel's Precise-Event-Based Sampling (PEBS) and Branch Trace Store
(BTS) features. Those features can be found on Intel P4 and Core 2 
processors among others and can be used by perfmon.

changelog:
	- add CPU_FEATURE_PEBS and CPU_FEATURE_BTS
	- add feature detection code

signed-off-by: stephane eranian <eranian@hpl.hp.com>

diff --exclude=.git -urNp linux-2.6.orig/arch/i386/kernel/cpu/intel.c linux-2.6.base/arch/i386/kernel/cpu/intel.c
--- linux-2.6.orig/arch/i386/kernel/cpu/intel.c	2006-10-17 05:33:35.000000000 -0700
+++ linux-2.6.base/arch/i386/kernel/cpu/intel.c	2006-11-15 08:12:22.000000000 -0800
@@ -97,7 +97,7 @@ static int __cpuinit num_cpu_cores(struc
 
 static void __cpuinit init_intel(struct cpuinfo_x86 *c)
 {
-	unsigned int l2 = 0;
+	unsigned int l1, l2 = 0;
 	char *p = NULL;
 
 #ifdef CONFIG_X86_F00F_BUG
@@ -195,6 +195,14 @@ static void __cpuinit init_intel(struct 
 	if ((c->x86 == 0xf && c->x86_model >= 0x03) ||
 		(c->x86 == 0x6 && c->x86_model >= 0x0e))
 		set_bit(X86_FEATURE_CONSTANT_TSC, c->x86_capability);
+
+	if (cpu_has_ds) {
+		rdmsr(MSR_IA32_MISC_ENABLE, l1, l2);
+		if (!(l1 & (1<<11)))
+			set_bit(X86_FEATURE_BTS, c->x86_capability);
+		if (!(l1 & (1<<12)))
+			set_bit(X86_FEATURE_PEBS, c->x86_capability);
+	}
 }
 
diff --exclude=.git -urNp linux-2.6.orig/include/asm-i386/cpufeature.h linux-2.6.base/include/asm-i386/cpufeature.h
--- linux-2.6.orig/include/asm-i386/cpufeature.h	2006-10-17 05:33:40.000000000 -0700
+++ linux-2.6.base/include/asm-i386/cpufeature.h	2006-11-15 08:13:37.000000000 -0800
@@ -73,6 +73,8 @@
 #define X86_FEATURE_UP		(3*32+ 9) /* smp kernel running on up */
 #define X86_FEATURE_FXSAVE_LEAK (3*32+10) /* FXSAVE leaks FOP/FIP/FOP */
 #define X86_FEATURE_ARCH_PERFMON (3*32+11) /* Intel Architectural PerfMon */
+#define X86_FEATURE_PEBS	(3*32+12)  /* Precise-Event Based Sampling */
+#define X86_FEATURE_BTS		(3*32+13)  /* Branch Trace Store */
 
 /* Intel-defined CPU features, CPUID level 0x00000001 (ecx), word 4 */
 #define X86_FEATURE_XMM3	(4*32+ 0) /* Streaming SIMD Extensions-3 */
@@ -134,6 +136,9 @@
 #define cpu_has_phe_enabled	boot_cpu_has(X86_FEATURE_PHE_EN)
 #define cpu_has_pmm		boot_cpu_has(X86_FEATURE_PMM)
 #define cpu_has_pmm_enabled	boot_cpu_has(X86_FEATURE_PMM_EN)
+#define cpu_has_ds 		boot_cpu_has(X86_FEATURE_DTES)
+#define cpu_has_pebs 		boot_cpu_has(X86_FEATURE_PEBS)
+#define cpu_has_bts		boot_cpu_has(X86_FEATURE_BTS)
 
 #endif /* __ASM_I386_CPUFEATURE_H */
 
