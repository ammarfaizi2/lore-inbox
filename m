Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264871AbTFLPxy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 11:53:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264872AbTFLPxy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 11:53:54 -0400
Received: from 216-42-72-151.ppp.netsville.net ([216.42.72.151]:24247 "EHLO
	tiny.suse.com") by vger.kernel.org with ESMTP id S264871AbTFLPxp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 11:53:45 -0400
Subject: Re: [PATCH] io stalls
From: Chris Mason <mason@suse.com>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: Andrea Arcangeli <andrea@suse.de>,
       Marc-Christian Petersen <m.c.p@wolk-project.de>,
       Jens Axboe <axboe@suse.de>, Marcelo Tosatti <marcelo@conectiva.com.br>,
       Georg Nikodym <georgn@somanetworks.com>,
       lkml <linux-kernel@vger.kernel.org>,
       Matthias Mueller <matthias.mueller@rz.uni-karlsruhe.de>
In-Reply-To: <3EE7F18C.3010502@cyberone.com.au>
References: <1055356032.24111.240.camel@tiny.suse.com>
	 <20030611183503.GY26270@dualathlon.random> <3EE7D1AA.30701@cyberone.com.au>
	 <20030612012951.GG1500@dualathlon.random>
	 <1055384547.24111.322.camel@tiny.suse.com> <3EE7E876.80808@cyberone.com.au>
	 <20030612024608.GE1415@dualathlon.random>
	 <3EE7EA4A.5030105@cyberone.com.au>
	 <20030612025812.GF1415@dualathlon.random> <3EE7EDBB.70608@cyberone.com.au>
	 <20030612031238.GA1571@dualathlon.random>
	 <3EE7F18C.3010502@cyberone.com.au>
Content-Type: multipart/mixed; boundary="=-JrtCRp21kIF7zYZcn0nB"
Organization: 
Message-Id: <1055434002.23697.431.camel@tiny.suse.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 12 Jun 2003 12:06:43 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-JrtCRp21kIF7zYZcn0nB
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, 2003-06-11 at 23:20, Nick Piggin wrote:

> 
> I think the cpu utilization gain of waking a number of tasks
> at once would be outweighed by advantage of waking 1 task
> and not putting it to sleep again for a number of requests.
> You obviously are not claiming concurrency improvements, as
> your method would also increase contention on the io lock
> (or the queue lock in 2.5).

I've been trying variations on this for a few days, none have been
thrilling but the end result is better dbench and iozone throughput
overall.  For the 20 writer iozone test, rc7 got an average throughput
of 3MB/s, and yesterdays latency patch got 500k/s or so.  Ouch.

This gets us up to 1.2MB/s.  I'm keeping yesterday's
get_request_wait_wake, which wakes up a waiter instead of unplugging.

The basic idea here is that after a process is woken up and grabs a
request, he becomes the batch owner.  Batch owners get to ignore the
q->full flag for either 1/5 second or 32 requests, whichever comes
first.  The timer part is an attempt at preventing memory pressure
writers (who go 1 req at a time) from holding onto batch ownership for
too long.  Latency stats after dbench 50:

device 08:01: num_req 120077, total jiffies waited 663231
        65538 forced to wait
        1 min wait, 175 max wait
        10 average wait
        65296 < 100, 242 < 200, 0 < 300, 0 < 400, 0 < 500
        0 waits longer than 500 jiffies

Good latency system wide comes from fair waiting, but it also comes from
how fast we can run write_some_buffers(), since that is the unit of
throttling.  Hopefully this patch decreases the time it takes for
write_some_buffers over the past latency patches, or gives someone else
a better idea ;-)

Attached is an incremental over yesterday's io-stalls-5.diff.

-chris


--=-JrtCRp21kIF7zYZcn0nB
Content-Disposition: attachment; filename=io-stalls-6-inc.diff
Content-Type: text/plain; name=io-stalls-6-inc.diff; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

diff -u edited/drivers/block/ll_rw_blk.c edited/drivers/block/ll_rw_blk.c
--- edited/drivers/block/ll_rw_blk.c	Wed Jun 11 13:36:10 2003
+++ edited/drivers/block/ll_rw_blk.c	Thu Jun 12 11:53:03 2003
@@ -437,6 +437,12 @@
 	nr_requests = 128;
 	if (megs < 32)
 		nr_requests /= 2;
+	q->batch_owner[0] = NULL;
+	q->batch_owner[1] = NULL;
+	q->batch_remaining[0] = 0;
+	q->batch_remaining[1] = 0;
+	q->batch_jiffies[0] = 0;
+	q->batch_jiffies[1] = 0;
 	blk_grow_request_list(q, nr_requests);
 
 	init_waitqueue_head(&q->wait_for_requests[0]);
@@ -558,6 +564,31 @@
 	blk_queue_bounce_limit(q, BLK_BOUNCE_HIGH);
 }
 
+#define BATCH_JIFFIES (HZ/5)
+static void check_batch_owner(request_queue_t *q, int rw)
+{
+	if (q->batch_owner[rw] != current)
+		return;
+	if (--q->batch_remaining[rw] > 0 && 
+	    jiffies - q->batch_jiffies[rw] < BATCH_JIFFIES) {
+		return;
+	}
+	q->batch_owner[rw] = NULL;
+}
+
+static void set_batch_owner(request_queue_t *q, int rw)
+{
+	struct task_struct *tsk = current;
+	if (q->batch_owner[rw] == tsk)
+		return;
+	if (q->batch_owner[rw] && 
+	    jiffies - q->batch_jiffies[rw] < BATCH_JIFFIES)
+		return;
+	q->batch_jiffies[rw] = jiffies;
+	q->batch_owner[rw] = current;
+	q->batch_remaining[rw] = q->batch_requests;
+}
+
 #define blkdev_free_rq(list) list_entry((list)->next, struct request, queue);
 /*
  * Get a free request. io_request_lock must be held and interrupts
@@ -587,9 +618,13 @@
  */
 static inline struct request *get_request(request_queue_t *q, int rw)
 {
-	if (queue_full(q, rw))
+	struct request *rq;
+	if (queue_full(q, rw) && q->batch_owner[rw] != current)
 		return NULL;
-	return __get_request(q, rw);
+	rq = __get_request(q, rw);
+	if (rq)
+		check_batch_owner(q, rw);
+	return rq;
 }
 
 /* 
@@ -657,9 +692,9 @@
 
 	add_wait_queue_exclusive(&q->wait_for_requests[rw], &wait);
 
+	spin_lock_irq(&io_request_lock);
 	do {
 		set_current_state(TASK_UNINTERRUPTIBLE);
-		spin_lock_irq(&io_request_lock);
 		if (queue_full(q, rw) || q->rq[rw].count == 0) {
 			if (q->rq[rw].count == 0)
 				__generic_unplug_device(q);
@@ -668,8 +703,9 @@
 			spin_lock_irq(&io_request_lock);
 		}
 		rq = __get_request(q, rw);
-		spin_unlock_irq(&io_request_lock);
 	} while (rq == NULL);
+	set_batch_owner(q, rw);
+	spin_unlock_irq(&io_request_lock);
 	remove_wait_queue(&q->wait_for_requests[rw], &wait);
 	current->state = TASK_RUNNING;
 
@@ -1010,6 +1046,7 @@
 	struct list_head *head, *insert_here;
 	int latency;
 	elevator_t *elevator = &q->elevator;
+	int need_unplug = 0;
 
 	count = bh->b_size >> 9;
 	sector = bh->b_rsector;
@@ -1145,8 +1182,8 @@
 				spin_unlock_irq(&io_request_lock);
 				freereq = __get_request_wait(q, rw);
 				head = &q->queue_head;
+				need_unplug = 1;
 				spin_lock_irq(&io_request_lock);
-				get_request_wait_wakeup(q, rw);
 				goto again;
 			}
 		}
@@ -1174,6 +1211,8 @@
 out:
 	if (freereq)
 		blkdev_release_request(freereq);
+	if (need_unplug)
+		get_request_wait_wakeup(q, rw);
 	spin_unlock_irq(&io_request_lock);
 	return 0;
 end_io:
diff -u edited/include/linux/blkdev.h edited/include/linux/blkdev.h
--- edited/include/linux/blkdev.h	Wed Jun 11 09:56:55 2003
+++ edited/include/linux/blkdev.h	Thu Jun 12 09:44:26 2003
@@ -92,6 +92,10 @@
 	 */
 	int batch_requests;
 
+	struct task_struct *batch_owner[2];
+	int		    batch_remaining[2];
+	unsigned long       batch_jiffies[2];
+
 	/*
 	 * Together with queue_head for cacheline sharing
 	 */

--=-JrtCRp21kIF7zYZcn0nB--

