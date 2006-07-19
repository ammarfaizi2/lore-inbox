Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964867AbWGSPIG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964867AbWGSPIG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jul 2006 11:08:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964865AbWGSPIF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jul 2006 11:08:05 -0400
Received: from 67.111.72.3.ptr.us.xo.net ([67.111.72.3]:11323 "EHLO
	nonameb.ptu.promise.com") by vger.kernel.org with ESMTP
	id S964860AbWGSPID (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jul 2006 11:08:03 -0400
Date: Wed, 19 Jul 2006 23:07:20 +0800
From: "Ed Lin" <ed.lin@promise.com>
To: "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
Cc: "James.Bottomley" <James.Bottomley@SteelEye.com>, "jeff" <jeff@garzik.org>,
       "hch" <hch@infradead.org>,
       "linux-kernel" <linux-kernel@vger.kernel.org>, "akpm" <akpm@osdl.org>,
       "promise_linux" <promise_linux@promise.com>
Subject: Re: [PATCH] Promise 'stex' driver
X-mailer: Foxmail 5.0 [cn]
Mime-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: 7bit
Message-ID: <NONAMEBMcvsq9IcVux1000001f9@nonameb.ptu.promise.com>
X-OriginalArrivalTime: 19 Jul 2006 15:09:47.0718 (UTC) FILETIME=[5FEE3E60:01C6AB45]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Please review following patch based on the 'stex' branch of
git://git.kernel.org/pub/scm/linux/kernel/git/jgarzik/misc-2.6.git

Jeff Garzik already finished some changes, and these are the rest.

>From Christoph Hellwig's comments:
	use scsi_kmap_atomic_sg/scsi_kunmap_atomic_sg
    callback argument to ->queuecommand changed to 'done'
	merge init functions into .probe

>From Alexey Dobriyan's comments:
	__le32 *time

Promise code changes:
	add hard reset function
	extend reset wait time
	add new device ids
	white space/ minor fix(INQUIRY, max_channel)

Block layer tag: 
	It is not implemented because here tag is adapter wide,
	not for single device.
Non-sg codepath:
	It can be eliminated when Christoph Hellwig's patch
	upstream.
Firmware lun issue:
	Firmware uses an id/lun pair for a logical drive. But
	lun could be always 0 in Linux(when you do not config
	CONFIG_SCSI_MULTI_LUN).I use channel to map lun,
	otherwise max_id will be 256.
INQUIRY, passthru command:
	Needed by management software. The special handling of
	INQUIRY is for management software to have a sg device
	to issue commands.




diff --git a/drivers/scsi/Kconfig b/drivers/scsi/Kconfig
index 1652e0c..9806f71 100644
--- a/drivers/scsi/Kconfig
+++ b/drivers/scsi/Kconfig
@@ -1054,11 +1054,11 @@ config 53C700_LE_ON_BE
 	default y
 
 config SCSI_STEX
-	tristate "Promise SuperTrak EX8350/8300/16350/16300 support"
+	tristate "Promise SuperTrak EX Series support"
 	depends on PCI && SCSI
 	---help---
-	  This driver supports Promise SuperTrak EX8350/8300/16350/16300
-	  Storage controllers.
+	  This driver supports Promise SuperTrak EX Series Storage
+	  controllers.
 
 config SCSI_SYM53C8XX_2
 	tristate "SYM53C8XX Version 2 SCSI support"
diff --git a/drivers/scsi/stex.c b/drivers/scsi/stex.c
index 8c44d45..a72df00 100644
--- a/drivers/scsi/stex.c
+++ b/drivers/scsi/stex.c
@@ -1,5 +1,5 @@
 /*
- * SuperTrak EX8350/8300/16350/16300 Storage Controller driver for Linux
+ * SuperTrak EX Series Storage Controller driver for Linux
  *
  *	Copyright (C) 2005, 2006 Promise Technology Inc.
  *
@@ -75,7 +75,7 @@ enum {
 	MU_STATE_STARTED			= 4,
 	MU_STATE_RESETTING			= 5,
 
-	MU_MAX_DELAY_TIME			= 50000,
+	MU_MAX_DELAY_TIME			= 240000,
 	MU_HANDSHAKE_SIGNATURE			= 0x55aaaa55,
 	HMU_PARTNER_TYPE			= 2,
 
@@ -102,7 +102,7 @@ enum {
 	MU_REQ_COUNT				= (MU_MAX_REQUEST + 1),
 	MU_STATUS_COUNT				= (MU_MAX_REQUEST + 1),
 
-	STEX_CDB_LENGTH			= MAX_COMMAND_SIZE,
+	STEX_CDB_LENGTH				= MAX_COMMAND_SIZE,
 	REQ_VARIABLE_LEN			= 1024,
 	STATUS_VAR_LEN				= 128,
 	ST_CAN_QUEUE				= MU_MAX_REQUEST,
@@ -118,6 +118,9 @@ enum {
 	ST_MAX_TARGET_NUM			= (ST_MAX_ARRAY_SUPPORTED+1),
 	ST_MAX_LUN_PER_TARGET			= 16,
 
+	st_shasta				= 0,
+	st_vsc					= 1,
+
 	PASSTHRU_REQ_TYPE			= 0x00000001,
 	PASSTHRU_REQ_NO_WAKEUP			= 0x00000100,
 	ST_INTERNAL_TIMEOUT			= 30,
@@ -194,10 +197,6 @@ struct status_msg {
 	u8 variable[STATUS_VAR_LEN];
 };
 
-#define MU_REQ_BUFFER_SIZE	(MU_REQ_COUNT * sizeof(struct req_msg))
-#define MU_STATUS_BUFFER_SIZE	(MU_STATUS_COUNT * sizeof(struct status_msg))
-#define MU_BUFFER_SIZE		(MU_REQ_BUFFER_SIZE + MU_STATUS_BUFFER_SIZE)
-
 struct ver_info {
 	u32 major;
 	u32 minor;
@@ -240,14 +239,18 @@ struct st_drvver {
 	u32 reserved[3];
 };
 
+#define MU_REQ_BUFFER_SIZE	(MU_REQ_COUNT * sizeof(struct req_msg))
+#define MU_STATUS_BUFFER_SIZE	(MU_STATUS_COUNT * sizeof(struct status_msg))
+#define MU_BUFFER_SIZE		(MU_REQ_BUFFER_SIZE + MU_STATUS_BUFFER_SIZE)
+#define STEX_BUFFER_SIZE	(MU_BUFFER_SIZE + sizeof(struct st_frame))
+
 struct st_ccb {
 	struct req_msg *req;
 	struct scsi_cmnd *cmd;
 
 	void *sense_buffer;
-	struct page *page;
 	unsigned int sense_bufflen;
-	unsigned int page_offset;
+	int sg_count;
 
 	u32 req_type;
 	u8 srb_status;
@@ -261,6 +264,7 @@ struct st_hba {
 
 	struct Scsi_Host *host;
 	struct pci_dev *pdev;
+	struct pci_dev *bus0;
 
 	u32 tag;
 	u32 req_head;
@@ -269,12 +273,15 @@ struct st_hba {
 	u32 status_tail;
 
 	struct status_msg *status_buffer;
+	void *scratch;
 	struct st_ccb ccb[MU_MAX_REQUEST];
 	struct st_ccb *wait_ccb;
 	wait_queue_head_t waitq;
 
 	unsigned int mu_status;
 	int out_req_cnt;
+
+	unsigned int cardtype;
 };
 
 static const char console_inq_page[] =
@@ -294,7 +301,7 @@ MODULE_DESCRIPTION("Promise Technology S
 MODULE_LICENSE("GPL");
 MODULE_VERSION(ST_DRIVER_VERSION);
 
-static void stex_gettime(u32 *time)
+static void stex_gettime(__le32 *time)
 {
 	struct timeval tv;
 	do_gettimeofday(&tv);
@@ -340,14 +347,16 @@ static struct req_msg *stex_alloc_req(st
 }
 
 static int stex_map_sg(struct st_hba *hba,
-	struct req_msg *req, struct scsi_cmnd *cmd)
+	struct req_msg *req, struct st_ccb *ccb)
 {
 	struct pci_dev *pdev = hba->pdev;
+	struct scsi_cmnd *cmd;
 	dma_addr_t dma_handle;
 	struct scatterlist *src;
 	struct st_sgtable *dst;
 	int i;
 
+	cmd = ccb->cmd;
 	dst = (struct st_sgtable *)req->variable;
 	dst->max_sg_count = cpu_to_le16(ST_MAX_SG);
 	dst->sz_in_byte = cpu_to_le32(cmd->request_bufflen);
@@ -361,6 +370,7 @@ static int stex_map_sg(struct st_hba *hb
 		if (n_elem <= 0)
 			return -EIO;
 
+		ccb->sg_count = n_elem;
 		dst->sg_count = cpu_to_le16((u16)n_elem);
 
 		for (i = 0; i < n_elem; i++, src++) {
@@ -370,7 +380,7 @@ static int stex_map_sg(struct st_hba *hb
 			dst->table[i].addr_hi =
 				cpu_to_le32((sg_dma_address(src) >> 16) >> 16);
 			dst->table[i].ctrl = SG_CF_64B | SG_CF_HOST;
-    		}
+		}
 		dst->table[--i].ctrl |= SG_CF_EOT;
 		return 0;
 	}
@@ -379,6 +389,7 @@ static int stex_map_sg(struct st_hba *hb
 		cmd->request_bufflen, cmd->sc_data_direction);
 	cmd->SCp.dma_handle = dma_handle;
 
+	ccb->sg_count = 1;
 	dst->sg_count = cpu_to_le16(1);
 	dst->table[0].addr = cpu_to_le32(dma_handle & 0xffffffff);
 	dst->table[0].addr_hi = cpu_to_le32((dma_handle >> 16) >> 16);
@@ -388,38 +399,67 @@ static int stex_map_sg(struct st_hba *hb
 	return 0;
 }
 
-static int stex_direct_cp(struct scsi_cmnd *cmd,
-	const void *src, unsigned int len)
+static void stex_internal_copy(struct scsi_cmnd *cmd,
+	const void *src, size_t *count, int sg_count)
 {
-	void *dest;
-	unsigned int cp_len;
-	struct scatterlist *sg = cmd->request_buffer;
+	size_t lcount;
+	size_t len;
+	void *s, *d, *base = NULL;
+	if (*count > cmd->request_bufflen)
+		*count = cmd->request_bufflen;
+	lcount = *count;
+	while (lcount) {
+		len = lcount;
+		s = (void *)src;
+		if (cmd->use_sg) {
+			size_t offset = *count - lcount;
+			s += offset;
+			base = scsi_kmap_atomic_sg(cmd->request_buffer,
+				sg_count, &offset, &len);
+			if (base == NULL) {
+				*count -= lcount;
+				return;
+			}
+			d = base + offset;
+		} else
+			d = cmd->request_buffer;
+
+		memcpy(d, s, len);
+
+		lcount -= len;
+		if (cmd->use_sg)
+			scsi_kunmap_atomic_sg(base);
+	}
+}
+
+static int stex_direct_copy(struct scsi_cmnd *cmd,
+	const void *src, size_t count)
+{
+	struct st_hba *hba = (struct st_hba *) &cmd->device->host->hostdata[0];
+	size_t cp_len = count;
+	int n_elem = 0;
 
 	if (cmd->use_sg) {
-		dest = kmap_atomic(sg->page, KM_IRQ0) + sg->offset;
-		cp_len = min(sg->length, len);
-	} else {
-		dest = cmd->request_buffer;
-		cp_len = min(cmd->request_bufflen, len);
+		n_elem = pci_map_sg(hba->pdev, cmd->request_buffer,
+			cmd->use_sg, cmd->sc_data_direction);
+		if (n_elem <= 0)
+			return 0;
 	}
 
-	memcpy(dest, src, cp_len);
+	stex_internal_copy(cmd, src, &cp_len, n_elem);
 
 	if (cmd->use_sg)
-		kunmap_atomic(dest - sg->offset, KM_IRQ0);
-	return cp_len == len;
+		pci_unmap_sg(hba->pdev, cmd->request_buffer,
+			cmd->use_sg, cmd->sc_data_direction);
+	return cp_len == count;
 }
 
 static void stex_controller_info(struct st_hba *hba, struct st_ccb *ccb)
 {
 	struct st_frame *p;
-	struct scsi_cmnd *cmd = ccb->cmd;
-
-	if (cmd->use_sg)
-		p = kmap_atomic(ccb->page, KM_IRQ0) + ccb->page_offset;
-	else
-		p = cmd->request_buffer;
+	size_t count = sizeof(struct st_frame);
 
+	p = hba->scratch;
 	memset(p->base, 0, sizeof(u32)*6);
 	*(unsigned long *)(p->base) = pci_resource_start(hba->pdev, 0);
 	p->rom_addr = 0;
@@ -436,8 +476,8 @@ static void stex_controller_info(struct 
 	p->id = hba->pdev->vendor << 16 | hba->pdev->device;
 	p->subid =
 		hba->pdev->subsystem_vendor << 16 | hba->pdev->subsystem_device;
-	if (cmd->use_sg)
-		kunmap_atomic((void *)p - ccb->page_offset, KM_IRQ0);
+
+	stex_internal_copy(ccb->cmd, p, &count, ccb->sg_count);
 }
 
 static void
@@ -465,7 +505,7 @@ stex_slave_config(struct scsi_device *sd
 }
 
 static int
-stex_queuecommand(struct scsi_cmnd *cmd, void (* fn)(struct scsi_cmnd *))
+stex_queuecommand(struct scsi_cmnd *cmd, void (* done)(struct scsi_cmnd *))
 {
 	struct st_hba *hba;
 	struct Scsi_Host *host;
@@ -482,21 +522,21 @@ stex_queuecommand(struct scsi_cmnd *cmd,
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
+		if(lun == 0 && (cmd->cmnd[1] & INQUIRY_EVPD) == 0) {
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
@@ -508,17 +548,17 @@ stex_queuecommand(struct scsi_cmnd *cmd,
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
@@ -531,20 +571,14 @@ stex_queuecommand(struct scsi_cmnd *cmd,
 	/* cdb */
 	memcpy(req->cdb, cmd->cmnd, STEX_CDB_LENGTH);
 
-	if (cmd->sc_data_direction != DMA_NONE)
-		stex_map_sg(hba, req, cmd);
-
 	hba->ccb[tag].cmd = cmd;
 	hba->ccb[tag].sense_bufflen = SCSI_SENSE_BUFFERSIZE;
 	hba->ccb[tag].sense_buffer = cmd->sense_buffer;
-	if (cmd->use_sg) {
-		hba->ccb[tag].page_offset =
-			((struct scatterlist *)cmd->request_buffer)->offset;
-		hba->ccb[tag].page =
-			((struct scatterlist *)cmd->request_buffer)->page;
-	}
 	hba->ccb[tag].req_type = 0;
 
+	if (cmd->sc_data_direction != DMA_NONE)
+		stex_map_sg(hba, req, &hba->ccb[tag]);
+
 	stex_send_cmd(hba, req, tag);
 	return 0;
 }
@@ -552,7 +586,7 @@ stex_queuecommand(struct scsi_cmnd *cmd,
 static void stex_unmap_sg(struct st_hba *hba, struct scsi_cmnd *cmd)
 {
 	if (cmd->sc_data_direction != DMA_NONE) {
- 		if (cmd->use_sg)
+		if (cmd->use_sg)
 			pci_unmap_sg(hba->pdev, cmd->request_buffer,
 				cmd->use_sg, cmd->sc_data_direction);
 		else
@@ -597,32 +631,26 @@ static void stex_scsi_done(struct st_ccb
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
 	struct status_msg *resp, unsigned int variable)
 {
-	void *p;
-	if (resp->scsi_status == SAM_STAT_GOOD) {
-		if (ccb->cmd == NULL)
-			return;
-		if (ccb->cmd->use_sg)
-			p = kmap_atomic(ccb->page, KM_IRQ0) + ccb->page_offset;
-		else
-			p = ccb->cmd->request_buffer;
-		memcpy(p, resp->variable, min(variable,
-			ccb->cmd->request_bufflen));
-		if (ccb->cmd->use_sg)
-			kunmap_atomic(p - ccb->page_offset, KM_IRQ0);
-	} else {
+	size_t count = variable;
+	if (resp->scsi_status != SAM_STAT_GOOD) {
 		if (ccb->sense_buffer != NULL)
 			memcpy(ccb->sense_buffer, resp->variable,
 				min(variable, ccb->sense_bufflen));
+		return;
 	}
+
+	if (ccb->cmd == NULL)
+		return;
+	stex_internal_copy(ccb->cmd, resp->variable, &count, ccb->sg_count);
 }
 
 static void stex_mu_intr(struct st_hba *hba, u32 doorbell)
@@ -672,7 +700,7 @@ static void stex_mu_intr(struct st_hba *
 			printk(KERN_WARNING DRV_NAME
 				"(%s): lagging req\n", pci_name(hba->pdev));
 			stex_free_tag((unsigned long *)&hba->tag, tag);
-  			stex_unmap_sg(hba, ccb->cmd); /* ??? */
+			stex_unmap_sg(hba, ccb->cmd); /* ??? */
 			continue;
 		}
 
@@ -704,7 +732,7 @@ static void stex_mu_intr(struct st_hba *
 			ccb->cmd->cmnd[1] == PASSTHRU_GET_ADAPTER)
 			stex_controller_info(hba, ccb);
 		stex_free_tag((unsigned long *)&hba->tag, tag);
-  		stex_unmap_sg(hba, ccb->cmd);
+		stex_unmap_sg(hba, ccb->cmd);
 		stex_scsi_done(ccb);
 	}
 
@@ -840,8 +868,8 @@ static int stex_abort(struct scsi_cmnd *
 
 	stex_mu_intr(hba, data);
 
- 	if (hba->wait_ccb == NULL) {
- 		printk(KERN_WARNING DRV_NAME
+	if (hba->wait_ccb == NULL) {
+		printk(KERN_WARNING DRV_NAME
 			"(%s): lost interrupt\n", pci_name(hba->pdev));
 		goto out;
 	}
@@ -855,6 +883,41 @@ out:
 	return result;
 }
 
+static void stex_hard_reset(struct st_hba *hba)
+{
+	int i;
+	u16 pci_cmd;
+	u8 control;
+	for (i = 0; i < 16; i++)
+		pci_read_config_dword(hba->pdev, i * 4,
+			&hba->pdev->saved_config_space[i]);
+
+	if (!hba->bus0) {
+		pci_write_config_dword(hba->pdev, 4,
+			hba->pdev->saved_config_space[1] & 0xfffffff9);
+		pci_write_config_byte(hba->pdev, 0x84, 1 << 5);
+	} else {
+		pci_read_config_byte(hba->bus0, 0x3e, &control);
+		control |= (1<<6);
+		pci_write_config_byte(hba->bus0, 0x3e, control);
+		msleep(1);
+		control &= ~(1<<6);
+		pci_write_config_byte(hba->bus0, 0x3e, control);
+	}
+
+	for (i = 0; i < MU_MAX_DELAY_TIME; i++) {
+		pci_read_config_word(hba->pdev, PCI_COMMAND, &pci_cmd);
+		if (pci_cmd & PCI_COMMAND_MASTER)
+			break;
+		msleep(1);
+	}
+
+	msleep(5000);
+	for (i = 0; i < 16; i++)
+		pci_write_config_dword(hba->pdev, i * 4,
+			hba->pdev->saved_config_space[i]);
+}
+
 static int stex_reset(struct scsi_cmnd *cmd)
 {
 	struct st_hba *hba;
@@ -876,9 +939,6 @@ wait_cmds:
 	}
 
 	hba->mu_status = MU_STATE_RESETTING;
-	writel(MU_INBOUND_DOORBELL_HANDSHAKE, hba->mmio_base + IDBL);
-	readl(hba->mmio_base + IDBL);
-	msleep(3000);
 
 	spin_lock_irqsave(hba->host->host_lock, flags);
 
@@ -892,6 +952,9 @@ wait_cmds:
 
 	spin_unlock_irqrestore(hba->host->host_lock, flags);
 
+	if (hba->cardtype == st_shasta)
+		stex_hard_reset(hba);
+
 	if (stex_handshake(hba)) {
 		printk(KERN_WARNING DRV_NAME
 			"(%s): resetting: handshake failed\n",
@@ -910,33 +973,6 @@ wait_cmds:
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
@@ -953,12 +989,11 @@ static void stex_internal_flush(struct s
 	} else {
 		req->target = id/ST_MAX_LUN_PER_TARGET - ST_MAX_ARRAY_SUPPORTED;
 		req->lun = id%ST_MAX_LUN_PER_TARGET;
-   		req->cdb[0] = SYNCHRONIZE_CACHE;
+		req->cdb[0] = SYNCHRONIZE_CACHE;
 	}
 
 	hba->ccb[tag].cmd = NULL;
-	hba->ccb[tag].page_offset = 0;
- 	hba->ccb[tag].page = NULL;
+	hba->ccb[tag].sg_count = 0;
 	hba->ccb[tag].sense_bufflen = 0;
 	hba->ccb[tag].sense_buffer = NULL;
 	hba->ccb[tag].req_type |= PASSTHRU_REQ_TYPE;
@@ -1004,8 +1039,8 @@ static int stex_set_dma_mask(struct pci_
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
@@ -1060,19 +1095,48 @@ stex_probe(struct pci_dev *pdev, const s
 		goto out_iounmap;
 	}
 
-	err = stex_init_shm(hba, pdev);
-	if (err) {
+	hba->dma_mem = pci_alloc_consistent(pdev,
+		STEX_BUFFER_SIZE, &hba->dma_handle);
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
+	hba->scratch = hba->dma_mem + MU_BUFFER_SIZE;
+	hba->mu_status = MU_STATE_STARTING;
+
+	hba->cardtype = (unsigned int) id->driver_data;
+	if (hba->cardtype == st_shasta) {
+		struct pci_dev *bus0 = NULL;
+		u8 atu_bus;
+		while ((bus0 = pci_get_device(0x8086, 0x0370, bus0)) != NULL) {
+			pci_read_config_byte(bus0, 0x19, &atu_bus);
+			pci_dev_put(bus0);
+			if (atu_bus == pdev->bus->number) {
+				hba->bus0 = bus0;
+				break;
+			}
+		}
+	}
+
+	host->max_channel = ST_MAX_LUN_PER_TARGET - 1; /* fw lun work around */
+	host->max_id = ST_MAX_TARGET_NUM;
+	host->max_lun = 1; /* fw lun work around */
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
 
@@ -1096,7 +1160,7 @@ stex_probe(struct pci_dev *pdev, const s
 out_free_irq:
 	free_irq(pdev->irq, hba);
 out_pci_free:
-	pci_free_consistent(pdev, MU_BUFFER_SIZE,
+	pci_free_consistent(pdev, STEX_BUFFER_SIZE,
 		hba->dma_mem, hba->dma_handle);
 out_iounmap:
 	iounmap(hba->mmio_base);
@@ -1147,7 +1211,7 @@ static void stex_hba_free(struct st_hba 
 
 	pci_release_regions(hba->pdev);
 
-	pci_free_consistent(hba->pdev, MU_BUFFER_SIZE,
+	pci_free_consistent(hba->pdev, STEX_BUFFER_SIZE,
 			hba->dma_mem, hba->dma_handle);
 }
 
@@ -1176,12 +1240,14 @@ static void stex_shutdown(struct pci_dev
 }
 
 static struct pci_device_id stex_pci_tbl[] = {
-	{ PCI_VENDOR_ID_PROMISE, 0x8350, PCI_ANY_ID, PCI_ANY_ID, },
-	{ PCI_VENDOR_ID_PROMISE, 0xf350, PCI_ANY_ID, PCI_ANY_ID, },
-	{ PCI_VENDOR_ID_PROMISE, 0x4301, PCI_ANY_ID, PCI_ANY_ID, },
-	{ PCI_VENDOR_ID_PROMISE, 0x4302, PCI_ANY_ID, PCI_ANY_ID, },
-	{ PCI_VENDOR_ID_PROMISE, 0x8301, PCI_ANY_ID, PCI_ANY_ID, },
-	{ PCI_VENDOR_ID_PROMISE, 0x8302, PCI_ANY_ID, PCI_ANY_ID, },
+	{ 0x105a, 0x8350, PCI_ANY_ID, PCI_ANY_ID, 0, 0, st_shasta },
+	{ 0x105a, 0xc350, PCI_ANY_ID, PCI_ANY_ID, 0, 0, st_shasta },
+	{ 0x105a, 0xf350, PCI_ANY_ID, PCI_ANY_ID, 0, 0, st_shasta },
+	{ 0x105a, 0x4301, PCI_ANY_ID, PCI_ANY_ID, 0, 0, st_shasta },
+	{ 0x105a, 0x4302, PCI_ANY_ID, PCI_ANY_ID, 0, 0, st_shasta },
+	{ 0x105a, 0x8301, PCI_ANY_ID, PCI_ANY_ID, 0, 0, st_shasta },
+	{ 0x105a, 0x8302, PCI_ANY_ID, PCI_ANY_ID, 0, 0, st_shasta },
+	{ 0x1725, 0x7250, PCI_ANY_ID, PCI_ANY_ID, 0, 0, st_vsc },
 	{ }	/* terminate list */
 };
 MODULE_DEVICE_TABLE(pci, stex_pci_tbl);

