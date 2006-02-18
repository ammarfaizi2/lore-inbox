Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751846AbWBRA7j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751846AbWBRA7j (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 19:59:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751818AbWBRA6n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 19:58:43 -0500
Received: from sj-iport-1-in.cisco.com ([171.71.176.70]:61498 "EHLO
	sj-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S1751826AbWBRA5t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 19:57:49 -0500
From: Roland Dreier <rolandd@cisco.com>
Subject: [PATCH 13/22] HCA query functions
Date: Fri, 17 Feb 2006 16:57:41 -0800
To: linux-kernel@vger.kernel.org, linuxppc64-dev@ozlabs.org,
       openib-general@openib.org
Cc: SCHICKHJ@de.ibm.com, RAISCH@de.ibm.com, HNGUYEN@de.ibm.com,
       MEDER@de.ibm.com
Message-Id: <20060218005741.13620.93906.stgit@localhost.localdomain>
In-Reply-To: <20060218005532.13620.79663.stgit@localhost.localdomain>
References: <20060218005532.13620.79663.stgit@localhost.localdomain>
X-OriginalArrivalTime: 18 Feb 2006 00:57:41.0727 (UTC) FILETIME=[5216DEF0:01C63426]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Roland Dreier <rolandd@cisco.com>


---

 drivers/infiniband/hw/ehca/ehca_hca.c |  321 +++++++++++++++++++++++++++++++++
 1 files changed, 321 insertions(+), 0 deletions(-)

diff --git a/drivers/infiniband/hw/ehca/ehca_hca.c b/drivers/infiniband/hw/ehca/ehca_hca.c
new file mode 100644
index 0000000..af05a5c
--- /dev/null
+++ b/drivers/infiniband/hw/ehca/ehca_hca.c
@@ -0,0 +1,321 @@
+/*
+ *  IBM eServer eHCA Infiniband device driver for Linux on POWER
+ *
+ *  HCA query functions
+ *
+ *  Authors: Heiko J Schick <schickhj@de.ibm.com>
+ *
+ *  Copyright (c) 2005 IBM Corporation
+ *
+ *  All rights reserved.
+ *
+ *  This source code is distributed under a dual license of GPL v2.0 and OpenIB
+ *  BSD.
+ *
+ * OpenIB BSD License
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions are met:
+ *
+ * Redistributions of source code must retain the above copyright notice, this
+ * list of conditions and the following disclaimer.
+ *
+ * Redistributions in binary form must reproduce the above copyright notice,
+ * this list of conditions and the following disclaimer in the documentation
+ * and/or other materials
+ * provided with the distribution.
+ *
+ * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
+ * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
+ * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
+ * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE
+ * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
+ * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
+ * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
+ * BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER
+ * IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
+ * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
+ * POSSIBILITY OF SUCH DAMAGE.
+ *
+ *  $Id: ehca_hca.c,v 1.46 2006/02/06 10:17:34 schickhj Exp $
+ */
+
+#undef DEB_PREFIX
+#define DEB_PREFIX "shca"
+
+#include "ehca_kernel.h"
+#include "ehca_tools.h"
+
+#include "hcp_if.h"		/* TODO: later via hipz_* header file */
+
+#define TO_MAX_INT(dest, src)			\
+	if (src >= INT_MAX)			\
+		dest = INT_MAX;			\
+	else					\
+		dest = src
+
+int ehca_query_device(struct ib_device *ibdev, struct ib_device_attr *props)
+{
+	int ret = 0;
+	struct ehca_shca *shca;
+	struct query_hca_rblock *rblock;
+
+	EDEB_EN(7, "");
+	EHCA_CHECK_DEVICE(ibdev);
+
+	memset(props, 0, sizeof(struct ib_device_attr));
+	shca = container_of(ibdev, struct ehca_shca, ib_device);
+
+	rblock = kmalloc(PAGE_SIZE, GFP_KERNEL);
+	if (rblock == NULL) {
+		EDEB_ERR(4, "Can't allocate rblock memory.");
+		ret = -ENOMEM;
+		goto query_device0;
+	}
+
+	memset(rblock, 0, PAGE_SIZE);
+
+	if (hipz_h_query_hca(shca->ipz_hca_handle, rblock) != H_Success) {
+		EDEB_ERR(4, "Can't query device properties");
+		ret = -EINVAL;
+		goto query_device1;
+	}
+	props->fw_ver              = rblock->hw_ver;
+	/* TODO: memcpy(&props->sys_image_guid, ...); */
+	props->max_mr_size         = rblock->max_mr_size;
+	/* TODO: props->page_size_cap        */
+	props->vendor_id           = rblock->vendor_id >> 8;
+	props->vendor_part_id      = rblock->vendor_part_id >> 16;
+	props->hw_ver              = rblock->hw_ver;
+	TO_MAX_INT(props->max_qp, (rblock->max_qp - rblock->cur_qp));
+	/* TODO: props->max_qp_wr  =         */
+	/* TODO: props->device_cap_flags     */
+	props->max_sge             = rblock->max_sge;
+	props->max_sge_rd          = rblock->max_sge_rd;
+	TO_MAX_INT(props->max_qp, (rblock->max_cq - rblock->cur_cq));
+	props->max_cqe             = rblock->max_cqe;
+	TO_MAX_INT(props->max_mr, (rblock->max_cq - rblock->cur_mr));
+	TO_MAX_INT(props->max_pd, rblock->max_pd);
+	/* TODO: props->max_qp_rd_atom       */
+	/* TODO: props->max_qp_init_rd_atom  */
+	/* TODO: props->atomic_cap           */
+	/* TODO: props->max_ee               */
+	/* TODO: props->max_rdd              */
+	props->max_mw              = rblock->max_mw;
+	TO_MAX_INT(props->max_mr, (rblock->max_mw - rblock->cur_mw));
+	props->max_raw_ipv6_qp     = rblock->max_raw_ipv6_qp;
+	props->max_raw_ethy_qp     = rblock->max_raw_ethy_qp;
+	props->max_mcast_grp       = rblock->max_mcast_grp;
+	props->max_mcast_qp_attach = rblock->max_qps_attached_mcast_grp;
+	props->max_total_mcast_qp_attach = rblock->max_qps_attached_all_mcast_grp;
+
+	TO_MAX_INT(props->max_ah, rblock->max_ah);
+
+	props->max_fmr             = rblock->max_mr;
+	/* TODO: props->max_map_per_fmr      */
+
+	/* TODO: props->max_srq              */
+	/* TODO: props->max_srq_wr           */
+	/* TODO: props->max_srq_sge          */
+	props->max_srq             = 0;
+	props->max_srq_wr          = 0;
+	props->max_srq_sge         = 0;
+
+	/* TODO: props->max_pkeys            */
+	props->max_pkeys           = 16;
+
+	props->local_ca_ack_delay  = rblock->local_ca_ack_delay;
+
+      query_device1:
+	kfree(rblock);
+
+      query_device0:
+	EDEB_EX(7, "ret=%x", ret);
+
+	return ret;
+}
+
+int ehca_query_port(struct ib_device *ibdev,
+		    u8 port, struct ib_port_attr *props)
+{
+	int ret = 0;
+	struct ehca_shca *shca;
+	struct query_port_rblock *rblock;
+
+	EDEB_EN(7, "port=%x", port);
+	EHCA_CHECK_DEVICE(ibdev);
+
+	memset(props, 0, sizeof(struct ib_port_attr));
+	shca = container_of(ibdev, struct ehca_shca, ib_device);
+
+	rblock = kmalloc(PAGE_SIZE, GFP_KERNEL);
+	if (rblock == NULL) {
+		EDEB_ERR(4, "Can't allocate rblock memory.");
+		ret = -ENOMEM;
+		goto query_port0;
+	}
+
+	memset(rblock, 0, PAGE_SIZE);
+
+	if (hipz_h_query_port(shca->ipz_hca_handle, port, rblock) != H_Success) {
+		EDEB_ERR(4, "Can't query port properties");
+		ret = -EINVAL;
+		goto query_port1;
+	}
+
+	props->state = rblock->state;
+
+	switch (rblock->max_mtu) {
+	case 0x1:
+		props->active_mtu = props->max_mtu = IB_MTU_256;
+		break;
+	case 0x2:
+		props->active_mtu = props->max_mtu = IB_MTU_512;
+		break;
+	case 0x3:
+		props->active_mtu = props->max_mtu = IB_MTU_1024;
+		break;
+	case 0x4:
+		props->active_mtu = props->max_mtu = IB_MTU_2048;
+		break;
+	case 0x5:
+		props->active_mtu = props->max_mtu = IB_MTU_4096;
+		break;
+	default:
+		EDEB_ERR(4, "Unknown MTU size: %x.", rblock->max_mtu);
+	}
+
+	props->gid_tbl_len     = rblock->gid_tbl_len;
+	/* TODO: props->port_cap_flags */
+	props->max_msg_sz      = rblock->max_msg_sz;
+	props->bad_pkey_cntr   = rblock->bad_pkey_cntr;
+	props->qkey_viol_cntr  = rblock->qkey_viol_cntr;
+	props->pkey_tbl_len    = rblock->pkey_tbl_len;
+	props->lid             = rblock->lid;
+	props->sm_lid          = rblock->sm_lid;
+	props->lmc             = rblock->lmc;
+	/* TODO: max_vl_num            */
+	props->sm_sl           = rblock->sm_sl;
+	props->subnet_timeout  = rblock->subnet_timeout;
+	props->init_type_reply = rblock->init_type_reply;
+
+	/* TODO: props->active_width   */
+	props->active_width    = IB_WIDTH_12X;
+	/* TODO: props->active_speed   */
+
+	/* TODO: props->phys_state     */
+
+      query_port1:
+	kfree(rblock);
+
+      query_port0:
+	EDEB_EX(7, "ret=%x", ret);
+
+	return ret;
+}
+
+int ehca_query_pkey(struct ib_device *ibdev, u8 port, u16 index, u16 *pkey)
+{
+	int ret = 0;
+	struct ehca_shca *shca;
+	struct query_port_rblock *rblock;
+
+	EDEB_EN(7, "port=%x index=%x", port, index);
+	EHCA_CHECK_DEVICE(ibdev);
+
+	if (index > 16) {
+		EDEB_ERR(4, "Invalid index: %x.", index);
+		ret = -EINVAL;
+		goto query_pkey0;
+	}
+
+	shca = container_of(ibdev, struct ehca_shca, ib_device);
+
+	rblock = kmalloc(PAGE_SIZE, GFP_KERNEL);
+	if (rblock == NULL) {
+		EDEB_ERR(4,  "Can't allocate rblock memory.");
+		ret = -ENOMEM;
+		goto query_pkey0;
+	}
+
+	memset(rblock, 0, PAGE_SIZE);
+
+	if (hipz_h_query_port(shca->ipz_hca_handle, port, rblock) != H_Success) {
+		EDEB_ERR(4, "Can't query port properties");
+		ret = -EINVAL;
+		goto query_pkey1;
+	}
+
+	memcpy(pkey, &rblock->pkey_entries + index, sizeof(u16));
+
+      query_pkey1:
+	kfree(rblock);
+
+      query_pkey0:
+	EDEB_EX(7, "ret=%x", ret);
+
+	return ret;
+}
+
+int ehca_query_gid(struct ib_device *ibdev, u8 port,
+		   int index, union ib_gid *gid)
+{
+	int ret = 0;
+	struct ehca_shca *shca;
+	struct query_port_rblock *rblock;
+
+	EDEB_EN(7, "port=%x index=%x", port, index);
+	EHCA_CHECK_DEVICE(ibdev);
+
+	if (index > 255) {
+		EDEB_ERR(4, "Invalid index: %x.", index);
+		ret = -EINVAL;
+		goto query_gid0;
+	}
+
+	shca = container_of(ibdev, struct ehca_shca, ib_device);
+
+	rblock = kmalloc(PAGE_SIZE, GFP_KERNEL);
+	if (rblock == NULL) {
+		EDEB_ERR(4, "Can't allocate rblock memory.");
+		ret = -ENOMEM;
+		goto query_gid0;
+	}
+
+	memset(rblock, 0, PAGE_SIZE);
+
+	if (hipz_h_query_port(shca->ipz_hca_handle, port, rblock) != H_Success) {
+		EDEB_ERR(4, "Can't query port properties");
+		ret = -EINVAL;
+		goto query_gid1;
+	}
+
+	memcpy(&gid->raw[0], &rblock->gid_prefix, sizeof(u64));
+	memcpy(&gid->raw[8], &rblock->guid_entries[index], sizeof(u64));
+
+      query_gid1:
+	kfree(rblock);
+
+      query_gid0:
+	EDEB_EX(7, "ret=%x GID=%lx%lx", ret,
+		*(u64 *) & gid->raw[0],
+		*(u64 *) & gid->raw[8]);
+
+	return ret;
+}
+
+int ehca_modify_port(struct ib_device *ibdev,
+		     u8 port, int port_modify_mask,
+		     struct ib_port_modify *props)
+{
+	int ret = 0;
+
+	EDEB_EN(7, "port=%x", port);
+	EHCA_CHECK_DEVICE(ibdev);
+
+	/* TODO: implementation */
+
+	EDEB_EX(7, "ret=%x", ret);
+
+	return ret;
+}
