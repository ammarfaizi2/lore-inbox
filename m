Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750810AbWEKWII@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750810AbWEKWII (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 May 2006 18:08:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750816AbWEKWIH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 May 2006 18:08:07 -0400
Received: from rtsoft2.corbina.net ([85.21.88.2]:17107 "HELO
	mail.dev.rtsoft.ru") by vger.kernel.org with SMTP id S1750810AbWEKWIG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 May 2006 18:08:06 -0400
Message-ID: <4463B589.5050205@ru.mvista.com>
Date: Fri, 12 May 2006 02:07:05 +0400
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: [PATCH] PIIX: remove check for broken MW DMA mode 0
Content-Type: multipart/mixed;
 boundary="------------080308030506060108080409"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080308030506060108080409
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello.

    There's no need to check in piix_config_drive_for_dma() for broken MW DMA
mode 0 as this mode is not supported by the driver (it sets hwif->mwdma_mask
to 0x6), and hence can't be selected by ide_dma_speed().

MBR, Sergei

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>


--------------080308030506060108080409
Content-Type: text/plain;
 name="piix-remove-mwdma0-check.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="piix-remove-mwdma0-check.patch"

Index: linus/drivers/ide/pci/piix.c
===================================================================
--- linus.orig/drivers/ide/pci/piix.c
+++ linus/drivers/ide/pci/piix.c
@@ -334,33 +334,6 @@ static int piix_tune_chipset (ide_drive_
 }
 
 /**
- *	piix_faulty_dma0		-	check for DMA0 errata
- *	@hwif: IDE interface to check
- *
- *	If an ICH/ICH0/ICH2 interface is is operating in multi-word
- *	DMA mode with 600nS cycle time the IDE PIO prefetch buffer will
- *	inadvertently provide an extra piece of secondary data to the primary
- *	device resulting in data corruption.
- *
- *	With such a device this test function returns true. This allows
- *	our tuning code to follow Intel recommendations and use PIO on
- *	such devices.
- */
- 
-static int piix_faulty_dma0(ide_hwif_t *hwif)
-{
-	switch(hwif->pci_dev->device)
-	{
-		case PCI_DEVICE_ID_INTEL_82801AA_1:	/* ICH */
-		case PCI_DEVICE_ID_INTEL_82801AB_1:	/* ICH0 */
-		case PCI_DEVICE_ID_INTEL_82801BA_8:	/* ICH2 */
-		case PCI_DEVICE_ID_INTEL_82801BA_9:	/* ICH2 */
-			return 1;
-	}
-	return 0;
-}
-
-/**
  *	piix_config_drive_for_dma	-	configure drive for DMA
  *	@drive: IDE drive to configure
  *
@@ -372,10 +345,6 @@ static int piix_faulty_dma0(ide_hwif_t *
 static int piix_config_drive_for_dma (ide_drive_t *drive)
 {
 	u8 speed = ide_dma_speed(drive, piix_ratemask(drive));
-	
-	/* Some ICH devices cannot support DMA mode 0 */
-	if(speed == XFER_MW_DMA_0 && piix_faulty_dma0(HWIF(drive)))
-		speed = 0;
 
 	/*
 	 * If no DMA speed was available or the chipset has DMA bugs


--------------080308030506060108080409--
