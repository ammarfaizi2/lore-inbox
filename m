Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261784AbUKPT4W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261784AbUKPT4W (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 14:56:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261782AbUKPTyX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 14:54:23 -0500
Received: from motgate8.mot.com ([129.188.136.8]:19074 "EHLO motgate8.mot.com")
	by vger.kernel.org with ESMTP id S261784AbUKPTxU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 14:53:20 -0500
Date: Tue, 16 Nov 2004 13:52:58 -0600 (CST)
From: Kumar Gala <galak@somerset.sps.mot.com>
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, linuxppc-embedded@ozlabs.org
Subject: [PATCH][PPC32] Freescale Book-E MMU cleanup
Message-ID: <Pine.LNX.4.61.0411161351320.32505@blarg.somerset.sps.mot.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

Updates the Freescale Book-E MMU usage to match the architecture spec.
This is mainly growing the widths of fields in various registers to match
the architecture spec instead of the implementation.
        
Signed-off-by: Becky Gill <becky.gill@freescale.com>
Signed-off-by: Kumar Gala <kumar.gala@freescale.com>

--
diff -Nru a/arch/ppc/kernel/head_e500.S b/arch/ppc/kernel/head_e500.S
--- a/arch/ppc/kernel/head_e500.S	2004-11-16 13:43:22 -06:00
+++ b/arch/ppc/kernel/head_e500.S	2004-11-16 13:43:22 -06:00
@@ -119,7 +119,7 @@
 	tlbsx	0,r6				/* Fall through, we had to match */
 match_TLB:
 	mfspr	r7,SPRN_MAS0
-	rlwinm	r3,r7,16,28,31			/* Extract MAS0(Entry) */
+	rlwinm	r3,r7,16,20,31			/* Extract MAS0(Entry) */
 
 	mfspr	r7,SPRN_MAS1			/* Insure IPROT set */
 	oris	r7,r7,MAS1_IPROT@h
@@ -131,7 +131,7 @@
 	andi.	r9,r9,0xfff
 	li	r6,0				/* Set Entry counter to 0 */
 1:	lis	r7,0x1000			/* Set MAS0(TLBSEL) = 1 */
-	rlwimi	r7,r6,16,12,15			/* Setup MAS0 = TLBSEL | ESEL(r6) */
+	rlwimi	r7,r6,16,4,15			/* Setup MAS0 = TLBSEL | ESEL(r6) */
 	mtspr	SPRN_MAS0,r7
 	tlbre
 	mfspr	r7,SPRN_MAS1
@@ -163,13 +163,13 @@
 	andi.	r5, r3, 0x1	/* Find an entry not used and is non-zero */
 	addi	r5, r5, 0x1
 	lis	r7,0x1000	/* Set MAS0(TLBSEL) = 1 */
-	rlwimi	r7,r3,16,12,15	/* Setup MAS0 = TLBSEL | ESEL(r3) */
+	rlwimi	r7,r3,16,4,15	/* Setup MAS0 = TLBSEL | ESEL(r3) */
 	mtspr	SPRN_MAS0,r7
 	tlbre
 
 	/* Just modify the entry ID and EPN for the temp mapping */
 	lis	r7,0x1000	/* Set MAS0(TLBSEL) = 1 */
-	rlwimi	r7,r5,16,12,15	/* Setup MAS0 = TLBSEL | ESEL(r5) */
+	rlwimi	r7,r5,16,4,15	/* Setup MAS0 = TLBSEL | ESEL(r5) */
 	mtspr	SPRN_MAS0,r7
 	xori	r6,r4,1		/* Setup TMP mapping in the other Address space */
 	slwi	r6,r6,12
@@ -201,7 +201,7 @@
 
 /* 5. Invalidate mapping we started in */
 	lis	r7,0x1000	/* Set MAS0(TLBSEL) = 1 */
-	rlwimi	r7,r3,16,12,15	/* Setup MAS0 = TLBSEL | ESEL(r3) */
+	rlwimi	r7,r3,16,4,15	/* Setup MAS0 = TLBSEL | ESEL(r3) */
 	mtspr	SPRN_MAS0,r7
 	tlbre
 	li	r6,0
@@ -242,7 +242,7 @@
 
 /* 8. Clear out the temp mapping */
 	lis	r7,0x1000	/* Set MAS0(TLBSEL) = 1 */
-	rlwimi	r7,r5,16,12,15	/* Setup MAS0 = TLBSEL | ESEL(r5) */
+	rlwimi	r7,r5,16,4,15	/* Setup MAS0 = TLBSEL | ESEL(r5) */
 	mtspr	SPRN_MAS0,r7
 	tlbre
 	mtspr	SPRN_MAS1,r8
@@ -282,7 +282,7 @@
 	mtspr	SPRN_IVPR,r4
 
 	/* Setup the defaults for TLB entries */
-	li	r2,MAS4_TSIZED(BOOKE_PAGESZ_4K)
+	li	r2,(MAS4_TSIZED(BOOKE_PAGESZ_4K))@l
    	mtspr	SPRN_MAS4, r2
 
 #if 0
@@ -539,8 +539,7 @@
 	ori	r11, r11, swapper_pg_dir@l
 
 	mfspr	r12,SPRN_MAS1		/* Set TID to 0 */
-	li	r13,MAS1_TID@l
-	andc	r12,r12,r13
+	rlwinm	r12,r12,0,16,1
 	mtspr	SPRN_MAS1,r12
 
 	b	4f
@@ -604,8 +603,7 @@
 	ori	r11, r11, swapper_pg_dir@l
 
 	mfspr	r12,SPRN_MAS1		/* Set TID to 0 */
-	li	r13,MAS1_TID@l
-	andc	r12,r12,r13
+	rlwinm	r12,r12,0,16,1	
 	mtspr	SPRN_MAS1,r12
 
 	b	4f
diff -Nru a/arch/ppc/mm/fsl_booke_mmu.c b/arch/ppc/mm/fsl_booke_mmu.c
--- a/arch/ppc/mm/fsl_booke_mmu.c	2004-11-16 13:43:22 -06:00
+++ b/arch/ppc/mm/fsl_booke_mmu.c	2004-11-16 13:43:22 -06:00
@@ -124,8 +124,8 @@
 		flags |= _PAGE_COHERENT;
 #endif
 
-	TLBCAM[index].MAS0 = MAS0_TLBSEL | (index << 16);
-	TLBCAM[index].MAS1 = MAS1_VALID | MAS1_IPROT | MAS1_TSIZE(tsize) | ((pid << 16) & MAS1_TID);
+	TLBCAM[index].MAS0 = MAS0_TLBSEL(1) | MAS0_ESEL(index);
+	TLBCAM[index].MAS1 = MAS1_VALID | MAS1_IPROT | MAS1_TSIZE(tsize) | MAS1_TID(pid);
 	TLBCAM[index].MAS2 = virt & PAGE_MASK;
 
 	TLBCAM[index].MAS2 |= (flags & _PAGE_WRITETHRU) ? MAS2_W : 0;
@@ -156,7 +156,7 @@
 
 void invalidate_tlbcam_entry(int index)
 {
-	TLBCAM[index].MAS0 = MAS0_TLBSEL | (index << 16);
+	TLBCAM[index].MAS0 = MAS0_TLBSEL(1) | MAS0_ESEL(index);
 	TLBCAM[index].MAS1 = ~MAS1_VALID;
 
 	loadcam_entry(index);
diff -Nru a/include/asm-ppc/mmu.h b/include/asm-ppc/mmu.h
--- a/include/asm-ppc/mmu.h	2004-11-16 13:43:22 -06:00
+++ b/include/asm-ppc/mmu.h	2004-11-16 13:43:22 -06:00
@@ -401,18 +401,17 @@
  * Freescale Book-E MMU support
  */
 
-#define MAS0_TLBSEL	0x10000000
-#define MAS0_ESEL	0x000F0000
-#define MAS0_NV		0x00000001
+#define MAS0_TLBSEL(x)	((x << 28) & 0x30000000)
+#define MAS0_ESEL(x)	((x << 16) & 0x0FFF0000)
+#define MAS0_NV		0x00000FFF
 
 #define MAS1_VALID 	0x80000000
 #define MAS1_IPROT	0x40000000
-#define MAS1_TID 	0x03FF0000
+#define MAS1_TID(x)	((x << 16) & 0x3FFF0000)
 #define MAS1_TS		0x00001000
-#define MAS1_TSIZE(x)	(x << 8)
+#define MAS1_TSIZE(x)	((x << 8) & 0x00000F00)
 
 #define MAS2_EPN	0xFFFFF000
-#define MAS2_SHAREN	0x00000200
 #define MAS2_X0		0x00000040
 #define MAS2_X1		0x00000020
 #define MAS2_W		0x00000010
@@ -433,10 +432,9 @@
 #define MAS3_UR		0x00000002
 #define MAS3_SR		0x00000001
 
-#define MAS4_TLBSELD	0x10000000
-#define MAS4_TIDDSEL	0x00030000
-#define MAS4_DSHAREN	0x00001000
-#define MAS4_TSIZED(x)	(x << 8)
+#define MAS4_TLBSELD(x) MAS0_TLBSEL(x)
+#define MAS4_TIDDSEL	0x000F0000
+#define MAS4_TSIZED(x)	MAS1_TSIZE(x)
 #define MAS4_X0D	0x00000040
 #define MAS4_X1D	0x00000020
 #define MAS4_WD		0x00000010
@@ -445,8 +443,12 @@
 #define MAS4_GD		0x00000002
 #define MAS4_ED		0x00000001
 
-#define MAS6_SPID	0x00FF0000
+#define MAS6_SPID0	0x3FFF0000
+#define MAS6_SPID1	0x00007FFE
 #define MAS6_SAS	0x00000001
+#define MAS6_SPID	MAS6_SPID0
+
+#define MAS7_RPN	0xFFFFFFFF
 
 #endif /* _PPC_MMU_H_ */
 #endif /* __KERNEL__ */
