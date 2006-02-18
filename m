Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751504AbWBRBGG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751504AbWBRBGG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 20:06:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751816AbWBRBFt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 20:05:49 -0500
Received: from sj-iport-2-in.cisco.com ([171.71.176.71]:58254 "EHLO
	sj-iport-2.cisco.com") by vger.kernel.org with ESMTP
	id S1751504AbWBRA5m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 19:57:42 -0500
From: Roland Dreier <rolandd@cisco.com>
Subject: [PATCH 12/22] ehca low-level verbs
Date: Fri, 17 Feb 2006 16:57:39 -0800
To: linux-kernel@vger.kernel.org, linuxppc64-dev@ozlabs.org,
       openib-general@openib.org
Cc: SCHICKHJ@de.ibm.com, RAISCH@de.ibm.com, HNGUYEN@de.ibm.com,
       MEDER@de.ibm.com
Message-Id: <20060218005739.13620.15633.stgit@localhost.localdomain>
In-Reply-To: <20060218005532.13620.79663.stgit@localhost.localdomain>
References: <20060218005532.13620.79663.stgit@localhost.localdomain>
X-OriginalArrivalTime: 18 Feb 2006 00:57:39.0320 (UTC) FILETIME=[50A79780:01C63426]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Roland Dreier <rolandd@cisco.com>

What is ehca_init_module()?  It is declared but never defined.
---

 drivers/infiniband/hw/ehca/ehca_iverbs.h |  163 ++++++++++++++++++
 drivers/infiniband/hw/ehca/ehca_qes.h    |  274 ++++++++++++++++++++++++++++++
 2 files changed, 437 insertions(+), 0 deletions(-)

diff --git a/drivers/infiniband/hw/ehca/ehca_iverbs.h b/drivers/infiniband/hw/ehca/ehca_iverbs.h
new file mode 100644
index 0000000..b1319a9
--- /dev/null
+++ b/drivers/infiniband/hw/ehca/ehca_iverbs.h
@@ -0,0 +1,163 @@
+/*
+ *  IBM eServer eHCA Infiniband device driver for Linux on POWER
+ *
+ *  Function definitions for internal functions
+ *
+ *  Authors: Heiko J Schick <schickhj@de.ibm.com>
+ *           Khadija Souissi <souissik@de.ibm.com>
+ *           Christoph Raisch <raisch@de.ibm.com>
+ *           Hoang-Nam Nguyen <hnguyen@de.ibm.com>
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
+ *  $Id: ehca_iverbs.h,v 1.32 2006/02/06 10:17:34 schickhj Exp $
+ */
+
+#ifndef __EHCA_IVERBS_H__
+#define __EHCA_IVERBS_H__
+
+#include "ehca_classes.h"
+/** ehca internal verb for testuse
+ */
+void ehca_init_module(void);
+
+int ehca_query_device(struct ib_device *ibdev, struct ib_device_attr *props);
+int ehca_query_port(struct ib_device *ibdev,
+		    u8 port, struct ib_port_attr *props);
+int ehca_query_pkey(struct ib_device *ibdev, u8 port, u16 index, u16 * pkey);
+int ehca_query_gid(struct ib_device *ibdev, u8 port,
+		   int index, union ib_gid *gid);
+int ehca_modify_port(struct ib_device *ibdev,
+		     u8 port, int port_modify_mask,
+		     struct ib_port_modify *props);
+
+struct ib_pd *ehca_alloc_pd(struct ib_device *device,
+			    struct ib_ucontext *context,
+			    struct ib_udata *udata);
+
+int ehca_dealloc_pd(struct ib_pd *pd);
+
+struct ib_ah *ehca_create_ah(struct ib_pd *pd, struct ib_ah_attr *ah_attr);
+int ehca_modify_ah(struct ib_ah *ah, struct ib_ah_attr *ah_attr);
+int ehca_query_ah(struct ib_ah *ah, struct ib_ah_attr *ah_attr);
+int ehca_destroy_ah(struct ib_ah *ah);
+
+struct ib_cq *ehca_create_cq(struct ib_device *device, int cqe,
+			     struct ib_ucontext *context,
+			     struct ib_udata *udata);
+int ehca_resize_cq(struct ib_cq *cq, int cqe);
+
+int ehca_destroy_cq(struct ib_cq *cq);
+
+int ehca_poll_cq(struct ib_cq *cq, int num_entries, struct ib_wc *wc);
+
+int ehca_peek_cq(struct ib_cq *cq, int wc_cnt);
+
+int ehca_req_notify_cq(struct ib_cq *cq, enum ib_cq_notify cq_notify);
+
+struct ib_qp *ehca_create_qp(struct ib_pd *pd,
+			     struct ib_qp_init_attr *init_attr,
+			     struct ib_udata *udata);
+
+u64 ehca_define_sqp(struct ehca_shca *shca, struct ehca_qp *ibqp,
+			       struct ib_qp_init_attr *qp_init_attr);
+
+int ehca_modify_qp(struct ib_qp *ibqp, struct ib_qp_attr *attr, int attr_mask);
+
+int ehca_query_qp(struct ib_qp *qp, struct ib_qp_attr *qp_attr,
+		  int qp_attr_mask, struct ib_qp_init_attr *qp_init_attr);
+
+int ehca_destroy_qp(struct ib_qp *qp);
+
+int ehca_post_send(struct ib_qp *qp,
+		   struct ib_send_wr *send_wr, struct ib_send_wr **bad_send_wr);
+
+int ehca_post_recv(struct ib_qp *qp,
+		   struct ib_recv_wr *recv_wr, struct ib_recv_wr **bad_recv_wr);
+
+struct ib_mr *ehca_get_dma_mr(struct ib_pd *pd, int mr_access_flags);
+
+struct ib_mr *ehca_reg_phys_mr(struct ib_pd *pd,
+			       struct ib_phys_buf *phys_buf_array,
+			       int num_phys_buf,
+			       int mr_access_flags, u64 *iova_start);
+
+struct ib_mr *ehca_reg_user_mr(struct ib_pd *pd,
+			       struct ib_umem *region,
+			       int mr_access_flags, struct ib_udata *udata);
+
+int ehca_rereg_phys_mr(struct ib_mr *mr,
+		       int mr_rereg_mask,
+		       struct ib_pd *pd,
+		       struct ib_phys_buf *phys_buf_array,
+		       int num_phys_buf, int mr_access_flags, u64 *iova_start);
+
+int ehca_query_mr(struct ib_mr *mr, struct ib_mr_attr *mr_attr);
+
+int ehca_dereg_mr(struct ib_mr *mr);
+
+struct ib_mw *ehca_alloc_mw(struct ib_pd *pd);
+
+int ehca_bind_mw(struct ib_qp *qp,
+		 struct ib_mw *mw, struct ib_mw_bind *mw_bind);
+
+int ehca_dealloc_mw(struct ib_mw *mw);
+
+struct ib_fmr *ehca_alloc_fmr(struct ib_pd *pd,
+			      int mr_access_flags,
+			      struct ib_fmr_attr *fmr_attr);
+
+int ehca_map_phys_fmr(struct ib_fmr *fmr,
+		      u64 *page_list, int list_len, u64 iova);
+
+int ehca_unmap_fmr(struct list_head *fmr_list);
+
+int ehca_dealloc_fmr(struct ib_fmr *fmr);
+
+int ehca_attach_mcast(struct ib_qp *qp, union ib_gid *gid, u16 lid);
+
+int ehca_detach_mcast(struct ib_qp *qp, union ib_gid *gid, u16 lid);
+
+struct ib_ucontext *ehca_alloc_ucontext(struct ib_device *device,
+					struct ib_udata *udata);
+int ehca_dealloc_ucontext(struct ib_ucontext *context);
+
+int ehca_mmap(struct ib_ucontext *context, struct vm_area_struct *vma);
+
+int ehca_poll_eqs(void *data);
+
+int ehca_mmap_nopage(u64 foffset,u64 length,void ** mapped,struct vm_area_struct ** vma);
+int ehca_mmap_register(u64 physical,void ** mapped,struct vm_area_struct ** vma);
+int ehca_munmap(unsigned long addr, size_t len);
+
+#endif
diff --git a/drivers/infiniband/hw/ehca/ehca_qes.h b/drivers/infiniband/hw/ehca/ehca_qes.h
new file mode 100644
index 0000000..e9420e3
--- /dev/null
+++ b/drivers/infiniband/hw/ehca/ehca_qes.h
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
+ *
+ *  $Id: ehca_qes.h,v 1.9 2006/02/06 10:17:34 schickhj Exp $
+ */
+
+
+#ifndef _EHCA_QES_H_
+#define _EHCA_QES_H_
+
+/** DON'T include any kernel related files here!!!
+ * This file is used commonly in user and kernel space!!!
+ */
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
+#define  WQE_OPTYPE_SEND             0x80
+#define  WQE_OPTYPE_RDMAREAD         0x40
+#define  WQE_OPTYPE_RDMAWRITE        0x20
+#define  WQE_OPTYPE_CMPSWAP          0x10
+#define  WQE_OPTYPE_FETCHADD         0x08
+#define  WQE_OPTYPE_BIND             0x04
+
+#define  WQE_WRFLAG_REQ_SIGNAL_COM   0x80
+#define  WQE_WRFLAG_FENCE            0x40
+#define  WQE_WRFLAG_IMM_DATA_PRESENT 0x20
+#define  WQE_WRFLAG_SOLIC_EVENT      0x10
+
+#define  WQEF_CACHE_HINT             0x80
+#define  WQEF_CACHE_HINT_RD_WR       0x40
+#define  WQEF_TIMED_WQE              0x20
+#define  WQEF_PURGE                  0x08
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
