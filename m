Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271186AbTHHCyl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 22:54:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271187AbTHHCyl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 22:54:41 -0400
Received: from host-64-213-145-173.atlantasolutions.com ([64.213.145.173]:22426
	"EHLO havoc.gtf.org") by vger.kernel.org with ESMTP id S271186AbTHHCyd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 22:54:33 -0400
Date: Thu, 7 Aug 2003 22:54:30 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: linux-kernel@vger.kernel.org
Subject: [patch 2.4 1/2] backport 2.6 x86 cpu capabilities
Message-ID: <20030808025430.GA31796@gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


(hopefully destined for 2.4.23-pre1)

#
#	include/asm-i386/msr.h	1.8     -> 1.9    
#	include/asm-i386/cpufeature.h	1.5     -> 1.6    
#	arch/i386/kernel/setup.c	1.70    -> 1.71   
#
# --------------------------------------------
# 03/08/07	jgarzik@redhat.com	1.1066
# [ia32] Via, Intel cpu capabilities update
# 
# * /proc/cpuinfo support for Intel Prescott New Instructions (PNI)
# * /proc/cpuinfo support for Centuar Extended Feature Flags
#   (including "xstore", Via RNG support)
# * at boot time, input x86 capability data for the two featuresets
# * sync include/asm-i386/cpufeature.h definitions with 2.6.x
# --------------------------------------------
#
diff -Nru a/arch/i386/kernel/setup.c b/arch/i386/kernel/setup.c
--- a/arch/i386/kernel/setup.c	Thu Aug  7 22:51:33 2003
+++ b/arch/i386/kernel/setup.c	Thu Aug  7 22:51:33 2003
@@ -1965,6 +1965,37 @@
 	
 #endif
 
+static void __init init_c3(struct cpuinfo_x86 *c)
+{
+	u32  lo, hi;
+
+	/* Test for Centaur Extended Feature Flags presence */
+	if (cpuid_eax(0xC0000000) >= 0xC0000001) {
+		/* store Centaur Extended Feature Flags as
+		 * word 5 of the CPU capability bit array
+		 */
+		c->x86_capability[5] = cpuid_edx(0xC0000001);
+	}
+
+	switch (c->x86_model) {
+		case 6 ... 8:		/* Cyrix III family */
+			rdmsr (MSR_VIA_FCR, lo, hi);
+			lo |= (1<<1 | 1<<7);	/* Report CX8 & enable PGE */
+			wrmsr (MSR_VIA_FCR, lo, hi);
+
+			set_bit(X86_FEATURE_CX8, c->x86_capability);
+			set_bit(X86_FEATURE_3DNOW, c->x86_capability);
+
+			/* fall through */
+
+		case 9:	/* Nehemiah */
+		default:
+			get_model_name(c);
+			display_cacheinfo(c);
+			break;
+	}
+}
+
 static void __init init_centaur(struct cpuinfo_x86 *c)
 {
 	enum {
@@ -2103,23 +2134,7 @@
 			break;
 
 		case 6:
-			switch (c->x86_model) {
-				case 6 ... 8:		/* Cyrix III family */
-					rdmsr (MSR_VIA_FCR, lo, hi);
-					lo |= (1<<1 | 1<<7);	/* Report CX8 & enable PGE */
-					wrmsr (MSR_VIA_FCR, lo, hi);
-
-					set_bit(X86_FEATURE_CX8, &c->x86_capability);
-					set_bit(X86_FEATURE_3DNOW, &c->x86_capability);
-
-					/* fall through */
-
-				case 9: /* Nehemiah */
-				default:
-					get_model_name(c);
-					display_cacheinfo(c);
-					break;
-			}
+			init_c3(c);
 			break;
 	}
 }
@@ -2754,10 +2769,16 @@
 
 		/* Intel-defined flags: level 0x00000001 */
 		if ( c->cpuid_level >= 0x00000001 ) {
-			cpuid(0x00000001, &tfms, &junk, &junk,
-			      &c->x86_capability[0]);
+			u32 capability, excap;
+			cpuid(0x00000001, &tfms, &junk, &excap, &capability);
+			c->x86_capability[0] = capability;
+			c->x86_capability[4] = excap;
 			c->x86 = (tfms >> 8) & 15;
 			c->x86_model = (tfms >> 4) & 15;
+			if (c->x86 == 0xf) {
+				c->x86 += (tfms >> 20) & 0xff;
+				c->x86_model += ((tfms >> 16) & 0xF) << 4;
+			} 
 			c->x86_mask = tfms & 15;
 		} else {
 			/* Have CPUID level 0 only - unheard of */
@@ -2961,12 +2982,12 @@
 	        "fpu", "vme", "de", "pse", "tsc", "msr", "pae", "mce",
 	        "cx8", "apic", NULL, "sep", "mtrr", "pge", "mca", "cmov",
 	        "pat", "pse36", "pn", "clflush", NULL, "dts", "acpi", "mmx",
-	        "fxsr", "sse", "sse2", "ss", "ht", "tm", "ia64", NULL,
+	        "fxsr", "sse", "sse2", "ss", "ht", "tm", "ia64", "pbe",
 
 		/* AMD-defined */
 		NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
 		NULL, NULL, NULL, "syscall", NULL, NULL, NULL, NULL,
-		NULL, NULL, NULL, NULL, NULL, NULL, "mmxext", NULL,
+		NULL, NULL, NULL, "mp", NULL, NULL, "mmxext", NULL,
 		NULL, NULL, NULL, NULL, NULL, "lm", "3dnowext", "3dnow",
 
 		/* Transmeta-defined */
@@ -2976,7 +2997,20 @@
 		NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
 
 		/* Other (Linux-defined) */
-		"cxmmx", "k6_mtrr", "cyrix_arr", "centaur_mcr", NULL, NULL, NULL, NULL,
+		"cxmmx", "k6_mtrr", "cyrix_arr", "centaur_mcr",
+		NULL, NULL, NULL, NULL,
+		NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
+		NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
+		NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
+
+		/* Intel-defined (#2) */
+		"pni", NULL, NULL, "monitor", "ds_cpl", NULL, NULL, "tm2",
+		"est", NULL, "cid", NULL, NULL, NULL, NULL, NULL,
+		NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
+		NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
+
+		/* VIA/Cyrix/Centaur-defined */
+		NULL, NULL, "xstore", NULL, NULL, NULL, NULL, NULL,
 		NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
 		NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
 		NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
diff -Nru a/include/asm-i386/cpufeature.h b/include/asm-i386/cpufeature.h
--- a/include/asm-i386/cpufeature.h	Thu Aug  7 22:51:33 2003
+++ b/include/asm-i386/cpufeature.h	Thu Aug  7 22:51:33 2003
@@ -10,9 +10,9 @@
 /* Sample usage: CPU_FEATURE_P(cpu.x86_capability, FPU) */
 #define CPU_FEATURE_P(CAP, FEATURE) test_bit(CAP, X86_FEATURE_##FEATURE ##_BIT)
 
-#define NCAPINTS	4	/* Currently we have 4 32-bit words worth of info */
+#define NCAPINTS	6	/* Currently we have 6 32-bit words worth of info */
 
-/* Intel-defined CPU features, CPUID level 0x00000001, word 0 */
+/* Intel-defined CPU features, CPUID level 0x00000001 (edx), word 0 */
 #define X86_FEATURE_FPU		(0*32+ 0) /* Onboard FPU */
 #define X86_FEATURE_VME		(0*32+ 1) /* Virtual Mode Extensions */
 #define X86_FEATURE_DE		(0*32+ 2) /* Debugging Extensions */
@@ -47,6 +47,7 @@
 /* AMD-defined CPU features, CPUID level 0x80000001, word 1 */
 /* Don't duplicate feature flags which are redundant with Intel! */
 #define X86_FEATURE_SYSCALL	(1*32+11) /* SYSCALL/SYSRET */
+#define X86_FEATURE_MP		(1*32+19) /* MP Capable. */
 #define X86_FEATURE_MMXEXT	(1*32+22) /* AMD MMX extensions */
 #define X86_FEATURE_LM		(1*32+29) /* Long Mode (x86-64) */
 #define X86_FEATURE_3DNOWEXT	(1*32+30) /* AMD 3DNow! extensions */
@@ -63,10 +64,19 @@
 #define X86_FEATURE_K6_MTRR	(3*32+ 1) /* AMD K6 nonstandard MTRRs */
 #define X86_FEATURE_CYRIX_ARR	(3*32+ 2) /* Cyrix ARRs (= MTRRs) */
 #define X86_FEATURE_CENTAUR_MCR	(3*32+ 3) /* Centaur MCRs (= MTRRs) */
+/* cpu types for specific tunings: */
+#define X86_FEATURE_K8		(3*32+ 4) /* Opteron, Athlon64 */
+#define X86_FEATURE_K7		(3*32+ 5) /* Athlon */
+#define X86_FEATURE_P3		(3*32+ 6) /* P3 */
+#define X86_FEATURE_P4		(3*32+ 7) /* P4 */
 
-/* Intel defined CPU features, CPUID level 0x00000001 (ecx), word 4 */
+/* Intel-defined CPU features, CPUID level 0x00000001 (ecx), word 4 */
 #define X86_FEATURE_EST		(4*32+ 7) /* Enhanced SpeedStep */
 
+/* VIA/Cyrix/Centaur-defined CPU features, CPUID level 0xC0000001, word 5 */
+#define X86_FEATURE_XSTORE	(5*32+ 2) /* on-CPU RNG present (xstore insn) */
+
+
 #define cpu_has(c, bit)		test_bit(bit, (c)->x86_capability)
 #define boot_cpu_has(bit)	test_bit(bit, boot_cpu_data.x86_capability)
 
@@ -77,7 +87,9 @@
 #define cpu_has_tsc		boot_cpu_has(X86_FEATURE_TSC)
 #define cpu_has_pae		boot_cpu_has(X86_FEATURE_PAE)
 #define cpu_has_pge		boot_cpu_has(X86_FEATURE_PGE)
+#define cpu_has_sse2		boot_cpu_has(X86_FEATURE_XMM2)
 #define cpu_has_apic		boot_cpu_has(X86_FEATURE_APIC)
+#define cpu_has_sep		boot_cpu_has(X86_FEATURE_SEP)
 #define cpu_has_mtrr		boot_cpu_has(X86_FEATURE_MTRR)
 #define cpu_has_mmx		boot_cpu_has(X86_FEATURE_MMX)
 #define cpu_has_fxsr		boot_cpu_has(X86_FEATURE_FXSR)
@@ -87,6 +99,7 @@
 #define cpu_has_k6_mtrr		boot_cpu_has(X86_FEATURE_K6_MTRR)
 #define cpu_has_cyrix_arr	boot_cpu_has(X86_FEATURE_CYRIX_ARR)
 #define cpu_has_centaur_mcr	boot_cpu_has(X86_FEATURE_CENTAUR_MCR)
+#define cpu_has_xstore		boot_cpu_has(X86_FEATURE_XSTORE)
 
 #endif /* __ASM_I386_CPUFEATURE_H */
 
diff -Nru a/include/asm-i386/msr.h b/include/asm-i386/msr.h
--- a/include/asm-i386/msr.h	Thu Aug  7 22:51:33 2003
+++ b/include/asm-i386/msr.h	Thu Aug  7 22:51:33 2003
@@ -113,6 +113,7 @@
 /* VIA Cyrix defined MSRs*/
 #define MSR_VIA_FCR			0x1107
 #define MSR_VIA_LONGHAUL		0x110a
+#define MSR_VIA_RNG			0x110b
 #define MSR_VIA_BCR2			0x1147
 
 /* Transmeta defined MSRs */
