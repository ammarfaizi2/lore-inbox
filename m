Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262636AbVCCXaq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262636AbVCCXaq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 18:30:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262662AbVCCX3g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 18:29:36 -0500
Received: from umhlanga.stratnet.net ([12.162.17.40]:53494 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S262747AbVCCXWe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 18:22:34 -0500
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: [PATCH][25/26] IB/mthca: implement query of device caps
In-Reply-To: <2005331520.i9PPmMDNBr0DxH5I@topspin.com>
X-Mailer: Roland's Patchbomber
Date: Thu, 3 Mar 2005 15:20:28 -0800
Message-Id: <2005331520.mctunM7QrSZHM8mX@topspin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: akpm@osdl.org
Content-Transfer-Encoding: 7BIT
From: Roland Dreier <roland@topspin.com>
X-OriginalArrivalTime: 03 Mar 2005 23:20:28.0613 (UTC) FILETIME=[964A0F50:01C52047]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael S. Tsirkin <mst@mellanox.co.il>

Set device_cap_flags field in mthca's query_device method.

Signed-off-by: Michael S. Tsirkin <mst@mellanox.co.il>
Signed-off-by: Roland Dreier <roland@topspin.com>


--- linux-export.orig/drivers/infiniband/hw/mthca/mthca_cmd.h	2005-01-25 20:48:02.000000000 -0800
+++ linux-export/drivers/infiniband/hw/mthca/mthca_cmd.h	2005-03-03 14:13:03.934043620 -0800
@@ -95,7 +95,21 @@
 };
 
 enum {
-	DEV_LIM_FLAG_SRQ = 1 << 6
+	DEV_LIM_FLAG_RC                 = 1 << 0,
+	DEV_LIM_FLAG_UC                 = 1 << 1,
+	DEV_LIM_FLAG_UD                 = 1 << 2,
+	DEV_LIM_FLAG_RD                 = 1 << 3,
+	DEV_LIM_FLAG_RAW_IPV6           = 1 << 4,
+	DEV_LIM_FLAG_RAW_ETHER          = 1 << 5,
+	DEV_LIM_FLAG_SRQ                = 1 << 6,
+	DEV_LIM_FLAG_BAD_PKEY_CNTR      = 1 << 8,
+	DEV_LIM_FLAG_BAD_QKEY_CNTR      = 1 << 9,
+	DEV_LIM_FLAG_MW                 = 1 << 16,
+	DEV_LIM_FLAG_AUTO_PATH_MIG      = 1 << 17,
+	DEV_LIM_FLAG_ATOMIC             = 1 << 18,
+	DEV_LIM_FLAG_RAW_MULTI          = 1 << 19,
+	DEV_LIM_FLAG_UD_AV_PORT_ENFORCE = 1 << 20,
+	DEV_LIM_FLAG_UD_MULTI           = 1 << 21,
 };
 
 struct mthca_dev_lim {
--- linux-export.orig/drivers/infiniband/hw/mthca/mthca_dev.h	2005-03-03 14:13:03.005245231 -0800
+++ linux-export/drivers/infiniband/hw/mthca/mthca_dev.h	2005-03-03 14:13:03.932044054 -0800
@@ -218,6 +218,7 @@
 
 	int          	 hca_type;
 	unsigned long	 mthca_flags;
+	unsigned long    device_cap_flags;
 
 	u32              rev_id;
 
--- linux-export.orig/drivers/infiniband/hw/mthca/mthca_main.c	2005-03-03 14:13:03.005245231 -0800
+++ linux-export/drivers/infiniband/hw/mthca/mthca_main.c	2005-03-03 14:13:03.933043837 -0800
@@ -171,6 +171,33 @@
 	mdev->limits.reserved_uars      = dev_lim->reserved_uars;
 	mdev->limits.reserved_pds       = dev_lim->reserved_pds;
 
+	/* IB_DEVICE_RESIZE_MAX_WR not supported by driver.
+	   May be doable since hardware supports it for SRQ.
+
+	   IB_DEVICE_N_NOTIFY_CQ is supported by hardware but not by driver.
+
+	   IB_DEVICE_SRQ_RESIZE is supported by hardware but SRQ is not
+	   supported by driver. */
+	mdev->device_cap_flags = IB_DEVICE_CHANGE_PHY_PORT |
+		IB_DEVICE_PORT_ACTIVE_EVENT |
+		IB_DEVICE_SYS_IMAGE_GUID |
+		IB_DEVICE_RC_RNR_NAK_GEN;
+
+	if (dev_lim->flags & DEV_LIM_FLAG_BAD_PKEY_CNTR)
+		mdev->device_cap_flags |= IB_DEVICE_BAD_PKEY_CNTR;
+
+	if (dev_lim->flags & DEV_LIM_FLAG_BAD_QKEY_CNTR)
+		mdev->device_cap_flags |= IB_DEVICE_BAD_QKEY_CNTR;
+				
+	if (dev_lim->flags & DEV_LIM_FLAG_RAW_MULTI)
+		mdev->device_cap_flags |= IB_DEVICE_RAW_MULTI;
+
+	if (dev_lim->flags & DEV_LIM_FLAG_AUTO_PATH_MIG)
+		mdev->device_cap_flags |= IB_DEVICE_AUTO_PATH_MIG;
+
+	if (dev_lim->flags & DEV_LIM_FLAG_UD_AV_PORT_ENFORCE)
+		mdev->device_cap_flags |= IB_DEVICE_UD_AV_PORT_ENFORCE;
+
 	if (dev_lim->flags & DEV_LIM_FLAG_SRQ)
 		mdev->mthca_flags |= MTHCA_FLAG_SRQ;
 
--- linux-export.orig/drivers/infiniband/hw/mthca/mthca_provider.c	2005-03-03 14:13:02.566340502 -0800
+++ linux-export/drivers/infiniband/hw/mthca/mthca_provider.c	2005-03-03 14:13:03.933043837 -0800
@@ -43,6 +43,8 @@
 	struct ib_smp *in_mad  = NULL;
 	struct ib_smp *out_mad = NULL;
 	int err = -ENOMEM;
+	struct mthca_dev* mdev = to_mdev(ibdev);
+
 	u8 status;
 
 	in_mad  = kmalloc(sizeof *in_mad, GFP_KERNEL);
@@ -50,7 +52,7 @@
 	if (!in_mad || !out_mad)
 		goto out;
 
-	props->fw_ver        = to_mdev(ibdev)->fw_ver;
+	props->fw_ver              = mdev->fw_ver;
 
 	memset(in_mad, 0, sizeof *in_mad);
 	in_mad->base_version       = 1;
@@ -59,7 +61,7 @@
 	in_mad->method         	   = IB_MGMT_METHOD_GET;
 	in_mad->attr_id   	   = IB_SMP_ATTR_NODE_INFO;
 
-	err = mthca_MAD_IFC(to_mdev(ibdev), 1, 1,
+	err = mthca_MAD_IFC(mdev, 1, 1,
 			    1, NULL, NULL, in_mad, out_mad,
 			    &status);
 	if (err)
@@ -69,10 +71,11 @@
 		goto out;
 	}
 
-	props->vendor_id      = be32_to_cpup((u32 *) (out_mad->data + 36)) &
+	props->device_cap_flags = mdev->device_cap_flags;
+	props->vendor_id        = be32_to_cpup((u32 *) (out_mad->data + 36)) &
 		0xffffff;
-	props->vendor_part_id = be16_to_cpup((u16 *) (out_mad->data + 30));
-	props->hw_ver         = be16_to_cpup((u16 *) (out_mad->data + 32));
+	props->vendor_part_id   = be16_to_cpup((u16 *) (out_mad->data + 30));
+	props->hw_ver           = be16_to_cpup((u16 *) (out_mad->data + 32));
 	memcpy(&props->sys_image_guid, out_mad->data +  4, 8);
 	memcpy(&props->node_guid,      out_mad->data + 12, 8);
 

