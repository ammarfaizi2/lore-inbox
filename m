Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263429AbUHAAS1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263429AbUHAAS1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Jul 2004 20:18:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263159AbUHAAS1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Jul 2004 20:18:27 -0400
Received: from mx1.redhat.com ([66.187.233.31]:40678 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261474AbUHAAQI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Jul 2004 20:16:08 -0400
Date: Sat, 31 Jul 2004 20:15:22 -0400
From: Alan Cox <alan@redhat.com>
To: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, akpm@osdl.org,
       torvalds@osdl.org
Subject: PATCH: Fix HPT366 crash and support HPT372N
Message-ID: <20040801001522.GA13954@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On a board containing the HPT372N IDE controller the 2.6.x series kernels will
misbehave. If the HPT372N is set up with the newer PCI identifier it is 
ignored. If it is set up with the HPT372 identifier then the kernel crashes
on boot.

This patch is a forward port of my 2.4 driver fixes that have been in 2.4
for a year but somehow escaped 2.6. Ronny Buchmann caught a couple
of merge details I missed and those are fixed in this diff too.

As well as adding 372N support this also fixes the unknown revision case
to avoid crashes should any future 37x variants with weird class_rev's appear

Alan

Signed-off-by: Alan Cox <alan@redhat.com>

--- linux.vanilla-2.6.8-rc2/drivers/ide/pci/hpt366.c	2004-07-27 19:22:42.000000000 +0100
+++ linux-2.6.8-rc2/drivers/ide/pci/hpt366.c	2004-08-01 00:58:30.948290640 +0100
@@ -1,8 +1,9 @@
 /*
- * linux/drivers/ide/pci/hpt366.c		Version 0.34	Sept 17, 2002
+ * linux/drivers/ide/pci/hpt366.c		Version 0.36	April 25, 2003
  *
  * Copyright (C) 1999-2003		Andre Hedrick <andre@linux-ide.org>
  * Portions Copyright (C) 2001	        Sun Microsystems, Inc.
+ * Portions Copyright (C) 2003		Red Hat Inc
  *
  * Thanks to HighPoint Technologies for their assistance, and hardware.
  * Special Thanks to Jon Burchmore in SanDiego for the deep pockets, his
@@ -39,6 +40,13 @@
  * Reset the hpt366 on error, reset on dma
  * Fix disabling Fast Interrupt hpt366.
  * 	Mike Waychison <crlf@sun.com>
+ *
+ * Added support for 372N clocking and clock switching. The 372N needs
+ * different clocks on read/write. This requires overloading rw_disk and
+ * other deeply crazy things. Thanks to <http://www.hoerstreich.de> for
+ * keeping me sane. 
+ *		Alan Cox <alan@redhat.com>
+ *
  */
 
 
@@ -168,6 +176,9 @@
 	class_rev &= 0xff;
 
 	switch(dev->device) {
+		/* Remap new 372N onto 372 */
+		case PCI_DEVICE_ID_TTI_HPT372N:
+			class_rev = PCI_DEVICE_ID_TTI_HPT372; break;
 		case PCI_DEVICE_ID_TTI_HPT374:
 			class_rev = PCI_DEVICE_ID_TTI_HPT374; break;
 		case PCI_DEVICE_ID_TTI_HPT371:
@@ -217,6 +228,11 @@
 	return mode;
 }
 
+/*
+ *	Note for the future; the SATA hpt37x we must set
+ *	either PIO or UDMA modes 0,4,5
+ */
+ 
 static u8 hpt3xx_ratefilter (ide_drive_t *drive, u8 speed)
 {
 	struct pci_dev *dev	= HWIF(drive)->pci_dev;
@@ -672,6 +688,69 @@
 	return __ide_dma_end(drive);
 }
 
+/**
+ *	hpt372n_set_clock	-	perform clock switching dance
+ *	@drive: Drive to switch
+ *	@mode: Switching mode (0x21 for write, 0x23 otherwise)
+ *
+ *	Switch the DPLL clock on the HPT372N devices. This is a
+ *	right mess.
+ */
+ 
+static void hpt372n_set_clock(ide_drive_t *drive, int mode)
+{
+	ide_hwif_t *hwif	= HWIF(drive);
+	
+	/* FIXME: should we check for DMA active and BUG() */
+	/* Tristate the bus */
+	outb(0x80, hwif->dma_base+0x73);
+	outb(0x80, hwif->dma_base+0x77);
+	
+	/* Switch clock and reset channels */
+	outb(mode, hwif->dma_base+0x7B);
+	outb(0xC0, hwif->dma_base+0x79);
+	
+	/* Reset state machines */
+	outb(0x37, hwif->dma_base+0x70);
+	outb(0x37, hwif->dma_base+0x74);
+	
+	/* Complete reset */
+	outb(0x00, hwif->dma_base+0x79);
+	
+	/* Reconnect channels to bus */
+	outb(0x00, hwif->dma_base+0x73);
+	outb(0x00, hwif->dma_base+0x77);
+}
+
+/**
+ *	hpt372n_rw_disk		-	wrapper for I/O
+ *	@drive: drive for command
+ *	@rq: block request structure
+ *	@block: block number
+ *
+ *	This is called when a disk I/O is issued to the 372N instead
+ *	of the default functionality. We need it because of the clock
+ *	switching
+ *
+ */
+ 
+static ide_startstop_t hpt372n_rw_disk(ide_drive_t *drive, struct request *rq, sector_t block)
+{
+	int wantclock;
+	
+	if(rq_data_dir(rq) == READ)
+		wantclock = 0x21;
+	else
+		wantclock = 0x23;
+		
+	if(HWIF(drive)->config_data != wantclock)
+	{
+		hpt372n_set_clock(drive, wantclock);
+		HWIF(drive)->config_data = wantclock;
+	}
+	return __ide_do_rw_disk(drive, rq, block);
+}
+
 /*
  * Since SUN Cobalt is attempting to do this operation, I should disclose
  * this has been a long time ago Thu Jul 27 16:40:57 2000 was the patch date
@@ -793,13 +872,23 @@
 	u16 freq;
 	u32 pll;
 	u8 reg5bh;
-
-#if 1
 	u8 reg5ah = 0;
+	unsigned long dmabase = pci_resource_start(dev, 4);
+	u8 did, rid;	
+	int is_372n = 0;
+	
 	pci_read_config_byte(dev, 0x5a, &reg5ah);
 	/* interrupt force enable */
 	pci_write_config_byte(dev, 0x5a, (reg5ah & ~0x10));
-#endif
+
+	if(dmabase)
+	{
+		did = inb(dmabase + 0x22);
+		rid = inb(dmabase + 0x28);
+	
+		if((did == 4 && rid == 6) || (did == 5 && rid > 1))
+			is_372n = 1;
+	}
 
 	/*
 	 * default to pci clock. make sure MA15/16 are set to output
@@ -810,47 +899,86 @@
 	/*
 	 * set up the PLL. we need to adjust it so that it's stable. 
 	 * freq = Tpll * 192 / Tpci
+	 *
+	 * Todo. For non x86 should probably check the dword is
+	 * set to 0xABCDExxx indicating the BIOS saved f_CNT
 	 */
 	pci_read_config_word(dev, 0x78, &freq);
 	freq &= 0x1FF;
-	if (freq < 0xa0) {
-		pll = F_LOW_PCI_33;
-		if (hpt_minimum_revision(dev,8))
-			pci_set_drvdata(dev, (void *) thirty_three_base_hpt374);
-		else if (hpt_minimum_revision(dev,5))
-			pci_set_drvdata(dev, (void *) thirty_three_base_hpt372);
-		else if (hpt_minimum_revision(dev,4))
-			pci_set_drvdata(dev, (void *) thirty_three_base_hpt370a);
+	
+	/*
+	 * The 372N uses different PCI clock information and has
+	 * some other complications
+	 *	On PCI33 timing we must clock switch
+	 *	On PCI66 timing we must NOT use the PCI clock
+	 *
+	 * Currently we always set up the PLL for the 372N
+	 */
+	 
+	pci_set_drvdata(dev, NULL);
+	
+	if(is_372n)
+	{
+		printk(KERN_INFO "hpt: HPT372N detected, using 372N timing.\n");
+		if(freq < 0x55)
+			pll = F_LOW_PCI_33;
+		else if(freq < 0x70)
+			pll = F_LOW_PCI_40;
+		else if(freq < 0x7F)
+			pll = F_LOW_PCI_50;
 		else
-			pci_set_drvdata(dev, (void *) thirty_three_base_hpt370);
-		printk("HPT37X: using 33MHz PCI clock\n");
-	} else if (freq < 0xb0) {
-		pll = F_LOW_PCI_40;
-	} else if (freq < 0xc8) {
-		pll = F_LOW_PCI_50;
-		if (hpt_minimum_revision(dev,8))
-			pci_set_drvdata(dev, NULL);
-		else if (hpt_minimum_revision(dev,5))
-			pci_set_drvdata(dev, (void *) fifty_base_hpt372);
-		else if (hpt_minimum_revision(dev,4))
-			pci_set_drvdata(dev, (void *) fifty_base_hpt370a);
+			pll = F_LOW_PCI_66;
+			
+		printk(KERN_INFO "FREQ: %d PLL: %d\n", freq, pll);
+			
+		/* We always use the pll not the PCI clock on 372N */
+	}
+	else
+	{
+		if(freq < 0x9C)
+			pll = F_LOW_PCI_33;
+		else if(freq < 0xb0)
+			pll = F_LOW_PCI_40;
+		else if(freq <0xc8)
+			pll = F_LOW_PCI_50;
 		else
-			pci_set_drvdata(dev, (void *) fifty_base_hpt370a);
-		printk("HPT37X: using 50MHz PCI clock\n");
-	} else {
-		pll = F_LOW_PCI_66;
-		if (hpt_minimum_revision(dev,8))
-		{
-			printk(KERN_ERR "HPT37x: 66MHz timings are not supported.\n");
-			pci_set_drvdata(dev, NULL);
+			pll = F_LOW_PCI_66;
+	
+		if (pll == F_LOW_PCI_33) {
+			if (hpt_minimum_revision(dev,8))
+				pci_set_drvdata(dev, (void *) thirty_three_base_hpt374);
+			else if (hpt_minimum_revision(dev,5))
+				pci_set_drvdata(dev, (void *) thirty_three_base_hpt372);
+			else if (hpt_minimum_revision(dev,4))
+				pci_set_drvdata(dev, (void *) thirty_three_base_hpt370a);
+			else
+				pci_set_drvdata(dev, (void *) thirty_three_base_hpt370);
+			printk("HPT37X: using 33MHz PCI clock\n");
+		} else if (pll == F_LOW_PCI_40) {
+			/* Unsupported */
+		} else if (pll == F_LOW_PCI_50) {
+			if (hpt_minimum_revision(dev,8))
+				pci_set_drvdata(dev, NULL);
+			else if (hpt_minimum_revision(dev,5))
+				pci_set_drvdata(dev, (void *) fifty_base_hpt372);
+			else if (hpt_minimum_revision(dev,4))
+				pci_set_drvdata(dev, (void *) fifty_base_hpt370a);
+			else
+				pci_set_drvdata(dev, (void *) fifty_base_hpt370a);
+			printk("HPT37X: using 50MHz PCI clock\n");
+		} else {
+			if (hpt_minimum_revision(dev,8))
+			{
+				printk(KERN_ERR "HPT37x: 66MHz timings are not supported.\n");
+			}
+			else if (hpt_minimum_revision(dev,5))
+				pci_set_drvdata(dev, (void *) sixty_six_base_hpt372);
+			else if (hpt_minimum_revision(dev,4))
+				pci_set_drvdata(dev, (void *) sixty_six_base_hpt370a);
+			else
+				pci_set_drvdata(dev, (void *) sixty_six_base_hpt370);
+			printk("HPT37X: using 66MHz PCI clock\n");
 		}
-		else if (hpt_minimum_revision(dev,5))
-			pci_set_drvdata(dev, (void *) sixty_six_base_hpt372);
-		else if (hpt_minimum_revision(dev,4))
-			pci_set_drvdata(dev, (void *) sixty_six_base_hpt370a);
-		else
-			pci_set_drvdata(dev, (void *) sixty_six_base_hpt370);
-		printk("HPT37X: using 66MHz PCI clock\n");
 	}
 	
 	/*
@@ -863,6 +991,11 @@
 	if (pci_get_drvdata(dev)) 
 		goto init_hpt37X_done;
 	
+	if (hpt_minimum_revision(dev,8))
+	{
+		printk(KERN_ERR "HPT374: Only 33MHz PCI timings are supported.\n");
+		return -EOPNOTSUPP;
+	}
 	/*
 	 * adjust PLL based upon PCI clock, enable it, and wait for
 	 * stabilization.
@@ -1000,12 +1133,27 @@
 {
 	struct pci_dev *dev		= hwif->pci_dev;
 	u8 ata66 = 0, regmask		= (hwif->channel) ? 0x01 : 0x02;
-
+	u8 did, rid;
+	unsigned long dmabase		= hwif->dma_base;
+	int is_372n = 0;
+	
+	if(dmabase)
+	{
+		did = inb(dmabase + 0x22);
+		rid = inb(dmabase + 0x28);
+	
+		if((did == 4 && rid == 6) || (did == 5 && rid > 1))
+			is_372n = 1;
+	}
+		
 	hwif->tuneproc			= &hpt3xx_tune_drive;
 	hwif->speedproc			= &hpt3xx_tune_chipset;
 	hwif->quirkproc			= &hpt3xx_quirkproc;
 	hwif->intrproc			= &hpt3xx_intrproc;
 	hwif->maskproc			= &hpt3xx_maskproc;
+	
+	if(is_372n)
+		hwif->rw_disk = &hpt372n_rw_disk;
 
 	/*
 	 * The HPT37x uses the CBLID pins as outputs for MA15/MA16
@@ -1179,7 +1327,8 @@
 	u8 pin1 = 0, pin2 = 0;
 	unsigned int class_rev;
 	char *chipset_names[] = {"HPT366", "HPT366",  "HPT368",
-				 "HPT370", "HPT370A", "HPT372"};
+				 "HPT370", "HPT370A", "HPT372",
+				 "HPT372N" };
 
 	if (PCI_FUNC(dev->devfn) & 1)
 		return;
@@ -1187,9 +1336,14 @@
 	pci_read_config_dword(dev, PCI_CLASS_REVISION, &class_rev);
 	class_rev &= 0xff;
 
-	strcpy(d->name, chipset_names[class_rev]);
+	if(dev->device == PCI_DEVICE_ID_TTI_HPT372N)
+		class_rev = 6;
+		
+	if(class_rev <= 6)
+		d->name = chipset_names[class_rev];
 
 	switch(class_rev) {
+		case 6:
 		case 5:
 		case 4:
 		case 3: ide_setup_pci_device(dev, d);
@@ -1243,6 +1397,7 @@
 	{ PCI_VENDOR_ID_TTI, PCI_DEVICE_ID_TTI_HPT302, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 2},
 	{ PCI_VENDOR_ID_TTI, PCI_DEVICE_ID_TTI_HPT371, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 3},
 	{ PCI_VENDOR_ID_TTI, PCI_DEVICE_ID_TTI_HPT374, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 4},
+	{ PCI_VENDOR_ID_TTI, PCI_DEVICE_ID_TTI_HPT372N, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 5},
 	{ 0, },
 };
 MODULE_DEVICE_TABLE(pci, hpt366_pci_tbl);
--- linux.vanilla-2.6.8-rc2/include/linux/pci_ids.h	2004-07-31 17:25:49.000000000 +0100
+++ linux-2.6.8-rc2/include/linux/pci_ids.h	2004-07-31 17:28:37.000000000 +0100
@@ -1184,6 +1184,7 @@
 #define PCI_DEVICE_ID_TTI_HPT302	0x0006
 #define PCI_DEVICE_ID_TTI_HPT371	0x0007
 #define PCI_DEVICE_ID_TTI_HPT374	0x0008
+#define PCI_DEVICE_ID_TTI_HPT372N	0x0009	// apparently a 372N variant?
 
 #define PCI_VENDOR_ID_VIA		0x1106
 #define PCI_DEVICE_ID_VIA_8763_0	0x0198
