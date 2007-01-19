Return-Path: <linux-kernel-owner+w=401wt.eu-S932790AbXASAbZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932790AbXASAbZ (ORCPT <rfc822;w@1wt.eu>);
	Thu, 18 Jan 2007 19:31:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932799AbXASAaz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Jan 2007 19:30:55 -0500
Received: from ug-out-1314.google.com ([66.249.92.172]:62361 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932802AbXASA1z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Jan 2007 19:27:55 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:cc:date:message-id:in-reply-to:references:subject;
        b=UfJJosvmgi1avX4Cq8h1vYoLL8t2tMOVNZegzMuUxCYEmoye8AeOIOkxHxe3praEGicCLG0TTsQkltsfraJRUjomE8ZBun1iaHro0pXdnA/LbtCtruBEgytncVB8XiySyQbzvgl5iPdX6D7nEcvuUTO0LgHi0t63m3knpOSpL3w=
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
       linux-kernel@vger.kernel.org
Date: Fri, 19 Jan 2007 01:31:54 +0100
Message-Id: <20070119003154.14846.87217.sendpatchset@localhost.localdomain>
In-Reply-To: <20070119003058.14846.43637.sendpatchset@localhost.localdomain>
References: <20070119003058.14846.43637.sendpatchset@localhost.localdomain>
Subject: [PATCH 8/15] ide: disable DMA in ->ide_dma_check for "no IORDY" case
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] ide: disable DMA in ->ide_dma_check for "no IORDY" case

If DMA is unsupported ->ide_dma_check should disable DMA.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

---
 drivers/ide/pci/aec62xx.c      |    8 +++-----
 drivers/ide/pci/atiixp.c       |    5 ++---
 drivers/ide/pci/cmd64x.c       |    8 +++-----
 drivers/ide/pci/cs5535.c       |    5 ++---
 drivers/ide/pci/hpt34x.c       |    8 +++-----
 drivers/ide/pci/hpt366.c       |    8 +++-----
 drivers/ide/pci/pdc202xx_new.c |    8 +++-----
 drivers/ide/pci/pdc202xx_old.c |    8 +++-----
 drivers/ide/pci/piix.c         |    5 ++---
 drivers/ide/pci/serverworks.c  |    9 +++------
 drivers/ide/pci/siimage.c      |    8 +++-----
 drivers/ide/pci/sis5513.c      |    8 +++-----
 drivers/ide/pci/slc90e66.c     |    5 ++---
 drivers/ide/pci/tc86c001.c     |    8 +++-----
 14 files changed, 38 insertions(+), 63 deletions(-)

Index: b/drivers/ide/pci/aec62xx.c
===================================================================
--- a/drivers/ide/pci/aec62xx.c
+++ b/drivers/ide/pci/aec62xx.c
@@ -214,12 +214,10 @@ static int aec62xx_config_drive_xfer_rat
 	if (ide_use_dma(drive) && config_chipset_for_dma(drive))
 		return hwif->ide_dma_on(drive);
 
-	if (ide_use_fast_pio(drive)) {
+	if (ide_use_fast_pio(drive))
 		aec62xx_tune_drive(drive, 5);
-		return hwif->ide_dma_off_quietly(drive);
-	}
-	/* IORDY not supported */
-	return 0;
+
+	return hwif->ide_dma_off_quietly(drive);
 }
 
 static int aec62xx_irq_timeout (ide_drive_t *drive)
Index: b/drivers/ide/pci/atiixp.c
===================================================================
--- a/drivers/ide/pci/atiixp.c
+++ b/drivers/ide/pci/atiixp.c
@@ -264,10 +264,9 @@ static int atiixp_dma_check(ide_drive_t 
 		tspeed = ide_get_best_pio_mode(drive, 255, 5, NULL);
 		speed = atiixp_dma_2_pio(XFER_PIO_0 + tspeed) + XFER_PIO_0;
 		hwif->speedproc(drive, speed);
-		return hwif->ide_dma_off_quietly(drive);
 	}
-	/* IORDY not supported */
-	return 0;
+
+	return hwif->ide_dma_off_quietly(drive);
 }
 
 /**
Index: b/drivers/ide/pci/cmd64x.c
===================================================================
--- a/drivers/ide/pci/cmd64x.c
+++ b/drivers/ide/pci/cmd64x.c
@@ -479,12 +479,10 @@ static int cmd64x_config_drive_for_dma (
 	if (ide_use_dma(drive) && config_chipset_for_dma(drive))
 		return hwif->ide_dma_on(drive);
 
-	if (ide_use_fast_pio(drive)) {
+	if (ide_use_fast_pio(drive))
 		config_chipset_for_pio(drive, 1);
-		return hwif->ide_dma_off_quietly(drive);
-	}
-	/* IORDY not supported */
-	return 0;
+
+	return hwif->ide_dma_off_quietly(drive);
 }
 
 static int cmd64x_alt_dma_status (struct pci_dev *dev)
Index: b/drivers/ide/pci/cs5535.c
===================================================================
--- a/drivers/ide/pci/cs5535.c
+++ b/drivers/ide/pci/cs5535.c
@@ -206,10 +206,9 @@ static int cs5535_dma_check(ide_drive_t 
 	if (ide_use_fast_pio(drive)) {
 		speed = ide_get_best_pio_mode(drive, 255, 4, NULL);
 		cs5535_set_drive(drive, speed);
-		return hwif->ide_dma_off_quietly(drive);
 	}
-	/* IORDY not supported */
-	return 0;
+
+	return hwif->ide_dma_off_quietly(drive);
 }
 
 static u8 __devinit cs5535_cable_detect(struct pci_dev *dev)
Index: b/drivers/ide/pci/hpt34x.c
===================================================================
--- a/drivers/ide/pci/hpt34x.c
+++ b/drivers/ide/pci/hpt34x.c
@@ -120,12 +120,10 @@ static int hpt34x_config_drive_xfer_rate
 		return hwif->ide_dma_on(drive);
 #endif
 
-	if (ide_use_fast_pio(drive)) {
+	if (ide_use_fast_pio(drive))
 		hpt34x_tune_drive(drive, 255);
-		return hwif->ide_dma_off_quietly(drive);
-	}
-	/* IORDY not supported */
-	return 0;
+
+	return hwif->ide_dma_off_quietly(drive);
 }
 
 /*
Index: b/drivers/ide/pci/hpt366.c
===================================================================
--- a/drivers/ide/pci/hpt366.c
+++ b/drivers/ide/pci/hpt366.c
@@ -743,12 +743,10 @@ static int hpt366_config_drive_xfer_rate
 	if (ide_use_dma(drive) && config_chipset_for_dma(drive))
 		return hwif->ide_dma_on(drive);
 
-	if (ide_use_fast_pio(drive)) {
+	if (ide_use_fast_pio(drive))
 		hpt3xx_tune_drive(drive, 255);
-		return hwif->ide_dma_off_quietly(drive);
-	}
-	/* IORDY not supported */
-	return 0;
+
+	return hwif->ide_dma_off_quietly(drive);
 }
 
 /*
Index: b/drivers/ide/pci/pdc202xx_new.c
===================================================================
--- a/drivers/ide/pci/pdc202xx_new.c
+++ b/drivers/ide/pci/pdc202xx_new.c
@@ -288,12 +288,10 @@ static int pdcnew_config_drive_xfer_rate
 	if (ide_use_dma(drive) && config_chipset_for_dma(drive))
 		return hwif->ide_dma_on(drive);
 
-	if (ide_use_fast_pio(drive)) {
+	if (ide_use_fast_pio(drive))
 		hwif->tuneproc(drive, 255);
-		return hwif->ide_dma_off_quietly(drive);
-	}
-	/* IORDY not supported */
-	return 0;
+
+	return hwif->ide_dma_off_quietly(drive);
 }
 
 static int pdcnew_quirkproc(ide_drive_t *drive)
Index: b/drivers/ide/pci/pdc202xx_old.c
===================================================================
--- a/drivers/ide/pci/pdc202xx_old.c
+++ b/drivers/ide/pci/pdc202xx_old.c
@@ -339,12 +339,10 @@ static int pdc202xx_config_drive_xfer_ra
 	if (ide_use_dma(drive) && config_chipset_for_dma(drive))
 		return hwif->ide_dma_on(drive);
 
-	if (ide_use_fast_pio(drive)) {
+	if (ide_use_fast_pio(drive))
 		hwif->tuneproc(drive, 5);
-		return hwif->ide_dma_off_quietly(drive);
-	}
-	/* IORDY not supported */
-	return 0;
+
+	return hwif->ide_dma_off_quietly(drive);
 }
 
 static int pdc202xx_quirkproc (ide_drive_t *drive)
Index: b/drivers/ide/pci/piix.c
===================================================================
--- a/drivers/ide/pci/piix.c
+++ b/drivers/ide/pci/piix.c
@@ -397,10 +397,9 @@ static int piix_config_drive_xfer_rate (
 		/* Find best PIO mode. */
 		(void) hwif->speedproc(drive, XFER_PIO_0 +
 				       ide_get_best_pio_mode(drive, 255, 4, NULL));
-		return hwif->ide_dma_off_quietly(drive);
 	}
-	/* IORDY not supported */
-	return 0;
+
+	return hwif->ide_dma_off_quietly(drive);
 }
 
 /**
Index: b/drivers/ide/pci/serverworks.c
===================================================================
--- a/drivers/ide/pci/serverworks.c
+++ b/drivers/ide/pci/serverworks.c
@@ -322,13 +322,10 @@ static int svwks_config_drive_xfer_rate 
 	if (ide_use_dma(drive) && config_chipset_for_dma(drive))
 		return hwif->ide_dma_on(drive);
 
-	if (ide_use_fast_pio(drive)) {
+	if (ide_use_fast_pio(drive))
 		config_chipset_for_pio(drive);
-		//	hwif->tuneproc(drive, 5);
-		return hwif->ide_dma_off_quietly(drive);
-	}
-	/* IORDY not supported */
-	return 0;
+
+	return hwif->ide_dma_off_quietly(drive);
 }
 
 static unsigned int __devinit init_chipset_svwks (struct pci_dev *dev, const char *name)
Index: b/drivers/ide/pci/siimage.c
===================================================================
--- a/drivers/ide/pci/siimage.c
+++ b/drivers/ide/pci/siimage.c
@@ -420,12 +420,10 @@ static int siimage_config_drive_for_dma 
 	if (ide_use_dma(drive) && config_chipset_for_dma(drive))
 		return hwif->ide_dma_on(drive);
 
-	if (ide_use_fast_pio(drive)) {
+	if (ide_use_fast_pio(drive))
 		config_chipset_for_pio(drive, 1);
-		return hwif->ide_dma_off_quietly(drive);
-	}
-	/* IORDY not supported */
-	return 0;
+
+	return hwif->ide_dma_off_quietly(drive);
 }
 
 /* returns 1 if dma irq issued, 0 otherwise */
Index: b/drivers/ide/pci/sis5513.c
===================================================================
--- a/drivers/ide/pci/sis5513.c
+++ b/drivers/ide/pci/sis5513.c
@@ -678,12 +678,10 @@ static int sis5513_config_xfer_rate(ide_
 	if (ide_use_dma(drive) && config_chipset_for_dma(drive))
 		return hwif->ide_dma_on(drive);
 
-	if (ide_use_fast_pio(drive)) {
+	if (ide_use_fast_pio(drive))
 		sis5513_tune_drive(drive, 5);
-		return hwif->ide_dma_off_quietly(drive);
-	}
-	/* IORDY not supported */
-	return 0;
+
+	return hwif->ide_dma_off_quietly(drive);
 }
 
 /* Chip detection and general config */
Index: b/drivers/ide/pci/slc90e66.c
===================================================================
--- a/drivers/ide/pci/slc90e66.c
+++ b/drivers/ide/pci/slc90e66.c
@@ -189,10 +189,9 @@ static int slc90e66_config_drive_xfer_ra
 	if (ide_use_fast_pio(drive)) {
 		(void) hwif->speedproc(drive, XFER_PIO_0 +
 				       ide_get_best_pio_mode(drive, 255, 4, NULL));
-		return hwif->ide_dma_off_quietly(drive);
 	}
-	/* IORDY not supported */
-	return 0;
+
+	return hwif->ide_dma_off_quietly(drive);
 }
 
 static void __devinit init_hwif_slc90e66 (ide_hwif_t *hwif)
Index: b/drivers/ide/pci/tc86c001.c
===================================================================
--- a/drivers/ide/pci/tc86c001.c
+++ b/drivers/ide/pci/tc86c001.c
@@ -190,12 +190,10 @@ static int tc86c001_config_drive_xfer_ra
 	if (ide_use_dma(drive) && config_chipset_for_dma(drive))
 		return hwif->ide_dma_on(drive);
 
-	if (ide_use_fast_pio(drive)) {
+	if (ide_use_fast_pio(drive))
 		tc86c001_tune_drive(drive, 255);
-		return hwif->ide_dma_off_quietly(drive);
-	}
-	/* IORDY not supported */
-	return 0;
+
+	return hwif->ide_dma_off_quietly(drive);
 }
 
 static void __devinit init_hwif_tc86c001(ide_hwif_t *hwif)
