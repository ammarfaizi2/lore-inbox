Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262190AbVC2NQF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262190AbVC2NQF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 08:16:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262262AbVC2NQF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 08:16:05 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:6564 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262190AbVC2NP5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 08:15:57 -0500
Date: Tue, 29 Mar 2005 15:15:51 +0200
From: Jens Axboe <axboe@suse.de>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: "Chen, Kenneth W" <kenneth.w.chen@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [patch] use cheaper elv_queue_empty when unplug a device
Message-ID: <20050329131549.GV16636@suse.de>
References: <200503290253.j2T2rqg25691@unix-os.sc.intel.com> <20050329080646.GE16636@suse.de> <42491DBE.6020303@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42491DBE.6020303@yahoo.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 29 2005, Nick Piggin wrote:
> @@ -2577,19 +2577,18 @@ static int __make_request(request_queue_
>  	spin_lock_prefetch(q->queue_lock);
>  
>  	barrier = bio_barrier(bio);
> -	if (barrier && (q->ordered == QUEUE_ORDERED_NONE)) {
> +	if (unlikely(barrier) && (q->ordered == QUEUE_ORDERED_NONE)) {
>  		err = -EOPNOTSUPP;
>  		goto end_io;
>  	}
>  
> -again:
>  	spin_lock_irq(q->queue_lock);
>  
>  	if (elv_queue_empty(q)) {
>  		blk_plug_device(q);
>  		goto get_rq;
>  	}

This should just goto get_rq, the plug should happen only at the end
where you did add it:

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
>  

-- 
Jens Axboe

