Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261188AbVDUCnp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261188AbVDUCnp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Apr 2005 22:43:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261194AbVDUCnp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Apr 2005 22:43:45 -0400
Received: from rproxy.gmail.com ([64.233.170.201]:60043 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261188AbVDUCni (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Apr 2005 22:43:38 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=NTvVAHAzEs01fkh2SOSjNOtCzSOpxXWmZGkvtkasTfY6gBptbDm5gme3qO7kNHP/TdxLeJo9bNkqRWGbyTNmEwbzz7Px81bH0zr2CFdM4Uoi8hH0MMVxPKxv7lZod8VL95KUmU14uK5FLjdMGCvnuckWYT/wr0LqhVZPuY/V75Q=
Date: Thu, 21 Apr 2005 11:43:33 +0900
From: Tejun Heo <htejun@gmail.com>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: Jens Axboe <axboe@suse.de>, Christoph Hellwig <hch@infradead.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH scsi-misc-2.6 03/05] scsi: make scsi_queue_insert() use blk_requeue_request()
Message-ID: <20050421024333.GA19112@htj.dyndns.org>
References: <20050419231435.D85F89C0@htj.dyndns.org> <20050419231435.329FA30B@htj.dyndns.org> <1114039446.5933.17.camel@mulgrave> <4266F1D0.2060003@gmail.com> <1114049793.5000.4.camel@mulgrave>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1114049793.5000.4.camel@mulgrave>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 Hello, James.

 This is the modified patch with the comment (slightly modified).
With this patch, the next patch in this patchset complains about line
offset but it's okay.

 Thanks.


 Signed-off-by: Tejun Heo <htejun@gmail.com>


Index: scsi-reqfn-export/drivers/scsi/scsi_lib.c
===================================================================
--- scsi-reqfn-export.orig/drivers/scsi/scsi_lib.c	2005-04-21 11:33:13.000000000 +0900
+++ scsi-reqfn-export/drivers/scsi/scsi_lib.c	2005-04-21 11:39:17.000000000 +0900
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
@@ -154,17 +158,22 @@ int scsi_queue_insert(struct scsi_cmnd *
 	scsi_device_unbusy(device);
 
 	/*
-	 * Insert this command at the head of the queue for it's device.
-	 * It will go before all other commands that are already in the queue.
+	 * Requeue this command.  It will go before all other commands
+	 * that are already in the queue.
 	 *
 	 * NOTE: there is magic here about the way the queue is plugged if
 	 * we have no outstanding commands.
 	 * 
-	 * Although this *doesn't* plug the queue, it does call the request
+	 * Although we *don't* plug the queue, we call the request
 	 * function.  The SCSI request function detects the blocked condition
 	 * and plugs the queue appropriately.
-	 */
-	blk_insert_request(device->request_queue, cmd->request, 1, cmd, 1);
+         */
+	spin_lock_irqsave(q->queue_lock, flags);
+	blk_requeue_request(q, cmd->request);
+	spin_unlock_irqrestore(q->queue_lock, flags);
+
+	scsi_run_queue(q);
+
 	return 0;
 }
 
