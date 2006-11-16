Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423837AbWKPOVO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423837AbWKPOVO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Nov 2006 09:21:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424079AbWKPOVO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Nov 2006 09:21:14 -0500
Received: from madara.hpl.hp.com ([192.6.19.124]:11007 "EHLO madara.hpl.hp.com")
	by vger.kernel.org with ESMTP id S1423837AbWKPOVN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Nov 2006 09:21:13 -0500
Date: Thu, 16 Nov 2006 06:20:49 -0800
From: Stephane Eranian <eranian@hpl.hp.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, ak@suse.de, Stephane Eranian <eranian@hpl.hp.com>
Subject: [PATCH] x86-64 add Intel BTS cpufeature bit and detection (take 2)
Message-ID: <20061116142049.GE18162@frankl.hpl.hp.com>
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

Andi,

Here is a small patch for x86-64 which adds a cpufeature flag and
detection code for Intel's Branch Trace Store (BTS) feature. This
feature can be found on Intel P4 and Core 2 processors among others.
It can also be used by perfmon.

The patch is relative to 2.6.19-rc5-git7 + x86_64-2.6.19-rc5-git7-061116-2

changelog:
	- add CPU_FEATURE_BTS
	- add Branch Trace Store detection

signed-off-by: stephane eranian <eranian@hpl.hp.com>

diff --exclude=.git -urNp linux-2.6.19-rc5-git7-ak.orig/arch/x86_64/kernel/setup.c linux-2.6.19-rc5-git7-ak/arch/x86_64/kernel/setup.c
--- linux-2.6.19-rc5-git7-ak.orig/arch/x86_64/kernel/setup.c	2006-11-16 05:15:39.000000000 -0800
+++ linux-2.6.19-rc5-git7-ak/arch/x86_64/kernel/setup.c	2006-11-16 05:46:51.000000000 -0800
@@ -838,6 +838,8 @@ static void __cpuinit init_intel(struct 
 	if (cpu_has_ds) {
 		unsigned int l1, l2;
 		rdmsr(MSR_IA32_MISC_ENABLE, l1, l2);
+		if (!(l1 & (1<<11)))
+			set_bit(X86_FEATURE_BTS, c->x86_capability);
 		if (!(l1 & (1<<12)))
 			set_bit(X86_FEATURE_PEBS, c->x86_capability);
 	}
diff --exclude=.git -urNp linux-2.6.19-rc5-git7-ak.orig/include/asm-x86_64/cpufeature.h linux-2.6.19-rc5-git7-ak/include/asm-x86_64/cpufeature.h
--- linux-2.6.19-rc5-git7-ak.orig/include/asm-x86_64/cpufeature.h	2006-11-16 05:15:39.000000000 -0800
+++ linux-2.6.19-rc5-git7-ak/include/asm-x86_64/cpufeature.h	2006-11-16 05:47:52.000000000 -0800
@@ -69,6 +69,7 @@
 #define X86_FEATURE_UP		(3*32+8) /* SMP kernel running on UP */
 #define X86_FEATURE_ARCH_PERFMON (3*32+9) /* Intel Architectural PerfMon */
 #define X86_FEATURE_PEBS	(3*32+10) /* Precise-Event Based Sampling */
+#define X86_FEATURE_BTS		(3*32+11) /* Branch Trace Store */
 
 /* Intel-defined CPU features, CPUID level 0x00000001 (ecx), word 4 */
 #define X86_FEATURE_XMM3	(4*32+ 0) /* Streaming SIMD Extensions-3 */
@@ -115,5 +116,6 @@
 #define cpu_has_clflush	       boot_cpu_has(X86_FEATURE_CLFLSH)
 #define cpu_has_ds 	       boot_cpu_has(X86_FEATURE_DS)
 #define cpu_has_pebs 	       boot_cpu_has(X86_FEATURE_PEBS)
+#define cpu_has_bts 	       boot_cpu_has(X86_FEATURE_BTS)
 
 #endif /* __ASM_X8664_CPUFEATURE_H */
