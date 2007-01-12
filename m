Return-Path: <linux-kernel-owner+w=401wt.eu-S1030481AbXALE0Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030481AbXALE0Z (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 23:26:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030524AbXALE0O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 23:26:14 -0500
Received: from ug-out-1314.google.com ([66.249.92.169]:34121 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030493AbXALEYL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 23:24:11 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:cc:date:message-id:in-reply-to:references:subject;
        b=S74/1U7RWwCnwR1N0rNZy8lEI9xZLzjwrcjOKg5vHukppNk8SmPu/jKBS9OOrztVUGreGUewRLYcyzc9+2GMr2W1LwRXNloEgS6GeSxzw9RK/bY83tBdsE13veFrr6PLmt5hb3ReRhnxIKyexmpV2DRiIE+fkyCiVEVCDqMVKNg=
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
       linux-kernel@vger.kernel.org
Date: Fri, 12 Jan 2007 05:27:47 +0100
Message-Id: <20070112042747.28794.38484.sendpatchset@localhost.localdomain>
In-Reply-To: <20070112042621.28794.6937.sendpatchset@localhost.localdomain>
References: <20070112042621.28794.6937.sendpatchset@localhost.localdomain>
Subject: [PATCH 16/19] sis5513: sis5513_config_xfer_rate() cleanup
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] sis5513: sis5513_config_xfer_rate() cleanup

* remove bogus comment for sis5513_config_xfer_rate()
* there is no need to call config_drive_art_rwp() because
  it is called by config_art_rwp_pio()
* remove needless wrapper
* remove stale "TODO" comment
  (IDE core should provide generic tuning code)

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

---
 drivers/ide/pci/sis5513.c |   41 +++--------------------------------------
 1 file changed, 3 insertions(+), 38 deletions(-)

Index: a/drivers/ide/pci/sis5513.c
===================================================================
--- a.orig/drivers/ide/pci/sis5513.c
+++ a/drivers/ide/pci/sis5513.c
@@ -667,11 +667,13 @@ static int config_chipset_for_dma (ide_d
 	return ide_dma_enable(drive);
 }
 
-static int sis5513_config_drive_xfer_rate (ide_drive_t *drive)
+static int sis5513_config_xfer_rate(ide_drive_t *drive)
 {
 	ide_hwif_t *hwif	= HWIF(drive);
 	struct hd_driveid *id	= drive->id;
 
+	config_art_rwp_pio(drive, 5);
+
 	drive->init_speed = 0;
 
 	if (id && (id->capability & 1) && drive->autodma) {
@@ -692,43 +694,6 @@ fast_ata_pio:
 	return 0;
 }
 
-/* initiates/aborts (U)DMA read/write operations on a drive. */
-static int sis5513_config_xfer_rate (ide_drive_t *drive)
-{
-	config_drive_art_rwp(drive);
-	config_art_rwp_pio(drive, 5);
-	return sis5513_config_drive_xfer_rate(drive);
-}
-
-/*
-  Future simpler config_xfer_rate :
-   When ide_find_best_mode is made bad-drive aware
-   - remove config_drive_xfer_rate and config_chipset_for_dma,
-   - replace config_xfer_rate with the following
-
-static int sis5513_config_xfer_rate (ide_drive_t *drive)
-{
-	u16 w80 = HWIF(drive)->udma_four;
-	u16 speed;
-
-	config_drive_art_rwp(drive);
-	config_art_rwp_pio(drive, 5);
-
-	speed = ide_find_best_mode(drive,
-		XFER_PIO | XFER_EPIO | XFER_SWDMA | XFER_MWDMA |
-		(chipset_family >= ATA_33 ? XFER_UDMA : 0) |
-		(w80 && chipset_family >= ATA_66 ? XFER_UDMA_66 : 0) |
-		(w80 && chipset_family >= ATA_100a ? XFER_UDMA_100 : 0) |
-		(w80 && chipset_family >= ATA_133a ? XFER_UDMA_133 : 0));
-
-	sis5513_tune_chipset(drive, speed);
-
-	if (drive->autodma && (speed & XFER_MODE) != XFER_PIO)
-		return HWIF(drive)->ide_dma_on(drive);
-	return HWIF(drive)->ide_dma_off_quietly(drive);
-}
-*/
-
 /* Chip detection and general config */
 static unsigned int __devinit init_chipset_sis5513 (struct pci_dev *dev, const char *name)
 {
