Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263580AbUAPAYk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jan 2004 19:24:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263564AbUAPAYk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jan 2004 19:24:40 -0500
Received: from palrel12.hp.com ([156.153.255.237]:30160 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id S263777AbUAPAX4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jan 2004 19:23:56 -0500
Date: Thu, 15 Jan 2004 16:23:54 -0800
To: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Jeff Garzik <jgarzik@pobox.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.4 IrDA] NSC '39x support
Message-ID: <20040116002354.GB2837@bougret.hpl.hp.com>
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

ir244_nsc_39x-2.diff :
~~~~~~~~~~~~~~~~~~~~
		<Original patch from Jan Frey>
	o [FEATURE] Add support for NSC PC8739x chipset	(IBM A/R31 laptops)


diff -u -p linux/include/net/irda/nsc-ircc.d5.h linux/include/net/irda/nsc-ircc.h
--- linux/include/net/irda/nsc-ircc.d5.h	Wed Jan 14 18:18:54 2004
+++ linux/include/net/irda/nsc-ircc.h	Wed Jan 14 18:21:16 2004
@@ -39,17 +39,29 @@
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
+#define CFG_39X_SIOCF1	0x21	/* SuperI/O Config */
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
--- linux/drivers/net/irda/nsc-ircc.d5.c	Wed Jan 14 18:18:22 2004
+++ linux/drivers/net/irda/nsc-ircc.c	Wed Jan 14 18:21:16 2004
@@ -83,8 +83,10 @@ static unsigned int dma[] = { 0, 0, 0, 0
 
 static int nsc_ircc_probe_108(nsc_chip_t *chip, chipio_t *info);
 static int nsc_ircc_probe_338(nsc_chip_t *chip, chipio_t *info);
+static int nsc_ircc_probe_39x(nsc_chip_t *chip, chipio_t *info);
 static int nsc_ircc_init_108(nsc_chip_t *chip, chipio_t *info);
 static int nsc_ircc_init_338(nsc_chip_t *chip, chipio_t *info);
+static int nsc_ircc_init_39x(nsc_chip_t *chip, chipio_t *info);
 
 /* These are the known NSC chips */
 static nsc_chip_t chips[] = {
@@ -93,10 +95,16 @@ static nsc_chip_t chips[] = {
 	  nsc_ircc_probe_108, nsc_ircc_init_108 },
 	{ "PC87338", { 0x398, 0x15c, 0x2e }, 0x08, 0xb0, 0xf8, 
 	  nsc_ircc_probe_338, nsc_ircc_init_338 },
+	/* Contributed by Jan Frey - IBM A30/A31 */
+	{ "PC8739x", { 0x2e, 0x4e, 0x0 }, 0x20, 0xea, 0xff, 
+	  nsc_ircc_probe_39x, nsc_ircc_init_39x },
+	{ NULL }
+#if 0
+	/* Probably bogus, "PC8739x" should be the real thing. Jean II */
 	/* Contributed by Kevin Thayer - OmniBook 6100 */
 	{ "PC87338?", { 0x2e, 0x15c, 0x398 }, 0x08, 0x00, 0xf8, 
 	  nsc_ircc_probe_338, nsc_ircc_init_338 },
-	{ NULL }
+#endif
 };
 
 /* Max 4 instances for now */
@@ -439,7 +447,7 @@ static int nsc_ircc_init_108(nsc_chip_t 
 	outb(0x00, cfg_base+1); /* Disable device */
 	
 	/* Base Address and Interrupt Control Register (BAIC) */
-	outb(0, cfg_base);
+	outb(CFG_108_BAIC, cfg_base);
 	switch (info->fir_base) {
 	case 0x3e8: outb(0x14, cfg_base+1); break;
 	case 0x2e8: outb(0x15, cfg_base+1); break;
@@ -459,7 +467,7 @@ static int nsc_ircc_init_108(nsc_chip_t 
 	case 15: temp = 0x07; break;
 	default: ERROR("%s(), invalid irq", __FUNCTION__);
 	}
-	outb(1, cfg_base);
+	outb(CFG_108_CSRT, cfg_base);
 	
 	switch (info->dma) {	
 	case 0: outb(0x08+temp, cfg_base+1); break;
@@ -468,7 +476,7 @@ static int nsc_ircc_init_108(nsc_chip_t 
 	default: ERROR("%s(), invalid dma", __FUNCTION__);
 	}
 	
-	outb(2, cfg_base);      /* Mode Control Register (MCTL) */
+	outb(CFG_108_MCTL, cfg_base);      /* Mode Control Register (MCTL) */
 	outb(0x03, cfg_base+1); /* Enable device */
 
 	return 0;
@@ -486,7 +494,7 @@ static int nsc_ircc_probe_108(nsc_chip_t
 	int reg;
 
 	/* Read address and interrupt control register (BAIC) */
-	outb(CFG_BAIC, cfg_base);
+	outb(CFG_108_BAIC, cfg_base);
 	reg = inb(cfg_base+1);
 	
 	switch (reg & 0x03) {
@@ -508,7 +516,7 @@ static int nsc_ircc_probe_108(nsc_chip_t
 		__FUNCTION__, info->fir_base);
 
 	/* Read control signals routing register (CSRT) */
-	outb(CFG_CSRT, cfg_base);
+	outb(CFG_108_CSRT, cfg_base);
 	reg = inb(cfg_base+1);
 
 	switch (reg & 0x07) {
@@ -557,7 +565,7 @@ static int nsc_ircc_probe_108(nsc_chip_t
 	IRDA_DEBUG(2, "%s(), probing dma=%d\n", __FUNCTION__, info->dma);
 
 	/* Read mode control register (MCTL) */
-	outb(CFG_MCTL, cfg_base);
+	outb(CFG_108_MCTL, cfg_base);
 	reg = inb(cfg_base+1);
 
 	info->enabled = reg & 0x01;
@@ -594,13 +602,13 @@ static int nsc_ircc_probe_338(nsc_chip_t
 	int pnp;
 
 	/* Read funtion enable register (FER) */
-	outb(CFG_FER, cfg_base);
+	outb(CFG_338_FER, cfg_base);
 	reg = inb(cfg_base+1);
 
 	info->enabled = (reg >> 2) & 0x01;
 
 	/* Check if we are in Legacy or PnP mode */
-	outb(CFG_PNP0, cfg_base);
+	outb(CFG_338_PNP0, cfg_base);
 	reg = inb(cfg_base+1);
 	
 	pnp = (reg >> 3) & 0x01;
@@ -615,7 +623,7 @@ static int nsc_ircc_probe_338(nsc_chip_t
 		info->fir_base = reg;
 	} else {
 		/* Read function address register (FAR) */
-		outb(CFG_FAR, cfg_base);
+		outb(CFG_338_FAR, cfg_base);
 		reg = inb(cfg_base+1);
 		
 		switch ((reg >> 4) & 0x03) {
@@ -665,22 +673,146 @@ static int nsc_ircc_probe_338(nsc_chip_t
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
+	int reg1, reg2, irq, irqt, dma1, dma2;
+	int enabled, susp;
+
+	IRDA_DEBUG(2, "%s(), nsc_ircc_probe_39x, base=%d\n",
+		   __FUNCTION__, cfg_base);
+
+	/* This function should be executed with irq off to avoid
+	 * another driver messing with the Super I/O bank - Jean II */
+
+	/* Access bank for SP2 */
+	outb(CFG_39X_LDN, cfg_base);
+	outb(0x02, cfg_base+1);
+
+	/* Read infos about SP2 ; store in info struct */
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
+	info->enabled = enabled = inb(cfg_base+1) & 0x01;
+	
+	outb(CFG_39X_SPC, cfg_base);
+	susp = 1 - ((inb(cfg_base+1) & 0x02) >> 1);
+
+	IRDA_DEBUG(2, "%s(): io=0x%02x%02x, irq=%d (type %d), rxdma=%d, txdma=%d, enabled=%d (suspended=%d)\n", __FUNCTION__, reg1,reg2,irq,irqt,dma1,dma2,enabled,susp);
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
 
 	return 0;
 }
