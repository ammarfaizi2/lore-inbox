Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262220AbVC2Iao@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262220AbVC2Iao (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 03:30:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262200AbVC2IMk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 03:12:40 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:48868 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262199AbVC2IGK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 03:06:10 -0500
Date: Tue, 29 Mar 2005 10:06:03 +0200
From: Jens Axboe <axboe@suse.de>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] new fifo I/O elevator that really does nothing at all
Message-ID: <20050329080559.GD16636@suse.de>
References: <200503290148.j2T1mOg25279@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200503290148.j2T1mOg25279@unix-os.sc.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 28 2005, Chen, Kenneth W wrote:
> The noop elevator is still too fat for db transaction processing
> workload.  Since the db application already merged all blocks before
> sending it down, the I/O presented to the elevator are actually not
> merge-able anymore. Since I/O are also random, we don't want to sort
> them either.  However the noop elevator is still doing a linear search
> on the entire list of requests in the queue.  A noop elevator after
> all isn't really noop.
> 
> We are proposing a true no-op elevator algorithm, no merge, no
> nothing. Just do first in and first out list management for the I/O
> request.  The best name I can come up with is "FIFO".  I also piggy
> backed the code onto noop-iosched.c.  I can easily pull those code
> into a separate file if people object.  Though, I hope Jens is OK with
> it.

It's not quite ok, because you don't honor the insertion point in
fifo_add_request. The only 'fat' part of the noop io scheduler is the
merge stuff, the original plan was to move that to a hash table lookup
instead like the other io schedulers do. So I would suggest just
changing noop to hash the request on the end point for back merges and
forget about front merges, since they are rare anyways. Hmm actually,
the last merge hint should catch most of the merges at almost zero cost.
How about this patch?

Signed-off-by: Jens Axboe <axboe@suse.de>

===== drivers/block/noop-iosched.c 1.7 vs edited =====
--- 1.7/drivers/block/noop-iosched.c	2005-01-14 17:35:40 +01:00
+++ edited/drivers/block/noop-iosched.c	2005-03-29 10:05:21 +02:00
@@ -13,34 +13,13 @@
 static int elevator_noop_merge(request_queue_t *q, struct request **req,
 			       struct bio *bio)
 {
-	struct list_head *entry = &q->queue_head;
-	struct request *__rq;
 	int ret;
 
-	if ((ret = elv_try_last_merge(q, bio))) {
+	ret = elv_try_last_merge(q, bio);
+	if (ret != ELEVATOR_NO_MERGE)
 		*req = q->last_merge;
-		return ret;
-	}
 
-	while ((entry = entry->prev) != &q->queue_head) {
-		__rq = list_entry_rq(entry);
-
-		if (__rq->flags & (REQ_SOFTBARRIER | REQ_HARDBARRIER))
-			break;
-		else if (__rq->flags & REQ_STARTED)
-			break;
-
-		if (!blk_fs_request(__rq))
-			continue;
-
-		if ((ret = elv_try_merge(__rq, bio))) {
-			*req = __rq;
-			q->last_merge = __rq;
-			return ret;
-		}
-	}
-
-	return ELEVATOR_NO_MERGE;
+	return ret;
 }
 
 static void elevator_noop_merge_requests(request_queue_t *q, struct request *req,

-- 
Jens Axboe

