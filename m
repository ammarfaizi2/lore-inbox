Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264158AbTDWR3c (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 13:29:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264156AbTDWR2J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 13:28:09 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:13777 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S264145AbTDWR1p
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 13:27:45 -0400
Date: Wed, 23 Apr 2003 19:39:37 +0200 (MET DST)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Andre Hedrick <andre@linux-ide.org>, Jens Axboe <axboe@suse.de>,
       <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2.5.67-ac2 direct-IO for IDE taskfile ioctl (3/4)
In-Reply-To: <Pine.SOL.4.30.0304231933360.10502-100000@mion.elka.pw.edu.pl>
Message-ID: <Pine.SOL.4.30.0304231939140.10502-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


# Add support for rq->bio based taskfile.
#
# Detailed changelog:
# - use ide_build_sglist() also for rq->bio based REQ_DRIVE_TASKFILE
#   in ide_build_dmatable(), plus similar changes for ARM and PPC
# - add support for REQ_DRIVE_TASKFILE to ide_end_request() and PIO handlers
# - add support for REQ_DRIVE_TASKFILE to ide_dma_intr() and icside_dmaintr()
#
# Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>

diff -uNr linux-2.5.67-ac2-dtf2/drivers/ide/arm/icside.c linux/drivers/ide/arm/icside.c
--- linux-2.5.67-ac2-dtf2/drivers/ide/arm/icside.c	Wed Apr 23 15:14:07 2003
+++ linux/drivers/ide/arm/icside.c	Wed Apr 23 15:32:56 2003
@@ -276,7 +276,8 @@

 	BUG_ON(hwif->sg_dma_active);

-	if (rq->flags & REQ_DRIVE_TASKFILE) {
+	/* rq->buffer based taskfile */
+	if ((rq->flags & REQ_DRIVE_TASKFILE) && !rq->bio) {
 		ide_task_t *args = rq->special;

 		if (args->command_type == IDE_DRIVE_TASK_RAW_WRITE)
@@ -573,13 +574,10 @@
 	if (OK_STAT(stat, DRIVE_READY, drive->bad_wstat | DRQ_STAT)) {
 		if (!dma_stat) {
 			struct request *rq = HWGROUP(drive)->rq;
-			int i;
-
-			for (i = rq->nr_sectors; i > 0; ) {
-				i -= rq->current_nr_sectors;
-				DRIVER(drive)->end_request(drive, 1, rq->nr_sectors);
-			}

+			DRIVER(drive)->end_request(drive, 1, rq->nr_sectors);
+			if (rq->flags & REQ_DRIVE_TASKFILE)
+				ide_end_drive_cmd(drive, stat, HWIF(drive)->INB(IDE_ERROR_REG));
 			return ide_stopped;
 		}
 		printk(KERN_ERR "%s: bad DMA status (dma_stat=%x)\n",
diff -uNr linux-2.5.67-ac2-dtf2/drivers/ide/ppc/pmac.c linux/drivers/ide/ppc/pmac.c
--- linux-2.5.67-ac2-dtf2/drivers/ide/ppc/pmac.c	Wed Apr 23 15:14:07 2003
+++ linux/drivers/ide/ppc/pmac.c	Wed Apr 23 15:39:28 2003
@@ -1010,7 +1010,9 @@
 		udelay(1);

 	/* Build sglist */
-	if (HWGROUP(drive)->rq->flags & REQ_DRIVE_TASKFILE)
+
+	/* rq->buffer based taskfile */
+	if ((HWGROUP(drive)->rq->flags & REQ_DRIVE_TASKFILE) && !rq->bio)
 		pmif->sg_nents = i = pmac_ide_raw_build_sglist(drive, rq);
 	else
 		pmif->sg_nents = i = pmac_ide_build_sglist(drive, rq);
diff -uNr linux-2.5.67-ac2-dtf2/drivers/ide/ide-dma.c linux/drivers/ide/ide-dma.c
--- linux-2.5.67-ac2-dtf2/drivers/ide/ide-dma.c	Wed Apr 23 15:14:07 2003
+++ linux/drivers/ide/ide-dma.c	Wed Apr 23 15:35:27 2003
@@ -180,6 +180,8 @@
 			struct request *rq = HWGROUP(drive)->rq;

 			DRIVER(drive)->end_request(drive, 1, rq->nr_sectors);
+			if (rq->flags & REQ_DRIVE_TASKFILE)
+				ide_end_drive_cmd(drive, stat, HWIF(drive)->INB(IDE_ERROR_REG));
 			return ide_stopped;
 		}
 		printk(KERN_ERR "%s: dma_intr: bad DMA status (dma_stat=%x)\n",
@@ -303,7 +305,8 @@
 	int i;
 	struct scatterlist *sg;

-	if (HWGROUP(drive)->rq->flags & REQ_DRIVE_TASKFILE)
+	/* rq->buffer based taskfile */
+	if ((HWGROUP(drive)->rq->flags & REQ_DRIVE_TASKFILE) && !rq->bio)
 		hwif->sg_nents = i = ide_raw_build_sglist(drive, rq);
 	else
 		hwif->sg_nents = i = ide_build_sglist(drive, rq);
diff -uNr linux-2.5.67-ac2-dtf2/drivers/ide/ide-io.c linux/drivers/ide/ide-io.c
--- linux-2.5.67-ac2-dtf2/drivers/ide/ide-io.c	Tue Apr 22 22:34:34 2003
+++ linux/drivers/ide/ide-io.c	Wed Apr 23 00:27:43 2003
@@ -124,6 +124,12 @@
 	}

 	if (!end_that_request_first(rq, uptodate, nr_sectors)) {
+
+		if (rq->flags & REQ_DRIVE_TASKFILE) {
+			spin_unlock_irqrestore(&ide_lock, flags);
+			return 0;
+		}
+
 		add_disk_randomness(rq->rq_disk);
 		if (!blk_rq_tagged(rq))
 			blkdev_dequeue_request(rq);
diff -uNr linux-2.5.67-ac2-dtf2/drivers/ide/ide-taskfile.c linux/drivers/ide/ide-taskfile.c
--- linux-2.5.67-ac2-dtf2/drivers/ide/ide-taskfile.c	Wed Apr 23 00:19:19 2003
+++ linux/drivers/ide/ide-taskfile.c	Wed Apr 23 00:21:34 2003
@@ -419,8 +419,11 @@
 	 * Status was already verifyied.
 	 */
 	while (rq->hard_bio != rq->bio)
-		if (!DRIVER(drive)->end_request(drive, 1, bio_sectors(rq->hard_bio)))
+		if (!DRIVER(drive)->end_request(drive, 1, bio_sectors(rq->hard_bio))) {
+			if (rq->flags & REQ_DRIVE_TASKFILE)
+				ide_end_drive_cmd(drive, stat, HWIF(drive)->INB(IDE_ERROR_REG));
 			return ide_stopped;
+		}
 	/* Complete rq->buffer based request (ioctls). */
 	if (!rq->bio && !rq->nr_sectors) {
 		ide_end_drive_cmd(drive, stat, HWIF(drive)->INB(IDE_ERROR_REG));
@@ -476,8 +479,11 @@
 	 * Status was already verifyied.
 	 */
 	while (rq->hard_bio != rq->bio)
-		if (!DRIVER(drive)->end_request(drive, 1, bio_sectors(rq->hard_bio)))
+		if (!DRIVER(drive)->end_request(drive, 1, bio_sectors(rq->hard_bio))) {
+			if (rq->flags & REQ_DRIVE_TASKFILE)
+				ide_end_drive_cmd(drive, stat, HWIF(drive)->INB(IDE_ERROR_REG));
 			return ide_stopped;
+		}
 	/* Complete rq->buffer based request (ioctls). */
 	if (!rq->bio && !rq->nr_sectors) {
 		ide_end_drive_cmd(drive, stat, HWIF(drive)->INB(IDE_ERROR_REG));
@@ -549,8 +555,11 @@
 	 * Status was already verifyied.
 	 */
 	while (rq->hard_bio != rq->bio)
-		if (!DRIVER(drive)->end_request(drive, 1, bio_sectors(rq->hard_bio)))
+		if (!DRIVER(drive)->end_request(drive, 1, bio_sectors(rq->hard_bio))) {
+			if (rq->flags & REQ_DRIVE_TASKFILE)
+				ide_end_drive_cmd(drive, stat, HWIF(drive)->INB(IDE_ERROR_REG));
 			return ide_stopped;
+		}
 	/* Complete rq->buffer based request (ioctls). */
 	if (!rq->bio && !rq->nr_sectors) {
 		ide_end_drive_cmd(drive, stat, HWIF(drive)->INB(IDE_ERROR_REG));
@@ -618,8 +627,11 @@
 	 * Status was already verifyied.
 	 */
 	while (rq->hard_bio != rq->bio)
-		if (!DRIVER(drive)->end_request(drive, 1, bio_sectors(rq->hard_bio)))
+		if (!DRIVER(drive)->end_request(drive, 1, bio_sectors(rq->hard_bio))) {
+			if (rq->flags & REQ_DRIVE_TASKFILE)
+				ide_end_drive_cmd(drive, stat, HWIF(drive)->INB(IDE_ERROR_REG));
 			return ide_stopped;
+		}
 	/* Complete rq->buffer based request (ioctls). */
 	if (!rq->bio && !rq->nr_sectors) {
 		ide_end_drive_cmd(drive, stat, HWIF(drive)->INB(IDE_ERROR_REG));

