Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262308AbTJNKQ2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Oct 2003 06:16:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262310AbTJNKQ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Oct 2003 06:16:27 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:46299 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262308AbTJNKP4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Oct 2003 06:15:56 -0400
Date: Tue, 14 Oct 2003 12:15:52 +0200
From: Jens Axboe <axboe@suse.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] ide barrier support, #2
Message-ID: <20031014101552.GJ1107@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Closer to a 100% working version. Changes:

- Corrected spelling of 'caching' (Troels Walsted Hansen)
- Use the proper buffer_head macros (Andrew Morton)
- Make q->ordered an int (Andrew Morton)
- Only enabled cache flush if write cache is enabled (me)
- Move flush setup to ide-disk (me)
- Implement error handling (me)
- Make jbd b_end_io clear buffer_ordered to get rid of reference
  problem (me)
- Fix raid1 compilation. SPECIAL has no real meaning since 2.5.1-pre,
  but raid1 was still using it. Add WRITESYNC for raid1. (me)

The big one is the error handling. If an error occurs during the
pre-flush, the barrier write is aborted. File system must take
appropriate action in that case. If an error occurs during the post
barrier flush, we successfully complete the good part and end the bad.
Again it's up to the fs to find out what to do with that info.

IDE write cache enabled/disable snooping is still missing.

===== drivers/block/ll_rw_blk.c 1.219 vs edited =====
--- 1.219/drivers/block/ll_rw_blk.c	Wed Oct  8 04:53:42 2003
+++ edited/drivers/block/ll_rw_blk.c	Tue Oct 14 12:13:23 2003
@@ -240,11 +240,40 @@
 	INIT_LIST_HEAD(&q->plug_list);
 
 	blk_queue_activity_fn(q, NULL, NULL);
+
+	q->ordered = QUEUE_ORDERED_NONE;
 }
 
 EXPORT_SYMBOL(blk_queue_make_request);
 
 /**
+ * blk_queue_ordered - does this queue support ordered writes
+ * @q:     the request queue
+ * @flag:  see below
+ *
+ * Description:
+ *   For journalled file systems, doing ordered writes on a commit
+ *   block instead of explicitly doing wait_on_buffer (which is bad
+ *   for performance) can be a big win. Block drivers supporting this
+ *   feature should call this function and indicate so.
+ *
+ *   SCSI drivers usually need to support ordered tags, while others
+ *   may have to do a complete drive cache flush if they are using write
+ *   back caching (or not and lying about it)
+ *
+ *   With this in mind, the values are
+ *             QUEUE_ORDERED_NONE:	the default, doesn't support barrier
+ *             QUEUE_ORDERED_TAG:	supports ordered tags
+ *             QUEUE_ORDERED_FLUSH:	supports barrier through cache flush
+ **/
+void blk_queue_ordered(request_queue_t *q, int flag)
+{
+	q->ordered = flag;
+}
+
+EXPORT_SYMBOL(blk_queue_ordered);
+
+/**
  * blk_queue_bounce_limit - set bounce buffer limit for queue
  * @q:  the request queue for the device
  * @dma_addr:   bus address limit
@@ -1820,6 +1849,8 @@
 
 	if (unlikely(!q))
 		return;
+
+	WARN_ON(!req->ref_count);
 	if (unlikely(--req->ref_count))
 		return;
 
@@ -1986,7 +2017,7 @@
 static int __make_request(request_queue_t *q, struct bio *bio)
 {
 	struct request *req, *freereq = NULL;
-	int el_ret, rw, nr_sectors, cur_nr_sectors, barrier, ra;
+	int el_ret, rw, nr_sectors, cur_nr_sectors, barrier, ra, err;
 	sector_t sector;
 
 	sector = bio->bi_sector;
@@ -2004,7 +2035,11 @@
 
 	spin_lock_prefetch(q->queue_lock);
 
-	barrier = test_bit(BIO_RW_BARRIER, &bio->bi_rw);
+	barrier = bio_barrier(bio);
+	if (barrier && (q->ordered == QUEUE_ORDERED_NONE)) {
+		err = -EOPNOTSUPP;
+		goto end_io;
+	}
 
 	ra = bio->bi_rw & (1 << BIO_RW_AHEAD);
 
@@ -2086,6 +2121,7 @@
 			/*
 			 * READA bit set
 			 */
+			err = -EWOULDBLOCK;
 			if (ra)
 				goto end_io;
 	
@@ -2141,7 +2177,7 @@
 	return 0;
 
 end_io:
-	bio_endio(bio, nr_sectors << 9, -EWOULDBLOCK);
+	bio_endio(bio, nr_sectors << 9, err);
 	return 0;
 }
 
===== drivers/ide/ide-disk.c 1.62 vs edited =====
--- 1.62/drivers/ide/ide-disk.c	Fri Sep  5 14:36:36 2003
+++ edited/drivers/ide/ide-disk.c	Tue Oct 14 12:14:37 2003
@@ -1688,6 +1688,12 @@
 	if (drive->id->cfs_enable_2 & 0x3000)
 		write_cache(drive, (id->cfs_enable_2 & 0x3000));
 
+	drive->wcache = drive->id->cfs_enable_1 & 0x20;
+	if (drive->wcache) {
+		printk("%s: write cache enabled\n", drive->name);
+		blk_queue_ordered(drive->queue, QUEUE_ORDERED_FLUSH);
+	}
+
 #ifdef CONFIG_BLK_DEV_IDE_TCQ_DEFAULT
 	if (drive->using_dma)
 		HWIF(drive)->ide_dma_queued_on(drive);
@@ -1755,7 +1761,7 @@
 		drive->wcache = 0;
 		/* Cache enabled ? */
 		if (drive->id->csfo & 1)
-		drive->wcache = 1;
+			drive->wcache = 1;
 		/* Cache command set available ? */
 		if (drive->id->cfs_enable_1 & (1<<5))
 			drive->wcache = 1;
===== drivers/ide/ide-io.c 1.20 vs edited =====
--- 1.20/drivers/ide/ide-io.c	Tue Sep  9 20:31:23 2003
+++ edited/drivers/ide/ide-io.c	Tue Oct 14 12:03:07 2003
@@ -85,30 +85,54 @@
 #endif /* DISK_RECOVERY_TIME */
 }
 
-/**
- *	ide_end_request		-	complete an IDE I/O
- *	@drive: IDE device for the I/O
- *	@uptodate: 
- *	@nr_sectors: number of sectors completed
- *
- *	This is our end_request wrapper function. We complete the I/O
- *	update random number input and dequeue the request, which if
- *	it was tagged may be out of order.
+/*
+ * preempt pending requests, and store this cache flush for immediate
+ * execution
  */
- 
-int ide_end_request (ide_drive_t *drive, int uptodate, int nr_sectors)
+static struct request *ide_queue_flush_cmd(ide_drive_t *drive,
+					   struct request *rq, int post)
 {
-	struct request *rq;
-	unsigned long flags;
-	int ret = 1;
+	struct request *flush_rq = &HWGROUP(drive)->wrq;
 
-	spin_lock_irqsave(&ide_lock, flags);
-	rq = HWGROUP(drive)->rq;
+	/*
+	 * write cache disabled, just return barrier write immediately
+	 */
+	if (!drive->wcache)
+		return rq;
 
-	BUG_ON(!(rq->flags & REQ_STARTED));
+	blkdev_dequeue_request(rq);
 
-	if (!nr_sectors)
-		nr_sectors = rq->hard_cur_sectors;
+	memset(drive->special_buf, 0, sizeof(drive->special_buf));
+
+	ide_init_drive_cmd(flush_rq);
+
+	flush_rq->flags = REQ_DRIVE_TASK;
+	flush_rq->buffer = drive->special_buf;
+	flush_rq->special = rq;
+	flush_rq->buffer[0] = WIN_FLUSH_CACHE;
+	flush_rq->nr_sectors = rq->nr_sectors;
+
+	if (drive->id->cfs_enable_2 & 0x2400)
+		flush_rq->buffer[0] = WIN_FLUSH_CACHE_EXT;
+
+	if (!post) {
+		drive->doing_barrier = 1;
+		flush_rq->flags |= REQ_BAR_PREFLUSH;
+	} else
+		flush_rq->flags |= REQ_BAR_POSTFLUSH;
+
+	flush_rq->flags |= REQ_STARTED;
+	list_add(&flush_rq->queuelist, &drive->queue->queue_head);
+	HWGROUP(drive)->rq = NULL;
+	return flush_rq;
+}
+
+static int __ide_end_request(ide_drive_t *drive, struct request *rq,
+			     int uptodate, int nr_sectors)
+{
+	int ret = 1;
+
+	BUG_ON(!(rq->flags & REQ_STARTED));
 
 	/*
 	 * if failfast is set on a request, override number of sectors and
@@ -128,14 +152,55 @@
 
 	if (!end_that_request_first(rq, uptodate, nr_sectors)) {
 		add_disk_randomness(rq->rq_disk);
-		if (!blk_rq_tagged(rq))
-			blkdev_dequeue_request(rq);
-		else
+
+		if (blk_rq_tagged(rq))
 			blk_queue_end_tag(drive->queue, rq);
-		HWGROUP(drive)->rq = NULL;
+		else if (!blk_barrier_rq(rq))
+			blkdev_dequeue_request(rq);
+
 		end_that_request_last(rq);
+		HWGROUP(drive)->rq = NULL;
 		ret = 0;
 	}
+
+	return ret;
+}
+
+/**
+ *	ide_end_request		-	complete an IDE I/O
+ *	@drive: IDE device for the I/O
+ *	@uptodate: 
+ *	@nr_sectors: number of sectors completed
+ *
+ *	This is our end_request wrapper function. We complete the I/O
+ *	update random number input and dequeue the request, which if
+ *	it was tagged may be out of order.
+ */
+ 
+int ide_end_request (ide_drive_t *drive, int uptodate, int nr_sectors)
+{
+	struct request *rq;
+	unsigned long flags;
+	int ret = 1;
+
+	spin_lock_irqsave(&ide_lock, flags);
+	rq = HWGROUP(drive)->rq;
+
+	if (!nr_sectors)
+		nr_sectors = rq->hard_cur_sectors;
+
+	if (!blk_barrier_rq(rq))
+		ret = __ide_end_request(drive, rq, uptodate, nr_sectors);
+	else {
+		struct request *flush_rq = &HWGROUP(drive)->wrq;
+
+		flush_rq->nr_sectors -= nr_sectors;
+		if (!flush_rq->nr_sectors) {
+			ide_queue_flush_cmd(drive, rq, 1);
+			ret = 0;
+		}
+	}
+
 	spin_unlock_irqrestore(&ide_lock, flags);
 	return ret;
 }
@@ -171,6 +236,92 @@
 	spin_unlock_irqrestore(&ide_lock, flags);
 }
 
+/*
+ * FIXME: probably move this somewhere else, name is bad too :)
+ */
+static sector_t ide_get_error_location(ide_drive_t *drive, char *args)
+{
+	u32 high, low;
+	u8 hcyl, lcyl, sect;
+	sector_t sector;
+
+	high = 0;
+	hcyl = args[5];
+	lcyl = args[4];
+	sect = args[3];
+	
+	if (drive->id->cfs_enable_2 & 0x2400) {
+		low = (hcyl << 16) | (lcyl << 8) | sect;
+		HWIF(drive)->OUTB(drive->ctl|0x80, IDE_CONTROL_REG);
+		high = ide_read_24(drive);
+	} else {
+		u8 cur = HWIF(drive)->INB(IDE_SELECT_REG);
+		if (cur & 0x40)
+			low = (hcyl << 16) | (lcyl << 8) | sect;
+		else {
+			low = hcyl * drive->head * drive->sect;
+			low += lcyl * drive->sect;
+			low += sect - 1;
+		}
+	}
+
+	sector = ((sector_t) high << 24) | low;
+	return sector;
+}
+
+static void ide_complete_barrier(ide_drive_t *drive, struct request *rq,
+				 int error)
+{
+	struct request *real_rq = rq->special;
+	int good_sectors, bad_sectors;
+	sector_t sector;
+
+	if (!error) {
+		if (blk_barrier_postflush(rq)) {
+			/*
+			 * this completes the barrier write
+			 */
+			__ide_end_request(drive, real_rq, 1, real_rq->hard_nr_sectors);
+			drive->doing_barrier = 0;
+		} else {
+			/*
+			 * just indicate that we did the pre flush
+			 */
+			real_rq->flags |= REQ_BAR_PREFLUSH;
+			__elv_add_request(drive->queue, real_rq, ELEVATOR_INSERT_FRONT, 0);
+		}
+
+		/*
+		 * all is fine, return
+		 */
+		return;
+	}
+
+	/*
+	 * bummer, flush failed. if it was the pre-flush, fail the barrier.
+	 * if it was the post-flush, complete the succesful part of the request
+	 * and fail the rest
+	 */
+	good_sectors = 0;
+	if (blk_barrier_postflush(rq)) {
+		sector = ide_get_error_location(drive, rq->buffer);
+
+		if ((sector >= real_rq->hard_sector) &&
+		    (sector < real_rq->hard_sector + real_rq->hard_nr_sectors))
+			good_sectors = sector - real_rq->hard_sector;
+	} else
+		sector = real_rq->hard_sector;
+
+	bad_sectors = real_rq->hard_nr_sectors - good_sectors;
+	if (good_sectors)
+		__ide_end_request(drive, real_rq, 1, good_sectors);
+	if (bad_sectors)
+		__ide_end_request(drive, real_rq, 0, bad_sectors);
+
+	printk(KERN_ERR "%s: failed barrier write: sector=%Lx(good=%d/bad=%d)\n", drive->name, sector, good_sectors, bad_sectors);
+	blk_queue_ordered(drive->queue, QUEUE_ORDERED_NONE);
+}
+
 /**
  *	ide_end_drive_cmd	-	end an explicit drive command
  *	@drive: command 
@@ -260,6 +411,10 @@
 
 	spin_lock_irqsave(&ide_lock, flags);
 	blkdev_dequeue_request(rq);
+
+	if (blk_barrier_preflush(rq) || blk_barrier_postflush(rq))
+		ide_complete_barrier(drive, rq, err);
+
 	HWGROUP(drive)->rq = NULL;
 	end_that_request_last(rq);
 	spin_unlock_irqrestore(&ide_lock, flags);
@@ -752,6 +907,15 @@
 repeat:	
 	best = NULL;
 	drive = hwgroup->drive;
+
+	/*
+	 * drive is doing pre-flush, ordered write, post-flush sequence. even
+	 * though that is 3 requests, it must be seen as a single transaction.
+	 * we must not preempt this drive until that is complete
+	 */
+	if (drive->doing_barrier)
+		return drive;
+
 	do {
 		if ((!drive->sleep || time_after_eq(jiffies, drive->sleep))
 		    && !elv_queue_empty(drive->queue)) {
@@ -919,6 +1083,13 @@
 		}
 
 		/*
+		 * if rq is a barrier write, issue pre cache flush if not
+		 * already done
+		 */
+		if (blk_barrier_rq(rq) && !blk_barrier_preflush(rq))
+			rq = ide_queue_flush_cmd(drive, rq, 0);
+
+		/*
 		 * Sanity: don't accept a request that isn't a PM request
 		 * if we are currently power managed. This is very important as
 		 * blk_stop_queue() doesn't prevent the elv_next_request()
@@ -937,6 +1108,10 @@
 			break;
 		}
 
+		/*
+		 * we can only queue read-write requests, so let the drive
+		 * queue drain before continuing with this command.
+		 */
 		if (!rq->bio && ata_pending_commands(drive))
 			break;
 
@@ -1344,6 +1519,7 @@
 {
 	memset(rq, 0, sizeof(*rq));
 	rq->flags = REQ_DRIVE_CMD;
+	rq->ref_count = 1;
 }
 
 EXPORT_SYMBOL(ide_init_drive_cmd);
===== drivers/md/raid1.c 1.72 vs edited =====
--- 1.72/drivers/md/raid1.c	Tue Sep 23 01:12:05 2003
+++ edited/drivers/md/raid1.c	Tue Oct 14 08:44:51 2003
@@ -879,7 +879,7 @@
 		conf = mddev_to_conf(mddev);
 		bio = r1_bio->master_bio;
 		switch(r1_bio->cmd) {
-		case SPECIAL:
+		case WRITESYNC:
 			sync_request_write(mddev, r1_bio);
 			break;
 		case READ:
@@ -989,7 +989,7 @@
 
 	r1_bio->mddev = mddev;
 	r1_bio->sector = sector_nr;
-	r1_bio->cmd = SPECIAL;
+	r1_bio->cmd = WRITESYNC;
 	r1_bio->read_disk = disk;
 
 	bio = r1_bio->master_bio;
===== fs/buffer.c 1.215 vs edited =====
--- 1.215/fs/buffer.c	Tue Sep 30 03:12:02 2003
+++ edited/fs/buffer.c	Tue Oct 14 10:16:02 2003
@@ -2665,6 +2665,9 @@
 	if (rw == READ && buffer_dirty(bh))
 		buffer_error();
 
+	if (buffer_ordered(bh) && (rw == WRITE))
+		rw = WRITEBARRIER;
+
 	/* Only clear out a write error when rewriting */
 	if (test_set_buffer_req(bh) && rw == WRITE)
 		clear_buffer_write_io_error(bh);
===== fs/jbd/commit.c 1.40 vs edited =====
--- 1.40/fs/jbd/commit.c	Fri Aug  1 12:02:20 2003
+++ edited/fs/jbd/commit.c	Tue Oct 14 08:51:50 2003
@@ -32,6 +32,7 @@
 		set_buffer_uptodate(bh);
 	else
 		clear_buffer_uptodate(bh);
+	clear_buffer_ordered(bh);
 	unlock_buffer(bh);
 }
 
@@ -474,6 +475,7 @@
 				clear_buffer_dirty(bh);
 				set_buffer_uptodate(bh);
 				bh->b_end_io = journal_end_buffer_io_sync;
+				set_buffer_ordered(bh);
 				submit_bh(WRITE, bh);
 			}
 			cond_resched();
===== include/linux/blkdev.h 1.127 vs edited =====
--- 1.127/include/linux/blkdev.h	Tue Sep 16 13:57:26 2003
+++ edited/include/linux/blkdev.h	Tue Oct 14 12:12:48 2003
@@ -193,6 +193,8 @@
 	__REQ_PM_SUSPEND,	/* suspend request */
 	__REQ_PM_RESUME,	/* resume request */
 	__REQ_PM_SHUTDOWN,	/* shutdown request */
+	__REQ_BAR_PREFLUSH,	/* barrier pre-flush done */
+	__REQ_BAR_POSTFLUSH,	/* barrier post-flush */
 	__REQ_NR_BITS,		/* stops here */
 };
 
@@ -218,6 +220,8 @@
 #define REQ_PM_SUSPEND	(1 << __REQ_PM_SUSPEND)
 #define REQ_PM_RESUME	(1 << __REQ_PM_RESUME)
 #define REQ_PM_SHUTDOWN	(1 << __REQ_PM_SHUTDOWN)
+#define REQ_BAR_PREFLUSH	(1 << __REQ_BAR_PREFLUSH)
+#define REQ_BAR_POSTFLUSH	(1 << __REQ_BAR_POSTFLUSH)
 
 /*
  * State information carried for REQ_PM_SUSPEND and REQ_PM_RESUME
@@ -344,6 +348,8 @@
 	unsigned long		seg_boundary_mask;
 	unsigned int		dma_alignment;
 
+	unsigned int		ordered;
+
 	struct blk_queue_tag	*queue_tags;
 
 	atomic_t		refcnt;
@@ -368,6 +374,13 @@
 #define QUEUE_FLAG_WRITEFULL	4	/* read queue has been filled */
 #define QUEUE_FLAG_DEAD		5	/* queue being torn down */
 
+/*
+ * write barrier support
+ */
+#define QUEUE_ORDERED_NONE	0	/* no support */
+#define QUEUE_ORDERED_TAG	1	/* supported by tags */
+#define QUEUE_ORDERED_FLUSH	2	/* supported by cache flush */
+
 #define blk_queue_plugged(q)	!list_empty(&(q)->plug_list)
 #define blk_queue_tagged(q)	test_bit(QUEUE_FLAG_QUEUED, &(q)->queue_flags)
 #define blk_fs_request(rq)	((rq)->flags & REQ_CMD)
@@ -379,6 +392,10 @@
 #define blk_pm_request(rq)	\
 	((rq)->flags & (REQ_PM_SUSPEND | REQ_PM_RESUME))
 
+#define blk_barrier_rq(rq)	((rq)->flags & REQ_HARDBARRIER)
+#define blk_barrier_preflush(rq)	((rq)->flags & REQ_BAR_PREFLUSH)
+#define blk_barrier_postflush(rq)	((rq)->flags & REQ_BAR_POSTFLUSH)
+
 #define list_entry_rq(ptr)	list_entry((ptr), struct request, queuelist)
 
 #define rq_data_dir(rq)		((rq)->flags & 1)
@@ -561,6 +578,7 @@
 extern void blk_queue_merge_bvec(request_queue_t *, merge_bvec_fn *);
 extern void blk_queue_dma_alignment(request_queue_t *, int);
 extern struct backing_dev_info *blk_get_backing_dev_info(struct block_device *bdev);
+extern void blk_queue_ordered(request_queue_t *, int);
 
 extern int blk_rq_map_sg(request_queue_t *, struct request *, struct scatterlist *);
 extern void blk_dump_rq_flags(struct request *, char *);
===== include/linux/buffer_head.h 1.44 vs edited =====
--- 1.44/include/linux/buffer_head.h	Tue Aug 19 07:30:30 2003
+++ edited/include/linux/buffer_head.h	Tue Oct 14 08:52:16 2003
@@ -26,6 +26,7 @@
 	BH_Delay,	/* Buffer is not yet allocated on disk */
 	BH_Boundary,	/* Block is followed by a discontiguity */
 	BH_Write_EIO,	/* I/O error on write */
+	BH_Ordered,	/* ordered write */
 
 	BH_PrivateStart,/* not a state bit, but the first bit available
 			 * for private allocation by other entities
@@ -117,7 +118,8 @@
 BUFFER_FNS(Async_Write, async_write)
 BUFFER_FNS(Delay, delay)
 BUFFER_FNS(Boundary, boundary)
-BUFFER_FNS(Write_EIO,write_io_error)
+BUFFER_FNS(Write_EIO, write_io_error)
+BUFFER_FNS(Ordered, ordered)
 
 #define bh_offset(bh)		((unsigned long)(bh)->b_data & ~PAGE_MASK)
 #define touch_buffer(bh)	mark_page_accessed(bh->b_page)
===== include/linux/fs.h 1.274 vs edited =====
--- 1.274/include/linux/fs.h	Tue Sep 23 06:16:30 2003
+++ edited/include/linux/fs.h	Tue Oct 14 08:44:34 2003
@@ -81,7 +81,8 @@
 #define READ 0
 #define WRITE 1
 #define READA 2		/* read-ahead  - don't block if no resources */
-#define SPECIAL 4	/* For non-blockdevice requests in request queue */
+#define WRITESYNC 4
+#define WRITEBARRIER	5	/* 1st bit, write, 3rd barrier */
 
 #define SEL_IN		1
 #define SEL_OUT		2
===== include/linux/ide.h 1.75 vs edited =====
--- 1.75/include/linux/ide.h	Sat Sep  6 17:21:14 2003
+++ edited/include/linux/ide.h	Tue Oct 14 09:10:19 2003
@@ -728,6 +728,7 @@
 	unsigned ata_flash	: 1;	/* 1=present, 0=default */
 	unsigned blocked        : 1;	/* 1=powermanagment told us not to do anything, so sleep nicely */
 	unsigned vdma		: 1;	/* 1=doing PIO over DMA 0=doing normal DMA */
+	unsigned doing_barrier	: 1;	/* state, 1=currently doing flush */
 	unsigned addressing;		/*      : 3;
 					 *  0=28-bit
 					 *  1=48-bit
@@ -773,6 +774,7 @@
 	int		forced_lun;	/* if hdxlun was given at boot */
 	int		lun;		/* logical unit */
 	int		crc_count;	/* crc counter to reduce drive speed */
+	char		special_buf[8];	/* private command buffer */
 	struct list_head list;
 	struct device	gendev;
 	struct semaphore gendev_rel_sem;	/* to deal with device release() */

-- 
Jens Axboe

