Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750919AbWDRNP6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750919AbWDRNP6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Apr 2006 09:15:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750886AbWDRNP6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Apr 2006 09:15:58 -0400
Received: from bay105-f11.bay105.hotmail.com ([65.54.224.21]:8522 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S1750865AbWDRNP5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Apr 2006 09:15:57 -0400
Message-ID: <BAY105-F111271D2374577E2FBCB9FA3C40@phx.gbl>
X-Originating-IP: [82.226.72.184]
X-Originating-Email: [tobiasoed@hotmail.com]
From: "Tobias Oed" <tobiasoed@hotmail.com>
To: B.Zolnierkiewicz@elka.pw.edu.pl, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org
Cc: tobiasoed@hotmail.com, andre@linux-ide.org
Subject: [RFC] Get DMA to work for CD/DVD with pdc202xx_old
Date: Tue, 18 Apr 2006 09:15:53 -0400
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
X-OriginalArrivalTime: 18 Apr 2006 13:15:57.0197 (UTC) FILETIME=[3A9E73D0:01C662EA]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
I send something similar to linux-ide some weeks ago but got no reply.
This patch against 2.6.17-rc1-mm3 for pdc202xx_old.c allows me to
enable dma on my DVD and CD drives attached to my on board
pdc20265 ide controller. It works with udma modes only.
Tobias

--- pdc202xx_old.c.1    2006-04-18 13:12:47.000000000 +0200
+++ pdc202xx_old.c      2006-04-18 14:21:57.000000000 +0200
@@ -180,9 +180,11 @@
        u8                      AP, BP, CP, DP;
        u8                      TA = 0, TB = 0, TC = 0;

+       #if 0
        if ((drive->media != ide_disk) && (speed < XFER_SW_DMA_0))
                return -1;
-
+       #endif
+
        pci_read_config_dword(dev, drive_pci, &drive_conf);
        pci_read_config_byte(dev, (drive_pci), &AP);
        pci_read_config_byte(dev, (drive_pci)|0x01, &BP);
@@ -356,14 +358,12 @@

chipset_is_set:

-       if (drive->media == ide_disk) {
-               pci_read_config_byte(dev, (drive_pci), &AP);
-               if (id->capability & 4) /* IORDY_EN */
-                       pci_write_config_byte(dev, (drive_pci), 
AP|IORDY_EN);
-               pci_read_config_byte(dev, (drive_pci), &AP);
-               if (drive->media == ide_disk)   /* PREFETCH_EN */
-                       pci_write_config_byte(dev, (drive_pci), 
AP|PREFETCH_EN);
-       }
+       pci_read_config_byte(dev, (drive_pci), &AP);
+       if (id->capability & 4) /* IORDY_EN */
+               pci_write_config_byte(dev, (drive_pci), AP|IORDY_EN);
+       pci_read_config_byte(dev, (drive_pci), &AP);
+       if (drive->media == ide_disk)   /* PREFETCH_EN */
+               pci_write_config_byte(dev, (drive_pci), AP|PREFETCH_EN);

        speed = ide_dma_speed(drive, pdc202xx_ratemask(drive));

@@ -411,7 +411,7 @@
{
        if (drive->current_speed > XFER_UDMA_2)
                pdc_old_enable_66MHz_clock(drive->hwif);
-       if (drive->addressing == 1) {
+       if (drive->media != ide_disk || drive->addressing == 1) {
                struct request *rq      = HWGROUP(drive)->rq;
                ide_hwif_t *hwif        = HWIF(drive);
//             struct pci_dev *dev     = hwif->pci_dev;
@@ -433,7 +433,7 @@

static int pdc202xx_old_ide_dma_end(ide_drive_t *drive)
{
-       if (drive->addressing == 1) {
+       if (drive->media != ide_disk || drive->addressing == 1) {
                ide_hwif_t *hwif        = HWIF(drive);
//             unsigned long high_16   = pci_resource_start(hwif->pci_dev, 
4);
                unsigned long high_16   = hwif->dma_master;
@@ -635,6 +635,7 @@
        hwif->ultra_mask = 0x3f;
        hwif->mwdma_mask = 0x07;
        hwif->swdma_mask = 0x07;
+        hwif->atapi_dma = 1;

        hwif->ide_dma_check = &pdc202xx_config_drive_xfer_rate;
        hwif->ide_dma_lostirq = &pdc202xx_ide_dma_lostirq;

_________________________________________________________________
Is your PC infected? Get a FREE online computer virus scan from McAfee® 
Security. http://clinic.mcafee.com/clinic/ibuy/campaign.asp?cid=3963

