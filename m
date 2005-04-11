Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261683AbVDKDqr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261683AbVDKDqr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Apr 2005 23:46:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261684AbVDKDqj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Apr 2005 23:46:39 -0400
Received: from rproxy.gmail.com ([64.233.170.196]:54600 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261683AbVDKDpx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Apr 2005 23:45:53 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:user-agent:content-type:references:in-reply-to:subject:message-id:date;
        b=fv4+HKn6iTyqwh32RgyG5h1xHsARQZ/nhR0gfZUvM6BZKmL90KpXSZtXmNm67hgCmIN9Aysc4QTy39Xc/hRovZMIsrwTM8xy5l6PZqQUK4IPbK+VIvOHONbxLgRk2irBWp7N3C85tfUxrHQNxLOzdzMH70CCryI9IJSmO2zj1vc=
From: Tejun Heo <htejun@gmail.com>
To: James.Bottomley@steeleye.com, axboe@suse.de,
       Christoph Hellwig <hch@infradead.org>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
User-Agent: lksp 0.3
Content-Type: text/plain; charset=US-ASCII
References: <20050411034451.B75F3870@htj.dyndns.org>
In-Reply-To: <20050411034451.B75F3870@htj.dyndns.org>
Subject: Re: [PATCH scsi-misc-2.6 02/04] scsi: make scsi_queue_insert() use blk_requeue_request()
Message-ID: <20050411034451.A1163C31@htj.dyndns.org>
Date: Mon, 11 Apr 2005 12:45:47 +0900 (KST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

02_scsi_REQ_SPECIAL_semantic_scsi_queue_insert.patch

	scsi_queue_insert() used to use blk_insert_request() for
	requeueing requests.  This behavior depends on the unobvious
	behavior of blk_insert_request() setting REQ_SPECIAL and
	REQ_SOFTBARRIER when requeueing.  This patch makes
	scsi_queue_insert() use blk_requeue_request() and explicitly
	set REQ_SOFTBARRIER.  As REQ_SPECIAL now means special
	requests, the flag is not set on requeue.

	Note that scsi_queue_insert() now calls scsi_run_queue()
	itself, and the prototype of the function is added right above
	scsi_queue_insert().  This is temporary, as later requeue path
	consolidation patchset removes scsi_queue_insert().  By adding
	temporary prototype, we can do away with unnecessary changes.

Signed-off-by: Tejun Heo <htejun@gmail.com>

 scsi_lib.c |   24 ++++++++++++++----------
 1 files changed, 14 insertions(+), 10 deletions(-)

Index: scsi-reqfn-export/drivers/scsi/scsi_lib.c
===================================================================
--- scsi-reqfn-export.orig/drivers/scsi/scsi_lib.c	2005-04-11 12:27:07.000000000 +0900
+++ scsi-reqfn-export/drivers/scsi/scsi_lib.c	2005-04-11 12:27:07.000000000 +0900
@@ -96,6 +96,8 @@ int scsi_insert_special_req(struct scsi_
 	return 0;
 }
 
+static void scsi_run_queue(struct request_queue *q);
+
 /*
  * Function:    scsi_queue_insert()
  *
@@ -119,6 +121,8 @@ int scsi_queue_insert(struct scsi_cmnd *
 {
 	struct Scsi_Host *host = cmd->device->host;
 	struct scsi_device *device = cmd->device;
+	struct request_queue *q = device->request_queue;
+	unsigned long flags;
 
 	SCSI_LOG_MLQUEUE(1,
 		 printk("Inserting command %p into mlqueue\n", cmd));
@@ -154,17 +158,17 @@ int scsi_queue_insert(struct scsi_cmnd *
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
 

