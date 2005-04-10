Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261566AbVDJSts@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261566AbVDJSts (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Apr 2005 14:49:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261570AbVDJSs4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Apr 2005 14:48:56 -0400
Received: from rproxy.gmail.com ([64.233.170.201]:1941 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261569AbVDJSpa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Apr 2005 14:45:30 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:user-agent:content-type:references:in-reply-to:subject:message-id:date;
        b=Ft8BbncyJaMjRcYgSGsEzHt5sqS3LPabVd1pUrGOtsUdWa02D6oKzz4adu5naYfx913Op7R4CFg39WAZ4HIZEe1j3uInZxJpnLYjg8XEr88mcmGnjvXhZ6OP3efQpsO1ZYWze1N5ZxoC0gYXpDeQ7iU9L6OP1he2XBIq4PEdSzg=
From: Tejun Heo <htejun@gmail.com>
To: James.Bottomley@steeleye.com, axboe@suse.de,
       Christoph Hellwig <hch@infradead.org>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
User-Agent: lksp 0.3
Content-Type: text/plain; charset=US-ASCII
References: <20050410184214.4AAD0992@htj.dyndns.org>
In-Reply-To: <20050410184214.4AAD0992@htj.dyndns.org>
Subject: Re: [PATCH scsi-misc-2.6 03/07] scsi: remove a timer race in scsi_queue_insert()
Message-ID: <20050410184214.A47105CF@htj.dyndns.org>
Date: Mon, 11 Apr 2005 03:45:21 +0900 (KST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

03_scsi_timer_dispatch_race_fix.patch

	scsi_queue_insert() has four callers.  Three callers call with
	timer disabled and one (the second invocation in
	scsi_dispatch_cmd()) calls with timer activated.
	scsi_queue_insert() used to always call scsi_delete_timer()
	and ignore the return value.  This results in race with timer
	expiration.  Remove scsi_delete_timer() call from
	scsi_queue_insert() and make the caller delete timer and check
	the return value.

Signed-off-by: Tejun Heo <htejun@gmail.com>

 scsi.c     |   10 ++++++----
 scsi_lib.c |    8 +-------
 2 files changed, 7 insertions(+), 11 deletions(-)

Index: scsi-reqfn-export/drivers/scsi/scsi.c
===================================================================
--- scsi-reqfn-export.orig/drivers/scsi/scsi.c	2005-04-11 03:42:10.000000000 +0900
+++ scsi-reqfn-export/drivers/scsi/scsi.c	2005-04-11 03:42:12.000000000 +0900
@@ -638,10 +638,12 @@ int scsi_dispatch_cmd(struct scsi_cmnd *
 	}
 	spin_unlock_irqrestore(host->host_lock, flags);
 	if (rtn) {
-		atomic_inc(&cmd->device->iodone_cnt);
-		scsi_queue_insert(cmd,
-				(rtn == SCSI_MLQUEUE_DEVICE_BUSY) ?
-				 rtn : SCSI_MLQUEUE_HOST_BUSY);
+		if (scsi_delete_timer(cmd)) {
+			atomic_inc(&cmd->device->iodone_cnt);
+			scsi_queue_insert(cmd,
+					  (rtn == SCSI_MLQUEUE_DEVICE_BUSY) ?
+					  rtn : SCSI_MLQUEUE_HOST_BUSY);
+		}
 		SCSI_LOG_MLQUEUE(3,
 		    printk("queuecommand : request rejected\n"));
 	}
Index: scsi-reqfn-export/drivers/scsi/scsi_lib.c
===================================================================
--- scsi-reqfn-export.orig/drivers/scsi/scsi_lib.c	2005-04-11 03:42:10.000000000 +0900
+++ scsi-reqfn-export/drivers/scsi/scsi_lib.c	2005-04-11 03:42:12.000000000 +0900
@@ -124,13 +124,7 @@ int scsi_queue_insert(struct scsi_cmnd *
 		 printk("Inserting command %p into mlqueue\n", cmd));
 
 	/*
-	 * We are inserting the command into the ml queue.  First, we
-	 * cancel the timer, so it doesn't time out.
-	 */
-	scsi_delete_timer(cmd);
-
-	/*
-	 * Next, set the appropriate busy bit for the device/host.
+	 * Set the appropriate busy bit for the device/host.
 	 *
 	 * If the host/device isn't busy, assume that something actually
 	 * completed, and that we should be able to queue a command now.

