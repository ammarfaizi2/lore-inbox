Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268660AbUHaOXz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268660AbUHaOXz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 10:23:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268408AbUHaOXz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 10:23:55 -0400
Received: from mx1.redhat.com ([66.187.233.31]:51909 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S268660AbUHaOXw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 10:23:52 -0400
Date: Tue, 31 Aug 2004 10:23:35 -0400
From: Alan Cox <alan@redhat.com>
To: torvalds@osdl.org, linux-kernel@vger.kernel.org, axboe@suse.dk
Subject: Nasty IDE crasher in 2.6.9rc1
Message-ID: <20040831142335.GA15841@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You never never issue unknown commands to drives. Thats how Mandrake destroyed 
CD-ROM drives. I knew this was in -mm and supposed to be getting sorted I was
somewhat horrified to find it in 2.6.9rc1.

This patch crashes two of my CF cards (one so badly you have to reformat it
to get it back) and anything attached to an IT8212 controller. The correct
fix is to do what the standard actually says and always check for cache
flush. Contrary to the comment in the patch drives do report this correctly
its just that some of them nop unknown commands.

Please fix this patch segment for rc2, its not just wrong, its dangerous.

Another problem with barrier is that it can take several minutes worst case
for the command to complete on a large modern drive (timings c/o friendly
ide drive engineer). That causes two problems I've pointed out to Jens that
we need to fix before barriers are IMHO production grade

1.	Anything based on fairness and latency is screwed. Throughput 
	apparently is up so it makes sense for some users, and probably
	for others we should write cache off as Jens suggested.

2.	The timeouts on the command issue appear to be too small, and
	we will time out and reset the drive in loaded situations. 

Thankfully next generation ATA has both cache bypass writes and tagging.

diff -Nru a/drivers/ide/ide-disk.c b/drivers/ide/ide-disk.c
--- a/drivers/ide/ide-disk.c	2004-08-24 00:04:06 -07:00
+++ b/drivers/ide/ide-disk.c	2004-08-24 00:04:06 -07:00
@@ -1543,6 +1608,27 @@
 		drive->wcache = 1;
 
 	write_cache(drive, 1);
+
+	/*
+	 * decide if we can sanely support flushes and barriers on
+	 * this drive. unfortunately not all drives advertise FLUSH_CACHE
+	 * support even if they support it. So assume FLUSH_CACHE is there
+	 * always. LBA48 drives are newer, so expect it to flag support
+	 * properly. We can safely support FLUSH_CACHE on lba48, if capacity
+	 * doesn't exceed lba28
+	 */
+	barrier = 1;
+	if (drive->addressing == 1) {
+		if (capacity > (1ULL << 28) && !ide_id_has_flush_cache_ext(id))
+			barrier = 0;
+	}
+
+	printk("%s: cache flushes %ssupported\n",
+		drive->name, barrier ? "" : "not ");
+	if (barrier) {
+		blk_queue_ordered(drive->queue, 1);
+		blk_queue_issue_flush_fn(drive->queue, idedisk_issue_flush);
+	}
 }
 
 static void ide_cacheflush_p(ide_drive_t *drive)
