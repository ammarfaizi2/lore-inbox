Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270902AbTGNVP4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 17:15:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270901AbTGNVO0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 17:14:26 -0400
Received: from 69-55-72-150.ppp.netsville.net ([69.55.72.150]:34002 "EHLO
	tiny.suse.com") by vger.kernel.org with ESMTP id S270883AbTGNVLb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 17:11:31 -0400
Subject: Re: RFC on io-stalls patch
From: Chris Mason <mason@suse.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Jens Axboe <axboe@suse.de>, Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>,
       "Stephen C. Tweedie" <sct@redhat.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Jeff Garzik <jgarzik@pobox.com>,
       Andrew Morton <akpm@digeo.com>, Alexander Viro <viro@math.psu.edu>
In-Reply-To: <20030714201924.GR16313@dualathlon.random>
References: <1057932804.13313.58.camel@tiny.suse.com>
	 <20030712073710.GK843@suse.de> <1058034751.13318.95.camel@tiny.suse.com>
	 <20030713090116.GU843@suse.de> <20030713191921.GI16313@dualathlon.random>
	 <20030714054918.GD843@suse.de>
	 <Pine.LNX.4.55L.0307140922130.17091@freak.distro.conectiva>
	 <20030714131206.GJ833@suse.de> <20030714195138.GX833@suse.de>
	 <1058213348.13313.274.camel@tiny.suse.com>
	 <20030714201924.GR16313@dualathlon.random>
Content-Type: text/plain
Organization: 
Message-Id: <1058217899.13317.338.camel@tiny.suse.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 14 Jul 2003 17:24:59 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-07-14 at 16:19, Andrea Arcangeli wrote:

> > Could I talk you into trying a form of this patch that honors
> > blk_oversized_queue for everything except the BH_sync requests?
> 
> not honoring blk_oversized_queue for BH_sync isn't safe either (still it
> would be an order of magnitude safer than not honoring it for all reads
> unconditonally)  there must be a secondary limit, eating all the
> requests with potentially 512k of ram queued into each requests is
> unsafe (one can generate many sync requests by forking some hundred
> thousand tasks, this isn't only x86).

Fair enough.  This patch allows sync requests to steal up to
q->batch_sectors of additional requests.  This is probably too big a
number but it had the benefit of being already calculated for me.

I need to replace that q->rq.count < 4 crud with a constant or just drop
it entirely.  I like that elevator-lowlatency is more concerned with
sectors in flight than free requests, it would probably be best to keep
it that way.

In other words, this patch is for discussion only.  It allows BH_Sync to
be set for write requests as well, since my original idea for it was to
give lower latencies to any request the rest of the box might be waiting
on (like a log commit).

-chris

--- 1.48/drivers/block/ll_rw_blk.c	Fri Jul 11 15:08:30 2003
+++ edited/drivers/block/ll_rw_blk.c	Mon Jul 14 17:15:35 2003
@@ -546,13 +546,20 @@
  * Get a free request. io_request_lock must be held and interrupts
  * disabled on the way in.  Returns NULL if there are no free requests.
  */
-static struct request *get_request(request_queue_t *q, int rw)
+static struct request *get_request(request_queue_t *q, int rw, int sync)
 {
 	struct request *rq = NULL;
-	struct request_list *rl;
+	struct request_list *rl = &q->rq;
 
-	rl = &q->rq;
-	if (!list_empty(&rl->free) && !blk_oversized_queue(q)) {
+	if (sync) {
+		if (blk_oversized_queue_sync(q))
+			return NULL;
+	} else {
+		if (blk_oversized_queue(q) || q->rq.count < 4)
+			return NULL;
+	}
+
+	if (!list_empty(&rl->free)) {
 		rq = blkdev_free_rq(&rl->free);
 		list_del(&rq->queue);
 		rl->count--;
@@ -608,7 +615,7 @@
  *   wakeups where there aren't any requests available yet.
  */
 
-static struct request *__get_request_wait(request_queue_t *q, int rw)
+static struct request *__get_request_wait(request_queue_t *q, int rw, int sync)
 {
 	register struct request *rq;
 	DECLARE_WAITQUEUE(wait, current);
@@ -618,13 +625,13 @@
 	do {
 		set_current_state(TASK_UNINTERRUPTIBLE);
 		spin_lock_irq(&io_request_lock);
-		if (blk_oversized_queue(q) || q->rq.count == 0) {
+		if (blk_oversized_queue(q) || q->rq.count < 4) {
 			__generic_unplug_device(q);
 			spin_unlock_irq(&io_request_lock);
 			schedule();
 			spin_lock_irq(&io_request_lock);
 		}
-		rq = get_request(q, rw);
+		rq = get_request(q, rw, sync);
 		spin_unlock_irq(&io_request_lock);
 	} while (rq == NULL);
 	remove_wait_queue(&q->wait_for_requests, &wait);
@@ -947,7 +954,7 @@
 static int __make_request(request_queue_t * q, int rw,
 				  struct buffer_head * bh)
 {
-	unsigned int sector, count;
+	unsigned int sector, count, sync;
 	int max_segments = MAX_SEGMENTS;
 	struct request * req, *freereq = NULL;
 	int rw_ahead, max_sectors, el_ret;
@@ -958,6 +965,7 @@
 
 	count = bh->b_size >> 9;
 	sector = bh->b_rsector;
+	sync = test_and_clear_bit(BH_Sync, &bh->b_state);
 
 	rw_ahead = 0;	/* normal case; gets changed below for READA */
 	switch (rw) {
@@ -1084,14 +1092,14 @@
 				spin_unlock_irq(&io_request_lock);
 				goto end_io;
 			}
-			req = get_request(q, rw);
+			req = get_request(q, rw, sync);
 			if (req == NULL)
 				BUG();
 		} else {
-			req = get_request(q, rw);
+			req = get_request(q, rw, sync);
 			if (req == NULL) {
 				spin_unlock_irq(&io_request_lock);
-				freereq = __get_request_wait(q, rw);
+				freereq = __get_request_wait(q, rw, sync);
 				head = &q->queue_head;
 				spin_lock_irq(&io_request_lock);
 				should_wake = 1;
@@ -1122,6 +1130,8 @@
 out:
 	if (freereq)
 		blkdev_release_request(freereq);
+	if (sync)
+		__generic_unplug_device(q);
 	if (should_wake)
 		get_request_wait_wakeup(q, rw);
 	spin_unlock_irq(&io_request_lock);
--- 1.92/fs/buffer.c	Fri Jul 11 16:43:23 2003
+++ edited/fs/buffer.c	Mon Jul 14 16:23:24 2003
@@ -1144,6 +1144,7 @@
 	bh = getblk(dev, block, size);
 	if (buffer_uptodate(bh))
 		return bh;
+	set_bit(BH_Sync, &bh->b_state);
 	ll_rw_block(READ, 1, &bh);
 	wait_on_buffer(bh);
 	if (buffer_uptodate(bh))
--- 1.24/include/linux/blkdev.h	Fri Jul  4 13:18:12 2003
+++ edited/include/linux/blkdev.h	Mon Jul 14 16:46:56 2003
@@ -295,6 +295,13 @@
 	return q->rq.count == 0;
 }
 
+static inline int blk_oversized_queue_sync(request_queue_t * q)
+{
+	if (q->can_throttle)
+		return atomic_read(&q->nr_sectors) > q->max_queue_sectors + q->batch_sectors;
+	return q->rq.count == 0;
+}
+
 static inline int blk_oversized_queue_batch(request_queue_t * q)
 {
 	return atomic_read(&q->nr_sectors) > q->max_queue_sectors - q->batch_sectors;
--- 1.84/include/linux/fs.h	Fri Jul 11 15:13:13 2003
+++ edited/include/linux/fs.h	Mon Jul 14 16:23:24 2003
@@ -221,6 +221,7 @@
 	BH_Launder,	/* 1 if we can throttle on this buffer */
 	BH_Attached,	/* 1 if b_inode_buffers is linked into a list */
 	BH_JBD,		/* 1 if it has an attached journal_head */
+	BH_Sync,
 
 	BH_PrivateStart,/* not a state bit, but the first bit available
 			 * for private allocation by other entities



