Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262205AbVC2JWG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262205AbVC2JWG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 04:22:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262250AbVC2JWF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 04:22:05 -0500
Received: from smtp204.mail.sc5.yahoo.com ([216.136.130.127]:12147 "HELO
	smtp204.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262205AbVC2JUJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 04:20:09 -0500
Message-ID: <42491DBE.6020303@yahoo.com.au>
Date: Tue, 29 Mar 2005 19:19:58 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20050105 Debian/1.7.5-1
X-Accept-Language: en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: "Chen, Kenneth W" <kenneth.w.chen@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [patch] use cheaper elv_queue_empty when unplug a device
References: <200503290253.j2T2rqg25691@unix-os.sc.intel.com> <20050329080646.GE16636@suse.de>
In-Reply-To: <20050329080646.GE16636@suse.de>
Content-Type: multipart/mixed;
 boundary="------------070200050208010702090600"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070200050208010702090600
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Jens Axboe wrote:
> On Mon, Mar 28 2005, Chen, Kenneth W wrote:
> 
>>This patch was posted last year and if I remember correctly, Jens said
>>he is OK with the patch.  In function __generic_unplug_deivce(), kernel
>>can use a cheaper function elv_queue_empty() instead of more expensive
>>elv_next_request to find whether the queue is empty or not. blk_run_queue
>>can also made conditional on whether queue's emptiness before calling
>>request_fn().
>>
>>
>>Signed-off-by: Ken Chen <kenneth.w.chen@intel.com>
> 
> 
> Looks good, thanks.
> 
> Signed-off-by: Jens Axboe <axboe@suse.de>
> 

Speaking of which, I've had a few ideas lying around for possible
performance improvement in the block code.

I haven't used a big disk array (or tried any simulation), but I'll
attach the patch if you're looking into that area.

It puts in a few unlikely()s, but the main changes are:
- don't generic_unplug_device unconditionally in get_request_wait,
- removes the relock/retry merge mechanism in __make_request if we
   aren't able to get the GFP_ATOMIC allocation. Just fall through
   and assume the chances of getting a merge will be small (is this
   a valid assumption? Should measure it I guess).
- removes the GFP_ATOMIC allocation. That's always a good thing.


--------------070200050208010702090600
Content-Type: text/plain;
 name="blk-efficient.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="blk-efficient.patch"

---

 linux-2.6-npiggin/drivers/block/ll_rw_blk.c |   63 ++++++++++------------------
 1 files changed, 23 insertions(+), 40 deletions(-)

diff -puN drivers/block/ll_rw_blk.c~blk-efficient drivers/block/ll_rw_blk.c
--- linux-2.6/drivers/block/ll_rw_blk.c~blk-efficient	2005-03-29 19:00:07.000000000 +1000
+++ linux-2.6-npiggin/drivers/block/ll_rw_blk.c	2005-03-29 19:10:45.000000000 +1000
@@ -1450,7 +1450,7 @@ EXPORT_SYMBOL(blk_remove_plug);
  */
 void __generic_unplug_device(request_queue_t *q)
 {
-	if (test_bit(QUEUE_FLAG_STOPPED, &q->queue_flags))
+	if (unlikely(test_bit(QUEUE_FLAG_STOPPED, &q->queue_flags)))
 		return;
 
 	if (!blk_remove_plug(q))
@@ -1955,7 +1955,6 @@ static struct request *get_request_wait(
 	DEFINE_WAIT(wait);
 	struct request *rq;
 
-	generic_unplug_device(q);
 	do {
 		struct request_list *rl = &q->rq;
 
@@ -1967,6 +1966,7 @@ static struct request *get_request_wait(
 		if (!rq) {
 			struct io_context *ioc;
 
+			generic_unplug_device(q);
 			io_schedule();
 
 			/*
@@ -2557,7 +2557,7 @@ EXPORT_SYMBOL(__blk_attempt_remerge);
 
 static int __make_request(request_queue_t *q, struct bio *bio)
 {
-	struct request *req, *freereq = NULL;
+	struct request *req;
 	int el_ret, rw, nr_sectors, cur_nr_sectors, barrier, err;
 	sector_t sector;
 
@@ -2577,19 +2577,18 @@ static int __make_request(request_queue_
 	spin_lock_prefetch(q->queue_lock);
 
 	barrier = bio_barrier(bio);
-	if (barrier && (q->ordered == QUEUE_ORDERED_NONE)) {
+	if (unlikely(barrier) && (q->ordered == QUEUE_ORDERED_NONE)) {
 		err = -EOPNOTSUPP;
 		goto end_io;
 	}
 
-again:
 	spin_lock_irq(q->queue_lock);
 
 	if (elv_queue_empty(q)) {
 		blk_plug_device(q);
 		goto get_rq;
 	}
-	if (barrier)
+	if (unlikely(barrier))
 		goto get_rq;
 
 	el_ret = elv_merge(q, &req, bio);
@@ -2632,40 +2631,23 @@ again:
 				elv_merged_request(q, req);
 			goto out;
 
-		/*
-		 * elevator says don't/can't merge. get new request
-		 */
-		case ELEVATOR_NO_MERGE:
-			break;
-
+		/* ELV_NO_MERGE: elevator says don't/can't merge. */
 		default:
-			printk("elevator returned crap (%d)\n", el_ret);
-			BUG();
+			;
 	}
 
+get_rq:
 	/*
-	 * Grab a free request from the freelist - if that is empty, check
-	 * if we are doing read ahead and abort instead of blocking for
-	 * a free slot.
+	 * Grab a free request. This is might sleep but can not fail.
+	 */
+	spin_unlock_irq(q->queue_lock);
+	req = get_request_wait(q, rw);
+	/*
+	 * After dropping the lock and possibly sleeping here, our request
+	 * may now be mergeable after it had proven unmergeable (above).
+	 * We don't worry about that case for efficiency. It won't happen
+	 * often, and the elevators are able to handle it.
 	 */
-get_rq:
-	if (freereq) {
-		req = freereq;
-		freereq = NULL;
-	} else {
-		spin_unlock_irq(q->queue_lock);
-		if ((freereq = get_request(q, rw, GFP_ATOMIC)) == NULL) {
-			/*
-			 * READA bit set
-			 */
-			err = -EWOULDBLOCK;
-			if (bio_rw_ahead(bio))
-				goto end_io;
-	
-			freereq = get_request_wait(q, rw);
-		}
-		goto again;
-	}
 
 	req->flags |= REQ_CMD;
 
@@ -2678,7 +2660,7 @@ get_rq:
 	/*
 	 * REQ_BARRIER implies no merging, but lets make it explicit
 	 */
-	if (barrier)
+	if (unlikely(barrier))
 		req->flags |= (REQ_HARDBARRIER | REQ_NOMERGE);
 
 	req->errors = 0;
@@ -2693,10 +2675,11 @@ get_rq:
 	req->rq_disk = bio->bi_bdev->bd_disk;
 	req->start_time = jiffies;
 
+	spin_lock_irq(q->queue_lock);
+	if (elv_queue_empty(q))
+		blk_plug_device(q);
 	add_request(q, req);
 out:
-	if (freereq)
-		__blk_put_request(q, freereq);
 	if (bio_sync(bio))
 		__generic_unplug_device(q);
 
@@ -2802,7 +2785,7 @@ static inline void block_wait_queue_runn
 {
 	DEFINE_WAIT(wait);
 
-	while (test_bit(QUEUE_FLAG_DRAIN, &q->queue_flags)) {
+	while (unlikely(test_bit(QUEUE_FLAG_DRAIN, &q->queue_flags))) {
 		struct request_list *rl = &q->rq;
 
 		prepare_to_wait_exclusive(&rl->drain, &wait,
@@ -2911,7 +2894,7 @@ end_io:
 			goto end_io;
 		}
 
-		if (test_bit(QUEUE_FLAG_DEAD, &q->queue_flags))
+		if (unlikely(test_bit(QUEUE_FLAG_DEAD, &q->queue_flags)))
 			goto end_io;
 
 		block_wait_queue_running(q);

_

--------------070200050208010702090600--

