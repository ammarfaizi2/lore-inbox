Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263138AbVFXEWd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263138AbVFXEWd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Jun 2005 00:22:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263131AbVFXEVa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Jun 2005 00:21:30 -0400
Received: from webmail.topspin.com ([12.162.17.3]:33605 "EHLO
	exch-1.topspincom.com") by vger.kernel.org with ESMTP
	id S263102AbVFXEE1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Jun 2005 00:04:27 -0400
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: [PATCH 13/14] IB/mthca: Align FW command mailboxes to 4K
In-Reply-To: <2005623214.Wl3n9twXcA60cNkd@topspin.com>
X-Mailer: Roland's Patchbomber
Date: Thu, 23 Jun 2005 21:04:21 -0700
Message-Id: <2005623214.1yVGvzp1yi0UQ3bC@topspin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: akpm@osdl.org
Content-Transfer-Encoding: 7BIT
From: Roland Dreier <roland@topspin.com>
X-OriginalArrivalTime: 24 Jun 2005 04:04:21.0292 (UTC) FILETIME=[CCD29EC0:01C57871]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Future versions of Mellanox HCA firmware will require command
mailboxes to be aligned to 4K.  Support this by using a pci_pool to
allocate all mailboxes.  This has the added benefit of shrinking the
source and text of mthca.

Signed-off-by: Roland Dreier <roland@topspin.com>

---

 linux.git/drivers/infiniband/hw/mthca/mthca_cmd.c |  512 ++++++++++++--------------------
 linux.git/drivers/infiniband/hw/mthca/mthca_cmd.h |   46 +-
 linux.git/drivers/infiniband/hw/mthca/mthca_cq.c  |   34 +-
 linux.git/drivers/infiniband/hw/mthca/mthca_dev.h |    1 
 linux.git/drivers/infiniband/hw/mthca/mthca_eq.c  |   37 +-
 linux.git/drivers/infiniband/hw/mthca/mthca_mcg.c |   63 ++-
 linux.git/drivers/infiniband/hw/mthca/mthca_mr.c  |   46 +-
 linux.git/drivers/infiniband/hw/mthca/mthca_qp.c  |   14 
 8 files changed, 330 insertions(+), 423 deletions(-)



--- linux.git.orig/drivers/infiniband/hw/mthca/mthca_cmd.c	2005-06-23 13:03:08.794213733 -0700
+++ linux.git/drivers/infiniband/hw/mthca/mthca_cmd.c	2005-06-23 13:03:09.282108141 -0700
@@ -444,11 +444,20 @@ int mthca_cmd_init(struct mthca_dev *dev
 		return -ENOMEM;
 	}
 
+	dev->cmd.pool = pci_pool_create("mthca_cmd", dev->pdev,
+					MTHCA_MAILBOX_SIZE,
+					MTHCA_MAILBOX_SIZE, 0);
+	if (!dev->cmd.pool) {
+		iounmap(dev->hcr);
+		return -ENOMEM;
+	}
+
 	return 0;
 }
 
 void mthca_cmd_cleanup(struct mthca_dev *dev)
 {
+	pci_pool_destroy(dev->cmd.pool);
 	iounmap(dev->hcr);
 }
 
@@ -510,6 +519,33 @@ void mthca_cmd_use_polling(struct mthca_
 	up(&dev->cmd.poll_sem);
 }
 
+struct mthca_mailbox *mthca_alloc_mailbox(struct mthca_dev *dev,
+					  unsigned int gfp_mask)
+{
+	struct mthca_mailbox *mailbox;
+
+	mailbox = kmalloc(sizeof *mailbox, gfp_mask);
+	if (!mailbox)
+		return ERR_PTR(-ENOMEM);
+
+	mailbox->buf = pci_pool_alloc(dev->cmd.pool, gfp_mask, &mailbox->dma);
+	if (!mailbox->buf) {
+		kfree(mailbox);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	return mailbox;
+}
+
+void mthca_free_mailbox(struct mthca_dev *dev, struct mthca_mailbox *mailbox)
+{
+	if (!mailbox)
+		return;
+
+	pci_pool_free(dev->cmd.pool, mailbox->buf, mailbox->dma);
+	kfree(mailbox);
+}
+
 int mthca_SYS_EN(struct mthca_dev *dev, u8 *status)
 {
 	u64 out;
@@ -534,20 +570,20 @@ int mthca_SYS_DIS(struct mthca_dev *dev,
 static int mthca_map_cmd(struct mthca_dev *dev, u16 op, struct mthca_icm *icm,
 			 u64 virt, u8 *status)
 {
-	u32 *inbox;
-	dma_addr_t indma;
+	struct mthca_mailbox *mailbox;
 	struct mthca_icm_iter iter;
+	__be64 *pages;
 	int lg;
 	int nent = 0;
 	int i;
 	int err = 0;
 	int ts = 0, tc = 0;
 
-	inbox = pci_alloc_consistent(dev->pdev, PAGE_SIZE, &indma);
-	if (!inbox)
-		return -ENOMEM;
-
-	memset(inbox, 0, PAGE_SIZE);
+	mailbox = mthca_alloc_mailbox(dev, GFP_KERNEL);
+	if (IS_ERR(mailbox))
+		return PTR_ERR(mailbox);
+	memset(mailbox->buf, 0, MTHCA_MAILBOX_SIZE);
+	pages = mailbox->buf;
 
 	for (mthca_icm_first(icm, &iter);
 	     !mthca_icm_last(&iter);
@@ -567,19 +603,17 @@ static int mthca_map_cmd(struct mthca_de
 		}
 		for (i = 0; i < mthca_icm_size(&iter) / (1 << lg); ++i, ++nent) {
 			if (virt != -1) {
-				*((__be64 *) (inbox + nent * 4)) =
-					cpu_to_be64(virt);
+				pages[nent * 2] = cpu_to_be64(virt);
 				virt += 1 << lg;
 			}
-
-			*((__be64 *) (inbox + nent * 4 + 2)) =
-				cpu_to_be64((mthca_icm_addr(&iter) +
-					     (i << lg)) | (lg - 12));
+			
+			pages[nent * 2 + 1] = cpu_to_be64((mthca_icm_addr(&iter) +
+							   (i << lg)) | (lg - 12));
 			ts += 1 << (lg - 10);
 			++tc;
 
-			if (nent == PAGE_SIZE / 16) {
-				err = mthca_cmd(dev, indma, nent, 0, op,
+			if (nent == MTHCA_MAILBOX_SIZE / 16) {
+				err = mthca_cmd(dev, mailbox->dma, nent, 0, op,
 						CMD_TIME_CLASS_B, status);
 				if (err || *status)
 					goto out;
@@ -589,7 +623,7 @@ static int mthca_map_cmd(struct mthca_de
 	}
 
 	if (nent)
-		err = mthca_cmd(dev, indma, nent, 0, op,
+		err = mthca_cmd(dev, mailbox->dma, nent, 0, op,
 				CMD_TIME_CLASS_B, status);
 
 	switch (op) {
@@ -606,7 +640,7 @@ static int mthca_map_cmd(struct mthca_de
 	}
 
 out:
-	pci_free_consistent(dev->pdev, PAGE_SIZE, inbox, indma);
+	mthca_free_mailbox(dev, mailbox);
 	return err;
 }
 
@@ -627,8 +661,8 @@ int mthca_RUN_FW(struct mthca_dev *dev, 
 
 int mthca_QUERY_FW(struct mthca_dev *dev, u8 *status)
 {
+	struct mthca_mailbox *mailbox;
 	u32 *outbox;
-	dma_addr_t outdma;
 	int err = 0;
 	u8 lg;
 
@@ -646,12 +680,12 @@ int mthca_QUERY_FW(struct mthca_dev *dev
 #define QUERY_FW_EQ_ARM_BASE_OFFSET    0x40
 #define QUERY_FW_EQ_SET_CI_BASE_OFFSET 0x48
 
-	outbox = pci_alloc_consistent(dev->pdev, QUERY_FW_OUT_SIZE, &outdma);
-	if (!outbox) {
-		return -ENOMEM;
-	}
+	mailbox = mthca_alloc_mailbox(dev, GFP_KERNEL);
+	if (IS_ERR(mailbox))
+		return PTR_ERR(mailbox);
+	outbox = mailbox->buf;
 
-	err = mthca_cmd_box(dev, 0, outdma, 0, 0, CMD_QUERY_FW,
+	err = mthca_cmd_box(dev, 0, mailbox->dma, 0, 0, CMD_QUERY_FW,
 			    CMD_TIME_CLASS_A, status);
 
 	if (err)
@@ -702,15 +736,15 @@ int mthca_QUERY_FW(struct mthca_dev *dev
 	}
 
 out:
-	pci_free_consistent(dev->pdev, QUERY_FW_OUT_SIZE, outbox, outdma);
+	mthca_free_mailbox(dev, mailbox);
 	return err;
 }
 
 int mthca_ENABLE_LAM(struct mthca_dev *dev, u8 *status)
 {
+	struct mthca_mailbox *mailbox;
 	u8 info;
 	u32 *outbox;
-	dma_addr_t outdma;
 	int err = 0;
 
 #define ENABLE_LAM_OUT_SIZE         0x100
@@ -721,11 +755,12 @@ int mthca_ENABLE_LAM(struct mthca_dev *d
 #define ENABLE_LAM_INFO_HIDDEN_FLAG (1 << 4)
 #define ENABLE_LAM_INFO_ECC_MASK    0x3
 
-	outbox = pci_alloc_consistent(dev->pdev, ENABLE_LAM_OUT_SIZE, &outdma);
-	if (!outbox)
-		return -ENOMEM;
+	mailbox = mthca_alloc_mailbox(dev, GFP_KERNEL);
+	if (IS_ERR(mailbox))
+		return PTR_ERR(mailbox);
+	outbox = mailbox->buf;
 
-	err = mthca_cmd_box(dev, 0, outdma, 0, 0, CMD_ENABLE_LAM,
+	err = mthca_cmd_box(dev, 0, mailbox->dma, 0, 0, CMD_ENABLE_LAM,
 			    CMD_TIME_CLASS_C, status);
 
 	if (err)
@@ -754,7 +789,7 @@ int mthca_ENABLE_LAM(struct mthca_dev *d
 		  (unsigned long long) dev->ddr_end);
 
 out:
-	pci_free_consistent(dev->pdev, ENABLE_LAM_OUT_SIZE, outbox, outdma);
+	mthca_free_mailbox(dev, mailbox);
 	return err;
 }
 
@@ -765,9 +800,9 @@ int mthca_DISABLE_LAM(struct mthca_dev *
 
 int mthca_QUERY_DDR(struct mthca_dev *dev, u8 *status)
 {
+	struct mthca_mailbox *mailbox;
 	u8 info;
 	u32 *outbox;
-	dma_addr_t outdma;
 	int err = 0;
 
 #define QUERY_DDR_OUT_SIZE         0x100
@@ -778,11 +813,12 @@ int mthca_QUERY_DDR(struct mthca_dev *de
 #define QUERY_DDR_INFO_HIDDEN_FLAG (1 << 4)
 #define QUERY_DDR_INFO_ECC_MASK    0x3
 
-	outbox = pci_alloc_consistent(dev->pdev, QUERY_DDR_OUT_SIZE, &outdma);
-	if (!outbox)
-		return -ENOMEM;
+	mailbox = mthca_alloc_mailbox(dev, GFP_KERNEL);
+	if (IS_ERR(mailbox))
+		return PTR_ERR(mailbox);
+	outbox = mailbox->buf;
 
-	err = mthca_cmd_box(dev, 0, outdma, 0, 0, CMD_QUERY_DDR,
+	err = mthca_cmd_box(dev, 0, mailbox->dma, 0, 0, CMD_QUERY_DDR,
 			    CMD_TIME_CLASS_A, status);
 
 	if (err)
@@ -808,15 +844,15 @@ int mthca_QUERY_DDR(struct mthca_dev *de
 		  (unsigned long long) dev->ddr_end);
 
 out:
-	pci_free_consistent(dev->pdev, QUERY_DDR_OUT_SIZE, outbox, outdma);
+	mthca_free_mailbox(dev, mailbox);
 	return err;
 }
 
 int mthca_QUERY_DEV_LIM(struct mthca_dev *dev,
 			struct mthca_dev_lim *dev_lim, u8 *status)
 {
+	struct mthca_mailbox *mailbox;
 	u32 *outbox;
-	dma_addr_t outdma;
 	u8 field;
 	u16 size;
 	int err;
@@ -881,11 +917,12 @@ int mthca_QUERY_DEV_LIM(struct mthca_dev
 #define QUERY_DEV_LIM_LAMR_OFFSET           0x9f
 #define QUERY_DEV_LIM_MAX_ICM_SZ_OFFSET     0xa0
 
-	outbox = pci_alloc_consistent(dev->pdev, QUERY_DEV_LIM_OUT_SIZE, &outdma);
-	if (!outbox)
-		return -ENOMEM;
+	mailbox = mthca_alloc_mailbox(dev, GFP_KERNEL);
+	if (IS_ERR(mailbox))
+		return PTR_ERR(mailbox);
+	outbox = mailbox->buf;
 
-	err = mthca_cmd_box(dev, 0, outdma, 0, 0, CMD_QUERY_DEV_LIM,
+	err = mthca_cmd_box(dev, 0, mailbox->dma, 0, 0, CMD_QUERY_DEV_LIM,
 			    CMD_TIME_CLASS_A, status);
 
 	if (err)
@@ -1041,15 +1078,15 @@ int mthca_QUERY_DEV_LIM(struct mthca_dev
 	}
 
 out:
-	pci_free_consistent(dev->pdev, QUERY_DEV_LIM_OUT_SIZE, outbox, outdma);
+	mthca_free_mailbox(dev, mailbox);
 	return err;
 }
 
 int mthca_QUERY_ADAPTER(struct mthca_dev *dev,
 			struct mthca_adapter *adapter, u8 *status)
 {
+	struct mthca_mailbox *mailbox;
 	u32 *outbox;
-	dma_addr_t outdma;
 	int err;
 
 #define QUERY_ADAPTER_OUT_SIZE             0x100
@@ -1058,23 +1095,24 @@ int mthca_QUERY_ADAPTER(struct mthca_dev
 #define QUERY_ADAPTER_REVISION_ID_OFFSET   0x08
 #define QUERY_ADAPTER_INTA_PIN_OFFSET      0x10
 
-	outbox = pci_alloc_consistent(dev->pdev, QUERY_ADAPTER_OUT_SIZE, &outdma);
-	if (!outbox)
-		return -ENOMEM;
+	mailbox = mthca_alloc_mailbox(dev, GFP_KERNEL);
+	if (IS_ERR(mailbox))
+		return PTR_ERR(mailbox);
+	outbox = mailbox->buf;
 
-	err = mthca_cmd_box(dev, 0, outdma, 0, 0, CMD_QUERY_ADAPTER,
+	err = mthca_cmd_box(dev, 0, mailbox->dma, 0, 0, CMD_QUERY_ADAPTER,
 			    CMD_TIME_CLASS_A, status);
 
 	if (err)
 		goto out;
 
-	MTHCA_GET(adapter->vendor_id, outbox, QUERY_ADAPTER_VENDOR_ID_OFFSET);
-	MTHCA_GET(adapter->device_id, outbox, QUERY_ADAPTER_DEVICE_ID_OFFSET);
+	MTHCA_GET(adapter->vendor_id, outbox,   QUERY_ADAPTER_VENDOR_ID_OFFSET);
+	MTHCA_GET(adapter->device_id, outbox,   QUERY_ADAPTER_DEVICE_ID_OFFSET);
 	MTHCA_GET(adapter->revision_id, outbox, QUERY_ADAPTER_REVISION_ID_OFFSET);
-	MTHCA_GET(adapter->inta_pin, outbox, QUERY_ADAPTER_INTA_PIN_OFFSET);
+	MTHCA_GET(adapter->inta_pin, outbox,    QUERY_ADAPTER_INTA_PIN_OFFSET);
 
 out:
-	pci_free_consistent(dev->pdev, QUERY_DEV_LIM_OUT_SIZE, outbox, outdma);
+	mthca_free_mailbox(dev, mailbox);
 	return err;
 }
 
@@ -1082,8 +1120,8 @@ int mthca_INIT_HCA(struct mthca_dev *dev
 		   struct mthca_init_hca_param *param,
 		   u8 *status)
 {
+	struct mthca_mailbox *mailbox;
 	u32 *inbox;
-	dma_addr_t indma;
 	int err;
 
 #define INIT_HCA_IN_SIZE             	 0x200
@@ -1123,9 +1161,10 @@ int mthca_INIT_HCA(struct mthca_dev *dev
 #define  INIT_HCA_UAR_SCATCH_BASE_OFFSET (INIT_HCA_UAR_OFFSET + 0x10)
 #define  INIT_HCA_UAR_CTX_BASE_OFFSET    (INIT_HCA_UAR_OFFSET + 0x18)
 
-	inbox = pci_alloc_consistent(dev->pdev, INIT_HCA_IN_SIZE, &indma);
-	if (!inbox)
-		return -ENOMEM;
+	mailbox = mthca_alloc_mailbox(dev, GFP_KERNEL);
+	if (IS_ERR(mailbox))
+		return PTR_ERR(mailbox);
+	inbox = mailbox->buf;
 
 	memset(inbox, 0, INIT_HCA_IN_SIZE);
 
@@ -1188,10 +1227,9 @@ int mthca_INIT_HCA(struct mthca_dev *dev
 		MTHCA_PUT(inbox, param->uarc_base,   INIT_HCA_UAR_CTX_BASE_OFFSET);
 	}
 
-	err = mthca_cmd(dev, indma, 0, 0, CMD_INIT_HCA,
-			HZ, status);
+	err = mthca_cmd(dev, mailbox->dma, 0, 0, CMD_INIT_HCA, HZ, status);
 
-	pci_free_consistent(dev->pdev, INIT_HCA_IN_SIZE, inbox, indma);
+	mthca_free_mailbox(dev, mailbox);
 	return err;
 }
 
@@ -1199,8 +1237,8 @@ int mthca_INIT_IB(struct mthca_dev *dev,
 		  struct mthca_init_ib_param *param,
 		  int port, u8 *status)
 {
+	struct mthca_mailbox *mailbox;
 	u32 *inbox;
-	dma_addr_t indma;
 	int err;
 	u32 flags;
 
@@ -1220,9 +1258,10 @@ int mthca_INIT_IB(struct mthca_dev *dev,
 #define INIT_IB_NODE_GUID_OFFSET 0x18
 #define INIT_IB_SI_GUID_OFFSET   0x20
 
-	inbox = pci_alloc_consistent(dev->pdev, INIT_IB_IN_SIZE, &indma);
-	if (!inbox)
-		return -ENOMEM;
+	mailbox = mthca_alloc_mailbox(dev, GFP_KERNEL);
+	if (IS_ERR(mailbox))
+		return PTR_ERR(mailbox);
+	inbox = mailbox->buf;
 
 	memset(inbox, 0, INIT_IB_IN_SIZE);
 
@@ -1242,10 +1281,10 @@ int mthca_INIT_IB(struct mthca_dev *dev,
 	MTHCA_PUT(inbox, param->node_guid, INIT_IB_NODE_GUID_OFFSET);
 	MTHCA_PUT(inbox, param->si_guid,   INIT_IB_SI_GUID_OFFSET);
 
-	err = mthca_cmd(dev, indma, port, 0, CMD_INIT_IB,
+	err = mthca_cmd(dev, mailbox->dma, port, 0, CMD_INIT_IB,
 			CMD_TIME_CLASS_A, status);
 
-	pci_free_consistent(dev->pdev, INIT_HCA_IN_SIZE, inbox, indma);
+	mthca_free_mailbox(dev, mailbox);
 	return err;
 }
 
@@ -1262,8 +1301,8 @@ int mthca_CLOSE_HCA(struct mthca_dev *de
 int mthca_SET_IB(struct mthca_dev *dev, struct mthca_set_ib_param *param,
 		 int port, u8 *status)
 {
+	struct mthca_mailbox *mailbox;
 	u32 *inbox;
-	dma_addr_t indma;
 	int err;
 	u32 flags = 0;
 
@@ -1274,9 +1313,10 @@ int mthca_SET_IB(struct mthca_dev *dev, 
 #define SET_IB_CAP_MASK_OFFSET 0x04
 #define SET_IB_SI_GUID_OFFSET  0x08
 
-	inbox = pci_alloc_consistent(dev->pdev, SET_IB_IN_SIZE, &indma);
-	if (!inbox)
-		return -ENOMEM;
+	mailbox = mthca_alloc_mailbox(dev, GFP_KERNEL);
+	if (IS_ERR(mailbox))
+		return PTR_ERR(mailbox);
+	inbox = mailbox->buf;
 
 	memset(inbox, 0, SET_IB_IN_SIZE);
 
@@ -1287,10 +1327,10 @@ int mthca_SET_IB(struct mthca_dev *dev, 
 	MTHCA_PUT(inbox, param->cap_mask, SET_IB_CAP_MASK_OFFSET);
 	MTHCA_PUT(inbox, param->si_guid,  SET_IB_SI_GUID_OFFSET);
 
-	err = mthca_cmd(dev, indma, port, 0, CMD_SET_IB,
+	err = mthca_cmd(dev, mailbox->dma, port, 0, CMD_SET_IB,
 			CMD_TIME_CLASS_B, status);
 
-	pci_free_consistent(dev->pdev, INIT_HCA_IN_SIZE, inbox, indma);
+	mthca_free_mailbox(dev, mailbox);
 	return err;
 }
 
@@ -1301,20 +1341,22 @@ int mthca_MAP_ICM(struct mthca_dev *dev,
 
 int mthca_MAP_ICM_page(struct mthca_dev *dev, u64 dma_addr, u64 virt, u8 *status)
 {
+	struct mthca_mailbox *mailbox;
 	u64 *inbox;
-	dma_addr_t indma;
 	int err;
 
-	inbox = pci_alloc_consistent(dev->pdev, 16, &indma);
-	if (!inbox)
-		return -ENOMEM;
+	mailbox = mthca_alloc_mailbox(dev, GFP_KERNEL);
+	if (IS_ERR(mailbox))
+		return PTR_ERR(mailbox);
+	inbox = mailbox->buf;
 
 	inbox[0] = cpu_to_be64(virt);
 	inbox[1] = cpu_to_be64(dma_addr);
 
-	err = mthca_cmd(dev, indma, 1, 0, CMD_MAP_ICM, CMD_TIME_CLASS_B, status);
+	err = mthca_cmd(dev, mailbox->dma, 1, 0, CMD_MAP_ICM,
+			CMD_TIME_CLASS_B, status);
 
-	pci_free_consistent(dev->pdev, 16, inbox, indma);
+	mthca_free_mailbox(dev, mailbox);
 
 	if (!err)
 		mthca_dbg(dev, "Mapped page at %llx to %llx for ICM.\n",
@@ -1359,69 +1401,26 @@ int mthca_SET_ICM_SIZE(struct mthca_dev 
 	return 0;
 }
 
-int mthca_SW2HW_MPT(struct mthca_dev *dev, void *mpt_entry,
+int mthca_SW2HW_MPT(struct mthca_dev *dev, struct mthca_mailbox *mailbox,
 		    int mpt_index, u8 *status)
 {
-	dma_addr_t indma;
-	int err;
-
-	indma = pci_map_single(dev->pdev, mpt_entry,
-			       MTHCA_MPT_ENTRY_SIZE,
-			       PCI_DMA_TODEVICE);
-	if (pci_dma_mapping_error(indma))
-		return -ENOMEM;
-
-	err = mthca_cmd(dev, indma, mpt_index, 0, CMD_SW2HW_MPT,
-			CMD_TIME_CLASS_B, status);
-
-	pci_unmap_single(dev->pdev, indma,
-			 MTHCA_MPT_ENTRY_SIZE, PCI_DMA_TODEVICE);
-	return err;
+	return mthca_cmd(dev, mailbox->dma, mpt_index, 0, CMD_SW2HW_MPT,
+			 CMD_TIME_CLASS_B, status);
 }
 
-int mthca_HW2SW_MPT(struct mthca_dev *dev, void *mpt_entry,
+int mthca_HW2SW_MPT(struct mthca_dev *dev, struct mthca_mailbox *mailbox,
 		    int mpt_index, u8 *status)
 {
-	dma_addr_t outdma = 0;
-	int err;
-
-	if (mpt_entry) {
-		outdma = pci_map_single(dev->pdev, mpt_entry,
-					MTHCA_MPT_ENTRY_SIZE,
-					PCI_DMA_FROMDEVICE);
-		if (pci_dma_mapping_error(outdma))
-			return -ENOMEM;
-	}
-
-	err = mthca_cmd_box(dev, 0, outdma, mpt_index, !mpt_entry,
-			    CMD_HW2SW_MPT,
-			    CMD_TIME_CLASS_B, status);
-
-	if (mpt_entry)
-		pci_unmap_single(dev->pdev, outdma,
-				 MTHCA_MPT_ENTRY_SIZE,
-				 PCI_DMA_FROMDEVICE);
-	return err;
+	return mthca_cmd_box(dev, 0, mailbox ? mailbox->dma : 0, mpt_index,
+			     !mailbox, CMD_HW2SW_MPT,
+			     CMD_TIME_CLASS_B, status);
 }
 
-int mthca_WRITE_MTT(struct mthca_dev *dev, u64 *mtt_entry,
+int mthca_WRITE_MTT(struct mthca_dev *dev, struct mthca_mailbox *mailbox,
 		    int num_mtt, u8 *status)
 {
-	dma_addr_t indma;
-	int err;
-
-	indma = pci_map_single(dev->pdev, mtt_entry,
-			       (num_mtt + 2) * 8,
-			       PCI_DMA_TODEVICE);
-	if (pci_dma_mapping_error(indma))
-		return -ENOMEM;
-
-	err = mthca_cmd(dev, indma, num_mtt, 0, CMD_WRITE_MTT,
-			CMD_TIME_CLASS_B, status);
-
-	pci_unmap_single(dev->pdev, indma,
-			 (num_mtt + 2) * 8, PCI_DMA_TODEVICE);
-	return err;
+	return mthca_cmd(dev, mailbox->dma, num_mtt, 0, CMD_WRITE_MTT,
+			 CMD_TIME_CLASS_B, status);
 }
 
 int mthca_SYNC_TPT(struct mthca_dev *dev, u8 *status)
@@ -1439,92 +1438,38 @@ int mthca_MAP_EQ(struct mthca_dev *dev, 
 			 0, CMD_MAP_EQ, CMD_TIME_CLASS_B, status);
 }
 
-int mthca_SW2HW_EQ(struct mthca_dev *dev, void *eq_context,
+int mthca_SW2HW_EQ(struct mthca_dev *dev, struct mthca_mailbox *mailbox,
 		   int eq_num, u8 *status)
 {
-	dma_addr_t indma;
-	int err;
-
-	indma = pci_map_single(dev->pdev, eq_context,
-			       MTHCA_EQ_CONTEXT_SIZE,
-			       PCI_DMA_TODEVICE);
-	if (pci_dma_mapping_error(indma))
-		return -ENOMEM;
-
-	err = mthca_cmd(dev, indma, eq_num, 0, CMD_SW2HW_EQ,
-			CMD_TIME_CLASS_A, status);
-
-	pci_unmap_single(dev->pdev, indma,
-			 MTHCA_EQ_CONTEXT_SIZE, PCI_DMA_TODEVICE);
-	return err;
+	return mthca_cmd(dev, mailbox->dma, eq_num, 0, CMD_SW2HW_EQ,
+			 CMD_TIME_CLASS_A, status);
 }
 
-int mthca_HW2SW_EQ(struct mthca_dev *dev, void *eq_context,
+int mthca_HW2SW_EQ(struct mthca_dev *dev, struct mthca_mailbox *mailbox,
 		   int eq_num, u8 *status)
 {
-	dma_addr_t outdma = 0;
-	int err;
-
-	outdma = pci_map_single(dev->pdev, eq_context,
-				MTHCA_EQ_CONTEXT_SIZE,
-				PCI_DMA_FROMDEVICE);
-	if (pci_dma_mapping_error(outdma))
-		return -ENOMEM;
-
-	err = mthca_cmd_box(dev, 0, outdma, eq_num, 0,
-			    CMD_HW2SW_EQ,
-			    CMD_TIME_CLASS_A, status);
-
-	pci_unmap_single(dev->pdev, outdma,
-			 MTHCA_EQ_CONTEXT_SIZE,
-			 PCI_DMA_FROMDEVICE);
-	return err;
+	return mthca_cmd_box(dev, 0, mailbox->dma, eq_num, 0,
+			     CMD_HW2SW_EQ,
+			     CMD_TIME_CLASS_A, status);
 }
 
-int mthca_SW2HW_CQ(struct mthca_dev *dev, void *cq_context,
+int mthca_SW2HW_CQ(struct mthca_dev *dev, struct mthca_mailbox *mailbox,
 		   int cq_num, u8 *status)
 {
-	dma_addr_t indma;
-	int err;
-
-	indma = pci_map_single(dev->pdev, cq_context,
-			       MTHCA_CQ_CONTEXT_SIZE,
-			       PCI_DMA_TODEVICE);
-	if (pci_dma_mapping_error(indma))
-		return -ENOMEM;
-
-	err = mthca_cmd(dev, indma, cq_num, 0, CMD_SW2HW_CQ,
+	return mthca_cmd(dev, mailbox->dma, cq_num, 0, CMD_SW2HW_CQ,
 			CMD_TIME_CLASS_A, status);
-
-	pci_unmap_single(dev->pdev, indma,
-			 MTHCA_CQ_CONTEXT_SIZE, PCI_DMA_TODEVICE);
-	return err;
 }
 
-int mthca_HW2SW_CQ(struct mthca_dev *dev, void *cq_context,
+int mthca_HW2SW_CQ(struct mthca_dev *dev, struct mthca_mailbox *mailbox,
 		   int cq_num, u8 *status)
 {
-	dma_addr_t outdma = 0;
-	int err;
-
-	outdma = pci_map_single(dev->pdev, cq_context,
-				MTHCA_CQ_CONTEXT_SIZE,
-				PCI_DMA_FROMDEVICE);
-	if (pci_dma_mapping_error(outdma))
-		return -ENOMEM;
-
-	err = mthca_cmd_box(dev, 0, outdma, cq_num, 0,
-			    CMD_HW2SW_CQ,
-			    CMD_TIME_CLASS_A, status);
-
-	pci_unmap_single(dev->pdev, outdma,
-			 MTHCA_CQ_CONTEXT_SIZE,
-			 PCI_DMA_FROMDEVICE);
-	return err;
+	return mthca_cmd_box(dev, 0, mailbox->dma, cq_num, 0,
+			     CMD_HW2SW_CQ,
+			     CMD_TIME_CLASS_A, status);
 }
 
 int mthca_MODIFY_QP(struct mthca_dev *dev, int trans, u32 num,
-		    int is_ee, void *qp_context, u32 optmask,
+		    int is_ee, struct mthca_mailbox *mailbox, u32 optmask,
 		    u8 *status)
 {
 	static const u16 op[] = {
@@ -1541,36 +1486,34 @@ int mthca_MODIFY_QP(struct mthca_dev *de
 		[MTHCA_TRANS_ANY2RST]   = CMD_ERR2RST_QPEE
 	};
 	u8 op_mod = 0;
-
-	dma_addr_t indma;
+	int my_mailbox = 0;
 	int err;
 
 	if (trans < 0 || trans >= ARRAY_SIZE(op))
 		return -EINVAL;
 
 	if (trans == MTHCA_TRANS_ANY2RST) {
-		indma  = 0;
 		op_mod = 3;	/* don't write outbox, any->reset */
 
 		/* For debugging */
-		qp_context = pci_alloc_consistent(dev->pdev, MTHCA_QP_CONTEXT_SIZE,
-						  &indma);
-		op_mod = 2;	/* write outbox, any->reset */
+		if (!mailbox) {
+			mailbox = mthca_alloc_mailbox(dev, GFP_KERNEL);
+			if (!IS_ERR(mailbox)) {
+				my_mailbox = 1;
+				op_mod     = 2;	/* write outbox, any->reset */
+			} else
+				mailbox = NULL;
+		}
 	} else {
-		indma = pci_map_single(dev->pdev, qp_context,
-				       MTHCA_QP_CONTEXT_SIZE,
-				       PCI_DMA_TODEVICE);
-		if (pci_dma_mapping_error(indma))
-			return -ENOMEM;
-
 		if (0) {
 			int i;
 			mthca_dbg(dev, "Dumping QP context:\n");
-			printk("  opt param mask: %08x\n", be32_to_cpup(qp_context));
+			printk("  opt param mask: %08x\n", be32_to_cpup(mailbox->buf));
 			for (i = 0; i < 0x100 / 4; ++i) {
 				if (i % 8 == 0)
 					printk("  [%02x] ", i * 4);
-				printk(" %08x", be32_to_cpu(((u32 *) qp_context)[i + 2]));
+				printk(" %08x",
+				       be32_to_cpu(((u32 *) mailbox->buf)[i + 2]));
 				if ((i + 1) % 8 == 0)
 					printk("\n");
 			}
@@ -1578,55 +1521,39 @@ int mthca_MODIFY_QP(struct mthca_dev *de
 	}
 
 	if (trans == MTHCA_TRANS_ANY2RST) {
-		err = mthca_cmd_box(dev, 0, indma, (!!is_ee << 24) | num,
-				    op_mod, op[trans], CMD_TIME_CLASS_C, status);
+		err = mthca_cmd_box(dev, 0, mailbox ? mailbox->dma : 0,
+				    (!!is_ee << 24) | num, op_mod,
+				    op[trans], CMD_TIME_CLASS_C, status);
 
-		if (0) {
+		if (0 && mailbox) {
 			int i;
 			mthca_dbg(dev, "Dumping QP context:\n");
-			printk(" %08x\n", be32_to_cpup(qp_context));
+			printk(" %08x\n", be32_to_cpup(mailbox->buf));
 			for (i = 0; i < 0x100 / 4; ++i) {
 				if (i % 8 == 0)
 					printk("[%02x] ", i * 4);
-				printk(" %08x", be32_to_cpu(((u32 *) qp_context)[i + 2]));
+				printk(" %08x",
+				       be32_to_cpu(((u32 *) mailbox->buf)[i + 2]));
 				if ((i + 1) % 8 == 0)
 					printk("\n");
 			}
 		}
 
 	} else
-		err = mthca_cmd(dev, indma, (!!is_ee << 24) | num,
+		err = mthca_cmd(dev, mailbox->dma, (!!is_ee << 24) | num,
 				op_mod, op[trans], CMD_TIME_CLASS_C, status);
 
-	if (trans != MTHCA_TRANS_ANY2RST)
-		pci_unmap_single(dev->pdev, indma,
-				 MTHCA_QP_CONTEXT_SIZE, PCI_DMA_TODEVICE);
-	else
-		pci_free_consistent(dev->pdev, MTHCA_QP_CONTEXT_SIZE,
-				    qp_context, indma);
+	if (my_mailbox)
+		mthca_free_mailbox(dev, mailbox);
+
 	return err;
 }
 
 int mthca_QUERY_QP(struct mthca_dev *dev, u32 num, int is_ee,
-		   void *qp_context, u8 *status)
+		   struct mthca_mailbox *mailbox, u8 *status)
 {
-	dma_addr_t outdma = 0;
-	int err;
-
-	outdma = pci_map_single(dev->pdev, qp_context,
-				MTHCA_QP_CONTEXT_SIZE,
-				PCI_DMA_FROMDEVICE);
-	if (pci_dma_mapping_error(outdma))
-		return -ENOMEM;
-
-	err = mthca_cmd_box(dev, 0, outdma, (!!is_ee << 24) | num, 0,
-			    CMD_QUERY_QPEE,
-			    CMD_TIME_CLASS_A, status);
-
-	pci_unmap_single(dev->pdev, outdma,
-			 MTHCA_QP_CONTEXT_SIZE,
-			 PCI_DMA_FROMDEVICE);
-	return err;
+	return mthca_cmd_box(dev, 0, mailbox->dma, (!!is_ee << 24) | num, 0,
+			     CMD_QUERY_QPEE, CMD_TIME_CLASS_A, status);
 }
 
 int mthca_CONF_SPECIAL_QP(struct mthca_dev *dev, int type, u32 qpn,
@@ -1656,11 +1583,11 @@ int mthca_CONF_SPECIAL_QP(struct mthca_d
 }
 
 int mthca_MAD_IFC(struct mthca_dev *dev, int ignore_mkey, int ignore_bkey,
-		  int port, struct ib_wc* in_wc, struct ib_grh* in_grh,
+		  int port, struct ib_wc *in_wc, struct ib_grh *in_grh,
 		  void *in_mad, void *response_mad, u8 *status)
 {
-	void *box;
-	dma_addr_t dma;
+	struct mthca_mailbox *inmailbox, *outmailbox;
+	void *inbox;
 	int err;
 	u32 in_modifier = port;
 	u8 op_modifier = 0;
@@ -1674,11 +1601,18 @@ int mthca_MAD_IFC(struct mthca_dev *dev,
 #define MAD_IFC_PKEY_OFFSET   0x10e
 #define MAD_IFC_GRH_OFFSET    0x140
 
-	box = pci_alloc_consistent(dev->pdev, MAD_IFC_BOX_SIZE, &dma);
-	if (!box)
-		return -ENOMEM;
+	inmailbox = mthca_alloc_mailbox(dev, GFP_KERNEL);
+	if (IS_ERR(inmailbox))
+		return PTR_ERR(inmailbox);
+	inbox = inmailbox->buf;
+
+	outmailbox = mthca_alloc_mailbox(dev, GFP_KERNEL);
+	if (IS_ERR(outmailbox)) {
+		mthca_free_mailbox(dev, inmailbox);
+		return PTR_ERR(outmailbox);
+	}
 
-	memcpy(box, in_mad, 256);
+	memcpy(inbox, in_mad, 256);
 
 	/*
 	 * Key check traps can't be generated unless we have in_wc to
@@ -1692,97 +1626,65 @@ int mthca_MAD_IFC(struct mthca_dev *dev,
 	if (in_wc) {
 		u8 val;
 
-		memset(box + 256, 0, 256);
+		memset(inbox + 256, 0, 256);
 
-		MTHCA_PUT(box, in_wc->qp_num, 	  MAD_IFC_MY_QPN_OFFSET);
-		MTHCA_PUT(box, in_wc->src_qp, 	  MAD_IFC_RQPN_OFFSET);
+		MTHCA_PUT(inbox, in_wc->qp_num,     MAD_IFC_MY_QPN_OFFSET);
+		MTHCA_PUT(inbox, in_wc->src_qp,     MAD_IFC_RQPN_OFFSET);
 
 		val = in_wc->sl << 4;
-		MTHCA_PUT(box, val,               MAD_IFC_SL_OFFSET);
+		MTHCA_PUT(inbox, val,               MAD_IFC_SL_OFFSET);
 
 		val = in_wc->dlid_path_bits |
 			(in_wc->wc_flags & IB_WC_GRH ? 0x80 : 0);
-		MTHCA_PUT(box, val,               MAD_IFC_GRH_OFFSET);
+		MTHCA_PUT(inbox, val,               MAD_IFC_GRH_OFFSET);
 
-		MTHCA_PUT(box, in_wc->slid,       MAD_IFC_RLID_OFFSET);
-		MTHCA_PUT(box, in_wc->pkey_index, MAD_IFC_PKEY_OFFSET);
+		MTHCA_PUT(inbox, in_wc->slid,       MAD_IFC_RLID_OFFSET);
+		MTHCA_PUT(inbox, in_wc->pkey_index, MAD_IFC_PKEY_OFFSET);
 
 		if (in_grh)
-			memcpy((u8 *) box + MAD_IFC_GRH_OFFSET, in_grh, 40);
+			memcpy(inbox + MAD_IFC_GRH_OFFSET, in_grh, 40);
 
 		op_modifier |= 0x10;
 
 		in_modifier |= in_wc->slid << 16;
 	}
 
-	err = mthca_cmd_box(dev, dma, dma + 512, in_modifier, op_modifier,
+	err = mthca_cmd_box(dev, inmailbox->dma, outmailbox->dma,
+			    in_modifier, op_modifier,
 			    CMD_MAD_IFC, CMD_TIME_CLASS_C, status);
 
 	if (!err && !*status)
-		memcpy(response_mad, box + 512, 256);
+		memcpy(response_mad, outmailbox->buf, 256);
 
-	pci_free_consistent(dev->pdev, MAD_IFC_BOX_SIZE, box, dma);
+	mthca_free_mailbox(dev, inmailbox);
+	mthca_free_mailbox(dev, outmailbox);
 	return err;
 }
 
-int mthca_READ_MGM(struct mthca_dev *dev, int index, void *mgm,
-		   u8 *status)
+int mthca_READ_MGM(struct mthca_dev *dev, int index,
+		   struct mthca_mailbox *mailbox, u8 *status)
 {
-	dma_addr_t outdma = 0;
-	int err;
-
-	outdma = pci_map_single(dev->pdev, mgm,
-				MTHCA_MGM_ENTRY_SIZE,
-				PCI_DMA_FROMDEVICE);
-	if (pci_dma_mapping_error(outdma))
-		return -ENOMEM;
-
-	err = mthca_cmd_box(dev, 0, outdma, index, 0,
-			    CMD_READ_MGM,
-			    CMD_TIME_CLASS_A, status);
-
-	pci_unmap_single(dev->pdev, outdma,
-			 MTHCA_MGM_ENTRY_SIZE,
-			 PCI_DMA_FROMDEVICE);
-	return err;
+	return mthca_cmd_box(dev, 0, mailbox->dma, index, 0,
+			     CMD_READ_MGM, CMD_TIME_CLASS_A, status);
 }
 
-int mthca_WRITE_MGM(struct mthca_dev *dev, int index, void *mgm,
-		    u8 *status)
+int mthca_WRITE_MGM(struct mthca_dev *dev, int index,
+		    struct mthca_mailbox *mailbox, u8 *status)
 {
-	dma_addr_t indma;
-	int err;
-
-	indma = pci_map_single(dev->pdev, mgm,
-			       MTHCA_MGM_ENTRY_SIZE,
-			       PCI_DMA_TODEVICE);
-	if (pci_dma_mapping_error(indma))
-		return -ENOMEM;
-
-	err = mthca_cmd(dev, indma, index, 0, CMD_WRITE_MGM,
-			CMD_TIME_CLASS_A, status);
-
-	pci_unmap_single(dev->pdev, indma,
-			 MTHCA_MGM_ENTRY_SIZE, PCI_DMA_TODEVICE);
-	return err;
+	return mthca_cmd(dev, mailbox->dma, index, 0, CMD_WRITE_MGM,
+			 CMD_TIME_CLASS_A, status);
 }
 
-int mthca_MGID_HASH(struct mthca_dev *dev, void *gid, u16 *hash,
-		    u8 *status)
+int mthca_MGID_HASH(struct mthca_dev *dev, struct mthca_mailbox *mailbox,
+		    u16 *hash, u8 *status)
 {
-	dma_addr_t indma;
 	u64 imm;
 	int err;
 
-	indma = pci_map_single(dev->pdev, gid, 16, PCI_DMA_TODEVICE);
-	if (pci_dma_mapping_error(indma))
-		return -ENOMEM;
-
-	err = mthca_cmd_imm(dev, indma, &imm, 0, 0, CMD_MGID_HASH,
+	err = mthca_cmd_imm(dev, mailbox->dma, &imm, 0, 0, CMD_MGID_HASH,
 			    CMD_TIME_CLASS_A, status);
-	*hash = imm;
 
-	pci_unmap_single(dev->pdev, indma, 16, PCI_DMA_TODEVICE);
+	*hash = imm;
 	return err;
 }
 
--- linux.git.orig/drivers/infiniband/hw/mthca/mthca_cmd.h	2005-06-23 13:03:08.795213517 -0700
+++ linux.git/drivers/infiniband/hw/mthca/mthca_cmd.h	2005-06-23 13:03:09.282108141 -0700
@@ -37,8 +37,7 @@
 
 #include <ib_verbs.h>
 
-#define MTHCA_CMD_MAILBOX_ALIGN 16UL
-#define MTHCA_CMD_MAILBOX_EXTRA (MTHCA_CMD_MAILBOX_ALIGN - 1)
+#define MTHCA_MAILBOX_SIZE 4096
 
 enum {
 	/* command completed successfully: */
@@ -112,6 +111,11 @@ enum {
 	DEV_LIM_FLAG_UD_MULTI           = 1 << 21,
 };
 
+struct mthca_mailbox {
+	dma_addr_t dma;
+	void      *buf;
+};
+
 struct mthca_dev_lim {
 	int max_srq_sz;
 	int max_qp_sz;
@@ -242,6 +246,10 @@ void mthca_cmd_use_polling(struct mthca_
 void mthca_cmd_event(struct mthca_dev *dev, u16 token,
 		     u8  status, u64 out_param);
 
+struct mthca_mailbox *mthca_alloc_mailbox(struct mthca_dev *dev,
+					  unsigned int gfp_mask);
+void mthca_free_mailbox(struct mthca_dev *dev, struct mthca_mailbox *mailbox);
+
 int mthca_SYS_EN(struct mthca_dev *dev, u8 *status);
 int mthca_SYS_DIS(struct mthca_dev *dev, u8 *status);
 int mthca_MAP_FA(struct mthca_dev *dev, struct mthca_icm *icm, u8 *status);
@@ -272,41 +280,39 @@ int mthca_MAP_ICM_AUX(struct mthca_dev *
 int mthca_UNMAP_ICM_AUX(struct mthca_dev *dev, u8 *status);
 int mthca_SET_ICM_SIZE(struct mthca_dev *dev, u64 icm_size, u64 *aux_pages,
 		       u8 *status);
-int mthca_SW2HW_MPT(struct mthca_dev *dev, void *mpt_entry,
+int mthca_SW2HW_MPT(struct mthca_dev *dev, struct mthca_mailbox *mailbox,
 		    int mpt_index, u8 *status);
-int mthca_HW2SW_MPT(struct mthca_dev *dev, void *mpt_entry,
+int mthca_HW2SW_MPT(struct mthca_dev *dev, struct mthca_mailbox *mailbox,
 		    int mpt_index, u8 *status);
-int mthca_WRITE_MTT(struct mthca_dev *dev, u64 *mtt_entry,
+int mthca_WRITE_MTT(struct mthca_dev *dev, struct mthca_mailbox *mailbox,
 		    int num_mtt, u8 *status);
 int mthca_SYNC_TPT(struct mthca_dev *dev, u8 *status);
 int mthca_MAP_EQ(struct mthca_dev *dev, u64 event_mask, int unmap,
 		 int eq_num, u8 *status);
-int mthca_SW2HW_EQ(struct mthca_dev *dev, void *eq_context,
+int mthca_SW2HW_EQ(struct mthca_dev *dev, struct mthca_mailbox *mailbox,
 		   int eq_num, u8 *status);
-int mthca_HW2SW_EQ(struct mthca_dev *dev, void *eq_context,
+int mthca_HW2SW_EQ(struct mthca_dev *dev, struct mthca_mailbox *mailbox,
 		   int eq_num, u8 *status);
-int mthca_SW2HW_CQ(struct mthca_dev *dev, void *cq_context,
+int mthca_SW2HW_CQ(struct mthca_dev *dev, struct mthca_mailbox *mailbox,
 		   int cq_num, u8 *status);
-int mthca_HW2SW_CQ(struct mthca_dev *dev, void *cq_context,
+int mthca_HW2SW_CQ(struct mthca_dev *dev, struct mthca_mailbox *mailbox,
 		   int cq_num, u8 *status);
 int mthca_MODIFY_QP(struct mthca_dev *dev, int trans, u32 num,
-		    int is_ee, void *qp_context, u32 optmask,
+		    int is_ee, struct mthca_mailbox *mailbox, u32 optmask,
 		    u8 *status);
 int mthca_QUERY_QP(struct mthca_dev *dev, u32 num, int is_ee,
-		   void *qp_context, u8 *status);
+		   struct mthca_mailbox *mailbox, u8 *status);
 int mthca_CONF_SPECIAL_QP(struct mthca_dev *dev, int type, u32 qpn,
 			  u8 *status);
 int mthca_MAD_IFC(struct mthca_dev *dev, int ignore_mkey, int ignore_bkey,
-		  int port, struct ib_wc* in_wc, struct ib_grh* in_grh,
+		  int port, struct ib_wc *in_wc, struct ib_grh *in_grh,
 		  void *in_mad, void *response_mad, u8 *status);
-int mthca_READ_MGM(struct mthca_dev *dev, int index, void *mgm,
-		   u8 *status);
-int mthca_WRITE_MGM(struct mthca_dev *dev, int index, void *mgm,
-		    u8 *status);
-int mthca_MGID_HASH(struct mthca_dev *dev, void *gid, u16 *hash,
-		    u8 *status);
+int mthca_READ_MGM(struct mthca_dev *dev, int index,
+		   struct mthca_mailbox *mailbox, u8 *status);
+int mthca_WRITE_MGM(struct mthca_dev *dev, int index,
+		    struct mthca_mailbox *mailbox, u8 *status);
+int mthca_MGID_HASH(struct mthca_dev *dev, struct mthca_mailbox *mailbox,
+		    u16 *hash, u8 *status);
 int mthca_NOP(struct mthca_dev *dev, u8 *status);
 
-#define MAILBOX_ALIGN(x) ((void *) ALIGN((unsigned long) (x), MTHCA_CMD_MAILBOX_ALIGN))
-
 #endif /* MTHCA_CMD_H */
--- linux.git.orig/drivers/infiniband/hw/mthca/mthca_cq.c	2005-06-23 13:03:06.793646706 -0700
+++ linux.git/drivers/infiniband/hw/mthca/mthca_cq.c	2005-06-23 13:03:09.280108573 -0700
@@ -745,7 +745,7 @@ int mthca_init_cq(struct mthca_dev *dev,
 		  struct mthca_cq *cq)
 {
 	int size = nent * MTHCA_CQ_ENTRY_SIZE;
-	void *mailbox = NULL;
+	struct mthca_mailbox *mailbox;
 	struct mthca_cq_context *cq_context;
 	int err = -ENOMEM;
 	u8 status;
@@ -779,12 +779,11 @@ int mthca_init_cq(struct mthca_dev *dev,
 			goto err_out_ci;
 	}
 
-	mailbox = kmalloc(sizeof (struct mthca_cq_context) + MTHCA_CMD_MAILBOX_EXTRA,
-			  GFP_KERNEL);
-	if (!mailbox)
-		goto err_out_mailbox;
+	mailbox = mthca_alloc_mailbox(dev, GFP_KERNEL);
+	if (IS_ERR(mailbox))
+		goto err_out_arm;
 
-	cq_context = MAILBOX_ALIGN(mailbox);
+	cq_context = mailbox->buf;
 
 	err = mthca_alloc_cq_buf(dev, size, cq);
 	if (err)
@@ -815,7 +814,7 @@ int mthca_init_cq(struct mthca_dev *dev,
 		cq_context->state_db = cpu_to_be32(cq->arm_db_index);
 	}
 
-	err = mthca_SW2HW_CQ(dev, cq_context, cq->cqn, &status);
+	err = mthca_SW2HW_CQ(dev, mailbox, cq->cqn, &status);
 	if (err) {
 		mthca_warn(dev, "SW2HW_CQ failed (%d)\n", err);
 		goto err_out_free_mr;
@@ -839,7 +838,7 @@ int mthca_init_cq(struct mthca_dev *dev,
 
 	cq->cons_index = 0;
 
-	kfree(mailbox);
+	mthca_free_mailbox(dev, mailbox);
 
 	return 0;
 
@@ -848,8 +847,9 @@ err_out_free_mr:
 	mthca_free_cq_buf(dev, cq);
 
 err_out_mailbox:
-	kfree(mailbox);
+	mthca_free_mailbox(dev, mailbox);
 
+err_out_arm:
 	if (mthca_is_memfree(dev))
 		mthca_free_db(dev, MTHCA_DB_TYPE_CQ_ARM, cq->arm_db_index);
 
@@ -869,28 +869,26 @@ err_out:
 void mthca_free_cq(struct mthca_dev *dev,
 		   struct mthca_cq *cq)
 {
-	void *mailbox;
+	struct mthca_mailbox *mailbox;
 	int err;
 	u8 status;
 
 	might_sleep();
 
-	mailbox = kmalloc(sizeof (struct mthca_cq_context) + MTHCA_CMD_MAILBOX_EXTRA,
-			  GFP_KERNEL);
-	if (!mailbox) {
+	mailbox = mthca_alloc_mailbox(dev, GFP_KERNEL);
+	if (IS_ERR(mailbox)) {
 		mthca_warn(dev, "No memory for mailbox to free CQ.\n");
 		return;
 	}
 
-	err = mthca_HW2SW_CQ(dev, MAILBOX_ALIGN(mailbox), cq->cqn, &status);
+	err = mthca_HW2SW_CQ(dev, mailbox, cq->cqn, &status);
 	if (err)
 		mthca_warn(dev, "HW2SW_CQ failed (%d)\n", err);
 	else if (status)
-		mthca_warn(dev, "HW2SW_CQ returned status 0x%02x\n",
-			   status);
+		mthca_warn(dev, "HW2SW_CQ returned status 0x%02x\n", status);
 
 	if (0) {
-		u32 *ctx = MAILBOX_ALIGN(mailbox);
+		u32 *ctx = mailbox->buf;
 		int j;
 
 		printk(KERN_ERR "context for CQN %x (cons index %x, next sw %d)\n",
@@ -922,7 +920,7 @@ void mthca_free_cq(struct mthca_dev *dev
 
 	mthca_table_put(dev, dev->cq_table.table, cq->cqn);
 	mthca_free(&dev->cq_table.alloc, cq->cqn);
-	kfree(mailbox);
+	mthca_free_mailbox(dev, mailbox);
 }
 
 int __devinit mthca_init_cq_table(struct mthca_dev *dev)
--- linux.git.orig/drivers/infiniband/hw/mthca/mthca_dev.h	2005-06-23 13:03:07.308535271 -0700
+++ linux.git/drivers/infiniband/hw/mthca/mthca_dev.h	2005-06-23 13:03:09.283107924 -0700
@@ -99,6 +99,7 @@ enum {
 };
 
 struct mthca_cmd {
+	struct pci_pool          *pool;
 	int                       use_events;
 	struct semaphore          hcr_sem;
 	struct semaphore 	  poll_sem;
--- linux.git.orig/drivers/infiniband/hw/mthca/mthca_eq.c	2005-06-23 13:03:04.752088550 -0700
+++ linux.git/drivers/infiniband/hw/mthca/mthca_eq.c	2005-06-23 13:03:09.281108357 -0700
@@ -469,7 +469,7 @@ static int __devinit mthca_create_eq(str
 		PAGE_SIZE;
 	u64 *dma_list = NULL;
 	dma_addr_t t;
-	void *mailbox = NULL;
+	struct mthca_mailbox *mailbox;
 	struct mthca_eq_context *eq_context;
 	int err = -ENOMEM;
 	int i;
@@ -494,17 +494,16 @@ static int __devinit mthca_create_eq(str
 	if (!dma_list)
 		goto err_out_free;
 
-	mailbox = kmalloc(sizeof *eq_context + MTHCA_CMD_MAILBOX_EXTRA,
-			  GFP_KERNEL);
-	if (!mailbox)
+	mailbox = mthca_alloc_mailbox(dev, GFP_KERNEL);
+	if (IS_ERR(mailbox))
 		goto err_out_free;
-	eq_context = MAILBOX_ALIGN(mailbox);
+	eq_context = mailbox->buf;
 
 	for (i = 0; i < npages; ++i) {
 		eq->page_list[i].buf = dma_alloc_coherent(&dev->pdev->dev,
 							  PAGE_SIZE, &t, GFP_KERNEL);
 		if (!eq->page_list[i].buf)
-			goto err_out_free;
+			goto err_out_free_pages;
 
 		dma_list[i] = t;
 		pci_unmap_addr_set(&eq->page_list[i], mapping, t);
@@ -517,7 +516,7 @@ static int __devinit mthca_create_eq(str
 
 	eq->eqn = mthca_alloc(&dev->eq_table.alloc);
 	if (eq->eqn == -1)
-		goto err_out_free;
+		goto err_out_free_pages;
 
 	err = mthca_mr_alloc_phys(dev, dev->driver_pd.pd_num,
 				  dma_list, PAGE_SHIFT, npages,
@@ -548,7 +547,7 @@ static int __devinit mthca_create_eq(str
 	eq_context->intr            = intr;
 	eq_context->lkey            = cpu_to_be32(eq->mr.ibmr.lkey);
 
-	err = mthca_SW2HW_EQ(dev, eq_context, eq->eqn, &status);
+	err = mthca_SW2HW_EQ(dev, mailbox, eq->eqn, &status);
 	if (err) {
 		mthca_warn(dev, "SW2HW_EQ failed (%d)\n", err);
 		goto err_out_free_mr;
@@ -561,7 +560,7 @@ static int __devinit mthca_create_eq(str
 	}
 
 	kfree(dma_list);
-	kfree(mailbox);
+	mthca_free_mailbox(dev, mailbox);
 
 	eq->eqn_mask   = swab32(1 << eq->eqn);
 	eq->cons_index = 0;
@@ -579,7 +578,7 @@ static int __devinit mthca_create_eq(str
  err_out_free_eq:
 	mthca_free(&dev->eq_table.alloc, eq->eqn);
 
- err_out_free:
+ err_out_free_pages:
 	for (i = 0; i < npages; ++i)
 		if (eq->page_list[i].buf)
 			dma_free_coherent(&dev->pdev->dev, PAGE_SIZE,
@@ -587,9 +586,11 @@ static int __devinit mthca_create_eq(str
 					  pci_unmap_addr(&eq->page_list[i],
 							 mapping));
 
+	mthca_free_mailbox(dev, mailbox);
+
+ err_out_free:
 	kfree(eq->page_list);
 	kfree(dma_list);
-	kfree(mailbox);
 
  err_out:
 	return err;
@@ -598,20 +599,18 @@ static int __devinit mthca_create_eq(str
 static void mthca_free_eq(struct mthca_dev *dev,
 			  struct mthca_eq *eq)
 {
-	void *mailbox = NULL;
+	struct mthca_mailbox *mailbox;
 	int err;
 	u8 status;
 	int npages = (eq->nent * MTHCA_EQ_ENTRY_SIZE + PAGE_SIZE - 1) /
 		PAGE_SIZE;
 	int i;
 
-	mailbox = kmalloc(sizeof (struct mthca_eq_context) + MTHCA_CMD_MAILBOX_EXTRA,
-			  GFP_KERNEL);
-	if (!mailbox)
+	mailbox = mthca_alloc_mailbox(dev, GFP_KERNEL);
+	if (IS_ERR(mailbox))
 		return;
 
-	err = mthca_HW2SW_EQ(dev, MAILBOX_ALIGN(mailbox),
-			     eq->eqn, &status);
+	err = mthca_HW2SW_EQ(dev, mailbox, eq->eqn, &status);
 	if (err)
 		mthca_warn(dev, "HW2SW_EQ failed (%d)\n", err);
 	if (status)
@@ -624,7 +623,7 @@ static void mthca_free_eq(struct mthca_d
 		for (i = 0; i < sizeof (struct mthca_eq_context) / 4; ++i) {
 			if (i % 4 == 0)
 				printk("[%02x] ", i * 4);
-			printk(" %08x", be32_to_cpup(MAILBOX_ALIGN(mailbox) + i * 4));
+			printk(" %08x", be32_to_cpup(mailbox->buf + i * 4));
 			if ((i + 1) % 4 == 0)
 				printk("\n");
 		}
@@ -637,7 +636,7 @@ static void mthca_free_eq(struct mthca_d
 				    pci_unmap_addr(&eq->page_list[i], mapping));
 
 	kfree(eq->page_list);
-	kfree(mailbox);
+	mthca_free_mailbox(dev, mailbox);
 }
 
 static void mthca_free_irqs(struct mthca_dev *dev)
--- linux.git.orig/drivers/infiniband/hw/mthca/mthca_mcg.c	2005-06-23 13:03:00.964908188 -0700
+++ linux.git/drivers/infiniband/hw/mthca/mthca_mcg.c	2005-06-23 13:03:09.281108357 -0700
@@ -66,22 +66,23 @@ static const u8 zero_gid[16];	/* automat
  * entry in hash chain and *mgm holds end of hash chain.
  */
 static int find_mgm(struct mthca_dev *dev,
-		    u8 *gid, struct mthca_mgm *mgm,
+		    u8 *gid, struct mthca_mailbox *mgm_mailbox,
 		    u16 *hash, int *prev, int *index)
 {
-	void *mailbox;
+	struct mthca_mailbox *mailbox;
+	struct mthca_mgm *mgm = mgm_mailbox->buf;
 	u8 *mgid;
 	int err;
 	u8 status;
 
-	mailbox = kmalloc(16 + MTHCA_CMD_MAILBOX_EXTRA, GFP_KERNEL);
-	if (!mailbox)
+	mailbox = mthca_alloc_mailbox(dev, GFP_KERNEL);
+	if (IS_ERR(mailbox))
 		return -ENOMEM;
-	mgid = MAILBOX_ALIGN(mailbox);
+	mgid = mailbox->buf;
 
 	memcpy(mgid, gid, 16);
 
-	err = mthca_MGID_HASH(dev, mgid, hash, &status);
+	err = mthca_MGID_HASH(dev, mailbox, hash, &status);
 	if (err)
 		goto out;
 	if (status) {
@@ -103,7 +104,7 @@ static int find_mgm(struct mthca_dev *de
 	*prev  = -1;
 
 	do {
-		err = mthca_READ_MGM(dev, *index, mgm, &status);
+		err = mthca_READ_MGM(dev, *index, mgm_mailbox, &status);
 		if (err)
 			goto out;
 		if (status) {
@@ -129,14 +130,14 @@ static int find_mgm(struct mthca_dev *de
 	*index = -1;
 
  out:
-	kfree(mailbox);
+	mthca_free_mailbox(dev, mailbox);
 	return err;
 }
 
 int mthca_multicast_attach(struct ib_qp *ibqp, union ib_gid *gid, u16 lid)
 {
 	struct mthca_dev *dev = to_mdev(ibqp->device);
-	void *mailbox;
+	struct mthca_mailbox *mailbox;
 	struct mthca_mgm *mgm;
 	u16 hash;
 	int index, prev;
@@ -145,15 +146,15 @@ int mthca_multicast_attach(struct ib_qp 
 	int err;
 	u8 status;
 
-	mailbox = kmalloc(sizeof *mgm + MTHCA_CMD_MAILBOX_EXTRA, GFP_KERNEL);
-	if (!mailbox)
-		return -ENOMEM;
-	mgm = MAILBOX_ALIGN(mailbox);
+	mailbox = mthca_alloc_mailbox(dev, GFP_KERNEL);
+	if (IS_ERR(mailbox))
+		return PTR_ERR(mailbox);
+	mgm = mailbox->buf;
 
 	if (down_interruptible(&dev->mcg_table.sem))
 		return -EINTR;
 
-	err = find_mgm(dev, gid->raw, mgm, &hash, &prev, &index);
+	err = find_mgm(dev, gid->raw, mailbox, &hash, &prev, &index);
 	if (err)
 		goto out;
 
@@ -170,7 +171,7 @@ int mthca_multicast_attach(struct ib_qp 
 			goto out;
 		}
 
-		err = mthca_READ_MGM(dev, index, mgm, &status);
+		err = mthca_READ_MGM(dev, index, mailbox, &status);
 		if (err)
 			goto out;
 		if (status) {
@@ -195,7 +196,7 @@ int mthca_multicast_attach(struct ib_qp 
 		goto out;
 	}
 
-	err = mthca_WRITE_MGM(dev, index, mgm, &status);
+	err = mthca_WRITE_MGM(dev, index, mailbox, &status);
 	if (err)
 		goto out;
 	if (status) {
@@ -206,7 +207,7 @@ int mthca_multicast_attach(struct ib_qp 
 	if (!link)
 		goto out;
 
-	err = mthca_READ_MGM(dev, prev, mgm, &status);
+	err = mthca_READ_MGM(dev, prev, mailbox, &status);
 	if (err)
 		goto out;
 	if (status) {
@@ -217,7 +218,7 @@ int mthca_multicast_attach(struct ib_qp 
 
 	mgm->next_gid_index = cpu_to_be32(index << 5);
 
-	err = mthca_WRITE_MGM(dev, prev, mgm, &status);
+	err = mthca_WRITE_MGM(dev, prev, mailbox, &status);
 	if (err)
 		goto out;
 	if (status) {
@@ -227,14 +228,14 @@ int mthca_multicast_attach(struct ib_qp 
 
  out:
 	up(&dev->mcg_table.sem);
-	kfree(mailbox);
+	mthca_free_mailbox(dev, mailbox);
 	return err;
 }
 
 int mthca_multicast_detach(struct ib_qp *ibqp, union ib_gid *gid, u16 lid)
 {
 	struct mthca_dev *dev = to_mdev(ibqp->device);
-	void *mailbox;
+	struct mthca_mailbox *mailbox;
 	struct mthca_mgm *mgm;
 	u16 hash;
 	int prev, index;
@@ -242,15 +243,15 @@ int mthca_multicast_detach(struct ib_qp 
 	int err;
 	u8 status;
 
-	mailbox = kmalloc(sizeof *mgm + MTHCA_CMD_MAILBOX_EXTRA, GFP_KERNEL);
-	if (!mailbox)
-		return -ENOMEM;
-	mgm = MAILBOX_ALIGN(mailbox);
+	mailbox = mthca_alloc_mailbox(dev, GFP_KERNEL);
+	if (IS_ERR(mailbox))
+		return PTR_ERR(mailbox);
+	mgm = mailbox->buf;
 
 	if (down_interruptible(&dev->mcg_table.sem))
 		return -EINTR;
 
-	err = find_mgm(dev, gid->raw, mgm, &hash, &prev, &index);
+	err = find_mgm(dev, gid->raw, mailbox, &hash, &prev, &index);
 	if (err)
 		goto out;
 
@@ -285,7 +286,7 @@ int mthca_multicast_detach(struct ib_qp 
 	mgm->qp[loc]   = mgm->qp[i - 1];
 	mgm->qp[i - 1] = 0;
 
-	err = mthca_WRITE_MGM(dev, index, mgm, &status);
+	err = mthca_WRITE_MGM(dev, index, mailbox, &status);
 	if (err)
 		goto out;
 	if (status) {
@@ -304,7 +305,7 @@ int mthca_multicast_detach(struct ib_qp 
 		if (be32_to_cpu(mgm->next_gid_index) >> 5) {
 			err = mthca_READ_MGM(dev,
 					     be32_to_cpu(mgm->next_gid_index) >> 5,
-					     mgm, &status);
+					     mailbox, &status);
 			if (err)
 				goto out;
 			if (status) {
@@ -316,7 +317,7 @@ int mthca_multicast_detach(struct ib_qp 
 		} else
 			memset(mgm->gid, 0, 16);
 
-		err = mthca_WRITE_MGM(dev, index, mgm, &status);
+		err = mthca_WRITE_MGM(dev, index, mailbox, &status);
 		if (err)
 			goto out;
 		if (status) {
@@ -327,7 +328,7 @@ int mthca_multicast_detach(struct ib_qp 
 	} else {
 		/* Remove entry from AMGM */
 		index = be32_to_cpu(mgm->next_gid_index) >> 5;
-		err = mthca_READ_MGM(dev, prev, mgm, &status);
+		err = mthca_READ_MGM(dev, prev, mailbox, &status);
 		if (err)
 			goto out;
 		if (status) {
@@ -338,7 +339,7 @@ int mthca_multicast_detach(struct ib_qp 
 
 		mgm->next_gid_index = cpu_to_be32(index << 5);
 
-		err = mthca_WRITE_MGM(dev, prev, mgm, &status);
+		err = mthca_WRITE_MGM(dev, prev, mailbox, &status);
 		if (err)
 			goto out;
 		if (status) {
@@ -350,7 +351,7 @@ int mthca_multicast_detach(struct ib_qp 
 
  out:
 	up(&dev->mcg_table.sem);
-	kfree(mailbox);
+	mthca_free_mailbox(dev, mailbox);
 	return err;
 }
 
--- linux.git.orig/drivers/infiniband/hw/mthca/mthca_mr.c	2005-06-23 13:03:07.308535271 -0700
+++ linux.git/drivers/infiniband/hw/mthca/mthca_mr.c	2005-06-23 13:03:09.279108790 -0700
@@ -246,21 +246,23 @@ void mthca_free_mtt(struct mthca_dev *de
 int mthca_write_mtt(struct mthca_dev *dev, struct mthca_mtt *mtt,
 		    int start_index, u64 *buffer_list, int list_len)
 {
+	struct mthca_mailbox *mailbox;
 	u64 *mtt_entry;
 	int err = 0;
 	u8 status;
 	int i;
 
-	mtt_entry = (u64 *) __get_free_page(GFP_KERNEL);
-	if (!mtt_entry)
-		return -ENOMEM;
+	mailbox = mthca_alloc_mailbox(dev, GFP_KERNEL);
+	if (IS_ERR(mailbox))
+		return PTR_ERR(mailbox);
+	mtt_entry = mailbox->buf;
 
 	while (list_len > 0) {
 		mtt_entry[0] = cpu_to_be64(dev->mr_table.mtt_base +
 					   mtt->first_seg * MTHCA_MTT_SEG_SIZE +
 					   start_index * 8);
 		mtt_entry[1] = 0;
-		for (i = 0; i < list_len && i < PAGE_SIZE / 8 - 2; ++i)
+		for (i = 0; i < list_len && i < MTHCA_MAILBOX_SIZE / 8 - 2; ++i)
 			mtt_entry[i + 2] = cpu_to_be64(buffer_list[i] |
 						       MTHCA_MTT_FLAG_PRESENT);
 
@@ -271,7 +273,7 @@ int mthca_write_mtt(struct mthca_dev *de
 		if (i & 1)
 			mtt_entry[i + 2] = 0;
 
-		err = mthca_WRITE_MTT(dev, mtt_entry, (i + 1) & ~1, &status);
+		err = mthca_WRITE_MTT(dev, mailbox, (i + 1) & ~1, &status);
 		if (err) {
 			mthca_warn(dev, "WRITE_MTT failed (%d)\n", err);
 			goto out;
@@ -289,7 +291,7 @@ int mthca_write_mtt(struct mthca_dev *de
 	}
 
 out:
-	free_page((unsigned long) mtt_entry);
+	mthca_free_mailbox(dev, mailbox);
 	return err;
 }
 
@@ -332,7 +334,7 @@ static inline u32 key_to_hw_index(struct
 int mthca_mr_alloc(struct mthca_dev *dev, u32 pd, int buffer_size_shift,
 		   u64 iova, u64 total_size, u32 access, struct mthca_mr *mr)
 {
-	void *mailbox;
+	struct mthca_mailbox *mailbox;
 	struct mthca_mpt_entry *mpt_entry;
 	u32 key;
 	int i;
@@ -354,13 +356,12 @@ int mthca_mr_alloc(struct mthca_dev *dev
 			goto err_out_mpt_free;
 	}
 
-	mailbox = kmalloc(sizeof *mpt_entry + MTHCA_CMD_MAILBOX_EXTRA,
-			  GFP_KERNEL);
-	if (!mailbox) {
-		err = -ENOMEM;
+	mailbox = mthca_alloc_mailbox(dev, GFP_KERNEL);
+	if (IS_ERR(mailbox)) {
+		err = PTR_ERR(mailbox);
 		goto err_out_table;
 	}
-	mpt_entry = MAILBOX_ALIGN(mailbox);
+	mpt_entry = mailbox->buf;
 
 	mpt_entry->flags = cpu_to_be32(MTHCA_MPT_FLAG_SW_OWNS     |
 				       MTHCA_MPT_FLAG_MIO         |
@@ -394,7 +395,7 @@ int mthca_mr_alloc(struct mthca_dev *dev
 		}
 	}
 
-	err = mthca_SW2HW_MPT(dev, mpt_entry,
+	err = mthca_SW2HW_MPT(dev, mailbox,
 			      key & (dev->limits.num_mpts - 1),
 			      &status);
 	if (err) {
@@ -407,11 +408,11 @@ int mthca_mr_alloc(struct mthca_dev *dev
 		goto err_out_mailbox;
 	}
 
-	kfree(mailbox);
+	mthca_free_mailbox(dev, mailbox);
 	return err;
 
 err_out_mailbox:
-	kfree(mailbox);
+	mthca_free_mailbox(dev, mailbox);
 
 err_out_table:
 	mthca_table_put(dev, dev->mr_table.mpt_table, key);
@@ -487,7 +488,7 @@ int mthca_fmr_alloc(struct mthca_dev *de
 		    u32 access, struct mthca_fmr *mr)
 {
 	struct mthca_mpt_entry *mpt_entry;
-	void *mailbox;
+	struct mthca_mailbox *mailbox;
 	u64 mtt_seg;
 	u32 key, idx;
 	u8 status;
@@ -538,12 +539,11 @@ int mthca_fmr_alloc(struct mthca_dev *de
 	} else
 		mr->mem.tavor.mtts = dev->mr_table.tavor_fmr.mtt_base + mtt_seg;
 
-	mailbox = kmalloc(sizeof *mpt_entry + MTHCA_CMD_MAILBOX_EXTRA,
-			  GFP_KERNEL);
-	if (!mailbox)
+	mailbox = mthca_alloc_mailbox(dev, GFP_KERNEL);
+	if (IS_ERR(mailbox))
 		goto err_out_free_mtt;
 
-	mpt_entry = MAILBOX_ALIGN(mailbox);
+	mpt_entry = mailbox->buf;
 
 	mpt_entry->flags = cpu_to_be32(MTHCA_MPT_FLAG_SW_OWNS     |
 				       MTHCA_MPT_FLAG_MIO         |
@@ -568,7 +568,7 @@ int mthca_fmr_alloc(struct mthca_dev *de
 		}
 	}
 
-	err = mthca_SW2HW_MPT(dev, mpt_entry,
+	err = mthca_SW2HW_MPT(dev, mailbox,
 			      key & (dev->limits.num_mpts - 1),
 			      &status);
 	if (err) {
@@ -582,11 +582,11 @@ int mthca_fmr_alloc(struct mthca_dev *de
 		goto err_out_mailbox_free;
 	}
 
-	kfree(mailbox);
+	mthca_free_mailbox(dev, mailbox);
 	return 0;
 
 err_out_mailbox_free:
-	kfree(mailbox);
+	mthca_free_mailbox(dev, mailbox);
 
 err_out_free_mtt:
 	mthca_free_mtt(dev, mr->mtt);
--- linux.git.orig/drivers/infiniband/hw/mthca/mthca_qp.c	2005-06-23 13:03:06.792646922 -0700
+++ linux.git/drivers/infiniband/hw/mthca/mthca_qp.c	2005-06-23 13:03:09.280108573 -0700
@@ -589,7 +589,7 @@ int mthca_modify_qp(struct ib_qp *ibqp, 
 	struct mthca_dev *dev = to_mdev(ibqp->device);
 	struct mthca_qp *qp = to_mqp(ibqp);
 	enum ib_qp_state cur_state, new_state;
-	void *mailbox = NULL;
+	struct mthca_mailbox *mailbox;
 	struct mthca_qp_param *qp_param;
 	struct mthca_qp_context *qp_context;
 	u32 req_param, opt_param;
@@ -646,10 +646,10 @@ int mthca_modify_qp(struct ib_qp *ibqp, 
 		return -EINVAL;
 	}
 
-	mailbox = kmalloc(sizeof (*qp_param) + MTHCA_CMD_MAILBOX_EXTRA, GFP_KERNEL);
-	if (!mailbox)
-		return -ENOMEM;
-	qp_param = MAILBOX_ALIGN(mailbox);
+	mailbox = mthca_alloc_mailbox(dev, GFP_KERNEL);
+	if (IS_ERR(mailbox))
+		return PTR_ERR(mailbox);
+	qp_param = mailbox->buf;
 	qp_context = &qp_param->context;
 	memset(qp_param, 0, sizeof *qp_param);
 
@@ -872,7 +872,7 @@ int mthca_modify_qp(struct ib_qp *ibqp, 
 	}
 
 	err = mthca_MODIFY_QP(dev, state_table[cur_state][new_state].trans,
-			      qp->qpn, 0, qp_param, 0, &status);
+			      qp->qpn, 0, mailbox, 0, &status);
 	if (status) {
 		mthca_warn(dev, "modify QP %d returned status %02x.\n",
 			   state_table[cur_state][new_state].trans, status);
@@ -882,7 +882,7 @@ int mthca_modify_qp(struct ib_qp *ibqp, 
 	if (!err)
 		qp->state = new_state;
 
-	kfree(mailbox);
+	mthca_free_mailbox(dev, mailbox);
 
 	if (is_sqp(dev, qp))
 		store_attrs(to_msqp(qp), attr, attr_mask);

