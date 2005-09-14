Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030202AbVINPtt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030202AbVINPtt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 11:49:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030203AbVINPtt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 11:49:49 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:53151 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP
	id S1030202AbVINPts (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 11:49:48 -0400
Date: Wed, 14 Sep 2005 11:49:47 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Anton Blanchard <anton@samba.org>
cc: James Bottomley <James.Bottomley@SteelEye.com>,
       Dipankar Sarma <dipankar@in.ibm.com>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [2.6.14-rc1] sym scsi boot hang
In-Reply-To: <20050914080629.GB19051@krispykreme>
Message-ID: <Pine.LNX.4.44L0.0509141052410.5064-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Sep 2005, Anton Blanchard wrote:

> Hi,
> 
> > If that's the cause, it's probably a double down of the host scan
> > semaphore somewhere in the code.  alt-sysrq-t should work in this case,
> > can you get a stack trace of the blocked process?
> 
> It appears to be this patch:
> 
>   [SCSI] SCSI core: fix leakage of scsi_cmnd's
> 
>   From:         Alan Stern <stern@rowland.harvard.edu>

> And in particular it looks like the scsi_unprep_request in
> scsi_queue_insert is causing it. The following patch fixes the boot
> problems on the vscsi machine:

In general the scsi_unprep_request routine is correct and needs to be
there.  The one part that might be questionable is the assignment to
req->special.  It may turn out that the real solution is to have
scsi_execute set req->special to NULL; I assumed it would be NULL already
but perhaps I was wrong.

(James, I see a possible problem with scsi_insert_special_req.  It adds to
the queue a request with REQ_DONTPREP set.  How can such a request, with
no associated scsi_cmnd, ever work?  Also, won't scsi_end_request and 
__scsi_release_request end up putting the same scsi_command twice?)

Here is a patch that addresses the first problem and fixes up a few other
loose ends.  Please see if it helps.

Alan Stern



Index: usb-2.6/drivers/scsi/scsi_lib.c
===================================================================
--- usb-2.6.orig/drivers/scsi/scsi_lib.c
+++ usb-2.6/drivers/scsi/scsi_lib.c
@@ -116,7 +116,13 @@ static void scsi_unprep_request(struct r
 	struct scsi_cmnd *cmd = req->special;
 
 	req->flags &= ~REQ_DONTPREP;
-	req->special = (req->flags & REQ_SPECIAL) ? cmd->sc_request : NULL;
+	req->special = NULL;
+	if (req->flags & REQ_SPECIAL) {
+		struct scsi_request *sreq = cmd->sc_request;
+
+		if (sreq->sr_magic == SCSI_REQ_MAGIC)
+			req->special = sreq;
+	}
 
 	scsi_release_buffers(cmd);
 	scsi_put_command(cmd);
@@ -343,6 +349,7 @@ int scsi_execute(struct scsi_device *sde
 	req->sense_len = 0;
 	req->timeout = timeout;
 	req->flags |= flags | REQ_BLOCK_PC | REQ_SPECIAL | REQ_QUIET;
+	req->special = NULL;
 
 	/*
 	 * head injection *required* here otherwise quiesce won't work
@@ -1072,9 +1079,6 @@ static int scsi_init_io(struct scsi_cmnd
 	printk(KERN_ERR "req nr_sec %lu, cur_nr_sec %u\n", req->nr_sectors,
 			req->current_nr_sectors);
 
-	/* release the command and kill it */
-	scsi_release_buffers(cmd);
-	scsi_put_command(cmd);
 	return BLKPREP_KILL;
 }
 
@@ -1176,13 +1180,13 @@ static int scsi_prep_fn(struct request_q
 	if (req->flags & REQ_SPECIAL && req->special) {
 		struct scsi_request *sreq = req->special;
 
-		if (sreq->sr_magic == SCSI_REQ_MAGIC) {
-			cmd = scsi_get_command(sreq->sr_device, GFP_ATOMIC);
-			if (unlikely(!cmd))
-				goto defer;
-			scsi_init_cmd_from_req(cmd, sreq);
-		} else
-			cmd = req->special;
+		if (sreq->sr_magic != SCSI_REQ_MAGIC)
+			printk(KERN_ERR "invalid sr_magic in %s\n",
+					__FUNCTION__);
+		cmd = scsi_get_command(sreq->sr_device, GFP_ATOMIC);
+		if (unlikely(!cmd))
+			goto defer;
+		scsi_init_cmd_from_req(cmd, sreq);
 	} else if (req->flags & (REQ_CMD | REQ_BLOCK_PC)) {
 
 		if(unlikely(specials_only) && !(req->flags & REQ_SPECIAL)) {
@@ -1194,17 +1198,14 @@ static int scsi_prep_fn(struct request_q
 			       sdev->host->host_no, sdev->id, sdev->lun);
 			goto kill;
 		}
-			
 			
 		/*
 		 * Now try and find a command block that we can use.
 		 */
-		if (!req->special) {
-			cmd = scsi_get_command(sdev, GFP_ATOMIC);
-			if (unlikely(!cmd))
-				goto defer;
-		} else
-			cmd = req->special;
+		cmd = scsi_get_command(sdev, GFP_ATOMIC);
+		if (unlikely(!cmd))
+			goto defer;
+		cmd->sc_request = NULL;
 		
 		/* pull a tag out of the request if we have one */
 		cmd->tag = req->tag;
@@ -1250,7 +1251,7 @@ static int scsi_prep_fn(struct request_q
 		ret = scsi_init_io(cmd);
 		switch(ret) {
 		case BLKPREP_KILL:
-			/* BLKPREP_KILL return also releases the command */
+			scsi_unprep_request(req);
 			goto kill;
 		case BLKPREP_DEFER:
 			goto defer;

