Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263836AbTJCS23 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Oct 2003 14:28:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263839AbTJCS23
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Oct 2003 14:28:29 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:20883 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S263836AbTJCS2O
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Oct 2003 14:28:14 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: [PATCH][IDE] small cleanup for VIA IDE driver
Date: Fri, 3 Oct 2003 20:31:26 +0200
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200310032031.26349.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Vojtech,

Can you take a look?
Patch was tested on vt8235 with one port disabled, worked okay.

--bartlomiej

[IDE] small cleanup for VIA IDE driver

ide_pci_setup_ports() from setup-pci.c checks if port is disabled, if so
d->init_setup_dma() and d->init_hwif() won't be called.  There is no need
to check it once again inside init_hwif_via82cxxx(), init_dma_via82cxxx()
and via82cxxx_tune_drive() (hwif->tuneproc will be NULL for disabled port).
Therefore remove via_enabled variable and now unnecessary init_dma_via82cxx().
Also do not set .init_{iops, dma} to NULL in via82cxxx.h (via82cxxx_chipsets[]
is declared static).  Bump driver's version number to reflect changes.

 drivers/ide/pci/via82cxxx.c |   33 +++++++--------------------------
 drivers/ide/pci/via82cxxx.h |    5 -----
 2 files changed, 7 insertions(+), 31 deletions(-)

diff -puN drivers/ide/pci/via82cxxx.c~ide-via-enabled-cleanup drivers/ide/pci/via82cxxx.c
--- linux-2.6.0-test6-bk2/drivers/ide/pci/via82cxxx.c~ide-via-enabled-cleanup	2003-10-03 20:04:07.000000000 +0200
+++ linux-2.6.0-test6-bk2-root/drivers/ide/pci/via82cxxx.c	2003-10-03 20:15:17.048526664 +0200
@@ -1,6 +1,6 @@
 /*
  *
- * Version 3.37
+ * Version 3.38
  *
  * VIA IDE driver for Linux. Supported southbridges:
  *
@@ -96,7 +96,6 @@ static struct via_isa_bridge {
 };
 
 static struct via_isa_bridge *via_config;
-static unsigned char via_enabled;
 static unsigned int via_80w;
 static unsigned int via_clock;
 static char *via_dma[] = { "MWDMA16", "UDMA33", "UDMA66", "UDMA100", "UDMA133" };
@@ -146,7 +145,7 @@ static int via_get_info(char *buffer, ch
 	via_print("----------VIA BusMastering IDE Configuration"
 		"----------------");
 
-	via_print("Driver Version:                     3.37");
+	via_print("Driver Version:                     3.38");
 	via_print("South Bridge:                       VIA %s",
 		via_config->name);
 
@@ -370,9 +369,6 @@ static int via_set_drive(ide_drive_t *dr
 
 static void via82cxxx_tune_drive(ide_drive_t *drive, u8 pio)
 {
-	if (!((via_enabled >> HWIF(drive)->channel) & 1))
-		return;
-
 	if (pio == 255) {
 		via_set_drive(drive,
 			ide_find_best_mode(drive, XFER_PIO | XFER_EPIO));
@@ -506,7 +502,6 @@ static unsigned int __init init_chipset_
 	 */
 
 	pci_read_config_byte(dev, VIA_IDE_ENABLE, &v);
-	via_enabled = ((v & 1) ? 2 : 0) | ((v & 2) ? 1 : 0);
 
 	/*
 	 * Set up FIFO sizes and thresholds.
@@ -523,9 +518,9 @@ static unsigned int __init init_chipset_
 	/* Fix FIFO split between channels */
 	if (via_config->flags & VIA_SET_FIFO) {
 		t &= (t & 0x9f);
-		switch (via_enabled) {
-			case 1: t |= 0x00; break;	/* 16 on primary */
-			case 2: t |= 0x60; break;	/* 16 on secondary */
+		switch (v & 3) {
+			case 2: t |= 0x00; break;	/* 16 on primary */
+			case 1: t |= 0x60; break;	/* 16 on secondary */
 			case 3: t |= 0x20; break;	/* 8 pri 8 sec */
 		}
 	}
@@ -603,8 +598,8 @@ static void __init init_hwif_via82cxxx(i
 	hwif->mwdma_mask = 0x07;
 	hwif->swdma_mask = 0x07;
 
-	if (!(hwif->udma_four))
-		hwif->udma_four = ((via_enabled & via_80w) >> hwif->channel) & 1;
+	if (!hwif->udma_four)
+		hwif->udma_four = (via_80w >> hwif->channel) & 1;
 	hwif->ide_dma_check = &via82cxxx_ide_dma_check;
 	if (!noautodma)
 		hwif->autodma = 1;
@@ -612,20 +607,6 @@ static void __init init_hwif_via82cxxx(i
 	hwif->drives[1].autodma = hwif->autodma;
 }
 
-/**
- *	init_dma_via82cxxx	-	set up for IDE DMA
- *	@hwif: IDE interface
- *	@dmabase: DMA base address
- *
- *	We allow the BM-DMA driver to only work on enabled interfaces.
- */
-
-static void __init init_dma_via82cxxx(ide_hwif_t *hwif, unsigned long dmabase)
-{
-	if ((via_enabled >> hwif->channel) & 1)
-		ide_setup_dma(hwif, dmabase, 8);
-}
-
 extern void ide_setup_pci_device(struct pci_dev *, ide_pci_device_t *);
 
 static int __devinit via_init_one(struct pci_dev *dev, const struct pci_device_id *id)
diff -puN drivers/ide/pci/via82cxxx.h~ide-via-enabled-cleanup drivers/ide/pci/via82cxxx.h
--- linux-2.6.0-test6-bk2/drivers/ide/pci/via82cxxx.h~ide-via-enabled-cleanup	2003-10-03 20:04:07.000000000 +0200
+++ linux-2.6.0-test6-bk2-root/drivers/ide/pci/via82cxxx.h	2003-10-03 20:04:07.000000000 +0200
@@ -27,7 +27,6 @@ static ide_pci_host_proc_t via_procs[] _
 
 static unsigned int init_chipset_via82cxxx(struct pci_dev *, const char *);
 static void init_hwif_via82cxxx(ide_hwif_t *);
-static void init_dma_via82cxxx(ide_hwif_t *, unsigned long);
 
 static ide_pci_device_t via82cxxx_chipsets[] __devinitdata = {
 	{	/* 0 */
@@ -35,9 +34,7 @@ static ide_pci_device_t via82cxxx_chipse
 		.device		= PCI_DEVICE_ID_VIA_82C576_1,
 		.name		= "VP_IDE",
 		.init_chipset	= init_chipset_via82cxxx,
-		.init_iops	= NULL,
 		.init_hwif	= init_hwif_via82cxxx,
-		.init_dma	= init_dma_via82cxxx,
 		.channels	= 2,
 		.autodma	= NOAUTODMA,
 		.enablebits	= {{0x40,0x02,0x02}, {0x40,0x01,0x01}},
@@ -48,9 +45,7 @@ static ide_pci_device_t via82cxxx_chipse
 		.device		= PCI_DEVICE_ID_VIA_82C586_1,
 		.name		= "VP_IDE",
 		.init_chipset	= init_chipset_via82cxxx,
-		.init_iops	= NULL,
 		.init_hwif	= init_hwif_via82cxxx,
-		.init_dma	= init_dma_via82cxxx,
 		.channels	= 2,
 		.autodma	= NOAUTODMA,
 		.enablebits	= {{0x40,0x02,0x02}, {0x40,0x01,0x01}},

_

