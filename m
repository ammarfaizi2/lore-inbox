Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932423AbVHaHbW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932423AbVHaHbW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 03:31:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932454AbVHaHbW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 03:31:22 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:61880 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S932423AbVHaHbV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 03:31:21 -0400
Date: Wed, 31 Aug 2005 09:31:27 +0200
From: Jens Axboe <axboe@suse.de>
To: Nathan Scott <nathans@sgi.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] blk queue io tracing support
Message-ID: <20050831073126.GH4018@suse.de>
References: <20050823123235.GG16461@suse.de> <20050824010346.GA1021@frodo> <20050824070809.GA27956@suse.de> <20050824171931.H4209301@wobbly.melbourne.sgi.com> <20050824072501.GA27992@suse.de> <20050824092838.GB28272@suse.de> <20050830234359.GE780@frodo>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050830234359.GE780@frodo>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 31 2005, Nathan Scott wrote:
> Hi Jens,
> 
> On Wed, Aug 24, 2005 at 11:28:39AM +0200, Jens Axboe wrote:
> > Patch attached is against 2.6.13-rc6-mm2. Still a good idea to apply the
> > relayfs read update from the previous mail [*] as well.
> 
> There's a small memory leak there on one of the start-tracing
> error paths (relay_open failure)... this should plug it up.
> 
> cheers.
> 
> -- 
> Nathan
> 
> 
> Index: 2.6.x-xfs/drivers/block/blktrace.c
> ===================================================================
> --- 2.6.x-xfs.orig/drivers/block/blktrace.c
> +++ 2.6.x-xfs/drivers/block/blktrace.c
> @@ -73,9 +73,9 @@ int blk_start_trace(struct block_device 
>  {
>  	request_queue_t *q = bdev_get_queue(bdev);
>  	struct blk_user_trace_setup buts;
> -	struct blk_trace *bt;
> +	struct blk_trace *bt = NULL;
>  	char b[BDEVNAME_SIZE];
> -	int ret = 0;
> +	int ret;
>  
>  	if (!q)
>  		return -ENXIO;
> @@ -116,9 +116,14 @@ int blk_start_trace(struct block_device 
>  	spin_lock_irq(q->queue_lock);
>  	q->blk_trace = bt;
>  	spin_unlock_irq(q->queue_lock);
> -	ret = 0;
> +
> +	up(&bdev->bd_sem);
> +	return 0;
> +
>  err:
>  	up(&bdev->bd_sem);
> +	if (bt)
> +		kfree(bt);
>  	return ret;
>  }

Indeed, thanks! I've applied the patch, I'll do a new release against
2.6.14-pre/rc/git as soon as relayfs gets merged. Or 2.6.13-mm1, if that
comes first.

BTW, the trace tools now live in a git repo here:

rsync://rsync.kernel.org/pub/scm/linux/kernel/git/axboe/blktrace.git

-- 
Jens Axboe

