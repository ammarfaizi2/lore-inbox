Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262430AbSLAUty>; Sun, 1 Dec 2002 15:49:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262446AbSLAUtx>; Sun, 1 Dec 2002 15:49:53 -0500
Received: from mailout11.sul.t-online.com ([194.25.134.85]:50102 "EHLO
	mailout11.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S262430AbSLAUtv>; Sun, 1 Dec 2002 15:49:51 -0500
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.4.20-rmap15a
Date: Sun, 1 Dec 2002 21:56:10 +0100
User-Agent: KMail/1.4.3
Organization: WOLK - Working Overloaded Linux Kernel
Cc: Rik van Riel <riel@conectiva.com.br>
MIME-Version: 1.0
Message-Id: <200212012155.30534.m.c.p@wolk-project.de>
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_MTKGRVJZAM140GIPS8EG"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_MTKGRVJZAM140GIPS8EG
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Rik, Hi all,

> This is a merge of rmap15a with marcelo's 2.4 bitkeeper tree,
> which is identical to 2.4.20-rc4 (he didn't push the makefile
> update).  The only thing left out of the merge for now is
> Andrew Morton's read_latency patch, both because I'm not sure
> how needed it is with the elevator updates and because this
> part of the merge was too tricky to do at merge time; I'll port
> over Andrew Morton's read_latency patch later...
Well, it is needed. This makes a difference for the I/O pauses noticed in=
=20
2.4.19 and 2.4.20. Anyway, readlatency-2 won't make them go away, but tho=
se=20
stops/pauses are a bit less than before.

So, here my patch proposal. Ontop of 2.4.20-rmap15a.

ciao, Marc
--------------Boundary-00=_MTKGRVJZAM140GIPS8EG
Content-Type: text/x-diff;
  charset="us-ascii";
  name="read-latency2-2.4.20-rmap15a.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="read-latency2-2.4.20-rmap15a.patch"

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

