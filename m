Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262186AbVDLTjH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262186AbVDLTjH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 15:39:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262187AbVDLTfn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 15:35:43 -0400
Received: from fire.osdl.org ([65.172.181.4]:2505 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262186AbVDLKcG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 06:32:06 -0400
Message-Id: <200504121031.j3CAVxJK005467@shell0.pdx.osdl.net>
Subject: [patch 085/198] x86_64: Support constantly ticking TSCs
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, ak@suse.de,
       venkatesh.pallipadi@intel.com
From: akpm@osdl.org
Date: Tue, 12 Apr 2005 03:31:53 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: "Andi Kleen" <ak@suse.de>

On Intel Noconas the TSC ticks with a constant frequency.  Don't scale the
factor used by udelay when cpufreq changes the frequency.

This generalizes an earlier patch by Intel for this. 

Cc: <venkatesh.pallipadi@intel.com>
Signed-off-by: Andi Kleen <ak@suse.de>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/arch/x86_64/kernel/setup.c      |    5 ++++-
 25-akpm/arch/x86_64/kernel/time.c       |    5 +++--
 25-akpm/include/asm-x86_64/cpufeature.h |    1 +
 3 files changed, 8 insertions(+), 3 deletions(-)

diff -puN arch/x86_64/kernel/setup.c~x86_64-support-constantly-ticking-tscs arch/x86_64/kernel/setup.c
--- 25/arch/x86_64/kernel/setup.c~x86_64-support-constantly-ticking-tscs	2005-04-12 03:21:23.473568376 -0700
+++ 25-akpm/arch/x86_64/kernel/setup.c	2005-04-12 03:21:23.479567464 -0700
@@ -855,6 +855,8 @@ static void __init init_intel(struct cpu
 
 	if (c->x86 == 15)
 		c->x86_cache_alignment = c->x86_clflush_size * 2;
+	if (c->x86 >= 15)
+		set_bit(X86_FEATURE_CONSTANT_TSC, &c->x86_capability);
 }
 
 void __init get_cpu_vendor(struct cpuinfo_x86 *c)
@@ -1055,7 +1057,8 @@ static int show_cpuinfo(struct seq_file 
 		NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
 
 		/* Other (Linux-defined) */
-		"cxmmx", "k6_mtrr", "cyrix_arr", "centaur_mcr", NULL, NULL, NULL, NULL,
+		"cxmmx", NULL, "cyrix_arr", "centaur_mcr", "k8c+",
+		"constant_tsc", NULL, NULL,
 		NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
 		NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
 		NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
diff -puN arch/x86_64/kernel/time.c~x86_64-support-constantly-ticking-tscs arch/x86_64/kernel/time.c
--- 25/arch/x86_64/kernel/time.c~x86_64-support-constantly-ticking-tscs	2005-04-12 03:21:23.474568224 -0700
+++ 25-akpm/arch/x86_64/kernel/time.c	2005-04-12 03:21:23.480567312 -0700
@@ -614,6 +614,9 @@ static int time_cpufreq_notifier(struct 
         struct cpufreq_freqs *freq = data;
 	unsigned long *lpj, dummy;
 
+	if (cpu_has(&cpu_data[freq->cpu], X86_FEATURE_CONSTANT_TSC))
+		return 0;
+
 	lpj = &dummy;
 	if (!(freq->flags & CPUFREQ_CONST_LOOPS))
 #ifdef CONFIG_SMP
@@ -622,8 +625,6 @@ static int time_cpufreq_notifier(struct 
 	lpj = &boot_cpu_data.loops_per_jiffy;
 #endif
 
-
-
 	if (!ref_freq) {
 		ref_freq = freq->old;
 		loops_per_jiffy_ref = *lpj;
diff -puN include/asm-x86_64/cpufeature.h~x86_64-support-constantly-ticking-tscs include/asm-x86_64/cpufeature.h
--- 25/include/asm-x86_64/cpufeature.h~x86_64-support-constantly-ticking-tscs	2005-04-12 03:21:23.475568072 -0700
+++ 25-akpm/include/asm-x86_64/cpufeature.h	2005-04-12 03:21:23.481567160 -0700
@@ -62,6 +62,7 @@
 #define X86_FEATURE_CYRIX_ARR	(3*32+ 2) /* Cyrix ARRs (= MTRRs) */
 #define X86_FEATURE_CENTAUR_MCR	(3*32+ 3) /* Centaur MCRs (= MTRRs) */
 #define X86_FEATURE_K8_C	(3*32+ 4) /* C stepping K8 */
+#define X86_FEATURE_CONSTANT_TSC (3*32+5) /* TSC runs at constant rate */
 
 /* Intel-defined CPU features, CPUID level 0x00000001 (ecx), word 4 */
 #define X86_FEATURE_XMM3	(4*32+ 0) /* Streaming SIMD Extensions-3 */
_
