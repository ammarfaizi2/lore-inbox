Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932274AbWFRR1l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932274AbWFRR1l (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jun 2006 13:27:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932272AbWFRR1k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jun 2006 13:27:40 -0400
Received: from bay105-f24.bay105.hotmail.com ([65.54.224.34]:18526 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S932271AbWFRR1j
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jun 2006 13:27:39 -0400
Message-ID: <BAY105-F2466BA098FF92E836830CAA3810@phx.gbl>
X-Originating-IP: [82.226.72.184]
X-Originating-Email: [tobiasoed@hotmail.com]
In-Reply-To: <BAY105-F37E386C7671BF4F79ABE01A3810@phx.gbl>
From: "Tobias Oed" <tobiasoed@hotmail.com>
To: tobiasoed@hotmail.com, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org, B.Zolnierkiewicz@elka.pw.edu.pl
Subject: RE: [patch] Enable cdrom dma access with pdc20265_old
Date: Sun, 18 Jun 2006 13:27:36 -0400
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
X-OriginalArrivalTime: 18 Jun 2006 17:27:39.0497 (UTC) FILETIME=[7F7D4D90:01C692FC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch allows me to use dma with my cd/dvd attached to
my on board pdc20265 ide controller

Signed-off-by: Tobias Oed <tobiasoed@hotmail.com>

diff -r -u linux-2.6.17-2/drivers/ide/pci/pdc202xx_old.c 
linux-2.6.17-3/drivers/ide/pci/pdc202xx_old.c
--- linux-2.6.17-2/drivers/ide/pci/pdc202xx_old.c       2006-06-18 
19:00:57.000000000 +0200
+++ linux-2.6.17-3/drivers/ide/pci/pdc202xx_old.c       2006-06-18 
19:01:25.000000000 +0200
@@ -180,7 +180,8 @@
        u8                      AP, BP, CP, DP;
        u8                      TA = 0, TB = 0, TC = 0;

-       if ((drive->media != ide_disk) && (speed < XFER_SW_DMA_0))
+       if (drive->media != ide_disk
+           && drive->media != ide_cdrom && speed < XFER_SW_DMA_0)
                return -1;

        pci_read_config_dword(dev, drive_pci, &drive_conf);
@@ -356,14 +357,12 @@

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

@@ -412,7 +411,7 @@
{
        if (drive->current_speed > XFER_UDMA_2)
                pdc_old_enable_66MHz_clock(drive->hwif);
-       if (drive->addressing == 1) {
+       if (drive->media != ide_disk || drive->addressing == 1) {
                struct request *rq      = HWGROUP(drive)->rq;
                ide_hwif_t *hwif        = HWIF(drive);
                unsigned long high_16   = hwif->dma_master;
@@ -432,7 +431,7 @@

static int pdc202xx_old_ide_dma_end(ide_drive_t *drive)
{
-       if (drive->addressing == 1) {
+       if (drive->media != ide_disk || drive->addressing == 1) {
                ide_hwif_t *hwif        = HWIF(drive);
                unsigned long high_16   = hwif->dma_master;
                unsigned long atapi_reg = high_16 + (hwif->channel ? 0x24 : 
0x20);
@@ -625,6 +624,7 @@
        hwif->ultra_mask = 0x3f;
        hwif->mwdma_mask = 0x07;
        hwif->swdma_mask = 0x07;
+       hwif->atapi_dma = 1;

        hwif->ide_dma_check = &pdc202xx_config_drive_xfer_rate;
        hwif->ide_dma_lostirq = &pdc202xx_ide_dma_lostirq;

_________________________________________________________________
Express yourself instantly with MSN Messenger! Download today - it's FREE! 
http://messenger.msn.click-url.com/go/onm00200471ave/direct/01/

