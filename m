Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261462AbVAXGWx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261462AbVAXGWx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 01:22:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261453AbVAXGVe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 01:21:34 -0500
Received: from umhlanga.stratnet.net ([12.162.17.40]:19986 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S261447AbVAXGO2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 01:14:28 -0500
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: [PATCH][6/12] InfiniBand/mthca: pass full process_mad info to firmware
In-Reply-To: <20051232214.2iCZjnfrVaRa2RW5@topspin.com>
X-Mailer: Roland's Patchbomber
Date: Sun, 23 Jan 2005 22:14:23 -0800
Message-Id: <20051232214.2ZjgnbDloKBl5KUG@topspin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: akpm@osdl.org
Content-Transfer-Encoding: 7BIT
From: Roland Dreier <roland@topspin.com>
X-OriginalArrivalTime: 24 Jan 2005 06:14:25.0262 (UTC) FILETIME=[F3F9B0E0:01C501DB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Michael S. Tsirkin" <mst@mellanox.co.il>

Pass full extended MAD information to firmware when a work completion is supplied to 
the MAD_IFC command.  This allows B_Key checking/trap generation.

Signed-off-by: Michael S. Tsirkin <mst@mellanox.co.il>
Signed-off-by: Roland Dreier <roland@topspin.com>

--- linux-bk.orig/drivers/infiniband/hw/mthca/mthca_cmd.h	2005-01-23 20:39:02.039561320 -0800
+++ linux-bk/drivers/infiniband/hw/mthca/mthca_cmd.h	2005-01-23 20:49:34.829362648 -0800
@@ -280,7 +280,8 @@
 		   void *qp_context, u8 *status);
 int mthca_CONF_SPECIAL_QP(struct mthca_dev *dev, int type, u32 qpn,
 			  u8 *status);
-int mthca_MAD_IFC(struct mthca_dev *dev, int ignore_mkey, int port,
+int mthca_MAD_IFC(struct mthca_dev *dev, int ignore_mkey, int ignore_bkey,
+		  int port, struct ib_wc* in_wc, struct ib_grh* in_grh,
 		  void *in_mad, void *response_mad, u8 *status);
 int mthca_READ_MGM(struct mthca_dev *dev, int index, void *mgm,
 		   u8 *status);
--- linux-bk.orig/drivers/infiniband/hw/mthca/mthca_provider.c	2005-01-23 20:39:02.036561776 -0800
+++ linux-bk/drivers/infiniband/hw/mthca/mthca_provider.c	2005-01-23 20:49:34.826363104 -0800
@@ -59,8 +59,8 @@
 	in_mad->method         	   = IB_MGMT_METHOD_GET;
 	in_mad->attr_id   	   = IB_SMP_ATTR_NODE_INFO;
 
-	err = mthca_MAD_IFC(to_mdev(ibdev), 1,
-			    1, in_mad, out_mad,
+	err = mthca_MAD_IFC(to_mdev(ibdev), 1, 1,
+			    1, NULL, NULL, in_mad, out_mad,
 			    &status);
 	if (err)
 		goto out;
@@ -104,8 +104,8 @@
 	in_mad->attr_id   	   = IB_SMP_ATTR_PORT_INFO;
 	in_mad->attr_mod           = cpu_to_be32(port);
 
-	err = mthca_MAD_IFC(to_mdev(ibdev), 1,
-			    port, in_mad, out_mad,
+	err = mthca_MAD_IFC(to_mdev(ibdev), 1, 1,
+			    port, NULL, NULL, in_mad, out_mad,
 			    &status);
 	if (err)
 		goto out;
@@ -189,8 +189,8 @@
 	in_mad->attr_id   	   = IB_SMP_ATTR_PKEY_TABLE;
 	in_mad->attr_mod           = cpu_to_be32(index / 32);
 
-	err = mthca_MAD_IFC(to_mdev(ibdev), 1,
-			    port, in_mad, out_mad,
+	err = mthca_MAD_IFC(to_mdev(ibdev), 1, 1,
+			    port, NULL, NULL, in_mad, out_mad,
 			    &status);
 	if (err)
 		goto out;
@@ -228,8 +228,8 @@
 	in_mad->attr_id   	   = IB_SMP_ATTR_PORT_INFO;
 	in_mad->attr_mod           = cpu_to_be32(port);
 
-	err = mthca_MAD_IFC(to_mdev(ibdev), 1,
-			    port, in_mad, out_mad,
+	err = mthca_MAD_IFC(to_mdev(ibdev), 1, 1,
+			    port, NULL, NULL, in_mad, out_mad,
 			    &status);
 	if (err)
 		goto out;
@@ -248,8 +248,8 @@
 	in_mad->attr_id   	   = IB_SMP_ATTR_GUID_INFO;
 	in_mad->attr_mod           = cpu_to_be32(index / 8);
 
-	err = mthca_MAD_IFC(to_mdev(ibdev), 1,
-			    port, in_mad, out_mad,
+	err = mthca_MAD_IFC(to_mdev(ibdev), 1, 1,
+			    port, NULL, NULL, in_mad, out_mad,
 			    &status);
 	if (err)
 		goto out;
--- linux-bk.orig/drivers/infiniband/hw/mthca/mthca_cmd.c	2005-01-23 20:39:02.038561472 -0800
+++ linux-bk/drivers/infiniband/hw/mthca/mthca_cmd.c	2005-01-23 20:49:34.828362800 -0800
@@ -36,6 +36,7 @@
 #include <linux/pci.h>
 #include <linux/errno.h>
 #include <asm/io.h>
+#include <ib_mad.h>
 
 #include "mthca_dev.h"
 #include "mthca_config_reg.h"
@@ -1626,13 +1627,24 @@
 			 CMD_TIME_CLASS_B, status);
 }
 
-int mthca_MAD_IFC(struct mthca_dev *dev, int ignore_mkey, int port,
-		  void *in_mad, void *response_mad, u8 *status) {
+int mthca_MAD_IFC(struct mthca_dev *dev, int ignore_mkey, int ignore_bkey,
+		  int port, struct ib_wc* in_wc, struct ib_grh* in_grh,
+		  void *in_mad, void *response_mad, u8 *status)
+{
 	void *box;
 	dma_addr_t dma;
 	int err;
+	u32 in_modifier = port;
+	u8 op_modifier = 0;
 
-#define MAD_IFC_BOX_SIZE 512
+#define MAD_IFC_BOX_SIZE      0x400
+#define MAD_IFC_MY_QPN_OFFSET 0x100
+#define MAD_IFC_RQPN_OFFSET   0x104
+#define MAD_IFC_SL_OFFSET     0x108
+#define MAD_IFC_G_PATH_OFFSET 0x109
+#define MAD_IFC_RLID_OFFSET   0x10a
+#define MAD_IFC_PKEY_OFFSET   0x10e
+#define MAD_IFC_GRH_OFFSET    0x140
 
 	box = pci_alloc_consistent(dev->pdev, MAD_IFC_BOX_SIZE, &dma);
 	if (!box)
@@ -1640,11 +1652,46 @@
 
 	memcpy(box, in_mad, 256);
 
-	err = mthca_cmd_box(dev, dma, dma + 256, port, !!ignore_mkey,
+	/*
+	 * Key check traps can't be generated unless we have in_wc to
+	 * tell us where to send the trap.
+	 */
+	if (ignore_mkey || !in_wc)
+		op_modifier |= 0x1;
+	if (ignore_bkey || !in_wc)
+		op_modifier |= 0x2;
+
+	if (in_wc) {
+		u8 val;
+
+		memset(box + 256, 0, 256);
+
+		MTHCA_PUT(box, in_wc->qp_num, 	  MAD_IFC_MY_QPN_OFFSET);
+		MTHCA_PUT(box, in_wc->src_qp, 	  MAD_IFC_RQPN_OFFSET);
+
+		val = in_wc->sl << 4;
+		MTHCA_PUT(box, val,               MAD_IFC_SL_OFFSET);
+
+		val = in_wc->dlid_path_bits |
+			(in_wc->wc_flags & IB_WC_GRH ? 0x80 : 0);
+		MTHCA_PUT(box, val,               MAD_IFC_GRH_OFFSET);
+
+		MTHCA_PUT(box, in_wc->slid,       MAD_IFC_RLID_OFFSET);
+		MTHCA_PUT(box, in_wc->pkey_index, MAD_IFC_PKEY_OFFSET);
+
+		if (in_grh)
+			memcpy((u8 *) box + MAD_IFC_GRH_OFFSET, in_grh, 40);
+
+		op_modifier |= 0x10;
+
+		in_modifier |= in_wc->slid << 16;
+	}
+
+	err = mthca_cmd_box(dev, dma, dma + 512, in_modifier, op_modifier,
 			    CMD_MAD_IFC, CMD_TIME_CLASS_C, status);
 
 	if (!err && !*status)
-		memcpy(response_mad, box + 256, 256);
+		memcpy(response_mad, box + 512, 256);
 
 	pci_free_consistent(dev->pdev, MAD_IFC_BOX_SIZE, box, dma);
 	return err;
--- linux-bk.orig/drivers/infiniband/hw/mthca/mthca_mad.c	2005-01-23 08:31:45.000000000 -0800
+++ linux-bk/drivers/infiniband/hw/mthca/mthca_mad.c	2005-01-23 20:49:34.827362952 -0800
@@ -232,8 +232,9 @@
 		return IB_MAD_RESULT_SUCCESS;
 
 	err = mthca_MAD_IFC(to_mdev(ibdev),
-			    !!(mad_flags & IB_MAD_IGNORE_MKEY),
-			    port_num, in_mad, out_mad,
+			    mad_flags & IB_MAD_IGNORE_MKEY,
+			    mad_flags & IB_MAD_IGNORE_BKEY,
+			    port_num, in_wc, in_grh, in_mad, out_mad,
 			    &status);
 	if (err) {
 		mthca_err(to_mdev(ibdev), "MAD_IFC failed\n");

