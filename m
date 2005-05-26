Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261268AbVEZHt2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261268AbVEZHt2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 May 2005 03:49:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261261AbVEZHs5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 May 2005 03:48:57 -0400
Received: from mail.dvmed.net ([216.237.124.58]:51416 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S261258AbVEZHrP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 May 2005 03:47:15 -0400
Message-ID: <42957EFE.2040005@pobox.com>
Date: Thu, 26 May 2005 03:47:10 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050328 Fedora/1.7.6-1.2.5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Denis Vlasenko <vda@ilport.com.ua>
CC: linux-kernel@vger.kernel.org
Subject: Re: libata slab corruption saga
References: <200505261032.23758.vda@ilport.com.ua>
In-Reply-To: <200505261032.23758.vda@ilport.com.ua>
Content-Type: multipart/mixed;
 boundary="------------090405010002060402070709"
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090405010002060402070709
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Does the attached patch change things?

	Jeff




--------------090405010002060402070709
Content-Type: text/x-patch;
 name="atapi-fix-error-handling.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="atapi-fix-error-handling.patch"

From: Hannes Reinecke <hare@suse.de>
Subject: Fix sata atapi error handling
References: 70918

SCSI commands which end up on the error handler need special attention;
we have to make sure that eh_cmd_q is properly emptied or scsi_eh will
try to forever finalize the command.

With this patch eh_cmd_q is explicitely emptied if not done so in the
strategy handler and a proper abort sequence is executed for each
command if required.
We rely on the strategy handler to fill out proper sense information for
us as SATA is 'special' when it comes to command sense gathering.

Signed-off-by: Kurt Garloff <garloff@suse.de>
Signed-off-by: Jens Axboe <axboe@suse.de>
Acked-by: Andreas Gruenbacher <agruen@suse.de>

Index: linux-2.6.11/drivers/scsi/libata-core.c
===================================================================
--- linux-2.6.11.orig/drivers/scsi/libata-core.c
+++ linux-2.6.11/drivers/scsi/libata-core.c
@@ -41,6 +41,7 @@
 #include <scsi/scsi.h>
 #include "scsi.h"
 #include "scsi_priv.h"
+#include "scsi_logging.h"
 #include <scsi/scsi_host.h>
 #include <linux/libata.h>
 #include <asm/io.h>
@@ -2587,6 +2588,11 @@ static void atapi_request_sense(struct a
 	DPRINTK("EXIT\n");
 }
 
+void ata_qc_timeout_done(struct scsi_cmnd *scmd)
+{
+	return;
+}
+
 /**
  *	ata_qc_timeout - Handle timeout of queued command
  *	@qc: Command that timed out
@@ -2618,17 +2624,16 @@ static void ata_qc_timeout(struct ata_qu
 		struct scsi_cmnd *cmd = qc->scsicmd;
 
 		if (!scsi_eh_eflags_chk(cmd, SCSI_EH_CANCEL_CMD)) {
-
 			/* finish completing original command */
+			qc->scsidone = ata_qc_timeout_done;
+
 			__ata_qc_complete(qc);
 
 			atapi_request_sense(ap, dev, cmd);
 
 			cmd->result = (CHECK_CONDITION << 1) | (DID_OK << 16);
-			scsi_finish_command(cmd);
-
-			goto out;
 		}
+		goto out;
 	}
 
 	/* hack alert!  We cannot use the supplied completion
Index: linux-2.6.11/drivers/scsi/libata-scsi.c
===================================================================
--- linux-2.6.11.orig/drivers/scsi/libata-scsi.c
+++ linux-2.6.11/drivers/scsi/libata-scsi.c
@@ -633,12 +633,6 @@ int ata_scsi_error(struct Scsi_Host *hos
 	ap = (struct ata_port *) &host->hostdata[0];
 	ap->ops->eng_timeout(ap);
 
-	/* TODO: this is per-command; when queueing is supported
-	 * this code will either change or move to a more
-	 * appropriate place
-	 */
-	host->host_failed--;
-
 	DPRINTK("EXIT\n");
 	return 0;
 }
Index: linux-2.6.11/drivers/scsi/scsi_error.c
===================================================================
--- linux-2.6.11.orig/drivers/scsi/scsi_error.c
+++ linux-2.6.11/drivers/scsi/scsi_error.c
@@ -1610,6 +1610,40 @@ static void scsi_unjam_host(struct Scsi_
 	scsi_eh_flush_done_q(&eh_done_q);
 }
 
+static void scsi_invoke_strategy_handler(struct Scsi_Host *shost)
+{
+	int rtn;
+	struct list_head *lh, *lh_sf;
+	struct scsi_cmnd *scmd;
+	unsigned long flags;
+	LIST_HEAD(eh_work_q);
+	LIST_HEAD(eh_done_q);
+
+	rtn = shost->hostt->eh_strategy_handler(shost);
+
+	spin_lock_irqsave(shost->host_lock, flags);
+	list_splice_init(&shost->eh_cmd_q, &eh_work_q);
+	spin_unlock_irqrestore(shost->host_lock, flags);
+
+	SCSI_LOG_ERROR_RECOVERY(1, scsi_eh_prt_fail_stats(shost, &eh_work_q));
+
+	list_for_each_safe(lh, lh_sf, &eh_work_q) {
+		scmd = list_entry(lh, struct scsi_cmnd, eh_entry);
+
+		if (scsi_eh_eflags_chk(scmd, SCSI_EH_CANCEL_CMD) ||
+		    !SCSI_SENSE_VALID(scmd))
+			continue;
+		scmd->retries = scmd->allowed;
+		scsi_eh_finish_cmd(scmd, &eh_done_q);
+	}
+
+	if (!list_empty(&eh_work_q))
+		if (!scsi_eh_abort_cmds(&eh_work_q, &eh_done_q))
+			scsi_eh_ready_devs(shost, &eh_work_q, &eh_done_q);
+
+	scsi_eh_flush_done_q(&eh_done_q);
+}
+
 /**
  * scsi_error_handler - Handle errors/timeouts of SCSI cmds.
  * @data:	Host for which we are running.
@@ -1624,7 +1658,6 @@ static void scsi_unjam_host(struct Scsi_
 int scsi_error_handler(void *data)
 {
 	struct Scsi_Host *shost = (struct Scsi_Host *) data;
-	int rtn;
 	DECLARE_MUTEX_LOCKED(sem);
 
 	/*
@@ -1680,8 +1713,8 @@ int scsi_error_handler(void *data)
 		 * what we need to do to get it up and online again (if we can).
 		 * If we fail, we end up taking the thing offline.
 		 */
-		if (shost->hostt->eh_strategy_handler) 
-			rtn = shost->hostt->eh_strategy_handler(shost);
+		if (shost->hostt->eh_strategy_handler)
+			scsi_invoke_strategy_handler(shost);
 		else
 			scsi_unjam_host(shost);
 

--------------090405010002060402070709--
