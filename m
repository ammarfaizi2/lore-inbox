Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263865AbTCUTyK>; Fri, 21 Mar 2003 14:54:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263860AbTCUTdp>; Fri, 21 Mar 2003 14:33:45 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:62596
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S263865AbTCUTdd>; Fri, 21 Mar 2003 14:33:33 -0500
Date: Fri, 21 Mar 2003 20:48:48 GMT
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200303212048.h2LKmmUP026515@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: fix tuning of alim15x3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/drivers/ide/pci/alim15x3.c linux-2.5.65-ac2/drivers/ide/pci/alim15x3.c
--- linux-2.5.65/drivers/ide/pci/alim15x3.c	2003-03-03 19:20:09.000000000 +0000
+++ linux-2.5.65-ac2/drivers/ide/pci/alim15x3.c	2003-03-06 23:11:45.000000000 +0000
@@ -518,7 +518,7 @@
 	if ((id != NULL) && ((id->capability & 1) != 0) && drive->autodma) {
 		/* Consult the list of known "bad" drives */
 		if (hwif->ide_dma_bad_drive(drive))
-			goto fast_ata_pio;
+			goto ata_pio;
 		if ((id->field_valid & 4) && (m5229_revision >= 0xC2)) {
 			if (id->dma_ultra & hwif->ultra_mask) {
 				/* Force if Capable UltraDMA */
@@ -540,12 +540,12 @@
 			if (!config_chipset_for_dma(drive))
 				goto no_dma_set;
 		} else {
-			goto fast_ata_pio;
+			goto ata_pio;
 		}
-	} else if ((id->capability & 8) || (id->field_valid & 2)) {
-fast_ata_pio:
+	} else {
+ata_pio:
+		hwif->tuneproc(drive, 255);
 no_dma_set:
-		hwif->tuneproc(drive, 5);
 		return hwif->ide_dma_off_quietly(drive);
 	}
 	return hwif->ide_dma_on(drive);
@@ -753,6 +753,8 @@
 		return;
 	}
 
+	hwif->atapi_dma = 1;
+
 	if (m5229_revision > 0x20)
 		hwif->ultra_mask = 0x3f;
 	hwif->mwdma_mask = 0x07;
