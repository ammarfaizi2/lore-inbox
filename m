Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264612AbTE1IRw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 04:17:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264613AbTE1IRv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 04:17:51 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:9399 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S264612AbTE1IRt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 04:17:49 -0400
Date: Wed, 28 May 2003 10:30:28 +0200
From: Jens Axboe <axboe@suse.de>
To: Andrew Morton <akpm@digeo.com>
Cc: m.c.p@wolk-project.de, kernel@kolivas.org, manish@storadinc.com,
       andrea@suse.de, marcelo@conectiva.com.br, linux-kernel@vger.kernel.org
Subject: Re: 2.4.20: Proccess stuck in __lock_page ...
Message-ID: <20030528083028.GE845@suse.de>
References: <3ED2DE86.2070406@storadinc.com> <200305281713.24357.kernel@kolivas.org> <20030528071355.GO845@suse.de> <200305280930.48810.m.c.p@wolk-project.de> <20030528073544.GR845@suse.de> <20030528005156.1fda5710.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030528005156.1fda5710.akpm@digeo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 28 2003, Andrew Morton wrote:
> Jens Axboe <axboe@suse.de> wrote:
> >
> > > that one, the answer is YES.
> > 
> >  That's the one, yes. Andrew, looks like your patch brought out some
> >  really bad behaviour.
> 
> Yes, but why?
> 
> It'd be interesting if any of these changes make a difference.
> 
> 
>  drivers/block/ll_rw_blk.c |    7 
>  fs/buffer.c               | 3030 ++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 3033 insertions(+), 4 deletions(-)
> 
> diff -puN drivers/block/ll_rw_blk.c~a drivers/block/ll_rw_blk.c
> --- 24/drivers/block/ll_rw_blk.c~a	2003-05-28 00:48:09.000000000 -0700
> +++ 24-akpm/drivers/block/ll_rw_blk.c	2003-05-28 00:50:02.000000000 -0700
> @@ -590,10 +590,10 @@ static struct request *__get_request_wai
>  	register struct request *rq;
>  	DECLARE_WAITQUEUE(wait, current);
>  
> -	generic_unplug_device(q);
> -	add_wait_queue_exclusive(&q->wait_for_requests[rw], &wait);
> +	add_wait_queue(&q->wait_for_requests[rw], &wait);
>  	do {
>  		set_current_state(TASK_UNINTERRUPTIBLE);
> +		generic_unplug_device(q);
>  		if (q->rq[rw].count == 0)
>  			schedule();
>  		spin_lock_irq(&io_request_lock);
> @@ -829,8 +829,7 @@ void blkdev_release_request(struct reque
>  	 */
>  	if (q) {
>  		list_add(&req->queue, &q->rq[rw].free);
> -		if (++q->rq[rw].count >= q->batch_requests &&
> -				waitqueue_active(&q->wait_for_requests[rw]))
> +		if (++q->rq[rw].count >= q->batch_requests)
>  			wake_up(&q->wait_for_requests[rw]);
>  	}
>  }

The unplug() move could be the key, in theory we could end up having to
unplug the queue again.

Question to the ones seeing the stalls - does a sysrq-s make things go
again?

-- 
Jens Axboe

