Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030289AbWHRMJ4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030289AbWHRMJ4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 08:09:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030311AbWHRMJz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 08:09:55 -0400
Received: from mtagate3.uk.ibm.com ([195.212.29.136]:7325 "EHLO
	mtagate3.uk.ibm.com") by vger.kernel.org with ESMTP
	id S1030289AbWHRMJw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 08:09:52 -0400
From: Jan-Bernd Themann <ossthema@de.ibm.com>
Subject: [2.6.19 PATCH 2/7] ehea: pHYP interface
Date: Fri, 18 Aug 2006 13:30:21 +0200
User-Agent: KMail/1.8.2
MIME-Version: 1.0
Content-Disposition: inline
To: netdev <netdev@vger.kernel.org>
Cc: Christoph Raisch <raisch@de.ibm.com>,
       "Jan-Bernd Themann" <themann@de.ibm.com>,
       "linux-kernel" <linux-kernel@vger.kernel.org>,
       "linux-ppc" <linuxppc-dev@ozlabs.org>, Marcus Eder <meder@de.ibm.com>,
       Thomas Klein <osstklei@de.ibm.com>, Thomas Klein <tklein@de.ibm.com>
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200608181330.21507.ossthema@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Jan-Bernd Themann <themann@de.ibm.com> 


 drivers/net/ehea/ehea_hcall.h |   51 ++
 drivers/net/ehea/ehea_phyp.c  |  884 ++++++++++++++++++++++++++++++++++++++++++
 drivers/net/ehea/ehea_phyp.h  |  523 ++++++++++++++++++++++++
 3 files changed, 1458 insertions(+)



--- linux-2.6.18-rc4-orig/drivers/net/ehea/ehea_phyp.c	1969-12-31 16:00:00.000000000 -0800
+++ kernel/drivers/net/ehea/ehea_phyp.c	2006-08-18 00:01:02.556365279 -0700
@@ -0,0 +1,884 @@
+/*
+ *  linux/drivers/net/ehea/ehea_phyp.c
+ *
+ *  eHEA ethernet device driver for IBM eServer System p
+ *
+ *  (C) Copyright IBM Corp. 2006
+ *
+ *  Authors:
+ *       Christoph Raisch <raisch@de.ibm.com>
+ *       Jan-Bernd Themann <themann@de.ibm.com>
+ *       Thomas Klein <tklein@de.ibm.com>
+ *
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2, or (at your option)
+ * any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.	 See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+#include "ehea_phyp.h"
+
+
+static inline u16 get_order_of_qentries(u16 queue_entries)
+{
+	u8 ld = 1;		/*  logarithmus dualis */
+	while (((1U << ld) - 1) < queue_entries)
+		ld++;
+	return ld - 1;
+}
+
+
+/* Defines for H_CALL H_ALLOC_RESOURCE */
+#define H_ALL_RES_TYPE_QP        1
+#define H_ALL_RES_TYPE_CQ        2
+#define H_ALL_RES_TYPE_EQ        3
+#define H_ALL_RES_TYPE_MR        5
+#define H_ALL_RES_TYPE_MW        6
+
+u64 ehea_h_query_ehea_qp(const u64 hcp_adapter_handle,
+			 const u8 qp_category,
+			 const u64 qp_handle, const u64 sel_mask, void *cb_addr)
+{
+	u64 hret = H_ADAPTER_PARM;
+	u64 dummy = 0;
+
+	if ((((u64)cb_addr) & (PAGE_SIZE - 1)) != 0)
+		panic("query_ehea_qp: cb_addr not on page boundary!!!");
+
+	hret = ehea_hcall_9arg_9ret(H_QUERY_HEA_QP,
+				    hcp_adapter_handle,	        /* R4 */
+				    qp_category,	        /* R5 */
+				    qp_handle,	                /* R6 */
+				    sel_mask,	                /* R7 */
+				    virt_to_abs(cb_addr),	/* R8 */
+				    0, 0, 0, 0,	                /* R9-R12 */
+				    &dummy,                     /* R4 */
+				    &dummy,                     /* R5 */
+				    &dummy,	                /* R6 */
+				    &dummy,	                /* R7 */
+				    &dummy,	                /* R8 */
+				    &dummy,	                /* R9 */
+				    &dummy,	                /* R10 */
+				    &dummy,	                /* R11 */
+				    &dummy);	                /* R12 */
+	return hret;
+}
+
+/* input param R5 */
+#define H_ALL_RES_QP_EQPO         EHEA_BMASK_IBM(9, 11)
+#define H_ALL_RES_QP_QPP          EHEA_BMASK_IBM(12, 12)
+#define H_ALL_RES_QP_RQR          EHEA_BMASK_IBM(13, 15)
+#define H_ALL_RES_QP_EQEG         EHEA_BMASK_IBM(16, 16)
+#define H_ALL_RES_QP_LL_QP        EHEA_BMASK_IBM(17, 17)
+#define H_ALL_RES_QP_DMA128       EHEA_BMASK_IBM(19, 19)
+#define H_ALL_RES_QP_HSM          EHEA_BMASK_IBM(20, 21)
+#define H_ALL_RES_QP_SIGT         EHEA_BMASK_IBM(22, 23)
+#define H_ALL_RES_QP_TENURE       EHEA_BMASK_IBM(48, 55)
+#define H_ALL_RES_QP_RES_TYP      EHEA_BMASK_IBM(56, 63)
+
+/* input param R9  */
+#define H_ALL_RES_QP_TOKEN        EHEA_BMASK_IBM(0, 31)
+#define H_ALL_RES_QP_PD           EHEA_BMASK_IBM(32,63)
+
+/* input param R10 */
+#define H_ALL_RES_QP_MAX_SWQE     EHEA_BMASK_IBM(4, 7)
+#define H_ALL_RES_QP_MAX_R1WQE    EHEA_BMASK_IBM(12, 15)
+#define H_ALL_RES_QP_MAX_R2WQE    EHEA_BMASK_IBM(20, 23)
+#define H_ALL_RES_QP_MAX_R3WQE    EHEA_BMASK_IBM(28, 31)
+/* Max Send Scatter Gather Elements */
+#define H_ALL_RES_QP_MAX_SSGE     EHEA_BMASK_IBM(37, 39)
+#define H_ALL_RES_QP_MAX_R1SGE    EHEA_BMASK_IBM(45, 47)
+/* Max Receive SG Elements RQ1 */
+#define H_ALL_RES_QP_MAX_R2SGE    EHEA_BMASK_IBM(53, 55)
+#define H_ALL_RES_QP_MAX_R3SGE    EHEA_BMASK_IBM(61, 63)
+
+/* input param R11 */
+#define H_ALL_RES_QP_SWQE_IDL     EHEA_BMASK_IBM(0, 7)
+/* max swqe immediate data length */
+#define H_ALL_RES_QP_PORT_NUM     EHEA_BMASK_IBM(48, 63)
+
+/* input param R12 */
+#define H_ALL_RES_QP_TH_RQ2       EHEA_BMASK_IBM(0, 15)
+/* Threshold RQ2 */
+#define H_ALL_RES_QP_TH_RQ3       EHEA_BMASK_IBM(16, 31)
+/* Threshold RQ3 */
+
+/* output param R6 */
+#define H_ALL_RES_QP_ACT_SWQE     EHEA_BMASK_IBM(0, 15)
+#define H_ALL_RES_QP_ACT_R1WQE    EHEA_BMASK_IBM(16, 31)
+#define H_ALL_RES_QP_ACT_R2WQE    EHEA_BMASK_IBM(32, 47)
+#define H_ALL_RES_QP_ACT_R3WQE    EHEA_BMASK_IBM(48, 63)
+
+/* output param, R7 */
+#define H_ALL_RES_QP_ACT_SSGE     EHEA_BMASK_IBM(0, 7)
+#define H_ALL_RES_QP_ACT_R1SGE    EHEA_BMASK_IBM(8, 15)
+#define H_ALL_RES_QP_ACT_R2SGE    EHEA_BMASK_IBM(16, 23)
+#define H_ALL_RES_QP_ACT_R3SGE    EHEA_BMASK_IBM(24, 31)
+#define H_ALL_RES_QP_ACT_SWQE_IDL EHEA_BMASK_IBM(32, 39)
+
+/* output param R8,R9 */
+#define H_ALL_RES_QP_SIZE_SQ      EHEA_BMASK_IBM(0, 31)
+#define H_ALL_RES_QP_SIZE_RQ1     EHEA_BMASK_IBM(32, 63)
+#define H_ALL_RES_QP_SIZE_RQ2     EHEA_BMASK_IBM(0, 31)
+#define H_ALL_RES_QP_SIZE_RQ3     EHEA_BMASK_IBM(32, 63)
+
+/* output param R11,R12 */
+#define H_ALL_RES_QP_LIOBN_SQ     EHEA_BMASK_IBM(0, 31)
+#define H_ALL_RES_QP_LIOBN_RQ1    EHEA_BMASK_IBM(32, 63)
+#define H_ALL_RES_QP_LIOBN_RQ2    EHEA_BMASK_IBM(0, 31)
+#define H_ALL_RES_QP_LIOBN_RQ3    EHEA_BMASK_IBM(32, 63)
+
+u64 ehea_h_alloc_resource_qp(const u64 adapter_handle,
+			     struct ehea_qp *ehea_qp,
+			     struct ehea_qp_init_attr *init_attr,
+			     const u32 pd,
+			     u64 *qp_handle, struct h_epas *h_epas)
+{
+	u64 hret = H_ADAPTER_PARM;
+
+	u64 allocate_controls =
+	    EHEA_BMASK_SET(H_ALL_RES_QP_EQPO, init_attr->low_lat_rq1 ? 1 : 0)
+	    | EHEA_BMASK_SET(H_ALL_RES_QP_QPP, 0)
+	    | EHEA_BMASK_SET(H_ALL_RES_QP_RQR, 6)	/* RQ1 & RQ2 & rq3 */
+	    | EHEA_BMASK_SET(H_ALL_RES_QP_EQEG, 0)	/* EQE gen. disabled */
+	    | EHEA_BMASK_SET(H_ALL_RES_QP_LL_QP, init_attr->low_lat_rq1)
+	    | EHEA_BMASK_SET(H_ALL_RES_QP_DMA128, 0)
+	    | EHEA_BMASK_SET(H_ALL_RES_QP_HSM, 0)
+	    | EHEA_BMASK_SET(H_ALL_RES_QP_SIGT, init_attr->signalingtype)
+	    | EHEA_BMASK_SET(H_ALL_RES_QP_RES_TYP, H_ALL_RES_TYPE_QP);
+
+	u64 r9_reg = EHEA_BMASK_SET(H_ALL_RES_QP_PD, pd)
+	    | EHEA_BMASK_SET(H_ALL_RES_QP_TOKEN, init_attr->qp_token);
+
+	u64 max_r10_reg =
+	    EHEA_BMASK_SET(H_ALL_RES_QP_MAX_SWQE,
+			  get_order_of_qentries(init_attr->max_nr_send_wqes))
+	    | EHEA_BMASK_SET(H_ALL_RES_QP_MAX_R1WQE,
+			     get_order_of_qentries(init_attr->max_nr_rwqes_rq1))
+	    | EHEA_BMASK_SET(H_ALL_RES_QP_MAX_R2WQE,
+			     get_order_of_qentries(init_attr->max_nr_rwqes_rq2))
+	    | EHEA_BMASK_SET(H_ALL_RES_QP_MAX_R3WQE,
+			     get_order_of_qentries(init_attr->max_nr_rwqes_rq3))
+	    | EHEA_BMASK_SET(H_ALL_RES_QP_MAX_SSGE, init_attr->wqe_size_enc_sq)
+	    | EHEA_BMASK_SET(H_ALL_RES_QP_MAX_R1SGE,
+			     init_attr->wqe_size_enc_rq1)
+	    | EHEA_BMASK_SET(H_ALL_RES_QP_MAX_R2SGE,
+			     init_attr->wqe_size_enc_rq2)
+	    | EHEA_BMASK_SET(H_ALL_RES_QP_MAX_R3SGE,
+			     init_attr->wqe_size_enc_rq3);
+
+	u64 r11_in =
+	    EHEA_BMASK_SET(H_ALL_RES_QP_SWQE_IDL, init_attr->swqe_imm_data_len)
+	    | EHEA_BMASK_SET(H_ALL_RES_QP_PORT_NUM, init_attr->port_nr);
+	u64 threshold =
+	    EHEA_BMASK_SET(H_ALL_RES_QP_TH_RQ2, init_attr->rq2_threshold)
+	    | EHEA_BMASK_SET(H_ALL_RES_QP_TH_RQ3, init_attr->rq3_threshold);
+
+	u64 r5_out = 0;
+	u64 r6_out = 0;
+	u64 r7_out = 0;
+	u64 r8_out = 0;
+	u64 r9_out = 0;
+	u64 g_la_user_out = 0;
+	u64 r11_out = 0;
+	u64 r12_out = 0;
+
+	hret = ehea_hcall_9arg_9ret(H_ALLOC_HEA_RESOURCE,
+				    adapter_handle,		/* R4 */
+				    allocate_controls,		/* R5 */
+				    init_attr->send_cq_handle,	/* R6 */
+				    init_attr->recv_cq_handle,	/* R7 */
+				    init_attr->aff_eq_handle,	/* R8 */
+				    r9_reg,			/* R9 */
+				    max_r10_reg,		/* R10 */
+				    r11_in,			/* R11 */
+				    threshold,			/* R12 */
+				    qp_handle,			/* R4 */
+				    &r5_out,			/* R5 */
+				    &r6_out,			/* R6 */
+				    &r7_out,			/* R7 */
+				    &r8_out,			/* R8 */
+				    &r9_out,			/* R9 */
+				    &g_la_user_out,		/* R10 */
+				    &r11_out,			/* R11 */
+				    &r12_out);			/* R12 */
+
+	init_attr->qp_nr = (u32)r5_out;
+
+	init_attr->act_nr_send_wqes =
+	    (u16)EHEA_BMASK_GET(H_ALL_RES_QP_ACT_SWQE, r6_out);
+	init_attr->act_nr_rwqes_rq1 =
+	    (u16)EHEA_BMASK_GET(H_ALL_RES_QP_ACT_R1WQE, r6_out);
+	init_attr->act_nr_rwqes_rq2 =
+	    (u16)EHEA_BMASK_GET(H_ALL_RES_QP_ACT_R2WQE, r6_out);
+	init_attr->act_nr_rwqes_rq3 =
+	    (u16)EHEA_BMASK_GET(H_ALL_RES_QP_ACT_R3WQE, r6_out);
+
+	init_attr->act_wqe_size_enc_sq = init_attr->wqe_size_enc_sq;
+	init_attr->act_wqe_size_enc_rq1 = init_attr->wqe_size_enc_rq1;
+	init_attr->act_wqe_size_enc_rq2 = init_attr->wqe_size_enc_rq2;
+	init_attr->act_wqe_size_enc_rq3 = init_attr->wqe_size_enc_rq3;
+
+	init_attr->nr_sq_pages =
+	    (u32)EHEA_BMASK_GET(H_ALL_RES_QP_SIZE_SQ, r8_out);
+	init_attr->nr_rq1_pages =
+	    (u32)EHEA_BMASK_GET(H_ALL_RES_QP_SIZE_RQ1, r8_out);
+	init_attr->nr_rq2_pages =
+	    (u32)EHEA_BMASK_GET(H_ALL_RES_QP_SIZE_RQ2, r9_out);
+	init_attr->nr_rq3_pages =
+	    (u32)EHEA_BMASK_GET(H_ALL_RES_QP_SIZE_RQ3, r9_out);
+
+	init_attr->liobn_sq =
+	    (u32)EHEA_BMASK_GET(H_ALL_RES_QP_LIOBN_SQ, r11_out);
+	init_attr->liobn_rq1 =
+	    (u32)EHEA_BMASK_GET(H_ALL_RES_QP_LIOBN_RQ1, r11_out);
+	init_attr->liobn_rq2 =
+	    (u32)EHEA_BMASK_GET(H_ALL_RES_QP_LIOBN_RQ2, r12_out);
+	init_attr->liobn_rq3 =
+	    (u32)EHEA_BMASK_GET(H_ALL_RES_QP_LIOBN_RQ3, r12_out);
+
+	if (!hret)
+		hcp_epas_ctor(h_epas, g_la_user_out, g_la_user_out);
+
+	return hret;
+}
+
+u64 ehea_h_alloc_resource_cq(const u64 hcp_adapter_handle,
+			     struct ehea_cq *ehea_cq,
+			     struct ehea_cq_attr *cq_attr,
+			     u64 *cq_handle, struct h_epas *epas)
+{
+	u64 hret = H_ADAPTER_PARM;
+	u64 dummy = 0;
+	u64 act_nr_of_cqes_out;
+	u64 act_pages_out;
+	u64 g_la_privileged_out;
+	u64 g_la_user_out;
+
+	hret = ehea_hcall_9arg_9ret(H_ALLOC_HEA_RESOURCE,
+				    hcp_adapter_handle,		/* R4 */
+				    H_ALL_RES_TYPE_CQ,		/* R5 */
+				    cq_attr->eq_handle,		/* R6 */
+				    cq_attr->cq_token,		/* R7 */
+				    cq_attr->max_nr_of_cqes,	/* R8 */
+				    0, 0, 0, 0,			/* R9-R12 */
+				    cq_handle,			/* R4 */
+				    &dummy,			/* R5 */
+				    &dummy,			/* R6 */
+				    &act_nr_of_cqes_out,	/* R7 */
+				    &act_pages_out,		/* R8 */
+				    &g_la_privileged_out,	/* R9 */
+				    &g_la_user_out,		/* R10 */
+				    &dummy,	                /* R11 */
+				    &dummy);	                /* R12 */
+
+	cq_attr->act_nr_of_cqes = act_nr_of_cqes_out;
+	cq_attr->nr_pages = act_pages_out;
+
+	if (!hret)
+		hcp_epas_ctor(epas, g_la_privileged_out, g_la_user_out);
+
+	return hret;
+}
+
+/* Defines for H_CALL H_ALLOC_RESOURCE */
+#define H_ALL_RES_TYPE_QP        1
+#define H_ALL_RES_TYPE_CQ        2
+#define H_ALL_RES_TYPE_EQ        3
+#define H_ALL_RES_TYPE_MR        5
+#define H_ALL_RES_TYPE_MW        6
+
+/*  input param R5 */
+#define H_ALL_RES_EQ_NEQ             EHEA_BMASK_IBM(0, 0)
+#define H_ALL_RES_EQ_NON_NEQ_ISN     EHEA_BMASK_IBM(6, 7)
+#define H_ALL_RES_EQ_INH_EQE_GEN     EHEA_BMASK_IBM(16, 16)
+#define H_ALL_RES_EQ_RES_TYPE        EHEA_BMASK_IBM(56, 63)
+/*  input param R6 */
+#define H_ALL_RES_EQ_MAX_EQE         EHEA_BMASK_IBM(32, 63)
+
+/*  output param R6 */
+#define H_ALL_RES_EQ_LIOBN           EHEA_BMASK_IBM(32, 63)
+
+/*  output param R7 */
+#define H_ALL_RES_EQ_ACT_EQE         EHEA_BMASK_IBM(32, 63)
+
+/*  output param R8 */
+#define H_ALL_RES_EQ_ACT_PS          EHEA_BMASK_IBM(32, 63)
+
+/*  output param R9 */
+#define H_ALL_RES_EQ_ACT_EQ_IST_C    EHEA_BMASK_IBM(30, 31)
+#define H_ALL_RES_EQ_ACT_EQ_IST_1    EHEA_BMASK_IBM(40, 63)
+
+/*  output param R10 */
+#define H_ALL_RES_EQ_ACT_EQ_IST_2    EHEA_BMASK_IBM(40, 63)
+
+/*  output param R11 */
+#define H_ALL_RES_EQ_ACT_EQ_IST_3    EHEA_BMASK_IBM(40, 63)
+
+/*  output param R12 */
+#define H_ALL_RES_EQ_ACT_EQ_IST_4    EHEA_BMASK_IBM(40, 63)
+
+u64 ehea_h_alloc_resource_eq(const u64 hcp_adapter_handle,
+			     struct ehea_eq *ehea_eq,
+			     struct ehea_eq_attr *eq_attr, u64 *eq_handle)
+{
+	u64 hret = H_ADAPTER_PARM;
+	u64 dummy;
+	u64 eq_liobn = 0;
+	u64 allocate_controls = 0;
+	u64 ist1_out = 0;
+	u64 ist2_out = 0;
+	u64 ist3_out = 0;
+	u64 ist4_out = 0;
+	u64 act_nr_of_eqes_out = 0;
+	u64 act_pages_out = 0;
+
+	/* resource type */
+	allocate_controls =
+	    EHEA_BMASK_SET(H_ALL_RES_EQ_RES_TYPE, H_ALL_RES_TYPE_EQ)
+	    | EHEA_BMASK_SET(H_ALL_RES_EQ_NEQ, eq_attr->type ? 1 : 0)
+	    | EHEA_BMASK_SET(H_ALL_RES_EQ_INH_EQE_GEN, !eq_attr->eqe_gen)
+	    | EHEA_BMASK_SET(H_ALL_RES_EQ_NON_NEQ_ISN, 1);
+
+	hret = ehea_hcall_9arg_9ret(H_ALLOC_HEA_RESOURCE,
+				    hcp_adapter_handle,		/* R4 */
+				    allocate_controls,		/* R5 */
+				    eq_attr->max_nr_of_eqes,	/* R6 */
+				    0, 0, 0, 0, 0, 0,		/* R7-R10 */
+				    eq_handle,			/* R4 */
+				    &dummy,			/* R5 */
+				    &eq_liobn,			/* R6 */
+				    &act_nr_of_eqes_out,	/* R7 */
+				    &act_pages_out,		/* R8 */
+				    &ist1_out,			/* R9 */
+				    &ist2_out,			/* R10 */
+				    &ist3_out,			/* R11 */
+				    &ist4_out);			/* R12 */
+
+	eq_attr->act_nr_of_eqes = act_nr_of_eqes_out;
+	eq_attr->nr_pages = act_pages_out;
+	eq_attr->ist1 = ist1_out;
+	eq_attr->ist2 = ist2_out;
+	eq_attr->ist3 = ist3_out;
+	eq_attr->ist4 = ist4_out;
+
+	return hret;
+}
+
+u64 ehea_h_modify_ehea_qp(const u64 hcp_adapter_handle,
+			  const u8 cat,
+			  const u64 qp_handle,
+			  const u64 sel_mask,
+			  void *cb_addr,
+			  u64 *inv_attr_id,
+			  u64 *proc_mask,
+			  u16 *out_swr,
+			  u16 *out_rwr)
+{
+	u64 hret = H_ADAPTER_PARM;
+	u64 dummy = 0;
+	u64 act_out_swr = 0;
+	u64 act_out_rwr = 0;
+
+	if ((((u64)cb_addr) & (PAGE_SIZE - 1)) != 0)
+		panic("query_ehea_qp: cb_addr not on page boundary!!!");
+
+	hret = ehea_hcall_9arg_9ret(H_MODIFY_HEA_QP,
+				    hcp_adapter_handle,		/* R4 */
+				    (u64) cat,			/* R5 */
+				    qp_handle,			/* R6 */
+				    sel_mask,			/* R7 */
+				    virt_to_abs(cb_addr),	/* R8 */
+				    0, 0, 0, 0,			/* R9-R12 */
+				    inv_attr_id,		/* R4 */
+				    &dummy,			/* R5 */
+				    &dummy,			/* R6 */
+				    &act_out_swr,		/* R7 */
+				    &act_out_rwr,		/* R8 */
+				    proc_mask,			/* R9 */
+				    &dummy,			/* R10 */
+				    &dummy,			/* R11 */
+				    &dummy);			/* R12 */
+	*out_swr = act_out_swr;
+	*out_rwr = act_out_rwr;
+
+	return hret;
+}
+
+u64 ehea_h_register_rpage(const u64 hcp_adapter_handle,
+			  const u8 pagesize,
+			  const u8 queue_type,
+			  const u64 resource_handle,
+			  const u64 log_pageaddr, u64 count)
+{
+	u64 hret = H_ADAPTER_PARM;
+	u64 dummy;
+	u64 reg_control;
+
+	reg_control = EHEA_BMASK_SET(H_REG_RPAGE_PAGE_SIZE, pagesize)
+		    | EHEA_BMASK_SET(H_REG_RPAGE_QT, queue_type);
+
+	hret = ehea_hcall_9arg_9ret(H_REGISTER_HEA_RPAGES,
+				    hcp_adapter_handle,		/* R4 */
+				    reg_control,		/* R5 */
+				    resource_handle,		/* R6 */
+				    log_pageaddr,		/* R7 */
+				    count,			/* R8 */
+				    0, 0, 0, 0,			/* R9-R12 */
+				    &dummy,			/* R4 */
+				    &dummy,			/* R5 */
+				    &dummy,			/* R6 */
+				    &dummy,			/* R7 */
+				    &dummy,			/* R8 */
+				    &dummy,			/* R9 */
+				    &dummy,			/* R10 */
+				    &dummy,	                /* R11 */
+				    &dummy);	                /* R12 */
+	return hret;
+}
+
+u64 ehea_h_register_rpage_eq(const u64 hcp_adapter_handle,
+			     const u64 eq_handle,
+			     const u8 pagesize,
+			     const u8 queue_type,
+			     const u64 log_pageaddr, const u64 count)
+{
+	u64 hret = H_ADAPTER_PARM;
+
+	if (count != 1)
+		return H_PARAMETER;
+
+	hret = ehea_h_register_rpage(hcp_adapter_handle, pagesize, queue_type,
+				     eq_handle, log_pageaddr, count);
+	return hret;
+}
+
+u64 ehea_h_register_rpage_cq(const u64 hcp_adapter_handle,
+			     const u64 cq_handle,
+			     const u8 pagesize,
+			     const u8 queue_type,
+			     const u64 log_pageaddr,
+			     const u64 count, const struct h_epa epa)
+{
+	u64 hret = H_ADAPTER_PARM;
+
+	if (count != 1)
+		return H_PARAMETER;
+
+	hret = ehea_h_register_rpage(hcp_adapter_handle, pagesize, queue_type,
+				     cq_handle, log_pageaddr, count);
+	return hret;
+}
+
+u64 ehea_h_register_rpage_qp(const u64 hcp_adapter_handle,
+			     const u64 qp_handle,
+			     const u8 pagesize,
+			     const u8 queue_type,
+			     const u64 log_pageaddr,
+			     const u64 count, struct h_epa epa)
+{
+	u64 hret = H_ADAPTER_PARM;
+
+	if (count != 1)
+		return H_PARAMETER;
+
+	hret = ehea_h_register_rpage(hcp_adapter_handle, pagesize, queue_type,
+				     qp_handle, log_pageaddr, count);
+	return hret;
+}
+
+
+u64 ehea_h_register_smr(const u64 adapter_handle,
+			const u64 orig_mr_handle,
+			const u64 vaddr_in,
+			const u32 access_ctrl,
+			const u32 pd,
+			struct ehea_mr *mr)
+{
+	u64 hret = H_ADAPTER_PARM;
+	u64 dummy;
+	u64 lkey_out;
+
+	hret = ehea_hcall_9arg_9ret(H_REGISTER_SMR,
+				    adapter_handle       ,          /* R4 */
+				    orig_mr_handle,                 /* R5 */
+				    vaddr_in,                       /* R6 */
+				    (((u64)access_ctrl) << 32ULL),  /* R7 */
+				    pd,                             /* R8 */
+				    0, 0, 0, 0,			    /* R9-R12 */
+				    &mr->handle,                    /* R4 */
+				    &dummy,                         /* R5 */
+				    &lkey_out,                      /* R6 */
+				    &dummy,                         /* R7 */
+				    &dummy,                         /* R8 */
+				    &dummy,                         /* R9 */
+				    &dummy,                         /* R10 */
+				    &dummy,                         /* R11 */
+				    &dummy);                        /* R12 */
+	mr->lkey = (u32)lkey_out;
+
+	return hret;
+}
+
+u64 ehea_h_destroy_qp(const u64 hcp_adapter_handle,
+		      struct ehea_qp *qp,
+		      u64 qp_handle, struct h_epas *epas)
+{
+	u64 hret = H_ADAPTER_PARM;
+	int ret = 0;
+	u64 dummy;
+	u64 ladr_next_sq_wqe_out;
+	u64 ladr_next_rq1_wqe_out;
+	u64 ladr_next_rq2_wqe_out;
+	u64 ladr_next_rq3_wqe_out;
+
+	ret = hcp_epas_dtor(epas);
+	if (ret) {
+		ehea_error("failed destroying qp->epas");
+		return H_RESOURCE;
+	}
+
+	hret = ehea_hcall_9arg_9ret(H_DISABLE_AND_GET_HEA,
+				    hcp_adapter_handle,		/* R4 */
+				    H_DISABLE_GET_EHEA_WQE_P,	/* R5 */
+				    qp_handle,			/* R6 */
+				    0, 0, 0, 0, 0, 0,		/* R7-R12 */
+				    &ladr_next_sq_wqe_out,	/* R4 */
+				    &ladr_next_rq1_wqe_out,	/* R5 */
+				    &ladr_next_rq2_wqe_out,	/* R6 */
+				    &ladr_next_rq3_wqe_out,	/* R7 */
+				    &dummy,			/* R8 */
+				    &dummy,			/* R9 */
+				    &dummy,			/* R10 */
+				    &dummy,                     /* R11 */
+				    &dummy);                    /* R12 */
+	if (hret == H_HARDWARE) {
+		ehea_error("QP not disabled, hret=%lx", hret);
+		return hret;
+	}
+
+	hret = ehea_hcall_9arg_9ret(H_FREE_RESOURCE,
+				    hcp_adapter_handle,		/* R4 */
+				    qp_handle,			/* R5 */
+				    0, 0, 0, 0, 0, 0, 0,	/* R6-R12 */
+				    &dummy,			/* R4 */
+				    &dummy,			/* R5 */
+				    &dummy,			/* R6 */
+				    &dummy,			/* R7 */
+				    &dummy,			/* R8 */
+				    &dummy,			/* R9 */
+				    &dummy,			/* R10 */
+				    &dummy,                     /* R11 */
+				    &dummy);                    /* R12 */
+	if (hret == H_RESOURCE)
+		ehea_error("resource still in use, hret=%lx", hret);
+
+	return hret;
+}
+
+u64 ehea_h_destroy_cq(const u64 hcp_adapter_handle,
+		      struct ehea_cq *cq,
+		      u64 cq_handle, struct h_epas *epas)
+{
+	u64 hret = H_ADAPTER_PARM;
+	u64 dummy;
+
+	hret = hcp_epas_dtor(epas);
+	if (hret != H_SUCCESS) {
+		ehea_error("failed destroying cp->epas");
+		return H_RESOURCE;
+	}
+
+	hret = ehea_hcall_9arg_9ret(H_FREE_RESOURCE,
+				    hcp_adapter_handle,		/* R4 */
+				    cq_handle,			/* R5 */
+				    0, 0, 0, 0, 0, 0, 0,	/* R6-R12 */
+				    &dummy,			/* R4 */
+				    &dummy,			/* R5 */
+				    &dummy,			/* R6 */
+				    &dummy,			/* R7 */
+				    &dummy,			/* R8 */
+				    &dummy,			/* R9 */
+				    &dummy,			/* R10 */
+				    &dummy,                     /* R11 */
+				    &dummy);                    /* R12 */
+	if (hret == H_RESOURCE)
+		ehea_error("resource in use, hret=%lx ", hret);
+
+	return hret;
+}
+
+u64 ehea_h_destroy_eq(const u64 hcp_adapter_handle,
+		      struct ehea_eq * eq,
+		      u64 eq_handle, struct h_epas * epas)
+{
+	u64 hret = H_ADAPTER_PARM;
+	u64 dummy;
+
+	hret = hcp_epas_dtor(epas);
+
+	if (hret != H_SUCCESS) {
+		ehea_error("failed destroying ep->epas");
+		return H_RESOURCE;
+	}
+
+	hret = ehea_hcall_9arg_9ret(H_FREE_RESOURCE,
+				    hcp_adapter_handle,		/* R4 */
+				    eq_handle,			/* R5 */
+				    0, 0, 0, 0, 0, 0, 0,	/* R6-R12 */
+				    &dummy,			/* R4 */
+				    &dummy,			/* R5 */
+				    &dummy,			/* R6 */
+				    &dummy,			/* R7 */
+				    &dummy,			/* R8 */
+				    &dummy,			/* R9 */
+				    &dummy,			/* R10 */
+				    &dummy,                     /* R11 */
+				    &dummy);                    /* R12 */
+	if (hret == H_RESOURCE)
+		ehea_error("resource in use, hret=%lx ", hret);
+
+	return hret;
+}
+
+u64 ehea_h_free_resource_mr(const u64 hcp_adapter_handle,
+			    const u64 mr_handle)
+{
+	u64 hret = H_ADAPTER_PARM;
+	u64 dummy;
+
+	hret = ehea_hcall_9arg_9ret(H_FREE_RESOURCE,
+				    hcp_adapter_handle,    /* R4 */
+				    mr_handle,             /* R5 */
+				    0, 0, 0, 0, 0, 0, 0,   /* R6-R12 */
+				    &dummy,                /* R4 */
+				    &dummy,                /* R5 */
+				    &dummy,                /* R6 */
+				    &dummy,                /* R7 */
+				    &dummy,                /* R8 */
+				    &dummy,                /* R9 */
+				    &dummy,		   /* R10 */
+				    &dummy,                /* R11 */
+				    &dummy);               /* R12 */
+	return hret;
+}
+
+u64 ehea_h_alloc_resource_mr(const u64 hcp_adapter_handle,
+			     const u64 vaddr,
+			     const u64 length,
+			     const u32 access_ctrl,
+			     const u32 pd, u64 *mr_handle, u32 *lkey)
+{
+	u64 hret = H_ADAPTER_PARM;
+	u64 dummy;
+	u64 lkey_out;
+
+	hret = ehea_hcall_9arg_9ret(H_ALLOC_HEA_RESOURCE,
+				    hcp_adapter_handle,		   /* R4 */
+				    5,				   /* R5 */
+				    vaddr,			   /* R6 */
+				    length,			   /* R7 */
+				    (((u64) access_ctrl) << 32ULL),/* R8 */
+				    pd,				   /* R9 */
+				    0, 0, 0,			   /* R10-R12 */
+				    mr_handle,			   /* R4 */
+				    &dummy,			   /* R5 */
+				    &lkey_out,			   /* R6 */
+				    &dummy,			   /* R7 */
+				    &dummy,			   /* R8 */
+				    &dummy,			   /* R9 */
+				    &dummy,			   /* R10 */
+				    &dummy,                        /* R11 */
+				    &dummy);                       /* R12 */
+	*lkey = (u32) lkey_out;
+
+	return hret;
+}
+
+u64 ehea_h_register_rpage_mr(const u64 hcp_adapter_handle,
+			     const u64 mr_handle,
+			     const u8 pagesize,
+			     const u8 queue_type,
+			     const u64 log_pageaddr, const u64 count)
+{
+	u64 hret = H_ADAPTER_PARM;
+
+	if ((count > 1) && (log_pageaddr & 0xfff)) {
+		ehea_error("not on pageboundary");
+		hret = H_PARAMETER;
+	} else
+		hret = ehea_h_register_rpage(hcp_adapter_handle, pagesize,
+					     queue_type, mr_handle, 
+					     log_pageaddr, count);
+	return hret;
+}
+
+u64 ehea_h_query_ehea(const u64 hcp_adapter_handle, void *cb_addr)
+{
+	u64 hret = H_ADAPTER_PARM;
+	u64 dummy = 0;
+	u64 cb_logaddr;
+
+	cb_logaddr = virt_to_abs(cb_addr);
+
+	hret = ehea_hcall_9arg_9ret(H_QUERY_HEA,
+				    hcp_adapter_handle,		/* R4 */
+				    cb_logaddr,			/* R5 */
+				    0, 0, 0, 0, 0, 0, 0,	/* R6-R12 */
+				    &dummy,			/* R4 */
+				    &dummy,			/* R5 */
+				    &dummy,			/* R6 */
+				    &dummy,			/* R7 */
+				    &dummy,			/* R8 */
+				    &dummy,			/* R9 */
+				    &dummy,			/* R10 */
+				    &dummy,             	/* R11 */
+				    &dummy);            	/* R12 */
+#ifdef DEBUG
+	ehea_dmp(cb_addr, sizeof(struct hcp_query_ehea), "hcp_query_ehea");
+#endif
+	return hret;
+}
+
+u64 ehea_h_query_ehea_port(const u64 hcp_adapter_handle,
+			   const u16 port_num,
+			   const u8 cb_cat, const u64 select_mask,
+			   void *cb_addr)
+{
+	u64 hret = H_ADAPTER_PARM;
+	u64 port_info = 0;
+	u64 arr_index = 0;
+	u64 dummy = 0;
+	u64 cb_logaddr = virt_to_abs(cb_addr);
+
+	port_info = EHEA_BMASK_SET(H_MEHEAPORT_CAT, cb_cat)
+		  | EHEA_BMASK_SET(H_MEHEAPORT_PN, port_num);
+
+	hret = ehea_hcall_9arg_9ret(H_QUERY_HEA_PORT,
+				    hcp_adapter_handle,		/* R4 */
+				    port_info,			/* R5 */
+				    select_mask,		/* R6 */
+				    arr_index,			/* R7 */
+				    cb_logaddr,			/* R8 */
+				    0, 0, 0, 0,			/* R9-R12 */
+				    &dummy,			/* R4 */
+				    &dummy,			/* R5 */
+				    &dummy,			/* R6 */
+				    &dummy,			/* R7 */
+				    &dummy,			/* R8 */
+				    &dummy,			/* R9 */
+				    &dummy,			/* R10 */
+				    &dummy,                     /* R11 */
+				    &dummy);                    /* R12 */
+	return hret;
+}
+
+u64 ehea_h_modify_ehea_port(const u64 hcp_adapter_handle,
+			    const u16 port_num,
+			    const u8 cb_cat,
+			    const u64 select_mask, void *cb_addr)
+{
+	u64 hret = H_ADAPTER_PARM;
+	u64 port_info = 0;
+	u64 arr_index = 0;
+	u64 dummy = 0;
+	u64 cb_logaddr = virt_to_abs(cb_addr);
+
+	port_info = EHEA_BMASK_SET(H_MEHEAPORT_CAT, cb_cat)
+		  | EHEA_BMASK_SET(H_MEHEAPORT_PN, port_num);
+
+#ifdef DEBUG
+	ehea_dump(cb_addr,
+		 sizeof(struct hcp_query_ehea_port_cb_0), "Before HCALL");
+#endif
+
+	hret = ehea_hcall_9arg_9ret(H_MODIFY_HEA_PORT,
+				    hcp_adapter_handle,		/* R4 */
+				    port_info,			/* R5 */
+				    select_mask,		/* R6 */
+				    arr_index,			/* R7 */
+				    cb_logaddr,			/* R8 */
+				    0, 0, 0, 0,			/* R9-R12 */
+				    &dummy,			/* R4 */
+				    &dummy,			/* R5 */
+				    &dummy,			/* R6 */
+				    &dummy,			/* R7 */
+				    &dummy,			/* R8 */
+				    &dummy,			/* R9 */
+				    &dummy,			/* R10 */
+				    &dummy,                     /* R11 */
+				    &dummy);                    /* R12 */
+	return hret;
+}
+
+u64 ehea_h_reg_dereg_bcmc(const u64 hcp_adapter_handle,
+			  const u16 port_num,
+			  const u8 reg_type,
+			  const u64 mc_mac_addr,
+			  const u16 vlan_id, const u32 hcall_id)
+{
+	u64 hret = H_ADAPTER_PARM;
+	u64 r5_port_num = 0;
+	u64 r6_reg_type = 0;
+	u64 r7_mc_mac_addr = 0;
+	u64 r8_vlan_id = 0;
+	u64 dummy = 0;
+
+	u64 mac_addr = mc_mac_addr >> 16;
+
+	r5_port_num = EHEA_BMASK_SET(H_REGBCMC_PN, port_num);
+	r6_reg_type = EHEA_BMASK_SET(H_REGBCMC_REGTYPE, reg_type);
+	r7_mc_mac_addr = EHEA_BMASK_SET(H_REGBCMC_MACADDR, mac_addr);
+	r8_vlan_id = EHEA_BMASK_SET(H_REGBCMC_VLANID, vlan_id);
+
+	hret = ehea_hcall_9arg_9ret(hcall_id,
+				    hcp_adapter_handle,		/* R4 */
+				    r5_port_num,		/* R5 */
+				    r6_reg_type,		/* R6 */
+				    r7_mc_mac_addr,		/* R7 */
+				    r8_vlan_id,			/* R8 */
+				    0, 0, 0, 0,			/* R9-R12 */
+				    &dummy,			/* R4 */
+				    &dummy,			/* R5 */
+				    &dummy,			/* R6 */
+				    &dummy,			/* R7 */
+				    &dummy,			/* R8 */
+				    &dummy,			/* R9 */
+				    &dummy,			/* R10 */
+				    &dummy,                     /* R11 */
+				    &dummy);                    /* R12 */
+	return hret;
+}
+
+u64 ehea_h_reset_events(const u64 hcp_adapter_handle,
+			const u64 neq_handle, const u64 event_mask)
+{
+	u64 hret = H_ADAPTER_PARM;
+	u64 dummy = 0;
+
+	hret = ehea_hcall_9arg_9ret(H_RESET_EVENTS,
+				    hcp_adapter_handle,		/* R4 */
+				    neq_handle,			/* R5 */
+				    event_mask,			/* R6 */
+				    0, 0, 0, 0, 0, 0,		/* R7-R12 */
+				    &dummy,			/* R4 */
+				    &dummy,			/* R5 */
+				    &dummy,			/* R6 */
+				    &dummy,			/* R7 */
+				    &dummy,			/* R8 */
+				    &dummy,			/* R9 */
+				    &dummy,			/* R10 */
+				    &dummy,                     /* R11 */
+				    &dummy);                    /* R12 */
+	return hret;
+}
--- linux-2.6.18-rc4-orig/drivers/net/ehea/ehea_phyp.h	1969-12-31 16:00:00.000000000 -0800
+++ kernel/drivers/net/ehea/ehea_phyp.h	2006-08-18 00:01:02.359363484 -0700
@@ -0,0 +1,523 @@
+/*
+ *  linux/drivers/net/ehea/ehea_phyp.h
+ *
+ *  eHEA ethernet device driver for IBM eServer System p
+ *
+ *  (C) Copyright IBM Corp. 2006
+ *
+ *  Authors:
+ *       Christoph Raisch <raisch@de.ibm.com>
+ *       Jan-Bernd Themann <themann@de.ibm.com>
+ *       Thomas Klein <tklein@de.ibm.com>
+ *
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2, or (at your option)
+ * any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.	 See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+#ifndef __EHEA_PHYP_H__
+#define __EHEA_PHYP_H__
+
+#include <linux/delay.h>
+#include <asm/hvcall.h>
+#include "ehea.h"
+#include "ehea_hw.h"
+#include "ehea_hcall.h"
+
+
+
+/* Some abbreviations used here:
+ *
+ * hcp_*  - structures, variables and functions releated to Hypervisor Calls
+ */
+
+
+static inline u32 get_longbusy_msecs(int long_busy_ret_code)
+{
+	switch (long_busy_ret_code) {
+	case H_LONG_BUSY_ORDER_1_MSEC:
+		return 1;
+	case H_LONG_BUSY_ORDER_10_MSEC:
+		return 10;
+	case H_LONG_BUSY_ORDER_100_MSEC:
+		return 100;
+	case H_LONG_BUSY_ORDER_1_SEC:
+		return 1000;
+	case H_LONG_BUSY_ORDER_10_SEC:
+		return 10000;
+	case H_LONG_BUSY_ORDER_100_SEC:
+		return 100000;
+	default:
+		return 1;
+	}
+}
+
+/* Notification Event Queue (NEQ) Entry bit masks */
+#define NEQE_EVENT_CODE		EHEA_BMASK_IBM(2, 7)
+#define NEQE_PORTNUM  		EHEA_BMASK_IBM(32, 47)
+#define NEQE_PORT_UP		EHEA_BMASK_IBM(16, 16)
+#define NEQE_EXTSWITCH_PORT_UP	EHEA_BMASK_IBM(17, 17)
+#define NEQE_EXTSWITCH_PRIMARY	EHEA_BMASK_IBM(18, 18)
+#define NEQE_PLID		EHEA_BMASK_IBM(16, 47)
+
+/* Notification Event Codes */
+#define EHEA_EC_PORTSTATE_CHG	0x30
+#define EHEA_EC_ADAPTER_MALFUNC	0x32
+#define EHEA_EC_PORT_MALFUNC	0x33
+
+/* Notification Event Log Register (NELR) bit masks */
+#define NELR_PORT_MALFUNC	EHEA_BMASK_IBM(61, 61)
+#define NELR_ADAPTER_MALFUNC	EHEA_BMASK_IBM(62, 62)
+#define NELR_PORTSTATE_CHG	EHEA_BMASK_IBM(63, 63)
+
+static inline long ehea_hcall_9arg_9ret(unsigned long opcode,
+					unsigned long arg1, unsigned long arg2,
+					unsigned long arg3, unsigned long arg4,
+					unsigned long arg5, unsigned long arg6,
+					unsigned long arg7, unsigned long arg8,
+					unsigned long arg9, unsigned long *out1,
+					unsigned long *out2,unsigned long *out3,
+					unsigned long *out4,unsigned long *out5,
+					unsigned long *out6,unsigned long *out7,
+					unsigned long *out8,unsigned long *out9)
+{
+	long hret = H_HARDWARE;
+	int i, sleep_msecs;
+
+	for (i = 0; i < 5; i++) {
+		hret = plpar_hcall_9arg_9ret(opcode,arg1, arg2, arg3, arg4,
+					     arg5, arg6, arg7, arg8, arg9, out1,
+					     out2, out3, out4, out5, out6, out7,
+					     out8, out9);
+
+		if (H_IS_LONG_BUSY(hret)) {
+			sleep_msecs = get_longbusy_msecs(hret);
+			msleep_interruptible(sleep_msecs);
+			continue;
+		}
+
+		if (hret < H_SUCCESS)
+			ehea_error("opcode=%lx hret=%lx"
+				   " arg1=%lx arg2=%lx arg3=%lx arg4=%lx"
+				   " arg5=%lx arg6=%lx arg7=%lx arg8=%lx"
+				   " arg9=%lx"
+				   " out1=%lx out2=%lx out3=%lx out4=%lx"
+				   " out5=%lx out6=%lx out7=%lx out8=%lx"
+				   " out9=%lx",
+				   opcode, hret, arg1, arg2, arg3, arg4, arg5,
+				   arg6, arg7, arg8, arg9, *out1, *out2, *out3,
+				   *out4, *out5, *out6, *out7, *out8, *out9);
+		return hret;
+	}
+	return H_BUSY;
+}
+
+static inline int hcp_epas_ctor(struct h_epas *epas, u64 paddr_kernel,
+				u64 paddr_user)
+{
+	epas->kernel.fw_handle = (u64) ioremap(paddr_kernel, PAGE_SIZE);
+	epas->user.fw_handle = paddr_user;
+	return 0;
+}
+
+static inline int hcp_epas_dtor(struct h_epas *epas)
+{
+
+	if (epas->kernel.fw_handle)
+		iounmap((void *)epas->kernel.fw_handle);
+	epas->user.fw_handle = epas->kernel.fw_handle = 0;
+	return 0;
+}
+
+struct hcp_modify_qp_cb_0 {
+	u64 qp_ctl_reg;		/* 00 */
+	u32 max_swqe;		/* 02 */
+	u32 max_rwqe;		/* 03 */
+	u32 port_nb;		/* 04 */
+	u32 reserved0;		/* 05 */
+	u64 qp_aer;		/* 06 */
+	u64 qp_tenure;		/* 08 */
+};
+
+/* Hcall Query/Modify Queue Pair Control Block 0 Selection Mask Bits */
+#define H_QPCB0_ALL             EHEA_BMASK_IBM(0, 5)
+#define H_QPCB0_QP_CTL_REG      EHEA_BMASK_IBM(0, 0)
+#define H_QPCB0_MAX_SWQE        EHEA_BMASK_IBM(1, 1)
+#define H_QPCB0_MAX_RWQE        EHEA_BMASK_IBM(2, 2)
+#define H_QPCB0_PORT_NB         EHEA_BMASK_IBM(3, 3)
+#define H_QPCB0_QP_AER          EHEA_BMASK_IBM(4, 4)
+#define H_QPCB0_QP_TENURE       EHEA_BMASK_IBM(5, 5)
+
+/* Queue Pair Control Register Status Bits */
+#define H_QP_CR_ENABLED		    0x8000000000000000ULL /* QP enabled */
+							  /* QP States: */
+#define H_QP_CR_STATE_RESET	    0x0000010000000000ULL /*  Reset */
+#define H_QP_CR_STATE_INITIALIZED   0x0000020000000000ULL /*  Initialized */
+#define H_QP_CR_STATE_RDY2RCV	    0x0000030000000000ULL /*  Ready to recv */
+#define H_QP_CR_STATE_RDY2SND	    0x0000050000000000ULL /*  Ready to send */
+#define H_QP_CR_STATE_ERROR	    0x0000800000000000ULL /*  Error */
+
+struct hcp_modify_qp_cb_1 {
+	u32 qpn;		/* 00 */
+	u32 qp_asyn_ev_eq_nb;	/* 01 */
+	u64 sq_cq_handle;	/* 02 */
+	u64 rq_cq_handle;	/* 04 */
+	/* sgel = scatter gather element */
+	u32 sgel_nb_sq;		/* 06 */
+	u32 sgel_nb_rq1;	/* 07 */
+	u32 sgel_nb_rq2;	/* 08 */
+	u32 sgel_nb_rq3;	/* 09 */
+};
+
+/* Hcall Query/Modify Queue Pair Control Block 1 Selection Mask Bits */
+#define H_QPCB1_ALL             EHEA_BMASK_IBM(0, 7)
+#define H_QPCB1_QPN             EHEA_BMASK_IBM(0, 0)
+#define H_QPCB1_ASYN_EV_EQ_NB   EHEA_BMASK_IBM(1, 1)
+#define H_QPCB1_SQ_CQ_HANDLE    EHEA_BMASK_IBM(2, 2)
+#define H_QPCB1_RQ_CQ_HANDLE    EHEA_BMASK_IBM(3, 3)
+#define H_QPCB1_SGEL_NB_SQ      EHEA_BMASK_IBM(4, 4)
+#define H_QPCB1_SGEL_NB_RQ1     EHEA_BMASK_IBM(5, 5)
+#define H_QPCB1_SGEL_NB_RQ2     EHEA_BMASK_IBM(6, 6)
+#define H_QPCB1_SGEL_NB_RQ3     EHEA_BMASK_IBM(7, 7)
+
+struct hcp_query_ehea {
+	u32 cur_num_qps;		/* 00 */
+	u32 cur_num_cqs;		/* 01 */
+	u32 cur_num_eqs;		/* 02 */
+	u32 cur_num_mrs;		/* 03 */
+	u32 auth_level;			/* 04 */
+	u32 max_num_qps;		/* 05 */
+	u32 max_num_cqs;		/* 06 */
+	u32 max_num_eqs;		/* 07 */
+	u32 max_num_mrs;		/* 08 */
+	u32 reserved0;			/* 09 */
+	u32 int_clock_freq;		/* 10 */
+	u32 max_num_pds;		/* 11 */
+	u32 max_num_addr_handles;	/* 12 */
+	u32 max_num_cqes;		/* 13 */
+	u32 max_num_wqes;		/* 14 */
+	u32 max_num_sgel_rq1wqe;	/* 15 */
+	u32 max_num_sgel_rq2wqe;	/* 16 */
+	u32 max_num_sgel_rq3wqe;	/* 17 */
+	u32 mr_page_size;		/*define */
+	u32 reserved1;			/* 19 */
+	u64 max_mr_size;		/* 20 */
+	u64 reserved2;			/* 22 */
+	u32 num_ports;			/* 24 */
+	u32 reserved3;			/* 25 */
+	u32 reserved4;			/* 26 */
+	u32 reserved5;			/* 27 */
+	u64 max_mc_mac;			/* 28 */
+	u64 ehea_cap;			/* 30 */
+	u32 max_isn_per_eq;		/* 32 */
+	u32 max_num_neq;		/* 33 */
+	u64 max_num_vlan_ids;		/* 34 */
+	u32 max_num_port_group;		/* 36 */
+	u32 max_num_phys_port;		/* 37 */
+
+};
+
+/* Hcall Query/Modify Port Control Block defines */
+#define H_PORT_CB0	 0
+#define H_PORT_CB1	 1
+#define H_PORT_CB2	 2
+#define H_PORT_CB3	 3
+#define H_PORT_CB4	 4
+#define H_PORT_CB5	 5
+#define H_PORT_CB6	 6
+#define H_PORT_CB7	 7
+
+struct hcp_query_ehea_port_cb_0 {
+	u64 port_mac_addr;
+	u64 port_rc;
+	u64 reserved0;
+	u32 port_op_state;
+	u32 port_speed;
+	u32 ext_swport_op_state;
+	u32 neg_tpf_prpf;
+	u32 num_default_qps;
+	u32 reserved1;
+	u64 default_qpn_array[16];
+};
+
+/* Hcall Query/Modify Port Control Block 0 Selection Mask Bits */
+#define H_PORT_CB0_ALL		EHEA_BMASK_IBM(0, 7)    /* Set all bits */
+#define H_PORT_CB0_MAC		EHEA_BMASK_IBM(0, 0)    /* MAC address */
+#define H_PORT_CB0_PRC		EHEA_BMASK_IBM(1, 1)    /* Port Recv Control */
+#define H_PORT_CB0_DEFQPNARRAY	EHEA_BMASK_IBM(7, 7)    /* Default QPN Array */
+
+/*  Hcall Query Port: Returned port speed values */
+#define H_PORT_SPEED_10M_H	1	/*  10 Mbps, Half Duplex */
+#define H_PORT_SPEED_10M_F	2	/*  10 Mbps, Full Duplex */
+#define H_PORT_SPEED_100M_H	3	/* 100 Mbps, Half Duplex */
+#define H_PORT_SPEED_100M_F	4	/* 100 Mbps, Full Duplex */
+#define H_PORT_SPEED_1G_F	6	/*   1 Gbps, Full Duplex */
+#define H_PORT_SPEED_10G_F	8	/*  10 Gbps, Full Duplex */
+
+/* Port Receive Control Status Bits */
+#define PXLY_RC_VALID           EHEA_BMASK_IBM(49, 49)
+#define PXLY_RC_VLAN_XTRACT     EHEA_BMASK_IBM(50, 50)
+#define PXLY_RC_TCP_6_TUPLE     EHEA_BMASK_IBM(51, 51)
+#define PXLY_RC_UDP_6_TUPLE     EHEA_BMASK_IBM(52, 52)
+#define PXLY_RC_TCP_3_TUPLE     EHEA_BMASK_IBM(53, 53)
+#define PXLY_RC_TCP_2_TUPLE     EHEA_BMASK_IBM(54, 54)
+#define PXLY_RC_LLC_SNAP        EHEA_BMASK_IBM(55, 55)
+#define PXLY_RC_JUMBO_FRAME     EHEA_BMASK_IBM(56, 56)
+#define PXLY_RC_FRAG_IP_PKT     EHEA_BMASK_IBM(57, 57)
+#define PXLY_RC_TCP_UDP_CHKSUM  EHEA_BMASK_IBM(58, 58)
+#define PXLY_RC_IP_CHKSUM       EHEA_BMASK_IBM(59, 59)
+#define PXLY_RC_MAC_FILTER      EHEA_BMASK_IBM(60, 60)
+#define PXLY_RC_UNTAG_FILTER    EHEA_BMASK_IBM(61, 61)
+#define PXLY_RC_VLAN_TAG_FILTER EHEA_BMASK_IBM(62, 63)
+
+#define PXLY_RC_VLAN_FILTER     2
+#define PXLY_RC_VLAN_PERM       0
+
+
+#define H_PORT_CB1_ALL          0x8000000000000000ULL
+
+struct hcp_query_ehea_port_cb_1 {
+	u64 vlan_filter[64];
+};
+
+#define H_PORT_CB2_ALL          0xFFE0000000000000ULL
+
+struct hcp_query_ehea_port_cb_2 {
+	u64 rxo;
+	u64 rxucp;
+	u64 rxufd;
+	u64 rxuerr;
+	u64 rxftl;
+	u64 rxmcp;
+	u64 rxbcp;
+	u64 txo;
+	u64 txucp;
+	u64 txmcp;
+	u64 txbcp;
+};
+
+struct hcp_query_ehea_port_cb_3 {
+	u64 vlan_bc_filter[64];
+	u64 vlan_mc_filter[64];
+	u64 vlan_un_filter[64];
+	u64 port_mac_hash_array[64];
+};
+
+#define H_PORT_CB4_ALL          0xF000000000000000ULL
+#define H_PORT_CB4_JUMBO        0x1000000000000000ULL
+
+struct hcp_query_ehea_port_cb_4 {
+	u32 port_speed;
+	u32 pause_frame;
+	u32 ens_port_op_state;
+	u32 jumbo_frame;
+	u32 ens_port_wrap;
+};
+
+struct hcp_query_ehea_port_cb_5 {
+	u64 prc;	        /* 00 */
+	u64 uaa;		/* 01 */
+	u64 macvc;		/* 02 */
+	u64 xpcsc;		/* 03 */
+	u64 xpcsp;		/* 04 */
+	u64 pcsid;		/* 05 */
+	u64 xpcsst;		/* 06 */
+	u64 pthlb;		/* 07 */
+	u64 pthrb;		/* 08 */
+	u64 pqu;		/* 09 */
+	u64 pqd;		/* 10 */
+	u64 prt;		/* 11 */
+	u64 wsth;		/* 12 */
+	u64 rcb;		/* 13 */
+	u64 rcm;		/* 14 */
+	u64 rcu;		/* 15 */
+	u64 macc;		/* 16 */
+	u64 pc;			/* 17 */
+	u64 pst;		/* 18 */
+	u64 ducqpn;		/* 19 */
+	u64 mcqpn;		/* 20 */
+	u64 mma;		/* 21 */
+	u64 pmc0h;		/* 22 */
+	u64 pmc0l;		/* 23 */
+	u64 lbc;		/* 24 */
+};
+
+#define H_PORT_CB6_ALL  0xFFFFFE7FFFFF8000ULL
+
+struct hcp_query_ehea_port_cb_6 {
+	u64 rxo;		/* 00 */
+	u64 rx64;		/* 01 */
+	u64 rx65;		/* 02 */
+	u64 rx128;		/* 03 */
+	u64 rx256;		/* 04 */
+	u64 rx512;		/* 05 */
+	u64 rx1024;		/* 06 */
+	u64 rxbfcs;		/* 07 */
+	u64 rxime;		/* 08 */
+	u64 rxrle;		/* 09 */
+	u64 rxorle;		/* 10 */
+	u64 rxftl;		/* 11 */
+	u64 rxjab;		/* 12 */
+	u64 rxse;		/* 13 */
+	u64 rxce;		/* 14 */
+	u64 rxrf;		/* 15 */
+	u64 rxfrag;		/* 16 */
+	u64 rxuoc;		/* 17 */
+	u64 rxcpf;		/* 18 */
+	u64 rxsb;		/* 19 */
+	u64 rxfd;		/* 20 */
+	u64 rxoerr;		/* 21 */
+	u64 rxaln;		/* 22 */
+	u64 ducqpn;		/* 23 */
+	u64 reserved0;		/* 24 */
+	u64 rxmcp;		/* 25 */
+	u64 rxbcp;		/* 26 */
+	u64 txmcp;		/* 27 */
+	u64 txbcp;		/* 28 */
+	u64 txo;		/* 29 */
+	u64 tx64;		/* 30 */
+	u64 tx65;		/* 31 */
+	u64 tx128;		/* 32 */
+	u64 tx256;		/* 33 */
+	u64 tx512;		/* 34 */
+	u64 tx1024;		/* 35 */
+	u64 txbfcs;		/* 36 */
+	u64 txcpf;		/* 37 */
+	u64 txlf;		/* 38 */
+	u64 txrf;		/* 39 */
+	u64 txime;		/* 40 */
+	u64 txsc;		/* 41 */
+	u64 txmc;		/* 42 */
+	u64 txsqe;		/* 43 */
+	u64 txdef;		/* 44 */
+	u64 txlcol;		/* 45 */
+	u64 txexcol;		/* 46 */
+	u64 txcse;		/* 47 */
+	u64 txbor;		/* 48 */
+};
+
+struct hcp_query_ehea_port_cb_7 {
+	u64 def_uc_qpn;
+};
+
+u64 ehea_h_query_ehea_qp(const u64 hcp_adapter_handle,
+			 const u8 qp_category,
+			 const u64 qp_handle, const u64 sel_mask,
+			 void *cb_addr);
+
+u64 ehea_h_modify_ehea_qp(const u64 hcp_adapter_handle,
+			  const u8 cat,
+			  const u64 qp_handle,
+			  const u64 sel_mask,
+			  void *cb_addr,
+			  u64 * inv_attr_id,
+			  u64 * proc_mask, u16 * out_swr, u16 * out_rwr);
+
+u64 ehea_h_alloc_resource_eq(const u64 hcp_adapter_handle,
+			     struct ehea_eq *ehea_eq,
+			     struct ehea_eq_attr *eq_attr, u64 * eq_handle);
+
+u64 ehea_h_alloc_resource_cq(const u64 hcp_adapter_handle,
+			     struct ehea_cq *ehea_cq,
+			     struct ehea_cq_attr *cq_attr,
+			     u64 * cq_handle, struct h_epas *epas);
+
+u64 ehea_h_alloc_resource_qp(const u64 adapter_handle,
+			     struct ehea_qp *ehea_qp,
+			     struct ehea_qp_init_attr *init_attr,
+			     const u32 pd,
+			     u64 * qp_handle, struct h_epas *h_epas);
+
+#define H_REG_RPAGE_PAGE_SIZE          EHEA_BMASK_IBM(48,55)
+#define H_REG_RPAGE_QT                 EHEA_BMASK_IBM(62,63)
+
+u64 ehea_h_register_rpage(const u64 hcp_adapter_handle,
+			  const u8 pagesize,
+			  const u8 queue_type,
+			  const u64 resource_handle,
+			  const u64 log_pageaddr, u64 count);
+
+u64 ehea_h_register_rpage_eq(const u64 hcp_adapter_handle,
+			     const u64 eq_handle,
+			     const u8 pagesize,
+			     const u8 queue_type,
+			     const u64 log_pageaddr, const u64 count);
+
+u64 ehea_h_register_rpage_cq(const u64 hcp_adapter_handle,
+			     const u64 cq_handle,
+			     const u8 pagesize,
+			     const u8 queue_type,
+			     const u64 log_pageaddr,
+			     const u64 count, const struct h_epa epa);
+
+u64 ehea_h_register_rpage_qp(const u64 hcp_adapter_handle,
+			     const u64 qp_handle,
+			     const u8 pagesize,
+			     const u8 queue_type,
+			     const u64 log_pageaddr,
+			     const u64 count, struct h_epa epa);
+
+#define H_DISABLE_GET_EHEA_WQE_P  1
+#define H_DISABLE_GET_SQ_WQE_P    2
+#define H_DISABLE_GET_RQC         3
+
+u64 ehea_h_destroy_qp(const u64 hcp_adapter_handle, struct ehea_qp *qp,
+		      u64 qp_handle, struct h_epas *epas);
+
+u64 ehea_h_destroy_cq(const u64 hcp_adapter_handle, struct ehea_cq *cq,
+		      u64 cq_handle, struct h_epas *epas);
+
+u64 ehea_h_destroy_eq(const u64 hcp_adapter_handle, struct ehea_eq *eq,
+		      u64 eq_handle, struct h_epas *epas);
+
+u64 ehea_h_free_resource_mr(const u64 hcp_adapter_handle, const u64 mr_handle);
+
+u64 ehea_h_alloc_resource_mr(const u64 hcp_adapter_handle, const u64 vaddr,
+			     const u64 length, const u32 access_ctrl,
+			     const u32 pd, u64 * mr_handle, u32 * lkey);
+
+u64 ehea_h_register_rpage_mr(const u64 hcp_adapter_handle, const u64 mr_handle,
+			     const u8 pagesize, const u8 queue_type,
+			     const u64 log_pageaddr, const u64 count);
+u64 ehea_h_register_smr(const u64 adapter_handle, const u64 orig_mr_handle,
+			const u64 vaddr_in, const u32 access_ctrl, const u32 pd,
+			struct ehea_mr *mr);
+
+u64 ehea_h_query_ehea(const u64 hcp_adapter_handle, void *cb_addr);
+
+/* output param R5 */
+#define H_MEHEAPORT_CAT		EHEA_BMASK_IBM(40,47)
+#define H_MEHEAPORT_PN		EHEA_BMASK_IBM(48,63)
+
+u64 ehea_h_query_ehea_port(const u64 hcp_adapter_handle, const u16 port_num,
+			   const u8 cb_cat, const u64 select_mask,
+			   void *cb_addr);
+
+u64 ehea_h_modify_ehea_port(const u64 hcp_adapter_handle, const u16 port_num,
+			    const u8 cb_cat, const u64 select_mask,
+			    void *cb_addr);
+
+#define H_REGBCMC_PN            EHEA_BMASK_IBM(48, 63)
+#define H_REGBCMC_REGTYPE       EHEA_BMASK_IBM(61, 63)
+#define H_REGBCMC_MACADDR       EHEA_BMASK_IBM(16, 63)
+#define H_REGBCMC_VLANID        EHEA_BMASK_IBM(52, 63)
+
+u64 ehea_h_reg_dereg_bcmc(const u64 hcp_adapter_handle, const u16 port_num,
+			  const u8 reg_type, const u64 mc_mac_addr,
+			  const u16 vlan_id, const u32 hcall_id);
+
+u64 ehea_h_reset_events(const u64 hcp_adapter_handle, const u64 neq_handle,
+			const u64 event_mask);
+
+#endif	/* __EHEA_PHYP_H__ */
--- linux-2.6.18-rc4-orig/drivers/net/ehea/ehea_hcall.h	1969-12-31 16:00:00.000000000 -0800
+++ kernel/drivers/net/ehea/ehea_hcall.h	2006-08-18 00:01:00.781975060 -0700
@@ -0,0 +1,51 @@
+/*
+ *  linux/drivers/net/ehea/ehea_hcall.h
+ *
+ *  eHEA ethernet device driver for IBM eServer System p
+ *
+ *  (C) Copyright IBM Corp. 2006
+ *
+ *  Authors:
+ *       Christoph Raisch <raisch@de.ibm.com>
+ *       Jan-Bernd Themann <themann@de.ibm.com>
+ *       Thomas Klein <tklein@de.ibm.com>
+ *
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2, or (at your option)
+ * any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.	 See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+#ifndef __EHEA_HCALL_H__
+#define __EHEA_HCALL_H__
+
+/**
+ * This file contains HCALL defines that are to be included in the appropriate
+ * kernel files later
+ */
+
+#define H_ALLOC_HEA_RESOURCE   0x278
+#define H_MODIFY_HEA_QP        0x250
+#define H_QUERY_HEA_QP         0x254
+#define H_QUERY_HEA            0x258
+#define H_QUERY_HEA_PORT       0x25C
+#define H_MODIFY_HEA_PORT      0x260
+#define H_REG_BCMC             0x264
+#define H_DEREG_BCMC           0x268
+#define H_REGISTER_HEA_RPAGES  0x26C
+#define H_DISABLE_AND_GET_HEA  0x270
+#define H_GET_HEA_INFO         0x274
+#define H_ADD_CONN             0x284
+#define H_DEL_CONN             0x288
+
+#endif	/* __EHEA_HCALL_H__ */
