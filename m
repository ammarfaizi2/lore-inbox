Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261409AbTBEPJu>; Wed, 5 Feb 2003 10:09:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261427AbTBEPJu>; Wed, 5 Feb 2003 10:09:50 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:35476 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S261409AbTBEPJn>;
	Wed, 5 Feb 2003 10:09:43 -0500
Date: Wed, 5 Feb 2003 16:18:59 +0100
From: Jens Axboe <axboe@suse.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Chris Mason <mason@suse.com>
Subject: [PATCH] ide write barriers
Message-ID: <20030205151859.GK31566@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The attached patch implements write barrier operations in the block
layer and for IDE, specifically. The goal is to make the use of write
back cache enabled ide drives safe with journalled file systems.

Patch is against 2.4.21-pre4-bk as of today, and includes a small patch
to enable it on ext3. Chris has a patch for reiserfs as well.

===== drivers/block/elevator.c 1.7 vs edited =====
--- 1.7/drivers/block/elevator.c	Mon Sep 16 09:36:31 2002
+++ edited/drivers/block/elevator.c	Wed Feb  5 13:44:38 2003
@@ -156,6 +156,12 @@
 	while ((entry = entry->prev) != head) {
 		struct request *__rq = blkdev_entry_to_request(entry);
 
+		/*
+		 * we can neither merge nor insert before/with a flush
+		 */
+		if (__rq->cmd_flags & RQ_WRITE_ORDERED)
+			break;
+
 		if (__rq->cmd != rw)
 			continue;
 		if (__rq->rq_dev != bh->b_rdev)
===== drivers/block/ll_rw_blk.c 1.42 vs edited =====
--- 1.42/drivers/block/ll_rw_blk.c	Mon Dec 16 07:22:15 2002
+++ edited/drivers/block/ll_rw_blk.c	Wed Feb  5 13:44:38 2003
@@ -240,6 +240,32 @@
 void blk_queue_make_request(request_queue_t * q, make_request_fn * mfn)
 {
 	q->make_request_fn = mfn;
+	q->ordered = QUEUE_ORDERED_NONE;
+}
+
+/**
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
+        q->ordered = flag;
 }
 
 /**
@@ -517,6 +543,7 @@
 		rq = blkdev_free_rq(&rl->free);
 		list_del(&rq->queue);
 		rl->count--;
+		rq->cmd_flags = 0;
 		rq->rq_status = RQ_ACTIVE;
 		rq->cmd = rw;
 		rq->special = NULL;
@@ -908,12 +935,27 @@
 	int rw_ahead, max_sectors, el_ret;
 	struct list_head *head, *insert_here;
 	int latency;
+	int write_ordered = 0;
 	elevator_t *elevator = &q->elevator;
 
+	/* check for barrier requests the device can't handle */
+	if (buffer_ordered_tag(bh)) 
+		write_ordered = QUEUE_ORDERED_TAG;
+	else if (buffer_ordered_flush(bh)) 
+		write_ordered = QUEUE_ORDERED_FLUSH;
+
+	if (write_ordered && q->ordered != write_ordered) {
+		if (buffer_ordered_hard(bh)) {
+			set_bit(BH_IO_OPNOTSUPP, &bh->b_state);
+			goto end_io;
+		}
+		write_ordered = 0;
+	}
+
 	count = bh->b_size >> 9;
 	sector = bh->b_rsector;
 
-	rw_ahead = 0;	/* normal case; gets changed below for READA */
+	latency = rw_ahead = 0;	/* normal case; gets changed below for READA */
 	switch (rw) {
 		case READA:
 #if 0	/* bread() misinterprets failed READA attempts as IO errors on SMP */
@@ -922,7 +964,8 @@
 			rw = READ;	/* drop into READ */
 		case READ:
 		case WRITE:
-			latency = elevator_request_latency(elevator, rw);
+			if (!write_ordered)
+				latency = elevator_request_latency(elevator, rw);
 			break;
 		default:
 			BUG();
@@ -1049,6 +1092,9 @@
 	}
 
 /* fill up the request-info, and add it to the queue */
+	if (write_ordered)
+		req->cmd_flags |= RQ_WRITE_ORDERED;
+
 	req->elevator_sequence = latency;
 	req->cmd = rw;
 	req->errors = 0;
@@ -1519,3 +1565,4 @@
 EXPORT_SYMBOL(blk_max_pfn);
 EXPORT_SYMBOL(blk_seg_merge_ok);
 EXPORT_SYMBOL(blk_nohighio);
+EXPORT_SYMBOL(blk_queue_ordered);
===== drivers/ide/ide-disk.c 1.12 vs edited =====
--- 1.12/drivers/ide/ide-disk.c	Mon Sep 30 18:19:50 2002
+++ edited/drivers/ide/ide-disk.c	Wed Feb  5 15:57:43 2003
@@ -766,32 +766,7 @@
 
 static int idedisk_end_request (ide_drive_t *drive, int uptodate)
 {
-	struct request *rq;
-	unsigned long flags;
-	int ret = 1;
-
-	spin_lock_irqsave(&io_request_lock, flags);
-	rq = HWGROUP(drive)->rq;
-
-	/*
-	 * decide whether to reenable DMA -- 3 is a random magic for now,
-	 * if we DMA timeout more than 3 times, just stay in PIO
-	 */
-	if (drive->state == DMA_PIO_RETRY && drive->retry_pio <= 3) {
-		drive->state = 0;
-		HWGROUP(drive)->hwif->ide_dma_on(drive);
-	}
-
-	if (!end_that_request_first(rq, uptodate, drive->name)) {
-		add_blkdev_randomness(MAJOR(rq->rq_dev));
-		blkdev_dequeue_request(rq);
-		HWGROUP(drive)->rq = NULL;
-		end_that_request_last(rq);
-		ret = 0;
-	}
-
-	spin_unlock_irqrestore(&io_request_lock, flags);
-	return ret;
+	return ide_end_request(drive, uptodate);
 }
 
 static u8 idedisk_dump_status (ide_drive_t *drive, const char *msg, u8 stat)
===== drivers/ide/ide-io.c 1.2 vs edited =====
--- 1.2/drivers/ide/ide-io.c	Thu Jan 30 18:28:59 2003
+++ edited/drivers/ide/ide-io.c	Wed Feb  5 16:15:33 2003
@@ -58,8 +58,8 @@
 
 #if (DISK_RECOVERY_TIME > 0)
 
-Error So the User Has To Fix the Compilation And Stop Hacking Port 0x43
-Does anyone ever use this anyway ??
+#error So the User Has To Fix the Compilation And Stop Hacking Port 0x43
+#error Does anyone ever use this anyway ??
 
 /*
  * For really screwy hardware (hey, at least it *can* be used with Linux)
@@ -88,6 +88,38 @@
 #endif /* DISK_RECOVERY_TIME */
 }
 
+ /*
+ * preempt pending requests, and store this cache flush for immediate
+ * execution
+ */
+static struct request *ide_queue_flush_cmd(ide_drive_t *drive,
+					   struct request *rq, int post)
+{
+	struct request *flush_rq = &HWGROUP(drive)->wrq;
+
+	list_del_init(&rq->queue);
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
+		flush_rq->cmd_flags |= RQ_WRITE_PREFLUSH;
+	} else
+		flush_rq->cmd_flags |= RQ_WRITE_POSTFLUSH;
+
+	list_add(&flush_rq->queue, &drive->queue.queue_head);
+	return flush_rq;
+}
+
 /*
  *	ide_end_request		-	complete an IDE I/O
  *	@drive: IDE device for the I/O
@@ -117,10 +149,20 @@
 
 	if (!end_that_request_first(rq, uptodate, drive->name)) {
 		add_blkdev_randomness(MAJOR(rq->rq_dev));
-		blkdev_dequeue_request(rq);
 		HWGROUP(drive)->rq = NULL;
-		end_that_request_last(rq);
 		ret = 0;
+
+		/*
+                 * if this is a write barrier, flush the writecache before
+                 * signalling completion of this request.
+                 */
+		if (rq->cmd_flags & RQ_WRITE_ORDERED)
+			ide_queue_flush_cmd(drive, rq, 1);
+		else {
+			blkdev_dequeue_request(rq);
+			end_that_request_last(rq);
+		}
+
 	}
 
 	spin_unlock_irqrestore(&io_request_lock, flags);
@@ -220,6 +262,35 @@
 	}
 	spin_lock_irqsave(&io_request_lock, flags);
 	blkdev_dequeue_request(rq);
+
+	/*
+	 * if a cache flush fails, disable ordered write support
+	 */
+	if (rq->cmd_flags & (RQ_WRITE_PREFLUSH | RQ_WRITE_POSTFLUSH)) {
+		struct request *real_rq = rq->special;
+
+		/*
+		 * best-effort currently, this ignores the fact that there
+		 * may be other barriers currently queued that we can't
+		 * honor any more
+		 */
+		if (err) {
+			printk("%s: cache flushing failed. disable write back cacheing for journalled file systems\n", drive->name);
+			blk_queue_ordered(&drive->queue, QUEUE_ORDERED_NONE);
+		}
+
+		if (rq->cmd_flags & RQ_WRITE_POSTFLUSH) {
+			drive->doing_barrier = 0;
+			end_that_request_last(real_rq);
+		} else {
+			/*
+			 * just indicate that we did the pre flush
+			 */
+			real_rq->cmd_flags |= RQ_WRITE_PREFLUSH;
+			list_add(&real_rq->queue, &drive->queue.queue_head);
+		}
+	}
+
 	HWGROUP(drive)->rq = NULL;
 	end_that_request_last(rq);
 	spin_unlock_irqrestore(&io_request_lock, flags);
@@ -277,8 +348,11 @@
 	struct request *rq;
 	u8 err;
 
+	if (drive == NULL)
+		return ide_stopped;
+
 	err = ide_dump_status(drive, msg, stat);
-	if (drive == NULL || (rq = HWGROUP(drive)->rq) == NULL)
+	if ((rq = HWGROUP(drive)->rq) == NULL)
 		return ide_stopped;
 
 	hwif = HWIF(drive);
@@ -682,6 +756,15 @@
 repeat:	
 	best = NULL;
 	drive = hwgroup->drive;
+
+	/*
+	 * drive is doing pre-flush, ordered write, post-flush sequence. even
+	 * though that is 3 requests, it must be seen as a single transaction.
+	 * we must no preempt this drive until that is complete
+	 */
+	if (drive->doing_barrier)
+		return drive;
+
 	do {
 		if (!blk_queue_empty(&drive->queue) && (!drive->sleep || time_after_eq(jiffies, drive->sleep))) {
 			if (!best
@@ -824,7 +907,18 @@
 			printk(KERN_ERR "%s: Huh? nuking plugged queue\n", drive->name);
 
 		rq = blkdev_entry_next_request(&drive->queue.queue_head);
+
+ 		/*
+ 		 * if rq is a barrier write, issue pre cache flush if not
+ 		 * already done
+ 		 */
+		if (rq->cmd_flags & RQ_WRITE_ORDERED) {
+			if (!(rq->cmd_flags & RQ_WRITE_PREFLUSH))
+ 				rq = ide_queue_flush_cmd(drive, rq, 0);
+		}
+
 		hwgroup->rq = rq;
+
 		/*
 		 * Some systems have trouble with IDE IRQs arriving while
 		 * the driver is still setting things up.  So, here we disable
===== drivers/ide/ide-probe.c 1.14 vs edited =====
--- 1.14/drivers/ide/ide-probe.c	Mon Jan 27 17:44:05 2003
+++ edited/drivers/ide/ide-probe.c	Wed Feb  5 16:17:25 2003
@@ -784,11 +784,8 @@
 	q->queuedata = HWGROUP(drive);
 	blk_init_queue(q, do_ide_request);
 
-	if (drive->media == ide_disk) {
-#ifdef CONFIG_BLK_DEV_ELEVATOR_NOOP
-		elevator_init(&q->elevator, ELEVATOR_NOOP);
-#endif
-	}
+	if (drive->media == ide_disk)
+		blk_queue_ordered(&drive->queue, QUEUE_ORDERED_FLUSH);
 }
 
 #undef __IRQ_HELL_SPIN
===== fs/jbd/commit.c 1.5 vs edited =====
--- 1.5/fs/jbd/commit.c	Thu Sep 26 14:25:37 2002
+++ edited/fs/jbd/commit.c	Wed Feb  5 13:44:38 2003
@@ -598,7 +598,15 @@
 		struct buffer_head *bh = jh2bh(descriptor);
 		clear_bit(BH_Dirty, &bh->b_state);
 		bh->b_end_io = journal_end_buffer_io_sync;
+
+		/* if we're on an ide device, setting BH_Ordered_Flush
+		   will force a write cache flush before and after the
+		   commit block.  Otherwise, it'll do nothing.  */
+
+		set_bit(BH_Ordered_Flush, &bh->b_state); 
 		submit_bh(WRITE, bh);
+		clear_bit(BH_Ordered_Flush, &bh->b_state);
+
 		wait_on_buffer(bh);
 		put_bh(bh);		/* One for getblk() */
 		journal_unlock_journal_head(descriptor);
===== include/linux/blkdev.h 1.23 vs edited =====
--- 1.23/include/linux/blkdev.h	Fri Nov 29 23:03:01 2002
+++ edited/include/linux/blkdev.h	Wed Feb  5 13:54:09 2003
@@ -32,6 +32,7 @@
 
 	kdev_t rq_dev;
 	int cmd;		/* READ or WRITE */
+	unsigned long cmd_flags;
 	int errors;
 	unsigned long start_time;
 	unsigned long sector;
@@ -48,6 +49,10 @@
 	request_queue_t *q;
 };
 
+#define RQ_WRITE_ORDERED	1	/* ordered write */
+#define RQ_WRITE_PREFLUSH	2	/* pre-barrier flush */
+#define RQ_WRITE_POSTFLUSH	4	/* post-barrier flush */
+
 #include <linux/elevator.h>
 
 typedef int (merge_request_fn) (request_queue_t *q, 
@@ -127,6 +132,10 @@
 	char			head_active;
 
 	unsigned long		bounce_pfn;
+	/*
+	 * ordered write support
+	 */
+	char			ordered;
 
 	/*
 	 * Is meant to protect the queue in the future instead of
@@ -156,6 +165,9 @@
 	}
 }
 
+#define QUEUE_ORDERED_NONE    0       /* no support */
+#define QUEUE_ORDERED_TAG     1       /* supported by tags (fast) */
+#define QUEUE_ORDERED_FLUSH   2       /* supported by cache flush (ugh!) */
 extern unsigned long blk_max_low_pfn, blk_max_pfn;
 
 #define BLK_BOUNCE_HIGH		(blk_max_low_pfn << PAGE_SHIFT)
@@ -225,6 +237,7 @@
 extern void blk_init_queue(request_queue_t *, request_fn_proc *);
 extern void blk_cleanup_queue(request_queue_t *);
 extern void blk_queue_headactive(request_queue_t *, int);
+extern void blk_queue_ordered(request_queue_t *, int);
 extern void blk_queue_make_request(request_queue_t *, make_request_fn *);
 extern void generic_unplug_device(void *);
 extern inline int blk_seg_merge_ok(struct buffer_head *, struct buffer_head *);
===== include/linux/fs.h 1.74 vs edited =====
--- 1.74/include/linux/fs.h	Sat Jan  4 04:09:16 2003
+++ edited/include/linux/fs.h	Wed Feb  5 13:53:34 2003
@@ -221,6 +221,10 @@
 	BH_Launder,	/* 1 if we can throttle on this buffer */
 	BH_Attached,	/* 1 if b_inode_buffers is linked into a list */
 	BH_JBD,		/* 1 if it has an attached journal_head */
+	BH_Ordered_Tag, /* 1 if this buffer is a ordered write barrier */
+	BH_Ordered_Flush,/* 1 if this buffer is a flush write barrier */
+	BH_Ordered_Hard, /* 1 if barrier required by the caller */
+	BH_IO_OPNOTSUPP,/* 1 if block layer rejected a barrier write */
 
 	BH_PrivateStart,/* not a state bit, but the first bit available
 			 * for private allocation by other entities
@@ -283,7 +287,10 @@
 #define buffer_new(bh)		__buffer_state(bh,New)
 #define buffer_async(bh)	__buffer_state(bh,Async)
 #define buffer_launder(bh)	__buffer_state(bh,Launder)
-
+#define buffer_ordered_tag(bh)	__buffer_state(bh,Ordered_Tag)
+#define buffer_ordered_hard(bh)	__buffer_state(bh,Ordered_Hard)
+#define buffer_ordered_flush(bh)	__buffer_state(bh,Ordered_Flush)
+ 
 #define bh_offset(bh)		((unsigned long)(bh)->b_data & ~PAGE_MASK)
 
 extern void set_bh_page(struct buffer_head *bh, struct page *page, unsigned long offset);
===== include/linux/ide.h 1.9 vs edited =====
--- 1.9/include/linux/ide.h	Fri Jan 31 14:22:15 2003
+++ edited/include/linux/ide.h	Wed Feb  5 16:14:15 2003
@@ -743,6 +743,7 @@
 	unsigned remap_0_to_1	: 2;	/* 0=remap if ezdrive, 1=remap, 2=noremap */
 	unsigned ata_flash	: 1;	/* 1=present, 0=default */
 	unsigned dead		: 1;	/* 1=dead, no new attachments */
+	unsigned doing_barrier	: 1;	/* state, 1=currently doing flush */
 	unsigned addressing;		/*      : 3;
 					 *  0=28-bit
 					 *  1=48-bit
@@ -788,6 +789,8 @@
 	int		forced_lun;	/* if hdxlun was given at boot */
 	int		lun;		/* logical unit */
 	int		crc_count;	/* crc counter to reduce drive speed */
+
+	char		special_buf[4];	/* IDE_DRIVE_CMD, free use */
 } ide_drive_t;
 
 typedef struct ide_pio_ops_s {

-- 
Jens Axboe

