Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262452AbVDLNna@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262452AbVDLNna (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 09:43:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262451AbVDLM7m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 08:59:42 -0400
Received: from smtp207.mail.sc5.yahoo.com ([216.136.129.97]:64856 "HELO
	smtp207.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262422AbVDLMwL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 08:52:11 -0400
Message-ID: <425BC477.4020002@yahoo.com.au>
Date: Tue, 12 Apr 2005 22:52:07 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050324 Debian/1.7.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Jens Axboe <axboe@suse.de>, linux-kernel <linux-kernel@vger.kernel.org>,
       "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Subject: [patch 0/9] blk: reduce locking
References: <425BC262.1070500@yahoo.com.au>
In-Reply-To: <425BC262.1070500@yahoo.com.au>
Content-Type: multipart/mixed;
 boundary="------------080908040102080705010601"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080908040102080705010601
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

8/9

-- 
SUSE Labs, Novell Inc.

--------------080908040102080705010601
Content-Type: text/plain;
 name="blk-reduce-locking.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="blk-reduce-locking.patch"

Change around locking a bit for a result of 1-2 less spin lock
unlock pairs in request submission paths.

Signed-off-by: Nick Piggin <nickpiggin@yahoo.com.au>

Index: linux-2.6/drivers/block/ll_rw_blk.c
===================================================================
--- linux-2.6.orig/drivers/block/ll_rw_blk.c	2005-04-12 22:26:14.000000000 +1000
+++ linux-2.6/drivers/block/ll_rw_blk.c	2005-04-12 22:26:15.000000000 +1000
@@ -1859,18 +1859,20 @@ static void freed_request(request_queue_
 
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
-	struct io_context *ioc = get_io_context(gfp_mask);
+	struct io_context *ioc = get_io_context(GFP_ATOMIC);
 
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
@@ -1967,7 +1971,8 @@ static struct request *get_request_wait(
 		if (!rq) {
 			struct io_context *ioc;
 
-			generic_unplug_device(q);
+			__generic_unplug_device(q);
+			spin_unlock_irq(q->queue_lock);
 			io_schedule();
 
 			/*
@@ -1979,6 +1984,8 @@ static struct request *get_request_wait(
 			ioc = get_io_context(GFP_NOIO);
 			ioc_set_batching(q, ioc);
 			put_io_context(ioc);
+
+			spin_lock_irq(q->queue_lock);
 		}
 		finish_wait(&rl->wait[rw], &wait);
 	}
@@ -1992,10 +1999,15 @@ struct request *blk_get_request(request_
 
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
@@ -2636,9 +2648,10 @@ static int __make_request(request_queue_
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

--------------080908040102080705010601--

