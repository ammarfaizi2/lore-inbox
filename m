Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932296AbWGYJjx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932296AbWGYJjx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 05:39:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932287AbWGYJjw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 05:39:52 -0400
Received: from sabe.cs.wisc.edu ([128.105.6.20]:54466 "EHLO sabe.cs.wisc.edu")
	by vger.kernel.org with ESMTP id S932273AbWGYJjn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 05:39:43 -0400
Subject: [PATCH 2/2] blk request timeout handler:
From: Mike Christie <michaelc@cs.wisc.edu>
To: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org, axboe@suse.de
Content-Type: text/plain
Date: Tue, 25 Jul 2006 05:39:40 -0400
Message-Id: <1153820380.4166.24.camel@max>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 (2.6.0-1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Convert scsi to the block layer request timer code. The block layer
functions are exactly the ones that used to live in scsi, so the
conversion is mostly renames and removal of code from scsi.

Signed-off-by: Mike Christie <michaelc@cs.wisc.edu>


diff -aurp linux-2.6.18-rc2/drivers/scsi/aacraid/aachba.c linux-2.6.18-rc2.blkeh/drivers/scsi/aacraid/aachba.c
--- linux-2.6.18-rc2/drivers/scsi/aacraid/aachba.c	2006-07-15 17:53:08.000000000 -0400
+++ linux-2.6.18-rc2.blkeh/drivers/scsi/aacraid/aachba.c	2006-07-25 05:13:04.000000000 -0400
@@ -2113,7 +2113,7 @@ static int aac_send_srb_fib(struct scsi_
 	srbcmd->id   = cpu_to_le32(scmd_id(scsicmd));
 	srbcmd->lun      = cpu_to_le32(scsicmd->device->lun);
 	srbcmd->flags    = cpu_to_le32(flag);
-	timeout = scsicmd->timeout_per_command/HZ;
+	timeout = scsicmd->request->timeout/HZ;
 	if(timeout == 0){
 		timeout = 1;
 	}
diff -aurp linux-2.6.18-rc2/drivers/scsi/advansys.c linux-2.6.18-rc2.blkeh/drivers/scsi/advansys.c
--- linux-2.6.18-rc2/drivers/scsi/advansys.c	2006-07-15 17:53:08.000000000 -0400
+++ linux-2.6.18-rc2.blkeh/drivers/scsi/advansys.c	2006-07-25 04:31:46.000000000 -0400
@@ -9196,7 +9196,7 @@ asc_prt_scsi_cmnd(struct scsi_cmnd *s)
 
     printk(
 " timeout_per_command %d\n",
-        s->timeout_per_command);
+        s->request->timeout);
 
     printk(
 " scsi_done 0x%lx, done 0x%lx, host_scribble 0x%lx, result 0x%x\n",
diff -aurp linux-2.6.18-rc2/drivers/scsi/gdth.c linux-2.6.18-rc2.blkeh/drivers/scsi/gdth.c
--- linux-2.6.18-rc2/drivers/scsi/gdth.c	2006-07-15 17:53:08.000000000 -0400
+++ linux-2.6.18-rc2.blkeh/drivers/scsi/gdth.c	2006-07-25 04:30:48.000000000 -0400
@@ -734,7 +734,6 @@ int __gdth_execute(struct scsi_device *s
     scp->device = sdev;
     /* use request field to save the ptr. to completion struct. */
     scp->request = (struct request *)&wait;
-    scp->timeout_per_command = timeout*HZ;
     scp->request_buffer = gdtcmd;
     scp->cmd_len = 12;
     memcpy(scp->cmnd, cmnd, 12);
@@ -4951,7 +4950,7 @@ static int gdth_queuecommand(Scsi_Cmnd *
     if (scp->done == gdth_scsi_done)
         priority = scp->SCp.this_residual;
     else
-        gdth_update_timeout(hanum, scp, scp->timeout_per_command * 6);
+        gdth_update_timeout(hanum, scp, scp->request->timeout* 6);
 
     gdth_putq( hanum, scp, priority );
     gdth_next( hanum );
diff -aurp linux-2.6.18-rc2/drivers/scsi/gdth_proc.c linux-2.6.18-rc2.blkeh/drivers/scsi/gdth_proc.c
--- linux-2.6.18-rc2/drivers/scsi/gdth_proc.c	2006-07-15 17:53:08.000000000 -0400
+++ linux-2.6.18-rc2.blkeh/drivers/scsi/gdth_proc.c	2006-07-25 04:44:39.000000000 -0400
@@ -846,19 +846,19 @@ static int gdth_update_timeout(int hanum
 {
     int oldto;
 
-    oldto = scp->timeout_per_command;
-    scp->timeout_per_command = timeout;
+    oldto = scp->request->timeout;
+    scp->request->timeout = timeout;
 
     if (timeout == 0) {
-        del_timer(&scp->eh_timeout);
-        scp->eh_timeout.data = (unsigned long) NULL;
-        scp->eh_timeout.expires = 0;
+        del_timer(&scp->request->timer);
+        scp->request->timer.data = (unsigned long) NULL;
+        scp->request->timer.expires = 0;
     } else {
-        if (scp->eh_timeout.data != (unsigned long) NULL) 
-            del_timer(&scp->eh_timeout);
-        scp->eh_timeout.data = (unsigned long) scp;
-        scp->eh_timeout.expires = jiffies + timeout;
-        add_timer(&scp->eh_timeout);
+        if (scp->request->timer.data != (unsigned long) NULL) 
+            del_timer(&scp->request->timer);
+        scp->request->timer.data = (unsigned long) scp;
+        scp->request->timer.expires = jiffies + timeout;
+        add_timer(&scp->request->timer);
     }
 
     return oldto;
diff -aurp linux-2.6.18-rc2/drivers/scsi/ibmvscsi/ibmvscsi.c linux-2.6.18-rc2.blkeh/drivers/scsi/ibmvscsi/ibmvscsi.c
--- linux-2.6.18-rc2/drivers/scsi/ibmvscsi/ibmvscsi.c	2006-07-15 17:53:08.000000000 -0400
+++ linux-2.6.18-rc2.blkeh/drivers/scsi/ibmvscsi/ibmvscsi.c	2006-07-25 05:12:39.000000000 -0400
@@ -681,7 +681,7 @@ static int ibmvscsi_queuecommand(struct 
 	init_event_struct(evt_struct,
 			  handle_cmd_rsp,
 			  VIOSRP_SRP_FORMAT,
-			  cmnd->timeout_per_command/HZ);
+			  cmnd->request->timeout/HZ);
 
 	evt_struct->cmnd = cmnd;
 	evt_struct->cmnd_done = done;
diff -aurp linux-2.6.18-rc2/drivers/scsi/ide-scsi.c linux-2.6.18-rc2.blkeh/drivers/scsi/ide-scsi.c
--- linux-2.6.18-rc2/drivers/scsi/ide-scsi.c	2006-07-15 17:53:08.000000000 -0400
+++ linux-2.6.18-rc2.blkeh/drivers/scsi/ide-scsi.c	2006-07-25 04:46:27.000000000 -0400
@@ -921,7 +921,7 @@ static int idescsi_queue (struct scsi_cm
 	pc->request_transfer = pc->buffer_size = cmd->request_bufflen;
 	pc->scsi_cmd = cmd;
 	pc->done = done;
-	pc->timeout = jiffies + cmd->timeout_per_command;
+	pc->timeout = jiffies + cmd->request->timeout;
 
 	if (should_transform(drive, cmd))
 		set_bit(PC_TRANSFORM, &pc->flags);
diff -aurp linux-2.6.18-rc2/drivers/scsi/ipr.c linux-2.6.18-rc2.blkeh/drivers/scsi/ipr.c
--- linux-2.6.18-rc2/drivers/scsi/ipr.c	2006-07-15 17:53:08.000000000 -0400
+++ linux-2.6.18-rc2.blkeh/drivers/scsi/ipr.c	2006-07-25 03:30:46.000000000 -0400
@@ -3186,7 +3186,7 @@ static int ipr_slave_configure(struct sc
 			sdev->no_uld_attach = 1;
 		}
 		if (ipr_is_vset_device(res)) {
-			sdev->timeout = IPR_VSET_RW_TIMEOUT;
+			blk_queue_rq_timeout(IPR_VSET_RW_TIMEOUT);
 			blk_queue_max_sectors(sdev->request_queue, IPR_VSET_MAX_SECTORS);
 		}
 		if (ipr_is_vset_device(res) || ipr_is_scsi_disk(res))
diff -aurp linux-2.6.18-rc2/drivers/scsi/ips.c linux-2.6.18-rc2.blkeh/drivers/scsi/ips.c
--- linux-2.6.18-rc2/drivers/scsi/ips.c	2006-07-15 17:53:08.000000000 -0400
+++ linux-2.6.18-rc2.blkeh/drivers/scsi/ips.c	2006-07-25 04:47:04.000000000 -0400
@@ -4030,7 +4030,7 @@ ips_send_cmd(ips_ha_t * ha, ips_scb_t * 
 		scb->cmd.dcdb.segment_4G = 0;
 		scb->cmd.dcdb.enhanced_sg = 0;
 
-		TimeOut = scb->scsi_cmd->timeout_per_command;
+		TimeOut = scb->scsi_cmd->request->timeout;
 
 		if (ha->subsys->param[4] & 0x00100000) {	/* If NEW Tape DCDB is Supported */
 			if (!scb->sg_len) {
diff -aurp linux-2.6.18-rc2/drivers/scsi/libata-eh.c linux-2.6.18-rc2.blkeh/drivers/scsi/libata-eh.c
--- linux-2.6.18-rc2/drivers/scsi/libata-eh.c	2006-07-15 17:53:08.000000000 -0400
+++ linux-2.6.18-rc2.blkeh/drivers/scsi/libata-eh.c	2006-07-25 03:30:46.000000000 -0400
@@ -34,6 +34,7 @@
 
 #include <linux/config.h>
 #include <linux/kernel.h>
+#include <linux/blkdev.h>
 #include <scsi/scsi.h>
 #include <scsi/scsi_host.h>
 #include <scsi/scsi_eh.h>
@@ -146,29 +147,29 @@ static void ata_eh_clear_action(struct a
  *	RETURNS:
  *	EH_HANDLED or EH_NOT_HANDLED
  */
-enum scsi_eh_timer_return ata_scsi_timed_out(struct scsi_cmnd *cmd)
+enum blk_eh_timer_return ata_scsi_timed_out(struct scsi_cmnd *cmd)
 {
 	struct Scsi_Host *host = cmd->device->host;
 	struct ata_port *ap = ata_shost_to_port(host);
 	unsigned long flags;
 	struct ata_queued_cmd *qc;
-	enum scsi_eh_timer_return ret;
+	enum blk_eh_timer_return ret;
 
 	DPRINTK("ENTER\n");
 
 	if (ap->ops->error_handler) {
-		ret = EH_NOT_HANDLED;
+		ret = BLK_EH_NOT_HANDLED;
 		goto out;
 	}
 
-	ret = EH_HANDLED;
+	ret = BLK_EH_HANDLED;
 	spin_lock_irqsave(ap->lock, flags);
 	qc = ata_qc_from_tag(ap, ap->active_tag);
 	if (qc) {
 		WARN_ON(qc->scsicmd != cmd);
 		qc->flags |= ATA_QCFLAG_EH_SCHEDULED;
 		qc->err_mask |= AC_ERR_TIMEOUT;
-		ret = EH_NOT_HANDLED;
+		ret = BLK_EH_NOT_HANDLED;
 	}
 	spin_unlock_irqrestore(ap->lock, flags);
 
@@ -502,7 +503,7 @@ void ata_qc_schedule_eh(struct ata_queue
 	 * Note that ATA_QCFLAG_FAILED is unconditionally set after
 	 * this function completes.
 	 */
-	scsi_req_abort_cmd(qc->scsicmd);
+	blk_abort_req(qc->scsicmd->request);
 }
 
 /**
diff -aurp linux-2.6.18-rc2/drivers/scsi/libata.h linux-2.6.18-rc2.blkeh/drivers/scsi/libata.h
--- linux-2.6.18-rc2/drivers/scsi/libata.h	2006-07-15 17:53:08.000000000 -0400
+++ linux-2.6.18-rc2.blkeh/drivers/scsi/libata.h	2006-07-25 03:30:46.000000000 -0400
@@ -109,7 +109,7 @@ extern void ata_schedule_scsi_eh(struct 
 extern void ata_scsi_dev_rescan(void *data);
 
 /* libata-eh.c */
-extern enum scsi_eh_timer_return ata_scsi_timed_out(struct scsi_cmnd *cmd);
+extern enum blk_eh_timer_return ata_scsi_timed_out(struct scsi_cmnd *cmd);
 extern void ata_scsi_error(struct Scsi_Host *host);
 extern void ata_port_wait_eh(struct ata_port *ap);
 extern void ata_qc_schedule_eh(struct ata_queued_cmd *qc);
diff -aurp linux-2.6.18-rc2/drivers/scsi/ncr53c8xx.c linux-2.6.18-rc2.blkeh/drivers/scsi/ncr53c8xx.c
--- linux-2.6.18-rc2/drivers/scsi/ncr53c8xx.c	2006-07-15 17:53:08.000000000 -0400
+++ linux-2.6.18-rc2.blkeh/drivers/scsi/ncr53c8xx.c	2006-07-25 04:47:25.000000000 -0400
@@ -4191,8 +4191,8 @@ static int ncr_queue_command (struct ncb
 	**
 	**----------------------------------------------------
 	*/
-	if (np->settle_time && cmd->timeout_per_command >= HZ) {
-		u_long tlimit = jiffies + cmd->timeout_per_command - HZ;
+	if (np->settle_time && cmd->request->timeout >= HZ) {
+		u_long tlimit = jiffies + cmd->request->timeout - HZ;
 		if (time_after(np->settle_time, tlimit))
 			np->settle_time = tlimit;
 	}
diff -aurp linux-2.6.18-rc2/drivers/scsi/scsi.c linux-2.6.18-rc2.blkeh/drivers/scsi/scsi.c
--- linux-2.6.18-rc2/drivers/scsi/scsi.c	2006-07-15 17:53:08.000000000 -0400
+++ linux-2.6.18-rc2.blkeh/drivers/scsi/scsi.c	2006-07-25 03:30:46.000000000 -0400
@@ -184,7 +184,6 @@ struct scsi_cmnd *scsi_get_command(struc
 
 		memset(cmd, 0, sizeof(*cmd));
 		cmd->device = dev;
-		init_timer(&cmd->eh_timeout);
 		INIT_LIST_HEAD(&cmd->list);
 		spin_lock_irqsave(&dev->list_lock, flags);
 		list_add_tail(&cmd->list, &dev->cmd_list);
@@ -464,7 +463,7 @@ int scsi_dispatch_cmd(struct scsi_cmnd *
 		 * that the device is no longer present */
 		cmd->result = DID_NO_CONNECT << 16;
 		atomic_inc(&cmd->device->iorequest_cnt);
-		__scsi_done(cmd);
+		__blk_complete_request(cmd->request);
 		/* return 0 (because the command has been processed) */
 		goto out;
 	}
@@ -519,12 +518,6 @@ int scsi_dispatch_cmd(struct scsi_cmnd *
 		host->resetting = 0;
 	}
 
-	/* 
-	 * AK: unlikely race here: for some reason the timer could
-	 * expire before the serial number is set up below.
-	 */
-	scsi_add_timer(cmd, cmd->timeout_per_command, scsi_times_out);
-
 	scsi_log_send(cmd);
 
 	/*
@@ -547,6 +540,12 @@ int scsi_dispatch_cmd(struct scsi_cmnd *
 	}
 
 	spin_lock_irqsave(host->host_lock, flags);
+	/* 
+	 * AK: unlikely race here: for some reason the timer could
+	 * expire before the serial number is set up below.
+	 *
+	 * TODO: kill serial or move to blk layer
+	 */
 	scsi_cmd_get_serial(host, cmd); 
 
 	if (unlikely(host->shost_state == SHOST_DEL)) {
@@ -557,7 +556,7 @@ int scsi_dispatch_cmd(struct scsi_cmnd *
 	}
 	spin_unlock_irqrestore(host->host_lock, flags);
 	if (rtn) {
-		if (scsi_delete_timer(cmd)) {
+		if (blk_delete_timer(cmd->request)) {
 			atomic_inc(&cmd->device->iodone_cnt);
 			scsi_queue_insert(cmd,
 					  (rtn == SCSI_MLQUEUE_DEVICE_BUSY) ?
@@ -572,30 +571,6 @@ int scsi_dispatch_cmd(struct scsi_cmnd *
 	return rtn;
 }
 
-
-/*
- * Per-CPU I/O completion queue.
- */
-static DEFINE_PER_CPU(struct list_head, scsi_done_q);
-
-/**
- * scsi_req_abort_cmd -- Request command recovery for the specified command
- * cmd: pointer to the SCSI command of interest
- *
- * This function requests that SCSI Core start recovery for the
- * command by deleting the timer and adding the command to the eh
- * queue.  It can be called by either LLDDs or SCSI Core.  LLDDs who
- * implement their own error recovery MAY ignore the timeout event if
- * they generated scsi_req_abort_cmd.
- */
-void scsi_req_abort_cmd(struct scsi_cmnd *cmd)
-{
-	if (!scsi_delete_timer(cmd))
-		return;
-	scsi_times_out(cmd);
-}
-EXPORT_SYMBOL(scsi_req_abort_cmd);
-
 /**
  * scsi_done - Enqueue the finished SCSI command into the done queue.
  * @cmd: The SCSI Command for which a low-level device driver (LLDD) gives
@@ -611,42 +586,7 @@ EXPORT_SYMBOL(scsi_req_abort_cmd);
  */
 static void scsi_done(struct scsi_cmnd *cmd)
 {
-	/*
-	 * We don't have to worry about this one timing out any more.
-	 * If we are unable to remove the timer, then the command
-	 * has already timed out.  In which case, we have no choice but to
-	 * let the timeout function run, as we have no idea where in fact
-	 * that function could really be.  It might be on another processor,
-	 * etc, etc.
-	 */
-	if (!scsi_delete_timer(cmd))
-		return;
-	__scsi_done(cmd);
-}
-
-/* Private entry to scsi_done() to complete a command when the timer
- * isn't running --- used by scsi_times_out */
-void __scsi_done(struct scsi_cmnd *cmd)
-{
-	struct request *rq = cmd->request;
-
-	/*
-	 * Set the serial numbers back to zero
-	 */
-	cmd->serial_number = 0;
-
-	atomic_inc(&cmd->device->iodone_cnt);
-	if (cmd->result)
-		atomic_inc(&cmd->device->ioerr_cnt);
-
-	BUG_ON(!rq);
-
-	/*
-	 * The uptodate/nbytes values don't matter, as we allow partial
-	 * completes and thus will check this in the softirq callback
-	 */
-	rq->completion_data = cmd;
-	blk_complete_request(rq);
+	blk_complete_request(cmd->request);
 }
 
 /*
@@ -1030,52 +970,6 @@ struct scsi_device *scsi_device_lookup(s
 }
 EXPORT_SYMBOL(scsi_device_lookup);
 
-/**
- * scsi_device_cancel - cancel outstanding IO to this device
- * @sdev:	Pointer to struct scsi_device
- * @recovery:	Boolean instructing function to recover device or not.
- *
- **/
-int scsi_device_cancel(struct scsi_device *sdev, int recovery)
-{
-	struct scsi_cmnd *scmd;
-	LIST_HEAD(active_list);
-	struct list_head *lh, *lh_sf;
-	unsigned long flags;
-
-	scsi_device_set_state(sdev, SDEV_CANCEL);
-
-	spin_lock_irqsave(&sdev->list_lock, flags);
-	list_for_each_entry(scmd, &sdev->cmd_list, list) {
-		if (scmd->request && scmd->request->rq_status != RQ_INACTIVE) {
-			/*
-			 * If we are unable to remove the timer, it means
-			 * that the command has already timed out or
-			 * finished.
-			 */
-			if (!scsi_delete_timer(scmd))
-				continue;
-			list_add_tail(&scmd->eh_entry, &active_list);
-		}
-	}
-	spin_unlock_irqrestore(&sdev->list_lock, flags);
-
-	if (!list_empty(&active_list)) {
-		list_for_each_safe(lh, lh_sf, &active_list) {
-			scmd = list_entry(lh, struct scsi_cmnd, eh_entry);
-			list_del_init(lh);
-			if (recovery &&
-			    !scsi_eh_scmd_add(scmd, SCSI_EH_CANCEL_CMD)) {
-				scmd->result = (DID_ABORT << 16);
-				scsi_finish_command(scmd);
-			}
-		}
-	}
-
-	return 0;
-}
-EXPORT_SYMBOL(scsi_device_cancel);
-
 MODULE_DESCRIPTION("SCSI core");
 MODULE_LICENSE("GPL");
 
@@ -1084,7 +978,7 @@ MODULE_PARM_DESC(scsi_logging_level, "a 
 
 static int __init init_scsi(void)
 {
-	int error, i;
+	int error;
 
 	error = scsi_init_queue();
 	if (error)
@@ -1105,9 +999,6 @@ static int __init init_scsi(void)
 	if (error)
 		goto cleanup_sysctl;
 
-	for_each_possible_cpu(i)
-		INIT_LIST_HEAD(&per_cpu(scsi_done_q, i));
-
 	printk(KERN_NOTICE "SCSI subsystem initialized\n");
 	return 0;
 
diff -aurp linux-2.6.18-rc2/drivers/scsi/scsi_error.c linux-2.6.18-rc2.blkeh/drivers/scsi/scsi_error.c
--- linux-2.6.18-rc2/drivers/scsi/scsi_error.c	2006-07-15 17:53:08.000000000 -0400
+++ linux-2.6.18-rc2.blkeh/drivers/scsi/scsi_error.c	2006-07-25 03:30:46.000000000 -0400
@@ -112,69 +112,8 @@ int scsi_eh_scmd_add(struct scsi_cmnd *s
 }
 
 /**
- * scsi_add_timer - Start timeout timer for a single scsi command.
- * @scmd:	scsi command that is about to start running.
- * @timeout:	amount of time to allow this command to run.
- * @complete:	timeout function to call if timer isn't canceled.
- *
- * Notes:
- *    This should be turned into an inline function.  Each scsi command
- *    has its own timer, and as it is added to the queue, we set up the
- *    timer.  When the command completes, we cancel the timer.
- **/
-void scsi_add_timer(struct scsi_cmnd *scmd, int timeout,
-		    void (*complete)(struct scsi_cmnd *))
-{
-
-	/*
-	 * If the clock was already running for this command, then
-	 * first delete the timer.  The timer handling code gets rather
-	 * confused if we don't do this.
-	 */
-	if (scmd->eh_timeout.function)
-		del_timer(&scmd->eh_timeout);
-
-	scmd->eh_timeout.data = (unsigned long)scmd;
-	scmd->eh_timeout.expires = jiffies + timeout;
-	scmd->eh_timeout.function = (void (*)(unsigned long)) complete;
-
-	SCSI_LOG_ERROR_RECOVERY(5, printk("%s: scmd: %p, time:"
-					  " %d, (%p)\n", __FUNCTION__,
-					  scmd, timeout, complete));
-
-	add_timer(&scmd->eh_timeout);
-}
-
-/**
- * scsi_delete_timer - Delete/cancel timer for a given function.
- * @scmd:	Cmd that we are canceling timer for
- *
- * Notes:
- *     This should be turned into an inline function.
- *
- * Return value:
- *     1 if we were able to detach the timer.  0 if we blew it, and the
- *     timer function has already started to run.
- **/
-int scsi_delete_timer(struct scsi_cmnd *scmd)
-{
-	int rtn;
-
-	rtn = del_timer(&scmd->eh_timeout);
-
-	SCSI_LOG_ERROR_RECOVERY(5, printk("%s: scmd: %p,"
-					 " rtn: %d\n", __FUNCTION__,
-					 scmd, rtn));
-
-	scmd->eh_timeout.data = (unsigned long)NULL;
-	scmd->eh_timeout.function = NULL;
-
-	return rtn;
-}
-
-/**
  * scsi_times_out - Timeout function for normal scsi commands.
- * @scmd:	Cmd that is timing out.
+ * @req:	request that is timing out.
  *
  * Notes:
  *     We do not need to lock this.  There is the potential for a race
@@ -182,27 +121,28 @@ int scsi_delete_timer(struct scsi_cmnd *
  *     normal completion function determines that the timer has already
  *     fired, then it mustn't do anything.
  **/
-void scsi_times_out(struct scsi_cmnd *scmd)
+enum blk_eh_timer_return scsi_times_out(struct request *req)
 {
+	struct scsi_cmnd *scmd = req->special;
+	enum blk_eh_timer_return rtn = BLK_EH_NOT_HANDLED;
+
 	scsi_log_completion(scmd, TIMEOUT_ERROR);
 
 	if (scmd->device->host->transportt->eh_timed_out)
-		switch (scmd->device->host->transportt->eh_timed_out(scmd)) {
-		case EH_HANDLED:
-			__scsi_done(scmd);
-			return;
-		case EH_RESET_TIMER:
-			scsi_add_timer(scmd, scmd->timeout_per_command,
-				       scsi_times_out);
-			return;
-		case EH_NOT_HANDLED:
+		rtn = scmd->device->host->transportt->eh_timed_out(scmd);
+		switch (rtn) {
+		case BLK_EH_NOT_HANDLED:
 			break;
+		default:
+			return rtn;
 		}
 
 	if (unlikely(!scsi_eh_scmd_add(scmd, SCSI_EH_CANCEL_CMD))) {
 		scmd->result |= DID_TIME_OUT << 16;
-		__scsi_done(scmd);
+		return BLK_EH_HANDLED;
 	}
+
+	return BLK_EH_NOT_HANDLED;
 }
 
 /**
@@ -1678,7 +1618,6 @@ scsi_reset_provider(struct scsi_device *
 	int rtn;
 
 	scmd->request = &req;
-	memset(&scmd->eh_timeout, 0, sizeof(scmd->eh_timeout));
 
 	memset(&scmd->cmnd, '\0', sizeof(scmd->cmnd));
     
@@ -1693,8 +1632,6 @@ scsi_reset_provider(struct scsi_device *
 
 	scmd->sc_data_direction		= DMA_BIDIRECTIONAL;
 
-	init_timer(&scmd->eh_timeout);
-
 	/*
 	 * Sometimes the command can get back into the timer chain,
 	 * so use the pid as an identifier.
diff -aurp linux-2.6.18-rc2/drivers/scsi/scsi_lib.c linux-2.6.18-rc2.blkeh/drivers/scsi/scsi_lib.c
--- linux-2.6.18-rc2/drivers/scsi/scsi_lib.c	2006-07-15 17:53:08.000000000 -0400
+++ linux-2.6.18-rc2.blkeh/drivers/scsi/scsi_lib.c	2006-07-25 05:03:01.000000000 -0400
@@ -1162,7 +1162,6 @@ static void scsi_setup_blk_pc_cmnd(struc
 	
 	cmd->transfersize = req->data_len;
 	cmd->allowed = req->retries;
-	cmd->timeout_per_command = req->timeout;
 	cmd->done = scsi_blk_pc_done;
 }
 
@@ -1419,17 +1418,26 @@ static void scsi_kill_request(struct req
 	spin_unlock(shost->host_lock);
 	spin_lock(sdev->request_queue->queue_lock);
 
-	__scsi_done(cmd);
+	__blk_complete_request(req);
 }
 
 static void scsi_softirq_done(struct request *rq)
 {
-	struct scsi_cmnd *cmd = rq->completion_data;
-	unsigned long wait_for = (cmd->allowed + 1) * cmd->timeout_per_command;
+	struct scsi_cmnd *cmd = rq->special;
+	unsigned long wait_for = (cmd->allowed + 1) * rq->timeout;
 	int disposition;
 
 	INIT_LIST_HEAD(&cmd->eh_entry);
 
+	/*
+	 * Set the serial numbers back to zero
+	 */
+	cmd->serial_number = 0;
+	
+	atomic_inc(&cmd->device->iodone_cnt);
+	if (cmd->result)
+		atomic_inc(&cmd->device->ioerr_cnt);
+
 	disposition = scsi_decide_disposition(cmd);
 	if (disposition != SUCCESS &&
 	    time_before(cmd->jiffies_at_alloc + wait_for, jiffies)) {
@@ -1632,6 +1640,7 @@ struct request_queue *scsi_alloc_queue(s
 	blk_queue_segment_boundary(q, shost->dma_boundary);
 	blk_queue_issue_flush_fn(q, scsi_issue_flush_fn);
 	blk_queue_softirq_done(q, scsi_softirq_done);
+	blk_queue_rq_timed_out(q, scsi_times_out);
 
 	if (!shost->use_clustering)
 		clear_bit(QUEUE_FLAG_CLUSTER, &q->queue_flags);
diff -aurp linux-2.6.18-rc2/drivers/scsi/scsi_priv.h linux-2.6.18-rc2.blkeh/drivers/scsi/scsi_priv.h
--- linux-2.6.18-rc2/drivers/scsi/scsi_priv.h	2006-07-15 17:53:08.000000000 -0400
+++ linux-2.6.18-rc2.blkeh/drivers/scsi/scsi_priv.h	2006-07-25 03:30:46.000000000 -0400
@@ -4,6 +4,7 @@
 #include <linux/device.h>
 
 struct request_queue;
+struct request;
 struct scsi_cmnd;
 struct scsi_device;
 struct scsi_host_template;
@@ -26,7 +27,6 @@ extern void scsi_exit_hosts(void);
 extern int scsi_dispatch_cmd(struct scsi_cmnd *cmd);
 extern int scsi_setup_command_freelist(struct Scsi_Host *shost);
 extern void scsi_destroy_command_freelist(struct Scsi_Host *shost);
-extern void __scsi_done(struct scsi_cmnd *cmd);
 extern int scsi_retry_command(struct scsi_cmnd *cmd);
 #ifdef CONFIG_SCSI_LOGGING
 void scsi_log_send(struct scsi_cmnd *cmd);
@@ -46,10 +46,7 @@ extern int __init scsi_init_devinfo(void
 extern void scsi_exit_devinfo(void);
 
 /* scsi_error.c */
-extern void scsi_add_timer(struct scsi_cmnd *, int,
-		void (*)(struct scsi_cmnd *));
-extern int scsi_delete_timer(struct scsi_cmnd *);
-extern void scsi_times_out(struct scsi_cmnd *cmd);
+extern enum blk_eh_timer_return scsi_times_out(struct request *req);
 extern int scsi_error_handler(void *host);
 extern int scsi_decide_disposition(struct scsi_cmnd *cmd);
 extern void scsi_eh_wakeup(struct Scsi_Host *shost);
diff -aurp linux-2.6.18-rc2/drivers/scsi/scsi_sysfs.c linux-2.6.18-rc2.blkeh/drivers/scsi/scsi_sysfs.c
--- linux-2.6.18-rc2/drivers/scsi/scsi_sysfs.c	2006-07-15 17:53:08.000000000 -0400
+++ linux-2.6.18-rc2.blkeh/drivers/scsi/scsi_sysfs.c	2006-07-25 03:30:46.000000000 -0400
@@ -422,12 +422,15 @@ sdev_rd_attr (vendor, "%.8s\n");
 sdev_rd_attr (model, "%.16s\n");
 sdev_rd_attr (rev, "%.4s\n");
 
+/*
+ * TODO: can we make these symlinks to the block layer ones?
+ */
 static ssize_t
 sdev_show_timeout (struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct scsi_device *sdev;
 	sdev = to_scsi_device(dev);
-	return snprintf (buf, 20, "%d\n", sdev->timeout / HZ);
+	return snprintf (buf, 20, "%d\n", sdev->request_queue->rq_timeout / HZ);
 }
 
 static ssize_t
@@ -437,7 +440,7 @@ sdev_store_timeout (struct device *dev, 
 	int timeout;
 	sdev = to_scsi_device(dev);
 	sscanf (buf, "%d\n", &timeout);
-	sdev->timeout = timeout * HZ;
+	blk_queue_rq_timeout(sdev->request_queue, timeout * HZ);
 	return count;
 }
 static DEVICE_ATTR(timeout, S_IRUGO | S_IWUSR, sdev_show_timeout, sdev_store_timeout);
diff -aurp linux-2.6.18-rc2/drivers/scsi/scsi_transport_fc.c linux-2.6.18-rc2.blkeh/drivers/scsi/scsi_transport_fc.c
--- linux-2.6.18-rc2/drivers/scsi/scsi_transport_fc.c	2006-07-15 17:53:08.000000000 -0400
+++ linux-2.6.18-rc2.blkeh/drivers/scsi/scsi_transport_fc.c	2006-07-25 03:30:46.000000000 -0400
@@ -1130,15 +1130,15 @@ static int fc_rport_match(struct attribu
  * Notes:
  *	This routine assumes no locks are held on entry.
  **/
-static enum scsi_eh_timer_return
+static enum blk_eh_timer_return
 fc_timed_out(struct scsi_cmnd *scmd)
 {
 	struct fc_rport *rport = starget_to_rport(scsi_target(scmd->device));
 
 	if (rport->port_state == FC_PORTSTATE_BLOCKED)
-		return EH_RESET_TIMER;
+		return BLK_EH_RESET_TIMER;
 
-	return EH_NOT_HANDLED;
+	return BLK_EH_NOT_HANDLED;
 }
 
 /*
diff -aurp linux-2.6.18-rc2/drivers/scsi/sd.c linux-2.6.18-rc2.blkeh/drivers/scsi/sd.c
--- linux-2.6.18-rc2/drivers/scsi/sd.c	2006-07-15 17:53:08.000000000 -0400
+++ linux-2.6.18-rc2.blkeh/drivers/scsi/sd.c	2006-07-25 03:30:46.000000000 -0400
@@ -370,7 +370,6 @@ static int sd_init_command(struct scsi_c
 	struct gendisk *disk = rq->rq_disk;
 	sector_t block = rq->sector;
 	unsigned int this_count = SCpnt->request_bufflen >> 9;
-	unsigned int timeout = sdp->timeout;
 
 	SCSI_LOG_HLQUEUE(1, printk("sd_init_command: disk=%s, block=%llu, "
 			    "count=%d\n", disk->disk_name,
@@ -513,7 +512,6 @@ static int sd_init_command(struct scsi_c
 	SCpnt->transfersize = sdp->sector_size;
 	SCpnt->underflow = this_count << 9;
 	SCpnt->allowed = SD_MAX_RETRIES;
-	SCpnt->timeout_per_command = timeout;
 
 	/*
 	 * This is the completion routine we use.  This is matched in terms
@@ -1664,11 +1662,12 @@ static int sd_probe(struct device *dev)
 	sdkp->index = index;
 	sdkp->openers = 0;
 
-	if (!sdp->timeout) {
+	if (!sdp->request_queue->rq_timeout) {
 		if (sdp->type != TYPE_MOD)
-			sdp->timeout = SD_TIMEOUT;
+			blk_queue_rq_timeout(sdp->request_queue, SD_TIMEOUT);
 		else
-			sdp->timeout = SD_MOD_TIMEOUT;
+			blk_queue_rq_timeout(sdp->request_queue,
+					     SD_MOD_TIMEOUT);
 	}
 
 	gd->major = sd_major((index & 0xf0) >> 4);
diff -aurp linux-2.6.18-rc2/drivers/scsi/sr.c linux-2.6.18-rc2.blkeh/drivers/scsi/sr.c
--- linux-2.6.18-rc2/drivers/scsi/sr.c	2006-07-15 17:53:08.000000000 -0400
+++ linux-2.6.18-rc2.blkeh/drivers/scsi/sr.c	2006-07-25 03:30:46.000000000 -0400
@@ -297,7 +297,7 @@ static void rw_intr(struct scsi_cmnd * S
 
 static int sr_init_command(struct scsi_cmnd * SCpnt)
 {
-	int block=0, this_count, s_size, timeout = SR_TIMEOUT;
+	int block=0, this_count, s_size;
 	struct scsi_cd *cd = scsi_cd(SCpnt->request->rq_disk);
 
 	SCSI_LOG_HLQUEUE(1, printk("Doing sr request, dev = %s, block = %d\n",
@@ -407,7 +407,6 @@ static int sr_init_command(struct scsi_c
 	SCpnt->transfersize = cd->device->sector_size;
 	SCpnt->underflow = this_count << 9;
 	SCpnt->allowed = MAX_RETRIES;
-	SCpnt->timeout_per_command = timeout;
 
 	/*
 	 * This is the completion routine we use.  This is matched in terms
@@ -570,6 +569,8 @@ static int sr_probe(struct device *dev)
 	disk->fops = &sr_bdops;
 	disk->flags = GENHD_FL_CD;
 
+	blk_queue_rq_timeout(sdev->request_queue, SR_TIMEOUT);
+
 	cd->device = sdev;
 	cd->disk = disk;
 	cd->driver = &sr_template;
diff -aurp linux-2.6.18-rc2/drivers/scsi/sym53c8xx_2/sym_glue.c linux-2.6.18-rc2.blkeh/drivers/scsi/sym53c8xx_2/sym_glue.c
--- linux-2.6.18-rc2/drivers/scsi/sym53c8xx_2/sym_glue.c	2006-07-15 17:53:08.000000000 -0400
+++ linux-2.6.18-rc2.blkeh/drivers/scsi/sym53c8xx_2/sym_glue.c	2006-07-25 05:12:08.000000000 -0400
@@ -632,8 +632,8 @@ static int sym53c8xx_queue_command(struc
 	 *  Shorten our settle_time if needed for 
 	 *  this command not to time out.
 	 */
-	if (np->s.settle_time_valid && cmd->timeout_per_command) {
-		unsigned long tlimit = jiffies + cmd->timeout_per_command;
+	if (np->s.settle_time_valid && cmd->request->timeout) {
+		unsigned long tlimit = jiffies + cmd->request->timeout;
 		tlimit -= SYM_CONF_TIMER_INTERVAL*2;
 		if (time_after(np->s.settle_time, tlimit)) {
 			np->s.settle_time = tlimit;
diff -aurp linux-2.6.18-rc2/include/scsi/scsi_cmnd.h linux-2.6.18-rc2.blkeh/include/scsi/scsi_cmnd.h
--- linux-2.6.18-rc2/include/scsi/scsi_cmnd.h	2006-07-15 17:53:08.000000000 -0400
+++ linux-2.6.18-rc2.blkeh/include/scsi/scsi_cmnd.h	2006-07-25 03:30:46.000000000 -0400
@@ -55,7 +55,6 @@ struct scsi_cmnd {
 
 	int retries;
 	int allowed;
-	int timeout_per_command;
 
 	unsigned char cmd_len;
 	unsigned char old_cmd_len;
@@ -67,7 +66,6 @@ struct scsi_cmnd {
 	unsigned char cmnd[MAX_COMMAND_SIZE];
 	unsigned request_bufflen;	/* Actual request size */
 
-	struct timer_list eh_timeout;	/* Used to time out the command. */
 	void *request_buffer;		/* Actual requested buffer */
 
 	/* These elements define the operation we ultimately want to perform */
@@ -145,7 +143,6 @@ extern struct scsi_cmnd *scsi_get_comman
 extern void scsi_put_command(struct scsi_cmnd *);
 extern void scsi_io_completion(struct scsi_cmnd *, unsigned int);
 extern void scsi_finish_command(struct scsi_cmnd *cmd);
-extern void scsi_req_abort_cmd(struct scsi_cmnd *cmd);
 
 extern void *scsi_kmap_atomic_sg(struct scatterlist *sg, int sg_count,
 				 size_t *offset, size_t *len);
diff -aurp linux-2.6.18-rc2/include/scsi/scsi_device.h linux-2.6.18-rc2.blkeh/include/scsi/scsi_device.h
--- linux-2.6.18-rc2/include/scsi/scsi_device.h	2006-07-15 17:53:08.000000000 -0400
+++ linux-2.6.18-rc2.blkeh/include/scsi/scsi_device.h	2006-07-25 03:30:46.000000000 -0400
@@ -203,7 +203,6 @@ extern struct scsi_device *__scsi_add_de
 extern int scsi_add_device(struct Scsi_Host *host, uint channel,
 			   uint target, uint lun);
 extern void scsi_remove_device(struct scsi_device *);
-extern int scsi_device_cancel(struct scsi_device *, int);
 
 extern int scsi_device_get(struct scsi_device *);
 extern void scsi_device_put(struct scsi_device *);
diff -aurp linux-2.6.18-rc2/include/scsi/scsi_host.h linux-2.6.18-rc2.blkeh/include/scsi/scsi_host.h
--- linux-2.6.18-rc2/include/scsi/scsi_host.h	2006-07-15 17:53:08.000000000 -0400
+++ linux-2.6.18-rc2.blkeh/include/scsi/scsi_host.h	2006-07-25 03:30:46.000000000 -0400
@@ -34,13 +34,6 @@ struct scsi_transport_template;
 #define DISABLE_CLUSTERING 0
 #define ENABLE_CLUSTERING 1
 
-enum scsi_eh_timer_return {
-	EH_NOT_HANDLED,
-	EH_HANDLED,
-	EH_RESET_TIMER,
-};
-
-
 struct scsi_host_template {
 	struct module *module;
 	const char *name;
diff -aurp linux-2.6.18-rc2/include/scsi/scsi_transport.h linux-2.6.18-rc2.blkeh/include/scsi/scsi_transport.h
--- linux-2.6.18-rc2/include/scsi/scsi_transport.h	2006-07-15 17:53:08.000000000 -0400
+++ linux-2.6.18-rc2.blkeh/include/scsi/scsi_transport.h	2006-07-25 03:30:46.000000000 -0400
@@ -21,6 +21,7 @@
 #define SCSI_TRANSPORT_H
 
 #include <linux/transport_class.h>
+#include <linux/blkdev.h>
 #include <scsi/scsi_host.h>
 
 struct scsi_transport_template {
@@ -63,7 +64,7 @@ struct scsi_transport_template {
 	 *			begin counting again
 	 * EH_NOT_HANDLED	Begin normal error recovery
 	 */
-	enum scsi_eh_timer_return (* eh_timed_out)(struct scsi_cmnd *);
+	enum blk_eh_timer_return (* eh_timed_out)(struct scsi_cmnd *);
 };
 
 #define transport_class_to_shost(tc) \


