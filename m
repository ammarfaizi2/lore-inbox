Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932582AbVINUTv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932582AbVINUTv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 16:19:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932763AbVINUTu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 16:19:50 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:33716 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP id S932523AbVINUTt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 16:19:49 -0400
Date: Wed, 14 Sep 2005 16:19:45 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: James Bottomley <James.Bottomley@SteelEye.com>
cc: Anton Blanchard <anton@samba.org>, Dipankar Sarma <dipankar@in.ibm.com>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [2.6.14-rc1] sym scsi boot hang
In-Reply-To: <1126717062.4584.4.camel@mulgrave>
Message-ID: <Pine.LNX.4.44L0.0509141610480.8011-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Sep 2005, James Bottomley wrote:

> OK, my fault.  Your fix is almost correct .. I was going to do this
> eventually, honest, because there's no need to unprep and reprep a
> command that comes in through scsi_queue_insert().
> 
> However, I decided to leave it in to exercise the scsi_unprep_request()
> path just to make sure it was working.  What's happening, I think, is
> that we also use this path for retries.  Since we kill and reget the
> command each time, the retries decrement is never seen, so we're
> retrying forever.
> 
> This should be the correct reversal.

Then shouldn't you also avoid unprepping and reprepping a command that is
deferred because the host isn't ready?

And isn't it necessary to make sure that req->special is NULL when
submitting a special request with no scsi_request, and that
cmd->sc_request is NULL when associating a command block to a special
request with no scsi_request?

In short, is this patch needed?

Alan Stern



Index: usb-2.6/drivers/scsi/scsi_lib.c
===================================================================
--- usb-2.6.orig/drivers/scsi/scsi_lib.c
+++ usb-2.6/drivers/scsi/scsi_lib.c
@@ -343,6 +343,7 @@ int scsi_execute(struct scsi_device *sde
 	req->sense_len = 0;
 	req->timeout = timeout;
 	req->flags |= flags | REQ_BLOCK_PC | REQ_SPECIAL | REQ_QUIET;
+	req->special = NULL;
 
 	/*
 	 * head injection *required* here otherwise quiesce won't work
@@ -1072,9 +1073,6 @@ static int scsi_init_io(struct scsi_cmnd
 	printk(KERN_ERR "req nr_sec %lu, cur_nr_sec %u\n", req->nr_sectors,
 			req->current_nr_sectors);
 
-	/* release the command and kill it */
-	scsi_release_buffers(cmd);
-	scsi_put_command(cmd);
 	return BLKPREP_KILL;
 }
 
@@ -1205,6 +1203,7 @@ static int scsi_prep_fn(struct request_q
 				goto defer;
 		} else
 			cmd = req->special;
+		cmd->sc_request = NULL;
 		
 		/* pull a tag out of the request if we have one */
 		cmd->tag = req->tag;
@@ -1250,7 +1249,7 @@ static int scsi_prep_fn(struct request_q
 		ret = scsi_init_io(cmd);
 		switch(ret) {
 		case BLKPREP_KILL:
-			/* BLKPREP_KILL return also releases the command */
+			scsi_unprep_request(req);
 			goto kill;
 		case BLKPREP_DEFER:
 			goto defer;
@@ -1514,7 +1513,6 @@ static void scsi_request_fn(struct reque
 	 * cases (host limits or settings) should run the queue at some
 	 * later time.
 	 */
-	scsi_unprep_request(req);
 	spin_lock_irq(q->queue_lock);
 	blk_requeue_request(q, req);
 	sdev->device_busy--;

