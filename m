Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280293AbRKEHTQ>; Mon, 5 Nov 2001 02:19:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280291AbRKEHTH>; Mon, 5 Nov 2001 02:19:07 -0500
Received: from 117.ppp1-1.hob.worldonline.dk ([212.54.84.117]:14976 "EHLO
	milhouse.home.kernel.dk") by vger.kernel.org with ESMTP
	id <S280290AbRKEHSx>; Mon, 5 Nov 2001 02:18:53 -0500
Date: Mon, 5 Nov 2001 08:18:36 +0100
From: Jens Axboe <axboe@suse.de>
To: Andrew Morton <akpm@zip.com.au>
Cc: Mike Fedyk <mfedyk@matchmail.com>, lkml <linux-kernel@vger.kernel.org>,
        ext2-devel@lists.sourceforge.net
Subject: Re: [Ext2-devel] disk throughput
Message-ID: <20011105081836.F2580@suse.de>
In-Reply-To: <3BE5F5BF.7A249BDF@zip.com.au>, <3BE5F5BF.7A249BDF@zip.com.au> <20011104193232.A16679@mikef-linux.matchmail.com> <3BE60B51.968458D3@zip.com.au> <20011105080635.D2580@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="J/dobhs11T7y2rNN"
Content-Disposition: inline
In-Reply-To: <20011105080635.D2580@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--J/dobhs11T7y2rNN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 05 2001, Jens Axboe wrote:
> Interesting, the 2.5 design prevents this since it doesn't account
> merges as a penalty (like a seek). I can do something like that for 2.4
> too, I'll do a patch for you to test.

Ok here it is. It's not as efficient as the 2.5 version since it
proceeds to scan the entire queue for a merge, but it should suffice for
your testing.

-- 
Jens Axboe


--J/dobhs11T7y2rNN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=elv-merge-account-1

--- drivers/block/ll_rw_blk.c~	Mon Nov  5 08:15:25 2001
+++ drivers/block/ll_rw_blk.c	Mon Nov  5 08:15:51 2001
@@ -696,7 +696,9 @@
 		case ELEVATOR_BACK_MERGE:
 			if (!q->back_merge_fn(q, req, bh, max_segments))
 				break;
+#if 0
 			elevator->elevator_merge_cleanup_fn(q, req, count);
+#endif
 			req->bhtail->b_reqnext = bh;
 			req->bhtail = bh;
 			req->nr_sectors = req->hard_nr_sectors += count;
@@ -708,7 +710,9 @@
 		case ELEVATOR_FRONT_MERGE:
 			if (!q->front_merge_fn(q, req, bh, max_segments))
 				break;
+#if 0
 			elevator->elevator_merge_cleanup_fn(q, req, count);
+#endif
 			bh->b_reqnext = req->bh;
 			req->bh = bh;
 			req->buffer = bh->b_data;
--- drivers/block/elevator.c~	Mon Nov  5 08:13:19 2001
+++ drivers/block/elevator.c	Mon Nov  5 08:18:04 2001
@@ -81,8 +81,9 @@
 			 int max_sectors)
 {
 	struct list_head *entry = &q->queue_head;
-	unsigned int count = bh->b_size >> 9, ret = ELEVATOR_NO_MERGE;
+	unsigned int count = bh->b_size >> 9, ret = ELEVATOR_NO_MERGE, queue;
 
+	queue = 1;
 	while ((entry = entry->prev) != head) {
 		struct request *__rq = blkdev_entry_to_request(entry);
 
@@ -90,13 +91,13 @@
 		 * simply "aging" of requests in queue
 		 */
 		if (__rq->elevator_sequence-- <= 0)
-			break;
+			queue = 0;
 
 		if (__rq->waiting)
 			continue;
 		if (__rq->rq_dev != bh->b_rdev)
 			continue;
-		if (!*req && bh_rq_in_between(bh, __rq, &q->queue_head))
+		if (queue && !*req && bh_rq_in_between(bh, __rq,&q->queue_head))
 			*req = __rq;
 		if (__rq->cmd != rw)
 			continue;
@@ -110,7 +111,6 @@
 			break;
 		} else if (__rq->sector - count == bh->b_rsector) {
 			ret = ELEVATOR_FRONT_MERGE;
-			__rq->elevator_sequence -= count;
 			*req = __rq;
 			break;
 		}

--J/dobhs11T7y2rNN--
