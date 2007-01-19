Return-Path: <linux-kernel-owner+w=401wt.eu-S932828AbXASA34@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932828AbXASA34 (ORCPT <rfc822;w@1wt.eu>);
	Thu, 18 Jan 2007 19:29:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932820AbXASA2e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Jan 2007 19:28:34 -0500
Received: from ug-out-1314.google.com ([66.249.92.172]:62361 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932821AbXASA21 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Jan 2007 19:28:27 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:cc:date:message-id:in-reply-to:references:subject;
        b=lte2tUTNd1U26aOUXRaXRTrimtSaBMuT3QPPQy+mtf+QhErAUaUzN6eJiSYoB3QC4mejaeJSvevPKY6XqPYIe8y1JUjkPpbpXe2zGJwci7lqlKEHpjuWLWHWHgkeTnRq1H8rj5jT689Axvw20ecVbvQmEEl7NEWbncaRhSE5kDI=
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
       linux-kernel@vger.kernel.org
Date: Fri, 19 Jan 2007 01:32:26 +0100
Message-Id: <20070119003226.14846.87052.sendpatchset@localhost.localdomain>
In-Reply-To: <20070119003058.14846.43637.sendpatchset@localhost.localdomain>
References: <20070119003058.14846.43637.sendpatchset@localhost.localdomain>
Subject: [PATCH 13/15] ide: fix UDMA/MWDMA/SWDMA masks
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] ide: fix UDMA/MWDMA/SWDMA masks

* use 0x00 instead of 0x80 to disable ->{ultra,mwdma,swdma}_mask
* add udma_mask field to ide_pci_device_t and use it to initialize
  ->ultra_mask in aec62xx, pdc202xx_new and pdc202xx_old drivers
* fix UDMA masks to match with chipset specific *_ratemask()
  (alim15x3, hpt366, serverworks and siimage drivers need UDMA mask
   filtering method - done in the next patch)

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

---
 drivers/ide/ide.c              |    3 ---
 drivers/ide/pci/aec62xx.c      |   20 ++++++++++++++++++--
 drivers/ide/pci/alim15x3.c     |   13 +++++++++++--
 drivers/ide/pci/cmd64x.c       |    5 +++--
 drivers/ide/pci/pdc202xx_new.c |    9 ++++++++-
 drivers/ide/pci/pdc202xx_old.c |    7 ++++++-
 drivers/ide/pci/piix.c         |    6 +++++-
 drivers/ide/pci/sis5513.c      |    5 ++++-
 include/linux/ide.h            |    1 +
 9 files changed, 56 insertions(+), 13 deletions(-)

Index: b/drivers/ide/ide.c
===================================================================
--- a/drivers/ide/ide.c
+++ b/drivers/ide/ide.c
@@ -222,9 +222,6 @@ static void init_hwif_data(ide_hwif_t *h
 	hwif->bus_state	= BUSSTATE_ON;
 
 	hwif->atapi_dma = 0;		/* disable all atapi dma */ 
-	hwif->ultra_mask = 0x80;	/* disable all ultra */
-	hwif->mwdma_mask = 0x80;	/* disable all mwdma */
-	hwif->swdma_mask = 0x80;	/* disable all swdma */
 
 	init_completion(&hwif->gendev_rel_comp);
 
Index: b/drivers/ide/pci/aec62xx.c
===================================================================
--- a/drivers/ide/pci/aec62xx.c
+++ b/drivers/ide/pci/aec62xx.c
@@ -270,11 +270,13 @@ static unsigned int __devinit init_chips
 
 static void __devinit init_hwif_aec62xx(ide_hwif_t *hwif)
 {
+	struct pci_dev *dev = hwif->pci_dev;
+
 	hwif->autodma = 0;
 	hwif->tuneproc = &aec62xx_tune_drive;
 	hwif->speedproc = &aec62xx_tune_chipset;
 
-	if (hwif->pci_dev->device == PCI_DEVICE_ID_ARTOP_ATP850UF)
+	if (dev->device == PCI_DEVICE_ID_ARTOP_ATP850UF)
 		hwif->serialized = hwif->channel;
 
 	if (hwif->mate)
@@ -286,7 +288,16 @@ static void __devinit init_hwif_aec62xx(
 		return;
 	}
 
-	hwif->ultra_mask = 0x7f;
+	hwif->ultra_mask = hwif->cds->udma_mask;
+
+	/* atp865 and atp865r */
+	if (hwif->ultra_mask == 0x3f) {
+		unsigned long io = pci_resource_start(dev, 4);
+
+		if (inb(io) & 0x10)
+ 			hwif->ultra_mask = 0x7f; /* udma0-6 */
+	}
+
 	hwif->mwdma_mask = 0x07;
 	hwif->swdma_mask = 0x07;
 
@@ -354,6 +365,7 @@ static ide_pci_device_t aec62xx_chipsets
 		.autodma	= AUTODMA,
 		.enablebits	= {{0x4a,0x02,0x02}, {0x4a,0x04,0x04}},
 		.bootable	= OFF_BOARD,
+		.udma_mask	= 0x07, /* udma0-2 */
 	},{	/* 1 */
 		.name		= "AEC6260",
 		.init_setup	= init_setup_aec62xx,
@@ -363,6 +375,7 @@ static ide_pci_device_t aec62xx_chipsets
 		.channels	= 2,
 		.autodma	= NOAUTODMA,
 		.bootable	= OFF_BOARD,
+		.udma_mask	= 0x1f, /* udma0-4 */
 	},{	/* 2 */
 		.name		= "AEC6260R",
 		.init_setup	= init_setup_aec62xx,
@@ -373,6 +386,7 @@ static ide_pci_device_t aec62xx_chipsets
 		.autodma	= AUTODMA,
 		.enablebits	= {{0x4a,0x02,0x02}, {0x4a,0x04,0x04}},
 		.bootable	= NEVER_BOARD,
+		.udma_mask	= 0x1f, /* udma0-4 */
 	},{	/* 3 */
 		.name		= "AEC6X80",
 		.init_setup	= init_setup_aec6x80,
@@ -382,6 +396,7 @@ static ide_pci_device_t aec62xx_chipsets
 		.channels	= 2,
 		.autodma	= AUTODMA,
 		.bootable	= OFF_BOARD,
+		.udma_mask	= 0x3f, /* udma0-5 */
 	},{	/* 4 */
 		.name		= "AEC6X80R",
 		.init_setup	= init_setup_aec6x80,
@@ -392,6 +407,7 @@ static ide_pci_device_t aec62xx_chipsets
 		.autodma	= AUTODMA,
 		.enablebits	= {{0x4a,0x02,0x02}, {0x4a,0x04,0x04}},
 		.bootable	= OFF_BOARD,
+		.udma_mask	= 0x3f, /* udma0-5 */
 	}
 };
 
Index: b/drivers/ide/pci/alim15x3.c
===================================================================
--- a/drivers/ide/pci/alim15x3.c
+++ b/drivers/ide/pci/alim15x3.c
@@ -765,8 +765,17 @@ static void __devinit init_hwif_common_a
 
 	hwif->atapi_dma = 1;
 
-	if (m5229_revision > 0x20)
-		hwif->ultra_mask = 0x7f;
+	if (m5229_revision <= 0x20)
+		hwif->ultra_mask = 0x00; /* no udma */
+	else if (m5229_revision < 0xC2)
+		hwif->ultra_mask = 0x07; /* udma0-2 */
+	else if (m5229_revision == 0xC2 || m5229_revision == 0xC3)
+		hwif->ultra_mask = 0x1f; /* udma0-4 */
+	else if (m5229_revision == 0xC4)
+		hwif->ultra_mask = 0x3f; /* udma0-5 */
+	else
+		hwif->ultra_mask = 0x7f; /* udma0-6 */
+
 	hwif->mwdma_mask = 0x07;
 	hwif->swdma_mask = 0x07;
 
Index: b/drivers/ide/pci/cmd64x.c
===================================================================
--- a/drivers/ide/pci/cmd64x.c
+++ b/drivers/ide/pci/cmd64x.c
@@ -695,9 +695,10 @@ static void __devinit init_hwif_cmd64x(i
 	hwif->swdma_mask = 0x07;
 
 	if (dev->device == PCI_DEVICE_ID_CMD_643)
-		hwif->ultra_mask = 0x80;
+		hwif->ultra_mask = 0x00;
 	if (dev->device == PCI_DEVICE_ID_CMD_646)
-		hwif->ultra_mask = (class_rev > 0x04) ? 0x07 : 0x80;
+		hwif->ultra_mask =
+			(class_rev == 0x05 || class_rev == 0x07) ? 0x07 : 0x00;
 	if (dev->device == PCI_DEVICE_ID_CMD_648)
 		hwif->ultra_mask = 0x1f;
 
Index: b/drivers/ide/pci/pdc202xx_new.c
===================================================================
--- a/drivers/ide/pci/pdc202xx_new.c
+++ b/drivers/ide/pci/pdc202xx_new.c
@@ -545,7 +545,7 @@ static void __devinit init_hwif_pdc202ne
 
 	hwif->drives[0].autotune = hwif->drives[1].autotune = 1;
 
-	hwif->ultra_mask = 0x7f;
+	hwif->ultra_mask = hwif->cds->udma_mask;
 	hwif->mwdma_mask = 0x07;
 
 	hwif->err_stops_fifo = 1;
@@ -621,6 +621,7 @@ static ide_pci_device_t pdcnew_chipsets[
 		.channels	= 2,
 		.autodma	= AUTODMA,
 		.bootable	= OFF_BOARD,
+		.udma_mask	= 0x3f, /* udma0-5 */
 	},{	/* 1 */
 		.name		= "PDC20269",
 		.init_setup	= init_setup_pdcnew,
@@ -629,6 +630,7 @@ static ide_pci_device_t pdcnew_chipsets[
 		.channels	= 2,
 		.autodma	= AUTODMA,
 		.bootable	= OFF_BOARD,
+		.udma_mask	= 0x7f, /* udma0-6*/
 	},{	/* 2 */
 		.name		= "PDC20270",
 		.init_setup	= init_setup_pdc20270,
@@ -637,6 +639,7 @@ static ide_pci_device_t pdcnew_chipsets[
 		.channels	= 2,
 		.autodma	= AUTODMA,
 		.bootable	= OFF_BOARD,
+		.udma_mask	= 0x3f, /* udma0-5 */
 	},{	/* 3 */
 		.name		= "PDC20271",
 		.init_setup	= init_setup_pdcnew,
@@ -645,6 +648,7 @@ static ide_pci_device_t pdcnew_chipsets[
 		.channels	= 2,
 		.autodma	= AUTODMA,
 		.bootable	= OFF_BOARD,
+		.udma_mask	= 0x7f, /* udma0-6*/
 	},{	/* 4 */
 		.name		= "PDC20275",
 		.init_setup	= init_setup_pdcnew,
@@ -653,6 +657,7 @@ static ide_pci_device_t pdcnew_chipsets[
 		.channels	= 2,
 		.autodma	= AUTODMA,
 		.bootable	= OFF_BOARD,
+		.udma_mask	= 0x7f, /* udma0-6*/
 	},{	/* 5 */
 		.name		= "PDC20276",
 		.init_setup	= init_setup_pdc20276,
@@ -661,6 +666,7 @@ static ide_pci_device_t pdcnew_chipsets[
 		.channels	= 2,
 		.autodma	= AUTODMA,
 		.bootable	= OFF_BOARD,
+		.udma_mask	= 0x7f, /* udma0-6*/
 	},{	/* 6 */
 		.name		= "PDC20277",
 		.init_setup	= init_setup_pdcnew,
@@ -669,6 +675,7 @@ static ide_pci_device_t pdcnew_chipsets[
 		.channels	= 2,
 		.autodma	= AUTODMA,
 		.bootable	= OFF_BOARD,
+		.udma_mask	= 0x7f, /* udma0-6*/
 	}
 };
 
Index: b/drivers/ide/pci/pdc202xx_old.c
===================================================================
--- a/drivers/ide/pci/pdc202xx_old.c
+++ b/drivers/ide/pci/pdc202xx_old.c
@@ -488,7 +488,7 @@ static void __devinit init_hwif_pdc202xx
 
 	hwif->drives[0].autotune = hwif->drives[1].autotune = 1;
 
-	hwif->ultra_mask = 0x3f;
+	hwif->ultra_mask = hwif->cds->udma_mask;
 	hwif->mwdma_mask = 0x07;
 	hwif->swdma_mask = 0x07;
 	hwif->atapi_dma = 1;
@@ -597,6 +597,7 @@ static ide_pci_device_t pdc202xx_chipset
 		.autodma	= AUTODMA,
 		.bootable	= OFF_BOARD,
 		.extra		= 16,
+		.udma_mask	= 0x07, /* udma0-2 */
 	},{	/* 1 */
 		.name		= "PDC20262",
 		.init_setup	= init_setup_pdc202ata4,
@@ -607,6 +608,7 @@ static ide_pci_device_t pdc202xx_chipset
 		.autodma	= AUTODMA,
 		.bootable	= OFF_BOARD,
 		.extra		= 48,
+		.udma_mask	= 0x1f, /* udma0-4 */
 	},{	/* 2 */
 		.name		= "PDC20263",
 		.init_setup	= init_setup_pdc202ata4,
@@ -617,6 +619,7 @@ static ide_pci_device_t pdc202xx_chipset
 		.autodma	= AUTODMA,
 		.bootable	= OFF_BOARD,
 		.extra		= 48,
+		.udma_mask	= 0x1f, /* udma0-4 */
 	},{	/* 3 */
 		.name		= "PDC20265",
 		.init_setup	= init_setup_pdc20265,
@@ -627,6 +630,7 @@ static ide_pci_device_t pdc202xx_chipset
 		.autodma	= AUTODMA,
 		.bootable	= OFF_BOARD,
 		.extra		= 48,
+		.udma_mask	= 0x3f, /* udma0-5 */
 	},{	/* 4 */
 		.name		= "PDC20267",
 		.init_setup	= init_setup_pdc202xx,
@@ -637,6 +641,7 @@ static ide_pci_device_t pdc202xx_chipset
 		.autodma	= AUTODMA,
 		.bootable	= OFF_BOARD,
 		.extra		= 48,
+		.udma_mask	= 0x3f, /* udma0-5 */
 	}
 };
 
Index: b/drivers/ide/pci/piix.c
===================================================================
--- a/drivers/ide/pci/piix.c
+++ b/drivers/ide/pci/piix.c
@@ -493,7 +493,7 @@ static void __devinit init_hwif_piix(ide
 		case PCI_DEVICE_ID_INTEL_82371FB_0:
 		case PCI_DEVICE_ID_INTEL_82371FB_1:
 		case PCI_DEVICE_ID_INTEL_82371SB_1:
-			hwif->ultra_mask = 0x80;
+			hwif->ultra_mask = 0x00;
 			break;
 		case PCI_DEVICE_ID_INTEL_82371AB:
 		case PCI_DEVICE_ID_INTEL_82443MX_1:
@@ -501,6 +501,10 @@ static void __devinit init_hwif_piix(ide
 		case PCI_DEVICE_ID_INTEL_82801AB_1:
 			hwif->ultra_mask = 0x07;
 			break;
+		case PCI_DEVICE_ID_INTEL_82801AA_1:
+		case PCI_DEVICE_ID_INTEL_82372FB_1:
+			hwif->ultra_mask = 0x1f;
+			break;
 		default:
 			if (!hwif->udma_four)
 				hwif->udma_four = piix_cable_detect(hwif);
Index: b/drivers/ide/pci/sis5513.c
===================================================================
--- a/drivers/ide/pci/sis5513.c
+++ b/drivers/ide/pci/sis5513.c
@@ -858,6 +858,8 @@ static unsigned int __devinit ata66_sis5
 
 static void __devinit init_hwif_sis5513 (ide_hwif_t *hwif)
 {
+	u8 udma_rates[] = { 0x00, 0x00, 0x07, 0x1f, 0x3f, 0x3f, 0x7f, 0x7f };
+
 	hwif->autodma = 0;
 
 	if (!hwif->irq)
@@ -873,7 +875,8 @@ static void __devinit init_hwif_sis5513 
 	}
 
 	hwif->atapi_dma = 1;
-	hwif->ultra_mask = 0x7f;
+
+	hwif->ultra_mask = udma_rates[chipset_family];
 	hwif->mwdma_mask = 0x07;
 	hwif->swdma_mask = 0x07;
 
Index: b/include/linux/ide.h
===================================================================
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -1255,6 +1255,7 @@ typedef struct ide_pci_device_s {
 	unsigned int		extra;
 	struct ide_pci_device_s	*next;
 	u8			flags;
+	u8			udma_mask;
 } ide_pci_device_t;
 
 extern int ide_setup_pci_device(struct pci_dev *, ide_pci_device_t *);
