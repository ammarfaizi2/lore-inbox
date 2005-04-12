Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262246AbVDLLPV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262246AbVDLLPV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 07:15:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262347AbVDLLO5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 07:14:57 -0400
Received: from rproxy.gmail.com ([64.233.170.199]:40007 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262246AbVDLKdE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 06:33:04 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:user-agent:content-type:references:in-reply-to:subject:message-id:date;
        b=Z7z3cP7DRg4uVjIC7pP2JjaC0RjzSldwJ2L9V0jpWgGKvYiGu/fvaq2KtBRXu00RrLVYk0rO4KkeTkDbhoS13MzRDXAgqY1wm0yAyO8WZO6KLfQQs2IsPcLRV3wmxDc5Fvou9pwhfHfKdSYR00Sw3hD6qtXf6GS+2gvYNUbqVs4=
From: Tejun Heo <htejun@gmail.com>
To: James.Bottomley@steeleye.com, axboe@suse.de,
       Christoph Hellwig <hch@infradead.org>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
User-Agent: lksp 0.3
Content-Type: text/plain; charset=US-ASCII
References: <20050412103128.69172FEB@htj.dyndns.org>
In-Reply-To: <20050412103128.69172FEB@htj.dyndns.org>
Subject: Re: [PATCH scsi-misc-2.6 02/04] scsi: move request preps in other places into prep_fn()
Message-ID: <20050412103128.FF558BA4@htj.dyndns.org>
Date: Tue, 12 Apr 2005 19:32:58 +0900 (KST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

02_scsi_reqfn_move_preps_to_prep_fn.patch

	Move request preparations scattered in scsi_request_fn() and
	scsi_dispatch_cmd() into scsi_prep_fn()

	* CDB_SIZE check in scsi_dispatch_cmd()
	* SCSI-2 LUN preparation in scsi_dispatch_cmd()

	No invalid request reaches scsi_request_fn() anymore.

	Note that scsi_init_cmd_errh() is still left in
	scsi_request_fn().  As all requeued requests need its sense
	buffer and result value cleared, we can't move this to
	prep_fn() yet.  This is moved into prep_fn in the following
	requeue path consoildation patchset.

Signed-off-by: Tejun Heo <htejun@gmail.com>

 scsi.c     |   30 ------------------------------
 scsi_lib.c |   17 +++++++++++++++++
 2 files changed, 17 insertions(+), 30 deletions(-)

Index: scsi-reqfn-export/drivers/scsi/scsi.c
===================================================================
--- scsi-reqfn-export.orig/drivers/scsi/scsi.c	2005-04-12 19:27:54.000000000 +0900
+++ scsi-reqfn-export/drivers/scsi/scsi.c	2005-04-12 19:27:55.000000000 +0900
@@ -79,15 +79,6 @@
 #define MIN_RESET_PERIOD (15*HZ)
 
 /*
- * Macro to determine the size of SCSI command. This macro takes vendor
- * unique commands into account. SCSI commands in groups 6 and 7 are
- * vendor unique and we will depend upon the command length being
- * supplied correctly in cmd_len.
- */
-#define CDB_SIZE(cmd)	(((((cmd)->cmnd[0] >> 5) & 7) < 6) ? \
-				COMMAND_SIZE((cmd)->cmnd[0]) : (cmd)->cmd_len)
-
-/*
  * Note - the initial logging level can be set here to log events at boot time.
  * After the system is up, you may enable logging via the /proc interface.
  */
@@ -566,14 +557,6 @@ int scsi_dispatch_cmd(struct scsi_cmnd *
 		goto out;
 	}
 
-	/* 
-	 * If SCSI-2 or lower, store the LUN value in cmnd.
-	 */
-	if (cmd->device->scsi_level <= SCSI_2) {
-		cmd->cmnd[1] = (cmd->cmnd[1] & 0x1f) |
-			       (cmd->device->lun << 5 & 0xe0);
-	}
-
 	/*
 	 * We will wait MIN_RESET_DELAY clock ticks after the last reset so
 	 * we can avoid the drive not being ready.
@@ -614,19 +597,6 @@ int scsi_dispatch_cmd(struct scsi_cmnd *
 
 	atomic_inc(&cmd->device->iorequest_cnt);
 
-	/*
-	 * Before we queue this command, check if the command
-	 * length exceeds what the host adapter can handle.
-	 */
-	if (CDB_SIZE(cmd) > cmd->device->host->max_cmd_len) {
-		SCSI_LOG_MLQUEUE(3,
-				printk("queuecommand : command too long.\n"));
-		cmd->result = (DID_ABORT << 16);
-
-		scsi_done(cmd);
-		goto out;
-	}
-
 	spin_lock_irqsave(host->host_lock, flags);
 	scsi_cmd_get_serial(host, cmd); 
 
Index: scsi-reqfn-export/drivers/scsi/scsi_lib.c
===================================================================
--- scsi-reqfn-export.orig/drivers/scsi/scsi_lib.c	2005-04-12 19:27:55.000000000 +0900
+++ scsi-reqfn-export/drivers/scsi/scsi_lib.c	2005-04-12 19:27:55.000000000 +0900
@@ -28,6 +28,14 @@
 #include "scsi_priv.h"
 #include "scsi_logging.h"
 
+/*
+ * Macro to determine the size of SCSI command. This macro takes vendor
+ * unique commands into account. SCSI commands in groups 6 and 7 are
+ * vendor unique and we will depend upon the command length being
+ * supplied correctly in cmd_len.
+ */
+#define CDB_SIZE(cmd)	(((((cmd)->cmnd[0] >> 5) & 7) < 6) ? \
+				COMMAND_SIZE((cmd)->cmnd[0]) : (cmd)->cmd_len)
 
 #define SG_MEMPOOL_NR		(sizeof(scsi_sg_pools)/sizeof(struct scsi_host_sg_pool))
 #define SG_MEMPOOL_SIZE		32
@@ -1160,6 +1168,15 @@ static int scsi_prep_fn(struct request_q
 			goto kill;
 	}
 
+	/* Check command length. */
+	if (CDB_SIZE(cmd) > sdev->host->max_cmd_len)
+		goto kill;
+
+	/* If SCSI-2 or lower, store the LUN value in cmnd. */
+	if (cmd->device->scsi_level <= SCSI_2)
+		cmd->cmnd[1] = (cmd->cmnd[1] & 0x1f) |
+			(cmd->device->lun << 5 & 0xe0);
+
 	/*
 	 * The request is now prepped, no need to come back here
 	 */

