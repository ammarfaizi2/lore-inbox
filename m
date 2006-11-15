Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161735AbWKOVfO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161735AbWKOVfO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 16:35:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161736AbWKOVfO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 16:35:14 -0500
Received: from madara.hpl.hp.com ([192.6.19.124]:46035 "EHLO madara.hpl.hp.com")
	by vger.kernel.org with ESMTP id S1161735AbWKOVfK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 16:35:10 -0500
Date: Wed, 15 Nov 2006 13:34:38 -0800
From: Stephane Eranian <eranian@hpl.hp.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, ak@suse.de, Stephane Eranian <eranian@hpl.hp.com>
Subject: [PATCH] x86-64 add Intel PEBS and BTS cpufeature bits and detection
Message-ID: <20061115213438.GD17238@frankl.hpl.hp.com>
Reply-To: eranian@hpl.hp.com
References: <20061115213241.GC17238@frankl.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061115213241.GC17238@frankl.hpl.hp.com>
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
processors among others and can be used by perfmon. This patch is
for x86-64.

changelog:
	- add CPU_FEATURE_PEBS and CPU_FEATURE_BTS
	- add feature detection code

signed-off-by: stephane eranian <eranian@hpl.hp.com>

diff --exclude=.git -urNp linux-2.6.orig/include/asm-x86_64/cpufeature.h linux-2.6.base/include/asm-x86_64/cpufeature.h
--- linux-2.6.orig/include/asm-x86_64/cpufeature.h	2006-10-17 05:33:56.000000000 -0700
+++ linux-2.6.base/include/asm-x86_64/cpufeature.h	2006-11-15 13:08:25.000000000 -0800
@@ -68,6 +68,8 @@
 #define X86_FEATURE_FXSAVE_LEAK (3*32+7)  /* FIP/FOP/FDP leaks through FXSAVE */
 #define X86_FEATURE_UP		(3*32+8) /* SMP kernel running on UP */
 #define X86_FEATURE_ARCH_PERFMON (3*32+9) /* Intel Architectural PerfMon */
+#define X86_FEATURE_PEBS	(3*32+10) /* Precise-Event Based Sampling */
+#define X86_FEATURE_BTS		(3*32+11) /* Branch Trace Store */
 
 /* Intel-defined CPU features, CPUID level 0x00000001 (ecx), word 4 */
 #define X86_FEATURE_XMM3	(4*32+ 0) /* Streaming SIMD Extensions-3 */
@@ -112,5 +114,8 @@
 #define cpu_has_cyrix_arr      0
 #define cpu_has_centaur_mcr    0
 #define cpu_has_clflush	       boot_cpu_has(X86_FEATURE_CLFLSH)
+#define cpu_has_ds 	       boot_cpu_has(X86_FEATURE_DTES)
+#define cpu_has_pebs 	       boot_cpu_has(X86_FEATURE_PEBS)
+#define cpu_has_bts 	       boot_cpu_has(X86_FEATURE_BTS)
 
 #endif /* __ASM_X8664_CPUFEATURE_H */
diff --exclude=.git -urNp linux-2.6.orig/arch/x86_64/kernel/setup.c linux-2.6.base/arch/x86_64/kernel/setup.c
--- linux-2.6.orig/arch/x86_64/kernel/setup.c	2006-10-17 05:33:35.000000000 -0700
+++ linux-2.6.base/arch/x86_64/kernel/setup.c	2006-11-15 08:21:12.000000000 -0800
@@ -835,6 +835,15 @@ static void __cpuinit init_intel(struct 
 			set_bit(X86_FEATURE_ARCH_PERFMON, &c->x86_capability);
 	}
 
+	if (cpu_has_ds) {
+		unsigned int l1, l2;
+		rdmsr(MSR_IA32_MISC_ENABLE, l1, l2);
+		if (!(l1 & (1<<11)))
+			set_bit(X86_FEATURE_BTS, c->x86_capability);
+		if (!(l1 & (1<<12)))
+			set_bit(X86_FEATURE_PEBS, c->x86_capability);
+	}
+
 	n = c->extended_cpuid_level;
 	if (n >= 0x80000008) {
 		unsigned eax = cpuid_eax(0x80000008);
