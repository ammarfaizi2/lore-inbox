Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290495AbSBFNIQ>; Wed, 6 Feb 2002 08:08:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290496AbSBFNIH>; Wed, 6 Feb 2002 08:08:07 -0500
Received: from holomorphy.com ([216.36.33.161]:51333 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S290495AbSBFNHu>;
	Wed, 6 Feb 2002 08:07:50 -0500
Date: Wed, 6 Feb 2002 05:07:41 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Dan Chen <crimsun@email.unc.edu>
Cc: Shawn Starr <spstarr@sh0n.net>, linux-kernel@vger.kernel.org,
        riel@surriel.com
Subject: Re: 2.4.18-pre8 + 2.4.17-pre8-ac3 + rmap12c + XFS Results
Message-ID: <20020206130741.GA767@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Dan Chen <crimsun@email.unc.edu>, Shawn Starr <spstarr@sh0n.net>,
	linux-kernel@vger.kernel.org, riel@surriel.com
In-Reply-To: <Pine.LNX.4.40.0202060213380.395-100000@coredump.sh0n.net> <20020206091338.GA670@opeth.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <20020206091338.GA670@opeth.ath.cx>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 06, 2002 at 02:17:28AM -0500, Shawn Starr wrote:
>> I'm happy to say that rmap12c has huge preformance improvements over
>> rmap11c with my Pentium 200Mhz w/64MB ram.
>> Some of the differences:
>> rmap11c: slow redrawing of mozilla, mouse hangs, system sluggishness.
>> rmap12c: no slow redrawing UNLESS heavy I/O & swapping is occuring. System
>                                     ^^^^^^^^^^^^^^^^^^^^

On Wed, Feb 06, 2002 at 04:13:38AM -0500, Dan Chen wrote:
> Would you try the ChangeSet 1.188, specifically the one for
> fs/buffer.c@1.52?
> http://linuxvm.bkbits.net:8088/vm-2.4/diffs/fs/buffer.c@1.52?nav=index.html|ChangeSet@-2d|cset@1.188
> 
> I agree that rmap12c + the above fix has noticeable improvements over
> the 11 series. I'll be pushing some numbers out later today.

That patch is:

--- 1.51/fs/buffer.c	Wed Jan 23 15:29:44 2002
+++ 1.52/fs/buffer.c	Mon Feb  4 05:08:59 2002
@@ -2933,7 +2933,6 @@
 
 		spin_lock(&lru_list_lock);
 		if (!write_some_buffers(NODEV) || balance_dirty_state() < 0) {
-			wait_for_some_buffers(NODEV);
 			interruptible_sleep_on(&bdflush_wait);
 		}
 	}
@@ -2964,7 +2964,6 @@
 	complete((struct completion *)startup);
 
 	for (;;) {
-		wait_for_some_buffers(NODEV);
 
 		/* update interval */
 		interval = bdf_prm.b_un.interval;

I think I already sent him that, along with the following, which updates
rmap to akpm's read-latency-2.

Cheers,
Bill


diff -urN linux-virgin/drivers/block/elevator.c linux-wli/drivers/block/elevator.c
--- linux-virgin/drivers/block/elevator.c	Mon Feb  4 17:12:08 2002
+++ linux-wli/drivers/block/elevator.c	Tue Feb  5 17:31:24 2002
@@ -80,31 +80,38 @@
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
diff -urN linux-virgin/drivers/block/ll_rw_blk.c linux-wli/drivers/block/ll_rw_blk.c
--- linux-virgin/drivers/block/ll_rw_blk.c	Mon Feb  4 17:11:27 2002
+++ linux-wli/drivers/block/ll_rw_blk.c	Tue Feb  5 17:31:24 2002
@@ -1095,7 +1095,7 @@
 int __init blk_dev_init(void)
 {
 	struct blk_dev_struct *dev;
-	int total_ram;
+	int total_ram;		/* kilobytes */
 
 	request_cachep = kmem_cache_create("blkdev_requests",
 					   sizeof(struct request),
@@ -1117,9 +1117,11 @@
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
