Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261773AbTEHQWN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 12:22:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261807AbTEHQWN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 12:22:13 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:4064 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261773AbTEHQWJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 12:22:09 -0400
Date: Thu, 8 May 2003 18:34:41 +0200
From: Jens Axboe <axboe@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5 ide 48-bit usage
Message-ID: <20030508163441.GG20941@suse.de>
References: <20030508161600.GE20941@suse.de> <Pine.LNX.4.44.0305080924400.2967-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0305080924400.2967-100000@home.transmeta.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 08 2003, Linus Torvalds wrote:
> 
> On Thu, 8 May 2003, Jens Axboe wrote:
> > 
> > Maybe a define or two would help here. When you see drive->addressing
> > and hwif->addressing, you assume that they are used identically. That
> > !hwif->addressing means 48-bit is ok, while !drive->addressing means
> > it's not does not help at all.
> 
> Why not just change the names? The current setup clearly is confusing, and
> adding defines doesn't much help. Rename the structure member so that the
> name says what it is, aka "address_mode", and when renaming it you'd go
> through the source anyway and change "!addressing" to something more
> readable like "address_mode == IDE_LBA48" or whatever.

Might not be a bad idea, drive->address_mode is a heck of a lot more to
the point. I'll do a swipe of this tomorrow, if no one beats me to it.

> (Anyway, I'll just drop all the 48-bit patches for now, since you've 
> totally confused me about which ones are right and what the bugs are ;)

I think we can all agree on the last one (attached again, it's short) is
ok. The 'only use 48-bit when needed' can wait until Bart gets the
taskfile infrastructure in place, until then I'll just have to eat the
overhead :)

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

