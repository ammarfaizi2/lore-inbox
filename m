Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264840AbUD2TEe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264840AbUD2TEe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 15:04:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264921AbUD2TEe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 15:04:34 -0400
Received: from bern.wildisoft.net ([66.80.62.108]:42769 "EHLO
	bern.wildisoft.net") by vger.kernel.org with ESMTP id S264840AbUD2TER
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 15:04:17 -0400
Date: Thu, 29 Apr 2004 12:04:13 -0700 (PDT)
From: Patrick Wildi <patrick@wildi.com>
X-X-Sender: patrick@bern.wildisoft.net
To: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
cc: andre@linux-ide.org, B.Zolnierkiewicz@elka.pw.edu.pl
Subject: [RFC][PATCH] 2.4 IDE Serverworks OSB4 DMA patch
Message-ID: <Pine.LNX.4.58.0404291130420.19527@bern.wildisoft.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have been using a OSB4 chipset based system with a CompactFlash
that supports PIO only and a laptop IBM/Hitachi Travelstar HDD
that supports UDMA.
For both drives, the serverworks code misconfigures the drives:

- for the CF (hooked up as /dev/hda), svwks_config_drive_xfer_rate()
  will not match any tests (drive->autodma = 0, id->capability = 2,
  id->field_valid = 1), but the function will then call
  hwif->ide_dma_on(drive), which it should not do for this drive.
  This patch moves the enabling of DMA up into the DMA section of
  the code.

- for the Travelstart HDD, the settings coming into
  svwks_config_drive_xfer_rate() are: drive->autodma = 32,
  id->capability = 15, id->field_valid = 7, id->dma_ultra = 0x43f.
  But as this is an OSB4, the hwif->ultra_mask is set to not support
  UDMA. Unfortunately in that case svwks_config_drive_xfer_rate()
  falls through to the end of the function, instead of trying
  other DMA modes.
  By adding a jump to try_dma_modes in the case that the drive
  is UDMA capable but the mask does not allow UDMA, the drive
  will be setup up for MWDMA.

The logic in svwks_config_drive_xfer_rate() could probably be
improved a bit, but I kept the changes to an absolute minium
to reduce the risk of breakage.

The patch is against 2.4.24, but the file has not changed in
2.4.25 and 2.4.26.

Patrick


--- linux-2.4.24-nam/drivers/ide/pci/serverworks.c.orig	Thu Apr 22 17:31:28 2004
+++ linux-2.4.24-nam/drivers/ide/pci/serverworks.c	Thu Apr 29 11:02:05 2004
@@ -473,7 +473,9 @@
 				int dma = config_chipset_for_dma(drive);
 				if ((id->field_valid & 2) && !dma)
 					goto try_dma_modes;
-			}
+			} else
+				/* UDMA disabled by mask, try other DMA modes */
+				goto try_dma_modes;
 		} else if (id->field_valid & 2) {
 try_dma_modes:
 			if ((id->dma_mword & hwif->mwdma_mask) ||
@@ -490,6 +492,7 @@
 		} else {
 			goto no_dma_set;
 		}
+		return hwif->ide_dma_on(drive);
 	} else if ((id->capability & 8) || (id->field_valid & 2)) {
 fast_ata_pio:
 no_dma_set:
@@ -497,7 +500,7 @@
 		//	hwif->tuneproc(drive, 5);
 		return hwif->ide_dma_off_quietly(drive);
 	}
-	return hwif->ide_dma_on(drive);
+	return 0;
 }

 /* This can go soon */
