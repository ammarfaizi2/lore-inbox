Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262350AbUCHAB1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Mar 2004 19:01:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262359AbUCHAB1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Mar 2004 19:01:27 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:65236 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S262350AbUCHABV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Mar 2004 19:01:21 -0500
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Carlo Orecchia <carlo@numb.darktech.org>,
       "David B. Stevens" <dsteven3@maine.rr.com>
Subject: Re: KERNEL 2.6.3 and MAXTOR 160 GB
Date: Mon, 8 Mar 2004 01:09:05 +0100
User-Agent: KMail/1.5.3
Cc: linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0403072320180.2714-100000@numb.darktech.org>
In-Reply-To: <Pine.LNX.4.44.0403072320180.2714-100000@numb.darktech.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200403080109.05428.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sunday 07 of March 2004 23:26, Carlo Orecchia wrote:
> Sorry my stupid mistake .. this is the correct message from boot:
> Thanks for any reply!!
>
> ide: Assuming 33MHz system bus speed for PIO modes; override with
> idebus=xx
> ALI15X3: IDE controller at PCI slot 0000:00:04.0
> ACPI: No IRQ known for interrupt pin A of device 0000:00:04.0 - using IRQ
> 255
> ALI15X3: chipset revision 196
> ALI15X3: not 100% native mode: will probe irqs later
>     ide0: BM-DMA at 0xb400-0xb407, BIOS settings: hda:DMA, hdb:pio
>     ide1: BM-DMA at 0xb408-0xb40f, BIOS settings: hdc:pio, hdd:pio
> hda: Maxtor 6Y160P0, ATA DISK drive
> ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> hdc: no response (status = 0xa1), resetting drive
> hdc: no response (status = 0xa1)
> hdd: no response (status = 0xa1), resetting drive
> hdd: no response (status = 0xa1)
> hdc: no response (status = 0xa1), resetting drive
> hdc: no response (status = 0xa1)
> hdd: no response (status = 0xa1), resetting drive
> hdd: no response (status = 0xa1)
> hda: max request size: 128KiB
> hda: cannot use LBA48 - full capacity 320173056 sectors (163928 MB)
> hda: 268435456 sectors (137438 MB) w/7936KiB Cache, CHS=16709/255/63,
> UDMA(100)

Your IDE controller doesn't support DMA transfer modes when LBA48 is used.
This means that access to the > 137GB part of the disk can only be done
using PIO modes (slow!).

Patch below (against kernel 2.6.4-rc2) should fix access to >137GB part
of the disk in the best possible way - IDE driver will always try to use
DMA and revert to PIO only when necessary.  I dunno what patches are
included in RedHat's 2.4.20-8 but kernels < 2.4.23 can silently corrupt
your data because of this issue (and you still won't access whole disk
with >= 2.4.23, although -ac tree contained fix which just turned DMA off).

> # CONFIG_IDE_TASKFILE_IO is not set

Please don't set it to 'y' while using this patch (because it's harder to
fix for CONFIG_IDE_TASKFILE_IO and conflicts with other pending patches).

Regards,
Bartlomiej

 linux-2.6.4-rc2-root/drivers/ide/ide-disk.c     |   29 +++++++++++++++++-------
 linux-2.6.4-rc2-root/drivers/ide/ide-probe.c    |    8 ++++--
 linux-2.6.4-rc2-root/drivers/ide/pci/alim15x3.c |    4 +--
 linux-2.6.4-rc2-root/include/linux/ide.h        |    1 
 4 files changed, 30 insertions(+), 12 deletions(-)

diff -puN drivers/ide/ide-disk.c~ide_no_lba48_dma drivers/ide/ide-disk.c
--- linux-2.6.4-rc2/drivers/ide/ide-disk.c~ide_no_lba48_dma	2004-03-08 00:07:38.518961600 +0100
+++ linux-2.6.4-rc2-root/drivers/ide/ide-disk.c	2004-03-08 00:51:05.705608984 +0100
@@ -470,12 +470,15 @@ ide_startstop_t __ide_do_rw_disk (ide_dr
 	}
 
 	if (rq_data_dir(rq) == READ) {
+		if (!drive->hwif->no_lba48_dma ||
+		    rq->sector + rq->nr_sectors < 1ULL << 28) {
 #ifdef CONFIG_BLK_DEV_IDE_TCQ
-		if (blk_rq_tagged(rq))
-			return __ide_dma_queued_read(drive);
+			if (blk_rq_tagged(rq))
+				return __ide_dma_queued_read(drive);
 #endif
-		if (drive->using_dma && !hwif->ide_dma_read(drive))
-			return ide_started;
+			if (drive->using_dma && !hwif->ide_dma_read(drive))
+				return ide_started;
+		}
 
 		command = ((drive->mult_count) ?
 			   ((lba48) ? WIN_MULTREAD_EXT : WIN_MULTREAD) :
@@ -484,12 +487,16 @@ ide_startstop_t __ide_do_rw_disk (ide_dr
 		return ide_started;
 	} else if (rq_data_dir(rq) == WRITE) {
 		ide_startstop_t startstop;
+
+		if (!drive->hwif->no_lba48_dma ||
+		    rq->sector + rq->nr_sectors < 1ULL << 28) {
 #ifdef CONFIG_BLK_DEV_IDE_TCQ
-		if (blk_rq_tagged(rq))
-			return __ide_dma_queued_write(drive);
+			if (blk_rq_tagged(rq))
+				return __ide_dma_queued_write(drive);
 #endif
-		if (drive->using_dma && !(HWIF(drive)->ide_dma_write(drive)))
-			return ide_started;
+			if (drive->using_dma && !hwif->ide_dma_write(drive))
+				return ide_started;
+		}
 
 		command = ((drive->mult_count) ?
 			   ((lba48) ? WIN_MULTWRITE_EXT : WIN_MULTWRITE) :
@@ -1601,6 +1608,12 @@ static void idedisk_setup (ide_drive_t *
 		drive->capacity64 = 1ULL << 28;
 	}
 
+	if (drive->hwif->no_lba48_dma && drive->capacity64 > 1ULL << 28) {
+		printk(KERN_INFO "%s: cannot use LBA48 DMA - PIO mode will be"
+				 "used for accessing sectors > %u\n",
+				 drive->name, 1 << 28);
+	}
+
 	/*
 	 * if possible, give fdisk access to more of the drive,
 	 * by correcting bios_cyls:
diff -puN drivers/ide/ide-probe.c~ide_no_lba48_dma drivers/ide/ide-probe.c
--- linux-2.6.4-rc2/drivers/ide/ide-probe.c~ide_no_lba48_dma	2004-03-08 00:07:38.522960992 +0100
+++ linux-2.6.4-rc2-root/drivers/ide/ide-probe.c	2004-03-08 00:07:38.531959624 +0100
@@ -922,8 +922,12 @@ static int ide_init_queue(ide_drive_t *d
 	q->queuedata = HWGROUP(drive);
 	blk_queue_segment_boundary(q, 0xffff);
 
-	if (!hwif->rqsize)
-		hwif->rqsize = hwif->no_lba48 ? 256 : 65536;
+	if (!hwif->rqsize) {
+		if (hwif->no_lba48 || hwif->no_lba48_dma)
+			hwif->rqsize = 256;
+		else
+			hwif->rqsize = 65536;
+	}
 	if (hwif->rqsize < max_sectors)
 		max_sectors = hwif->rqsize;
 	blk_queue_max_sectors(q, max_sectors);
diff -puN drivers/ide/pci/alim15x3.c~ide_no_lba48_dma drivers/ide/pci/alim15x3.c
--- linux-2.6.4-rc2/drivers/ide/pci/alim15x3.c~ide_no_lba48_dma	2004-03-08 00:07:38.504963728 +0100
+++ linux-2.6.4-rc2-root/drivers/ide/pci/alim15x3.c	2004-03-08 00:07:38.526960384 +0100
@@ -752,8 +752,8 @@ static void __init init_hwif_common_ali1
 	hwif->tuneproc = &ali15x3_tune_drive;
 	hwif->speedproc = &ali15x3_tune_chipset;
 
-	/* Don't use LBA48 on ALi devices before rev 0xC5 */
-	hwif->no_lba48 = (m5229_revision <= 0xC4) ? 1 : 0;
+	/* don't use LBA48 DMA on ALi devices before rev 0xC5 */
+	hwif->no_lba48_dma = (m5229_revision <= 0xC4) ? 1 : 0;
 
 	if (!hwif->dma_base) {
 		hwif->drives[0].autotune = 1;
diff -puN include/linux/ide.h~ide_no_lba48_dma include/linux/ide.h
--- linux-2.6.4-rc2/include/linux/ide.h~ide_no_lba48_dma	2004-03-08 00:07:38.515962056 +0100
+++ linux-2.6.4-rc2-root/include/linux/ide.h	2004-03-08 00:07:38.527960232 +0100
@@ -980,6 +980,7 @@ typedef struct hwif_s {
 	unsigned	autodma    : 1;	/* auto-attempt using DMA at boot */
 	unsigned	udma_four  : 1;	/* 1=ATA-66 capable, 0=default */
 	unsigned	no_lba48   : 1; /* 1 = cannot do LBA48 */
+	unsigned	no_lba48_dma : 1; /* 1 = cannot do LBA48 DMA */
 	unsigned	no_dsc     : 1;	/* 0 default, 1 dsc_overlap disabled */
 	unsigned	auto_poll  : 1; /* supports nop auto-poll */
 

_

