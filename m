Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261304AbVC2TCo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261304AbVC2TCo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 14:02:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261301AbVC2TCo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 14:02:44 -0500
Received: from fmr23.intel.com ([143.183.121.15]:182 "EHLO
	scsfmr003.sc.intel.com") by vger.kernel.org with ESMTP
	id S261308AbVC2TCV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 14:02:21 -0500
Message-Id: <200503291902.j2TJ2Dg00724@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Nick Piggin'" <nickpiggin@yahoo.com.au>, "Jens Axboe" <axboe@suse.de>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: [patch] use cheaper elv_queue_empty when unplug a device
Date: Tue, 29 Mar 2005 11:02:13 -0800
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcU0QH4Mpsv7gCQiRQ2gizKKxhPPswAT8Bgg
In-Reply-To: <42491DBE.6020303@yahoo.com.au>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote on Tuesday, March 29, 2005 1:20 AM
> Speaking of which, I've had a few ideas lying around for possible
> performance improvement in the block code.
>
> I haven't used a big disk array (or tried any simulation), but I'll
> attach the patch if you're looking into that area.
>
>  linux-2.6-npiggin/drivers/block/ll_rw_blk.c |   63 ++++++++++------------------
>  1 files changed, 23 insertions(+), 40 deletions(-)
>
> diff -puN drivers/block/ll_rw_blk.c~blk-efficient drivers/block/ll_rw_blk.c
> --- linux-2.6/drivers/block/ll_rw_blk.c~blk-efficient	2005-03-29 19:00:07.000000000 +1000
> +++ linux-2.6-npiggin/drivers/block/ll_rw_blk.c	2005-03-29 19:10:45.000000000 +1000
> @@ -2557,7 +2557,7 @@ EXPORT_SYMBOL(__blk_attempt_remerge);
>
>  static int __make_request(request_queue_t *q, struct bio *bio)
>  {
> -	struct request *req, *freereq = NULL;
> +	struct request *req;
>  	int el_ret, rw, nr_sectors, cur_nr_sectors, barrier, err;
>  	sector_t sector;
>
> @@ -2577,19 +2577,18 @@ static int __make_request(request_queue_
>
> -again:
>  	spin_lock_irq(q->queue_lock);
>
>  	if (elv_queue_empty(q)) {
>

....

> +get_rq:
>  	/*
> -	 * Grab a free request from the freelist - if that is empty, check
> -	 * if we are doing read ahead and abort instead of blocking for
> -	 * a free slot.
> +	 * Grab a free request. This is might sleep but can not fail.
> +	 */
> +	spin_unlock_irq(q->queue_lock);
> +	req = get_request_wait(q, rw);
> +	/*
> +	 * After dropping the lock and possibly sleeping here, our request
> +	 * may now be mergeable after it had proven unmergeable (above).
> +	 * We don't worry about that case for efficiency. It won't happen
> +	 * often, and the elevators are able to handle it.
>  	 */
> -get_rq:
> -	if (freereq) {
> -		req = freereq;
> -		freereq = NULL;
> -	} else {
> -		spin_unlock_irq(q->queue_lock);
> -		if ((freereq = get_request(q, rw, GFP_ATOMIC)) == NULL) {
> -			/*
> -			 * READA bit set
> -			 */
> -			err = -EWOULDBLOCK;
> -			if (bio_rw_ahead(bio))
> -				goto end_io;
> -
> -			freereq = get_request_wait(q, rw);
> -		}
> -		goto again;
> -	}
>
>  	req->flags |= REQ_CMD;
>

....

> @@ -2693,10 +2675,11 @@ get_rq:
>  	req->rq_disk = bio->bi_bdev->bd_disk;
>  	req->start_time = jiffies;
>
> +	spin_lock_irq(q->queue_lock);
> +	if (elv_queue_empty(q))
> +		blk_plug_device(q);
>  	add_request(q, req);
>  out:
> -	if (freereq)
> -		__blk_put_request(q, freereq);
>  	if (bio_sync(bio))
>  		__generic_unplug_device(q);

This part of change in __make_request() is very welcome for enterprise workload.
I have an unpublished version of patch does something similar.  I will look through
all other changes in your patch.


