Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263587AbTE0NvJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 09:51:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263589AbTE0NvJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 09:51:09 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:36356 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id S263587AbTE0NvI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 09:51:08 -0400
Date: Tue, 27 May 2003 18:04:03 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Willy Tarreau <willy@w.ods.org>
Cc: Jason Papadopoulos <jasonp@boo.net>, linux-kernel@vger.kernel.org,
       marcelo@conectiva.com.br
Subject: Re: Linux 2.4.21-rc3 : IDE pb on Alpha
Message-ID: <20030527180403.A2292@jurassic.park.msu.ru>
References: <5.2.1.1.2.20030526232835.00a468e0@boo.net> <20030527045302.GA545@alpha.home.local> <20030527134017.B3408@jurassic.park.msu.ru> <20030527123152.GA24849@alpha.home.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030527123152.GA24849@alpha.home.local>; from willy@w.ods.org on Tue, May 27, 2003 at 02:31:52PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 27, 2003 at 02:31:52PM +0200, Willy Tarreau wrote:
> Sorry, I pasted the .config that I used just after, and which allowed me to
> boot. Later I set CONFIG_BLK_DEV_ALI15X3 again and CONFIG_BLK_DEV_IDEDMA_PCI,
> but I left CONFIG_IDEDMA_PCI_AUTO disabled. I now can boot and enable DMA
> later. That's weird, but it works.

Perhaps not that weird. From my experience, ALi DMA is sensitive to
some of "PIO timings". That is, if SRM hasn't initialized the chipset
properly (on Nautilus it has, BTW), DMA won't work. When you boot with
DMA disabled, driver has to set right PIO mode, so you can safely
enable DMA later.

Can you (and Jason) try this patch with CONFIG_IDEDMA_PCI_AUTO=y?

Ivan.

--- linux/drivers/ide/pci/alim15x3.c.orig	Tue Apr 22 19:17:22 2003
+++ linux/drivers/ide/pci/alim15x3.c	Tue May 27 17:42:17 2003
@@ -525,10 +525,14 @@ static int ali15x3_config_drive_for_dma(
 
 	drive->init_speed = 0;
 
+	/* Set reasonable PIO timings first - some of them are needed
+	   for DMA as well. */
+	hwif->tuneproc(drive, 255);
+
 	if ((id->capability & 1) != 0 && drive->autodma) {
 		/* Consult the list of known "bad" drives */
 		if (hwif->ide_dma_bad_drive(drive))
-			goto ata_pio;
+			goto no_dma_set;
 		if ((id->field_valid & 4) && (m5229_revision >= 0xC2)) {
 			if (id->dma_ultra & hwif->ultra_mask) {
 				/* Force if Capable UltraDMA */
@@ -550,11 +554,9 @@ try_dma_modes:
 			if (!config_chipset_for_dma(drive))
 				goto no_dma_set;
 		} else {
-			goto ata_pio;
+			goto no_dma_set;
 		}
 	} else {
-ata_pio:
-		hwif->tuneproc(drive, 255);
 no_dma_set:
 		return hwif->ide_dma_off_quietly(drive);
 	}
