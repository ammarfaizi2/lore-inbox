Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270958AbTGPQyK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 12:54:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270952AbTGPQyK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 12:54:10 -0400
Received: from 69-55-72-159.ppp.netsville.net ([69.55.72.159]:42201 "EHLO
	tiny.suse.com") by vger.kernel.org with ESMTP id S270960AbTGPQxF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 12:53:05 -0400
Subject: Re: RFC on io-stalls patch
From: Chris Mason <mason@suse.com>
To: Jens Axboe <axboe@suse.de>
Cc: Andrea Arcangeli <andrea@suse.de>, Andrew Morton <akpm@osdl.org>,
       marcelo@conectiva.com.br, linux-kernel@vger.kernel.org
In-Reply-To: <1058278688.4012.57.camel@tiny.suse.com>
References: <20030714224528.GU16313@dualathlon.random>
	 <1058229360.13317.364.camel@tiny.suse.com>
	 <20030714175238.3eaddd9a.akpm@osdl.org>
	 <20030715020706.GC16313@dualathlon.random> <20030715054551.GD833@suse.de>
	 <20030715060101.GB30537@dualathlon.random> <20030715060857.GG833@suse.de>
	 <20030715070314.GD30537@dualathlon.random> <20030715082850.GH833@suse.de>
	 <1058260347.4012.11.camel@tiny.suse.com>  <20030715091730.GI833@suse.de>
	 <1058278688.4012.57.camel@tiny.suse.com>
Content-Type: multipart/mixed; boundary="=-0KWPHZAhunDOGayCQaCE"
Organization: 
Message-Id: <1058375181.4016.147.camel@tiny.suse.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 16 Jul 2003 13:06:21 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-0KWPHZAhunDOGayCQaCE
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Ok, I grabbed Jens' patch from yesterday and made one small change to
limit the total amount of io past blk_oversized_batch.  The new patch is
attached as axboe-2l.diff.

We should probably drop the BH_Sync stuff, I need more time to make sure
it is worth while.  Also, the patch needs to be changed to calculate
rlim once instead of in every get_request call.  But I wanted to get
some numbers out.

Starting with my simple script yesterday to combine rio write loads and
tiobench (8 tiotest threads):

2.4.22-axboe2 was Jens' patch (adds q->pending[rw]), 2.4.22-axboe-2l is
from the patch attached.

Sequential Reads
                 File  Blk   Num                   Avg      Maximum      Lat%     Lat%    CPU
Identifier       Size  Size  Thr   Rate  (CPU%)  Latency    Latency      >2s      >10s    Eff
---------------- ------ ----- ---  ------ ------ --------- -----------  -------- -------- -----
2.4.21           1792  4096    8    8.15 3.344%     3.564     9557.91   0.00022  0.00000   244
2.4.22-pre5      1792  4096    8    5.15 2.168%     5.964     2781.71   0.00022  0.00000   237
2.4.22-axboe2    1792  4096    8    5.07 2.119%     6.105     1095.73   0.00000  0.00000   239
2.4.22-axboe-2l  1792  4096    8    5.14 2.211%     5.998      970.74   0.00000  0.00000   232

Random Reads
                 File  Blk   Num                   Avg      Maximum      Lat%     Lat%    CPU
Identifier       Size  Size  Thr   Rate  (CPU%)  Latency    Latency      >2s      >10s    Eff
---------------- ------ ----- ---  ------ ------ --------- -----------  -------- -------- -----
2.4.21           1792  4096    8    0.83 0.318%    28.295      529.56   0.00000  0.00000   260
2.4.22-pre5      1792  4096    8    0.53 0.203%    45.613      770.82   0.00000  0.00000   260
2.4.22-axboe2    1792  4096    8    0.66 0.503%    41.791      637.23   0.00000  0.00000   130
2.4.22-axboe-2l  1792  4096    8    0.64 0.163%    46.923      742.38   0.00000  0.00000   391

Sequential Writes
                 File  Blk   Num                   Avg      Maximum      Lat%     Lat%    CPU
Identifier       Size  Size  Thr   Rate  (CPU%)  Latency    Latency      >2s      >10s    Eff
---------------- ------ ----- ---  ------ ------ --------- -----------  -------- -------- -----
2.4.21           1792  4096    8   15.51 11.40%     1.243    11776.20   0.01460  0.00109   136
2.4.22-pre5      1792  4096    8   11.99 9.960%     1.695     4628.58   0.00371  0.00000   120
2.4.22-axboe2    1792  4096    8   11.75 9.324%     1.755     2406.28   0.00065  0.00000   126
2.4.22-axboe-2l  1792  4096    8   11.73 9.320%     1.752     2924.61   0.00109  0.00000   126

Random Writes
                 File  Blk   Num                   Avg      Maximum      Lat%     Lat%    CPU
Identifier       Size  Size  Thr   Rate  (CPU%)  Latency    Latency      >2s      >10s    Eff
---------------- ------ ----- ---  ------ ------ --------- -----------  -------- -------- -----
2.4.21           1792  4096    8    0.41 0.318%     0.033       18.81   0.00000  0.00000   130
2.4.22-pre5      1792  4096    8    0.57 1.234%     0.041       37.63   0.00000  0.00000    46
2.4.22-axboe2    1792  4096    8    0.64 1.435%     0.040       29.32   0.00000  0.00000    45
2.4.22-axboe-2l  1792  4096    8    0.64 1.355%     0.033       20.79   0.00000  0.00000    47

So the max sequential read and write latencies were helped by
elevator-low-latency while the averages were not.  A good std deviation
setup would help here, but tiobench's percentage setup shows some
numbers.  In practice, those max latencies are visible for interactive
loads.

Why did max sequential write latencies go down with -axboe?  my guess is
that we read the ext2 indirect blocks faster, but that's only a guess.

For a little variety, I measured some read latencies in the face of a
dbench 50 workload (after adding some latency stats to rio).  These were
done on scsi because my IDE drive wasn't big enough.  You're looking at
the last line from dbench (worthless) and the read throughput/latency
stats from rio (rio was killed right after dbench finished).

2.4.21          Throughput 100.617 MB/sec (NB=125.771 MB/sec  1006.17 MBit/sec)
2.4.22-pre5     Throughput 111.563 MB/sec (NB=139.454 MB/sec  1115.63 MBit/sec)
2.4.21-axboe-2l Throughput 126.298 MB/sec (NB=157.873 MB/sec  1262.98 MBit/sec)
2.4.21          reads: 34.160 MB, 0.512 MB/s
2.4.22-pre5     reads: 34.254 MB, 0.569 MB/s
2.4.21-axboe-2l reads: 47.733 MB, 0.896 MB/s
2.4.21          read latency min 0.00 avg 7.54 max 5742.93 > 2s 0.00% > 10s 0.00%
2.4.22-pre5     read latency min 0.00 avg 6.74 max 7225.02 > 2s 0.00% > 10s 0.00%
2.4.21-axboe-2l read latency min 0.00 avg 4.32 max 2128.92 > 2s 0.00% > 10s 0.00%

Both the dbench throughput numbers and the rio stats were fairly stable
across runs.  As the number of dbench procs increases vanilla 2.4.21
does worse on latency.

-chris


--=-0KWPHZAhunDOGayCQaCE
Content-Disposition: attachment; filename=axboe-2l.diff
Content-Type: text/plain; name=axboe-2l.diff; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

===== drivers/block/ll_rw_blk.c 1.47 vs edited =====
--- 1.47/drivers/block/ll_rw_blk.c	Fri Jul 11 04:30:54 2003
+++ edited/drivers/block/ll_rw_blk.c	Wed Jul 16 12:27:24 2003
@@ -458,6 +458,7 @@
   
  	INIT_LIST_HEAD(&q->rq.free);
 	q->rq.count = 0;
+	q->rq.pending[READ] = q->rq.pending[WRITE] = 0;
 	q->nr_requests = 0;
 
 	si_meminfo(&si);
@@ -549,18 +550,35 @@
 static struct request *get_request(request_queue_t *q, int rw)
 {
 	struct request *rq = NULL;
-	struct request_list *rl;
+	struct request_list *rl = &q->rq;
 
-	rl = &q->rq;
-	if (!list_empty(&rl->free) && !blk_oversized_queue(q)) {
+	if (blk_oversized_queue(q)) {
+		int rlim = q->nr_requests >> 5;
+
+		if (rlim < 4)
+			rlim = 4;
+
+		/*
+		 * if its a write, or we have more than a handful of reads
+		 * pending, bail out
+		 */
+		if ((rw == WRITE) || (rw == READ && rl->pending[READ] > rlim))
+			return NULL;
+		if (blk_oversized_queue_reads(q))
+			return NULL;
+	}
+	
+	if (!list_empty(&rl->free)) {
 		rq = blkdev_free_rq(&rl->free);
 		list_del(&rq->queue);
 		rl->count--;
+		rl->pending[rw]++;
 		rq->rq_status = RQ_ACTIVE;
 		rq->cmd = rw;
 		rq->special = NULL;
 		rq->q = q;
 	}
+
 	return rq;
 }
 
@@ -866,13 +884,25 @@
 	 * assume it has free buffers and check waiters
 	 */
 	if (q) {
+		struct request_list *rl = &q->rq;
 		int oversized_batch = 0;
 
 		if (q->can_throttle)
 			oversized_batch = blk_oversized_queue_batch(q);
-		q->rq.count++;
-		list_add(&req->queue, &q->rq.free);
-		if (q->rq.count >= q->batch_requests && !oversized_batch) {
+		rl->count++;
+		/*
+		 * paranoia check
+		 */
+		if (req->cmd == READ || req->cmd == WRITE)
+			rl->pending[req->cmd]--;
+		if (rl->pending[READ] > q->nr_requests)
+			printk("reads: %u\n", rl->pending[READ]);
+		if (rl->pending[WRITE] > q->nr_requests)
+			printk("writes: %u\n", rl->pending[WRITE]);
+		if (rl->pending[READ] + rl->pending[WRITE] > q->nr_requests)
+			printk("too many: %u + %u > %u\n", rl->pending[READ], rl->pending[WRITE], q->nr_requests);
+		list_add(&req->queue, &rl->free);
+		if (rl->count >= q->batch_requests && !oversized_batch) {
 			smp_mb();
 			if (waitqueue_active(&q->wait_for_requests))
 				wake_up(&q->wait_for_requests);
@@ -947,7 +977,7 @@
 static int __make_request(request_queue_t * q, int rw,
 				  struct buffer_head * bh)
 {
-	unsigned int sector, count;
+	unsigned int sector, count, sync;
 	int max_segments = MAX_SEGMENTS;
 	struct request * req, *freereq = NULL;
 	int rw_ahead, max_sectors, el_ret;
@@ -958,6 +988,7 @@
 
 	count = bh->b_size >> 9;
 	sector = bh->b_rsector;
+	sync = test_and_clear_bit(BH_Sync, &bh->b_state);
 
 	rw_ahead = 0;	/* normal case; gets changed below for READA */
 	switch (rw) {
@@ -1124,6 +1155,8 @@
 		blkdev_release_request(freereq);
 	if (should_wake)
 		get_request_wait_wakeup(q, rw);
+	if (sync)
+		__generic_unplug_device(q);
 	spin_unlock_irq(&io_request_lock);
 	return 0;
 end_io:
===== fs/buffer.c 1.89 vs edited =====
--- 1.89/fs/buffer.c	Tue Jun 24 17:11:29 2003
+++ edited/fs/buffer.c	Tue Jul 15 15:31:07 2003
@@ -1142,6 +1142,7 @@
 	bh = getblk(dev, block, size);
 	if (buffer_uptodate(bh))
 		return bh;
+	set_bit(BH_Sync, &bh->b_state);
 	ll_rw_block(READ, 1, &bh);
 	wait_on_buffer(bh);
 	if (buffer_uptodate(bh))
===== include/linux/blkdev.h 1.24 vs edited =====
--- 1.24/include/linux/blkdev.h	Fri Jul  4 13:18:12 2003
+++ edited/include/linux/blkdev.h	Tue Jul 15 16:32:32 2003
@@ -66,6 +66,7 @@
 
 struct request_list {
 	unsigned int count;
+	unsigned int pending[2];
 	struct list_head free;
 };
 
@@ -292,6 +293,13 @@
 {
 	if (q->can_throttle)
 		return atomic_read(&q->nr_sectors) > q->max_queue_sectors;
+	return q->rq.count == 0;
+}
+
+static inline int blk_oversized_queue_reads(request_queue_t * q)
+{
+	if (q->can_throttle)
+		return atomic_read(&q->nr_sectors) > q->max_queue_sectors + q->batch_sectors;
 	return q->rq.count == 0;
 }
 
===== include/linux/fs.h 1.82 vs edited =====
--- 1.82/include/linux/fs.h	Wed Jul  9 14:42:38 2003
+++ edited/include/linux/fs.h	Tue Jul 15 15:31:07 2003
@@ -221,6 +221,7 @@
 	BH_Launder,	/* 1 if we can throttle on this buffer */
 	BH_Attached,	/* 1 if b_inode_buffers is linked into a list */
 	BH_JBD,		/* 1 if it has an attached journal_head */
+	BH_Sync,	/* 1 if the buffer is a sync read */
 
 	BH_PrivateStart,/* not a state bit, but the first bit available
 			 * for private allocation by other entities

--=-0KWPHZAhunDOGayCQaCE--

