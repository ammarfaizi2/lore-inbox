Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262638AbVA0PMX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262638AbVA0PMX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 10:12:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262630AbVA0PMX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 10:12:23 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:19141 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262638AbVA0PIu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 10:08:50 -0500
Date: Thu, 27 Jan 2005 16:08:46 +0100
From: Jens Axboe <axboe@suse.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Jeff Garzik <jgarzik@pobox.com>, linux-scsi@vger.kernel.org
Subject: [PATCH] scsi/sata write barrier support #2
Message-ID: <20050127150845.GY2751@suse.de>
References: <20050127120244.GO2751@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050127120244.GO2751@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

A few changes:

- Cleanup up the driver additions even more, blk_complete_barrier_rq()
  does all the work now.

- Fixed up the exports

- Comment functions

- Fixed a bug with SCSI and write back caching disabled

- Rename blk_queue_flush() to blk_queue_flushing() to indicate it's a
  state

diff -urp -X /home/axboe/cdrom/exclude /opt/kernel/linux-2.6.10/drivers/block/cfq-iosched.c linux-2.6.10/drivers/block/cfq-iosched.c
--- /opt/kernel/linux-2.6.10/drivers/block/cfq-iosched.c	2005-01-26 21:18:37.000000000 +0100
+++ linux-2.6.10/drivers/block/cfq-iosched.c	2005-01-26 21:19:05.000000000 +0100
@@ -1285,19 +1285,19 @@ static int cfq_queue_empty(request_queue
 static void cfq_completed_request(request_queue_t *q, struct request *rq)
 {
 	struct cfq_rq *crq = RQ_DATA(rq);
+	struct cfq_queue *cfqq;
 
 	if (unlikely(!blk_fs_request(rq)))
 		return;
 
-	if (crq->in_flight) {
-		struct cfq_queue *cfqq = crq->cfq_queue;
+	cfqq = crq->cfq_queue;
 
+	if (crq->in_flight) {
 		WARN_ON(!cfqq->in_flight);
 		cfqq->in_flight--;
-
-		cfq_account_completion(cfqq, crq);
 	}
 
+	cfq_account_completion(cfqq, crq);
 }
 
 static struct request *
diff -urp -X /home/axboe/cdrom/exclude /opt/kernel/linux-2.6.10/drivers/block/elevator.c linux-2.6.10/drivers/block/elevator.c
--- /opt/kernel/linux-2.6.10/drivers/block/elevator.c	2005-01-26 21:18:37.000000000 +0100
+++ linux-2.6.10/drivers/block/elevator.c	2005-01-26 21:19:05.000000000 +0100
@@ -320,7 +320,21 @@ void elv_add_request(request_queue_t *q,
 
 static inline struct request *__elv_next_request(request_queue_t *q)
 {
-	return q->elevator->ops->elevator_next_req_fn(q);
+	struct request *rq = q->elevator->ops->elevator_next_req_fn(q);
+
+	/*
+	 * if this is a barrier write and the device has to issue a
+	 * flush sequence to support it, check how far we are
+	 */
+	if (rq && blk_fs_request(rq) && blk_barrier_rq(rq)) {
+		BUG_ON(q->ordered == QUEUE_ORDERED_NONE);
+
+		if (q->ordered == QUEUE_ORDERED_FLUSH &&
+		    !blk_barrier_preflush(rq))
+			rq = blk_start_pre_flush(q, rq);
+	}
+
+	return rq;
 }
 
 struct request *elv_next_request(request_queue_t *q)
diff -urp -X /home/axboe/cdrom/exclude /opt/kernel/linux-2.6.10/drivers/block/ll_rw_blk.c linux-2.6.10/drivers/block/ll_rw_blk.c
--- /opt/kernel/linux-2.6.10/drivers/block/ll_rw_blk.c	2005-01-26 21:18:37.000000000 +0100
+++ linux-2.6.10/drivers/block/ll_rw_blk.c	2005-01-27 15:57:41.000000000 +0100
@@ -267,6 +267,24 @@ void blk_queue_make_request(request_queu
 
 EXPORT_SYMBOL(blk_queue_make_request);
 
+static inline void rq_init(request_queue_t *q, struct request *rq)
+{
+	INIT_LIST_HEAD(&rq->queuelist);
+
+	rq->errors = 0;
+	rq->rq_status = RQ_ACTIVE;
+	rq->bio = rq->biotail = NULL;
+	rq->buffer = NULL;
+	rq->ref_count = 1;
+	rq->q = q;
+	rq->waiting = NULL;
+	rq->special = NULL;
+	rq->data_len = 0;
+	rq->data = NULL;
+	rq->sense = NULL;
+	rq->end_io = NULL;
+}
+
 /**
  * blk_queue_ordered - does this queue support ordered writes
  * @q:     the request queue
@@ -281,10 +299,26 @@ EXPORT_SYMBOL(blk_queue_make_request);
  **/
 void blk_queue_ordered(request_queue_t *q, int flag)
 {
-	if (flag)
-		set_bit(QUEUE_FLAG_ORDERED, &q->queue_flags);
-	else
-		clear_bit(QUEUE_FLAG_ORDERED, &q->queue_flags);
+	switch (flag) {
+		case QUEUE_ORDERED_NONE:
+			if (q->flush_rq)
+				kmem_cache_free(request_cachep, q->flush_rq);
+			q->flush_rq = NULL;
+			q->ordered = flag;
+			break;
+		case QUEUE_ORDERED_TAG:
+			q->ordered = flag;
+			break;
+		case QUEUE_ORDERED_FLUSH:
+			q->ordered = flag;
+			if (!q->flush_rq)
+				q->flush_rq = kmem_cache_alloc(request_cachep,
+								GFP_KERNEL);
+			break;
+		default:
+			printk("blk_queue_ordered: bad value %d\n", flag);
+			break;
+	}
 }
 
 EXPORT_SYMBOL(blk_queue_ordered);
@@ -306,6 +340,166 @@ void blk_queue_issue_flush_fn(request_qu
 
 EXPORT_SYMBOL(blk_queue_issue_flush_fn);
 
+/*
+ * Cache flushing for ordered writes handling
+ */
+static void blk_pre_flush_end_io(struct request *flush_rq)
+{
+	struct request *rq = flush_rq->end_io_data;
+	request_queue_t *q = rq->q;
+
+	rq->flags |= REQ_BAR_PREFLUSH;
+
+	if (!flush_rq->errors)
+		elv_requeue_request(q, rq);
+	else {
+		q->end_flush_fn(q, flush_rq);
+		clear_bit(QUEUE_FLAG_FLUSH, &q->queue_flags);
+	}
+}
+
+static void blk_post_flush_end_io(struct request *flush_rq)
+{
+	struct request *rq = flush_rq->end_io_data;
+	request_queue_t *q = rq->q;
+
+	rq->flags |= REQ_BAR_POSTFLUSH;
+
+	/*
+	 * called from end_that_request_last(), so we know that the queue
+	 * lock is held
+	 */
+	spin_unlock(q->queue_lock);
+	q->end_flush_fn(q, flush_rq);
+	spin_lock(q->queue_lock);
+
+	clear_bit(QUEUE_FLAG_FLUSH, &q->queue_flags);
+}
+
+struct request *blk_start_pre_flush(request_queue_t *q, struct request *rq)
+{
+	struct request *flush_rq = q->flush_rq;
+
+	BUG_ON(!blk_barrier_rq(rq));
+
+	rq_init(q, flush_rq);
+	flush_rq->flags = 0;
+	flush_rq->rq_disk = rq->rq_disk;
+
+	/*
+	 * prepare_flush returns 0 if no flush is needed, just mark both
+	 * pre and post flush as done in that case
+	 */
+	if (!q->prepare_flush_fn(q, flush_rq)) {
+		rq->flags |= REQ_BAR_PREFLUSH | REQ_BAR_POSTFLUSH;
+		return rq;
+	}
+
+	set_bit(QUEUE_FLAG_FLUSH, &q->queue_flags);
+
+	/*
+	 * some drivers dequeue requests right away, some only after io
+	 * completion. make sure the request is dequeued.
+	 */
+	if (!list_empty(&rq->queuelist))
+		blkdev_dequeue_request(rq);
+
+	flush_rq->end_io_data = rq;
+	flush_rq->end_io = blk_pre_flush_end_io;
+
+	__elv_add_request(q, flush_rq, ELEVATOR_INSERT_FRONT, 0);
+	return flush_rq;
+}
+
+static void blk_start_post_flush(request_queue_t *q, struct request *rq)
+{
+	struct request *flush_rq = q->flush_rq;
+
+	BUG_ON(!blk_barrier_rq(rq));
+
+	rq_init(q, flush_rq);
+	flush_rq->flags = 0;
+	flush_rq->rq_disk = rq->rq_disk;
+
+	if (q->prepare_flush_fn(q, flush_rq)) {
+		flush_rq->end_io_data = rq;
+		flush_rq->end_io = blk_post_flush_end_io;
+
+		__elv_add_request(q, flush_rq, ELEVATOR_INSERT_FRONT, 0);
+		q->request_fn(q);
+	}
+}
+
+static inline int blk_check_end_barrier(request_queue_t *q, struct request *rq,
+					int sectors)
+{
+	if (sectors > rq->nr_sectors)
+		sectors = rq->nr_sectors;
+
+	rq->nr_sectors -= sectors;
+	return rq->nr_sectors;
+}
+
+static int __blk_complete_barrier_rq(request_queue_t *q, struct request *rq,
+				     int sectors, int queue_locked)
+{
+	if (q->ordered != QUEUE_ORDERED_FLUSH)
+		return 0;
+	if (!blk_fs_request(rq) || !blk_barrier_rq(rq))
+		return 0;
+	if (blk_barrier_postflush(rq))
+		return 0;
+
+	if (!blk_check_end_barrier(q, rq, sectors)) {
+		unsigned long flags = 0;
+
+		if (!queue_locked)
+			spin_lock_irqsave(q->queue_lock, flags);
+
+		blk_start_post_flush(q, rq);
+
+		if (!queue_locked)
+			spin_unlock_irqrestore(q->queue_lock, flags);
+	}
+
+	return 1;
+}
+
+/**
+ * blk_complete_barrier_rq - complete possible barrier request
+ * @q:  the request queue for the device
+ * @rq:  the request
+ * @sectors:  number of sectors to complete
+ *
+ * Description:
+ *   Used in driver end_io handling to determine whether to postpone
+ *   completion of a barrier request until a post flush has been done. This
+ *   is the unlocked variant, used if the caller doesn't already hold the
+ *   queue lock.
+ **/
+int blk_complete_barrier_rq(request_queue_t *q, struct request *rq, int sectors)
+{
+	return __blk_complete_barrier_rq(q, rq, sectors, 0);
+}
+EXPORT_SYMBOL(blk_complete_barrier_rq);
+
+/**
+ * blk_complete_barrier_rq_locked - complete possible barrier request
+ * @q:  the request queue for the device
+ * @rq:  the request
+ * @sectors:  number of sectors to complete
+ *
+ * Description:
+ *   See blk_complete_barrier_rq(). This variant must be used if the caller
+ *   holds the queue lock.
+ **/
+int blk_complete_barrier_rq_locked(request_queue_t *q, struct request *rq,
+				   int sectors)
+{
+	return __blk_complete_barrier_rq(q, rq, sectors, 1);
+}
+EXPORT_SYMBOL(blk_complete_barrier_rq_locked);
+
 /**
  * blk_queue_bounce_limit - set bounce buffer limit for queue
  * @q:  the request queue for the device
@@ -1428,6 +1622,8 @@ void blk_cleanup_queue(request_queue_t *
 	if (q->queue_tags)
 		__blk_queue_free_tags(q);
 
+	blk_queue_ordered(q, QUEUE_ORDERED_NONE);
+
 	kmem_cache_free(requestq_cachep, q);
 }
 
@@ -1739,21 +1935,8 @@ rq_starved:
 	if (ioc_batching(q, ioc))
 		ioc->nr_batch_requests--;
 	
-	INIT_LIST_HEAD(&rq->queuelist);
-
-	rq->errors = 0;
-	rq->rq_status = RQ_ACTIVE;
-	rq->bio = rq->biotail = NULL;
-	rq->buffer = NULL;
-	rq->ref_count = 1;
-	rq->q = q;
+	rq_init(q, rq);
 	rq->rl = rl;
-	rq->waiting = NULL;
-	rq->special = NULL;
-	rq->data_len = 0;
-	rq->data = NULL;
-	rq->sense = NULL;
-
 out:
 	put_io_context(ioc);
 	return rq;
@@ -2018,8 +2201,8 @@ int blk_execute_rq(request_queue_t *q, s
 	}
 
 	rq->flags |= REQ_NOMERGE;
-	if (!rq->waiting)
-		rq->waiting = &wait;
+	rq->waiting = &wait;
+	rq->end_io = blk_end_sync_rq;
 	elv_add_request(q, rq, ELEVATOR_INSERT_BACK, 1);
 	generic_unplug_device(q);
 	wait_for_completion(rq->waiting);
@@ -2171,7 +2354,7 @@ void disk_round_stats(struct gendisk *di
 /*
  * queue lock must be held
  */
-void __blk_put_request(request_queue_t *q, struct request *req)
+static void __blk_put_request(request_queue_t *q, struct request *req)
 {
 	struct request_list *rl = req->rl;
 
@@ -2219,6 +2402,25 @@ void blk_put_request(struct request *req
 EXPORT_SYMBOL(blk_put_request);
 
 /**
+ * blk_end_sync_rq - executes a completion event on a request
+ * @rq: request to complete
+ */
+void blk_end_sync_rq(struct request *rq)
+{
+	struct completion *waiting = rq->waiting;
+
+	rq->waiting = NULL;
+	__blk_put_request(rq->q, rq);
+
+	/*
+	 * complete last, if this is a stack request the process (and thus
+	 * the rq pointer) could be invalid right after this complete()
+	 */
+	complete(waiting);
+}
+EXPORT_SYMBOL(blk_end_sync_rq);
+
+/**
  * blk_congestion_wait - wait for a queue to become uncongested
  * @rw: READ or WRITE
  * @timeout: timeout in jiffies
@@ -2371,7 +2573,7 @@ static int __make_request(request_queue_
 	spin_lock_prefetch(q->queue_lock);
 
 	barrier = bio_barrier(bio);
-	if (barrier && !(q->queue_flags & (1 << QUEUE_FLAG_ORDERED))) {
+	if (barrier && (q->ordered == QUEUE_ORDERED_NONE)) {
 		err = -EOPNOTSUPP;
 		goto end_io;
 	}
@@ -2978,7 +3180,9 @@ EXPORT_SYMBOL(end_that_request_chunk);
 void end_that_request_last(struct request *req)
 {
 	struct gendisk *disk = req->rq_disk;
-	struct completion *waiting = req->waiting;
+
+	if (blk_barrier_rq(req) && !blk_barrier_postflush(req))
+		return;
 
 	if (unlikely(laptop_mode) && blk_fs_request(req))
 		laptop_io_completion();
@@ -2998,10 +3202,10 @@ void end_that_request_last(struct reques
 		disk_round_stats(disk);
 		disk->in_flight--;
 	}
-	__blk_put_request(req->q, req);
-	/* Do this LAST! The structure may be freed immediately afterwards */
-	if (waiting)
-		complete(waiting);
+	if (req->end_io)
+		req->end_io(req);
+	else
+		__blk_put_request(req->q, req);
 }
 
 EXPORT_SYMBOL(end_that_request_last);
diff -urp -X /home/axboe/cdrom/exclude /opt/kernel/linux-2.6.10/drivers/block/paride/pd.c linux-2.6.10/drivers/block/paride/pd.c
--- /opt/kernel/linux-2.6.10/drivers/block/paride/pd.c	2005-01-26 21:18:36.000000000 +0100
+++ linux-2.6.10/drivers/block/paride/pd.c	2005-01-26 21:19:05.000000000 +0100
@@ -743,6 +743,7 @@ static int pd_special_command(struct pd_
 	rq.rq_disk = disk->gd;
 	rq.ref_count = 1;
 	rq.waiting = &wait;
+	rq.end_io = blk_end_sync_rq;
 	blk_insert_request(disk->gd->queue, &rq, 0, func, 0);
 	wait_for_completion(&wait);
 	rq.waiting = NULL;
diff -urp -X /home/axboe/cdrom/exclude /opt/kernel/linux-2.6.10/drivers/ide/ide-disk.c linux-2.6.10/drivers/ide/ide-disk.c
--- /opt/kernel/linux-2.6.10/drivers/ide/ide-disk.c	2005-01-26 21:18:38.000000000 +0100
+++ linux-2.6.10/drivers/ide/ide-disk.c	2005-01-26 21:19:05.000000000 +0100
@@ -701,18 +701,54 @@ static ide_proc_entry_t idedisk_proc[] =
 
 #endif	/* CONFIG_PROC_FS */
 
-static int idedisk_issue_flush(request_queue_t *q, struct gendisk *disk,
-			       sector_t *error_sector)
+static void idedisk_end_flush(request_queue_t *q, struct request *flush_rq)
+{
+	ide_drive_t *drive = q->queuedata;
+	struct request *rq = flush_rq->end_io_data;
+	int good_sectors = rq->hard_nr_sectors;
+	int bad_sectors;
+	sector_t sector;
+
+	if (flush_rq->errors & ABRT_ERR) {
+		printk(KERN_ERR "%s: barrier support doesn't work\n", drive->name);
+		blk_queue_ordered(drive->queue, QUEUE_ORDERED_NONE);
+		blk_queue_issue_flush_fn(drive->queue, NULL);
+		good_sectors = 0;
+	} else if (flush_rq->errors) {
+		sector = ide_get_error_location(drive, flush_rq->buffer);
+		if ((sector >= rq->hard_sector) &&
+		    (sector < rq->hard_sector + rq->hard_nr_sectors))
+			good_sectors = sector - rq->hard_sector;
+		else
+			good_sectors = 0;
+	}
+
+	if (flush_rq->errors)
+		printk(KERN_ERR "%s: failed barrier write: "
+				"sector=%Lx(good=%d/bad=%d)\n",
+				drive->name, (unsigned long long)rq->sector,
+				good_sectors,
+				(int) (rq->hard_nr_sectors-good_sectors));
+
+	bad_sectors = rq->hard_nr_sectors - good_sectors;
+
+	spin_lock(&ide_lock);
+
+	if (good_sectors)
+		__ide_end_request(drive, rq, 1, good_sectors);
+	if (bad_sectors)
+		__ide_end_request(drive, rq, 0, bad_sectors);
+
+	spin_unlock(&ide_lock);
+}
+
+static int idedisk_prepare_flush(request_queue_t *q, struct request *rq)
 {
 	ide_drive_t *drive = q->queuedata;
-	struct request *rq;
-	int ret;
 
 	if (!drive->wcache)
 		return 0;
 
-	rq = blk_get_request(q, WRITE, __GFP_WAIT);
-
 	memset(rq->cmd, 0, sizeof(rq->cmd));
 
 	if (ide_id_has_flush_cache_ext(drive->id) &&
@@ -724,6 +760,22 @@ static int idedisk_issue_flush(request_q
 
 	rq->flags |= REQ_DRIVE_TASK | REQ_SOFTBARRIER;
 	rq->buffer = rq->cmd;
+	return 1;
+}
+
+static int idedisk_issue_flush(request_queue_t *q, struct gendisk *disk,
+			       sector_t *error_sector)
+{
+	ide_drive_t *drive = q->queuedata;
+	struct request *rq;
+	int ret;
+
+	if (!drive->wcache)
+		return 0;
+
+	rq = blk_get_request(q, WRITE, __GFP_WAIT);
+
+	idedisk_prepare_flush(q, rq);
 
 	ret = blk_execute_rq(q, disk, rq);
 
@@ -1101,10 +1153,15 @@ static void idedisk_setup (ide_drive_t *
 			barrier = 0;
 	}
 
-	printk(KERN_DEBUG "%s: cache flushes %ssupported\n",
+	if (!strncmp(drive->name, "hdc", 3))
+		barrier = 1;
+
+	printk(KERN_INFO "%s: cache flushes %ssupported\n",
 		drive->name, barrier ? "" : "not ");
 	if (barrier) {
-		blk_queue_ordered(drive->queue, 1);
+		blk_queue_ordered(drive->queue, QUEUE_ORDERED_FLUSH);
+		drive->queue->prepare_flush_fn = idedisk_prepare_flush;
+		drive->queue->end_flush_fn = idedisk_end_flush;
 		blk_queue_issue_flush_fn(drive->queue, idedisk_issue_flush);
 	}
 }
diff -urp -X /home/axboe/cdrom/exclude /opt/kernel/linux-2.6.10/drivers/ide/ide-io.c linux-2.6.10/drivers/ide/ide-io.c
--- /opt/kernel/linux-2.6.10/drivers/ide/ide-io.c	2005-01-26 21:18:38.000000000 +0100
+++ linux-2.6.10/drivers/ide/ide-io.c	2005-01-27 15:17:41.000000000 +0100
@@ -55,62 +55,8 @@
 #include <asm/io.h>
 #include <asm/bitops.h>
 
-static void ide_fill_flush_cmd(ide_drive_t *drive, struct request *rq)
-{
-	char *buf = rq->cmd;
-
-	/*
-	 * reuse cdb space for ata command
-	 */
-	memset(buf, 0, sizeof(rq->cmd));
-
-	rq->flags |= REQ_DRIVE_TASK | REQ_STARTED;
-	rq->buffer = buf;
-	rq->buffer[0] = WIN_FLUSH_CACHE;
-
-	if (ide_id_has_flush_cache_ext(drive->id) &&
-	    (drive->capacity64 >= (1UL << 28)))
-		rq->buffer[0] = WIN_FLUSH_CACHE_EXT;
-}
-
-/*
- * preempt pending requests, and store this cache flush for immediate
- * execution
- */
-static struct request *ide_queue_flush_cmd(ide_drive_t *drive,
-					   struct request *rq, int post)
-{
-	struct request *flush_rq = &HWGROUP(drive)->wrq;
-
-	/*
-	 * write cache disabled, clear the barrier bit and treat it like
-	 * an ordinary write
-	 */
-	if (!drive->wcache) {
-		rq->flags |= REQ_BAR_PREFLUSH;
-		return rq;
-	}
-
-	ide_init_drive_cmd(flush_rq);
-	ide_fill_flush_cmd(drive, flush_rq);
-
-	flush_rq->special = rq;
-	flush_rq->nr_sectors = rq->nr_sectors;
-
-	if (!post) {
-		drive->doing_barrier = 1;
-		flush_rq->flags |= REQ_BAR_PREFLUSH;
-		blkdev_dequeue_request(rq);
-	} else
-		flush_rq->flags |= REQ_BAR_POSTFLUSH;
-
-	__elv_add_request(drive->queue, flush_rq, ELEVATOR_INSERT_FRONT, 0);
-	HWGROUP(drive)->rq = NULL;
-	return flush_rq;
-}
-
-static int __ide_end_request(ide_drive_t *drive, struct request *rq,
-			     int uptodate, int nr_sectors)
+int __ide_end_request(ide_drive_t *drive, struct request *rq, int uptodate,
+		      int nr_sectors)
 {
 	int ret = 1;
 
@@ -148,6 +94,7 @@ static int __ide_end_request(ide_drive_t
 	}
 	return ret;
 }
+EXPORT_SYMBOL(__ide_end_request);
 
 /**
  *	ide_end_request		-	complete an IDE I/O
@@ -172,17 +119,10 @@ int ide_end_request (ide_drive_t *drive,
 	if (!nr_sectors)
 		nr_sectors = rq->hard_cur_sectors;
 
-	if (!blk_barrier_rq(rq) || !drive->wcache)
+	if (blk_complete_barrier_rq_locked(drive->queue, rq, nr_sectors))
+		ret = rq->nr_sectors != 0;
+	else
 		ret = __ide_end_request(drive, rq, uptodate, nr_sectors);
-	else {
-		struct request *flush_rq = &HWGROUP(drive)->wrq;
-
-		flush_rq->nr_sectors -= nr_sectors;
-		if (!flush_rq->nr_sectors) {
-			ide_queue_flush_cmd(drive, rq, 1);
-			ret = 0;
-		}
-	}
 
 	spin_unlock_irqrestore(&ide_lock, flags);
 	return ret;
@@ -252,79 +192,6 @@ u64 ide_get_error_location(ide_drive_t *
 }
 EXPORT_SYMBOL(ide_get_error_location);
 
-static void ide_complete_barrier(ide_drive_t *drive, struct request *rq,
-				 int error)
-{
-	struct request *real_rq = rq->special;
-	int good_sectors, bad_sectors;
-	sector_t sector;
-
-	if (!error) {
-		if (blk_barrier_postflush(rq)) {
-			/*
-			 * this completes the barrier write
-			 */
-			__ide_end_request(drive, real_rq, 1, real_rq->hard_nr_sectors);
-			drive->doing_barrier = 0;
-		} else {
-			/*
-			 * just indicate that we did the pre flush
-			 */
-			real_rq->flags |= REQ_BAR_PREFLUSH;
-			elv_requeue_request(drive->queue, real_rq);
-		}
-		/*
-		 * all is fine, return
-		 */
-		return;
-	}
-
-	/*
-	 * we need to end real_rq, but it's not on the queue currently.
-	 * put it back on the queue, so we don't have to special case
-	 * anything else for completing it
-	 */
-	if (!blk_barrier_postflush(rq))
-		elv_requeue_request(drive->queue, real_rq);
-
-	/*
-	 * drive aborted flush command, assume FLUSH_CACHE_* doesn't
-	 * work and disable barrier support
-	 */
-	if (error & ABRT_ERR) {
-		printk(KERN_ERR "%s: barrier support doesn't work\n", drive->name);
-		__ide_end_request(drive, real_rq, -EOPNOTSUPP, real_rq->hard_nr_sectors);
-		blk_queue_ordered(drive->queue, 0);
-		blk_queue_issue_flush_fn(drive->queue, NULL);
-	} else {
-		/*
-		 * find out what part of the request failed
-		 */
-		good_sectors = 0;
-		if (blk_barrier_postflush(rq)) {
-			sector = ide_get_error_location(drive, rq->buffer);
-
-			if ((sector >= real_rq->hard_sector) &&
-			    (sector < real_rq->hard_sector + real_rq->hard_nr_sectors))
-				good_sectors = sector - real_rq->hard_sector;
-		} else
-			sector = real_rq->hard_sector;
-
-		bad_sectors = real_rq->hard_nr_sectors - good_sectors;
-		if (good_sectors)
-			__ide_end_request(drive, real_rq, 1, good_sectors);
-		if (bad_sectors)
-			__ide_end_request(drive, real_rq, 0, bad_sectors);
-
-		printk(KERN_ERR "%s: failed barrier write: "
-				"sector=%Lx(good=%d/bad=%d)\n",
-				drive->name, (unsigned long long)sector,
-				good_sectors, bad_sectors);
-	}
-
-	drive->doing_barrier = 0;
-}
-
 /**
  *	ide_end_drive_cmd	-	end an explicit drive command
  *	@drive: command 
@@ -416,11 +283,8 @@ void ide_end_drive_cmd (ide_drive_t *dri
 
 	spin_lock_irqsave(&ide_lock, flags);
 	blkdev_dequeue_request(rq);
-
-	if (blk_barrier_preflush(rq) || blk_barrier_postflush(rq))
-		ide_complete_barrier(drive, rq, err);
-
 	HWGROUP(drive)->rq = NULL;
+	rq->errors = err;
 	end_that_request_last(rq);
 	spin_unlock_irqrestore(&ide_lock, flags);
 }
@@ -961,7 +825,7 @@ repeat:	
 	 * though that is 3 requests, it must be seen as a single transaction.
 	 * we must not preempt this drive until that is complete
 	 */
-	if (drive->doing_barrier) {
+	if (blk_queue_flushing(drive->queue)) {
 		/*
 		 * small race where queue could get replugged during
 		 * the 3-request flush cycle, just yank the plug since
@@ -1124,13 +988,6 @@ static void ide_do_request (ide_hwgroup_
 		}
 
 		/*
-		 * if rq is a barrier write, issue pre cache flush if not
-		 * already done
-		 */
-		if (blk_barrier_rq(rq) && !blk_barrier_preflush(rq))
-			rq = ide_queue_flush_cmd(drive, rq, 0);
-
-		/*
 		 * Sanity: don't accept a request that isn't a PM request
 		 * if we are currently power managed. This is very important as
 		 * blk_stop_queue() doesn't prevent the elv_next_request()
@@ -1604,6 +1461,7 @@ int ide_do_drive_cmd (ide_drive_t *drive
 	if (must_wait) {
 		rq->ref_count++;
 		rq->waiting = &wait;
+		rq->end_io = blk_end_sync_rq;
 	}
 
 	spin_lock_irqsave(&ide_lock, flags);
diff -urp -X /home/axboe/cdrom/exclude /opt/kernel/linux-2.6.10/drivers/ide/ide-tape.c linux-2.6.10/drivers/ide/ide-tape.c
--- /opt/kernel/linux-2.6.10/drivers/ide/ide-tape.c	2005-01-26 21:18:38.000000000 +0100
+++ linux-2.6.10/drivers/ide/ide-tape.c	2005-01-26 21:19:05.000000000 +0100
@@ -2720,6 +2720,7 @@ static void idetape_wait_for_request (id
 	}
 #endif /* IDETAPE_DEBUG_BUGS */
 	rq->waiting = &wait;
+	rq->end_io = blk_end_sync_rq;
 	spin_unlock_irq(&tape->spinlock);
 	wait_for_completion(&wait);
 	/* The stage and its struct request have been deallocated */
diff -urp -X /home/axboe/cdrom/exclude /opt/kernel/linux-2.6.10/drivers/scsi/ahci.c linux-2.6.10/drivers/scsi/ahci.c
--- /opt/kernel/linux-2.6.10/drivers/scsi/ahci.c	2005-01-26 21:18:33.000000000 +0100
+++ linux-2.6.10/drivers/scsi/ahci.c	2005-01-26 21:40:57.000000000 +0100
@@ -198,6 +198,7 @@ static Scsi_Host_Template ahci_sht = {
 	.dma_boundary		= AHCI_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
 	.bios_param		= ata_std_bios_param,
+	.ordered_flush		= 1,
 };
 
 static struct ata_port_operations ahci_ops = {
diff -urp -X /home/axboe/cdrom/exclude /opt/kernel/linux-2.6.10/drivers/scsi/ata_piix.c linux-2.6.10/drivers/scsi/ata_piix.c
--- /opt/kernel/linux-2.6.10/drivers/scsi/ata_piix.c	2005-01-26 21:18:35.000000000 +0100
+++ linux-2.6.10/drivers/scsi/ata_piix.c	2005-01-26 21:42:19.000000000 +0100
@@ -121,6 +121,7 @@ static Scsi_Host_Template piix_sht = {
 	.dma_boundary		= ATA_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
 	.bios_param		= ata_std_bios_param,
+	.ordered_flush		= 1,
 };
 
 static struct ata_port_operations piix_pata_ops = {
diff -urp -X /home/axboe/cdrom/exclude /opt/kernel/linux-2.6.10/drivers/scsi/hosts.c linux-2.6.10/drivers/scsi/hosts.c
--- /opt/kernel/linux-2.6.10/drivers/scsi/hosts.c	2005-01-26 21:18:33.000000000 +0100
+++ linux-2.6.10/drivers/scsi/hosts.c	2005-01-26 21:19:05.000000000 +0100
@@ -258,6 +258,16 @@ struct Scsi_Host *scsi_host_alloc(struct
 	shost->cmd_per_lun = sht->cmd_per_lun;
 	shost->unchecked_isa_dma = sht->unchecked_isa_dma;
 	shost->use_clustering = sht->use_clustering;
+	shost->ordered_flush = sht->ordered_flush;
+	shost->ordered_tag = sht->ordered_tag;
+
+	/*
+	 * hosts/devices that do queueing must support ordered tags
+	 */
+	if (shost->can_queue > 1 && shost->ordered_flush) {
+		printk(KERN_ERR "scsi: ordered flushes don't support queueing\n");
+		shost->ordered_flush = 0;
+	}
 
 	if (sht->max_host_blocked)
 		shost->max_host_blocked = sht->max_host_blocked;
diff -urp -X /home/axboe/cdrom/exclude /opt/kernel/linux-2.6.10/drivers/scsi/sata_nv.c linux-2.6.10/drivers/scsi/sata_nv.c
--- /opt/kernel/linux-2.6.10/drivers/scsi/sata_nv.c	2005-01-26 21:18:33.000000000 +0100
+++ linux-2.6.10/drivers/scsi/sata_nv.c	2005-01-26 21:41:14.000000000 +0100
@@ -194,6 +194,7 @@ static Scsi_Host_Template nv_sht = {
 	.dma_boundary		= ATA_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
 	.bios_param		= ata_std_bios_param,
+	.ordered_flush		= 1,
 };
 
 static struct ata_port_operations nv_ops = {
diff -urp -X /home/axboe/cdrom/exclude /opt/kernel/linux-2.6.10/drivers/scsi/sata_promise.c linux-2.6.10/drivers/scsi/sata_promise.c
--- /opt/kernel/linux-2.6.10/drivers/scsi/sata_promise.c	2005-01-26 21:18:34.000000000 +0100
+++ linux-2.6.10/drivers/scsi/sata_promise.c	2005-01-26 21:41:18.000000000 +0100
@@ -102,6 +102,7 @@ static Scsi_Host_Template pdc_ata_sht = 
 	.dma_boundary		= ATA_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
 	.bios_param		= ata_std_bios_param,
+	.ordered_flush		= 1,
 };
 
 static struct ata_port_operations pdc_ata_ops = {
diff -urp -X /home/axboe/cdrom/exclude /opt/kernel/linux-2.6.10/drivers/scsi/sata_sil.c linux-2.6.10/drivers/scsi/sata_sil.c
--- /opt/kernel/linux-2.6.10/drivers/scsi/sata_sil.c	2005-01-26 21:18:33.000000000 +0100
+++ linux-2.6.10/drivers/scsi/sata_sil.c	2005-01-26 21:41:22.000000000 +0100
@@ -123,6 +123,7 @@ static Scsi_Host_Template sil_sht = {
 	.dma_boundary		= ATA_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
 	.bios_param		= ata_std_bios_param,
+	.ordered_flush		= 1,
 };
 
 static struct ata_port_operations sil_ops = {
diff -urp -X /home/axboe/cdrom/exclude /opt/kernel/linux-2.6.10/drivers/scsi/sata_sis.c linux-2.6.10/drivers/scsi/sata_sis.c
--- /opt/kernel/linux-2.6.10/drivers/scsi/sata_sis.c	2005-01-26 21:18:34.000000000 +0100
+++ linux-2.6.10/drivers/scsi/sata_sis.c	2005-01-26 21:41:27.000000000 +0100
@@ -90,6 +90,7 @@ static Scsi_Host_Template sis_sht = {
 	.dma_boundary		= ATA_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
 	.bios_param		= ata_std_bios_param,
+	.ordered_flush		= 1,
 };
 
 static struct ata_port_operations sis_ops = {
diff -urp -X /home/axboe/cdrom/exclude /opt/kernel/linux-2.6.10/drivers/scsi/sata_svw.c linux-2.6.10/drivers/scsi/sata_svw.c
--- /opt/kernel/linux-2.6.10/drivers/scsi/sata_svw.c	2005-01-26 21:18:34.000000000 +0100
+++ linux-2.6.10/drivers/scsi/sata_svw.c	2005-01-26 21:41:32.000000000 +0100
@@ -288,6 +288,7 @@ static Scsi_Host_Template k2_sata_sht = 
 	.proc_info		= k2_sata_proc_info,
 #endif
 	.bios_param		= ata_std_bios_param,
+	.ordered_flush		= 1,
 };
 
 
diff -urp -X /home/axboe/cdrom/exclude /opt/kernel/linux-2.6.10/drivers/scsi/sata_sx4.c linux-2.6.10/drivers/scsi/sata_sx4.c
--- /opt/kernel/linux-2.6.10/drivers/scsi/sata_sx4.c	2005-01-26 21:18:32.000000000 +0100
+++ linux-2.6.10/drivers/scsi/sata_sx4.c	2005-01-26 21:41:37.000000000 +0100
@@ -188,6 +188,7 @@ static Scsi_Host_Template pdc_sata_sht =
 	.dma_boundary		= ATA_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
 	.bios_param		= ata_std_bios_param,
+	.ordered_flush		= 1,
 };
 
 static struct ata_port_operations pdc_20621_ops = {
diff -urp -X /home/axboe/cdrom/exclude /opt/kernel/linux-2.6.10/drivers/scsi/sata_uli.c linux-2.6.10/drivers/scsi/sata_uli.c
--- /opt/kernel/linux-2.6.10/drivers/scsi/sata_uli.c	2005-01-26 21:18:34.000000000 +0100
+++ linux-2.6.10/drivers/scsi/sata_uli.c	2005-01-26 21:41:41.000000000 +0100
@@ -82,6 +82,7 @@ static Scsi_Host_Template uli_sht = {
 	.dma_boundary		= ATA_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
 	.bios_param		= ata_std_bios_param,
+	.ordered_flush		= 1,
 };
 
 static struct ata_port_operations uli_ops = {
diff -urp -X /home/axboe/cdrom/exclude /opt/kernel/linux-2.6.10/drivers/scsi/sata_via.c linux-2.6.10/drivers/scsi/sata_via.c
--- /opt/kernel/linux-2.6.10/drivers/scsi/sata_via.c	2005-01-26 21:18:33.000000000 +0100
+++ linux-2.6.10/drivers/scsi/sata_via.c	2005-01-26 21:41:52.000000000 +0100
@@ -95,6 +95,7 @@ static Scsi_Host_Template svia_sht = {
 	.dma_boundary		= ATA_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
 	.bios_param		= ata_std_bios_param,
+	.ordered_flush		= 1,
 };
 
 static struct ata_port_operations svia_sata_ops = {
diff -urp -X /home/axboe/cdrom/exclude /opt/kernel/linux-2.6.10/drivers/scsi/sata_vsc.c linux-2.6.10/drivers/scsi/sata_vsc.c
--- /opt/kernel/linux-2.6.10/drivers/scsi/sata_vsc.c	2005-01-26 21:18:34.000000000 +0100
+++ linux-2.6.10/drivers/scsi/sata_vsc.c	2005-01-26 21:41:56.000000000 +0100
@@ -204,6 +204,7 @@ static Scsi_Host_Template vsc_sata_sht =
 	.dma_boundary		= ATA_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
 	.bios_param		= ata_std_bios_param,
+	.ordered_flush		= 1,
 };
 
 
diff -urp -X /home/axboe/cdrom/exclude /opt/kernel/linux-2.6.10/drivers/scsi/scsi_lib.c linux-2.6.10/drivers/scsi/scsi_lib.c
--- /opt/kernel/linux-2.6.10/drivers/scsi/scsi_lib.c	2005-01-26 21:18:34.000000000 +0100
+++ linux-2.6.10/drivers/scsi/scsi_lib.c	2005-01-27 15:11:09.000000000 +0100
@@ -697,6 +697,9 @@ void scsi_io_completion(struct scsi_cmnd
 	int clear_errors = 1;
 	struct scsi_sense_hdr sshdr;
 
+	if (blk_complete_barrier_rq(q, req, good_bytes << 9))
+		return;
+
 	/*
 	 * Free up any indirection buffers we allocated for DMA purposes. 
 	 * For the case of a READ, we need to copy the data out of the
@@ -964,6 +967,38 @@ static int scsi_init_io(struct scsi_cmnd
 	return BLKPREP_KILL;
 }
 
+static int scsi_prepare_flush_fn(request_queue_t *q, struct request *rq)
+{
+	struct scsi_device *sdev = q->queuedata;
+	struct scsi_driver *drv;
+
+	if (sdev->sdev_state == SDEV_RUNNING) {
+		drv = *(struct scsi_driver **) rq->rq_disk->private_data;
+
+		if (drv->prepare_flush)
+			return drv->prepare_flush(q, rq);
+	}
+
+	return 0;
+}
+
+static void scsi_end_flush_fn(request_queue_t *q, struct request *rq)
+{
+	struct scsi_device *sdev = q->queuedata;
+	struct request *flush_rq = rq->end_io_data;
+	struct scsi_driver *drv;
+
+	if (flush_rq->errors) {
+		printk("scsi: barrier error, disabling flush support\n");
+		blk_queue_ordered(q, QUEUE_ORDERED_NONE);
+	}
+
+	if (sdev->sdev_state == SDEV_RUNNING) {
+		drv = *(struct scsi_driver **) rq->rq_disk->private_data;
+		drv->end_flush(q, rq);
+	}
+}
+
 static int scsi_issue_flush_fn(request_queue_t *q, struct gendisk *disk,
 			       sector_t *error_sector)
 {
@@ -1368,6 +1403,17 @@ struct request_queue *scsi_alloc_queue(s
 	blk_queue_segment_boundary(q, shost->dma_boundary);
 	blk_queue_issue_flush_fn(q, scsi_issue_flush_fn);
 
+	/*
+	 * ordered tags are superior to flush ordering
+	 */
+	if (shost->ordered_tag)
+		blk_queue_ordered(q, QUEUE_ORDERED_TAG);
+	else if (shost->ordered_flush) {
+		blk_queue_ordered(q, QUEUE_ORDERED_FLUSH);
+		q->prepare_flush_fn = scsi_prepare_flush_fn;
+		q->end_flush_fn = scsi_end_flush_fn;
+	}
+
 	if (!shost->use_clustering)
 		clear_bit(QUEUE_FLAG_CLUSTER, &q->queue_flags);
 	return q;
diff -urp -X /home/axboe/cdrom/exclude /opt/kernel/linux-2.6.10/drivers/scsi/sd.c linux-2.6.10/drivers/scsi/sd.c
--- /opt/kernel/linux-2.6.10/drivers/scsi/sd.c	2005-01-26 21:18:34.000000000 +0100
+++ linux-2.6.10/drivers/scsi/sd.c	2005-01-27 16:05:14.000000000 +0100
@@ -121,6 +121,8 @@ static void sd_shutdown(struct device *d
 static void sd_rescan(struct device *);
 static int sd_init_command(struct scsi_cmnd *);
 static int sd_issue_flush(struct device *, sector_t *);
+static void sd_end_flush(request_queue_t *, struct request *);
+static int sd_prepare_flush(request_queue_t *, struct request *);
 static void sd_read_capacity(struct scsi_disk *sdkp, char *diskname,
 		 struct scsi_request *SRpnt, unsigned char *buffer);
 
@@ -135,6 +137,8 @@ static struct scsi_driver sd_template = 
 	.rescan			= sd_rescan,
 	.init_command		= sd_init_command,
 	.issue_flush		= sd_issue_flush,
+	.prepare_flush		= sd_prepare_flush,
+	.end_flush		= sd_end_flush,
 };
 
 /*
@@ -734,6 +738,33 @@ static int sd_issue_flush(struct device 
 	return sd_sync_cache(sdp);
 }
 
+static void sd_end_flush(request_queue_t *q, struct request *flush_rq)
+{
+	struct request *rq = flush_rq->end_io_data;
+	struct scsi_cmnd *cmd = rq->special;
+	unsigned int bytes = rq->hard_nr_sectors << 9;
+
+	if (!flush_rq->errors)
+		scsi_io_completion(cmd, bytes, 0);
+	else
+		scsi_io_completion(cmd, 0, bytes);
+}
+
+static int sd_prepare_flush(request_queue_t *q, struct request *rq)
+{
+	struct scsi_device *sdev = q->queuedata;
+	struct scsi_disk *sdkp = dev_get_drvdata(&sdev->sdev_gendev);
+
+	if (sdkp->WCE) {
+		memset(rq->cmd, 0, sizeof(rq->cmd));
+		rq->flags = REQ_BLOCK_PC | REQ_SOFTBARRIER;
+		rq->cmd[0] = SYNCHRONIZE_CACHE;
+		return 1;
+	}
+
+	return 0;
+}
+
 static void sd_rescan(struct device *dev)
 {
 	struct scsi_disk *sdkp = dev_get_drvdata(dev);
diff -urp -X /home/axboe/cdrom/exclude /opt/kernel/linux-2.6.10/include/linux/blkdev.h linux-2.6.10/include/linux/blkdev.h
--- /opt/kernel/linux-2.6.10/include/linux/blkdev.h	2005-01-26 21:18:13.000000000 +0100
+++ linux-2.6.10/include/linux/blkdev.h	2005-01-27 15:55:12.000000000 +0100
@@ -93,6 +93,9 @@ struct io_context *get_io_context(int gf
 void copy_io_context(struct io_context **pdst, struct io_context **psrc);
 void swap_io_context(struct io_context **ioc1, struct io_context **ioc2);
 
+struct request;
+typedef void (rq_end_io_fn)(struct request *);
+
 struct request_list {
 	int count[2];
 	int starved[2];
@@ -176,6 +179,12 @@ struct request {
 	 * For Power Management requests
 	 */
 	struct request_pm_state *pm;
+
+	/*
+	 * completion callback. end_io_data should be folded in with waiting
+	 */
+	rq_end_io_fn *end_io;
+	void *end_io_data;
 };
 
 /*
@@ -266,6 +275,8 @@ struct bio_vec;
 typedef int (merge_bvec_fn) (request_queue_t *, struct bio *, struct bio_vec *);
 typedef void (activity_fn) (void *data, int rw);
 typedef int (issue_flush_fn) (request_queue_t *, struct gendisk *, sector_t *);
+typedef int (prepare_flush_fn) (request_queue_t *, struct request *);
+typedef void (end_flush_fn) (request_queue_t *, struct request *);
 
 enum blk_queue_state {
 	Queue_down,
@@ -309,6 +320,8 @@ struct request_queue
 	merge_bvec_fn		*merge_bvec_fn;
 	activity_fn		*activity_fn;
 	issue_flush_fn		*issue_flush_fn;
+	prepare_flush_fn	*prepare_flush_fn;
+	end_flush_fn		*end_flush_fn;
 
 	/*
 	 * Auto-unplugging state
@@ -380,6 +393,18 @@ struct request_queue
 	unsigned int		sg_reserved_size;
 
 	struct list_head	drain_list;
+
+	/*
+	 * reserved for flush operations
+	 */
+	struct request		*flush_rq;
+	unsigned char		ordered;
+};
+
+enum {
+	QUEUE_ORDERED_NONE,
+	QUEUE_ORDERED_TAG,
+	QUEUE_ORDERED_FLUSH,
 };
 
 #define RQ_INACTIVE		(-1)
@@ -396,12 +421,13 @@ struct request_queue
 #define QUEUE_FLAG_DEAD		5	/* queue being torn down */
 #define QUEUE_FLAG_REENTER	6	/* Re-entrancy avoidance */
 #define QUEUE_FLAG_PLUGGED	7	/* queue is plugged */
-#define QUEUE_FLAG_ORDERED	8	/* supports ordered writes */
-#define QUEUE_FLAG_DRAIN	9	/* draining queue for sched switch */
+#define QUEUE_FLAG_DRAIN	8	/* draining queue for sched switch */
+#define QUEUE_FLAG_FLUSH	9	/* doing barrier flush sequence */
 
 #define blk_queue_plugged(q)	test_bit(QUEUE_FLAG_PLUGGED, &(q)->queue_flags)
 #define blk_queue_tagged(q)	test_bit(QUEUE_FLAG_QUEUED, &(q)->queue_flags)
 #define blk_queue_stopped(q)	test_bit(QUEUE_FLAG_STOPPED, &(q)->queue_flags)
+#define blk_queue_flushing(q)	test_bit(QUEUE_FLAG_FLUSH, &(q)->queue_flags)
 
 #define blk_fs_request(rq)	((rq)->flags & REQ_CMD)
 #define blk_pc_request(rq)	((rq)->flags & REQ_BLOCK_PC)
@@ -509,10 +535,10 @@ extern void blk_unregister_queue(struct 
 extern void register_disk(struct gendisk *dev);
 extern void generic_make_request(struct bio *bio);
 extern void blk_put_request(struct request *);
+extern void blk_end_sync_rq(struct request *rq);
 extern void blk_attempt_remerge(request_queue_t *, struct request *);
 extern void __blk_attempt_remerge(request_queue_t *, struct request *);
 extern struct request *blk_get_request(request_queue_t *, int, int);
-extern void blk_put_request(struct request *);
 extern void blk_insert_request(request_queue_t *, struct request *, int, void *, int);
 extern void blk_requeue_request(request_queue_t *, struct request *);
 extern void blk_plug_device(request_queue_t *);
@@ -602,6 +628,9 @@ extern struct backing_dev_info *blk_get_
 extern void blk_queue_ordered(request_queue_t *, int);
 extern void blk_queue_issue_flush_fn(request_queue_t *, issue_flush_fn *);
 extern int blkdev_scsi_issue_flush_fn(request_queue_t *, struct gendisk *, sector_t *);
+extern struct request *blk_start_pre_flush(request_queue_t *,struct request *);
+extern int blk_complete_barrier_rq(request_queue_t *, struct request *, int);
+extern int blk_complete_barrier_rq_locked(request_queue_t *, struct request *, int);
 
 extern int blk_rq_map_sg(request_queue_t *, struct request *, struct scatterlist *);
 extern void blk_dump_rq_flags(struct request *, char *);
diff -urp -X /home/axboe/cdrom/exclude /opt/kernel/linux-2.6.10/include/linux/ide.h linux-2.6.10/include/linux/ide.h
--- /opt/kernel/linux-2.6.10/include/linux/ide.h	2005-01-26 21:18:14.000000000 +0100
+++ linux-2.6.10/include/linux/ide.h	2005-01-26 21:19:05.000000000 +0100
@@ -743,7 +743,6 @@ typedef struct ide_drive_s {
 	u8	sect;		/* "real" sectors per track */
 	u8	bios_head;	/* BIOS/fdisk/LILO number of heads */
 	u8	bios_sect;	/* BIOS/fdisk/LILO sectors per track */
-	u8	doing_barrier;	/* state, 1=currently doing flush */
 
 	unsigned int	bios_cyl;	/* BIOS/fdisk/LILO number of cyls */
 	unsigned int	cyl;		/* "real" number of cyls */
@@ -1131,6 +1130,7 @@ extern	ide_hwif_t	ide_hwifs[];		/* maste
 extern int noautodma;
 
 extern int ide_end_request (ide_drive_t *drive, int uptodate, int nrsecs);
+extern int __ide_end_request (ide_drive_t *drive, struct request *rq, int uptodate, int nrsecs);
 
 /*
  * This is used on exit from the driver to designate the next irq handler
diff -urp -X /home/axboe/cdrom/exclude /opt/kernel/linux-2.6.10/include/scsi/scsi_driver.h linux-2.6.10/include/scsi/scsi_driver.h
--- /opt/kernel/linux-2.6.10/include/scsi/scsi_driver.h	2005-01-26 21:18:15.000000000 +0100
+++ linux-2.6.10/include/scsi/scsi_driver.h	2005-01-26 21:19:05.000000000 +0100
@@ -14,6 +14,8 @@ struct scsi_driver {
 	int (*init_command)(struct scsi_cmnd *);
 	void (*rescan)(struct device *);
 	int (*issue_flush)(struct device *, sector_t *);
+	int (*prepare_flush)(struct request_queue *, struct request *);
+	void (*end_flush)(struct request_queue *, struct request *);
 };
 #define to_scsi_driver(drv) \
 	container_of((drv), struct scsi_driver, gendrv)
diff -urp -X /home/axboe/cdrom/exclude /opt/kernel/linux-2.6.10/include/scsi/scsi_host.h linux-2.6.10/include/scsi/scsi_host.h
--- /opt/kernel/linux-2.6.10/include/scsi/scsi_host.h	2005-01-26 21:18:15.000000000 +0100
+++ linux-2.6.10/include/scsi/scsi_host.h	2005-01-26 21:19:05.000000000 +0100
@@ -352,6 +352,12 @@ struct scsi_host_template {
 	unsigned skip_settle_delay:1;
 
 	/*
+	 * ordered write support
+	 */
+	unsigned ordered_flush:1;
+	unsigned ordered_tag:1;
+
+	/*
 	 * Countdown for host blocking with no commands outstanding
 	 */
 	unsigned int max_host_blocked;
@@ -491,6 +497,12 @@ struct Scsi_Host {
 	unsigned reverse_ordering:1;
 
 	/*
+	 * ordered write support
+	 */
+	unsigned ordered_flush:1;
+	unsigned ordered_tag:1;
+
+	/*
 	 * Host has rejected a command because it was busy.
 	 */
 	unsigned int host_blocked;


-- 
Jens Axboe

