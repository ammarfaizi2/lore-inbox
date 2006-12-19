Return-Path: <linux-kernel-owner+w=401wt.eu-S933046AbWLSWOc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933046AbWLSWOc (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 17:14:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933047AbWLSWOc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 17:14:32 -0500
Received: from mx1.redhat.com ([66.187.233.31]:45119 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933045AbWLSWOa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 17:14:30 -0500
Date: Tue, 19 Dec 2006 17:14:08 -0500 (EST)
Message-Id: <20061219.171408.111210519.k-ueda@ct.jp.nec.com>
To: jens.axboe@oracle.com, agk@redhat.com, mchristi@redhat.com,
       linux-kernel@vger.kernel.org, dm-devel@redhat.com
Cc: j-nomura@ce.jp.nec.com, k-ueda@ct.jp.nec.com
Subject: [RFC PATCH 7/8] rqbased-dm: core code
From: Kiyoshi Ueda <k-ueda@ct.jp.nec.com>
X-Mailer: Mew version 2.3 on Emacs 20.7 / Mule 4.1
 =?iso-2022-jp?B?KBskQjAqGyhCKQ==?=
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds core code for request-based device-mapper.

Changed and added md->queue's functions
----------------------------------------
  Method           Function name                 Called from
  -------------------------------------------------------------------------
  make_request_fn: dm_make_request()             generic_make_request()
  request_fn     : dm_request_fn()               __generic_unplug_device()
  prep_rq_fn     : dm_prep_fn()                  elv_next_request()


Endio functions of struct request
----------------------------------
  Method           Function name                 Called from
  -------------------------------------------------------------------------
  end_io_first   : clone_request_endio_first()   __end_that_request_first()
  end_io         : clone_request_endio()         end_that_request_last()


md->queue (queue member of struct mapped device)
-------------------------------------------------
md->queue has an I/O scheduler and it is used to keep submitted bios
as struct request in the mapped device temporarily and merge them
if possible.

md->queue has make_request_fn, request_fn and prep_rq_fn.
Mapping is done in request_fn and prep_rq_fn after requests are
sorted by I/O scheduler.


bio to request
---------------
md->queue->make_request_fn is called for a submitted bio.
The bio is checked whether it's spanned across targets or not.
If it's not spanned across targets, __make_request() is called
for the bio.

If it's spanned across targets, splitted clones for the bio are
created like current dm and __make_request() is called for each clone.
NO_MERGE flag is set for each clone preliminarily so that they
can't be merged again in __make_request().
(This is not implemented yet.)


map
----
After md->queue is unpluged, prep_map/clone/map/dispatch are done
in request_fn function (dm_request_fn()).
prep_map is a new target function which is called to decide devices
to which the I/O should be directed when original request is pulled
from I/O scheduler.
map function is needed to be splitted into 'prep_map' and 'map'
because clone of request must be gotten from mapped underlying
device's queue and it must be done before map function call.
So the device decision is done in prep_map before clone in dm core.

Imprementation is:
In dm_request_fn(), target prep_map function is called from
dm_prep_fn() and it stores the mapping information (struct dm_map_info)
into rq->special.
The mapping information is passed to clone_and_map_request() and it
gets a clone from the device specified in the mapping information.
After getting clone, the clone is mapped by target's map_rq function
and dispatched to the device which is decided by prep_map.


endio_first
------------
clone_request_endio_first() is called to finish bios of a returned
clone.  Target's endio_first function is called from the
clone_request_endio_first() and it checks errors of the clone
and decides whether the original request can be finished or not.
If retry is needed, target has to remember it until endio below
is called.

If bio was splitted, the same procedure will be done for finishing
the cloned bio and the original bio.
(Splitting is not implemented yet.)


endio
------
clone_request_endio() is called when the cloned I/O finishes.
Target's endio function is called from clone_request_endio() and
it can decide to retry or not.
If no need to retry, clone_request_endio() will free the original
request and the clone request.


suspend/resume
---------------
Stop md->queue after flush at suspend time.
Start md->queue at resume time.


Signed-off-by: Kiyoshi Ueda <k-ueda@ct.jp.nec.com>
Signed-off-by: Jun'ichi Nomura <j-nomura@ce.jp.nec.com>

diff -rupN 6-add-target-func/drivers/md/dm.c 7-rqbase-dm-core/drivers/md/dm.c
--- 6-add-target-func/drivers/md/dm.c	2006-12-15 10:40:15.000000000 -0500
+++ 7-rqbase-dm-core/drivers/md/dm.c	2006-12-15 10:57:16.000000000 -0500
@@ -550,6 +550,117 @@ static int clone_endio(struct bio *bio, 
 	return r;
 }
 
+static void blk_update_cloned_rq(struct request *rq, struct request *clone)
+{
+	clone->nr_phys_segments = rq->nr_phys_segments;
+	clone->nr_hw_segments = rq->nr_hw_segments;
+	clone->current_nr_sectors = rq->current_nr_sectors;
+	clone->hard_cur_sectors = rq->hard_cur_sectors;
+	clone->hard_nr_sectors = rq->hard_nr_sectors;
+	clone->nr_sectors = rq->nr_sectors;
+	clone->hard_sector = rq->hard_sector;
+	clone->sector = rq->sector;
+	clone->data_len = rq->data_len;
+	clone->buffer = rq->buffer;
+	clone->data = rq->data;
+	clone->bio = rq->bio;
+	clone->biotail = rq->biotail;
+}
+
+static int clone_request_endio_first(struct request *clone, int uptodate,
+				     int nr_bytes)
+{
+	int r = 0;
+	struct rq_target_io *tio = clone->end_io_data;
+	dm_request_endio_first_fn endio_first = tio->ti->type->rq_end_io_first;
+	struct request *orig = tio->rq;
+
+	if (endio_first) {
+		r = endio_first(tio->ti, clone, uptodate, &tio->info);
+		switch (r) {
+		case 0:
+			/* succeeded. complete original request's chunk. */
+			break;
+		case 1:
+			/*
+			 * the target wants:
+			 *   original request not being completed
+			 *   end_that_request_last() not being called
+			 */
+			return 1;
+		case 2:
+			/*
+			 * the target wants:
+			 *   original request not being completed
+			 *   end_that_request_last() being called
+			 */
+			return 0;
+		default:
+			/* error detected. direct the error to upper layer. */
+			uptodate = r;
+			break;
+		}
+	}
+
+	/* complete original request's chunk */
+	r = end_that_request_chunk(orig, uptodate, nr_bytes);
+
+	/*
+	 * recopy orig req fields that were updated in end_that_request_chunk
+	 * to our clone
+	 */
+	blk_update_cloned_rq(orig, clone);
+
+	return r;
+}
+
+static void dec_rq_pending(struct rq_target_io *tio)
+{
+	if (!atomic_dec_return(&tio->md->pending))
+		/* nudge anyone waiting on suspend queue */
+		wake_up(&tio->md->wait);
+}
+
+/*
+ * called with clone->q->queue_lock held
+ */
+static void clone_request_endio(struct request *clone, int error)
+{
+	int requeue = 0;
+	struct rq_target_io *tio = clone->end_io_data;
+	dm_request_endio_fn endio = tio->ti->type->rq_end_io;
+	struct request *orig = tio->rq;
+	struct request_queue *q = clone->q, *q_orig = orig->q;
+
+	if (endio)
+		requeue = endio(tio->ti, clone, error, &tio->info);
+
+	spin_unlock(q->queue_lock);
+	spin_lock(q_orig->queue_lock);
+
+	if (requeue) {
+		/* we have parts that need a requeue */
+		blk_requeue_request(q_orig, orig);
+
+/* Do we need plug here?
+		if (elv_queue_empty(q_orig))
+			blk_plug_device(q_orig);
+ */
+	} else {
+		/* complete original request */
+		end_that_request_last(orig, 1);
+	}
+
+	spin_unlock(q_orig->queue_lock);
+	blk_run_queue(q_orig);
+
+	spin_lock(q->queue_lock);
+
+	dec_rq_pending(tio);
+	free_rq_tio(tio->md, tio);
+	__blk_put_request(q, clone);
+}
+
 static sector_t max_io_len(struct mapped_device *md,
 			   sector_t sector, struct dm_target *ti)
 {
@@ -851,6 +962,246 @@ static int dm_request(request_queue_t *q
 	return 0;
 }
 
+/* FIXME */
+static int dm_make_request(request_queue_t *q, struct bio *bio)
+{
+	int r = 0;
+	struct mapped_device *md = (struct mapped_device *)q->queuedata;
+
+	r = md->saved_make_request_fn(q, bio); /* call __make_request() */
+
+	return r;
+}
+
+/*
+ * The queue is only valid as long as you have a reference
+ * count on 'md'.
+ */
+struct request_queue *dm_get_queue(struct mapped_device *md)
+{
+	if (blk_get_queue(md->queue))
+		return NULL;
+
+	return md->queue;
+}
+EXPORT_SYMBOL_GPL(dm_get_queue);
+
+void dm_put_queue(struct request_queue *q)
+{
+	blk_put_queue(q);
+}
+EXPORT_SYMBOL_GPL(dm_put_queue);
+
+void dm_stop_queue(struct request_queue *q)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(q->queue_lock, flags);
+	blk_stop_queue(q);
+	spin_unlock_irqrestore(q->queue_lock, flags);
+}
+EXPORT_SYMBOL_GPL(dm_stop_queue);
+
+void dm_start_queue(struct request_queue *q)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(q->queue_lock, flags);
+	if (blk_queue_stopped(q))
+		blk_start_queue(q);
+	spin_unlock_irqrestore(q->queue_lock, flags);
+}
+EXPORT_SYMBOL_GPL(dm_start_queue);
+
+void dm_requeue_request(struct request_queue *q, struct request *rq)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(q->queue_lock, flags);
+	blk_requeue_request(q, rq);
+	blk_plug_device(q);
+	spin_unlock_irqrestore(q->queue_lock, flags);
+}
+EXPORT_SYMBOL_GPL(dm_requeue_request);
+
+/*
+ * Called with q->queue_lock held
+ */
+static int dm_prep_fn(struct request_queue *q, struct request *rq)
+{
+	int r = BLKPREP_OK;
+	struct mapped_device *md = (struct mapped_device *)q->queuedata;
+	struct dm_table *map = dm_get_table(md);
+	struct dm_target *ti = dm_table_find_target(map, rq->sector);
+
+	r = ti->type->prep_map(ti, rq, q);
+
+	dm_table_put(map);
+
+	return r;
+}
+
+static void kill_request(struct request *rq)
+{
+	int nr_bytes = rq->hard_nr_sectors << 9;
+
+	if (!nr_bytes)
+		nr_bytes = rq->data_len;
+
+	rq->cmd_flags |= REQ_QUIET;
+	end_that_request_chunk(rq, 0, nr_bytes);
+	end_that_request_last(rq, 0);
+}
+
+static void free_map_info(struct dm_target *ti, struct request *rq)
+{
+	if (ti->type->free_context)
+		ti->type->free_context(ti, rq);
+
+	kfree(rq->special);
+}
+
+/*
+ * This should go into ll_rw_blk.c
+ */
+static struct request *blk_clone_rq(struct request *rq,
+				    struct request_queue *q, gfp_t gfp_mask)
+{
+	struct request *clone;
+
+	clone = blk_get_request(q, rq_data_dir(rq), gfp_mask);
+	if (!clone)
+		return NULL;
+
+	memcpy(clone->cmd, rq->cmd, sizeof(rq->cmd));
+	clone->cmd_len = rq->cmd_len;
+	clone->cmd_flags |= rq_data_dir(rq);
+	clone->cmd_type = rq->cmd_type;
+	clone->nr_phys_segments = rq->nr_phys_segments;
+	clone->nr_hw_segments = rq->nr_hw_segments;
+	clone->current_nr_sectors = rq->current_nr_sectors;
+	clone->hard_cur_sectors = rq->hard_cur_sectors;
+	clone->hard_nr_sectors = rq->hard_nr_sectors;
+	clone->nr_sectors = rq->nr_sectors;
+	clone->hard_sector = rq->hard_sector;
+	clone->sector = rq->sector;
+	clone->data_len = rq->data_len;
+	clone->buffer = rq->buffer;
+	clone->data = rq->data;
+	clone->bio = rq->bio;
+	clone->biotail = rq->biotail;
+	clone->sense = rq->sense;
+	clone->ioprio = rq->ioprio;
+
+	return clone;
+}
+
+struct request *clone_request(struct request *rq)
+{
+	struct dm_map_info *mi = (struct dm_map_info *) rq->special;
+	struct request_queue *dest_q = bdev_get_queue(mi->devs);
+	struct request *clone;
+
+	clone = blk_clone_rq(rq, dest_q, GFP_ATOMIC);
+	if (!clone)
+		return NULL;
+
+	clone->cmd_flags |= REQ_NOMERGE;
+	clone->end_io = clone_request_endio;
+	clone->end_io_first = clone_request_endio_first;
+
+	return clone;
+}
+
+static void clone_and_map_request(struct request_queue *q, struct request *rq)
+{
+	int r;
+	struct mapped_device *md = (struct mapped_device *)q->queuedata;
+	struct dm_table *map = dm_get_table(md);
+	struct dm_target *ti = dm_table_find_target(map, rq->sector);
+	struct dm_map_info *mi = (struct dm_map_info *)rq->special;
+	struct request *clone;
+	struct rq_target_io *tio;
+	unsigned long flags;
+
+	tio = alloc_rq_tio(md); /* only one for each original request */
+	if (!tio)
+		/* -ENOMEM */
+		goto requeue;
+	tio->md = md;
+	tio->error = 0;
+	tio->rq = rq;
+	tio->ti = ti;
+	memset(&tio->info, 0, sizeof(tio->info));
+
+	clone = clone_request(rq);
+	if (!clone) {
+		free_rq_tio(md, tio);
+		goto requeue;
+	}
+
+	clone->end_io_data = tio;
+	r = ti->type->map_rq(ti, clone, &tio->info, mi);
+	switch (r) {
+	case 0:
+		/* success */
+		kfree(mi);
+		atomic_inc(&md->pending);
+
+		spin_lock_irqsave(clone->q->queue_lock, flags);
+//		drive_stat_acct(clone, clone->nr_sectors, 1);
+		disk_round_stats(clone->rq_disk);
+		clone->rq_disk->in_flight++;
+		spin_unlock_irqrestore(clone->q->queue_lock, flags);
+
+		elv_add_request(clone->q, clone, ELEVATOR_INSERT_BACK, 0);
+		break;
+	case 1:
+		/* requeue */
+		free_rq_tio(md, tio);
+		blk_put_request(clone);
+		goto requeue;
+	default:
+		free_rq_tio(md, tio);
+		blk_put_request(clone);
+		kill_request(rq);
+		break;
+	}
+
+	dm_table_put(map);
+
+	return;
+
+requeue:
+	free_map_info(ti, rq);
+	dm_table_put(map);
+	dm_requeue_request(q, rq);
+}
+
+/*
+ * q->request_fn for request based dm.
+ * called with q->queue_lock held
+ */
+static void dm_request_fn(struct request_queue *q)
+{
+	struct request *rq;
+
+	while (!blk_queue_plugged(q)) {
+		rq = elv_next_request(q);
+		if (!rq)
+			break;
+
+		blkdev_dequeue_request(rq);
+		spin_unlock(q->queue_lock);
+
+		clone_and_map_request(q, rq);
+
+		spin_lock_irq(q->queue_lock);
+	}
+
+	return;
+}
+
 static int dm_flush_all(request_queue_t *q, struct gendisk *disk,
 			sector_t *error_sector)
 {
@@ -872,6 +1223,9 @@ static void dm_unplug_all(request_queue_
 	struct dm_table *map = dm_get_table(md);
 
 	if (map) {
+		if (dm_feat_rq_base(md))
+			generic_unplug_device(q);
+
 		dm_table_unplug_all(map);
 		dm_table_put(map);
 	}
@@ -1263,6 +1617,7 @@ void dm_put(struct mapped_device *md)
 		free_dev(md);
 	}
 }
+EXPORT_SYMBOL_GPL(dm_put);
 
 /*
  * Process the deferred bios
@@ -1383,9 +1738,13 @@ int dm_suspend(struct mapped_device *md,
 	up_write(&md->io_lock);
 
 	/* unplug */
-	if (map)
+	if (map) {
 		dm_table_unplug_all(map);
 
+		if (dm_feat_rq_base(md))
+			dm_stop_queue(md->queue);
+	}
+
 	/*
 	 * Then we wait for the already mapped ios to
 	 * complete.
@@ -1448,6 +1807,9 @@ int dm_resume(struct mapped_device *md)
 	if (!map || !dm_table_get_size(map))
 		goto out;
 
+	if (dm_feat_rq_base(md))
+		dm_start_queue(md->queue);
+
 	r = dm_table_resume_targets(map);
 	if (r)
 		goto out;
diff -rupN 6-add-target-func/include/linux/device-mapper.h 7-rqbase-dm-core/include/linux/device-mapper.h
--- 6-add-target-func/include/linux/device-mapper.h	2006-12-15 10:42:49.000000000 -0500
+++ 7-rqbase-dm-core/include/linux/device-mapper.h	2006-12-15 10:45:34.000000000 -0500
@@ -190,6 +190,14 @@ void dm_get(struct mapped_device *md);
 void dm_put(struct mapped_device *md);
 
 /*
+ * Queue operations
+ */
+struct request_queue *dm_get_queue(struct mapped_device *md);
+void dm_put_queue(struct request_queue *q);
+void dm_stop_queue(struct request_queue *q);
+void dm_start_queue(struct request_queue *q);
+
+/*
  * An arbitrary pointer may be stored alongside a mapped device.
  */
 void dm_set_mdptr(struct mapped_device *md, void *ptr);

