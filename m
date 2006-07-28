Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161195AbWG1RdY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161195AbWG1RdY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 13:33:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161197AbWG1RdY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 13:33:24 -0400
Received: from 67.111.72.3.ptr.us.xo.net ([67.111.72.3]:20462 "EHLO
	nonameb.ptu.promise.com") by vger.kernel.org with ESMTP
	id S1161195AbWG1RdW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 13:33:22 -0400
Date: Sat, 29 Jul 2006 01:33:08 +0800
From: "Ed Lin" <ed.lin@promise.com>
To: "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
Cc: "James.Bottomley" <James.Bottomley@SteelEye.com>, "jeff" <jeff@garzik.org>,
       "linux-kernel" <linux-kernel@vger.kernel.org>, "akpm" <akpm@osdl.org>,
       "promise_linux" <promise_linux@promise.com>
Subject: [PATCH 3/4] stex: update internal copy code path
X-mailer: Foxmail 5.0 [cn]
Mime-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: 7bit
Message-ID: <NONAMEBwBGpEI2rV4Zn000002b7@nonameb.ptu.promise.com>
X-OriginalArrivalTime: 28 Jul 2006 17:35:19.0546 (UTC) FILETIME=[323935A0:01C6B26C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


use scsi_kmap_atomic_sg/scsi_kunmap_atomic_sg for internal copy code path

Signed-off-by: Ed Lin <ed.lin@promise.com>
---
 stex.c |  130 ++++++++++++++++++++++++++++++++++++++---------------------------
 1 files changed, 76 insertions(+), 54 deletions(-)
diff -urN a/drivers/scsi/stex.c b/drivers/scsi/stex.c
--- a/drivers/scsi/stex.c	2006-07-28 05:54:37.000000000 -0400
+++ b/drivers/scsi/stex.c	2006-07-28 05:57:03.000000000 -0400
@@ -197,10 +197,6 @@
 	u8 variable[STATUS_VAR_LEN];
 };
 
-#define MU_REQ_BUFFER_SIZE	(MU_REQ_COUNT * sizeof(struct req_msg))
-#define MU_STATUS_BUFFER_SIZE	(MU_STATUS_COUNT * sizeof(struct status_msg))
-#define MU_BUFFER_SIZE		(MU_REQ_BUFFER_SIZE + MU_STATUS_BUFFER_SIZE)
-
 struct ver_info {
 	u32 major;
 	u32 minor;
@@ -243,14 +239,18 @@
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
@@ -272,6 +272,7 @@
 	u32 status_tail;
 
 	struct status_msg *status_buffer;
+	void *copy_buffer; /* temp buffer for driver-handled commands */
 	struct st_ccb ccb[MU_MAX_REQUEST];
 	struct st_ccb *wait_ccb;
 	wait_queue_head_t waitq;
@@ -345,14 +346,16 @@
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
@@ -366,6 +369,7 @@
 		if (n_elem <= 0)
 			return -EIO;
 
+		ccb->sg_count = n_elem;
 		dst->sg_count = cpu_to_le16((u16)n_elem);
 
 		for (i = 0; i < n_elem; i++, src++) {
@@ -384,6 +388,7 @@
 		cmd->request_bufflen, cmd->sc_data_direction);
 	cmd->SCp.dma_handle = dma_handle;
 
+	ccb->sg_count = 1;
 	dst->sg_count = cpu_to_le16(1);
 	dst->table[0].addr = cpu_to_le32(dma_handle & 0xffffffff);
 	dst->table[0].addr_hi = cpu_to_le32((dma_handle >> 16) >> 16);
@@ -393,38 +398,67 @@
 	return 0;
 }
 
+static void stex_internal_copy(struct scsi_cmnd *cmd,
+	const void *src, size_t *count, int sg_count)
+{
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
 static int stex_direct_copy(struct scsi_cmnd *cmd,
-	const void *src, unsigned int len)
+	const void *src, size_t count)
 {
-	void *dest;
-	unsigned int cp_len;
-	struct scatterlist *sg = cmd->request_buffer;
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
 
+	p = hba->copy_buffer;
 	memset(p->base, 0, sizeof(u32)*6);
 	*(unsigned long *)(p->base) = pci_resource_start(hba->pdev, 0);
 	p->rom_addr = 0;
@@ -441,8 +475,8 @@
 	p->id = hba->pdev->vendor << 16 | hba->pdev->device;
 	p->subid =
 		hba->pdev->subsystem_vendor << 16 | hba->pdev->subsystem_device;
-	if (cmd->use_sg)
-		kunmap_atomic((void *)p - ccb->page_offset, KM_IRQ0);
+
+	stex_internal_copy(ccb->cmd, p, &count, ccb->sg_count);
 }
 
 static void
@@ -536,20 +570,14 @@
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
@@ -611,23 +639,17 @@
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
@@ -932,8 +954,7 @@
 	}
 
 	hba->ccb[tag].cmd = NULL;
-	hba->ccb[tag].page_offset = 0;
-	hba->ccb[tag].page = NULL;
+	hba->ccb[tag].sg_count = 0;
 	hba->ccb[tag].sense_bufflen = 0;
 	hba->ccb[tag].sense_buffer = NULL;
 	hba->ccb[tag].req_type |= PASSTHRU_REQ_TYPE;
@@ -1036,7 +1057,7 @@
 	}
 
 	hba->dma_mem = pci_alloc_consistent(pdev,
-		MU_BUFFER_SIZE, &hba->dma_handle);
+		STEX_BUFFER_SIZE, &hba->dma_handle);
 	if (!hba->dma_mem) {
 		err = -ENOMEM;
 		printk(KERN_ERR DRV_NAME "(%s): dma mem alloc failed\n",
@@ -1046,6 +1067,7 @@
 
 	hba->status_buffer =
 		(struct status_msg *)(hba->dma_mem + MU_REQ_BUFFER_SIZE);
+	hba->copy_buffer = hba->dma_mem + MU_BUFFER_SIZE;
 	hba->mu_status = MU_STATE_STARTING;
 
 	hba->cardtype = (unsigned int) id->driver_data;
@@ -1090,7 +1112,7 @@
 out_free_irq:
 	free_irq(pdev->irq, hba);
 out_pci_free:
-	pci_free_consistent(pdev, MU_BUFFER_SIZE,
+	pci_free_consistent(pdev, STEX_BUFFER_SIZE,
 		hba->dma_mem, hba->dma_handle);
 out_iounmap:
 	iounmap(hba->mmio_base);
@@ -1141,7 +1163,7 @@
 
 	pci_release_regions(hba->pdev);
 
-	pci_free_consistent(hba->pdev, MU_BUFFER_SIZE,
+	pci_free_consistent(hba->pdev, STEX_BUFFER_SIZE,
 			hba->dma_mem, hba->dma_handle);
 }
 

