Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751455AbWCFUbR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751455AbWCFUbR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 15:31:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751467AbWCFUbR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 15:31:17 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:38179 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1751455AbWCFUbQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 15:31:16 -0500
Date: Mon, 6 Mar 2006 21:30:37 +0100
From: Jens Axboe <axboe@suse.de>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, markhe@nextd.demon.co.uk,
       Andrea Arcangeli <andrea@suse.de>, Mike Christie <michaelc@cs.wisc.edu>,
       James Bottomley <James.Bottomley@steeleye.com>
Subject: Re: Slab corruption in 2.6.16-rc5-mm2
Message-ID: <20060306203036.GQ4595@suse.de>
References: <200603060117.16484.jesper.juhl@gmail.com> <Pine.LNX.4.64.0603061122270.13139@g5.osdl.org> <Pine.LNX.4.64.0603061147260.13139@g5.osdl.org> <200603062124.42223.jesper.juhl@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200603062124.42223.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 06 2006, Jesper Juhl wrote:
> On Monday 06 March 2006 21:06, Linus Torvalds wrote:
> > 
> > On Mon, 6 Mar 2006, Linus Torvalds wrote:
> > > 
> > > So it's either an aic7xxx bug, or it's generic SCSI.
> > > 
> > > Considering that we've had other slab corruption issues (the reason I was 
> > > looking closely at yours), generic SCSI isn't out of the question.
> > > 
> > > If you were a git user, doing a bisection run would be useful since you 
> > > seem to be able to recreate it at will. Oh, well. Testign that one patch 
> > > would still help.
> > 
> 
> Since the patch you sent me didn't apply cleanly to the mm kernel I made the
> changes by hand. This is what I ended up with (should be the same end result
> as what you intended as far as I can see) :
> 
> --- linux-2.6.16-rc5-mm2-orig/drivers/scsi/scsi_lib.c	2006-03-05 23:43:56.000000000 +0100
> +++ linux-2.6.16-rc5-mm2/drivers/scsi/scsi_lib.c	2006-03-06 21:13:53.000000000 +0100
> @@ -260,7 +260,6 @@ int scsi_execute(struct scsi_device *sde
>  	memcpy(req->cmd, cmd, req->cmd_len);
>  	req->sense = sense;
>  	req->sense_len = 0;
> -	req->retries = retries;
>  	req->timeout = timeout;
>  	req->flags |= flags | REQ_BLOCK_PC | REQ_SPECIAL | REQ_QUIET;
>  
> @@ -478,7 +477,6 @@ int scsi_execute_async(struct scsi_devic
>  	req->sense = sioc->sense;
>  	req->sense_len = 0;
>  	req->timeout = timeout;
> -	req->retries = retries;
>  	req->end_io_data = sioc;
>  
>  	sioc->data = privdata;
> @@ -1240,7 +1238,7 @@ static void scsi_setup_blk_pc_cmnd(struc
>  		cmd->sc_data_direction = DMA_FROM_DEVICE;
>  	
>  	cmd->transfersize = req->data_len;
> -	cmd->allowed = req->retries;
> +	cmd->allowed = 3;
>  	cmd->timeout_per_command = req->timeout;
>  	cmd->done = scsi_blk_pc_done;
>  }
> --- linux-2.6.16-rc5-mm2-orig/block/scsi_ioctl.c	2006-03-05 23:43:41.000000000 +0100
> +++ linux-2.6.16-rc5-mm2/block/scsi_ioctl.c	2006-03-06 21:16:19.000000000 +0100
> @@ -314,8 +314,6 @@ static int sg_io(struct file *file, requ
>  	if (!rq->timeout)
>  		rq->timeout = BLK_DEFAULT_TIMEOUT;
>  
> -	rq->retries = 0;
> -
>  	start_time = jiffies;
>  
>  	/* ignore return value. All information is passed back to caller
> @@ -433,7 +431,6 @@ static int sg_scsi_ioctl(struct file *fi
>  	rq->data = buffer;
>  	rq->data_len = bytes;
>  	rq->flags |= REQ_BLOCK_PC;
> -	rq->retries = 0;
>  
>  	blk_execute_rq(q, bd_disk, rq, 0);
>  	err = rq->errors & 0xff;	/* only 8 bit SCSI status */
> --- linux-2.6.16-rc5-mm2-orig/include/linux/blkdev.h	2006-03-05 23:44:06.000000000 +0100
> +++ linux-2.6.16-rc5-mm2/include/linux/blkdev.h	2006-03-06 21:13:02.000000000 +0100
> @@ -190,7 +190,6 @@ struct request {
>  	void *sense;
>  
>  	unsigned int timeout;
> -	int retries;
>  
>  	/*
>  	 * For Power Management requests
> 
> 
> Unfortunately that didn't fix it. After booting the patched kernel I found
> this in dmesg :

I don't see how it could be, honestly, we would gladly oops in locally
close places if that was the case. If you disable slab debug/poison, do
you get a nice NULL pointer dereference instead? There have been some
reports on a NULL queue for sr devices as of lately, I wonder if some
SCSI change recently was broken.

Tejun, I seem to recall you looking at this, but I can't seem to locate
the thread. Did anything come of it?

-- 
Jens Axboe

