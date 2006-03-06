Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751584AbWCFUYW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751584AbWCFUYW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 15:24:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751623AbWCFUYV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 15:24:21 -0500
Received: from nproxy.gmail.com ([64.233.182.200]:48340 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751584AbWCFUYU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 15:24:20 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=j0lh923fN5HA30m5cyrV2NsoILSytY0ghLQLSZs5wkgWHJiCdHBml18K2gi4ZSHVpgVm4JXFwoNItp/xUK0fNgnxo1wS93HGXrjG+beNnmlZTzw9xprRDa/bJmbhEu2sLrjyQMKOITCsOBeASr+9jWZWKW1mC4n97QOh1H7dHyo=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Slab corruption in 2.6.16-rc5-mm2
Date: Mon, 6 Mar 2006 21:24:42 +0100
User-Agent: KMail/1.9.1
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, markhe@nextd.demon.co.uk,
       Andrea Arcangeli <andrea@suse.de>, Mike Christie <michaelc@cs.wisc.edu>,
       James Bottomley <James.Bottomley@steeleye.com>
References: <200603060117.16484.jesper.juhl@gmail.com> <Pine.LNX.4.64.0603061122270.13139@g5.osdl.org> <Pine.LNX.4.64.0603061147260.13139@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0603061147260.13139@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603062124.42223.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 06 March 2006 21:06, Linus Torvalds wrote:
> 
> On Mon, 6 Mar 2006, Linus Torvalds wrote:
> > 
> > So it's either an aic7xxx bug, or it's generic SCSI.
> > 
> > Considering that we've had other slab corruption issues (the reason I was 
> > looking closely at yours), generic SCSI isn't out of the question.
> > 
> > If you were a git user, doing a bisection run would be useful since you 
> > seem to be able to recreate it at will. Oh, well. Testign that one patch 
> > would still help.
> 

Since the patch you sent me didn't apply cleanly to the mm kernel I made the
changes by hand. This is what I ended up with (should be the same end result
as what you intended as far as I can see) :

--- linux-2.6.16-rc5-mm2-orig/drivers/scsi/scsi_lib.c	2006-03-05 23:43:56.000000000 +0100
+++ linux-2.6.16-rc5-mm2/drivers/scsi/scsi_lib.c	2006-03-06 21:13:53.000000000 +0100
@@ -260,7 +260,6 @@ int scsi_execute(struct scsi_device *sde
 	memcpy(req->cmd, cmd, req->cmd_len);
 	req->sense = sense;
 	req->sense_len = 0;
-	req->retries = retries;
 	req->timeout = timeout;
 	req->flags |= flags | REQ_BLOCK_PC | REQ_SPECIAL | REQ_QUIET;
 
@@ -478,7 +477,6 @@ int scsi_execute_async(struct scsi_devic
 	req->sense = sioc->sense;
 	req->sense_len = 0;
 	req->timeout = timeout;
-	req->retries = retries;
 	req->end_io_data = sioc;
 
 	sioc->data = privdata;
@@ -1240,7 +1238,7 @@ static void scsi_setup_blk_pc_cmnd(struc
 		cmd->sc_data_direction = DMA_FROM_DEVICE;
 	
 	cmd->transfersize = req->data_len;
-	cmd->allowed = req->retries;
+	cmd->allowed = 3;
 	cmd->timeout_per_command = req->timeout;
 	cmd->done = scsi_blk_pc_done;
 }
--- linux-2.6.16-rc5-mm2-orig/block/scsi_ioctl.c	2006-03-05 23:43:41.000000000 +0100
+++ linux-2.6.16-rc5-mm2/block/scsi_ioctl.c	2006-03-06 21:16:19.000000000 +0100
@@ -314,8 +314,6 @@ static int sg_io(struct file *file, requ
 	if (!rq->timeout)
 		rq->timeout = BLK_DEFAULT_TIMEOUT;
 
-	rq->retries = 0;
-
 	start_time = jiffies;
 
 	/* ignore return value. All information is passed back to caller
@@ -433,7 +431,6 @@ static int sg_scsi_ioctl(struct file *fi
 	rq->data = buffer;
 	rq->data_len = bytes;
 	rq->flags |= REQ_BLOCK_PC;
-	rq->retries = 0;
 
 	blk_execute_rq(q, bd_disk, rq, 0);
 	err = rq->errors & 0xff;	/* only 8 bit SCSI status */
--- linux-2.6.16-rc5-mm2-orig/include/linux/blkdev.h	2006-03-05 23:44:06.000000000 +0100
+++ linux-2.6.16-rc5-mm2/include/linux/blkdev.h	2006-03-06 21:13:02.000000000 +0100
@@ -190,7 +190,6 @@ struct request {
 	void *sense;
 
 	unsigned int timeout;
-	int retries;
 
 	/*
 	 * For Power Management requests


Unfortunately that didn't fix it. After booting the patched kernel I found
this in dmesg :

Slab corruption: start=f77d768c, len=64
Redzone: 0x5a2cf071/0x5a2cf071.
Last user: [<c02934db>](sr_do_ioctl+0x11b/0x270)
000: 70 00 02 00 00 00 00 0a 00 00 00 00 3a 01 00 00
010: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
020: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
030: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
Prev obj: start=f77d7640, len=64
Redzone: 0x170fc2a5/0x170fc2a5.
Last user: [<c023d64d>](init_dev+0x55d/0x630)
000: 00 01 00 00 05 00 00 00 bf 00 00 00 3b 8a 00 00
010: 00 03 1c 7f 15 04 00 01 00 11 13 1a 00 12 0f 17
Next obj: start=f77d76d8, len=64
Redzone: 0x170fc2a5/0x170fc2a5.
Last user: [<c01c7c80>](ext3_init_block_alloc_info+0x20/0x70)
000: 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a
010: 08 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
Slab corruption: start=f7001640, len=64
Redzone: 0x5a2cf071/0x5a2cf071.
Last user: [<c02934db>](sr_do_ioctl+0x11b/0x270)
000: 70 00 05 00 00 00 00 0a 00 00 00 00 24 00 00 00
010: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
020: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
030: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
Prev obj: start=f70015f4, len=64
Redzone: 0x170fc2a5/0x170fc2a5.
Last user: [<f8bdf124>](__snd_util_mem_alloc+0x74/0x80 [snd_util_mem])
000: 00 10 00 00 00 00 00 00 b0 75 7d f7 50 33 bd f5
010: 00 00 00 00 00 00 00 00 01 00 00 00 00 00 00 00
Next obj: start=f700168c, len=64
Redzone: 0x170fc2a5/0x170fc2a5.
Last user: [<c0173923>](real_lookup+0x93/0xe0)
000: 6c 69 62 62 6f 6f 73 74 5f 75 6e 69 74 5f 74 65
010: 73 74 5f 66 72 61 6d 65 77 6f 72 6b 2d 67 63 63


> Hmm.. This appended patch may or may not help.
> 
I'll give it a spin.


> It overwrites the SCSI command "req" pointer when the request has been 
> done. The request cannot be used afterwards, so anybody accessing it would 
> be a bug. I think.
> 
Let's see what happens.
I've applied it on top of the changes mentioned above - let me know if 
that's wrong.


> HOWEVER. I noticed something else strange. Your slab corruption report 
> says
> 
> 	Slab corruption: start=f72948a0, len=64
> 	Redzone: 0x5a2cf071/0x5a2cf071.
> 	Last user: [<c02934eb>](sr_do_ioctl+0x11b/0x270)
> 	...
> 
> and the scary thing is that "len=64". 
> 
> The thing is, SCSI uses "SCSI_SENSE_BUFFERSIZE" to determine the maximum 
> sense size to copy, and what do we have, if not
> 
> 	include/scsi/scsi_cmnd.h:#define SCSI_SENSE_BUFFERSIZE  96
> 
> ie a 64-byte buffer is simply TOO DAMN SMALL!
> 
> Now, the thing is, the 64 comes from "sizeof(struct request_sense)", which 
> is what "struct packet_command *" uses. We can change that sizeof() to 
> just use SCSI_SENSE_BUFFERSIZE, but that still makes me worry about 

I'll try that after booting with the patch you just supplied and let you 
know the results shortly.


 /Jesper

