Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261333AbVFIFnp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261333AbVFIFnp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Jun 2005 01:43:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261540AbVFIFnp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Jun 2005 01:43:45 -0400
Received: from de01egw01.freescale.net ([192.88.165.102]:10168 "EHLO
	de01egw01.freescale.net") by vger.kernel.org with ESMTP
	id S261333AbVFIFnh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Jun 2005 01:43:37 -0400
Date: Thu, 9 Jun 2005 00:43:23 -0500 (CDT)
From: Kumar Gala <galak@freescale.com>
X-X-Sender: galak@nylon.am.freescale.net
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org,
       linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: [PATCH] ppc32: Clean up NUM_TLBCAMS usage for Freescale Book-E PPC's
Message-ID: <Pine.LNX.4.61.0506090042560.22020@nylon.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Made the number of TLB CAM entries private and converted the board consumers
to use num_tlbcam_entries which is setup at boot time from configuration
registers.  This way the only consumers of the #define NUM_TLBCAMS are the
arrays used to manage the TLB.

Signed-off-by: Kumar Gala <kumar.gala@freescale.com>

---
commit 24e4731a8b0b74af65f39fa11cc3a520e52f0a63
tree 89a18636e8eab485757cb89ee0645bc3ca27f1de
parent d754db8e39a79ae9a159f747511889647e46748a
author Kumar K. Gala <kumar.gala@freescale.com> Thu, 09 Jun 2005 00:41:46 -0500
committer Kumar K. Gala <kumar.gala@freescale.com> Thu, 09 Jun 2005 00:41:46 -0500

 arch/ppc/mm/fsl_booke_mmu.c                  |    2 ++
 arch/ppc/mm/mmu_decl.h                       |    2 ++
 arch/ppc/mm/pgtable.c                        |    1 -
 arch/ppc/platforms/85xx/mpc8540_ads.c        |    4 ++--
 arch/ppc/platforms/85xx/mpc85xx_cds_common.c |    4 ++--
 arch/ppc/platforms/85xx/sbc8560.c            |    4 ++--
 include/asm-ppc/pgtable.h                    |    2 --
 7 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/arch/ppc/mm/fsl_booke_mmu.c b/arch/ppc/mm/fsl_booke_mmu.c
--- a/arch/ppc/mm/fsl_booke_mmu.c
+++ b/arch/ppc/mm/fsl_booke_mmu.c
@@ -64,6 +64,8 @@ extern unsigned long total_lowmem;
 extern unsigned long __max_low_memory;
 #define MAX_LOW_MEM	CONFIG_LOWMEM_SIZE
 
+#define NUM_TLBCAMS	(16)
+
 struct tlbcam {
    	u32	MAS0;
 	u32	MAS1;
diff --git a/arch/ppc/mm/mmu_decl.h b/arch/ppc/mm/mmu_decl.h
--- a/arch/ppc/mm/mmu_decl.h
+++ b/arch/ppc/mm/mmu_decl.h
@@ -43,6 +43,8 @@ extern int mem_init_done;
 extern PTE *Hash, *Hash_end;
 extern unsigned long Hash_size, Hash_mask;
 
+extern unsigned int num_tlbcam_entries;
+
 /* ...and now those things that may be slightly different between processor
  * architectures.  -- Dan
  */
diff --git a/arch/ppc/mm/pgtable.c b/arch/ppc/mm/pgtable.c
--- a/arch/ppc/mm/pgtable.c
+++ b/arch/ppc/mm/pgtable.c
@@ -66,7 +66,6 @@ void setbat(int index, unsigned long vir
 
 #ifdef HAVE_TLBCAM
 extern unsigned int tlbcam_index;
-extern unsigned int num_tlbcam_entries;
 extern unsigned long v_mapped_by_tlbcam(unsigned long va);
 extern unsigned long p_mapped_by_tlbcam(unsigned long pa);
 #else /* !HAVE_TLBCAM */
diff --git a/arch/ppc/platforms/85xx/mpc8540_ads.c b/arch/ppc/platforms/85xx/mpc8540_ads.c
--- a/arch/ppc/platforms/85xx/mpc8540_ads.c
+++ b/arch/ppc/platforms/85xx/mpc8540_ads.c
@@ -88,7 +88,7 @@ mpc8540ads_setup_arch(void)
 #ifdef CONFIG_SERIAL_TEXT_DEBUG
 	/* Invalidate the entry we stole earlier the serial ports
 	 * should be properly mapped */
-	invalidate_tlbcam_entry(NUM_TLBCAMS - 1);
+	invalidate_tlbcam_entry(num_tlbcam_entries - 1);
 #endif
 
 	/* setup the board related information for the enet controllers */
@@ -150,7 +150,7 @@ platform_init(unsigned long r3, unsigned
 		struct uart_port p;
 
 		/* Use the last TLB entry to map CCSRBAR to allow access to DUART regs */
-		settlbcam(NUM_TLBCAMS - 1, binfo->bi_immr_base,
+		settlbcam(num_tlbcam_entries - 1, binfo->bi_immr_base,
 			  binfo->bi_immr_base, MPC85xx_CCSRBAR_SIZE, _PAGE_IO, 0);
 
 		memset(&p, 0, sizeof (p));
diff --git a/arch/ppc/platforms/85xx/mpc85xx_cds_common.c b/arch/ppc/platforms/85xx/mpc85xx_cds_common.c
--- a/arch/ppc/platforms/85xx/mpc85xx_cds_common.c
+++ b/arch/ppc/platforms/85xx/mpc85xx_cds_common.c
@@ -446,7 +446,7 @@ mpc85xx_cds_setup_arch(void)
 #ifdef CONFIG_SERIAL_TEXT_DEBUG
 	/* Invalidate the entry we stole earlier the serial ports
 	 * should be properly mapped */
-	invalidate_tlbcam_entry(NUM_TLBCAMS - 1);
+	invalidate_tlbcam_entry(num_tlbcam_entries - 1);
 #endif
 
 	/* setup the board related information for the enet controllers */
@@ -528,7 +528,7 @@ platform_init(unsigned long r3, unsigned
 		struct uart_port p;
 
 		/* Use the last TLB entry to map CCSRBAR to allow access to DUART regs */
-		settlbcam(NUM_TLBCAMS - 1, binfo->bi_immr_base,
+		settlbcam(num_tlbcam_entries - 1, binfo->bi_immr_base,
 				binfo->bi_immr_base, MPC85xx_CCSRBAR_SIZE, _PAGE_IO, 0);
 
 		memset(&p, 0, sizeof (p));
diff --git a/arch/ppc/platforms/85xx/sbc8560.c b/arch/ppc/platforms/85xx/sbc8560.c
--- a/arch/ppc/platforms/85xx/sbc8560.c
+++ b/arch/ppc/platforms/85xx/sbc8560.c
@@ -125,7 +125,7 @@ sbc8560_setup_arch(void)
 #ifdef CONFIG_SERIAL_TEXT_DEBUG
 	/* Invalidate the entry we stole earlier the serial ports
 	 * should be properly mapped */ 
-	invalidate_tlbcam_entry(NUM_TLBCAMS - 1);
+	invalidate_tlbcam_entry(num_tlbcam_entries - 1);
 #endif
 
 	/* setup the board related information for the enet controllers */
@@ -176,7 +176,7 @@ platform_init(unsigned long r3, unsigned
 
 #ifdef CONFIG_SERIAL_TEXT_DEBUG
 	/* Use the last TLB entry to map CCSRBAR to allow access to DUART regs */
-	settlbcam(NUM_TLBCAMS - 1, UARTA_ADDR,
+	settlbcam(num_tlbcam_entries - 1, UARTA_ADDR,
 		  UARTA_ADDR, 0x1000, _PAGE_IO, 0);
 #endif
 
diff --git a/include/asm-ppc/pgtable.h b/include/asm-ppc/pgtable.h
--- a/include/asm-ppc/pgtable.h
+++ b/include/asm-ppc/pgtable.h
@@ -267,8 +267,6 @@ extern unsigned long ioremap_bot, iorema
 #define _PMD_PRESENT_MASK (PAGE_MASK)
 #define _PMD_BAD	(~PAGE_MASK)
 
-#define NUM_TLBCAMS	(16)
-
 #elif defined(CONFIG_8xx)
 /* Definitions for 8xx embedded chips. */
 #define _PAGE_PRESENT	0x0001	/* Page is valid */
