Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261603AbTEHOek (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 10:34:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261618AbTEHOek
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 10:34:40 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:57275 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261603AbTEHOeg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 10:34:36 -0400
Date: Thu, 8 May 2003 16:47:12 +0200
From: Jens Axboe <axboe@suse.de>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5 ide 48-bit usage
Message-ID: <20030508144712.GB20941@suse.de>
References: <20030508132314.GZ823@suse.de> <Pine.SOL.4.30.0305081532170.12362-100000@mion.elka.pw.edu.pl> <20030508133702.GC823@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030508133702.GC823@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 08 2003, Jens Axboe wrote:
> > > Ditto, cannot be reliable without the taskfile changes.
> > >
> > > I won't bother with anything new until the taskfile stuff is in.
> > 
> > Good decision.
> 
> So what's the time frame on that?

And the more important question, how are you creating the taskfile? If
it's reachable from end_io context (and not just the submission path),
which it must be to solve the problem was are discussing here, then
surely it's not from the stack.

BTW, how about a minor compromise. See attached patch, I'd be happy with
that for now. It _is_ essentially two seperate issues, right? One is
getting good request sizes on 48-bit commands, the other is taking some
decent advantage of 48-bit commands.

diff -Nru a/drivers/ide/ide-disk.c b/drivers/ide/ide-disk.c
--- a/drivers/ide/ide-disk.c	Thu May  8 14:32:59 2003
+++ b/drivers/ide/ide-disk.c	Thu May  8 14:32:59 2003
@@ -1479,7 +1483,7 @@
 
 static int set_lba_addressing (ide_drive_t *drive, int arg)
 {
-	return (probe_lba_addressing(drive, arg));
+	return probe_lba_addressing(drive, arg);
 }
 
 static void idedisk_add_settings(ide_drive_t *drive)
@@ -1565,6 +1569,18 @@
 	}
 
 	(void) probe_lba_addressing(drive, 1);
+
+	if (drive->addressing == 1) {
+		ide_hwif_t *hwif = HWIF(drive);
+		int max_s = 2048;
+
+		if (max_s > hwif->rqsize)
+			max_s = hwif->rqsize;
+
+		blk_queue_max_sectors(&drive->queue, max_s);
+	}
+
+	printk("%s: max request size: %dKiB\n", drive->name, drive->queue.max_sectors / 2);
 
 	/* Extract geometry if we did not already have one for the drive */
 	if (!drive->cyl || !drive->head || !drive->sect) {
diff -Nru a/drivers/ide/ide-probe.c b/drivers/ide/ide-probe.c
--- a/drivers/ide/ide-probe.c	Thu May  8 14:32:59 2003
+++ b/drivers/ide/ide-probe.c	Thu May  8 14:32:59 2003
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
+		hwif->rqsize = hwif->addressing ? 256 : 65536;
+	if (hwif->rqsize < max_sectors)
+		max_sectors = hwif->rqsize;
 	blk_queue_max_sectors(q, max_sectors);
 
 	/* IDE DMA can do PRD_ENTRIES number of segments. */

-- 
Jens Axboe

