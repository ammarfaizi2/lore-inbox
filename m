Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932588AbVINUo0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932588AbVINUo0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 16:44:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932491AbVINUoZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 16:44:25 -0400
Received: from stat9.steeleye.com ([209.192.50.41]:47842 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S932090AbVINUoY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 16:44:24 -0400
Subject: Re: [2.6.14-rc1] sym scsi boot hang
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Anton Blanchard <anton@samba.org>, Dipankar Sarma <dipankar@in.ibm.com>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44L0.0509141610480.8011-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.44L0.0509141610480.8011-100000@iolanthe.rowland.org>
Content-Type: text/plain
Date: Wed, 14 Sep 2005 16:44:19 -0400
Message-Id: <1126730659.4825.18.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-09-14 at 16:19 -0400, Alan Stern wrote:
> On Wed, 14 Sep 2005, James Bottomley wrote:
> Then shouldn't you also avoid unprepping and reprepping a command that is
> deferred because the host isn't ready?

Yes ... really the only case for unprep is when we've partially released
the command (like in scsi_io_completion) where we need to tear the rest
of it down.

The rule should be that if it needs preparing, then it's in the same
state as the block layer would send it to us in (with no appendages).

For most requeues, we have all the prepared resources attached, so they
don't need tearing down and repreparing.

> And isn't it necessary to make sure that req->special is NULL when
> submitting a special request with no scsi_request, and that

Yes, but only if the command will be prepared again.

> cmd->sc_request is NULL when associating a command block to a special
> request with no scsi_request?

No, that's zeroed out when the command is allocated.  It's only set in
the path that sends down a scsi_request.

James



> In short, is this patch needed?
> 
> Alan Stern
> 
> 
> 
> Index: usb-2.6/drivers/scsi/scsi_lib.c
> ===================================================================
> --- usb-2.6.orig/drivers/scsi/scsi_lib.c
> +++ usb-2.6/drivers/scsi/scsi_lib.c
> @@ -343,6 +343,7 @@ int scsi_execute(struct scsi_device *sde
>  	req->sense_len = 0;
>  	req->timeout = timeout;
>  	req->flags |= flags | REQ_BLOCK_PC | REQ_SPECIAL | REQ_QUIET;
> +	req->special = NULL;
>  
>  	/*
>  	 * head injection *required* here otherwise quiesce won't work
> @@ -1072,9 +1073,6 @@ static int scsi_init_io(struct scsi_cmnd
>  	printk(KERN_ERR "req nr_sec %lu, cur_nr_sec %u\n", req->nr_sectors,
>  			req->current_nr_sectors);
>  
> -	/* release the command and kill it */
> -	scsi_release_buffers(cmd);
> -	scsi_put_command(cmd);
>  	return BLKPREP_KILL;
>  }
>  
> @@ -1205,6 +1203,7 @@ static int scsi_prep_fn(struct request_q
>  				goto defer;
>  		} else
>  			cmd = req->special;
> +		cmd->sc_request = NULL;
>  		
>  		/* pull a tag out of the request if we have one */
>  		cmd->tag = req->tag;
> @@ -1250,7 +1249,7 @@ static int scsi_prep_fn(struct request_q
>  		ret = scsi_init_io(cmd);
>  		switch(ret) {
>  		case BLKPREP_KILL:
> -			/* BLKPREP_KILL return also releases the command */
> +			scsi_unprep_request(req);
>  			goto kill;
>  		case BLKPREP_DEFER:
>  			goto defer;
> @@ -1514,7 +1513,6 @@ static void scsi_request_fn(struct reque
>  	 * cases (host limits or settings) should run the queue at some
>  	 * later time.
>  	 */
> -	scsi_unprep_request(req);
>  	spin_lock_irq(q->queue_lock);
>  	blk_requeue_request(q, req);
>  	sdev->device_busy--;
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-scsi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

