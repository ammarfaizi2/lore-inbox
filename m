Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261646AbSJNNpa>; Mon, 14 Oct 2002 09:45:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261647AbSJNNp3>; Mon, 14 Oct 2002 09:45:29 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:41195 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S261646AbSJNNpR>;
	Mon, 14 Oct 2002 09:45:17 -0400
Date: Mon, 14 Oct 2002 15:51:00 +0200
From: Jens Axboe <axboe@suse.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: "Stephen C. Tweedie" <sct@redhat.com>, Joel.Becker@oracle.com
Subject: [PATCH] superbh, fractured blocks, and grouped io
Message-ID: <20021014135100.GD28283@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch introduces a concept called 'super buffer_heads', or just
superbh. I came up with this beast to solve one problem, but in the end
it actually solves two. So it can't be all bad.

Problem #1. Consider an application that internally deals with data in
blocks of a certain size. This application would like to, from time to
time, write out some of these blocks, and is uses raw io or direct io to
do so. Lets assume that the block size is 32kb, the application writes
out a nice 32kb chunk. Linux then breaks this down into device block
size chunks, this is anywhere from 512 bytes to 4096 bytes, and passes
them to the io scheduler. If we are lucky, these buffer_heads that make
up the application block size will end up in one request and there is a
good chance that the write will be atomic (not really 100% atomic, but
close enough). If we are unlucky, the 8-64 buffer_heads will be
scattered over the request queue and not written in order. If the
machine looses power, there's a good chance that some of the block
belonging to the application block are written and some are not. We call
this fractured blocks, and this is something we want to avoid.

So intead of breaking io down into teeny bits, we submit io in multiples
for the application block size. In 2.5 this can be done with a bio, in
2.4 we have to mess around with smaller buffer_heads. So we add a
submit_bh_linked() that acts like submit_bh(), but you can pass in a
chain of buffer_heads instead of just one (via b_reqnext, like the block
layer would do).

We need some way of passing in a bunch of buffer_heads to the io
scheduler for insertion (and merge), for this we add a concept called a
superbh. A superbh is a pseudo buffer_head, that doesn't contain any
data itself. Instead it describes a bunch of buffer_heads. A superbh can
be as big as the

	unsigned short b_size;

allows. So submit_bh_linked() sets up a superbh of the right size, and
passes it to generic_make_request().

We differentiate between superbh handling and atomic io blocks. An
atomic io block will be submitted as a superbh, but it is possible for a
queue to say that it can accept a superbh but it cannot guarentee atomic
operations on it. Note that this does not require changes to block
drivers, if they don't define a private make_request_fn(). So it will
not directly work on loop, md, and lvm before someone does the work to
support it. Should work on basically everything else, though.

The queue has two new properties:

	/*
	 * max size of an atomic io block, 0 if not supported
	 */
	int	grouped_queue;

	/*
	 * max size of a superbh, 0 if not supported
	 */
	int	superbh_queue;

Should be self-explanatory. Normally, superbh_queue is just the max size
a request can be for this device as it requires no driver or hardware
support. grouped_queue can only safely be set if the hardware has
battery backed write cache, or can guarentee atomic io in some other
way.

So what was problem #2? Well, queueing an O_DIRECT or raw write/read of
128KiB in units of 512 bytes *sucks* from a system utilization
perspective. Even if you disregard the atomic io bit of the patch (which
is basically not done, only the infrastructure is there), the patch can
heavily cut down on sys time when lots of data is moved.

Patch is against 2.4.20-pre10

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.737   -> 1.738  
#	drivers/ide/ide-probe.c	1.12    -> 1.13   
#	drivers/block/ll_rw_blk.c	1.40    -> 1.41   
#	include/linux/blkdev.h	1.22    -> 1.23   
#	drivers/block/elevator.c	1.7     -> 1.8    
#	  include/linux/fs.h	1.69    -> 1.70   
#	drivers/scsi/scsi_merge.c	1.9     -> 1.10   
#	 drivers/scsi/scsi.c	1.17    -> 1.18   
#	         fs/buffer.c	1.74    -> 1.75   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/10/14	axboe@burns.home.kernel.dk	1.738
# Introduce superbh and grouped IO concept
# --------------------------------------------
#
diff -Nru a/drivers/block/elevator.c b/drivers/block/elevator.c
--- a/drivers/block/elevator.c	Mon Oct 14 15:50:00 2002
+++ b/drivers/block/elevator.c	Mon Oct 14 15:50:00 2002
@@ -103,6 +103,8 @@
 			continue;
 		if (__rq->nr_sectors + count > max_sectors)
 			continue;
+		if (__rq->dont_merge)
+			continue;
 		if (__rq->sector + __rq->nr_sectors == bh->b_rsector) {
 			ret = ELEVATOR_BACK_MERGE;
 			*req = __rq;
@@ -163,6 +165,8 @@
 		if (__rq->nr_sectors + count > max_sectors)
 			continue;
 		if (__rq->waiting)
+			continue;
+		if (__rq->dont_merge)
 			continue;
 		if (__rq->sector + __rq->nr_sectors == bh->b_rsector) {
 			*req = __rq;
diff -Nru a/drivers/block/ll_rw_blk.c b/drivers/block/ll_rw_blk.c
--- a/drivers/block/ll_rw_blk.c	Mon Oct 14 15:50:00 2002
+++ b/drivers/block/ll_rw_blk.c	Mon Oct 14 15:50:00 2002
@@ -186,6 +186,34 @@
 }
 
 /**
+ * blk_queue_grouped - indicate whether queue can accept grouped bhs or not
+ * @q:       The queue which this applies to.
+ * @grouped: Max size in sectors
+ *
+ **/
+void blk_queue_grouped(request_queue_t *q, int grouped)
+{
+	if ((grouped << 9) > MAX_SUPERBH)
+		grouped = MAX_SUPERBH >> 9;
+
+	q->grouped_queue = grouped << 9;
+}
+
+/**
+ * blk_queue_superbh - indicate whether queue can accept superbhs or not
+ * @q:       The queue which this applies to.
+ * @superbh: Max size in sectors
+ *
+ **/
+void blk_queue_superbh(request_queue_t *q, int superbh)
+{
+	if ((superbh << 9) > MAX_SUPERBH)
+		superbh = MAX_SUPERBH >> 9;
+
+	q->superbh_queue = superbh << 9;
+}
+
+/**
  * blk_queue_headactive - indicate whether head of request queue may be active
  * @q:       The queue which this applies to.
  * @active:  A flag indication where the head of the queue is active.
@@ -240,6 +268,12 @@
 void blk_queue_make_request(request_queue_t * q, make_request_fn * mfn)
 {
 	q->make_request_fn = mfn;
+
+	/*
+	 * clear this, if queue can take a superbh it needs to enable this
+	 * manually
+	 */
+	blk_queue_superbh(q, 0);
 }
 
 /**
@@ -499,6 +533,9 @@
 	 */
 	q->plug_device_fn 	= generic_plug_device;
 	q->head_active    	= 1;
+	q->grouped_queue	= 0;
+	q->superbh_queue	= 0;
+	q->max_segments		= MAX_SEGMENTS;
 
 	blk_queue_bounce_limit(q, BLK_BOUNCE_HIGH);
 }
@@ -899,8 +936,43 @@
 	attempt_merge(q, blkdev_entry_to_request(prev), max_sectors, max_segments);
 }
 
-static int __make_request(request_queue_t * q, int rw,
-				  struct buffer_head * bh)
+/*
+ * bh abuse :/
+ */
+#define superbh_segments(bh)	((bh)->b_blocknr)
+#define superbh_rw(bh)		((bh)->b_list)
+#define superbh_bhtail(bh)	((bh)->b_reqnext)
+#define superbh_bh(bh)		((bh)->b_private)
+
+static inline void req_add_bh(struct request *rq, struct buffer_head *bh)
+{
+	unsigned short tot_size = bh->b_size >> 9;
+	struct buffer_head *bhtail = bh;
+	int segments = 1;
+
+	if (!tot_size)
+		printk("%s: size is %u, sector %lu\n", kdevname(bh->b_rdev), tot_size, bh->b_rsector);
+
+	if (buffer_superbh(bh)) {
+		segments = superbh_segments(bh);
+		bhtail = superbh_bhtail(bh);
+
+		/*
+		 * now bh points to the first real bh, superbh is used no more
+		 */
+		bh = superbh_bh(bh);
+	}
+
+	rq->hard_nr_sectors = rq->nr_sectors = tot_size;
+	rq->current_nr_sectors = rq->hard_cur_sectors = bh->b_size >> 9;
+	rq->nr_segments = segments;
+	rq->nr_hw_segments = segments;
+	rq->buffer = bh->b_data;
+	rq->bh = bh;
+	rq->bhtail = bhtail;
+}
+
+static int __make_request(request_queue_t *q, int rw, struct buffer_head *bh)
 {
 	unsigned int sector, count;
 	int max_segments = MAX_SEGMENTS;
@@ -943,7 +1015,6 @@
 	 */
 	bh = blk_queue_bounce(q, rw, bh);
 
-/* look for a free request. */
 	/*
 	 * Try to coalesce the new request with old requests
 	 */
@@ -965,6 +1036,17 @@
 	} else if (q->head_active && !q->plugged)
 		head = head->next;
 
+	/*
+	 * potentially we could easily allow merge with superbh, however
+	 * it requires extensive changes to merge functions etc, so I prefer
+	 * to only let merges happen the other way around (ie normal bh _can_
+	 * be merged into a request which originated from a superbh). look
+	 * into doing this, if MAX_GROUPED is not enough to pull full io
+	 * bandwidth from device.
+	 */
+	if (buffer_grouped(bh) || buffer_superbh(bh))
+		goto get_rq;
+
 	el_ret = elevator->elevator_merge_fn(q, &req, head, bh, rw,max_sectors);
 	switch (el_ret) {
 
@@ -1048,23 +1130,23 @@
 		}
 	}
 
-/* fill up the request-info, and add it to the queue */
+	/*
+	 * fill up the request-info, and add it to the queue
+	 */
 	req->elevator_sequence = latency;
 	req->cmd = rw;
 	req->errors = 0;
 	req->hard_sector = req->sector = sector;
-	req->hard_nr_sectors = req->nr_sectors = count;
-	req->current_nr_sectors = req->hard_cur_sectors = count;
-	req->nr_segments = 1; /* Always 1 for a new request. */
-	req->nr_hw_segments = 1; /* Always 1 for a new request. */
-	req->buffer = bh->b_data;
 	req->waiting = NULL;
-	req->bh = bh;
-	req->bhtail = bh;
 	req->rq_dev = bh->b_rdev;
 	req->start_time = jiffies;
+	req->dont_merge = buffer_grouped(bh);
+	req->seg_invalid = buffer_superbh(bh);
+	req_add_bh(req, bh);
 	req_new_io(req, 0, count);
 	blk_started_io(count);
+	if (req->nr_segments > q->max_segments)
+		printk("__make_request: seg count %u > %u\n", req->nr_segments, q->max_segments);
 	add_request(q, req, insert_here);
 out:
 	if (freereq)
@@ -1164,9 +1246,38 @@
 			buffer_IO_error(bh);
 			break;
 		}
+
+		/*
+		 * superbh_end_io() will gracefully resubmit, this is a soft
+		 * error. if !grouped_queue, fail hard
+		 */
+		if ((buffer_superbh(bh) && !q->superbh_queue)
+		    || (buffer_grouped(bh) && !q->grouped_queue)) {
+			buffer_IO_error(bh);
+			break;
+		}
+
 	} while (q->make_request_fn(q, rw, bh));
 }
 
+static inline void __submit_bh(int rw, struct buffer_head *bh)
+{
+	if (!test_bit(BH_Lock, &bh->b_state))
+		BUG();
+
+	set_bit(BH_Req, &bh->b_state);
+	set_bit(BH_Launder, &bh->b_state);
+
+	/*
+	 * First step, 'identity mapping' - RAID or LVM might
+	 * further remap this.
+	 */
+	bh->b_rdev = bh->b_dev;
+	bh->b_rsector = bh->b_blocknr * (bh->b_size >> 9);
+
+	generic_make_request(rw, bh);
+}
+
 
 /**
  * submit_bh: submit a buffer_head to the block device later for I/O
@@ -1185,29 +1296,177 @@
 {
 	int count = bh->b_size >> 9;
 
-	if (!test_bit(BH_Lock, &bh->b_state))
-		BUG();
+	__submit_bh(rw, bh);
 
-	set_bit(BH_Req, &bh->b_state);
-	set_bit(BH_Launder, &bh->b_state);
+	switch (rw) {
+		case WRITE:
+			kstat.pgpgout += count;
+			break;
+		default:
+			kstat.pgpgin += count;
+			break;
+	}
+}
+
+/*
+ * if this is called, it's prior to the super_bh being submitted. so
+ * we can fallback to normal IO submission here. uptodate bool means
+ * absolutely nothing here.
+ */
+void superbh_end_io(struct buffer_head *superbh, int uptodate)
+{
+	struct buffer_head *bh = superbh_bh(superbh);
+	struct buffer_head *next_bh;
+	int rw = superbh_rw(superbh);
+
+	printk("%s: fallback to regular bh submission\n", __FUNCTION__);
+
+	if (!buffer_superbh(superbh)) {
+		printk("%s: non-grouped bh?!\n", __FUNCTION__);
+		return;
+	}
 
 	/*
-	 * First step, 'identity mapping' - RAID or LVM might
-	 * further remap this.
+	 * detach each bh and resubmit, or completely and if its a grouped bh
 	 */
-	bh->b_rdev = bh->b_dev;
-	bh->b_rsector = bh->b_blocknr * count;
+	do {
+		next_bh = bh->b_reqnext;
+		bh->b_reqnext = NULL;
 
-	generic_make_request(rw, bh);
+		if (!buffer_grouped(superbh))
+			__submit_bh(rw, bh);
+		else
+			bh->b_end_io(bh, test_bit(BH_Uptodate, &bh->b_state));
+
+	} while ((bh = next_bh));
+}
+
+/**
+ * submit_bh_linked: submit a list of buffer_heads for I/O
+ * @rw: whether to %READ or %WRITE, or maybe to %READA (read ahead)
+ * @bh: The first &struct buffer_head
+ *
+ * submit_bh_linked() acts like submit_bh(), but it can submit more than
+ * one buffer_head in one go. It sets up a "superbh" describing the combined
+ * transfer of the linked buffer_heads, and submit these in one go. This
+ * heavily cuts down on time spent inside io scheduler.
+ *
+ * The buffer_head strings must be linked via b_reqnext. All buffer_heads
+ * must be valid and pre-setup like the caller would for submit_bh()
+ */
+int submit_bh_linked(int rw, struct buffer_head *bh)
+{
+	struct buffer_head superbh, *tmp_bh, *bhprev, *bhfirst;
+	request_queue_t *q = blk_get_queue(bh->b_dev);
+	int size, segments, max_size;
+
+	/*
+	 * these must be the same for all buffer_heads
+	 */
+	superbh_rw(&superbh) = rw;
+	superbh.b_rdev = bh->b_dev;
+	superbh.b_state = bh->b_state | (1 << BH_Super);
+	superbh.b_end_io = superbh_end_io;
+
+	/*
+	 * not really needed...
+	 */
+	superbh.b_data = NULL;
+	superbh.b_page = NULL;
+
+	tmp_bh = bh;
+
+queue_next:
+	bhprev = bhfirst = tmp_bh;
+	segments = size = 0;
+
+	superbh_bh(&superbh) = bhfirst;
+
+	if (!q)
+		goto punt;
+
+	max_size = q->superbh_queue;
+	if (buffer_grouped(bh) && max_size > q->grouped_queue)
+		max_size = q->grouped_queue;
+
+	do {
+		if (!buffer_locked(tmp_bh)) {
+			printk("bh list contained unlocked buffer\n");
+			goto punt;
+		}
+
+		/*
+		 * submit this bit if it would exceed the allowed size
+		 */
+		if ((size + tmp_bh->b_size > max_size)
+		    || (segments >= q->max_segments)) {
+			bhprev->b_reqnext = NULL;
+			break;
+		}
+
+		/*
+		 * init each bh like submit_bh() does
+		 */
+		tmp_bh->b_rdev = tmp_bh->b_dev;
+		tmp_bh->b_rsector = tmp_bh->b_blocknr * (tmp_bh->b_size >> 9);
+		set_bit(BH_Req, &tmp_bh->b_state);
+		set_bit(BH_Launder, &tmp_bh->b_state);
+
+		size += tmp_bh->b_size;
+		bhprev = tmp_bh;
+		segments++;
+	} while ((tmp_bh = tmp_bh->b_reqnext));
+
+	if (size > MAX_SUPERBH) {
+		printk("%s: wrong size %u\n", __FUNCTION__, size);
+		goto punt;
+	}
+
+	/*
+	 * this is a super bh, it's only valid for io submission. it describes
+	 * in size the entire bh list submitted.
+	 */
+	superbh.b_size = size;
+	superbh_segments(&superbh) = segments;
+	superbh_bhtail(&superbh) = bhprev;
+	superbh.b_rsector = bhfirst->b_rsector;
+
+	generic_make_request(rw, &superbh);
 
 	switch (rw) {
 		case WRITE:
-			kstat.pgpgout += count;
+			kstat.pgpgout += size >> 9;
 			break;
 		default:
-			kstat.pgpgin += count;
+			kstat.pgpgin += size >> 9;
 			break;
 	}
+
+	/*
+	 * not done
+	 */
+	if (tmp_bh)
+		goto queue_next;
+
+	return 0;
+punt:
+	superbh.b_end_io(&superbh, 0);
+	return 1;
+}
+
+/**
+ * submit_bh_grouped: submit a list of buffer_heads for I/O
+ * @rw: whether to %READ or %WRITE, or maybe to %READA (read ahead)
+ * @bh: The first &struct buffer_head
+ *
+ * Like submit_bh_linked(). In addition, we try to guarentee that io
+ * operations on this chunk of data will be as atomic as we can make it.
+ *
+ */
+int submit_bh_grouped(int rw, struct buffer_head *bh)
+{
+	set_bit(BH_Grouped, &bh->b_state);
+	return submit_bh_linked(rw, bh);
 }
 
 /**
@@ -1516,6 +1775,8 @@
 EXPORT_SYMBOL(blk_get_queue);
 EXPORT_SYMBOL(blk_cleanup_queue);
 EXPORT_SYMBOL(blk_queue_headactive);
+EXPORT_SYMBOL(blk_queue_grouped);
+EXPORT_SYMBOL(blk_queue_superbh);
 EXPORT_SYMBOL(blk_queue_make_request);
 EXPORT_SYMBOL(generic_make_request);
 EXPORT_SYMBOL(blkdev_release_request);
diff -Nru a/drivers/ide/ide-probe.c b/drivers/ide/ide-probe.c
--- a/drivers/ide/ide-probe.c	Mon Oct 14 15:50:00 2002
+++ b/drivers/ide/ide-probe.c	Mon Oct 14 15:50:00 2002
@@ -603,9 +603,15 @@
 static void ide_init_queue(ide_drive_t *drive)
 {
 	request_queue_t *q = &drive->queue;
+	int max_sectors = 128;
 
 	q->queuedata = HWGROUP(drive);
 	blk_init_queue(q, do_ide_request);
+
+	if (HWIF(drive)->chipset == ide_pdc4030)
+		max_sectors = 127;
+
+	blk_queue_superbh(q, max_sectors);
 
 	if (drive->media == ide_disk) {
 #ifdef CONFIG_BLK_DEV_ELEVATOR_NOOP
diff -Nru a/drivers/scsi/scsi.c b/drivers/scsi/scsi.c
--- a/drivers/scsi/scsi.c	Mon Oct 14 15:50:00 2002
+++ b/drivers/scsi/scsi.c	Mon Oct 14 15:50:00 2002
@@ -198,6 +198,14 @@
 	blk_init_queue(q, scsi_request_fn);
 	blk_queue_headactive(q, 0);
 	q->queuedata = (void *) SDpnt;
+
+	q->max_segments = SHpnt->sg_tablesize;
+	blk_queue_superbh(q, SHpnt->max_sectors);
+
+	/*
+	 * FIXME: just for testing, needs to be based on real evidence
+	 */
+	blk_queue_grouped(q, SHpnt->max_sectors);
 }
 
 #ifdef MODULE
diff -Nru a/drivers/scsi/scsi_merge.c b/drivers/scsi/scsi_merge.c
--- a/drivers/scsi/scsi_merge.c	Mon Oct 14 15:50:00 2002
+++ b/drivers/scsi/scsi_merge.c	Mon Oct 14 15:50:00 2002
@@ -810,11 +810,9 @@
 	/*
 	 * First we need to know how many scatter gather segments are needed.
 	 */
-	if (!sg_count_valid) {
+	count = req->nr_segments;
+	if (!sg_count_valid || req->seg_invalid)
 		count = __count_segments(req, use_clustering, dma_host, NULL);
-	} else {
-		count = req->nr_segments;
-	}
 
 	/*
 	 * If the dma pool is nearly empty, then queue a minimal request
diff -Nru a/fs/buffer.c b/fs/buffer.c
--- a/fs/buffer.c	Mon Oct 14 15:50:00 2002
+++ b/fs/buffer.c	Mon Oct 14 15:50:00 2002
@@ -2220,7 +2220,7 @@
 	unsigned long	blocknr;
 	struct kiobuf *	iobuf = NULL;
 	struct page *	map;
-	struct buffer_head *tmp, **bhs = NULL;
+	struct buffer_head *tmp, **bhs = NULL, *bh_first, *bh_prev;
 
 	if (!nr)
 		return 0;
@@ -2241,6 +2241,7 @@
 	 * OK to walk down the iovec doing page IO on each page we find. 
 	 */
 	bufind = bhind = transferred = err = 0;
+	bh_first = bh_prev = NULL;
 	for (i = 0; i < nr; i++) {
 		iobuf = iovec[i];
 		offset = iobuf->offset;
@@ -2255,7 +2256,7 @@
 				err = -EFAULT;
 				goto finished;
 			}
-			
+
 			while (length > 0) {
 				blocknr = b[bufind++];
 				if (blocknr == -1UL) {
@@ -2272,6 +2273,9 @@
 				}
 				tmp = bhs[bhind++];
 
+				if (!bh_first)
+					bh_first = tmp;
+
 				tmp->b_size = size;
 				set_bh_page(tmp, map, offset);
 				tmp->b_this_page = tmp;
@@ -2280,6 +2284,7 @@
 				tmp->b_dev = dev;
 				tmp->b_blocknr = blocknr;
 				tmp->b_state = (1 << BH_Mapped) | (1 << BH_Lock) | (1 << BH_Req);
+				tmp->b_reqnext = NULL;
 
 				if (rw == WRITE) {
 					set_bit(BH_Uptodate, &tmp->b_state);
@@ -2288,11 +2293,21 @@
 					set_bit(BH_Uptodate, &tmp->b_state);
 
 				atomic_inc(&iobuf->io_count);
-				submit_bh(rw, tmp);
+
+				if (bh_prev)
+					bh_prev->b_reqnext = tmp;
+
+				bh_prev = tmp;
+
 				/* 
 				 * Wait for IO if we have got too much 
 				 */
 				if (bhind >= KIO_MAX_SECTORS) {
+submit_io:
+					/*
+					 * FIXME: use _grouped for atomic IO
+					 */
+					submit_bh_linked(rw, bh_first);
 					kiobuf_wait_for_io(iobuf); /* wake-one */
 					err = wait_kio(rw, bhind, bhs, size);
 					if (err >= 0)
@@ -2300,12 +2315,19 @@
 					else
 						goto finished;
 					bhind = 0;
+					bh_prev = bh_first = NULL;
 				}
 
 			skip_block:
 				length -= size;
 				offset += size;
 
+				/*
+				 * see if we need to submit the previous bit
+				 */
+				if ((blocknr == -1) && bhind)
+					goto submit_io;
+
 				if (offset >= PAGE_SIZE) {
 					offset = 0;
 					break;
@@ -2316,12 +2338,14 @@
 
 	/* Is there any IO still left to submit? */
 	if (bhind) {
+		/*
+		 * FIXME: use _grouped for atomic IO
+		 */
+		submit_bh_linked(rw, bh_first);
 		kiobuf_wait_for_io(iobuf); /* wake-one */
 		err = wait_kio(rw, bhind, bhs, size);
 		if (err >= 0)
 			transferred += err;
-		else
-			goto finished;
 	}
 
  finished:
diff -Nru a/include/linux/blkdev.h b/include/linux/blkdev.h
--- a/include/linux/blkdev.h	Mon Oct 14 15:50:00 2002
+++ b/include/linux/blkdev.h	Mon Oct 14 15:50:00 2002
@@ -46,6 +46,9 @@
 	struct buffer_head * bh;
 	struct buffer_head * bhtail;
 	request_queue_t *q;
+
+	char dont_merge;
+	char seg_invalid;
 };
 
 #include <linux/elevator.h>
@@ -126,6 +129,22 @@
 	 */
 	char			head_active;
 
+	/*
+	 * max segments
+	 */
+	int			max_segments;
+
+	/*
+	 * The biggest "atomic" io chunk we can deal with, or 0 if not
+	 * supported.
+	 */
+	int			grouped_queue;
+
+	/*
+	 * The biggest superbh we can generate for this queue
+	 */
+	int			superbh_queue;
+
 	unsigned long		bounce_pfn;
 
 	/*
@@ -154,6 +173,12 @@
 {
 	struct page *page = bh->b_page;
 
+	/*
+	 * not a real bh
+	 */
+	if (test_bit(BH_Super, &bh->b_state))
+		return bh;
+
 #ifndef CONFIG_DISCONTIGMEM
 	if (page - mem_map <= q->bounce_pfn)
 #else
@@ -209,6 +234,8 @@
 extern void blk_init_queue(request_queue_t *, request_fn_proc *);
 extern void blk_cleanup_queue(request_queue_t *);
 extern void blk_queue_headactive(request_queue_t *, int);
+extern void blk_queue_grouped(request_queue_t *, int);
+extern void blk_queue_superbh(request_queue_t *, int);
 extern void blk_queue_make_request(request_queue_t *, make_request_fn *);
 extern void generic_unplug_device(void *);
 extern inline int blk_seg_merge_ok(struct buffer_head *, struct buffer_head *);
@@ -227,8 +254,7 @@
 
 #define MAX_SEGMENTS 128
 #define MAX_SECTORS 255
-
-#define PageAlignSize(size) (((size) + PAGE_SIZE -1) & PAGE_MASK)
+#define MAX_SUPERBH 65535	/* must fit info ->b_size right now */
 
 #define blkdev_entry_to_request(entry) list_entry((entry), struct request, queue)
 #define blkdev_entry_next_request(entry) blkdev_entry_to_request((entry)->next)
diff -Nru a/include/linux/fs.h b/include/linux/fs.h
--- a/include/linux/fs.h	Mon Oct 14 15:50:00 2002
+++ b/include/linux/fs.h	Mon Oct 14 15:50:00 2002
@@ -220,7 +220,8 @@
 	BH_Wait_IO,	/* 1 if we should write out this buffer */
 	BH_Launder,	/* 1 if we can throttle on this buffer */
 	BH_JBD,		/* 1 if it has an attached journal_head */
-
+	BH_Super,	/* 1 if this is a superbh */
+	BH_Grouped,	/* 1 if this is a grouped submit */
 	BH_PrivateStart,/* not a state bit, but the first bit available
 			 * for private allocation by other entities
 			 */
@@ -283,6 +284,8 @@
 #define buffer_new(bh)		__buffer_state(bh,New)
 #define buffer_async(bh)	__buffer_state(bh,Async)
 #define buffer_launder(bh)	__buffer_state(bh,Launder)
+#define buffer_superbh(bh)	__buffer_state(bh,Super)
+#define buffer_grouped(bh)	__buffer_state(bh,Grouped)
 
 #define bh_offset(bh)		((unsigned long)(bh)->b_data & ~PAGE_MASK)
 
@@ -1377,6 +1380,8 @@
 extern struct buffer_head * getblk(kdev_t, int, int);
 extern void ll_rw_block(int, int, struct buffer_head * bh[]);
 extern void submit_bh(int, struct buffer_head *);
+extern int submit_bh_linked(int, struct buffer_head *);
+extern int submit_bh_grouped(int, struct buffer_head *);
 extern int is_read_only(kdev_t);
 extern void __brelse(struct buffer_head *);
 static inline void brelse(struct buffer_head *buf)

-- 
Jens Axboe

