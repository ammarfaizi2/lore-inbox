Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262283AbTFBMkL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jun 2003 08:40:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262288AbTFBMkL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jun 2003 08:40:11 -0400
Received: from [203.221.74.223] ([203.221.74.223]:31492 "EHLO chimp.local.net")
	by vger.kernel.org with ESMTP id S262283AbTFBMkF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jun 2003 08:40:05 -0400
Message-ID: <3EDB48B7.2050604@cyberone.com.au>
Date: Mon, 02 Jun 2003 22:53:11 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030327 Debian/1.3-4
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
CC: Con Kolivas <kernel@kolivas.org>,
       Marc-Christian Petersen <m.c.p@wolk-project.de>
Subject: [PATCH][CFT] blk-fair-batches vs 2.4.20-rc6
Content-Type: multipart/mixed;
 boundary="------------030405090901050704090302"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030405090901050704090302
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi,
Due to the recently discussed IO stalls in 2.4, I had a
bit of a look at the request allocator in 2.5 and found a
problem. The same problem does exist in 2.4 as well. It
could cause the same symptoms as these stalls. It would
be nice to know if its really the cause.

It would be nice if anyone interested could test.
Patch compiles, boots and survives tiobench, etc. here.
Jens thought the patch (2.5 version) looked OK.

Thanks,
Nick

Previously:
* request queue fills up
* process 1 calls get_request, sleeps
* a couple of requests are freed
* process 2 calls get_request, proceeds
* a couple of requests are freed
* process 2 calls get_request, proceeds
...

Now as unlikely as it seems, it could be a problem. Its a fairness
problem that process 2 can skip ahead of process 1 anyway.

With the patch:
* request queue fills up
* any process calling get_request will sleep
* once the queue gets below the batch watermark, processes
 start being worken, and may allocate.

--------------030405090901050704090302
Content-Type: text/plain;
 name="blk-fair-batches-24"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="blk-fair-batches-24"

--- linux-2.4/include/linux/blkdev.h.orig	2003-06-02 21:59:06.000000000 +1000
+++ linux-2.4/include/linux/blkdev.h	2003-06-02 22:39:57.000000000 +1000
@@ -118,13 +118,21 @@ struct request_queue
 	/*
 	 * Boolean that indicates whether this queue is plugged or not.
 	 */
-	char			plugged;
+	int			plugged:1;
 
 	/*
 	 * Boolean that indicates whether current_request is active or
 	 * not.
 	 */
-	char			head_active;
+	int			head_active:1;
+
+	/*
+	 * Booleans that indicate whether the queue's free requests have
+	 * been exhausted and is waiting to drop below the batch_requests
+	 * threshold
+	 */
+	int			read_full:1;
+	int			write_full:1;
 
 	unsigned long		bounce_pfn;
 
@@ -140,6 +148,30 @@ struct request_queue
 	wait_queue_head_t	wait_for_requests[2];
 };
 
+static inline void set_queue_full(request_queue_t *q, int rw)
+{
+	if (rw == READ)
+		q->read_full = 1;
+	else
+		q->write_full = 1;
+}
+
+static inline void clear_queue_full(request_queue_t *q, int rw)
+{
+	if (rw == READ)
+		q->read_full = 0;
+	else
+		q->write_full = 0;
+}
+
+static inline int queue_full(request_queue_t *q, int rw)
+{
+	if (rw == READ)
+		return q->read_full;
+	else
+		return q->write_full;
+}
+
 extern unsigned long blk_max_low_pfn, blk_max_pfn;
 
 #define BLK_BOUNCE_HIGH		(blk_max_low_pfn << PAGE_SHIFT)
--- linux-2.4/drivers/block/ll_rw_blk.c.orig	2003-06-02 21:56:54.000000000 +1000
+++ linux-2.4/drivers/block/ll_rw_blk.c	2003-06-02 22:17:13.000000000 +1000
@@ -513,7 +513,10 @@ static struct request *get_request(reque
 	struct request *rq = NULL;
 	struct request_list *rl = q->rq + rw;
 
-	if (!list_empty(&rl->free)) {
+	if (list_empty(&rl->free))
+		set_queue_full(q, rw);
+	
+	if (!queue_full(q, rw)) {
 		rq = blkdev_free_rq(&rl->free);
 		list_del(&rq->queue);
 		rl->count--;
@@ -594,7 +597,7 @@ static struct request *__get_request_wai
 	add_wait_queue_exclusive(&q->wait_for_requests[rw], &wait);
 	do {
 		set_current_state(TASK_UNINTERRUPTIBLE);
-		if (q->rq[rw].count == 0)
+		if (queue_full(q, rw))
 			schedule();
 		spin_lock_irq(&io_request_lock);
 		rq = get_request(q, rw);
@@ -829,9 +832,14 @@ void blkdev_release_request(struct reque
 	 */
 	if (q) {
 		list_add(&req->queue, &q->rq[rw].free);
-		if (++q->rq[rw].count >= q->batch_requests &&
-				waitqueue_active(&q->wait_for_requests[rw]))
-			wake_up(&q->wait_for_requests[rw]);
+		q->rq[rw].count++;
+		if (q->rq[rw].count >= q->batch_requests) {
+			if (q->rq[rw].count == q->batch_requests) 
+				clear_queue_full(q, rw);
+
+			if (waitqueue_active(&q->wait_for_requests[rw]))
+				wake_up(&q->wait_for_requests[rw]);
+		}
 	}
 }
 

--------------030405090901050704090302--

