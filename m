Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261299AbVCaJdG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261299AbVCaJdG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 04:33:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261274AbVCaJ2w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 04:28:52 -0500
Received: from rproxy.gmail.com ([64.233.170.201]:53570 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261265AbVCaJI4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 04:08:56 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:user-agent:content-type:references:in-reply-to:subject:message-id:date;
        b=i/8No9RGNRxl39slqZnO5gdB8GAdMDpfCe/21uhbrK3hlCf7EJejbFF3VoFVzDwccgkSZHwJIacnYBT66Xdizna2Lnmw/HwS2Kx1QN3t0LthZnTjXjxPq3Hstr1iSd//aPOdcLlgEd2CLXFhGOTQDnGhRo0qsV3klKNN/lmKGt8=
From: Tejun Heo <htejun@gmail.com>
To: James.Bottomley@steeleye.com, axboe@suse.de
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
User-Agent: lksp 0.3
Content-Type: text/plain; charset=US-ASCII
References: <20050331090647.FEDC3964@htj.dyndns.org>
In-Reply-To: <20050331090647.FEDC3964@htj.dyndns.org>
Subject: Re: [PATCH scsi-misc-2.6 12/13] scsi: replace scsi_queue_insert() with scsi_requeue_command()
Message-ID: <20050331090647.B916C84F@htj.dyndns.org>
Date: Thu, 31 Mar 2005 18:08:50 +0900 (KST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

12_scsi_consolidate_requeue_paths.patch

	Add scsi_device_unbusy() call to scsi_retry_command(), replace
	scsi_queue_insert() with scsi_requeue_command(), make
	scsi_softirq() use scsi_retry_command() for ADD_TO_MLQUEUE
	case too (with explicit device blocking), and make
	scsi_eh_flush_done_q() use scsi_retry_command().  While at it,
	remove leading and tailing empty comment lines from trivial
	comments.

	As scsi_queue_insert() has no users now, kill it.

Signed-off-by: Tejun Heo <htejun@gmail.com>

 scsi.c       |   25 ++++++++++---------
 scsi_error.c |    2 -
 scsi_lib.c   |   74 -----------------------------------------------------------
 scsi_priv.h  |    3 --
 4 files changed, 15 insertions(+), 89 deletions(-)

Index: scsi-export/drivers/scsi/scsi.c
===================================================================
--- scsi-export.orig/drivers/scsi/scsi.c	2005-03-31 18:06:22.000000000 +0900
+++ scsi-export/drivers/scsi/scsi.c	2005-03-31 18:06:22.000000000 +0900
@@ -638,6 +638,7 @@ static void scsi_softirq(struct softirq_
 	while (!list_empty(&local_q)) {
 		struct scsi_cmnd *cmd = list_entry(local_q.next,
 						   struct scsi_cmnd, eh_entry);
+		struct scsi_device *sdev = cmd->device;
 		list_del_init(&cmd->eh_entry);
 
 		disposition = scsi_decide_disposition(cmd);
@@ -646,12 +647,12 @@ static void scsi_softirq(struct softirq_
 		case SUCCESS:
 			scsi_finish_command(cmd);
 			break;
+		case ADD_TO_MLQUEUE:
+			sdev->device_blocked = sdev->max_device_blocked;
+			/* fall thru */
 		case NEEDS_RETRY:
 			scsi_retry_command(cmd);
 			break;
-		case ADD_TO_MLQUEUE:
-			scsi_queue_insert(cmd, SCSI_MLQUEUE_DEVICE_BUSY);
-			break;
 		default:
 			if (!scsi_eh_scmd_add(cmd, 0))
 				scsi_finish_command(cmd);
@@ -669,20 +670,20 @@ static void scsi_softirq(struct softirq_
  *              level drivers should not become re-entrant as a result of
  *              this.
  */
-int scsi_retry_command(struct scsi_cmnd *cmd)
+void scsi_retry_command(struct scsi_cmnd *cmd)
 {
-	/*
-	 * Restore the SCSI command state.
-	 */
+	SCSI_LOG_MLQUEUE(1, printk("Retrying command %p\n", cmd));
+
+	scsi_device_unbusy(cmd->device);
+
+	/* Restore the SCSI command state. */
 	scsi_setup_cmd_retry(cmd);
 
-        /*
-         * Zero the sense information from the last time we tried
-         * this command.
-         */
+        /* Zero the sense information from the last time we tried
+         * this command. */
 	memset(cmd->sense_buffer, 0, sizeof(cmd->sense_buffer));
 
-	return scsi_queue_insert(cmd, SCSI_MLQUEUE_EH_RETRY);
+	scsi_requeue_command(cmd, 0);
 }
 
 /*
Index: scsi-export/drivers/scsi/scsi_error.c
===================================================================
--- scsi-export.orig/drivers/scsi/scsi_error.c	2005-03-31 18:06:21.000000000 +0900
+++ scsi-export/drivers/scsi/scsi_error.c	2005-03-31 18:06:22.000000000 +0900
@@ -1551,7 +1551,7 @@ static void scsi_eh_flush_done_q(struct 
 							  " retry cmd: %p\n",
 							  current->comm,
 							  scmd));
-				scsi_queue_insert(scmd, SCSI_MLQUEUE_EH_RETRY);
+				scsi_retry_command(scmd);
 		} else {
 			if (!scmd->result)
 				scmd->result |= (DRIVER_TIMEOUT << 24);
Index: scsi-export/drivers/scsi/scsi_lib.c
===================================================================
--- scsi-export.orig/drivers/scsi/scsi_lib.c	2005-03-31 18:06:22.000000000 +0900
+++ scsi-export/drivers/scsi/scsi_lib.c	2005-03-31 18:06:22.000000000 +0900
@@ -210,80 +210,6 @@ int scsi_insert_special_req(struct scsi_
 }
 
 /*
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
-	 * Next, set the appropriate busy bit for the device/host.
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
-/*
  * Function:    scsi_do_req
  *
  * Purpose:     Queue a SCSI request
Index: scsi-export/drivers/scsi/scsi_priv.h
===================================================================
--- scsi-export.orig/drivers/scsi/scsi_priv.h	2005-03-31 18:06:22.000000000 +0900
+++ scsi-export/drivers/scsi/scsi_priv.h	2005-03-31 18:06:22.000000000 +0900
@@ -62,7 +62,7 @@ extern int scsi_dispatch_cmd(struct scsi
 extern int scsi_setup_command_freelist(struct Scsi_Host *shost);
 extern void scsi_destroy_command_freelist(struct Scsi_Host *shost);
 extern void scsi_done(struct scsi_cmnd *cmd);
-extern int scsi_retry_command(struct scsi_cmnd *cmd);
+extern void scsi_retry_command(struct scsi_cmnd *cmd);
 extern int scsi_insert_special_req(struct scsi_request *sreq, int);
 extern void scsi_init_cmd_from_req(struct scsi_cmnd *cmd,
 		struct scsi_request *sreq);
@@ -95,7 +95,6 @@ extern int scsi_eh_scmd_add(struct scsi_
 extern int scsi_maybe_unblock_host(struct scsi_device *sdev);
 extern void scsi_setup_cmd_retry(struct scsi_cmnd *cmd);
 extern void scsi_device_unbusy(struct scsi_device *sdev);
-extern int scsi_queue_insert(struct scsi_cmnd *cmd, int reason);
 extern void scsi_requeue_command(struct scsi_cmnd *cmd, int reprep);
 extern void scsi_next_command(struct scsi_cmnd *cmd);
 extern void scsi_run_host_queues(struct Scsi_Host *shost);

