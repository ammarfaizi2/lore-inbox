Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318768AbSIKODZ>; Wed, 11 Sep 2002 10:03:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318769AbSIKODZ>; Wed, 11 Sep 2002 10:03:25 -0400
Received: from hq.fsmlabs.com ([209.155.42.197]:3718 "EHLO hq.fsmlabs.com")
	by vger.kernel.org with ESMTP id <S318768AbSIKODW>;
	Wed, 11 Sep 2002 10:03:22 -0400
From: Cort Dougan <cort@fsmlabs.com>
Date: Wed, 11 Sep 2002 08:07:49 -0600
To: linuxppc-dev@lists.linuxppc.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] support for all 8 BATs on PPC 750fx
Message-ID: <20020911080749.A11852@host110.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support for all 8 BATs on the 750fx.

I did this in a different tree then brought it over to the latest
linuxppc-2.4 BK tree but I can't find a configuration that the current BK tree
will actually build with (common, gemini and others break at different
places).  Needless to say, I didn't test this patch with that tree, but
apparently the last set of changes weren't either.

This patch works fine in my other trees and it's a minor change.  It clears
up some uninitialized BAT problems with those processors on startup.  This
patch doesn't actually use those BATs, though.  A small change to ppc_mmu.c
could add that.

diff -Nru a/arch/ppc/kernel/cputable.c b/arch/ppc/kernel/cputable.c
--- a/arch/ppc/kernel/cputable.c	Wed Sep 11 08:06:10 2002
+++ b/arch/ppc/kernel/cputable.c	Wed Sep 11 08:06:10 2002
@@ -146,7 +146,8 @@
     {	/* 750FX (All revs for now) */
     	0xffff0000, 0x70000000, "750FX",
     	CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_CAN_DOZE | CPU_FTR_USE_TB |
-	CPU_FTR_L2CR | CPU_FTR_TAU | CPU_FTR_HPTE_TABLE | CPU_FTR_CAN_NAP,
+	CPU_FTR_L2CR | CPU_FTR_TAU | CPU_FTR_HPTE_TABLE | CPU_FTR_CAN_NAP |
+	CPU_FTR_8BATS,
 	COMMON_PPC,
 	32, 32,
 	__setup_cpu_750
diff -Nru a/arch/ppc/kernel/head.S b/arch/ppc/kernel/head.S
--- a/arch/ppc/kernel/head.S	Wed Sep 11 08:06:10 2002
+++ b/arch/ppc/kernel/head.S	Wed Sep 11 08:06:10 2002
@@ -1500,6 +1500,21 @@
 	LOAD_BAT(1,r3,r4,r5)
 	LOAD_BAT(2,r3,r4,r5)
 	LOAD_BAT(3,r3,r4,r5)
+	/*
+	 * Some CPUS have 8 BATS, not just 4.  So, check the cpu_secs
+	 * and see if we have 8 BATS or not.
+	 *     -- Cort <cort@fsmlabs.com>
+	 */
+	addis	r26,r3,cur_cpu_spec@ha
+	addi	r26,r26,cur_cpu_spec@l
+	tophys(r26,r26)
+	lwz	r26,0(r26)
+	andi.	r26,r26,CPU_FTR_8BATS
+	bnelr
+	LOAD_BAT(4,r3,r4,r5)
+	LOAD_BAT(5,r3,r4,r5)
+	LOAD_BAT(6,r3,r4,r5)
+	LOAD_BAT(7,r3,r4,r5)
 #endif /* CONFIG_POWER4 */
 	blr
 
@@ -1671,6 +1686,38 @@
 	mtspr	IBAT2L,r20
 	mtspr	IBAT3U,r20
 	mtspr	IBAT3L,r20
+
+	/*
+	 * Some CPUS have 8 BATS, not just 4.  So, check the cpu_secs
+	 * and see if we have 8 BATS or not.  We need to account for the 
+	 * physical addr we're at (in r3).
+	 *     -- Cort <cort@fsmlabs.com>
+	 */
+	addis	r26,r3,cur_cpu_spec@ha
+	addi	r26,r26,cur_cpu_spec@l
+	lwz	r26,0(r26)
+	andi.	r26,r26,CPU_FTR_8BATS
+	bnelr
+
+	/* we have 8 BATS, clear them -- Cort */
+	mtspr	DBAT4U,r20
+	mtspr	DBAT4L,r20
+	mtspr	DBAT5U,r20
+	mtspr	DBAT5L,r20
+	mtspr	DBAT6U,r20
+	mtspr	DBAT6L,r20
+	mtspr	DBAT7U,r20
+	mtspr	DBAT7L,r20
+
+	mtspr	IBAT4U,r20
+	mtspr	IBAT4L,r20
+	mtspr	IBAT5U,r20
+	mtspr	IBAT5L,r20
+	mtspr	IBAT6U,r20
+	mtspr	IBAT6L,r20
+	mtspr	IBAT7U,r20
+	mtspr	IBAT7L,r20
+
 #endif /* !defined(CONFIG_GEMINI) */
 	blr
 
diff -Nru a/arch/ppc/mm/ppc_mmu.c b/arch/ppc/mm/ppc_mmu.c
--- a/arch/ppc/mm/ppc_mmu.c	Wed Sep 11 08:06:10 2002
+++ b/arch/ppc/mm/ppc_mmu.c	Wed Sep 11 08:06:10 2002
@@ -52,13 +52,13 @@
 #else
 	u32	word[2];
 #endif
-} BATS[4][2];			/* 4 pairs of IBAT, DBAT */
+} BATS[8][2];			/* 4 pairs of IBAT, DBAT */
 
 struct batrange {		/* stores address ranges mapped by BATs */
 	unsigned long start;
 	unsigned long limit;
 	unsigned long phys;
-} bat_addrs[4];
+} bat_addrs[8];
 
 /*
  * Return PA for this VA if it is mapped by a BAT, or 0
@@ -66,7 +66,7 @@
 unsigned long v_mapped_by_bats(unsigned long va)
 {
 	int b;
-	for (b = 0; b < 4; ++b)
+	for (b = 0; b < 8; ++b)
 		if (va >= bat_addrs[b].start && va < bat_addrs[b].limit)
 			return bat_addrs[b].phys + (va - bat_addrs[b].start);
 	return 0;
@@ -78,7 +78,7 @@
 unsigned long p_mapped_by_bats(unsigned long pa)
 {
 	int b;
-	for (b = 0; b < 4; ++b)
+	for (b = 0; b < 8; ++b)
 		if (pa >= bat_addrs[b].phys
 	    	    && pa < (bat_addrs[b].limit-bat_addrs[b].start)
 		              +bat_addrs[b].phys)
diff -Nru a/include/asm-ppc/cputable.h b/include/asm-ppc/cputable.h
--- a/include/asm-ppc/cputable.h	Wed Sep 11 08:06:10 2002
+++ b/include/asm-ppc/cputable.h	Wed Sep 11 08:06:10 2002
@@ -69,6 +69,7 @@
 #define CPU_FTR_HPTE_TABLE		0x00000200
 #define CPU_FTR_CAN_NAP			0x00000400
 #define CPU_FTR_L3CR			0x00000800
+#define CPU_FTR_8BATS			0x00001000
 
 #ifdef __ASSEMBLY__
 
diff -Nru a/include/asm-ppc/processor.h b/include/asm-ppc/processor.h
--- a/include/asm-ppc/processor.h	Wed Sep 11 08:06:10 2002
+++ b/include/asm-ppc/processor.h	Wed Sep 11 08:06:10 2002
@@ -102,6 +102,17 @@
 #define	SPRN_DBAT2U	0x21C	/* Data BAT 2 Upper Register */
 #define	SPRN_DBAT3L	0x21F	/* Data BAT 3 Lower Register */
 #define	SPRN_DBAT3U	0x21E	/* Data BAT 3 Upper Register */
+#define	SPRN_DBAT4U	568
+#define	SPRN_DBAT4L	569
+#define	SPRN_DBAT5U	570
+#define	SPRN_DBAT5L	571
+#define	SPRN_DBAT6U	572
+#define	SPRN_DBAT6L	573
+#define	SPRN_DBAT7U	574
+#define	SPRN_DBAT7L	575
+
+
+
 #define	SPRN_DBCR	0x3F2	/* Debug Control Regsiter */
 #define	  DBCR_EDM	0x80000000
 #define	  DBCR_IDM	0x40000000
@@ -230,6 +241,14 @@
 #define	SPRN_IBAT2U	0x214	/* Instruction BAT 2 Upper Register */
 #define	SPRN_IBAT3L	0x217	/* Instruction BAT 3 Lower Register */
 #define	SPRN_IBAT3U	0x216	/* Instruction BAT 3 Upper Register */
+#define	SPRN_IBAT4U	560
+#define	SPRN_IBAT4L	561
+#define	SPRN_IBAT5U	562
+#define	SPRN_IBAT5L	563
+#define	SPRN_IBAT6U	564
+#define	SPRN_IBAT6L	565
+#define	SPRN_IBAT7U	566
+#define	SPRN_IBAT7L	567
 #define	SPRN_ICCR	0x3FB	/* Instruction Cache Cacheability Register */
 #define	  ICCR_NOCACHE		0	/* Noncacheable */
 #define	  ICCR_CACHE		1	/* Cacheable */
@@ -398,6 +417,14 @@
 #define	DBAT2U	SPRN_DBAT2U	/* Data BAT 2 Upper Register */
 #define	DBAT3L	SPRN_DBAT3L	/* Data BAT 3 Lower Register */
 #define	DBAT3U	SPRN_DBAT3U	/* Data BAT 3 Upper Register */
+#define	DBAT4L	SPRN_DBAT4L	/* Data BAT 4 Lower Register */
+#define	DBAT4U	SPRN_DBAT4U	/* Data BAT 4 Upper Register */
+#define	DBAT5L	SPRN_DBAT5L	/* Data BAT 5 Lower Register */
+#define	DBAT5U	SPRN_DBAT5U	/* Data BAT 5 Upper Register */
+#define	DBAT6L	SPRN_DBAT6L	/* Data BAT 6 Lower Register */
+#define	DBAT6U	SPRN_DBAT6U	/* Data BAT 6 Upper Register */
+#define	DBAT7L	SPRN_DBAT7L	/* Data BAT 7 Lower Register */
+#define	DBAT7U	SPRN_DBAT7U	/* Data BAT 7 Upper Register */
 #define	DCMP	SPRN_DCMP      	/* Data TLB Compare Register */
 #define	DEC	SPRN_DEC       	/* Decrement Register */
 #define	DMISS	SPRN_DMISS     	/* Data TLB Miss Register */
@@ -416,6 +443,14 @@
 #define	IBAT2U	SPRN_IBAT2U	/* Instruction BAT 2 Upper Register */
 #define	IBAT3L	SPRN_IBAT3L	/* Instruction BAT 3 Lower Register */
 #define	IBAT3U	SPRN_IBAT3U	/* Instruction BAT 3 Upper Register */
+#define	IBAT4L	SPRN_IBAT4L	/* Instruction BAT 4 Lower Register */
+#define	IBAT4U	SPRN_IBAT4U	/* Instruction BAT 4 Upper Register */
+#define	IBAT5L	SPRN_IBAT5L	/* Instruction BAT 5 Lower Register */
+#define	IBAT5U	SPRN_IBAT5U	/* Instruction BAT 5 Upper Register */
+#define	IBAT6L	SPRN_IBAT6L	/* Instruction BAT 6 Lower Register */
+#define	IBAT6U	SPRN_IBAT6U	/* Instruction BAT 6 Upper Register */
+#define	IBAT7L	SPRN_IBAT7L	/* Instruction BAT 7 Lower Register */
+#define	IBAT7U	SPRN_IBAT7U	/* Instruction BAT 7 Upper Register */
 #define	ICMP	SPRN_ICMP	/* Instruction TLB Compare Register */
 #define	IMISS	SPRN_IMISS	/* Instruction TLB Miss Register */
 #define	IMMR	SPRN_IMMR      	/* PPC 860/821 Internal Memory Map Register */
