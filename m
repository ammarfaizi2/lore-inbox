Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261191AbUCHUgE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Mar 2004 15:36:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261205AbUCHUgE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Mar 2004 15:36:04 -0500
Received: from ztxmail03.ztx.compaq.com ([161.114.1.207]:59909 "EHLO
	ztxmail03.ztx.compaq.com") by vger.kernel.org with ESMTP
	id S261191AbUCHUfD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Mar 2004 15:35:03 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.0.6529.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: cciss per device queue patch for 2.6.4
Date: Mon, 8 Mar 2004 14:35:00 -0600
Message-ID: <D4CFB69C345C394284E4B78B876C1CF105BC1EA6@cceexc23.americas.cpqcorp.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: cciss per device queue patch for 2.6.4
Thread-Index: AcQFRhW40EfNoweaQAqsa9XcJppw3AABrGEw
From: "Miller, Mike (OS Dev)" <mike.miller@hp.com>
To: "Jens Axboe" <axboe@suse.de>
Cc: <apkm@osdl.org>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 08 Mar 2004 20:35:01.0375 (UTC) FILETIME=[D47BC0F0:01C4054C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks, Jens. I'll fix it & resubmit.

-----Original Message-----
From: Jens Axboe [mailto:axboe@suse.de]
Sent: Monday, March 08, 2004 1:46 PM
To: Miller, Mike (OS Dev)
Cc: apkm@osdl.org; linux-kernel@vger.kernel.org
Subject: Re: cciss per device queue patch for 2.6.4


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

