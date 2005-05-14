Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262767AbVENOBJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262767AbVENOBJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 May 2005 10:01:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262768AbVENN66
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 May 2005 09:58:58 -0400
Received: from rproxy.gmail.com ([64.233.170.205]:63820 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262665AbVENN5s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 May 2005 09:57:48 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:user-agent:content-type:references:in-reply-to:subject:message-id:date;
        b=E2m5e5DR+cEtIlhvidO61eLRGzoDSSw4y97bptTgTW8lppQcBn4RQ5bw0Q3FGjjtlA+eK76EMbwyqZej2wwzhmURxILRCSGVmvtHjjuvTFA4XLH3sJVMDxokX4e+guSzuP08ViBn+zBMG7RQAJV5vxdJFc7hAYOxFDND4sndhfI=
From: Tejun Heo <htejun@gmail.com>
To: James.Bottomley@steeleye.com, axboe@suse.de,
       Christoph Hellwig <hch@infradead.org>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
User-Agent: lksp 0.3
Content-Type: text/plain; charset=US-ASCII
References: <20050514135610.81030F26@htj.dyndns.org>
In-Reply-To: <20050514135610.81030F26@htj.dyndns.org>
Subject: Re: [PATCH scsi-misc-2.6 02/04] scsi: move request preps in other places into prep_fn()
Message-ID: <20050514135610.37EC68D7@htj.dyndns.org>
Date: Sat, 14 May 2005 22:57:43 +0900 (KST)
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
--- scsi-reqfn-export.orig/drivers/scsi/scsi.c	2005-05-14 22:35:18.000000000 +0900
+++ scsi-reqfn-export/drivers/scsi/scsi.c	2005-05-14 22:35:18.000000000 +0900
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
--- scsi-reqfn-export.orig/drivers/scsi/scsi_lib.c	2005-05-14 22:35:18.000000000 +0900
+++ scsi-reqfn-export/drivers/scsi/scsi_lib.c	2005-05-14 22:35:18.000000000 +0900
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
@@ -1164,6 +1172,15 @@ static int scsi_prep_fn(struct request_q
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

