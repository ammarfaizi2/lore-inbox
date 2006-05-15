Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965031AbWEORok@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965031AbWEORok (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 13:44:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965006AbWEORoH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 13:44:07 -0400
Received: from mtagate1.de.ibm.com ([195.212.29.150]:34985 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP id S965007AbWEORmQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 13:42:16 -0400
Message-ID: <4468BD8E.7010102@de.ibm.com>
Date: Mon, 15 May 2006 19:42:38 +0200
From: Heiko J Schick <schihei@de.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.6 (Windows/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: openib-general@openib.org, Christoph Raisch <RAISCH@de.ibm.com>,
       Hoang-Nam Nguyen <HNGUYEN@de.ibm.com>, Marcus Eder <MEDER@de.ibm.com>,
       schihei@de.ibm.com, linux-kernel@vger.kernel.org,
       linuxppc-dev@ozlabs.org
Subject: [PATCH 11/16] ehca: queue pair
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Heiko J Schick <schickhj@de.ibm.com>


  drivers/infiniband/hw/ehca/ehca_qes.h  |  274 +++++
  drivers/infiniband/hw/ehca/ehca_qp.c   | 1565 +++++++++++++++++++++++++++++++++
  drivers/infiniband/hw/ehca/ehca_reqs.c |  683 ++++++++++++++
  drivers/infiniband/hw/ehca/ehca_sqp.c  |  123 ++
  4 files changed, 2645 insertions(+)



--- linux-2.6.17-rc2-orig/drivers/infiniband/hw/ehca/ehca_qes.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.17-rc2/drivers/infiniband/hw/ehca/ehca_qes.h	2006-05-02 10:55:26.000000000 +0200
@@ -0,0 +1,274 @@
+/*
+ *  IBM eServer eHCA Infiniband device driver for Linux on POWER
+ *
+ *  Hardware request structures
+ *
+ *  Authors: Waleri Fomin <fomin@de.ibm.com>
+ *           Reinhard Ernst <rernst@de.ibm.com>
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
+
+#ifndef _EHCA_QES_H_
+#define _EHCA_QES_H_
+
+#include "ehca_tools.h"
+
+/**
+ * virtual scatter gather entry to specify remote adresses with length
+ */
+struct ehca_vsgentry {
+	u64 vaddr;
+	u32 lkey;
+	u32 length;
+};
+
+#define GRH_FLAG_MASK        EHCA_BMASK_IBM(7,7)
+#define GRH_IPVERSION_MASK   EHCA_BMASK_IBM(0,3)
+#define GRH_TCLASS_MASK      EHCA_BMASK_IBM(4,12)
+#define GRH_FLOWLABEL_MASK   EHCA_BMASK_IBM(13,31)
+#define GRH_PAYLEN_MASK      EHCA_BMASK_IBM(32,47)
+#define GRH_NEXTHEADER_MASK  EHCA_BMASK_IBM(48,55)
+#define GRH_HOPLIMIT_MASK    EHCA_BMASK_IBM(56,63)
+
+/**
+ * Unreliable Datagram Address Vector Format
+ * see IBTA Vol1 chapter 8.3 Global Routing Header
+ */
+struct ehca_ud_av {
+	u8 sl;
+	u8 lnh;
+	u16 dlid;
+	u8 reserved1;
+	u8 reserved2;
+	u8 reserved3;
+	u8 slid_path_bits;
+	u8 reserved4;
+	u8 ipd;
+	u8 reserved5;
+	u8 pmtu;
+	u32 reserved6;
+	u64 reserved7;
+	union {
+		struct {
+			u64 word_0; /* always set to 6  */
+			/*should be 0x1B for IB transport */
+			u64 word_1;
+			u64 word_2;
+			u64 word_3;
+			u64 word_4;
+		} grh;
+		struct {
+			u32 wd_0;
+			u32 wd_1;
+			/* DWord_1 --> SGID */
+
+			u32 sgid_wd3;
+			/* bits 127 - 96       */
+
+			u32 sgid_wd2;
+			/* bits  95 - 64 */
+			/* DWord_2 */
+
+			u32 sgid_wd1;
+			/* bits  63 - 32 */
+
+			u32 sgid_wd0;
+			/* bits  31 -  0 */
+			/* DWord_3 --> DGID */
+
+			u32 dgid_wd3;
+			/* bits 127 - 96
+			 **/
+			u32 dgid_wd2;
+			/* bits  95 - 64
+			 DWord_4 */
+			u32 dgid_wd1;
+			/* bits  63 - 32 */
+
+			u32 dgid_wd0;
+			/* bits  31 -  0    */
+		} grh_l;
+	};
+};
+
+/* maximum number of sg entries allowed in a WQE */
+#define MAX_WQE_SG_ENTRIES 252
+
+#define WQE_OPTYPE_SEND             0x80
+#define WQE_OPTYPE_RDMAREAD         0x40
+#define WQE_OPTYPE_RDMAWRITE        0x20
+#define WQE_OPTYPE_CMPSWAP          0x10
+#define WQE_OPTYPE_FETCHADD         0x08
+#define WQE_OPTYPE_BIND             0x04
+
+#define WQE_WRFLAG_REQ_SIGNAL_COM   0x80
+#define WQE_WRFLAG_FENCE            0x40
+#define WQE_WRFLAG_IMM_DATA_PRESENT 0x20
+#define WQE_WRFLAG_SOLIC_EVENT      0x10
+
+#define WQEF_CACHE_HINT             0x80
+#define WQEF_CACHE_HINT_RD_WR       0x40
+#define WQEF_TIMED_WQE              0x20
+#define WQEF_PURGE                  0x08
+#define WQEF_HIGH_NIBBLE            0xF0
+
+#define MW_BIND_ACCESSCTRL_R_WRITE   0x40
+#define MW_BIND_ACCESSCTRL_R_READ    0x20
+#define MW_BIND_ACCESSCTRL_R_ATOMIC  0x10
+
+struct ehca_wqe {
+	u64 work_request_id;
+	u8 optype;
+	u8 wr_flag;
+	u16 pkeyi;
+	u8 wqef;
+	u8 nr_of_data_seg;
+	u16 wqe_provided_slid;
+	u32 destination_qp_number;
+	u32 resync_psn_sqp;
+	u32 local_ee_context_qkey;
+	u32 immediate_data;
+	union {
+		struct {
+			u64 remote_virtual_adress;
+			u32 rkey;
+			u32 reserved;
+			u64 atomic_1st_op_dma_len;
+			u64 atomic_2nd_op;
+			struct ehca_vsgentry sg_list[MAX_WQE_SG_ENTRIES];
+
+		} nud;
+		struct {
+			u64 ehca_ud_av_ptr;
+			u64 reserved1;
+			u64 reserved2;
+			u64 reserved3;
+			struct ehca_vsgentry sg_list[MAX_WQE_SG_ENTRIES];
+		} ud_avp;
+		struct {
+			struct ehca_ud_av ud_av;
+			struct ehca_vsgentry sg_list[MAX_WQE_SG_ENTRIES -
+						     2];
+		} ud_av;
+		struct {
+			u64 reserved0;
+			u64 reserved1;
+			u64 reserved2;
+			u64 reserved3;
+			struct ehca_vsgentry sg_list[MAX_WQE_SG_ENTRIES];
+		} all_rcv;
+
+		struct {
+			u64 reserved;
+			u32 rkey;
+			u32 old_rkey;
+			u64 reserved1;
+			u64 reserved2;
+			u64 virtual_address;
+			u32 reserved3;
+			u32 length;
+			u32 reserved4;
+			u16 reserved5;
+			u8 reserved6;
+			u8 lr_ctl;
+			u32 lkey;
+			u32 reserved7;
+			u64 reserved8;
+			u64 reserved9;
+			u64 reserved10;
+			u64 reserved11;
+		} bind;
+		struct {
+			u64 reserved12;
+			u64 reserved13;
+			u32 size;
+			u32 start;
+		} inline_data;
+	} u;
+
+};
+
+#define WC_SEND_RECEIVE EHCA_BMASK_IBM(0,0)
+#define WC_IMM_DATA     EHCA_BMASK_IBM(1,1)
+#define WC_GRH_PRESENT  EHCA_BMASK_IBM(2,2)
+#define WC_SE_BIT       EHCA_BMASK_IBM(3,3)
+#define WC_STATUS_ERROR_BIT 0x80000000
+#define WC_STATUS_REMOTE_ERROR_FLAGS 0x0000F800
+#define WC_STATUS_PURGE_BIT 0x10
+
+struct ehca_cqe {
+	u64 work_request_id;
+	u8 optype;
+	u8 w_completion_flags;
+	u16 reserved1;
+	u32 nr_bytes_transferred;
+	u32 immediate_data;
+	u32 local_qp_number;
+	u8 freed_resource_count;
+	u8 service_level;
+	u16 wqe_count;
+	u32 qp_token;
+	u32 qkey_ee_token;
+	u32 remote_qp_number;
+	u16 dlid;
+	u16 rlid;
+	u16 reserved2;
+	u16 pkey_index;
+	u32 cqe_timestamp;
+	u32 wqe_timestamp;
+	u8 wqe_timestamp_valid;
+	u8 reserved3;
+	u8 reserved4;
+	u8 cqe_flags;
+	u32 status;
+};
+
+struct ehca_eqe {
+	u64 entry;
+};
+
+struct ehca_mrte {
+	u64 starting_va;
+	u64 length; /* length of memory region in bytes*/
+	u32 pd;
+	u8 key_instance;
+	u8 pagesize;
+	u8 mr_control;
+	u8 local_remote_access_ctrl;
+	u8 reserved[0x20 - 0x18];
+	u64 at_pointer[4];
+};
+#endif /*_EHCA_QES_H_*/
--- linux-2.6.17-rc2-orig/drivers/infiniband/hw/ehca/ehca_qp.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.17-rc2/drivers/infiniband/hw/ehca/ehca_qp.c	2006-05-15 15:43:31.000000000 +0200
@@ -0,0 +1,1565 @@
+/*
+ *  IBM eServer eHCA Infiniband device driver for Linux on POWER
+ *
+ *  QP functions
+ *
+ *  Authors: Waleri Fomin <fomin@de.ibm.com>
+ *           Hoang-Nam Nguyen <hnguyen@de.ibm.com>
+ *           Reinhard Ernst <rernst@de.ibm.com>
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
+
+#define DEB_PREFIX "e_qp"
+
+#include <asm/current.h>
+
+#include "ehca_classes.h"
+#include "ehca_tools.h"
+#include "ehca_qes.h"
+#include "ehca_iverbs.h"
+#include "hcp_if.h"
+#include "hipz_fns.h"
+
+/**
+ * attributes not supported by query qp
+ */
+#define QP_ATTR_QUERY_NOT_SUPPORTED (IB_QP_MAX_DEST_RD_ATOMIC | \
+				     IB_QP_MAX_QP_RD_ATOMIC   | \
+				     IB_QP_ACCESS_FLAGS       | \
+				     IB_QP_EN_SQD_ASYNC_NOTIFY)
+
+/**
+ * ehca (internal) qp state values
+ */
+enum ehca_qp_state {
+	EHCA_QPS_RESET = 1,
+	EHCA_QPS_INIT = 2,
+	EHCA_QPS_RTR = 3,
+	EHCA_QPS_RTS = 5,
+	EHCA_QPS_SQD = 6,
+	EHCA_QPS_SQE = 8,
+	EHCA_QPS_ERR = 128
+};
+
+/**
+ * qp state transitions as defined by IB Arch Rel 1.1 page 431
+ */
+enum ib_qp_statetrans {
+	IB_QPST_ANY2RESET,
+	IB_QPST_ANY2ERR,
+	IB_QPST_RESET2INIT,
+	IB_QPST_INIT2RTR,
+	IB_QPST_INIT2INIT,
+	IB_QPST_RTR2RTS,
+	IB_QPST_RTS2SQD,
+	IB_QPST_RTS2RTS,
+	IB_QPST_SQD2RTS,
+	IB_QPST_SQE2RTS,
+	IB_QPST_SQD2SQD,
+	IB_QPST_MAX	/* nr of transitions, this must be last!!! */
+};
+
+/**
+ * ib2ehca_qp_state - maps IB to ehca qp_state
+ * returns ehca qp state corresponding to given ib qp state
+ */
+static inline enum ehca_qp_state ib2ehca_qp_state(enum ib_qp_state ib_qp_state)
+{
+	switch (ib_qp_state) {
+	case IB_QPS_RESET:
+		return EHCA_QPS_RESET;
+	case IB_QPS_INIT:
+		return EHCA_QPS_INIT;
+	case IB_QPS_RTR:
+		return EHCA_QPS_RTR;
+	case IB_QPS_RTS:
+		return EHCA_QPS_RTS;
+	case IB_QPS_SQD:
+		return EHCA_QPS_SQD;
+	case IB_QPS_SQE:
+		return EHCA_QPS_SQE;
+	case IB_QPS_ERR:
+		return EHCA_QPS_ERR;
+	default:
+		EDEB_ERR(4, "invalid ib_qp_state=%x", ib_qp_state);
+		return -EINVAL;
+	}
+}
+
+/**
+ * ehca2ib_qp_state - maps ehca to IB qp_state
+ * returns ib qp state corresponding to given ehca qp state
+ */
+static inline enum ib_qp_state ehca2ib_qp_state(enum ehca_qp_state
+						ehca_qp_state)
+{
+	switch (ehca_qp_state) {
+	case EHCA_QPS_RESET:
+		return IB_QPS_RESET;
+	case EHCA_QPS_INIT:
+		return IB_QPS_INIT;
+	case EHCA_QPS_RTR:
+		return IB_QPS_RTR;
+	case EHCA_QPS_RTS:
+		return IB_QPS_RTS;
+	case EHCA_QPS_SQD:
+		return IB_QPS_SQD;
+	case EHCA_QPS_SQE:
+		return IB_QPS_SQE;
+	case EHCA_QPS_ERR:
+		return IB_QPS_ERR;
+	default:
+		EDEB_ERR(4,"invalid ehca_qp_state=%x",ehca_qp_state);
+		return -EINVAL;
+	}
+}
+
+/**
+ * ehca_qp_type - used as index for req_attr and opt_attr of
+ * struct ehca_modqp_statetrans
+ */
+enum ehca_qp_type {
+	QPT_RC = 0,
+	QPT_UC = 1,
+	QPT_UD = 2,
+	QPT_SQP = 3,
+	QPT_MAX
+};
+
+/**
+ * ib2ehcaqptype - maps Ib to ehca qp_type
+ * returns ehca qp type corresponding to ib qp type
+ */
+static inline enum ehca_qp_type ib2ehcaqptype(enum ib_qp_type ibqptype)
+{
+	switch (ibqptype) {
+	case IB_QPT_SMI:
+	case IB_QPT_GSI:
+		return QPT_SQP;
+	case IB_QPT_RC:
+		return QPT_RC;
+	case IB_QPT_UC:
+		return QPT_UC;
+	case IB_QPT_UD:
+		return QPT_UD;
+	default:
+		EDEB_ERR(4,"Invalid ibqptype=%x", ibqptype);
+		return -EINVAL;
+	}
+}
+
+static inline enum ib_qp_statetrans get_modqp_statetrans(int ib_fromstate,
+							 int ib_tostate)
+{
+	int index = -EINVAL;
+	switch (ib_tostate) {
+	case IB_QPS_RESET:
+		index = IB_QPST_ANY2RESET;
+		break;
+	case IB_QPS_INIT:
+		if (ib_fromstate == IB_QPS_RESET)
+			index = IB_QPST_RESET2INIT;
+		else if (ib_fromstate == IB_QPS_INIT)
+			index = IB_QPST_INIT2INIT;
+		break;
+	case IB_QPS_RTR:
+		if (ib_fromstate == IB_QPS_INIT)
+			index = IB_QPST_INIT2RTR;
+		break;
+	case IB_QPS_RTS:
+		if (ib_fromstate == IB_QPS_RTR)
+			index = IB_QPST_RTR2RTS;
+		else if (ib_fromstate == IB_QPS_RTS)
+			index = IB_QPST_RTS2RTS;
+		else if (ib_fromstate == IB_QPS_SQD)
+			index = IB_QPST_SQD2RTS;
+		else if (ib_fromstate == IB_QPS_SQE)
+			index = IB_QPST_SQE2RTS;
+		break;
+	case IB_QPS_SQD:
+		if (ib_fromstate == IB_QPS_RTS)
+			index = IB_QPST_RTS2SQD;
+		break;
+	case IB_QPS_SQE:
+		break;
+	case IB_QPS_ERR:
+		index = IB_QPST_ANY2ERR;
+		break;
+	default:
+		break;
+	}
+	return index;
+}
+
+enum ehca_service_type {
+	ST_RC = 0,
+	ST_UC = 1,
+	ST_RD = 2,
+	ST_UD = 3
+};
+
+/**
+ * ibqptype2servicetype - returns hcp service type corresponding to given
+ * ib qp type used by create_qp()
+ */
+static inline int ibqptype2servicetype(enum ib_qp_type ibqptype)
+{
+	switch (ibqptype) {
+	case IB_QPT_SMI:
+	case IB_QPT_GSI:
+		return ST_UD;
+	case IB_QPT_RC:
+		return ST_RC;
+	case IB_QPT_UC:
+		return ST_UC;
+	case IB_QPT_UD:
+		return ST_UD;
+	case IB_QPT_RAW_IPV6:
+		return -EINVAL;
+	case IB_QPT_RAW_ETY:
+		return -EINVAL;
+	default:
+		EDEB_ERR(4, "Invalid ibqptype=%x", ibqptype);
+		return -EINVAL;
+	}
+}
+
+/**
+ * init_qp_queues - Initializes/constructs r/squeue and registers queue pages.
+ */
+static inline int init_qp_queues(struct ipz_adapter_handle ipz_hca_handle,
+				 struct ehca_qp *my_qp,
+				 int nr_sq_pages,
+				 int nr_rq_pages,
+				 int swqe_size,
+				 int rwqe_size,
+				 int nr_send_sges, int nr_receive_sges)
+{
+	int ret = -EINVAL;
+	int cnt = 0;
+	void *vpage = NULL;
+	u64 rpage = 0;
+	int ipz_rc = -1;
+	u64 h_ret = H_PARAMETER;
+
+	ipz_rc = ipz_queue_ctor(&my_qp->ipz_squeue,
+				nr_sq_pages,
+				EHCA_PAGESIZE, swqe_size, nr_send_sges);
+	if (!ipz_rc) {
+		EDEB_ERR(4, "Cannot allocate page for squeue. ipz_rc=%x",
+			 ipz_rc);
+		ret = -EBUSY;
+		return ret;
+	}
+
+	ipz_rc = ipz_queue_ctor(&my_qp->ipz_rqueue,
+				nr_rq_pages,
+				EHCA_PAGESIZE, rwqe_size, nr_receive_sges);
+	if (!ipz_rc) {
+		EDEB_ERR(4, "Cannot allocate page for rqueue. ipz_rc=%x",
+			 ipz_rc);
+		ret = -EBUSY;
+		goto init_qp_queues0;
+	}
+	/* register SQ pages */
+	for (cnt = 0; cnt < nr_sq_pages; cnt++) {
+		vpage = ipz_qpageit_get_inc(&my_qp->ipz_squeue);
+		if (!vpage) {
+			EDEB_ERR(4, "SQ ipz_qpageit_get_inc() "
+				 "failed p_vpage= %p", vpage);
+			ret = -EINVAL;
+			goto init_qp_queues1;
+		}
+		rpage = virt_to_abs(vpage);
+
+		h_ret = hipz_h_register_rpage_qp(ipz_hca_handle,
+						 my_qp->ipz_qp_handle,
+						 &my_qp->pf, 0, 0,
+						 rpage, 1,
+						 my_qp->galpas.kernel);
+		if (h_ret < H_SUCCESS) {
+			EDEB_ERR(4,"SQ  hipz_qp_register_rpage() faield "
+				 "rc=%lx", h_ret);
+			ret = ehca2ib_return_code(h_ret);
+			goto init_qp_queues1;
+		}
+	}
+
+	ipz_qeit_reset(&my_qp->ipz_squeue);
+
+	/* register RQ pages */
+	for (cnt = 0; cnt < nr_rq_pages; cnt++) {
+		vpage = ipz_qpageit_get_inc(&my_qp->ipz_rqueue);
+		if (!vpage) {
+			EDEB_ERR(4,"RQ ipz_qpageit_get_inc() "
+				 "failed p_vpage = %p", vpage);
+			h_ret = H_RESOURCE;
+			ret = -EINVAL;
+			goto init_qp_queues1;
+		}
+
+		rpage = virt_to_abs(vpage);
+
+		h_ret = hipz_h_register_rpage_qp(ipz_hca_handle,
+						 my_qp->ipz_qp_handle,
+						 &my_qp->pf, 0, 1,
+						 rpage, 1,my_qp->galpas.kernel);
+		if (h_ret < H_SUCCESS) {
+			EDEB_ERR(4, "RQ hipz_qp_register_rpage() failed "
+				 "rc=%lx", h_ret);
+			ret = ehca2ib_return_code(h_ret);
+			goto init_qp_queues1;
+		}
+		if (cnt == (nr_rq_pages - 1)) {	/* last page! */
+			if (h_ret != H_SUCCESS) {
+				EDEB_ERR(4,"RQ hipz_qp_register_rpage() "
+					 "h_ret= %lx ", h_ret);
+				ret = ehca2ib_return_code(h_ret);
+				goto init_qp_queues1;
+			}
+			vpage = ipz_qpageit_get_inc(&my_qp->ipz_rqueue);
+			if (vpage) {
+				EDEB_ERR(4,"ipz_qpageit_get_inc() "
+					 "should not succeed vpage=%p",
+					 vpage);
+				ret = -EINVAL;
+				goto init_qp_queues1;
+			}
+		} else {
+			if (h_ret != H_PAGE_REGISTERED) {
+				EDEB_ERR(4,"RQ hipz_qp_register_rpage() "
+					 "h_ret= %lx ", h_ret);
+				ret = ehca2ib_return_code(h_ret);
+				goto init_qp_queues1;
+			}
+		}
+	}
+
+	ipz_qeit_reset(&my_qp->ipz_rqueue);
+
+	return 0;
+
+init_qp_queues1:
+	ipz_queue_dtor(&my_qp->ipz_rqueue);
+init_qp_queues0:
+	ipz_queue_dtor(&my_qp->ipz_squeue);
+	return ret;
+}
+
+
+struct ib_qp *ehca_create_qp(struct ib_pd *pd,
+			     struct ib_qp_init_attr *init_attr,
+			     struct ib_udata *udata)
+{
+	extern struct ehca_module ehca_module;
+	static int da_msg_size[]={ 128, 256, 512, 1024, 2048, 4096 };
+	int ret = -EINVAL;
+
+	struct ehca_qp *my_qp = NULL;
+	struct ehca_pd *my_pd = NULL;
+	struct ehca_shca *shca = NULL;
+	struct ib_ucontext *context = NULL;
+	u64 h_ret = H_PARAMETER;
+	int max_send_sge;
+	int max_recv_sge;
+
+	/* h_call's out parameters */
+	struct ehca_alloc_qp_parms parms;
+	u32 qp_nr = 0, swqe_size = 0, rwqe_size = 0;
+	u8 daqp_completion, isdaqp;
+	unsigned long flags;
+
+	EDEB_EN(7,"pd=%p init_attr=%p", pd, init_attr);
+	EHCA_CHECK_PD_P(pd);
+	EHCA_CHECK_ADR_P(init_attr);
+
+	if (init_attr->sq_sig_type != IB_SIGNAL_REQ_WR &&
+		init_attr->sq_sig_type != IB_SIGNAL_ALL_WR) {
+		EDEB_ERR(4, "init_attr->sg_sig_type=%x not allowed",
+			init_attr->sq_sig_type);
+		return ERR_PTR(-EINVAL);
+	}
+
+	/* save daqp completion bits */
+	daqp_completion = init_attr->qp_type & 0x60;
+	/* save daqp bit */
+	isdaqp = (init_attr->qp_type & 0x80) ? 1 : 0;
+	init_attr->qp_type = init_attr->qp_type & 0x1F;
+
+	if (init_attr->qp_type != IB_QPT_UD &&
+	    init_attr->qp_type != IB_QPT_SMI &&
+	    init_attr->qp_type != IB_QPT_GSI &&
+	    init_attr->qp_type != IB_QPT_UC &&
+	    init_attr->qp_type != IB_QPT_RC) {
+		EDEB_ERR(4,"wrong QP Type=%x",init_attr->qp_type);
+		return ERR_PTR(-EINVAL);
+	}
+	if (init_attr->qp_type != IB_QPT_RC && isdaqp != 0) {
+		EDEB_ERR(4,"unsupported LL QP Type=%x",init_attr->qp_type);
+		return ERR_PTR(-EINVAL);
+	}
+
+	if (pd->uobject && udata)
+		context = pd->uobject->context;
+
+	my_qp = kmem_cache_alloc(ehca_module.cache_qp, SLAB_KERNEL);
+	if (!my_qp) {
+		EDEB_ERR(4, "pd=%p not enough memory to alloc qp", pd);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	memset(my_qp, 0, sizeof(struct ehca_qp));
+	memset (&parms, 0, sizeof(struct ehca_alloc_qp_parms));
+	spin_lock_init(&my_qp->spinlock_s);
+	spin_lock_init(&my_qp->spinlock_r);
+
+	my_pd = container_of(pd, struct ehca_pd, ib_pd);
+
+	shca = container_of(pd->device, struct ehca_shca, ib_device);
+	my_qp->recv_cq =
+		container_of(init_attr->recv_cq, struct ehca_cq, ib_cq);
+	my_qp->send_cq =
+		container_of(init_attr->send_cq, struct ehca_cq, ib_cq);
+
+	my_qp->init_attr = *init_attr;
+
+	do {
+		if (!idr_pre_get(&ehca_qp_idr, GFP_KERNEL)) {
+			ret = -ENOMEM;
+			EDEB_ERR(4, "Can't reserve idr resources.");
+			goto create_qp_exit0;
+		}
+
+		spin_lock_irqsave(&ehca_qp_idr_lock, flags);
+		ret = idr_get_new(&ehca_qp_idr, my_qp, &my_qp->token);
+		spin_unlock_irqrestore(&ehca_qp_idr_lock, flags);
+
+	} while (ret == -EAGAIN);
+
+	if (ret) {
+		ret = -ENOMEM;
+		EDEB_ERR(4, "Can't allocate new idr entry.");
+		goto create_qp_exit0;
+	}
+
+	parms.servicetype = ibqptype2servicetype(init_attr->qp_type);
+	if (parms.servicetype < 0) {
+		ret = -EINVAL;
+		EDEB_ERR(4, "Invalid qp_type=%x", init_attr->qp_type);
+		goto create_qp_exit0;
+	}
+
+	if (init_attr->sq_sig_type == IB_SIGNAL_ALL_WR)
+		parms.sigtype = HCALL_SIGT_EVERY;
+	else
+		parms.sigtype = HCALL_SIGT_BY_WQE;
+
+	/* UD_AV CIRCUMVENTION */
+	max_send_sge = init_attr->cap.max_send_sge;
+	max_recv_sge = init_attr->cap.max_recv_sge;
+	if (IB_QPT_UD == init_attr->qp_type ||
+	    IB_QPT_GSI == init_attr->qp_type ||
+	    IB_QPT_SMI == init_attr->qp_type) {
+		max_send_sge += 2;
+		max_recv_sge += 2;
+	}
+
+	EDEB(7, "isdaqp=%x daqp_completion=%x", isdaqp, daqp_completion);
+
+	parms.ipz_eq_handle = shca->eq.ipz_eq_handle;
+	parms.daqp_ctrl = isdaqp | daqp_completion;
+	parms.pd = my_pd->fw_pd;
+	parms.max_recv_sge = max_recv_sge;
+	parms.max_send_sge = max_send_sge;
+
+	h_ret = hipz_h_alloc_resource_qp(shca->ipz_hca_handle, my_qp, &parms);
+
+	if (h_ret != H_SUCCESS) {
+		EDEB_ERR(4, "h_alloc_resource_qp() failed h_ret=%lx", h_ret);
+		ret = ehca2ib_return_code(h_ret);
+		goto create_qp_exit1;
+	}
+
+	switch (init_attr->qp_type) {
+	case IB_QPT_RC:
+	        if (isdaqp == 0) {
+			swqe_size = offsetof(struct ehca_wqe, u.nud.sg_list[
+					     (parms.act_nr_send_sges)]);
+			rwqe_size = offsetof(struct ehca_wqe, u.nud.sg_list[
+					     (parms.act_nr_recv_sges)]);
+		} else { /* for daqp we need to use msg size, not wqe size */
+		        swqe_size = da_msg_size[max_send_sge];
+			rwqe_size = da_msg_size[max_recv_sge];
+			parms.act_nr_send_sges = 1;
+			parms.act_nr_recv_sges = 1;
+		}
+		break;
+	case IB_QPT_UC:
+		swqe_size = offsetof(struct ehca_wqe,
+				     u.nud.sg_list[parms.act_nr_send_sges]);
+		rwqe_size = offsetof(struct ehca_wqe,
+				     u.nud.sg_list[parms.act_nr_recv_sges]);
+		break;
+
+	case IB_QPT_UD:
+	case IB_QPT_GSI:
+	case IB_QPT_SMI:
+		/* UD circumvention */
+		parms.act_nr_recv_sges -= 2;
+		parms.act_nr_send_sges -= 2;
+                swqe_size = offsetof(struct ehca_wqe,
+				     u.ud_av.sg_list[parms.act_nr_send_sges]);
+		rwqe_size = offsetof(struct ehca_wqe,
+				     u.ud_av.sg_list[parms.act_nr_recv_sges]);
+
+		if (IB_QPT_GSI == init_attr->qp_type ||
+		    IB_QPT_SMI == init_attr->qp_type) {
+			parms.act_nr_send_wqes = init_attr->cap.max_send_wr;
+			parms.act_nr_recv_wqes = init_attr->cap.max_recv_wr;
+			parms.act_nr_send_sges = init_attr->cap.max_send_sge;
+			parms.act_nr_recv_sges = init_attr->cap.max_recv_sge;
+			my_qp->real_qp_num =
+				(init_attr->qp_type == IB_QPT_SMI) ? 0 : 1;
+		}
+
+		break;
+
+	default:
+		break;
+	}
+
+	/* initializes r/squeue and registers queue pages */
+	ret = init_qp_queues(shca->ipz_hca_handle, my_qp,
+			     parms.nr_sq_pages, parms.nr_rq_pages,
+			     swqe_size, rwqe_size,
+			     parms.act_nr_send_sges, parms.act_nr_recv_sges);
+	if (ret) {
+		EDEB_ERR(4,"Couldn't initialize r/squeue and pages ret=%x",
+			 ret);
+		goto create_qp_exit2;
+	}
+
+	my_qp->ib_qp.pd = &my_pd->ib_pd;
+	my_qp->ib_qp.device = my_pd->ib_pd.device;
+
+	my_qp->ib_qp.recv_cq = init_attr->recv_cq;
+	my_qp->ib_qp.send_cq = init_attr->send_cq;
+
+	my_qp->ib_qp.qp_num = my_qp->real_qp_num;
+	my_qp->ib_qp.qp_type = init_attr->qp_type;
+
+	my_qp->qp_type = init_attr->qp_type;
+	my_qp->ib_qp.srq = init_attr->srq;
+
+	my_qp->ib_qp.qp_context = init_attr->qp_context;
+	my_qp->ib_qp.event_handler = init_attr->event_handler;
+
+	init_attr->cap.max_inline_data = 0; /* not supported yet */
+	init_attr->cap.max_recv_sge = parms.act_nr_recv_sges;
+	init_attr->cap.max_recv_wr = parms.act_nr_recv_wqes;
+	init_attr->cap.max_send_sge = parms.act_nr_send_sges;
+	init_attr->cap.max_send_wr = parms.act_nr_send_wqes;
+
+	/* NOTE: define_apq0() not supported yet */
+	if (init_attr->qp_type == IB_QPT_GSI) {
+		h_ret = ehca_define_sqp(shca, my_qp, init_attr);
+		if (h_ret != H_SUCCESS) {
+			EDEB_ERR(4, "ehca_define_sqp() failed rc=%lx",h_ret);
+			ret = ehca2ib_return_code(h_ret);
+			goto create_qp_exit3;
+		}
+	}
+	if (init_attr->send_cq) {
+		struct ehca_cq *cq = container_of(init_attr->send_cq,
+						  struct ehca_cq, ib_cq);
+		ret = ehca_cq_assign_qp(cq, my_qp);
+		if (ret) {
+			EDEB_ERR(4, "Couldn't assign qp to send_cq ret=%x",
+				 ret);
+			goto create_qp_exit3;
+		}
+		my_qp->send_cq = cq;
+	}
+	/* copy queues, galpa data to user space */
+	if (context && udata) {
+		struct ipz_queue *ipz_rqueue = &my_qp->ipz_rqueue;
+		struct ipz_queue *ipz_squeue = &my_qp->ipz_squeue;
+		struct ehca_create_qp_resp resp;
+		struct vm_area_struct * vma;
+		memset(&resp, 0, sizeof(resp));
+
+		resp.qp_num = my_qp->real_qp_num;
+		resp.token = my_qp->token;
+		resp.qp_type = my_qp->qp_type;
+		resp.qkey = my_qp->qkey;
+		resp.real_qp_num = my_qp->real_qp_num;
+		/* rqueue properties */
+		resp.ipz_rqueue.qe_size = ipz_rqueue->qe_size;
+		resp.ipz_rqueue.act_nr_of_sg = ipz_rqueue->act_nr_of_sg;
+		resp.ipz_rqueue.queue_length = ipz_rqueue->queue_length;
+		resp.ipz_rqueue.pagesize = ipz_rqueue->pagesize;
+		resp.ipz_rqueue.toggle_state = ipz_rqueue->toggle_state;
+		ehca_mmap_nopage(((u64)(my_qp->token) << 32) | 0x22000000,
+				 ipz_rqueue->queue_length,
+				 ((void**)&resp.ipz_rqueue.queue),
+				 &vma);
+		my_qp->uspace_rqueue = resp.ipz_rqueue.queue;
+		/* squeue properties */
+		resp.ipz_squeue.qe_size = ipz_squeue->qe_size;
+		resp.ipz_squeue.act_nr_of_sg = ipz_squeue->act_nr_of_sg;
+		resp.ipz_squeue.queue_length = ipz_squeue->queue_length;
+		resp.ipz_squeue.pagesize = ipz_squeue->pagesize;
+		resp.ipz_squeue.toggle_state = ipz_squeue->toggle_state;
+		ehca_mmap_nopage(((u64)(my_qp->token) << 32) | 0x23000000,
+				 ipz_squeue->queue_length,
+				 ((void**)&resp.ipz_squeue.queue),
+				 &vma);
+		my_qp->uspace_squeue = resp.ipz_squeue.queue;
+		/* fw_handle */
+		resp.galpas = my_qp->galpas;
+		ehca_mmap_register(my_qp->galpas.user.fw_handle,
+				   ((void**)&resp.galpas.kernel.fw_handle),
+				   &vma);
+		my_qp->uspace_fwh = (u64)resp.galpas.kernel.fw_handle;
+
+		if (ib_copy_to_udata(udata, &resp, sizeof resp)) {
+			EDEB_ERR(4, "Copy to udata failed");
+			ret = -EINVAL;
+			goto create_qp_exit3;
+		}
+	}
+
+	EDEB_EX(7, "ehca_qp=%p qp_num=%x, token=%x",
+		my_qp, qp_nr, my_qp->token);
+	return &my_qp->ib_qp;
+
+create_qp_exit3:
+	ipz_queue_dtor(&my_qp->ipz_rqueue);
+	ipz_queue_dtor(&my_qp->ipz_squeue);
+
+create_qp_exit2:
+	hipz_h_destroy_qp(shca->ipz_hca_handle, my_qp);
+
+create_qp_exit1:
+	spin_lock_irqsave(&ehca_qp_idr_lock, flags);
+	idr_remove(&ehca_qp_idr, my_qp->token);
+	spin_unlock_irqrestore(&ehca_qp_idr_lock, flags);
+
+create_qp_exit0:
+	kmem_cache_free(ehca_module.cache_qp, my_qp);
+	EDEB_EX(4, "failed ret=%x", ret);
+	return ERR_PTR(ret);
+
+}
+
+/**
+ * prepare_sqe_rts - called by internal_modify_qp() at trans sqe -> rts
+ * set purge bit of bad wqe and subsequent wqes to avoid reentering sqe
+ * returns total number of bad wqes in bad_wqe_cnt
+ */
+static int prepare_sqe_rts(struct ehca_qp *my_qp, struct ehca_shca *shca,
+			   int *bad_wqe_cnt)
+{
+	int ret = 0;
+	u64 h_ret = H_SUCCESS;
+	struct ipz_queue *squeue = NULL;
+	void *bad_send_wqe_p = NULL;
+	void *bad_send_wqe_v = NULL;
+	void *squeue_start_p = NULL;
+	void *squeue_end_p = NULL;
+	void *squeue_start_v = NULL;
+	void *squeue_end_v = NULL;
+	struct ehca_wqe *wqe = NULL;
+	int qp_num = my_qp->ib_qp.qp_num;
+
+	EDEB_EN(7, "ehca_qp=%p qp_num=%x ", my_qp, qp_num);
+
+	/* get send wqe pointer */
+	h_ret = hipz_h_disable_and_get_wqe(shca->ipz_hca_handle,
+					   my_qp->ipz_qp_handle, &my_qp->pf,
+					   &bad_send_wqe_p, NULL, 2);
+	if (h_ret != H_SUCCESS) {
+		EDEB_ERR(4, "hipz_h_disable_and_get_wqe() failed "
+			 "ehca_qp=%p qp_num=%x h_ret=%lx",my_qp, qp_num, h_ret);
+		ret = ehca2ib_return_code(h_ret);
+		goto prepare_sqe_rts_exit1;
+	}
+	bad_send_wqe_p = (void*)((u64)bad_send_wqe_p & (~(1L<<63)));
+	EDEB(7, "qp_num=%x bad_send_wqe_p=%p", qp_num, bad_send_wqe_p);
+	/* convert wqe pointer to vadr */
+	bad_send_wqe_v = abs_to_virt((u64)bad_send_wqe_p);
+	EDEB_DMP(6, bad_send_wqe_v, 32, "qp_num=%x bad_wqe", qp_num);
+	squeue = &my_qp->ipz_squeue;
+	squeue_start_p = (void*)virt_to_abs(ipz_qeit_calc(squeue, 0L));
+	squeue_end_p = squeue_start_p+squeue->queue_length;
+	squeue_start_v = abs_to_virt((u64)squeue_start_p);
+	squeue_end_v = abs_to_virt((u64)squeue_end_p);
+	EDEB(6, "qp_num=%x squeue_start_v=%p squeue_end_v=%p",
+	     qp_num, squeue_start_v, squeue_end_v);
+
+	/* loop sets wqe's purge bit */
+	wqe = (struct ehca_wqe*)bad_send_wqe_v;
+	*bad_wqe_cnt = 0;
+	while (wqe->optype != 0xff && wqe->wqef != 0xff) {
+		EDEB_DMP(6, wqe, 32, "qp_num=%x wqe", qp_num);
+		wqe->nr_of_data_seg = 0; /* suppress data access */
+		wqe->wqef = WQEF_PURGE; /* WQE to be purged */
+		wqe = (struct ehca_wqe*)((u8*)wqe+squeue->qe_size);
+		*bad_wqe_cnt = (*bad_wqe_cnt)+1;
+		if ((void*)wqe >= squeue_end_v) {
+			wqe = squeue_start_v;
+		}
+	}
+	/* bad wqe will be reprocessed and ignored when pol_cq() is called,
+	 *  i.e. nr of wqes with flush error status is one less
+	 */
+	EDEB(6, "qp_num=%x flusherr_wqe_cnt=%x", qp_num, (*bad_wqe_cnt)-1);
+	wqe->wqef = 0;
+
+prepare_sqe_rts_exit1:
+
+	EDEB_EX(7, "ehca_qp=%p qp_num=%x ret=%x", my_qp, qp_num, ret);
+	return ret;
+}
+
+/**
+ * internal_modify_qp - with circumvention to handle aqp0 properly
+ * smi_reset2init indicates if this is an internal reset-to-init-call for
+ * smi. This flag must always be zero if called from ehca_modify_qp()!
+ * This internal func was intorduced to avoid recursion of ehca_modify_qp()!
+ */
+static int internal_modify_qp(struct ib_qp *ibqp,
+			      struct ib_qp_attr *attr,
+			      int attr_mask, int smi_reset2init)
+{
+	enum ib_qp_state qp_cur_state = 0, qp_new_state = 0;
+	int cnt = 0, qp_attr_idx = 0, ret = 0;
+
+	enum ib_qp_statetrans statetrans;
+	struct hcp_modify_qp_control_block *mqpcb = NULL;
+	struct ehca_qp *my_qp = NULL;
+	struct ehca_shca *shca = NULL;
+	u64 update_mask = 0;
+	u64 h_ret = H_SUCCESS;
+	int bad_wqe_cnt = 0;
+	int squeue_locked = 0;
+	unsigned long spl_flags = 0;
+
+	my_qp = container_of(ibqp, struct ehca_qp, ib_qp);
+	shca = container_of(ibqp->pd->device, struct ehca_shca, ib_device);
+
+	EDEB_EN(7, "ehca_qp=%p qp_num=%x ibqp_type=%x "
+		"new qp_state=%x attribute_mask=%x",
+		my_qp, ibqp->qp_num, ibqp->qp_type,
+		attr->qp_state, attr_mask);
+
+	/* do query_qp to obtain current attr values */
+	mqpcb = kzalloc(H_CB_ALIGNMENT, GFP_KERNEL);
+	if (mqpcb == NULL) {
+		ret = -ENOMEM;
+		EDEB_ERR(4, "Could not get zeroed page for mqpcb "
+			 "ehca_qp=%p qp_num=%x ", my_qp, ibqp->qp_num);
+		goto modify_qp_exit0;
+	}
+
+	h_ret = hipz_h_query_qp(shca->ipz_hca_handle,
+				my_qp->ipz_qp_handle,
+				&my_qp->pf,
+				mqpcb, my_qp->galpas.kernel);
+	if (h_ret != H_SUCCESS) {
+		EDEB_ERR(4, "hipz_h_query_qp() failed "
+			 "ehca_qp=%p qp_num=%x h_ret=%lx",
+			 my_qp, ibqp->qp_num, h_ret);
+		ret = ehca2ib_return_code(h_ret);
+		goto modify_qp_exit1;
+	}
+	EDEB(7, "ehca_qp=%p qp_num=%x ehca_qp_state=%x",
+	     my_qp, ibqp->qp_num, mqpcb->qp_state);
+
+	qp_cur_state = ehca2ib_qp_state(mqpcb->qp_state);
+
+	if (qp_cur_state == -EINVAL) {	/* invalid qp state */
+		ret = -EINVAL;
+		EDEB_ERR(4, "Invalid current ehca_qp_state=%x "
+			 "ehca_qp=%p qp_num=%x",
+			 mqpcb->qp_state, my_qp, ibqp->qp_num);
+		goto modify_qp_exit1;
+	}
+	/* circumvention to set aqp0 initial state to init
+	   as expected by IB spec */
+	if (smi_reset2init == 0 &&
+	    ibqp->qp_type == IB_QPT_SMI &&
+	    qp_cur_state == IB_QPS_RESET &&
+	    (attr_mask & IB_QP_STATE) &&
+	    attr->qp_state == IB_QPS_INIT) { /* RESET -> INIT */
+		struct ib_qp_attr smiqp_attr = {
+			.qp_state = IB_QPS_INIT,
+			.port_num = my_qp->init_attr.port_num,
+			.pkey_index = 0,
+			.qkey = 0
+		};
+		int smiqp_attr_mask = IB_QP_STATE | IB_QP_PORT |
+			IB_QP_PKEY_INDEX | IB_QP_QKEY;
+		int smirc = internal_modify_qp(
+			ibqp, &smiqp_attr, smiqp_attr_mask, 1);
+		if (smirc) {
+			EDEB_ERR(4, "SMI RESET -> INIT failed. "
+				 "ehca_modify_qp() rc=%x", smirc);
+			ret = H_PARAMETER;
+			goto modify_qp_exit1;
+		}
+		qp_cur_state = IB_QPS_INIT;
+		EDEB(7, "SMI RESET -> INIT succeeded");
+	}
+	/* is transmitted current state  equal to "real" current state */
+	if ((attr_mask & IB_QP_CUR_STATE) &&
+	    qp_cur_state != attr->cur_qp_state) {
+		ret = -EINVAL;
+		EDEB_ERR(4, "Invalid IB_QP_CUR_STATE attr->curr_qp_state=%x <>"
+			 " actual cur_qp_state=%x. ehca_qp=%p qp_num=%x",
+			 attr->cur_qp_state, qp_cur_state, my_qp, ibqp->qp_num);
+		goto modify_qp_exit1;
+	}
+
+	EDEB(7,	"ehca_qp=%p qp_num=%x current qp_state=%x "
+	     "new qp_state=%x attribute_mask=%x",
+	     my_qp, ibqp->qp_num, qp_cur_state, attr->qp_state, attr_mask);
+
+	qp_new_state = attr_mask & IB_QP_STATE ? attr->qp_state : qp_cur_state;
+	if (!smi_reset2init &&
+	    !ib_modify_qp_is_ok(qp_cur_state, qp_new_state, ibqp->qp_type,
+				attr_mask)) {
+		ret = -EINVAL;
+		EDEB_ERR(4, "Invalid qp transition new_state=%x cur_state=%x "
+			 "ehca_qp=%p qp_num=%x attr_mask=%x",
+			 qp_new_state, qp_cur_state, my_qp, ibqp->qp_num,
+			 attr_mask);
+		goto modify_qp_exit1;
+	}
+
+	if ((mqpcb->qp_state = ib2ehca_qp_state(qp_new_state)))
+		update_mask = EHCA_BMASK_SET(MQPCB_MASK_QP_STATE, 1);
+	else {
+		ret = -EINVAL;
+		EDEB_ERR(4, "Invalid new qp state=%x "
+			 "ehca_qp=%p qp_num=%x",
+			 qp_new_state, my_qp, ibqp->qp_num);
+		goto modify_qp_exit1;
+	}
+
+	/* retrieve state transition struct to get req and opt attrs */
+	statetrans = get_modqp_statetrans(qp_cur_state, qp_new_state);
+	if (statetrans < 0) {
+		ret = -EINVAL;
+		EDEB_ERR(4, "<INVALID STATE CHANGE> qp_cur_state=%x "
+			 "new_qp_state=%x State_xsition=%x "
+			 "ehca_qp=%p qp_num=%x",
+			 qp_cur_state, qp_new_state,
+			 statetrans, my_qp, ibqp->qp_num);
+		goto modify_qp_exit1;
+	}
+
+	qp_attr_idx = ib2ehcaqptype(ibqp->qp_type);
+
+	if (qp_attr_idx < 0) {
+		ret = qp_attr_idx;
+		EDEB_ERR(4, "Invalid QP type=%x ehca_qp=%p qp_num=%x",
+			 ibqp->qp_type, my_qp, ibqp->qp_num);
+		goto modify_qp_exit1;
+	}
+
+	EDEB(7, "ehca_qp=%p qp_num=%x <VALID STATE CHANGE> qp_state_xsit=%x",
+	     my_qp, ibqp->qp_num, statetrans);
+
+	/* sqe -> rts: set purge bit of bad wqe before actual trans */
+	if ((my_qp->qp_type == IB_QPT_UD ||
+	     my_qp->qp_type == IB_QPT_GSI ||
+	     my_qp->qp_type == IB_QPT_SMI) &&
+	    statetrans == IB_QPST_SQE2RTS) {
+		/* mark next free wqe if kernel */
+		if (my_qp->uspace_squeue == 0) {
+			struct ehca_wqe *wqe = NULL;
+			/* lock send queue */
+			spin_lock_irqsave(&my_qp->spinlock_s, spl_flags);
+			squeue_locked = 1;
+			/* mark next free wqe */
+			wqe = (struct ehca_wqe*)
+				ipz_qeit_get(&my_qp->ipz_squeue);
+			wqe->optype = wqe->wqef = 0xff;
+			EDEB(7, "qp_num=%x next_free_wqe=%p",
+			     ibqp->qp_num, wqe);
+		}
+		ret = prepare_sqe_rts(my_qp, shca, &bad_wqe_cnt);
+		if (ret) {
+			EDEB_ERR(4, "prepare_sqe_rts() failed "
+				 "ehca_qp=%p qp_num=%x ret=%x",
+				 my_qp, ibqp->qp_num, ret);
+			goto modify_qp_exit2;
+		}
+	}
+
+	/* enable RDMA_Atomic_Control if reset->init und reliable con
+	   this is necessary since gen2 does not provide that flag,
+	   but pHyp requires it */
+	if (statetrans == IB_QPST_RESET2INIT &&
+	    (ibqp->qp_type == IB_QPT_RC || ibqp->qp_type == IB_QPT_UC)) {
+		mqpcb->rdma_atomic_ctrl = 3;
+		update_mask |= EHCA_BMASK_SET(MQPCB_MASK_RDMA_ATOMIC_CTRL, 1);
+	}
+	/* circ. pHyp requires #RDMA/Atomic Resp Res for UC INIT -> RTR */
+	if (statetrans == IB_QPST_INIT2RTR &&
+	    (ibqp->qp_type == IB_QPT_UC) &&
+	    !(attr_mask & IB_QP_MAX_DEST_RD_ATOMIC)) {
+		mqpcb->rdma_nr_atomic_resp_res = 1; /* default to 1 */
+		update_mask |=
+			EHCA_BMASK_SET(MQPCB_MASK_RDMA_NR_ATOMIC_RESP_RES, 1);
+	}
+
+	if (attr_mask & IB_QP_PKEY_INDEX) {
+		mqpcb->prim_p_key_idx = attr->pkey_index;
+		update_mask |= EHCA_BMASK_SET(MQPCB_MASK_PRIM_P_KEY_IDX, 1);
+		EDEB(7, "ehca_qp=%p qp_num=%x "
+		     "IB_QP_PKEY_INDEX update_mask=%lx",
+		     my_qp, ibqp->qp_num, update_mask);
+	}
+	if (attr_mask & IB_QP_PORT) {
+		if (attr->port_num < 1 || attr->port_num > shca->num_ports) {
+			ret = -EINVAL;
+			EDEB_ERR(4, "Invalid port=%x. "
+				 "ehca_qp=%p qp_num=%x num_ports=%x",
+				 attr->port_num, my_qp, ibqp->qp_num,
+				 shca->num_ports);
+			goto modify_qp_exit2;
+		}
+		mqpcb->prim_phys_port = attr->port_num;
+		update_mask |= EHCA_BMASK_SET(MQPCB_MASK_PRIM_PHYS_PORT, 1);
+		EDEB(7, "ehca_qp=%p qp_num=%x IB_QP_PORT update_mask=%lx",
+		     my_qp, ibqp->qp_num, update_mask);
+	}
+	if (attr_mask & IB_QP_QKEY) {
+		mqpcb->qkey = attr->qkey;
+		update_mask |= EHCA_BMASK_SET(MQPCB_MASK_QKEY, 1);
+		EDEB(7, "ehca_qp=%p qp_num=%x IB_QP_QKEY update_mask=%lx",
+		     my_qp, ibqp->qp_num, update_mask);
+	}
+	if (attr_mask & IB_QP_AV) {
+		int ah_mult = ib_rate_to_mult(attr->ah_attr.static_rate);
+		int ehca_mult = ib_rate_to_mult(shca->sport[my_qp->
+						init_attr.port_num].rate);
+
+		mqpcb->dlid = attr->ah_attr.dlid;
+		update_mask |= EHCA_BMASK_SET(MQPCB_MASK_DLID, 1);
+		mqpcb->source_path_bits = attr->ah_attr.src_path_bits;
+		update_mask |= EHCA_BMASK_SET(MQPCB_MASK_SOURCE_PATH_BITS, 1);
+		mqpcb->service_level = attr->ah_attr.sl;
+		update_mask |= EHCA_BMASK_SET(MQPCB_MASK_SERVICE_LEVEL, 1);
+
+                if (ah_mult < ehca_mult)
+			mqpcb->max_static_rate = (ah_mult > 0) ?
+			((ehca_mult - 1) / ah_mult) : 0;
+		else
+			mqpcb->max_static_rate = 0;
+
+		EDEB(7, " ipd=mqpcb->max_static_rate set %x "
+			" ah_mult=%x  ehca_mult=%x "
+			" attr->ah_attr.static_rate=%x",
+		     mqpcb->max_static_rate,ah_mult,ehca_mult,
+		     attr->ah_attr.static_rate);
+
+		update_mask |= EHCA_BMASK_SET(MQPCB_MASK_MAX_STATIC_RATE, 1);
+
+		/* only if GRH is TRUE we might consider SOURCE_GID_IDX
+		 * and DEST_GID otherwise phype will return H_ATTR_PARM!!!
+		 */
+		if (attr->ah_attr.ah_flags == IB_AH_GRH) {
+			mqpcb->send_grh_flag = 1 << 31;
+			update_mask |=
+				EHCA_BMASK_SET(MQPCB_MASK_SEND_GRH_FLAG, 1);
+			mqpcb->source_gid_idx = attr->ah_attr.grh.sgid_index;
+			update_mask |=
+				EHCA_BMASK_SET(MQPCB_MASK_SOURCE_GID_IDX, 1);
+
+			for (cnt = 0; cnt < 16; cnt++)
+				mqpcb->dest_gid.byte[cnt] =
+					attr->ah_attr.grh.dgid.raw[cnt];
+
+			update_mask |= EHCA_BMASK_SET(MQPCB_MASK_DEST_GID, 1);
+			mqpcb->flow_label = attr->ah_attr.grh.flow_label;
+			update_mask |= EHCA_BMASK_SET(MQPCB_MASK_FLOW_LABEL, 1);
+			mqpcb->hop_limit = attr->ah_attr.grh.hop_limit;
+			update_mask |= EHCA_BMASK_SET(MQPCB_MASK_HOP_LIMIT, 1);
+			mqpcb->traffic_class = attr->ah_attr.grh.traffic_class;
+			update_mask |=
+				EHCA_BMASK_SET(MQPCB_MASK_TRAFFIC_CLASS, 1);
+		}
+
+		EDEB(7, "ehca_qp=%p qp_num=%x IB_QP_AV update_mask=%lx",
+		     my_qp, ibqp->qp_num, update_mask);
+	}
+
+	if (attr_mask & IB_QP_PATH_MTU) {
+		mqpcb->path_mtu = attr->path_mtu;
+		update_mask |= EHCA_BMASK_SET(MQPCB_MASK_PATH_MTU, 1);
+		EDEB(7, "ehca_qp=%p qp_num=%x IB_QP_PATH_MTU update_mask=%lx",
+		     my_qp, ibqp->qp_num, update_mask);
+	}
+	if (attr_mask & IB_QP_TIMEOUT) {
+		mqpcb->timeout = attr->timeout;
+		update_mask |= EHCA_BMASK_SET(MQPCB_MASK_TIMEOUT, 1);
+		EDEB(7, "ehca_qp=%p qp_num=%x IB_QP_TIMEOUT update_mask=%lx",
+		     my_qp, ibqp->qp_num, update_mask);
+	}
+	if (attr_mask & IB_QP_RETRY_CNT) {
+		mqpcb->retry_count = attr->retry_cnt;
+		update_mask |= EHCA_BMASK_SET(MQPCB_MASK_RETRY_COUNT, 1);
+		EDEB(7, "ehca_qp=%p qp_num=%x IB_QP_RETRY_CNT update_mask=%lx",
+		     my_qp, ibqp->qp_num, update_mask);
+	}
+	if (attr_mask & IB_QP_RNR_RETRY) {
+		mqpcb->rnr_retry_count = attr->rnr_retry;
+		update_mask |= EHCA_BMASK_SET(MQPCB_MASK_RNR_RETRY_COUNT, 1);
+		EDEB(7, "ehca_qp=%p qp_num=%x IB_QP_RNR_RETRY update_mask=%lx",
+		     my_qp, ibqp->qp_num, update_mask);
+	}
+	if (attr_mask & IB_QP_RQ_PSN) {
+		mqpcb->receive_psn = attr->rq_psn;
+		update_mask |= EHCA_BMASK_SET(MQPCB_MASK_RECEIVE_PSN, 1);
+		EDEB(7, "ehca_qp=%p qp_num=%x IB_QP_RQ_PSN update_mask=%lx",
+		     my_qp, ibqp->qp_num, update_mask);
+	}
+	if (attr_mask & IB_QP_MAX_DEST_RD_ATOMIC) {
+		mqpcb->rdma_nr_atomic_resp_res = attr->max_dest_rd_atomic < 3 ?
+			attr->max_dest_rd_atomic : 2; /* max is 2 */
+		update_mask |=
+			EHCA_BMASK_SET(MQPCB_MASK_RDMA_NR_ATOMIC_RESP_RES, 1);
+		EDEB(7, "ehca_qp=%p qp_num=%x IB_QP_MAX_DEST_RD_ATOMIC "
+		     "update_mask=%lx", my_qp, ibqp->qp_num, update_mask);
+	}
+	if (attr_mask & IB_QP_MAX_QP_RD_ATOMIC) {
+		mqpcb->rdma_atomic_outst_dest_qp = attr->max_rd_atomic;
+		update_mask |=
+			EHCA_BMASK_SET
+			(MQPCB_MASK_RDMA_ATOMIC_OUTST_DEST_QP, 1);
+		EDEB(7, "ehca_qp=%p qp_num=%x IB_QP_MAX_QP_RD_ATOMIC "
+		     "update_mask=%lx", my_qp, ibqp->qp_num, update_mask);
+	}
+	if (attr_mask & IB_QP_ALT_PATH) {
+		int ah_mult = ib_rate_to_mult(attr->alt_ah_attr.static_rate);
+		int ehca_mult = ib_rate_to_mult(
+			shca->sport[my_qp->init_attr.port_num].rate);
+
+		mqpcb->dlid_al = attr->alt_ah_attr.dlid;
+		update_mask |= EHCA_BMASK_SET(MQPCB_MASK_DLID_AL, 1);
+		mqpcb->source_path_bits_al = attr->alt_ah_attr.src_path_bits;
+		update_mask |=
+			EHCA_BMASK_SET(MQPCB_MASK_SOURCE_PATH_BITS_AL, 1);
+		mqpcb->service_level_al = attr->alt_ah_attr.sl;
+		update_mask |= EHCA_BMASK_SET(MQPCB_MASK_SERVICE_LEVEL_AL, 1);
+
+		if (ah_mult < ehca_mult)
+			mqpcb->max_static_rate = (ah_mult > 0) ?
+			((ehca_mult - 1) / ah_mult) : 0;
+		else
+			mqpcb->max_static_rate_al = 0;
+
+		EDEB(7, " ipd=mqpcb->max_static_rate set %x,"
+			" ah_mult=%x ehca_mult=%x",
+		     mqpcb->max_static_rate,ah_mult,ehca_mult);
+
+		update_mask |= EHCA_BMASK_SET(MQPCB_MASK_MAX_STATIC_RATE_AL, 1);
+
+		/* only if GRH is TRUE we might consider SOURCE_GID_IDX
+		 * and DEST_GID otherwise phype will return H_ATTR_PARM!!!
+		 */
+		if (attr->alt_ah_attr.ah_flags == IB_AH_GRH) {
+			mqpcb->send_grh_flag_al = 1 << 31;
+			update_mask |=
+				EHCA_BMASK_SET(MQPCB_MASK_SEND_GRH_FLAG_AL, 1);
+			mqpcb->source_gid_idx_al =
+				attr->alt_ah_attr.grh.sgid_index;
+			update_mask |=
+				EHCA_BMASK_SET(MQPCB_MASK_SOURCE_GID_IDX_AL, 1);
+
+			for (cnt = 0; cnt < 16; cnt++)
+				mqpcb->dest_gid_al.byte[cnt] =
+					attr->alt_ah_attr.grh.dgid.raw[cnt];
+
+			update_mask |=
+				EHCA_BMASK_SET(MQPCB_MASK_DEST_GID_AL, 1);
+			mqpcb->flow_label_al = attr->alt_ah_attr.grh.flow_label;
+			update_mask |=
+				EHCA_BMASK_SET(MQPCB_MASK_FLOW_LABEL_AL, 1);
+			mqpcb->hop_limit_al = attr->alt_ah_attr.grh.hop_limit;
+			update_mask |=
+				EHCA_BMASK_SET(MQPCB_MASK_HOP_LIMIT_AL, 1);
+			mqpcb->traffic_class_al =
+				attr->alt_ah_attr.grh.traffic_class;
+			update_mask |=
+				EHCA_BMASK_SET(MQPCB_MASK_TRAFFIC_CLASS_AL, 1);
+		}
+
+		EDEB(7, "ehca_qp=%p qp_num=%x IB_QP_ALT_PATH update_mask=%lx",
+		     my_qp, ibqp->qp_num, update_mask);
+	}
+
+	if (attr_mask & IB_QP_MIN_RNR_TIMER) {
+		mqpcb->min_rnr_nak_timer_field = attr->min_rnr_timer;
+		update_mask |=
+			EHCA_BMASK_SET(MQPCB_MASK_MIN_RNR_NAK_TIMER_FIELD, 1);
+		EDEB(7, "ehca_qp=%p qp_num=%x "
+		     "IB_QP_MIN_RNR_TIMER update_mask=%lx",
+		     my_qp, ibqp->qp_num, update_mask);
+	}
+
+	if (attr_mask & IB_QP_SQ_PSN) {
+		mqpcb->send_psn = attr->sq_psn;
+		update_mask |= EHCA_BMASK_SET(MQPCB_MASK_SEND_PSN, 1);
+		EDEB(7, "ehca_qp=%p qp_num=%x "
+		     "IB_QP_SQ_PSN update_mask=%lx",
+		     my_qp, ibqp->qp_num, update_mask);
+	}
+
+	if (attr_mask & IB_QP_DEST_QPN) {
+		mqpcb->dest_qp_nr = attr->dest_qp_num;
+		update_mask |= EHCA_BMASK_SET(MQPCB_MASK_DEST_QP_NR, 1);
+		EDEB(7, "ehca_qp=%p qp_num=%x "
+		     "IB_QP_DEST_QPN update_mask=%lx",
+		     my_qp, ibqp->qp_num, update_mask);
+	}
+
+	if (attr_mask & IB_QP_PATH_MIG_STATE) {
+		mqpcb->path_migration_state = attr->path_mig_state;
+		update_mask |=
+			EHCA_BMASK_SET(MQPCB_MASK_PATH_MIGRATION_STATE, 1);
+		EDEB(7, "ehca_qp=%p qp_num=%x "
+		     "IB_QP_PATH_MIG_STATE update_mask=%lx", my_qp,
+		     ibqp->qp_num, update_mask);
+	}
+
+	if (attr_mask & IB_QP_CAP) {
+		mqpcb->max_nr_outst_send_wr = attr->cap.max_send_wr+1;
+		update_mask |=
+			EHCA_BMASK_SET(MQPCB_MASK_MAX_NR_OUTST_SEND_WR, 1);
+		mqpcb->max_nr_outst_recv_wr = attr->cap.max_recv_wr+1;
+		update_mask |=
+			EHCA_BMASK_SET(MQPCB_MASK_MAX_NR_OUTST_RECV_WR, 1);
+		EDEB(7, "ehca_qp=%p qp_num=%x "
+		     "IB_QP_CAP update_mask=%lx",
+		     my_qp, ibqp->qp_num, update_mask);
+		/* no support for max_send/recv_sge yet */
+	}
+
+	EDEB_DMP(7, mqpcb, 4*70, "ehca_qp=%p qp_num=%x", my_qp, ibqp->qp_num);
+
+	h_ret = hipz_h_modify_qp(shca->ipz_hca_handle,
+				 my_qp->ipz_qp_handle,
+				 &my_qp->pf,
+				 update_mask,
+				 mqpcb, my_qp->galpas.kernel);
+
+	if (h_ret != H_SUCCESS) {
+		ret = ehca2ib_return_code(h_ret);
+		EDEB_ERR(4, "hipz_h_modify_qp() failed rc=%lx "
+			 "ehca_qp=%p qp_num=%x",
+			 h_ret, my_qp, ibqp->qp_num);
+		goto modify_qp_exit2;
+	}
+
+	if ((my_qp->qp_type == IB_QPT_UD ||
+	     my_qp->qp_type == IB_QPT_GSI ||
+	     my_qp->qp_type == IB_QPT_SMI) &&
+	    statetrans == IB_QPST_SQE2RTS) {
+		/* doorbell to reprocessing wqes */
+		iosync(); /* serialize GAL register access */
+		hipz_update_sqa(my_qp, bad_wqe_cnt-1);
+		EDEB(6, "doorbell for %x wqes", bad_wqe_cnt);
+	}
+
+	if (statetrans == IB_QPST_RESET2INIT ||
+	    statetrans == IB_QPST_INIT2INIT) {
+		mqpcb->qp_enable = 1;
+		mqpcb->qp_state = EHCA_QPS_INIT;
+		update_mask = 0;
+		update_mask = EHCA_BMASK_SET(MQPCB_MASK_QP_ENABLE, 1);
+
+		EDEB(7, "ehca_qp=%p qp_num=%x "
+		     "RESET_2_INIT needs an additional enable "
+		     "-> update_mask=%lx", my_qp, ibqp->qp_num, update_mask);
+
+		h_ret = hipz_h_modify_qp(shca->ipz_hca_handle,
+					 my_qp->ipz_qp_handle,
+					 &my_qp->pf,
+					 update_mask,
+					 mqpcb,
+					 my_qp->galpas.kernel);
+
+		if (h_ret != H_SUCCESS) {
+			ret = ehca2ib_return_code(h_ret);
+			EDEB_ERR(4, "ENABLE in context of "
+				 "RESET_2_INIT failed! "
+				 "Maybe you didn't get a LID"
+				 "h_ret=%lx ehca_qp=%p qp_num=%x",
+				 h_ret, my_qp, ibqp->qp_num);
+			goto modify_qp_exit2;
+		}
+	}
+
+	if (statetrans == IB_QPST_ANY2RESET) {
+		ipz_qeit_reset(&my_qp->ipz_rqueue);
+		ipz_qeit_reset(&my_qp->ipz_squeue);
+	}
+
+	if (attr_mask & IB_QP_QKEY)
+		my_qp->qkey = attr->qkey;
+
+modify_qp_exit2:
+	if (squeue_locked) { /* this means: sqe -> rts */
+		spin_unlock_irqrestore(&my_qp->spinlock_s, spl_flags);
+		my_qp->sqerr_purgeflag = 1;
+	}
+
+modify_qp_exit1:
+	kfree(mqpcb);
+
+modify_qp_exit0:
+	EDEB_EX(7, "ehca_qp=%p qp_num=%x ibqp_type=%x ret=%x",
+		my_qp, ibqp->qp_num, ibqp->qp_type, ret);
+	return ret;
+}
+
+int ehca_modify_qp(struct ib_qp *ibqp, struct ib_qp_attr *attr, int attr_mask)
+{
+	int ret = 0;
+	struct ehca_qp *my_qp = NULL;
+	struct ehca_pd *my_pd = NULL;
+	u32 cur_pid = current->tgid;
+
+	EHCA_CHECK_ADR(ibqp);
+	EHCA_CHECK_ADR(attr);
+	EHCA_CHECK_ADR(ibqp->device);
+
+	my_qp = container_of(ibqp, struct ehca_qp, ib_qp);
+
+	EDEB_EN(7, "ehca_qp=%p qp_num=%x ibqp_type=%x attr_mask=%x",
+		my_qp, ibqp->qp_num, ibqp->qp_type, attr_mask);
+
+	my_pd = container_of(my_qp->ib_qp.pd, struct ehca_pd, ib_pd);
+	if (my_pd->ib_pd.uobject && my_pd->ib_pd.uobject->context &&
+	    my_pd->ownpid != cur_pid) {
+		EDEB_ERR(4, "Invalid caller pid=%x ownpid=%x",
+			 cur_pid, my_pd->ownpid);
+		ret = -EINVAL;
+	} else
+		ret = internal_modify_qp(ibqp, attr, attr_mask, 0);
+
+	EDEB_EX(7, "ehca_qp=%p qp_num=%x ibqp_type=%x ret=%x",
+		my_qp, ibqp->qp_num, ibqp->qp_type, ret);
+	return ret;
+}
+
+int ehca_query_qp(struct ib_qp *qp,
+		  struct ib_qp_attr *qp_attr,
+		  int qp_attr_mask, struct ib_qp_init_attr *qp_init_attr)
+{
+	struct ehca_qp *my_qp = NULL;
+	struct ehca_shca *shca = NULL;
+	struct hcp_modify_qp_control_block *qpcb = NULL;
+	struct ipz_adapter_handle adapter_handle;
+	struct ehca_pd *my_pd = NULL;
+	u32 cur_pid = current->tgid;
+	int cnt = 0, ret = 0;
+	u64 h_ret = H_SUCCESS;
+
+	EHCA_CHECK_ADR(qp);
+	EHCA_CHECK_ADR(qp_attr);
+	EHCA_CHECK_DEVICE(qp->device);
+
+	my_qp = container_of(qp, struct ehca_qp, ib_qp);
+
+	EDEB_EN(7, "ehca_qp=%p qp_num=%x "
+		"qp_attr=%p qp_attr_mask=%x qp_init_attr=%p",
+		my_qp, qp->qp_num, qp_attr, qp_attr_mask, qp_init_attr);
+
+	my_pd = container_of(my_qp->ib_qp.pd, struct ehca_pd, ib_pd);
+	if (my_pd->ib_pd.uobject  && my_pd->ib_pd.uobject->context  &&
+	    my_pd->ownpid != cur_pid) {
+		EDEB_ERR(4, "Invalid caller pid=%x ownpid=%x",
+			 cur_pid, my_pd->ownpid);
+		ret = -EINVAL;
+		goto query_qp_exit0;
+	}
+
+	shca = container_of(qp->device, struct ehca_shca, ib_device);
+	adapter_handle = shca->ipz_hca_handle;
+
+	if (qp_attr_mask & QP_ATTR_QUERY_NOT_SUPPORTED) {
+		ret = -EINVAL;
+		EDEB_ERR(4,"Invalid attribute mask "
+			 "ehca_qp=%p qp_num=%x qp_attr_mask=%x ",
+			 my_qp, qp->qp_num, qp_attr_mask);
+		goto query_qp_exit0;
+	}
+
+	qpcb = kzalloc(H_CB_ALIGNMENT, GFP_KERNEL );
+	if (!qpcb) {
+		ret = -ENOMEM;
+		EDEB_ERR(4,"Out of memory for qpcb "
+			 "ehca_qp=%p qp_num=%x", my_qp, qp->qp_num);
+		goto query_qp_exit0;
+	}
+
+	h_ret = hipz_h_query_qp(adapter_handle,
+				my_qp->ipz_qp_handle,
+				&my_qp->pf,
+				qpcb, my_qp->galpas.kernel);
+
+	if (h_ret != H_SUCCESS) {
+		ret = ehca2ib_return_code(h_ret);
+		EDEB_ERR(4,"hipz_h_query_qp() failed "
+			 "ehca_qp=%p qp_num=%x h_ret=%lx",
+			 my_qp, qp->qp_num, h_ret);
+		goto query_qp_exit1;
+	}
+
+	qp_attr->cur_qp_state = ehca2ib_qp_state(qpcb->qp_state);
+	qp_attr->qp_state = qp_attr->cur_qp_state;
+	if (qp_attr->cur_qp_state == -EINVAL) {
+		ret = -EINVAL;
+		EDEB_ERR(4,"Got invalid ehca_qp_state=%x "
+			 "ehca_qp=%p qp_num=%x",
+			 qpcb->qp_state, my_qp, qp->qp_num);
+		goto query_qp_exit1;
+	}
+
+	if (qp_attr->qp_state == IB_QPS_SQD)
+		qp_attr->sq_draining = 1;
+
+	qp_attr->qkey = qpcb->qkey;
+	qp_attr->path_mtu = qpcb->path_mtu;
+	qp_attr->path_mig_state = qpcb->path_migration_state;
+	qp_attr->rq_psn = qpcb->receive_psn;
+	qp_attr->sq_psn = qpcb->send_psn;
+	qp_attr->min_rnr_timer = qpcb->min_rnr_nak_timer_field;
+	qp_attr->cap.max_send_wr = qpcb->max_nr_outst_send_wr-1;
+	qp_attr->cap.max_recv_wr = qpcb->max_nr_outst_recv_wr-1;
+	/* UD_AV CIRCUMVENTION */
+	if (my_qp->qp_type == IB_QPT_UD) {
+		qp_attr->cap.max_send_sge =
+			qpcb->actual_nr_sges_in_sq_wqe - 2;
+		qp_attr->cap.max_recv_sge =
+			qpcb->actual_nr_sges_in_rq_wqe - 2;
+	} else {
+		qp_attr->cap.max_send_sge =
+			qpcb->actual_nr_sges_in_sq_wqe;
+		qp_attr->cap.max_recv_sge =
+			qpcb->actual_nr_sges_in_rq_wqe;
+	}
+
+	qp_attr->cap.max_inline_data = my_qp->sq_max_inline_data_size;
+	qp_attr->dest_qp_num = qpcb->dest_qp_nr;
+
+	qp_attr->pkey_index =
+		EHCA_BMASK_GET(MQPCB_PRIM_P_KEY_IDX, qpcb->prim_p_key_idx);
+
+	qp_attr->port_num =
+		EHCA_BMASK_GET(MQPCB_PRIM_PHYS_PORT, qpcb->prim_phys_port);
+
+	qp_attr->timeout = qpcb->timeout;
+	qp_attr->retry_cnt = qpcb->retry_count;
+	qp_attr->rnr_retry = qpcb->rnr_retry_count;
+
+	qp_attr->alt_pkey_index =
+		EHCA_BMASK_GET(MQPCB_PRIM_P_KEY_IDX, qpcb->alt_p_key_idx);
+
+	qp_attr->alt_port_num = qpcb->alt_phys_port;
+	qp_attr->alt_timeout = qpcb->timeout_al;
+
+	/* primary av */
+	qp_attr->ah_attr.sl = qpcb->service_level;
+
+	if (qpcb->send_grh_flag) {
+		qp_attr->ah_attr.ah_flags = IB_AH_GRH;
+	}
+
+	qp_attr->ah_attr.static_rate = qpcb->max_static_rate;
+	qp_attr->ah_attr.dlid = qpcb->dlid;
+	qp_attr->ah_attr.src_path_bits = qpcb->source_path_bits;
+	qp_attr->ah_attr.port_num = qp_attr->port_num;
+
+	/* primary GRH */
+	qp_attr->ah_attr.grh.traffic_class = qpcb->traffic_class;
+	qp_attr->ah_attr.grh.hop_limit = qpcb->hop_limit;
+	qp_attr->ah_attr.grh.sgid_index = qpcb->source_gid_idx;
+	qp_attr->ah_attr.grh.flow_label = qpcb->flow_label;
+
+	for (cnt = 0; cnt < 16; cnt++)
+		qp_attr->ah_attr.grh.dgid.raw[cnt] =
+			qpcb->dest_gid.byte[cnt];
+
+	/* alternate AV */
+	qp_attr->alt_ah_attr.sl = qpcb->service_level_al;
+	if (qpcb->send_grh_flag_al) {
+		qp_attr->alt_ah_attr.ah_flags = IB_AH_GRH;
+	}
+
+	qp_attr->alt_ah_attr.static_rate = qpcb->max_static_rate_al;
+	qp_attr->alt_ah_attr.dlid = qpcb->dlid_al;
+	qp_attr->alt_ah_attr.src_path_bits = qpcb->source_path_bits_al;
+
+	/* alternate GRH */
+	qp_attr->alt_ah_attr.grh.traffic_class = qpcb->traffic_class_al;
+	qp_attr->alt_ah_attr.grh.hop_limit = qpcb->hop_limit_al;
+	qp_attr->alt_ah_attr.grh.sgid_index = qpcb->source_gid_idx_al;
+	qp_attr->alt_ah_attr.grh.flow_label = qpcb->flow_label_al;
+
+	for (cnt = 0; cnt < 16; cnt++)
+		qp_attr->alt_ah_attr.grh.dgid.raw[cnt] =
+			qpcb->dest_gid_al.byte[cnt];
+
+	/* return init attributes given in ehca_create_qp */
+	if (qp_init_attr)
+		*qp_init_attr = my_qp->init_attr;
+
+	EDEB(7,	"ehca_qp=%p qp_number=%x dest_qp_number=%x "
+	     "dlid=%x path_mtu=%x dest_gid=%lx_%lx "
+	     "service_level=%x qp_state=%x",
+	     my_qp, qpcb->qp_number, qpcb->dest_qp_nr,
+	     qpcb->dlid, qpcb->path_mtu,
+	     qpcb->dest_gid.dw[0], qpcb->dest_gid.dw[1],
+	     qpcb->service_level, qpcb->qp_state);
+
+	EDEB_DMP(7, qpcb, 4*70, "ehca_qp=%p qp_num=%x", my_qp, qp->qp_num);
+
+query_qp_exit1:
+	kfree(qpcb);
+
+query_qp_exit0:
+	EDEB_EX(7, "ehca_qp=%p qp_num=%x ret=%x",
+		my_qp, qp->qp_num, ret);
+	return ret;
+}
+
+int ehca_destroy_qp(struct ib_qp *ibqp)
+{
+	extern struct ehca_module ehca_module;
+	struct ehca_qp *my_qp = NULL;
+	struct ehca_shca *shca = NULL;
+	struct ehca_pfqp *qp_pf = NULL;
+	struct ehca_pd *my_pd = NULL;
+	u32 cur_pid = current->tgid;
+	u32 qp_num = 0;
+	int ret = 0;
+	u64 h_ret = H_SUCCESS;
+	u8 port_num = 0;
+	enum ib_qp_type	qp_type;
+	unsigned long flags;
+
+	EHCA_CHECK_ADR(ibqp);
+
+	my_qp = container_of(ibqp, struct ehca_qp, ib_qp);
+	qp_num = ibqp->qp_num;
+	qp_pf = &my_qp->pf;
+
+	shca = container_of(ibqp->device, struct ehca_shca, ib_device);
+
+	EDEB_EN(7, "ehca_qp=%p qp_num=%x", my_qp, ibqp->qp_num);
+
+	my_pd = container_of(my_qp->ib_qp.pd, struct ehca_pd, ib_pd);
+	if (my_pd->ib_pd.uobject && my_pd->ib_pd.uobject->context &&
+	    my_pd->ownpid != cur_pid) {
+		EDEB_ERR(4, "Invalid caller pid=%x ownpid=%x",
+			 cur_pid, my_pd->ownpid);
+		return -EINVAL;
+	}
+
+	if (my_qp->send_cq) {
+		ret = ehca_cq_unassign_qp(my_qp->send_cq,
+					      my_qp->real_qp_num);
+		if (ret) {
+			EDEB_ERR(4, "Couldn't unassign qp from send_cq "
+				 "ret=%x qp_num=%x cq_num=%x",
+				 ret, my_qp->ib_qp.qp_num,
+				 my_qp->send_cq->cq_number);
+			goto destroy_qp_exit0;
+		}
+	}
+
+	spin_lock_irqsave(&ehca_qp_idr_lock, flags);
+	idr_remove(&ehca_qp_idr, my_qp->token);
+	spin_unlock_irqrestore(&ehca_qp_idr_lock, flags);
+
+	/* un-mmap if vma alloc */
+	if (my_qp->uspace_rqueue) {
+		ret = ehca_munmap(my_qp->uspace_rqueue,
+				  my_qp->ipz_rqueue.queue_length);
+		ret = ehca_munmap(my_qp->uspace_squeue,
+				  my_qp->ipz_squeue.queue_length);
+		ret = ehca_munmap(my_qp->uspace_fwh, 4096);
+	}
+
+	h_ret = hipz_h_destroy_qp(shca->ipz_hca_handle, my_qp);
+	if (h_ret != H_SUCCESS) {
+		EDEB_ERR(4, "hipz_h_destroy_qp() failed "
+			 "rc=%lx ehca_qp=%p qp_num=%x",
+			 h_ret, qp_pf, qp_num);
+		goto destroy_qp_exit0;
+	}
+
+	port_num = my_qp->init_attr.port_num;
+	qp_type  = my_qp->init_attr.qp_type;
+
+	/* no support for IB_QPT_SMI yet */
+	if (qp_type == IB_QPT_GSI) {
+		struct ib_event event;
+
+		EDEB(4, "device %s: port %x is inactive.",
+		     shca->ib_device.name, port_num);
+		event.device = &shca->ib_device;
+		event.event = IB_EVENT_PORT_ERR;
+		event.element.port_num = port_num;
+		shca->sport[port_num - 1].port_state = IB_PORT_DOWN;
+		ib_dispatch_event(&event);
+	}
+
+	ipz_queue_dtor(&my_qp->ipz_rqueue);
+	ipz_queue_dtor(&my_qp->ipz_squeue);
+	kmem_cache_free(ehca_module.cache_qp, my_qp);
+
+destroy_qp_exit0:
+	ret = ehca2ib_return_code(h_ret);
+	EDEB_EX(7,"ret=%x", ret);
+	return ret;
+}
--- linux-2.6.17-rc2-orig/drivers/infiniband/hw/ehca/ehca_reqs.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.17-rc2/drivers/infiniband/hw/ehca/ehca_reqs.c	2006-05-15 08:09:49.000000000 +0200
@@ -0,0 +1,683 @@
+/*
+ *  IBM eServer eHCA Infiniband device driver for Linux on POWER
+ *
+ *  post_send/recv, poll_cq, req_notify
+ *
+ *  Authors: Waleri Fomin <fomin@de.ibm.com>
+ *           Hoang-Nam Nguyen <hnguyen@de.ibm.com>
+ *           Reinhard Ernst <rernst@de.ibm.com>
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
+
+#define DEB_PREFIX "reqs"
+
+#include "ehca_classes.h"
+#include "ehca_tools.h"
+#include "ehca_qes.h"
+#include "ehca_iverbs.h"
+#include "hcp_if.h"
+#include "hipz_fns.h"
+
+static inline int ehca_write_rwqe(struct ipz_queue *ipz_rqueue,
+				  struct ehca_wqe *wqe_p,
+				  struct ib_recv_wr *recv_wr)
+{
+	u8 cnt_ds;
+	if (unlikely((recv_wr->num_sge < 0) ||
+		     (recv_wr->num_sge > ipz_rqueue->act_nr_of_sg))) {
+		EDEB_ERR(4, "Invalid number of WQE SGE. "
+			 "num_sqe=%x max_nr_of_sg=%x",
+			 recv_wr->num_sge, ipz_rqueue->act_nr_of_sg);
+		return -EINVAL; /* invalid SG list length */
+	}
+
+	/* clear wqe header until sglist */
+	memset(wqe_p, 0, offsetof(struct ehca_wqe, u.ud_av.sg_list));
+
+	wqe_p->work_request_id = be64_to_cpu(recv_wr->wr_id);
+	wqe_p->nr_of_data_seg = recv_wr->num_sge;
+
+	for (cnt_ds = 0; cnt_ds < recv_wr->num_sge; cnt_ds++) {
+		wqe_p->u.all_rcv.sg_list[cnt_ds].vaddr =
+		    be64_to_cpu(recv_wr->sg_list[cnt_ds].addr);
+		wqe_p->u.all_rcv.sg_list[cnt_ds].lkey =
+		    ntohl(recv_wr->sg_list[cnt_ds].lkey);
+		wqe_p->u.all_rcv.sg_list[cnt_ds].length =
+		    ntohl(recv_wr->sg_list[cnt_ds].length);
+	}
+
+	if (IS_EDEB_ON(7)) {
+		EDEB(7, "RECEIVE WQE written into ipz_rqueue=%p", ipz_rqueue);
+		EDEB_DMP(7, wqe_p, 16*(6 + wqe_p->nr_of_data_seg), "recv wqe");
+	}
+
+	return 0;
+}
+
+#if defined(DEBUG_GSI_SEND_WR)
+
+/* need ib_mad struct */
+#include <rdma/ib_mad.h>
+
+static void trace_send_wr_ud(const struct ib_send_wr *send_wr)
+{
+	int idx = 0;
+	int j = 0;
+	while (send_wr) {
+		struct ib_mad_hdr *mad_hdr = send_wr->wr.ud.mad_hdr;
+		struct ib_sge *sge = send_wr->sg_list;
+		EDEB(4, "send_wr#%x wr_id=%lx num_sge=%x "
+		     "send_flags=%x opcode=%x",idx, send_wr->wr_id,
+		     send_wr->num_sge, send_wr->send_flags, send_wr->opcode);
+		if (mad_hdr) {
+			EDEB(4, "send_wr#%x mad_hdr base_version=%x "
+			     "mgmt_class=%x class_version=%x method=%x "
+			     "status=%x class_specific=%x tid=%lx attr_id=%x "
+			     "resv=%x attr_mod=%x",
+			     idx, mad_hdr->base_version, mad_hdr->mgmt_class,
+			     mad_hdr->class_version, mad_hdr->method,
+			     mad_hdr->status, mad_hdr->class_specific,
+			     mad_hdr->tid, mad_hdr->attr_id, mad_hdr->resv,
+			     mad_hdr->attr_mod);
+		}
+		for (j = 0; j < send_wr->num_sge; j++) {
+			u8 *data = (u8 *) abs_to_virt(sge->addr);
+			EDEB(4, "send_wr#%x sge#%x addr=%p length=%x lkey=%x",
+			     idx, j, data, sge->length, sge->lkey);
+			/* assume length is n*16 */
+			EDEB_DMP(4, data, sge->length, "send_wr#%x sge#%x",
+				 idx, j);
+			sge++;
+		} /* eof for j */
+		idx++;
+		send_wr = send_wr->next;
+	} /* eof while send_wr */
+}
+
+#endif /* DEBUG_GSI_SEND_WR */
+
+static inline int ehca_write_swqe(struct ehca_qp *qp,
+				  struct ehca_wqe *wqe_p,
+				  const struct ib_send_wr *send_wr)
+{
+	u32 idx;
+	u64 dma_length;
+	struct ehca_av *my_av;
+	u32 remote_qkey = send_wr->wr.ud.remote_qkey;
+
+	if (unlikely((send_wr->num_sge < 0) ||
+		     (send_wr->num_sge > qp->ipz_squeue.act_nr_of_sg))) {
+		EDEB_ERR(4, "Invalid number of WQE SGE. "
+			 "num_sqe=%x max_nr_of_sg=%x",
+			 send_wr->num_sge, qp->ipz_squeue.act_nr_of_sg);
+		return -EINVAL; /* invalid SG list length */
+	}
+
+	/* clear wqe header until sglist */
+	memset(wqe_p, 0, offsetof(struct ehca_wqe, u.ud_av.sg_list));
+
+	wqe_p->work_request_id = be64_to_cpu(send_wr->wr_id);
+
+	switch (send_wr->opcode) {
+	case IB_WR_SEND:
+	case IB_WR_SEND_WITH_IMM:
+		wqe_p->optype = WQE_OPTYPE_SEND;
+		break;
+	case IB_WR_RDMA_WRITE:
+	case IB_WR_RDMA_WRITE_WITH_IMM:
+		wqe_p->optype = WQE_OPTYPE_RDMAWRITE;
+		break;
+	case IB_WR_RDMA_READ:
+		wqe_p->optype = WQE_OPTYPE_RDMAREAD;
+		break;
+	default:
+		EDEB_ERR(4, "Invalid opcode=%x", send_wr->opcode);
+		return -EINVAL; /* invalid opcode */
+	}
+
+	wqe_p->wqef = (send_wr->opcode) & WQEF_HIGH_NIBBLE;
+
+	wqe_p->wr_flag = 0;
+
+	if (send_wr->send_flags & IB_SEND_SIGNALED)
+		wqe_p->wr_flag |= WQE_WRFLAG_REQ_SIGNAL_COM;
+
+	if (send_wr->opcode == IB_WR_SEND_WITH_IMM ||
+	    send_wr->opcode == IB_WR_RDMA_WRITE_WITH_IMM) {
+		/* this might not work as long as HW does not support it */
+		wqe_p->immediate_data = send_wr->imm_data;
+		wqe_p->wr_flag |= WQE_WRFLAG_IMM_DATA_PRESENT;
+	}
+
+	wqe_p->nr_of_data_seg = send_wr->num_sge;
+
+	switch (qp->qp_type) {
+	case IB_QPT_SMI:
+	case IB_QPT_GSI:
+		/* no break is intential here */
+	case IB_QPT_UD:
+		/* IB 1.2 spec C10-15 compliance */
+		if (send_wr->wr.ud.remote_qkey & 0x80000000)
+			remote_qkey = qp->qkey;
+
+		wqe_p->destination_qp_number =
+		    ntohl(send_wr->wr.ud.remote_qpn << 8);
+		wqe_p->local_ee_context_qkey = ntohl(remote_qkey);
+		if (!send_wr->wr.ud.ah) {
+			EDEB_ERR(4, "wr.ud.ah is NULL. qp=%p", qp);
+			return -EINVAL;
+		}
+		my_av = container_of(send_wr->wr.ud.ah, struct ehca_av, ib_ah);
+		wqe_p->u.ud_av.ud_av = my_av->av;
+
+		/* omitted check of IB_SEND_INLINE
+		   since HW does not support it */
+		for (idx = 0; idx < send_wr->num_sge; idx++) {
+			wqe_p->u.ud_av.sg_list[idx].vaddr =
+			    be64_to_cpu(send_wr->sg_list[idx].addr);
+			wqe_p->u.ud_av.sg_list[idx].lkey =
+			    ntohl(send_wr->sg_list[idx].lkey);
+			wqe_p->u.ud_av.sg_list[idx].length =
+			    ntohl(send_wr->sg_list[idx].length);
+		} /* eof for idx */
+		if (qp->qp_type == IB_QPT_SMI ||
+		    qp->qp_type == IB_QPT_GSI)
+			wqe_p->u.ud_av.ud_av.pmtu = 1;
+		if (qp->qp_type == IB_QPT_GSI) {
+			wqe_p->pkeyi =
+			    ntohs(send_wr->wr.ud.pkey_index);
+#ifdef DEBUG_GSI_SEND_WR
+			trace_send_wr_ud(send_wr);
+#endif /* DEBUG_GSI_SEND_WR */
+		}
+		break;
+
+	case IB_QPT_UC:
+		if (send_wr->send_flags & IB_SEND_FENCE)
+			wqe_p->wr_flag |= WQE_WRFLAG_FENCE;
+		/* no break is intentional here */
+	case IB_QPT_RC:
+		/* TODO: atomic not implemented */
+		wqe_p->u.nud.remote_virtual_adress =
+		    be64_to_cpu(send_wr->wr.rdma.remote_addr);
+		wqe_p->u.nud.rkey = ntohl(send_wr->wr.rdma.rkey);
+
+		/* omitted checking of IB_SEND_INLINE
+		   since HW does not support it */
+		dma_length = 0;
+		for (idx = 0; idx < send_wr->num_sge; idx++) {
+			wqe_p->u.nud.sg_list[idx].vaddr =
+			    be64_to_cpu(send_wr->sg_list[idx].addr);
+			wqe_p->u.nud.sg_list[idx].lkey =
+			    ntohl(send_wr->sg_list[idx].lkey);
+			wqe_p->u.nud.sg_list[idx].length =
+			    ntohl(send_wr->sg_list[idx].length);
+			dma_length += send_wr->sg_list[idx].length;
+		} /* eof idx */
+		wqe_p->u.nud.atomic_1st_op_dma_len = be64_to_cpu(dma_length);
+
+		break;
+
+	default:
+		EDEB_ERR(4, "Invalid qptype=%x", qp->qp_type);
+		return -EINVAL;
+	}
+
+	if (IS_EDEB_ON(7)) {
+		EDEB(7, "SEND WQE written into queue qp=%p ", qp);
+		EDEB_DMP(7, wqe_p, 16*(6 + wqe_p->nr_of_data_seg), "send wqe");
+	}
+	return 0;
+}
+
+/** map_ib_wc_status - convert raw cqe_status to ib_wc_status
+ */
+static inline void map_ib_wc_status(u32 cqe_status,
+				    enum ib_wc_status *wc_status)
+{
+	if (unlikely(cqe_status & WC_STATUS_ERROR_BIT)) {
+		switch (cqe_status & 0x3F) {
+		case 0x01:
+		case 0x21:
+			*wc_status = IB_WC_LOC_LEN_ERR;
+			break;
+		case 0x02:
+		case 0x22:
+			*wc_status = IB_WC_LOC_QP_OP_ERR;
+			break;
+		case 0x03:
+		case 0x23:
+			*wc_status = IB_WC_LOC_EEC_OP_ERR;
+			break;
+		case 0x04:
+		case 0x24:
+			*wc_status = IB_WC_LOC_PROT_ERR;
+			break;
+		case 0x05:
+		case 0x25:
+			*wc_status = IB_WC_WR_FLUSH_ERR;
+			break;
+		case 0x06:
+			*wc_status = IB_WC_MW_BIND_ERR;
+			break;
+		case 0x07: /* remote error - look into bits 20:24 */
+			switch ((cqe_status
+				 & WC_STATUS_REMOTE_ERROR_FLAGS) >> 11) {
+			case 0x0:
+				/* PSN Sequence Error!
+				   couldn't find a matching status! */
+				*wc_status = IB_WC_GENERAL_ERR;
+				break;
+			case 0x1:
+				*wc_status = IB_WC_REM_INV_REQ_ERR;
+				break;
+			case 0x2:
+				*wc_status = IB_WC_REM_ACCESS_ERR;
+				break;
+			case 0x3:
+				*wc_status = IB_WC_REM_OP_ERR;
+				break;
+			case 0x4:
+				*wc_status = IB_WC_REM_INV_RD_REQ_ERR;
+				break;
+			}
+			break;
+		case 0x08:
+			*wc_status = IB_WC_RETRY_EXC_ERR;
+			break;
+		case 0x09:
+			*wc_status = IB_WC_RNR_RETRY_EXC_ERR;
+			break;
+		case 0x0A:
+		case 0x2D:
+			*wc_status = IB_WC_REM_ABORT_ERR;
+			break;
+		case 0x0B:
+		case 0x2E:
+			*wc_status = IB_WC_INV_EECN_ERR;
+			break;
+		case 0x0C:
+		case 0x2F:
+			*wc_status = IB_WC_INV_EEC_STATE_ERR;
+			break;
+		case 0x0D:
+			*wc_status = IB_WC_BAD_RESP_ERR;
+			break;
+		case 0x10:
+			/* WQE purged */
+			*wc_status = IB_WC_WR_FLUSH_ERR;
+			break;
+		default:
+			*wc_status = IB_WC_FATAL_ERR;
+
+		}
+	} else
+		*wc_status = IB_WC_SUCCESS;
+}
+
+int ehca_post_send(struct ib_qp *qp,
+		   struct ib_send_wr *send_wr,
+		   struct ib_send_wr **bad_send_wr)
+{
+	struct ehca_qp *my_qp = NULL;
+	struct ib_send_wr *cur_send_wr = NULL;
+	struct ehca_wqe *wqe_p = NULL;
+	int wqe_cnt = 0;
+	int ret = 0;
+	unsigned long spl_flags = 0;
+
+	EHCA_CHECK_ADR(qp);
+	my_qp = container_of(qp, struct ehca_qp, ib_qp);
+	EHCA_CHECK_QP(my_qp);
+	EHCA_CHECK_ADR(send_wr);
+	EDEB_EN(7, "ehca_qp=%p qp_num=%x send_wr=%p bad_send_wr=%p",
+		my_qp, qp->qp_num, send_wr, bad_send_wr);
+
+	/* LOCK the QUEUE */
+	spin_lock_irqsave(&my_qp->spinlock_s, spl_flags);
+
+	/* loop processes list of send reqs */
+	for (cur_send_wr = send_wr; cur_send_wr != NULL;
+	     cur_send_wr = cur_send_wr->next) {
+		u64 start_offset = my_qp->ipz_squeue.current_q_offset;
+		/* get pointer next to free WQE */
+		wqe_p = ipz_qeit_get_inc(&my_qp->ipz_squeue);
+		if (unlikely(!wqe_p)) {
+			/* too many posted work requests: queue overflow */
+			if (bad_send_wr)
+				*bad_send_wr = cur_send_wr;
+			if (wqe_cnt == 0) {
+				ret = -ENOMEM;
+				EDEB_ERR(4, "Too many posted WQEs qp_num=%x",
+					 qp->qp_num);
+			}
+			goto post_send_exit0;
+		}
+		/* write a SEND WQE into the QUEUE */
+		ret = ehca_write_swqe(my_qp, wqe_p, cur_send_wr);
+		/* if something failed,
+		   reset the free entry pointer to the start value
+		*/
+		if (unlikely(ret)) {
+			my_qp->ipz_squeue.current_q_offset = start_offset;
+			*bad_send_wr = cur_send_wr;
+			if (wqe_cnt == 0) {
+				ret = -EINVAL;
+				EDEB_ERR(4, "Could not write WQE qp_num=%x",
+					 qp->qp_num);
+			}
+			goto post_send_exit0;
+		}
+		wqe_cnt++;
+		EDEB(7, "ehca_qp=%p qp_num=%x wqe_cnt=%d",
+		     my_qp, qp->qp_num, wqe_cnt);
+	} /* eof for cur_send_wr */
+
+post_send_exit0:
+	/* UNLOCK the QUEUE */
+	spin_unlock_irqrestore(&my_qp->spinlock_s, spl_flags);
+	iosync(); /* serialize GAL register access */
+	hipz_update_sqa(my_qp, wqe_cnt);
+	EDEB_EX(7, "ehca_qp=%p qp_num=%x ret=%x wqe_cnt=%d",
+		my_qp, qp->qp_num, ret, wqe_cnt);
+	return ret;
+}
+
+int ehca_post_recv(struct ib_qp *qp,
+		   struct ib_recv_wr *recv_wr,
+		   struct ib_recv_wr **bad_recv_wr)
+{
+	struct ehca_qp *my_qp = NULL;
+	struct ib_recv_wr *cur_recv_wr = NULL;
+	struct ehca_wqe *wqe_p = NULL;
+	int wqe_cnt = 0;
+	int ret = 0;
+	unsigned long spl_flags = 0;
+
+	EHCA_CHECK_ADR(qp);
+	my_qp = container_of(qp, struct ehca_qp, ib_qp);
+	EHCA_CHECK_QP(my_qp);
+	EHCA_CHECK_ADR(recv_wr);
+	EDEB_EN(7, "ehca_qp=%p qp_num=%x recv_wr=%p bad_recv_wr=%p",
+		my_qp, qp->qp_num, recv_wr, bad_recv_wr);
+
+	/* LOCK the QUEUE */
+	spin_lock_irqsave(&my_qp->spinlock_r, spl_flags);
+
+	/* loop processes list of send reqs */
+	for (cur_recv_wr = recv_wr; cur_recv_wr != NULL;
+	     cur_recv_wr = cur_recv_wr->next) {
+		u64 start_offset = my_qp->ipz_rqueue.current_q_offset;
+		/* get pointer next to free WQE */
+		wqe_p = ipz_qeit_get_inc(&my_qp->ipz_rqueue);
+		if (unlikely(!wqe_p)) {
+			/* too many posted work requests: queue overflow */
+			if (bad_recv_wr)
+				*bad_recv_wr = cur_recv_wr;
+			if (wqe_cnt == 0) {
+				ret = -ENOMEM;
+				EDEB_ERR(4, "Too many posted WQEs qp_num=%x",
+					 qp->qp_num);
+			}
+			goto post_recv_exit0;
+		}
+		/* write a RECV WQE into the QUEUE */
+		ret = ehca_write_rwqe(&my_qp->ipz_rqueue, wqe_p,
+					  cur_recv_wr);
+		/* if something failed,
+		   reset the free entry pointer to the start value
+		*/
+		if (unlikely(ret)) {
+			my_qp->ipz_rqueue.current_q_offset = start_offset;
+			*bad_recv_wr = cur_recv_wr;
+			if (wqe_cnt == 0) {
+				ret = -EINVAL;
+				EDEB_ERR(4, "Could not write WQE qp_num=%x",
+					 qp->qp_num);
+			}
+			goto post_recv_exit0;
+		}
+		wqe_cnt++;
+		EDEB(7, "ehca_qp=%p qp_num=%x wqe_cnt=%d",
+		     my_qp, qp->qp_num, wqe_cnt);
+	} /* eof for cur_recv_wr */
+
+post_recv_exit0:
+	spin_unlock_irqrestore(&my_qp->spinlock_r, spl_flags);
+	iosync(); /* serialize GAL register access */
+	hipz_update_rqa(my_qp, wqe_cnt);
+	EDEB_EX(7, "ehca_qp=%p qp_num=%x ret=%x wqe_cnt=%d",
+		my_qp, qp->qp_num, ret, wqe_cnt);
+	return ret;
+}
+
+/**
+ * ib_wc_opcode - Table converts ehca wc opcode to ib
+ * Since we use zero to indicate invalid opcode, the actual ib opcode must
+ * be decremented!!!
+ */
+static const u8 ib_wc_opcode[255] = {
+	[0x01] = IB_WC_RECV+1,
+	[0x02] = IB_WC_RECV_RDMA_WITH_IMM+1,
+	[0x04] = IB_WC_BIND_MW+1,
+	[0x08] = IB_WC_FETCH_ADD+1,
+	[0x10] = IB_WC_COMP_SWAP+1,
+	[0x20] = IB_WC_RDMA_WRITE+1,
+	[0x40] = IB_WC_RDMA_READ+1,
+	[0x80] = IB_WC_SEND+1
+};
+
+/**
+ * internal function to poll one entry of cq
+ */
+static inline int ehca_poll_cq_one(struct ib_cq *cq, struct ib_wc *wc)
+{
+	int ret = 0;
+	struct ehca_cq *my_cq = container_of(cq, struct ehca_cq, ib_cq);
+	struct ehca_cqe *cqe = NULL;
+	int cqe_count = 0;
+
+	EDEB_EN(7, "ehca_cq=%p cq_num=%x wc=%p", my_cq, my_cq->cq_number, wc);
+
+poll_cq_one_read_cqe:
+	cqe = (struct ehca_cqe *)
+		ipz_qeit_get_inc_valid(&my_cq->ipz_queue);
+	if (!cqe) {
+		ret = -EAGAIN;
+		EDEB(7, "Completion queue is empty ehca_cq=%p cq_num=%x "
+		     "ret=%x", my_cq, my_cq->cq_number, ret);
+		goto  poll_cq_one_exit0;
+	}
+	cqe_count++;
+	if (unlikely(cqe->status & WC_STATUS_PURGE_BIT)) {
+		struct ehca_qp *qp=ehca_cq_get_qp(my_cq, cqe->local_qp_number);
+		int purgeflag = 0;
+		unsigned long spl_flags = 0;
+		if (!qp) {
+			EDEB_ERR(4, "cq_num=%x qp_num=%x "
+				 "could not find qp -> ignore cqe",
+				 my_cq->cq_number, cqe->local_qp_number);
+			EDEB_DMP(4, cqe, 64, "cq_num=%x qp_num=%x",
+				 my_cq->cq_number, cqe->local_qp_number);
+			/* ignore this purged cqe */
+			goto poll_cq_one_read_cqe;
+		}
+		spin_lock_irqsave(&qp->spinlock_s, spl_flags);
+		purgeflag = qp->sqerr_purgeflag;
+		spin_unlock_irqrestore(&qp->spinlock_s, spl_flags);
+
+		if (purgeflag) {
+			EDEB(6, "Got CQE with purged bit qp_num=%x src_qp=%x",
+			     cqe->local_qp_number, cqe->remote_qp_number);
+			EDEB_DMP(6, cqe, 64, "qp_num=%x src_qp=%x",
+				 cqe->local_qp_number, cqe->remote_qp_number);
+			/* ignore this to avoid double cqes of bad wqe
+			   that caused sqe and turn off purge flag */
+			qp->sqerr_purgeflag = 0;
+			goto poll_cq_one_read_cqe;
+		}
+	}
+
+	/* tracing cqe */
+	if (IS_EDEB_ON(7)) {
+		EDEB(7, "Received COMPLETION ehca_cq=%p cq_num=%x -----",
+		     my_cq, my_cq->cq_number);
+		EDEB_DMP(7, cqe, 64, "ehca_cq=%p cq_num=%x",
+			 my_cq, my_cq->cq_number);
+		EDEB(7, "ehca_cq=%p cq_num=%x -------------------------",
+		     my_cq, my_cq->cq_number);
+	}
+
+	/* we got a completion! */
+	wc->wr_id = cqe->work_request_id;
+
+	/* eval ib_wc_opcode */
+	wc->opcode = ib_wc_opcode[cqe->optype]-1;
+	if (unlikely(wc->opcode == -1)) {
+		EDEB_ERR(4, "Invalid cqe->OPType=%x cqe->status=%x "
+			 "ehca_cq=%p cq_num=%x",
+			 cqe->optype, cqe->status, my_cq, my_cq->cq_number);
+		/* dump cqe for other infos */
+		EDEB_DMP(4, cqe, 64, "ehca_cq=%p cq_num=%x",
+			 my_cq, my_cq->cq_number);
+		/* update also queue adder to throw away this entry!!! */
+		goto poll_cq_one_exit0;
+	}
+	/* eval ib_wc_status */
+	if (unlikely(cqe->status & WC_STATUS_ERROR_BIT)) { /* complete with errors */
+		map_ib_wc_status(cqe->status, &wc->status);
+		wc->vendor_err = wc->status;
+	} else
+		wc->status = IB_WC_SUCCESS;
+
+	wc->qp_num = cqe->local_qp_number;
+	wc->byte_len = ntohl(cqe->nr_bytes_transferred);
+	wc->pkey_index = cqe->pkey_index;
+	wc->slid = cqe->rlid;
+	wc->dlid_path_bits = cqe->dlid;
+	wc->src_qp = cqe->remote_qp_number;
+	wc->wc_flags = cqe->w_completion_flags;
+	wc->imm_data = cqe->immediate_data;
+	wc->sl = cqe->service_level;
+
+	if (wc->status != IB_WC_SUCCESS)
+		EDEB(6, "ehca_cq=%p cq_num=%x WARNING unsuccessful cqe "
+		     "OPType=%x status=%x qp_num=%x src_qp=%x wr_id=%lx cqe=%p",
+		     my_cq, my_cq->cq_number, cqe->optype, cqe->status,
+		     cqe->local_qp_number, cqe->remote_qp_number,
+		     cqe->work_request_id, cqe);
+
+poll_cq_one_exit0:
+	if (cqe_count > 0)
+		hipz_update_feca(my_cq, cqe_count);
+
+	EDEB_EX(7, "ret=%x ehca_cq=%p cq_number=%x wc=%p "
+		"status=%x opcode=%x qp_num=%x byte_len=%x",
+		ret, my_cq, my_cq->cq_number, wc, wc->status,
+		wc->opcode, wc->qp_num, wc->byte_len);
+
+	return ret;
+}
+
+int ehca_poll_cq(struct ib_cq *cq, int num_entries, struct ib_wc *wc)
+{
+	struct ehca_cq *my_cq = NULL;
+	int nr = 0;
+	struct ib_wc *current_wc = NULL;
+	int ret = 0;
+	unsigned long spl_flags = 0;
+
+	EHCA_CHECK_CQ(cq);
+	EHCA_CHECK_ADR(wc);
+
+	my_cq = container_of(cq, struct ehca_cq, ib_cq);
+	EHCA_CHECK_CQ(my_cq);
+
+	EDEB_EN(7, "ehca_cq=%p cq_num=%x num_entries=%d wc=%p",
+		my_cq, my_cq->cq_number, num_entries, wc);
+
+	if (num_entries < 1) {
+		EDEB_ERR(4, "Invalid num_entries=%d ehca_cq=%p cq_num=%x",
+			 num_entries, my_cq, my_cq->cq_number);
+		ret = -EINVAL;
+		goto poll_cq_exit0;
+	}
+
+	current_wc = wc;
+	spin_lock_irqsave(&my_cq->spinlock, spl_flags);
+	for (nr = 0; nr < num_entries; nr++) {
+		ret = ehca_poll_cq_one(cq, current_wc);
+		if (ret)
+			break;
+		current_wc++;
+	} /* eof for nr */
+	spin_unlock_irqrestore(&my_cq->spinlock, spl_flags);
+	if (ret == -EAGAIN  || !ret)
+		ret = nr;
+
+poll_cq_exit0:
+	EDEB_EX(7, "ehca_cq=%p cq_num=%x ret=%x wc=%p nr_entries=%d",
+		my_cq, my_cq->cq_number, ret, wc, nr);
+
+	return ret;
+}
+
+int ehca_req_notify_cq(struct ib_cq *cq, enum ib_cq_notify cq_notify)
+{
+	struct ehca_cq *my_cq = NULL;
+	int ret = 0;
+
+	EHCA_CHECK_CQ(cq);
+	my_cq = container_of(cq, struct ehca_cq, ib_cq);
+	EHCA_CHECK_CQ(my_cq);
+	EDEB_EN(7, "ehca_cq=%p cq_num=%x cq_notif=%x",
+		my_cq, my_cq->cq_number, cq_notify);
+
+	switch (cq_notify) {
+	case IB_CQ_SOLICITED:
+		hipz_set_cqx_n0(my_cq, 1);
+		break;
+	case IB_CQ_NEXT_COMP:
+		hipz_set_cqx_n1(my_cq, 1);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	EDEB_EX(7, "ehca_cq=%p cq_num=%x ret=%x",
+		my_cq, my_cq->cq_number, ret);
+
+	return ret;
+}
--- linux-2.6.17-rc2-orig/drivers/infiniband/hw/ehca/ehca_sqp.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.17-rc2/drivers/infiniband/hw/ehca/ehca_sqp.c	2006-05-15 13:35:24.000000000 +0200
@@ -0,0 +1,123 @@
+/*
+ *  IBM eServer eHCA Infiniband device driver for Linux on POWER
+ *
+ *  SQP functions
+ *
+ *  Authors: Khadija Souissi <souissi@de.ibm.com>
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
+
+#define DEB_PREFIX "e_qp"
+
+#include <linux/module.h>
+#include <linux/err.h>
+#include "ehca_classes.h"
+#include "ehca_tools.h"
+#include "ehca_qes.h"
+#include "ehca_iverbs.h"
+#include "hcp_if.h"
+
+
+extern int ehca_create_aqp1(struct ehca_shca *shca, struct ehca_sport *sport);
+extern int ehca_destroy_aqp1(struct ehca_sport *sport);
+
+extern int ehca_port_act_time;
+
+/**
+ * ehca_define_sqp - Defines special queue pair 1 (GSI QP). When special queue
+ * pair is created successfully, the corresponding port gets active.
+ *
+ * Define Special Queue pair 0 (SMI QP) is still not supported.
+ *
+ * @qp_init_attr: Queue pair init attributes with port and queue pair type
+ */
+
+u64 ehca_define_sqp(struct ehca_shca *shca,
+		    struct ehca_qp *ehca_qp,
+		    struct ib_qp_init_attr *qp_init_attr)
+{
+
+	u32 pma_qp_nr = 0;
+	u32 bma_qp_nr = 0;
+	u64 ret = H_SUCCESS;
+	u8 port = qp_init_attr->port_num;
+	int counter = 0;
+
+	EDEB_EN(7, "port=%x qp_type=%x",
+		port, qp_init_attr->qp_type);
+
+	shca->sport[port - 1].port_state = IB_PORT_DOWN;
+
+	switch (qp_init_attr->qp_type) {
+	case IB_QPT_SMI:
+		/* function not supported yet */
+		break;
+	case IB_QPT_GSI:
+		ret = hipz_h_define_aqp1(shca->ipz_hca_handle,
+					 ehca_qp->ipz_qp_handle,
+					 ehca_qp->galpas.kernel,
+					 (u32) qp_init_attr->port_num,
+					 &pma_qp_nr, &bma_qp_nr);
+
+		if (ret != H_SUCCESS) {
+			EDEB_ERR(4, "Can't define AQP1 for port %x. rc=%lx",
+				    port, ret);
+			goto ehca_define_aqp1;
+		}
+		break;
+	default:
+		ret = H_PARAMETER;
+		goto ehca_define_aqp1;
+	}
+
+	while ((shca->sport[port - 1].port_state != IB_PORT_ACTIVE) &&
+	       (counter < ehca_port_act_time)) {
+		EDEB(6, "... wait until port %x is active",
+			port);
+		msleep_interruptible(1000);
+		counter++;
+	}
+
+	if (counter == ehca_port_act_time) {
+		EDEB_ERR(4, "Port %x is not active.", port);
+		ret = H_HARDWARE;
+	}
+
+ehca_define_aqp1:
+	EDEB_EX(7, "ret=%lx", ret);
+
+	return ret;
+}


