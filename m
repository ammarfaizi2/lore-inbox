Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263250AbTFDLpt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 07:45:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263258AbTFDLpt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 07:45:49 -0400
Received: from [203.221.72.3] ([203.221.72.3]:48905 "EHLO chimp.local.net")
	by vger.kernel.org with ESMTP id S263250AbTFDLpp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 07:45:45 -0400
Message-ID: <3EDDDEBB.4080209@cyberone.com.au>
Date: Wed, 04 Jun 2003 21:57:47 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030327 Debian/1.3-4
X-Accept-Language: en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
CC: Marc-Christian Petersen <m.c.p@wolk-project.de>,
       Jens Axboe <axboe@suse.de>, Marcelo Tosatti <marcelo@conectiva.com.br>,
       Georg Nikodym <georgn@somanetworks.com>,
       lkml <linux-kernel@vger.kernel.org>,
       Matthias Mueller <matthias.mueller@rz.uni-karlsruhe.de>
Subject: Re: -rc7   Re: Linux 2.4.21-rc6
References: <Pine.LNX.4.55L.0305282019160.321@freak.distro.conectiva> <200306041235.07832.m.c.p@wolk-project.de> <20030604104215.GN4853@suse.de> <200306041246.21636.m.c.p@wolk-project.de> <20030604104825.GR3412@x30.school.suse.de>
In-Reply-To: <20030604104825.GR3412@x30.school.suse.de>
Content-Type: multipart/mixed;
 boundary="------------020101040903050006080906"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020101040903050006080906
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Andrea Arcangeli wrote:

>On Wed, Jun 04, 2003 at 12:46:33PM +0200, Marc-Christian Petersen wrote:
>
>>On Wednesday 04 June 2003 12:42, Jens Axboe wrote:
>>
>>Hi Jens,
>>
>>
>>>>>the issue with batching in 2.4, is that it is blocking at 0 and waking
>>>>>at batch_requests. But it's not blocking new get_request to eat
>>>>>requests in the way back from 0 to batch_requests. I mean, there are
>>>>>two directions, when we move from batch_requests to 0 get_requests
>>>>>should return requests. in the way back from 0 to batch_requests the
>>>>>get_request should block (and it doesn't in 2.4, that is the problem)
>>>>>
>>>>do you see a chance to fix this up in 2.4?
>>>>
>>>Nick posted a patch to do so the other day and asked people to test.
>>>
>>Silly mcp. His mail was CC'ed to me :( ... F*ck huge inbox.
>>
>
>I was probably not CC'ed, I'll search for the email (and I was
>travelling the last few days so I didn't read every single l-k email yet
>sorry ;)
>
>
The patch I sent is actually against 2.4.20, contrary to my
babling. Reports I have had say it helps, but maybe not so
much as Andrew'ss fixes. Then Matthias Mueller ported my patch
to 2.4.21-rc6 which include Andrew's fixes.

It seems that they might be fixing two different problems.
It looks promising though.

My patch would not affect read IO throughput for a smallish
number of readers because the queue should never fill up.
 > 1 writer or a lot of readers could see some throughput
drop due to the patch causing the queue to be more FIFO
at high loads.

I have attached the patch again. Its against 2.4.20.

Nick

Matthias Mueller wrote:

>Currently I'm running 2.4.21-rc6 with your patch and the patch from Andrew 
>and it looks very promising.  Both patches seem to address two different 
>problems, combined I can have 2 parallel dds running and play music with 
>xmms and notice no sounddrops (actually i had one, but that was during 
>very high cpu load). Your patch seems to lower IO-throughput, but I 
>haven't tested this, so no real numbers, just my personal feelings and 
>the numbers 'time dd ...' gave me.
>  
>


--------------020101040903050006080906
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
 

--------------020101040903050006080906--

