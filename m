Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264153AbUHaQvV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264153AbUHaQvV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 12:51:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264377AbUHaQvV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 12:51:21 -0400
Received: from mx1.redhat.com ([66.187.233.31]:19633 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S264153AbUHaQvQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 12:51:16 -0400
Date: Tue, 31 Aug 2004 12:50:46 -0400
From: Alan Cox <alan@redhat.com>
To: torvalds@osdl.org, axboe@suse.dk, linux-kernel@vger.kernel.org
Subject: PATCH: fix the barrier IDE detection logic
Message-ID: <20040831165046.GA6928@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes the logic so we always check for the cache. It also defaults
to safer behaviour for the non cache flush case now we have the right bits
in the right places. I've also played a bit with timings - the worst case
timings I can get for the flush are about 7 seconds (which I'd expect
as the engineering worst cases will include retries)

Probably what should happen is that the barrier logic is enabled providing
the wcache is disabled. I've not meddled with this as I don't know what
the intended semantics and rules are for disabling barrier on a live disk
(eg when a user uses hdparm to turn on the write cache). In the current
code as with Jens original that cannot occur.

I've also fixed the new printk's as per a private request from Matt Domsch.

This look right to you Jens ?

--- drivers/ide/ide-disk.c~	2004-08-31 17:35:01.065916488 +0100
+++ drivers/ide/ide-disk.c	2004-08-31 17:41:42.637868272 +0100
@@ -1298,7 +1298,7 @@
 	return 0;
 }
 
-static int write_cache (ide_drive_t *drive, int arg)
+static int write_cache(ide_drive_t *drive, int arg)
 {
 	ide_task_t args;
 	int err;
@@ -1508,7 +1508,7 @@
 		blk_queue_max_sectors(drive->queue, max_s);
 	}
 
-	printk("%s: max request size: %dKiB\n", drive->name, drive->queue->max_sectors / 2);
+	printk(KERN_INFO "%s: max request size: %dKiB\n", drive->name, drive->queue->max_sectors / 2);
 
 	/* Extract geometry if we did not already have one for the drive */
 	if (!drive->cyl || !drive->head || !drive->sect) {
@@ -1537,7 +1537,7 @@
 
 	/* limit drive capacity to 137GB if LBA48 cannot be used */
 	if (drive->addressing == 0 && drive->capacity64 > 1ULL << 28) {
-		printk("%s: cannot use LBA48 - full capacity "
+		printk(KERN_WARNING "%s: cannot use LBA48 - full capacity "
 		       "%llu sectors (%llu MB)\n",
 		       drive->name, (unsigned long long)drive->capacity64,
 		       sectors_to_MB(drive->capacity64));
@@ -1607,23 +1607,31 @@
 	if ((id->csfo & 1) || (id->cfs_enable_1 & (1 << 5)))
 		drive->wcache = 1;
 
-	write_cache(drive, 1);
-
 	/*
-	 * decide if we can sanely support flushes and barriers on
-	 * this drive. unfortunately not all drives advertise FLUSH_CACHE
-	 * support even if they support it. So assume FLUSH_CACHE is there
-	 * always. LBA48 drives are newer, so expect it to flag support
-	 * properly. We can safely support FLUSH_CACHE on lba48, if capacity
-	 * doesn't exceed lba28
+	 * We must avoid issuing commands a drive does not understand
+	 * or we may crash it. We check flush cache is supported. We also
+	 * check we have the LBA48 flush cache if the drive capacity is
+	 * too large. By this time we have trimmed the drive capacity if
+	 * LBA48 is not available so we don't need to recheck that.
 	 */
-	barrier = 1;
+	barrier = 0;
+	if (ide_id_has_flush_cache(id))
+		barrier = 1;
 	if (drive->addressing == 1) {
+		/* Can't issue the correct flush ? */
 		if (capacity > (1ULL << 28) && !ide_id_has_flush_cache_ext(id))
 			barrier = 0;
 	}
+	/* Now we have barrier awareness we can be properly conservative
+	   by default with other drives. We turn off write caching when
+	   barrier is not available. Users can adjust this at runtime if
+	   they need unsafe but fast filesystems. This will reduce the
+	   performance of non cache flush supporting disks but it means
+	   you get the data order guarantees the journalling fs's require */
+	   
+	write_cache(drive, barrier);
 
-	printk("%s: cache flushes %ssupported\n",
+	printk(KERN_DEBUG "%s: cache flushes %ssupported\n",
 		drive->name, barrier ? "" : "not ");
 	if (barrier) {
 		blk_queue_ordered(drive->queue, 1);
