Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262050AbUDYBa5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262050AbUDYBa5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Apr 2004 21:30:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262051AbUDYBa5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Apr 2004 21:30:57 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:22237 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S262050AbUDYBax
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Apr 2004 21:30:53 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Sebastian Witt <se.witt@gmx.net>
Subject: Re: PROBLEM: Oops when using both channels of the PDC20262
Date: Sun, 25 Apr 2004 03:31:25 +0200
User-Agent: KMail/1.5.3
Cc: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       linux-kernel@vger.kernel.org, andre@linux-ide.org, frankt@promise.com
References: <40898ADA.8020708@hasw.net> <200404242230.20985.bzolnier@elka.pw.edu.pl> <408B046B.9040306@hasw.net>
In-Reply-To: <408B046B.9040306@hasw.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200404250331.25606.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 25 of April 2004 02:20, Sebastian Witt wrote:
> Bartlomiej Zolnierkiewicz wrote:
>  > There were some change in pdc202xx_old.c driver in 2.6.2.
>  > Please revert this patch and report if it helps.
>
> I've tested 2.6.2 with the reverted patch and it seems to work.
> Normally it takes <1min to crash the system when I access the discs
> on the controller, with the patched driver it works >1 hour without a
> error.

Ok, so now I know I screwed something but don't know what (yet). :-)

Please return back to 2.6.5 and try this patch, it disables PIO autotune.
It fixed hangs for people disabling Promise BIOS but...

 linux-2.6.6-rc2-bk1-bzolnier/drivers/ide/pci/pdc202xx_old.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN drivers/ide/pci/pdc202xx_old.c~pdc_old_notune drivers/ide/pci/pdc202xx_old.c
--- linux-2.6.6-rc2-bk1/drivers/ide/pci/pdc202xx_old.c~pdc_old_notune	2004-04-25 03:25:49.962088200 +0200
+++ linux-2.6.6-rc2-bk1-bzolnier/drivers/ide/pci/pdc202xx_old.c	2004-04-25 03:26:59.749478904 +0200
@@ -728,7 +728,7 @@ static void __init init_hwif_pdc202xx (i
 
 	hwif->speedproc = &pdc202xx_tune_chipset;
 
-	hwif->drives[0].autotune = hwif->drives[1].autotune = 1;
+//	hwif->drives[0].autotune = hwif->drives[1].autotune = 1;
 
 	hwif->ultra_mask = 0x3f;
 	hwif->mwdma_mask = 0x07;

_

If it doesn't help try this one instead
(reverts old way of setting 66MHz clock):

 linux-2.6.6-rc2-bk1-bzolnier/drivers/ide/pci/pdc202xx_old.c |   13 ++++++------
 1 files changed, 7 insertions(+), 6 deletions(-)

diff -puN drivers/ide/pci/pdc202xx_old.c~pdc_old_fix drivers/ide/pci/pdc202xx_old.c
--- linux-2.6.6-rc2-bk1/drivers/ide/pci/pdc202xx_old.c~pdc_old_fix	2004-04-25 03:09:26.692567888 +0200
+++ linux-2.6.6-rc2-bk1-bzolnier/drivers/ide/pci/pdc202xx_old.c	2004-04-25 03:21:30.607516088 +0200
@@ -405,10 +405,15 @@ static int config_chipset_for_dma (ide_d
 	if (ultra_66 && cable) {
 		printk(KERN_WARNING "Warning: %s channel requires an 80-pin cable for operation.\n", hwif->channel ? "Secondary":"Primary");
 		printk(KERN_WARNING "%s reduced to Ultra33 mode.\n", drive->name);
+		pdc_old_disable_66MHz_clock(drive->hwif);
 	}
 
-	if (dev->device != PCI_DEVICE_ID_PROMISE_20246)
-		pdc_old_disable_66MHz_clock(drive->hwif);
+	if (ultra_66 && !cable) {
+		if (hwif->drives[!(drive->dn%2)].id->dma_ultra & 0x0078)
+			pdc_old_enable_66MHz_clock(drive->hwif);
+		else
+			pdc_old_disable_66MHz_clock(drive->hwif);
+	}
 
 	drive_pci = 0x60 + (drive->dn << 2);
 	pci_read_config_dword(dev, drive_pci, &drive_conf);
@@ -507,8 +512,6 @@ static int pdc202xx_quirkproc (ide_drive
 
 static int pdc202xx_old_ide_dma_begin(ide_drive_t *drive)
 {
-	if (drive->current_speed > XFER_UDMA_2)
-		pdc_old_enable_66MHz_clock(drive->hwif);
 	if (drive->addressing == 1) {
 		struct request *rq	= HWGROUP(drive)->rq;
 		ide_hwif_t *hwif	= HWIF(drive);
@@ -542,8 +545,6 @@ static int pdc202xx_old_ide_dma_end(ide_
 		clock = hwif->INB(high_16 + 0x11);
 		hwif->OUTB(clock & ~(hwif->channel ? 0x08:0x02), high_16+0x11);
 	}
-	if (drive->current_speed > XFER_UDMA_2)
-		pdc_old_disable_66MHz_clock(drive->hwif);
 	return __ide_dma_end(drive);
 }
 

_

Thanks,
Bartlomiej

