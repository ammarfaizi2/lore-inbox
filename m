Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965096AbWD0Ktw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965096AbWD0Ktw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 06:49:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965104AbWD0Ktc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 06:49:32 -0400
Received: from mtagate4.de.ibm.com ([195.212.29.153]:22139 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP id S965101AbWD0KtL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 06:49:11 -0400
Message-ID: <4450A1C0.3080209@de.ibm.com>
Date: Thu, 27 Apr 2006 12:49:36 +0200
From: Heiko J Schick <schihei@de.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.6 (Windows/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: openib-general@openib.org, Christoph Raisch <RAISCH@de.ibm.com>,
       Hoang-Nam Nguyen <HNGUYEN@de.ibm.com>, Marcus Eder <MEDER@de.ibm.com>,
       schihei@de.ibm.com, linux-kernel@vger.kernel.org,
       linuxppc-dev@ozlabs.org
Subject: [PATCH 13/16] ehca: firmware InfiniBand interface
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Heiko J Schick <schickhj@de.ibm.com>


  hcp_if.c | 2028 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  hcp_if.h |  398 ++++++++++++
  2 files changed, 2426 insertions(+)



--- linux-2.6.17-rc2-orig/drivers/infiniband/hw/ehca/hcp_if.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.17-rc2/drivers/infiniband/hw/ehca/hcp_if.h	2006-04-04 23:52:30.000000000 +0200
@@ -0,0 +1,398 @@
+/*
+ *  IBM eServer eHCA Infiniband device driver for Linux on POWER
+ *
+ *  Firmware Infiniband Interface code for POWER
+ *
+ *  Authors: Christoph Raisch <raisch@de.ibm.com>
+ *           Hoang-Nam Nguyen <hnguyen@de.ibm.com>
+ *           Gerd Bayer <gerd.bayer@de.ibm.com>
+ *           Waleri Fomin <fomin@de.ibm.com>
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
+ *  $Id: hcp_if.h,v 1.12 2006/04/04 21:52:30 nguyen Exp $
+ */
+
+#ifndef __HCP_IF_H__
+#define __HCP_IF_H__
+
+#include "ehca_classes.h"
+#include "hipz_hw.h"
+
+/**
+ * hipz_h_alloc_resource_eq - Allocate EQ resources in HW and FW, initalize
+ * resources, create the empty EQPT (ring).
+ *
+ * @eq_handle:         eq handle for this queue
+ * @act_nr_of_entries: actual number of queue entries
+ * @act_pages:         actual number of queue pages
+ * @eq_ist:            used by hcp_H_XIRR() call
+ */
+u64 hipz_h_alloc_resource_eq(const struct ipz_adapter_handle adapter_handle,
+			     struct ehca_pfeq *pfeq,
+			     const u32 neq_control,
+			     const u32 number_of_entries,
+			     struct ipz_eq_handle *eq_handle,
+			     u32 * act_nr_of_entries,
+			     u32 * act_pages,
+			     u32 * eq_ist);
+
+u64 hipz_h_reset_event(const struct ipz_adapter_handle adapter_handle,
+		       struct ipz_eq_handle eq_handle,
+		       const u64 event_mask);
+/**
+ * hipz_h_allocate_resource_cq - Allocate CQ resources in HW and FW, initialize
+ * resources, create the empty CQPT (ring).
+ *
+ * @eq_handle:         eq handle to use for this cq
+ * @cq_handle:         cq handle for this queue
+ * @act_nr_of_entries: actual number of queue entries
+ * @act_pages:         actual number of queue pages
+ * @galpas:            contain logical adress of priv. storage and
+ *                     log_user_storage
+ */
+u64 hipz_h_alloc_resource_cq(const struct ipz_adapter_handle adapter_handle,
+			     struct ehca_pfcq *pfcq,
+			     const struct ipz_eq_handle eq_handle,
+			     const u32 cq_token,
+			     const u32 number_of_entries,
+			     struct ipz_cq_handle *cq_handle,
+			     u32 * act_nr_of_entries,
+			     u32 * act_pages,
+			     struct h_galpas *galpas);
+
+/**
+ * hipz_h_alloc_resource_qp - Allocate QP resources in HW and FW,
+ * initialize resources, create empty QPPTs (2 rings).
+ *
+ * @h_galpas to access HCA resident QP attributes
+ */
+u64 hipz_h_alloc_resource_qp(const struct ipz_adapter_handle adapter_handle,
+			     struct ehca_pfqp *pfqp,
+			     const u8 servicetype,
+			     const u8 daqp_ctrl,
+			     const u8 signalingtype,
+			     const u8 ud_av_l_key_ctl,
+			     const struct ipz_cq_handle send_cq_handle,
+			     const struct ipz_cq_handle receive_cq_handle,
+			     const struct ipz_eq_handle async_eq_handle,
+			     const u32 qp_token,
+			     const struct ipz_pd pd,
+			     const u16 max_nr_send_wqes,
+			     const u16 max_nr_receive_wqes,
+			     const u8 max_nr_send_sges,
+			     const u8 max_nr_receive_sges,
+			     const u32 ud_av_l_key,
+			     struct ipz_qp_handle *qp_handle,
+			     u32 * qp_nr,
+			     u16 * act_nr_send_wqes,
+			     u16 * act_nr_receive_wqes,
+			     u8 * act_nr_send_sges,
+			     u8 * act_nr_receive_sges,
+			     u32 * nr_sq_pages,
+			     u32 * nr_rq_pages,
+			     struct h_galpas *h_galpas);
+
+u64 hipz_h_query_port(const struct ipz_adapter_handle adapter_handle,
+		      const u8 port_id,
+		      struct hipz_query_port *query_port_response_block);
+
+u64 hipz_h_query_hca(const struct ipz_adapter_handle adapter_handle,
+		     struct hipz_query_hca *query_hca_rblock);
+
+/**
+ * hipz_h_register_rpage - hcp_if.h internal function for all
+ * hcp_H_REGISTER_RPAGE calls.
+ *
+ * @logical_address_of_page: kv transformation to GX address in this routine
+ */
+u64 hipz_h_register_rpage(const struct ipz_adapter_handle adapter_handle,
+			  const u8 pagesize,
+			  const u8 queue_type,
+			  const u64 resource_handle,
+			  const u64 logical_address_of_page,
+			  u64 count);
+
+u64 hipz_h_register_rpage_eq(const struct ipz_adapter_handle adapter_handle,
+			     const struct ipz_eq_handle eq_handle,
+			     struct ehca_pfeq *pfeq,
+			     const u8 pagesize,
+			     const u8 queue_type,
+			     const u64 logical_address_of_page,
+			     const u64 count);
+
+u32 hipz_h_query_int_state(const struct ipz_adapter_handle
+			   hcp_adapter_handle,
+			   u32 ist);
+
+u64 hipz_h_register_rpage_cq(const struct ipz_adapter_handle adapter_handle,
+			     const struct ipz_cq_handle cq_handle,
+			     struct ehca_pfcq *pfcq,
+			     const u8 pagesize,
+			     const u8 queue_type,
+			     const u64 logical_address_of_page,
+			     const u64 count,
+			     const struct h_galpa gal);
+
+u64 hipz_h_register_rpage_qp(const struct ipz_adapter_handle adapter_handle,
+			     const struct ipz_qp_handle qp_handle,
+			     struct ehca_pfqp *pfqp,
+			     const u8 pagesize,
+			     const u8 queue_type,
+			     const u64 logical_address_of_page,
+			     const u64 count,
+			     const struct h_galpa galpa);
+
+u64 hipz_h_remove_rpt_cq(const struct ipz_adapter_handle adapter_handle,
+			 const struct ipz_cq_handle cq_handle,
+			 struct ehca_pfcq *pfcq);
+
+u64 hipz_h_remove_rpt_eq(const struct ipz_adapter_handle adapter_handle,
+			 const struct ipz_eq_handle eq_handle,
+			 struct ehca_pfeq *pfeq);
+
+u64 hipz_h_remove_rpt_qp(const struct ipz_adapter_handle adapter_handle,
+			 const struct ipz_qp_handle qp_handle,
+			 struct ehca_pfqp *pfqp);
+
+u64 hipz_h_disable_and_get_wqe(const struct ipz_adapter_handle adapter_handle,
+			       const struct ipz_qp_handle qp_handle,
+			       struct ehca_pfqp *pfqp,
+			       void **log_addr_next_sq_wqe_tb_processed,
+			       void **log_addr_next_rq_wqe_tb_processed,
+			       int dis_and_get_function_code);
+enum hcall_sigt {
+	HCALL_SIGT_NO_CQE = 0,
+	HCALL_SIGT_BY_WQE = 1,
+	HCALL_SIGT_EVERY = 2
+};
+
+u64 hipz_h_modify_qp(const struct ipz_adapter_handle adapter_handle,
+		     const struct ipz_qp_handle qp_handle,
+		     struct ehca_pfqp *pfqp,
+		     const u64 update_mask,
+		     struct hcp_modify_qp_control_block *mqpcb,
+		     struct h_galpa gal);
+
+u64 hipz_h_query_qp(const struct ipz_adapter_handle adapter_handle,
+		    const struct ipz_qp_handle qp_handle,
+		    struct ehca_pfqp *pfqp,
+		    struct hcp_modify_qp_control_block *qqpcb,
+		    struct h_galpa gal);
+
+u64 hipz_h_destroy_qp(const struct ipz_adapter_handle adapter_handle,
+		      struct ehca_qp *qp);
+
+u64 hipz_h_define_aqp0(const struct ipz_adapter_handle adapter_handle,
+		       const struct ipz_qp_handle qp_handle,
+		       struct h_galpa gal,
+		       u32 port);
+
+u64 hipz_h_define_aqp1(const struct ipz_adapter_handle adapter_handle,
+		       const struct ipz_qp_handle qp_handle,
+		       struct h_galpa gal,
+		       u32 port, u32 * pma_qp_nr,
+		       u32 * bma_qp_nr);
+
+u64 hipz_h_attach_mcqp(const struct ipz_adapter_handle adapter_handle,
+		       const struct ipz_qp_handle qp_handle,
+		       struct h_galpa gal,
+		       u16 mcg_dlid,
+		       u64 subnet_prefix, u64 interface_id);
+
+u64 hipz_h_detach_mcqp(const struct ipz_adapter_handle adapter_handle,
+		       const struct ipz_qp_handle qp_handle,
+		       struct h_galpa gal,
+		       u16 mcg_dlid,
+		       u64 subnet_prefix, u64 interface_id);
+
+u64 hipz_h_destroy_cq(const struct ipz_adapter_handle adapter_handle,
+		      struct ehca_cq *cq,
+		      u8 force_flag);
+
+u64 hipz_h_destroy_eq(const struct ipz_adapter_handle adapter_handle,
+		      struct ehca_eq *eq);
+
+/**
+ * hipz_h_alloc_resource_mr - Allocate MR resources in HW and FW, initialize
+ * resources.
+ *
+ * @pfmr:        platform specific for MR
+ * pfshca:       platform specific for SHCA
+ * vaddr:        Memory Region I/O Virtual Address
+ * @length:      Memory Region Length
+ * @access_ctrl: Memory Region Access Controls
+ * @pd:          Protection Domain
+ * @mr_handle:   Memory Region Handle
+ */
+u64 hipz_h_alloc_resource_mr(const struct ipz_adapter_handle adapter_handle,
+			     struct ehca_pfmr *pfmr,
+			     struct ehca_pfshca *pfshca,
+			     const u64 vaddr,
+			     const u64 length,
+			     const u32 access_ctrl,
+			     const struct ipz_pd pd,
+			     struct ipz_mrmw_handle *mr_handle,
+			     u32 * lkey,
+			     u32 * rkey);
+
+/**
+ * hipz_h_register_rpage_mr - Register MR resource page in HW and FW .
+ *
+ * @pfmr:       platform specific for MR
+ * @pfshca:     platform specific for SHCA
+ * @queue_type: must be zero for MR
+ */
+u64 hipz_h_register_rpage_mr(const struct ipz_adapter_handle adapter_handle,
+			     const struct ipz_mrmw_handle *mr_handle,
+			     struct ehca_pfmr *pfmr,
+			     struct ehca_pfshca *pfshca,
+			     const u8 pagesize,
+			     const u8 queue_type,
+			     const u64 logical_address_of_page,
+			     const u64 count);
+
+/**
+ * hipz_h_query_mr - Query MR in HW and FW.
+ *
+ * @pfmr:             platform specific for MR
+ * @mr_handle:        Memory Region Handle
+ * @mr_local_length:  Local MR Length
+ * @mr_local_vaddr:   Local MR I/O Virtual Address
+ * @mr_remote_length: Remote MR Length
+ * @mr_remote_vaddr   Remote MR I/O Virtual Address
+ * @access_ctrl:      Memory Region Access Controls
+ * @pd:               Protection Domain
+ * lkey:              L_Key
+ * rkey:              R_Key
+ */
+u64 hipz_h_query_mr(const struct ipz_adapter_handle adapter_handle,
+		    struct ehca_pfmr *pfmr,
+		    const struct ipz_mrmw_handle *mr_handle,
+		    u64 * mr_local_length,
+		    u64 * mr_local_vaddr,
+		    u64 * mr_remote_length,
+		    u64 * mr_remote_vaddr,
+		    u32 * access_ctrl,
+		    struct ipz_pd *pd,
+		    u32 * lkey,
+		    u32 * rkey);
+
+/**
+ * hipz_h_free_resource_mr - Free MR resources in HW and FW.
+ *
+ * @pfmr:      platform specific for MR
+ * @mr_handle: Memory Region Handle
+ */
+u64 hipz_h_free_resource_mr(const struct ipz_adapter_handle adapter_handle,
+			    struct ehca_pfmr *pfmr,
+			    const struct ipz_mrmw_handle *mr_handle);
+
+/**
+ * hipz_h_reregister_pmr - Reregister MR in HW and FW.
+ *
+ * @pfmr:        platform specific for MR
+ * @pfshca:      platform specific for SHCA
+ * @mr_handle:   Memory Region Handle
+ * @vaddr_in:    Memory Region I/O Virtual Address
+ * @length:      Memory Region Length
+ * @access_ctrl: Memory Region Access Controls
+ * @pd:          Protection Domain
+ * @mr_addr_cb:  Logical Address of MR Control Block
+ * @vaddr_out:   Memory Region I/O Virtual Address
+ * lkey:         L_Key
+ * rkey:         R_Key
+ *
+ */
+u64 hipz_h_reregister_pmr(const struct ipz_adapter_handle adapter_handle,
+			  struct ehca_pfmr *pfmr,
+			  struct ehca_pfshca *pfshca,
+			  const struct ipz_mrmw_handle *mr_handle,
+			  const u64 vaddr_in,
+			  const u64 length,
+			  const u32 access_ctrl,
+			  const struct ipz_pd pd,
+			  const u64 mr_addr_cb,
+			  u64 * vaddr_out,
+			  u32 * lkey,
+			  u32 * rkey);
+
+/**
+ * hipz_h_register_smr - Register shared MR in HW and FW.
+ *
+ * @pfmr:           platform specific for new shared MR
+ * @orig_pfmr:      platform specific for original MR
+ * @pfshca:         platform specific for SHCA
+ * @orig_mr_handle: Memory Region Handle of original MR
+ * @vaddr_in:       Memory Region I/O Virtual Address of new shared MR
+ * @access_ctrl:    Memory Region Access Controls of new shared MR
+ * @pd:             Protection Domain of new shared MR
+ * @mr_handle:      Memory Region Handle of new shared MR
+ * @lkey:           L_Key of new shared MR
+ * @rkey:           R_Key of new shared MR
+ */
+u64 hipz_h_register_smr(const struct ipz_adapter_handle adapter_handle,
+			struct ehca_pfmr *pfmr,
+			struct ehca_pfmr *orig_pfmr,
+			struct ehca_pfshca *pfshca,
+			const struct ipz_mrmw_handle *orig_mr_handle,
+			const u64 vaddr_in,
+			const u32 access_ctrl,
+			const struct ipz_pd pd,
+			struct ipz_mrmw_handle *mr_handle,
+			u32 * lkey,
+			u32 * rkey);
+
+u64 hipz_h_alloc_resource_mw(const struct ipz_adapter_handle adapter_handle,
+			     struct ehca_pfmw *pfmw,
+			     struct ehca_pfshca *pfshca,
+			     const struct ipz_pd pd,
+			     struct ipz_mrmw_handle *mw_handle,
+			     u32 * rkey);
+
+u64 hipz_h_query_mw(const struct ipz_adapter_handle adapter_handle,
+		    struct ehca_pfmw *pfmw,
+		    const struct ipz_mrmw_handle *mw_handle,
+		    u32 * rkey,
+		    struct ipz_pd *pd);
+
+u64 hipz_h_free_resource_mw(const struct ipz_adapter_handle adapter_handle,
+			    struct ehca_pfmw *pfmw,
+			    const struct ipz_mrmw_handle *mw_handle);
+
+u64 hipz_h_error_data(const struct ipz_adapter_handle adapter_handle,
+		      const u64 ressource_handle,
+		      void *rblock,
+		      unsigned long *byte_count);
+
+#endif /* __HCP_IF_H__ */
--- linux-2.6.17-rc2-orig/drivers/infiniband/hw/ehca/hcp_if.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.17-rc2/drivers/infiniband/hw/ehca/hcp_if.c	2006-04-04 23:52:30.000000000 +0200
@@ -0,0 +1,2028 @@
+/*
+ *  IBM eServer eHCA Infiniband device driver for Linux on POWER
+ *
+ *  Firmware Infiniband Interface code for POWER
+ *
+ *  Authors: Christoph Raisch <raisch@de.ibm.com>
+ *           Hoang-Nam Nguyen <hnguyen@de.ibm.com>
+ *           Gerd Bayer <gerd.bayer@de.ibm.com>
+ *           Waleri Fomin <fomin@de.ibm.com>
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
+ *  $Id: hcp_if.c,v 1.18 2006/04/04 21:52:30 nguyen Exp $
+ */
+
+#define DEB_PREFIX "hcpi"
+
+#include <asm/hvcall.h>
+#include "ehca_kernel.h"
+#include "ehca_tools.h"
+#include "hcp_if.h"
+#include "hcp_phyp.h"
+#include "hipz_fns.h"
+
+#define H_ALL_RES_QP_ENHANCED_OPS       EHCA_BMASK_IBM(9,11)
+#define H_ALL_RES_QP_PTE_PIN            EHCA_BMASK_IBM(12,12)
+#define H_ALL_RES_QP_SERVICE_TYPE       EHCA_BMASK_IBM(13,15)
+#define H_ALL_RES_QP_LL_RQ_CQE_POSTING  EHCA_BMASK_IBM(18,18)
+#define H_ALL_RES_QP_LL_SQ_CQE_POSTING  EHCA_BMASK_IBM(19,21)
+#define H_ALL_RES_QP_SIGNALING_TYPE     EHCA_BMASK_IBM(22,23)
+#define H_ALL_RES_QP_UD_AV_LKEY_CTRL    EHCA_BMASK_IBM(31,31)
+#define H_ALL_RES_QP_RESOURCE_TYPE      EHCA_BMASK_IBM(56,63)
+
+#define H_ALL_RES_QP_MAX_OUTST_SEND_WR  EHCA_BMASK_IBM(0,15)
+#define H_ALL_RES_QP_MAX_OUTST_RECV_WR  EHCA_BMASK_IBM(16,31)
+#define H_ALL_RES_QP_MAX_SEND_SGE       EHCA_BMASK_IBM(32,39)
+#define H_ALL_RES_QP_MAX_RECV_SGE       EHCA_BMASK_IBM(40,47)
+
+#define H_ALL_RES_QP_ACT_OUTST_SEND_WR  EHCA_BMASK_IBM(16,31)
+#define H_ALL_RES_QP_ACT_OUTST_RECV_WR  EHCA_BMASK_IBM(48,63)
+#define H_ALL_RES_QP_ACT_SEND_SGE       EHCA_BMASK_IBM(8,15)
+#define H_ALL_RES_QP_ACT_RECV_SGE       EHCA_BMASK_IBM(24,31)
+
+#define H_ALL_RES_QP_SQUEUE_SIZE_PAGES  EHCA_BMASK_IBM(0,31)
+#define H_ALL_RES_QP_RQUEUE_SIZE_PAGES  EHCA_BMASK_IBM(32,63)
+
+/* direct access qp controls */
+#define DAQP_CTRL_ENABLE          0x01
+#define DAQP_CTRL_SEND_COMPLETION 0x20
+#define DAQP_CTRL_RECV_COMPLETION 0x40
+
+/* We will remove this lines in SVN when it is included in the Linux kernel.
+ * We don't want to introducte unnecessary dependencies to a patched kernel.
+ */
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,17)
+struct hcall {
+        u64 regs[11];
+};
+
+static long plpar_hcall_7arg_7ret(unsigned long opcode,
+				  unsigned long arg1,  /* <R4  */
+				  unsigned long arg2,  /* <R5  */
+				  unsigned long arg3,  /* <R6  */
+				  unsigned long arg4,  /* <R7  */
+				  unsigned long arg5,  /* <R8  */
+				  unsigned long arg6,  /* <R9  */
+				  unsigned long arg7,  /* <R10 */
+				  unsigned long *out1, /* <R4  */
+				  unsigned long *out2, /* <R5  */
+				  unsigned long *out3, /* <R6  */
+				  unsigned long *out4, /* <R7  */
+				  unsigned long *out5, /* <R8  */
+				  unsigned long *out6, /* <R9  */
+				  unsigned long *out7  /* <R10 */
+	)
+{
+        struct hcall hcall_in = {
+                .regs[0] = opcode,
+                .regs[1] = arg1,
+                .regs[2] = arg2,
+                .regs[3] = arg3,
+                .regs[4] = arg4,
+                .regs[5] = arg5,
+                .regs[6] = arg6,
+                .regs[7] = arg7
+        };
+
+        struct hcall hcall = hcall_in;
+        long ret;
+
+        EDEB(7, "HCALL77_IN r3=%lx r4=%lx r5=%lx r6=%lx r7=%lx r8=%lx"
+             " r9=%lx r10=%lx r11=%lx", hcall.regs[0], hcall.regs[1],
+             hcall.regs[2], hcall.regs[3], hcall.regs[4], hcall.regs[5],
+             hcall.regs[6], hcall.regs[7], hcall.regs[8]);
+
+	__asm__ __volatile__("mr 3,%10\n"
+			     "mr 4,%11\n"
+			     "mr 5,%12\n"
+			     "mr 6,%13\n"
+			     "mr 7,%14\n"
+			     "mr 8,%15\n"
+			     "mr 9,%16\n"
+			     "mr 10,%17\n"
+			     "mr 11,%18\n"
+			     "mr 12,%19\n"
+			     ".long 0x44000022\n"
+			     "mr %0,3\n"
+			     "mr %1,4\n"
+			     "mr %2,5\n"
+			     "mr %3,6\n"
+			     "mr %4,7\n"
+			     "mr %5,8\n"
+			     "mr %6,9\n"
+			     "mr %7,10\n"
+			     "mr %8,11\n"
+			     "mr %9,12\n":"=r"(hcall.regs[0]),
+			     "=r"(hcall.regs[1]), "=r"(hcall.regs[2]),
+			     "=r"(hcall.regs[3]), "=r"(hcall.regs[4]),
+			     "=r"(hcall.regs[5]), "=r"(hcall.regs[6]),
+			     "=r"(hcall.regs[7]), "=r"(hcall.regs[8]),
+			     "=r"(hcall.regs[9])
+			     :"r"(hcall.regs[0]), "r"(hcall.regs[1]),
+			     "r"(hcall.regs[2]), "r"(hcall.regs[3]),
+			     "r"(hcall.regs[4]), "r"(hcall.regs[5]),
+			     "r"(hcall.regs[6]), "r"(hcall.regs[7]),
+			     "r"(hcall.regs[8]), "r"(hcall.regs[9])
+			     :"r0", "r2", "r3", "r4", "r5", "r6", "r7",
+			     "r8", "r9", "r10", "r11", "r12", "cc",
+			     "xer", "ctr", "lr", "cr0", "cr1", "cr5",
+			     "cr6", "cr7");
+
+	EDEB(7, "HCALL77_OUT r3=%lx r4=%lx r5=%lx r6=%lx r7=%lx r8=%lx"
+	     "r9=%lx r10=%lx r11=%lx", hcall.regs[0], hcall.regs[1],
+	     hcall.regs[2], hcall.regs[3], hcall.regs[4], hcall.regs[5],
+	     hcall.regs[6], hcall.regs[7], hcall.regs[8]);
+
+	ret = hcall.regs[0];
+	*out1 = hcall.regs[1];
+	*out2 = hcall.regs[2];
+	*out3 = hcall.regs[3];
+	*out4 = hcall.regs[4];
+	*out5 = hcall.regs[5];
+	*out6 = hcall.regs[6];
+	*out7 = hcall.regs[7];
+
+	return ret;
+}
+
+static long plpar_hcall_9arg_9ret(unsigned long opcode,
+				  unsigned long arg1,  /* <R4  */
+				  unsigned long arg2,  /* <R5  */
+				  unsigned long arg3,  /* <R6  */
+				  unsigned long arg4,  /* <R7  */
+				  unsigned long arg5,  /* <R8  */
+				  unsigned long arg6,  /* <R9  */
+				  unsigned long arg7,  /* <R10 */
+				  unsigned long arg8,  /* <R11 */
+				  unsigned long arg9,  /* <R12 */
+				  unsigned long *out1, /* <R4  */
+				  unsigned long *out2, /* <R5  */
+				  unsigned long *out3, /* <R6  */
+				  unsigned long *out4, /* <R7  */
+				  unsigned long *out5, /* <R8  */
+				  unsigned long *out6, /* <R9  */
+				  unsigned long *out7, /* <R10 */
+				  unsigned long *out8, /* <R11 */
+				  unsigned long *out9  /* <R12 */
+        )
+{
+        struct hcall hcall_in = {
+                .regs[0] = opcode,
+                .regs[1] = arg1,
+                .regs[2] = arg2,
+                .regs[3] = arg3,
+                .regs[4] = arg4,
+                .regs[5] = arg5,
+                .regs[6] = arg6,
+                .regs[7] = arg7,
+                .regs[8] = arg8,
+                .regs[9] = arg9,
+        };
+
+        struct hcall hcall = hcall_in;
+        long ret;
+
+        EDEB(7,"HCALL99_IN  r3=%lx r4=%lx r5=%lx r6=%lx r7=%lx r8=%lx r9=%lx"
+             " r10=%lx r11=%lx r12=%lx",
+             hcall.regs[0], hcall.regs[1], hcall.regs[2], hcall.regs[3],
+             hcall.regs[4], hcall.regs[5], hcall.regs[6], hcall.regs[7],
+             hcall.regs[8], hcall.regs[9]);
+
+	__asm__ __volatile__("mr 3,%10\n"
+			     "mr 4,%11\n"
+			     "mr 5,%12\n"
+			     "mr 6,%13\n"
+			     "mr 7,%14\n"
+			     "mr 8,%15\n"
+			     "mr 9,%16\n"
+			     "mr 10,%17\n"
+			     "mr 11,%18\n"
+			     "mr 12,%19\n"
+			     ".long 0x44000022\n"
+			     "mr %0,3\n"
+			     "mr %1,4\n"
+			     "mr %2,5\n"
+			     "mr %3,6\n"
+			     "mr %4,7\n"
+			     "mr %5,8\n"
+			     "mr %6,9\n"
+			     "mr %7,10\n"
+			     "mr %8,11\n"
+			     "mr %9,12\n":"=r"(hcall.regs[0]),
+			     "=r"(hcall.regs[1]), "=r"(hcall.regs[2]),
+			     "=r"(hcall.regs[3]), "=r"(hcall.regs[4]),
+			     "=r"(hcall.regs[5]), "=r"(hcall.regs[6]),
+			     "=r"(hcall.regs[7]), "=r"(hcall.regs[8]),
+			     "=r"(hcall.regs[9])
+			     :"r"(hcall.regs[0]), "r"(hcall.regs[1]),
+			     "r"(hcall.regs[2]), "r"(hcall.regs[3]),
+			     "r"(hcall.regs[4]), "r"(hcall.regs[5]),
+			     "r"(hcall.regs[6]), "r"(hcall.regs[7]),
+			     "r"(hcall.regs[8]), "r"(hcall.regs[9])
+			     :"r0", "r2", "r3", "r4", "r5", "r6", "r7",
+			     "r8", "r9", "r10", "r11", "r12", "cc",
+			     "xer", "ctr", "lr", "cr0", "cr1", "cr5",
+			     "cr6", "cr7");
+
+	EDEB(7,"HCALL99_OUT r3=%lx r4=%lx r5=%lx r6=%lx r7=%lx r8=%lx "
+	     "r9=%lx r10=%lx r11=%lx r12=%lx", hcall.regs[0],
+	     hcall.regs[1], hcall.regs[2], hcall.regs[3], hcall.regs[4],
+	     hcall.regs[5], hcall.regs[6], hcall.regs[7], hcall.regs[8],
+	     hcall.regs[9]);
+
+	ret = hcall.regs[0];
+	*out1 = hcall.regs[1];
+	*out2 = hcall.regs[2];
+	*out3 = hcall.regs[3];
+	*out4 = hcall.regs[4];
+	*out5 = hcall.regs[5];
+	*out6 = hcall.regs[6];
+	*out7 = hcall.regs[7];
+	*out8 = hcall.regs[8];
+	*out9 = hcall.regs[9];
+
+        return ret;
+}
+
+#endif /* LINUX_VERSION_CODE */
+
+static u32 get_longbusy_msecs(int longbusy_rc)
+{
+	switch (longbusy_rc) {
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
+static long ehca_hcall_7arg_7ret(unsigned long opcode,
+				 unsigned long arg1,
+				 unsigned long arg2,
+				 unsigned long arg3,
+				 unsigned long arg4,
+				 unsigned long arg5,
+				 unsigned long arg6,
+				 unsigned long arg7,
+				 unsigned long *out1,
+				 unsigned long *out2,
+				 unsigned long *out3,
+				 unsigned long *out4,
+				 unsigned long *out5,
+				 unsigned long *out6,
+				 unsigned long *out7)
+{
+	long ret;
+	int i, sleep_msecs;
+
+	EDEB_EN(7, "opcode=%lx arg1=%lx arg2=%lx arg3=%lx arg4=%lx arg5=%lx"
+	        " arg6=%lx arg7=%lx", opcode, arg1, arg2, arg3, arg4, arg5,
+		arg6, arg7);
+
+	for (i = 0; i < 5; i++) {
+		ret = plpar_hcall_7arg_7ret(opcode,
+					    arg1, arg2, arg3, arg4,
+					    arg5, arg6, arg7,
+					    out1, out2, out3, out4,
+					    out5, out6,out7);
+
+		if (H_IS_LONG_BUSY(ret))
+			continue;
+
+		if (ret < H_SUCCESS)
+			EDEB_ERR(4, "opcode=%lx ret=%lx"
+				 " arg1=%lx arg2=%lx arg3=%lx arg4=%lx"
+				 " arg5=%lx arg6=%lx arg7=%lx"
+				 " out1=%lx out2=%lx out3=%lx out4=%lx"
+				 " out5=%lx out6=%lx out7=%lx",
+				 opcode, ret,
+				 arg1, arg2, arg3, arg4,
+				 arg5, arg6, arg7,
+				 *out1, *out2, *out3, *out4,
+				 *out5, *out6, *out7);
+
+		return ret;
+
+		sleep_msecs = get_longbusy_msecs(ret);
+		msleep_interruptible(sleep_msecs);
+	}
+
+	EDEB_EX(7, "opcode=%lx ret=%lx out1=%lx out2=%lx out3=%lx out4=%lx"
+		" out5=%lx out6=%lx out7=%lx", opcode, ret, *out1, *out2,
+		*out3, *out4, *out5, *out6, *out7);
+
+	return H_BUSY;
+}
+
+static long ehca_hcall_9arg_9ret(unsigned long opcode,
+				 unsigned long arg1,
+				 unsigned long arg2,
+				 unsigned long arg3,
+				 unsigned long arg4,
+				 unsigned long arg5,
+				 unsigned long arg6,
+				 unsigned long arg7,
+				 unsigned long arg8,
+				 unsigned long arg9,
+				 unsigned long *out1,
+				 unsigned long *out2,
+				 unsigned long *out3,
+				 unsigned long *out4,
+				 unsigned long *out5,
+				 unsigned long *out6,
+				 unsigned long *out7,
+				 unsigned long *out8,
+				 unsigned long *out9)
+{
+	long ret;
+	int i, sleep_msecs;
+
+	EDEB_EN(7, "opcode=%lx arg1=%lx arg2=%lx arg3=%lx arg4=%lx arg5=%lx"
+	        " arg6=%lx arg7=%lx arg8=%lx arg9=%lx", opcode, arg1, arg2,
+		arg3, arg4, arg5, arg6, arg7, arg8, arg9);
+
+
+	for (i = 0; i < 5; i++) {
+		ret = plpar_hcall_9arg_9ret(opcode,
+					    arg1, arg2, arg3, arg4,
+					    arg5, arg6, arg7, arg8,
+					    arg9,
+					    out1, out2, out3, out4,
+					    out5, out6, out7, out8,
+					    out9);
+
+		if (H_IS_LONG_BUSY(ret))
+			continue;
+
+		if (ret < H_SUCCESS)
+			EDEB_ERR(4, "opcode=%lx ret=%lx"
+				 " arg1=%lx arg2=%lx arg3=%lx arg4=%lx"
+				 " arg5=%lx arg6=%lx arg7=%lx arg8=%lx"
+				 " arg9=%lx"
+				 " out1=%lx out2=%lx out3=%lx out4=%lx"
+				 " out5=%lx out6=%lx out7=%lx out8=%lx"
+				 " out9=%lx",
+				 opcode, ret,
+				 arg1, arg2, arg3, arg4,
+				 arg5, arg6, arg7, arg8,
+				 arg9,
+				 *out1, *out2, *out3, *out4,
+				 *out5, *out6, *out7, *out8,
+				 *out9);
+
+		return ret;
+
+		sleep_msecs = get_longbusy_msecs(ret);
+		msleep_interruptible(sleep_msecs);
+	}
+
+	EDEB_EX(7, "opcode=%lx ret=%lx out1=%lx out2=%lx out3=%lx out4=%lx"
+		" out5=%lx out6=%lx out7=%lx out8=%lx out9=%lx", opcode, ret,
+		*out1, *out2, *out3, *out4, *out5, *out6, *out7, *out8, *out9);
+
+	return ret;
+}
+
+u64 hipz_h_alloc_resource_eq(const struct ipz_adapter_handle adapter_handle,
+			     struct ehca_pfeq *pfeq,
+			     const u32 neq_control,
+			     const u32 number_of_entries,
+			     struct ipz_eq_handle *eq_handle,
+			     u32 * act_nr_of_entries,
+			     u32 * act_pages,
+			     u32 * eq_ist)
+{
+	u64 retcode;
+	u64 dummy;
+	u64 act_nr_of_entries_out = 0;
+	u64 act_pages_out         = 0;
+	u64 eq_ist_out            = 0;
+	u64 allocate_controls     = 0;
+	u32 x = (u64)(&x);
+
+	EDEB_EN(7, "pfeq=%p adapter_handle=%lx  new_control=%x"
+		   " number_of_entries=%x",
+		   pfeq, adapter_handle.handle, neq_control,
+		   number_of_entries);
+
+#ifndef EHCA_USE_HCALL
+	retcode = simp_h_alloc_resource_eq(adapter_handle, pfeq,
+					   neq_control,
+					   number_of_entries,
+					   eq_handle,
+					   act_nr_of_entries,
+					   act_pages, eq_ist);
+#else
+
+	/* resource type */
+	allocate_controls = 3ULL;
+
+	/* ISN is associated */
+	if (neq_control != 1) {
+		allocate_controls = (1ULL << (63 - 7)) | allocate_controls;
+	}
+
+	/* notification event queue */
+	if (neq_control == 1) {
+		allocate_controls = (1ULL << 63) | allocate_controls;
+	}
+
+	retcode = ehca_hcall_7arg_7ret(H_ALLOC_RESOURCE,
+				       adapter_handle.handle,  /* r4 */
+				       allocate_controls,      /* r5 */
+				       number_of_entries,      /* r6 */
+				       0, 0, 0, 0,
+				       &eq_handle->handle,     /* r4 */
+				       &dummy,	               /* r5 */
+				       &dummy,	               /* r6 */
+				       &act_nr_of_entries_out, /* r7 */
+				       &act_pages_out,	       /* r8 */
+				       &eq_ist_out,            /* r8 */
+				       &dummy);
+
+	*act_nr_of_entries = (u32) act_nr_of_entries_out;
+	*act_pages         = (u32) act_pages_out;
+	*eq_ist            = (u32) eq_ist_out;
+
+#endif /* EHCA_USE_HCALL */
+
+	if (retcode == H_NOT_ENOUGH_RESOURCES) {
+		EDEB_ERR(4, "Not enough resource - retcode=%lx ", retcode);
+	}
+
+	EDEB_EX(7, "act_nr_of_entries=%x act_pages=%x eq_ist=%x",
+		*act_nr_of_entries, *act_pages, *eq_ist);
+
+	return retcode;
+}
+
+u64 hipz_h_reset_event(const struct ipz_adapter_handle adapter_handle,
+		       struct ipz_eq_handle eq_handle,
+		       const u64 event_mask)
+{
+	u64 retcode = 0;
+	u64 dummy;
+
+	EDEB_EN(7, "eq_handle=%lx, adapter_handle=%lx  event_mask=%lx",
+		   eq_handle.handle, adapter_handle.handle, event_mask);
+
+	retcode = ehca_hcall_7arg_7ret(H_RESET_EVENTS,
+				       adapter_handle.handle, /* r4 */
+				       eq_handle.handle,      /* r5 */
+				       event_mask,	       /* r6 */
+				       0, 0, 0, 0,
+				       &dummy,
+				       &dummy,
+				       &dummy,
+				       &dummy,
+				       &dummy,
+				       &dummy,
+				       &dummy);
+
+	EDEB(7, "retcode=%lx", retcode);
+
+	return retcode;
+}
+
+u64 hipz_h_alloc_resource_cq(const struct ipz_adapter_handle adapter_handle,
+			     struct ehca_pfcq *pfcq,
+			     const struct ipz_eq_handle eq_handle,
+			     const u32 cq_token,
+			     const u32  number_of_entries,
+			     struct ipz_cq_handle *cq_handle,
+			     u32 * act_nr_of_entries,
+			     u32 * act_pages,
+			     struct h_galpas *galpas)
+{
+	u64 retcode = 0;
+	u64 dummy;
+	u64 act_nr_of_entries_out;
+	u64 act_pages_out;
+	u64 g_la_privileged_out;
+	u64 g_la_user_out;
+	/* stack location is a unique identifier for a process from beginning
+	 * to end of this frame */
+	u32 x = (u64)(&x);
+
+	EDEB_EN(7, "pfcq=%p adapter_handle=%lx eq_handle=%lx cq_token=%x"
+		" number_of_entries=%x",
+		pfcq, adapter_handle.handle, eq_handle.handle,
+		cq_token, number_of_entries);
+
+#ifndef EHCA_USE_HCALL
+	retcode = simp_h_alloc_resource_cq(adapter_handle,
+					   pfcq,
+					   eq_handle,
+					   cq_token,
+					   number_of_entries,
+					   cq_handle,
+					   act_nr_of_entries,
+					   act_pages, galpas);
+#else
+	retcode = ehca_hcall_7arg_7ret(H_ALLOC_RESOURCE,
+				       adapter_handle.handle, /* r4  */
+				       2,	               /* r5  */
+				       eq_handle.handle,      /* r6  */
+				       cq_token,	       /* r7  */
+				       number_of_entries,     /* r8  */
+				       0, 0,
+				       &cq_handle->handle,    /* r4  */
+				       &dummy,	               /* r5  */
+				       &dummy,	               /* r6  */
+				       &act_nr_of_entries_out,/* r7  */
+				       &act_pages_out,	       /* r8  */
+				       &g_la_privileged_out,  /* r9  */
+				       &g_la_user_out);       /* r10 */
+
+	*act_nr_of_entries = (u32) act_nr_of_entries_out;
+	*act_pages = (u32) act_pages_out;
+
+	if (retcode == 0) {
+		hcp_galpas_ctor(galpas, g_la_privileged_out, g_la_user_out);
+	}
+#endif /* EHCA_USE_HCALL */
+
+	if (retcode == H_NOT_ENOUGH_RESOURCES) {
+		EDEB_ERR(4, "Not enough resources. retcode=%lx", retcode);
+	}
+
+	EDEB_EX(7, "cq_handle=%lx act_nr_of_entries=%x act_pages=%x",
+		cq_handle->handle, *act_nr_of_entries, *act_pages);
+
+	return retcode;
+}
+
+u64 hipz_h_alloc_resource_qp(const struct ipz_adapter_handle adapter_handle,
+			     struct ehca_pfqp *pfqp,
+			     const u8 servicetype,
+			     const u8 daqp_ctrl,
+			     const u8 signalingtype,
+			     const u8 ud_av_l_key_ctl,
+			     const struct ipz_cq_handle send_cq_handle,
+			     const struct ipz_cq_handle receive_cq_handle,
+			     const struct ipz_eq_handle async_eq_handle,
+			     const u32 qp_token,
+			     const struct ipz_pd pd,
+			     const u16 max_nr_send_wqes,
+			     const u16 max_nr_receive_wqes,
+			     const u8 max_nr_send_sges,
+			     const u8 max_nr_receive_sges,
+			     const u32 ud_av_l_key,
+			     struct ipz_qp_handle *qp_handle,
+			     u32 * qp_nr,
+			     u16 * act_nr_send_wqes,
+			     u16 * act_nr_receive_wqes,
+			     u8 * act_nr_send_sges,
+			     u8 * act_nr_receive_sges,
+			     u32 * nr_sq_pages,
+			     u32 * nr_rq_pages,
+			     struct h_galpas *h_galpas)
+{
+	u64 retcode = H_SUCCESS;
+	u64 allocate_controls;
+	u64 max_r10_reg;
+	u64 dummy         = 0;
+	u64 qp_nr_out     = 0;
+	u64 r6_out        = 0;
+	u64 r7_out        = 0;
+	u64 r8_out        = 0;
+	u64 g_la_user_out = 0;
+	u64 r11_out       = 0;
+
+	EDEB_EN(7, "pfqp=%p adapter_handle=%lx servicetype=%x signalingtype=%x"
+		" ud_av_l_key=%x send_cq_handle=%lx receive_cq_handle=%lx"
+		" async_eq_handle=%lx qp_token=%x  pd=%x max_nr_send_wqes=%x"
+		" max_nr_receive_wqes=%x max_nr_send_sges=%x"
+		" max_nr_receive_sges=%x ud_av_l_key=%x galpa.pid=%x",
+		pfqp, adapter_handle.handle, servicetype, signalingtype,
+		ud_av_l_key, send_cq_handle.handle,
+		receive_cq_handle.handle, async_eq_handle.handle, qp_token,
+		pd.value, max_nr_send_wqes, max_nr_receive_wqes,
+		max_nr_send_sges, max_nr_receive_sges, ud_av_l_key,
+		h_galpas->pid);
+
+#ifndef EHCA_USE_HCALL
+	retcode = simp_h_alloc_resource_qp(adapter_handle,
+					   pfqp,
+					   servicetype,
+					   signalingtype,
+					   ud_av_l_key_ctl,
+					   send_cq_handle,
+					   receive_cq_handle,
+					   async_eq_handle,
+					   qp_token,
+					   pd,
+					   max_nr_send_wqes,
+					   max_nr_receive_wqes,
+					   max_nr_send_sges,
+					   max_nr_receive_sges,
+					   ud_av_l_key,
+					   qp_handle,
+					   qp_nr,
+					   act_nr_send_wqes,
+					   act_nr_receive_wqes,
+					   act_nr_send_sges,
+					   act_nr_receive_sges,
+					   nr_sq_pages, nr_rq_pages, h_galpas);
+
+#else
+	allocate_controls =
+		EHCA_BMASK_SET(H_ALL_RES_QP_ENHANCED_OPS,
+			       (daqp_ctrl & DAQP_CTRL_ENABLE) ? 1 : 0)
+		| EHCA_BMASK_SET(H_ALL_RES_QP_PTE_PIN, 0)
+		| EHCA_BMASK_SET(H_ALL_RES_QP_SERVICE_TYPE, servicetype)
+		| EHCA_BMASK_SET(H_ALL_RES_QP_SIGNALING_TYPE, signalingtype)
+		| EHCA_BMASK_SET(H_ALL_RES_QP_LL_RQ_CQE_POSTING,
+				 (daqp_ctrl & DAQP_CTRL_RECV_COMPLETION) ? 1 : 0)
+		| EHCA_BMASK_SET(H_ALL_RES_QP_LL_SQ_CQE_POSTING,
+				 (daqp_ctrl & DAQP_CTRL_SEND_COMPLETION) ? 1 : 0)
+		| EHCA_BMASK_SET(H_ALL_RES_QP_UD_AV_LKEY_CTRL,
+				 ud_av_l_key_ctl)
+		| EHCA_BMASK_SET(H_ALL_RES_QP_RESOURCE_TYPE, 1);
+
+	max_r10_reg =
+		EHCA_BMASK_SET(H_ALL_RES_QP_MAX_OUTST_SEND_WR,
+			       max_nr_send_wqes)
+		| EHCA_BMASK_SET(H_ALL_RES_QP_MAX_OUTST_RECV_WR,
+				 max_nr_receive_wqes)
+		| EHCA_BMASK_SET(H_ALL_RES_QP_MAX_SEND_SGE,
+				 max_nr_send_sges)
+		| EHCA_BMASK_SET(H_ALL_RES_QP_MAX_RECV_SGE,
+				 max_nr_receive_sges);
+
+
+	retcode = ehca_hcall_9arg_9ret(H_ALLOC_RESOURCE,
+				       adapter_handle.handle,	 /* r4  */
+				       allocate_controls,	 /* r5  */
+				       send_cq_handle.handle,	 /* r6  */
+				       receive_cq_handle.handle, /* r7  */
+				       async_eq_handle.handle,	 /* r8  */
+				       ((u64) qp_token << 32)
+				       | pd.value,               /* r9  */
+				       max_r10_reg,	         /* r10 */
+				       ud_av_l_key,	         /* r11 */
+				       0,
+				       &qp_handle->handle,	 /* r4  */
+				       &qp_nr_out,	         /* r5  */
+				       &r6_out,	                 /* r6  */
+				       &r7_out,	                 /* r7  */
+				       &r8_out,	                 /* r8  */
+				       &dummy,	                 /* r9  */
+				       &g_la_user_out,	         /* r10 */
+				       &r11_out,
+				       &dummy);
+
+	/* extract outputs */
+	*qp_nr = (u32) qp_nr_out;
+	*act_nr_send_wqes = (u16)
+		EHCA_BMASK_GET(H_ALL_RES_QP_ACT_OUTST_SEND_WR,
+			       r6_out);
+	*act_nr_receive_wqes = (u16)
+		EHCA_BMASK_GET(H_ALL_RES_QP_ACT_OUTST_RECV_WR,
+			       r6_out);
+	*act_nr_send_sges =
+		(u8) EHCA_BMASK_GET(H_ALL_RES_QP_ACT_SEND_SGE,
+				    r7_out);
+	*act_nr_receive_sges =
+		(u8) EHCA_BMASK_GET(H_ALL_RES_QP_ACT_RECV_SGE,
+				    r7_out);
+	*nr_sq_pages =
+		(u32) EHCA_BMASK_GET(H_ALL_RES_QP_SQUEUE_SIZE_PAGES,
+				     r8_out);
+	*nr_rq_pages =
+		(u32) EHCA_BMASK_GET(H_ALL_RES_QP_RQUEUE_SIZE_PAGES,
+				     r8_out);
+	if (retcode == 0) {
+		hcp_galpas_ctor(h_galpas, g_la_user_out, g_la_user_out);
+	}
+#endif /* EHCA_USE_HCALL */
+
+	if (retcode == H_NOT_ENOUGH_RESOURCES) {
+		EDEB_ERR(4, "Not enough resources. retcode=%lx",
+			 retcode);
+	}
+
+	EDEB_EX(7, "qp_nr=%x act_nr_send_wqes=%x"
+		" act_nr_receive_wqes=%x act_nr_send_sges=%x"
+		" act_nr_receive_sges=%x nr_sq_pages=%x"
+		" nr_rq_pages=%x galpa.user=%lx galpa.kernel=%lx",
+		*qp_nr, *act_nr_send_wqes, *act_nr_receive_wqes,
+		*act_nr_send_sges, *act_nr_receive_sges, *nr_sq_pages,
+		*nr_rq_pages, h_galpas->user.fw_handle,
+		h_galpas->kernel.fw_handle);
+
+	return (retcode);
+}
+
+u64 hipz_h_query_port(const struct ipz_adapter_handle adapter_handle,
+		      const u8 port_id,
+		      struct hipz_query_port *query_port_response_block)
+{
+	u64 retcode = H_SUCCESS;
+	u64 dummy;
+	u64 r_cb;
+
+	EDEB_EN(7, "adapter_handle=%lx port_id %x",
+		adapter_handle.handle, port_id);
+
+	if ((((u64)query_port_response_block) & 0xfff) != 0) {
+		EDEB_ERR(4, "response block not page aligned");
+		retcode = H_PARAMETER;
+		return (retcode);
+	}
+
+	r_cb = virt_to_abs(query_port_response_block);
+
+	retcode = ehca_hcall_7arg_7ret(H_QUERY_PORT,
+				       adapter_handle.handle, /* r4 */
+				       port_id,	              /* r5 */
+				       r_cb,	              /* r6 */
+				       0, 0, 0, 0,
+				       &dummy,
+				       &dummy,
+				       &dummy,
+				       &dummy,
+				       &dummy,
+				       &dummy,
+				       &dummy);
+
+	EDEB_DMP(7, query_port_response_block, 64, "query_port_response_block");
+	EDEB(7, "offset31=%x offset35=%x offset36=%x",
+	     ((u32 *) query_port_response_block)[32],
+	     ((u32 *) query_port_response_block)[36],
+	     ((u32 *) query_port_response_block)[37]);
+	EDEB(7, "offset200=%x offset201=%x offset202=%x "
+	     "offset203=%x",
+	     ((u32 *) query_port_response_block)[0x200],
+	     ((u32 *) query_port_response_block)[0x201],
+	     ((u32 *) query_port_response_block)[0x202],
+	     ((u32 *) query_port_response_block)[0x203]);
+
+	EDEB_EX(7, "retcode=%lx", retcode);
+
+	return retcode;
+}
+
+u64 hipz_h_query_hca(const struct ipz_adapter_handle adapter_handle,
+		     struct hipz_query_hca *query_hca_rblock)
+{
+	u64 retcode = 0;
+	u64 dummy;
+	u64 r_cb;
+	EDEB_EN(7, "adapter_handle=%lx", adapter_handle.handle);
+
+	if ((((u64)query_hca_rblock) & 0xfff) != 0) {
+		EDEB_ERR(4, "response block not page aligned");
+		retcode = H_PARAMETER;
+		return (retcode);
+	}
+
+	r_cb = virt_to_abs(query_hca_rblock);
+
+	retcode = ehca_hcall_7arg_7ret(H_QUERY_HCA,
+				       adapter_handle.handle, /* r4 */
+				       r_cb,                  /* r5 */
+				       0, 0, 0, 0, 0,
+				       &dummy,
+				       &dummy,
+				       &dummy,
+				       &dummy,
+				       &dummy,
+				       &dummy,
+				       &dummy);
+
+	EDEB(7, "offset0=%x offset1=%x offset2=%x offset3=%x",
+	     ((u32 *) query_hca_rblock)[0],
+	     ((u32 *) query_hca_rblock)[1],
+	     ((u32 *) query_hca_rblock)[2], ((u32 *) query_hca_rblock)[3]);
+	EDEB(7, "offset4=%x offset5=%x offset6=%x offset7=%x",
+	     ((u32 *) query_hca_rblock)[4],
+	     ((u32 *) query_hca_rblock)[5],
+	     ((u32 *) query_hca_rblock)[6], ((u32 *) query_hca_rblock)[7]);
+	EDEB(7, "offset8=%x offset9=%x offseta=%x offsetb=%x",
+	     ((u32 *) query_hca_rblock)[8],
+	     ((u32 *) query_hca_rblock)[9],
+	     ((u32 *) query_hca_rblock)[10], ((u32 *) query_hca_rblock)[11]);
+	EDEB(7, "offsetc=%x offsetd=%x offsete=%x offsetf=%x",
+	     ((u32 *) query_hca_rblock)[12],
+	     ((u32 *) query_hca_rblock)[13],
+	     ((u32 *) query_hca_rblock)[14], ((u32 *) query_hca_rblock)[15]);
+	EDEB(7, "offset136=%x offset192=%x offset204=%x",
+	     ((u32 *) query_hca_rblock)[32],
+	     ((u32 *) query_hca_rblock)[48], ((u32 *) query_hca_rblock)[51]);
+	EDEB(7, "offset231=%x offset235=%x",
+	     ((u32 *) query_hca_rblock)[57], ((u32 *) query_hca_rblock)[58]);
+	EDEB(7, "offset200=%x offset201=%x offset202=%x offset203=%x",
+	     ((u32 *) query_hca_rblock)[0x201],
+	     ((u32 *) query_hca_rblock)[0x202],
+	     ((u32 *) query_hca_rblock)[0x203],
+	     ((u32 *) query_hca_rblock)[0x204]);
+
+	EDEB_EX(7, "retcode=%lx adapter_handle=%lx",
+		retcode, adapter_handle.handle);
+
+	return retcode;
+}
+
+u64 hipz_h_register_rpage(const struct ipz_adapter_handle adapter_handle,
+			  const u8 pagesize,
+			  const u8 queue_type,
+			  const u64 resource_handle,
+			  const u64 logical_address_of_page,
+			  u64 count)
+{
+	u64 retcode = 0;
+	u64 dummy;
+
+	EDEB_EN(7, "adapter_handle=%lx pagesize=%x queue_type=%x"
+		" resource_handle=%lx logical_address_of_page=%lx count=%lx",
+		adapter_handle.handle, pagesize, queue_type,
+		resource_handle, logical_address_of_page, count);
+
+	retcode = ehca_hcall_7arg_7ret(H_REGISTER_RPAGES,
+				       adapter_handle.handle,      /* r4  */
+				       queue_type | pagesize << 8, /* r5  */
+				       resource_handle,	           /* r6  */
+				       logical_address_of_page,    /* r7  */
+				       count,	                   /* r8  */
+				       0, 0,
+				       &dummy,
+				       &dummy,
+				       &dummy,
+				       &dummy,
+				       &dummy,
+				       &dummy,
+				       &dummy);
+
+	EDEB_EX(7, "retcode=%lx", retcode);
+
+	return retcode;
+}
+
+u64 hipz_h_register_rpage_eq(const struct ipz_adapter_handle adapter_handle,
+			     const struct ipz_eq_handle eq_handle,
+			     struct ehca_pfeq *pfeq,
+			     const u8 pagesize,
+			     const u8 queue_type,
+			     const u64 logical_address_of_page,
+			     const u64 count)
+{
+	u64 retcode = 0;
+
+	EDEB_EN(7, "pfeq=%p adapter_handle=%lx eq_handle=%lx pagesize=%x"
+		" queue_type=%x  logical_address_of_page=%lx count=%lx",
+		pfeq, adapter_handle.handle, eq_handle.handle, pagesize,
+		queue_type,logical_address_of_page, count);
+
+#ifndef EHCA_USE_HCALL
+	retcode =
+		simp_h_register_rpage_eq(adapter_handle, eq_handle, pfeq,
+					 pagesize, queue_type,
+					 logical_address_of_page, count);
+#else
+	if (count != 1) {
+		EDEB_ERR(4, "Ppage counter=%lx", count);
+		return (H_PARAMETER);
+	}
+	retcode = hipz_h_register_rpage(adapter_handle,
+					pagesize,
+					queue_type,
+					eq_handle.handle,
+					logical_address_of_page, count);
+#endif /* EHCA_USE_HCALL */
+
+	EDEB_EX(7, "retcode=%lx", retcode);
+
+	return retcode;
+}
+
+u32 hipz_h_query_int_state(const struct ipz_adapter_handle adapter_handle,
+			   u32 ist)
+{
+	u32 rc = 0;
+	u64 dummy = 0;
+
+	EDEB_EN(7, "ist=%x", ist);
+
+	rc = ehca_hcall_7arg_7ret(H_QUERY_INT_STATE,
+				 adapter_handle.handle, /* r4 */
+				 ist,                   /* r5 */
+				 0, 0, 0, 0, 0,
+				 &dummy,
+				 &dummy,
+				 &dummy,
+				 &dummy,
+				 &dummy,
+				 &dummy,
+				 &dummy);
+
+	if ((rc != H_SUCCESS) && (rc != H_BUSY))
+		EDEB_ERR(4, "Could not query interrupt state.");
+
+	EDEB_EX(7, "interrupt state: %x", rc);
+
+	return rc;
+}
+
+u64 hipz_h_register_rpage_cq(const struct ipz_adapter_handle adapter_handle,
+			     const struct ipz_cq_handle cq_handle,
+			     struct ehca_pfcq *pfcq,
+			     const u8 pagesize,
+			     const u8 queue_type,
+			     const u64 logical_address_of_page,
+			     const u64 count,
+			     const struct h_galpa gal)
+{
+	u64 retcode = 0;
+
+	EDEB_EN(7, "pfcq=%p adapter_handle=%lx cq_handle=%lx pagesize=%x"
+		" queue_type=%x  logical_address_of_page=%lx count=%lx",
+		pfcq, adapter_handle.handle, cq_handle.handle, pagesize,
+		queue_type, logical_address_of_page, count);
+
+#ifndef EHCA_USE_HCALL
+	retcode =
+		simp_h_register_rpage_cq(adapter_handle, cq_handle, pfcq,
+					 pagesize, queue_type,
+					 logical_address_of_page, count, gal);
+#else
+	if (count != 1) {
+		EDEB_ERR(4, "Page counter=%lx", count);
+		return (H_PARAMETER);
+	}
+
+	retcode =
+		hipz_h_register_rpage(adapter_handle, pagesize, queue_type,
+				      cq_handle.handle, logical_address_of_page,
+				      count);
+#endif /* EHCA_USE_HCALL */
+	EDEB_EX(7, "retcode=%lx", retcode);
+
+	return retcode;
+}
+
+u64 hipz_h_register_rpage_qp(const struct ipz_adapter_handle adapter_handle,
+			     const struct ipz_qp_handle qp_handle,
+			     struct ehca_pfqp *pfqp,
+			     const u8 pagesize,
+			     const u8 queue_type,
+			     const u64 logical_address_of_page,
+			     const u64 count,
+			     const struct h_galpa galpa)
+{
+	u64 retcode = 0;
+
+	EDEB_EN(7, "pfqp=%p adapter_handle=%lx qp_handle=%lx pagesize=%x"
+		" queue_type=%x  logical_address_of_page=%lx count=%lx",
+		pfqp, adapter_handle.handle, qp_handle.handle, pagesize,
+		queue_type, logical_address_of_page, count);
+
+#ifndef EHCA_USE_HCALL
+	retcode = simp_h_register_rpage_qp(adapter_handle,
+					   qp_handle,
+					   pfqp,
+					   pagesize,
+					   queue_type,
+					   logical_address_of_page,
+					   count, galpa);
+#else
+	if (count != 1) {
+		EDEB_ERR(4, "Page counter=%lx", count);
+		return (H_PARAMETER);
+	}
+
+	retcode = hipz_h_register_rpage(adapter_handle,
+					pagesize,
+					queue_type,
+					qp_handle.handle,
+					logical_address_of_page, count);
+#endif /* EHCA_USE_HCALL */
+	EDEB_EX(7, "retcode=%lx", retcode);
+
+	return retcode;
+}
+
+u64 hipz_h_remove_rpt_cq(const struct ipz_adapter_handle adapter_handle,
+			 const struct ipz_cq_handle cq_handle,
+			 struct ehca_pfcq *pfcq)
+{
+	u64 retcode = 0;
+
+	EDEB_EN(7, "pfcq=%p adapter_handle=%lx  cq_handle=%lx",
+		pfcq, adapter_handle.handle, cq_handle.handle);
+
+#ifndef EHCA_USE_HCALL
+	retcode = simp_h_remove_rpt_cq(adapter_handle, cq_handle, pfcq);
+#endif
+	EDEB_EX(7, "retcode=%lx", retcode);
+
+	return 0;
+}
+
+u64 hipz_h_remove_rpt_eq(const struct ipz_adapter_handle adapter_handle,
+			 const struct ipz_eq_handle eq_handle,
+			 struct ehca_pfeq *pfeq)
+{
+	u64 retcode = 0;
+
+	EDEB_EX(7, "adapter_handle=%lx eq_handle=%lx",
+		adapter_handle.handle, eq_handle.handle);
+
+#ifndef EHCA_USE_HCALL
+	retcode = simp_h_remove_rpt_eq(adapter_handle, eq_handle, pfeq);
+#endif
+	EDEB_EX(7, "retcode=%lx", retcode);
+
+	return 0;
+}
+
+u64 hipz_h_remove_rpt_qp(const struct ipz_adapter_handle adapter_handle,
+		     const struct ipz_qp_handle qp_handle,
+		     struct ehca_pfqp *pfqp)
+{
+	u64 retcode = 0;
+
+	EDEB_EN(7, "pfqp=%p adapter_handle=%lx qp_handle=%lx",
+		pfqp, adapter_handle.handle, qp_handle.handle);
+
+#ifndef EHCA_USE_HCALL
+	retcode = simp_h_remove_rpt_qp(adapter_handle, qp_handle, pfqp);
+#endif
+	EDEB_EX(7, "retcode=%lx", retcode);
+
+	return 0;
+}
+
+u64 hipz_h_disable_and_get_wqe(const struct ipz_adapter_handle adapter_handle,
+			       const struct ipz_qp_handle qp_handle,
+			       struct ehca_pfqp *pfqp,
+			       void **log_addr_next_sq_wqe2processed,
+			       void **log_addr_next_rq_wqe2processed,
+			       int dis_and_get_function_code)
+{
+	u64 retcode = 0;
+	u8 function_code = 1;
+	u64 dummy, dummy1, dummy2;
+
+	EDEB_EN(7, "pfqp=%p adapter_handle=%lx function=%x qp_handle=%lx",
+		pfqp, adapter_handle.handle, function_code, qp_handle.handle);
+
+	if (log_addr_next_sq_wqe2processed==NULL) {
+		log_addr_next_sq_wqe2processed = (void**)&dummy1;
+	}
+	if (log_addr_next_rq_wqe2processed==NULL) {
+		log_addr_next_rq_wqe2processed = (void**)&dummy2;
+	}
+#ifndef EHCA_USE_HCALL
+	retcode =
+		simp_h_disable_and_get_wqe(adapter_handle, qp_handle, pfqp,
+					   log_addr_next_sq_wqe2processed,
+					   log_addr_next_rq_wqe2processed);
+#else
+
+	retcode = ehca_hcall_7arg_7ret(H_DISABLE_AND_GETC,
+				       adapter_handle.handle,     /* r4 */
+				       dis_and_get_function_code, /* r5 */
+				       /* function code 1-disQP ret
+					* SQ RQ wqe ptr
+					* 2- ret SQ wqe ptr
+					* 3- ret. RQ count */
+				       qp_handle.handle,	   /* r6 */
+				       0, 0, 0, 0,
+				       (void*)log_addr_next_sq_wqe2processed,
+				       (void*)log_addr_next_rq_wqe2processed,
+				       &dummy,
+				       &dummy,
+				       &dummy,
+				       &dummy,
+				       &dummy);
+#endif /* EHCA_USE_HCALL */
+	EDEB_EX(7, "retcode=%lx  ladr_next_rq_wqe_out=%p"
+		" ladr_next_sq_wqe_out=%p", retcode,
+		*log_addr_next_sq_wqe2processed,
+		*log_addr_next_rq_wqe2processed);
+
+	return retcode;
+}
+
+u64 hipz_h_modify_qp(const struct ipz_adapter_handle adapter_handle,
+		     const struct ipz_qp_handle qp_handle,
+		     struct ehca_pfqp *pfqp,
+		     const u64 update_mask,
+		     struct hcp_modify_qp_control_block *mqpcb,
+		     struct h_galpa gal)
+{
+	u64 retcode = 0;
+	u64 invalid_attribute_identifier = 0;
+	u64 rc_attrib_mask = 0;
+	u64 dummy;
+	u64 r_cb;
+	EDEB_EN(7, "pfqp=%p adapter_handle=%lx qp_handle=%lx"
+		   " update_mask=%lx qp_state=%x mqpcb=%p",
+		   pfqp, adapter_handle.handle, qp_handle.handle,
+		   update_mask, mqpcb->qp_state, mqpcb);
+
+#ifndef EHCA_USE_HCALL
+	simp_h_modify_qp(adapter_handle, qp_handle, pfqp, update_mask,
+			 mqpcb, gal);
+#else
+	r_cb = virt_to_abs(mqpcb);
+	retcode = ehca_hcall_7arg_7ret(H_MODIFY_QP,
+				       adapter_handle.handle,         /* r4 */
+				       qp_handle.handle,	      /* r5 */
+				       update_mask,	              /* r6 */
+				       r_cb,	                      /* r7 */
+				       0, 0, 0,
+				       &invalid_attribute_identifier, /* r4 */
+				       &dummy,	                      /* r5 */
+				       &dummy,	                      /* r6 */
+				       &dummy,                        /* r7 */
+				       &dummy,	                      /* r8 */
+				       &rc_attrib_mask,               /* r9 */
+				       &dummy);
+#endif
+	if (retcode == H_NOT_ENOUGH_RESOURCES) {
+		EDEB_ERR(4, "Insufficient resources retcode=%lx", retcode);
+	}
+
+	EDEB_EX(7, "retcode=%lx invalid_attribute_identifier=%lx"
+		" invalid_attribute_MASK=%lx", retcode,
+		invalid_attribute_identifier, rc_attrib_mask);
+
+	return retcode;
+}
+
+u64 hipz_h_query_qp(const struct ipz_adapter_handle adapter_handle,
+		    const struct ipz_qp_handle qp_handle,
+		    struct ehca_pfqp *pfqp,
+		    struct hcp_modify_qp_control_block *qqpcb,
+		    struct h_galpa gal)
+{
+	u64 retcode = 0;
+	u64 dummy;
+	u64 r_cb;
+	EDEB_EN(7, "adapter_handle=%lx qp_handle=%lx",
+		adapter_handle.handle, qp_handle.handle);
+
+#ifndef EHCA_USE_HCALL
+	simp_h_query_qp(adapter_handle, qp_handle, qqpcb, gal);
+#else
+	r_cb = virt_to_abs(qqpcb);
+	EDEB(7, "r_cb=%lx", r_cb);
+
+	retcode = ehca_hcall_7arg_7ret(H_QUERY_QP,
+				       adapter_handle.handle, /* r4 */
+				       qp_handle.handle,      /* r5 */
+				       r_cb,	               /* r6 */
+				       0, 0, 0, 0,
+				       &dummy,
+				       &dummy,
+				       &dummy,
+				       &dummy,
+				       &dummy,
+				       &dummy,
+				       &dummy);
+
+#endif
+	EDEB_EX(7, "retcode=%lx", retcode);
+
+	return retcode;
+}
+
+u64 hipz_h_destroy_qp(const struct ipz_adapter_handle adapter_handle,
+		      struct ehca_qp *qp)
+{
+	u64 retcode = 0;
+	u64 dummy;
+	u64 ladr_next_sq_wqe_out;
+	u64 ladr_next_rq_wqe_out;
+
+	EDEB_EN(7, "qp = %p ,ipz_qp_handle=%lx adapter_handle=%lx",
+		qp, qp->ipz_qp_handle.handle, adapter_handle.handle);
+
+#ifndef EHCA_USE_HCALL
+	retcode =
+		simp_h_destroy_qp(adapter_handle, qp,
+				  qp->galpas.user);
+#else
+
+	retcode = hcp_galpas_dtor(&qp->galpas);
+
+	retcode = ehca_hcall_7arg_7ret(H_DISABLE_AND_GETC,
+				       adapter_handle.handle,     /* r4 */
+				       /* function code */
+				       1,	                   /* r5 */
+				       qp->ipz_qp_handle.handle,  /* r6 */
+				       0, 0, 0, 0,
+				       &ladr_next_sq_wqe_out,     /* r4 */
+				       &ladr_next_rq_wqe_out,     /* r5 */
+				       &dummy,
+				       &dummy,
+				       &dummy,
+				       &dummy,
+				       &dummy);
+	if (retcode == H_HARDWARE) {
+		EDEB_ERR(4, "HCA not operational. retcode=%lx", retcode);
+	}
+
+	retcode = ehca_hcall_7arg_7ret(H_FREE_RESOURCE,
+				       adapter_handle.handle,     /* r4 */
+				       qp->ipz_qp_handle.handle,  /* r5 */
+				       0, 0, 0, 0, 0,
+				       &dummy,
+				       &dummy,
+				       &dummy,
+				       &dummy,
+				       &dummy,
+				       &dummy,
+				       &dummy);
+#endif /* EHCA_USE_HCALL */
+
+	if (retcode == H_RESOURCE) {
+		EDEB_ERR(4, "Resource still in use. retcode=%lx", retcode);
+	}
+	EDEB_EX(7, "retcode=%lx", retcode);
+
+	return retcode;
+}
+
+u64 hipz_h_define_aqp0(const struct ipz_adapter_handle adapter_handle,
+		       const struct ipz_qp_handle qp_handle,
+		       struct h_galpa gal,
+		       u32 port)
+{
+	u64 retcode = 0;
+	u64 dummy;
+
+	EDEB_EN(7, "port=%x ipz_qp_handle=%lx adapter_handle=%lx",
+		port, qp_handle.handle, adapter_handle.handle);
+
+	retcode = ehca_hcall_7arg_7ret(H_DEFINE_AQP0,
+				       adapter_handle.handle, /* r4 */
+				       qp_handle.handle,      /* r5 */
+				       port,                  /* r6 */
+				       0, 0, 0, 0,
+				       &dummy,
+				       &dummy,
+				       &dummy,
+				       &dummy,
+				       &dummy,
+				       &dummy,
+				       &dummy);
+
+	EDEB_EX(7, "retcode=%lx", retcode);
+
+	return retcode;
+}
+
+u64 hipz_h_define_aqp1(const struct ipz_adapter_handle adapter_handle,
+		       const struct ipz_qp_handle qp_handle,
+		       struct h_galpa gal,
+		       u32 port, u32 * pma_qp_nr,
+		       u32 * bma_qp_nr)
+{
+	u64 retcode = 0;
+	u64 dummy;
+	u64 pma_qp_nr_out;
+	u64 bma_qp_nr_out;
+
+	EDEB_EN(7, "port=%x qp_handle=%lx adapter_handle=%lx",
+		port, qp_handle.handle, adapter_handle.handle);
+
+	retcode = ehca_hcall_7arg_7ret(H_DEFINE_AQP1,
+				       adapter_handle.handle, /* r4 */
+				       qp_handle.handle,      /* r5 */
+				       port,	               /* r6 */
+				       0, 0, 0, 0,
+				       &pma_qp_nr_out,        /* r4 */
+				       &bma_qp_nr_out,        /* r5 */
+				       &dummy,
+				       &dummy,
+				       &dummy,
+				       &dummy,
+				       &dummy);
+
+	*pma_qp_nr = (u32) pma_qp_nr_out;
+	*bma_qp_nr = (u32) bma_qp_nr_out;
+
+	if (retcode == H_ALIAS_EXIST) {
+		EDEB_ERR(4, "AQP1 already exists. retcode=%lx", retcode);
+	}
+
+	EDEB_EX(7, "retcode=%lx pma_qp_nr=%i bma_qp_nr=%i",
+		retcode, (int)*pma_qp_nr, (int)*bma_qp_nr);
+
+	return retcode;
+}
+
+u64 hipz_h_attach_mcqp(const struct ipz_adapter_handle adapter_handle,
+		       const struct ipz_qp_handle qp_handle,
+		       struct h_galpa gal,
+		       u16 mcg_dlid,
+		       u64 subnet_prefix, u64 interface_id)
+{
+	u64 retcode = 0;
+	u64 dummy;
+	u8 *dgid_sp = (u8*)&subnet_prefix;
+	u8 *dgid_ii = (u8*)&interface_id;
+
+	EDEB_EN(7, "qp_handle=%lx adapter_handle=%lx\nMCG_DGID ="
+		" %d.%d.%d.%d.%d.%d.%d.%d."
+		" %d.%d.%d.%d.%d.%d.%d.%d\n",
+		qp_handle.handle, adapter_handle.handle,
+		dgid_sp[0], dgid_sp[1],
+		dgid_sp[2], dgid_sp[3],
+		dgid_sp[4], dgid_sp[5],
+		dgid_sp[6], dgid_sp[7],
+		dgid_ii[0], dgid_ii[1],
+		dgid_ii[2], dgid_ii[3],
+		dgid_ii[4], dgid_ii[5],
+		dgid_ii[6], dgid_ii[7]);
+
+	retcode = ehca_hcall_7arg_7ret(H_ATTACH_MCQP,
+				       adapter_handle.handle,     /* r4 */
+				       qp_handle.handle,          /* r5 */
+				       mcg_dlid,                  /* r6 */
+				       interface_id,              /* r7 */
+				       subnet_prefix,             /* r8 */
+				       0, 0,
+				       &dummy,
+				       &dummy,
+				       &dummy,
+				       &dummy,
+				       &dummy,
+				       &dummy,
+				       &dummy);
+
+	if (retcode == H_NOT_ENOUGH_RESOURCES) {
+		EDEB_ERR(4, "Not enough resources. retcode=%lx", retcode);
+	}
+
+	EDEB_EX(7, "retcode=%lx", retcode);
+
+	return retcode;
+}
+
+u64 hipz_h_detach_mcqp(const struct ipz_adapter_handle adapter_handle,
+		       const struct ipz_qp_handle qp_handle,
+		       struct h_galpa gal,
+		       u16 mcg_dlid,
+		       u64 subnet_prefix, u64 interface_id)
+{
+	u64 retcode = 0;
+	u64 dummy;
+	u8 *dgid_sp = (u8*)&subnet_prefix;
+	u8 *dgid_ii = (u8*)&interface_id;
+
+	EDEB_EN(7, "qp_handle=%lx adapter_handle=%lx\nMCG_DGID ="
+		" %d.%d.%d.%d.%d.%d.%d.%d."
+		" %d.%d.%d.%d.%d.%d.%d.%d\n",
+		qp_handle.handle, adapter_handle.handle,
+		dgid_sp[0], dgid_sp[1],
+		dgid_sp[2], dgid_sp[3],
+		dgid_sp[4], dgid_sp[5],
+		dgid_sp[6], dgid_sp[7],
+		dgid_ii[0], dgid_ii[1],
+		dgid_ii[2], dgid_ii[3],
+		dgid_ii[4], dgid_ii[5],
+		dgid_ii[6], dgid_ii[7]);
+	retcode = ehca_hcall_7arg_7ret(H_DETACH_MCQP,
+				       adapter_handle.handle,     /* r4 */
+				       qp_handle.handle,	  /* r5 */
+				       mcg_dlid,	          /* r6 */
+				       interface_id,              /* r7 */
+				       subnet_prefix,             /* r8 */
+				       0, 0,
+				       &dummy,
+				       &dummy,
+				       &dummy,
+				       &dummy,
+				       &dummy,
+				       &dummy,
+				       &dummy);
+
+	EDEB(7, "retcode=%lx", retcode);
+
+	return retcode;
+}
+
+u64 hipz_h_destroy_cq(const struct ipz_adapter_handle adapter_handle,
+		      struct ehca_cq *cq,
+		      u8 force_flag)
+{
+	u64 retcode = 0;
+	u64 dummy;
+
+	EDEB_EN(7, "cq->pf=%p cq=.%p ipz_cq_handle=%lx adapter_handle=%lx",
+		&cq->pf, cq, cq->ipz_cq_handle.handle, adapter_handle.handle);
+
+#ifndef EHCA_USE_HCALL
+	simp_h_destroy_cq(adapter_handle, cq,
+			  cq->galpas.kernel);
+#else
+	retcode = hcp_galpas_dtor(&cq->galpas);
+	if (retcode != 0) {
+		EDEB_ERR(4, "Could not destruct cp->galpas");
+		return (H_RESOURCE);
+	}
+
+	retcode = ehca_hcall_7arg_7ret(H_FREE_RESOURCE,
+				       adapter_handle.handle,     /* r4 */
+				       cq->ipz_cq_handle.handle,  /* r5 */
+				       force_flag!=0 ? 1L : 0L,   /* r6 */
+				       0, 0, 0, 0,
+				       &dummy,
+				       &dummy,
+				       &dummy,
+				       &dummy,
+				       &dummy,
+				       &dummy,
+				       &dummy);
+#endif
+
+	if (retcode == H_RESOURCE) {
+		EDEB(4, "retcode=%lx ", retcode);
+	}
+
+	EDEB_EX(7, "retcode=%lx", retcode);
+
+	return retcode;
+}
+
+u64 hipz_h_destroy_eq(const struct ipz_adapter_handle adapter_handle,
+		      struct ehca_eq *eq)
+{
+	u64 retcode = 0;
+	u64 dummy;
+
+	EDEB_EN(7, "eq->pf=%p eq=%p ipz_eq_handle=%lx adapter_handle=%lx",
+		&eq->pf, eq, eq->ipz_eq_handle.handle,
+		adapter_handle.handle);
+
+	retcode = hcp_galpas_dtor(&eq->galpas);
+	if (retcode != 0) {
+		EDEB_ERR(4, "Could not destruct ep->galpas");
+		return (H_RESOURCE);
+	}
+
+	retcode = ehca_hcall_7arg_7ret(H_FREE_RESOURCE,
+				       adapter_handle.handle,     /* r4 */
+				       eq->ipz_eq_handle.handle,  /* r5 */
+				       0, 0, 0, 0, 0,
+				       &dummy,
+				       &dummy,
+				       &dummy,
+				       &dummy,
+				       &dummy,
+				       &dummy,
+				       &dummy);
+
+
+	if (retcode == H_RESOURCE) {
+		EDEB_ERR(4, "Resource in use. retcode=%lx ", retcode);
+	}
+	EDEB_EX(7, "retcode=%lx", retcode);
+
+	return retcode;
+}
+
+u64 hipz_h_alloc_resource_mr(const struct ipz_adapter_handle adapter_handle,
+			     struct ehca_pfmr *pfmr,
+			     struct ehca_pfshca *pfshca,
+			     const u64 vaddr,
+			     const u64 length,
+			     const u32 access_ctrl,
+			     const struct ipz_pd pd,
+			     struct ipz_mrmw_handle *mr_handle,
+			     u32 * lkey,
+			     u32 * rkey)
+{
+	u64 rc = H_SUCCESS;
+	u64 dummy;
+	u64 lkey_out;
+	u64 rkey_out;
+
+	EDEB_EN(7, "adapter_handle=%lx pfmr=%p vaddr=%lx length=%lx"
+		" access_ctrl=%x pd=%x pfshca=%p",
+		adapter_handle.handle, pfmr, vaddr, length, access_ctrl,
+		pd.value, pfshca);
+
+#ifndef EHCA_USE_HCALL
+	rc = simp_hcz_h_alloc_resource_mr(adapter_handle,
+					  pfmr,
+					  pfshca,
+					  vaddr,
+					  length,
+					  access_ctrl,
+					  pd,
+					  (struct hcz_mrmw_handle *)mr_handle,
+					  lkey, rkey);
+	EDEB_EX(7, "rc=%lx mr_handle.mrwpte=%p mr_handle.page_index=%x"
+		" lkey=%x rkey=%x",
+		rc, mr_handle->mrwpte, mr_handle->page_index, *lkey, *rkey);
+#else
+
+	rc = ehca_hcall_7arg_7ret(H_ALLOC_RESOURCE,
+				  adapter_handle.handle,            /* r4 */
+				  5,                                /* r5 */
+				  vaddr,                            /* r6 */
+				  length,                           /* r7 */
+				  ((((u64) access_ctrl) << 32ULL)), /* r8 */
+				  pd.value,                         /* r9 */
+				  0,
+				  &mr_handle->handle,               /* r4 */
+				  &dummy,                           /* r5 */
+				  &lkey_out,                        /* r6 */
+				  &rkey_out,                        /* r7 */
+				  &dummy,
+				  &dummy,
+				  &dummy);
+	*lkey = (u32) lkey_out;
+	*rkey = (u32) rkey_out;
+
+	EDEB_EX(7, "rc=%lx mr_handle=%lx lkey=%x rkey=%x",
+		rc, mr_handle->handle, *lkey, *rkey);
+#endif /* EHCA_USE_HCALL */
+
+	return rc;
+}
+
+u64 hipz_h_register_rpage_mr(const struct ipz_adapter_handle adapter_handle,
+			     const struct ipz_mrmw_handle *mr_handle,
+			     struct ehca_pfmr *pfmr,
+			     struct ehca_pfshca *pfshca,
+			     const u8 pagesize,
+			     const u8 queue_type,
+			     const u64 logical_address_of_page,
+			     const u64 count)
+{
+	u64 rc = H_SUCCESS;
+
+#ifndef EHCA_USE_HCALL
+	EDEB_EN(7, "adapter_handle=%lx pfmr=%p mr_handle.mrwpte=%p"
+		" mr_handle.page_index=%x pagesize=%x queue_type=%x "
+		" logical_address_of_page=%lx count=%lx pfshca=%p",
+		adapter_handle.handle, pfmr, mr_handle->mrwpte,
+		mr_handle->page_index, pagesize, queue_type,
+		logical_address_of_page, count, pfshca);
+
+	rc = simp_hcz_h_register_rpage_mr(adapter_handle,
+					  (struct hcz_mrmw_handle *)mr_handle,
+					  pfmr,
+					  pfshca,
+					  pagesize,
+					  queue_type,
+					  logical_address_of_page, count);
+#else
+	EDEB_EN(7, "adapter_handle=%lx pfmr=%p mr_handle=%lx pagesize=%x"
+		" queue_type=%x logical_address_of_page=%lx count=%lx",
+		adapter_handle.handle, pfmr, mr_handle->handle, pagesize,
+		queue_type, logical_address_of_page, count);
+
+	if ((count > 1) && (logical_address_of_page & 0xfff)) {
+		EDEB_ERR(4, "logical_address_of_page not on a 4k boundary "
+			 "adapter_handle=%lx pfmr=%p mr_handle=%lx "
+			 "pagesize=%x queue_type=%x logical_address_of_page=%lx"
+			 " count=%lx",
+			 adapter_handle.handle, pfmr, mr_handle->handle,
+			 pagesize, queue_type, logical_address_of_page, count);
+		rc = H_PARAMETER;
+	} else {
+		rc = hipz_h_register_rpage(adapter_handle, pagesize,
+					   queue_type, mr_handle->handle,
+					   logical_address_of_page, count);
+	}
+#endif /* EHCA_USE_HCALL */
+	EDEB_EX(7, "rc=%lx", rc);
+
+	return rc;
+}
+
+u64 hipz_h_query_mr(const struct ipz_adapter_handle adapter_handle,
+		    struct ehca_pfmr *pfmr,
+		    const struct ipz_mrmw_handle *mr_handle,
+		    u64 * mr_local_length,
+		    u64 * mr_local_vaddr,
+		    u64 * mr_remote_length,
+		    u64 * mr_remote_vaddr,
+		    u32 * access_ctrl,
+		    struct ipz_pd *pd,
+		    u32 * lkey,
+		    u32 * rkey)
+{
+	u64 rc = H_SUCCESS;
+	u64 dummy;
+	u64 acc_ctrl_pd_out;
+	u64 r9_out;
+
+#ifndef EHCA_USE_HCALL
+	EDEB_EN(7, "adapter_handle=%lx pfmr=%p mr_handle.mrwpte=%p"
+		" mr_handle.page_index=%x",
+		adapter_handle.handle, pfmr, mr_handle->mrwpte,
+		mr_handle->page_index);
+
+	rc = simp_hcz_h_query_mr(adapter_handle,
+				 pfmr,
+				 mr_handle,
+				 mr_local_length,
+				 mr_local_vaddr,
+				 mr_remote_length,
+				 mr_remote_vaddr, access_ctrl, pd, lkey, rkey);
+
+	EDEB_EX(7, "rc=%lx mr_local_length=%lx mr_local_vaddr=%lx"
+		" mr_remote_length=%lx mr_remote_vaddr=%lx access_ctrl=%x"
+		" pd=%x lkey=%x rkey=%x",
+		rc, *mr_local_length, *mr_local_vaddr, *mr_remote_length,
+		*mr_remote_vaddr, *access_ctrl, pd->value, *lkey, *rkey);
+#else
+	EDEB_EN(7, "adapter_handle=%lx pfmr=%p mr_handle=%lx",
+		adapter_handle.handle, pfmr, mr_handle->handle);
+
+
+	rc = ehca_hcall_7arg_7ret(H_QUERY_MR,
+				  adapter_handle.handle, /* r4 */
+				  mr_handle->handle,     /* r5 */
+				  0, 0, 0, 0, 0,
+				  mr_local_length,       /* r4 */
+				  mr_local_vaddr,        /* r5 */
+				  mr_remote_length,      /* r6 */
+				  mr_remote_vaddr,       /* r7 */
+				  &acc_ctrl_pd_out,      /* r8 */
+				  &r9_out,
+				  &dummy);
+
+	*access_ctrl = acc_ctrl_pd_out >> 32;
+	pd->value = (u32) acc_ctrl_pd_out;
+	*lkey = (u32) (r9_out >> 32);
+	*rkey = (u32) (r9_out & (0xffffffff));
+
+	EDEB_EX(7, "rc=%lx mr_local_length=%lx mr_local_vaddr=%lx"
+		" mr_remote_length=%lx mr_remote_vaddr=%lx access_ctrl=%x"
+		" pd=%x lkey=%x rkey=%x",
+		rc, *mr_local_length, *mr_local_vaddr, *mr_remote_length,
+		*mr_remote_vaddr, *access_ctrl, pd->value, *lkey, *rkey);
+#endif /* EHCA_USE_HCALL */
+
+	return rc;
+}
+
+u64 hipz_h_free_resource_mr(const struct ipz_adapter_handle adapter_handle,
+			    struct ehca_pfmr *pfmr,
+			    const struct ipz_mrmw_handle *mr_handle)
+{
+	u64 rc = H_SUCCESS;
+	u64 dummy;
+
+#ifndef EHCA_USE_HCALL
+	EDEB_EN(7, "adapter_handle=%lx pfmr=%p mr_handle.mrwpte=%p"
+		" mr_handle.page_index=%x",
+		adapter_handle.handle, pfmr, mr_handle->mrwpte,
+		mr_handle->page_index);
+
+	rc = simp_hcz_h_free_resource_mr(adapter_handle, pfmr, mr_handle);
+#else
+	EDEB_EN(7, "adapter_handle=%lx pfmr=%p mr_handle=%lx",
+		adapter_handle.handle, pfmr, mr_handle->handle);
+
+	rc = ehca_hcall_7arg_7ret(H_FREE_RESOURCE,
+				  adapter_handle.handle, /* r4 */
+				  mr_handle->handle,     /* r5 */
+				  0, 0, 0, 0, 0,
+				  &dummy,
+				  &dummy,
+				  &dummy,
+				  &dummy,
+				  &dummy,
+				  &dummy,
+				  &dummy);
+#endif /* EHCA_USE_HCALL */
+	EDEB_EX(7, "rc=%lx", rc);
+
+	return rc;
+}
+
+u64 hipz_h_reregister_pmr(const struct ipz_adapter_handle adapter_handle,
+			  struct ehca_pfmr *pfmr,
+			  struct ehca_pfshca *pfshca,
+			  const struct ipz_mrmw_handle *mr_handle,
+			  const u64 vaddr_in,
+			  const u64 length,
+			  const u32 access_ctrl,
+			  const struct ipz_pd pd,
+			  const u64 mr_addr_cb,
+			  u64 * vaddr_out,
+			  u32 * lkey,
+			  u32 * rkey)
+{
+	u64 rc = H_SUCCESS;
+	u64 dummy;
+	u64 lkey_out;
+	u64 rkey_out;
+
+#ifndef EHCA_USE_HCALL
+	EDEB_EN(7, "adapter_handle=%lx pfmr=%p pfshca=%p"
+		" mr_handle.mrwpte=%p mr_handle.page_index=%x vaddr_in=%lx"
+		" length=%lx access_ctrl=%x pd=%x mr_addr_cb=",
+		adapter_handle.handle, pfmr, pfshca, mr_handle->mrwpte,
+		mr_handle->page_index, vaddr_in, length, access_ctrl,
+		pd.value, mr_addr_cb);
+
+	rc = simp_hcz_h_reregister_pmr(adapter_handle, pfmr, pfshca,
+				       mr_handle, vaddr_in, length, access_ctrl,
+				       pd, mr_addr_cb, vaddr_out, lkey, rkey);
+#else
+	EDEB_EN(7, "adapter_handle=%lx pfmr=%p pfshca=%p mr_handle=%lx "
+		"vaddr_in=%lx length=%lx access_ctrl=%x pd=%x mr_addr_cb=%lx",
+		adapter_handle.handle, pfmr, pfshca, mr_handle->handle,
+		vaddr_in, length, access_ctrl, pd.value, mr_addr_cb);
+
+	rc = ehca_hcall_7arg_7ret(H_REREGISTER_PMR,
+				  adapter_handle.handle, /* r4 */
+				  mr_handle->handle,	  /* r5 */
+				  vaddr_in,	          /* r6 */
+				  length,                /* r7 */
+				  /* r8 */
+				  ((((u64) access_ctrl) << 32ULL) | pd.value),
+				  mr_addr_cb,            /* r9 */
+				  0,
+				  &dummy,                /* r4 */
+				  vaddr_out,             /* r5 */
+				  &lkey_out,             /* r6 */
+				  &rkey_out,             /* r7 */
+				  &dummy,
+				  &dummy,
+				  &dummy);
+
+	*lkey = (u32) lkey_out;
+	*rkey = (u32) rkey_out;
+#endif /* EHCA_USE_HCALL */
+
+	EDEB_EX(7, "rc=%lx vaddr_out=%lx lkey=%x rkey=%x",
+		rc, *vaddr_out, *lkey, *rkey);
+	return rc;
+}
+
+u64 hipz_h_register_smr(const struct ipz_adapter_handle adapter_handle,
+			struct ehca_pfmr *pfmr,
+			struct ehca_pfmr *orig_pfmr,
+			struct ehca_pfshca *pfshca,
+			const struct ipz_mrmw_handle *orig_mr_handle,
+			const u64 vaddr_in,
+			const u32 access_ctrl,
+			const struct ipz_pd pd,
+			struct ipz_mrmw_handle *mr_handle,
+			u32 * lkey,
+			u32 * rkey)
+{
+	u64 rc = H_SUCCESS;
+	u64 dummy;
+	u64 lkey_out;
+	u64 rkey_out;
+
+#ifndef EHCA_USE_HCALL
+	EDEB_EN(7, "adapter_handle=%lx pfmr=%p orig_pfmr=%p pfshca=%p"
+		" orig_mr_handle.mrwpte=%p orig_mr_handle.page_index=%x"
+		" vaddr_in=%lx access_ctrl=%x pd=%x",
+		adapter_handle.handle, pfmr, orig_pfmr, pfshca,
+		orig_mr_handle->mrwpte, orig_mr_handle->page_index,
+		vaddr_in, access_ctrl, pd.value);
+
+	rc = simp_hcz_h_register_smr(adapter_handle, pfmr, orig_pfmr,
+				     pfshca, orig_mr_handle, vaddr_in,
+				     access_ctrl, pd,
+				     (struct hcz_mrmw_handle *)mr_handle, lkey,
+				     rkey);
+	EDEB_EX(7, "rc=%lx mr_handle.mrwpte=%p mr_handle.page_index=%x"
+		" lkey=%x rkey=%x",
+		rc, mr_handle->mrwpte, mr_handle->page_index, *lkey, *rkey);
+#else
+	EDEB_EN(7, "adapter_handle=%lx orig_pfmr=%p pfshca=%p"
+		" orig_mr_handle=%lx vaddr_in=%lx access_ctrl=%x pd=%x",
+		adapter_handle.handle, orig_pfmr, pfshca,
+		orig_mr_handle->handle, vaddr_in, access_ctrl, pd.value);
+
+
+	rc = ehca_hcall_7arg_7ret(H_REGISTER_SMR,
+				  adapter_handle.handle,            /* r4 */
+				  orig_mr_handle->handle,           /* r5 */
+				  vaddr_in,                         /* r6 */
+				  ((((u64) access_ctrl) << 32ULL)), /* r7 */
+				  pd.value,                         /* r8 */
+				  0, 0,
+				  &mr_handle->handle,               /* r4 */
+				  &dummy,                           /* r5 */
+				  &lkey_out,                        /* r6 */
+				  &rkey_out,                        /* r7 */
+				  &dummy,
+				  &dummy,
+				  &dummy);
+	*lkey = (u32) lkey_out;
+	*rkey = (u32) rkey_out;
+
+	EDEB_EX(7, "rc=%lx mr_handle=%lx lkey=%x rkey=%x",
+		rc, mr_handle->handle, *lkey, *rkey);
+#endif /* EHCA_USE_HCALL */
+
+	return rc;
+}
+
+u64 hipz_h_alloc_resource_mw(const struct ipz_adapter_handle adapter_handle,
+			     struct ehca_pfmw *pfmw,
+			     struct ehca_pfshca *pfshca,
+			     const struct ipz_pd pd,
+			     struct ipz_mrmw_handle *mw_handle,
+			     u32 * rkey)
+{
+	u64 rc = H_SUCCESS;
+	u64 dummy;
+	u64 rkey_out;
+
+	EDEB_EN(7, "adapter_handle=%lx pfmw=%p pd=%x pfshca=%p",
+		    adapter_handle.handle, pfmw, pd.value, pfshca);
+
+#ifndef EHCA_USE_HCALL
+
+	rc = simp_hcz_h_alloc_resource_mw(adapter_handle, pfmw, pfshca, pd,
+					  (struct hcz_mrmw_handle *)mw_handle,
+					  rkey);
+	EDEB_EX(7, "rc=%lx mw_handle.mrwpte=%p mw_handle.page_index=%x rkey=%x",
+		rc, mw_handle->mrwpte, mw_handle->page_index, *rkey);
+#else
+	rc = ehca_hcall_7arg_7ret(H_ALLOC_RESOURCE,
+				  adapter_handle.handle, /* r4 */
+				  6,                     /* r5 */
+				  pd.value,              /* r6 */
+				  0, 0, 0, 0,
+				  &mw_handle->handle,    /* r4 */
+				  &dummy,                /* r5 */
+				  &dummy,                /* r6 */
+				  &rkey_out,             /* r7 */
+				  &dummy,
+				  &dummy,
+				  &dummy);
+
+	*rkey = (u32) rkey_out;
+
+	EDEB_EX(7, "rc=%lx mw_handle=%lx rkey=%x",
+		rc, mw_handle->handle, *rkey);
+#endif /* EHCA_USE_HCALL */
+	return rc;
+}
+
+u64 hipz_h_query_mw(const struct ipz_adapter_handle adapter_handle,
+		    struct ehca_pfmw *pfmw,
+		    const struct ipz_mrmw_handle *mw_handle,
+		    u32 * rkey,
+		    struct ipz_pd *pd)
+{
+	u64 rc = H_SUCCESS;
+	u64 dummy;
+	u64 pd_out;
+	u64 rkey_out;
+
+#ifndef EHCA_USE_HCALL
+	EDEB_EN(7, "adapter_handle=%lx pfmw=%p mw_handle.mrwpte=%p"
+		" mw_handle.page_index=%x",
+		adapter_handle.handle, pfmw, mw_handle->mrwpte,
+		mw_handle->page_index);
+
+	rc = simp_hcz_h_query_mw(adapter_handle, pfmw, mw_handle, rkey, pd);
+
+	EDEB_EX(7, "rc=%lx rkey=%x pd=%x", rc, *rkey, pd->value);
+#else
+	EDEB_EN(7, "adapter_handle=%lx pfmw=%p mw_handle=%lx",
+		adapter_handle.handle, pfmw, mw_handle->handle);
+
+	rc = ehca_hcall_7arg_7ret(H_QUERY_MW,
+				  adapter_handle.handle, /* r4 */
+				  mw_handle->handle,     /* r5 */
+				  0, 0, 0, 0, 0,
+				  &dummy,                /* r4 */
+				  &dummy,                /* r5 */
+				  &dummy,                /* r6 */
+				  &rkey_out,             /* r7 */
+				  &pd_out,               /* r8 */
+				  &dummy,
+				  &dummy);
+	*rkey = (u32) rkey_out;
+	pd->value = (u32) pd_out;
+
+	EDEB_EX(7, "rc=%lx rkey=%x pd=%x", rc, *rkey, pd->value);
+#endif /* EHCA_USE_HCALL */
+
+	return rc;
+}
+
+u64 hipz_h_free_resource_mw(const struct ipz_adapter_handle adapter_handle,
+			    struct ehca_pfmw *pfmw,
+			    const struct ipz_mrmw_handle *mw_handle)
+{
+	u64 rc = H_SUCCESS;
+	u64 dummy;
+
+#ifndef EHCA_USE_HCALL
+	EDEB_EN(7, "adapter_handle=%lx pfmw=%p mw_handle.mrwpte=%p"
+		" mw_handle.page_index=%x",
+		adapter_handle.handle, pfmw, mw_handle->mrwpte,
+		mw_handle->page_index);
+
+	rc = simp_hcz_h_free_resource_mw(adapter_handle, pfmw, mw_handle);
+#else
+	EDEB_EN(7, "adapter_handle=%lx pfmw=%p mw_handle=%lx",
+		adapter_handle.handle, pfmw, mw_handle->handle);
+
+	rc = ehca_hcall_7arg_7ret(H_FREE_RESOURCE,
+				  adapter_handle.handle, /* r4 */
+				  mw_handle->handle,     /* r5 */
+				  0, 0, 0, 0, 0,
+				  &dummy,
+				  &dummy,
+				  &dummy,
+				  &dummy,
+				  &dummy,
+				  &dummy,
+				  &dummy);
+#endif /* EHCA_USE_HCALL */
+	EDEB_EX(7, "rc=%lx", rc);
+
+	return rc;
+}
+
+u64 hipz_h_error_data(const struct ipz_adapter_handle adapter_handle,
+		      const u64 ressource_handle,
+		      void *rblock,
+		      unsigned long *byte_count)
+{
+	u64 rc = H_SUCCESS;
+	u64 dummy;
+	u64 r_cb;
+
+	EDEB_EN(7, "adapter_handle=%lx ressource_handle=%lx  rblock=%p",
+		adapter_handle.handle, ressource_handle, rblock);
+
+	if ((((u64)rblock) & 0xfff) != 0) {
+		EDEB_ERR(4, "rblock not page aligned.");
+		rc = H_PARAMETER;
+		return rc;
+	}
+
+	r_cb = virt_to_abs(rblock);
+
+	rc = ehca_hcall_7arg_7ret(H_ERROR_DATA,
+				  adapter_handle.handle,
+				  ressource_handle,
+				  r_cb,
+				  0, 0, 0, 0,
+				  &dummy,
+				  &dummy,
+				  &dummy,
+				  &dummy,
+				  &dummy,
+				  &dummy,
+				  &dummy);
+
+	EDEB_EX(7, "rc=%lx", rc);
+
+	return rc;
+}



