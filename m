Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263163AbUEGJjg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263163AbUEGJjg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 May 2004 05:39:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263252AbUEGJjg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 May 2004 05:39:36 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:45255 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S263163AbUEGJjc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 May 2004 05:39:32 -0400
Date: Fri, 7 May 2004 11:39:21 +0200
From: Jens Axboe <axboe@suse.de>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Cc: "'Andrew Morton'" <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: Cache queue_congestion_on/off_threshold
Message-ID: <20040507093921.GD21109@suse.de>
References: <20040505233426.704926da.akpm@osdl.org> <200405062029.i46KT5F13603@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200405062029.i46KT5F13603@unix-os.sc.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 06 2004, Chen, Kenneth W wrote:
> >>>> Andrew Morton wrote on Wednesday, May 05, 2004 11:34 PM
> > Jens Axboe <axboe@suse.de> wrote:
> > >
> > > Do you have any numbers at all for this? I'd say these calculations are
> > >  severly into the noise area when submitting io.
> >
> > The difference will not be measurable, but I think the patch makes sense
> > regardless of what the numbers say.
> 
> Even though it is in the noise range that can't be easily measured, they are
> indeed in the positive territory.  If I stack 5 of these little things, we
> actually measured positive gain on a large db workload.

I somehow still find that very hard to believe, it's a branch and a
couple of cycles.

> There isn't anything absurd in 2.6 kernel, however, I hate to say that we
> consistently see performance regression with latest 2.6 kernel compare to
> best 2.4 based kernel under heavy db workload on 4-way SMP platform. (2.6
> rocks on numa platform that 2.4 doesn't even have a chance to compete).
> 
> Some of the examples are:
> 
> (1) it's cheaper to find out whether a queue is empty or not by calling
>     elv_queue_empty() instead of using heavier elv_next_request().
> (2) it's better to check queue empty before calling into q->request_fn()
> 
> 
> diff -Nurp linux-2.6.6-rc3/drivers/block/ll_rw_blk.c linux-2.6.6-rc3.ken/drivers/block/ll_rw_blk.c
> --- linux-2.6.6-rc3/drivers/block/ll_rw_blk.c	2004-05-06 13:03:14.000000000 -0700
> +++ linux-2.6.6-rc3.ken/drivers/block/ll_rw_blk.c	2004-05-06 13:04:04.000000000 -0700
> @@ -1128,7 +1128,7 @@ static inline void __generic_unplug_devi
>  	/*
>  	 * was plugged, fire request_fn if queue has stuff to do
>  	 */
> -	if (elv_next_request(q))
> +	if (!elv_queue_empty(q))
>  		q->request_fn(q);
>  }
> 
> @@ -1237,7 +1237,8 @@ void blk_run_queue(struct request_queue
> 
>  	spin_lock_irqsave(q->queue_lock, flags);
>  	blk_remove_plug(q);
> -	q->request_fn(q);
> +	if (!elv_queue_empty(q))
> +		q->request_fn(q);
>  	spin_unlock_irqrestore(q->queue_lock, flags);
>  }

This looks great, should be merged right away.

> (3) can we allocate request structure up front in __make_request?
>     For I/O that cannot be merged, the elevator code executes twice
>     in __make_request.
> 
> 
> diff -Nurp linux-2.6.6-rc3/drivers/block/ll_rw_blk.c linux-2.6.6-rc3.ken/drivers/block/ll_rw_blk.c
> --- linux-2.6.6-rc3/drivers/block/ll_rw_blk.c	2004-05-06 13:03:14.000000000 -0700
> +++ linux-2.6.6-rc3.ken/drivers/block/ll_rw_blk.c	2004-05-06 13:11:39.000000000 -0700
> @@ -2154,15 +2154,14 @@ static int __make_request(request_queue_
> 
>  	ra = bio->bi_rw & (1 << BIO_RW_AHEAD);
> 
> +	/* Grab a free request from the freelist */
> +	freereq = get_request(q, rw, GFP_ATOMIC);
> +
>  again:
>  	spin_lock_irq(q->queue_lock);
> 
> -	if (elv_queue_empty(q)) {
> +	if (elv_queue_empty(q))
>  		blk_plug_device(q);
> -		goto get_rq;
> -	}
> -	if (barrier)
> -		goto get_rq;
> 
>  	el_ret = elv_merge(q, &req, bio);
>  	switch (el_ret) {

Actually, with the good working batching we might get away with killing
freereq completely. Have you tested that (if not, could you?)

> Some more, I will post in another thread.

Can you please remember to cc in initial posts as well, I don't want to
always hunt for your findings. Thanks.

-- 
Jens Axboe

