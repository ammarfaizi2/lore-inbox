Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261263AbVCaJ2R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261263AbVCaJ2R (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 04:28:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261274AbVCaJ10
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 04:27:26 -0500
Received: from rproxy.gmail.com ([64.233.170.195]:64806 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261263AbVCaJIu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 04:08:50 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:user-agent:content-type:references:in-reply-to:subject:message-id:date;
        b=qQonwjSR+R65b8Y4/4Oj5I9z5cUjy/6W4IPp0iHlV2gI4lfHM0XUZg5c/dtBobEGINGMWKRSuACeLi0GlxipRCjajrm7F7bvBoQiMA3H8W6tH+ihYbrX61z4HeLMEMuygI6AmFrvqxP+OSRAkohU2l1xbnOoNN/WPSM3CkzEfqU=
From: Tejun Heo <htejun@gmail.com>
To: James.Bottomley@steeleye.com, axboe@suse.de
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
User-Agent: lksp 0.3
Content-Type: text/plain; charset=US-ASCII
References: <20050331090647.FEDC3964@htj.dyndns.org>
In-Reply-To: <20050331090647.FEDC3964@htj.dyndns.org>
Subject: Re: [PATCH scsi-misc-2.6 11/13] scsi: add reprep arg to scsi_requeue_command() and make it public
Message-ID: <20050331090647.ABDB1FF4@htj.dyndns.org>
Date: Thu, 31 Mar 2005 18:08:45 +0900 (KST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

11_scsi_make_requeue_command_public.patch

	Add reprep argument to scsi_requeue_command(), remove
	redundant q argument, add code to set cmd->state/owner, and
	make the function public.  This patch is preparation for
	consolidating requeue paths.

Signed-off-by: Tejun Heo <htejun@gmail.com>

 scsi_lib.c  |   23 ++++++++++++++---------
 scsi_priv.h |    1 +
 2 files changed, 15 insertions(+), 9 deletions(-)

Index: scsi-export/drivers/scsi/scsi_lib.c
===================================================================
--- scsi-export.orig/drivers/scsi/scsi_lib.c	2005-03-31 18:06:22.000000000 +0900
+++ scsi-export/drivers/scsi/scsi_lib.c	2005-03-31 18:06:22.000000000 +0900
@@ -466,8 +466,8 @@ void scsi_device_unbusy(struct scsi_devi
  *
  * Purpose:	Handle post-processing of completed commands.
  *
- * Arguments:	q	- queue to operate on
- *		cmd	- command that may need to be requeued.
+ * Arguments:	cmd	- command that may need to be requeued.
+ *		reprep	- needs to prep the command again?
  *
  * Returns:	Nothing
  *
@@ -478,11 +478,16 @@ void scsi_device_unbusy(struct scsi_devi
  *		we need to request the blocks that come after the bad
  *		sector.
  */
-static void scsi_requeue_command(struct request_queue *q, struct scsi_cmnd *cmd)
+void scsi_requeue_command(struct scsi_cmnd *cmd, int reprep)
 {
+	struct request_queue *q = cmd->device->request_queue;
 	unsigned long flags;
 
-	cmd->request->flags &= ~REQ_DONTPREP;
+	cmd->state = SCSI_STATE_MLQUEUE;
+	cmd->owner = SCSI_OWNER_MIDLEVEL;
+
+	if (reprep)
+		cmd->request->flags &= ~REQ_DONTPREP;
 	cmd->request->flags |= REQ_SOFTBARRIER;
 
 	spin_lock_irqsave(q->queue_lock, flags);
@@ -556,7 +561,7 @@ static struct scsi_cmnd *scsi_end_reques
 				 * leftovers in the front of the
 				 * queue, and goose the queue again.
 				 */
-				scsi_requeue_command(q, cmd);
+				scsi_requeue_command(cmd, 1);
 
 			return cmd;
 		}
@@ -818,7 +823,7 @@ void scsi_io_completion(struct scsi_cmnd
 				* media change, so we just retry the
 				* request and see what happens.  
 				*/
-				scsi_requeue_command(q, cmd);
+				scsi_requeue_command(cmd, 1);
 				return;
 			}
 			break;
@@ -839,7 +844,7 @@ void scsi_io_completion(struct scsi_cmnd
 				 * This will cause a retry with a 6-byte
 				 * command.
 				 */
-				scsi_requeue_command(q, cmd);
+				scsi_requeue_command(cmd, 1);
 				result = 0;
 			} else {
 				cmd = scsi_end_request(cmd, 0, this_count, 1);
@@ -852,7 +857,7 @@ void scsi_io_completion(struct scsi_cmnd
 			 * retry.
 			 */
 			if (sshdr.asc == 0x04 && sshdr.ascq == 0x01) {
-				scsi_requeue_command(q, cmd);
+				scsi_requeue_command(cmd, 1);
 				return;
 			}
 			printk(KERN_INFO "Device %s not ready.\n",
@@ -878,7 +883,7 @@ void scsi_io_completion(struct scsi_cmnd
 		 * recovery reasons.  Just retry the request
 		 * and see what happens.  
 		 */
-		scsi_requeue_command(q, cmd);
+		scsi_requeue_command(cmd, 1);
 		return;
 	}
 	if (result) {
Index: scsi-export/drivers/scsi/scsi_priv.h
===================================================================
--- scsi-export.orig/drivers/scsi/scsi_priv.h	2005-03-31 18:06:20.000000000 +0900
+++ scsi-export/drivers/scsi/scsi_priv.h	2005-03-31 18:06:22.000000000 +0900
@@ -96,6 +96,7 @@ extern int scsi_maybe_unblock_host(struc
 extern void scsi_setup_cmd_retry(struct scsi_cmnd *cmd);
 extern void scsi_device_unbusy(struct scsi_device *sdev);
 extern int scsi_queue_insert(struct scsi_cmnd *cmd, int reason);
+extern void scsi_requeue_command(struct scsi_cmnd *cmd, int reprep);
 extern void scsi_next_command(struct scsi_cmnd *cmd);
 extern void scsi_run_host_queues(struct Scsi_Host *shost);
 extern struct request_queue *scsi_alloc_queue(struct scsi_device *sdev);

