Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265413AbSKPERM>; Fri, 15 Nov 2002 23:17:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267215AbSKPERM>; Fri, 15 Nov 2002 23:17:12 -0500
Received: from dialup346.canberra.net.au ([203.33.188.218]:35588 "EHLO
	chimp.local.net") by vger.kernel.org with ESMTP id <S265413AbSKPERJ>;
	Fri, 15 Nov 2002 23:17:09 -0500
Message-ID: <3DD5C86C.70903@cyberone.com.au>
Date: Sat, 16 Nov 2002 15:24:12 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020913 Debian/1.1-1
MIME-Version: 1.0
To: Andrew Morton <akpm@digeo.com>
CC: Con Kolivas <conman@kolivas.net>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Jens Axboe <axboe@suse.de>
Subject: Re: [BENCHMARK] 2.5.47-mm3 with contest
References: <200211161422.17438.conman@kolivas.net> <3DD5BBD9.7DA70FFF@digeo.com>
Content-Type: multipart/mixed;
 boundary="------------000301060002040306030705"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000301060002040306030705
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Andrew Morton wrote:

>Con Kolivas wrote:
>
>>Note the significant discrepancy between mm1 and mm3. This reminds me of what
>>happened last time I enabled shared 3rd level pagetables - Andrew do you want
>>me to do a set of numbers with this disabled?
>>
>
>That certainly couldn't hurt.  But your tests are, in general, tesging
>the IO scheduler.  And the IO scheduler has changed radically in each
>of the recent -mm's.
>
>So testing with rbtree-iosched reverted would really be the only way
>to draw comparisons on how the rest of the code is behaving.
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>
Andrew there is, in fact a problem with the io scheduler in mm3 as far
as I can see. Jens is away 'till Monday so he hasn't confirmed this yet.
Basically if the device can't get through the entire queue within the
read|write_expire timeout, they will start being submitted in fifo order
slowing down the device more (probably) and contributing to the problem.
It may be causing the bad numbers in contest. Here is a patch which
relieves the problem for loads I am testing (bench.c, tiobench).

Con, it would be nice if you could try this, if you value your disk,
maybe you could wait for Jens to get back!

Regards,
Nick Piggin

--------------000301060002040306030705
Content-Type: text/plain;
 name="deadline.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="deadline.patch"

--- linux-2.5/drivers/block/deadline-iosched.c.orig	2002-11-15 23:22:19.000000000 +1100
+++ linux-2.5/drivers/block/deadline-iosched.c	2002-11-16 13:01:01.000000000 +1100
@@ -407,20 +407,46 @@
 	if (rbnext)
 		dd->last_drq[data_dir] = rb_entry_drq(rbnext);
 	
 	/*
 	 * take it off the sort and fifo list, move
 	 * to dispatch queue
 	 */
 	deadline_move_to_dispatch(dd, drq);
 }
 
+static int expire_batch = 8;
+/*
+ * move a batch of entries to dispatch queue
+ */
+static inline void deadline_move_batch(struct deadline_data *dd, struct deadline_rq *drq)
+{
+	const int data_dir = rq_data_dir(drq->request);
+	struct rb_node *rbnext;
+	int i;
+	
+	for (i = 0; i < expire_batch; i++) {
+		struct rb_node *rbnext;
+		rbnext = rb_next(&drq->rb_node);
+		
+		deadline_move_to_dispatch(dd, drq);
+
+		if (!rbnext)
+			break;
+		drq = rb_entry_drq(rbnext);
+	}
+
+	dd->last_drq[data_dir] = NULL;
+	if (rbnext)
+		dd->last_drq[data_dir] = drq;
+}
+
 /*
  * returns 0 if there are no expired reads on the fifo, 1 otherwise
  */
 #define list_entry_fifo(ptr)	list_entry((ptr), struct deadline_rq, fifo)
 static inline int deadline_check_fifo(struct deadline_data *dd, int ddir)
 {
 	if (!list_empty(&dd->rw_fifo[ddir])) {
 		struct deadline_rq *drq = list_entry_fifo(dd->rw_fifo[ddir].next);
 
 		/*
@@ -439,56 +465,74 @@
 	struct deadline_rq *drq;
 
 	/*
 	 * if we have expired entries on the fifo list, move some to dispatch
 	 */
 	if (deadline_check_fifo(dd, READ)) {
 		if (writes && (dd->starved++ >= dd->writes_starved))
 			goto dispatch_writes;
 
 		drq = list_entry_fifo(dd->rw_fifo[READ].next);
-dispatch_requests:
-		deadline_move_request(dd, drq);
-		return 1;
+
+		goto dispatch_batch;
 	}
 
 	if (!list_empty(&dd->rw_fifo[READ])) {
 		if (writes && (dd->starved++ >= dd->writes_starved))
 			goto dispatch_writes;
 
 		BUG_ON(RB_EMPTY(&dd->rb_list[READ]));
 
 		drq = dd->last_drq[READ];
 		if (!drq)
 			drq = list_entry_fifo(dd->rw_fifo[READ].next);
 
-		goto dispatch_requests;
+		goto dispatch_request;
 	}
 
 	/*
 	 * either there are no reads expired or on sort list, or the reads
 	 * have starved writes for too long. dispatch some writes
 	 */
+	
 	if (writes) {
 dispatch_writes:
 		BUG_ON(RB_EMPTY(&dd->rb_list[WRITE]));
 
 		dd->starved = 0;
+		
+		if (deadline_check_fifo(dd, WRITE)) {
+			drq = list_entry_fifo(dd->rw_fifo[WRITE].next);
+
+			goto dispatch_batch;
+		}
 
 		drq = dd->last_drq[WRITE];
-		if (!drq || deadline_check_fifo(dd, WRITE))
+		if (!drq) 
 			drq = list_entry_fifo(dd->rw_fifo[WRITE].next);
 
-		goto dispatch_requests;
+		goto dispatch_request;
 	}
 
 	return 0;
+	
+dispatch_request:
+	deadline_move_request(dd, drq);
+	return 1;
+	
+dispatch_batch:
+	/* dispatch in batches to prevent a seek storm if the disk
+	 * can't keep up with the queue size and all entries end up
+	 * being expired and submitted fifo.
+	 */
+	deadline_move_batch(dd, drq);
+	return 1;
 }
 
 static struct request *deadline_next_request(request_queue_t *q)
 {
 	struct deadline_data *dd = q->elevator.elevator_data;
 	struct request *rq;
 
 	/*
 	 * if there are still requests on the dispatch queue, grab the first one
 	 */

--------------000301060002040306030705--

