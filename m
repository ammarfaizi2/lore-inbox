Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266591AbUHOLVw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266591AbUHOLVw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Aug 2004 07:21:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266582AbUHOLVk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Aug 2004 07:21:40 -0400
Received: from aun.it.uu.se ([130.238.12.36]:40389 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S266622AbUHOLQP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Aug 2004 07:16:15 -0400
Date: Sun, 15 Aug 2004 13:16:09 +0200 (MEST)
Message-Id: <200408151116.i7FBG9ds029029@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.linuxppc.org
Subject: [PATCH][2.4.27] PowerPC 745x data corruption bug fix
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes a data corruption bug affecting 745x
PowerPC processors. The patch is a backport from 2.6.8
to 2.4.27. (I believe the original author is Adrian Cox.)

The impact of the bug can be spectacular. On my G3 with
a 7455 upgrade processor, it caused DMA timeouts and
data corruption on reads with a PDC20269 IDE controller
card, and DMA timeouts and complete system hangs with a
PDC20267 IDE controller card.

/Mikael Pettersson

diff -ruN linux-2.4.27/arch/ppc/kernel/cputable.c linux-2.4.27.ppc-coherent-fix/arch/ppc/kernel/cputable.c
--- linux-2.4.27/arch/ppc/kernel/cputable.c	2004-04-14 20:22:20.000000000 +0200
+++ linux-2.4.27.ppc-coherent-fix/arch/ppc/kernel/cputable.c	2004-08-15 12:04:31.770016000 +0200
@@ -51,10 +51,20 @@
 #define CPU_FTR_ALTIVEC_COMP	0
 #endif
 
+/* We need to mark all pages as being coherent if we're SMP or we
+ * have a 754x and an MPC107 host bridge.
+ */
+#if defined(CONFIG_SMP) || defined(CONFIG_MPC10X_BRIDGE)
+#define CPU_FTR_COMMON                  CPU_FTR_NEED_COHERENT
+#else
+#define CPU_FTR_COMMON                  0
+#endif
+
 struct cpu_spec	cpu_specs[] = {
 #if CLASSIC_PPC
     { 	/* 601 */
 	0xffff0000, 0x00010000, "601",
+	CPU_FTR_COMMON |
 	CPU_FTR_601 | CPU_FTR_HPTE_TABLE,
 	COMMON_PPC | PPC_FEATURE_601_INSTR | PPC_FEATURE_UNIFIED_CACHE,
 	32, 32,
@@ -62,6 +72,7 @@
     },
     {	/* 603 */
     	0xffff0000, 0x00030000, "603",
+	CPU_FTR_COMMON |
     	CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_CAN_DOZE | CPU_FTR_USE_TB |
     	CPU_FTR_CAN_NAP,
 	COMMON_PPC,
@@ -70,6 +81,7 @@
     },
     {	/* 603e */
     	0xffff0000, 0x00060000, "603e",
+	CPU_FTR_COMMON |
     	CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_CAN_DOZE | CPU_FTR_USE_TB |
     	CPU_FTR_CAN_NAP,
 	COMMON_PPC,
@@ -78,6 +90,7 @@
     },
     {	/* 603ev */
     	0xffff0000, 0x00070000, "603ev",
+	CPU_FTR_COMMON |
     	CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_CAN_DOZE | CPU_FTR_USE_TB |
     	CPU_FTR_CAN_NAP,
 	COMMON_PPC,
@@ -86,6 +99,7 @@
     },
     {	/* 604 */
     	0xffff0000, 0x00040000, "604",
+	CPU_FTR_COMMON |
     	CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB | CPU_FTR_604_PERF_MON |
 	CPU_FTR_HPTE_TABLE,
 	COMMON_PPC,
@@ -94,6 +108,7 @@
     },
     {	/* 604e */
     	0xfffff000, 0x00090000, "604e",
+	CPU_FTR_COMMON |
     	CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB | CPU_FTR_604_PERF_MON |
 	CPU_FTR_HPTE_TABLE,
 	COMMON_PPC,
@@ -102,6 +117,7 @@
     },
     {	/* 604r */
     	0xffff0000, 0x00090000, "604r",
+	CPU_FTR_COMMON |
     	CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB | CPU_FTR_604_PERF_MON |
 	CPU_FTR_HPTE_TABLE,
 	COMMON_PPC,
@@ -110,6 +126,7 @@
     },
     {	/* 604ev */
     	0xffff0000, 0x000a0000, "604ev",
+	CPU_FTR_COMMON |
     	CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB | CPU_FTR_604_PERF_MON |
 	CPU_FTR_HPTE_TABLE,
 	COMMON_PPC,
@@ -118,6 +135,7 @@
     },
     {	/* 740/750 (0x4202, don't support TAU ?) */
     	0xffffffff, 0x00084202, "740/750",
+	CPU_FTR_COMMON |
     	CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_CAN_DOZE | CPU_FTR_USE_TB |
 	CPU_FTR_L2CR | CPU_FTR_HPTE_TABLE | CPU_FTR_CAN_NAP,
 	COMMON_PPC,
@@ -126,6 +144,7 @@
     },
     {	/* 745/755 */
     	0xfffff000, 0x00083000, "745/755",
+	CPU_FTR_COMMON |
     	CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_CAN_DOZE | CPU_FTR_USE_TB |
 	CPU_FTR_L2CR | CPU_FTR_TAU | CPU_FTR_HPTE_TABLE | CPU_FTR_CAN_NAP,
 	COMMON_PPC,
@@ -134,6 +153,7 @@
     },
     {	/* 750CX */
     	0xffffff00, 0x00082200, "750CX",
+	CPU_FTR_COMMON |
     	CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_CAN_DOZE | CPU_FTR_USE_TB |
 	CPU_FTR_L2CR | CPU_FTR_TAU | CPU_FTR_HPTE_TABLE | CPU_FTR_CAN_NAP,
 	COMMON_PPC,
@@ -142,6 +162,7 @@
     },
     {	/* 750FX rev 1.x */
     	0xffffff00, 0x70000100, "750FX",
+	CPU_FTR_COMMON |
     	CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_CAN_DOZE | CPU_FTR_USE_TB |
 	CPU_FTR_L2CR | CPU_FTR_TAU | CPU_FTR_HPTE_TABLE | CPU_FTR_CAN_NAP |
 	CPU_FTR_750FX | CPU_FTR_NO_DPM,
@@ -151,6 +172,7 @@
     },
     {	/* 750FX rev 2.0 must disable HID0[DPM] */
     	0xffffffff, 0x70000200, "750FX",
+	CPU_FTR_COMMON |
     	CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_CAN_DOZE | CPU_FTR_USE_TB |
 	CPU_FTR_L2CR | CPU_FTR_TAU | CPU_FTR_HPTE_TABLE | CPU_FTR_CAN_NAP |
 	CPU_FTR_750FX | CPU_FTR_HAS_HIGH_BATS | CPU_FTR_NO_DPM,
@@ -160,6 +182,7 @@
     },
     {	/* 750FX (All revs > 2.0) */
     	0xffff0000, 0x70000000, "750FX",
+	CPU_FTR_COMMON |
     	CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_CAN_DOZE | CPU_FTR_USE_TB |
 	CPU_FTR_L2CR | CPU_FTR_TAU | CPU_FTR_HPTE_TABLE | CPU_FTR_CAN_NAP |
 	CPU_FTR_750FX | CPU_FTR_HAS_HIGH_BATS,
@@ -169,6 +192,7 @@
     },
     {	/* 740/750 (L2CR bit need fixup for 740) */
     	0xffff0000, 0x00080000, "740/750",
+	CPU_FTR_COMMON |
     	CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_CAN_DOZE | CPU_FTR_USE_TB |
 	CPU_FTR_L2CR | CPU_FTR_TAU | CPU_FTR_HPTE_TABLE | CPU_FTR_CAN_NAP,
 	COMMON_PPC,
@@ -177,6 +201,7 @@
     },
     {	/* 7400 rev 1.1 ? (no TAU) */
     	0xffffffff, 0x000c1101, "7400 (1.1)",
+	CPU_FTR_COMMON |
     	CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_CAN_DOZE | CPU_FTR_USE_TB |
 	CPU_FTR_L2CR | CPU_FTR_ALTIVEC_COMP | CPU_FTR_HPTE_TABLE |
 	CPU_FTR_CAN_NAP,
@@ -186,6 +211,7 @@
     },
     {	/* 7400 */
     	0xffff0000, 0x000c0000, "7400",
+	CPU_FTR_COMMON |
     	CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_CAN_DOZE | CPU_FTR_USE_TB |
 	CPU_FTR_L2CR | CPU_FTR_TAU | CPU_FTR_ALTIVEC_COMP | CPU_FTR_HPTE_TABLE |
 	CPU_FTR_CAN_NAP,
@@ -195,6 +221,7 @@
     },
     {	/* 7410 */
     	0xffff0000, 0x800c0000, "7410",
+	CPU_FTR_COMMON |
     	CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_CAN_DOZE | CPU_FTR_USE_TB |
 	CPU_FTR_L2CR | CPU_FTR_TAU | CPU_FTR_ALTIVEC_COMP | CPU_FTR_HPTE_TABLE |
 	CPU_FTR_CAN_NAP,
@@ -204,82 +231,104 @@
     },
     {	/* 7450 1.x - no doze/nap */
     	0xffffff00, 0x80000100, "7450",
+	CPU_FTR_COMMON |
     	CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB |
 	CPU_FTR_L2CR | CPU_FTR_ALTIVEC_COMP | CPU_FTR_L3CR |
-	CPU_FTR_HPTE_TABLE | CPU_FTR_SPEC7450,
+	CPU_FTR_HPTE_TABLE | CPU_FTR_SPEC7450 | CPU_FTR_NEED_COHERENT,
 	COMMON_PPC | PPC_FEATURE_HAS_ALTIVEC,
 	32, 32,
 	__setup_cpu_745x
     },
     {	/* 7450 2.0 - no doze/nap */
     	0xffffffff, 0x80000200, "7450",
+	CPU_FTR_COMMON |
     	CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB |
 	CPU_FTR_L2CR | CPU_FTR_ALTIVEC_COMP | CPU_FTR_L3CR |
-	CPU_FTR_HPTE_TABLE | CPU_FTR_SPEC7450,
+	CPU_FTR_HPTE_TABLE | CPU_FTR_SPEC7450 | CPU_FTR_NEED_COHERENT,
 	COMMON_PPC | PPC_FEATURE_HAS_ALTIVEC,
 	32, 32,
 	__setup_cpu_745x
     },
     {	/* 7450 2.1 */
     	0xffffffff, 0x80000201, "7450",
+	CPU_FTR_COMMON |
     	CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB | CPU_FTR_CAN_NAP |
 	CPU_FTR_L2CR | CPU_FTR_ALTIVEC_COMP | CPU_FTR_L3CR |
 	CPU_FTR_HPTE_TABLE | CPU_FTR_SPEC7450 | CPU_FTR_NAP_DISABLE_L2_PR |
-	CPU_FTR_L3_DISABLE_NAP,
+	CPU_FTR_L3_DISABLE_NAP | CPU_FTR_NEED_COHERENT,
 	COMMON_PPC | PPC_FEATURE_HAS_ALTIVEC,
 	32, 32,
 	__setup_cpu_745x
     },
     {	/* 7450 2.3 and newer */
     	0xffff0000, 0x80000000, "7450",
+	CPU_FTR_COMMON |
     	CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB | CPU_FTR_CAN_NAP |
 	CPU_FTR_L2CR | CPU_FTR_ALTIVEC_COMP | CPU_FTR_L3CR |
-	CPU_FTR_HPTE_TABLE | CPU_FTR_SPEC7450 | CPU_FTR_NAP_DISABLE_L2_PR,
+	CPU_FTR_HPTE_TABLE | CPU_FTR_SPEC7450 | CPU_FTR_NAP_DISABLE_L2_PR |
+	CPU_FTR_NEED_COHERENT,
 	COMMON_PPC | PPC_FEATURE_HAS_ALTIVEC,
 	32, 32,
 	__setup_cpu_745x
     },
     {	/* 7455 rev 1.x */
     	0xffffff00, 0x80010100, "7455",
+	CPU_FTR_COMMON |
     	CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB |
 	CPU_FTR_L2CR | CPU_FTR_ALTIVEC_COMP | CPU_FTR_L3CR |
-	CPU_FTR_HPTE_TABLE | CPU_FTR_SPEC7450 | CPU_FTR_HAS_HIGH_BATS,
+	CPU_FTR_HPTE_TABLE | CPU_FTR_SPEC7450 | CPU_FTR_HAS_HIGH_BATS |
+	CPU_FTR_NEED_COHERENT,
 	COMMON_PPC | PPC_FEATURE_HAS_ALTIVEC,
 	32, 32,
 	__setup_cpu_745x
     },
     {	/* 7455 rev 2.0 */
     	0xffffffff, 0x80010200, "7455",
+	CPU_FTR_COMMON |
     	CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB | CPU_FTR_CAN_NAP |
 	CPU_FTR_L2CR | CPU_FTR_ALTIVEC_COMP | CPU_FTR_L3CR |
 	CPU_FTR_HPTE_TABLE | CPU_FTR_SPEC7450 | CPU_FTR_NAP_DISABLE_L2_PR |
-	CPU_FTR_L3_DISABLE_NAP | CPU_FTR_HAS_HIGH_BATS,
+	CPU_FTR_L3_DISABLE_NAP | CPU_FTR_NEED_COHERENT | CPU_FTR_HAS_HIGH_BATS,
 	COMMON_PPC | PPC_FEATURE_HAS_ALTIVEC,
 	32, 32,
 	__setup_cpu_745x
     },
     {	/* 7455 others */
     	0xffff0000, 0x80010000, "7455",
+	CPU_FTR_COMMON |
     	CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB | CPU_FTR_CAN_NAP |
 	CPU_FTR_L2CR | CPU_FTR_ALTIVEC_COMP | CPU_FTR_L3CR |
 	CPU_FTR_HPTE_TABLE | CPU_FTR_SPEC7450 | CPU_FTR_NAP_DISABLE_L2_PR |
-	CPU_FTR_HAS_HIGH_BATS,
+	CPU_FTR_HAS_HIGH_BATS | CPU_FTR_NEED_COHERENT,
 	COMMON_PPC | PPC_FEATURE_HAS_ALTIVEC,
 	32, 32,
 	__setup_cpu_745x
     },
     {	/* 7457 */
     	0xffff0000, 0x80020000, "7457",
+	CPU_FTR_COMMON |
     	CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB | CPU_FTR_CAN_NAP |
 	CPU_FTR_L2CR | CPU_FTR_ALTIVEC_COMP | CPU_FTR_L3CR |
 	CPU_FTR_HPTE_TABLE | CPU_FTR_SPEC7450 | CPU_FTR_NAP_DISABLE_L2_PR |
-	CPU_FTR_HAS_HIGH_BATS,
+	CPU_FTR_HAS_HIGH_BATS | CPU_FTR_NEED_COHERENT,
 	COMMON_PPC | PPC_FEATURE_HAS_ALTIVEC,
 	32, 32,
 	__setup_cpu_745x
     },
+    {	/* 7447A */
+    	0xffff0000, 0x80030000, "7447A",
+	CPU_FTR_COMMON |
+    	CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB | CPU_FTR_CAN_NAP |
+	CPU_FTR_L2CR | CPU_FTR_ALTIVEC_COMP |
+	CPU_FTR_HPTE_TABLE | CPU_FTR_SPEC7450 | CPU_FTR_NAP_DISABLE_L2_PR |
+	CPU_FTR_HAS_HIGH_BATS | CPU_FTR_NEED_COHERENT,
+	COMMON_PPC | PPC_FEATURE_HAS_ALTIVEC,
+	32, 32,
+	__setup_cpu_745x
+    },
     {	/* 82xx (8240, 8245, 8260 are all 603e cores) */
 	0x7fff0000, 0x00810000, "82xx",
+	CPU_FTR_COMMON |
 	CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_CAN_DOZE | CPU_FTR_USE_TB,
 	COMMON_PPC,
 	32, 32,
@@ -295,6 +344,7 @@
     },
     {	/* default match, we assume split I/D cache & TB (non-601)... */
     	0x00000000, 0x00000000, "(generic PPC)",
+	CPU_FTR_COMMON |
     	CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB | CPU_FTR_HPTE_TABLE,
 	COMMON_PPC,
 	32, 32,
@@ -304,6 +354,7 @@
 #ifdef CONFIG_PPC64BRIDGE
     {	/* Power3 */
     	0xffff0000, 0x00400000, "Power3 (630)",
+	CPU_FTR_COMMON |
     	CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB | CPU_FTR_HPTE_TABLE,
     	COMMON_PPC | PPC_FEATURE_64,
 	128, 128,
@@ -311,6 +362,7 @@
     },
     {	/* Power3+ */
     	0xffff0000, 0x00410000, "Power3 (630+)",
+	CPU_FTR_COMMON |
     	CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB | CPU_FTR_HPTE_TABLE,
     	COMMON_PPC | PPC_FEATURE_64,
 	128, 128,
@@ -318,6 +370,7 @@
     },
 	{	/* I-star */
 		0xffff0000, 0x00360000, "I-star",
+		CPU_FTR_COMMON |
 		CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB | CPU_FTR_HPTE_TABLE,
 		COMMON_PPC | PPC_FEATURE_64,
 		128, 128,
@@ -325,6 +378,7 @@
 	},
 	{	/* S-star */
 		0xffff0000, 0x00370000, "S-star",
+		CPU_FTR_COMMON |
 		CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB | CPU_FTR_HPTE_TABLE,
 		COMMON_PPC | PPC_FEATURE_64,
 		128, 128,
@@ -334,6 +388,7 @@
 #ifdef CONFIG_POWER4
     {	/* Power4 */
     	0xffff0000, 0x00350000, "Power4",
+	CPU_FTR_COMMON |
     	CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB | CPU_FTR_HPTE_TABLE,
     	COMMON_PPC | PPC_FEATURE_64,
 	128, 128,
@@ -341,6 +396,7 @@
     },
     {	/* PPC970 */
 	0xffff0000, 0x00390000, "PPC970",
+	CPU_FTR_COMMON |
 	CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB | CPU_FTR_HPTE_TABLE |
 	CPU_FTR_ALTIVEC_COMP | CPU_FTR_CAN_NAP,
 	COMMON_PPC | PPC_FEATURE_64 | PPC_FEATURE_HAS_ALTIVEC,
@@ -435,7 +491,7 @@
 #if !CLASSIC_PPC
     {	/* default match */
     	0x00000000, 0x00000000, "(generic PPC)",
-    	0,
+	CPU_FTR_COMMON,
     	PPC_FEATURE_32,
 	32, 32,
 	0,
diff -ruN linux-2.4.27/arch/ppc/mm/hashtable.S linux-2.4.27.ppc-coherent-fix/arch/ppc/mm/hashtable.S
--- linux-2.4.27/arch/ppc/mm/hashtable.S	2003-08-25 20:07:42.000000000 +0200
+++ linux-2.4.27.ppc-coherent-fix/arch/ppc/mm/hashtable.S	2004-08-15 12:04:31.770016000 +0200
@@ -327,9 +327,9 @@
 	rlwimi	r5,r5,32-2,31,31	/* _PAGE_USER -> PP lsb */
 	ori	r8,r8,0xe14		/* clear out reserved bits and M */
 	andc	r8,r5,r8		/* PP = user? (rw&dirty? 2: 3): 0 */
-#ifdef CONFIG_SMP
+BEGIN_FTR_SECTION
 	ori	r8,r8,_PAGE_COHERENT	/* set M (coherence required) */
-#endif
+END_FTR_SECTION_IFSET(CPU_FTR_NEED_COHERENT)
 
 	/* Construct the high word of the PPC-style PTE (r5) */
 #ifndef CONFIG_PPC64BRIDGE
diff -ruN linux-2.4.27/arch/ppc/mm/ppc_mmu.c linux-2.4.27.ppc-coherent-fix/arch/ppc/mm/ppc_mmu.c
--- linux-2.4.27/arch/ppc/mm/ppc_mmu.c	2003-11-29 00:28:11.000000000 +0100
+++ linux-2.4.27.ppc-coherent-fix/arch/ppc/mm/ppc_mmu.c	2004-08-15 12:04:31.770016000 +0200
@@ -106,10 +106,10 @@
 	int wimgxpp;
 	union ubat *bat = BATS[index];
 
-#ifdef CONFIG_SMP
-	if ((flags & _PAGE_NO_CACHE) == 0)
+	if (((flags & _PAGE_NO_CACHE) == 0) &&
+	    (cur_cpu_spec[0]->cpu_features & CPU_FTR_NEED_COHERENT))
 		flags |= _PAGE_COHERENT;
-#endif
+
 	bl = (size >> 17) - 1;
 	if (PVR_VER(mfspr(PVR)) != 1) {
 		/* 603, 604, etc. */
diff -ruN linux-2.4.27/include/asm-ppc/cputable.h linux-2.4.27.ppc-coherent-fix/include/asm-ppc/cputable.h
--- linux-2.4.27/include/asm-ppc/cputable.h	2004-02-18 15:16:24.000000000 +0100
+++ linux-2.4.27.ppc-coherent-fix/include/asm-ppc/cputable.h	2004-08-15 12:04:31.770016000 +0200
@@ -75,6 +75,7 @@
 #define CPU_FTR_750FX			0x00004000
 #define CPU_FTR_NO_DPM			0x00008000
 #define CPU_FTR_HAS_HIGH_BATS		0x00010000
+#define CPU_FTR_NEED_COHERENT           0x00020000
 
 #ifdef __ASSEMBLY__
 
