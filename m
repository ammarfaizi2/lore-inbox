Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132501AbRBEBIE>; Sun, 4 Feb 2001 20:08:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132471AbRBEBHx>; Sun, 4 Feb 2001 20:07:53 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:30213 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S132427AbRBEBHm>;
	Sun, 4 Feb 2001 20:07:42 -0500
Date: Mon, 5 Feb 2001 02:07:16 +0100
From: Jens Axboe <axboe@suse.de>
To: LA Walsh <law@sgi.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: System unresponsitive when copying HD/HD
Message-ID: <20010205020716.A1276@suse.de>
In-Reply-To: <E14PMvB-0001Mq-00@the-village.bc.nu> <3A7DB3AD.8A2E996E@sgi.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="azLHFNyN32YCQGCU"
Content-Disposition: inline
In-Reply-To: <3A7DB3AD.8A2E996E@sgi.com>; from law@sgi.com on Sun, Feb 04, 2001 at 11:55:25AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--azLHFNyN32YCQGCU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Feb 04 2001, LA Walsh wrote:
> 	Seems to have gotten a bit worse.  Vmstat output after 'vmware' had completed
> write -- but system unresponsive and writing out a 155M file...

Your numbers seem way too much off to have much to do with i/o scheduling
fairness, but there is a slight bug due to the merge and insertion scan
being done at once now. So you could try with attached patch and see
if it makes any difference whatsoever.

> 	Those columns are output from a 'vmstat 5'.  Meaning it took about 70 seconds
> to write out 158M.  Or about 2.2M/s.  That's probably not bad.  It still locks
> up the system for over a minute though -- which is really undesirable performance
> for interactive use.  I'm guessing the vmstat output numbers are showing 4K? 8K? 
> blocks?  8K would about make sense for the 2.2M average.

Most likely 4kB blocks. I'd say the numbers are pretty bad...

-- 
Jens Axboe


--azLHFNyN32YCQGCU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=elv_fair-1

--- /opt/kernel/linux-2.4.2-pre1/drivers/block/elevator.c	Tue Jan 30 13:32:10 2001
+++ drivers/block/elevator.c	Mon Feb  5 01:26:49 2001
@@ -35,6 +35,7 @@
 	struct list_head *entry = &q->queue_head;
 	unsigned int count = bh->b_size >> 9, ret = ELEVATOR_NO_MERGE;
 
+	*req = NULL;
 	while ((entry = entry->prev) != head) {
 		struct request *__rq = blkdev_entry_to_request(entry);
 
@@ -46,10 +47,13 @@
 			break;
 		}
 
+
 		if (__rq->sem)
 			continue;
 		if (__rq->cmd != rw)
 			continue;
+		if (!*req && BHRQ_IN_ORDER(bh, __rq))
+			*req = __rq;
 		if (__rq->rq_dev != bh->b_rdev)
 			continue;
 		if (__rq->nr_sectors + count > max_sectors)
@@ -65,8 +69,7 @@
 			__rq->elevator_sequence -= count;
 			*req = __rq;
 			break;
-		} else if (!*req && BHRQ_IN_ORDER(bh, __rq))
-			*req = __rq;
+		}
 	}
 
 	return ret;
--- /opt/kernel/linux-2.4.2-pre1/drivers/block/ll_rw_blk.c	Tue Jan 30 13:32:10 2001
+++ drivers/block/ll_rw_blk.c	Mon Feb  5 02:02:22 2001
@@ -628,11 +628,19 @@
 		    && atomic_read(&queued_sectors) < low_queued_sectors)
 			wake_up(&blk_buffers_wait);
 
+		if (!list_empty(&q->request_freelist[rw])) {
+			blk_refill_freelist(q, rw);
+			list_add(&req->table, &q->request_freelist[rw]);
+			if (waitqueue_active(&q->wait_for_request))
+				wake_up_nr(&q->wait_for_request, 2);
+			return;
+		}
+
 		/*
-		 * Add to pending free list and batch wakeups
+		 * free list is empty, add to pending free list and
+		 * batch wakeups
 		 */
 		list_add(&req->table, &q->pending_freelist[rw]);
-
 		if (++q->pending_free[rw] >= batch_requests) {
 			int wake_up = q->pending_free[rw];
 			blk_refill_freelist(q, rw);
@@ -705,7 +713,7 @@
 {
 	unsigned int sector, count;
 	int max_segments = MAX_SEGMENTS;
-	struct request * req = NULL, *freereq = NULL;
+	struct request *req, *freereq = NULL;
 	int rw_ahead, max_sectors, el_ret;
 	struct list_head *head, *insert_here;
 	int latency;
@@ -767,6 +775,10 @@
 
 	el_ret = elevator->elevator_merge_fn(q, &req, head, bh, rw,
 					     max_sectors, max_segments);
+	if (el_ret && q->head_active && !q->plugged
+	    && req->queue.prev == &q->queue_head)
+		BUG();
+
 	switch (el_ret) {
 
 		case ELEVATOR_BACK_MERGE:

--azLHFNyN32YCQGCU--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
