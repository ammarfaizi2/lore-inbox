Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S273296AbTHKVE1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 17:04:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274824AbTHKVE0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 17:04:26 -0400
Received: from palrel10.hp.com ([156.153.255.245]:50384 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S273296AbTHKVD1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 17:03:27 -0400
Date: Mon, 11 Aug 2003 14:03:22 -0700
To: Jeff Garzik <jgarzik@pobox.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.5 IrDA] NSC '39x fixes
Message-ID: <20030811210322.GC21178@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ir260_nsc_39x_fixes.diff :
~~~~~~~~~~~~~~~~~~~~~~~~
		<Patch from Jan Frey>
	o [CORRECT] Make NSC 3839x probe and init *really* work
		The new 3839x code was totally broken.
		Won't affect code for 38108/38338 chips.


diff -u -p linux/include/net/irda/nsc-ircc.d2.h linux/include/net/irda/nsc-ircc.h
--- linux/include/net/irda/nsc-ircc.d2.h	Fri Aug  8 11:01:54 2003
+++ linux/include/net/irda/nsc-ircc.h	Fri Aug  8 11:06:10 2003
@@ -53,6 +53,7 @@
 
 /* Config registers for the '39x (in the logical device bank) */
 #define CFG_39X_LDN	0x07	/* Logical device number (Super I/O bank) */
+#define CFG_39X_SIOCF1	0x21	/* SuperI/O Config */
 #define CFG_39X_ACT	0x30	/* Device activation */
 #define CFG_39X_BASEH	0x60	/* Device base address (high bits) */
 #define CFG_39X_BASEL	0x61	/* Device base address (low bits) */
diff -u -p linux/drivers/net/irda/nsc-ircc.d2.c linux/drivers/net/irda/nsc-ircc.c
--- linux/drivers/net/irda/nsc-ircc.d2.c	Fri Aug  8 11:01:41 2003
+++ linux/drivers/net/irda/nsc-ircc.c	Fri Aug  8 11:19:17 2003
@@ -93,14 +93,16 @@ static nsc_chip_t chips[] = {
 	  nsc_ircc_probe_108, nsc_ircc_init_108 },
 	{ "PC87338", { 0x398, 0x15c, 0x2e }, 0x08, 0xb0, 0xf8, 
 	  nsc_ircc_probe_338, nsc_ircc_init_338 },
-	/* Contributed by Kevin Thayer - OmniBook 6100 */
-	{ "PC87338?", { 0x2e, 0x15c, 0x398 }, 0x08, 0x00, 0xf8, 
-	  nsc_ircc_probe_338, nsc_ircc_init_338 },
 	/* Contributed by Jan Frey - IBM A30/A31 */
-	/* Should use nsc_ircc_probe_39x properly */
 	{ "PC8739x", { 0x2e, 0x4e, 0x0 }, 0x20, 0xea, 0xff, 
 	  nsc_ircc_probe_39x, nsc_ircc_init_39x },
 	{ NULL }
+#if 0
+	/* Probably bogus, "PC8739x" should be the real thing. Jean II */
+	/* Contributed by Kevin Thayer - OmniBook 6100 */
+	{ "PC87338?", { 0x2e, 0x15c, 0x398 }, 0x08, 0x00, 0xf8, 
+	  nsc_ircc_probe_338, nsc_ircc_init_338 },
+#endif
 };
 
 /* Max 4 instances for now */
@@ -699,9 +701,54 @@ static int nsc_ircc_probe_338(nsc_chip_t
 static int nsc_ircc_init_39x(nsc_chip_t *chip, chipio_t *info) 
 {
 	int cfg_base = info->cfg_base;
+	int enabled;
+
+	/* User is shure about his config... accept it. */
+	IRDA_DEBUG(2, "%s(): nsc_ircc_init_39x (user settings): "
+		   "io=0x%04x, irq=%d, dma=%d\n", 
+		   __FUNCTION__, info->fir_base, info->irq, info->dma);
+
+	/* Access bank for SP2 */
+	outb(CFG_39X_LDN, cfg_base);
+	outb(0x02, cfg_base+1);
+
+	/* Configure SP2 */
+
+	/* We want to enable the device if not enabled */
+	outb(CFG_39X_ACT, cfg_base);
+	enabled = inb(cfg_base+1) & 0x01;
+	
+	if (!enabled) {
+		/* Enable the device */
+		outb(CFG_39X_SIOCF1, cfg_base);
+		outb(0x01, cfg_base+1);
+		/* May want to update info->enabled. Jean II */
+	}
+
+	/* Enable UART bank switching (bit 7) ; Sets the chip to normal
+	 * power mode (wake up from sleep mode) (bit 1) */
+	outb(CFG_39X_SPC, cfg_base);
+	outb(0x82, cfg_base+1);
+
+	return 0;
+}
+
+/*
+ * Function nsc_ircc_probe_39x (chip, info)
+ *
+ *    Test if we really have a '39x chip at the given address
+ *
+ * Note : this code was written by Jan Frey <janfrey@web.de>
+ */
+static int nsc_ircc_probe_39x(nsc_chip_t *chip, chipio_t *info) 
+{
+	int cfg_base = info->cfg_base;
 	int reg1, reg2, irq, irqt, dma1, dma2;
 	int enabled, susp;
 
+	IRDA_DEBUG(2, "%s(), nsc_ircc_probe_39x, base=%d\n",
+		   __FUNCTION__, cfg_base);
+
 	/* This function should be executed with irq off to avoid
 	 * another driver messing with the Super I/O bank - Jean II */
 
@@ -709,7 +756,7 @@ static int nsc_ircc_init_39x(nsc_chip_t 
 	outb(CFG_39X_LDN, cfg_base);
 	outb(0x02, cfg_base+1);
 
-	/* Read infos about SP2 */
+	/* Read infos about SP2 ; store in info struct */
 	outb(CFG_39X_BASEH, cfg_base);
 	reg1 = inb(cfg_base+1);
 	outb(CFG_39X_BASEL, cfg_base);
@@ -729,133 +776,30 @@ static int nsc_ircc_init_39x(nsc_chip_t 
 	info->dma = dma1 -1;
 
 	outb(CFG_39X_ACT, cfg_base);
-	enabled = inb(cfg_base+1) & 0x01;
-
+	info->enabled = enabled = inb(cfg_base+1) & 0x01;
+	
 	outb(CFG_39X_SPC, cfg_base);
 	susp = 1 - ((inb(cfg_base+1) & 0x02) >> 1);
 
-	/* We should store those values in info ? Jean II */
-
 	IRDA_DEBUG(2, "%s(): io=0x%02x%02x, irq=%d (type %d), rxdma=%d, txdma=%d, enabled=%d (suspended=%d)\n", __FUNCTION__, reg1,reg2,irq,irqt,dma1,dma2,enabled,susp);
 
 	/* Configure SP2 */
 
-	/* Do we want to enable the device if not enabled ? */
-
-	/* Enable UART bank switching (bit 7) */
-	outb(CFG_39X_SPC, cfg_base);
-	outb(0x80, cfg_base+1);
-
-	return 0;
-}
-
-/*
- * Function nsc_ircc_probe_39x (chip, info)
- *
- *    Test if we really have a '39x chip at the given address
- *
- */
-static int nsc_ircc_probe_39x(nsc_chip_t *chip, chipio_t *info) 
-{
-#if 0
-	int cfg_base = info->cfg_base;
-	int reg, com = 0;
-	int pnp;
-#endif
-
-	/* Why are we using the '338 configuration registers in here ?
-	 * This probably need to be rewritten...
-	 * Jean II */
-#if 0
-	/* Read funtion enable register (FER) */
-	outb(CFG_338_FER, cfg_base);
-	reg = inb(cfg_base+1);
-
-	info->enabled = (reg >> 2) & 0x01;
-
-	/* Check if we are in Legacy or PnP mode */
-	outb(CFG_338_PNP0, cfg_base);
-	reg = inb(cfg_base+1);
+	/* We want to enable the device if not enabled */
+	outb(CFG_39X_ACT, cfg_base);
+	enabled = inb(cfg_base+1) & 0x01;
 	
-	pnp = (reg >> 3) & 0x01;
-	if (pnp) {
-		IRDA_DEBUG(2, "(), Chip is in PnP mode\n");
-		outb(0x46, cfg_base);
-		reg = (inb(cfg_base+1) & 0xfe) << 2;
-
-		outb(0x47, cfg_base);
-		reg |= ((inb(cfg_base+1) & 0xfc) << 8);
-
-		info->fir_base = reg;
-	} else {
-		/* Read function address register (FAR) */
-		outb(CFG_338_FAR, cfg_base);
-		reg = inb(cfg_base+1);
-		
-		switch ((reg >> 4) & 0x03) {
-		case 0:
-			info->fir_base = 0x3f8;
-			break;
-		case 1:
-			info->fir_base = 0x2f8;
-			break;
-		case 2:
-			com = 3;
-			break;
-		case 3:
-			com = 4;
-			break;
-		}
-		
-		if (com) {
-			switch ((reg >> 6) & 0x03) {
-			case 0:
-				if (com == 3)
-					info->fir_base = 0x3e8;
-				else
-					info->fir_base = 0x2e8;
-				break;
-			case 1:
-				if (com == 3)
-					info->fir_base = 0x338;
-				else
-					info->fir_base = 0x238;
-				break;
-			case 2:
-				if (com == 3)
-					info->fir_base = 0x2e8;
-				else
-					info->fir_base = 0x2e0;
-				break;
-			case 3:
-				if (com == 3)
-					info->fir_base = 0x220;
-				else
-					info->fir_base = 0x228;
-				break;
-			}
-		}
+	if (!enabled) {
+		/* Enable the device */
+		outb(CFG_39X_SIOCF1, cfg_base);
+		outb(0x01, cfg_base+1);
+		/* May want to update info->enabled. Jean II */
 	}
-	info->sir_base = info->fir_base;
 
-	/* Read PnP register 1 (PNP1) */
-	outb(CFG_338_PNP1, cfg_base);
-	reg = inb(cfg_base+1);
-	
-	info->irq = reg >> 4;
-	
-	/* Read PnP register 3 (PNP3) */
-	outb(CFG_338_PNP3, cfg_base);
-	reg = inb(cfg_base+1);
-
-	info->dma = (reg & 0x07) - 1;
-
-	/* Read power and test register (PTR) */
-	outb(CFG_338_PTR, cfg_base);
-	reg = inb(cfg_base+1);
-
-	info->suspended = reg & 0x01;
-#endif
+	/* Enable UART bank switching (bit 7) ; Sets the chip to normal
+	 * power mode (wake up from sleep mode) (bit 1) */
+	outb(CFG_39X_SPC, cfg_base);
+	outb(0x82, cfg_base+1);
 
 	return 0;
 }
