Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265531AbUAGNoJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 08:44:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266197AbUAGNoI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 08:44:08 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:40411 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S265531AbUAGNnZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 08:43:25 -0500
Date: Wed, 7 Jan 2004 14:43:23 +0100
From: Jens Axboe <axboe@suse.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: [PATCH] 2.6.1-rc2 ide barrier support
Message-ID: <20040107134323.GB16720@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Updated to work with 2.6.1-rc2. Changes since last version:

- Don't include jbd or xfs support, just ide + block layer bits. Makes
  it easier to include, as no actual barriers will be generated.

- Failure case in ide should _clear_ barrier support, not reset it.

Bart, would you care to review the ide bits for sanity?

===== drivers/block/ll_rw_blk.c 1.223 vs edited =====
--- 1.223/drivers/block/ll_rw_blk.c	Thu Jan  1 11:44:04 2004
+++ edited/drivers/block/ll_rw_blk.c	Wed Jan  7 14:39:11 2004
@@ -245,6 +245,28 @@
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
+ **/
+void blk_queue_ordered(request_queue_t *q, int flag)
+{
+	if (flag)
+		set_bit(QUEUE_FLAG_ORDERED, &q->queue_flags);
+	else
+		clear_bit(QUEUE_FLAG_ORDERED, &q->queue_flags);
+}
+
+EXPORT_SYMBOL(blk_queue_ordered);
+
+/**
  * blk_queue_bounce_limit - set bounce buffer limit for queue
  * @q:  the request queue for the device
  * @dma_addr:   bus address limit
@@ -1831,6 +1853,8 @@
 
 	if (unlikely(!q))
 		return;
+
+	WARN_ON(!req->ref_count);
 	if (unlikely(--req->ref_count))
 		return;
 
@@ -1997,7 +2021,7 @@
 static int __make_request(request_queue_t *q, struct bio *bio)
 {
 	struct request *req, *freereq = NULL;
-	int el_ret, rw, nr_sectors, cur_nr_sectors, barrier, ra;
+	int el_ret, rw, nr_sectors, cur_nr_sectors, barrier, ra, err;
 	sector_t sector;
 
 	sector = bio->bi_sector;
@@ -2015,7 +2039,11 @@
 
 	spin_lock_prefetch(q->queue_lock);
 
-	barrier = test_bit(BIO_RW_BARRIER, &bio->bi_rw);
+	barrier = bio_barrier(bio);
+	if (barrier && !test_bit(QUEUE_FLAG_ORDERED, &q->queue_flags)) {
+		err = -EOPNOTSUPP;
+		goto end_io;
+	}
 
 	ra = bio->bi_rw & (1 << BIO_RW_AHEAD);
 
@@ -2097,6 +2125,7 @@
 			/*
 			 * READA bit set
 			 */
+			err = -EWOULDBLOCK;
 			if (ra)
 				goto end_io;
 	
@@ -2152,7 +2181,7 @@
 	return 0;
 
 end_io:
-	bio_endio(bio, nr_sectors << 9, -EWOULDBLOCK);
+	bio_endio(bio, nr_sectors << 9, err);
 	return 0;
 }
 
===== drivers/ide/ide-disk.c 1.62 vs edited =====
--- 1.62/drivers/ide/ide-disk.c	Fri Sep  5 14:36:36 2003
+++ edited/drivers/ide/ide-disk.c	Wed Jan  7 14:40:06 2004
@@ -1371,6 +1371,7 @@
 static int write_cache (ide_drive_t *drive, int arg)
 {
 	ide_task_t args;
+	int err;
 
 	if (!(drive->id->cfs_enable_2 & 0x3000))
 		return 1;
@@ -1380,7 +1381,10 @@
 			SETFEATURES_EN_WCACHE : SETFEATURES_DIS_WCACHE;
 	args.tfRegister[IDE_COMMAND_OFFSET]	= WIN_SETFEATURES;
 	args.command_type			= ide_cmd_type_parser(&args);
-	(void) ide_raw_taskfile(drive, &args, NULL);
+
+	err = ide_raw_taskfile(drive, &args, NULL);
+	if (err)
+		return err;
 
 	drive->wcache = arg;
 	return 0;
@@ -1755,7 +1759,7 @@
 		drive->wcache = 0;
 		/* Cache enabled ? */
 		if (drive->id->csfo & 1)
-		drive->wcache = 1;
+			drive->wcache = 1;
 		/* Cache command set available ? */
 		if (drive->id->cfs_enable_1 & (1<<5))
 			drive->wcache = 1;
===== drivers/ide/ide-io.c 1.21 vs edited =====
--- 1.21/drivers/ide/ide-io.c	Thu Jan  1 11:49:12 2004
+++ edited/drivers/ide/ide-io.c	Wed Jan  7 14:42:26 2004
@@ -54,30 +54,63 @@
 #include <asm/io.h>
 #include <asm/bitops.h>
 
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
+	/*
+	 * if last rq issued was the post-flush, we can skip the pre-flush
+	 */
+	if (drive->last_rq_flush) {
+		rq->flags |= REQ_BAR_PREFLUSH;
+		return rq;
+	}
 
-	if (!nr_sectors)
-		nr_sectors = rq->hard_cur_sectors;
+	blkdev_dequeue_request(rq);
+
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
+	flush_rq->timeout = jiffies;
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
@@ -97,14 +130,55 @@
 
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
@@ -140,6 +214,97 @@
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
+			drive->last_rq_flush = 1;
+		} else {
+			/*
+			 * just indicate that we did the pre flush
+			 */
+			real_rq->flags |= REQ_BAR_PREFLUSH;
+			__elv_add_request(drive->queue, real_rq, ELEVATOR_INSERT_FRONT, 0);
+		}
+
+#ifdef IDE_DUMP_FLUSH_TIMINGS
+		printk("%s: %sflush took %lu jiffies\n", drive->name, blk_barrier_postflush(rq) ? "post" : "pre", jiffies - rq->timeout);
+#endif
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
+	blk_queue_ordered(drive->queue, 0);
+}
+
 /**
  *	ide_end_drive_cmd	-	end an explicit drive command
  *	@drive: command 
@@ -229,6 +394,10 @@
 
 	spin_lock_irqsave(&ide_lock, flags);
 	blkdev_dequeue_request(rq);
+
+	if (blk_barrier_preflush(rq) || blk_barrier_postflush(rq))
+		ide_complete_barrier(drive, rq, err);
+
 	HWGROUP(drive)->rq = NULL;
 	end_that_request_last(rq);
 	spin_unlock_irqrestore(&ide_lock, flags);
@@ -717,6 +886,15 @@
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
@@ -884,6 +1062,15 @@
 		}
 
 		/*
+		 * if rq is a barrier write, issue pre cache flush if not
+		 * already done
+		 */
+		if (blk_barrier_rq(rq) && !blk_barrier_preflush(rq))
+			rq = ide_queue_flush_cmd(drive, rq, 0);
+
+		drive->last_rq_flush = 0;
+
+		/*
 		 * Sanity: don't accept a request that isn't a PM request
 		 * if we are currently power managed. This is very important as
 		 * blk_stop_queue() doesn't prevent the elv_next_request()
@@ -902,6 +1089,10 @@
 			break;
 		}
 
+		/*
+		 * we can only queue read-write requests, so let the drive
+		 * queue drain before continuing with this command.
+		 */
 		if (!rq->bio && ata_pending_commands(drive))
 			break;
 
@@ -1307,6 +1498,7 @@
 {
 	memset(rq, 0, sizeof(*rq));
 	rq->flags = REQ_DRIVE_CMD;
+	rq->ref_count = 1;
 }
 
 EXPORT_SYMBOL(ide_init_drive_cmd);
===== drivers/md/raid1.c 1.75 vs edited =====
--- 1.75/drivers/md/raid1.c	Tue Dec 30 09:43:50 2003
+++ edited/drivers/md/raid1.c	Wed Jan  7 14:38:34 2004
@@ -889,7 +889,7 @@
 		conf = mddev_to_conf(mddev);
 		bio = r1_bio->master_bio;
 		switch(r1_bio->cmd) {
-		case SPECIAL:
+		case WRITESYNC:
 			sync_request_write(mddev, r1_bio);
 			break;
 		case READ:
@@ -999,7 +999,7 @@
 
 	r1_bio->mddev = mddev;
 	r1_bio->sector = sector_nr;
-	r1_bio->cmd = SPECIAL;
+	r1_bio->cmd = WRITESYNC;
 	r1_bio->read_disk = disk;
 
 	bio = r1_bio->master_bio;
===== fs/buffer.c 1.216 vs edited =====
--- 1.216/fs/buffer.c	Tue Dec 30 09:41:48 2003
+++ edited/fs/buffer.c	Wed Jan  7 14:38:34 2004
@@ -2665,6 +2665,9 @@
 	if (rw == READ && buffer_dirty(bh))
 		buffer_error();
 
+	if (buffer_ordered(bh) && (rw == WRITE))
+		rw = WRITESYNC;
+
 	/* Only clear out a write error when rewriting */
 	if (test_set_buffer_req(bh) && rw == WRITE)
 		clear_buffer_write_io_error(bh);
===== include/linux/blkdev.h 1.130 vs edited =====
--- 1.130/include/linux/blkdev.h	Thu Jan  1 11:44:04 2004
+++ edited/include/linux/blkdev.h	Wed Jan  7 14:38:34 2004
@@ -195,6 +195,8 @@
 	__REQ_PM_SUSPEND,	/* suspend request */
 	__REQ_PM_RESUME,	/* resume request */
 	__REQ_PM_SHUTDOWN,	/* shutdown request */
+	__REQ_BAR_PREFLUSH,	/* barrier pre-flush done */
+	__REQ_BAR_POSTFLUSH,	/* barrier post-flush */
 	__REQ_NR_BITS,		/* stops here */
 };
 
@@ -220,6 +222,8 @@
 #define REQ_PM_SUSPEND	(1 << __REQ_PM_SUSPEND)
 #define REQ_PM_RESUME	(1 << __REQ_PM_RESUME)
 #define REQ_PM_SHUTDOWN	(1 << __REQ_PM_SHUTDOWN)
+#define REQ_BAR_PREFLUSH	(1 << __REQ_BAR_PREFLUSH)
+#define REQ_BAR_POSTFLUSH	(1 << __REQ_BAR_POSTFLUSH)
 
 /*
  * State information carried for REQ_PM_SUSPEND and REQ_PM_RESUME
@@ -369,6 +373,7 @@
 #define	QUEUE_FLAG_READFULL	3	/* write queue has been filled */
 #define QUEUE_FLAG_WRITEFULL	4	/* read queue has been filled */
 #define QUEUE_FLAG_DEAD		5	/* queue being torn down */
+#define QUEUE_FLAG_ORDERED	6	/* supports ordered writes */
 
 #define blk_queue_plugged(q)	!list_empty(&(q)->plug_list)
 #define blk_queue_tagged(q)	test_bit(QUEUE_FLAG_QUEUED, &(q)->queue_flags)
@@ -381,6 +386,10 @@
 #define blk_pm_request(rq)	\
 	((rq)->flags & (REQ_PM_SUSPEND | REQ_PM_RESUME))
 
+#define blk_barrier_rq(rq)	((rq)->flags & REQ_HARDBARRIER)
+#define blk_barrier_preflush(rq)	((rq)->flags & REQ_BAR_PREFLUSH)
+#define blk_barrier_postflush(rq)	((rq)->flags & REQ_BAR_POSTFLUSH)
+
 #define list_entry_rq(ptr)	list_entry((ptr), struct request, queuelist)
 
 #define rq_data_dir(rq)		((rq)->flags & 1)
@@ -563,6 +572,7 @@
 extern void blk_queue_merge_bvec(request_queue_t *, merge_bvec_fn *);
 extern void blk_queue_dma_alignment(request_queue_t *, int);
 extern struct backing_dev_info *blk_get_backing_dev_info(struct block_device *bdev);
+extern void blk_queue_ordered(request_queue_t *, int);
 
 extern int blk_rq_map_sg(request_queue_t *, struct request *, struct scatterlist *);
 extern void blk_dump_rq_flags(struct request *, char *);
===== include/linux/buffer_head.h 1.44 vs edited =====
--- 1.44/include/linux/buffer_head.h	Tue Aug 19 07:30:30 2003
+++ edited/include/linux/buffer_head.h	Wed Jan  7 14:38:34 2004
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
===== include/linux/fs.h 1.276 vs edited =====
--- 1.276/include/linux/fs.h	Mon Dec 29 22:37:20 2003
+++ edited/include/linux/fs.h	Wed Jan  7 14:38:34 2004
@@ -81,7 +81,7 @@
 #define READ 0
 #define WRITE 1
 #define READA 2		/* read-ahead  - don't block if no resources */
-#define SPECIAL 4	/* For non-blockdevice requests in request queue */
+#define WRITESYNC	((1 << BIO_RW) | (1 << BIO_RW_BARRIER))
 
 #define SEL_IN		1
 #define SEL_OUT		2
===== include/linux/ide.h 1.79 vs edited =====
--- 1.79/include/linux/ide.h	Thu Jan  1 11:49:12 2004
+++ edited/include/linux/ide.h	Wed Jan  7 14:38:35 2004
@@ -754,6 +754,8 @@
 	u8	bios_head;	/* BIOS/fdisk/LILO number of heads */
 	u8	bios_sect;	/* BIOS/fdisk/LILO sectors per track */
 	u8	queue_depth;	/* max queue depth */
+	u8	doing_barrier;	/* state, 1=currently doing flush */
+	u8	last_rq_flush;	/* last rq was a flush */
 
 	unsigned int	bios_cyl;	/* BIOS/fdisk/LILO number of cyls */
 	unsigned int	cyl;		/* "real" number of cyls */
@@ -768,6 +770,7 @@
 	int		forced_lun;	/* if hdxlun was given at boot */
 	int		lun;		/* logical unit */
 	int		crc_count;	/* crc counter to reduce drive speed */
+	char		special_buf[8];	/* private command buffer */
 	struct list_head list;
 	struct device	gendev;
 	struct semaphore gendev_rel_sem;	/* to deal with device release() */

-- 
Jens Axboe

