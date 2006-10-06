Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932092AbWJFJKW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932092AbWJFJKW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 05:10:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932106AbWJFJKV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 05:10:21 -0400
Received: from madara.hpl.hp.com ([192.6.19.124]:56775 "EHLO madara.hpl.hp.com")
	by vger.kernel.org with ESMTP id S932092AbWJFJKV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 05:10:21 -0400
Date: Fri, 6 Oct 2006 02:10:06 -0700
From: Stephane Eranian <eranian@hpl.hp.com>
To: linux-kernel@vger.kernel.org
Cc: ak@suse.de, Stephane Eranian <eranian@hpl.hp.com>
Subject: [PATCH] add X86_FEATURE_PEBS and detection
Message-ID: <20061006091006.GD8793@frankl.hpl.hp.com>
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
Precise Event Based Sampling (PEBS) feature for Intel 64-bit processors.
The patch also adds the cpu_has_pebs macro.

IMPORTANT: you need to have the X86_FEATURE_DS renaming patch applied first!

changelog:
	- adds X86_FEATURE_PEBS
	- adds cpu_has_pebs to test for X86_FEATURE_PEBS

signed-off-by: stephane eranian <eranian@hpl.hp.com>

--- a/arch/x86_64/kernel/setup.c
+++ b/arch/x86_64/kernel/setup.c
@@ -835,6 +835,13 @@ static void __cpuinit init_intel(struct 
 			set_bit(X86_FEATURE_ARCH_PERFMON, &c->x86_capability);
 	}
 
+	if (cpu_has_ds) {
+		unsigned int l1, l2;
+		rdmsr(MSR_IA32_MISC_ENABLE, l1, l2);
+		if (!(l1 & (1<<12)))
+			set_bit(X86_FEATURE_PEBS, c->x86_capability);
+	}
+
 	n = c->extended_cpuid_level;
 	if (n >= 0x80000008) {
 		unsigned eax = cpuid_eax(0x80000008);
--- a/include/asm-x86_64/cpufeature.h
+++ b/include/asm-x86_64/cpufeature.h
@@ -68,6 +68,7 @@
 #define X86_FEATURE_FXSAVE_LEAK (3*32+7)  /* FIP/FOP/FDP leaks through FXSAVE */
 #define X86_FEATURE_UP		(3*32+8) /* SMP kernel running on UP */
 #define X86_FEATURE_ARCH_PERFMON (3*32+9) /* Intel Architectural PerfMon */
+#define X86_FEATURE_PEBS	(3*32+10) /* Precise-Event Based Sampling */
 
 /* Intel-defined CPU features, CPUID level 0x00000001 (ecx), word 4 */
 #define X86_FEATURE_XMM3	(4*32+ 0) /* Streaming SIMD Extensions-3 */
@@ -113,5 +114,6 @@
 #define cpu_has_centaur_mcr    0
 #define cpu_has_clflush	       boot_cpu_has(X86_FEATURE_CLFLSH)
 #define cpu_has_ds 	       boot_cpu_has(X86_FEATURE_DS)
+#define cpu_has_pebs 	       boot_cpu_has(X86_FEATURE_PEBS)
 
 #endif /* __ASM_X8664_CPUFEATURE_H */
