Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261220AbVCaJOQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261220AbVCaJOQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 04:14:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261212AbVCaJOQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 04:14:16 -0500
Received: from wproxy.gmail.com ([64.233.184.198]:12584 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261220AbVCaJIA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 04:08:00 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:user-agent:content-type:references:in-reply-to:subject:message-id:date;
        b=Ky9VpiTZJvvtEs2Ms1QS8xp2pCOVJh0AT+m+Ly0q3ut0s2ykG82Xe7uHtoMp3kjP4nmvekCzPvC2b1pJp/bJ06kUQEZCO9xI+Z3kG8/2wU6C9uy1Y4KqVSCJeIQjVfXSG1GdmxdLB05980PBmtYjahI0FqfSJvxVr1TPLEpC6ZE=
From: Tejun Heo <htejun@gmail.com>
To: James.Bottomley@steeleye.com, axboe@suse.de
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
User-Agent: lksp 0.3
Content-Type: text/plain; charset=US-ASCII
References: <20050331090647.FEDC3964@htj.dyndns.org>
In-Reply-To: <20050331090647.FEDC3964@htj.dyndns.org>
Subject: Re: [PATCH scsi-misc-2.6 01/13] scsi: don't use blk_insert_request() for requeueing
Message-ID: <20050331090647.BA0001D5@htj.dyndns.org>
Date: Thu, 31 Mar 2005 18:07:55 +0900 (KST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

01_scsi_no_REQ_SPECIAL_on_requeue.patch

	blk_insert_request() has 'reinsert' argument, which, when set,
	turns on REQ_SPECIAL and REQ_SOFTBARRIER and requeues the
	request.  SCSI midlayer was the only user of this feature and
	all requeued requests become special requests defeating
	quiesce state.  This patch makes scsi midlayer use
	blk_requeue_request() for requeueing and removes 'reinsert'
	feature from blk_insert_request().

	Note: In drivers/scsi/scsi_lib.c, scsi_single_lun_run() and
	scsi_run_queue() are moved upward unchanged.

Signed-off-by: Tejun Heo <htejun@gmail.com>

 drivers/block/ll_rw_blk.c |   20 +--
 drivers/block/paride/pd.c |    2 
 drivers/block/sx8.c       |    4 
 drivers/scsi/scsi_lib.c   |  238 +++++++++++++++++++++++-----------------------
 include/linux/blkdev.h    |    2 
 5 files changed, 133 insertions(+), 133 deletions(-)

Index: scsi-export/drivers/block/ll_rw_blk.c
===================================================================
--- scsi-export.orig/drivers/block/ll_rw_blk.c	2005-03-31 17:42:05.000000000 +0900
+++ scsi-export/drivers/block/ll_rw_blk.c	2005-03-31 18:06:19.000000000 +0900
@@ -2028,7 +2028,6 @@ EXPORT_SYMBOL(blk_requeue_request);
  * @rq:		request to be inserted
  * @at_head:	insert request at head or tail of queue
  * @data:	private data
- * @reinsert:	true if request it a reinsertion of previously processed one
  *
  * Description:
  *    Many block devices need to execute commands asynchronously, so they don't
@@ -2043,8 +2042,9 @@ EXPORT_SYMBOL(blk_requeue_request);
  *    host that is unable to accept a particular command.
  */
 void blk_insert_request(request_queue_t *q, struct request *rq,
-			int at_head, void *data, int reinsert)
+			int at_head, void *data)
 {
+	int where = at_head ? ELEVATOR_INSERT_FRONT : ELEVATOR_INSERT_BACK;
 	unsigned long flags;
 
 	/*
@@ -2061,20 +2061,12 @@ void blk_insert_request(request_queue_t 
 	/*
 	 * If command is tagged, release the tag
 	 */
-	if (reinsert)
-		blk_requeue_request(q, rq);
-	else {
-		int where = ELEVATOR_INSERT_BACK;
+	if (blk_rq_tagged(rq))
+		blk_queue_end_tag(q, rq);
 
-		if (at_head)
-			where = ELEVATOR_INSERT_FRONT;
+	drive_stat_acct(rq, rq->nr_sectors, 1);
+	__elv_add_request(q, rq, where, 0);
 
-		if (blk_rq_tagged(rq))
-			blk_queue_end_tag(q, rq);
-
-		drive_stat_acct(rq, rq->nr_sectors, 1);
-		__elv_add_request(q, rq, where, 0);
-	}
 	if (blk_queue_plugged(q))
 		__generic_unplug_device(q);
 	else
Index: scsi-export/drivers/block/paride/pd.c
===================================================================
--- scsi-export.orig/drivers/block/paride/pd.c	2005-03-31 17:42:05.000000000 +0900
+++ scsi-export/drivers/block/paride/pd.c	2005-03-31 18:06:19.000000000 +0900
@@ -723,7 +723,7 @@ static int pd_special_command(struct pd_
 	rq.ref_count = 1;
 	rq.waiting = &wait;
 	rq.end_io = blk_end_sync_rq;
-	blk_insert_request(disk->gd->queue, &rq, 0, func, 0);
+	blk_insert_request(disk->gd->queue, &rq, 0, func);
 	wait_for_completion(&wait);
 	rq.waiting = NULL;
 	if (rq.errors)
Index: scsi-export/drivers/block/sx8.c
===================================================================
--- scsi-export.orig/drivers/block/sx8.c	2005-03-31 17:42:05.000000000 +0900
+++ scsi-export/drivers/block/sx8.c	2005-03-31 18:06:19.000000000 +0900
@@ -614,7 +614,7 @@ static int carm_array_info (struct carm_
 	spin_unlock_irq(&host->lock);
 
 	DPRINTK("blk_insert_request, tag == %u\n", idx);
-	blk_insert_request(host->oob_q, crq->rq, 1, crq, 0);
+	blk_insert_request(host->oob_q, crq->rq, 1, crq);
 
 	return 0;
 
@@ -653,7 +653,7 @@ static int carm_send_special (struct car
 	crq->msg_bucket = (u32) rc;
 
 	DPRINTK("blk_insert_request, tag == %u\n", idx);
-	blk_insert_request(host->oob_q, crq->rq, 1, crq, 0);
+	blk_insert_request(host->oob_q, crq->rq, 1, crq);
 
 	return 0;
 }
Index: scsi-export/drivers/scsi/scsi_lib.c
===================================================================
--- scsi-export.orig/drivers/scsi/scsi_lib.c	2005-03-31 17:42:05.000000000 +0900
+++ scsi-export/drivers/scsi/scsi_lib.c	2005-03-31 18:06:19.000000000 +0900
@@ -65,6 +65,109 @@ struct scsi_host_sg_pool scsi_sg_pools[]
 
 
 /*
+ * Called for single_lun devices on IO completion. Clear starget_sdev_user,
+ * and call blk_run_queue for all the scsi_devices on the target -
+ * including current_sdev first.
+ *
+ * Called with *no* scsi locks held.
+ */
+static void scsi_single_lun_run(struct scsi_device *current_sdev)
+{
+	struct Scsi_Host *shost = current_sdev->host;
+	struct scsi_device *sdev, *tmp;
+	struct scsi_target *starget = scsi_target(current_sdev);
+	unsigned long flags;
+
+	spin_lock_irqsave(shost->host_lock, flags);
+	starget->starget_sdev_user = NULL;
+	spin_unlock_irqrestore(shost->host_lock, flags);
+
+	/*
+	 * Call blk_run_queue for all LUNs on the target, starting with
+	 * current_sdev. We race with others (to set starget_sdev_user),
+	 * but in most cases, we will be first. Ideally, each LU on the
+	 * target would get some limited time or requests on the target.
+	 */
+	blk_run_queue(current_sdev->request_queue);
+
+	spin_lock_irqsave(shost->host_lock, flags);
+	if (starget->starget_sdev_user)
+		goto out;
+	list_for_each_entry_safe(sdev, tmp, &starget->devices,
+			same_target_siblings) {
+		if (sdev == current_sdev)
+			continue;
+		if (scsi_device_get(sdev))
+			continue;
+
+		spin_unlock_irqrestore(shost->host_lock, flags);
+		blk_run_queue(sdev->request_queue);
+		spin_lock_irqsave(shost->host_lock, flags);
+	
+		scsi_device_put(sdev);
+	}
+ out:
+	spin_unlock_irqrestore(shost->host_lock, flags);
+}
+
+/*
+ * Function:	scsi_run_queue()
+ *
+ * Purpose:	Select a proper request queue to serve next
+ *
+ * Arguments:	q	- last request's queue
+ *
+ * Returns:     Nothing
+ *
+ * Notes:	The previous command was completely finished, start
+ *		a new one if possible.
+ */
+static void scsi_run_queue(struct request_queue *q)
+{
+	struct scsi_device *sdev = q->queuedata;
+	struct Scsi_Host *shost = sdev->host;
+	unsigned long flags;
+
+	if (sdev->single_lun)
+		scsi_single_lun_run(sdev);
+
+	spin_lock_irqsave(shost->host_lock, flags);
+	while (!list_empty(&shost->starved_list) &&
+	       !shost->host_blocked && !shost->host_self_blocked &&
+		!((shost->can_queue > 0) &&
+		  (shost->host_busy >= shost->can_queue))) {
+		/*
+		 * As long as shost is accepting commands and we have
+		 * starved queues, call blk_run_queue. scsi_request_fn
+		 * drops the queue_lock and can add us back to the
+		 * starved_list.
+		 *
+		 * host_lock protects the starved_list and starved_entry.
+		 * scsi_request_fn must get the host_lock before checking
+		 * or modifying starved_list or starved_entry.
+		 */
+		sdev = list_entry(shost->starved_list.next,
+					  struct scsi_device, starved_entry);
+		list_del_init(&sdev->starved_entry);
+		spin_unlock_irqrestore(shost->host_lock, flags);
+
+		blk_run_queue(sdev->request_queue);
+
+		spin_lock_irqsave(shost->host_lock, flags);
+		if (unlikely(!list_empty(&sdev->starved_entry)))
+			/*
+			 * sdev lost a race, and was put back on the
+			 * starved list. This is unlikely but without this
+			 * in theory we could loop forever.
+			 */
+			break;
+	}
+	spin_unlock_irqrestore(shost->host_lock, flags);
+
+	blk_run_queue(q);
+}
+
+/*
  * Function:    scsi_insert_special_req()
  *
  * Purpose:     Insert pre-formed request into request queue.
@@ -92,7 +195,7 @@ int scsi_insert_special_req(struct scsi_
 	 */
 	sreq->sr_request->flags &= ~REQ_DONTPREP;
 	blk_insert_request(sreq->sr_device->request_queue, sreq->sr_request,
-		       	   at_head, sreq, 0);
+		       	   at_head, sreq);
 	return 0;
 }
 
@@ -119,6 +222,8 @@ int scsi_queue_insert(struct scsi_cmnd *
 {
 	struct Scsi_Host *host = cmd->device->host;
 	struct scsi_device *device = cmd->device;
+	struct request_queue *q = device->request_queue;
+	unsigned long flags;
 
 	SCSI_LOG_MLQUEUE(1,
 		 printk("Inserting command %p into mlqueue\n", cmd));
@@ -160,17 +265,17 @@ int scsi_queue_insert(struct scsi_cmnd *
 	scsi_device_unbusy(device);
 
 	/*
-	 * Insert this command at the head of the queue for it's device.
-	 * It will go before all other commands that are already in the queue.
-	 *
-	 * NOTE: there is magic here about the way the queue is plugged if
-	 * we have no outstanding commands.
-	 * 
-	 * Although this *doesn't* plug the queue, it does call the request
-	 * function.  The SCSI request function detects the blocked condition
-	 * and plugs the queue appropriately.
+	 * Requeue the command.  Turn on REQ_SOFTBARRIER to prevent
+	 * other requests from passing this request.
 	 */
-	blk_insert_request(device->request_queue, cmd->request, 1, cmd, 1);
+	cmd->request->flags |= REQ_SOFTBARRIER;
+
+	spin_lock_irqsave(q->queue_lock, flags);
+	blk_requeue_request(q, cmd->request);
+	spin_unlock_irqrestore(q->queue_lock, flags);
+
+	scsi_run_queue(q);
+
 	return 0;
 }
 
@@ -355,109 +460,6 @@ void scsi_device_unbusy(struct scsi_devi
 }
 
 /*
- * Called for single_lun devices on IO completion. Clear starget_sdev_user,
- * and call blk_run_queue for all the scsi_devices on the target -
- * including current_sdev first.
- *
- * Called with *no* scsi locks held.
- */
-static void scsi_single_lun_run(struct scsi_device *current_sdev)
-{
-	struct Scsi_Host *shost = current_sdev->host;
-	struct scsi_device *sdev, *tmp;
-	struct scsi_target *starget = scsi_target(current_sdev);
-	unsigned long flags;
-
-	spin_lock_irqsave(shost->host_lock, flags);
-	starget->starget_sdev_user = NULL;
-	spin_unlock_irqrestore(shost->host_lock, flags);
-
-	/*
-	 * Call blk_run_queue for all LUNs on the target, starting with
-	 * current_sdev. We race with others (to set starget_sdev_user),
-	 * but in most cases, we will be first. Ideally, each LU on the
-	 * target would get some limited time or requests on the target.
-	 */
-	blk_run_queue(current_sdev->request_queue);
-
-	spin_lock_irqsave(shost->host_lock, flags);
-	if (starget->starget_sdev_user)
-		goto out;
-	list_for_each_entry_safe(sdev, tmp, &starget->devices,
-			same_target_siblings) {
-		if (sdev == current_sdev)
-			continue;
-		if (scsi_device_get(sdev))
-			continue;
-
-		spin_unlock_irqrestore(shost->host_lock, flags);
-		blk_run_queue(sdev->request_queue);
-		spin_lock_irqsave(shost->host_lock, flags);
-	
-		scsi_device_put(sdev);
-	}
- out:
-	spin_unlock_irqrestore(shost->host_lock, flags);
-}
-
-/*
- * Function:	scsi_run_queue()
- *
- * Purpose:	Select a proper request queue to serve next
- *
- * Arguments:	q	- last request's queue
- *
- * Returns:     Nothing
- *
- * Notes:	The previous command was completely finished, start
- *		a new one if possible.
- */
-static void scsi_run_queue(struct request_queue *q)
-{
-	struct scsi_device *sdev = q->queuedata;
-	struct Scsi_Host *shost = sdev->host;
-	unsigned long flags;
-
-	if (sdev->single_lun)
-		scsi_single_lun_run(sdev);
-
-	spin_lock_irqsave(shost->host_lock, flags);
-	while (!list_empty(&shost->starved_list) &&
-	       !shost->host_blocked && !shost->host_self_blocked &&
-		!((shost->can_queue > 0) &&
-		  (shost->host_busy >= shost->can_queue))) {
-		/*
-		 * As long as shost is accepting commands and we have
-		 * starved queues, call blk_run_queue. scsi_request_fn
-		 * drops the queue_lock and can add us back to the
-		 * starved_list.
-		 *
-		 * host_lock protects the starved_list and starved_entry.
-		 * scsi_request_fn must get the host_lock before checking
-		 * or modifying starved_list or starved_entry.
-		 */
-		sdev = list_entry(shost->starved_list.next,
-					  struct scsi_device, starved_entry);
-		list_del_init(&sdev->starved_entry);
-		spin_unlock_irqrestore(shost->host_lock, flags);
-
-		blk_run_queue(sdev->request_queue);
-
-		spin_lock_irqsave(shost->host_lock, flags);
-		if (unlikely(!list_empty(&sdev->starved_entry)))
-			/*
-			 * sdev lost a race, and was put back on the
-			 * starved list. This is unlikely but without this
-			 * in theory we could loop forever.
-			 */
-			break;
-	}
-	spin_unlock_irqrestore(shost->host_lock, flags);
-
-	blk_run_queue(q);
-}
-
-/*
  * Function:	scsi_requeue_command()
  *
  * Purpose:	Handle post-processing of completed commands.
@@ -476,8 +478,14 @@ static void scsi_run_queue(struct reques
  */
 static void scsi_requeue_command(struct request_queue *q, struct scsi_cmnd *cmd)
 {
+	unsigned long flags;
+
 	cmd->request->flags &= ~REQ_DONTPREP;
-	blk_insert_request(q, cmd->request, 1, cmd, 1);
+	cmd->request->flags |= REQ_SOFTBARRIER;
+
+	spin_lock_irqsave(q->queue_lock, flags);
+	blk_requeue_request(q, cmd->request);
+	spin_unlock_irqrestore(q->queue_lock, flags);
 
 	scsi_run_queue(q);
 }
Index: scsi-export/include/linux/blkdev.h
===================================================================
--- scsi-export.orig/include/linux/blkdev.h	2005-03-31 17:42:05.000000000 +0900
+++ scsi-export/include/linux/blkdev.h	2005-03-31 18:06:19.000000000 +0900
@@ -541,7 +541,7 @@ extern void blk_end_sync_rq(struct reque
 extern void blk_attempt_remerge(request_queue_t *, struct request *);
 extern void __blk_attempt_remerge(request_queue_t *, struct request *);
 extern struct request *blk_get_request(request_queue_t *, int, int);
-extern void blk_insert_request(request_queue_t *, struct request *, int, void *, int);
+extern void blk_insert_request(request_queue_t *, struct request *, int, void *);
 extern void blk_requeue_request(request_queue_t *, struct request *);
 extern void blk_plug_device(request_queue_t *);
 extern int blk_remove_plug(request_queue_t *);

