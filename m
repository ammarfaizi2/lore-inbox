Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261588AbTEMPrh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 11:47:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261624AbTEMPrh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 11:47:37 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:58594 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261588AbTEMPrb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 11:47:31 -0400
Date: Tue, 13 May 2003 18:00:15 +0200
From: Jens Axboe <axboe@suse.de>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: First part of getting ide-tcq in line...
Message-ID: <20030513160015.GD17033@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Adds blacklist check for drives, and refuses to enable tcq on a drive
that isn't alone on a channel.

It has been running 'beat me up' tests for half an hour now, lets see
if anything shows up. I'd very much like people with IDE TCQ experience
to mail me their results, both good and bad, so I can get a clear view
of what the problem might be.

===== drivers/ide/ide-probe.c 1.45 vs edited =====
--- 1.45/drivers/ide/ide-probe.c	Tue May 13 03:59:22 2003
+++ edited/drivers/ide/ide-probe.c	Tue May 13 17:27:08 2003
@@ -998,6 +998,7 @@
 static void ide_init_queue(ide_drive_t *drive)
 {
 	request_queue_t *q = &drive->queue;
+	ide_hwif_t *hwif = HWIF(drive);
 	int max_sectors = 256;
 
 	/*
@@ -1013,8 +1014,10 @@
 	drive->queue_setup = 1;
 	blk_queue_segment_boundary(q, 0xffff);
 
-	if (HWIF(drive)->rqsize)
-		max_sectors = HWIF(drive)->rqsize;
+	if (!hwif->rqsize)
+		hwif->rqsize = max_sectors;
+	if (hwif->rqsize < max_sectors)
+		max_sectors = hwif->rqsize;
 	blk_queue_max_sectors(q, max_sectors);
 
 	/* IDE DMA can do PRD_ENTRIES number of segments. */
===== drivers/ide/ide-tcq.c 1.4 vs edited =====
--- 1.4/drivers/ide/ide-tcq.c	Mon May 12 02:09:46 2003
+++ edited/drivers/ide/ide-tcq.c	Tue May 13 17:56:39 2003
@@ -51,9 +51,54 @@
  */
 #undef IDE_TCQ_FIDDLE_SI
 
+/*
+ * bad drive blacklist, for drives that raport tcq capability but don't
+ * work reliably with the default config. from freebsd.
+ */
+struct ide_tcq_blacklist {
+	char *model;
+	char works;
+	unsigned int max_sectors;
+};
+
+static struct ide_tcq_blacklist ide_tcq_blacklist[] = {
+	{
+		.model =	"IBM-DTTA",
+		.works =	1,
+		.max_sectors =	128,
+	},
+	{
+		.model =	"IBM-DJNA",
+		.works =	0,
+	},
+	{
+		.model =	NULL,
+	},
+};
+
 ide_startstop_t ide_dmaq_intr(ide_drive_t *drive);
 ide_startstop_t ide_service(ide_drive_t *drive);
 
+static struct ide_tcq_blacklist *ide_find_drive_blacklist(ide_drive_t *drive)
+{
+	struct ide_tcq_blacklist *itb;
+	int i = 0;
+
+	do {
+		itb = &ide_tcq_blacklist[i];
+
+		if (!itb->model)
+			break;
+
+		if (!strncmp(drive->id->model, itb->model, strlen(itb->model)))
+			return itb;
+
+		i++;
+	} while (1);
+
+	return NULL;
+}
+
 static inline void drive_ctl_nien(ide_drive_t *drive, int set)
 {
 #ifdef IDE_TCQ_NIEN
@@ -511,6 +556,7 @@
  */
 static int ide_enable_queued(ide_drive_t *drive, int on)
 {
+	struct ide_tcq_blacklist *itb;
 	int depth = drive->using_tcq ? drive->queue_depth : 0;
 
 	/*
@@ -530,6 +576,17 @@
 	}
 
 	/*
+	 * some drives need limited transfer size in tcq
+	 */
+	itb = ide_find_drive_blacklist(drive);
+	if (itb && itb->max_sectors) {
+		if (itb->max_sectors > HWIF(drive)->rqsize)
+			itb->max_sectors = HWIF(drive)->rqsize;
+
+		blk_queue_max_sectors(&drive->queue, itb->max_sectors);
+	}
+
+	/*
 	 * enable block tagging
 	 */
 	if (!blk_queue_tagged(&drive->queue))
@@ -582,10 +639,29 @@
 	return 0;
 }
 
+static int ide_tcq_check_blacklist(ide_drive_t *drive)
+{
+	struct ide_tcq_blacklist *itb = ide_find_drive_blacklist(drive);
+
+	if (!itb)
+		return 0;
+
+	return !itb->works;
+}
+
 int __ide_dma_queued_on(ide_drive_t *drive)
 {
 	if (!drive->using_dma)
 		return 1;
+	if (ide_tcq_check_blacklist(drive)) {
+		printk(KERN_WARNING "%s: tcq forbidden by blacklist\n", drive->name);
+		return 1;
+	}
+	if (drive->next) {
+		printk(KERN_WARNING "%s: only one drive on a channel supported"
+					" for tcq\n", drive->name);
+		return 1;
+	}
 
 	if (ata_pending_commands(drive)) {
 		printk(KERN_WARNING "ide-tcq; can't toggle tcq feature on busy drive\n");

-- 
Jens Axboe

