Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290380AbSAPHH2>; Wed, 16 Jan 2002 02:07:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290378AbSAPHHS>; Wed, 16 Jan 2002 02:07:18 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:16400 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S290375AbSAPHHL>;
	Wed, 16 Jan 2002 02:07:11 -0500
Date: Wed, 16 Jan 2002 08:07:05 +0100
From: Jens Axboe <axboe@suse.de>
To: Andrew Morton <akpm@zip.com.au>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: block completion races
Message-ID: <20020116080705.F3805@suse.de>
In-Reply-To: <3C44DC7B.D960D15D@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C44DC7B.D960D15D@zip.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 15 2002, Andrew Morton wrote:
> void end_that_request_last(struct request *req)
> {
>         if (req->waiting != NULL)
>                 complete(req->waiting);
> 
>         blkdev_release_request(req);
> }
> 
> 
> I think a bug.  Sometimes (eg, cdrom_queue_packet_command())
> the request is allocated on a task's kernel stack.  As soon as
> we call complete(), that task can wake and release the request
> while blkdev_release_request() is diddling it on this CPU.
> 
> Do you see any problem with releasing the request before running
> complete()?.  Also I think it's best to uninline blkdev_release_request().
> It's 104 bytes long, and we have four copies of it in ll_rw_blk.c.  A
> patch is here.

Agreed, patch is fine with me.

> Also, there is this code in ide_do_drive_cmd():
> 
>         if (action == ide_wait) {
>                 wait_for_completion(&wait);     /* wait for it to be serviced */
>                 return rq->errors ? -EIO : 0;   /* return -EIO if errors */
>         }
> 
> Is it safe to use `rq' here?  It has just been recycled in
> end_that_request_last() and we don't own it any more.

Not really, I guess it would be easiest to make end_that_request_last
return errors status.

> --- linux-2.4.18-pre4/drivers/block/ll_rw_blk.c	Tue Jan 15 15:08:24 2002
> +++ linux-akpm/drivers/block/ll_rw_blk.c	Tue Jan 15 17:39:22 2002
> @@ -546,7 +546,7 @@ static inline void add_request(request_q
>  /*
>   * Must be called with io_request_lock held and interrupts disabled
>   */
> -inline void blkdev_release_request(struct request *req)
> +void blkdev_release_request(struct request *req)
>  {
>  	request_queue_t *q = req->q;
>  	int rw = req->cmd;
> @@ -1084,10 +1084,11 @@ int end_that_request_first (struct reque
>  
>  void end_that_request_last(struct request *req)
>  {
> -	if (req->waiting != NULL)
> -		complete(req->waiting);
> +	struct completion *waiting = req->waiting;
>  
>  	blkdev_release_request(req);
> +	if (waiting != NULL)
> +		complete(waiting);
>  }
>  
>  #define MB(kb)	((kb) << 10)

I've applied this.

-- 
Jens Axboe

