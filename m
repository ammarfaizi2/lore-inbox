Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261531AbVEOBQx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261531AbVEOBQx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 May 2005 21:16:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261534AbVEOBQs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 May 2005 21:16:48 -0400
Received: from rproxy.gmail.com ([64.233.170.193]:16419 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261531AbVEOBQZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 May 2005 21:16:25 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=n0MU+6/SnOAliRCSPYEM39tch+FS1a7WxePfdtL9+4ZaTugOXQgGY5RrqRg3lEeLKreU6XRLjk6GuXLpUc0aLMMCw6tsUteFjZ4YWGbcHO0xFWaWeRwWWonI2VIpblWoSNgyBlFZTROShlIMhXFFpZiqPFpL5h/oN4cX6g+Zyg4=
Date: Sun, 15 May 2005 10:16:21 +0900
From: Tejun Heo <htejun@gmail.com>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: Jens Axboe <axboe@suse.de>, Christoph Hellwig <hch@infradead.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH scsi-misc-2.6 04/04] scsi: remove unnecessary scsi_wait_req_end_io()
Message-ID: <20050515011621.GB26421@htj.dyndns.org>
References: <20050514135610.81030F26@htj.dyndns.org> <20050514135610.50606F9C@htj.dyndns.org> <1116084383.5049.18.camel@mulgrave> <20050514154733.GA5557@htj.dyndns.org> <1116087547.5049.25.camel@mulgrave>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1116087547.5049.25.camel@mulgrave>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 And, this is the other version.

Index: scsi-reqfn-export/drivers/scsi/scsi_lib.c
===================================================================
--- scsi-reqfn-export.orig/drivers/scsi/scsi_lib.c	2005-05-15 08:49:40.000000000 +0900
+++ scsi-reqfn-export/drivers/scsi/scsi_lib.c	2005-05-15 10:05:02.000000000 +0900
@@ -265,16 +265,6 @@ static void scsi_wait_done(struct scsi_c
 		complete(req->waiting);
 }
 
-/* This is the end routine we get to if a command was never attached
- * to the request.  Simply complete the request without changing
- * rq_status; this will cause a DRIVER_ERROR. */
-static void scsi_wait_req_end_io(struct request *req)
-{
-	BUG_ON(!req->waiting);
-
-	complete(req->waiting);
-}
-
 void scsi_wait_req(struct scsi_request *sreq, const void *cmnd, void *buffer,
 		   unsigned bufflen, int timeout, int retries)
 {
@@ -282,7 +272,6 @@ void scsi_wait_req(struct scsi_request *
 	
 	sreq->sr_request->waiting = &wait;
 	sreq->sr_request->rq_status = RQ_SCSI_BUSY;
-	sreq->sr_request->end_io = scsi_wait_req_end_io;
 	scsi_do_req(sreq, cmnd, buffer, bufflen, scsi_wait_done,
 			timeout, retries);
 	wait_for_completion(&wait);
@@ -649,45 +638,6 @@ static void scsi_free_sgtable(struct sca
 }
 
 /*
- * Function:    scsi_release_buffers()
- *
- * Purpose:     Completion processing for block device I/O requests.
- *
- * Arguments:   cmd	- command that we are bailing.
- *
- * Lock status: Assumed that no lock is held upon entry.
- *
- * Returns:     Nothing
- *
- * Notes:       In the event that an upper level driver rejects a
- *		command, we must release resources allocated during
- *		the __init_io() function.  Primarily this would involve
- *		the scatter-gather table, and potentially any bounce
- *		buffers.
- */
-static void scsi_release_buffers(struct scsi_cmnd *cmd)
-{
-	struct request *req = cmd->request;
-
-	/*
-	 * Free up any indirection buffers we allocated for DMA purposes. 
-	 */
-	if (cmd->use_sg)
-		scsi_free_sgtable(cmd->request_buffer, cmd->sglist_len);
-	else if (cmd->request_buffer != req->buffer)
-		kfree(cmd->request_buffer);
-
-	/*
-	 * Zero these out.  They now point to freed memory, and it is
-	 * dangerous to hang onto the pointers.
-	 */
-	cmd->buffer  = NULL;
-	cmd->bufflen = 0;
-	cmd->request_buffer = NULL;
-	cmd->request_bufflen = 0;
-}
-
-/*
  * Function:    scsi_io_completion()
  *
  * Purpose:     Completion processing for block device I/O requests.
@@ -1072,7 +1022,8 @@ static int scsi_prep_fn(struct request_q
 			cmd = req->special;
 	} else {
 		blk_dump_rq_flags(req, "SCSI bad req");
-		return BLKPREP_KILL;
+		BUG();
+		cmd = NULL; /* shut up, gcc */
 	}
 	
 	/* note the overloading of req->special.  When the tag
@@ -1157,14 +1108,13 @@ static int scsi_prep_fn(struct request_q
 
  kill:
 	/*
-	 * Here we have to release every resource associated with the
-	 * request because this will complete at the request level
-	 * (req->end_io), not the scsi command level, so no scsi
-	 * routine will get to free the associated resources.
+	 * This one is a trash.  Tell scsi_request_fn() to kill it.
+	 * Note that we can't kill directly w/ BLKPREP_KILL here as
+	 * special requests don't have their end_io routine set and
+	 * can't be killed via block layer.
 	 */
-	scsi_release_buffers(cmd);
-	scsi_put_command(cmd);
-	return BLKPREP_KILL;
+	cmd->result = DRIVER_ERROR << 24;
+	return BLKPREP_OK;
 }
 
 /*
@@ -1340,16 +1290,18 @@ static void scsi_request_fn(struct reque
 		cmd = req->special;
 		state = cmd->device->sdev_state;
 
-		if (state == SDEV_OFFLINE || state == SDEV_DEL ||
+		if (driver_byte(cmd->result) == DRIVER_ERROR ||
+		    state == SDEV_OFFLINE || state == SDEV_DEL ||
 		    (state == SDEV_CANCEL && !is_special)) {
-			printk(KERN_ERR
-			       "scsi%d (%d:%d): rejecting I/O to %s\n",
-			       shost->host_no, sdev->id, sdev->lun,
-			       (state == SDEV_OFFLINE ?
-					"offline device" :
-				(state == SDEV_DEL ?
-					"dead device" :
-					"device being removed")));
+			if (driver_byte(cmd->result) != DRIVER_ERROR)
+				printk(KERN_ERR
+				       "scsi%d (%d:%d): rejecting I/O to %s\n",
+				       shost->host_no, sdev->id, sdev->lun,
+				       (state == SDEV_OFFLINE ?
+						"offline device" :
+					(state == SDEV_DEL ?
+						 "dead device" :
+						 "device being removed")));
 			kill = 1;
 		} else if (state == SDEV_BLOCK ||
 			   (state == SDEV_QUIESCE && !is_special) ||
