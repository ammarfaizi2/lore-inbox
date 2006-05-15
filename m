Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965001AbWEORqH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965001AbWEORqH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 13:46:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751651AbWEORll
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 13:41:41 -0400
Received: from mtagate3.de.ibm.com ([195.212.29.152]:63293 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751639AbWEORlO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 13:41:14 -0400
Message-ID: <4468BD52.8080506@de.ibm.com>
Date: Mon, 15 May 2006 19:41:38 +0200
From: Heiko J Schick <schihei@de.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.6 (Windows/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: openib-general@openib.org, Christoph Raisch <RAISCH@de.ibm.com>,
       Hoang-Nam Nguyen <HNGUYEN@de.ibm.com>, Marcus Eder <MEDER@de.ibm.com>,
       schihei@de.ibm.com, linux-kernel@vger.kernel.org,
       linuxppc-dev@ozlabs.org
Subject: [PATCH 04/16] ehca: InfiniBand query and multicast functionality
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Heiko J Schick <schickhj@de.ibm.com>


  drivers/infiniband/hw/ehca/ehca_hca.c   |  282 ++++++++++++++++++++++++++++++++
  drivers/infiniband/hw/ehca/ehca_mcast.c |  194 ++++++++++++++++++++++
  2 files changed, 476 insertions(+)



--- linux-2.6.17-rc2-orig/drivers/infiniband/hw/ehca/ehca_hca.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.17-rc2/drivers/infiniband/hw/ehca/ehca_hca.c	2006-05-02 10:55:26.000000000 +0200
@@ -0,0 +1,282 @@
+/*
+ *  IBM eServer eHCA Infiniband device driver for Linux on POWER
+ *
+ *  HCA query functions
+ *
+ *  Authors: Heiko J Schick <schickhj@de.ibm.com>
+ *           Christoph Raisch <raisch@de.ibm.com>
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
+ */
+
+#undef DEB_PREFIX
+#define DEB_PREFIX "shca"
+
+#include "ehca_tools.h"
+
+#include "hcp_if.h"
+
+int ehca_query_device(struct ib_device *ibdev, struct ib_device_attr *props)
+{
+	int ret = 0;
+	struct ehca_shca *shca;
+	struct hipz_query_hca *rblock;
+
+	EDEB_EN(7, "");
+
+	memset(props, 0, sizeof(struct ib_device_attr));
+	shca = container_of(ibdev, struct ehca_shca, ib_device);
+
+	rblock = kzalloc(H_CB_ALIGNMENT, GFP_KERNEL);
+	if (!rblock) {
+		EDEB_ERR(4, "Can't allocate rblock memory.");
+		ret = -ENOMEM;
+		goto query_device0;
+	}
+
+	if (hipz_h_query_hca(shca->ipz_hca_handle, rblock) != H_SUCCESS) {
+		EDEB_ERR(4, "Can't query device properties");
+		ret = -EINVAL;
+		goto query_device1;
+	}
+	props->fw_ver          = rblock->hw_ver;
+	props->max_mr_size     = rblock->max_mr_size;
+	props->vendor_id       = rblock->vendor_id >> 8;
+	props->vendor_part_id  = rblock->vendor_part_id >> 16;
+	props->hw_ver          = rblock->hw_ver;
+	props->max_qp          = min_t(int, rblock->max_qp, INT_MAX);
+	props->max_qp_wr       = min_t(int, rblock->max_wqes_wq, INT_MAX);
+	props->max_sge         = min_t(int, rblock->max_sge, INT_MAX);
+	props->max_sge_rd      = min_t(int, rblock->max_sge_rd, INT_MAX);
+	props->max_cq          = min_t(int, rblock->max_cq, INT_MAX);
+	props->max_cqe         = min_t(int, rblock->max_cqe, INT_MAX);
+	props->max_mr          = min_t(int, rblock->max_mr, INT_MAX);
+	props->max_mw          = min_t(int, rblock->max_mw, INT_MAX);
+	props->max_pd          = min_t(int, rblock->max_pd, INT_MAX);
+	props->max_ah          = min_t(int, rblock->max_ah, INT_MAX);
+	props->max_fmr         = min_t(int, rblock->max_mr, INT_MAX);
+	props->max_srq         = 0;
+	props->max_srq_wr      = 0;
+	props->max_srq_sge     = 0;
+	props->max_pkeys       = 16;
+	props->local_ca_ack_delay
+		= rblock->local_ca_ack_delay;
+	props->max_raw_ipv6_qp
+		= min_t(int, rblock->max_raw_ipv6_qp, INT_MAX);
+	props->max_raw_ethy_qp
+		= min_t(int, rblock->max_raw_ethy_qp, INT_MAX);
+	props->max_mcast_grp
+		= min_t(int, rblock->max_mcast_grp, INT_MAX);
+	props->max_mcast_qp_attach
+		= min_t(int, rblock->max_mcast_qp_attach, INT_MAX);
+	props->max_total_mcast_qp_attach
+		= min_t(int, rblock->max_total_mcast_qp_attach, INT_MAX);
+
+query_device1:
+	kfree(rblock);
+
+query_device0:
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
+	struct hipz_query_port *rblock;
+
+	EDEB_EN(7, "port=%x", port);
+
+	memset(props, 0, sizeof(struct ib_port_attr));
+	shca = container_of(ibdev, struct ehca_shca, ib_device);
+
+	rblock = kzalloc(H_CB_ALIGNMENT, GFP_KERNEL);
+	if (!rblock) {
+		EDEB_ERR(4, "Can't allocate rblock memory.");
+		ret = -ENOMEM;
+		goto query_port0;
+	}
+
+	if (hipz_h_query_port(shca->ipz_hca_handle, port, rblock) != H_SUCCESS) {
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
+	props->max_msg_sz      = rblock->max_msg_sz;
+	props->bad_pkey_cntr   = rblock->bad_pkey_cntr;
+	props->qkey_viol_cntr  = rblock->qkey_viol_cntr;
+	props->pkey_tbl_len    = rblock->pkey_tbl_len;
+	props->lid             = rblock->lid;
+	props->sm_lid          = rblock->sm_lid;
+	props->lmc             = rblock->lmc;
+	props->sm_sl           = rblock->sm_sl;
+	props->subnet_timeout  = rblock->subnet_timeout;
+	props->init_type_reply = rblock->init_type_reply;
+
+	props->active_width    = IB_WIDTH_12X;
+	props->active_speed    = 0x1;
+
+query_port1:
+	kfree(rblock);
+
+query_port0:
+	EDEB_EX(7, "ret=%x", ret);
+
+	return ret;
+}
+
+int ehca_query_pkey(struct ib_device *ibdev, u8 port, u16 index, u16 *pkey)
+{
+	int ret = 0;
+	struct ehca_shca *shca;
+	struct hipz_query_port *rblock;
+
+	EDEB_EN(7, "port=%x index=%x", port, index);
+
+	if (index > 16) {
+		EDEB_ERR(4, "Invalid index: %x.", index);
+		ret = -EINVAL;
+		goto query_pkey0;
+	}
+
+	shca = container_of(ibdev, struct ehca_shca, ib_device);
+
+	rblock = kzalloc(H_CB_ALIGNMENT, GFP_KERNEL);
+	if (!rblock) {
+		EDEB_ERR(4,  "Can't allocate rblock memory.");
+		ret = -ENOMEM;
+		goto query_pkey0;
+	}
+
+	if (hipz_h_query_port(shca->ipz_hca_handle, port, rblock) != H_SUCCESS) {
+		EDEB_ERR(4, "Can't query port properties");
+		ret = -EINVAL;
+		goto query_pkey1;
+	}
+
+	memcpy(pkey, &rblock->pkey_entries + index, sizeof(u16));
+
+query_pkey1:
+	kfree(rblock);
+
+query_pkey0:
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
+	struct hipz_query_port *rblock;
+
+	EDEB_EN(7, "port=%x index=%x", port, index);
+
+	if (index > 255) {
+		EDEB_ERR(4, "Invalid index: %x.", index);
+		ret = -EINVAL;
+		goto query_gid0;
+	}
+
+	shca = container_of(ibdev, struct ehca_shca, ib_device);
+
+	rblock = kzalloc(H_CB_ALIGNMENT, GFP_KERNEL);
+	if (!rblock) {
+		EDEB_ERR(4, "Can't allocate rblock memory.");
+		ret = -ENOMEM;
+		goto query_gid0;
+	}
+
+	if (hipz_h_query_port(shca->ipz_hca_handle, port, rblock) != H_SUCCESS) {
+		EDEB_ERR(4, "Can't query port properties");
+		ret = -EINVAL;
+		goto query_gid1;
+	}
+
+	memcpy(&gid->raw[0], &rblock->gid_prefix, sizeof(u64));
+	memcpy(&gid->raw[8], &rblock->guid_entries[index], sizeof(u64));
+
+query_gid1:
+	kfree(rblock);
+
+query_gid0:
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
+
+	/* Not implemented yet. */
+
+	EDEB_EX(7, "ret=%x", ret);
+
+	return ret;
+}
--- linux-2.6.17-rc2-orig/drivers/infiniband/hw/ehca/ehca_mcast.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.17-rc2/drivers/infiniband/hw/ehca/ehca_mcast.c	2006-05-15 09:54:24.000000000 +0200
@@ -0,0 +1,194 @@
+/*
+ *  IBM eServer eHCA Infiniband device driver for Linux on POWER
+ *
+ *  mcast  functions
+ *
+ *  Authors: Khadija Souissi <souissik@de.ibm.com>
+ *           Waleri Fomin <fomin@de.ibm.com>
+ *           Reinhard Ernst <rernst@de.ibm.com>
+ *           Hoang-Nam Nguyen <hnguyen@de.ibm.com>
+ *           Heiko J Schick <schickhj@de.ibm.com>
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
+ */
+
+#define DEB_PREFIX "mcas"
+
+#include <linux/module.h>
+#include <linux/err.h>
+#include "ehca_classes.h"
+#include "ehca_tools.h"
+#include "ehca_qes.h"
+#include "ehca_iverbs.h"
+
+#include "hcp_if.h"
+
+#define MAX_MC_LID 0xFFFE
+#define MIN_MC_LID 0xC000	/* Multicast limits */
+#define EHCA_VALID_MULTICAST_GID(gid)  ((gid)[0] == 0xFF)
+#define EHCA_VALID_MULTICAST_LID(lid)  (((lid) >= MIN_MC_LID) && ((lid) <= MAX_MC_LID))
+
+int ehca_attach_mcast(struct ib_qp *ibqp, union ib_gid *gid, u16 lid)
+{
+	struct ehca_qp *my_qp = NULL;
+	struct ehca_shca *shca = NULL;
+	union ib_gid my_gid;
+	u64 h_ret = H_SUCCESS;
+	int ret = 0;
+
+	EHCA_CHECK_ADR(ibqp);
+	EHCA_CHECK_ADR(gid);
+
+	my_qp = container_of(ibqp, struct ehca_qp, ib_qp);
+
+	EHCA_CHECK_QP(my_qp);
+	if (ibqp->qp_type != IB_QPT_UD) {
+		EDEB_ERR(4, "invalid qp_type %x gid, ret=%x",
+			 ibqp->qp_type, EINVAL);
+		return -EINVAL;
+	}
+
+	shca = container_of(ibqp->pd->device, struct ehca_shca, ib_device);
+	EHCA_CHECK_ADR(shca);
+
+	if (!(EHCA_VALID_MULTICAST_GID(gid->raw))) {
+		EDEB_ERR(4, "gid is not valid mulitcast gid ret=%x",
+			 EINVAL);
+		return -EINVAL;
+	} else if ((lid < MIN_MC_LID) || (lid > MAX_MC_LID)) {
+		EDEB_ERR(4, "lid=%x is not valid mulitcast lid ret=%x",
+			 lid, EINVAL);
+		return -EINVAL;
+	}
+
+	memcpy(&my_gid.raw, gid->raw, sizeof(union ib_gid));
+
+	h_ret = hipz_h_attach_mcqp(shca->ipz_hca_handle,
+				     my_qp->ipz_qp_handle,
+				     my_qp->galpas.kernel,
+				     lid, my_gid.global.subnet_prefix,
+				     my_gid.global.interface_id);
+	if (h_ret != H_SUCCESS) {
+		EDEB_ERR(4,
+			 "ehca_qp=%p qp_num=%x hipz_h_attach_mcqp() failed "
+			 "h_ret=%lx", my_qp, ibqp->qp_num, h_ret);
+	}
+	ret = ehca2ib_return_code(h_ret);
+
+	EDEB_EX(7, "mcast attach ret=%x\n"
+		   "ehca_qp=%p qp_num=%x  lid=%x\n"
+		   "my_gid=  %x %x %x %x\n"
+		   "         %x %x %x %x\n"
+		   "         %x %x %x %x\n"
+		   "         %x %x %x %x\n",
+		   ret, my_qp, ibqp->qp_num, lid,
+		   my_gid.raw[0], my_gid.raw[1],
+		   my_gid.raw[2], my_gid.raw[3],
+		   my_gid.raw[4], my_gid.raw[5],
+		   my_gid.raw[6], my_gid.raw[7],
+		   my_gid.raw[8], my_gid.raw[9],
+		   my_gid.raw[10], my_gid.raw[11],
+		   my_gid.raw[12], my_gid.raw[13],
+		   my_gid.raw[14], my_gid.raw[15]);
+
+	return ret;
+}
+
+int ehca_detach_mcast(struct ib_qp *ibqp, union ib_gid *gid, u16 lid)
+{
+	struct ehca_qp *my_qp = NULL;
+	struct ehca_shca *shca = NULL;
+	union ib_gid my_gid;
+	u64 h_ret = H_SUCCESS;
+	int ret = 0;
+
+	EHCA_CHECK_ADR(ibqp);
+	EHCA_CHECK_ADR(gid);
+
+	my_qp = container_of(ibqp, struct ehca_qp, ib_qp);
+
+	EHCA_CHECK_QP(my_qp);
+	if (ibqp->qp_type != IB_QPT_UD) {
+		EDEB_ERR(4, "invalid qp_type %x gid, ret=%x",
+			 ibqp->qp_type, EINVAL);
+		return -EINVAL;
+	}
+
+	shca = container_of(ibqp->pd->device, struct ehca_shca, ib_device);
+	EHCA_CHECK_ADR(shca);
+
+	if (!(EHCA_VALID_MULTICAST_GID(gid->raw))) {
+		EDEB_ERR(4, "gid is not valid mulitcast gid ret=%x",
+			 EINVAL);
+		return -EINVAL;
+	} else if ((lid < MIN_MC_LID) || (lid > MAX_MC_LID)) {
+		EDEB_ERR(4, "lid=%x is not valid mulitcast lid ret=%x",
+			 lid, EINVAL);
+		return -EINVAL;
+	}
+
+	EDEB_EN(7, "dgid=%p qp_numl=%x lid=%x",
+		gid, ibqp->qp_num, lid);
+
+	memcpy(&my_gid.raw, gid->raw, sizeof(union ib_gid));
+
+	h_ret = hipz_h_detach_mcqp(shca->ipz_hca_handle,
+				     my_qp->ipz_qp_handle,
+				     my_qp->galpas.kernel,
+				     lid, my_gid.global.subnet_prefix,
+				     my_gid.global.interface_id);
+	if (h_ret != H_SUCCESS) {
+		EDEB_ERR(4,
+			 "ehca_qp=%p qp_num=%x hipz_h_detach_mcqp() failed "
+			 "h_ret=%lx", my_qp, ibqp->qp_num, h_ret);
+	}
+	ret = ehca2ib_return_code(h_ret);
+
+	EDEB_EX(7, "mcast detach ret=%x\n"
+		"ehca_qp=%p qp_num=%x  lid=%x\n"
+		"my_gid=  %x %x %x %x\n"
+		"         %x %x %x %x\n"
+		"         %x %x %x %x\n"
+		"         %x %x %x %x\n",
+		ret, my_qp, ibqp->qp_num, lid,
+		my_gid.raw[0], my_gid.raw[1],
+		my_gid.raw[2], my_gid.raw[3],
+		my_gid.raw[4], my_gid.raw[5],
+		my_gid.raw[6], my_gid.raw[7],
+		my_gid.raw[8], my_gid.raw[9],
+		my_gid.raw[10], my_gid.raw[11],
+		my_gid.raw[12], my_gid.raw[13],
+		my_gid.raw[14], my_gid.raw[15]);
+
+	return ret;
+}


