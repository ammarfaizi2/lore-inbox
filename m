Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263824AbTJCSbX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Oct 2003 14:31:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263825AbTJCSbX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Oct 2003 14:31:23 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:3476 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S263824AbTJCSbQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Oct 2003 14:31:16 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: [PATCH][IDE] small cleanup for AMD/nVidia IDE driver
Date: Fri, 3 Oct 2003 20:34:01 +0200
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200310032034.01122.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Almost identical to VIA's patch.

--bartlomiej

[IDE] small cleanup for AMD/nVidia IDE driver

ide_pci_setup_ports() from setup-pci.c checks if port is disabled, if so
d->init_setup_dma() and d->init_hwif() won't be called.  There is no need
to check it once again inside init_hwif_amd74xx(), init_dma_amd74xx()
and amd74xx_tune_drive() (hwif->tuneproc will be NULL for disabled port).
Therefore remove amd_enabled variable and now unnecessary init_dma_amd74xx().
Also do not set .init_{iops, dma} to NULL in amd74xx.h (amd74xx_chipsets[]
is declared static).  Bump driver's version number to reflect changes.

 drivers/ide/pci/amd74xx.c |   25 ++++---------------------
 drivers/ide/pci/amd74xx.h |   15 ---------------
 2 files changed, 4 insertions(+), 36 deletions(-)

diff -puN drivers/ide/pci/amd74xx.c~ide-amd-enabled-cleanup drivers/ide/pci/amd74xx.c
--- linux-2.6.0-test6-bk2/drivers/ide/pci/amd74xx.c~ide-amd-enabled-cleanup	2003-10-03 20:22:25.372286072 +0200
+++ linux-2.6.0-test6-bk2-root/drivers/ide/pci/amd74xx.c	2003-10-03 20:22:41.094895872 +0200
@@ -1,5 +1,5 @@
 /*
- * Version 2.9
+ * Version 2.11
  *
  * AMD 755/756/766/8111 and nVidia nForce IDE driver for Linux.
  *
@@ -65,7 +65,6 @@ static struct amd_ide_chip {
 };
 
 static struct amd_ide_chip *amd_config;
-static unsigned char amd_enabled;
 static unsigned int amd_80w;
 static unsigned int amd_clock;
 
@@ -103,7 +102,7 @@ static int amd74xx_get_info(char *buffer
 
 	amd_print("----------AMD BusMastering IDE Configuration----------------");
 
-	amd_print("Driver Version:                     2.9");
+	amd_print("Driver Version:                     2.11");
 	amd_print("South Bridge:                       %s", pci_name(bmide_dev));
 
 	pci_read_config_byte(dev, PCI_REVISION_ID, &t);
@@ -250,9 +249,6 @@ static int amd_set_drive(ide_drive_t *dr
 
 static void amd74xx_tune_drive(ide_drive_t *drive, u8 pio)
 {
-	if (!((amd_enabled >> HWIF(drive)->channel) & 1))
-		return;
-
 	if (pio == 255) {
 		amd_set_drive(drive, ide_find_best_mode(drive, XFER_PIO | XFER_EPIO));
 		return;
@@ -330,9 +326,6 @@ static unsigned int __init init_chipset_
 			break;
 	}
 
-	pci_read_config_dword(dev, AMD_IDE_ENABLE, &u);
-	amd_enabled = ((u & 1) ? 2 : 0) | ((u & 2) ? 1 : 0);
-
 /*
  * Take care of prefetch & postwrite.
  */
@@ -408,8 +401,8 @@ static void __init init_hwif_amd74xx(ide
         hwif->mwdma_mask = 0x07;
         hwif->swdma_mask = 0x07;
 
-        if (!(hwif->udma_four))
-                hwif->udma_four = ((amd_enabled & amd_80w) >> hwif->channel) & 1;
+	if (!hwif->udma_four)
+		hwif->udma_four = (amd_80w >> hwif->channel) & 1;
         hwif->ide_dma_check = &amd74xx_ide_dma_check;
         if (!noautodma)
                 hwif->autodma = 1;
@@ -417,16 +410,6 @@ static void __init init_hwif_amd74xx(ide
         hwif->drives[1].autodma = hwif->autodma;
 }
 
-/*
- * We allow the BM-DMA driver only work on enabled interfaces.
- */
-
-static void __init init_dma_amd74xx(ide_hwif_t *hwif, unsigned long dmabase)
-{
-	if ((amd_enabled >> hwif->channel) & 1)
-		ide_setup_dma(hwif, dmabase, 8);
-}
-
 extern void ide_setup_pci_device(struct pci_dev *, ide_pci_device_t *);
 
 static int __devinit amd74xx_probe(struct pci_dev *dev, const struct pci_device_id *id)
diff -puN drivers/ide/pci/amd74xx.h~ide-amd-enabled-cleanup drivers/ide/pci/amd74xx.h
--- linux-2.6.0-test6-bk2/drivers/ide/pci/amd74xx.h~ide-amd-enabled-cleanup	2003-10-03 20:22:25.375285616 +0200
+++ linux-2.6.0-test6-bk2-root/drivers/ide/pci/amd74xx.h	2003-10-03 20:22:25.379285008 +0200
@@ -27,7 +27,6 @@ static ide_pci_host_proc_t amd74xx_procs
 
 static unsigned int init_chipset_amd74xx(struct pci_dev *, const char *);
 static void init_hwif_amd74xx(ide_hwif_t *);
-static void init_dma_amd74xx(ide_hwif_t *, unsigned long);
 
 static ide_pci_device_t amd74xx_chipsets[] __devinitdata = {
 	{	/* 0 */
@@ -35,9 +34,7 @@ static ide_pci_device_t amd74xx_chipsets
 		.device		= PCI_DEVICE_ID_AMD_COBRA_7401,
 		.name		= "AMD7401",
 		.init_chipset	= init_chipset_amd74xx,
-		.init_iops	= NULL,
 		.init_hwif	= init_hwif_amd74xx,
-		.init_dma	= init_dma_amd74xx,
 		.channels	= 2,
 		.autodma	= AUTODMA,
 		.enablebits	= {{0x40,0x02,0x02}, {0x40,0x01,0x01}},
@@ -48,9 +45,7 @@ static ide_pci_device_t amd74xx_chipsets
 		.device		= PCI_DEVICE_ID_AMD_VIPER_7409,
 		.name		= "AMD7409",
 		.init_chipset	= init_chipset_amd74xx,
-		.init_iops	= NULL,
 		.init_hwif	= init_hwif_amd74xx,
-		.init_dma	= init_dma_amd74xx,
 		.channels	= 2,
 		.autodma	= AUTODMA,
 		.enablebits	= {{0x40,0x02,0x02}, {0x40,0x01,0x01}},
@@ -61,9 +56,7 @@ static ide_pci_device_t amd74xx_chipsets
 		.device		= PCI_DEVICE_ID_AMD_VIPER_7411,
 		.name		= "AMD7411",
 		.init_chipset	= init_chipset_amd74xx,
-		.init_iops	= NULL,
 		.init_hwif	= init_hwif_amd74xx,
-		.init_dma	= init_dma_amd74xx,
 		.channels	= 2,
 		.autodma	= AUTODMA,
 		.enablebits	= {{0x40,0x02,0x02}, {0x40,0x01,0x01}},
@@ -74,9 +67,7 @@ static ide_pci_device_t amd74xx_chipsets
 		.device		= PCI_DEVICE_ID_AMD_OPUS_7441,
 		.name		= "AMD7441",
 		.init_chipset	= init_chipset_amd74xx,
-		.init_iops	= NULL,
 		.init_hwif	= init_hwif_amd74xx,
-		.init_dma	= init_dma_amd74xx,
 		.channels	= 2,
 		.autodma	= AUTODMA,
 		.enablebits	= {{0x40,0x02,0x02}, {0x40,0x01,0x01}},
@@ -87,9 +78,7 @@ static ide_pci_device_t amd74xx_chipsets
 		.device		= PCI_DEVICE_ID_AMD_8111_IDE,
 		.name		= "AMD8111",
 		.init_chipset	= init_chipset_amd74xx,
-		.init_iops	= NULL,
 		.init_hwif	= init_hwif_amd74xx,
-		.init_dma	= init_dma_amd74xx,
 		.autodma	= AUTODMA,
 		.channels	= 2,
 		.enablebits	= {{0x40,0x02,0x02}, {0x40,0x01,0x01}},
@@ -101,9 +90,7 @@ static ide_pci_device_t amd74xx_chipsets
 		.device		= PCI_DEVICE_ID_NVIDIA_NFORCE_IDE,
 		.name		= "NFORCE",
 		.init_chipset	= init_chipset_amd74xx,
-		.init_iops	= NULL,
 		.init_hwif	= init_hwif_amd74xx,
-		.init_dma	= init_dma_amd74xx,
 		.channels	= 2,
 		.autodma	= AUTODMA,
 		.enablebits	= {{0x50,0x02,0x02}, {0x50,0x01,0x01}},
@@ -115,9 +102,7 @@ static ide_pci_device_t amd74xx_chipsets
 		.device		= PCI_DEVICE_ID_NVIDIA_NFORCE2_IDE,
 		.name		= "NFORCE2",
 		.init_chipset	= init_chipset_amd74xx,
-		.init_iops	= NULL,
 		.init_hwif	= init_hwif_amd74xx,
-		.init_dma	= init_dma_amd74xx,
 		.channels	= 2,
 		.autodma	= AUTODMA,
 		.enablebits	= {{0x50,0x02,0x02}, {0x50,0x01,0x01}},

_

