Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262933AbUCKIhc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 03:37:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262954AbUCKIhN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 03:37:13 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:32653 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262641AbUCKIgV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 03:36:21 -0500
Date: Thu, 11 Mar 2004 09:36:19 +0100
From: Jens Axboe <axboe@suse.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, kenneth.w.chen@intel.com
Subject: [PATCH] per-backing dev unplugging #2
Message-ID: <20040311083619.GH6955@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Final version, unless something stupid pops up. Changes:

- Adapt to 2.6.4-mm1
- Cleaned up the dm bits, much nicer with the lockless unplugging
  (thanks Joe)
- md and loop unplugging, stacked devices should unplug their targets.
  Otherwise they'll end up waiting for the unplug timer, which sucks.
- XFS fixed up, I hope. XFS folks still encouraged to look at this,
  looks better this time around though (and works, I tested).
- blk_run_* inlined in blkdev.h

Against 2.6.4-mm1 (note you need other attached patch to boot it).

diff -ur -X /home/axboe/cdrom/exclude /opt/kernel/linux-2.6.4-mm1/drivers/block/ll_rw_blk.c linux-2.6.4-mm1/drivers/block/ll_rw_blk.c
--- /opt/kernel/linux-2.6.4-mm1/drivers/block/ll_rw_blk.c	2004-03-11 09:10:00.000000000 +0100
+++ linux-2.6.4-mm1/drivers/block/ll_rw_blk.c	2004-03-11 09:07:12.000000000 +0100
@@ -42,12 +42,6 @@
  */
 static kmem_cache_t *request_cachep;
 
-/*
- * plug management
- */
-static LIST_HEAD(blk_plug_list);
-static spinlock_t blk_plug_lock __cacheline_aligned_in_smp = SPIN_LOCK_UNLOCKED;
-
 static wait_queue_head_t congestion_wqh[2];
 
 /*
@@ -248,8 +242,6 @@
 	 */
 	blk_queue_bounce_limit(q, BLK_BOUNCE_HIGH);
 
-	INIT_LIST_HEAD(&q->plug_list);
-
 	blk_queue_activity_fn(q, NULL, NULL);
 }
 
@@ -1101,13 +1093,11 @@
 	 * don't plug a stopped queue, it must be paired with blk_start_queue()
 	 * which will restart the queueing
 	 */
-	if (!blk_queue_plugged(q)
-	    && !test_bit(QUEUE_FLAG_STOPPED, &q->queue_flags)) {
-		spin_lock(&blk_plug_lock);
-		list_add_tail(&q->plug_list, &blk_plug_list);
+	if (test_bit(QUEUE_FLAG_STOPPED, &q->queue_flags))
+		return;
+
+	if (!test_and_set_bit(QUEUE_FLAG_PLUGGED, &q->queue_flags))
 		mod_timer(&q->unplug_timer, jiffies + q->unplug_delay);
-		spin_unlock(&blk_plug_lock);
-	}
 }
 
 EXPORT_SYMBOL(blk_plug_device);
@@ -1119,15 +1109,12 @@
 int blk_remove_plug(request_queue_t *q)
 {
 	WARN_ON(!irqs_disabled());
-	if (blk_queue_plugged(q)) {
-		spin_lock(&blk_plug_lock);
-		list_del_init(&q->plug_list);
-		del_timer(&q->unplug_timer);
-		spin_unlock(&blk_plug_lock);
-		return 1;
-	}
 
-	return 0;
+	if (!test_and_clear_bit(QUEUE_FLAG_PLUGGED, &q->queue_flags))
+		return 0;
+
+	del_timer(&q->unplug_timer);
+	return 1;
 }
 
 EXPORT_SYMBOL(blk_remove_plug);
@@ -1158,14 +1145,11 @@
  *   Linux uses plugging to build bigger requests queues before letting
  *   the device have at them. If a queue is plugged, the I/O scheduler
  *   is still adding and merging requests on the queue. Once the queue
- *   gets unplugged (either by manually calling this function, or by
- *   calling blk_run_queues()), the request_fn defined for the
- *   queue is invoked and transfers started.
+ *   gets unplugged, the request_fn defined for the queue is invoked and
+ *   transfers started.
  **/
-void generic_unplug_device(void *data)
+void generic_unplug_device(request_queue_t *q)
 {
-	request_queue_t *q = data;
-
 	spin_lock_irq(q->queue_lock);
 	__generic_unplug_device(q);
 	spin_unlock_irq(q->queue_lock);
@@ -1173,9 +1157,23 @@
 
 EXPORT_SYMBOL(generic_unplug_device);
 
+static inline void blk_backing_dev_unplug(struct backing_dev_info *bdi)
+{
+	request_queue_t *q = bdi->unplug_io_data;
+
+	/*
+	 * devices don't necessarily have an ->unplug_fn defined
+	 */
+	if (q->unplug_fn)
+		q->unplug_fn(q);
+}
+
+EXPORT_SYMBOL(blk_backing_dev_unplug);
+
 static void blk_unplug_work(void *data)
 {
 	request_queue_t *q = data;
+
 	q->unplug_fn(q);
 }
 
@@ -1253,42 +1251,6 @@
 EXPORT_SYMBOL(blk_run_queue);
 
 /**
- * blk_run_queues - fire all plugged queues
- *
- * Description:
- *   Start I/O on all plugged queues known to the block layer. Queues that
- *   are currently stopped are ignored. This is equivalent to the older
- *   tq_disk task queue run.
- **/
-#define blk_plug_entry(entry) list_entry((entry), request_queue_t, plug_list)
-void blk_run_queues(void)
-{
-	LIST_HEAD(local_plug_list);
-
-	spin_lock_irq(&blk_plug_lock);
-
-	/*
-	 * this will happen fairly often
-	 */
-	if (list_empty(&blk_plug_list))
-		goto out;
-
-	list_splice_init(&blk_plug_list, &local_plug_list);
-	
-	while (!list_empty(&local_plug_list)) {
-		request_queue_t *q = blk_plug_entry(local_plug_list.next);
-
-		spin_unlock_irq(&blk_plug_lock);
-		q->unplug_fn(q);
-		spin_lock_irq(&blk_plug_lock);
-	}
-out:
-	spin_unlock_irq(&blk_plug_lock);
-}
-
-EXPORT_SYMBOL(blk_run_queues);
-
-/**
  * blk_cleanup_queue: - release a &request_queue_t when it is no longer needed
  * @q:    the request queue to be released
  *
@@ -1393,6 +1355,10 @@
 	memset(q, 0, sizeof(*q));
 	init_timer(&q->unplug_timer);
 	atomic_set(&q->refcnt, 1);
+
+	q->backing_dev_info.unplug_io_fn = blk_backing_dev_unplug;
+	q->backing_dev_info.unplug_io_data = q;
+
 	return q;
 }
 
@@ -2046,7 +2012,6 @@
 	DEFINE_WAIT(wait);
 	wait_queue_head_t *wqh = &congestion_wqh[rw];
 
-	blk_run_queues();
 	prepare_to_wait(wqh, &wait, TASK_UNINTERRUPTIBLE);
 	ret = io_schedule_timeout(timeout);
 	finish_wait(wqh, &wait);
@@ -2302,7 +2267,7 @@
 	if (blk_queue_plugged(q)) {
 		int nr_queued = q->rq.count[READ] + q->rq.count[WRITE];
 
-		if (nr_queued == q->unplug_thresh)
+		if (nr_queued == q->unplug_thresh || bio_sync(bio))
 			__generic_unplug_device(q);
 	}
 	spin_unlock_irq(q->queue_lock);
diff -ur -X /home/axboe/cdrom/exclude /opt/kernel/linux-2.6.4-mm1/drivers/block/loop.c linux-2.6.4-mm1/drivers/block/loop.c
--- /opt/kernel/linux-2.6.4-mm1/drivers/block/loop.c	2004-03-11 09:10:00.000000000 +0100
+++ linux-2.6.4-mm1/drivers/block/loop.c	2004-03-11 09:07:12.000000000 +0100
@@ -434,6 +434,17 @@
 	goto out;
 }
 
+/*
+ * kick off io on the underlying address space
+ */
+static void loop_unplug(request_queue_t *q)
+{
+	struct loop_device *lo = q->queuedata;
+
+	clear_bit(QUEUE_FLAG_PLUGGED, &q->queue_flags);
+	blk_run_address_space(lo->lo_backing_file->f_mapping);
+}
+
 struct switch_request {
 	struct file *file;
 	struct completion wait;
@@ -614,7 +625,6 @@
 {
 	struct file	*file;
 	struct inode	*inode;
-	struct block_device *lo_device = NULL;
 	struct address_space *mapping;
 	unsigned lo_blocksize;
 	int		lo_flags = 0;
@@ -671,7 +681,7 @@
 	set_device_ro(bdev, (lo_flags & LO_FLAGS_READ_ONLY) != 0);
 
 	lo->lo_blocksize = lo_blocksize;
-	lo->lo_device = lo_device;
+	lo->lo_device = bdev;
 	lo->lo_flags = lo_flags;
 	lo->lo_backing_file = file;
 	lo->transfer = NULL;
@@ -689,6 +699,7 @@
 	 */
 	blk_queue_make_request(lo->lo_queue, loop_make_request);
 	lo->lo_queue->queuedata = lo;
+	lo->lo_queue->unplug_fn = loop_unplug;
 
 	set_capacity(disks[lo->lo_number], size);
 
diff -ur -X /home/axboe/cdrom/exclude /opt/kernel/linux-2.6.4-mm1/drivers/md/dm.c linux-2.6.4-mm1/drivers/md/dm.c
--- /opt/kernel/linux-2.6.4-mm1/drivers/md/dm.c	2004-03-11 09:10:01.000000000 +0100
+++ linux-2.6.4-mm1/drivers/md/dm.c	2004-03-11 09:07:12.000000000 +0100
@@ -575,6 +575,14 @@
 	return 0;
 }
 
+static void dm_unplug_all(request_queue_t *q)
+{
+	struct mapped_device *md = q->queuedata;
+
+	clear_bit(QUEUE_FLAG_PLUGGED, &q->queue_flags);
+	dm_table_unplug_all(md->map);
+}
+
 static int dm_any_congested(void *congested_data, int bdi_bits)
 {
 	int r;
@@ -672,6 +680,7 @@
 	md->queue->backing_dev_info.congested_fn = dm_any_congested;
 	md->queue->backing_dev_info.congested_data = md;
 	blk_queue_make_request(md->queue, dm_request);
+	md->queue->unplug_fn = dm_unplug_all;
 
 	md->io_pool = mempool_create(MIN_IOS, mempool_alloc_slab,
 				     mempool_free_slab, _io_cache);
@@ -900,7 +909,7 @@
 	 * Then we wait for the already mapped ios to
 	 * complete.
 	 */
-	blk_run_queues();
+	dm_table_unplug_all(md->map);
 	while (1) {
 		set_current_state(TASK_INTERRUPTIBLE);
 
@@ -947,7 +956,7 @@
 	up_write(&md->lock);
 	dm_table_put(map);
 
-	blk_run_queues();
+	dm_table_unplug_all(md->map);
 
 	return 0;
 }
diff -ur -X /home/axboe/cdrom/exclude /opt/kernel/linux-2.6.4-mm1/drivers/md/dm-crypt.c linux-2.6.4-mm1/drivers/md/dm-crypt.c
--- /opt/kernel/linux-2.6.4-mm1/drivers/md/dm-crypt.c	2004-03-11 09:10:01.000000000 +0100
+++ linux-2.6.4-mm1/drivers/md/dm-crypt.c	2004-03-11 09:07:12.000000000 +0100
@@ -668,7 +668,7 @@
 
 		/* out of memory -> run queues */
 		if (remaining)
-			blk_run_queues();
+			blk_congestion_wait(bio_data_dir(clone), HZ/100);
 	}
 
 	/* drop reference, clones could have returned before we reach this */
diff -ur -X /home/axboe/cdrom/exclude /opt/kernel/linux-2.6.4-mm1/drivers/md/dm.h linux-2.6.4-mm1/drivers/md/dm.h
--- /opt/kernel/linux-2.6.4-mm1/drivers/md/dm.h	2004-03-11 09:10:01.000000000 +0100
+++ linux-2.6.4-mm1/drivers/md/dm.h	2004-03-11 09:07:12.000000000 +0100
@@ -116,6 +116,7 @@
 void dm_table_suspend_targets(struct dm_table *t);
 void dm_table_resume_targets(struct dm_table *t);
 int dm_table_any_congested(struct dm_table *t, int bdi_bits);
+void dm_table_unplug_all(struct dm_table *t);
 
 /*-----------------------------------------------------------------
  * A registry of target types.
diff -ur -X /home/axboe/cdrom/exclude /opt/kernel/linux-2.6.4-mm1/drivers/md/dm-table.c linux-2.6.4-mm1/drivers/md/dm-table.c
--- /opt/kernel/linux-2.6.4-mm1/drivers/md/dm-table.c	2004-03-11 09:10:01.000000000 +0100
+++ linux-2.6.4-mm1/drivers/md/dm-table.c	2004-03-11 09:07:12.000000000 +0100
@@ -885,6 +885,21 @@
 	return r;
 }
 
+void dm_table_unplug_all(struct dm_table *t)
+{
+	struct list_head *d, *devices = dm_table_get_devices(t);
+
+	for (d = devices->next; d != devices; d = d->next) {
+		struct dm_dev *dd = list_entry(d, struct dm_dev, list);
+		request_queue_t *q = bdev_get_queue(dd->bdev);
+
+		if (q->unplug_fn) {
+			set_bit(QUEUE_FLAG_PLUGGED, &q->queue_flags);
+			q->unplug_fn(q);
+		}
+	}
+}
+
 EXPORT_SYMBOL(dm_vcalloc);
 EXPORT_SYMBOL(dm_get_device);
 EXPORT_SYMBOL(dm_put_device);
diff -ur -X /home/axboe/cdrom/exclude /opt/kernel/linux-2.6.4-mm1/drivers/md/md.c linux-2.6.4-mm1/drivers/md/md.c
--- /opt/kernel/linux-2.6.4-mm1/drivers/md/md.c	2004-03-11 09:10:01.000000000 +0100
+++ linux-2.6.4-mm1/drivers/md/md.c	2004-03-11 09:07:12.000000000 +0100
@@ -160,6 +160,28 @@
 	return 0;
 }
 
+static void md_unplug_all(request_queue_t *q)
+{
+	mddev_t *mddev = q->queuedata;
+	struct list_head *tmp;
+	mdk_rdev_t *rdev;
+
+	clear_bit(QUEUE_FLAG_PLUGGED, &q->queue_flags);
+
+	/*
+	 * this list iteration is done without any locking in md?!
+	 */
+	ITERATE_RDEV(mddev, rdev, tmp) {
+		request_queue_t *r_queue = bdev_get_queue(rdev->bdev);
+
+		if (r_queue->unplug_fn) {
+			set_bit(QUEUE_FLAG_PLUGGED, &r_queue->queue_flags);
+			r_queue->unplug_fn(r_queue);
+		}
+	}
+
+}
+
 static inline mddev_t *mddev_get(mddev_t *mddev)
 {
 	atomic_inc(&mddev->active);
@@ -335,6 +357,8 @@
 	struct bio_vec vec;
 	struct completion event;
 
+	rw |= (1 << BIO_RW_SYNC);
+
 	bio_init(&bio);
 	bio.bi_io_vec = &vec;
 	vec.bv_page = page;
@@ -349,7 +373,6 @@
 	bio.bi_private = &event;
 	bio.bi_end_io = bi_complete;
 	submit_bio(rw, &bio);
-	blk_run_queues();
 	wait_for_completion(&event);
 
 	return test_bit(BIO_UPTODATE, &bio.bi_flags);
@@ -1644,6 +1667,7 @@
 	 */
 	mddev->queue->queuedata = mddev;
 	mddev->queue->make_request_fn = mddev->pers->make_request;
+	mddev->queue->unplug_fn = md_unplug_all;
 
 	mddev->changed = 1;
 	return 0;
@@ -2718,7 +2742,7 @@
 		run = thread->run;
 		if (run) {
 			run(thread->mddev);
-			blk_run_queues();
+			blk_run_queue(thread->mddev->queue);
 		}
 		if (signal_pending(current))
 			flush_signals(current);
@@ -3286,7 +3310,7 @@
 		    test_bit(MD_RECOVERY_ERR, &mddev->recovery))
 			break;
 
-		blk_run_queues();
+		blk_run_queue(mddev->queue);
 
 	repeat:
 		if (jiffies >= mark[last_mark] + SYNC_MARK_STEP ) {
diff -ur -X /home/axboe/cdrom/exclude /opt/kernel/linux-2.6.4-mm1/drivers/md/raid1.c linux-2.6.4-mm1/drivers/md/raid1.c
--- /opt/kernel/linux-2.6.4-mm1/drivers/md/raid1.c	2004-03-11 03:55:28.000000000 +0100
+++ linux-2.6.4-mm1/drivers/md/raid1.c	2004-03-11 09:07:12.000000000 +0100
@@ -451,6 +451,7 @@
 
 static void device_barrier(conf_t *conf, sector_t sect)
 {
+	blk_run_queue(conf->mddev->queue);
 	spin_lock_irq(&conf->resync_lock);
 	wait_event_lock_irq(conf->wait_idle, !waitqueue_active(&conf->wait_resume), conf->resync_lock);
 	
@@ -478,6 +479,7 @@
 	 * thread has put up a bar for new requests.
 	 * Continue immediately if no resync is active currently.
 	 */
+	blk_run_queue(conf->mddev->queue);
 	spin_lock_irq(&conf->resync_lock);
 	wait_event_lock_irq(conf->wait_resume, !conf->barrier, conf->resync_lock);
 	conf->nr_pending++;
@@ -644,6 +646,7 @@
 
 static void close_sync(conf_t *conf)
 {
+	blk_run_queue(conf->mddev->queue);
 	spin_lock_irq(&conf->resync_lock);
 	wait_event_lock_irq(conf->wait_resume, !conf->barrier, conf->resync_lock);
 	spin_unlock_irq(&conf->resync_lock);
diff -ur -X /home/axboe/cdrom/exclude /opt/kernel/linux-2.6.4-mm1/drivers/md/raid5.c linux-2.6.4-mm1/drivers/md/raid5.c
--- /opt/kernel/linux-2.6.4-mm1/drivers/md/raid5.c	2004-03-11 09:10:01.000000000 +0100
+++ linux-2.6.4-mm1/drivers/md/raid5.c	2004-03-11 09:07:12.000000000 +0100
@@ -249,6 +249,7 @@
 				break;
 			if (!sh) {
 				conf->inactive_blocked = 1;
+				blk_run_queue(conf->mddev->queue);
 				wait_event_lock_irq(conf->wait_for_stripe,
 						    !list_empty(&conf->inactive_list) &&
 						    (atomic_read(&conf->active_stripes) < (NR_STRIPES *3/4)
@@ -1292,9 +1293,8 @@
 		}
 	}
 }
-static void raid5_unplug_device(void *data)
+static void raid5_unplug_device(request_queue_t *q)
 {
-	request_queue_t *q = data;
 	mddev_t *mddev = q->queuedata;
 	raid5_conf_t *conf = mddev_to_conf(mddev);
 	unsigned long flags;
diff -ur -X /home/axboe/cdrom/exclude /opt/kernel/linux-2.6.4-mm1/drivers/md/raid6main.c linux-2.6.4-mm1/drivers/md/raid6main.c
--- /opt/kernel/linux-2.6.4-mm1/drivers/md/raid6main.c	2004-03-11 09:10:01.000000000 +0100
+++ linux-2.6.4-mm1/drivers/md/raid6main.c	2004-03-11 09:07:12.000000000 +0100
@@ -1454,9 +1454,8 @@
 		}
 	}
 }
-static void raid6_unplug_device(void *data)
+static void raid6_unplug_device(request_queue_t *q)
 {
-	request_queue_t *q = data;
 	mddev_t *mddev = q->queuedata;
 	raid6_conf_t *conf = mddev_to_conf(mddev);
 	unsigned long flags;
diff -ur -X /home/axboe/cdrom/exclude /opt/kernel/linux-2.6.4-mm1/drivers/mtd/devices/blkmtd.c linux-2.6.4-mm1/drivers/mtd/devices/blkmtd.c
--- /opt/kernel/linux-2.6.4-mm1/drivers/mtd/devices/blkmtd.c	2004-03-11 03:55:21.000000000 +0100
+++ linux-2.6.4-mm1/drivers/mtd/devices/blkmtd.c	2004-03-11 09:07:12.000000000 +0100
@@ -147,8 +147,7 @@
 		bio->bi_private = &event;
 		bio->bi_end_io = bi_read_complete;
 		if(bio_add_page(bio, page, PAGE_SIZE, 0) == PAGE_SIZE) {
-			submit_bio(READ, bio);
-			blk_run_queues();
+			submit_bio(READ_SYNC, bio);
 			wait_for_completion(&event);
 			err = test_bit(BIO_UPTODATE, &bio->bi_flags) ? 0 : -EIO;
 			bio_put(bio);
@@ -179,8 +178,7 @@
 	init_completion(&event);
 	bio->bi_private = &event;
 	bio->bi_end_io = bi_write_complete;
-	submit_bio(WRITE, bio);
-	blk_run_queues();
+	submit_bio(WRITE_SYNC, bio);
 	wait_for_completion(&event);
 	DEBUG(3, "submit_bio completed, bi_vcnt = %d\n", bio->bi_vcnt);
 	err = test_bit(BIO_UPTODATE, &bio->bi_flags) ? 0 : -EIO;
diff -ur -X /home/axboe/cdrom/exclude /opt/kernel/linux-2.6.4-mm1/fs/buffer.c linux-2.6.4-mm1/fs/buffer.c
--- /opt/kernel/linux-2.6.4-mm1/fs/buffer.c	2004-03-11 09:10:01.948448091 +0100
+++ linux-2.6.4-mm1/fs/buffer.c	2004-03-11 09:07:12.000000000 +0100
@@ -132,7 +132,7 @@
 	do {
 		prepare_to_wait(wqh, &wait, TASK_UNINTERRUPTIBLE);
 		if (buffer_locked(bh)) {
-			blk_run_queues();
+			blk_run_address_space(bh->b_bdev->bd_inode->i_mapping);
 			io_schedule();
 		}
 	} while (buffer_locked(bh));
@@ -491,7 +491,6 @@
 	pg_data_t *pgdat;
 
 	wakeup_bdflush(1024);
-	blk_run_queues();
 	yield();
 
 	for_each_pgdat(pgdat) {
@@ -2924,7 +2923,7 @@
 
 int block_sync_page(struct page *page)
 {
-	blk_run_queues();
+	blk_run_address_space(page->mapping);
 	return 0;
 }
 
diff -ur -X /home/axboe/cdrom/exclude /opt/kernel/linux-2.6.4-mm1/fs/direct-io.c linux-2.6.4-mm1/fs/direct-io.c
--- /opt/kernel/linux-2.6.4-mm1/fs/direct-io.c	2004-03-11 09:10:01.987443867 +0100
+++ linux-2.6.4-mm1/fs/direct-io.c	2004-03-11 09:07:12.000000000 +0100
@@ -364,7 +364,7 @@
 		if (dio->bio_list == NULL) {
 			dio->waiter = current;
 			spin_unlock_irqrestore(&dio->bio_lock, flags);
-			blk_run_queues();
+			blk_run_address_space(dio->inode->i_mapping);
 			io_schedule();
 			spin_lock_irqsave(&dio->bio_lock, flags);
 			dio->waiter = NULL;
@@ -1035,7 +1035,7 @@
 		if (ret == 0)
 			ret = dio->result;
 		finished_one_bio(dio);		/* This can free the dio */
-		blk_run_queues();
+		blk_run_address_space(inode->i_mapping);
 		if (should_wait) {
 			unsigned long flags;
 			/*
diff -ur -X /home/axboe/cdrom/exclude /opt/kernel/linux-2.6.4-mm1/fs/jfs/jfs_logmgr.c linux-2.6.4-mm1/fs/jfs/jfs_logmgr.c
--- /opt/kernel/linux-2.6.4-mm1/fs/jfs/jfs_logmgr.c	2004-03-11 03:55:27.000000000 +0100
+++ linux-2.6.4-mm1/fs/jfs/jfs_logmgr.c	2004-03-11 09:07:12.000000000 +0100
@@ -1972,8 +1972,7 @@
 
 	bio->bi_end_io = lbmIODone;
 	bio->bi_private = bp;
-	submit_bio(READ, bio);
-	blk_run_queues();
+	submit_bio(READ_SYNC, bio);
 
 	wait_event(bp->l_ioevent, (bp->l_flag != lbmREAD));
 
@@ -2117,9 +2116,8 @@
 
 	/* check if journaling to disk has been disabled */
 	if (!log->no_integrity) {
-		submit_bio(WRITE, bio);
+		submit_bio(WRITE_SYNC, bio);
 		INCREMENT(lmStat.submitted);
-		blk_run_queues();
 	}
 	else {
 		bio->bi_size = 0;
diff -ur -X /home/axboe/cdrom/exclude /opt/kernel/linux-2.6.4-mm1/fs/ntfs/compress.c linux-2.6.4-mm1/fs/ntfs/compress.c
--- /opt/kernel/linux-2.6.4-mm1/fs/ntfs/compress.c	2004-03-11 03:55:27.000000000 +0100
+++ linux-2.6.4-mm1/fs/ntfs/compress.c	2004-03-11 09:07:12.000000000 +0100
@@ -668,7 +668,7 @@
 					"uptodate! Unplugging the disk queue "
 					"and rescheduling.");
 			get_bh(tbh);
-			blk_run_queues();
+			blk_run_address_space(mapping);
 			schedule();
 			put_bh(tbh);
 			if (unlikely(!buffer_uptodate(tbh)))
diff -ur -X /home/axboe/cdrom/exclude /opt/kernel/linux-2.6.4-mm1/fs/ufs/truncate.c linux-2.6.4-mm1/fs/ufs/truncate.c
--- /opt/kernel/linux-2.6.4-mm1/fs/ufs/truncate.c	2004-03-11 03:55:27.000000000 +0100
+++ linux-2.6.4-mm1/fs/ufs/truncate.c	2004-03-11 09:07:12.000000000 +0100
@@ -456,7 +456,7 @@
 			break;
 		if (IS_SYNC(inode) && (inode->i_state & I_DIRTY))
 			ufs_sync_inode (inode);
-		blk_run_queues();
+		blk_run_address_space(inode->i_mapping);
 		yield();
 	}
 	offset = inode->i_size & uspi->s_fshift;
diff -ur -X /home/axboe/cdrom/exclude /opt/kernel/linux-2.6.4-mm1/fs/xfs/linux/xfs_buf.c linux-2.6.4-mm1/fs/xfs/linux/xfs_buf.c
--- /opt/kernel/linux-2.6.4-mm1/fs/xfs/linux/xfs_buf.c	2004-03-11 03:55:21.000000000 +0100
+++ linux-2.6.4-mm1/fs/xfs/linux/xfs_buf.c	2004-03-11 09:07:12.706793571 +0100
@@ -1013,7 +1013,7 @@
 {
 	PB_TRACE(pb, "lock", 0);
 	if (atomic_read(&pb->pb_io_remaining))
-		blk_run_queues();
+		blk_run_address_space(pb->pb_target->pbr_mapping);
 	down(&pb->pb_sema);
 	PB_SET_OWNER(pb);
 	PB_TRACE(pb, "locked", 0);
@@ -1109,7 +1109,7 @@
 		if (atomic_read(&pb->pb_pin_count) == 0)
 			break;
 		if (atomic_read(&pb->pb_io_remaining))
-			blk_run_queues();
+			blk_run_address_space(pb->pb_target->pbr_mapping);
 		schedule();
 	}
 	remove_wait_queue(&pb->pb_waiters, &wait);
@@ -1407,7 +1407,7 @@
 	if (pb->pb_flags & PBF_RUN_QUEUES) {
 		pb->pb_flags &= ~PBF_RUN_QUEUES;
 		if (atomic_read(&pb->pb_io_remaining) > 1)
-			blk_run_queues();
+			blk_run_address_space(pb->pb_target->pbr_mapping);
 	}
 }
 
@@ -1471,7 +1471,7 @@
 {
 	PB_TRACE(pb, "iowait", 0);
 	if (atomic_read(&pb->pb_io_remaining))
-		blk_run_queues();
+		blk_run_address_space(pb->pb_target->pbr_mapping);
 	down(&pb->pb_iodonesema);
 	PB_TRACE(pb, "iowaited", (long)pb->pb_error);
 	return pb->pb_error;
@@ -1617,7 +1617,6 @@
 pagebuf_daemon(
 	void			*data)
 {
-	int			count;
 	page_buf_t		*pb;
 	struct list_head	*curr, *next, tmp;
 
@@ -1640,7 +1639,6 @@
 
 		spin_lock(&pbd_delwrite_lock);
 
-		count = 0;
 		list_for_each_safe(curr, next, &pbd_delwrite_queue) {
 			pb = list_entry(curr, page_buf_t, pb_list);
 
@@ -1657,7 +1655,6 @@
 				pb->pb_flags &= ~PBF_DELWRI;
 				pb->pb_flags |= PBF_WRITE;
 				list_move(&pb->pb_list, &tmp);
-				count++;
 			}
 		}
 
@@ -1667,12 +1664,11 @@
 			list_del_init(&pb->pb_list);
 
 			pagebuf_iostrategy(pb);
+			blk_run_address_space(pb->pb_target->pbr_mapping);
 		}
 
 		if (as_list_len > 0)
 			purge_addresses();
-		if (count)
-			blk_run_queues();
 
 		force_flush = 0;
 	} while (pagebuf_daemon_active);
@@ -1689,7 +1685,6 @@
 	page_buf_t		*pb;
 	struct list_head	*curr, *next, tmp;
 	int			pincount = 0;
-	int			flush_cnt = 0;
 
 	pagebuf_runall_queues(pagebuf_dataio_workqueue);
 	pagebuf_runall_queues(pagebuf_logio_workqueue);
@@ -1733,14 +1728,8 @@
 
 		pagebuf_lock(pb);
 		pagebuf_iostrategy(pb);
-		if (++flush_cnt > 32) {
-			blk_run_queues();
-			flush_cnt = 0;
-		}
 	}
 
-	blk_run_queues();
-
 	while (!list_empty(&tmp)) {
 		pb = list_entry(tmp.next, page_buf_t, pb_list);
 
diff -ur -X /home/axboe/cdrom/exclude /opt/kernel/linux-2.6.4-mm1/include/linux/backing-dev.h linux-2.6.4-mm1/include/linux/backing-dev.h
--- /opt/kernel/linux-2.6.4-mm1/include/linux/backing-dev.h	2004-03-11 09:10:02.000000000 +0100
+++ linux-2.6.4-mm1/include/linux/backing-dev.h	2004-03-11 09:07:12.706793571 +0100
@@ -28,6 +28,8 @@
 	int memory_backed;	/* Cannot clean pages with writepage */
 	congested_fn *congested_fn; /* Function pointer if device is md/dm */
 	void *congested_data;	/* Pointer to aux data for congested func */
+	void (*unplug_io_fn)(struct backing_dev_info *);
+	void *unplug_io_data;
 };
 
 extern struct backing_dev_info default_backing_dev_info;
diff -ur -X /home/axboe/cdrom/exclude /opt/kernel/linux-2.6.4-mm1/include/linux/bio.h linux-2.6.4-mm1/include/linux/bio.h
--- /opt/kernel/linux-2.6.4-mm1/include/linux/bio.h	2004-03-11 03:55:37.000000000 +0100
+++ linux-2.6.4-mm1/include/linux/bio.h	2004-03-11 09:07:12.707793462 +0100
@@ -124,6 +124,7 @@
 #define BIO_RW_AHEAD	1
 #define BIO_RW_BARRIER	2
 #define BIO_RW_FAILFAST	3
+#define BIO_RW_SYNC	4
 
 /*
  * various member access, note that bio_data should of course not be used
@@ -138,6 +139,7 @@
 #define bio_cur_sectors(bio)	(bio_iovec(bio)->bv_len >> 9)
 #define bio_data(bio)		(page_address(bio_page((bio))) + bio_offset((bio)))
 #define bio_barrier(bio)	((bio)->bi_rw & (1 << BIO_RW_BARRIER))
+#define bio_sync(bio)		((bio)->bi_rw & (1 << BIO_RW_SYNC))
 
 /*
  * will die
diff -ur -X /home/axboe/cdrom/exclude /opt/kernel/linux-2.6.4-mm1/include/linux/blkdev.h linux-2.6.4-mm1/include/linux/blkdev.h
--- /opt/kernel/linux-2.6.4-mm1/include/linux/blkdev.h	2004-03-11 09:10:02.000000000 +0100
+++ linux-2.6.4-mm1/include/linux/blkdev.h	2004-03-11 09:07:12.708793354 +0100
@@ -243,7 +243,7 @@
 typedef void (request_fn_proc) (request_queue_t *q);
 typedef int (make_request_fn) (request_queue_t *q, struct bio *bio);
 typedef int (prep_rq_fn) (request_queue_t *, struct request *);
-typedef void (unplug_fn) (void *q);
+typedef void (unplug_fn) (request_queue_t *);
 
 struct bio_vec;
 typedef int (merge_bvec_fn) (request_queue_t *, struct bio *, struct bio_vec *);
@@ -315,8 +315,6 @@
 	unsigned long		bounce_pfn;
 	int			bounce_gfp;
 
-	struct list_head	plug_list;
-
 	/*
 	 * various queue flags, see QUEUE_* below
 	 */
@@ -370,8 +368,9 @@
 #define QUEUE_FLAG_WRITEFULL	4	/* read queue has been filled */
 #define QUEUE_FLAG_DEAD		5	/* queue being torn down */
 #define QUEUE_FLAG_REENTER	6	/* Re-entrancy avoidance */
+#define QUEUE_FLAG_PLUGGED	7	/* queue is plugged */
 
-#define blk_queue_plugged(q)	!list_empty(&(q)->plug_list)
+#define blk_queue_plugged(q)	test_bit(QUEUE_FLAG_PLUGGED, &(q)->queue_flags)
 #define blk_queue_tagged(q)	test_bit(QUEUE_FLAG_QUEUED, &(q)->queue_flags)
 #define blk_queue_stopped(q)	test_bit(QUEUE_FLAG_STOPPED, &(q)->queue_flags)
 
@@ -515,7 +514,7 @@
 extern void blk_start_queue(request_queue_t *q);
 extern void blk_stop_queue(request_queue_t *q);
 extern void __blk_stop_queue(request_queue_t *q);
-extern void blk_run_queue(request_queue_t *q);
+extern void blk_run_queue(request_queue_t *);
 extern void blk_queue_activity_fn(request_queue_t *, activity_fn *, void *);
 extern struct request *blk_rq_map_user(request_queue_t *, int, void __user *, unsigned int);
 extern int blk_rq_unmap_user(struct request *, void __user *, unsigned int, int);
@@ -526,6 +525,18 @@
 	return bdev->bd_disk->queue;
 }
 
+static inline void blk_run_backing_dev(struct backing_dev_info *bdi)
+{
+	if (bdi)
+		bdi->unplug_io_fn(bdi);
+}
+
+static inline void blk_run_address_space(struct address_space *mapping)
+{
+	if (mapping)
+		blk_run_backing_dev(mapping->backing_dev_info);
+}
+
 /*
  * end_request() and friends. Must be called with the request queue spinlock
  * acquired. All functions called within end_request() _must_be_ atomic.
@@ -572,7 +583,7 @@
 
 extern int blk_rq_map_sg(request_queue_t *, struct request *, struct scatterlist *);
 extern void blk_dump_rq_flags(struct request *, char *);
-extern void generic_unplug_device(void *);
+extern void generic_unplug_device(request_queue_t *);
 extern long nr_blockdev_pages(void);
 
 int blk_get_queue(request_queue_t *);
diff -ur -X /home/axboe/cdrom/exclude /opt/kernel/linux-2.6.4-mm1/include/linux/fs.h linux-2.6.4-mm1/include/linux/fs.h
--- /opt/kernel/linux-2.6.4-mm1/include/linux/fs.h	2004-03-11 09:10:02.309408999 +0100
+++ linux-2.6.4-mm1/include/linux/fs.h	2004-03-11 09:07:12.000000000 +0100
@@ -82,6 +82,8 @@
 #define WRITE 1
 #define READA 2		/* read-ahead  - don't block if no resources */
 #define SPECIAL 4	/* For non-blockdevice requests in request queue */
+#define READ_SYNC	(READ | BIO_RW_SYNC)
+#define WRITE_SYNC	(WRITE | BIO_RW_SYNC)
 
 #define SEL_IN		1
 #define SEL_OUT		2
diff -ur -X /home/axboe/cdrom/exclude /opt/kernel/linux-2.6.4-mm1/include/linux/raid/md_k.h linux-2.6.4-mm1/include/linux/raid/md_k.h
--- /opt/kernel/linux-2.6.4-mm1/include/linux/raid/md_k.h	2004-03-11 03:55:21.000000000 +0100
+++ linux-2.6.4-mm1/include/linux/raid/md_k.h	2004-03-11 09:07:12.000000000 +0100
@@ -326,7 +326,6 @@
 		if (condition)						\
 			break;						\
 		spin_unlock_irq(&lock);					\
-		blk_run_queues();					\
 		schedule();						\
 		spin_lock_irq(&lock);					\
 	}								\
@@ -341,30 +340,5 @@
 	__wait_event_lock_irq(wq, condition, lock);			\
 } while (0)
 
-
-#define __wait_disk_event(wq, condition) 				\
-do {									\
-	wait_queue_t __wait;						\
-	init_waitqueue_entry(&__wait, current);				\
-									\
-	add_wait_queue(&wq, &__wait);					\
-	for (;;) {							\
-		set_current_state(TASK_UNINTERRUPTIBLE);		\
-		if (condition)						\
-			break;						\
-		blk_run_queues();					\
-		schedule();						\
-	}								\
-	current->state = TASK_RUNNING;					\
-	remove_wait_queue(&wq, &__wait);				\
-} while (0)
-
-#define wait_disk_event(wq, condition) 					\
-do {									\
-	if (condition)	 						\
-		break;							\
-	__wait_disk_event(wq, condition);				\
-} while (0)
-
 #endif
 
diff -ur -X /home/axboe/cdrom/exclude /opt/kernel/linux-2.6.4-mm1/kernel/power/disk.c linux-2.6.4-mm1/kernel/power/disk.c
--- /opt/kernel/linux-2.6.4-mm1/kernel/power/disk.c	2004-03-11 03:55:21.000000000 +0100
+++ linux-2.6.4-mm1/kernel/power/disk.c	2004-03-11 09:07:12.000000000 +0100
@@ -84,7 +84,6 @@
 	while (shrink_all_memory(10000))
 		printk(".");
 	printk("|\n");
-	blk_run_queues();
 }
 
 
diff -ur -X /home/axboe/cdrom/exclude /opt/kernel/linux-2.6.4-mm1/kernel/power/pmdisk.c linux-2.6.4-mm1/kernel/power/pmdisk.c
--- /opt/kernel/linux-2.6.4-mm1/kernel/power/pmdisk.c	2004-03-11 03:55:28.000000000 +0100
+++ linux-2.6.4-mm1/kernel/power/pmdisk.c	2004-03-11 09:07:12.000000000 +0100
@@ -859,7 +859,6 @@
 
 static void wait_io(void)
 {
-	blk_run_queues();
 	while(atomic_read(&io_done))
 		io_schedule();
 }
@@ -895,6 +894,7 @@
 		goto Done;
 	}
 
+	rw |= BIO_RW_SYNC;
 	if (rw == WRITE)
 		bio_set_pages_dirty(bio);
 	start_io();
diff -ur -X /home/axboe/cdrom/exclude /opt/kernel/linux-2.6.4-mm1/kernel/power/swsusp.c linux-2.6.4-mm1/kernel/power/swsusp.c
--- /opt/kernel/linux-2.6.4-mm1/kernel/power/swsusp.c	2004-03-11 03:55:24.000000000 +0100
+++ linux-2.6.4-mm1/kernel/power/swsusp.c	2004-03-11 09:07:12.000000000 +0100
@@ -707,11 +707,6 @@
 
 		free_some_memory();
 		
-		/* No need to invalidate any vfsmnt list -- 
-		 * they will be valid after resume, anyway.
-		 */
-		blk_run_queues();
-
 		/* Save state of all device drivers, and stop them. */		   
 		if ((res = device_suspend(4))==0)
 			/* If stopping device drivers worked, we proceed basically into
diff -ur -X /home/axboe/cdrom/exclude /opt/kernel/linux-2.6.4-mm1/mm/mempool.c linux-2.6.4-mm1/mm/mempool.c
--- /opt/kernel/linux-2.6.4-mm1/mm/mempool.c	2004-03-11 03:55:34.000000000 +0100
+++ linux-2.6.4-mm1/mm/mempool.c	2004-03-11 09:07:12.000000000 +0100
@@ -233,8 +233,6 @@
 	if (!(gfp_mask & __GFP_WAIT))
 		return NULL;
 
-	blk_run_queues();
-
 	prepare_to_wait(&pool->wait, &wait, TASK_UNINTERRUPTIBLE);
 	if (!pool->curr_nr)
 		io_schedule();
diff -ur -X /home/axboe/cdrom/exclude /opt/kernel/linux-2.6.4-mm1/mm/readahead.c linux-2.6.4-mm1/mm/readahead.c
--- /opt/kernel/linux-2.6.4-mm1/mm/readahead.c	2004-03-11 09:10:02.452393513 +0100
+++ linux-2.6.4-mm1/mm/readahead.c	2004-03-11 09:07:12.000000000 +0100
@@ -15,9 +15,14 @@
 #include <linux/backing-dev.h>
 #include <linux/pagevec.h>
 
+static void default_unplug_io_fn(struct backing_dev_info *bdi)
+{
+}
+
 struct backing_dev_info default_backing_dev_info = {
 	.ra_pages	= (VM_MAX_READAHEAD * 1024) / PAGE_CACHE_SIZE,
 	.state		= 0,
+	.unplug_io_fn	= default_unplug_io_fn,
 };
 
 EXPORT_SYMBOL_GPL(default_backing_dev_info);

-- 
Jens Axboe

