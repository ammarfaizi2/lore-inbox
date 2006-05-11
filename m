Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750755AbWEKV6G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750755AbWEKV6G (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 May 2006 17:58:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750785AbWEKV6G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 May 2006 17:58:06 -0400
Received: from rtsoft2.corbina.net ([85.21.88.2]:55506 "HELO
	mail.dev.rtsoft.ru") by vger.kernel.org with SMTP id S1750738AbWEKV6E
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 May 2006 17:58:04 -0400
Message-ID: <4463B327.20307@ru.mvista.com>
Date: Fri, 12 May 2006 01:56:55 +0400
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: [PATCH] PIIX/SLC90E66: PIO mode fallback fix
Content-Type: multipart/mixed;
 boundary="------------040800030607080304040302"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040800030607080304040302
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello.

    The fallback to PIO mode in the hwif->dma_check() handler didn't work in
the Intel PIIX and SMsC SLC90E66 IDE drivers because:

  - config_drive_for_dma() called the hwif->speedproc() handler with the wrong
    mode number (unbiased by XFER_PIO_0) in case of the PIO fallback;

  - hwif->tuneproc() handler doesn't really set the drive's own speed (this
    is not fixed as yet).

MBR, Sergei

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>


--------------040800030607080304040302
Content-Type: text/plain;
 name="piix-slc90e66-pio-fallback-fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="piix-slc90e66-pio-fallback-fix.patch"

Index: linus/drivers/ide/pci/piix.c
===================================================================
--- linus.orig/drivers/ide/pci/piix.c
+++ linus/drivers/ide/pci/piix.c
@@ -1,13 +1,14 @@
 /*
- *  linux/drivers/ide/pci/piix.c	Version 0.44	March 20, 2003
+ *  linux/drivers/ide/pci/piix.c	Version 0.45	May 12, 2006
  *
  *  Copyright (C) 1998-1999 Andrzej Krzysztofowicz, Author and Maintainer
  *  Copyright (C) 1998-2000 Andre Hedrick <andre@linux-ide.org>
  *  Copyright (C) 2003 Red Hat Inc <alan@redhat.com>
+ *  Copyright (C) 2006 MontaVista Software, Inc. <source@mvista.com>
  *
  *  May be copied or modified under the terms of the GNU General Public License
  *
- *  PIO mode setting function for Intel chipsets.  
+ *  PIO mode setting function for Intel chipsets.
  *  For use instead of BIOS settings.
  *
  * 40-41
@@ -25,7 +26,7 @@
  * sitre = word42 & 0x4000; secondary
  *
  * 44 8421|8421    hdd|hdb
- * 
+ *
  * 48 8421         hdd|hdc|hdb|hda udma enabled
  *
  *    0001         hda
@@ -364,8 +365,8 @@ static int piix_faulty_dma0(ide_hwif_t *
  *	@drive: IDE drive to configure
  *
  *	Set up a PIIX interface channel for the best available speed.
- *	We prefer UDMA if it is available and then MWDMA. If DMA is 
- *	not available we switch to PIO and return 0. 
+ *	We prefer UDMA if it is available and then MWDMA.  If DMA is
+ *	not available we switch to PIO and return 0.
  */
  
 static int piix_config_drive_for_dma (ide_drive_t *drive)
@@ -376,13 +377,12 @@ static int piix_config_drive_for_dma (id
 	if(speed == XFER_MW_DMA_0 && piix_faulty_dma0(HWIF(drive)))
 		speed = 0;
 
-	/* If no DMA speed was available or the chipset has DMA bugs
-	   then disable DMA and use PIO */
-	   
-	if (!speed || no_piix_dma) {
-		u8 tspeed = ide_get_best_pio_mode(drive, 255, 5, NULL);
-		speed = piix_dma_2_pio(XFER_PIO_0 + tspeed);
-	}
+	/*
+	 * If no DMA speed was available or the chipset has DMA bugs
+	 * then disable DMA and use PIO
+	 */
+	if (!speed || no_piix_dma)
+		return 0;
 
 	(void) piix_tune_chipset(drive, speed);
 	return ide_dma_enable(drive);
@@ -405,17 +405,16 @@ static int piix_config_drive_xfer_rate (
 
 	if ((id->capability & 1) && drive->autodma) {
 
-		if (ide_use_dma(drive)) {
-			if (piix_config_drive_for_dma(drive))
-				return hwif->ide_dma_on(drive);
-		}
+		if (ide_use_dma(drive) && piix_config_drive_for_dma(drive))
+			return hwif->ide_dma_on(drive);
 
 		goto fast_ata_pio;
 
 	} else if ((id->capability & 8) || (id->field_valid & 2)) {
 fast_ata_pio:
 		/* Find best PIO mode. */
-		hwif->tuneproc(drive, 255);
+		(void) hwif->speedproc(drive, XFER_PIO_0 +
+				       ide_get_best_pio_mode(drive, 255, 4, NULL));
 		return hwif->ide_dma_off_quietly(drive);
 	}
 	/* IORDY not supported */
Index: linus/drivers/ide/pci/slc90e66.c
===================================================================
--- linus.orig/drivers/ide/pci/slc90e66.c
+++ linus/drivers/ide/pci/slc90e66.c
@@ -1,9 +1,10 @@
 /*
- *  linux/drivers/ide/pci/slc90e66.c	Version 0.11	September 11, 2002
+ *  linux/drivers/ide/pci/slc90e66.c	Version 0.12	May 12, 2006
  *
  *  Copyright (C) 2000-2002 Andre Hedrick <andre@linux-ide.org>
+ *  Copyright (C) 2006 MontaVista Software, Inc. <source@mvista.com>
  *
- * This a look-a-like variation of the ICH0 PIIX4 Ultra-66,
+ * This is a look-alike variation of the ICH0 PIIX4 Ultra-66,
  * but this keeps the ISA-Bridge and slots alive.
  *
  */
@@ -161,10 +162,8 @@ static int slc90e66_config_drive_for_dma
 {
 	u8 speed = ide_dma_speed(drive, slc90e66_ratemask(drive));
 
-	if (!(speed)) {
-		u8 tspeed = ide_get_best_pio_mode(drive, 255, 5, NULL);
-		speed = slc90e66_dma_2_pio(XFER_PIO_0 + tspeed);
-	}
+	if (!speed)
+		return 0;
 
 	(void) slc90e66_tune_chipset(drive, speed);
 	return ide_dma_enable(drive);
@@ -179,16 +178,15 @@ static int slc90e66_config_drive_xfer_ra
 
 	if (id && (id->capability & 1) && drive->autodma) {
 
-		if (ide_use_dma(drive)) {
-			if (slc90e66_config_drive_for_dma(drive))
-				return hwif->ide_dma_on(drive);
-		}
+		if (ide_use_dma(drive) && slc90e66_config_drive_for_dma(drive))
+			return hwif->ide_dma_on(drive);
 
 		goto fast_ata_pio;
 
 	} else if ((id->capability & 8) || (id->field_valid & 2)) {
 fast_ata_pio:
-		hwif->tuneproc(drive, 5);
+		(void) hwif->speedproc(drive, XFER_PIO_0 +
+				       ide_get_best_pio_mode(drive, 255, 4, NULL));
 		return hwif->ide_dma_off_quietly(drive);
 	}
 	/* IORDY not supported */


--------------040800030607080304040302--
