Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261760AbTJMOJi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Oct 2003 10:09:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261773AbTJMOJi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Oct 2003 10:09:38 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:22460 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261760AbTJMOJE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Oct 2003 10:09:04 -0400
Date: Mon, 13 Oct 2003 16:08:58 +0200
From: Jens Axboe <axboe@suse.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] ide write barrier support
Message-ID: <20031013140858.GU1107@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Forward ported and tested today (with the dummy ext3 patch included),
works for me. Some todo's left, but I thought I'd send it out to gauge
interest. TODO:

- Detect write cache setting and only issue SYNC_CACHE if write cache is
  enabled (not a biggy, all drives ship with it enabled)

- Toggle flush support on hdparm -W0/1

- Various small bits I can't remember right now

===== drivers/block/ll_rw_blk.c 1.219 vs edited =====
--- 1.219/drivers/block/ll_rw_blk.c	Wed Oct  8 04:53:42 2003
+++ edited/drivers/block/ll_rw_blk.c	Mon Oct 13 14:28:51 2003
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
@@ -2005,6 +2036,10 @@
 	spin_lock_prefetch(q->queue_lock);
 
 	barrier = test_bit(BIO_RW_BARRIER, &bio->bi_rw);
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
 
===== drivers/ide/ide-io.c 1.20 vs edited =====
--- 1.20/drivers/ide/ide-io.c	Tue Sep  9 20:31:23 2003
+++ edited/drivers/ide/ide-io.c	Mon Oct 13 15:37:24 2003
@@ -85,6 +85,39 @@
 #endif /* DISK_RECOVERY_TIME */
 }
 
+/*
+ * preempt pending requests, and store this cache flush for immediate
+ * execution
+ */
+static struct request *ide_queue_flush_cmd(ide_drive_t *drive,
+					   struct request *rq, int post)
+{
+	struct request *flush_rq = &HWGROUP(drive)->wrq;
+
+	blkdev_dequeue_request(rq);
+
+	memset(drive->special_buf, 0, sizeof(drive->special_buf));
+
+	ide_init_drive_cmd(flush_rq);
+
+	flush_rq->buffer = drive->special_buf;
+	flush_rq->special = rq;
+	flush_rq->buffer[0] = WIN_FLUSH_CACHE;
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
+	return flush_rq;
+}
+
 /**
  *	ide_end_request		-	complete an IDE I/O
  *	@drive: IDE device for the I/O
@@ -128,12 +161,23 @@
 
 	if (!end_that_request_first(rq, uptodate, nr_sectors)) {
 		add_disk_randomness(rq->rq_disk);
-		if (!blk_rq_tagged(rq))
-			blkdev_dequeue_request(rq);
-		else
-			blk_queue_end_tag(drive->queue, rq);
+
+		/*
+		 * if this is a barrier write, flush the write cache
+		 * before signalling completion of this request
+		 */
+		if (blk_barrier_rq(rq))
+			ide_queue_flush_cmd(drive, rq, 1);
+		else {
+			if (!blk_rq_tagged(rq))
+				blkdev_dequeue_request(rq);
+			else
+				blk_queue_end_tag(drive->queue, rq);
+
+			end_that_request_last(rq);
+		}
+
 		HWGROUP(drive)->rq = NULL;
-		end_that_request_last(rq);
 		ret = 0;
 	}
 	spin_unlock_irqrestore(&ide_lock, flags);
@@ -260,6 +304,36 @@
 
 	spin_lock_irqsave(&ide_lock, flags);
 	blkdev_dequeue_request(rq);
+
+	/*
+	 * if a cache flush fails, disable ordered write support
+	 */
+	if (blk_barrier_preflush(rq) || blk_barrier_postflush(rq)) {
+		struct request *real_rq = rq->special;
+
+		/*
+		 * should we forcibly disable the write back caching?
+		 */
+		if (err) {
+			printk("%s: cache flushing failed. disable write back cacheing for journalled file systems\n", drive->name);
+			blk_queue_ordered(drive->queue, QUEUE_ORDERED_NONE);
+		}
+
+		if (blk_barrier_postflush(rq)) {
+			/*
+			 * this completes the barrier write
+			 */
+			drive->doing_barrier = 0;
+			end_that_request_last(real_rq);
+		} else {
+			/*
+			 * just indicate that we did the pre flush
+			 */
+			real_rq->flags |= REQ_BAR_PREFLUSH;
+			__elv_add_request(drive->queue, real_rq, ELEVATOR_INSERT_FRONT, 0);
+		}
+	}
+
 	HWGROUP(drive)->rq = NULL;
 	end_that_request_last(rq);
 	spin_unlock_irqrestore(&ide_lock, flags);
@@ -752,6 +826,15 @@
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
@@ -919,6 +1002,13 @@
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
@@ -1344,6 +1434,7 @@
 {
 	memset(rq, 0, sizeof(*rq));
 	rq->flags = REQ_DRIVE_CMD;
+	rq->ref_count = 1;
 }
 
 EXPORT_SYMBOL(ide_init_drive_cmd);
===== drivers/ide/ide-probe.c 1.65 vs edited =====
--- 1.65/drivers/ide/ide-probe.c	Wed Sep  3 18:52:16 2003
+++ edited/drivers/ide/ide-probe.c	Mon Oct 13 09:55:02 2003
@@ -958,9 +958,14 @@
 	/* needs drive->queue to be set */
 	ide_toggle_bounce(drive, 1);
 
-	/* enable led activity for disk drives only */
-	if (drive->media == ide_disk && hwif->led_act)
-		blk_queue_activity_fn(q, hwif->led_act, drive);
+	if (drive->media == ide_disk) {
+		/* enable led activity for disk drives only */
+		if (hwif->led_act)
+			blk_queue_activity_fn(q, hwif->led_act, drive);
+
+		/* flush cache for ordered writes */
+		blk_queue_ordered(q, QUEUE_ORDERED_FLUSH);
+	}
 
 	return 0;
 }
===== fs/buffer.c 1.215 vs edited =====
--- 1.215/fs/buffer.c	Tue Sep 30 03:12:02 2003
+++ edited/fs/buffer.c	Mon Oct 13 10:06:59 2003
@@ -2658,12 +2658,20 @@
 	BUG_ON(!buffer_mapped(bh));
 	BUG_ON(!bh->b_end_io);
 
+	if (rw == WRITEBARRIER) {
+		set_bit(BH_Ordered, &bh->b_state);
+		rw = WRITE;
+	}
+
 	if ((rw == READ || rw == READA) && buffer_uptodate(bh))
 		buffer_error();
 	if (rw == WRITE && !buffer_uptodate(bh))
 		buffer_error();
 	if (rw == READ && buffer_dirty(bh))
 		buffer_error();
+
+	if (test_bit(BH_Ordered, &bh->b_state) && (rw == WRITE))
+		rw = WRITEBARRIER;
 
 	/* Only clear out a write error when rewriting */
 	if (test_set_buffer_req(bh) && rw == WRITE)
===== fs/jbd/commit.c 1.40 vs edited =====
--- 1.40/fs/jbd/commit.c	Fri Aug  1 12:02:20 2003
+++ edited/fs/jbd/commit.c	Mon Oct 13 10:17:28 2003
@@ -474,7 +474,9 @@
 				clear_buffer_dirty(bh);
 				set_buffer_uptodate(bh);
 				bh->b_end_io = journal_end_buffer_io_sync;
+				set_bit(BH_Ordered, &bh->b_state);
 				submit_bh(WRITE, bh);
+				clear_bit(BH_Ordered, &bh->b_state);
 			}
 			cond_resched();
 
===== include/linux/blkdev.h 1.127 vs edited =====
--- 1.127/include/linux/blkdev.h	Tue Sep 16 13:57:26 2003
+++ edited/include/linux/blkdev.h	Mon Oct 13 09:52:33 2003
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
 
+	unsigned short		ordered;
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
+++ edited/include/linux/buffer_head.h	Mon Oct 13 09:56:22 2003
@@ -26,6 +26,7 @@
 	BH_Delay,	/* Buffer is not yet allocated on disk */
 	BH_Boundary,	/* Block is followed by a discontiguity */
 	BH_Write_EIO,	/* I/O error on write */
+	BH_Ordered,	/* ordered write */
 
 	BH_PrivateStart,/* not a state bit, but the first bit available
 			 * for private allocation by other entities
===== include/linux/fs.h 1.274 vs edited =====
--- 1.274/include/linux/fs.h	Tue Sep 23 06:16:30 2003
+++ edited/include/linux/fs.h	Mon Oct 13 10:04:04 2003
@@ -81,7 +81,7 @@
 #define READ 0
 #define WRITE 1
 #define READA 2		/* read-ahead  - don't block if no resources */
-#define SPECIAL 4	/* For non-blockdevice requests in request queue */
+#define WRITEBARRIER	5	/* 1st bit, write, 3rd barrier */
 
 #define SEL_IN		1
 #define SEL_OUT		2
===== include/linux/ide.h 1.75 vs edited =====
--- 1.75/include/linux/ide.h	Sat Sep  6 17:21:14 2003
+++ edited/include/linux/ide.h	Mon Oct 13 09:40:46 2003
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
+	char		special_buf[4];	/* private command buffer */
 	struct list_head list;
 	struct device	gendev;
 	struct semaphore gendev_rel_sem;	/* to deal with device release() */

-- 
Jens Axboe

