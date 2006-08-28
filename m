Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750989AbWH1OXz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750989AbWH1OXz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 10:23:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750975AbWH1OXy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 10:23:54 -0400
Received: from 67.111.72.3.ptr.us.xo.net ([67.111.72.3]:63107 "EHLO
	nonameb.ptu.promise.com") by vger.kernel.org with ESMTP
	id S1750968AbWH1OXw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 10:23:52 -0400
Date: Mon, 28 Aug 2006 22:23:27 +0800
From: "Ed Lin" <ed.lin@promise.com>
To: "linux-scsi" <linux-scsi@vger.kernel.org>
Cc: "promise_linux@promise.com" <promise_linux@promise.com>,
       "James Bottomley" <James.Bottomley@SteelEye.com>,
       "jeff" <jeff@garzik.org>, "linux-kernel" <linux-kernel@vger.kernel.org>,
       "akpm" <akpm@osdl.org>
Subject: [patch 2/3] stex: use more efficient method for unload/shutdown flush
X-mailer: Foxmail 5.0 [cn]
Mime-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: 7bit
Message-ID: <NONAMEBXDvCeqTPcaWC00000d5e@nonameb.ptu.promise.com>
X-OriginalArrivalTime: 28 Aug 2006 14:23:00.0671 (UTC) FILETIME=[7752DCF0:01C6CAAD]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Ed Lin" <ed.lin@promise.com>

- indicate correct MODE SENSE caching page for shutdown sd flush
- implement slave_destroy for driver unload flush
- modify notification routine(stex_hba_stop) for firmware to prepare shutdown
- adjust alloc/free tag functions for this purpose as necessary
---
diff --git a/drivers/scsi/stex.c b/drivers/scsi/stex.c
index cb17415..22a2dfb 100644
--- a/drivers/scsi/stex.c
+++ b/drivers/scsi/stex.c
@@ -309,7 +309,7 @@ static void stex_gettime(__le32 *time)
 	*(time + 1) = cpu_to_le32((tv.tv_sec >> 16) >> 16);
 }
 
-static u16 stex_alloc_tag(unsigned long *bitmap)
+static u16 __stex_alloc_tag(unsigned long *bitmap)
 {
 	int i;
 	i = find_first_zero_bit(bitmap, TAG_BITMAP_LENGTH);
@@ -318,11 +318,31 @@ static u16 stex_alloc_tag(unsigned long 
 	return (u16)i;
 }
 
-static void stex_free_tag(unsigned long *bitmap, u16 tag)
+static u16 stex_alloc_tag(struct st_hba *hba, unsigned long *bitmap)
+{
+	unsigned long flags;
+	u16 tag;
+
+	spin_lock_irqsave(hba->host->host_lock, flags);
+	tag = __stex_alloc_tag(bitmap);
+	spin_unlock_irqrestore(hba->host->host_lock, flags);
+	return tag;
+}
+
+static void __stex_free_tag(unsigned long *bitmap, u16 tag)
 {
 	__clear_bit((int)tag, bitmap);
 }
 
+static void stex_free_tag(struct st_hba *hba, unsigned long *bitmap, u16 tag)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(hba->host->host_lock, flags);
+	__stex_free_tag(bitmap, tag);
+	spin_unlock_irqrestore(hba->host->host_lock, flags);
+}
+
 static struct status_msg *stex_get_status(struct st_hba *hba)
 {
 	struct status_msg *status =
@@ -523,6 +543,51 @@ stex_slave_config(struct scsi_device *sd
 	return 0;
 }
 
+static void
+stex_slave_destroy(struct scsi_device *sdev)
+{
+	struct st_hba *hba = (struct st_hba *) sdev->host->hostdata;
+	struct req_msg *req;
+	unsigned long flags;
+	unsigned long before;
+	u16 tag;
+
+	if (sdev->type != TYPE_DISK)
+		return;
+
+	before = jiffies;
+	while ((tag = stex_alloc_tag(hba, (unsigned long *)&hba->tag))
+		== TAG_BITMAP_LENGTH) {
+		if (time_after(jiffies, before + ST_INTERNAL_TIMEOUT * HZ))
+			return;
+		msleep(10);
+	}
+
+	spin_lock_irqsave(hba->host->host_lock, flags);
+	req = stex_alloc_req(hba);
+	memset(req->cdb, 0, STEX_CDB_LENGTH);
+
+	req->target = sdev->id;
+	req->lun = sdev->channel; /* firmware lun issue work around */
+	req->cdb[0] = SYNCHRONIZE_CACHE;
+
+	hba->ccb[tag].cmd = NULL;
+	hba->ccb[tag].sg_count = 0;
+	hba->ccb[tag].sense_bufflen = 0;
+	hba->ccb[tag].sense_buffer = NULL;
+	hba->ccb[tag].req_type |= PASSTHRU_REQ_TYPE;
+
+	stex_send_cmd(hba, req, tag);
+	spin_unlock_irqrestore(hba->host->host_lock, flags);
+
+	wait_event_timeout(hba->waitq,
+		!(hba->ccb[tag].req_type), ST_INTERNAL_TIMEOUT * HZ);
+	if (hba->ccb[tag].req_type & PASSTHRU_REQ_TYPE)
+		return;
+
+	stex_free_tag(hba, (unsigned long *)&hba->tag, tag);
+}
+
 static int
 stex_queuecommand(struct scsi_cmnd *cmd, void (* done)(struct scsi_cmnd *))
 {
@@ -539,9 +604,11 @@ stex_queuecommand(struct scsi_cmnd *cmd,
 	switch (cmd->cmnd[0]) {
 	case MODE_SENSE_10:
 	{
-		static char mode_sense10[8] = { 0, 6, 0, 0, 0, 0, 0, 0 };
-
-		stex_direct_copy(cmd, mode_sense10, sizeof(mode_sense10));
+		static char ms10_caching_page[12] =
+			{ 0, 0x12, 0, 0, 0, 0, 0, 0, 0x8, 0xa, 0x4, 0 };
+		if (cmd->cmnd[2] == 0x8)
+			stex_direct_copy(cmd, ms10_caching_page,
+					sizeof(ms10_caching_page));
 		cmd->result = DID_OK << 16 | COMMAND_COMPLETE << 8;
 		done(cmd);
 		return 0;
@@ -579,7 +646,7 @@ stex_queuecommand(struct scsi_cmnd *cmd,
 
 	cmd->scsi_done = done;
 
-	if (unlikely((tag = stex_alloc_tag((unsigned long *)&hba->tag))
+	if (unlikely((tag = __stex_alloc_tag((unsigned long *)&hba->tag))
 		== TAG_BITMAP_LENGTH))
 		return SCSI_MLQUEUE_HOST_BUSY;
 
@@ -718,7 +785,7 @@ static void stex_mu_intr(struct st_hba *
 		if (unlikely(ccb->req == NULL)) {
 			printk(KERN_WARNING DRV_NAME
 				"(%s): lagging req\n", pci_name(hba->pdev));
-			stex_free_tag((unsigned long *)&hba->tag, tag);
+			__stex_free_tag((unsigned long *)&hba->tag, tag);
 			stex_unmap_sg(hba, ccb->cmd); /* ??? */
 			continue;
 		}
@@ -750,7 +817,7 @@ static void stex_mu_intr(struct st_hba *
 		if (ccb->cmd->cmnd[0] == PASSTHRU_CMD &&
 			ccb->cmd->cmnd[1] == PASSTHRU_GET_ADAPTER)
 			stex_controller_info(hba, ccb);
-		stex_free_tag((unsigned long *)&hba->tag, tag);
+		__stex_free_tag((unsigned long *)&hba->tag, tag);
 		stex_unmap_sg(hba, ccb->cmd);
 		stex_scsi_done(ccb);
 	}
@@ -965,34 +1032,6 @@ static int stex_reset(struct scsi_cmnd *
 	return SUCCESS;
 }
 
-static void stex_internal_flush(struct st_hba *hba, int id, u16 tag)
-{
-	struct req_msg *req;
-
-	req = stex_alloc_req(hba);
-	memset(req->cdb, 0, STEX_CDB_LENGTH);
-
-	if (id < ST_MAX_ARRAY_SUPPORTED*ST_MAX_LUN_PER_TARGET) {
-		req->target = id/ST_MAX_LUN_PER_TARGET;
-		req->lun = id%ST_MAX_LUN_PER_TARGET;
-		req->cdb[0] = CONTROLLER_CMD;
-		req->cdb[1] = CTLR_POWER_STATE_CHANGE;
-		req->cdb[2] = CTLR_POWER_SAVING;
-	} else {
-		req->target = id/ST_MAX_LUN_PER_TARGET - ST_MAX_ARRAY_SUPPORTED;
-		req->lun = id%ST_MAX_LUN_PER_TARGET;
-		req->cdb[0] = SYNCHRONIZE_CACHE;
-	}
-
-	hba->ccb[tag].cmd = NULL;
-	hba->ccb[tag].sg_count = 0;
-	hba->ccb[tag].sense_bufflen = 0;
-	hba->ccb[tag].sense_buffer = NULL;
-	hba->ccb[tag].req_type |= PASSTHRU_REQ_TYPE;
-
-	stex_send_cmd(hba, req, tag);
-}
-
 static int stex_biosparam(struct scsi_device *sdev,
 	struct block_device *bdev, sector_t capacity, int geom[])
 {
@@ -1019,6 +1058,7 @@ static struct scsi_host_template driver_
 	.bios_param			= stex_biosparam,
 	.queuecommand			= stex_queuecommand,
 	.slave_configure		= stex_slave_config,
+	.slave_destroy			= stex_slave_destroy,
 	.eh_abort_handler		= stex_abort,
 	.eh_host_reset_handler		= stex_reset,
 	.can_queue			= ST_CAN_QUEUE,
@@ -1159,31 +1199,42 @@ out_disable:
 
 static void stex_hba_stop(struct st_hba *hba)
 {
+	struct req_msg *req;
 	unsigned long flags;
-	int i;
+	unsigned long before;
 	u16 tag;
 
-	spin_lock_irqsave(hba->host->host_lock, flags);
-	if ((tag = stex_alloc_tag((unsigned long *)&hba->tag))
+	before = jiffies;
+	while ((tag = stex_alloc_tag(hba, (unsigned long *)&hba->tag))
 		== TAG_BITMAP_LENGTH) {
-		spin_unlock_irqrestore(hba->host->host_lock, flags);
-		printk(KERN_ERR DRV_NAME "(%s): unable to alloc tag\n",
-			pci_name(hba->pdev));
-		return;
-	}
-	for (i=0; i<(ST_MAX_ARRAY_SUPPORTED*ST_MAX_LUN_PER_TARGET*2); i++) {
-		stex_internal_flush(hba, i, tag);
-		spin_unlock_irqrestore(hba->host->host_lock, flags);
-
-		wait_event_timeout(hba->waitq,
-			!(hba->ccb[tag].req_type), ST_INTERNAL_TIMEOUT*HZ);
-		if (hba->ccb[tag].req_type & PASSTHRU_REQ_TYPE)
+		if (time_after(jiffies, before + ST_INTERNAL_TIMEOUT * HZ))
 			return;
-		spin_lock_irqsave(hba->host->host_lock, flags);
+		msleep(10);
 	}
 
-	stex_free_tag((unsigned long *)&hba->tag, tag);
+	spin_lock_irqsave(hba->host->host_lock, flags);
+	req = stex_alloc_req(hba);
+	memset(req->cdb, 0, STEX_CDB_LENGTH);
+
+	req->cdb[0] = CONTROLLER_CMD;
+	req->cdb[1] = CTLR_POWER_STATE_CHANGE;
+	req->cdb[2] = CTLR_POWER_SAVING;
+
+	hba->ccb[tag].cmd = NULL;
+	hba->ccb[tag].sg_count = 0;
+	hba->ccb[tag].sense_bufflen = 0;
+	hba->ccb[tag].sense_buffer = NULL;
+	hba->ccb[tag].req_type |= PASSTHRU_REQ_TYPE;
+
+	stex_send_cmd(hba, req, tag);
 	spin_unlock_irqrestore(hba->host->host_lock, flags);
+
+	wait_event_timeout(hba->waitq,
+		!(hba->ccb[tag].req_type), ST_INTERNAL_TIMEOUT * HZ);
+	if (hba->ccb[tag].req_type & PASSTHRU_REQ_TYPE)
+		return;
+
+	stex_free_tag(hba, (unsigned long *)&hba->tag, tag);
 }
 
 static void stex_hba_free(struct st_hba *hba)

