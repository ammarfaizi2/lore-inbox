Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262506AbSLAVS2>; Sun, 1 Dec 2002 16:18:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262528AbSLAVS2>; Sun, 1 Dec 2002 16:18:28 -0500
Received: from 5-106.ctame701-1.telepar.net.br ([200.193.163.106]:26347 "EHLO
	5-106.ctame701-1.telepar.net.br") by vger.kernel.org with ESMTP
	id <S262506AbSLAVSZ>; Sun, 1 Dec 2002 16:18:25 -0500
Date: Sun, 1 Dec 2002 19:25:43 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Marc-Christian Petersen <m.c.p@wolk-project.de>
cc: linux-kernel@vger.kernel.org, Con Kolivas <conman@kolivas.net>
Subject: Re: [PATCH] 2.4.20-rmap15a
In-Reply-To: <200212012155.30534.m.c.p@wolk-project.de>
Message-ID: <Pine.LNX.4.44L.0212011921420.15981-200000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: MULTIPART/Mixed; BOUNDARY="------------Boundary-00=_MTKGRVJZAM140GIPS8EG"
Content-ID: <Pine.LNX.4.44L.0212011921421.15981@imladris.surriel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--------------Boundary-00=_MTKGRVJZAM140GIPS8EG
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-ID: <Pine.LNX.4.44L.0212011921422.15981@imladris.surriel.com>

On Sun, 1 Dec 2002, Marc-Christian Petersen wrote:

> > update).  The only thing left out of the merge for now is
> > Andrew Morton's read_latency patch, both because I'm not sure
> > how needed it is with the elevator updates

> Well, it is needed. This makes a difference for the I/O pauses noticed
> in 2.4.19 and 2.4.20. Anyway, readlatency-2 won't make them go away, but
> those stops/pauses are a bit less than before.

That was my gut feeling as well, but I guess it's a good thing
to quantify how much of a difference it makes.  I wonder if we
could convince Con to test a kernel both with and without this
patch and look at the difference.

> So, here my patch proposal. Ontop of 2.4.20-rmap15a.

Looks good, now lets test it.  If the patch is as needed as you
say we should push it to marcelo ;)

regards,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".
http://www.surriel.com/		http://guru.conectiva.com/
Current spamtrap:  <a href=mailto:"october@surriel.com">october@surriel.com</a>

--------------Boundary-00=_MTKGRVJZAM140GIPS8EG
Content-Type: TEXT/X-DIFF; CHARSET=us-ascii; NAME="read-latency2-2.4.20-rmap15a.patch"
Content-ID: <Pine.LNX.4.44L.0212011921423.15981@imladris.surriel.com>
Content-Description: 
Content-Disposition: ATTACHMENT; FILENAME="read-latency2-2.4.20-rmap15a.patch"

--- linux-akpm/drivers/block/elevator.c~read-latency2	Sun Nov 10 19:53:53 2002
+++ linux-akpm-akpm/drivers/block/elevator.c	Sun Nov 10 19:59:21 2002
@@ -80,25 +80,38 @@ int elevator_linus_merge(request_queue_t
 			 struct buffer_head *bh, int rw,
 			 int max_sectors)
 {
-	struct list_head *entry = &q->queue_head;
-	unsigned int count = bh->b_size >> 9, ret = ELEVATOR_NO_MERGE;
+	struct list_head *entry;
+	unsigned int count = bh->b_size >> 9;
+	unsigned int ret = ELEVATOR_NO_MERGE;
+	int merge_only = 0;
+	const int max_bomb_segments = q->elevator.max_bomb_segments;
 	struct request *__rq;
+	int passed_a_read = 0;
+
+	entry = &q->queue_head;
 
 	while ((entry = entry->prev) != head) {
 		__rq = blkdev_entry_to_request(entry);
 
-		/*
-		 * we can't insert beyond a zero sequence point
-		 */
-		if (__rq->elevator_sequence <= 0)
-			break;
+		if (__rq->elevator_sequence-- <= 0) {
+			/*
+			 * OK, we've exceeded someone's latency limit.
+			 * But we still continue to look for merges,
+			 * because they're so much better than seeks.
+			 */
+			merge_only = 1;
+		}
 
 		if (__rq->waiting)
 			continue;
 		if (__rq->rq_dev != bh->b_rdev)
 			continue;
-		if (!*req && bh_rq_in_between(bh, __rq, &q->queue_head))
+		if (!*req && !merge_only &&
+				bh_rq_in_between(bh, __rq, &q->queue_head)) {
 			*req = __rq;
+		}
+		if (__rq->cmd != WRITE)
+			passed_a_read = 1;
 		if (__rq->cmd != rw)
 			continue;
 		if (__rq->nr_sectors + count > max_sectors)
@@ -129,6 +142,57 @@ int elevator_linus_merge(request_queue_t
 		}
 	}
 
+	/*
+	 * If we failed to merge a read anywhere in the request
+	 * queue, we really don't want to place it at the end
+	 * of the list, behind lots of writes.  So place it near
+	 * the front.
+	 *
+	 * We don't want to place it in front of _all_ writes: that
+	 * would create lots of seeking, and isn't tunable.
+	 * We try to avoid promoting this read in front of existing
+	 * reads.
+	 *
+	 * max_bomb_segments becomes the maximum number of write
+	 * requests which we allow to remain in place in front of
+	 * a newly introduced read.  We weight things a little bit,
+	 * so large writes are more expensive than small ones, but it's
+	 * requests which count, not sectors.
+	 */
+	if (max_bomb_segments && rw == READ && !passed_a_read &&
+				ret == ELEVATOR_NO_MERGE) {
+		int cur_latency = 0;
+		struct request * const cur_request = *req;
+
+		entry = head->next;
+		while (entry != &q->queue_head) {
+			struct request *__rq;
+
+			if (entry == &q->queue_head)
+				BUG();
+			if (entry == q->queue_head.next &&
+					q->head_active && !q->plugged)
+				BUG();
+			__rq = blkdev_entry_to_request(entry);
+
+			if (__rq == cur_request) {
+				/*
+				 * This is where the old algorithm placed it.
+				 * There's no point pushing it further back,
+				 * so leave it here, in sorted order.
+				 */
+				break;
+			}
+			if (__rq->cmd == WRITE) {
+				cur_latency += 1 + __rq->nr_sectors / 64;
+				if (cur_latency >= max_bomb_segments) {
+					*req = __rq;
+					break;
+				}
+			}
+			entry = entry->next;
+		}
+	}
 	return ret;
 }
 
@@ -186,7 +250,7 @@ int blkelvget_ioctl(elevator_t * elevato
 	output.queue_ID			= elevator->queue_ID;
 	output.read_latency		= elevator->read_latency;
 	output.write_latency		= elevator->write_latency;
-	output.max_bomb_segments	= 0;
+	output.max_bomb_segments	= elevator->max_bomb_segments;
 
 	if (copy_to_user(arg, &output, sizeof(blkelv_ioctl_arg_t)))
 		return -EFAULT;
@@ -205,9 +269,12 @@ int blkelvset_ioctl(elevator_t * elevato
 		return -EINVAL;
 	if (input.write_latency < 0)
 		return -EINVAL;
+	if (input.max_bomb_segments < 0)
+		return -EINVAL;
 
 	elevator->read_latency		= input.read_latency;
 	elevator->write_latency		= input.write_latency;
+	elevator->max_bomb_segments	= input.max_bomb_segments;
 	return 0;
 }
 
--- linux-akpm/drivers/block/ll_rw_blk.c~read-latency2	Sun Nov 10 19:53:53 2002
+++ linux-akpm-akpm/drivers/block/ll_rw_blk.c	Sun Nov 10 19:53:53 2002
@@ -432,9 +432,11 @@ static void blk_init_free_list(request_q
 
 	si_meminfo(&si);
 	megs = si.totalram >> (20 - PAGE_SHIFT);
-	nr_requests = 128;
-	if (megs < 32)
-		nr_requests /= 2;
+	nr_requests = (megs * 2) & ~15;	/* One per half-megabyte */
+	if (nr_requests < 32)
+		nr_requests = 32;
+	if (nr_requests > 1024)
+		nr_requests = 1024;
 	blk_grow_request_list(q, nr_requests);
 
 	init_waitqueue_head(&q->wait_for_requests[0]);

--------------Boundary-00=_MTKGRVJZAM140GIPS8EG--
