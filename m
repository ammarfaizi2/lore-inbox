Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261687AbVDKDsd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261687AbVDKDsd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Apr 2005 23:48:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261684AbVDKDrQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Apr 2005 23:47:16 -0400
Received: from wproxy.gmail.com ([64.233.184.195]:24949 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261690AbVDKDqD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Apr 2005 23:46:03 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:user-agent:content-type:references:in-reply-to:subject:message-id:date;
        b=KFSdDgFxkHfG2lGNIjc9jn5iKGJVBYOsoGK8rQfCliwr+6mHYCO8URAJhvPZ7E2HsK4Wj6o1loavYKWdf+boC2puOhk2CAD/1ZXppSlvZnsVU2oVZgdQpIEVwaKt1KP9T7ouai/y3OL9gJ040PQVXLHwKwg4ofSysXipf2tLLeQ=
From: Tejun Heo <htejun@gmail.com>
To: James.Bottomley@steeleye.com, axboe@suse.de,
       Christoph Hellwig <hch@infradead.org>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
User-Agent: lksp 0.3
Content-Type: text/plain; charset=US-ASCII
References: <20050411034451.B75F3870@htj.dyndns.org>
In-Reply-To: <20050411034451.B75F3870@htj.dyndns.org>
Subject: Re: [PATCH scsi-misc-2.6 04/04] scsi: remove requeue feature from blk_insert_request()
Message-ID: <20050411034451.9E89A385@htj.dyndns.org>
Date: Mon, 11 Apr 2005 12:45:58 +0900 (KST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

04_scsi_blk_insert_request_no_requeue.patch

	blk_insert_request() has a unobivous feature of requeuing a
	request setting REQ_SPECIAL|REQ_SOFTBARRIER.  SCSI midlayer
	was the only user and as previous patches removed the usage,
	remove the feature from blk_insert_request().  Only special
	requests should be queued with blk_insert_request().  All
	requeueing should go through blk_requeue_request().

Signed-off-by: Tejun Heo <htejun@gmail.com>

 drivers/block/ll_rw_blk.c |   20 ++++++--------------
 drivers/block/paride/pd.c |    2 +-
 drivers/block/sx8.c       |    4 ++--
 drivers/scsi/scsi_lib.c   |    2 +-
 include/linux/blkdev.h    |    2 +-
 5 files changed, 11 insertions(+), 19 deletions(-)

Index: scsi-reqfn-export/drivers/block/ll_rw_blk.c
===================================================================
--- scsi-reqfn-export.orig/drivers/block/ll_rw_blk.c	2005-04-11 12:25:15.000000000 +0900
+++ scsi-reqfn-export/drivers/block/ll_rw_blk.c	2005-04-11 12:27:08.000000000 +0900
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
Index: scsi-reqfn-export/drivers/block/paride/pd.c
===================================================================
--- scsi-reqfn-export.orig/drivers/block/paride/pd.c	2005-04-11 12:25:15.000000000 +0900
+++ scsi-reqfn-export/drivers/block/paride/pd.c	2005-04-11 12:27:08.000000000 +0900
@@ -723,7 +723,7 @@ static int pd_special_command(struct pd_
 	rq.ref_count = 1;
 	rq.waiting = &wait;
 	rq.end_io = blk_end_sync_rq;
-	blk_insert_request(disk->gd->queue, &rq, 0, func, 0);
+	blk_insert_request(disk->gd->queue, &rq, 0, func);
 	wait_for_completion(&wait);
 	rq.waiting = NULL;
 	if (rq.errors)
Index: scsi-reqfn-export/drivers/block/sx8.c
===================================================================
--- scsi-reqfn-export.orig/drivers/block/sx8.c	2005-04-11 12:25:15.000000000 +0900
+++ scsi-reqfn-export/drivers/block/sx8.c	2005-04-11 12:27:08.000000000 +0900
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
Index: scsi-reqfn-export/drivers/scsi/scsi_lib.c
===================================================================
--- scsi-reqfn-export.orig/drivers/scsi/scsi_lib.c	2005-04-11 12:27:08.000000000 +0900
+++ scsi-reqfn-export/drivers/scsi/scsi_lib.c	2005-04-11 12:27:08.000000000 +0900
@@ -92,7 +92,7 @@ int scsi_insert_special_req(struct scsi_
 	 */
 	sreq->sr_request->flags &= ~REQ_DONTPREP;
 	blk_insert_request(sreq->sr_device->request_queue, sreq->sr_request,
-		       	   at_head, sreq, 0);
+		       	   at_head, sreq);
 	return 0;
 }
 
Index: scsi-reqfn-export/include/linux/blkdev.h
===================================================================
--- scsi-reqfn-export.orig/include/linux/blkdev.h	2005-04-11 12:25:15.000000000 +0900
+++ scsi-reqfn-export/include/linux/blkdev.h	2005-04-11 12:27:08.000000000 +0900
@@ -541,7 +541,7 @@ extern void blk_end_sync_rq(struct reque
 extern void blk_attempt_remerge(request_queue_t *, struct request *);
 extern void __blk_attempt_remerge(request_queue_t *, struct request *);
 extern struct request *blk_get_request(request_queue_t *, int, int);
-extern void blk_insert_request(request_queue_t *, struct request *, int, void *, int);
+extern void blk_insert_request(request_queue_t *, struct request *, int, void *);
 extern void blk_requeue_request(request_queue_t *, struct request *);
 extern void blk_plug_device(request_queue_t *);
 extern int blk_remove_plug(request_queue_t *);

