Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267844AbTGOOPc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 10:15:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267773AbTGOOPc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 10:15:32 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:56756 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S268171AbTGOOPS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 10:15:18 -0400
Date: Tue, 15 Jul 2003 16:29:50 +0200
From: Jens Axboe <axboe@suse.de>
To: Chris Mason <mason@suse.com>
Cc: Andrea Arcangeli <andrea@suse.de>, Andrew Morton <akpm@osdl.org>,
       marcelo@conectiva.com.br, linux-kernel@vger.kernel.org
Subject: Re: RFC on io-stalls patch
Message-ID: <20030715142950.GZ833@suse.de>
References: <20030714175238.3eaddd9a.akpm@osdl.org> <20030715020706.GC16313@dualathlon.random> <20030715054551.GD833@suse.de> <20030715060101.GB30537@dualathlon.random> <20030715060857.GG833@suse.de> <20030715070314.GD30537@dualathlon.random> <20030715082850.GH833@suse.de> <1058260347.4012.11.camel@tiny.suse.com> <20030715091730.GI833@suse.de> <1058278688.4012.57.camel@tiny.suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1058278688.4012.57.camel@tiny.suse.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 15 2003, Chris Mason wrote:
> On Tue, 2003-07-15 at 05:17, Jens Axboe wrote:
> 
> > > BTW, the contest run times vary pretty wildy.  My 3 compiles with
> > > io_load running on 2.4.21 were 603s, 443s and 515s.  This doesn't make
> > > the average of the 3 numbers invalid, but we need a more stable metric.
> > 
> > Mine are pretty consistent [1], I'd suspect that it isn't contest but your
> > drive tcq skewing things. But it would be nice to test with other things
> > as well, I just used contest because it was at hand.
> 
> I hacked up my random io generator a bit, combined with tiobench it gets
> pretty consistent numbers.  rio is attached, it does lots of different
> things but the basic idea is to create a sparse file and then do io of
> random sizes into random places in the file.
> 
> So, random writes with a large max record size can starve readers pretty
> well.  I've been running it like so:
> 
> #!/bin/sh
> #
> # rio sparse file size of 2G, writes only, max record size 1MB
> #
> rio -s 2G -W -m 1m &
> kid=$!
> sleep 1
> tiobench.pl --threads 8
> kill $kid
> wait
> 
> tiobench is nice because it also gives latency numbers, I'm playing a
> bit to see how the number of tiobench threads changes things, but the
> contest output is much easier to compare.  After a little formatting:
> 
> Sequential Reads
>             File  Blk   Num                   Avg      Maximum      Lat%     Lat%    CPU
> Identifier  Size  Size  Thr   Rate  (CPU%)  Latency    Latency      >2s      >10s    Eff
> ------------ ------ ----- ---  ------ ------ --------- -----------  -------- -------- -----
> 2.4.22-pre5 1792  4096    8    6.92 2.998%     4.363     9666.86   0.02245  0.00000   231
> 2.4.21      1792  4096    8    8.40 3.275%     3.052     3249.79   0.00131  0.00000   256
> 
> Random Reads
>             File  Blk   Num                   Avg      Maximum      Lat%     Lat%    CPU
> Identifier  Size  Size  Thr   Rate  (CPU%)  Latency    Latency      >2s      >10s    Eff
> ------------ ------ ----- ---  ------ ------ --------- -----------  -------- -------- -----
> 2.4.22-pre5 1792  4096    8    1.41 0.540%    20.932      604.13   0.00000  0.00000   260
> 2.4.21      1792  4096    8    0.65 0.540%    41.458     2689.96   0.05000  0.00000   120
> 
> Sequential Writes
>             File  Blk   Num                   Avg      Maximum      Lat%     Lat%    CPU
> Identifier  Size  Size  Thr   Rate  (CPU%)  Latency    Latency      >2s      >10s    Eff
> ------------ ------ ----- ---  ------ ------ --------- -----------  -------- -------- -----
> 2.4.22-pre5 1792  4096    8   13.77 8.793%     1.550     3416.72   0.00567  0.00000   157
> 2.4.21      1792  4096    8   15.38 8.847%     1.169    47134.93   0.00719  0.00305   174
> 
> Random Writes
>             File  Blk   Num                   Avg      Maximum      Lat%     Lat%    CPU
> Identifier  Size  Size  Thr   Rate  (CPU%)  Latency    Latency      >2s      >10s    Eff
> ------------ ------ ----- ---  ------ ------ --------- -----------  -------- -------- -----
> 2.4.22-pre5 1792  4096    8    0.68 1.470%     0.027       12.91   0.00000  0.00000    46
> 2.4.21      1792  4096    8    0.67 0.598%     0.043       67.21   0.00000  0.00000   112
> 
> rio output:
> 2.4.22-pre5 total io 2683.087 MB, 428.000 seconds 6.269 MB/s
> 2.4.21      total io 3231.576 MB, 381.000 seconds 8.482 MB/s
> 2.4.22-pre5 writes: 2683.087 MB, 6.269 MB/s
> 2.4.21      writes: 3231.576 MB, 8.482 MB/s
> 
> Without breaking tiobench apart to skip the write phase it is hard to
> tell where the rio throughput loss is.  My guess is that most of it was
> lost during the sequential write tiobench phase.
> 
> Since jens is getting consistent contest numbers, this isn't meant to
> replace it.  Just another data point worth looking at.  Jens if you want
> to send me your current patch I can give it a quick spin here.

Very nice Chris! I'm still getting the ide numbers here, the patch I'm
using at present looks like the following.

===== drivers/block/ll_rw_blk.c 1.47 vs edited =====
--- 1.47/drivers/block/ll_rw_blk.c	Fri Jul 11 10:30:54 2003
+++ edited/drivers/block/ll_rw_blk.c	Tue Jul 15 11:09:38 2003
@@ -458,6 +458,7 @@
   
  	INIT_LIST_HEAD(&q->rq.free);
 	q->rq.count = 0;
+	q->rq.pending[READ] = q->rq.pending[WRITE] = 0;
 	q->nr_requests = 0;
 
 	si_meminfo(&si);
@@ -549,18 +550,33 @@
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
 
@@ -866,13 +882,25 @@
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
+			printf("reads: %u\n", rl->pending[READ]);
+		if (rl->pending[WRITE] > q->nr_requests)
+			printf("writes: %u\n", rl->pending[WRITE]);
+		if (rl->pending[READ] + rl->pending[WRITE] > q->nr_requests)
+			printf("too many: %u + %u > %u\n", rl->pending[READ], rl->pending[WRITE], q->nr_requests);
+		list_add(&req->queue, &rl->free);
+		if (rl->count >= q->batch_requests && !oversized_batch) {
 			smp_mb();
 			if (waitqueue_active(&q->wait_for_requests))
 				wake_up(&q->wait_for_requests);
@@ -947,7 +975,7 @@
 static int __make_request(request_queue_t * q, int rw,
 				  struct buffer_head * bh)
 {
-	unsigned int sector, count;
+	unsigned int sector, count, sync;
 	int max_segments = MAX_SEGMENTS;
 	struct request * req, *freereq = NULL;
 	int rw_ahead, max_sectors, el_ret;
@@ -958,6 +986,7 @@
 
 	count = bh->b_size >> 9;
 	sector = bh->b_rsector;
+	sync = test_and_clear_bit(BH_Sync, &bh->b_state);
 
 	rw_ahead = 0;	/* normal case; gets changed below for READA */
 	switch (rw) {
@@ -1124,6 +1153,8 @@
 		blkdev_release_request(freereq);
 	if (should_wake)
 		get_request_wait_wakeup(q, rw);
+	if (sync)
+		__generic_unplug_device(q);
 	spin_unlock_irq(&io_request_lock);
 	return 0;
 end_io:
===== fs/buffer.c 1.89 vs edited =====
--- 1.89/fs/buffer.c	Tue Jun 24 23:11:29 2003
+++ edited/fs/buffer.c	Mon Jul 14 16:59:59 2003
@@ -1142,6 +1142,7 @@
 	bh = getblk(dev, block, size);
 	if (buffer_uptodate(bh))
 		return bh;
+	set_bit(BH_Sync, &bh->b_state);
 	ll_rw_block(READ, 1, &bh);
 	wait_on_buffer(bh);
 	if (buffer_uptodate(bh))
===== include/linux/blkdev.h 1.24 vs edited =====
--- 1.24/include/linux/blkdev.h	Fri Jul  4 19:18:12 2003
+++ edited/include/linux/blkdev.h	Tue Jul 15 10:06:04 2003
@@ -66,6 +66,7 @@
 
 struct request_list {
 	unsigned int count;
+	unsigned int pending[2];
 	struct list_head free;
 };
 
===== include/linux/fs.h 1.82 vs edited =====
--- 1.82/include/linux/fs.h	Wed Jul  9 20:42:38 2003
+++ edited/include/linux/fs.h	Tue Jul 15 10:13:13 2003
@@ -221,6 +221,7 @@
 	BH_Launder,	/* 1 if we can throttle on this buffer */
 	BH_Attached,	/* 1 if b_inode_buffers is linked into a list */
 	BH_JBD,		/* 1 if it has an attached journal_head */
+	BH_Sync,	/* 1 if the buffer is a sync read */
 
 	BH_PrivateStart,/* not a state bit, but the first bit available
 			 * for private allocation by other entities

-- 
Jens Axboe

