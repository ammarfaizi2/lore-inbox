Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268715AbTGIXkd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jul 2003 19:40:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268720AbTGIXj5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jul 2003 19:39:57 -0400
Received: from palrel10.hp.com ([156.153.255.245]:4305 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S266217AbTGIXiq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jul 2003 19:38:46 -0400
Date: Wed, 9 Jul 2003 16:53:23 -0700
To: Jeff Garzik <jgarzik@pobox.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.5 IrDA] nsc 39x support
Message-ID: <20030709235323.GI12747@bougret.hpl.hp.com>
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

ir254_nsc_39x-1.diff :
~~~~~~~~~~~~~~~~~~~~
		<Original patch from Jan Frey>
	o [FEATURE] Add preliminary support for NSC PC8739x chipset
		(IBM R31 laptops)


diff -u -p linux/include/net/irda/nsc-ircc.d0.h linux/include/net/irda/nsc-ircc.h
--- linux/include/net/irda/nsc-ircc.d0.h	Wed Jul  9 15:45:54 2003
+++ linux/include/net/irda/nsc-ircc.h	Wed Jul  9 15:47:24 2003
@@ -39,17 +39,28 @@
 #define DMA_RX_MODE     0x04    /* I/O to mem, ++, demand. */
 
 /* Config registers for the '108 */
-#define CFG_BAIC 0x00
-#define CFG_CSRT 0x01
-#define CFG_MCTL 0x02
+#define CFG_108_BAIC 0x00
+#define CFG_108_CSRT 0x01
+#define CFG_108_MCTL 0x02
 
 /* Config registers for the '338 */
-#define CFG_FER  0x00
-#define CFG_FAR  0x01
-#define CFG_PTR  0x02
-#define CFG_PNP0 0x1b
-#define CFG_PNP1 0x1c
-#define CFG_PNP3 0x4f
+#define CFG_338_FER  0x00
+#define CFG_338_FAR  0x01
+#define CFG_338_PTR  0x02
+#define CFG_338_PNP0 0x1b
+#define CFG_338_PNP1 0x1c
+#define CFG_338_PNP3 0x4f
+
+/* Config registers for the '39x (in the logical device bank) */
+#define CFG_39X_LDN	0x07	/* Logical device number (Super I/O bank) */
+#define CFG_39X_ACT	0x30	/* Device activation */
+#define CFG_39X_BASEH	0x60	/* Device base address (high bits) */
+#define CFG_39X_BASEL	0x61	/* Device base address (low bits) */
+#define CFG_39X_IRQNUM	0x70	/* Interrupt number & wake up enable */
+#define CFG_39X_IRQSEL	0x71	/* Interrupt select (edge/level + polarity) */
+#define CFG_39X_DMA0	0x74	/* DMA 0 configuration */
+#define CFG_39X_DMA1	0x75	/* DMA 1 configuration */
+#define CFG_39X_SPC	0xF0	/* Serial port configuration register */
 
 /* Flags for configuration register CRF0 */
 #define APEDCRC		0x02
diff -u -p linux/drivers/net/irda/nsc-ircc.d0.c linux/drivers/net/irda/nsc-ircc.c
--- linux/drivers/net/irda/nsc-ircc.d0.c	Wed Jul  9 15:46:07 2003
+++ linux/drivers/net/irda/nsc-ircc.c	Wed Jul  9 15:47:24 2003
@@ -81,8 +81,10 @@ static unsigned int dma[] = { 0, 0, 0, 0
 
 static int nsc_ircc_probe_108(nsc_chip_t *chip, chipio_t *info);
 static int nsc_ircc_probe_338(nsc_chip_t *chip, chipio_t *info);
+static int nsc_ircc_probe_39x(nsc_chip_t *chip, chipio_t *info);
 static int nsc_ircc_init_108(nsc_chip_t *chip, chipio_t *info);
 static int nsc_ircc_init_338(nsc_chip_t *chip, chipio_t *info);
+static int nsc_ircc_init_39x(nsc_chip_t *chip, chipio_t *info);
 
 /* These are the known NSC chips */
 static nsc_chip_t chips[] = {
@@ -94,6 +96,10 @@ static nsc_chip_t chips[] = {
 	/* Contributed by Kevin Thayer - OmniBook 6100 */
 	{ "PC87338?", { 0x2e, 0x15c, 0x398 }, 0x08, 0x00, 0xf8, 
 	  nsc_ircc_probe_338, nsc_ircc_init_338 },
+	/* Contributed by Jan Frey - IBM A30/A31 */
+	/* Should use nsc_ircc_probe_39x properly */
+	{ "PC8739x", { 0x2e, 0x4e, 0x0 }, 0x20, 0xea, 0xff, 
+	  nsc_ircc_probe_39x, nsc_ircc_init_39x },
 	{ NULL }
 };
 
@@ -426,7 +432,7 @@ static int nsc_ircc_init_108(nsc_chip_t 
 	outb(0x00, cfg_base+1); /* Disable device */
 	
 	/* Base Address and Interrupt Control Register (BAIC) */
-	outb(0, cfg_base);
+	outb(CFG_108_BAIC, cfg_base);
 	switch (info->fir_base) {
 	case 0x3e8: outb(0x14, cfg_base+1); break;
 	case 0x2e8: outb(0x15, cfg_base+1); break;
@@ -446,7 +452,7 @@ static int nsc_ircc_init_108(nsc_chip_t 
 	case 15: temp = 0x07; break;
 	default: ERROR("%s(), invalid irq", __FUNCTION__);
 	}
-	outb(1, cfg_base);
+	outb(CFG_108_CSRT, cfg_base);
 	
 	switch (info->dma) {	
 	case 0: outb(0x08+temp, cfg_base+1); break;
@@ -455,7 +461,7 @@ static int nsc_ircc_init_108(nsc_chip_t 
 	default: ERROR("%s(), invalid dma", __FUNCTION__);
 	}
 	
-	outb(2, cfg_base);      /* Mode Control Register (MCTL) */
+	outb(CFG_108_MCTL, cfg_base);      /* Mode Control Register (MCTL) */
 	outb(0x03, cfg_base+1); /* Enable device */
 
 	return 0;
@@ -473,7 +479,7 @@ static int nsc_ircc_probe_108(nsc_chip_t
 	int reg;
 
 	/* Read address and interrupt control register (BAIC) */
-	outb(CFG_BAIC, cfg_base);
+	outb(CFG_108_BAIC, cfg_base);
 	reg = inb(cfg_base+1);
 	
 	switch (reg & 0x03) {
@@ -495,7 +501,7 @@ static int nsc_ircc_probe_108(nsc_chip_t
 		   info->fir_base);
 
 	/* Read control signals routing register (CSRT) */
-	outb(CFG_CSRT, cfg_base);
+	outb(CFG_108_CSRT, cfg_base);
 	reg = inb(cfg_base+1);
 
 	switch (reg & 0x07) {
@@ -544,7 +550,7 @@ static int nsc_ircc_probe_108(nsc_chip_t
 	IRDA_DEBUG(2, "%s(), probing dma=%d\n", __FUNCTION__, info->dma);
 
 	/* Read mode control register (MCTL) */
-	outb(CFG_MCTL, cfg_base);
+	outb(CFG_108_MCTL, cfg_base);
 	reg = inb(cfg_base+1);
 
 	info->enabled = reg & 0x01;
@@ -581,13 +587,194 @@ static int nsc_ircc_probe_338(nsc_chip_t
 	int pnp;
 
 	/* Read funtion enable register (FER) */
-	outb(CFG_FER, cfg_base);
+	outb(CFG_338_FER, cfg_base);
+	reg = inb(cfg_base+1);
+
+	info->enabled = (reg >> 2) & 0x01;
+
+	/* Check if we are in Legacy or PnP mode */
+	outb(CFG_338_PNP0, cfg_base);
+	reg = inb(cfg_base+1);
+	
+	pnp = (reg >> 3) & 0x01;
+	if (pnp) {
+		IRDA_DEBUG(2, "(), Chip is in PnP mode\n");
+		outb(0x46, cfg_base);
+		reg = (inb(cfg_base+1) & 0xfe) << 2;
+
+		outb(0x47, cfg_base);
+		reg |= ((inb(cfg_base+1) & 0xfc) << 8);
+
+		info->fir_base = reg;
+	} else {
+		/* Read function address register (FAR) */
+		outb(CFG_338_FAR, cfg_base);
+		reg = inb(cfg_base+1);
+		
+		switch ((reg >> 4) & 0x03) {
+		case 0:
+			info->fir_base = 0x3f8;
+			break;
+		case 1:
+			info->fir_base = 0x2f8;
+			break;
+		case 2:
+			com = 3;
+			break;
+		case 3:
+			com = 4;
+			break;
+		}
+		
+		if (com) {
+			switch ((reg >> 6) & 0x03) {
+			case 0:
+				if (com == 3)
+					info->fir_base = 0x3e8;
+				else
+					info->fir_base = 0x2e8;
+				break;
+			case 1:
+				if (com == 3)
+					info->fir_base = 0x338;
+				else
+					info->fir_base = 0x238;
+				break;
+			case 2:
+				if (com == 3)
+					info->fir_base = 0x2e8;
+				else
+					info->fir_base = 0x2e0;
+				break;
+			case 3:
+				if (com == 3)
+					info->fir_base = 0x220;
+				else
+					info->fir_base = 0x228;
+				break;
+			}
+		}
+	}
+	info->sir_base = info->fir_base;
+
+	/* Read PnP register 1 (PNP1) */
+	outb(CFG_338_PNP1, cfg_base);
+	reg = inb(cfg_base+1);
+	
+	info->irq = reg >> 4;
+	
+	/* Read PnP register 3 (PNP3) */
+	outb(CFG_338_PNP3, cfg_base);
+	reg = inb(cfg_base+1);
+
+	info->dma = (reg & 0x07) - 1;
+
+	/* Read power and test register (PTR) */
+	outb(CFG_338_PTR, cfg_base);
+	reg = inb(cfg_base+1);
+
+	info->suspended = reg & 0x01;
+
+	return 0;
+}
+
+
+/*
+ * Function nsc_ircc_init_39x (chip, info)
+ *
+ *    Now that we know it's a '39x (see probe below), we need to
+ *    configure it so we can use it.
+ *
+ * The NSC '338 chip is a Super I/O chip with a "bank" architecture,
+ * the configuration of the different functionality (serial, parallel,
+ * floppy...) are each in a different bank (Logical Device Number).
+ * The base address, irq and dma configuration registers are common
+ * to all functionalities (index 0x30 to 0x7F).
+ * There is only one configuration register specific to the
+ * serial port, CFG_39X_SPC.
+ * JeanII
+ *
+ * Note : this code was written by Jan Frey <janfrey@web.de>
+ */
+static int nsc_ircc_init_39x(nsc_chip_t *chip, chipio_t *info) 
+{
+	int cfg_base = info->cfg_base;
+	int reg1, reg2, irq, irqt, dma1, dma2;
+	int enabled, susp;
+
+	/* This function should be executed with irq off to avoid
+	 * another driver messing with the Super I/O bank - Jean II */
+
+	/* Access bank for SP2 */
+	outb(CFG_39X_LDN, cfg_base);
+	outb(0x02, cfg_base+1);
+
+	/* Read infos about SP2 */
+	outb(CFG_39X_BASEH, cfg_base);
+	reg1 = inb(cfg_base+1);
+	outb(CFG_39X_BASEL, cfg_base);
+	reg2 = inb(cfg_base+1);
+	info->fir_base = (reg1 << 8) | reg2;
+
+	outb(CFG_39X_IRQNUM, cfg_base);
+	irq = inb(cfg_base+1);
+	outb(CFG_39X_IRQSEL, cfg_base);
+	irqt = inb(cfg_base+1);
+	info->irq = irq;
+
+	outb(CFG_39X_DMA0, cfg_base);
+	dma1 = inb(cfg_base+1);
+	outb(CFG_39X_DMA1, cfg_base);
+	dma2 = inb(cfg_base+1);
+	info->dma = dma1 -1;
+
+	outb(CFG_39X_ACT, cfg_base);
+	enabled = inb(cfg_base+1) & 0x01;
+
+	outb(CFG_39X_SPC, cfg_base);
+	susp = 1 - ((inb(cfg_base+1) & 0x02) >> 1);
+
+	/* We should store those values in info ? Jean II */
+
+	IRDA_DEBUG(2, "%s(): io=0x%02x%02x, irq=%d (type %d), rxdma=%d, txdma=%d, enabled=%d (suspended=%d)\n", __FUNCTION__, reg1,reg2,irq,irqt,dma1,dma2,enabled,susp);
+
+	/* Configure SP2 */
+
+	/* Do we want to enable the device if not enabled ? */
+
+	/* Enable UART bank switching (bit 7) */
+	outb(CFG_39X_SPC, cfg_base);
+	outb(0x80, cfg_base+1);
+
+	return 0;
+}
+
+/*
+ * Function nsc_ircc_probe_39x (chip, info)
+ *
+ *    Test if we really have a '39x chip at the given address
+ *
+ */
+static int nsc_ircc_probe_39x(nsc_chip_t *chip, chipio_t *info) 
+{
+#if 0
+	int cfg_base = info->cfg_base;
+	int reg, com = 0;
+	int pnp;
+#endif
+
+	/* Why are we using the '338 configuration registers in here ?
+	 * This probably need to be rewritten...
+	 * Jean II */
+#if 0
+	/* Read funtion enable register (FER) */
+	outb(CFG_338_FER, cfg_base);
 	reg = inb(cfg_base+1);
 
 	info->enabled = (reg >> 2) & 0x01;
 
 	/* Check if we are in Legacy or PnP mode */
-	outb(CFG_PNP0, cfg_base);
+	outb(CFG_338_PNP0, cfg_base);
 	reg = inb(cfg_base+1);
 	
 	pnp = (reg >> 3) & 0x01;
@@ -602,7 +789,7 @@ static int nsc_ircc_probe_338(nsc_chip_t
 		info->fir_base = reg;
 	} else {
 		/* Read function address register (FAR) */
-		outb(CFG_FAR, cfg_base);
+		outb(CFG_338_FAR, cfg_base);
 		reg = inb(cfg_base+1);
 		
 		switch ((reg >> 4) & 0x03) {
@@ -652,22 +839,23 @@ static int nsc_ircc_probe_338(nsc_chip_t
 	info->sir_base = info->fir_base;
 
 	/* Read PnP register 1 (PNP1) */
-	outb(CFG_PNP1, cfg_base);
+	outb(CFG_338_PNP1, cfg_base);
 	reg = inb(cfg_base+1);
 	
 	info->irq = reg >> 4;
 	
 	/* Read PnP register 3 (PNP3) */
-	outb(CFG_PNP3, cfg_base);
+	outb(CFG_338_PNP3, cfg_base);
 	reg = inb(cfg_base+1);
 
 	info->dma = (reg & 0x07) - 1;
 
 	/* Read power and test register (PTR) */
-	outb(CFG_PTR, cfg_base);
+	outb(CFG_338_PTR, cfg_base);
 	reg = inb(cfg_base+1);
 
 	info->suspended = reg & 0x01;
+#endif
 
 	return 0;
 }
