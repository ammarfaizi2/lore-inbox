Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262418AbVDLNC3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262418AbVDLNC3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 09:02:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262422AbVDLNA4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 09:00:56 -0400
Received: from smtp203.mail.sc5.yahoo.com ([216.136.129.93]:42099 "HELO
	smtp203.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262418AbVDLMvp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 08:51:45 -0400
Message-ID: <425BC45D.9030504@yahoo.com.au>
Date: Tue, 12 Apr 2005 22:51:41 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050324 Debian/1.7.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Jens Axboe <axboe@suse.de>, linux-kernel <linux-kernel@vger.kernel.org>,
       "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Subject: [patch 7/9] blk: efficiency improvements
References: <425BC262.1070500@yahoo.com.au>
In-Reply-To: <425BC262.1070500@yahoo.com.au>
Content-Type: multipart/mixed;
 boundary="------------040108040708020708090700"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040108040708020708090700
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

7/9

-- 
SUSE Labs, Novell Inc.

--------------040108040708020708090700
Content-Type: text/plain;
 name="blk-efficient.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="blk-efficient.patch"

In the case where the request is not able to be merged by the elevator,
don't retake the lock and retry the merge mechanism after allocating a
new request.

Instead assume that the chance of a merge remains slim, and now that
we've done most of the work allocating a request we may as well just
go with it.

Also be rid of the GFP_ATOMIC allocation: we've got working mempools
for the block layer now, so let's save atomic memory for things like
networking.

Lastly, in get_request_wait, do an initial get_request call before
going into the waitqueue. This is reported to help efficiency.

Signed-off-by: Nick Piggin <nickpiggin@yahoo.com.au>

Index: linux-2.6/drivers/block/ll_rw_blk.c
===================================================================
--- linux-2.6.orig/drivers/block/ll_rw_blk.c	2005-04-12 22:26:14.000000000 +1000
+++ linux-2.6/drivers/block/ll_rw_blk.c	2005-04-12 22:26:14.000000000 +1000
@@ -1952,10 +1952,11 @@ out:
  */
 static struct request *get_request_wait(request_queue_t *q, int rw)
 {
-	DEFINE_WAIT(wait);
 	struct request *rq;
 
-	do {
+	rq = get_request(q, rw, GFP_NOIO);
+	while (!rq) {
+		DEFINE_WAIT(wait);
 		struct request_list *rl = &q->rq;
 
 		prepare_to_wait_exclusive(&rl->wait[rw], &wait,
@@ -1980,7 +1981,7 @@ static struct request *get_request_wait(
 			put_io_context(ioc);
 		}
 		finish_wait(&rl->wait[rw], &wait);
-	} while (!rq);
+	}
 
 	return rq;
 }
@@ -2557,7 +2558,7 @@ EXPORT_SYMBOL(__blk_attempt_remerge);
 
 static int __make_request(request_queue_t *q, struct bio *bio)
 {
-	struct request *req, *freereq = NULL;
+	struct request *req;
 	int el_ret, rw, nr_sectors, cur_nr_sectors, barrier, err;
 	sector_t sector;
 
@@ -2582,14 +2583,9 @@ static int __make_request(request_queue_
 		goto end_io;
 	}
 
-again:
 	spin_lock_irq(q->queue_lock);
 
-	if (elv_queue_empty(q)) {
-		blk_plug_device(q);
-		goto get_rq;
-	}
-	if (barrier)
+	if (unlikely(barrier) || elv_queue_empty(q))
 		goto get_rq;
 
 	el_ret = elv_merge(q, &req, bio);
@@ -2632,40 +2628,23 @@ again:
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
 
@@ -2693,10 +2672,11 @@ get_rq:
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
 

--------------040108040708020708090700--

