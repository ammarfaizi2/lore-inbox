Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291266AbSBLXhv>; Tue, 12 Feb 2002 18:37:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291265AbSBLXhm>; Tue, 12 Feb 2002 18:37:42 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:43781 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S291263AbSBLXhd>;
	Tue, 12 Feb 2002 18:37:33 -0500
Message-ID: <3C69A708.FDDA6097@zip.com.au>
Date: Tue, 12 Feb 2002 15:36:41 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18-pre9-ac2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, lkml <linux-kernel@vger.kernel.org>
Subject: [patch] disk read latency update
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Updates the elevator changes to sync with the version
which is in the latest -rmap patch.

This may complicate future merging with Rik; the easiest
approach will be to just drop any ll_rw_blk.c and elevator.c
chunks when merging up -rmap.

The changes here are:

- More aggressive merging algorithm: continue to add new
  sectors to existing requests even if later requests have
  expired.  We now only refuse to promote new sectors over
  expired ones if the new sector would create a new
  request.

  In other words, latency expiration in the request queue
  no longer means "don't move sectors past this point".  It
  now means "don't create new requests past this point".

  The assumption here is that expanding an existing request
  is basically free.

  Worth about 10% on dbench, and we know how important that is.

- Increase the number of requests to (up to) 1024.

  We really need to do this, and we can afford to, with the
  read latency changes.

  Worth another 10% on dbench.

--- linux-2.4.18-pre9-ac2/drivers/block/elevator.c	Tue Feb 12 12:26:41 2002
+++ ac24/drivers/block/elevator.c	Tue Feb 12 14:30:32 2002
@@ -80,31 +80,38 @@ int elevator_linus_merge(request_queue_t
 			 struct buffer_head *bh, int rw,
 			 int max_sectors)
 {
-	struct list_head *entry = &q->queue_head;
-	unsigned int count = bh->b_size >> 9, ret = ELEVATOR_NO_MERGE;
+	struct list_head *entry;
+	unsigned int count = bh->b_size >> 9;
+	unsigned int ret = ELEVATOR_NO_MERGE;
+	int merge_only = 0;
 	const int max_bomb_segments = q->elevator.max_bomb_segments;
-
+ 
+	entry = &q->queue_head;
 	while ((entry = entry->prev) != head) {
 		struct request *__rq = blkdev_entry_to_request(entry);
 
-		/*
-		 * simply "aging" of requests in queue
-		 */
-		if (__rq->elevator_sequence-- <= 0)
-			break;
-
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
+			bh_rq_in_between(bh, __rq, &q->queue_head)) {
 			*req = __rq;
+		}
 		if (__rq->cmd != rw)
 			continue;
 		if (__rq->nr_sectors + count > max_sectors)
 			continue;
 		if (__rq->elevator_sequence < count)
-			break;
+			merge_only = 1;
 		if (__rq->sector + __rq->nr_sectors == bh->b_rsector) {
 			ret = ELEVATOR_BACK_MERGE;
 			*req = __rq;
@@ -128,7 +135,7 @@ int elevator_linus_merge(request_queue_t
 	 * We try to avoid promoting this read in front of existing
 	 * reads.
 	 *
-	 * max_bomb_sectors becomes the maximum number of write
+	 * max_bomb_segments becomes the maximum number of write
 	 * requests which we allow to remain in place in front of
 	 * a newly introduced read.  We weight things a little bit,
 	 * so large writes are more expensive than small ones, but it's
--- linux-2.4.18-pre9-ac2/drivers/block/ll_rw_blk.c	Tue Feb 12 12:26:41 2002
+++ ac24/drivers/block/ll_rw_blk.c	Tue Feb 12 14:31:08 2002
@@ -1134,7 +1134,7 @@ void end_that_request_last(struct reques
 int __init blk_dev_init(void)
 {
 	struct blk_dev_struct *dev;
-	int total_ram;
+	int total_ram;		/* kilobytes */
 
 	request_cachep = kmem_cache_create("blkdev_requests",
 					   sizeof(struct request),
@@ -1156,9 +1156,11 @@ int __init blk_dev_init(void)
 	 * Free request slots per queue.
 	 * (Half for reads, half for writes)
 	 */
-	queue_nr_requests = 64;
-	if (total_ram > MB(32))
-		queue_nr_requests = 128;
+	queue_nr_requests = (total_ram >> 9) & ~15;	/* One per half-megabyte */
+	if (queue_nr_requests < 32)
+		queue_nr_requests = 32;
+	if (queue_nr_requests > 1024)
+		queue_nr_requests = 1024;
 
 	/*
 	 * Batch frees according to queue length


-
