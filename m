Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261807AbTE2BUH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 21:20:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261808AbTE2BUH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 21:20:07 -0400
Received: from adsl-67-122-203-155.dsl.snfc21.pacbell.net ([67.122.203.155]:32779
	"EHLO ext.storadinc.com") by vger.kernel.org with ESMTP
	id S261807AbTE2BUF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 21:20:05 -0400
Message-ID: <3ED5633E.3020102@storadinc.com>
Date: Wed, 28 May 2003 18:32:46 -0700
From: manish <manish@storadinc.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020408
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@digeo.com>
CC: Matthias Mueller <matthias.mueller@rz.uni-karlsruhe.de>, axboe@suse.de,
       m.c.p@wolk-project.de, kernel@kolivas.org, andrea@suse.de,
       marcelo@conectiva.com.br, linux-kernel@vger.kernel.org
Subject: Re: 2.4.20: Proccess stuck in __lock_page ...
References: <3ED2DE86.2070406@storadinc.com>	<200305281713.24357.kernel@kolivas.org>	<20030528071355.GO845@suse.de>	<200305280930.48810.m.c.p@wolk-project.de>	<20030528073544.GR845@suse.de>	<20030528005156.1fda5710.akpm@digeo.com>	<20030528101348.GA804@rz.uni-karlsruhe.de> <20030528032315.679e77b0.akpm@digeo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>Matthias Mueller <matthias.mueller@rz.uni-karlsruhe.de> wrote:
>
>>Works fine on my notebook. Good throughput and no mouse hangs anymore.
>>
>
>Interesting.
>
>Could you please work out which change caused it?  Go back to stock 2.4 and
>then apply this:
>
>
>diff -puN drivers/block/ll_rw_blk.c~1 drivers/block/ll_rw_blk.c
>--- 24/drivers/block/ll_rw_blk.c~1	2003-05-28 03:20:42.000000000 -0700
>+++ 24-akpm/drivers/block/ll_rw_blk.c	2003-05-28 03:20:57.000000000 -0700
>@@ -590,10 +590,10 @@ static struct request *__get_request_wai
> 	register struct request *rq;
> 	DECLARE_WAITQUEUE(wait, current);
> 
>-	generic_unplug_device(q);
> 	add_wait_queue_exclusive(&q->wait_for_requests[rw], &wait);
> 	do {
> 		set_current_state(TASK_UNINTERRUPTIBLE);
>+		generic_unplug_device(q);
> 		if (q->rq[rw].count == 0)
> 			schedule();
> 		spin_lock_irq(&io_request_lock);
>
>
>
>then this:
>
>diff -puN drivers/block/ll_rw_blk.c~2 drivers/block/ll_rw_blk.c
>--- 24/drivers/block/ll_rw_blk.c~2	2003-05-28 03:21:03.000000000 -0700
>+++ 24-akpm/drivers/block/ll_rw_blk.c	2003-05-28 03:21:09.000000000 -0700
>@@ -590,7 +590,7 @@ static struct request *__get_request_wai
> 	register struct request *rq;
> 	DECLARE_WAITQUEUE(wait, current);
> 
>-	add_wait_queue_exclusive(&q->wait_for_requests[rw], &wait);
>+	add_wait_queue(&q->wait_for_requests[rw], &wait);
> 	do {
> 		set_current_state(TASK_UNINTERRUPTIBLE);
> 		generic_unplug_device(q);
>
>
>Then this (totally unlikely, don't bother):
>
>diff -puN drivers/block/ll_rw_blk.c~3 drivers/block/ll_rw_blk.c
>--- 24/drivers/block/ll_rw_blk.c~3	2003-05-28 03:21:15.000000000 -0700
>+++ 24-akpm/drivers/block/ll_rw_blk.c	2003-05-28 03:21:39.000000000 -0700
>@@ -829,8 +829,7 @@ void blkdev_release_request(struct reque
> 	 */
> 	if (q) {
> 		list_add(&req->queue, &q->rq[rw].free);
>-		if (++q->rq[rw].count >= q->batch_requests &&
>-				waitqueue_active(&q->wait_for_requests[rw]))
>+		if (++q->rq[rw].count >= q->batch_requests)
> 			wake_up(&q->wait_for_requests[rw]);
> 	}
> }
>
>_
>
Hello !

I have applied patch 1+2+3 and it seemed to have solved the 
stalls/pauses that I was seeing with the stock kernel after long hrs of 
test using bonnie.

Thanks much
Manish




