Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267416AbUIATgW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267416AbUIATgW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 15:36:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267424AbUIATgW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 15:36:22 -0400
Received: from mx1.redhat.com ([66.187.233.31]:38876 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267416AbUIATgN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 15:36:13 -0400
Date: Wed, 1 Sep 2004 14:57:34 +0200
From: Arjan van de Ven <arjanv@redhat.com>
To: akpm@osdl.org, axboe@suse.de
Subject: block fixes
Message-ID: <20040901125734.GA32130@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I was investigating a report of suboptimal performance on a FC device and
saw indeed something odd; during a heavy write period the device often had
32 IO's active (32 was the tcq limit) but every few seconds that suddenly
started to go down and only got back to 32 after hitting 0.

After looking through ll_rw_blk I noticed 3 things that I fixed with the
patch below:

1) the hysteresis for the queue congestion was a whopping 2 (!!) requests no
   matter how many requests the max was; I changed it to be an additional
   1/16th of the number of requests so that it scales with the size somewhat
   and to have a more useful hysteresis

2) freed_request() had an oddity where the queue full flag only got cleared
   if there are no waiters (after just waking up the waiters). This seems to
   be race prone and might have led to a "stuck" full bit. The first one to
   get a request struct that makes the queue really full again sets the bit
   again anyway

3) In get_request_wait() there was code like this:
                       ioc = get_io_context(GFP_NOIO);
                       ioc_set_batching(ioc);
                       put_io_context(ioc);
the problem with this code *inside the inner loop* is that put_io_context
happily will free the io context again so the batching bit just gets lost
for the next iteration. Moving this outside the loop fixes that.

With these patches I no longer see the dips in active IO count.

Comments?


Greetings,
    Arjan van de Ven

diff -purN linux-2.6.8/drivers/block.org/ll_rw_blk.c linux-2.6.8/drivers/block/ll_rw_blk.c
--- linux-2.6.8/drivers/block.org/ll_rw_blk.c	2004-09-01 14:02:50.364416000 +0200
+++ linux-2.6.8/drivers/block/ll_rw_blk.c	2004-09-01 14:09:56.039551972 +0200
@@ -100,7 +100,7 @@ static void blk_queue_congestion_thresho
 		nr = q->nr_requests;
 	q->nr_congestion_on = nr;
 
-	nr = q->nr_requests - (q->nr_requests / 8) - 1;
+	nr = q->nr_requests - (q->nr_requests / 8) - (q->nr_requests/16)- 1;
 	if (nr < 1)
 		nr = 1;
 	q->nr_congestion_off = nr;
@@ -1645,8 +1645,7 @@ static void freed_request(request_queue_
 	if (rl->count[rw]+1 <= q->nr_requests) {
 		if (waitqueue_active(&rl->wait[rw]))
 			wake_up(&rl->wait[rw]);
-		if (!waitqueue_active(&rl->wait[rw]))
-			blk_clear_queue_full(q, rw);
+		blk_clear_queue_full(q, rw);
 	}
 }
 
@@ -1741,8 +1740,10 @@ static struct request *get_request_wait(
 {
 	DEFINE_WAIT(wait);
 	struct request *rq;
+	struct io_context *ioc;
 
 	generic_unplug_device(q);
+	ioc = get_io_context(GFP_NOIO);
 	do {
 		struct request_list *rl = &q->rq;
 
@@ -1752,7 +1753,6 @@ static struct request *get_request_wait(
 		rq = get_request(q, rw, GFP_NOIO);
 
 		if (!rq) {
-			struct io_context *ioc;
 
 			io_schedule();
 
@@ -1762,12 +1762,11 @@ static struct request *get_request_wait(
 			 * up to a big batch of them for a small period time.
 			 * See ioc_batching, ioc_set_batching
 			 */
-			ioc = get_io_context(GFP_NOIO);
 			ioc_set_batching(ioc);
-			put_io_context(ioc);
 		}
 		finish_wait(&rl->wait[rw], &wait);
 	} while (!rq);
+	put_io_context(ioc);
 
 	return rq;
 }
