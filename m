Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262694AbTCMXyp>; Thu, 13 Mar 2003 18:54:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263147AbTCMXyo>; Thu, 13 Mar 2003 18:54:44 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:17083 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S262694AbTCMXx1>;
	Thu, 13 Mar 2003 18:53:27 -0500
Message-ID: <3E711C8C.3050800@pobox.com>
Date: Thu, 13 Mar 2003 19:04:28 -0500
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
CC: Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH 3/5] rng driver update
References: <3E711C0A.40705@pobox.com>
In-Reply-To: <3E711C0A.40705@pobox.com>
Content-Type: multipart/mixed;
 boundary="------------000305010403050303030903"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000305010403050303030903
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


--------------000305010403050303030903
Content-Type: text/plain;
 name="patch.3"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch.3"

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1106  -> 1.1107 
#	include/asm-i386/msr.h	1.12    -> 1.13   
#	arch/i386/kernel/cpu/common.c	1.19    -> 1.20   
#	arch/i386/kernel/cpu/centaur.c	1.6     -> 1.7    
#	include/asm-i386/cpufeature.h	1.6     -> 1.7    
#	arch/i386/kernel/cpu/proc.c	1.8     -> 1.9    
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/03/13	jgarzik@redhat.com	1.1107
# [ia32] cpu capabilities cleanups and additions
# 
# * Add support for new Centaur(VIA) and Intel cpuid feature bits,
#   expanding the x86_capability array by two.
# * (cleanup) Move cpu setup for newer Via C3 cpus into its own
#   function, init_c3()
# * Add support for RNG control msr on VIA Nehemiah
# * export X86_FEATURE_XSTORE and cpu_has_xstore macros so that
#   kernel code may easily test for cpu support of the new
#   "xstore" instruction.
# --------------------------------------------
#
diff -Nru a/arch/i386/kernel/cpu/centaur.c b/arch/i386/kernel/cpu/centaur.c
--- a/arch/i386/kernel/cpu/centaur.c	Thu Mar 13 18:52:54 2003
+++ b/arch/i386/kernel/cpu/centaur.c	Thu Mar 13 18:52:54 2003
@@ -248,6 +248,37 @@
 }
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
@@ -386,21 +417,7 @@
 			break;
 
 		case 6:
-			switch (c->x86_model) {
-				case 6 ... 8:		/* Cyrix III family */
-					rdmsr (MSR_VIA_FCR, lo, hi);
-					lo |= (1<<1 | 1<<7);	/* Report CX8 & enable PGE */
-					wrmsr (MSR_VIA_FCR, lo, hi);
-
-					set_bit(X86_FEATURE_CX8, c->x86_capability);
-					set_bit(X86_FEATURE_3DNOW, c->x86_capability);
-
-				case 9:	/* Nehemiah */
-				default:
-					get_model_name(c);
-					display_cacheinfo(c);
-					break;
-			}
+			init_c3(c);
 			break;
 	}
 }
diff -Nru a/arch/i386/kernel/cpu/common.c b/arch/i386/kernel/cpu/common.c
--- a/arch/i386/kernel/cpu/common.c	Thu Mar 13 18:52:54 2003
+++ b/arch/i386/kernel/cpu/common.c	Thu Mar 13 18:52:54 2003
@@ -211,9 +211,10 @@
 	
 		/* Intel-defined flags: level 0x00000001 */
 		if ( c->cpuid_level >= 0x00000001 ) {
-			u32 capability;
-			cpuid(0x00000001, &tfms, &junk, &junk, &capability);
+			u32 capability, excap;
+			cpuid(0x00000001, &tfms, &junk, &excap, &capability);
 			c->x86_capability[0] = capability;
+			c->x86_capability[4] = excap;
 			c->x86 = (tfms >> 8) & 15;
 			c->x86_model = (tfms >> 4) & 15;
 			c->x86_mask = tfms & 15;
diff -Nru a/arch/i386/kernel/cpu/proc.c b/arch/i386/kernel/cpu/proc.c
--- a/arch/i386/kernel/cpu/proc.c	Thu Mar 13 18:52:54 2003
+++ b/arch/i386/kernel/cpu/proc.c	Thu Mar 13 18:52:54 2003
@@ -37,7 +37,20 @@
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
+		"pni", NULL, NULL, "monitor", "ds_cpl", NULL, NULL, NULL,
+		"tm2", NULL, "cnxt_id", NULL, NULL, NULL, NULL, NULL,
+		NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
+		NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
+
+		/* VIA/Cyrix/Centaur-defined */
+		NULL, NULL, "xstore", NULL, NULL, NULL, NULL, NULL,
 		NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
 		NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
 		NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
diff -Nru a/include/asm-i386/cpufeature.h b/include/asm-i386/cpufeature.h
--- a/include/asm-i386/cpufeature.h	Thu Mar 13 18:52:54 2003
+++ b/include/asm-i386/cpufeature.h	Thu Mar 13 18:52:54 2003
@@ -9,9 +9,9 @@
 
 #include <linux/bitops.h>
 
-#define NCAPINTS	4	/* Currently we have 4 32-bit words worth of info */
+#define NCAPINTS	6	/* Currently we have 6 32-bit words worth of info */
 
-/* Intel-defined CPU features, CPUID level 0x00000001, word 0 */
+/* Intel-defined CPU features, CPUID level 0x00000001 (edx), word 0 */
 #define X86_FEATURE_FPU		(0*32+ 0) /* Onboard FPU */
 #define X86_FEATURE_VME		(0*32+ 1) /* Virtual Mode Extensions */
 #define X86_FEATURE_DE		(0*32+ 2) /* Debugging Extensions */
@@ -64,6 +64,11 @@
 #define X86_FEATURE_CYRIX_ARR	(3*32+ 2) /* Cyrix ARRs (= MTRRs) */
 #define X86_FEATURE_CENTAUR_MCR	(3*32+ 3) /* Centaur MCRs (= MTRRs) */
 
+/* Intel-defined CPU features, CPUID level 0x00000001 (ecx), word 4 */
+
+/* VIA/Cyrix/Centaur-defined CPU features, CPUID level 0xC0000001, word 5 */
+#define X86_FEATURE_XSTORE	(5*32+ 2) /* on-CPU RNG present (xstore insn) */
+
 
 #define cpu_has(c, bit)		test_bit(bit, (c)->x86_capability)
 #define boot_cpu_has(bit)	test_bit(bit, boot_cpu_data.x86_capability)
@@ -87,6 +92,7 @@
 #define cpu_has_k6_mtrr		boot_cpu_has(X86_FEATURE_K6_MTRR)
 #define cpu_has_cyrix_arr	boot_cpu_has(X86_FEATURE_CYRIX_ARR)
 #define cpu_has_centaur_mcr	boot_cpu_has(X86_FEATURE_CENTAUR_MCR)
+#define cpu_has_xstore		boot_cpu_has(X86_FEATURE_XSTORE)
 
 #endif /* __ASM_I386_CPUFEATURE_H */
 
diff -Nru a/include/asm-i386/msr.h b/include/asm-i386/msr.h
--- a/include/asm-i386/msr.h	Thu Mar 13 18:52:54 2003
+++ b/include/asm-i386/msr.h	Thu Mar 13 18:52:54 2003
@@ -218,6 +218,7 @@
 /* VIA Cyrix defined MSRs*/
 #define MSR_VIA_FCR			0x1107
 #define MSR_VIA_LONGHAUL		0x110a
+#define MSR_VIA_RNG			0x110b
 #define MSR_VIA_BCR2			0x1147
 
 /* Transmeta defined MSRs */

--------------000305010403050303030903--

