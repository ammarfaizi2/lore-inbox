Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261599AbTBEQYn>; Wed, 5 Feb 2003 11:24:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261600AbTBEQYn>; Wed, 5 Feb 2003 11:24:43 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:45724 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S261599AbTBEQYg>;
	Wed, 5 Feb 2003 11:24:36 -0500
Date: Wed, 5 Feb 2003 17:33:52 +0100
From: Jens Axboe <axboe@suse.de>
To: Marc-Christian Petersen <m.c.p@wolk-project.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ide write barriers
Message-ID: <20030205163352.GQ31566@suse.de>
References: <20030205151859.GK31566@suse.de> <200302051628.48803.m.c.p@wolk-project.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200302051628.48803.m.c.p@wolk-project.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 05 2003, Marc-Christian Petersen wrote:
> On Wednesday 05 February 2003 16:18, Jens Axboe wrote:
> 
> Hi Jens,
> 
> > The attached patch implements write barrier operations in the block
> > layer and for IDE, specifically. The goal is to make the use of write
> > back cache enabled ide drives safe with journalled file systems.
> > Patch is against 2.4.21-pre4-bk as of today, and includes a small patch
> > to enable it on ext3. Chris has a patch for reiserfs as well.
> Could you also please cook up one for 2.4.20? :) Thank you.

Sure, I had that one already. BTW, I discovered that the default io
scheduler forgets to honor the cmd_flags, it's supposed to break like
the noop does (see very first hunk in very first file). Must have
removed that by mistake some time ago... This applies both to the
2.4.21-pre4 patch posted and this one.

diff -urN -X /home/axboe/cdrom/exclude /opt/kernel/linux-2.4.20/drivers/block/elevator.c linux/drivers/block/elevator.c
--- /opt/kernel/linux-2.4.20/drivers/block/elevator.c	2002-11-29 00:53:12.000000000 +0100
+++ linux/drivers/block/elevator.c	2002-11-19 07:58:11.000000000 +0100
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
diff -urN -X /home/axboe/cdrom/exclude /opt/kernel/linux-2.4.20/drivers/block/ll_rw_blk.c linux/drivers/block/ll_rw_blk.c
--- /opt/kernel/linux-2.4.20/drivers/block/ll_rw_blk.c	2002-11-29 00:53:12.000000000 +0100
+++ linux/drivers/block/ll_rw_blk.c	2002-11-22 13:53:31.000000000 +0100
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
@@ -432,7 +458,7 @@
 
 	si_meminfo(&si);
 	megs = si.totalram >> (20 - PAGE_SHIFT);
-	nr_requests = 128;
+	nr_requests = 16;
 	if (megs < 32)
 		nr_requests /= 2;
 	blk_grow_request_list(q, nr_requests);
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
@@ -1525,3 +1571,4 @@
 EXPORT_SYMBOL(blk_max_pfn);
 EXPORT_SYMBOL(blk_seg_merge_ok);
 EXPORT_SYMBOL(blk_nohighio);
+EXPORT_SYMBOL(blk_queue_ordered);
diff -urN -X /home/axboe/cdrom/exclude /opt/kernel/linux-2.4.20/drivers/ide/ide.c linux/drivers/ide/ide.c
--- /opt/kernel/linux-2.4.20/drivers/ide/ide.c	2002-11-29 00:53:13.000000000 +0100
+++ linux/drivers/ide/ide.c	2002-11-19 07:58:11.000000000 +0100
@@ -555,6 +555,36 @@
 }
 
 /*
+ * preempt pending requests, and store this cache flush for immediate
+ * execution
+ */
+static struct request *ide_queue_flush_cmd(ide_drive_t *drive, struct request *rq, int post)
+{
+	struct request *flush_rq = &HWGROUP(drive)->wrq;
+
+	list_del(&rq->queue);
+
+	memset(drive->special_buf, 0, sizeof(drive->special_buf));
+
+	ide_init_drive_cmd(flush_rq);
+
+	flush_rq->buffer = drive->special_buf;
+	flush_rq->special = rq;
+
+	flush_rq->buffer[0] = (drive->id->cfs_enable_2 & 0x2400) ? WIN_FLUSH_CACHE_EXT : WIN_FLUSH_CACHE;
+
+	if (post)
+		flush_rq->cmd_flags |= RQ_WRITE_POSTFLUSH;
+	else {
+		drive->doing_barrier = 1;
+		flush_rq->cmd_flags |= RQ_WRITE_PREFLUSH;
+	}
+
+	list_add(&flush_rq->queue, &drive->queue.queue_head);
+	return flush_rq;
+}
+
+/*
  * This is our end_request replacement function.
  */
 void ide_end_request (byte uptodate, ide_hwgroup_t *hwgroup)
@@ -577,9 +607,19 @@
 
 	if (!end_that_request_first(rq, uptodate, hwgroup->drive->name)) {
 		add_blkdev_randomness(MAJOR(rq->rq_dev));
-		blkdev_dequeue_request(rq);
         	hwgroup->rq = NULL;
-		end_that_request_last(rq);
+
+		/*
+                 * if this is a write barrier, flush the writecache before
+                 * allowing new requests to finsh and before signalling
+                 * completion of this request
+                 */
+		if (rq->cmd_flags & RQ_WRITE_ORDERED)
+			ide_queue_flush_cmd(drive, rq, 1);
+		else {
+			blkdev_dequeue_request(rq);
+			end_that_request_last(rq);
+		}
 	}
 	spin_unlock_irqrestore(&io_request_lock, flags);
 }
@@ -932,8 +972,36 @@
 		default:
 			break;
 	}
+
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
+		if (err)
+			blk_queue_ordered(&drive->queue, QUEUE_ORDERED_NONE);
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
@@ -947,6 +1015,13 @@
 	unsigned long flags;
 	byte err = 0;
 
+	if (drive->quiet) {
+		if ((stat & (BUSY_STAT|ERR_STAT)) == ERR_STAT)
+			err = GET_ERR();
+
+		return err;
+	}
+
 	__save_flags (flags);	/* local CPU only */
 	ide__sti();		/* local CPU only */
 	printk("%s: %s: status=0x%02x", drive->name, msg, stat);
@@ -1049,9 +1124,14 @@
 	struct request *rq;
 	byte err;
 
+	if (drive == NULL)
+		return ide_stopped;
+
 	err = ide_dump_status(drive, msg, stat);
-	if (drive == NULL || (rq = HWGROUP(drive)->rq) == NULL)
+
+	if ((rq = HWGROUP(drive)->rq) == NULL)
 		return ide_stopped;
+
 	/* retry only "normal" I/O: */
 	if (rq->cmd == IDE_DRIVE_CMD || rq->cmd == IDE_DRIVE_TASK) {
 		rq->errors = 1;
@@ -1454,6 +1534,15 @@
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
 		if (!list_empty(&drive->queue.queue_head) && (!drive->sleep || 0 <= (signed long)(jiffies - drive->sleep))) {
 			if (!best
@@ -1583,7 +1672,18 @@
 		if ( drive->queue.plugged )	/* paranoia */
 			printk("%s: Huh? nuking plugged queue\n", drive->name);
 
-		rq = hwgroup->rq = blkdev_entry_next_request(&drive->queue.queue_head);
+		rq = blkdev_entry_next_request(&drive->queue.queue_head);
+
+ 		/*
+ 		 * if rq is a barrier write, issue pre cache flush if not
+ 		 * already done
+ 		 */
+		if ((rq->cmd_flags & RQ_WRITE_ORDERED)
+		    && !(rq->cmd_flags & RQ_WRITE_PREFLUSH))
+ 			rq = ide_queue_flush_cmd(drive, rq, 0);
+ 
+ 		hwgroup->rq = rq;
+ 
 		/*
 		 * Some systems have trouble with IDE IRQs arriving while
 		 * the driver is still setting things up.  So, here we disable
@@ -3868,6 +3968,14 @@
 		drive->dsc_overlap = (drive->next != drive && driver->supports_dsc_overlap);
 		drive->nice1 = 1;
 	}
+	if (DRIVER(drive)->flushcache && drive->media == ide_disk) {
+		drive->quiet = 1;
+		if (!DRIVER(drive)->flushcache(drive)) {
+			blk_queue_ordered(&drive->queue, QUEUE_ORDERED_FLUSH);
+			printk("%s: safely enabled flush\n", drive->name);
+		}
+		drive->quiet = 0;
+	}
 	drive->revalidate = 1;
 	drive->suspend_reset = 0;
 #ifdef CONFIG_PROC_FS
diff -urN -X /home/axboe/cdrom/exclude /opt/kernel/linux-2.4.20/fs/jbd/commit.c linux/fs/jbd/commit.c
--- /opt/kernel/linux-2.4.20/fs/jbd/commit.c	2002-11-29 00:53:15.000000000 +0100
+++ linux/fs/jbd/commit.c	2002-11-22 12:01:29.000000000 +0100
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
diff -urN -X /home/axboe/cdrom/exclude /opt/kernel/linux-2.4.20/include/linux/blkdev.h linux/include/linux/blkdev.h
--- /opt/kernel/linux-2.4.20/include/linux/blkdev.h	2002-11-29 00:53:15.000000000 +0100
+++ linux/include/linux/blkdev.h	2002-11-26 17:33:57.000000000 +0100
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
@@ -140,6 +149,9 @@
 	wait_queue_head_t	wait_for_requests[2];
 };
 
+#define QUEUE_ORDERED_NONE    0       /* no support */
+#define QUEUE_ORDERED_TAG     1       /* supported by tags (fast) */
+#define QUEUE_ORDERED_FLUSH   2       /* supported by cache flush (ugh!) */
 extern unsigned long blk_max_low_pfn, blk_max_pfn;
 
 #define BLK_BOUNCE_HIGH		(blk_max_low_pfn << PAGE_SHIFT)
@@ -209,6 +221,7 @@
 extern void blk_init_queue(request_queue_t *, request_fn_proc *);
 extern void blk_cleanup_queue(request_queue_t *);
 extern void blk_queue_headactive(request_queue_t *, int);
+extern void blk_queue_ordered(request_queue_t *, int);
 extern void blk_queue_make_request(request_queue_t *, make_request_fn *);
 extern void generic_unplug_device(void *);
 extern inline int blk_seg_merge_ok(struct buffer_head *, struct buffer_head *);
diff -urN -X /home/axboe/cdrom/exclude /opt/kernel/linux-2.4.20/include/linux/elevator.h linux/include/linux/elevator.h
--- /opt/kernel/linux-2.4.20/include/linux/elevator.h	2002-11-29 00:53:15.000000000 +0100
+++ linux/include/linux/elevator.h	2002-11-22 13:55:07.000000000 +0100
@@ -93,8 +93,8 @@
 
 #define ELEVATOR_LINUS							\
 ((elevator_t) {								\
-	2048,				/* read passovers */		\
-	8192,				/* write passovers */		\
+	256,				/* read passovers */		\
+	1024,				/* write passovers */		\
 									\
 	elevator_linus_merge,		/* elevator_merge_fn */		\
 	elevator_linus_merge_req,	/* elevator_merge_req_fn */	\
diff -urN -X /home/axboe/cdrom/exclude /opt/kernel/linux-2.4.20/include/linux/fs.h linux/include/linux/fs.h
--- /opt/kernel/linux-2.4.20/include/linux/fs.h	2002-11-29 00:53:15.000000000 +0100
+++ linux/include/linux/fs.h	2002-11-22 11:30:56.000000000 +0100
@@ -220,6 +220,10 @@
 	BH_Wait_IO,	/* 1 if we should write out this buffer */
 	BH_Launder,	/* 1 if we can throttle on this buffer */
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
diff -urN -X /home/axboe/cdrom/exclude /opt/kernel/linux-2.4.20/include/linux/ide.h linux/include/linux/ide.h
--- /opt/kernel/linux-2.4.20/include/linux/ide.h	2002-11-29 00:53:15.000000000 +0100
+++ linux/include/linux/ide.h	2002-11-26 17:36:30.000000000 +0100
@@ -381,6 +381,8 @@
 	unsigned autotune	: 2;	/* 1=autotune, 2=noautotune, 0=default */
 	unsigned remap_0_to_1	: 2;	/* 0=remap if ezdrive, 1=remap, 2=noremap */
 	unsigned ata_flash	: 1;	/* 1=present, 0=default */
+	unsigned quiet		: 1;
+	unsigned doing_barrier	: 1;	/* barrier sequence in progress */
 	unsigned	addressing;	/* : 2; 0=28-bit, 1=48-bit, 2=64-bit */
 	byte		scsi;		/* 0=default, 1=skip current ide-subdriver for ide-scsi emulation */
 	byte		media;		/* disk, cdrom, tape, floppy, ... */
@@ -428,6 +430,7 @@
 	byte		acoustic;	/* acoustic management */
 	unsigned int	failures;	/* current failure count */
 	unsigned int	max_failures;	/* maximum allowed failure count */
+	char		special_buf[4]; /* IDE_DRIVE_CMD, free use */
 } ide_drive_t;
 
 /*


-- 
Jens Axboe

