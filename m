Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750975AbWH1OYJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750975AbWH1OYJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 10:24:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750987AbWH1OYI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 10:24:08 -0400
Received: from 67.111.72.3.ptr.us.xo.net ([67.111.72.3]:49284 "EHLO
	nonameb.ptu.promise.com") by vger.kernel.org with ESMTP
	id S1750979AbWH1OYD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 10:24:03 -0400
Date: Mon, 28 Aug 2006 22:23:37 +0800
From: "Ed Lin" <ed.lin@promise.com>
To: "linux-scsi" <linux-scsi@vger.kernel.org>
Cc: "linux-kernel" <linux-kernel@vger.kernel.org>, "akpm" <akpm@osdl.org>,
       "promise_linux" <promise_linux@promise.com>,
       "james.Bottomley" <james.Bottomley@SteelEye.com>,
       "jeff" <jeff@garzik.org>
Subject: [patch 3/3] stex: use block layer tagging
X-mailer: Foxmail 5.0 [cn]
Mime-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: 7bit
Message-ID: <NONAMEBkWZ7fIZHO1g400000d5f@nonameb.ptu.promise.com>
X-OriginalArrivalTime: 28 Aug 2006 14:23:12.0500 (UTC) FILETIME=[7E5FD340:01C6CAAD]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Ed Lin" <ed.lin@promise.com>

use block layer tagging for hot path. we configure it in
slave_alloc routine because we need tagging from the beginning.
we implement host-wide tagging using shared map.
---
diff --git a/drivers/scsi/stex.c b/drivers/scsi/stex.c
index 22a2dfb..f798a5b 100644
--- a/drivers/scsi/stex.c
+++ b/drivers/scsi/stex.c
@@ -34,6 +34,7 @@ #include <scsi/scsi.h>
 #include <scsi/scsi_device.h>
 #include <scsi/scsi_cmnd.h>
 #include <scsi/scsi_host.h>
+#include <scsi/scsi_tcq.h>
 
 #define DRV_NAME "stex"
 #define ST_DRIVER_VERSION "2.9.0.13"
@@ -280,6 +281,9 @@ struct st_hba {
 	unsigned int mu_status;
 	int out_req_cnt;
 
+	int devnum;
+	int ref;
+	struct request_queue *shared_queue;
 	unsigned int cardtype;
 };
 
@@ -535,11 +539,53 @@ stex_send_cmd(struct st_hba *hba, struct
 }
 
 static int
+stex_slave_alloc(struct scsi_device *sdev)
+{
+	struct st_hba *hba = (struct st_hba *) sdev->host->hostdata;
+	unsigned long flags;
+
+	/*
+	 * this should be done in slave_configure routine. but we need
+	 * tagging ever since the first command. we can't wait...
+	 */
+	spin_lock_irqsave(hba->host->host_lock, flags);
+	if (hba->devnum++ == 0) {
+		if (blk_queue_init_tags(sdev->request_queue,
+				hba->host->can_queue, NULL) == 0) {
+			hba->ref = 1;
+			hba->shared_queue = sdev->request_queue;
+		} else
+			sdev->tagged_supported = 0;
+	} else if (hba->ref == 0) {
+		sdev->tagged_supported = 0;
+		spin_unlock_irqrestore(hba->host->host_lock, flags);
+		return 0;
+	} else {
+		blk_queue_init_tags(sdev->request_queue,
+			hba->host->can_queue, hba->shared_queue->queue_tags);
+		hba->ref++;
+	}
+
+	if (hba->ref) {
+		sdev->tagged_supported = 1;
+		scsi_set_tag_type(sdev, MSG_SIMPLE_TAG);
+		scsi_adjust_queue_depth(sdev,
+			scsi_get_tag_type(sdev), hba->host->can_queue);
+	}
+	spin_unlock_irqrestore(hba->host->host_lock, flags);
+
+	return 0;
+}
+
+static int
 stex_slave_config(struct scsi_device *sdev)
 {
+	struct st_hba *hba = (struct st_hba *) sdev->host->hostdata;
 	sdev->use_10_for_rw = 1;
 	sdev->use_10_for_ms = 1;
 	sdev->timeout = 60 * HZ;
+	sdev->tagged_supported = hba->ref ? 1 : 0;
+
 	return 0;
 }
 
@@ -552,6 +598,13 @@ stex_slave_destroy(struct scsi_device *s
 	unsigned long before;
 	u16 tag;
 
+	spin_lock_irqsave(hba->host->host_lock, flags);
+	if (--hba->devnum == 0)
+		hba->ref = 0;
+	else if (hba->ref > 0)
+		hba->ref--;
+	spin_unlock_irqrestore(hba->host->host_lock, flags);
+
 	if (sdev->type != TYPE_DISK)
 		return;
 
@@ -646,8 +699,12 @@ stex_queuecommand(struct scsi_cmnd *cmd,
 
 	cmd->scsi_done = done;
 
-	if (unlikely((tag = __stex_alloc_tag((unsigned long *)&hba->tag))
-		== TAG_BITMAP_LENGTH))
+	if (likely(cmd->device->tagged_supported))
+		tag = cmd->request->tag;
+	else
+		tag = __stex_alloc_tag((unsigned long *)&hba->tag);
+	
+	if (unlikely(tag >= host->can_queue))
 		return SCSI_MLQUEUE_HOST_BUSY;
 
 	req = stex_alloc_req(hba);
@@ -767,26 +824,28 @@ static void stex_mu_intr(struct st_hba *
 	while (hba->status_tail != hba->status_head) {
 		resp = stex_get_status(hba);
 		tag = le16_to_cpu(resp->tag);
-		if (unlikely(tag >= TAG_BITMAP_LENGTH)) {
+		if (unlikely(tag >= hba->host->can_queue)) {
 			printk(KERN_WARNING DRV_NAME
 				"(%s): invalid tag\n", pci_name(hba->pdev));
 			continue;
 		}
-		if (unlikely((hba->tag & (1 << tag)) == 0)) {
-			printk(KERN_WARNING DRV_NAME
-				"(%s): null tag\n", pci_name(hba->pdev));
-			continue;
-		}
 
-		hba->out_req_cnt--;
 		ccb = &hba->ccb[tag];
+		if (unlikely(ccb->cmd != NULL &&
+				!ccb->cmd->device->tagged_supported)) {
+			if ((hba->tag & (1 << tag)) == 0) {
+				printk(KERN_WARNING DRV_NAME "(%s): null tag\n",
+					pci_name(hba->pdev));
+				continue;
+			}
+		}
+
 		if (hba->wait_ccb == ccb)
 			hba->wait_ccb = NULL;
 		if (unlikely(ccb->req == NULL)) {
 			printk(KERN_WARNING DRV_NAME
 				"(%s): lagging req\n", pci_name(hba->pdev));
 			__stex_free_tag((unsigned long *)&hba->tag, tag);
-			stex_unmap_sg(hba, ccb->cmd); /* ??? */
 			continue;
 		}
 
@@ -804,7 +863,17 @@ static void stex_mu_intr(struct st_hba *
 		ccb->srb_status = resp->srb_status;
 		ccb->scsi_status = resp->scsi_status;
 
-		if (ccb->req_type & PASSTHRU_REQ_TYPE) {
+		if (likely(ccb->cmd != NULL)) {
+			if (unlikely(ccb->cmd->cmnd[0] == PASSTHRU_CMD &&
+				ccb->cmd->cmnd[1] == PASSTHRU_GET_ADAPTER))
+				stex_controller_info(hba, ccb);
+			if (unlikely(!ccb->cmd->device->tagged_supported))
+				__stex_free_tag((ulong *)&hba->tag, tag);
+			stex_unmap_sg(hba, ccb->cmd);
+			stex_scsi_done(ccb);
+			hba->out_req_cnt--;
+		} else if (ccb->req_type & PASSTHRU_REQ_TYPE) {
+			hba->out_req_cnt--;
 			if (ccb->req_type & PASSTHRU_REQ_NO_WAKEUP) {
 				ccb->req_type = 0;
 				continue;
@@ -812,14 +881,7 @@ static void stex_mu_intr(struct st_hba *
 			ccb->req_type = 0;
 			if (waitqueue_active(&hba->waitq))
 				wake_up(&hba->waitq);
-			continue;
 		}
-		if (ccb->cmd->cmnd[0] == PASSTHRU_CMD &&
-			ccb->cmd->cmnd[1] == PASSTHRU_GET_ADAPTER)
-			stex_controller_info(hba, ccb);
-		__stex_free_tag((unsigned long *)&hba->tag, tag);
-		stex_unmap_sg(hba, ccb->cmd);
-		stex_scsi_done(ccb);
 	}
 
 update_status:
@@ -936,14 +998,22 @@ static int stex_abort(struct scsi_cmnd *
 	unsigned long flags;
 	base = hba->mmio_base;
 	spin_lock_irqsave(host->host_lock, flags);
-
-	for (tag = 0; tag < MU_MAX_REQUEST; tag++)
-		if (hba->ccb[tag].cmd == cmd && (hba->tag & (1 << tag))) {
+	if (likely(cmd->device->tagged_supported)) {
+		tag = cmd->request->tag;
+		if (tag < host->can_queue && hba->ccb[tag].cmd == cmd)
 			hba->wait_ccb = &(hba->ccb[tag]);
-			break;
-		}
-	if (tag >= MU_MAX_REQUEST)
-		goto out;
+		else
+			goto out;
+	} else {
+		for (tag = 0; tag < host->can_queue; tag++)
+			if (hba->ccb[tag].cmd == cmd &&
+					(hba->tag & (1 << tag))) {
+				hba->wait_ccb = &(hba->ccb[tag]);
+				break;
+			}
+		if (tag >= host->can_queue)
+			goto out;
+	}
 
 	data = readl(base + ODBL);
 	if (data == 0 || data == 0xffffffff)
@@ -961,6 +1031,7 @@ static int stex_abort(struct scsi_cmnd *
 	}
 
 fail_out:
+	stex_unmap_sg(hba, cmd);
 	hba->wait_ccb->req = NULL; /* nullify the req's future return */
 	hba->wait_ccb = NULL;
 	result = FAILED;
@@ -1057,6 +1128,7 @@ static struct scsi_host_template driver_
 	.proc_name			= DRV_NAME,
 	.bios_param			= stex_biosparam,
 	.queuecommand			= stex_queuecommand,
+	.slave_alloc			= stex_slave_alloc,
 	.slave_configure		= stex_slave_config,
 	.slave_destroy			= stex_slave_destroy,
 	.eh_abort_handler		= stex_abort,

