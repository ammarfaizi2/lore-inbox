Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262720AbVCWC27@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262720AbVCWC27 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 21:28:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262719AbVCWCVp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 21:21:45 -0500
Received: from rproxy.gmail.com ([64.233.170.205]:4743 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262720AbVCWCO7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 21:14:59 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:user-agent:content-type:references:in-reply-to:subject:message-id:date;
        b=sQjQviitsKjApd+OGP2Wxw6CrZdUm39EA3PBDf0dqOx1NfyNgfjjKzBrjBFFIWexqzjw7TmdWi5tYphLVXOkEHe7GAv+iKwobEaNAK1TYtqx7/LhiEOSym4t6Q2bH/q96c3W2a+waIK3vmpSiUFJUk7/UxpDK7bBMOguV/WOCDY=
From: Tejun Heo <htejun@gmail.com>
To: James.Bottomley@steeleye.com, axboe@suse.de
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
User-Agent: lksp 0.3
Content-Type: text/plain; charset=US-ASCII
References: <20050323021335.960F95F8@htj.dyndns.org>
In-Reply-To: <20050323021335.960F95F8@htj.dyndns.org>
Subject: Re: [PATCH scsi-misc-2.6 07/08] scsi: remove bogus {get|put}_device() calls
Message-ID: <20050323021335.0D9E25EE@htj.dyndns.org>
Date: Wed, 23 Mar 2005 11:14:54 +0900 (KST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

07_scsi_refcnt_cleanup.patch

	SCSI request submission paths can be categorized like the
	following.

	* through high-level driver (sd, st, sg...)
		+ requests (fs / pc)
		+ ioctls
		+ flushes (issue_flush / barrier rqs)
		+ backing dev (unplug fn / field referencing)
		+ high-level specific (init / revalidation...)
	* through scsi-midlayer
		+ midlevel specific (init...)
		+ transport specific (domain validations...)

	All accesses either

	* open high-level driver before submitting requests and
	  closes with no request left.
	* get_device() before submitting requests and put_device()
          with no request left.

	So, basically, SCSI high-level object (scsi_disk) and
	mid-level object (scsi_device) are reference counted by users,
	not the requests they submit.  Reference count cannot go zero
	with active users and users cannot access the object once the
	reference count reaches zero.

	So, the {get/put}_device() calls in scsi_get_command() and
	scsi_request_fn() are bogus and misleading.  In addition,
	get_device() cannot synchronize 1->0 and 0->1 transitions and
	always returns the device pointer given as the argument.  The
	== NULL tests are just misleading.

Signed-off-by: Tejun Heo <htejun@gmail.com>

 scsi.c     |    9 +--------
 scsi_lib.c |   12 +-----------
 2 files changed, 2 insertions(+), 19 deletions(-)

Index: scsi-export/drivers/scsi/scsi.c
===================================================================
--- scsi-export.orig/drivers/scsi/scsi.c	2005-03-23 09:40:11.000000000 +0900
+++ scsi-export/drivers/scsi/scsi.c	2005-03-23 09:40:11.000000000 +0900
@@ -246,10 +246,6 @@ struct scsi_cmnd *scsi_get_command(struc
 {
 	struct scsi_cmnd *cmd;
 
-	/* Bail if we can't get a reference to the device */
-	if (!get_device(&dev->sdev_gendev))
-		return NULL;
-
 	cmd = __scsi_get_command(dev->host, gfp_mask);
 
 	if (likely(cmd != NULL)) {
@@ -264,8 +260,7 @@ struct scsi_cmnd *scsi_get_command(struc
 		spin_lock_irqsave(&dev->list_lock, flags);
 		list_add_tail(&cmd->list, &dev->cmd_list);
 		spin_unlock_irqrestore(&dev->list_lock, flags);
-	} else
-		put_device(&dev->sdev_gendev);
+	}
 
 	return cmd;
 }				
@@ -303,8 +298,6 @@ void scsi_put_command(struct scsi_cmnd *
 
 	if (likely(cmd != NULL))
 		kmem_cache_free(shost->cmd_pool->slab, cmd);
-
-	put_device(&sdev->sdev_gendev);
 }
 EXPORT_SYMBOL(scsi_put_command);
 
Index: scsi-export/drivers/scsi/scsi_lib.c
===================================================================
--- scsi-export.orig/drivers/scsi/scsi_lib.c	2005-03-23 09:40:11.000000000 +0900
+++ scsi-export/drivers/scsi/scsi_lib.c	2005-03-23 09:40:11.000000000 +0900
@@ -1200,10 +1200,6 @@ static void scsi_request_fn(struct reque
 	struct scsi_cmnd *cmd;
 	struct request *req;
 
-	if(!get_device(&sdev->sdev_gendev))
-		/* We must be tearing the block queue down already */
-		return;
-
 	/*
 	 * To start with, we keep looping until the queue is empty, or until
 	 * the host is no longer able to accept any more requests.
@@ -1288,7 +1284,7 @@ static void scsi_request_fn(struct reque
 		}
 	}
 
-	goto out;
+	return;
 
  not_ready:
 	spin_unlock_irq(shost->host_lock);
@@ -1306,12 +1302,6 @@ static void scsi_request_fn(struct reque
 	sdev->device_busy--;
 	if(sdev->device_busy == 0)
 		blk_plug_device(q);
- out:
-	/* must be careful here...if we trigger the ->remove() function
-	 * we cannot be holding the q lock */
-	spin_unlock_irq(q->queue_lock);
-	put_device(&sdev->sdev_gendev);
-	spin_lock_irq(q->queue_lock);
 }
 
 u64 scsi_calculate_bounce_limit(struct Scsi_Host *shost)

