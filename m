Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261239AbVCaJTL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261239AbVCaJTL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 04:19:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261212AbVCaJTH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 04:19:07 -0500
Received: from rproxy.gmail.com ([64.233.170.195]:45599 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261239AbVCaJI0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 04:08:26 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:user-agent:content-type:references:in-reply-to:subject:message-id:date;
        b=nTfnLZ3OrpLkffKYb9OMPuDCMDuEn58Eh9HkUcIRq7iyGu620UWDcTS4dnJoTDZymuNbF7Ug1txS1ISf0z3CXS3Bl291FhR75q7fXh1ke2PQoIzVzN96wOunzlWVEDJrpNhswwWSewPAFnT0WgxDx90IxvTnNdrfa4HEu9WrsHI=
From: Tejun Heo <htejun@gmail.com>
To: James.Bottomley@steeleye.com, axboe@suse.de
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
User-Agent: lksp 0.3
Content-Type: text/plain; charset=US-ASCII
References: <20050331090647.FEDC3964@htj.dyndns.org>
In-Reply-To: <20050331090647.FEDC3964@htj.dyndns.org>
Subject: Re: [PATCH scsi-misc-2.6 06/13] scsi: remove meaningless scsi_cmnd->serial_number_at_timeout field
Message-ID: <20050331090647.1428AD14@htj.dyndns.org>
Date: Thu, 31 Mar 2005 18:08:20 +0900 (KST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

06_scsi_remove_serial_number_at_timeout.patch

	scsi_cmnd->serial_number_at_timeout doesn't serve any purpose
	anymore.  All serial_number == serial_number_at_timeout tests
	are always true in abort callbacks.  Kill the field.  Also, as
	->pid always equals ->serial_number and ->serial_number
	doesn't have any special meaning anymore, update comments
	above ->serial_number accordingly.  Once we remove all uses of
	this field from all lldd's, this field should go.

Signed-off-by: Tejun Heo <htejun@gmail.com>

 drivers/scsi/BusLogic.c             |    7 -------
 drivers/scsi/advansys.c             |    5 ++---
 drivers/scsi/ips.c                  |    7 -------
 drivers/scsi/ncr53c8xx.c            |   14 ++------------
 drivers/scsi/qla2xxx/qla_dbg.c      |    6 ++----
 drivers/scsi/scsi.c                 |    2 --
 drivers/scsi/scsi_error.c           |    7 -------
 drivers/scsi/scsi_lib.c             |    1 -
 drivers/scsi/sym53c8xx_2/sym_glue.c |    6 ------
 include/scsi/scsi_cmnd.h            |   22 +++++++++-------------
 10 files changed, 15 insertions(+), 62 deletions(-)

Index: scsi-export/drivers/scsi/BusLogic.c
===================================================================
--- scsi-export.orig/drivers/scsi/BusLogic.c	2005-03-31 17:42:04.000000000 +0900
+++ scsi-export/drivers/scsi/BusLogic.c	2005-03-31 18:06:21.000000000 +0900
@@ -2958,13 +2958,6 @@ static int BusLogic_AbortCommand(struct 
 	struct BusLogic_CCB *CCB;
 	BusLogic_IncrementErrorCounter(&HostAdapter->TargetStatistics[TargetID].CommandAbortsRequested);
 	/*
-	   If this Command has already completed, then no Abort is necessary.
-	 */
-	if (Command->serial_number != Command->serial_number_at_timeout) {
-		BusLogic_Warning("Unable to Abort Command to Target %d - " "Already Completed\n", HostAdapter, TargetID);
-		return SUCCESS;
-	}
-	/*
 	   Attempt to find an Active CCB for this Command.  If no Active CCB for this
 	   Command is found, then no Abort is necessary.
 	 */
Index: scsi-export/drivers/scsi/advansys.c
===================================================================
--- scsi-export.orig/drivers/scsi/advansys.c	2005-03-31 18:06:20.000000000 +0900
+++ scsi-export/drivers/scsi/advansys.c	2005-03-31 18:06:21.000000000 +0900
@@ -9198,9 +9198,8 @@ asc_prt_scsi_cmnd(struct scsi_cmnd *s)
         s->use_sg, s->sglist_len, s->abort_reason);
 
     printk(
-" serial_number 0x%x, serial_number_at_timeout 0x%x, retries %d, allowed %d\n",
-        (unsigned) s->serial_number, (unsigned) s->serial_number_at_timeout,
-         s->retries, s->allowed);
+" serial_number 0x%x, retries %d, allowed %d\n",
+        (unsigned) s->serial_number, s->retries, s->allowed);
 
     printk(
 " timeout_per_command %d, timeout_total %d, timeout %d\n",
Index: scsi-export/drivers/scsi/ips.c
===================================================================
--- scsi-export.orig/drivers/scsi/ips.c	2005-03-31 17:42:04.000000000 +0900
+++ scsi-export/drivers/scsi/ips.c	2005-03-31 18:06:21.000000000 +0900
@@ -833,13 +833,6 @@ ips_eh_abort(Scsi_Cmnd * SC)
 	if (!ha->active)
 		return (FAILED);
 
-	if (SC->serial_number != SC->serial_number_at_timeout) {
-		/* HMM, looks like a bogus command */
-		DEBUG(1, "Abort called with bogus scsi command");
-
-		return (FAILED);
-	}
-
 	/* See if the command is on the copp queue */
 	item = ha->copp_waitlist.head;
 	while ((item) && (item->scsi_cmd != SC))
Index: scsi-export/drivers/scsi/ncr53c8xx.c
===================================================================
--- scsi-export.orig/drivers/scsi/ncr53c8xx.c	2005-03-31 17:42:04.000000000 +0900
+++ scsi-export/drivers/scsi/ncr53c8xx.c	2005-03-31 18:06:21.000000000 +0900
@@ -7601,24 +7601,14 @@ static int ncr53c8xx_abort(struct scsi_c
 	struct scsi_cmnd *done_list;
 
 #if defined SCSI_RESET_SYNCHRONOUS && defined SCSI_RESET_ASYNCHRONOUS
-	printk("ncr53c8xx_abort: pid=%lu serial_number=%ld serial_number_at_timeout=%ld\n",
-		cmd->pid, cmd->serial_number, cmd->serial_number_at_timeout);
+	printk("ncr53c8xx_abort: pid=%lu serial_number=%ld\n",
+		cmd->pid, cmd->serial_number);
 #else
 	printk("ncr53c8xx_abort: command pid %lu\n", cmd->pid);
 #endif
 
 	NCR_LOCK_NCB(np, flags);
 
-#if defined SCSI_RESET_SYNCHRONOUS && defined SCSI_RESET_ASYNCHRONOUS
-	/*
-	 * We have to just ignore abort requests in some situations.
-	 */
-	if (cmd->serial_number != cmd->serial_number_at_timeout) {
-		sts = SCSI_ABORT_NOT_RUNNING;
-		goto out;
-	}
-#endif
-
 	sts = ncr_abort_command(np, cmd);
 out:
 	done_list     = np->done_list;
Index: scsi-export/drivers/scsi/qla2xxx/qla_dbg.c
===================================================================
--- scsi-export.orig/drivers/scsi/qla2xxx/qla_dbg.c	2005-03-31 17:42:04.000000000 +0900
+++ scsi-export/drivers/scsi/qla2xxx/qla_dbg.c	2005-03-31 18:06:21.000000000 +0900
@@ -1050,10 +1050,8 @@ qla2x00_print_scsi_cmd(struct scsi_cmnd 
 	for (i = 0; i < cmd->cmd_len; i++) {
 		printk("0x%02x ", cmd->cmnd[i]);
 	}
-	printk("\n  seg_cnt=%d, allowed=%d, retries=%d, "
-	    "serial_number_at_timeout=0x%lx\n",
-	    cmd->use_sg, cmd->allowed, cmd->retries,
-	    cmd->serial_number_at_timeout);
+	printk("\n  seg_cnt=%d, allowed=%d, retries=%d\n",
+	    cmd->use_sg, cmd->allowed, cmd->retries);
 	printk("  request buffer=0x%p, request buffer len=0x%x\n",
 	    cmd->request_buffer, cmd->request_bufflen);
 	printk("  tag=%d, transfersize=0x%x\n",
Index: scsi-export/drivers/scsi/scsi.c
===================================================================
--- scsi-export.orig/drivers/scsi/scsi.c	2005-03-31 18:06:21.000000000 +0900
+++ scsi-export/drivers/scsi/scsi.c	2005-03-31 18:06:21.000000000 +0900
@@ -688,7 +688,6 @@ void scsi_init_cmd_from_req(struct scsi_
 	cmd->request = sreq->sr_request;
 	memcpy(cmd->data_cmnd, sreq->sr_cmnd, sizeof(cmd->data_cmnd));
 	cmd->serial_number = 0;
-	cmd->serial_number_at_timeout = 0;
 	cmd->bufflen = sreq->sr_bufflen;
 	cmd->buffer = sreq->sr_buffer;
 	cmd->retries = 0;
@@ -767,7 +766,6 @@ void __scsi_done(struct scsi_cmnd *cmd)
 	 * Set the serial numbers back to zero
 	 */
 	cmd->serial_number = 0;
-	cmd->serial_number_at_timeout = 0;
 	cmd->state = SCSI_STATE_BHQUEUE;
 	cmd->owner = SCSI_OWNER_BH_HANDLER;
 
Index: scsi-export/drivers/scsi/scsi_error.c
===================================================================
--- scsi-export.orig/drivers/scsi/scsi_error.c	2005-03-31 18:06:21.000000000 +0900
+++ scsi-export/drivers/scsi/scsi_error.c	2005-03-31 18:06:21.000000000 +0900
@@ -80,11 +80,6 @@ int scsi_eh_scmd_add(struct scsi_cmnd *s
 	 */
 	scmd->owner = SCSI_OWNER_ERROR_HANDLER;
 	scmd->state = SCSI_STATE_FAILED;
-	/*
-	 * Set the serial_number_at_timeout to the current
-	 * serial_number
-	 */
-	scmd->serial_number_at_timeout = scmd->serial_number;
 	list_add_tail(&scmd->eh_entry, &shost->eh_cmd_q);
 	set_bit(SHOST_RECOVERY, &shost->shost_state);
 	shost->host_failed++;
@@ -1057,7 +1052,6 @@ static int scsi_try_bus_reset(struct scs
 	SCSI_LOG_ERROR_RECOVERY(3, printk("%s: Snd Bus RST\n",
 					  __FUNCTION__));
 	scmd->owner = SCSI_OWNER_LOWLEVEL;
-	scmd->serial_number_at_timeout = scmd->serial_number;
 
 	if (!scmd->device->host->hostt->eh_bus_reset_handler)
 		return FAILED;
@@ -1089,7 +1083,6 @@ static int scsi_try_host_reset(struct sc
 	SCSI_LOG_ERROR_RECOVERY(3, printk("%s: Snd Host RST\n",
 					  __FUNCTION__));
 	scmd->owner = SCSI_OWNER_LOWLEVEL;
-	scmd->serial_number_at_timeout = scmd->serial_number;
 
 	if (!scmd->device->host->hostt->eh_host_reset_handler)
 		return FAILED;
Index: scsi-export/drivers/scsi/scsi_lib.c
===================================================================
--- scsi-export.orig/drivers/scsi/scsi_lib.c	2005-03-31 18:06:21.000000000 +0900
+++ scsi-export/drivers/scsi/scsi_lib.c	2005-03-31 18:06:21.000000000 +0900
@@ -386,7 +386,6 @@ static int scsi_init_cmd_errh(struct scs
 {
 	cmd->owner = SCSI_OWNER_MIDLEVEL;
 	cmd->serial_number = 0;
-	cmd->serial_number_at_timeout = 0;
 	cmd->abort_reason = 0;
 
 	memset(cmd->sense_buffer, 0, sizeof cmd->sense_buffer);
Index: scsi-export/drivers/scsi/sym53c8xx_2/sym_glue.c
===================================================================
--- scsi-export.orig/drivers/scsi/sym53c8xx_2/sym_glue.c	2005-03-31 17:42:04.000000000 +0900
+++ scsi-export/drivers/scsi/sym53c8xx_2/sym_glue.c	2005-03-31 18:06:21.000000000 +0900
@@ -799,12 +799,6 @@ static int sym_eh_handler(int op, char *
 
 	dev_warn(&cmd->device->sdev_gendev, "%s operation started.\n", opname);
 
-#if 0
-	/* This one should be the result of some race, thus to ignore */
-	if (cmd->serial_number != cmd->serial_number_at_timeout)
-		goto prepare;
-#endif
-
 	/* This one is queued in some place -> to wait for completion */
 	FOR_EACH_QUEUED_ELEMENT(&np->busy_ccbq, qp) {
 		struct sym_ccb *cp = sym_que_entry(qp, struct sym_ccb, link_ccbq);
Index: scsi-export/include/scsi/scsi_cmnd.h
===================================================================
--- scsi-export.orig/include/scsi/scsi_cmnd.h	2005-03-31 18:06:20.000000000 +0900
+++ scsi-export/include/scsi/scsi_cmnd.h	2005-03-31 18:06:21.000000000 +0900
@@ -43,21 +43,17 @@ struct scsi_cmnd {
 	void (*done) (struct scsi_cmnd *);	/* Mid-level done function */
 
 	/*
-	 * A SCSI Command is assigned a nonzero serial_number when internal_cmnd
-	 * passes it to the driver's queue command function.  The serial_number
-	 * is cleared when scsi_done is entered indicating that the command has
-	 * been completed.  If a timeout occurs, the serial number at the moment
-	 * of timeout is copied into serial_number_at_timeout.  By subsequently
-	 * comparing the serial_number and serial_number_at_timeout fields
-	 * during abort or reset processing, we can detect whether the command
-	 * has already completed.  This also detects cases where the command has
-	 * completed and the SCSI Command structure has already being reused
-	 * for another command, so that we can avoid incorrectly aborting or
-	 * resetting the new command.
-	 * The serial number is only unique per host.
+	 * A SCSI Command is assigned a nonzero serial_number before passed
+	 * to the driver's queue command function.  The serial_number is
+	 * cleared when scsi_done is entered indicating that the command
+	 * has been completed.  It currently doesn't have much use other
+	 * than printk's.  Some lldd's use this number for other purposes.
+	 * It's almost certain that such usages are either incorrect or
+	 * meaningless.  Please kill all usages other than printk's.  Also,
+	 * as this number is always identical to ->pid, please convert
+	 * printk's to use ->pid, so that we can kill this field.
 	 */
 	unsigned long serial_number;
-	unsigned long serial_number_at_timeout;
 
 	int retries;
 	int allowed;

