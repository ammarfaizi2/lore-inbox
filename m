Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266351AbUAGUEZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 15:04:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266352AbUAGUEZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 15:04:25 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.103]:46589 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S266351AbUAGUEQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 15:04:16 -0500
From: Kevin Corry <kevcorry@us.ibm.com>
To: linux-kernel <linux-kernel@vger.kernel.org>,
       DevMapper <dm-devel@sistina.com>
Subject: Re: [Bug 1806] New: disks stats not kept for DM (=?iso-8859-1?q?device	mapper?=) devices
Date: Wed, 7 Jan 2004 14:04:03 -0600
User-Agent: KMail/1.5
Cc: slpratt@us.ibm.com
References: <4340000.1073498494@[10.10.2.4]>
In-Reply-To: <4340000.1073498494@[10.10.2.4]>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401071404.04056.kevcorry@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> http://bugme.osdl.org/show_bug.cgi?id=1806
>
>            Summary: disks stats not kept for DM (device mapper) devices
>     Kernel Version: 2.6.0
>             Status: NEW
>           Severity: normal
>              Owner: axboe@suse.de
>          Submitter: slpratt@us.ibm.com
>
>
> Distribution:all
> Hardware Environment:all
> Software Environment:all
> Problem Description:
> Disk stats as reported through sysfs are empty for all DM (device mapper)
> devices.  This appears to be due to the fact that the stats are traced via
> request structs which are not generated until below the device mapper
> layer.  It seems it would be possible to add code to device mapper to track
> the stats since the actual location of the stats is in the gendisk entry
> which does exsist for DM deivices.  Only problem I see is in tracking ticks
> for IO since in the non DM case this is done by storing a start time in the
> request struct on driving the request.  Since DM has no request struct
> (only the BIO) it has no place to record the start time.
>
> Steps to reproduce:
> create a DM device using dmsetup, lvm2 or EVMS.  Do IO to device, look at
> /sys/block/dm-xxx/stat.

Steve and I noticed this behavior this morning. I poked around in ll_rw_blk.c 
and genhd.[ch] and some of the individual block drivers to get an idea for 
how I/O statistics are managed. I eventually came up with this patch for 
Device-Mapper.

Some things to note:

- In the lower-level drivers (IDE, SCIS, etc), statistics are calculated based 
on request structs. DM never uses/sees request structs, so these statistics 
are based on bio structs. Meaning...a "reads" count of 1 means DM completed 1 
bio, not 1 request.

- The statistics calculations are done when a bio is completed. As some brief 
background, when DM receives a bio, it holds on to that bio, and creates one 
or more clones (in case the original bio needs to be split across some 
internal DM boundary). DM manually submits each of those clones, and when all 
clones complete, DM completes the original bio. I've added the statistics 
calculations at this completion point. It could just as easily be done before 
the clones are submitted. I'm not sure if this is the desired behavior, but 
it seemed to be based on examining the other places where the statistics are 
updated. One side-effect of this decision is that an I/O that causes an error 
within DM may not show up at all in the statistics. E.g., if the DM device 
currently has no active mapping, DM will simply call bio_io_error() on that 
bio and thus never update the stats for the device - which may actually be 
the desired behavior.

- Device-Mapper doesn't do much of anything with the request_queue struct 
that's attached to its gendisk entry. However, all of the code that updates 
the I/O stats has comments that say the request_queue must be locked before 
the stats can be updated. So this patch allocates a spinlock for each DM 
request_queue, and this lock is taken while updating the stats. This 
introduces some new contention on DM's I/O completion path. I don't know yet 
whether it will be a significant amount.

I'm not sure if this is the best way to do this, but it's probably the 
simplest. On a related note, MD/Software-RAID also doesn't currently track 
I/O statistics. If we decide if/how to track statistics for DM, doing the 
same in MD ought to be pretty easy.

This patch is against 2.6.1-rc2. I also have a slightly different version for 
Joe's 2.6.0-udm3 patchset.

-- 
Kevin Corry
kevcorry@us.ibm.com
http://evms.sourceforge.net/



Update I/O statistics before completing the original, incoming bio.

--- a/drivers/md/dm.c	2004-01-07 13:53:55.000000000 -0600
+++ b/drivers/md/dm.c	2004-01-07 13:59:30.000000000 -0600
@@ -25,6 +25,7 @@
 	int error;
 	struct bio *bio;
 	atomic_t io_count;
+	unsigned long start_time;
 };
 
 struct deferred_io {
@@ -44,7 +45,7 @@
 
 	unsigned long flags;
 
-	request_queue_t *queue;
+	struct request_queue *queue;
 	struct gendisk *disk;
 
 	/*
@@ -243,6 +244,29 @@
 	return sector << SECTOR_SHIFT;
 }
 
+static inline void update_io_stats(struct dm_io *io)
+{
+	unsigned long flags;
+	unsigned long duration = jiffies - io->start_time;
+
+	spin_lock_irqsave(io->md->queue->queue_lock, flags);
+
+	switch (bio_data_dir(io->bio)) {
+	case READ:
+		disk_stat_inc(dm_disk(io->md), reads);
+		disk_stat_add(dm_disk(io->md), read_sectors, bio_sectors(io->bio));
+		disk_stat_add(dm_disk(io->md), read_ticks, duration);
+		break;
+	case WRITE:
+		disk_stat_inc(dm_disk(io->md), writes);
+		disk_stat_add(dm_disk(io->md), write_sectors, bio_sectors(io->bio));
+		disk_stat_add(dm_disk(io->md), write_ticks, duration);
+		break;
+	}
+
+	spin_unlock_irqrestore(io->md->queue->queue_lock, flags);
+}
+
 /*
  * Decrements the number of outstanding ios that a bio has been
  * cloned into, completing the original io if necc.
@@ -259,6 +283,8 @@
 	}
 
 	if (atomic_dec_and_test(&io->io_count)) {
+		update_io_stats(io);
+
 		if (atomic_dec_and_test(&io->md->pending))
 			/* nudge anyone waiting on suspend queue */
 			wake_up(&io->md->wait);
@@ -462,6 +488,7 @@
 	atomic_set(&ci.io->io_count, 1);
 	ci.io->bio = bio;
 	ci.io->md = md;
+	ci.io->start_time = jiffies;
 	ci.sector = bio->bi_sector;
 	ci.sector_count = bio_sectors(bio);
 	ci.idx = bio->bi_idx;
@@ -607,6 +634,14 @@
 		return NULL;
 	}
 
+	md->queue->queue_lock = kmalloc(sizeof(spinlock_t), GFP_KERNEL);
+	if (!md->queue->queue_lock) {
+		free_minor(minor);
+		blk_put_queue(md->queue);
+		kfree(md);
+		return NULL;
+	}
+
 	md->queue->queuedata = md;
 	blk_queue_make_request(md->queue, dm_request);
 
@@ -614,6 +649,7 @@
 				     mempool_free_slab, _io_cache);
 	if (!md->io_pool) {
 		free_minor(minor);
+		kfree(md->queue->queue_lock);
 		blk_put_queue(md->queue);
 		kfree(md);
 		return NULL;
@@ -623,6 +659,7 @@
 	if (!md->disk) {
 		mempool_destroy(md->io_pool);
 		free_minor(minor);
+		kfree(md->queue->queue_lock);
 		blk_put_queue(md->queue);
 		kfree(md);
 		return NULL;
@@ -649,6 +686,7 @@
 	mempool_destroy(md->io_pool);
 	del_gendisk(md->disk);
 	put_disk(md->disk);
+	kfree(md->queue->queue_lock);
 	blk_put_queue(md->queue);
 	kfree(md);
 }

