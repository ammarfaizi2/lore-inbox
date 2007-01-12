Return-Path: <linux-kernel-owner+w=401wt.eu-S1030517AbXALEYr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030517AbXALEYr (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 23:24:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030509AbXALEYP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 23:24:15 -0500
Received: from ug-out-1314.google.com ([66.249.92.169]:34121 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030512AbXALEYF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 23:24:05 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:cc:date:message-id:in-reply-to:references:subject;
        b=X7iNCpEVU4zFcVKv4sIGtZytlk5Nys7puxirBrlNGHVAjvWLBZkn9eIItChK4WQ0Xub/jVrdPRD9G0FJA6051dJbC7Z9ciMuBz+wowq3cWNxSlNo9QqNrfo3KPHXSgGcuzPq0DbdwYtf31jz5aHBUKLnF3PxeTFjyjx9ZjeM0tQ=
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
       linux-kernel@vger.kernel.org
Date: Fri, 12 Jan 2007 05:27:41 +0100
Message-Id: <20070112042741.28794.15864.sendpatchset@localhost.localdomain>
In-Reply-To: <20070112042621.28794.6937.sendpatchset@localhost.localdomain>
References: <20070112042621.28794.6937.sendpatchset@localhost.localdomain>
Subject: [PATCH 15/19] svwks: small cleanup
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] svwks: small cleanup

* remove redundant svwks_ide_dma_end() [ __ide_dma_end() is used by default ]
* remove init_dma_svwks() so the default ide_setup_dma() function is used
  [ init_setup_csb6() takes care of not initializing disabled channels ]

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

---
 drivers/ide/pci/serverworks.c |   34 ++++------------------------------
 1 file changed, 4 insertions(+), 30 deletions(-)

Index: a/drivers/ide/pci/serverworks.c
===================================================================
--- a.orig/drivers/ide/pci/serverworks.c
+++ a/drivers/ide/pci/serverworks.c
@@ -339,13 +339,6 @@ fast_ata_pio:
 	return 0;
 }
 
-/* This can go soon */
-
-static int svwks_ide_dma_end (ide_drive_t *drive)
-{
-	return __ide_dma_end(drive);
-}
-
 static unsigned int __devinit init_chipset_svwks (struct pci_dev *dev, const char *name)
 {
 	unsigned int reg;
@@ -537,10 +530,10 @@ static void __devinit init_hwif_svwks (i
 	}
 
 	hwif->ide_dma_check = &svwks_config_drive_xfer_rate;
-	if (hwif->pci_dev->device == PCI_DEVICE_ID_SERVERWORKS_OSB4IDE)
-		hwif->ide_dma_end = &svwks_ide_dma_end;
-	else if (!(hwif->udma_four))
-		hwif->udma_four = ata66_svwks(hwif);
+	if (hwif->pci_dev->device != PCI_DEVICE_ID_SERVERWORKS_OSB4IDE) {
+		if (!hwif->udma_four)
+			hwif->udma_four = ata66_svwks(hwif);
+	}
 	if (!noautodma)
 		hwif->autodma = 1;
 
@@ -551,21 +544,6 @@ static void __devinit init_hwif_svwks (i
 	hwif->drives[1].autotune = (!(dma_stat & 0x40));
 }
 
-/*
- * We allow the BM-DMA driver to only work on enabled interfaces.
- */
-static void __devinit init_dma_svwks (ide_hwif_t *hwif, unsigned long dmabase)
-{
-	struct pci_dev *dev = hwif->pci_dev;
-
-	if (((dev->device == PCI_DEVICE_ID_SERVERWORKS_CSB6IDE) ||
-	     (dev->device == PCI_DEVICE_ID_SERVERWORKS_CSB6IDE2)) &&
-	    (!(PCI_FUNC(dev->devfn) & 1)) && (hwif->channel))
-		return;
-
-	ide_setup_dma(hwif, dmabase, 8);
-}
-
 static int __devinit init_setup_svwks (struct pci_dev *dev, ide_pci_device_t *d)
 {
 	return ide_setup_pci_device(dev, d);
@@ -600,7 +578,6 @@ static ide_pci_device_t serverworks_chip
 		.init_setup	= init_setup_svwks,
 		.init_chipset	= init_chipset_svwks,
 		.init_hwif	= init_hwif_svwks,
-		.init_dma	= init_dma_svwks,
 		.channels	= 2,
 		.autodma	= AUTODMA,
 		.bootable	= ON_BOARD,
@@ -609,7 +586,6 @@ static ide_pci_device_t serverworks_chip
 		.init_setup	= init_setup_csb6,
 		.init_chipset	= init_chipset_svwks,
 		.init_hwif	= init_hwif_svwks,
-		.init_dma	= init_dma_svwks,
 		.channels	= 2,
 		.autodma	= AUTODMA,
 		.bootable	= ON_BOARD,
@@ -618,7 +594,6 @@ static ide_pci_device_t serverworks_chip
 		.init_setup	= init_setup_csb6,
 		.init_chipset	= init_chipset_svwks,
 		.init_hwif	= init_hwif_svwks,
-		.init_dma	= init_dma_svwks,
 		.channels	= 1,	/* 2 */
 		.autodma	= AUTODMA,
 		.bootable	= ON_BOARD,
@@ -627,7 +602,6 @@ static ide_pci_device_t serverworks_chip
 		.init_setup	= init_setup_svwks,
 		.init_chipset	= init_chipset_svwks,
 		.init_hwif	= init_hwif_svwks,
-		.init_dma	= init_dma_svwks,
 		.channels	= 1,	/* 2 */
 		.autodma	= AUTODMA,
 		.bootable	= ON_BOARD,
