Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262438AbVDLM5y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262438AbVDLM5y (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 08:57:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262444AbVDLM5q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 08:57:46 -0400
Received: from rproxy.gmail.com ([64.233.170.192]:61856 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262427AbVDLMwh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 08:52:37 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:user-agent:content-type:references:in-reply-to:subject:message-id:date;
        b=dIbgp08bdPu0slQ5gVbVkfVs88+1/807pZtCN0jidNkoP9/YB7mv5NRrA0Vpn+lEhdf1b4szsuyI9IFptZSBCE7Oea/iZGCKWWIJb/A0HjE7cc5/sqArxoN4vPb+lm7kd4TzLvr3Lm0RA2vERH4t+WRj3b5l0O90CBkDCw8xai0=
From: Tejun Heo <htejun@gmail.com>
To: James.Bottomley@steeleye.com, axboe@suse.de,
       Christoph Hellwig <hch@infradead.org>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
User-Agent: lksp 0.3
Content-Type: text/plain; charset=US-ASCII
References: <20050412125219.88E5C1F6@htj.dyndns.org>
In-Reply-To: <20050412125219.88E5C1F6@htj.dyndns.org>
Subject: Re: [PATCH scsi-misc-2.6 01/07] scsi: update and make public scsi_requeue_command()
Message-ID: <20050412125219.935A53FF@htj.dyndns.org>
Date: Tue, 12 Apr 2005 21:52:26 +0900 (KST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

01_scsi_requeue_make_requeue_command_public.patch

	This patch makes the following changes to
	scsi_requeue_command() and make the function public.

	* remove redundant argument @q
	* remove REQ_DONTPREP clearing
	* add state/owner setting

	A new inline function scsi_requeue_command_reprep() is defined
	and used for the original users of scsi_requeue_command().

	Using a wrapper function for reprep cases is suggested by
	Christoph Hellwig.

Signed-off-by: Tejun Heo <htejun@gmail.com>

 scsi_lib.c  |   42 +++++++++++++++++++++++++-----------------
 scsi_priv.h |    1 +
 2 files changed, 26 insertions(+), 17 deletions(-)

Index: scsi-reqfn-export/drivers/scsi/scsi_lib.c
===================================================================
--- scsi-reqfn-export.orig/drivers/scsi/scsi_lib.c	2005-04-12 21:50:11.000000000 +0900
+++ scsi-reqfn-export/drivers/scsi/scsi_lib.c	2005-04-12 21:50:11.000000000 +0900
@@ -468,23 +468,24 @@ static void scsi_run_queue(struct reques
  *
  * Purpose:	Handle post-processing of completed commands.
  *
- * Arguments:	q	- queue to operate on
- *		cmd	- command that may need to be requeued.
+ * Arguments:	cmd	- command that need to be requeued.
  *
  * Returns:	Nothing
  *
- * Notes:	After command completion, there may be blocks left
- *		over which weren't finished by the previous command
- *		this can be for a number of reasons - the main one is
- *		I/O errors in the middle of the request, in which case
- *		we need to request the blocks that come after the bad
- *		sector.
+ * Notes:	After command completion, a command may need to be
+ *		requeued due to error or unfinished blocks.  All
+ *		requeueing after command issueing goes through this
+ *		function.  The caller is expected to have performed
+ *		scsi_device_unbusy() before invoking this function.
  */
-static void scsi_requeue_command(struct request_queue *q, struct scsi_cmnd *cmd)
+void scsi_requeue_command(struct scsi_cmnd *cmd)
 {
+	struct request_queue *q = cmd->device->request_queue;
 	unsigned long flags;
 
-	cmd->request->flags &= ~REQ_DONTPREP;
+	cmd->state = SCSI_STATE_MLQUEUE;
+	cmd->owner = SCSI_OWNER_MIDLEVEL;
+
 	cmd->request->flags |= REQ_SOFTBARRIER;
 
 	spin_lock_irqsave(q->queue_lock, flags);
@@ -494,6 +495,12 @@ static void scsi_requeue_command(struct 
 	scsi_run_queue(q);
 }
 
+static inline void scsi_requeue_command_reprep(struct scsi_cmnd *cmd)
+{
+	cmd->request->flags &= ~REQ_DONTPREP;
+	scsi_requeue_command(cmd);
+}
+
 void scsi_next_command(struct scsi_cmnd *cmd)
 {
 	struct request_queue *q = cmd->device->request_queue;
@@ -558,7 +565,7 @@ static struct scsi_cmnd *scsi_end_reques
 				 * leftovers in the front of the
 				 * queue, and goose the queue again.
 				 */
-				scsi_requeue_command(q, cmd);
+				scsi_requeue_command_reprep(cmd);
 
 			return cmd;
 		}
@@ -697,8 +704,9 @@ static void scsi_release_buffers(struct 
  *		   function will be goosed.  If we are not done, then
  *		   scsi_end_request will directly goose the queue.
  *
- *		b) We can just use scsi_requeue_command() here.  This would
- *		   be used if we just wanted to retry, for example.
+ *		b) We can just use scsi_requeue_command_reprep() here.
+ *		   This would be used if we just wanted to retry, for
+ *		   example.
  */
 void scsi_io_completion(struct scsi_cmnd *cmd, unsigned int good_bytes,
 			unsigned int block_bytes)
@@ -820,7 +828,7 @@ void scsi_io_completion(struct scsi_cmnd
 				* media change, so we just retry the
 				* request and see what happens.  
 				*/
-				scsi_requeue_command(q, cmd);
+				scsi_requeue_command_reprep(cmd);
 				return;
 			}
 			break;
@@ -841,7 +849,7 @@ void scsi_io_completion(struct scsi_cmnd
 				 * This will cause a retry with a 6-byte
 				 * command.
 				 */
-				scsi_requeue_command(q, cmd);
+				scsi_requeue_command_reprep(cmd);
 				result = 0;
 			} else {
 				cmd = scsi_end_request(cmd, 0, this_count, 1);
@@ -854,7 +862,7 @@ void scsi_io_completion(struct scsi_cmnd
 			 * retry.
 			 */
 			if (sshdr.asc == 0x04 && sshdr.ascq == 0x01) {
-				scsi_requeue_command(q, cmd);
+				scsi_requeue_command_reprep(cmd);
 				return;
 			}
 			printk(KERN_INFO "Device %s not ready.\n",
@@ -880,7 +888,7 @@ void scsi_io_completion(struct scsi_cmnd
 		 * recovery reasons.  Just retry the request
 		 * and see what happens.  
 		 */
-		scsi_requeue_command(q, cmd);
+		scsi_requeue_command_reprep(cmd);
 		return;
 	}
 	if (result) {
Index: scsi-reqfn-export/drivers/scsi/scsi_priv.h
===================================================================
--- scsi-reqfn-export.orig/drivers/scsi/scsi_priv.h	2005-04-12 21:50:11.000000000 +0900
+++ scsi-reqfn-export/drivers/scsi/scsi_priv.h	2005-04-12 21:50:11.000000000 +0900
@@ -95,6 +95,7 @@ extern int scsi_maybe_unblock_host(struc
 extern void scsi_setup_cmd_retry(struct scsi_cmnd *cmd);
 extern void scsi_device_unbusy(struct scsi_device *sdev);
 extern int scsi_queue_insert(struct scsi_cmnd *cmd, int reason);
+extern void scsi_requeue_command(struct scsi_cmnd *cmd);
 extern void scsi_next_command(struct scsi_cmnd *cmd);
 extern void scsi_run_host_queues(struct Scsi_Host *shost);
 extern struct request_queue *scsi_alloc_queue(struct scsi_device *sdev);

