Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261457AbVAXGWt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261457AbVAXGWt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 01:22:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261464AbVAXGUt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 01:20:49 -0500
Received: from umhlanga.stratnet.net ([12.162.17.40]:19986 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S261453AbVAXGO2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 01:14:28 -0500
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: [PATCH][3/12] InfiniBand/mthca: implement modifying port attributes
In-Reply-To: <20051232214.G5RSVEyRyy7IWtkk@topspin.com>
X-Mailer: Roland's Patchbomber
Date: Sun, 23 Jan 2005 22:14:23 -0800
Message-Id: <20051232214.v4gD7pRb7UQo64yW@topspin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: akpm@osdl.org
Content-Transfer-Encoding: 7BIT
From: Roland Dreier <roland@topspin.com>
X-OriginalArrivalTime: 24 Jan 2005 06:14:25.0059 (UTC) FILETIME=[F3DAB730:01C501DB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Implement the port_modify() device method for mthca using the SET_IB
firmware command.  In particular this allows changing the port
capability mask.

Signed-off-by: Roland Dreier <roland@topspin.com>

--- linux-bk.orig/drivers/infiniband/hw/mthca/mthca_cmd.h	2005-01-23 20:38:50.944248064 -0800
+++ linux-bk/drivers/infiniband/hw/mthca/mthca_cmd.h	2005-01-23 20:39:02.039561320 -0800
@@ -215,6 +215,13 @@
 	u64 si_guid;
 };
 
+struct mthca_set_ib_param {
+	int set_si_guid;
+	int reset_qkey_viol;
+	u64 si_guid;
+	u32 cap_mask;
+};
+
 int mthca_cmd_use_events(struct mthca_dev *dev);
 void mthca_cmd_use_polling(struct mthca_dev *dev);
 void mthca_cmd_event(struct mthca_dev *dev, u16 token,
@@ -241,6 +248,8 @@
 		  int port, u8 *status);
 int mthca_CLOSE_IB(struct mthca_dev *dev, int port, u8 *status);
 int mthca_CLOSE_HCA(struct mthca_dev *dev, int panic, u8 *status);
+int mthca_SET_IB(struct mthca_dev *dev, struct mthca_set_ib_param *param,
+		 int port, u8 *status);
 int mthca_MAP_ICM(struct mthca_dev *dev, struct mthca_icm *icm, u64 virt, u8 *status);
 int mthca_MAP_ICM_page(struct mthca_dev *dev, u64 dma_addr, u64 virt, u8 *status);
 int mthca_UNMAP_ICM(struct mthca_dev *dev, u64 virt, u32 page_count, u8 *status);
--- linux-bk.orig/drivers/infiniband/hw/mthca/mthca_provider.c	2005-01-23 20:38:25.991041528 -0800
+++ linux-bk/drivers/infiniband/hw/mthca/mthca_provider.c	2005-01-23 20:39:02.036561776 -0800
@@ -137,7 +137,35 @@
 			     u8 port, int port_modify_mask,
 			     struct ib_port_modify *props)
 {
-	return 0;
+	struct mthca_set_ib_param set_ib;
+	struct ib_port_attr attr;
+	int err;
+	u8 status;
+
+	if (down_interruptible(&to_mdev(ibdev)->cap_mask_mutex))
+		return -ERESTARTSYS;
+
+	err = mthca_query_port(ibdev, port, &attr);
+	if (err)
+		goto out;
+
+	set_ib.set_si_guid     = 0;
+	set_ib.reset_qkey_viol = !!(port_modify_mask & IB_PORT_RESET_QKEY_CNTR);
+
+	set_ib.cap_mask = (attr.port_cap_flags | props->set_port_cap_mask) &
+		~props->clr_port_cap_mask;
+
+	err = mthca_SET_IB(to_mdev(ibdev), &set_ib, port, &status);
+	if (err)
+		goto out;
+	if (status) {
+		err = -EINVAL;
+		goto out;
+	}
+
+out:
+	up(&to_mdev(ibdev)->cap_mask_mutex);
+	return err;
 }
 
 static int mthca_query_pkey(struct ib_device *ibdev,
@@ -619,6 +647,8 @@
 		}
 	}
 
+	init_MUTEX(&dev->cap_mask_mutex);
+
 	return 0;
 }
 
--- linux-bk.orig/drivers/infiniband/hw/mthca/mthca_cmd.c	2005-01-23 20:38:50.949247304 -0800
+++ linux-bk/drivers/infiniband/hw/mthca/mthca_cmd.c	2005-01-23 20:39:02.038561472 -0800
@@ -1238,6 +1238,41 @@
 	return mthca_cmd(dev, 0, 0, panic, CMD_CLOSE_HCA, HZ, status);
 }
 
+int mthca_SET_IB(struct mthca_dev *dev, struct mthca_set_ib_param *param,
+		 int port, u8 *status)
+{
+	u32 *inbox;
+	dma_addr_t indma;
+	int err;
+	u32 flags = 0;
+
+#define SET_IB_IN_SIZE         0x40
+#define SET_IB_FLAGS_OFFSET    0x00
+#define SET_IB_FLAG_SIG        (1 << 18)
+#define SET_IB_FLAG_RQK        (1 <<  0)
+#define SET_IB_CAP_MASK_OFFSET 0x04
+#define SET_IB_SI_GUID_OFFSET  0x08
+
+	inbox = pci_alloc_consistent(dev->pdev, SET_IB_IN_SIZE, &indma);
+	if (!inbox)
+		return -ENOMEM;
+
+	memset(inbox, 0, SET_IB_IN_SIZE);
+
+	flags |= param->set_si_guid     ? SET_IB_FLAG_SIG : 0;
+	flags |= param->reset_qkey_viol ? SET_IB_FLAG_RQK : 0;
+	MTHCA_PUT(inbox, flags, SET_IB_FLAGS_OFFSET);
+
+	MTHCA_PUT(inbox, param->cap_mask, SET_IB_CAP_MASK_OFFSET);
+	MTHCA_PUT(inbox, param->si_guid,  SET_IB_SI_GUID_OFFSET);
+
+	err = mthca_cmd(dev, indma, port, 0, CMD_SET_IB,
+			CMD_TIME_CLASS_B, status);
+
+	pci_free_consistent(dev->pdev, INIT_HCA_IN_SIZE, inbox, indma);
+	return err;
+}
+
 int mthca_MAP_ICM(struct mthca_dev *dev, struct mthca_icm *icm, u64 virt, u8 *status)
 {
 	return mthca_map_cmd(dev, CMD_MAP_ICM, icm, virt, status);
--- linux-bk.orig/drivers/infiniband/hw/mthca/mthca_dev.h	2005-01-23 20:38:50.950247152 -0800
+++ linux-bk/drivers/infiniband/hw/mthca/mthca_dev.h	2005-01-23 20:39:02.036561776 -0800
@@ -234,6 +234,7 @@
 	u64              ddr_end;
 
 	MTHCA_DECLARE_DOORBELL_LOCK(doorbell_lock)
+	struct semaphore cap_mask_mutex;
 
 	void __iomem    *hcr;
 	void __iomem    *clr_base;

