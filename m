Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262707AbVCWCPb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262707AbVCWCPb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 21:15:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262718AbVCWCPa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 21:15:30 -0500
Received: from rproxy.gmail.com ([64.233.170.192]:43422 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262706AbVCWCO3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 21:14:29 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:user-agent:content-type:references:in-reply-to:subject:message-id:date;
        b=KnBykcJHn8+DmpkECvvczgLTuwXvoF2ff+qvxvzXy23tdgw93d3JwSNAVPPG06kNpvwqR+uHo9HA3lJUVSR2deaAM31jwyBXkVFVdqdvs7xUUK34DVW9jjl2ymRwZfrdYGoxW6bHHvBtNdCpgbNzXoil3ZRkNvhq+bPefdAAkIM=
From: Tejun Heo <htejun@gmail.com>
To: James.Bottomley@steeleye.com, axboe@suse.de
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
User-Agent: lksp 0.3
Content-Type: text/plain; charset=US-ASCII
References: <20050323021335.960F95F8@htj.dyndns.org>
In-Reply-To: <20050323021335.960F95F8@htj.dyndns.org>
Subject: Re: [PATCH scsi-misc-2.6 01/08] scsi: remove unused bounce-buffer release path
Message-ID: <20050323021335.F07B64D9@htj.dyndns.org>
Date: Wed, 23 Mar 2005 11:14:24 +0900 (KST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

01_scsi_remove_scsi_release_buffers.patch

	Buffer bouncing hasn't been done inside the scsi midlayer for
	quite sometime now, but bounce-buffer release paths are still
	around.  This patch removes these unused paths.

Signed-off-by: Tejun Heo <htejun@gmail.com>

 scsi_lib.c |   60 +++++-------------------------------------------------------
 1 files changed, 5 insertions(+), 55 deletions(-)

Index: scsi-export/drivers/scsi/scsi_lib.c
===================================================================
--- scsi-export.orig/drivers/scsi/scsi_lib.c	2005-03-23 09:39:36.000000000 +0900
+++ scsi-export/drivers/scsi/scsi_lib.c	2005-03-23 09:40:09.000000000 +0900
@@ -622,45 +622,6 @@ static void scsi_free_sgtable(struct sca
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
@@ -703,22 +664,8 @@ void scsi_io_completion(struct scsi_cmnd
 	if (blk_complete_barrier_rq(q, req, good_bytes >> 9))
 		return;
 
-	/*
-	 * Free up any indirection buffers we allocated for DMA purposes. 
-	 * For the case of a READ, we need to copy the data out of the
-	 * bounce buffer and into the real buffer.
-	 */
 	if (cmd->use_sg)
 		scsi_free_sgtable(cmd->buffer, cmd->sglist_len);
-	else if (cmd->buffer != req->buffer) {
-		if (rq_data_dir(req) == READ) {
-			unsigned long flags;
-			char *to = bio_kmap_irq(req->bio, &flags);
-			memcpy(to, cmd->buffer, cmd->bufflen);
-			bio_kunmap_irq(to, &flags);
-		}
-		kfree(cmd->buffer);
-	}
 
 	if (result) {
 		sense_valid = scsi_command_normalize_sense(cmd, &sshdr);
@@ -963,7 +910,8 @@ static int scsi_init_io(struct scsi_cmnd
 			req->current_nr_sectors);
 
 	/* release the command and kill it */
-	scsi_release_buffers(cmd);
+	if (cmd->use_sg)
+		scsi_free_sgtable(cmd->request_buffer, cmd->sglist_len);
 	scsi_put_command(cmd);
 	return BLKPREP_KILL;
 }
@@ -1140,7 +1088,9 @@ static int scsi_prep_fn(struct request_q
 		 */
 		drv = *(struct scsi_driver **)req->rq_disk->private_data;
 		if (unlikely(!drv->init_command(cmd))) {
-			scsi_release_buffers(cmd);
+			if (cmd->use_sg)
+				scsi_free_sgtable(cmd->request_buffer,
+						  cmd->sglist_len);
 			scsi_put_command(cmd);
 			return BLKPREP_KILL;
 		}

