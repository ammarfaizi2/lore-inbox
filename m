Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964776AbWIPL4P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964776AbWIPL4P (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Sep 2006 07:56:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964777AbWIPL4P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Sep 2006 07:56:15 -0400
Received: from cantor2.suse.de ([195.135.220.15]:38812 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S964776AbWIPL4M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Sep 2006 07:56:12 -0400
Date: Sat, 16 Sep 2006 13:56:07 +0200
From: Nick Piggin <npiggin@suse.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Jens Axboe <axboe@kernel.dk>
Subject: [rfc][patch 2.6.18-rc7] block: explicit plugging
Message-ID: <20060916115607.GA16971@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've been tinkering with this idea for a while, and I'd be interested
in seeing what people think about it. The patch isn't in a great state
of commenting or splitting ;) but I'd be interested feelings about the
general approach, and whether I'm going to hit any bad problems (eg.
with SCSI or IDE).

Nick


This is a patch to perform block device plugging explicitly in the submitting
process context rather than implicitly by the block device.

There are several advantages to plugging in process context over plugging
by the block device:

- Implicit plugging is only active when the queue empties, so any
  advantages are lost if there is parallel IO occuring. Not so with
  explicit plugging.

- Implicit plugging relies on a timer and watermarks and a kind-of-explicit
  directive in lock_page which directs plugging. These are heuristics and
  can cost performance due to holding a block device idle longer than it
  should be. Explicit plugging avoids most of these issues by only holding
  the device idle when it is known more requests will be submitted.

- This lock_page directive uses a roundabout way to attempt to minimise
  intrusiveness of plugging on the VM. In doing so, it gets needlessly
  complex: the VM really is in a good position to direct the block layer
  as to the nature of its requests, so there is no need to try to hide
  the fact.

- Explicit plugging keeps a process-private queue of requests being held.
  This offers some advantages over immediately sending requests to the
  block device: firstly, merging can be attempted on requests in this list
  (currently only attempted on the head of the list) without taking any
  locks; secondly, when unplugging occurs, the requests can be delivered
  to the block device queue in a batch, thus the lock aquisitions can be
  batched up.
  
On a parallel tiobench benchmark, of the 800 000 calls to __make_request
performed, this patch avoids 490 000 (62%) of queue_lock aquisitions by
early merging on the private plugged list.

Testing and development is in early stages yet. In particular, the lack of
a timer based unplug kick probably breaks some block device drivers in
funny ways (though works here for me with SCSI and UML so far). Also needs
much wider testing.

 block/cfq-iosched.c         |    6
 block/elevator.c            |   30 ---
 block/ll_rw_blk.c           |  396 ++++++++++++++++++--------------------------
 drivers/block/loop.c        |   12 -
 drivers/block/pktcdvd.c     |    5
 drivers/ide/ide-cd.c        |    9 -
 drivers/ide/ide-io.c        |   23 --
 drivers/scsi/scsi_lib.c     |   43 +---
 fs/block_dev.c              |    1
 fs/buffer.c                 |   26 --
 fs/direct-io.c              |   11 +
 fs/ext2/inode.c             |    2
 fs/ext3/inode.c             |    3
 fs/hfs/inode.c              |    2
 fs/hfsplus/inode.c          |    2
 fs/isofs/inode.c            |    1
 fs/udf/file.c               |    1
 fs/udf/inode.c              |    1
 include/linux/backing-dev.h |    3
 include/linux/blkdev.h      |   65 ++++---
 include/linux/buffer_head.h |    1
 include/linux/elevator.h    |    5
 include/linux/fs.h          |    1
 include/linux/sched.h       |    1
 mm/filemap.c                |   46 -----
 mm/page-writeback.c         |    6
 mm/readahead.c              |   11 -
 mm/shmem.c                  |    1
 mm/swap_state.c             |    5
 mm/swapfile.c               |   37 ----
 mm/vmscan.c                 |    6
 31 files changed, 272 insertions(+), 490 deletions(-)

Index: linux-2.6/fs/buffer.c
===================================================================
--- linux-2.6.orig/fs/buffer.c
+++ linux-2.6/fs/buffer.c
@@ -54,23 +54,16 @@ init_buffer(struct buffer_head *bh, bh_e
 	bh->b_private = private;
 }
 
-static int sync_buffer(void *word)
+static int sleep_on_buffer(void *word)
 {
-	struct block_device *bd;
-	struct buffer_head *bh
-		= container_of(word, struct buffer_head, b_state);
-
-	smp_mb();
-	bd = bh->b_bdev;
-	if (bd)
-		blk_run_address_space(bd->bd_inode->i_mapping);
+	replug_current_nested();
 	io_schedule();
 	return 0;
 }
 
 void fastcall __lock_buffer(struct buffer_head *bh)
 {
-	wait_on_bit_lock(&bh->b_state, BH_Lock, sync_buffer,
+	wait_on_bit_lock(&bh->b_state, BH_Lock, sleep_on_buffer,
 							TASK_UNINTERRUPTIBLE);
 }
 EXPORT_SYMBOL(__lock_buffer);
@@ -89,7 +82,7 @@ void fastcall unlock_buffer(struct buffe
  */
 void __wait_on_buffer(struct buffer_head * bh)
 {
-	wait_on_bit(&bh->b_state, BH_Lock, sync_buffer, TASK_UNINTERRUPTIBLE);
+	wait_on_bit(&bh->b_state, BH_Lock, sleep_on_buffer, TASK_UNINTERRUPTIBLE);
 }
 
 static void
@@ -3013,16 +3006,6 @@ out:
 }
 EXPORT_SYMBOL(try_to_free_buffers);
 
-void block_sync_page(struct page *page)
-{
-	struct address_space *mapping;
-
-	smp_mb();
-	mapping = page_mapping(page);
-	if (mapping)
-		blk_run_backing_dev(mapping->backing_dev_info, page);
-}
-
 /*
  * There are no bdflush tunables left.  But distributions are
  * still running obsolete flush daemons, so we terminate them here.
@@ -3166,7 +3149,6 @@ EXPORT_SYMBOL(__wait_on_buffer);
 EXPORT_SYMBOL(block_commit_write);
 EXPORT_SYMBOL(block_prepare_write);
 EXPORT_SYMBOL(block_read_full_page);
-EXPORT_SYMBOL(block_sync_page);
 EXPORT_SYMBOL(block_truncate_page);
 EXPORT_SYMBOL(block_write_full_page);
 EXPORT_SYMBOL(cont_prepare_write);
Index: linux-2.6/mm/filemap.c
===================================================================
--- linux-2.6.orig/mm/filemap.c
+++ linux-2.6/mm/filemap.c
@@ -133,38 +133,9 @@ void remove_from_page_cache(struct page 
 	write_unlock_irq(&mapping->tree_lock);
 }
 
-static int sync_page(void *word)
+static int sleep_on_page(void *word)
 {
-	struct address_space *mapping;
-	struct page *page;
-
-	page = container_of((unsigned long *)word, struct page, flags);
-
-	/*
-	 * page_mapping() is being called without PG_locked held.
-	 * Some knowledge of the state and use of the page is used to
-	 * reduce the requirements down to a memory barrier.
-	 * The danger here is of a stale page_mapping() return value
-	 * indicating a struct address_space different from the one it's
-	 * associated with when it is associated with one.
-	 * After smp_mb(), it's either the correct page_mapping() for
-	 * the page, or an old page_mapping() and the page's own
-	 * page_mapping() has gone NULL.
-	 * The ->sync_page() address_space operation must tolerate
-	 * page_mapping() going NULL. By an amazing coincidence,
-	 * this comes about because none of the users of the page
-	 * in the ->sync_page() methods make essential use of the
-	 * page_mapping(), merely passing the page down to the backing
-	 * device's unplug functions when it's non-NULL, which in turn
-	 * ignore it for all cases but swap, where only page_private(page) is
-	 * of interest. When page_mapping() does go NULL, the entire
-	 * call stack gracefully ignores the page and returns.
-	 * -- wli
-	 */
-	smp_mb();
-	mapping = page_mapping(page);
-	if (mapping && mapping->a_ops && mapping->a_ops->sync_page)
-		mapping->a_ops->sync_page(page);
+	replug_current_nested();
 	io_schedule();
 	return 0;
 }
@@ -515,7 +486,7 @@ void fastcall wait_on_page_bit(struct pa
 	DEFINE_WAIT_BIT(wait, &page->flags, bit_nr);
 
 	if (test_bit(bit_nr, &page->flags))
-		__wait_on_bit(page_waitqueue(page), &wait, sync_page,
+		__wait_on_bit(page_waitqueue(page), &wait, sleep_on_page,
 							TASK_UNINTERRUPTIBLE);
 }
 EXPORT_SYMBOL(wait_on_page_bit);
@@ -562,17 +533,12 @@ EXPORT_SYMBOL(end_page_writeback);
 /**
  * __lock_page - get a lock on the page, assuming we need to sleep to get it
  * @page: the page to lock
- *
- * Ugly. Running sync_page() in state TASK_UNINTERRUPTIBLE is scary.  If some
- * random driver's requestfn sets TASK_RUNNING, we could busywait.  However
- * chances are that on the second loop, the block layer's plug list is empty,
- * so sync_page() will then return in state TASK_UNINTERRUPTIBLE.
  */
 void fastcall __lock_page(struct page *page)
 {
 	DEFINE_WAIT_BIT(wait, &page->flags, PG_locked);
 
-	__wait_on_bit_lock(page_waitqueue(page), &wait, sync_page,
+	__wait_on_bit_lock(page_waitqueue(page), &wait, sleep_on_page,
 							TASK_UNINTERRUPTIBLE);
 }
 EXPORT_SYMBOL(__lock_page);
@@ -895,6 +861,8 @@ void do_generic_mapping_read(struct addr
 	last_index = (*ppos + desc->count + PAGE_CACHE_SIZE-1) >> PAGE_CACHE_SHIFT;
 	offset = *ppos & ~PAGE_CACHE_MASK;
 
+	plug_current();
+
 	isize = i_size_read(inode);
 	if (!isize)
 		goto out;
@@ -1080,6 +1048,8 @@ out:
 		page_cache_release(cached_page);
 	if (filp)
 		file_accessed(filp);
+
+	unplug_current();
 }
 EXPORT_SYMBOL(do_generic_mapping_read);
 
Index: linux-2.6/block/elevator.c
===================================================================
--- linux-2.6.orig/block/elevator.c
+++ linux-2.6/block/elevator.c
@@ -64,7 +64,7 @@ inline int elv_rq_merge_ok(struct reques
 }
 EXPORT_SYMBOL(elv_rq_merge_ok);
 
-static inline int elv_try_merge(struct request *__rq, struct bio *bio)
+int elv_try_merge(struct request *__rq, struct bio *bio)
 {
 	int ret = ELEVATOR_NO_MERGE;
 
@@ -336,7 +336,6 @@ void elv_insert(request_queue_t *q, stru
 {
 	struct list_head *pos;
 	unsigned ordseq;
-	int unplug_it = 1;
 
 	blk_add_trace_rq(q, rq, BLK_TA_INSERT);
 
@@ -345,7 +344,6 @@ void elv_insert(request_queue_t *q, stru
 	switch (where) {
 	case ELEVATOR_INSERT_FRONT:
 		rq->flags |= REQ_SOFTBARRIER;
-
 		list_add(&rq->queuelist, &q->queue_head);
 		break;
 
@@ -363,7 +361,6 @@ void elv_insert(request_queue_t *q, stru
 		 *   with anything.  There's no point in delaying queue
 		 *   processing.
 		 */
-		blk_remove_plug(q);
 		q->request_fn(q);
 		break;
 
@@ -403,11 +400,6 @@ void elv_insert(request_queue_t *q, stru
 		}
 
 		list_add_tail(&rq->queuelist, pos);
-		/*
-		 * most requeues happen because of a busy condition, don't
-		 * force unplug of the queue for that case.
-		 */
-		unplug_it = 0;
 		break;
 
 	default:
@@ -415,18 +407,9 @@ void elv_insert(request_queue_t *q, stru
 		       __FUNCTION__, where);
 		BUG();
 	}
-
-	if (unplug_it && blk_queue_plugged(q)) {
-		int nrq = q->rq.count[READ] + q->rq.count[WRITE]
-			- q->in_flight;
-
-		if (nrq >= q->unplug_thresh)
-			__generic_unplug_device(q);
-	}
 }
 
-void __elv_add_request(request_queue_t *q, struct request *rq, int where,
-		       int plug)
+void __elv_add_request(request_queue_t *q, struct request *rq, int where)
 {
 	if (q->ordcolor)
 		rq->flags |= REQ_ORDERED_COLOR;
@@ -455,19 +438,15 @@ void __elv_add_request(request_queue_t *
 	} else if (!(rq->flags & REQ_ELVPRIV) && where == ELEVATOR_INSERT_SORT)
 		where = ELEVATOR_INSERT_BACK;
 
-	if (plug)
-		blk_plug_device(q);
-
 	elv_insert(q, rq, where);
 }
 
-void elv_add_request(request_queue_t *q, struct request *rq, int where,
-		     int plug)
+void elv_add_request(request_queue_t *q, struct request *rq, int where)
 {
 	unsigned long flags;
 
 	spin_lock_irqsave(q->queue_lock, flags);
-	__elv_add_request(q, rq, where, plug);
+	__elv_add_request(q, rq, where);
 	spin_unlock_irqrestore(q->queue_lock, flags);
 }
 
@@ -812,7 +791,6 @@ static int elevator_switch(request_queue
 	elv_drain_elevator(q);
 
 	while (q->rq.elvpriv) {
-		blk_remove_plug(q);
 		q->request_fn(q);
 		spin_unlock_irq(q->queue_lock);
 		msleep(10);
Index: linux-2.6/block/ll_rw_blk.c
===================================================================
--- linux-2.6.orig/block/ll_rw_blk.c
+++ linux-2.6/block/ll_rw_blk.c
@@ -28,14 +28,13 @@
 #include <linux/interrupt.h>
 #include <linux/cpu.h>
 #include <linux/blktrace_api.h>
+#include <linux/elevator.h>
 
 /*
  * for max sense size
  */
 #include <scsi/scsi_cmnd.h>
 
-static void blk_unplug_work(void *data);
-static void blk_unplug_timeout(unsigned long data);
 static void drive_stat_acct(struct request *rq, int nr_sectors, int new_io);
 static void init_request_from_bio(struct request *req, struct bio *bio);
 static int __make_request(request_queue_t *q, struct bio *bio);
@@ -257,16 +256,6 @@ void blk_queue_make_request(request_queu
 	blk_queue_congestion_threshold(q);
 	q->nr_batching = BLK_BATCH_REQ;
 
-	q->unplug_thresh = 4;		/* hmm */
-	q->unplug_delay = (3 * HZ) / 1000;	/* 3 milliseconds */
-	if (q->unplug_delay == 0)
-		q->unplug_delay = 1;
-
-	INIT_WORK(&q->unplug_work, blk_unplug_work, q);
-
-	q->unplug_timer.function = blk_unplug_timeout;
-	q->unplug_timer.data = (unsigned long)q;
-
 	/*
 	 * by default assume old behaviour and bounce for any highmem page
 	 */
@@ -1148,8 +1137,9 @@ void blk_queue_invalidate_tags(request_q
 			blk_queue_end_tag(q, rq);
 
 		rq->flags &= ~REQ_STARTED;
-		__elv_add_request(q, rq, ELEVATOR_INSERT_BACK, 0);
+		__elv_add_request(q, rq, ELEVATOR_INSERT_BACK);
 	}
+	q->request_fn(q);
 }
 
 EXPORT_SYMBOL(blk_queue_invalidate_tags);
@@ -1537,120 +1527,6 @@ static int ll_merge_requests_fn(request_
 	return 1;
 }
 
-/*
- * "plug" the device if there are no outstanding requests: this will
- * force the transfer to start only after we have put all the requests
- * on the list.
- *
- * This is called with interrupts off and no requests on the queue and
- * with the queue lock held.
- */
-void blk_plug_device(request_queue_t *q)
-{
-	WARN_ON(!irqs_disabled());
-
-	/*
-	 * don't plug a stopped queue, it must be paired with blk_start_queue()
-	 * which will restart the queueing
-	 */
-	if (blk_queue_stopped(q))
-		return;
-
-	if (!test_and_set_bit(QUEUE_FLAG_PLUGGED, &q->queue_flags)) {
-		mod_timer(&q->unplug_timer, jiffies + q->unplug_delay);
-		blk_add_trace_generic(q, NULL, 0, BLK_TA_PLUG);
-	}
-}
-
-EXPORT_SYMBOL(blk_plug_device);
-
-/*
- * remove the queue from the plugged list, if present. called with
- * queue lock held and interrupts disabled.
- */
-int blk_remove_plug(request_queue_t *q)
-{
-	WARN_ON(!irqs_disabled());
-
-	if (!test_and_clear_bit(QUEUE_FLAG_PLUGGED, &q->queue_flags))
-		return 0;
-
-	del_timer(&q->unplug_timer);
-	return 1;
-}
-
-EXPORT_SYMBOL(blk_remove_plug);
-
-/*
- * remove the plug and let it rip..
- */
-void __generic_unplug_device(request_queue_t *q)
-{
-	if (unlikely(blk_queue_stopped(q)))
-		return;
-
-	if (!blk_remove_plug(q))
-		return;
-
-	q->request_fn(q);
-}
-EXPORT_SYMBOL(__generic_unplug_device);
-
-/**
- * generic_unplug_device - fire a request queue
- * @q:    The &request_queue_t in question
- *
- * Description:
- *   Linux uses plugging to build bigger requests queues before letting
- *   the device have at them. If a queue is plugged, the I/O scheduler
- *   is still adding and merging requests on the queue. Once the queue
- *   gets unplugged, the request_fn defined for the queue is invoked and
- *   transfers started.
- **/
-void generic_unplug_device(request_queue_t *q)
-{
-	spin_lock_irq(q->queue_lock);
-	__generic_unplug_device(q);
-	spin_unlock_irq(q->queue_lock);
-}
-EXPORT_SYMBOL(generic_unplug_device);
-
-static void blk_backing_dev_unplug(struct backing_dev_info *bdi,
-				   struct page *page)
-{
-	request_queue_t *q = bdi->unplug_io_data;
-
-	/*
-	 * devices don't necessarily have an ->unplug_fn defined
-	 */
-	if (q->unplug_fn) {
-		blk_add_trace_pdu_int(q, BLK_TA_UNPLUG_IO, NULL,
-					q->rq.count[READ] + q->rq.count[WRITE]);
-
-		q->unplug_fn(q);
-	}
-}
-
-static void blk_unplug_work(void *data)
-{
-	request_queue_t *q = data;
-
-	blk_add_trace_pdu_int(q, BLK_TA_UNPLUG_IO, NULL,
-				q->rq.count[READ] + q->rq.count[WRITE]);
-
-	q->unplug_fn(q);
-}
-
-static void blk_unplug_timeout(unsigned long data)
-{
-	request_queue_t *q = (request_queue_t *)data;
-
-	blk_add_trace_pdu_int(q, BLK_TA_UNPLUG_TIMER, NULL,
-				q->rq.count[READ] + q->rq.count[WRITE]);
-
-	kblockd_schedule_work(&q->unplug_work);
-}
-
 /**
  * blk_start_queue - restart a previously stopped queue
  * @q:    The &request_queue_t in question
@@ -1666,17 +1542,11 @@ void blk_start_queue(request_queue_t *q)
 
 	clear_bit(QUEUE_FLAG_STOPPED, &q->queue_flags);
 
-	/*
-	 * one level of recursion is ok and is much faster than kicking
-	 * the unplug handling
-	 */
-	if (!test_and_set_bit(QUEUE_FLAG_REENTER, &q->queue_flags)) {
-		q->request_fn(q);
-		clear_bit(QUEUE_FLAG_REENTER, &q->queue_flags);
-	} else {
-		blk_plug_device(q);
-		kblockd_schedule_work(&q->unplug_work);
-	}
+	if (unlikely(test_bit(QUEUE_FLAG_REENTER, &q->queue_flags)))
+		return;
+	set_bit(QUEUE_FLAG_REENTER, &q->queue_flags);
+	q->request_fn(q);
+	clear_bit(QUEUE_FLAG_REENTER, &q->queue_flags);
 }
 
 EXPORT_SYMBOL(blk_start_queue);
@@ -1697,7 +1567,6 @@ EXPORT_SYMBOL(blk_start_queue);
  **/
 void blk_stop_queue(request_queue_t *q)
 {
-	blk_remove_plug(q);
 	set_bit(QUEUE_FLAG_STOPPED, &q->queue_flags);
 }
 EXPORT_SYMBOL(blk_stop_queue);
@@ -1718,7 +1587,6 @@ EXPORT_SYMBOL(blk_stop_queue);
  */
 void blk_sync_queue(struct request_queue *q)
 {
-	del_timer_sync(&q->unplug_timer);
 	kblockd_flush();
 }
 EXPORT_SYMBOL(blk_sync_queue);
@@ -1732,22 +1600,8 @@ void blk_run_queue(struct request_queue 
 	unsigned long flags;
 
 	spin_lock_irqsave(q->queue_lock, flags);
-	blk_remove_plug(q);
-
-	/*
-	 * Only recurse once to avoid overrunning the stack, let the unplug
-	 * handling reinvoke the handler shortly if we already got there.
-	 */
-	if (!elv_queue_empty(q)) {
-		if (!test_and_set_bit(QUEUE_FLAG_REENTER, &q->queue_flags)) {
-			q->request_fn(q);
-			clear_bit(QUEUE_FLAG_REENTER, &q->queue_flags);
-		} else {
-			blk_plug_device(q);
-			kblockd_schedule_work(&q->unplug_work);
-		}
-	}
-
+	BUG_ON(test_bit(QUEUE_FLAG_STOPPED, &q->queue_flags));
+	blk_start_queue(q);
 	spin_unlock_irqrestore(q->queue_lock, flags);
 }
 EXPORT_SYMBOL(blk_run_queue);
@@ -1842,15 +1696,11 @@ request_queue_t *blk_alloc_queue_node(gf
 		return NULL;
 
 	memset(q, 0, sizeof(*q));
-	init_timer(&q->unplug_timer);
 
 	snprintf(q->kobj.name, KOBJ_NAME_LEN, "%s", "queue");
 	q->kobj.ktype = &queue_ktype;
 	kobject_init(&q->kobj);
 
-	q->backing_dev_info.unplug_io_fn = blk_backing_dev_unplug;
-	q->backing_dev_info.unplug_io_data = q;
-
 	mutex_init(&q->sysfs_lock);
 
 	return q;
@@ -1924,7 +1774,6 @@ blk_init_queue_node(request_fn_proc *rfn
 	q->front_merge_fn      	= ll_front_merge_fn;
 	q->merge_requests_fn	= ll_merge_requests_fn;
 	q->prep_rq_fn		= NULL;
-	q->unplug_fn		= generic_unplug_device;
 	q->queue_flags		= (1 << QUEUE_FLAG_CLUSTER);
 	q->queue_lock		= lock;
 
@@ -2167,8 +2016,8 @@ out:
 }
 
 /*
- * No available requests for this queue, unplug the device and wait for some
- * requests to become available.
+ * No available requests for this queue, wait for some requests to become
+ * available.
  *
  * Called with q->queue_lock held, and returns with it unlocked.
  */
@@ -2192,8 +2041,8 @@ static struct request *get_request_wait(
 
 			blk_add_trace_generic(q, bio, rw, BLK_TA_SLEEPRQ);
 
-			__generic_unplug_device(q);
 			spin_unlock_irq(q->queue_lock);
+			replug_current_nested(); /* XXX: should be above */
 			io_schedule();
 
 			/*
@@ -2298,12 +2147,9 @@ void blk_insert_request(request_queue_t 
 		blk_queue_end_tag(q, rq);
 
 	drive_stat_acct(rq, rq->nr_sectors, 1);
-	__elv_add_request(q, rq, where, 0);
+	__elv_add_request(q, rq, where);
+	q->request_fn(q);
 
-	if (blk_queue_plugged(q))
-		__generic_unplug_device(q);
-	else
-		q->request_fn(q);
 	spin_unlock_irqrestore(q->queue_lock, flags);
 }
 
@@ -2496,8 +2342,8 @@ void blk_execute_rq_nowait(request_queue
 	rq->end_io = done;
 	WARN_ON(irqs_disabled());
 	spin_lock_irq(q->queue_lock);
-	__elv_add_request(q, rq, where, 1);
-	__generic_unplug_device(q);
+	__elv_add_request(q, rq, where);
+	q->request_fn(q);
 	spin_unlock_irq(q->queue_lock);
 }
 EXPORT_SYMBOL_GPL(blk_execute_rq_nowait);
@@ -2604,7 +2450,7 @@ static inline void add_request(request_q
 	 * elevator indicated where it wants this request to be
 	 * inserted at elevator_merge time
 	 */
-	__elv_add_request(q, req, ELEVATOR_INSERT_SORT, 0);
+	__elv_add_request(q, req, ELEVATOR_INSERT_SORT);
 }
  
 /*
@@ -2843,17 +2689,68 @@ static void init_request_from_bio(struct
 	req->start_time = jiffies;
 }
 
-static int __make_request(request_queue_t *q, struct bio *bio)
+static int bio_attempt_back_merge(request_queue_t *q, struct request *req,
+					int nr_sectors, struct bio *bio)
 {
-	struct request *req;
-	int el_ret, rw, nr_sectors, cur_nr_sectors, barrier, err, sync;
-	unsigned short prio;
+	BUG_ON(!rq_mergeable(req));
+
+	if (!q->back_merge_fn(q, req, bio))
+		return 0;
+
+	blk_add_trace_bio(q, bio, BLK_TA_BACKMERGE);
+
+	req->biotail->bi_next = bio;
+	req->biotail = bio;
+	req->nr_sectors = req->hard_nr_sectors += nr_sectors;
+	req->ioprio = ioprio_best(req->ioprio, bio_prio(bio));
+
+	return 1;
+}
+
+
+static int bio_attempt_front_merge(request_queue_t *q, struct request *req,
+					int nr_sectors, struct bio *bio)
+{
+	int cur_nr_sectors;
 	sector_t sector;
 
+	BUG_ON(!rq_mergeable(req));
+
+	if (!q->front_merge_fn(q, req, bio))
+		return 0;
+
+	blk_add_trace_bio(q, bio, BLK_TA_FRONTMERGE);
+
 	sector = bio->bi_sector;
-	nr_sectors = bio_sectors(bio);
 	cur_nr_sectors = bio_cur_sectors(bio);
-	prio = bio_prio(bio);
+
+	bio->bi_next = req->bio;
+	req->bio = bio;
+
+	/*
+	 * may not be valid. if the low level driver said
+	 * it didn't need a bounce buffer then it better
+	 * not touch req->buffer either...
+	 */
+	req->buffer = bio_data(bio);
+	req->current_nr_sectors = cur_nr_sectors;
+	req->hard_cur_sectors = cur_nr_sectors;
+	req->sector = req->hard_sector = sector;
+	req->nr_sectors = req->hard_nr_sectors += nr_sectors;
+	req->ioprio = ioprio_best(req->ioprio, bio_prio(bio));
+
+	return 1;
+}
+
+static int __make_request(request_queue_t *q, struct bio *bio)
+{
+	struct io_context *ioc;
+	struct request *req;
+	int el_ret, rw, nr_sectors, barrier, err, sync;
+
+	spin_lock_prefetch(q->queue_lock);
+
+	nr_sectors = bio_sectors(bio);
 
 	rw = bio_data_dir(bio);
 	sync = bio_sync(bio);
@@ -2865,68 +2762,48 @@ static int __make_request(request_queue_
 	 */
 	blk_queue_bounce(q, &bio);
 
-	spin_lock_prefetch(q->queue_lock);
-
 	barrier = bio_barrier(bio);
 	if (unlikely(barrier) && (q->next_ordered == QUEUE_ORDERED_NONE)) {
 		err = -EOPNOTSUPP;
 		goto end_io;
 	}
 
+	/* Attempt merging with the plugged list before taking locks */
+	ioc = current->io_context;
+	if (ioc && ioc->plugged && !list_empty(&ioc->plugged_list)) {
+		struct request *rq;
+		rq = list_entry_rq(ioc->plugged_list.prev);
+
+		el_ret = elv_try_merge(rq, bio);
+		if (el_ret == ELEVATOR_BACK_MERGE) {
+			if (bio_attempt_back_merge(q, rq, nr_sectors, bio))
+				goto out;
+		} else if (el_ret == ELEVATOR_FRONT_MERGE) {
+			if (bio_attempt_front_merge(q, rq, nr_sectors, bio))
+				goto out;
+		}
+	}
+
 	spin_lock_irq(q->queue_lock);
 
-	if (unlikely(barrier) || elv_queue_empty(q))
+	if (elv_queue_empty(q))
 		goto get_rq;
 
 	el_ret = elv_merge(q, &req, bio);
-	switch (el_ret) {
-		case ELEVATOR_BACK_MERGE:
-			BUG_ON(!rq_mergeable(req));
-
-			if (!q->back_merge_fn(q, req, bio))
-				break;
-
-			blk_add_trace_bio(q, bio, BLK_TA_BACKMERGE);
-
-			req->biotail->bi_next = bio;
-			req->biotail = bio;
-			req->nr_sectors = req->hard_nr_sectors += nr_sectors;
-			req->ioprio = ioprio_best(req->ioprio, prio);
+	if (el_ret == ELEVATOR_BACK_MERGE) {
+		if (bio_attempt_back_merge(q, req, nr_sectors, bio)) {
 			drive_stat_acct(req, nr_sectors, 0);
 			if (!attempt_back_merge(q, req))
 				elv_merged_request(q, req);
-			goto out;
-
-		case ELEVATOR_FRONT_MERGE:
-			BUG_ON(!rq_mergeable(req));
-
-			if (!q->front_merge_fn(q, req, bio))
-				break;
-
-			blk_add_trace_bio(q, bio, BLK_TA_FRONTMERGE);
-
-			bio->bi_next = req->bio;
-			req->bio = bio;
-
-			/*
-			 * may not be valid. if the low level driver said
-			 * it didn't need a bounce buffer then it better
-			 * not touch req->buffer either...
-			 */
-			req->buffer = bio_data(bio);
-			req->current_nr_sectors = cur_nr_sectors;
-			req->hard_cur_sectors = cur_nr_sectors;
-			req->sector = req->hard_sector = sector;
-			req->nr_sectors = req->hard_nr_sectors += nr_sectors;
-			req->ioprio = ioprio_best(req->ioprio, prio);
+			goto out_unlock;
+		}
+	} else if (el_ret == ELEVATOR_FRONT_MERGE) {
+		if (bio_attempt_front_merge(q, req, nr_sectors, bio)) {
 			drive_stat_acct(req, nr_sectors, 0);
 			if (!attempt_front_merge(q, req))
 				elv_merged_request(q, req);
-			goto out;
-
-		/* ELV_NO_MERGE: elevator says don't/can't merge. */
-		default:
-			;
+			goto out_unlock;
+		}
 	}
 
 get_rq:
@@ -2944,15 +2821,24 @@ get_rq:
 	 */
 	init_request_from_bio(req, bio);
 
-	spin_lock_irq(q->queue_lock);
-	if (elv_queue_empty(q))
-		blk_plug_device(q);
-	add_request(q, req);
-out:
-	if (sync)
-		__generic_unplug_device(q);
+	if (!ioc || !ioc->plugged) {
+		spin_lock_irq(q->queue_lock);
+		add_request(q, req);
+		q->request_fn(q);
+	} else {
+		if (ioc->plugged_queue != q) {
+			replug_current_nested();
+			ioc->plugged_queue = q;
+		}
+		if (!ioc->plugged_queue)
+			ioc->plugged_queue = q;
+		list_add_tail(&req->queuelist, &ioc->plugged_list);
+		goto out;
+	}
 
+out_unlock:
 	spin_unlock_irq(q->queue_lock);
+out:
 	return 0;
 
 end_io:
@@ -3602,6 +3488,46 @@ void exit_io_context(void)
 	put_io_context(ioc);
 }
 
+void plug_current(void)
+{
+	struct io_context *ioc = current_io_context(GFP_NOIO);
+	if (ioc)
+		ioc->plugged++;
+}
+
+void unplug_current(void)
+{
+	struct io_context *ioc = current->io_context;
+	struct request *req;
+	request_queue_t *q;
+	static int batches = 0, requests = 0;
+
+	if (!ioc)
+		return;
+
+	ioc->plugged--;
+	if (ioc->plugged)
+		return;
+	q = ioc->plugged_queue;
+	ioc->plugged_queue = NULL;
+	if (list_empty(&ioc->plugged_list))
+		return;
+
+	batches++;
+	spin_lock_irq(q->queue_lock);
+	do {
+		req = list_entry_rq(ioc->plugged_list.next);
+		requests++;
+		list_del_init(&req->queuelist);
+		add_request(q, req);
+	} while (!list_empty(&ioc->plugged_list));
+	q->request_fn(q);
+	spin_unlock_irq(q->queue_lock);
+
+	if (batches % 1000 == 0)
+		printk(KERN_INFO "batches: %d, requests: %d\n", batches, requests);
+}
+
 /*
  * If the current task has no IO context then create one and initialise it.
  * Otherwise, return its existing IO context.
@@ -3624,6 +3550,8 @@ struct io_context *current_io_context(gf
 		atomic_set(&ret->refcount, 1);
 		ret->task = current;
 		ret->set_ioprio = NULL;
+		ret->plugged = 0;
+		INIT_LIST_HEAD(&ret->plugged_list);
 		ret->last_waited = jiffies; /* doesn't matter... */
 		ret->nr_batch_requests = 0; /* because this is 0 */
 		ret->aic = NULL;
Index: linux-2.6/include/linux/blkdev.h
===================================================================
--- linux-2.6.orig/include/linux/blkdev.h
+++ linux-2.6/include/linux/blkdev.h
@@ -95,6 +95,10 @@ struct io_context {
 	/*
 	 * For request batching
 	 */
+	int plugged;
+	struct list_head plugged_list;
+	struct request_queue *plugged_queue;
+
 	unsigned long last_waited; /* Time last woken after wait for request */
 	int nr_batch_requests;     /* Number of requests left in the batch */
 
@@ -102,6 +106,38 @@ struct io_context {
 	struct rb_root cic_root;
 };
 
+void plug_current(void);
+void unplug_current(void);
+
+static inline int unplug_current_nested(void)
+{
+	struct io_context *ioc = current->io_context;
+	int ret = 0;
+
+	if (ioc && ioc->plugged) {
+		ret = ioc->plugged;
+		ioc->plugged = 1;
+		unplug_current();
+	}
+
+	return ret;
+}
+
+static inline void plug_current_nested(int depth)
+{
+	struct io_context *ioc = current->io_context;
+
+	if (ioc) {
+		ioc->plugged = depth;
+		ioc->plugged_queue = NULL;
+	}
+}
+
+static inline void replug_current_nested(void)
+{
+	plug_current_nested(unplug_current_nested());
+}
+
 void put_io_context(struct io_context *ioc);
 void exit_io_context(void);
 struct io_context *current_io_context(gfp_t gfp_flags);
@@ -289,7 +325,6 @@ typedef int (merge_requests_fn) (request
 typedef void (request_fn_proc) (request_queue_t *q);
 typedef int (make_request_fn) (request_queue_t *q, struct bio *bio);
 typedef int (prep_rq_fn) (request_queue_t *, struct request *);
-typedef void (unplug_fn) (request_queue_t *);
 
 struct bio_vec;
 typedef int (merge_bvec_fn) (request_queue_t *, struct bio *, struct bio_vec *);
@@ -333,7 +368,6 @@ struct request_queue
 	merge_requests_fn	*merge_requests_fn;
 	make_request_fn		*make_request_fn;
 	prep_rq_fn		*prep_rq_fn;
-	unplug_fn		*unplug_fn;
 	merge_bvec_fn		*merge_bvec_fn;
 	activity_fn		*activity_fn;
 	issue_flush_fn		*issue_flush_fn;
@@ -346,14 +380,6 @@ struct request_queue
 	sector_t		end_sector;
 	struct request		*boundary_rq;
 
-	/*
-	 * Auto-unplugging state
-	 */
-	struct timer_list	unplug_timer;
-	int			unplug_thresh;	/* After this many requests */
-	unsigned long		unplug_delay;	/* After this many jiffies */
-	struct work_struct	unplug_work;
-
 	struct backing_dev_info	backing_dev_info;
 
 	/*
@@ -442,7 +468,6 @@ struct request_queue
 #define QUEUE_FLAG_WRITEFULL	4	/* read queue has been filled */
 #define QUEUE_FLAG_DEAD		5	/* queue being torn down */
 #define QUEUE_FLAG_REENTER	6	/* Re-entrancy avoidance */
-#define QUEUE_FLAG_PLUGGED	7	/* queue is plugged */
 #define QUEUE_FLAG_ELVSWITCH	8	/* don't use elevator, just do FIFO */
 
 enum {
@@ -485,7 +510,6 @@ enum {
 	QUEUE_ORDSEQ_DONE	= 0x20,
 };
 
-#define blk_queue_plugged(q)	test_bit(QUEUE_FLAG_PLUGGED, &(q)->queue_flags)
 #define blk_queue_tagged(q)	test_bit(QUEUE_FLAG_QUEUED, &(q)->queue_flags)
 #define blk_queue_stopped(q)	test_bit(QUEUE_FLAG_STOPPED, &(q)->queue_flags)
 #define blk_queue_flushing(q)	((q)->ordseq)
@@ -601,8 +625,6 @@ extern void blk_end_sync_rq(struct reque
 extern struct request *blk_get_request(request_queue_t *, int, gfp_t);
 extern void blk_insert_request(request_queue_t *, struct request *, int, void *);
 extern void blk_requeue_request(request_queue_t *, struct request *);
-extern void blk_plug_device(request_queue_t *);
-extern int blk_remove_plug(request_queue_t *);
 extern void blk_recount_segments(request_queue_t *, struct bio *);
 extern int scsi_cmd_ioctl(struct file *, struct gendisk *, unsigned int, void __user *);
 extern int sg_scsi_ioctl(struct file *, struct request_queue *,
@@ -627,19 +649,6 @@ static inline request_queue_t *bdev_get_
 	return bdev->bd_disk->queue;
 }
 
-static inline void blk_run_backing_dev(struct backing_dev_info *bdi,
-				       struct page *page)
-{
-	if (bdi && bdi->unplug_io_fn)
-		bdi->unplug_io_fn(bdi, page);
-}
-
-static inline void blk_run_address_space(struct address_space *mapping)
-{
-	if (mapping)
-		blk_run_backing_dev(mapping->backing_dev_info, NULL);
-}
-
 /*
  * end_request() and friends. Must be called with the request queue spinlock
  * acquired. All functions called within end_request() _must_be_ atomic.
@@ -723,8 +732,6 @@ extern void blk_ordered_complete_seq(req
 
 extern int blk_rq_map_sg(request_queue_t *, struct request *, struct scatterlist *);
 extern void blk_dump_rq_flags(struct request *, char *);
-extern void generic_unplug_device(request_queue_t *);
-extern void __generic_unplug_device(request_queue_t *);
 extern long nr_blockdev_pages(void);
 
 int blk_get_queue(request_queue_t *);
Index: linux-2.6/block/cfq-iosched.c
===================================================================
--- linux-2.6.orig/block/cfq-iosched.c
+++ linux-2.6/block/cfq-iosched.c
@@ -1750,10 +1750,7 @@ static void cfq_start_queueing(struct cf
 {
 	request_queue_t *q = cfqd->queue;
 
-	if (!blk_queue_plugged(q))
-		q->request_fn(q);
-	else
-		__generic_unplug_device(q);
+	q->request_fn(q);
 }
 
 /*
@@ -2109,7 +2106,6 @@ static void cfq_kick_queue(void *data)
 			wake_up(&rl->wait[WRITE]);
 	}
 
-	blk_remove_plug(q);
 	q->request_fn(q);
 	spin_unlock_irqrestore(q->queue_lock, flags);
 }
Index: linux-2.6/drivers/block/loop.c
===================================================================
--- linux-2.6.orig/drivers/block/loop.c
+++ linux-2.6/drivers/block/loop.c
@@ -536,17 +536,6 @@ out:
 	return 0;
 }
 
-/*
- * kick off io on the underlying address space
- */
-static void loop_unplug(request_queue_t *q)
-{
-	struct loop_device *lo = q->queuedata;
-
-	clear_bit(QUEUE_FLAG_PLUGGED, &q->queue_flags);
-	blk_run_address_space(lo->lo_backing_file->f_mapping);
-}
-
 struct switch_request {
 	struct file *file;
 	struct completion wait;
@@ -830,7 +819,6 @@ static int loop_set_fd(struct loop_devic
 	 */
 	blk_queue_make_request(lo->lo_queue, loop_make_request);
 	lo->lo_queue->queuedata = lo;
-	lo->lo_queue->unplug_fn = loop_unplug;
 
 	set_capacity(disks[lo->lo_number], size);
 	bd_set_size(bdev, size << 9);
Index: linux-2.6/include/linux/elevator.h
===================================================================
--- linux-2.6.orig/include/linux/elevator.h
+++ linux-2.6/include/linux/elevator.h
@@ -88,10 +88,11 @@ struct elevator_queue
  * block elevator interface
  */
 extern void elv_dispatch_sort(request_queue_t *, struct request *);
-extern void elv_add_request(request_queue_t *, struct request *, int, int);
-extern void __elv_add_request(request_queue_t *, struct request *, int, int);
+extern void elv_add_request(request_queue_t *, struct request *, int);
+extern void __elv_add_request(request_queue_t *, struct request *, int);
 extern void elv_insert(request_queue_t *, struct request *, int);
 extern int elv_merge(request_queue_t *, struct request **, struct bio *);
+extern int elv_try_merge(struct request *, struct bio *);
 extern void elv_merge_requests(request_queue_t *, struct request *,
 			       struct request *);
 extern void elv_merged_request(request_queue_t *, struct request *);
Index: linux-2.6/drivers/block/pktcdvd.c
===================================================================
--- linux-2.6.orig/drivers/block/pktcdvd.c
+++ linux-2.6/drivers/block/pktcdvd.c
@@ -377,8 +377,7 @@ static int pkt_generic_packet(struct pkt
 	rq->flags |= REQ_NOMERGE;
 	rq->waiting = &wait;
 	rq->end_io = blk_end_sync_rq;
-	elv_add_request(q, rq, ELEVATOR_INSERT_BACK, 1);
-	generic_unplug_device(q);
+	elv_add_request(q, rq, ELEVATOR_INSERT_BACK);
 	wait_for_completion(&wait);
 
 	if (rq->errors)
@@ -1231,8 +1230,6 @@ static int kcdrwd(void *foobar)
 					min_sleep_time = pkt->sleep_time;
 			}
 
-			generic_unplug_device(bdev_get_queue(pd->bdev));
-
 			VPRINTK("kcdrwd: sleeping\n");
 			residue = schedule_timeout(min_sleep_time);
 			VPRINTK("kcdrwd: wake up\n");
Index: linux-2.6/drivers/ide/ide-cd.c
===================================================================
--- linux-2.6.orig/drivers/ide/ide-cd.c
+++ linux-2.6/drivers/ide/ide-cd.c
@@ -785,15 +785,11 @@ static int cdrom_decode_status(ide_drive
 				if (time_after(jiffies, info->write_timeout))
 					do_end_request = 1;
 				else {
-					unsigned long flags;
-
 					/*
 					 * take a breather relying on the
 					 * unplug timer to kick us again
+					 * XXX: should be ide-cd local.
 					 */
-					spin_lock_irqsave(&ide_lock, flags);
-					blk_plug_device(drive->queue);
-					spin_unlock_irqrestore(&ide_lock,flags);
 					return 1;
 				}
 			}
@@ -3133,9 +3129,6 @@ int ide_cdrom_setup (ide_drive_t *drive)
 
 	blk_queue_prep_rq(drive->queue, ide_cdrom_prep_fn);
 	blk_queue_dma_alignment(drive->queue, 31);
-	drive->queue->unplug_delay = (1 * HZ) / 1000;
-	if (!drive->queue->unplug_delay)
-		drive->queue->unplug_delay = 1;
 
 	drive->special.all	= 0;
 
Index: linux-2.6/drivers/ide/ide-io.c
===================================================================
--- linux-2.6.orig/drivers/ide/ide-io.c
+++ linux-2.6/drivers/ide/ide-io.c
@@ -1082,15 +1082,8 @@ repeat:	
 	 * though that is 3 requests, it must be seen as a single transaction.
 	 * we must not preempt this drive until that is complete
 	 */
-	if (blk_queue_flushing(drive->queue)) {
-		/*
-		 * small race where queue could get replugged during
-		 * the 3-request flush cycle, just yank the plug since
-		 * we want it to finish asap
-		 */
-		blk_remove_plug(drive->queue);
+	if (blk_queue_flushing(drive->queue))
 		return drive;
-	}
 
 	do {
 		if ((!drive->sleeping || time_after_eq(jiffies, drive->sleep))
@@ -1098,10 +1091,7 @@ repeat:	
 			if (!best
 			 || (drive->sleeping && (!best->sleeping || time_before(drive->sleep, best->sleep)))
 			 || (!best->sleeping && time_before(WAKEUP(drive), WAKEUP(best))))
-			{
-				if (!blk_queue_plugged(drive->queue))
-					best = drive;
-			}
+				best = drive;
 		}
 	} while ((drive = drive->next) != hwgroup->drive);
 	if (best && best->nice1 && !best->sleeping && best != hwgroup->drive && best->service_time > WAIT_MIN_SLEEP) {
@@ -1233,11 +1223,6 @@ static void ide_do_request (ide_hwgroup_
 		drive->sleeping = 0;
 		drive->service_start = jiffies;
 
-		if (blk_queue_plugged(drive->queue)) {
-			printk(KERN_ERR "ide: huh? queue was plugged!\n");
-			break;
-		}
-
 		/*
 		 * we know that the queue isn't empty, but this can happen
 		 * if the q->prep_rq_fn() decides to kill a request
@@ -1266,7 +1251,7 @@ static void ide_do_request (ide_hwgroup_
 		 */
 		if (drive->blocked && !blk_pm_request(rq) && !(rq->flags & REQ_PREEMPT)) {
 			drive = drive->next ? drive->next : hwgroup->drive;
-			if (loops++ < 4 && !blk_queue_plugged(drive->queue))
+			if (loops++ < 4)
 				goto again;
 			/* We clear busy, there should be no pending ATA command at this point. */
 			hwgroup->busy = 0;
@@ -1729,7 +1714,7 @@ int ide_do_drive_cmd (ide_drive_t *drive
 		where = ELEVATOR_INSERT_FRONT;
 		rq->flags |= REQ_PREEMPT;
 	}
-	__elv_add_request(drive->queue, rq, where, 0);
+	__elv_add_request(drive->queue, rq, where);
 	ide_do_request(hwgroup, IDE_NO_IRQ);
 	spin_unlock_irqrestore(&ide_lock, flags);
 
Index: linux-2.6/drivers/scsi/scsi_lib.c
===================================================================
--- linux-2.6.orig/drivers/scsi/scsi_lib.c
+++ linux-2.6/drivers/scsi/scsi_lib.c
@@ -117,6 +117,7 @@ int scsi_queue_insert(struct scsi_cmnd *
 	SCSI_LOG_MLQUEUE(1,
 		 printk("Inserting command %p into mlqueue\n", cmd));
 
+#if 0
 	/*
 	 * Set the appropriate busy bit for the device/host.
 	 *
@@ -134,6 +135,7 @@ int scsi_queue_insert(struct scsi_cmnd *
 		host->host_blocked = host->max_host_blocked;
 	else if (reason == SCSI_MLQUEUE_DEVICE_BUSY)
 		device->device_blocked = device->max_device_blocked;
+#endif
 
 	/*
 	 * Decrement the counters, since these commands are no longer
@@ -144,14 +146,7 @@ int scsi_queue_insert(struct scsi_cmnd *
 	/*
 	 * Requeue this command.  It will go before all other commands
 	 * that are already in the queue.
-	 *
-	 * NOTE: there is magic here about the way the queue is plugged if
-	 * we have no outstanding commands.
-	 * 
-	 * Although we *don't* plug the queue, we call the request
-	 * function.  The SCSI request function detects the blocked condition
-	 * and plugs the queue appropriately.
-         */
+	 */
 	spin_lock_irqsave(q->queue_lock, flags);
 	blk_requeue_request(q, cmd->request);
 	spin_unlock_irqrestore(q->queue_lock, flags);
@@ -1229,11 +1224,8 @@ static int scsi_prep_fn(struct request_q
 	return BLKPREP_OK;
 
  defer:
-	/* If we defer, the elv_next_request() returns NULL, but the
-	 * queue must be restarted, so we plug here if no returning
-	 * command will automatically do that. */
-	if (sdev->device_busy == 0)
-		blk_plug_device(q);
+ 	if (sdev->device_busy == 0)
+		WARN_ON(1);
 	return BLKPREP_DEFER;
  kill:
 	req->errors = DID_NO_CONNECT << 16;
@@ -1260,7 +1252,7 @@ static inline int scsi_dev_queue_ready(s
 				   sdev_printk(KERN_INFO, sdev,
 				   "unblocking device at zero depth\n"));
 		} else {
-			blk_plug_device(q);
+			WARN_ON(1);
 			return 0;
 		}
 	}
@@ -1292,7 +1284,7 @@ static inline int scsi_host_queue_ready(
 				printk("scsi%d unblocking host at zero depth\n",
 					shost->host_no));
 		} else {
-			blk_plug_device(q);
+			WARN_ON(1);
 			return 0;
 		}
 	}
@@ -1415,7 +1407,7 @@ static void scsi_request_fn(struct reque
 	 * the host is no longer able to accept any more requests.
 	 */
 	shost = sdev->host;
-	while (!blk_queue_plugged(q)) {
+	for (;;) {
 		int rtn;
 		/*
 		 * get next queueable request.  We do this early to make sure
@@ -1478,16 +1470,12 @@ static void scsi_request_fn(struct reque
 		 * Dispatch the command to the low-level driver.
 		 */
 		rtn = scsi_dispatch_cmd(cmd);
-		spin_lock_irq(q->queue_lock);
-		if(rtn) {
-			/* we're refusing the command; because of
-			 * the way locks get dropped, we need to 
-			 * check here if plugging is required */
-			if(sdev->device_busy == 0)
-				blk_plug_device(q);
-
-			break;
+		if (rtn) {
+			if (sdev->device_busy == 0)
+				WARN_ON(1);
+			goto out_nolock;
 		}
+		spin_lock_irq(q->queue_lock);
 	}
 
 	goto out;
@@ -1506,12 +1494,13 @@ static void scsi_request_fn(struct reque
 	spin_lock_irq(q->queue_lock);
 	blk_requeue_request(q, req);
 	sdev->device_busy--;
-	if(sdev->device_busy == 0)
-		blk_plug_device(q);
+	if (sdev->device_busy == 0)
+		WARN_ON(1);
  out:
 	/* must be careful here...if we trigger the ->remove() function
 	 * we cannot be holding the q lock */
 	spin_unlock_irq(q->queue_lock);
+ out_nolock:
 	put_device(&sdev->sdev_gendev);
 	spin_lock_irq(q->queue_lock);
 }
Index: linux-2.6/include/linux/backing-dev.h
===================================================================
--- linux-2.6.orig/include/linux/backing-dev.h
+++ linux-2.6/include/linux/backing-dev.h
@@ -28,8 +28,6 @@ struct backing_dev_info {
 	unsigned int capabilities; /* Device capabilities */
 	congested_fn *congested_fn; /* Function pointer if device is md/dm */
 	void *congested_data;	/* Pointer to aux data for congested func */
-	void (*unplug_io_fn)(struct backing_dev_info *, struct page *);
-	void *unplug_io_data;
 };
 
 
@@ -59,7 +57,6 @@ struct backing_dev_info {
 #endif
 
 extern struct backing_dev_info default_backing_dev_info;
-void default_unplug_io_fn(struct backing_dev_info *bdi, struct page *page);
 
 int writeback_acquire(struct backing_dev_info *bdi);
 int writeback_in_progress(struct backing_dev_info *bdi);
Index: linux-2.6/mm/readahead.c
===================================================================
--- linux-2.6.orig/mm/readahead.c
+++ linux-2.6/mm/readahead.c
@@ -15,16 +15,10 @@
 #include <linux/backing-dev.h>
 #include <linux/pagevec.h>
 
-void default_unplug_io_fn(struct backing_dev_info *bdi, struct page *page)
-{
-}
-EXPORT_SYMBOL(default_unplug_io_fn);
-
 struct backing_dev_info default_backing_dev_info = {
 	.ra_pages	= (VM_MAX_READAHEAD * 1024) / PAGE_CACHE_SIZE,
 	.state		= 0,
 	.capabilities	= BDI_CAP_MAP_COPY,
-	.unplug_io_fn	= default_unplug_io_fn,
 };
 EXPORT_SYMBOL_GPL(default_backing_dev_info);
 
@@ -170,6 +164,8 @@ static int read_pages(struct address_spa
 	struct pagevec lru_pvec;
 	int ret;
 
+	plug_current();
+
 	if (mapping->a_ops->readpages) {
 		ret = mapping->a_ops->readpages(filp, mapping, pages, nr_pages);
 		goto out;
@@ -189,7 +185,10 @@ static int read_pages(struct address_spa
 	}
 	pagevec_lru_add(&lru_pvec);
 	ret = 0;
+
 out:
+	unplug_current();
+
 	return ret;
 }
 
Index: linux-2.6/mm/shmem.c
===================================================================
--- linux-2.6.orig/mm/shmem.c
+++ linux-2.6/mm/shmem.c
@@ -181,7 +181,6 @@ static struct vm_operations_struct shmem
 static struct backing_dev_info shmem_backing_dev_info  __read_mostly = {
 	.ra_pages	= 0,	/* No readahead */
 	.capabilities	= BDI_CAP_NO_ACCT_DIRTY | BDI_CAP_NO_WRITEBACK,
-	.unplug_io_fn	= default_unplug_io_fn,
 };
 
 static LIST_HEAD(shmem_swaplist);
Index: linux-2.6/mm/swap_state.c
===================================================================
--- linux-2.6.orig/mm/swap_state.c
+++ linux-2.6/mm/swap_state.c
@@ -21,19 +21,16 @@
 
 /*
  * swapper_space is a fiction, retained to simplify the path through
- * vmscan's shrink_list, to make sync_page look nicer, and to allow
- * future use of radix_tree tags in the swap cache.
+ * vmscan's shrink_list.
  */
 static const struct address_space_operations swap_aops = {
 	.writepage	= swap_writepage,
-	.sync_page	= block_sync_page,
 	.set_page_dirty	= __set_page_dirty_nobuffers,
 	.migratepage	= migrate_page,
 };
 
 static struct backing_dev_info swap_backing_dev_info = {
 	.capabilities	= BDI_CAP_NO_ACCT_DIRTY | BDI_CAP_NO_WRITEBACK,
-	.unplug_io_fn	= swap_unplug_io_fn,
 };
 
 struct address_space swapper_space = {
Index: linux-2.6/mm/swapfile.c
===================================================================
--- linux-2.6.orig/mm/swapfile.c
+++ linux-2.6/mm/swapfile.c
@@ -48,39 +48,6 @@ static struct swap_info_struct swap_info
 
 static DEFINE_MUTEX(swapon_mutex);
 
-/*
- * We need this because the bdev->unplug_fn can sleep and we cannot
- * hold swap_lock while calling the unplug_fn. And swap_lock
- * cannot be turned into a mutex.
- */
-static DECLARE_RWSEM(swap_unplug_sem);
-
-void swap_unplug_io_fn(struct backing_dev_info *unused_bdi, struct page *page)
-{
-	swp_entry_t entry;
-
-	down_read(&swap_unplug_sem);
-	entry.val = page_private(page);
-	if (PageSwapCache(page)) {
-		struct block_device *bdev = swap_info[swp_type(entry)].bdev;
-		struct backing_dev_info *bdi;
-
-		/*
-		 * If the page is removed from swapcache from under us (with a
-		 * racy try_to_unuse/swapoff) we need an additional reference
-		 * count to avoid reading garbage from page_private(page) above.
-		 * If the WARN_ON triggers during a swapoff it maybe the race
-		 * condition and it's harmless. However if it triggers without
-		 * swapoff it signals a problem.
-		 */
-		WARN_ON(page_count(page) <= 1);
-
-		bdi = bdev->bd_inode->i_mapping->backing_dev_info;
-		blk_run_backing_dev(bdi, page);
-	}
-	up_read(&swap_unplug_sem);
-}
-
 #define SWAPFILE_CLUSTER	256
 #define LATENCY_LIMIT		256
 
@@ -1219,10 +1186,6 @@ asmlinkage long sys_swapoff(const char _
 		goto out_dput;
 	}
 
-	/* wait for any unplug function to finish */
-	down_write(&swap_unplug_sem);
-	up_write(&swap_unplug_sem);
-
 	destroy_swap_extents(p);
 	mutex_lock(&swapon_mutex);
 	spin_lock(&swap_lock);
Index: linux-2.6/fs/block_dev.c
===================================================================
--- linux-2.6.orig/fs/block_dev.c
+++ linux-2.6/fs/block_dev.c
@@ -1166,7 +1166,6 @@ static long block_ioctl(struct file *fil
 const struct address_space_operations def_blk_aops = {
 	.readpage	= blkdev_readpage,
 	.writepage	= blkdev_writepage,
-	.sync_page	= block_sync_page,
 	.prepare_write	= blkdev_prepare_write,
 	.commit_write	= blkdev_commit_write,
 	.writepages	= generic_writepages,
Index: linux-2.6/fs/ext2/inode.c
===================================================================
--- linux-2.6.orig/fs/ext2/inode.c
+++ linux-2.6/fs/ext2/inode.c
@@ -688,7 +688,6 @@ const struct address_space_operations ex
 	.readpage		= ext2_readpage,
 	.readpages		= ext2_readpages,
 	.writepage		= ext2_writepage,
-	.sync_page		= block_sync_page,
 	.prepare_write		= ext2_prepare_write,
 	.commit_write		= generic_commit_write,
 	.bmap			= ext2_bmap,
@@ -706,7 +705,6 @@ const struct address_space_operations ex
 	.readpage		= ext2_readpage,
 	.readpages		= ext2_readpages,
 	.writepage		= ext2_nobh_writepage,
-	.sync_page		= block_sync_page,
 	.prepare_write		= ext2_nobh_prepare_write,
 	.commit_write		= nobh_commit_write,
 	.bmap			= ext2_bmap,
Index: linux-2.6/fs/ext3/inode.c
===================================================================
--- linux-2.6.orig/fs/ext3/inode.c
+++ linux-2.6/fs/ext3/inode.c
@@ -1705,7 +1705,6 @@ static const struct address_space_operat
 	.readpage	= ext3_readpage,
 	.readpages	= ext3_readpages,
 	.writepage	= ext3_ordered_writepage,
-	.sync_page	= block_sync_page,
 	.prepare_write	= ext3_prepare_write,
 	.commit_write	= ext3_ordered_commit_write,
 	.bmap		= ext3_bmap,
@@ -1719,7 +1718,6 @@ static const struct address_space_operat
 	.readpage	= ext3_readpage,
 	.readpages	= ext3_readpages,
 	.writepage	= ext3_writeback_writepage,
-	.sync_page	= block_sync_page,
 	.prepare_write	= ext3_prepare_write,
 	.commit_write	= ext3_writeback_commit_write,
 	.bmap		= ext3_bmap,
@@ -1733,7 +1731,6 @@ static const struct address_space_operat
 	.readpage	= ext3_readpage,
 	.readpages	= ext3_readpages,
 	.writepage	= ext3_journalled_writepage,
-	.sync_page	= block_sync_page,
 	.prepare_write	= ext3_prepare_write,
 	.commit_write	= ext3_journalled_commit_write,
 	.set_page_dirty	= ext3_journalled_set_page_dirty,
Index: linux-2.6/fs/hfs/inode.c
===================================================================
--- linux-2.6.orig/fs/hfs/inode.c
+++ linux-2.6/fs/hfs/inode.c
@@ -117,7 +117,6 @@ static int hfs_writepages(struct address
 const struct address_space_operations hfs_btree_aops = {
 	.readpage	= hfs_readpage,
 	.writepage	= hfs_writepage,
-	.sync_page	= block_sync_page,
 	.prepare_write	= hfs_prepare_write,
 	.commit_write	= generic_commit_write,
 	.bmap		= hfs_bmap,
@@ -127,7 +126,6 @@ const struct address_space_operations hf
 const struct address_space_operations hfs_aops = {
 	.readpage	= hfs_readpage,
 	.writepage	= hfs_writepage,
-	.sync_page	= block_sync_page,
 	.prepare_write	= hfs_prepare_write,
 	.commit_write	= generic_commit_write,
 	.bmap		= hfs_bmap,
Index: linux-2.6/include/linux/buffer_head.h
===================================================================
--- linux-2.6.orig/include/linux/buffer_head.h
+++ linux-2.6/include/linux/buffer_head.h
@@ -202,7 +202,6 @@ int cont_prepare_write(struct page*, uns
 int generic_cont_expand(struct inode *inode, loff_t size);
 int generic_cont_expand_simple(struct inode *inode, loff_t size);
 int block_commit_write(struct page *page, unsigned from, unsigned to);
-void block_sync_page(struct page *);
 sector_t generic_block_bmap(struct address_space *, sector_t, get_block_t *);
 int generic_commit_write(struct file *, struct page *, unsigned, unsigned);
 int block_truncate_page(struct address_space *, loff_t, get_block_t *);
Index: linux-2.6/include/linux/fs.h
===================================================================
--- linux-2.6.orig/include/linux/fs.h
+++ linux-2.6/include/linux/fs.h
@@ -354,7 +354,6 @@ struct writeback_control;
 struct address_space_operations {
 	int (*writepage)(struct page *page, struct writeback_control *wbc);
 	int (*readpage)(struct file *, struct page *);
-	void (*sync_page)(struct page *);
 
 	/* Write back some dirty pages from this mapping. */
 	int (*writepages)(struct address_space *, struct writeback_control *);
Index: linux-2.6/fs/hfsplus/inode.c
===================================================================
--- linux-2.6.orig/fs/hfsplus/inode.c
+++ linux-2.6/fs/hfsplus/inode.c
@@ -112,7 +112,6 @@ static int hfsplus_writepages(struct add
 const struct address_space_operations hfsplus_btree_aops = {
 	.readpage	= hfsplus_readpage,
 	.writepage	= hfsplus_writepage,
-	.sync_page	= block_sync_page,
 	.prepare_write	= hfsplus_prepare_write,
 	.commit_write	= generic_commit_write,
 	.bmap		= hfsplus_bmap,
@@ -122,7 +121,6 @@ const struct address_space_operations hf
 const struct address_space_operations hfsplus_aops = {
 	.readpage	= hfsplus_readpage,
 	.writepage	= hfsplus_writepage,
-	.sync_page	= block_sync_page,
 	.prepare_write	= hfsplus_prepare_write,
 	.commit_write	= generic_commit_write,
 	.bmap		= hfsplus_bmap,
Index: linux-2.6/fs/isofs/inode.c
===================================================================
--- linux-2.6.orig/fs/isofs/inode.c
+++ linux-2.6/fs/isofs/inode.c
@@ -1055,7 +1055,6 @@ static sector_t _isofs_bmap(struct addre
 
 static const struct address_space_operations isofs_aops = {
 	.readpage = isofs_readpage,
-	.sync_page = block_sync_page,
 	.bmap = _isofs_bmap
 };
 
Index: linux-2.6/fs/udf/file.c
===================================================================
--- linux-2.6.orig/fs/udf/file.c
+++ linux-2.6/fs/udf/file.c
@@ -98,7 +98,6 @@ static int udf_adinicb_commit_write(stru
 const struct address_space_operations udf_adinicb_aops = {
 	.readpage		= udf_adinicb_readpage,
 	.writepage		= udf_adinicb_writepage,
-	.sync_page		= block_sync_page,
 	.prepare_write		= udf_adinicb_prepare_write,
 	.commit_write		= udf_adinicb_commit_write,
 };
Index: linux-2.6/fs/udf/inode.c
===================================================================
--- linux-2.6.orig/fs/udf/inode.c
+++ linux-2.6/fs/udf/inode.c
@@ -135,7 +135,6 @@ static sector_t udf_bmap(struct address_
 const struct address_space_operations udf_aops = {
 	.readpage		= udf_readpage,
 	.writepage		= udf_writepage,
-	.sync_page		= block_sync_page,
 	.prepare_write		= udf_prepare_write,
 	.commit_write		= generic_commit_write,
 	.bmap			= udf_bmap,
Index: linux-2.6/include/linux/sched.h
===================================================================
--- linux-2.6.orig/include/linux/sched.h
+++ linux-2.6/include/linux/sched.h
@@ -951,6 +951,7 @@ struct task_struct {
 
 	struct backing_dev_info *backing_dev_info;
 
+/* block state */
 	struct io_context *io_context;
 
 	unsigned long ptrace_message;
Index: linux-2.6/mm/vmscan.c
===================================================================
--- linux-2.6.orig/mm/vmscan.c
+++ linux-2.6/mm/vmscan.c
@@ -961,6 +961,7 @@ static unsigned long shrink_zones(int pr
  */
 unsigned long try_to_free_pages(struct zone **zones, gfp_t gfp_mask)
 {
+	int plugdepth;
 	int priority;
 	int ret = 0;
 	unsigned long total_scanned = 0;
@@ -978,6 +979,8 @@ unsigned long try_to_free_pages(struct z
 
 	count_vm_event(ALLOCSTALL);
 
+	plugdepth = unplug_current_nested();
+
 	for (i = 0; zones[i] != NULL; i++) {
 		struct zone *zone = zones[i];
 
@@ -1030,6 +1033,9 @@ out:
 
 		zone->prev_priority = zone->temp_priority;
 	}
+
+	plug_current_nested(plugdepth);
+
 	return ret;
 }
 
Index: linux-2.6/mm/page-writeback.c
===================================================================
--- linux-2.6.orig/mm/page-writeback.c
+++ linux-2.6/mm/page-writeback.c
@@ -548,12 +548,18 @@ int do_writepages(struct address_space *
 
 	if (wbc->nr_to_write <= 0)
 		return 0;
+
+	plug_current();
+
 	wbc->for_writepages = 1;
 	if (mapping->a_ops->writepages)
 		ret =  mapping->a_ops->writepages(mapping, wbc);
 	else
 		ret = generic_writepages(mapping, wbc);
 	wbc->for_writepages = 0;
+
+	unplug_current();
+
 	return ret;
 }
 
Index: linux-2.6/fs/direct-io.c
===================================================================
--- linux-2.6.orig/fs/direct-io.c
+++ linux-2.6/fs/direct-io.c
@@ -383,13 +383,14 @@ static struct bio *dio_await_one(struct 
 	unsigned long flags;
 	struct bio *bio;
 
+	replug_current_nested();
+
 	spin_lock_irqsave(&dio->bio_lock, flags);
 	while (dio->bio_list == NULL) {
 		set_current_state(TASK_UNINTERRUPTIBLE);
 		if (dio->bio_list == NULL) {
 			dio->waiter = current;
 			spin_unlock_irqrestore(&dio->bio_lock, flags);
-			blk_run_address_space(dio->inode->i_mapping);
 			io_schedule();
 			spin_lock_irqsave(&dio->bio_lock, flags);
 			dio->waiter = NULL;
@@ -1097,9 +1098,11 @@ direct_io_worker(int rw, struct kiocb *i
 		if (ret == 0)
 			ret = dio->result;
 		finished_one_bio(dio);		/* This can free the dio */
-		blk_run_address_space(inode->i_mapping);
 		if (should_wait) {
 			unsigned long flags;
+
+			replug_current_nested();
+
 			/*
 			 * Wait for already issued I/O to drain out and
 			 * release its references to user-space pages
@@ -1194,6 +1197,8 @@ __blockdev_direct_IO(int rw, struct kioc
 	int release_i_mutex = 0;
 	int acquire_i_mutex = 0;
 
+	plug_current();
+
 	if (rw & WRITE)
 		rw = WRITE_SYNC;
 
@@ -1286,6 +1291,8 @@ out:
 		mutex_unlock(&inode->i_mutex);
 	else if (acquire_i_mutex)
 		mutex_lock(&inode->i_mutex);
+
+	unplug_current();
 	return retval;
 }
 EXPORT_SYMBOL(__blockdev_direct_IO);
