Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261180AbULMWEk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261180AbULMWEk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Dec 2004 17:04:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261196AbULMWEk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Dec 2004 17:04:40 -0500
Received: from pD953A0E2.dip.t-dialin.net ([217.83.160.226]:27541 "EHLO
	tglx.tec.linutronix.de") by vger.kernel.org with ESMTP
	id S261180AbULMWEM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Dec 2004 17:04:12 -0500
Date: Mon, 13 Dec 2004 23:03:50 +0100
From: tglx@linutronix.de
Message-ID: <20041213230348.1.patchmail@tglx>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
To: <kumar.gala@freescale.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Fix __res data type (PPC 85xx)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Defining the residual board data as char [sizeof(bd_t] and
typecasting it for each access makes not really sense. Use 
the real data type instead.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 arch/ppc/platforms/85xx/mpc8540_ads.c        |    6 +++---
 arch/ppc/platforms/85xx/mpc8560_ads.c        |    4 ++--
 arch/ppc/platforms/85xx/mpc85xx_ads_common.c |    8 +++-----
 arch/ppc/platforms/85xx/mpc85xx_cds_common.c |   13 ++++++-------
 arch/ppc/platforms/85xx/sbc8560.c            |    4 ++--
 arch/ppc/platforms/85xx/sbc85xx.c            |    8 +++-----
 include/asm-ppc/mpc85xx.h                    |    2 +-
 7 files changed, 20 insertions(+), 25 deletions(-)
---
Index: include/asm-ppc/mpc85xx.h
===================================================================
--- include/asm-ppc/mpc85xx.h	(revision 8)
+++ include/asm-ppc/mpc85xx.h	(working copy)
@@ -47,7 +47,7 @@
  * The "residual" board information structure the boot loader passes
  * into the kernel.
  */
-extern unsigned char __res[];
+extern bd_t __res;
 
 /* Internal IRQs on MPC85xx OpenPIC */
 /* Not all of these exist on all MPC85xx implementations */
Index: arch/ppc/platforms/85xx/sbc85xx.c
===================================================================
--- arch/ppc/platforms/85xx/sbc85xx.c	(revision 42)
+++ arch/ppc/platforms/85xx/sbc85xx.c	(working copy)
@@ -48,7 +48,7 @@
 
 #include <platforms/85xx/sbc85xx.h>
 
-unsigned char __res[sizeof (bd_t)];
+bd_t __res;
 
 #ifndef CONFIG_PCI
 unsigned long isa_io_base = 0;
@@ -120,11 +120,10 @@
 {
 	uint pvid, svid, phid1;
 	uint memsize = total_memory;
-	bd_t *binfo = (bd_t *) __res;
 	unsigned int freq;
 
 	/* get the core frequency */
-	freq = binfo->bi_intfreq;
+	freq = __res.bi_intfreq;
 
 	pvid = mfspr(PVR);
 	svid = mfspr(SVR);
@@ -159,10 +158,9 @@
 void __init
 sbc8560_init_IRQ(void)
 {
-	bd_t *binfo = (bd_t *) __res;
 	/* Determine the Physical Address of the OpenPIC regs */
 	phys_addr_t OpenPIC_PAddr =
-	    binfo->bi_immr_base + MPC85xx_OPENPIC_OFFSET;
+	    __res.bi_immr_base + MPC85xx_OPENPIC_OFFSET;
 	OpenPIC_Addr = ioremap(OpenPIC_PAddr, MPC85xx_OPENPIC_SIZE);
 	OpenPIC_InitSenses = sbc8560_openpic_initsenses;
 	OpenPIC_NumInitSenses = sizeof (sbc8560_openpic_initsenses);
Index: arch/ppc/platforms/85xx/mpc85xx_ads_common.c
===================================================================
--- arch/ppc/platforms/85xx/mpc85xx_ads_common.c	(revision 42)
+++ arch/ppc/platforms/85xx/mpc85xx_ads_common.c	(working copy)
@@ -56,7 +56,7 @@
 
 extern unsigned long total_memory;	/* in mm/init */
 
-unsigned char __res[sizeof (bd_t)];
+bd_t __res;
 
 /* Internal interrupts are all Level Sensitive, and Positive Polarity */
 
@@ -120,11 +120,10 @@
 {
 	uint pvid, svid, phid1;
 	uint memsize = total_memory;
-	bd_t *binfo = (bd_t *) __res;
 	unsigned int freq;
 
 	/* get the core frequency */
-	freq = binfo->bi_intfreq;
+	freq = __res.bi_intfreq;
 
 	pvid = mfspr(PVR);
 	svid = mfspr(SVR);
@@ -159,10 +158,9 @@
 void __init
 mpc85xx_ads_init_IRQ(void)
 {
-	bd_t *binfo = (bd_t *) __res;
 	/* Determine the Physical Address of the OpenPIC regs */
 	phys_addr_t OpenPIC_PAddr =
-	    binfo->bi_immr_base + MPC85xx_OPENPIC_OFFSET;
+	    __res.bi_immr_base + MPC85xx_OPENPIC_OFFSET;
 	OpenPIC_Addr = ioremap(OpenPIC_PAddr, MPC85xx_OPENPIC_SIZE);
 	OpenPIC_InitSenses = mpc85xx_ads_openpic_initsenses;
 	OpenPIC_NumInitSenses = sizeof (mpc85xx_ads_openpic_initsenses);
Index: arch/ppc/platforms/85xx/mpc85xx_cds_common.c
===================================================================
--- arch/ppc/platforms/85xx/mpc85xx_cds_common.c	(revision 42)
+++ arch/ppc/platforms/85xx/mpc85xx_cds_common.c	(working copy)
@@ -64,7 +64,7 @@
 
 extern unsigned long total_memory;      /* in mm/init */
 
-unsigned char __res[sizeof (bd_t)];
+bd_t __res;
 
 static int cds_pci_slot = 2;
 static volatile u8 * cadmus;
@@ -161,11 +161,10 @@
 {
         uint pvid, svid, phid1;
         uint memsize = total_memory;
-        bd_t *binfo = (bd_t *) __res;
         unsigned int freq;
 
         /* get the core frequency */
-        freq = binfo->bi_intfreq;
+        freq = __res.bi_intfreq;
 
         pvid = mfspr(PVR);
         svid = mfspr(SVR);
@@ -204,7 +203,7 @@
 void __init
 mpc85xx_cds_init_IRQ(void)
 {
-	bd_t *binfo = (bd_t *) __res;
+	bd_t *binfo = &__res;
 #ifdef CONFIG_CPM2
 	volatile cpm2_map_t *immap = cpm2_immr;
 	int i;
@@ -337,7 +336,7 @@
 {
         struct ocp_def *def;
         struct ocp_gfar_data *einfo;
-        bd_t *binfo = (bd_t *) __res;
+        bd_t *binfo = &__res;
         unsigned int freq;
 
         /* get the core frequency */
@@ -411,13 +410,13 @@
          * residual data area.
          */
         if (r3) {
-                memcpy((void *) __res, (void *) (r3 + KERNELBASE),
+                memcpy((void *) &__res, (void *) (r3 + KERNELBASE),
                        sizeof (bd_t));
 
         }
 #ifdef CONFIG_SERIAL_TEXT_DEBUG
 	{
-		bd_t *binfo = (bd_t *) __res;
+		bd_t *binfo = &__res;
 
 		/* Use the last TLB entry to map CCSRBAR to allow access to DUART regs */
 		settlbcam(NUM_TLBCAMS - 1, binfo->bi_immr_base,
Index: arch/ppc/platforms/85xx/mpc8540_ads.c
===================================================================
--- arch/ppc/platforms/85xx/mpc8540_ads.c	(revision 42)
+++ arch/ppc/platforms/85xx/mpc8540_ads.c	(working copy)
@@ -102,7 +102,7 @@
 {
 	struct ocp_def *def;
 	struct ocp_gfar_data *einfo;
-	bd_t *binfo = (bd_t *) __res;
+	bd_t *binfo = &__res;
 	unsigned int freq;
 
 	/* get the core frequency */
@@ -175,12 +175,12 @@
 	 * residual data area.
 	 */
 	if (r3) {
-		memcpy((void *) __res, (void *) (r3 + KERNELBASE),
+		memcpy((void *) &__res, (void *) (r3 + KERNELBASE),
 		       sizeof (bd_t));
 	}
 #ifdef CONFIG_SERIAL_TEXT_DEBUG
 	{
-		bd_t *binfo = (bd_t *) __res;
+		bd_t *binfo = &__res;
 
 		/* Use the last TLB entry to map CCSRBAR to allow access to DUART regs */
 		settlbcam(NUM_TLBCAMS - 1, binfo->bi_immr_base,
Index: arch/ppc/platforms/85xx/mpc8560_ads.c
===================================================================
--- arch/ppc/platforms/85xx/mpc8560_ads.c	(revision 42)
+++ arch/ppc/platforms/85xx/mpc8560_ads.c	(working copy)
@@ -97,7 +97,7 @@
 {
 	struct ocp_def *def;
 	struct ocp_gfar_data *einfo;
-	bd_t *binfo = (bd_t *) __res;
+	bd_t *binfo = &__res;
 	unsigned int freq;
 
 	cpm2_reset();
@@ -200,7 +200,7 @@
 	 * residual data area.
 	 */
 	if (r3) {
-		memcpy((void *) __res, (void *) (r3 + KERNELBASE),
+		memcpy((void *) &__res, (void *) (r3 + KERNELBASE),
 		       sizeof (bd_t));
 
 	}
Index: arch/ppc/platforms/85xx/sbc8560.c
===================================================================
--- arch/ppc/platforms/85xx/sbc8560.c	(revision 42)
+++ arch/ppc/platforms/85xx/sbc8560.c	(working copy)
@@ -127,7 +127,7 @@
 {
 	struct ocp_def *def;
 	struct ocp_gfar_data *einfo;
-	bd_t *binfo = (bd_t *) __res;
+	bd_t *binfo = &__res;
 	unsigned int freq;
 
 	/* get the core frequency */
@@ -193,7 +193,7 @@
 	 * residual data area.
 	 */
 	if (r3) {
-		memcpy((void *) __res, (void *) (r3 + KERNELBASE),
+		memcpy((void *) &__res, (void *) (r3 + KERNELBASE),
 		       sizeof (bd_t));
 	}
 
