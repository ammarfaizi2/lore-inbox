Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161193AbWG1RcS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161193AbWG1RcS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 13:32:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161192AbWG1RcS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 13:32:18 -0400
Received: from 67.111.72.3.ptr.us.xo.net ([67.111.72.3]:38893 "EHLO
	nonameb.ptu.promise.com") by vger.kernel.org with ESMTP
	id S1161190AbWG1RcQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 13:32:16 -0400
Date: Sat, 29 Jul 2006 01:32:04 +0800
From: "Ed Lin" <ed.lin@promise.com>
To: "linux-scsi" <linux-scsi@vger.kernel.org>
Cc: "James.Bottomley" <James.Bottomley@SteelEye.com>,
       "linux-kernel" <linux-kernel@vger.kernel.org>, "akpm" <akpm@osdl.org>,
       "promise_linux" <promise_linux@promise.com>, "jeff" <jeff@garzik.org>
Subject: [PATCH 1/4] stex: cleanup and minor fixes
X-mailer: Foxmail 5.0 [cn]
Mime-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: 7bit
Message-ID: <NONAMEBhA1qfT7eEmP9000002b5@nonameb.ptu.promise.com>
X-OriginalArrivalTime: 28 Jul 2006 17:34:15.0578 (UTC) FILETIME=[0C1877A0:01C6B26C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>From Christoph Hellwig's comments:
    callback argument to ->queuecommand changed to 'done'
	merge init functions into .probe

>From Alexey Dobriyan's comments:
	__le32 *time

Others:
	driver info changed to "SuperTrak EX Series"
	white space fixes
	change msleep(1000) to ssleep(1)
	remove unnecessary code in reset function
	change function name(stex_direct_copy)

Minor fixes:
	INQUIRY, max_channel(do not bother firmware with
	unnecessary commands)
	extend reset wait time

Signed-off-by: Ed Lin <ed.lin@promise.com>
---
 Kconfig |    2 -
 stex.c  |  115 ++++++++++++++++++++++++++++------------------------------------
 2 files changed, 52 insertions(+), 65 deletions(-)
diff -urN a/drivers/scsi/Kconfig b/drivers/scsi/Kconfig
--- a/drivers/scsi/Kconfig	2006-07-28 05:27:38.000000000 -0400
+++ b/drivers/scsi/Kconfig	2006-07-28 05:42:24.000000000 -0400
@@ -1054,7 +1054,7 @@
 	default y
 
 config SCSI_STEX
-	tristate "Promise SuperTrak EX8350/8300/16350/16300 support"
+	tristate "Promise SuperTrak EX Series support"
 	depends on PCI && SCSI
 	---help---
 	  This driver supports Promise SuperTrak EX8350/8300/16350/16300
diff -urN a/drivers/scsi/stex.c b/drivers/scsi/stex.c
--- a/drivers/scsi/stex.c	2006-07-28 05:37:53.000000000 -0400
+++ b/drivers/scsi/stex.c	2006-07-28 05:47:21.000000000 -0400
@@ -1,5 +1,5 @@
 /*
- * SuperTrak EX8350/8300/16350/16300 Storage Controller driver for Linux
+ * SuperTrak EX Series Storage Controller driver for Linux
  *
  *	Copyright (C) 2005, 2006 Promise Technology Inc.
  *
@@ -75,7 +75,7 @@
 	MU_STATE_STARTED			= 4,
 	MU_STATE_RESETTING			= 5,
 
-	MU_MAX_DELAY_TIME			= 50000,
+	MU_MAX_DELAY_TIME			= 240000,
 	MU_HANDSHAKE_SIGNATURE			= 0x55aaaa55,
 	HMU_PARTNER_TYPE			= 2,
 
@@ -102,7 +102,7 @@
 	MU_REQ_COUNT				= (MU_MAX_REQUEST + 1),
 	MU_STATUS_COUNT				= (MU_MAX_REQUEST + 1),
 
-	STEX_CDB_LENGTH			= MAX_COMMAND_SIZE,
+	STEX_CDB_LENGTH				= MAX_COMMAND_SIZE,
 	REQ_VARIABLE_LEN			= 1024,
 	STATUS_VAR_LEN				= 128,
 	ST_CAN_QUEUE				= MU_MAX_REQUEST,
@@ -294,7 +294,7 @@
 MODULE_LICENSE("GPL");
 MODULE_VERSION(ST_DRIVER_VERSION);
 
-static void stex_gettime(u32 *time)
+static void stex_gettime(__le32 *time)
 {
 	struct timeval tv;
 	do_gettimeofday(&tv);
@@ -370,7 +370,7 @@
 			dst->table[i].addr_hi =
 				cpu_to_le32((sg_dma_address(src) >> 16) >> 16);
 			dst->table[i].ctrl = SG_CF_64B | SG_CF_HOST;
-    		}
+		}
 		dst->table[--i].ctrl |= SG_CF_EOT;
 		return 0;
 	}
@@ -388,7 +388,7 @@
 	return 0;
 }
 
-static int stex_direct_cp(struct scsi_cmnd *cmd,
+static int stex_direct_copy(struct scsi_cmnd *cmd,
 	const void *src, unsigned int len)
 {
 	void *dest;
@@ -465,7 +465,7 @@
 }
 
 static int
-stex_queuecommand(struct scsi_cmnd *cmd, void (* fn)(struct scsi_cmnd *))
+stex_queuecommand(struct scsi_cmnd *cmd, void (* done)(struct scsi_cmnd *))
 {
 	struct st_hba *hba;
 	struct Scsi_Host *host;
@@ -482,21 +482,21 @@
 	{
 		static char mode_sense10[8] = { 0, 6, 0, 0, 0, 0, 0, 0 };
 
-		stex_direct_cp(cmd, mode_sense10, sizeof(mode_sense10));
+		stex_direct_copy(cmd, mode_sense10, sizeof(mode_sense10));
 		cmd->result = DID_OK << 16 | COMMAND_COMPLETE << 8;
-		fn(cmd);
+		done(cmd);
 		return 0;
 	}
 	case INQUIRY:
-		if (id != ST_MAX_ARRAY_SUPPORTED || lun != 0)
+		if (id != ST_MAX_ARRAY_SUPPORTED)
 			break;
-		if((cmd->cmnd[1] & INQUIRY_EVPD) == 0) {
-			stex_direct_cp(cmd, console_inq_page,
+		if (lun == 0 && (cmd->cmnd[1] & INQUIRY_EVPD) == 0) {
+			stex_direct_copy(cmd, console_inq_page,
 				sizeof(console_inq_page));
 			cmd->result = DID_OK << 16 | COMMAND_COMPLETE << 8;
 		} else
 			cmd->result = DID_ERROR << 16 | COMMAND_COMPLETE << 8;
-		fn(cmd);
+		done(cmd);
 		return 0;
 	case PASSTHRU_CMD:
 		if (cmd->cmnd[1] == PASSTHRU_GET_DRVVER) {
@@ -508,17 +508,17 @@
 			ver.signature[0] = PASSTHRU_SIGNATURE;
 			ver.console_id = ST_MAX_ARRAY_SUPPORTED;
 			ver.host_no = hba->host->host_no;
-			cmd->result = stex_direct_cp(cmd, &ver, sizeof(ver)) ?
+			cmd->result = stex_direct_copy(cmd, &ver, sizeof(ver)) ?
 				DID_OK << 16 | COMMAND_COMPLETE << 8 :
 				DID_ERROR << 16 | COMMAND_COMPLETE << 8;
-			fn(cmd);
+			done(cmd);
 			return 0;
 		}
 	default:
 		break;
 	}
 
-	cmd->scsi_done = fn;
+	cmd->scsi_done = done;
 
 	if (unlikely((tag = stex_alloc_tag((unsigned long *)&hba->tag))
 		== TAG_BITMAP_LENGTH))
@@ -552,7 +552,7 @@
 static void stex_unmap_sg(struct st_hba *hba, struct scsi_cmnd *cmd)
 {
 	if (cmd->sc_data_direction != DMA_NONE) {
- 		if (cmd->use_sg)
+		if (cmd->use_sg)
 			pci_unmap_sg(hba->pdev, cmd->request_buffer,
 				cmd->use_sg, cmd->sc_data_direction);
 		else
@@ -597,10 +597,10 @@
 		default:
 			result = DID_ERROR << 16 | COMMAND_COMPLETE << 8;
 			break;
-  	}
+	}
 
-   	cmd->result = result;
-   	cmd->scsi_done(cmd);
+	cmd->result = result;
+	cmd->scsi_done(cmd);
 }
 
 static void stex_copy_data(struct st_ccb *ccb,
@@ -672,7 +672,7 @@
 			printk(KERN_WARNING DRV_NAME
 				"(%s): lagging req\n", pci_name(hba->pdev));
 			stex_free_tag((unsigned long *)&hba->tag, tag);
-  			stex_unmap_sg(hba, ccb->cmd); /* ??? */
+			stex_unmap_sg(hba, ccb->cmd); /* ??? */
 			continue;
 		}
 
@@ -704,7 +704,7 @@
 			ccb->cmd->cmnd[1] == PASSTHRU_GET_ADAPTER)
 			stex_controller_info(hba, ccb);
 		stex_free_tag((unsigned long *)&hba->tag, tag);
-  		stex_unmap_sg(hba, ccb->cmd);
+		stex_unmap_sg(hba, ccb->cmd);
 		stex_scsi_done(ccb);
 	}
 
@@ -840,8 +840,8 @@
 
 	stex_mu_intr(hba, data);
 
- 	if (hba->wait_ccb == NULL) {
- 		printk(KERN_WARNING DRV_NAME
+	if (hba->wait_ccb == NULL) {
+		printk(KERN_WARNING DRV_NAME
 			"(%s): lost interrupt\n", pci_name(hba->pdev));
 		goto out;
 	}
@@ -870,15 +870,12 @@
 			break;
 	spin_unlock_irqrestore(hba->host->host_lock, flags);
 	if (tag < MU_MAX_REQUEST) {
-		msleep(1000);
+		ssleep(1);
 		if (++i < 10)
 			goto wait_cmds;
 	}
 
 	hba->mu_status = MU_STATE_RESETTING;
-	writel(MU_INBOUND_DOORBELL_HANDSHAKE, hba->mmio_base + IDBL);
-	readl(hba->mmio_base + IDBL);
-	msleep(3000);
 
 	spin_lock_irqsave(hba->host->host_lock, flags);
 
@@ -910,33 +907,6 @@
 	return SUCCESS;
 }
 
-static void stex_init_hba(struct st_hba *hba,
-	struct Scsi_Host * host, struct pci_dev *pdev)
-{
-	host->max_channel = ST_MAX_LUN_PER_TARGET; /* fw lun work around */
-    	host->max_id = ST_MAX_TARGET_NUM;
-    	host->max_lun = 1; /* fw lun work around */
-	host->unique_id = host->host_no;
-	host->max_cmd_len = STEX_CDB_LENGTH;
-
-	hba->host = host;
-	hba->pdev = pdev;
-	init_waitqueue_head(&hba->waitq);
-}
-
-static int stex_init_shm(struct st_hba *hba, struct pci_dev *pdev)
-{
-	hba->dma_mem = pci_alloc_consistent(pdev,
-		MU_BUFFER_SIZE, &hba->dma_handle);
-	if (!hba->dma_mem)
-		return -ENOMEM;
-
-	hba->status_buffer =
-		(struct status_msg *)(hba->dma_mem + MU_REQ_BUFFER_SIZE);
-	hba->mu_status = MU_STATE_STARTING;
-	return 0;
-}
-
 static void stex_internal_flush(struct st_hba *hba, int id, u16 tag)
 {
 	struct req_msg *req;
@@ -953,12 +923,12 @@
 	} else {
 		req->target = id/ST_MAX_LUN_PER_TARGET - ST_MAX_ARRAY_SUPPORTED;
 		req->lun = id%ST_MAX_LUN_PER_TARGET;
-   		req->cdb[0] = SYNCHRONIZE_CACHE;
+		req->cdb[0] = SYNCHRONIZE_CACHE;
 	}
 
 	hba->ccb[tag].cmd = NULL;
 	hba->ccb[tag].page_offset = 0;
- 	hba->ccb[tag].page = NULL;
+	hba->ccb[tag].page = NULL;
 	hba->ccb[tag].sense_bufflen = 0;
 	hba->ccb[tag].sense_buffer = NULL;
 	hba->ccb[tag].req_type |= PASSTHRU_REQ_TYPE;
@@ -1004,8 +974,8 @@
 {
 	int ret;
 	if (!pci_set_dma_mask(pdev, DMA_64BIT_MASK)
-	    && !pci_set_consistent_dma_mask(pdev, DMA_64BIT_MASK))
-	    return 0;
+		&& !pci_set_consistent_dma_mask(pdev, DMA_64BIT_MASK))
+		return 0;
 	ret = pci_set_dma_mask(pdev, DMA_32BIT_MASK);
 	if (!ret)
 		ret = pci_set_consistent_dma_mask(pdev, DMA_32BIT_MASK);
@@ -1060,19 +1030,36 @@
 		goto out_iounmap;
 	}
 
-	err = stex_init_shm(hba, pdev);
-	if (err) {
+	hba->dma_mem = pci_alloc_consistent(pdev,
+		MU_BUFFER_SIZE, &hba->dma_handle);
+	if (!hba->dma_mem) {
+		err = -ENOMEM;
 		printk(KERN_ERR DRV_NAME "(%s): dma mem alloc failed\n",
-		       pci_name(pdev));
+			pci_name(pdev));
 		goto out_iounmap;
 	}
 
-	stex_init_hba(hba, host, pdev);
+	hba->status_buffer =
+		(struct status_msg *)(hba->dma_mem + MU_REQ_BUFFER_SIZE);
+	hba->mu_status = MU_STATE_STARTING;
+
+	/* firmware uses id/lun pair for a logical drive, but lun would be
+	   always 0 if CONFIG_SCSI_MULTI_LUN not configured, so we use
+	   channel to map lun here */
+	host->max_channel = ST_MAX_LUN_PER_TARGET - 1;
+	host->max_id = ST_MAX_TARGET_NUM;
+	host->max_lun = 1;
+	host->unique_id = host->host_no;
+	host->max_cmd_len = STEX_CDB_LENGTH;
+
+	hba->host = host;
+	hba->pdev = pdev;
+	init_waitqueue_head(&hba->waitq);
 
 	err = request_irq(pdev->irq, stex_intr, SA_SHIRQ, DRV_NAME, hba);
 	if (err) {
 		printk(KERN_ERR DRV_NAME "(%s): request irq failed\n",
-		       pci_name(pdev));
+			pci_name(pdev));
 		goto out_pci_free;
 	}
 

