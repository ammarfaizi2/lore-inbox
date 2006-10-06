Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932225AbWJFNPF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932225AbWJFNPF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 09:15:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932297AbWJFNPE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 09:15:04 -0400
Received: from madara.hpl.hp.com ([192.6.19.124]:60380 "EHLO madara.hpl.hp.com")
	by vger.kernel.org with ESMTP id S932225AbWJFNPC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 09:15:02 -0400
Date: Fri, 6 Oct 2006 06:14:51 -0700
From: Stephane Eranian <eranian@hpl.hp.com>
To: linux-kernel@vger.kernel.org
Cc: Stephane Eranian <eranian@hpl.hp.com>
Subject: [PATCH] i386 add X86_FEATURE_PEBS and detection
Message-ID: <20061006131451.GE9063@frankl.hpl.hp.com>
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

Here is a patch (used by perfmon2) to detect the presence of the
Precise Event Based Sampling (PEBS) feature for i386.
The patch also adds the cpu_has_pebs macro.

IMPORTANT: you need to have the i386 X86_FEATURE_DS renaming patch applied first!

changelog:
        - adds X86_FEATURE_PEBS
        - adds cpu_has_pebs to test for X86_FEATURE_PEBS

signed-off-by: stephane eranian <eranian@hpl.hp.com>


diff --git a/arch/i386/kernel/cpu/intel.c b/arch/i386/kernel/cpu/intel.c
index 94a95aa..798c2f6 100644
--- a/arch/i386/kernel/cpu/intel.c
+++ b/arch/i386/kernel/cpu/intel.c
@@ -195,8 +195,14 @@ #endif
 	if ((c->x86 == 0xf && c->x86_model >= 0x03) ||
 		(c->x86 == 0x6 && c->x86_model >= 0x0e))
 		set_bit(X86_FEATURE_CONSTANT_TSC, c->x86_capability);
-}
 
+	if (cpu_has_ds) {
+		unsigned int l1;
+		rdmsr(MSR_IA32_MISC_ENABLE, l1, l2);
+		if (!(l1 & (1<<12)))
+			set_bit(X86_FEATURE_PEBS, c->x86_capability);
+	}
+}
 
 static unsigned int __cpuinit intel_size_cache(struct cpuinfo_x86 * c, unsigned int size)
 {
--- a/include/asm-i386/cpufeature.h	2006-10-06 05:34:05.000000000 -0700
+++ b/include/asm-i386/cpufeature.h	2006-10-06 05:12:57.000000000 -0700
@@ -73,6 +73,7 @@
 #define X86_FEATURE_UP		(3*32+ 9) /* smp kernel running on up */
 #define X86_FEATURE_FXSAVE_LEAK (3*32+10) /* FXSAVE leaks FOP/FIP/FOP */
 #define X86_FEATURE_ARCH_PERFMON (3*32+11) /* Intel Architectural PerfMon */
+#define X86_FEATURE_PEBS	(3*32+12)  /* Precise-Event Based Sampling */
 
 /* Intel-defined CPU features, CPUID level 0x00000001 (ecx), word 4 */
 #define X86_FEATURE_XMM3	(4*32+ 0) /* Streaming SIMD Extensions-3 */
@@ -135,6 +136,7 @@
 #define cpu_has_pmm		boot_cpu_has(X86_FEATURE_PMM)
 #define cpu_has_pmm_enabled	boot_cpu_has(X86_FEATURE_PMM_EN)
 #define cpu_has_ds		boot_cpu_has(X86_FEATURE_DS)
+#define cpu_has_pebs 		boot_cpu_has(X86_FEATURE_PEBS)
 
 #endif /* __ASM_I386_CPUFEATURE_H */
 
