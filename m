Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261166AbUCHTq6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Mar 2004 14:46:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261168AbUCHTqp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Mar 2004 14:46:45 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:50089 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261166AbUCHTqi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Mar 2004 14:46:38 -0500
Date: Mon, 8 Mar 2004 20:46:23 +0100
From: Jens Axboe <axboe@suse.de>
To: mike.miller@hp.com
Cc: apkm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: cciss per device queue patch for 2.6.4
Message-ID: <20040308194623.GI23525@suse.de>
References: <20040308194957.GA18954@beardog.cca.cpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040308194957.GA18954@beardog.cca.cpqcorp.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 08 2004, mikem@beardog.cca.cpqcorp.net wrote:
>  	/*
>  	 * See if we can queue up some more IO
> +	 * check every disk that exists on this controller 
> +	 * and start it's IO
>  	 */
> -	blk_start_queue(h->queue);
> +	for(j=0;j < NWD; j++) {
> +		/* make sure the disk has been added and the drive is real */
> +		/* because this can be called from the middle of init_one */
> +		if(!(h->gendisk[j]->queue) || !(h->drv[j].nr_blocks) )
> +			continue;
> +		blk_start_queue(h->gendisk[j]->queue);
> +	}
>  	spin_unlock_irqrestore(CCISS_LOCK(h->ctlr), flags);
>  	return IRQ_HANDLED;

You can't do this, you must hold the specific queue lock for calling
blk_start_queue() for it. The comment for that functions states that,
too. It's even more important now that blk_start_queue() actually works
properly (included).

===== drivers/block/ll_rw_blk.c 1.228 vs edited =====
--- 1.228/drivers/block/ll_rw_blk.c	Sun Feb  1 19:09:12 2004
+++ edited/drivers/block/ll_rw_blk.c	Mon Mar  8 20:41:21 2004
@@ -1188,13 +1193,23 @@
  * Description:
  *   blk_start_queue() will clear the stop flag on the queue, and call
  *   the request_fn for the queue if it was in a stopped state when
- *   entered. Also see blk_stop_queue(). Must not be called from driver
- *   request function due to recursion issues. Queue lock must be held.
+ *   entered. Also see blk_stop_queue(). Queue lock must be held.
  **/
 void blk_start_queue(request_queue_t *q)
 {
 	clear_bit(QUEUE_FLAG_STOPPED, &q->queue_flags);
-	schedule_work(&q->unplug_work);
+
+	/*
+	 * one level of recursion is ok and is much faster than kicking
+	 * the unplug handling
+	 */
+	if (!test_and_set_bit(QUEUE_FLAG_REENTER, &q->queue_flags)) {
+		q->request_fn(q);
+		clear_bit(QUEUE_FLAG_REENTER, &q->queue_flags);
+	} else {
+		blk_plug_device(q);
+		schedule_work(&q->unplug_work);
+	}
 }
 
 EXPORT_SYMBOL(blk_start_queue);


-- 
Jens Axboe

