Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261259AbVCaJ0e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261259AbVCaJ0e (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 04:26:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261241AbVCaJVZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 04:21:25 -0500
Received: from wproxy.gmail.com ([64.233.184.198]:24622 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261251AbVCaJIf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 04:08:35 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:user-agent:content-type:references:in-reply-to:subject:message-id:date;
        b=FeHFIIjRiSNg4g2rg/Y+ehUOnvComjhonbhLSwcVlt6XKcoedx8BjolLjZ5BlCCEU7LSdIN3iqO3dtBqpljRD+1C81HFeoIECMB+wgu6BTZ+oxWaRbOMVEPw612DfIzi69a3Mvf7kbZ/vy8XM3Jwszxf1eP7pbU7C7jijde1s0E=
From: Tejun Heo <htejun@gmail.com>
To: James.Bottomley@steeleye.com, axboe@suse.de
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
User-Agent: lksp 0.3
Content-Type: text/plain; charset=US-ASCII
References: <20050331090647.FEDC3964@htj.dyndns.org>
In-Reply-To: <20050331090647.FEDC3964@htj.dyndns.org>
Subject: Re: [PATCH scsi-misc-2.6 08/13] scsi: move request preps in other places into prep_fn()
Message-ID: <20050331090647.94FFEC1E@htj.dyndns.org>
Date: Thu, 31 Mar 2005 18:08:30 +0900 (KST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

08_scsi_move_preps_to_prep_fn.patch

	Move request preparations scattered in scsi_request_fn() and
	scsi_dispatch_cmd() into scsi_prep_fn().

	* CDB_SIZE check in scsi_dispatch_cmd()
	* SCSI-2 LUN preparation in scsi_dispatch_cmd()
	* scsi_init_cmd_errh() in scsi_request_fn()

	No invalid request reaches scsi_request_fn() anymore.

Signed-off-by: Tejun Heo <htejun@gmail.com>

 scsi.c     |   30 ------------------------------
 scsi_lib.c |   25 +++++++++++++++++++------
 2 files changed, 19 insertions(+), 36 deletions(-)

Index: scsi-export/drivers/scsi/scsi.c
===================================================================
--- scsi-export.orig/drivers/scsi/scsi.c	2005-03-31 18:06:21.000000000 +0900
+++ scsi-export/drivers/scsi/scsi.c	2005-03-31 18:06:22.000000000 +0900
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
 
Index: scsi-export/drivers/scsi/scsi_lib.c
===================================================================
--- scsi-export.orig/drivers/scsi/scsi_lib.c	2005-03-31 18:06:21.000000000 +0900
+++ scsi-export/drivers/scsi/scsi_lib.c	2005-03-31 18:06:22.000000000 +0900
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
@@ -1140,6 +1148,17 @@ static int scsi_prep_fn(struct request_q
 			goto kill;
 	}
 
+	/* Check command length. */
+	if (CDB_SIZE(cmd) > sdev->host->max_cmd_len)
+		goto kill;
+
+	scsi_init_cmd_errh(cmd);
+
+	/* If SCSI-2 or lower, store the LUN value in cmnd. */
+	if (cmd->device->scsi_level <= SCSI_2)
+		cmd->cmnd[1] = (cmd->cmnd[1] & 0x1f) |
+			(cmd->device->lun << 5 & 0xe0);
+
 	/*
 	 * The request is now prepped, no need to come back here
 	 */
@@ -1316,12 +1335,6 @@ static void scsi_request_fn(struct reque
 		}
 
 		/*
-		 * Finally, initialize any error handling parameters, and set up
-		 * the timers for timeouts.
-		 */
-		scsi_init_cmd_errh(cmd);
-
-		/*
 		 * Dispatch the command to the low-level driver.
 		 */
 		rtn = scsi_dispatch_cmd(cmd);

