Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262310AbVC2KGx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262310AbVC2KGx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 05:06:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262314AbVC2KGx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 05:06:53 -0500
Received: from smtp208.mail.sc5.yahoo.com ([216.136.130.116]:43369 "HELO
	smtp208.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262310AbVC2KG3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 05:06:29 -0500
Message-ID: <424928A1.8060400@yahoo.com.au>
Date: Tue, 29 Mar 2005 20:06:25 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20050105 Debian/1.7.5-1
X-Accept-Language: en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: "Chen, Kenneth W" <kenneth.w.chen@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [patch] use cheaper elv_queue_empty when unplug a device
References: <200503290253.j2T2rqg25691@unix-os.sc.intel.com> <20050329080646.GE16636@suse.de> <42491DBE.6020303@yahoo.com.au> <20050329092819.GK16636@suse.de>
In-Reply-To: <20050329092819.GK16636@suse.de>
Content-Type: multipart/mixed;
 boundary="------------020803060001070800050803"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020803060001070800050803
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Jens Axboe wrote:

> Looks good, I've been toying with something very similar for a long time
> myself.
> 

Here is another thing I just noticed that should further reduce the
locking by at least 1, sometimes 2 lock/unlock pairs per request.
At the cost of uglifying the code somewhat. Although it is pretty
nicely contained, so Jens you might consider it acceptable as is,
or we could investigate how to make it nicer if Kenneth reports some
improvement.

Note, this isn't runtime tested - it could easily have a bug.


--------------020803060001070800050803
Content-Type: text/plain;
 name="blk-reduce-locking.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="blk-reduce-locking.patch"




---

 linux-2.6-npiggin/drivers/block/ll_rw_blk.c |   31 +++++++++++++++++++---------
 1 files changed, 22 insertions(+), 9 deletions(-)

diff -puN drivers/block/ll_rw_blk.c~blk-reduce-locking drivers/block/ll_rw_blk.c
--- linux-2.6/drivers/block/ll_rw_blk.c~blk-reduce-locking	2005-03-29 19:51:30.000000000 +1000
+++ linux-2.6-npiggin/drivers/block/ll_rw_blk.c	2005-03-29 20:03:12.000000000 +1000
@@ -1859,10 +1859,13 @@ static void freed_request(request_queue_
 
 #define blkdev_free_rq(list) list_entry((list)->next, struct request, queuelist)
 /*
- * Get a free request, queue_lock must not be held
+ * Get a free request, queue_lock must be held.
+ * Returns NULL on failure, with queue_lock held.
+ * Returns !NULL on success, with queue_lock *not held*.
  */
 static struct request *get_request(request_queue_t *q, int rw, int gfp_mask)
 {
+	int batching;
 	struct request *rq = NULL;
 	struct request_list *rl = &q->rq;
 	struct io_context *ioc = get_io_context(gfp_mask);
@@ -1870,7 +1873,6 @@ static struct request *get_request(reque
 	if (unlikely(test_bit(QUEUE_FLAG_DRAIN, &q->queue_flags)))
 		goto out;
 
-	spin_lock_irq(q->queue_lock);
 	if (rl->count[rw]+1 >= q->nr_requests) {
 		/*
 		 * The queue will fill after this allocation, so set it as
@@ -1883,6 +1885,8 @@ static struct request *get_request(reque
 			blk_set_queue_full(q, rw);
 		}
 	}
+	
+	batching = ioc_batching(q, ioc);
 
 	switch (elv_may_queue(q, rw)) {
 		case ELV_MQUEUE_NO:
@@ -1893,12 +1897,11 @@ static struct request *get_request(reque
 			goto get_rq;
 	}
 
-	if (blk_queue_full(q, rw) && !ioc_batching(q, ioc)) {
+	if (blk_queue_full(q, rw) && !batching) {
 		/*
 		 * The queue is full and the allocating process is not a
 		 * "batcher", and not exempted by the IO scheduler
 		 */
-		spin_unlock_irq(q->queue_lock);
 		goto out;
 	}
 
@@ -1932,11 +1935,10 @@ rq_starved:
 		if (unlikely(rl->count[rw] == 0))
 			rl->starved[rw] = 1;
 
-		spin_unlock_irq(q->queue_lock);
 		goto out;
 	}
 
-	if (ioc_batching(q, ioc))
+	if (batching)
 		ioc->nr_batch_requests--;
 	
 	rq_init(q, rq);
@@ -1949,6 +1951,8 @@ out:
 /*
  * No available requests for this queue, unplug the device and wait for some
  * requests to become available.
+ *
+ * Called with q->queue_lock held, and returns with it unlocked.
  */
 static struct request *get_request_wait(request_queue_t *q, int rw)
 {
@@ -1966,7 +1970,8 @@ static struct request *get_request_wait(
 		if (!rq) {
 			struct io_context *ioc;
 
-			generic_unplug_device(q);
+			__generic_unplug_device(q);
+			spin_unlock_irq(q->queue_lock);
 			io_schedule();
 
 			/*
@@ -1978,6 +1983,8 @@ static struct request *get_request_wait(
 			ioc = get_io_context(GFP_NOIO);
 			ioc_set_batching(q, ioc);
 			put_io_context(ioc);
+
+			spin_lock_irq(q->queue_lock);
 		}
 		finish_wait(&rl->wait[rw], &wait);
 	} while (!rq);
@@ -1991,10 +1998,15 @@ struct request *blk_get_request(request_
 
 	BUG_ON(rw != READ && rw != WRITE);
 
+	spin_lock_irq(q->queue_lock);
 	if (gfp_mask & __GFP_WAIT)
 		rq = get_request_wait(q, rw);
-	else
+	else {
 		rq = get_request(q, rw, gfp_mask);
+		if (!rq)
+			spin_unlock_irq(q->queue_lock);
+	}
+	/* q->queue_lock is unlocked at this point */
 
 	return rq;
 }
@@ -2639,9 +2651,10 @@ static int __make_request(request_queue_
 get_rq:
 	/*
 	 * Grab a free request. This is might sleep but can not fail.
+	 * Returns with the queue unlocked.
 	 */
-	spin_unlock_irq(q->queue_lock);
 	req = get_request_wait(q, rw);
+
 	/*
 	 * After dropping the lock and possibly sleeping here, our request
 	 * may now be mergeable after it had proven unmergeable (above).

_

--------------020803060001070800050803--

