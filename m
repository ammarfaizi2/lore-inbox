Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261576AbVDSOc6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261576AbVDSOc6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Apr 2005 10:32:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261573AbVDSOcl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Apr 2005 10:32:41 -0400
Received: from rproxy.gmail.com ([64.233.170.205]:51603 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261568AbVDSObV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Apr 2005 10:31:21 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:user-agent:content-type:references:in-reply-to:subject:message-id:date;
        b=qeGzfIIxwv+4tJiVtV2E9Q9ercysCEyf8VIbAAJyUN+cGzvWuIslvEEbS+/jRNVL6L+ssCVJByTdR/la/wjlFOBaEqobgxjM9Wh085S7hVrYG5UpxWw+dy8i+NcmCJJITua2e4+pmgHBWxm/tEtHqH1cpMBucw28vMkPuI9qggk=
From: Tejun Heo <htejun@gmail.com>
To: James.Bottomley@steeleye.com
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
User-Agent: lksp 0.3
Content-Type: text/plain; charset=US-ASCII
References: <20050419143100.E231523D@htj.dyndns.org>
In-Reply-To: <20050419143100.E231523D@htj.dyndns.org>
Subject: Re: [PATCH scsi-misc-2.6 03/04] scsi: remove a timer race in scsi_queue_insert()
Message-ID: <20050419143100.DF54176B@htj.dyndns.org>
Date: Tue, 19 Apr 2005 23:31:16 +0900 (KST)
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
--- scsi-reqfn-export.orig/drivers/scsi/scsi.c	2005-04-19 23:28:33.000000000 +0900
+++ scsi-reqfn-export/drivers/scsi/scsi.c	2005-04-19 23:30:58.000000000 +0900
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
--- scsi-reqfn-export.orig/drivers/scsi/scsi_lib.c	2005-04-19 23:28:33.000000000 +0900
+++ scsi-reqfn-export/drivers/scsi/scsi_lib.c	2005-04-19 23:30:58.000000000 +0900
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

