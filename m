Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262030AbTFXNbJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jun 2003 09:31:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262032AbTFXNbI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jun 2003 09:31:08 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:12954 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S262030AbTFXNbC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jun 2003 09:31:02 -0400
Date: Tue, 24 Jun 2003 15:44:36 +0200 (MET DST)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Jan-Benedict Glaw <jbglaw@lug-owl.de>
cc: <axboe@suse.de>, <linux-kernel@vger.kernel.org>
Subject: Re: Testing IDE-TCQ and Taskfile - doesn't work nicely:)
In-Reply-To: <20030624063137.GA6353@lug-owl.de>
Message-ID: <Pine.SOL.4.30.0306241543050.23584-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Corrected patch below...
--
Bartlomiej

[ide] TCQ initialization fixes

- do not enable TCQ in ide_init_drive(), its too early
- enable TCQ in __ide_dma_on() only if CONFIG_BLK_DEV_IDE_TCQ_DEFAULT=y
- try to enable TCQ only on disk drives
- correct check for two drives on one channel

 drivers/ide/ide-dma.c   |    8 ++++----
 drivers/ide/ide-probe.c |    5 -----
 drivers/ide/ide-tcq.c   |   14 +++++++++++---
 include/linux/ide.h     |    1 -
 4 files changed, 15 insertions(+), 13 deletions(-)

diff -puN drivers/ide/ide-probe.c~ide-tcq-init-fixes drivers/ide/ide-probe.c
--- linux-2.5.73/drivers/ide/ide-probe.c~ide-tcq-init-fixes	Tue Jun 24 14:56:57 2003
+++ linux-2.5.73-root/drivers/ide/ide-probe.c	Tue Jun 24 14:56:57 2003
@@ -983,7 +983,6 @@ static void ide_init_queue(ide_drive_t *

 	blk_init_queue(q, do_ide_request, &ide_lock);
 	q->queuedata = HWGROUP(drive);
-	drive->queue_setup = 1;
 	blk_queue_segment_boundary(q, 0xffff);

 	if (!hwif->rqsize)
@@ -1005,10 +1004,6 @@ static void ide_init_queue(ide_drive_t *
 static void ide_init_drive(ide_drive_t *drive)
 {
 	ide_toggle_bounce(drive, 1);
-
-#ifdef CONFIG_BLK_DEV_IDE_TCQ_DEFAULT
-	HWIF(drive)->ide_dma_queued_on(drive);
-#endif
 }

 /*
diff -puN drivers/ide/ide-dma.c~ide-tcq-init-fixes drivers/ide/ide-dma.c
--- linux-2.5.73/drivers/ide/ide-dma.c~ide-tcq-init-fixes	Tue Jun 24 14:56:57 2003
+++ linux-2.5.73-root/drivers/ide/ide-dma.c	Tue Jun 24 15:16:34 2003
@@ -523,8 +523,7 @@ int __ide_dma_off_quietly (ide_drive_t *
 	if (HWIF(drive)->ide_dma_host_off(drive))
 		return 1;

-	if (drive->queue_setup)
-		HWIF(drive)->ide_dma_queued_off(drive);
+	HWIF(drive)->ide_dma_queued_off(drive);

 	return 0;
 }
@@ -585,8 +584,9 @@ int __ide_dma_on (ide_drive_t *drive)
 	if (HWIF(drive)->ide_dma_host_on(drive))
 		return 1;

-	if (drive->queue_setup)
-		HWIF(drive)->ide_dma_queued_on(drive);
+#ifdef CONFIG_BLK_DEV_IDE_TCQ_DEFAULT
+	HWIF(drive)->ide_dma_queued_on(drive);
+#endif

 	return 0;
 }
diff -puN drivers/ide/ide-tcq.c~ide-tcq-init-fixes drivers/ide/ide-tcq.c
--- linux-2.5.73/drivers/ide/ide-tcq.c~ide-tcq-init-fixes	Tue Jun 24 14:57:10 2003
+++ linux-2.5.73-root/drivers/ide/ide-tcq.c	Tue Jun 24 15:40:26 2003
@@ -501,8 +501,10 @@ static int ide_tcq_configure(ide_drive_t
 	 * bit 14 and 1 must be set in word 83 of the device id to indicate
 	 * support for dma queued protocol, and bit 15 must be cleared
 	 */
-	if ((drive->id->command_set_2 & tcq_bits) ^ tcq_mask)
+	if ((drive->id->command_set_2 & tcq_bits) ^ tcq_mask) {
+		printk(KERN_INFO "%s: TCQ not supported\n", drive->name);
 		return -EIO;
+	}

 	args = kmalloc(sizeof(*args), GFP_ATOMIC);
 	if (!args)
@@ -655,16 +657,20 @@ static int ide_tcq_check_blacklist(ide_d

 int __ide_dma_queued_on(ide_drive_t *drive)
 {
+	ide_hwif_t *hwif = HWIF(drive);
+
+	if (drive->media != ide_disk)
+		return 1;
 	if (!drive->using_dma)
 		return 1;
-	if (HWIF(drive)->chipset == ide_pdc4030)
+	if (hwif->chipset == ide_pdc4030)
 		return 1;
 	if (ide_tcq_check_blacklist(drive)) {
 		printk(KERN_WARNING "%s: tcq forbidden by blacklist\n",
 					drive->name);
 		return 1;
 	}
-	if (drive->next != drive) {
+	if (hwif->drives[0].present && hwif->drives[1].present) {
 		printk(KERN_WARNING "%s: only one drive on a channel supported"
 					" for tcq\n", drive->name);
 		return 1;
@@ -681,6 +687,8 @@ int __ide_dma_queued_on(ide_drive_t *dri

 int __ide_dma_queued_off(ide_drive_t *drive)
 {
+	if (drive->media != ide_disk)
+		return 1;
 	if (ata_pending_commands(drive)) {
 		printk("ide-tcq; can't toggle tcq feature on busy drive\n");
 		return 1;
diff -puN include/linux/ide.h~ide-tcq-init-fixes include/linux/ide.h
--- linux-2.5.73/include/linux/ide.h~ide-tcq-init-fixes	Tue Jun 24 14:56:57 2003
+++ linux-2.5.73-root/include/linux/ide.h	Tue Jun 24 14:56:57 2003
@@ -726,7 +726,6 @@ typedef struct ide_drive_s {
 	unsigned ata_flash	: 1;	/* 1=present, 0=default */
 	unsigned blocked        : 1;	/* 1=powermanagment told us not to do anything, so sleep nicely */
 	unsigned vdma		: 1;	/* 1=doing PIO over DMA 0=doing normal DMA */
-	unsigned queue_setup	: 1;
 	unsigned addressing;		/*      : 3;
 					 *  0=28-bit
 					 *  1=48-bit

_

