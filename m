Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262329AbVDLNr3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262329AbVDLNr3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 09:47:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262426AbVDLM41
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 08:56:27 -0400
Received: from rproxy.gmail.com ([64.233.170.204]:18641 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262434AbVDLMwv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 08:52:51 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:user-agent:content-type:references:in-reply-to:subject:message-id:date;
        b=ZZGXS3az9cmaDKpR8hdweJCmGVm90E4ygVSynQ1KClMfp9WDKrDicLFBdSRFCv+1Z1Za/qqLIhMWFWoU7GwI5psNR7TCkePihOroUGn2HQ5S+8qyOPF8rne+bdZkDxyFPPsCUnj/T7lAmnExRdP1HPDGVmpIs53xBlfqEBepDv0=
From: Tejun Heo <htejun@gmail.com>
To: James.Bottomley@steeleye.com, axboe@suse.de,
       Christoph Hellwig <hch@infradead.org>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
User-Agent: lksp 0.3
Content-Type: text/plain; charset=US-ASCII
References: <20050412125219.88E5C1F6@htj.dyndns.org>
In-Reply-To: <20050412125219.88E5C1F6@htj.dyndns.org>
Subject: Re: [PATCH scsi-misc-2.6 04/07] scsi: remove scsi_queue_insert()
Message-ID: <20050412125219.62897F6C@htj.dyndns.org>
Date: Tue, 12 Apr 2005 21:52:41 +0900 (KST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

04_scsi_requeue_remove_scsi_queue_insert.patch

	scsi_queue_insert() now has no user left.  Kill it.

Signed-off-by: Tejun Heo <htejun@gmail.com>

 scsi_lib.c  |   76 ------------------------------------------------------------
 scsi_priv.h |    1 
 2 files changed, 77 deletions(-)

Index: scsi-reqfn-export/drivers/scsi/scsi_lib.c
===================================================================
--- scsi-reqfn-export.orig/drivers/scsi/scsi_lib.c	2005-04-12 21:50:11.000000000 +0900
+++ scsi-reqfn-export/drivers/scsi/scsi_lib.c	2005-04-12 21:50:11.000000000 +0900
@@ -106,82 +106,6 @@ int scsi_insert_special_req(struct scsi_
 	return 0;
 }
 
-static void scsi_run_queue(struct request_queue *q);
-
-/*
- * Function:    scsi_queue_insert()
- *
- * Purpose:     Insert a command in the midlevel queue.
- *
- * Arguments:   cmd    - command that we are adding to queue.
- *              reason - why we are inserting command to queue.
- *
- * Lock status: Assumed that lock is not held upon entry.
- *
- * Returns:     Nothing.
- *
- * Notes:       We do this for one of two cases.  Either the host is busy
- *              and it cannot accept any more commands for the time being,
- *              or the device returned QUEUE_FULL and can accept no more
- *              commands.
- * Notes:       This could be called either from an interrupt context or a
- *              normal process context.
- */
-int scsi_queue_insert(struct scsi_cmnd *cmd, int reason)
-{
-	struct Scsi_Host *host = cmd->device->host;
-	struct scsi_device *device = cmd->device;
-	struct request_queue *q = device->request_queue;
-	unsigned long flags;
-
-	SCSI_LOG_MLQUEUE(1,
-		 printk("Inserting command %p into mlqueue\n", cmd));
-
-	/*
-	 * Set the appropriate busy bit for the device/host.
-	 *
-	 * If the host/device isn't busy, assume that something actually
-	 * completed, and that we should be able to queue a command now.
-	 *
-	 * Note that the prior mid-layer assumption that any host could
-	 * always queue at least one command is now broken.  The mid-layer
-	 * will implement a user specifiable stall (see
-	 * scsi_host.max_host_blocked and scsi_device.max_device_blocked)
-	 * if a command is requeued with no other commands outstanding
-	 * either for the device or for the host.
-	 */
-	if (reason == SCSI_MLQUEUE_HOST_BUSY)
-		host->host_blocked = host->max_host_blocked;
-	else if (reason == SCSI_MLQUEUE_DEVICE_BUSY)
-		device->device_blocked = device->max_device_blocked;
-
-	/*
-	 * Register the fact that we own the thing for now.
-	 */
-	cmd->state = SCSI_STATE_MLQUEUE;
-	cmd->owner = SCSI_OWNER_MIDLEVEL;
-
-	/*
-	 * Decrement the counters, since these commands are no longer
-	 * active on the host/device.
-	 */
-	scsi_device_unbusy(device);
-
-	/*
-	 * Requeue the command.  Turn on REQ_SOFTBARRIER to prevent
-	 * other requests from passing this request.
-	 */
-	cmd->request->flags |= REQ_SOFTBARRIER;
-
-	spin_lock_irqsave(q->queue_lock, flags);
-	blk_requeue_request(q, cmd->request);
-	spin_unlock_irqrestore(q->queue_lock, flags);
-
-	scsi_run_queue(q);
-
-	return 0;
-}
-
 /*
  * Function:    scsi_do_req
  *
Index: scsi-reqfn-export/drivers/scsi/scsi_priv.h
===================================================================
--- scsi-reqfn-export.orig/drivers/scsi/scsi_priv.h	2005-04-12 21:50:11.000000000 +0900
+++ scsi-reqfn-export/drivers/scsi/scsi_priv.h	2005-04-12 21:50:11.000000000 +0900
@@ -94,7 +94,6 @@ extern int scsi_eh_scmd_add(struct scsi_
 extern int scsi_maybe_unblock_host(struct scsi_device *sdev);
 extern void scsi_setup_cmd_retry(struct scsi_cmnd *cmd);
 extern void scsi_device_unbusy(struct scsi_device *sdev);
-extern int scsi_queue_insert(struct scsi_cmnd *cmd, int reason);
 extern void scsi_requeue_command(struct scsi_cmnd *cmd);
 extern void scsi_next_command(struct scsi_cmnd *cmd);
 extern void scsi_run_host_queues(struct Scsi_Host *shost);

