Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289862AbSAPEaQ>; Tue, 15 Jan 2002 23:30:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289855AbSAPEaG>; Tue, 15 Jan 2002 23:30:06 -0500
Received: from zeus.kernel.org ([204.152.189.113]:57586 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S289863AbSAPE3s>;
	Tue, 15 Jan 2002 23:29:48 -0500
Date: Tue, 15 Jan 2002 20:11:24 -0800 (PST)
From: Andre Hedrick <andre@linuxdiskcert.org>
To: Andrew Morton <akpm@zip.com.au>
cc: Jens Axboe <axboe@suse.de>, lkml <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: block completion races
In-Reply-To: <3C44DC7B.D960D15D@zip.com.au>
Message-ID: <Pine.LNX.4.10.10201152001400.26467-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


We have a more interesting problem!
This does not show up in 2.5.1 which is patch base for 2.5.3-pre1.
It does show up in 2.5.2-pre10 but I have not walked the patch through
2.5.2preX series.

We have a very bad queue race that is PIO specific but really the whole
darn driver before the patch was applied.  ACB only tighten the driver's
alignment to the NCITS standards.  One should note the direct access via
the ioctl does not lock the driver.  Only coming down from BLOCK will this
event occur.

Repeatable test "hdparm -d0 -t /dev/hdx"

If you apply the acb-io patch to 2.5.1 this does not happen.

In the introduction of BIO, there were no "q->queue_lock" applied to
protecting the queue.

        /*
         * Is meant to protect the queue in the future instead of
         * io_request_lock
         */
        spinlock_t              queue_lock;

Well we pulled "io_request_lock" but did we forgot to insert or add
q->queue_lock spinlocks?

It is going to be a LONG LONG NIGHT :-(

Andre Hedrick
Linux Disk Certification Project                Linux ATA Development


On Tue, 15 Jan 2002, Andrew Morton wrote:

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
> 
> Also, there is this code in ide_do_drive_cmd():
> 
>         if (action == ide_wait) {
>                 wait_for_completion(&wait);     /* wait for it to be serviced */
>                 return rq->errors ? -EIO : 0;   /* return -EIO if errors */
>         }
> 
> Is it safe to use `rq' here?  It has just been recycled in
> end_that_request_last() and we don't own it any more.
> 
> I think the simplest approach to this one is to make the error
> code a part of the completion structure, so:
> 
> struct blkdev_completion {
> 	struct completion completion;
> 	int errcode;
> };
> 
> If you agree, I'll do the patch.
> 
> 
> 
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
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

