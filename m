Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262002AbUKJCiK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262002AbUKJCiK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 21:38:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262001AbUKJCiK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 21:38:10 -0500
Received: from motgate8.mot.com ([129.188.136.8]:36561 "EHLO motgate8.mot.com")
	by vger.kernel.org with ESMTP id S262002AbUKJCbC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 21:31:02 -0500
Date: Tue, 9 Nov 2004 20:30:43 -0600 (CST)
From: Kumar Gala <galak@somerset.sps.mot.com>
To: akpm@osdl.org
cc: paulus@samba.org, linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH][PPC32] Update cpu_spec for performance monitor counters,
 C99, and e500 userland CPU features
Message-ID: <Pine.LNX.4.61.0411092016370.16462@blarg.somerset.sps.mot.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

This patch replaces the previous patch for adding performance monitor 
counters to cpu_spec.

-

Adds the number of performance monitor counters on each PowerPC processor 
has to the cpu table.  Makes oprofile support a bit cleaner since we dont 
need a case statement on processor version to determine the number of 
counters.

Reformatted cpu_spec to use C99 initialization.

Added userland CPU features for SPE, Embedded Floating Point Single 
precision, and Embedded Floating Point Double precision on e500.

Signed-off-by: Kumar Gala <kumar.gala@freescale.com> 

--
diff -Nru a/arch/ppc/kernel/cputable.c b/arch/ppc/kernel/cputable.c
--- a/arch/ppc/kernel/cputable.c	2004-11-09 20:14:49 -06:00
+++ b/arch/ppc/kernel/cputable.c	2004-11-09 20:14:49 -06:00
@@ -48,12 +48,21 @@
  */
 #ifdef CONFIG_ALTIVEC
 #define CPU_FTR_ALTIVEC_COMP		CPU_FTR_ALTIVEC
-#define PPC_FEATURE_ALTIVEC_COMP    	PPC_FEATURE_HAS_ALTIVEC  
+#define PPC_FEATURE_ALTIVEC_COMP    	PPC_FEATURE_HAS_ALTIVEC
 #else
 #define CPU_FTR_ALTIVEC_COMP		0
 #define PPC_FEATURE_ALTIVEC_COMP       	0
 #endif
 
+/* We only set the spe features if the kernel was compiled with
+ * spe support
+ */
+#ifdef CONFIG_SPE
+#define PPC_FEATURE_SPE_COMP    	PPC_FEATURE_HAS_SPE
+#else
+#define PPC_FEATURE_SPE_COMP       	0
+#endif
+
 /* We need to mark all pages as being coherent if we're SMP or we
  * have a 74[45]x and an MPC107 host bridge.
  */
@@ -76,555 +85,875 @@
 
 struct cpu_spec	cpu_specs[] = {
 #if CLASSIC_PPC
-    { 	/* 601 */
-	0xffff0000, 0x00010000, "601",
-	CPU_FTR_COMMON |
-	CPU_FTR_601 | CPU_FTR_HPTE_TABLE,
-	COMMON_PPC | PPC_FEATURE_601_INSTR | PPC_FEATURE_UNIFIED_CACHE,
-	32, 32,
-	__setup_cpu_601
-    },
-    {	/* 603 */
-    	0xffff0000, 0x00030000, "603",
-	CPU_FTR_COMMON |
-    	CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_MAYBE_CAN_DOZE | CPU_FTR_USE_TB |
-    	CPU_FTR_MAYBE_CAN_NAP,
-	COMMON_PPC,
-    	32, 32,
-	__setup_cpu_603
-    },
-    {	/* 603e */
-    	0xffff0000, 0x00060000, "603e",
-	CPU_FTR_COMMON |
-    	CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_MAYBE_CAN_DOZE | CPU_FTR_USE_TB |
-    	CPU_FTR_MAYBE_CAN_NAP,
-	COMMON_PPC,
-	32, 32,
-	__setup_cpu_603
-    },
-    {	/* 603ev */
-    	0xffff0000, 0x00070000, "603ev",
-	CPU_FTR_COMMON |
-    	CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_MAYBE_CAN_DOZE | CPU_FTR_USE_TB |
-    	CPU_FTR_MAYBE_CAN_NAP,
-	COMMON_PPC,
-	32, 32,
-	__setup_cpu_603
-    },
-    {	/* 604 */
-    	0xffff0000, 0x00040000, "604",
-	CPU_FTR_COMMON |
-    	CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB | CPU_FTR_604_PERF_MON |
-	CPU_FTR_HPTE_TABLE,
-	COMMON_PPC,
-	32, 32,
-	__setup_cpu_604
-    },
-    {	/* 604e */
-    	0xfffff000, 0x00090000, "604e",
-	CPU_FTR_COMMON |
-    	CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB | CPU_FTR_604_PERF_MON |
-	CPU_FTR_HPTE_TABLE,
-	COMMON_PPC,
-	32, 32,
-	__setup_cpu_604
-    },
-    {	/* 604r */
-    	0xffff0000, 0x00090000, "604r",
-	CPU_FTR_COMMON |
-    	CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB | CPU_FTR_604_PERF_MON |
-	CPU_FTR_HPTE_TABLE,
-	COMMON_PPC,
-	32, 32,
-	__setup_cpu_604
-    },
-    {	/* 604ev */
-    	0xffff0000, 0x000a0000, "604ev",
-	CPU_FTR_COMMON |
-    	CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB | CPU_FTR_604_PERF_MON |
-	CPU_FTR_HPTE_TABLE,
-	COMMON_PPC,
-	32, 32,
-	__setup_cpu_604
-    },
-    {	/* 740/750 (0x4202, don't support TAU ?) */
-    	0xffffffff, 0x00084202, "740/750",
-	CPU_FTR_COMMON |
-    	CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_MAYBE_CAN_DOZE | CPU_FTR_USE_TB |
-	CPU_FTR_L2CR | CPU_FTR_HPTE_TABLE | CPU_FTR_MAYBE_CAN_NAP,
-	COMMON_PPC,
-	32, 32,
-	__setup_cpu_750
-    },
-    {	/* 745/755 */
-    	0xfffff000, 0x00083000, "745/755",
-	CPU_FTR_COMMON |
-    	CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_MAYBE_CAN_DOZE | CPU_FTR_USE_TB |
-	CPU_FTR_L2CR | CPU_FTR_TAU | CPU_FTR_HPTE_TABLE | CPU_FTR_MAYBE_CAN_NAP,
-	COMMON_PPC,
-	32, 32,
-	__setup_cpu_750
-    },
-    {	/* 750CX (80100 and 8010x?) */
-    	0xfffffff0, 0x00080100, "750CX",
-	CPU_FTR_COMMON |
-    	CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_MAYBE_CAN_DOZE | CPU_FTR_USE_TB |
-	CPU_FTR_L2CR | CPU_FTR_TAU | CPU_FTR_HPTE_TABLE | CPU_FTR_MAYBE_CAN_NAP,
-	COMMON_PPC,
-	32, 32,
-	__setup_cpu_750cx
-    },
-    {	/* 750CX (82201 and 82202) */
-    	0xfffffff0, 0x00082200, "750CX",
-	CPU_FTR_COMMON |
-    	CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_MAYBE_CAN_DOZE | CPU_FTR_USE_TB |
-	CPU_FTR_L2CR | CPU_FTR_TAU | CPU_FTR_HPTE_TABLE | CPU_FTR_MAYBE_CAN_NAP,
-	COMMON_PPC,
-	32, 32,
-	__setup_cpu_750cx
-    },
-    {	/* 750CXe (82214) */
-    	0xfffffff0, 0x00082210, "750CXe",
-	CPU_FTR_COMMON |
-    	CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_MAYBE_CAN_DOZE | CPU_FTR_USE_TB |
-	CPU_FTR_L2CR | CPU_FTR_TAU | CPU_FTR_HPTE_TABLE | CPU_FTR_MAYBE_CAN_NAP,
-	COMMON_PPC,
-	32, 32,
-	__setup_cpu_750cx
-    },
-    {	/* 750FX rev 1.x */
-    	0xffffff00, 0x70000100, "750FX",
-	CPU_FTR_COMMON |
-    	CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_MAYBE_CAN_DOZE | CPU_FTR_USE_TB |
-	CPU_FTR_L2CR | CPU_FTR_TAU | CPU_FTR_HPTE_TABLE | CPU_FTR_MAYBE_CAN_NAP |
-	CPU_FTR_DUAL_PLL_750FX | CPU_FTR_NO_DPM,
-	COMMON_PPC,
-	32, 32,
-	__setup_cpu_750
-    },
-    {	/* 750FX rev 2.0 must disable HID0[DPM] */
-    	0xffffffff, 0x70000200, "750FX",
-	CPU_FTR_COMMON |
-    	CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_MAYBE_CAN_DOZE | CPU_FTR_USE_TB |
-	CPU_FTR_L2CR | CPU_FTR_TAU | CPU_FTR_HPTE_TABLE | CPU_FTR_MAYBE_CAN_NAP |
-	CPU_FTR_NO_DPM,
-	COMMON_PPC,
-	32, 32,
-	__setup_cpu_750
-    },
-    {	/* 750FX (All revs except 2.0) */
-    	0xffff0000, 0x70000000, "750FX",
-	CPU_FTR_COMMON |
-    	CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_MAYBE_CAN_DOZE | CPU_FTR_USE_TB |
-	CPU_FTR_L2CR | CPU_FTR_TAU | CPU_FTR_HPTE_TABLE | CPU_FTR_MAYBE_CAN_NAP |
-	CPU_FTR_DUAL_PLL_750FX | CPU_FTR_HAS_HIGH_BATS,
-	COMMON_PPC,
-	32, 32,
-	__setup_cpu_750fx
-    },
-    {	/* 750GX */
-    	0xffff0000, 0x70020000, "750GX",
-    	CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_MAYBE_CAN_DOZE | CPU_FTR_USE_TB |
-	CPU_FTR_L2CR | CPU_FTR_TAU | CPU_FTR_HPTE_TABLE | CPU_FTR_MAYBE_CAN_NAP |
-	CPU_FTR_DUAL_PLL_750FX | CPU_FTR_HAS_HIGH_BATS,
-	COMMON_PPC,
-	32, 32,
-	__setup_cpu_750fx
-    },
-    {	/* 740/750 (L2CR bit need fixup for 740) */
-    	0xffff0000, 0x00080000, "740/750",
-	CPU_FTR_COMMON |
-    	CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_MAYBE_CAN_DOZE | CPU_FTR_USE_TB |
-	CPU_FTR_L2CR | CPU_FTR_TAU | CPU_FTR_HPTE_TABLE | CPU_FTR_MAYBE_CAN_NAP,
-	COMMON_PPC,
-	32, 32,
-	__setup_cpu_750
-    },
-    {	/* 7400 rev 1.1 ? (no TAU) */
-    	0xffffffff, 0x000c1101, "7400 (1.1)",
-	CPU_FTR_COMMON |
-    	CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_MAYBE_CAN_DOZE | CPU_FTR_USE_TB |
-	CPU_FTR_L2CR | CPU_FTR_ALTIVEC_COMP | CPU_FTR_HPTE_TABLE |
-	CPU_FTR_MAYBE_CAN_NAP,
-	COMMON_PPC | PPC_FEATURE_ALTIVEC_COMP,
-	32, 32,
-	__setup_cpu_7400
-    },
-    {	/* 7400 */
-    	0xffff0000, 0x000c0000, "7400",
-	CPU_FTR_COMMON |
-    	CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_MAYBE_CAN_DOZE | CPU_FTR_USE_TB |
-	CPU_FTR_L2CR | CPU_FTR_TAU | CPU_FTR_ALTIVEC_COMP | CPU_FTR_HPTE_TABLE |
-	CPU_FTR_MAYBE_CAN_NAP,
-	COMMON_PPC | PPC_FEATURE_ALTIVEC_COMP,
-	32, 32,
-	__setup_cpu_7400
-    },
-    {	/* 7410 */
-    	0xffff0000, 0x800c0000, "7410",
-	CPU_FTR_COMMON |
-    	CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_MAYBE_CAN_DOZE | CPU_FTR_USE_TB |
-	CPU_FTR_L2CR | CPU_FTR_TAU | CPU_FTR_ALTIVEC_COMP | CPU_FTR_HPTE_TABLE |
-	CPU_FTR_MAYBE_CAN_NAP,
-	COMMON_PPC | PPC_FEATURE_ALTIVEC_COMP,
-	32, 32,
-	__setup_cpu_7410
-    },
-    {	/* 7450 2.0 - no doze/nap */
-    	0xffffffff, 0x80000200, "7450",
-	CPU_FTR_COMMON |
-    	CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB |
-	CPU_FTR_L2CR | CPU_FTR_ALTIVEC_COMP | CPU_FTR_L3CR |
-	CPU_FTR_HPTE_TABLE | CPU_FTR_SPEC7450 | CPU_FTR_NEED_COHERENT,
-	COMMON_PPC | PPC_FEATURE_ALTIVEC_COMP,
-	32, 32,
-	__setup_cpu_745x
-    },
-    {	/* 7450 2.1 */
-    	0xffffffff, 0x80000201, "7450",
-	CPU_FTR_COMMON |
-    	CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB | CPU_FTR_MAYBE_CAN_NAP |
-	CPU_FTR_L2CR | CPU_FTR_ALTIVEC_COMP | CPU_FTR_L3CR |
-	CPU_FTR_HPTE_TABLE | CPU_FTR_SPEC7450 | CPU_FTR_NAP_DISABLE_L2_PR |
-	CPU_FTR_L3_DISABLE_NAP | CPU_FTR_NEED_COHERENT,
-	COMMON_PPC | PPC_FEATURE_ALTIVEC_COMP,
-	32, 32,
-	__setup_cpu_745x
-    },
-    {	/* 7450 2.3 and newer */
-    	0xffff0000, 0x80000000, "7450",
-	CPU_FTR_COMMON |
-    	CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB | CPU_FTR_MAYBE_CAN_NAP |
-	CPU_FTR_L2CR | CPU_FTR_ALTIVEC_COMP | CPU_FTR_L3CR |
-	CPU_FTR_HPTE_TABLE | CPU_FTR_SPEC7450 | CPU_FTR_NAP_DISABLE_L2_PR |
-	CPU_FTR_NEED_COHERENT,
-	COMMON_PPC | PPC_FEATURE_ALTIVEC_COMP,
-	32, 32,
-	__setup_cpu_745x
-    },
-    {	/* 7455 rev 1.x */
-    	0xffffff00, 0x80010100, "7455",
-	CPU_FTR_COMMON |
-    	CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB |
-	CPU_FTR_L2CR | CPU_FTR_ALTIVEC_COMP | CPU_FTR_L3CR |
-	CPU_FTR_HPTE_TABLE | CPU_FTR_SPEC7450 | CPU_FTR_HAS_HIGH_BATS |
-	CPU_FTR_NEED_COHERENT,
-	COMMON_PPC | PPC_FEATURE_ALTIVEC_COMP,
-	32, 32,
-	__setup_cpu_745x
-    },
-    {	/* 7455 rev 2.0 */
-    	0xffffffff, 0x80010200, "7455",
-	CPU_FTR_COMMON |
-    	CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB | CPU_FTR_MAYBE_CAN_NAP |
-	CPU_FTR_L2CR | CPU_FTR_ALTIVEC_COMP | CPU_FTR_L3CR |
-	CPU_FTR_HPTE_TABLE | CPU_FTR_SPEC7450 | CPU_FTR_NAP_DISABLE_L2_PR |
-	CPU_FTR_L3_DISABLE_NAP | CPU_FTR_NEED_COHERENT | CPU_FTR_HAS_HIGH_BATS,
-	COMMON_PPC | PPC_FEATURE_ALTIVEC_COMP,
-	32, 32,
-	__setup_cpu_745x
-    },
-    {	/* 7455 others */
-    	0xffff0000, 0x80010000, "7455",
-	CPU_FTR_COMMON |
-    	CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB | CPU_FTR_MAYBE_CAN_NAP |
-	CPU_FTR_L2CR | CPU_FTR_ALTIVEC_COMP | CPU_FTR_L3CR |
-	CPU_FTR_HPTE_TABLE | CPU_FTR_SPEC7450 | CPU_FTR_NAP_DISABLE_L2_PR |
-	CPU_FTR_HAS_HIGH_BATS | CPU_FTR_NEED_COHERENT,
-	COMMON_PPC | PPC_FEATURE_ALTIVEC_COMP,
-	32, 32,
-	__setup_cpu_745x
-    },
-    {	/* 7447/7457 Rev 1.0 */
-    	0xffffffff, 0x80020100, "7447/7457",
-	CPU_FTR_COMMON |
-    	CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB | CPU_FTR_MAYBE_CAN_NAP |
-	CPU_FTR_L2CR | CPU_FTR_ALTIVEC_COMP | CPU_FTR_L3CR |
-	CPU_FTR_HPTE_TABLE | CPU_FTR_SPEC7450 | CPU_FTR_NAP_DISABLE_L2_PR |
-	CPU_FTR_HAS_HIGH_BATS | CPU_FTR_NEED_COHERENT | CPU_FTR_NO_BTIC,
-	COMMON_PPC | PPC_FEATURE_ALTIVEC_COMP,
-	32, 32,
-	__setup_cpu_745x
-    },
-    {	/* 7447/7457 Rev 1.1 */
-    	0xffffffff, 0x80020101, "7447/7457",
-	CPU_FTR_COMMON |
-    	CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB | CPU_FTR_MAYBE_CAN_NAP |
-	CPU_FTR_L2CR | CPU_FTR_ALTIVEC_COMP | CPU_FTR_L3CR |
-	CPU_FTR_HPTE_TABLE | CPU_FTR_SPEC7450 | CPU_FTR_NAP_DISABLE_L2_PR |
-	CPU_FTR_HAS_HIGH_BATS | CPU_FTR_NEED_COHERENT | CPU_FTR_NO_BTIC,
-	COMMON_PPC | PPC_FEATURE_ALTIVEC_COMP,
-	32, 32,
-	__setup_cpu_745x
-    },
-    {	/* 7447/7457 Rev 1.2 and later */
-    	0xffff0000, 0x80020000, "7447/7457",
-	CPU_FTR_COMMON |
-    	CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB | CPU_FTR_MAYBE_CAN_NAP |
-	CPU_FTR_L2CR | CPU_FTR_ALTIVEC_COMP | CPU_FTR_L3CR |
-	CPU_FTR_HPTE_TABLE | CPU_FTR_SPEC7450 | CPU_FTR_NAP_DISABLE_L2_PR |
-	CPU_FTR_HAS_HIGH_BATS | CPU_FTR_NEED_COHERENT,
-	COMMON_PPC | PPC_FEATURE_ALTIVEC_COMP,
-	32, 32,
-	__setup_cpu_745x
-    },
-    {	/* 7447A */
-    	0xffff0000, 0x80030000, "7447A",
-	CPU_FTR_COMMON |
-    	CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB | CPU_FTR_MAYBE_CAN_NAP |
-	CPU_FTR_L2CR | CPU_FTR_ALTIVEC_COMP |
-	CPU_FTR_HPTE_TABLE | CPU_FTR_SPEC7450 | CPU_FTR_NAP_DISABLE_L2_PR |
-	CPU_FTR_HAS_HIGH_BATS | CPU_FTR_NEED_COHERENT,
-	COMMON_PPC | PPC_FEATURE_ALTIVEC_COMP,
-	32, 32,
-	__setup_cpu_745x
-    },
-    {	/* 82xx (8240, 8245, 8260 are all 603e cores) */
-	0x7fff0000, 0x00810000, "82xx",
-	CPU_FTR_COMMON |
-	CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_MAYBE_CAN_DOZE | CPU_FTR_USE_TB,
-	COMMON_PPC,
-	32, 32,
-	__setup_cpu_603
-    },
-    {	/* All G2_LE (603e core, plus some) have the same pvr */
-	0x7fff0000, 0x00820000, "G2_LE",
-	CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_MAYBE_CAN_DOZE | CPU_FTR_USE_TB |
-	CPU_FTR_MAYBE_CAN_NAP | CPU_FTR_HAS_HIGH_BATS,
-	COMMON_PPC,
-	32, 32,
-	__setup_cpu_603
-    },
-    {	/* default match, we assume split I/D cache & TB (non-601)... */
-    	0x00000000, 0x00000000, "(generic PPC)",
-	CPU_FTR_COMMON |
-    	CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB | CPU_FTR_HPTE_TABLE,
-	COMMON_PPC,
-	32, 32,
-	__setup_cpu_generic
-    },
+	{ 	/* 601 */
+		.pvr_mask		= 0xffff0000,
+		.pvr_value		= 0x00010000,
+		.cpu_name		= "601",
+		.cpu_features		= CPU_FTR_COMMON | CPU_FTR_601 |
+			CPU_FTR_HPTE_TABLE,
+		.cpu_user_features 	= COMMON_PPC | PPC_FEATURE_601_INSTR |
+			PPC_FEATURE_UNIFIED_CACHE,
+		.icache_bsize		= 32,
+		.dcache_bsize		= 32,
+		.num_pmcs		= 0,
+		.cpu_setup		= __setup_cpu_601
+	},
+	{	/* 603 */
+		.pvr_mask		= 0xffff0000,
+		.pvr_value		= 0x00030000,
+		.cpu_name		= "603",
+		.cpu_features		= CPU_FTR_COMMON |
+			CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_MAYBE_CAN_DOZE |
+			CPU_FTR_USE_TB | CPU_FTR_MAYBE_CAN_NAP,
+		.cpu_user_features	= COMMON_PPC,
+		.icache_bsize		= 32,
+		.dcache_bsize		= 32,
+		.num_pmcs		= 0,
+		.cpu_setup		= __setup_cpu_603
+	},
+	{	/* 603e */
+		.pvr_mask		= 0xffff0000,
+		.pvr_value		= 0x00060000,
+		.cpu_name		= "603e",
+		.cpu_features		= CPU_FTR_COMMON |
+			CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_MAYBE_CAN_DOZE |
+			CPU_FTR_USE_TB | CPU_FTR_MAYBE_CAN_NAP,
+		.cpu_user_features	= COMMON_PPC,
+		.icache_bsize		= 32,
+		.dcache_bsize		= 32,
+		.num_pmcs		= 0,
+		.cpu_setup		= __setup_cpu_603
+	},
+	{	/* 603ev */
+		.pvr_mask		= 0xffff0000,
+		.pvr_value		= 0x00070000,
+		.cpu_name		= "603ev",
+		.cpu_features		= CPU_FTR_COMMON |
+			CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_MAYBE_CAN_DOZE |
+			CPU_FTR_USE_TB | CPU_FTR_MAYBE_CAN_NAP,
+		.cpu_user_features	= COMMON_PPC,
+		.icache_bsize		= 32,
+		.dcache_bsize		= 32,
+		.num_pmcs		= 0,
+		.cpu_setup		= __setup_cpu_603
+	},
+	{	/* 604 */
+		.pvr_mask		= 0xffff0000,
+		.pvr_value		= 0x00040000,
+		.cpu_name		= "604",
+		.cpu_features		= CPU_FTR_COMMON |
+			CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB |
+			CPU_FTR_604_PERF_MON | CPU_FTR_HPTE_TABLE,
+		.cpu_user_features	= COMMON_PPC,
+		.icache_bsize		= 32,
+		.dcache_bsize		= 32,
+		.num_pmcs		= 2,
+		.cpu_setup		= __setup_cpu_604
+	},
+	{	/* 604e */
+		.pvr_mask		= 0xfffff000,
+		.pvr_value		= 0x00090000,
+		.cpu_name		= "604e",
+		.cpu_features		= CPU_FTR_COMMON |
+			CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB |
+			CPU_FTR_604_PERF_MON | CPU_FTR_HPTE_TABLE,
+		.cpu_user_features	= COMMON_PPC,
+		.icache_bsize		= 32,
+		.dcache_bsize		= 32,
+		.num_pmcs		= 4,
+		.cpu_setup		= __setup_cpu_604
+	},
+	{	/* 604r */
+		.pvr_mask		= 0xffff0000,
+		.pvr_value		= 0x00090000,
+		.cpu_name		= "604r",
+		.cpu_features		= CPU_FTR_COMMON |
+			CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB |
+			CPU_FTR_604_PERF_MON | CPU_FTR_HPTE_TABLE,
+		.cpu_user_features	= COMMON_PPC,
+		.icache_bsize		= 32,
+		.dcache_bsize		= 32,
+		.num_pmcs		= 4,
+		.cpu_setup		= __setup_cpu_604
+	},
+	{	/* 604ev */
+		.pvr_mask		= 0xffff0000,
+		.pvr_value		= 0x000a0000,
+		.cpu_name		= "604ev",
+		.cpu_features		= CPU_FTR_COMMON |
+			CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB |
+			CPU_FTR_604_PERF_MON | CPU_FTR_HPTE_TABLE,
+		.cpu_user_features	= COMMON_PPC,
+		.icache_bsize		= 32,
+		.dcache_bsize		= 32,
+		.num_pmcs		= 4,
+		.cpu_setup		= __setup_cpu_604
+	},
+	{	/* 740/750 (0x4202, don't support TAU ?) */
+		.pvr_mask		= 0xffffffff,
+		.pvr_value		= 0x00084202,
+		.cpu_name		= "740/750",
+		.cpu_features		= CPU_FTR_COMMON |
+			CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_MAYBE_CAN_DOZE |
+			CPU_FTR_USE_TB | CPU_FTR_L2CR | CPU_FTR_HPTE_TABLE |
+			CPU_FTR_MAYBE_CAN_NAP,
+		.cpu_user_features	= COMMON_PPC,
+		.icache_bsize		= 32,
+		.dcache_bsize		= 32,
+		.num_pmcs		= 4,
+		.cpu_setup		= __setup_cpu_750
+	},
+	{	/* 745/755 */
+		.pvr_mask		= 0xfffff000,
+		.pvr_value		= 0x00083000,
+		.cpu_name		= "745/755",
+		.cpu_features		= CPU_FTR_COMMON |
+			CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_MAYBE_CAN_DOZE |
+			CPU_FTR_USE_TB | CPU_FTR_L2CR | CPU_FTR_TAU |
+			CPU_FTR_HPTE_TABLE | CPU_FTR_MAYBE_CAN_NAP,
+		.cpu_user_features	= COMMON_PPC,
+		.icache_bsize		= 32,
+		.dcache_bsize		= 32,
+		.num_pmcs		= 4,
+		.cpu_setup		= __setup_cpu_750
+	},
+	{	/* 750CX (80100 and 8010x?) */
+		.pvr_mask		= 0xfffffff0,
+		.pvr_value		= 0x00080100,
+		.cpu_name		= "750CX",
+		.cpu_features		= CPU_FTR_COMMON |
+			CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_MAYBE_CAN_DOZE |
+			CPU_FTR_USE_TB | CPU_FTR_L2CR | CPU_FTR_TAU |
+			CPU_FTR_HPTE_TABLE | CPU_FTR_MAYBE_CAN_NAP,
+		.cpu_user_features	= COMMON_PPC,
+		.icache_bsize		= 32,
+		.dcache_bsize		= 32,
+		.num_pmcs		= 4,
+		.cpu_setup		= __setup_cpu_750cx
+	},
+	{	/* 750CX (82201 and 82202) */
+		.pvr_mask		= 0xfffffff0,
+		.pvr_value		= 0x00082200,
+		.cpu_name		= "750CX",
+		.cpu_features		= CPU_FTR_COMMON |
+			CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_MAYBE_CAN_DOZE |
+			CPU_FTR_USE_TB | CPU_FTR_L2CR | CPU_FTR_TAU |
+			CPU_FTR_HPTE_TABLE | CPU_FTR_MAYBE_CAN_NAP,
+		.cpu_user_features	= COMMON_PPC,
+		.icache_bsize		= 32,
+		.dcache_bsize		= 32,
+		.num_pmcs		= 4,
+		.cpu_setup		= __setup_cpu_750cx
+	},
+	{	/* 750CXe (82214) */
+		.pvr_mask		= 0xfffffff0,
+		.pvr_value		= 0x00082210,
+		.cpu_name		= "750CXe",
+		.cpu_features		= CPU_FTR_COMMON |
+			CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_MAYBE_CAN_DOZE |
+			CPU_FTR_USE_TB | CPU_FTR_L2CR | CPU_FTR_TAU |
+			CPU_FTR_HPTE_TABLE | CPU_FTR_MAYBE_CAN_NAP,
+		.cpu_user_features	= COMMON_PPC,
+		.icache_bsize		= 32,
+		.dcache_bsize		= 32,
+		.num_pmcs		= 4,
+		.cpu_setup		= __setup_cpu_750cx
+	},
+	{	/* 750FX rev 1.x */
+		.pvr_mask		= 0xffffff00,
+		.pvr_value		= 0x70000100,
+		.cpu_name		= "750FX",
+		.cpu_features		= CPU_FTR_COMMON |
+			CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_MAYBE_CAN_DOZE |
+			CPU_FTR_USE_TB | CPU_FTR_L2CR | CPU_FTR_TAU |
+			CPU_FTR_HPTE_TABLE | CPU_FTR_MAYBE_CAN_NAP |
+			CPU_FTR_DUAL_PLL_750FX | CPU_FTR_NO_DPM,
+		.cpu_user_features	= COMMON_PPC,
+		.icache_bsize		= 32,
+		.dcache_bsize		= 32,
+		.num_pmcs		= 4,
+		.cpu_setup		= __setup_cpu_750
+	},
+	{	/* 750FX rev 2.0 must disable HID0[DPM] */
+		.pvr_mask		= 0xffffffff,
+		.pvr_value		= 0x70000200,
+		.cpu_name		= "750FX",
+		.cpu_features		= CPU_FTR_COMMON |
+			CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_MAYBE_CAN_DOZE |
+			CPU_FTR_USE_TB | CPU_FTR_L2CR | CPU_FTR_TAU |
+			CPU_FTR_HPTE_TABLE | CPU_FTR_MAYBE_CAN_NAP |
+			CPU_FTR_NO_DPM,
+		.cpu_user_features	= COMMON_PPC,
+		.icache_bsize		= 32,
+		.dcache_bsize		= 32,
+		.num_pmcs		= 4,
+		.cpu_setup		= __setup_cpu_750
+	},
+	{	/* 750FX (All revs except 2.0) */
+		.pvr_mask		= 0xffff0000,
+		.pvr_value		= 0x70000000,
+		.cpu_name		= "750FX",
+		.cpu_features		= CPU_FTR_COMMON |
+			CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_MAYBE_CAN_DOZE |
+			CPU_FTR_USE_TB | CPU_FTR_L2CR | CPU_FTR_TAU |
+			CPU_FTR_HPTE_TABLE | CPU_FTR_MAYBE_CAN_NAP |
+			CPU_FTR_DUAL_PLL_750FX | CPU_FTR_HAS_HIGH_BATS,
+		.cpu_user_features	= COMMON_PPC,
+		.icache_bsize		= 32,
+		.dcache_bsize		= 32,
+		.num_pmcs		= 4,
+		.cpu_setup		= __setup_cpu_750fx
+	},
+	{	/* 750GX */
+		.pvr_mask		= 0xffff0000,
+		.pvr_value		= 0x70020000,
+		.cpu_name		= "750GX",
+		.cpu_features		= CPU_FTR_SPLIT_ID_CACHE |
+			CPU_FTR_MAYBE_CAN_DOZE | CPU_FTR_USE_TB |
+			CPU_FTR_L2CR | CPU_FTR_TAU | CPU_FTR_HPTE_TABLE |
+			CPU_FTR_MAYBE_CAN_NAP | CPU_FTR_DUAL_PLL_750FX |
+			CPU_FTR_HAS_HIGH_BATS,
+		.cpu_user_features	= COMMON_PPC,
+		.icache_bsize		= 32,
+		.dcache_bsize		= 32,
+		.num_pmcs		= 4,
+		.cpu_setup		= __setup_cpu_750fx
+	},
+	{	/* 740/750 (L2CR bit need fixup for 740) */
+		.pvr_mask		= 0xffff0000,
+		.pvr_value		= 0x00080000,
+		.cpu_name		= "740/750",
+		.cpu_features		= CPU_FTR_COMMON |
+			CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_MAYBE_CAN_DOZE |
+			CPU_FTR_USE_TB | CPU_FTR_L2CR | CPU_FTR_TAU |
+			CPU_FTR_HPTE_TABLE | CPU_FTR_MAYBE_CAN_NAP,
+		.cpu_user_features	= COMMON_PPC,
+		.icache_bsize		= 32,
+		.dcache_bsize		= 32,
+		.num_pmcs		= 4,
+		.cpu_setup		= __setup_cpu_750
+	},
+	{	/* 7400 rev 1.1 ? (no TAU) */
+		.pvr_mask		= 0xffffffff,
+		.pvr_value		= 0x000c1101,
+		.cpu_name		= "7400 (1.1)",
+		.cpu_features		= CPU_FTR_COMMON |
+			CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_MAYBE_CAN_DOZE |
+			CPU_FTR_USE_TB | CPU_FTR_L2CR | CPU_FTR_ALTIVEC_COMP |
+			CPU_FTR_HPTE_TABLE | CPU_FTR_MAYBE_CAN_NAP,
+		.cpu_user_features	= COMMON_PPC | PPC_FEATURE_ALTIVEC_COMP,
+		.icache_bsize		= 32,
+		.dcache_bsize		= 32,
+		.num_pmcs		= 4,
+		.cpu_setup		= __setup_cpu_7400
+	},
+	{	/* 7400 */
+		.pvr_mask		= 0xffff0000,
+		.pvr_value		= 0x000c0000,
+		.cpu_name		= "7400",
+		.cpu_features		= CPU_FTR_COMMON |
+			CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_MAYBE_CAN_DOZE |
+			CPU_FTR_USE_TB | CPU_FTR_L2CR | CPU_FTR_TAU |
+			CPU_FTR_ALTIVEC_COMP | CPU_FTR_HPTE_TABLE |
+			CPU_FTR_MAYBE_CAN_NAP,
+		.cpu_user_features	= COMMON_PPC | PPC_FEATURE_ALTIVEC_COMP,
+		.icache_bsize		= 32,
+		.dcache_bsize		= 32,
+		.num_pmcs		= 4,
+		.cpu_setup		= __setup_cpu_7400
+	},
+	{	/* 7410 */
+		.pvr_mask		= 0xffff0000,
+		.pvr_value		= 0x800c0000,
+		.cpu_name		= "7410",
+		.cpu_features		= CPU_FTR_COMMON |
+			CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_MAYBE_CAN_DOZE |
+			CPU_FTR_USE_TB | CPU_FTR_L2CR | CPU_FTR_TAU |
+			CPU_FTR_ALTIVEC_COMP | CPU_FTR_HPTE_TABLE |
+			CPU_FTR_MAYBE_CAN_NAP,
+		.cpu_user_features	= COMMON_PPC | PPC_FEATURE_ALTIVEC_COMP,
+		.icache_bsize		= 32,
+		.dcache_bsize		= 32,
+		.num_pmcs		= 4,
+		.cpu_setup		= __setup_cpu_7410
+	},
+	{	/* 7450 2.0 - no doze/nap */
+		.pvr_mask		= 0xffffffff,
+		.pvr_value		= 0x80000200,
+		.cpu_name		= "7450",
+		.cpu_features		= CPU_FTR_COMMON |
+			CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB |
+			CPU_FTR_L2CR | CPU_FTR_ALTIVEC_COMP | CPU_FTR_L3CR |
+			CPU_FTR_HPTE_TABLE | CPU_FTR_SPEC7450 |
+			CPU_FTR_NEED_COHERENT,
+		.cpu_user_features	= COMMON_PPC | PPC_FEATURE_ALTIVEC_COMP,
+		.icache_bsize		= 32,
+		.dcache_bsize		= 32,
+		.num_pmcs		= 6,
+		.cpu_setup		= __setup_cpu_745x
+	},
+	{	/* 7450 2.1 */
+		.pvr_mask		= 0xffffffff,
+		.pvr_value		= 0x80000201,
+		.cpu_name		= "7450",
+		.cpu_features		= CPU_FTR_COMMON |
+			CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB |
+			CPU_FTR_MAYBE_CAN_NAP | CPU_FTR_L2CR |
+			CPU_FTR_ALTIVEC_COMP | CPU_FTR_L3CR |
+			CPU_FTR_HPTE_TABLE | CPU_FTR_SPEC7450 |
+			CPU_FTR_NAP_DISABLE_L2_PR | CPU_FTR_L3_DISABLE_NAP |
+			CPU_FTR_NEED_COHERENT,
+		.cpu_user_features	= COMMON_PPC | PPC_FEATURE_ALTIVEC_COMP,
+		.icache_bsize		= 32,
+		.dcache_bsize		= 32,
+		.num_pmcs		= 6,
+		.cpu_setup		= __setup_cpu_745x
+	},
+	{	/* 7450 2.3 and newer */
+		.pvr_mask		= 0xffff0000,
+		.pvr_value		= 0x80000000,
+		.cpu_name		= "7450",
+		.cpu_features		= CPU_FTR_COMMON |
+			CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB |
+			CPU_FTR_MAYBE_CAN_NAP | CPU_FTR_L2CR |
+			CPU_FTR_ALTIVEC_COMP | CPU_FTR_L3CR |
+			CPU_FTR_HPTE_TABLE | CPU_FTR_SPEC7450 |
+			CPU_FTR_NAP_DISABLE_L2_PR | CPU_FTR_NEED_COHERENT,
+		.cpu_user_features	= COMMON_PPC | PPC_FEATURE_ALTIVEC_COMP,
+		.icache_bsize		= 32,
+		.dcache_bsize		= 32,
+		.num_pmcs		= 6,
+		.cpu_setup		= __setup_cpu_745x
+	},
+	{	/* 7455 rev 1.x */
+		.pvr_mask		= 0xffffff00,
+		.pvr_value		= 0x80010100,
+		.cpu_name		= "7455",
+		.cpu_features		= CPU_FTR_COMMON |
+			CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB |
+			CPU_FTR_L2CR | CPU_FTR_ALTIVEC_COMP | CPU_FTR_L3CR |
+			CPU_FTR_HPTE_TABLE | CPU_FTR_SPEC7450 |
+			CPU_FTR_HAS_HIGH_BATS | CPU_FTR_NEED_COHERENT,
+		.cpu_user_features	= COMMON_PPC | PPC_FEATURE_ALTIVEC_COMP,
+		.icache_bsize		= 32,
+		.dcache_bsize		= 32,
+		.num_pmcs		= 6,
+		.cpu_setup		= __setup_cpu_745x
+	},
+	{	/* 7455 rev 2.0 */
+		.pvr_mask		= 0xffffffff,
+		.pvr_value		= 0x80010200,
+		.cpu_name		= "7455",
+		.cpu_features		= CPU_FTR_COMMON |
+			CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB |
+			CPU_FTR_MAYBE_CAN_NAP | CPU_FTR_L2CR |
+			CPU_FTR_ALTIVEC_COMP | CPU_FTR_L3CR |
+			CPU_FTR_HPTE_TABLE | CPU_FTR_SPEC7450 |
+			CPU_FTR_NAP_DISABLE_L2_PR | CPU_FTR_L3_DISABLE_NAP |
+			CPU_FTR_NEED_COHERENT | CPU_FTR_HAS_HIGH_BATS,
+		.cpu_user_features	= COMMON_PPC | PPC_FEATURE_ALTIVEC_COMP,
+		.icache_bsize		= 32,
+		.dcache_bsize		= 32,
+		.num_pmcs		= 6,
+		.cpu_setup		= __setup_cpu_745x
+	},
+	{	/* 7455 others */
+		.pvr_mask		= 0xffff0000,
+		.pvr_value		= 0x80010000,
+		.cpu_name		= "7455",
+		.cpu_features		= CPU_FTR_COMMON |
+			CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB |
+			CPU_FTR_MAYBE_CAN_NAP | CPU_FTR_L2CR |
+			CPU_FTR_ALTIVEC_COMP | CPU_FTR_L3CR |
+			CPU_FTR_HPTE_TABLE | CPU_FTR_SPEC7450 |
+			CPU_FTR_NAP_DISABLE_L2_PR | CPU_FTR_HAS_HIGH_BATS |
+			CPU_FTR_NEED_COHERENT,
+		.cpu_user_features	= COMMON_PPC | PPC_FEATURE_ALTIVEC_COMP,
+		.icache_bsize		= 32,
+		.dcache_bsize		= 32,
+		.num_pmcs		= 6,
+		.cpu_setup		= __setup_cpu_745x
+	},
+	{	/* 7447/7457 Rev 1.0 */
+		.pvr_mask		= 0xffffffff,
+		.pvr_value		= 0x80020100,
+		.cpu_name		= "7447/7457",
+		.cpu_features		= CPU_FTR_COMMON |
+			CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB |
+			CPU_FTR_MAYBE_CAN_NAP | CPU_FTR_L2CR |
+			CPU_FTR_ALTIVEC_COMP | CPU_FTR_L3CR |
+			CPU_FTR_HPTE_TABLE | CPU_FTR_SPEC7450 |
+			CPU_FTR_NAP_DISABLE_L2_PR | CPU_FTR_HAS_HIGH_BATS |
+			CPU_FTR_NEED_COHERENT | CPU_FTR_NO_BTIC,
+		.cpu_user_features	= COMMON_PPC | PPC_FEATURE_ALTIVEC_COMP,
+		.icache_bsize		= 32,
+		.dcache_bsize		= 32,
+		.num_pmcs		= 6,
+		.cpu_setup		= __setup_cpu_745x
+	},
+	{	/* 7447/7457 Rev 1.1 */
+		.pvr_mask		= 0xffffffff,
+		.pvr_value		= 0x80020101,
+		.cpu_name		= "7447/7457",
+		.cpu_features		= CPU_FTR_COMMON |
+			CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB |
+			CPU_FTR_MAYBE_CAN_NAP | CPU_FTR_L2CR |
+			CPU_FTR_ALTIVEC_COMP | CPU_FTR_L3CR |
+			CPU_FTR_HPTE_TABLE | CPU_FTR_SPEC7450 |
+			CPU_FTR_NAP_DISABLE_L2_PR | CPU_FTR_HAS_HIGH_BATS |
+			CPU_FTR_NEED_COHERENT | CPU_FTR_NO_BTIC,
+		.cpu_user_features	= COMMON_PPC | PPC_FEATURE_ALTIVEC_COMP,
+		.icache_bsize		= 32,
+		.dcache_bsize		= 32,
+		.num_pmcs		= 6,
+		.cpu_setup		= __setup_cpu_745x
+	},
+	{	/* 7447/7457 Rev 1.2 and later */
+		.pvr_mask		= 0xffff0000,
+		.pvr_value		= 0x80020000,
+		.cpu_name		= "7447/7457",
+		.cpu_features		= CPU_FTR_COMMON |
+			CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB |
+			CPU_FTR_MAYBE_CAN_NAP | CPU_FTR_L2CR |
+			CPU_FTR_ALTIVEC_COMP | CPU_FTR_L3CR |
+			CPU_FTR_HPTE_TABLE | CPU_FTR_SPEC7450 |
+			CPU_FTR_NAP_DISABLE_L2_PR | CPU_FTR_HAS_HIGH_BATS |
+			CPU_FTR_NEED_COHERENT,
+		.cpu_user_features	= COMMON_PPC | PPC_FEATURE_ALTIVEC_COMP,
+		.icache_bsize		= 32,
+		.dcache_bsize		= 32,
+		.num_pmcs		= 6,
+		.cpu_setup		= __setup_cpu_745x
+	},
+	{	/* 7447A */
+		.pvr_mask		= 0xffff0000,
+		.pvr_value		= 0x80030000,
+		.cpu_name		= "7447A",
+		.cpu_features		= CPU_FTR_COMMON |
+			CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB |
+			CPU_FTR_MAYBE_CAN_NAP | CPU_FTR_L2CR |
+			CPU_FTR_ALTIVEC_COMP | CPU_FTR_HPTE_TABLE |
+			CPU_FTR_SPEC7450 | CPU_FTR_NAP_DISABLE_L2_PR |
+			CPU_FTR_HAS_HIGH_BATS | CPU_FTR_NEED_COHERENT,
+		.cpu_user_features	= COMMON_PPC | PPC_FEATURE_ALTIVEC_COMP,
+		.icache_bsize		= 32,
+		.dcache_bsize		= 32,
+		.num_pmcs		= 6,
+		.cpu_setup		= __setup_cpu_745x
+	},
+	{	/* 82xx (8240, 8245, 8260 are all 603e cores) */
+		.pvr_mask		= 0x7fff0000,
+		.pvr_value		= 0x00810000,
+		.cpu_name		= "82xx",
+		.cpu_features		= CPU_FTR_COMMON |
+			CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_MAYBE_CAN_DOZE |
+			CPU_FTR_USE_TB,
+		.cpu_user_features	= COMMON_PPC,
+		.icache_bsize		= 32,
+		.dcache_bsize		= 32,
+		.num_pmcs		= 0,
+		.cpu_setup		= __setup_cpu_603
+	},
+	{	/* All G2_LE (603e core, plus some) have the same pvr */
+		.pvr_mask		= 0x7fff0000,
+		.pvr_value		= 0x00820000,
+		.cpu_name		= "G2_LE",
+		.cpu_features		= CPU_FTR_SPLIT_ID_CACHE |
+			CPU_FTR_MAYBE_CAN_DOZE | CPU_FTR_USE_TB |
+			CPU_FTR_MAYBE_CAN_NAP | CPU_FTR_HAS_HIGH_BATS,
+		.cpu_user_features	= COMMON_PPC,
+		.icache_bsize		= 32,
+		.dcache_bsize		= 32,
+		.num_pmcs		= 0,
+		.cpu_setup		= __setup_cpu_603
+	},
+	{	/* default match, we assume split I/D cache & TB (non-601)... */
+		.pvr_mask		= 0x00000000,
+		.pvr_value		= 0x00000000,
+		.cpu_name		= "(generic PPC)",
+		.cpu_features		= CPU_FTR_COMMON |
+			CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB |
+			CPU_FTR_HPTE_TABLE,
+		.cpu_user_features	= COMMON_PPC,
+		.icache_bsize		= 32,
+		.dcache_bsize		= 32,
+		.num_pmcs		= 0,
+		.cpu_setup		= __setup_cpu_generic
+	},
 #endif /* CLASSIC_PPC */
 #ifdef CONFIG_PPC64BRIDGE
-    {	/* Power3 */
-    	0xffff0000, 0x00400000, "Power3 (630)",
-	CPU_FTR_COMMON |
-    	CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB | CPU_FTR_HPTE_TABLE,
-    	COMMON_PPC | PPC_FEATURE_64,
-	128, 128,
-	__setup_cpu_power3
-    },
-    {	/* Power3+ */
-    	0xffff0000, 0x00410000, "Power3 (630+)",
-	CPU_FTR_COMMON |
-    	CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB | CPU_FTR_HPTE_TABLE,
-    	COMMON_PPC | PPC_FEATURE_64,
-	128, 128,
-	__setup_cpu_power3
-    },
+	{	/* Power3 */
+		.pvr_mask		= 0xffff0000,
+		.pvr_value		= 0x00400000,
+		.cpu_name		= "Power3 (630)",
+		.cpu_features		= CPU_FTR_COMMON |
+			CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB |
+			CPU_FTR_HPTE_TABLE,
+		.cpu_user_features	= COMMON_PPC | PPC_FEATURE_64,
+		.icache_bsize		= 128,
+		.dcache_bsize		= 128,
+		.num_pmcs		= 8,
+		.cpu_setup		= __setup_cpu_power3
+	},
+	{	/* Power3+ */
+		.pvr_mask		= 0xffff0000,
+		.pvr_value		= 0x00410000,
+		.cpu_name		= "Power3 (630+)",
+		.cpu_features		= CPU_FTR_COMMON |
+			CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB |
+			CPU_FTR_HPTE_TABLE,
+		.cpu_user_features	= COMMON_PPC | PPC_FEATURE_64,
+		.icache_bsize		= 128,
+		.dcache_bsize		= 128,
+		.num_pmcs		= 8,
+		.cpu_setup		= __setup_cpu_power3
+	},
 	{	/* I-star */
-		0xffff0000, 0x00360000, "I-star",
-		CPU_FTR_COMMON |
-		CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB | CPU_FTR_HPTE_TABLE,
-		COMMON_PPC | PPC_FEATURE_64,
-		128, 128,
-		__setup_cpu_power3
+		.pvr_mask		= 0xffff0000,
+		.pvr_value		= 0x00360000,
+		.cpu_name		= "I-star",
+		.cpu_features		= CPU_FTR_COMMON |
+			CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB |
+			CPU_FTR_HPTE_TABLE,
+		.cpu_user_features	= COMMON_PPC | PPC_FEATURE_64,
+		.icache_bsize		= 128,
+		.dcache_bsize		= 128,
+		.num_pmcs		= 8,
+		.cpu_setup		= __setup_cpu_power3
 	},
 	{	/* S-star */
-		0xffff0000, 0x00370000, "S-star",
-		CPU_FTR_COMMON |
-		CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB | CPU_FTR_HPTE_TABLE,
-		COMMON_PPC | PPC_FEATURE_64,
-		128, 128,
-		__setup_cpu_power3
+		.pvr_mask		= 0xffff0000,
+		.pvr_value		= 0x00370000,
+		.cpu_name		= "S-star",
+		.cpu_features		= CPU_FTR_COMMON |
+			CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB |
+			CPU_FTR_HPTE_TABLE,
+		.cpu_user_features	= COMMON_PPC | PPC_FEATURE_64,
+		.icache_bsize		= 128,
+		.dcache_bsize		= 128,
+		.num_pmcs		= 8,
+		.cpu_setup		= __setup_cpu_power3
 	},
 #endif /* CONFIG_PPC64BRIDGE */
 #ifdef CONFIG_POWER4
-    {	/* Power4 */
-    	0xffff0000, 0x00350000, "Power4",
-	CPU_FTR_COMMON |
-    	CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB | CPU_FTR_HPTE_TABLE,
-    	COMMON_PPC | PPC_FEATURE_64,
-	128, 128,
-	__setup_cpu_power4
-    },
-    {	/* PPC970 */
-	0xffff0000, 0x00390000, "PPC970",
-	CPU_FTR_COMMON |
-	CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB | CPU_FTR_HPTE_TABLE |
-	CPU_FTR_ALTIVEC_COMP | CPU_FTR_MAYBE_CAN_NAP,
-	COMMON_PPC | PPC_FEATURE_64 | PPC_FEATURE_ALTIVEC_COMP,
-	128, 128,
-	__setup_cpu_ppc970
-    },
-    {	/* PPC970FX */
-	0xffff0000, 0x003c0000, "PPC970FX",
-	CPU_FTR_COMMON |
-	CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB | CPU_FTR_HPTE_TABLE |
-	CPU_FTR_ALTIVEC_COMP | CPU_FTR_MAYBE_CAN_NAP,
-	COMMON_PPC | PPC_FEATURE_64 | PPC_FEATURE_ALTIVEC_COMP,
-	128, 128,
-	__setup_cpu_ppc970
-    },
+	{	/* Power4 */
+		.pvr_mask		= 0xffff0000,
+		.pvr_value		= 0x00350000,
+		.cpu_name		= "Power4",
+		.cpu_features		= CPU_FTR_COMMON |
+			CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB |
+			CPU_FTR_HPTE_TABLE,
+		.cpu_user_features	= COMMON_PPC | PPC_FEATURE_64,
+		.icache_bsize		= 128,
+		.dcache_bsize		= 128,
+		.num_pmcs		= 8,
+		.cpu_setup		= __setup_cpu_power4
+	},
+	{	/* PPC970 */
+		.pvr_mask		= 0xffff0000,
+		.pvr_value		= 0x00390000,
+		.cpu_name		= "PPC970",
+		.cpu_features		= CPU_FTR_COMMON |
+			CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB |
+			CPU_FTR_HPTE_TABLE |
+			CPU_FTR_ALTIVEC_COMP | CPU_FTR_MAYBE_CAN_NAP,
+		.cpu_user_features	= COMMON_PPC | PPC_FEATURE_64 |
+			PPC_FEATURE_ALTIVEC_COMP,
+		.icache_bsize		= 128,
+		.dcache_bsize		= 128,
+		.num_pmcs		= 8,
+		.cpu_setup		= __setup_cpu_ppc970
+	},
+	{	/* PPC970FX */
+		.pvr_mask		= 0xffff0000,
+		.pvr_value		= 0x003c0000,
+		.cpu_name		= "PPC970FX",
+		.cpu_features		= CPU_FTR_COMMON |
+			CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB |
+			CPU_FTR_HPTE_TABLE |
+			CPU_FTR_ALTIVEC_COMP | CPU_FTR_MAYBE_CAN_NAP,
+		.cpu_user_features	= COMMON_PPC | PPC_FEATURE_64 |
+			PPC_FEATURE_ALTIVEC_COMP,
+		.icache_bsize		= 128,
+		.dcache_bsize		= 128,
+		.num_pmcs		= 8,
+		.cpu_setup		= __setup_cpu_ppc970
+	},
 #endif /* CONFIG_POWER4 */
 #ifdef CONFIG_8xx
-    {	/* 8xx */
-    	0xffff0000, 0x00500000, "8xx",
+	{	/* 8xx */
+		.pvr_mask		= 0xffff0000,
+		.pvr_value		= 0x00500000,
+		.cpu_name		= "8xx",
 		/* CPU_FTR_MAYBE_CAN_DOZE is possible,
 		 * if the 8xx code is there.... */
-    	CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB,
-    	PPC_FEATURE_32 | PPC_FEATURE_HAS_MMU,
- 	16, 16,
-	__setup_cpu_8xx	/* Empty */
-    },
+		.cpu_features		= CPU_FTR_SPLIT_ID_CACHE |
+			CPU_FTR_USE_TB,
+		.cpu_user_features	= PPC_FEATURE_32 | PPC_FEATURE_HAS_MMU,
+		.icache_bsize		= 16,
+		.dcache_bsize		= 16,
+		.num_pmcs		= 0,
+		.cpu_setup		= __setup_cpu_8xx	/* Empty */
+	},
 #endif /* CONFIG_8xx */
 #ifdef CONFIG_40x
-    {	/* 403GC */
-    	0xffffff00, 0x00200200, "403GC",
-    	CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB,
-    	PPC_FEATURE_32 | PPC_FEATURE_HAS_MMU,
-	16, 16,
-	0, /*__setup_cpu_403 */
-    },
-    {	/* 403GCX */
-    	0xffffff00, 0x00201400, "403GCX",
-    	CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB,
-    	PPC_FEATURE_32 | PPC_FEATURE_HAS_MMU,
-	16, 16,
-	0, /*__setup_cpu_403 */
-    },
-    {	/* 403G ?? */
-    	0xffff0000, 0x00200000, "403G ??",
-    	CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB,
-    	PPC_FEATURE_32 | PPC_FEATURE_HAS_MMU,
-	16, 16,
-	0, /*__setup_cpu_403 */
-    },
-    {	/* 405GP */
-    	0xffff0000, 0x40110000, "405GP",
-    	CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB,
-    	PPC_FEATURE_32 | PPC_FEATURE_HAS_MMU | PPC_FEATURE_HAS_4xxMAC,
-	32, 32,
-	0, /*__setup_cpu_405 */
-    },
-    {	/* STB 03xxx */
-    	0xffff0000, 0x40130000, "STB03xxx",
-    	CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB,
-    	PPC_FEATURE_32 | PPC_FEATURE_HAS_MMU | PPC_FEATURE_HAS_4xxMAC,
-	32, 32,
-	0, /*__setup_cpu_405 */
-    },
-    {	/* STB 04xxx */
-    	0xffff0000, 0x41810000, "STB04xxx",
-    	CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB,
-    	PPC_FEATURE_32 | PPC_FEATURE_HAS_MMU | PPC_FEATURE_HAS_4xxMAC,
-	32, 32,
-	0, /*__setup_cpu_405 */
-    },
-    {	/* NP405L */
-    	0xffff0000, 0x41610000, "NP405L",
-    	CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB,
-    	PPC_FEATURE_32 | PPC_FEATURE_HAS_MMU | PPC_FEATURE_HAS_4xxMAC,
-	32, 32,
-	0, /*__setup_cpu_405 */
-    },
-    {	/* NP4GS3 */
-    	0xffff0000, 0x40B10000, "NP4GS3",
-    	CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB,
-    	PPC_FEATURE_32 | PPC_FEATURE_HAS_MMU | PPC_FEATURE_HAS_4xxMAC,
-	32, 32,
-	0, /*__setup_cpu_405 */
-    },
-    {   /* NP405H */
-        0xffff0000, 0x41410000, "NP405H",
-        CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB,
-        PPC_FEATURE_32 | PPC_FEATURE_HAS_MMU | PPC_FEATURE_HAS_4xxMAC,
-        32, 32,
-        0, /*__setup_cpu_405 */
-     },
-     {	/* 405GPr */
-    	0xffff0000, 0x50910000, "405GPr",
-    	CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB,
-    	PPC_FEATURE_32 | PPC_FEATURE_HAS_MMU | PPC_FEATURE_HAS_4xxMAC,
-	32, 32,
-	0, /*__setup_cpu_405 */
-    },
-    {   /* STBx25xx */
-        0xffff0000, 0x51510000, "STBx25xx",
-        CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB,
-        PPC_FEATURE_32 | PPC_FEATURE_HAS_MMU | PPC_FEATURE_HAS_4xxMAC,
-        32, 32,
-        0, /*__setup_cpu_405 */
-     },
-     {	/* 405LP */
-    	0xffff0000, 0x41F10000, "405LP",
-    	CPU_FTR_SPLIT_ID_CACHE |  CPU_FTR_USE_TB,
-    	PPC_FEATURE_32 | PPC_FEATURE_HAS_MMU,
-	32, 32,
-	0, /*__setup_cpu_405 */
-     },
-     {	/* Xilinx Virtex-II Pro  */
-	0xffff0000, 0x20010000, "Virtex-II Pro",
-	CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB,
-	PPC_FEATURE_32 | PPC_FEATURE_HAS_MMU | PPC_FEATURE_HAS_4xxMAC,
-	32, 32,
-	0, /*__setup_cpu_405 */
-     },
+	{	/* 403GC */
+		.pvr_mask		= 0xffffff00,
+		.pvr_value		= 0x00200200,
+		.cpu_name		= "403GC",
+		.cpu_features		= CPU_FTR_SPLIT_ID_CACHE |
+			CPU_FTR_USE_TB,
+		.cpu_user_features	= PPC_FEATURE_32 | PPC_FEATURE_HAS_MMU,
+		.icache_bsize		= 16,
+		.dcache_bsize		= 16,
+		.num_pmcs		= 0,
+		.cpu_setup		= 0, /*__setup_cpu_403 */
+	},
+	{	/* 403GCX */
+		.pvr_mask		= 0xffffff00,
+		.pvr_value		= 0x00201400,
+		.cpu_name		= "403GCX",
+		.cpu_features		= CPU_FTR_SPLIT_ID_CACHE |
+			CPU_FTR_USE_TB,
+		.cpu_user_features	= PPC_FEATURE_32 | PPC_FEATURE_HAS_MMU,
+		.icache_bsize		= 16,
+		.dcache_bsize		= 16,
+		.num_pmcs		= 0,
+		.cpu_setup		= 0, /*__setup_cpu_403 */
+	},
+	{	/* 403G ?? */
+		.pvr_mask		= 0xffff0000,
+		.pvr_value		= 0x00200000,
+		.cpu_name		= "403G ??",
+		.cpu_features		= CPU_FTR_SPLIT_ID_CACHE |
+			CPU_FTR_USE_TB,
+		.cpu_user_features	= PPC_FEATURE_32 | PPC_FEATURE_HAS_MMU,
+		.icache_bsize		= 16,
+		.dcache_bsize		= 16,
+		.num_pmcs		= 0,
+		.cpu_setup		= 0, /*__setup_cpu_403 */
+	},
+	{	/* 405GP */
+		.pvr_mask		= 0xffff0000,
+		.pvr_value		= 0x40110000,
+		.cpu_name		= "405GP",
+		.cpu_features		= CPU_FTR_SPLIT_ID_CACHE |
+			CPU_FTR_USE_TB,
+		.cpu_user_features	= PPC_FEATURE_32 |
+			PPC_FEATURE_HAS_MMU | PPC_FEATURE_HAS_4xxMAC,
+		.icache_bsize		= 32,
+		.dcache_bsize		= 32,
+		.num_pmcs		= 0,
+		.cpu_setup		= 0, /*__setup_cpu_405 */
+	},
+	{	/* STB 03xxx */
+		.pvr_mask		= 0xffff0000,
+		.pvr_value		= 0x40130000,
+		.cpu_name		= "STB03xxx",
+		.cpu_features		= CPU_FTR_SPLIT_ID_CACHE |
+			CPU_FTR_USE_TB,
+		.cpu_user_features	= PPC_FEATURE_32 |
+			PPC_FEATURE_HAS_MMU | PPC_FEATURE_HAS_4xxMAC,
+		.icache_bsize		= 32,
+		.dcache_bsize		= 32,
+		.num_pmcs		= 0,
+		.cpu_setup		= 0, /*__setup_cpu_405 */
+	},
+	{	/* STB 04xxx */
+		.pvr_mask		= 0xffff0000,
+		.pvr_value		= 0x41810000,
+		.cpu_name		= "STB04xxx",
+		.cpu_features		= CPU_FTR_SPLIT_ID_CACHE |
+			CPU_FTR_USE_TB,
+		.cpu_user_features	= PPC_FEATURE_32 |
+			PPC_FEATURE_HAS_MMU | PPC_FEATURE_HAS_4xxMAC,
+		.icache_bsize		= 32,
+		.dcache_bsize		= 32,
+		.num_pmcs		= 0,
+		.cpu_setup		= 0, /*__setup_cpu_405 */
+	},
+	{	/* NP405L */
+		.pvr_mask		= 0xffff0000,
+		.pvr_value		= 0x41610000,
+		.cpu_name		= "NP405L",
+		.cpu_features		= CPU_FTR_SPLIT_ID_CACHE |
+			CPU_FTR_USE_TB,
+		.cpu_user_features	= PPC_FEATURE_32 |
+			PPC_FEATURE_HAS_MMU | PPC_FEATURE_HAS_4xxMAC,
+		.icache_bsize		= 32,
+		.dcache_bsize		= 32,
+		.num_pmcs		= 0,
+		.cpu_setup		= 0, /*__setup_cpu_405 */
+	},
+	{	/* NP4GS3 */
+		.pvr_mask		= 0xffff0000,
+		.pvr_value		= 0x40B10000,
+		.cpu_name		= "NP4GS3",
+		.cpu_features		= CPU_FTR_SPLIT_ID_CACHE |
+			CPU_FTR_USE_TB,
+		.cpu_user_features	= PPC_FEATURE_32 |
+			PPC_FEATURE_HAS_MMU | PPC_FEATURE_HAS_4xxMAC,
+		.icache_bsize		= 32,
+		.dcache_bsize		= 32,
+		.num_pmcs		= 0,
+		.cpu_setup		= 0, /*__setup_cpu_405 */
+	},
+	{   /* NP405H */
+		.pvr_mask		= 0xffff0000,
+		.pvr_value		= 0x41410000,
+		.cpu_name		= "NP405H",
+		.cpu_features		= CPU_FTR_SPLIT_ID_CACHE |
+			CPU_FTR_USE_TB,
+		.cpu_user_features	= PPC_FEATURE_32 |
+			PPC_FEATURE_HAS_MMU | PPC_FEATURE_HAS_4xxMAC,
+		.icache_bsize		= 32,
+		.dcache_bsize		= 32,
+		.num_pmcs		= 0,
+		.cpu_setup		= 0, /*__setup_cpu_405 */
+	},
+	{	/* 405GPr */
+		.pvr_mask		= 0xffff0000,
+		.pvr_value		= 0x50910000,
+		.cpu_name		= "405GPr",
+		.cpu_features		= CPU_FTR_SPLIT_ID_CACHE |
+			CPU_FTR_USE_TB,
+		.cpu_user_features	= PPC_FEATURE_32 |
+			PPC_FEATURE_HAS_MMU | PPC_FEATURE_HAS_4xxMAC,
+		.icache_bsize		= 32,
+		.dcache_bsize		= 32,
+		.num_pmcs		= 0,
+		.cpu_setup		= 0, /*__setup_cpu_405 */
+	},
+	{   /* STBx25xx */
+		.pvr_mask		= 0xffff0000,
+		.pvr_value		= 0x51510000,
+		.cpu_name		= "STBx25xx",
+		.cpu_features		= CPU_FTR_SPLIT_ID_CACHE |
+			CPU_FTR_USE_TB,
+		.cpu_user_features	= PPC_FEATURE_32 |
+			PPC_FEATURE_HAS_MMU | PPC_FEATURE_HAS_4xxMAC,
+		.icache_bsize		= 32,
+		.dcache_bsize		= 32,
+		.num_pmcs		= 0,
+		.cpu_setup		= 0, /*__setup_cpu_405 */
+	},
+	{	/* 405LP */
+		.pvr_mask		= 0xffff0000,
+		.pvr_value		= 0x41F10000,
+		.cpu_name		= "405LP",
+		.cpu_features		= CPU_FTR_SPLIT_ID_CACHE |
+			CPU_FTR_USE_TB,
+		.cpu_user_features	= PPC_FEATURE_32 | PPC_FEATURE_HAS_MMU,
+		.icache_bsize		= 32,
+		.dcache_bsize		= 32,
+		.num_pmcs		= 0,
+		.cpu_setup		= 0, /*__setup_cpu_405 */
+	},
+	{	/* Xilinx Virtex-II Pro  */
+		.pvr_mask		= 0xffff0000,
+		.pvr_value		= 0x20010000,
+		.cpu_name		= "Virtex-II Pro",
+		.cpu_features		= CPU_FTR_SPLIT_ID_CACHE |
+			CPU_FTR_USE_TB,
+		.cpu_user_features	= PPC_FEATURE_32 |
+			PPC_FEATURE_HAS_MMU | PPC_FEATURE_HAS_4xxMAC,
+		.icache_bsize		= 32,
+		.dcache_bsize		= 32,
+		.num_pmcs		= 0,
+		.cpu_setup		= 0, /*__setup_cpu_405 */
+	},
 
 #endif /* CONFIG_40x */
 #ifdef CONFIG_44x
-    { /* 440GP Rev. B */
-        0xf0000fff, 0x40000440, "440GP Rev. B",
-        CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB,
-        PPC_FEATURE_32 | PPC_FEATURE_HAS_MMU,
-        32, 32,
-        0, /*__setup_cpu_440 */
-    },
-    { /* 440GP Rev. C */
-        0xf0000fff, 0x40000481, "440GP Rev. C",
-        CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB,
-        PPC_FEATURE_32 | PPC_FEATURE_HAS_MMU,
-        32, 32,
-        0, /*__setup_cpu_440 */
-    },
-    { /* 440GX Rev. A */
-        0xf0000fff, 0x50000850, "440GX Rev. A",
-        CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB,
-        PPC_FEATURE_32 | PPC_FEATURE_HAS_MMU,
-        32, 32,
-        0, /*__setup_cpu_440 */
-    },
-    { /* 440GX Rev. B */
-        0xf0000fff, 0x50000851, "440GX Rev. B",
-        CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB,
-        PPC_FEATURE_32 | PPC_FEATURE_HAS_MMU,
-        32, 32,
-        0, /*__setup_cpu_440 */
-    },
-    { /* 440GX Rev. C */
-        0xf0000fff, 0x50000892, "440GX Rev. C",
-        CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB,
-        PPC_FEATURE_32 | PPC_FEATURE_HAS_MMU,
-        32, 32,
-        0, /*__setup_cpu_440 */
-    },
+	{ 	/* 440GP Rev. B */
+		.pvr_mask		= 0xf0000fff,
+		.pvr_value		= 0x40000440,
+		.cpu_name		= "440GP Rev. B",
+		.cpu_features		= CPU_FTR_SPLIT_ID_CACHE |
+			CPU_FTR_USE_TB,
+		.cpu_user_features	= PPC_FEATURE_32 | PPC_FEATURE_HAS_MMU,
+		.icache_bsize		= 32,
+		.dcache_bsize		= 32,
+		.num_pmcs		= 0,
+		.cpu_setup		= 0, /*__setup_cpu_440 */
+	},
+	{ 	/* 440GP Rev. C */
+		.pvr_mask		= 0xf0000fff,
+		.pvr_value		= 0x40000481,
+		.cpu_name		= "440GP Rev. C",
+		.cpu_features		= CPU_FTR_SPLIT_ID_CACHE |
+			CPU_FTR_USE_TB,
+		.cpu_user_features	= PPC_FEATURE_32 | PPC_FEATURE_HAS_MMU,
+		.icache_bsize		= 32,
+		.dcache_bsize		= 32,
+		.num_pmcs		= 0,
+		.cpu_setup		= 0, /*__setup_cpu_440 */
+	},
+	{ /* 440GX Rev. A */
+		.pvr_mask		= 0xf0000fff,
+		.pvr_value		= 0x50000850,
+		.cpu_name		= "440GX Rev. A",
+		.cpu_features		= CPU_FTR_SPLIT_ID_CACHE |
+			CPU_FTR_USE_TB,
+		.cpu_user_features	= PPC_FEATURE_32 | PPC_FEATURE_HAS_MMU,
+		.icache_bsize		= 32,
+		.dcache_bsize		= 32,
+		.num_pmcs		= 0,
+		.cpu_setup		= 0, /*__setup_cpu_440 */
+	},
+	{ /* 440GX Rev. B */
+		.pvr_mask		= 0xf0000fff,
+		.pvr_value		= 0x50000851,
+		.cpu_name		= "440GX Rev. B",
+		.cpu_features		= CPU_FTR_SPLIT_ID_CACHE |
+			CPU_FTR_USE_TB,
+		.cpu_user_features	= PPC_FEATURE_32 | PPC_FEATURE_HAS_MMU,
+		.icache_bsize		= 32,
+		.dcache_bsize		= 32,
+		.num_pmcs		= 0,
+		.cpu_setup		= 0, /*__setup_cpu_440 */
+	},
+	{ /* 440GX Rev. C */
+		.pvr_mask		= 0xf0000fff,
+		.pvr_value		= 0x50000892,
+		.cpu_name		= "440GX Rev. C",
+		.cpu_features		= CPU_FTR_SPLIT_ID_CACHE |
+			CPU_FTR_USE_TB,
+		.cpu_user_features	= PPC_FEATURE_32 | PPC_FEATURE_HAS_MMU,
+		.icache_bsize		= 32,
+		.dcache_bsize		= 32,
+		.num_pmcs		= 0,
+		.cpu_setup		= 0, /*__setup_cpu_440 */
+	},
 #endif /* CONFIG_44x */
 #ifdef CONFIG_E500
-    { /* e500 */
-        0xffff0000, 0x80200000, "e500",
-	/* xxx - galak: add CPU_FTR_MAYBE_CAN_DOZE */
-        CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB,
-        PPC_FEATURE_32 | PPC_FEATURE_HAS_MMU,
-        32, 32,
-        0, /*__setup_cpu_e500 */
-    },
+	{ 	/* e500 */
+		.pvr_mask		= 0xffff0000,
+		.pvr_value		= 0x80200000,
+		.cpu_name		= "e500",
+		/* xxx - galak: add CPU_FTR_MAYBE_CAN_DOZE */
+		.cpu_features		= CPU_FTR_SPLIT_ID_CACHE |
+			CPU_FTR_USE_TB,
+		.cpu_user_features	= PPC_FEATURE_32 |
+			PPC_FEATURE_HAS_MMU | PPC_FEATURE_SPE_COMP |
+			PPC_FEATURE_HAS_EFP_SINGLE,
+		.icache_bsize		= 32,
+		.dcache_bsize		= 32,
+		.num_pmcs		= 4,
+		.cpu_setup		= 0, /*__setup_cpu_e500 */
+	},
 #endif
 #if !CLASSIC_PPC
-    {	/* default match */
-    	0x00000000, 0x00000000, "(generic PPC)",
-	CPU_FTR_COMMON,
-    	PPC_FEATURE_32,
-	32, 32,
-	0,
-    }
+	{	/* default match */
+		.pvr_mask		= 0x00000000,
+		.pvr_value		= 0x00000000,
+		.cpu_name		= "(generic PPC)",
+		.cpu_features		= CPU_FTR_COMMON,
+		.cpu_user_features	= PPC_FEATURE_32,
+		.icache_bsize		= 32,
+		.dcache_bsize		= 32,
+		.num_pmcs		= 0,
+		.cpu_setup		= 0,
+	}
 #endif /* !CLASSIC_PPC */
 };
diff -Nru a/include/asm-ppc/cputable.h b/include/asm-ppc/cputable.h
--- a/include/asm-ppc/cputable.h	2004-11-09 20:14:49 -06:00
+++ b/include/asm-ppc/cputable.h	2004-11-09 20:14:49 -06:00
@@ -21,6 +21,9 @@
 #define PPC_FEATURE_HAS_MMU		0x04000000
 #define PPC_FEATURE_HAS_4xxMAC		0x02000000
 #define PPC_FEATURE_UNIFIED_CACHE	0x01000000
+#define PPC_FEATURE_HAS_SPE		0x00800000
+#define PPC_FEATURE_HAS_EFP_SINGLE	0x00400000
+#define PPC_FEATURE_HAS_EFP_DOUBLE	0x00200000
 
 #ifdef __KERNEL__
 
@@ -45,6 +48,9 @@
 	/* cache line sizes */
 	unsigned int	icache_bsize;
 	unsigned int	dcache_bsize;
+
+	/* number of performance monitor counters */
+	unsigned int	num_pmcs;
 
 	/* this is called to initialize various CPU bits like L1 cache,
 	 * BHT, SPD, etc... from head.S before branching to identify_machine
