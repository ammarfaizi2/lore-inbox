Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751823AbWBRA5g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751823AbWBRA5g (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 19:57:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751810AbWBRA5Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 19:57:16 -0500
Received: from sj-iport-2-in.cisco.com ([171.71.176.71]:35626 "EHLO
	sj-iport-2.cisco.com") by vger.kernel.org with ESMTP
	id S1751501AbWBRA5M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 19:57:12 -0500
From: Roland Dreier <rolandd@cisco.com>
Subject: [PATCH 02/22] Firmware interface code for IB device.
Date: Fri, 17 Feb 2006 16:57:07 -0800
To: linux-kernel@vger.kernel.org, linuxppc64-dev@ozlabs.org,
       openib-general@openib.org
Cc: SCHICKHJ@de.ibm.com, RAISCH@de.ibm.com, HNGUYEN@de.ibm.com,
       MEDER@de.ibm.com
Message-Id: <20060218005707.13620.20538.stgit@localhost.localdomain>
In-Reply-To: <20060218005532.13620.79663.stgit@localhost.localdomain>
References: <20060218005532.13620.79663.stgit@localhost.localdomain>
X-OriginalArrivalTime: 18 Feb 2006 00:57:07.0281 (UTC) FILETIME=[3D8ED410:01C63426]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Roland Dreier <rolandd@cisco.com>

This is a very large file with way too much code for a .h file.
The functions look too big to be inlined also.  Is there any way
for this code to move to a .c file?
---

 drivers/infiniband/hw/ehca/hcp_if.h | 2022 +++++++++++++++++++++++++++++++++++
 1 files changed, 2022 insertions(+), 0 deletions(-)

diff --git a/drivers/infiniband/hw/ehca/hcp_if.h b/drivers/infiniband/hw/ehca/hcp_if.h
new file mode 100644
index 0000000..70bf77f
--- /dev/null
+++ b/drivers/infiniband/hw/ehca/hcp_if.h
@@ -0,0 +1,2022 @@
+/*
+ *  IBM eServer eHCA Infiniband device driver for Linux on POWER
+ *
+ *  Firmware Infiniband Interface code for POWER
+ *
+ *  Authors: Gerd Bayer <gerd.bayer@de.ibm.com>
+ *           Christoph Raisch <raisch@de.ibm.com>
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
+ *  $Id: hcp_if.h,v 1.62 2006/02/06 10:17:34 schickhj Exp $
+ */
+
+#ifndef __HCP_IF_H__
+#define __HCP_IF_H__
+
+#include "ehca_tools.h"
+#include "hipz_structs.h"
+#include "ehca_classes.h"
+
+#ifndef EHCA_USE_HCALL
+#include "hcz_queue.h"
+#include "hcz_mrmw.h"
+#include "hcz_emmio.h"
+#include "sim_prom.h"
+#endif
+#include "hipz_fns.h"
+#include "hcp_sense.h"
+#include "ehca_irq.h"
+
+#ifndef CONFIG_PPC64
+#ifndef Z_SERIES
+#warning "included with wrong target, this is a p file"
+#endif
+#endif
+
+#ifdef EHCA_USE_HCALL
+
+#ifndef EHCA_USERDRIVER
+#include "hcp_phyp.h"
+#else
+#include "testbench/hcallbridge.h"
+#endif
+#endif
+
+inline static int hcp_galpas_ctor(struct h_galpas *galpas,
+				  u64 paddr_kernel, u64 paddr_user)
+{
+	int rc = 0;
+
+	rc = hcall_map_page(paddr_kernel, &galpas->kernel.fw_handle);
+	if (rc != 0)
+		return (rc);
+
+	galpas->user.fw_handle = paddr_user;
+
+	EDEB(7, "paddr_kernel=%lx paddr_user=%lx galpas->kernel=%lx"
+	     " galpas->user=%lx",
+	     paddr_kernel, paddr_user, galpas->kernel.fw_handle,
+	     galpas->user.fw_handle);
+
+	return (rc);
+}
+
+inline static int hcp_galpas_dtor(struct h_galpas *galpas)
+{
+	int rc = 0;
+
+	if (galpas->kernel.fw_handle != 0)
+		rc = hcall_unmap_page(galpas->kernel.fw_handle);
+
+	if (rc != 0)
+		return (rc);
+
+	galpas->user.fw_handle = galpas->kernel.fw_handle = 0;
+
+	return rc;
+}
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
+inline static u64 hipz_h_alloc_resource_eq(const struct
+						      ipz_adapter_handle
+						      hcp_adapter_handle,
+						      struct ehca_pfeq *pfeq,
+						      const u32 neq_control,
+						      const u32
+						      number_of_entries,
+						      struct ipz_eq_handle
+						      *eq_handle,
+						      u32 * act_nr_of_entries,
+						      u32 * act_pages,
+						      u32 * eq_ist)
+{
+	u64 retcode;
+	u64 dummy;
+	u64 act_nr_of_entries_out = 0;
+	u64 act_pages_out         = 0;
+	u64 eq_ist_out            = 0;
+	u64 allocate_controls     = 0;
+	u32 x = (u64)(&x);
+
+	EDEB_EN(7, "pfeq=%p hcp_adapter_handle=%lx  new_control=%x"
+		   " number_of_entries=%x",
+		   pfeq, hcp_adapter_handle.handle, neq_control,
+		   number_of_entries);
+
+#ifndef EHCA_USE_HCALL
+	retcode = simp_h_alloc_resource_eq(hcp_adapter_handle, pfeq,
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
+	retcode = plpar_hcall_7arg_7ret(H_ALLOC_RESOURCE,
+					hcp_adapter_handle.handle, /* r4 */
+					allocate_controls,	   /* r5 */
+					number_of_entries,	   /* r6 */
+					0, 0, 0, 0,
+					&eq_handle->handle,	   /* r4 */
+					&dummy,	                   /* r5 */
+					&dummy,	                   /* r6 */
+					&act_nr_of_entries_out,	   /* r7 */
+					&act_pages_out,	           /* r8 */
+					&eq_ist_out,               /* r8 */
+					&dummy);
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
+static inline u64 hipz_h_reset_event(const struct ipz_adapter_handle
+						hcp_adapter_handle,
+						struct ipz_eq_handle eq_handle,
+						const u64 event_mask)
+{
+	u64 retcode = 0;
+	u64 dummy;
+
+	EDEB_EN(7, "eq_handle=%lx, adapter_handle=%lx  event_mask=%lx",
+		   eq_handle.handle, hcp_adapter_handle.handle, event_mask);
+
+#ifndef EHCA_USE_HCALL
+	/* TODO: Not implemented yet */
+#else
+
+	retcode = plpar_hcall_7arg_7ret(H_RESET_EVENTS,
+					hcp_adapter_handle.handle, /* r4 */
+					eq_handle.handle,	   /* r5 */
+					event_mask,	           /* r6 */
+					0, 0, 0, 0,
+					&dummy,
+					&dummy,
+					&dummy,
+					&dummy,
+					&dummy,
+					&dummy,
+					&dummy);
+#endif
+	EDEB(7, "retcode=%lx", retcode);
+
+	return retcode;
+}
+
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
+static inline u64 hipz_h_alloc_resource_cq(const struct
+						      ipz_adapter_handle
+						      hcp_adapter_handle,
+						      struct ehca_pfcq *pfcq,
+						      const struct ipz_eq_handle
+						      eq_handle,
+						      const u32 cq_token,
+						      const u32
+						      number_of_entries,
+						      struct ipz_cq_handle
+						      *cq_handle,
+						      u32 * act_nr_of_entries,
+						      u32 * act_pages,
+						      struct h_galpas *galpas)
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
+	EDEB_EN(7, "pfcq=%p hcp_adapter_handle=%lx eq_handle=%lx cq_token=%x"
+		" number_of_entries=%x",
+		pfcq, hcp_adapter_handle.handle, eq_handle.handle,
+		cq_token, number_of_entries);
+
+#ifndef EHCA_USE_HCALL
+	retcode = simp_h_alloc_resource_cq(hcp_adapter_handle,
+					   pfcq,
+					   eq_handle,
+					   cq_token,
+					   number_of_entries,
+					   cq_handle,
+					   act_nr_of_entries,
+					   act_pages, galpas);
+#else
+	retcode = plpar_hcall_7arg_7ret(H_ALLOC_RESOURCE,
+					hcp_adapter_handle.handle, /* r4  */
+					2,	                   /* r5  */
+					eq_handle.handle,	   /* r6  */
+					cq_token,	           /* r7  */
+					number_of_entries,	   /* r8  */
+					0, 0,
+					&cq_handle->handle,	   /* r4  */
+					&dummy,	                   /* r5  */
+					&dummy,	                   /* r6  */
+					&act_nr_of_entries_out,	   /* r7  */
+					&act_pages_out,	           /* r8  */
+					&g_la_privileged_out,	   /* r9  */
+					&g_la_user_out);	   /* r10 */
+
+	*act_nr_of_entries = (u32) act_nr_of_entries_out;
+	*act_pages = (u32) act_pages_out;
+
+	if (retcode == 0) {
+		hcp_galpas_ctor(galpas, g_la_privileged_out, g_la_user_out);
+	}
+#endif /* EHCA_US_HCALL */
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
+#define H_ALL_RES_QP_Enhanced_QP_Operations EHCA_BMASK_IBM(9,11)
+#define H_ALL_RES_QP_QP_PTE_Pin EHCA_BMASK_IBM(12,12)
+#define H_ALL_RES_QP_Service_Type EHCA_BMASK_IBM(13,15)
+#define H_ALL_RES_QP_LL_RQ_CQE_Posting EHCA_BMASK_IBM(18,18)
+#define H_ALL_RES_QP_LL_SQ_CQE_Posting EHCA_BMASK_IBM(19,21)
+#define H_ALL_RES_QP_Signalling_Type EHCA_BMASK_IBM(22,23)
+#define H_ALL_RES_QP_UD_Address_Vector_L_Key_Control EHCA_BMASK_IBM(31,31)
+#define H_ALL_RES_QP_Resource_Type EHCA_BMASK_IBM(56,63)
+
+#define H_ALL_RES_QP_Max_Outstanding_Send_Work_Requests EHCA_BMASK_IBM(0,15)
+#define H_ALL_RES_QP_Max_Outstanding_Receive_Work_Requests EHCA_BMASK_IBM(16,31)
+#define H_ALL_RES_QP_Max_Send_SG_Elements EHCA_BMASK_IBM(32,39)
+#define H_ALL_RES_QP_Max_Receive_SG_Elements EHCA_BMASK_IBM(40,47)
+
+#define H_ALL_RES_QP_Act_Outstanding_Send_Work_Requests EHCA_BMASK_IBM(16,31)
+#define H_ALL_RES_QP_Act_Outstanding_Receive_Work_Requests EHCA_BMASK_IBM(48,63)
+#define H_ALL_RES_QP_Act_Send_SG_Elements EHCA_BMASK_IBM(8,15)
+#define H_ALL_RES_QP_Act_Receeive_SG_Elements EHCA_BMASK_IBM(24,31)
+
+#define H_ALL_RES_QP_Send_Queue_Size_pages EHCA_BMASK_IBM(0,31)
+#define H_ALL_RES_QP_Receive_Queue_Size_pages EHCA_BMASK_IBM(32,63)
+
+/* direct access qp controls */
+#define DAQP_CTRL_ENABLE 0x01
+#define DAQP_CTRL_SEND_COMPLETION 0x20
+#define DAQP_CTRL_RECV_COMPLETION 0x40
+
+/**
+ * hipz_h_alloc_resource_qp - Allocate QP resources in HW and FW,
+ * initialize resources, create empty QPPTs (2 rings).
+ *
+ * @h_galpas to access HCA resident QP attributes
+ */
+static inline u64 hipz_h_alloc_resource_qp(const struct
+						      ipz_adapter_handle
+						      adapter_handle,
+						      struct ehca_pfqp *pfqp,
+						      const u8 servicetype,
+						      const u8 daqp_ctrl,
+						      const u8 signalingtype,
+						      const u8 ud_av_l_key_ctl,
+						      const struct ipz_cq_handle send_cq_handle,
+						      const struct ipz_cq_handle receive_cq_handle,
+						      const struct ipz_eq_handle async_eq_handle,
+						      const u32 qp_token,
+						      const struct ipz_pd pd,
+						      const u16 max_nr_send_wqes,
+						      const u16 max_nr_receive_wqes,
+						      const u8 max_nr_send_sges,
+						      const u8 max_nr_receive_sges,
+						      const u32 ud_av_l_key,
+						      struct ipz_qp_handle *qp_handle,
+						      u32 * qp_nr,
+						      u16 * act_nr_send_wqes,
+						      u16 * act_nr_receive_wqes,
+						      u8 * act_nr_send_sges,
+						      u8 * act_nr_receive_sges,
+						      u32 * nr_sq_pages,
+						      u32 * nr_rq_pages,
+						      struct h_galpas *h_galpas)
+{
+	u64 retcode = H_Success;
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
+		EHCA_BMASK_SET(H_ALL_RES_QP_Enhanced_QP_Operations,
+			       (daqp_ctrl & DAQP_CTRL_ENABLE) ? 1 : 0)
+		| EHCA_BMASK_SET(H_ALL_RES_QP_QP_PTE_Pin, 0)
+		| EHCA_BMASK_SET(H_ALL_RES_QP_Service_Type, servicetype)
+		| EHCA_BMASK_SET(H_ALL_RES_QP_Signalling_Type, signalingtype)
+		| EHCA_BMASK_SET(H_ALL_RES_QP_LL_RQ_CQE_Posting,
+				 (daqp_ctrl & DAQP_CTRL_RECV_COMPLETION) ? 1 : 0)
+		| EHCA_BMASK_SET(H_ALL_RES_QP_LL_SQ_CQE_Posting,
+				 (daqp_ctrl & DAQP_CTRL_SEND_COMPLETION) ? 1 : 0)
+		| EHCA_BMASK_SET(H_ALL_RES_QP_UD_Address_Vector_L_Key_Control,
+				 ud_av_l_key_ctl)
+		| EHCA_BMASK_SET(H_ALL_RES_QP_Resource_Type, 1);
+
+	max_r10_reg =
+		EHCA_BMASK_SET(H_ALL_RES_QP_Max_Outstanding_Send_Work_Requests,
+			       max_nr_send_wqes)
+		| EHCA_BMASK_SET(H_ALL_RES_QP_Max_Outstanding_Receive_Work_Requests,
+				 max_nr_receive_wqes)
+		| EHCA_BMASK_SET(H_ALL_RES_QP_Max_Send_SG_Elements,
+				 max_nr_send_sges)
+		| EHCA_BMASK_SET(H_ALL_RES_QP_Max_Receive_SG_Elements,
+				 max_nr_receive_sges);
+
+
+	retcode = plpar_hcall_9arg_9ret(H_ALLOC_RESOURCE,
+					adapter_handle.handle,	 /* r4  */
+					allocate_controls,	 /* r5  */
+					send_cq_handle.handle,	 /* r6  */
+					receive_cq_handle.handle,/* r7  */
+					async_eq_handle.handle,	 /* r8  */
+					((u64) qp_token << 32)
+					| pd.value,              /* r9  */
+					max_r10_reg,	         /* r10 */
+					ud_av_l_key,	         /* r11 */
+					0,
+					&qp_handle->handle,	 /* r4  */
+					&qp_nr_out,	         /* r5  */
+					&r6_out,	         /* r6  */
+					&r7_out,	         /* r7  */
+					&r8_out,	         /* r8  */
+					&dummy,	                 /* r9  */
+					&g_la_user_out,	         /* r10 */
+					&r11_out,
+					&dummy);
+
+	/* extract outputs */
+	*qp_nr = (u32) qp_nr_out;
+	*act_nr_send_wqes = (u16)
+		EHCA_BMASK_GET(H_ALL_RES_QP_Act_Outstanding_Send_Work_Requests,
+			       r6_out);
+	*act_nr_receive_wqes = (u16)
+		EHCA_BMASK_GET(H_ALL_RES_QP_Act_Outstanding_Receive_Work_Requests,
+			       r6_out);
+	*act_nr_send_sges =
+		(u8) EHCA_BMASK_GET(H_ALL_RES_QP_Act_Send_SG_Elements,
+				    r7_out);
+	*act_nr_receive_sges =
+		(u8) EHCA_BMASK_GET(H_ALL_RES_QP_Act_Receeive_SG_Elements,
+				    r7_out);
+	*nr_sq_pages =
+		(u32) EHCA_BMASK_GET(H_ALL_RES_QP_Send_Queue_Size_pages,
+				     r8_out);
+	*nr_rq_pages =
+		(u32) EHCA_BMASK_GET(H_ALL_RES_QP_Receive_Queue_Size_pages,
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
+static inline u64 hipz_h_query_port(const struct ipz_adapter_handle
+					       hcp_adapter_handle,
+					       const u8 port_id,
+					       struct query_port_rblock
+					       *query_port_response_block)
+{
+	u64 retcode = H_Success;
+	u64 dummy;
+	u64 r_cb;
+
+	EDEB_EN(7, "hcp_adapter_handle=%lx port_id %x",
+		hcp_adapter_handle.handle, port_id);
+
+	if ((((u64)query_port_response_block) & 0xfff) != 0) {
+		EDEB_ERR(4, "response block not page aligned");
+		retcode = H_Parameter;
+		return (retcode);
+	}
+
+#ifndef EHCA_USE_HCALL
+	retcode = 0;
+#else
+	r_cb = ehca_kv_to_g(query_port_response_block);
+
+	retcode = plpar_hcall_7arg_7ret(H_QUERY_PORT,
+					hcp_adapter_handle.handle, /* r4 */
+					port_id,	           /* r5 */
+					r_cb,	                   /* r6 */
+					0, 0, 0, 0,
+					&dummy,
+					&dummy,
+					&dummy,
+					&dummy,
+					&dummy,
+					&dummy,
+					&dummy);
+#endif /* EHCA_USE_HCALL */
+
+	EDEB(7, "offset0=%x offset1=%x offset2=%x offset3=%x",
+	     ((u32 *) query_port_response_block)[0],
+	     ((u32 *) query_port_response_block)[1],
+	     ((u32 *) query_port_response_block)[2],
+	     ((u32 *) query_port_response_block)[3]);
+	EDEB(7, "offset4=%x offset5=%x offset6=%x offset7=%x",
+	     ((u32 *) query_port_response_block)[4],
+	     ((u32 *) query_port_response_block)[5],
+	     ((u32 *) query_port_response_block)[6],
+	     ((u32 *) query_port_response_block)[7]);
+	EDEB(7, "offset8=%x offset9=%x offseta=%x offsetb=%x",
+	     ((u32 *) query_port_response_block)[8],
+	     ((u32 *) query_port_response_block)[9],
+	     ((u32 *) query_port_response_block)[10],
+	     ((u32 *) query_port_response_block)[11]);
+	EDEB(7, "offsetc=%x offsetd=%x offsete=%x offsetf=%x",
+	     ((u32 *) query_port_response_block)[12],
+	     ((u32 *) query_port_response_block)[13],
+	     ((u32 *) query_port_response_block)[14],
+	     ((u32 *) query_port_response_block)[15]);
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
+static inline u64 hipz_h_query_hca(const struct ipz_adapter_handle
+					      hcp_adapter_handle,
+					      struct query_hca_rblock
+					      *query_hca_rblock)
+{
+	u64 retcode = 0;
+	u64 dummy;
+	u64 r_cb;
+	EDEB_EN(7, "hcp_adapter_handle=%lx", hcp_adapter_handle.handle);
+
+	if ((((u64)query_hca_rblock) & 0xfff) != 0) {
+		EDEB_ERR(4, "response block not page aligned");
+		retcode = H_Parameter;
+		return (retcode);
+	}
+
+#ifndef EHCA_USE_HCALL
+	retcode = 0;
+#else
+	r_cb = ehca_kv_to_g(query_hca_rblock);
+
+	retcode = plpar_hcall_7arg_7ret(H_QUERY_HCA,
+					hcp_adapter_handle.handle, /* r4 */
+					r_cb,                      /* r5 */
+					0, 0, 0, 0, 0,
+					&dummy,
+					&dummy,
+					&dummy,
+					&dummy,
+					&dummy,
+					&dummy,
+					&dummy);
+#endif /* EHCA_USE_HCALL */
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
+	EDEB_EX(7, "retcode=%lx hcp_adapter_handle=%lx",
+		retcode, hcp_adapter_handle.handle);
+
+	return retcode;
+}
+
+/**
+ * hipz_h_register_rpage - hcp_if.h internal function for all
+ * hcp_H_REGISTER_RPAGE calls.
+ *
+ * @logical_address_of_page: kv transformation to GX address in this routine
+ */
+static inline u64 hipz_h_register_rpage(const struct
+						   ipz_adapter_handle
+						   hcp_adapter_handle,
+						   const u8 pagesize,
+						   const u8 queue_type,
+						   const u64 resource_handle,
+						   const u64
+						   logical_address_of_page,
+						   u64 count)
+{
+	u64 retcode = 0;
+	u64 dummy;
+
+	EDEB_EN(7, "hcp_adapter_handle=%lx pagesize=%x queue_type=%x"
+		" resource_handle=%lx logical_address_of_page=%lx count=%lx",
+		hcp_adapter_handle.handle, pagesize, queue_type,
+		resource_handle, logical_address_of_page, count);
+
+#ifndef EHCA_USE_HCALL
+	EDEB_ERR(4, "Not implemented");
+#else
+	retcode = plpar_hcall_7arg_7ret(H_REGISTER_RPAGES,
+					hcp_adapter_handle.handle,  /* r4  */
+					queue_type | pagesize << 8, /* r5  */
+					resource_handle,	    /* r6  */
+					logical_address_of_page,    /* r7  */
+					count,	                    /* r8  */
+					0, 0,
+					&dummy,
+					&dummy,
+					&dummy,
+					&dummy,
+					&dummy,
+					&dummy,
+					&dummy);
+#endif /* EHCA_USE_HCALL */
+
+	EDEB_EX(7, "retcode=%lx", retcode);
+
+	return retcode;
+}
+
+static inline u64 hipz_h_register_rpage_eq(const struct
+						      ipz_adapter_handle
+						      hcp_adapter_handle,
+						      const struct ipz_eq_handle
+						      eq_handle,
+						      struct ehca_pfeq *pfeq,
+						      const u8 pagesize,
+						      const u8 queue_type,
+						      const u64
+						      logical_address_of_page,
+						      const u64 count)
+{
+	u64 retcode = 0;
+
+	EDEB_EN(7, "pfeq=%p hcp_adapter_handle=%lx eq_handle=%lx pagesize=%x"
+		" queue_type=%x  logical_address_of_page=%lx count=%lx",
+		pfeq, hcp_adapter_handle.handle, eq_handle.handle, pagesize,
+		queue_type,logical_address_of_page, count);
+
+#ifndef EHCA_USE_HCALL
+	retcode =
+		simp_h_register_rpage_eq(hcp_adapter_handle, eq_handle, pfeq,
+					 pagesize, queue_type,
+					 logical_address_of_page, count);
+#else
+	if (count != 1) {
+		EDEB_ERR(4, "Ppage counter=%lx", count);
+		return (H_Parameter);
+	}
+	retcode = hipz_h_register_rpage(hcp_adapter_handle,
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
+static inline u32 hipz_request_interrupt(struct ehca_irq_info *irq_info,
+					 irqreturn_t(*handler)
+					 (int, void *, struct pt_regs *))
+{
+
+	int ret = 0;
+
+	EDEB_EN(7, "ist=0x%x", irq_info->ist);
+
+#ifdef EHCA_USE_HCALL
+#ifndef EHCA_USERDRIVER
+	ret = ibmebus_request_irq(NULL, irq_info->ist, handler,
+				  SA_INTERRUPT, "ehca", (void *)irq_info);
+
+	if (ret < 0)
+		EDEB_ERR(4, "Can't map interrupt handler.");
+#else
+	struct hcall_irq_info hirq = {.irq = irq_info->irq,
+				      .ist = irq_info->ist,
+				      .pid = irq_info->pid};
+
+	hirq = hirq;
+	ret = hcall_reg_eqh(&hirq, ehca_interrupt_eq);
+#endif /* EHCA_USERDRIVER */
+#endif /* EHCA_USE_HCALL  */
+
+	EDEB_EX(7, "ret=%x", ret);
+
+	return ret;
+}
+
+static inline void hipz_free_interrupt(struct ehca_irq_info *irq_info)
+{
+#ifdef EHCA_USE_HCALL
+#ifndef EHCA_USERDRIVER
+	ibmebus_free_irq(NULL, irq_info->ist, (void *)irq_info);
+#endif
+#endif
+}
+
+static inline u32 hipz_h_query_int_state(const struct ipz_adapter_handle
+					 hcp_adapter_handle,
+					 struct ehca_irq_info *irq_info)
+{
+	u32 rc = 0;
+	u64 dummy = 0;
+
+	EDEB_EN(7, "ist=0x%x", irq_info->ist);
+
+#ifdef EHCA_USE_HCALL
+#ifdef EHCA_USERDRIVER
+	/* TODO: Not implemented yet */
+#else
+	rc = plpar_hcall_7arg_7ret(H_QUERY_INT_STATE,
+				   hcp_adapter_handle.handle, /* r4 */
+				   irq_info->ist,             /* r5 */
+				   0, 0, 0, 0, 0,
+				   &dummy,
+				   &dummy,
+				   &dummy,
+				   &dummy,
+				   &dummy,
+				   &dummy,
+				   &dummy);
+
+	if ((rc != H_Success) && (rc != H_Busy))
+		EDEB_ERR(4, "Could not query interrupt state.");
+#endif
+#endif
+	EDEB_EX(7, "interrupt state: %x", rc);
+
+	return rc;
+}
+
+static inline u64 hipz_h_register_rpage_cq(const struct
+						      ipz_adapter_handle
+						      hcp_adapter_handle,
+						      const struct ipz_cq_handle
+						      cq_handle,
+						      struct ehca_pfcq *pfcq,
+						      const u8 pagesize,
+						      const u8 queue_type,
+						      const u64
+						      logical_address_of_page,
+						      const u64 count,
+						      const struct h_galpa gal)
+{
+	u64 retcode = 0;
+
+	EDEB_EN(7, "pfcq=%p hcp_adapter_handle=%lx cq_handle=%lx pagesize=%x"
+		" queue_type=%x  logical_address_of_page=%lx count=%lx",
+		pfcq, hcp_adapter_handle.handle, cq_handle.handle, pagesize,
+		queue_type, logical_address_of_page, count);
+
+#ifndef EHCA_USE_HCALL
+	retcode =
+		simp_h_register_rpage_cq(hcp_adapter_handle, cq_handle, pfcq,
+					 pagesize, queue_type,
+					 logical_address_of_page, count, gal);
+#else
+	if (count != 1) {
+		EDEB_ERR(4, "Page counter=%lx", count);
+		return (H_Parameter);
+	}
+
+	retcode =
+		hipz_h_register_rpage(hcp_adapter_handle, pagesize, queue_type,
+				      cq_handle.handle, logical_address_of_page,
+				      count);
+#endif /* EHCA_USE_HCALL */
+	EDEB_EX(7, "retcode=%lx", retcode);
+
+	return retcode;
+}
+
+static inline u64 hipz_h_register_rpage_qp(const struct
+						      ipz_adapter_handle
+						      hcp_adapter_handle,
+						      const struct ipz_qp_handle
+						      qp_handle,
+						      struct ehca_pfqp *pfqp,
+						      const u8 pagesize,
+						      const u8 queue_type,
+						      const u64
+						      logical_address_of_page,
+						      const u64 count,
+						      const struct h_galpa
+						      galpa)
+{
+	u64 retcode = 0;
+
+	EDEB_EN(7, "pfqp=%p hcp_adapter_handle=%lx qp_handle=%lx pagesize=%x"
+		" queue_type=%x  logical_address_of_page=%lx count=%lx",
+		pfqp, hcp_adapter_handle.handle, qp_handle.handle, pagesize,
+		queue_type, logical_address_of_page, count);
+
+#ifndef EHCA_USE_HCALL
+	retcode = simp_h_register_rpage_qp(hcp_adapter_handle,
+					   qp_handle,
+					   pfqp,
+					   pagesize,
+					   queue_type,
+					   logical_address_of_page,
+					   count, galpa);
+#else
+	if (count != 1) {
+		EDEB_ERR(4, "Page counter=%lx", count);
+		return (H_Parameter);
+	}
+
+	retcode = hipz_h_register_rpage(hcp_adapter_handle,
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
+static inline u64 hipz_h_remove_rpt_cq(const struct
+						  ipz_adapter_handle
+						  hcp_adapter_handle,
+						  const struct ipz_cq_handle
+						  cq_handle,
+						  struct ehca_pfcq *pfcq)
+{
+	u64 retcode = 0;
+
+	EDEB_EN(7, "pfcq=%p hcp_adapter_handle=%lx  cq_handle=%lx",
+		pfcq, hcp_adapter_handle.handle, cq_handle.handle);
+
+#ifndef EHCA_USE_HCALL
+	retcode = simp_h_remove_rpt_cq(hcp_adapter_handle, cq_handle, pfcq);
+#else
+	/* TODO: hcall not implemented */
+#endif
+	EDEB_EX(7, "retcode=%lx", retcode);
+
+	return 0;
+}
+
+static inline u64 hipz_h_remove_rpt_eq(const struct
+						  ipz_adapter_handle
+						  hcp_adapter_handle,
+						  const struct ipz_eq_handle
+						  eq_handle,
+						  struct ehca_pfeq *pfeq)
+{
+	u64 retcode = 0;
+
+	EDEB_EX(7, "hcp_adapter_handle=%lx eq_handle=%lx",
+		hcp_adapter_handle.handle, eq_handle.handle);
+
+#ifndef EHCA_USE_HCALL
+	retcode = simp_h_remove_rpt_eq(hcp_adapter_handle, eq_handle, pfeq);
+#else
+	/* TODO: hcall not implemented */
+#endif
+	EDEB_EX(7, "retcode=%lx", retcode);
+
+	return 0;
+}
+
+static inline u64 hipz_h_remove_rpt_qp(const struct
+						  ipz_adapter_handle
+						  hcp_adapter_handle,
+						  const struct ipz_qp_handle
+						  qp_handle,
+						  struct ehca_pfqp *pfqp)
+{
+	u64 retcode = 0;
+
+	EDEB_EN(7, "pfqp=%p hcp_adapter_handle=%lx qp_handle=%lx",
+		pfqp, hcp_adapter_handle.handle, qp_handle.handle);
+
+#ifndef EHCA_USE_HCALL
+	retcode = simp_h_remove_rpt_qp(hcp_adapter_handle, qp_handle, pfqp);
+#else
+	/* TODO: hcall not implemented */
+#endif
+	EDEB_EX(7, "retcode=%lx", retcode);
+
+	return 0;
+}
+
+static inline u64 hipz_h_disable_and_get_wqe(const struct
+							ipz_adapter_handle
+							hcp_adapter_handle,
+							const struct
+							ipz_qp_handle qp_handle,
+							struct ehca_pfqp *pfqp,
+							void **log_addr_next_sq_wqe_tb_processed,
+							void **log_addr_next_rq_wqe_tb_processed,
+							int dis_and_get_function_code)
+{
+	u64 retcode = 0;
+	u8 function_code = 1;
+	u64 dummy, dummy1, dummy2;
+
+	EDEB_EN(7, "pfqp=%p hcp_adapter_handle=%lx function=%x qp_handle=%lx",
+		pfqp, hcp_adapter_handle.handle, function_code, qp_handle.handle);
+
+	if (log_addr_next_sq_wqe_tb_processed==NULL) {
+		log_addr_next_sq_wqe_tb_processed = (void**)&dummy1;
+	}
+	if (log_addr_next_rq_wqe_tb_processed==NULL) {
+		log_addr_next_rq_wqe_tb_processed = (void**)&dummy2;
+	}
+#ifndef EHCA_USE_HCALL
+	retcode =
+		simp_h_disable_and_get_wqe(hcp_adapter_handle, qp_handle, pfqp,
+					   log_addr_next_sq_wqe_tb_processed,
+					   log_addr_next_rq_wqe_tb_processed);
+#else
+
+	retcode = plpar_hcall_7arg_7ret(H_DISABLE_AND_GETC,
+					hcp_adapter_handle.handle, /* r4 */
+					dis_and_get_function_code, /* r5 */
+				        /* function code 1-disQP ret
+					 * SQ RQ wqe ptr
+					 * 2- ret SQ wqe ptr
+					 * 3- ret. RQ count */
+					qp_handle.handle,	   /* r6 */
+					0, 0, 0, 0,
+					(void*)log_addr_next_sq_wqe_tb_processed, /* r4 */
+					(void*)log_addr_next_rq_wqe_tb_processed, /* r5 */
+					&dummy,
+					&dummy,
+					&dummy,
+					&dummy,
+					&dummy);
+#endif /* EHCA_USE_HCALL */
+	EDEB_EX(7, "retcode=%lx  ladr_next_rq_wqe_out=%p"
+		" ladr_next_sq_wqe_out=%p", retcode,
+		*log_addr_next_sq_wqe_tb_processed,
+		*log_addr_next_rq_wqe_tb_processed);
+
+	return retcode;
+}
+
+enum hcall_sigt {
+	HCALL_SIGT_NO_CQE = 0,
+	HCALL_SIGT_BY_WQE = 1,
+	HCALL_SIGT_EVERY = 2
+};
+
+static inline u64 hipz_h_modify_qp(const struct ipz_adapter_handle
+					      hcp_adapter_handle,
+					      const struct ipz_qp_handle
+					      qp_handle, struct ehca_pfqp *pfqp,
+					      const u64 update_mask,
+					      struct hcp_modify_qp_control_block
+					      *mqpcb,
+					      struct h_galpa gal)
+{
+	u64 retcode = 0;
+	u64 invalid_attribute_identifier = 0;
+	u64 rc_attrib_mask = 0;
+	u64 dummy;
+	u64 r_cb;
+	EDEB_EN(7, "pfqp=%p hcp_adapter_handle=%lx qp_handle=%lx"
+		   " update_mask=%lx qp_state=%x mqpcb=%p",
+		   pfqp, hcp_adapter_handle.handle, qp_handle.handle,
+		   update_mask, mqpcb->qp_state, mqpcb);
+
+#ifndef EHCA_USE_HCALL
+	simp_h_modify_qp(hcp_adapter_handle, qp_handle, pfqp, update_mask,
+			 mqpcb, gal);
+#else
+	r_cb = ehca_kv_to_g(mqpcb);
+	retcode = plpar_hcall_7arg_7ret(H_MODIFY_QP,
+					hcp_adapter_handle.handle,     /* r4 */
+					qp_handle.handle,	       /* r5 */
+					update_mask,	               /* r6 */
+					r_cb,	                       /* r7 */
+					0, 0, 0,
+					&invalid_attribute_identifier, /* r4 */
+					&dummy,	                       /* r5 */
+					&dummy,	                       /* r6 */
+					&dummy,                        /* r7 */
+					&dummy,	                       /* r8 */
+					&rc_attrib_mask,               /* r9 */
+					&dummy);
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
+static inline u64 hipz_h_query_qp(const struct ipz_adapter_handle
+					     hcp_adapter_handle,
+					     const struct ipz_qp_handle
+					     qp_handle, struct ehca_pfqp *pfqp,
+					     struct hcp_modify_qp_control_block
+					     *qqpcb, struct h_galpa gal)
+{
+	u64 retcode = 0;
+	u64 dummy;
+	u64 r_cb;
+	EDEB_EN(7, "hcp_adapter_handle=%lx qp_handle=%lx",
+		hcp_adapter_handle.handle, qp_handle.handle);
+
+#ifndef EHCA_USE_HCALL
+	simp_h_query_qp(hcp_adapter_handle, qp_handle, qqpcb, gal);
+#else
+	r_cb = ehca_kv_to_g(qqpcb);
+	EDEB(7, "r_cb=%lx", r_cb);
+
+	retcode = plpar_hcall_7arg_7ret(H_QUERY_QP,
+					hcp_adapter_handle.handle, /* r4 */
+					qp_handle.handle,          /* r5 */
+					r_cb,	                   /* r6 */
+					0, 0, 0, 0,
+					&dummy,
+					&dummy,
+					&dummy,
+					&dummy,
+					&dummy,
+					&dummy,
+					&dummy);
+
+#endif
+	EDEB_EX(7, "retcode=%lx", retcode);
+
+	return retcode;
+}
+
+static inline u64 hipz_h_destroy_qp(const struct ipz_adapter_handle
+					       hcp_adapter_handle,
+					       struct ehca_qp *qp)
+{
+	u64 retcode = 0;
+	u64 dummy;
+	u64 ladr_next_sq_wqe_out;
+	u64 ladr_next_rq_wqe_out;
+
+	EDEB_EN(7, "qp = %p ,ipz_qp_handle=%lx adapter_handle=%lx",
+		qp, qp->ipz_qp_handle.handle, hcp_adapter_handle.handle);
+
+#ifndef EHCA_USE_HCALL
+	retcode =
+		simp_h_destroy_qp(hcp_adapter_handle, qp,
+				  qp->ehca_qp_core.galpas.user);
+#else
+
+	retcode = hcp_galpas_dtor(&qp->ehca_qp_core.galpas);
+
+	retcode = plpar_hcall_7arg_7ret(H_DISABLE_AND_GETC,
+					hcp_adapter_handle.handle, /* r4 */
+					/* function code */
+					1,	                   /* r5 */
+					qp->ipz_qp_handle.handle,  /* r6 */
+					0, 0, 0, 0,
+					&ladr_next_sq_wqe_out,     /* r4 */
+					&ladr_next_rq_wqe_out,     /* r5 */
+					&dummy,
+					&dummy,
+					&dummy,
+					&dummy,
+					&dummy);
+	if (retcode == H_Hardware) {
+		EDEB_ERR(4, "HCA not operational. retcode=%lx", retcode);
+	}
+
+	retcode = plpar_hcall_7arg_7ret(H_FREE_RESOURCE,
+					hcp_adapter_handle.handle, /* r4 */
+					qp->ipz_qp_handle.handle,  /* r5 */
+					0, 0, 0, 0, 0,
+					&dummy,
+					&dummy,
+					&dummy,
+					&dummy,
+					&dummy,
+					&dummy,
+					&dummy);
+#endif /* EHCA_USE_HCALL */
+
+	if (retcode == H_Resource) {
+		EDEB_ERR(4, "Resource still in use. retcode=%lx", retcode);
+	}
+	EDEB_EX(7, "retcode=%lx", retcode);
+
+	return retcode;
+}
+
+static inline u64 hipz_h_define_aqp0(const struct ipz_adapter_handle
+						hcp_adapter_handle,
+						const struct ipz_qp_handle
+						qp_handle, struct h_galpa gal,
+						u32 port)
+{
+	u64 retcode = 0;
+	u64 dummy;
+
+	EDEB_EN(7, "port=%x ipz_qp_handle=%lx adapter_handle=%lx",
+		port, qp_handle.handle, hcp_adapter_handle.handle);
+
+#ifndef EHCA_USE_HCALL
+	/* TODO: not implemented yet */
+#else
+
+	retcode = plpar_hcall_7arg_7ret(H_DEFINE_AQP0,
+					hcp_adapter_handle.handle, /* r4 */
+					qp_handle.handle,	   /* r5 */
+					port,                      /* r6 */
+					0, 0, 0, 0,
+					&dummy,
+					&dummy,
+					&dummy,
+					&dummy,
+					&dummy,
+					&dummy,
+					&dummy);
+
+#endif /* EHCA_USE_HCALL */
+	EDEB_EX(7, "retcode=%lx", retcode);
+
+	return retcode;
+}
+
+static inline u64 hipz_h_define_aqp1(const struct ipz_adapter_handle
+						hcp_adapter_handle,
+						const struct ipz_qp_handle
+						qp_handle, struct h_galpa gal,
+						u32 port, u32 * pma_qp_nr,
+						u32 * bma_qp_nr)
+{
+	u64 retcode = 0;
+	u64 dummy;
+	u64 pma_qp_nr_out;
+	u64 bma_qp_nr_out;
+
+	EDEB_EN(7, "port=%x qp_handle=%lx adapter_handle=%lx",
+		port, qp_handle.handle, hcp_adapter_handle.handle);
+
+#ifndef EHCA_USE_HCALL
+	/* TODO: not implemented yet */
+#else
+
+	retcode = plpar_hcall_7arg_7ret(H_DEFINE_AQP1,
+					hcp_adapter_handle.handle, /* r4 */
+					qp_handle.handle,	   /* r5 */
+					port,	                   /* r6 */
+					0, 0, 0, 0,
+					&pma_qp_nr_out,            /* r4 */
+					&bma_qp_nr_out,            /* r5 */
+					&dummy,
+					&dummy,
+					&dummy,
+					&dummy,
+					&dummy);
+	*pma_qp_nr = (u32) pma_qp_nr_out;
+	*bma_qp_nr = (u32) bma_qp_nr_out;
+
+#endif
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
+/* TODO: Don't use ib_* types in this file */
+static inline u64 hipz_h_attach_mcqp(const struct ipz_adapter_handle
+						hcp_adapter_handle,
+						const struct ipz_qp_handle
+						qp_handle, struct h_galpa gal,
+						u16 mcg_dlid, union ib_gid dgid)
+{
+	u64 retcode = 0;
+	u64 dummy;
+
+	EDEB_EN(7, "qp_handle=%lx adapter_handle=%lx\nMCG_DGID ="
+		" %d.%d.%d.%d.%d.%d.%d.%d."
+		" %d.%d.%d.%d.%d.%d.%d.%d\n",
+		qp_handle.handle, hcp_adapter_handle.handle,
+		dgid.raw[0], dgid.raw[1],
+		dgid.raw[2], dgid.raw[3],
+		dgid.raw[4], dgid.raw[5],
+		dgid.raw[6], dgid.raw[7],
+		dgid.raw[0 + 8], dgid.raw[1 + 8],
+		dgid.raw[2 + 8], dgid.raw[3 + 8],
+		dgid.raw[4 + 8], dgid.raw[5 + 8],
+		dgid.raw[6 + 8], dgid.raw[7 + 8]);
+
+#ifndef EHCA_USE_HCALL
+	/* TODO: not implemented yet */
+#else
+	retcode = plpar_hcall_7arg_7ret(H_ATTACH_MCQP,
+					hcp_adapter_handle.handle, /* r4 */
+					qp_handle.handle,          /* r5 */
+					mcg_dlid,                  /* r6 */
+					dgid.global.interface_id,  /* r7 */
+					dgid.global.subnet_prefix, /* r8 */
+					0, 0,
+					&dummy,
+					&dummy,
+					&dummy,
+					&dummy,
+					&dummy,
+					&dummy,
+					&dummy);
+#endif /* EHCA_USE_HCALL */
+	if (retcode == H_NOT_ENOUGH_RESOURCES) {
+		EDEB_ERR(4, "Not enough resources. retcode=%lx", retcode);
+	}
+
+	EDEB_EX(7, "retcode=%lx", retcode);
+
+	return retcode;
+}
+
+static inline u64 hipz_h_detach_mcqp(const struct ipz_adapter_handle
+						hcp_adapter_handle,
+						const struct ipz_qp_handle
+						qp_handle, struct h_galpa gal,
+						u16 mcg_dlid, union ib_gid dgid)
+{
+	u64 retcode = 0;
+	u64 dummy;
+
+	EDEB_EN(7, "qp_handle=%lx adapter_handle=%lx\nMCG_DGID ="
+		" %d.%d.%d.%d.%d.%d.%d.%d."
+		" %d.%d.%d.%d.%d.%d.%d.%d\n",
+		qp_handle.handle, hcp_adapter_handle.handle,
+		dgid.raw[0], dgid.raw[1],
+		dgid.raw[2], dgid.raw[3],
+		dgid.raw[4], dgid.raw[5],
+		dgid.raw[6], dgid.raw[7],
+		dgid.raw[0 + 8], dgid.raw[1 + 8],
+		dgid.raw[2 + 8], dgid.raw[3 + 8],
+		dgid.raw[4 + 8], dgid.raw[5 + 8],
+		dgid.raw[6 + 8], dgid.raw[7 + 8]);
+#ifndef EHCA_USE_HCALL
+	/* TODO: not implemented yet */
+#else
+	retcode = plpar_hcall_7arg_7ret(H_DETACH_MCQP,
+					hcp_adapter_handle.handle, /* r4 */
+					qp_handle.handle,	   /* r5 */
+					mcg_dlid,	           /* r6 */
+					dgid.global.interface_id,  /* r7 */
+					dgid.global.subnet_prefix, /* r8 */
+					0, 0,
+					&dummy,
+					&dummy,
+					&dummy,
+					&dummy,
+					&dummy,
+					&dummy,
+					&dummy);
+#endif /* EHCA_USE_HCALL */
+	EDEB(7, "retcode=%lx", retcode);
+
+	return retcode;
+}
+
+static inline u64 hipz_h_destroy_cq(const struct ipz_adapter_handle
+					       hcp_adapter_handle,
+					       struct ehca_cq *cq,
+					       u8 force_flag)
+{
+	u64 retcode = 0;
+	u64 dummy;
+
+	EDEB_EN(7, "cq->pf=%p cq=.%p ipz_cq_handle=%lx adapter_handle=%lx",
+		&cq->pf, cq, cq->ipz_cq_handle.handle, hcp_adapter_handle.handle);
+
+#ifndef EHCA_USE_HCALL
+	simp_h_destroy_cq(hcp_adapter_handle, cq,
+			  cq->ehca_cq_core.galpas.kernel);
+#else
+	retcode = hcp_galpas_dtor(&cq->ehca_cq_core.galpas);
+	if (retcode != 0) {
+		EDEB_ERR(4, "Could not destruct cp->galpas");
+		return (H_Resource);
+	}
+
+	retcode = plpar_hcall_7arg_7ret(H_FREE_RESOURCE,
+					hcp_adapter_handle.handle, /* r4 */
+					cq->ipz_cq_handle.handle,  /* r5 */
+					force_flag!=0 ? 1L : 0L,   /* r6 */
+					0, 0, 0, 0,
+					&dummy,
+					&dummy,
+					&dummy,
+					&dummy,
+					&dummy,
+					&dummy,
+					&dummy);
+#endif
+
+	if (retcode == H_Resource) {
+		EDEB(4, "retcode=%lx ", retcode);
+	}
+
+	EDEB_EX(7, "retcode=%lx", retcode);
+
+	return retcode;
+}
+
+static inline u64 hipz_h_destroy_eq(const struct ipz_adapter_handle
+					       hcp_adapter_handle,
+					       struct ehca_eq *eq)
+{
+	u64 retcode = 0;
+	u64 dummy;
+
+	EDEB_EN(7, "eq->pf=%p eq=%p ipz_eq_handle=%lx adapter_handle=%lx",
+		&eq->pf, eq, eq->ipz_eq_handle.handle,
+		hcp_adapter_handle.handle);
+
+#ifndef EHCA_USE_HCALL
+	/* TODO: not implemeted et */
+#else
+
+	retcode = hcp_galpas_dtor(&eq->galpas);
+	if (retcode != 0) {
+		EDEB_ERR(4, "Could not destruct ep->galpas");
+		return (H_Resource);
+	}
+
+	retcode = plpar_hcall_7arg_7ret(H_FREE_RESOURCE,
+					hcp_adapter_handle.handle, /* r4 */
+					eq->ipz_eq_handle.handle,  /* r5 */
+					0, 0, 0, 0, 0,
+					&dummy,
+					&dummy,
+					&dummy,
+					&dummy,
+					&dummy,
+					&dummy,
+					&dummy);
+
+#endif
+	if (retcode == H_Resource) {
+		EDEB_ERR(4, "Resource in use. retcode=%lx ", retcode);
+	}
+	EDEB_EX(7, "retcode=%lx", retcode);
+
+	return retcode;
+}
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
+static inline u64 hipz_h_alloc_resource_mr(const struct ipz_adapter_handle
+						      hcp_adapter_handle,
+						      struct ehca_pfmr *pfmr,
+						      struct ehca_pfshca
+						      *pfshca,
+						      const u64 vaddr,
+						      const u64 length,
+						      const u32 access_ctrl,
+						      const struct ipz_pd pd,
+						      struct ipz_mrmw_handle
+						      *mr_handle,
+						      u32 * lkey,
+						      u32 * rkey)
+{
+	u64 rc = H_Success;
+	u64 dummy;
+	u64 lkey_out;
+	u64 rkey_out;
+
+	EDEB_EN(7, "hcp_adapter_handle=%lx pfmr=%p vaddr=%lx length=%lx"
+		" access_ctrl=%x pd=%x pfshca=%p",
+		hcp_adapter_handle.handle, pfmr, vaddr, length, access_ctrl,
+		pd.value, pfshca);
+
+#ifndef EHCA_USE_HCALL
+	rc = simp_hcz_h_alloc_resource_mr(hcp_adapter_handle,
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
+	rc = plpar_hcall_7arg_7ret(H_ALLOC_RESOURCE,
+				   hcp_adapter_handle.handle,        /* r4 */
+				   5,                                /* r5 */
+				   vaddr,                            /* r6 */
+				   length,                           /* r7 */
+				   ((((u64) access_ctrl) << 32ULL)), /* r8 */
+				   pd.value,                         /* r9 */
+				   0,
+				   &mr_handle->handle,               /* r4 */
+				   &dummy,                           /* r5 */
+				   &lkey_out,                        /* r6 */
+				   &rkey_out,                        /* r7 */
+				   &dummy,
+				   &dummy,
+				   &dummy);
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
+/**
+ * hipz_h_register_rpage_mr - Register MR resource page in HW and FW .
+ *
+ * @pfmr:       platform specific for MR
+ * @pfshca:     platform specific for SHCA
+ * @queue_type: must be zero for MR
+ */
+static inline u64 hipz_h_register_rpage_mr(const struct ipz_adapter_handle
+						      hcp_adapter_handle,
+						      const struct ipz_mrmw_handle
+						      *mr_handle,
+						      struct ehca_pfmr *pfmr,
+						      struct ehca_pfshca *pfshca,
+						      const u8 pagesize,
+						      const u8 queue_type,
+						      const u64
+						      logical_address_of_page,
+						      const u64 count)
+{
+	u64 rc = H_Success;
+
+#ifndef EHCA_USE_HCALL
+	EDEB_EN(7, "hcp_adapter_handle=%lx pfmr=%p mr_handle.mrwpte=%p"
+		" mr_handle.page_index=%x pagesize=%x queue_type=%x "
+		" logical_address_of_page=%lx count=%lx pfshca=%p",
+		hcp_adapter_handle.handle, pfmr, mr_handle->mrwpte,
+		mr_handle->page_index, pagesize, queue_type,
+		logical_address_of_page, count, pfshca);
+
+	rc = simp_hcz_h_register_rpage_mr(hcp_adapter_handle,
+					  (struct hcz_mrmw_handle *)mr_handle,
+					  pfmr,
+					  pfshca,
+					  pagesize,
+					  queue_type,
+					  logical_address_of_page, count);
+#else
+	EDEB_EN(7, "hcp_adapter_handle=%lx pfmr=%p mr_handle=%lx pagesize=%x"
+		" queue_type=%x logical_address_of_page=%lx count=%lx",
+		hcp_adapter_handle.handle, pfmr, mr_handle->handle, pagesize,
+		queue_type, logical_address_of_page, count);
+
+	if ((count > 1) && (logical_address_of_page & 0xfff)) {
+		ehca_catastrophic("ERROR: logical_address_of_page "
+				  "not on a 4k boundary");
+		rc = H_Parameter;
+	} else {
+		rc = hipz_h_register_rpage(hcp_adapter_handle, pagesize,
+					   queue_type, mr_handle->handle,
+					   logical_address_of_page, count);
+	}
+#endif /* EHCA_USE_HCALL */
+	EDEB_EX(7, "rc=%lx", rc);
+
+	return rc;
+}
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
+static inline u64 hipz_h_query_mr(const struct ipz_adapter_handle
+					     hcp_adapter_handle,
+					     struct ehca_pfmr *pfmr,
+					     const struct ipz_mrmw_handle
+					     *mr_handle,
+					     u64 * mr_local_length,
+					     u64 * mr_local_vaddr,
+					     u64 * mr_remote_length,
+					     u64 * mr_remote_vaddr,
+					     u32 * access_ctrl,
+					     struct ipz_pd *pd,
+					     u32 * lkey,
+					     u32 * rkey)
+{
+	u64 rc = H_Success;
+	u64 dummy;
+	u64 acc_ctrl_pd_out;
+	u64 r9_out;
+
+#ifndef EHCA_USE_HCALL
+	EDEB_EN(7, "hcp_adapter_handle=%lx pfmr=%p mr_handle.mrwpte=%p"
+		" mr_handle.page_index=%x",
+		hcp_adapter_handle.handle, pfmr, mr_handle->mrwpte,
+		mr_handle->page_index);
+
+	rc = simp_hcz_h_query_mr(hcp_adapter_handle,
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
+	EDEB_EN(7, "hcp_adapter_handle=%lx pfmr=%p mr_handle=%lx",
+		hcp_adapter_handle.handle, pfmr, mr_handle->handle);
+
+
+	rc = plpar_hcall_7arg_7ret(H_QUERY_MR,
+				   hcp_adapter_handle.handle, /* r4 */
+				   mr_handle->handle,         /* r5 */
+				   0, 0, 0, 0, 0,
+				   mr_local_length,           /* r4 */
+				   mr_local_vaddr,            /* r5 */
+				   mr_remote_length,          /* r6 */
+				   mr_remote_vaddr,           /* r7 */
+				   &acc_ctrl_pd_out,          /* r8 */
+				   &r9_out,
+				   &dummy);
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
+/**
+ * hipz_h_free_resource_mr - Free MR resources in HW and FW.
+ *
+ * @pfmr:      platform specific for MR
+ * @mr_handle: Memory Region Handle
+ */
+static inline u64 hipz_h_free_resource_mr(const struct ipz_adapter_handle
+						     hcp_adapter_handle,
+						     struct ehca_pfmr *pfmr,
+						     const struct ipz_mrmw_handle
+						     *mr_handle)
+{
+	u64 rc = H_Success;
+	u64 dummy;
+
+#ifndef EHCA_USE_HCALL
+	EDEB_EN(7, "hcp_adapter_handle=%lx pfmr=%p mr_handle.mrwpte=%p"
+		" mr_handle.page_index=%x",
+		hcp_adapter_handle.handle, pfmr, mr_handle->mrwpte,
+		mr_handle->page_index);
+
+	rc = simp_hcz_h_free_resource_mr(hcp_adapter_handle, pfmr, mr_handle);
+#else
+	EDEB_EN(7, "hcp_adapter_handle=%lx pfmr=%p mr_handle=%lx",
+		hcp_adapter_handle.handle, pfmr, mr_handle->handle);
+
+	rc = plpar_hcall_7arg_7ret(H_FREE_RESOURCE,
+				   hcp_adapter_handle.handle, /* r4 */
+				   mr_handle->handle,         /* r5 */
+				   0, 0, 0, 0, 0,
+				   &dummy,
+				   &dummy,
+				   &dummy,
+				   &dummy,
+				   &dummy,
+				   &dummy,
+				   &dummy);
+#endif /* EHCA_USE_HCALL */
+	EDEB_EX(7, "rc=%lx", rc);
+
+	return rc;
+}
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
+static inline u64 hipz_h_reregister_pmr(const struct ipz_adapter_handle
+						   hcp_adapter_handle,
+						   struct ehca_pfmr *pfmr,
+						   struct ehca_pfshca *pfshca,
+						   const struct ipz_mrmw_handle
+						   *mr_handle,
+						   const u64 vaddr_in,
+						   const u64 length,
+						   const u32 access_ctrl,
+						   const struct ipz_pd pd,
+						   const u64 mr_addr_cb,
+						   u64 * vaddr_out,
+						   u32 * lkey,
+						   u32 * rkey)
+{
+	u64 rc = H_Success;
+	u64 dummy;
+	u64 lkey_out;
+	u64 rkey_out;
+
+#ifndef EHCA_USE_HCALL
+	EDEB_EN(7, "hcp_adapter_handle=%lx pfmr=%p pfshca=%p"
+		" mr_handle.mrwpte=%p mr_handle.page_index=%x vaddr_in=%lx"
+		" length=%lx access_ctrl=%x pd=%x mr_addr_cb=",
+		hcp_adapter_handle.handle, pfmr, pfshca, mr_handle->mrwpte,
+		mr_handle->page_index, vaddr_in, length, access_ctrl,
+		pd.value, mr_addr_cb);
+
+	rc = simp_hcz_h_reregister_pmr(hcp_adapter_handle, pfmr, pfshca,
+				       mr_handle, vaddr_in, length, access_ctrl,
+				       pd, mr_addr_cb, vaddr_out, lkey, rkey);
+#else
+	EDEB_EN(7, "hcp_adapter_handle=%lx pfmr=%p pfshca=%p mr_handle=%lx "
+		"vaddr_in=%lx length=%lx access_ctrl=%x pd=%x mr_addr_cb=%lx",
+		hcp_adapter_handle.handle, pfmr, pfshca, mr_handle->handle,
+		vaddr_in, length, access_ctrl, pd.value, mr_addr_cb);
+
+	rc = plpar_hcall_7arg_7ret(H_REREGISTER_PMR,
+				   hcp_adapter_handle.handle, /* r4 */
+				   mr_handle->handle,	      /* r5 */
+				   vaddr_in,	              /* r6 */
+				   length,                    /* r7 */
+				   /* r8 */
+				   ((((u64) access_ctrl) << 32ULL) | pd.value),
+				   mr_addr_cb,                /* r9 */
+				   0,
+				   &dummy,                    /* r4 */
+				   vaddr_out,                 /* r5 */
+				   &lkey_out,                 /* r6 */
+				   &rkey_out,                 /* r7 */
+				   &dummy,
+				   &dummy,
+				   &dummy);
+	*lkey = (u32) lkey_out;
+	*rkey = (u32) rkey_out;
+#endif /* EHCA_USE_HCALL */
+
+	EDEB_EX(7, "rc=%lx vaddr_out=%lx lkey=%x rkey=%x",
+		rc, *vaddr_out, *lkey, *rkey);
+	return rc;
+}
+
+/**  @brief
+     as defined in carols hcall document
+*/
+
+/**
+ * Register shared MR in HW and FW.
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
+static inline u64 hipz_h_register_smr(const struct ipz_adapter_handle
+						 hcp_adapter_handle,
+						 struct ehca_pfmr *pfmr,
+						 struct ehca_pfmr *orig_pfmr,
+						 struct ehca_pfshca *pfshca,
+						 const struct ipz_mrmw_handle
+						 *orig_mr_handle,
+						 const u64 vaddr_in,
+						 const u32 access_ctrl,
+						 const struct ipz_pd pd,
+						 struct ipz_mrmw_handle
+						 *mr_handle,
+						 u32 * lkey,
+						 u32 * rkey)
+{
+	u64 rc = H_Success;
+	u64 dummy;
+	u64 lkey_out;
+	u64 rkey_out;
+
+#ifndef EHCA_USE_HCALL
+	EDEB_EN(7, "hcp_adapter_handle=%lx pfmr=%p orig_pfmr=%p pfshca=%p"
+		" orig_mr_handle.mrwpte=%p orig_mr_handle.page_index=%x"
+		" vaddr_in=%lx access_ctrl=%x pd=%x",
+		hcp_adapter_handle.handle, pfmr, orig_pfmr, pfshca,
+		orig_mr_handle->mrwpte, orig_mr_handle->page_index,
+		vaddr_in, access_ctrl, pd.value);
+
+	rc = simp_hcz_h_register_smr(hcp_adapter_handle, pfmr, orig_pfmr,
+				     pfshca, orig_mr_handle, vaddr_in,
+				     access_ctrl, pd,
+				     (struct hcz_mrmw_handle *)mr_handle, lkey,
+				     rkey);
+	EDEB_EX(7, "rc=%lx mr_handle.mrwpte=%p mr_handle.page_index=%x"
+		" lkey=%x rkey=%x",
+		rc, mr_handle->mrwpte, mr_handle->page_index, *lkey, *rkey);
+#else
+	EDEB_EN(7, "hcp_adapter_handle=%lx orig_pfmr=%p pfshca=%p"
+		" orig_mr_handle=%lx vaddr_in=%lx access_ctrl=%x pd=%x",
+		hcp_adapter_handle.handle, orig_pfmr, pfshca,
+		orig_mr_handle->handle, vaddr_in, access_ctrl, pd.value);
+
+
+	rc = plpar_hcall_7arg_7ret(H_REGISTER_SMR,
+				   hcp_adapter_handle.handle,        /* r4 */
+				   orig_mr_handle->handle,           /* r5 */
+				   vaddr_in,                         /* r6 */
+				   ((((u64) access_ctrl) << 32ULL)), /* r7 */
+				   pd.value,                         /* r8 */
+				   0, 0,
+				   &mr_handle->handle,               /* r4 */
+				   &dummy,                           /* r5 */
+				   &lkey_out,                        /* r6 */
+				   &rkey_out,                        /* r7 */
+				   &dummy,
+				   &dummy,
+				   &dummy);
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
+static inline u64 hipz_h_alloc_resource_mw(const struct ipz_adapter_handle
+						      hcp_adapter_handle,
+						      struct ehca_pfmw *pfmw,
+						      struct ehca_pfshca *pfshca,
+						      const struct ipz_pd pd,
+						      struct ipz_mrmw_handle *mw_handle,
+						      u32 * rkey)
+{
+	u64 rc = H_Success;
+	u64 dummy;
+	u64 rkey_out;
+
+	EDEB_EN(7, "hcp_adapter_handle=%lx pfmw=%p pd=%x pfshca=%p",
+		    hcp_adapter_handle.handle, pfmw, pd.value, pfshca);
+
+#ifndef EHCA_USE_HCALL
+
+	rc = simp_hcz_h_alloc_resource_mw(hcp_adapter_handle, pfmw, pfshca, pd,
+					  (struct hcz_mrmw_handle *)mw_handle,
+					  rkey);
+	EDEB_EX(7, "rc=%lx mw_handle.mrwpte=%p mw_handle.page_index=%x rkey=%x",
+		rc, mw_handle->mrwpte, mw_handle->page_index, *rkey);
+#else
+	rc = plpar_hcall_7arg_7ret(H_ALLOC_RESOURCE,
+				   hcp_adapter_handle.handle, /* r4 */
+				   6,                         /* r5 */
+				   pd.value,                  /* r6 */
+				   0, 0, 0, 0,
+				   &mw_handle->handle,        /* r4 */
+				   &dummy,                    /* r5 */
+				   &dummy,                    /* r6 */
+				   &rkey_out,                 /* r7 */
+				   &dummy,
+				   &dummy,
+				   &dummy);
+	*rkey = (u32) rkey_out;
+
+	EDEB_EX(7, "rc=%lx mw_handle=%lx rkey=%x",
+		rc, mw_handle->handle, *rkey);
+#endif /* EHCA_USE_HCALL */
+	return rc;
+}
+
+static inline u64 hipz_h_query_mw(const struct ipz_adapter_handle
+					     hcp_adapter_handle,
+					     struct ehca_pfmw *pfmw,
+					     const struct ipz_mrmw_handle
+					     *mw_handle,
+					     u32 * rkey,
+					     struct ipz_pd *pd)
+{
+	u64 rc = H_Success;
+	u64 dummy;
+	u64 pd_out;
+	u64 rkey_out;
+
+#ifndef EHCA_USE_HCALL
+	EDEB_EN(7, "hcp_adapter_handle=%lx pfmw=%p mw_handle.mrwpte=%p"
+		" mw_handle.page_index=%x",
+		hcp_adapter_handle.handle, pfmw, mw_handle->mrwpte,
+		mw_handle->page_index);
+
+	rc = simp_hcz_h_query_mw(hcp_adapter_handle, pfmw, mw_handle, rkey, pd);
+
+	EDEB_EX(7, "rc=%lx rkey=%x pd=%x", rc, *rkey, pd->value);
+#else
+	EDEB_EN(7, "hcp_adapter_handle=%lx pfmw=%p mw_handle=%lx",
+		hcp_adapter_handle.handle, pfmw, mw_handle->handle);
+
+	rc = plpar_hcall_7arg_7ret(H_QUERY_MW,
+				   hcp_adapter_handle.handle, /* r4 */
+				   mw_handle->handle,         /* r5 */
+				   0, 0, 0, 0, 0,
+				   &dummy,                    /* r4 */
+				   &dummy,                    /* r5 */
+				   &dummy,                    /* r6 */
+				   &rkey_out,                 /* r7 */
+				   &pd_out,                   /* r8 */
+				   &dummy,
+				   &dummy);
+	*rkey = (u32) rkey_out;
+	pd->value = (u32) pd_out;
+
+	EDEB_EX(7, "rc=%lx rkey=%x pd=%x", rc, *rkey, pd->value);
+#endif /* EHCA_USE_HCALL */
+
+	return rc;
+}
+
+static inline u64 hipz_h_free_resource_mw(const struct ipz_adapter_handle
+						     hcp_adapter_handle,
+						     struct ehca_pfmw *pfmw,
+						     const struct ipz_mrmw_handle
+						     *mw_handle)
+{
+	u64 rc = H_Success;
+	u64 dummy;
+
+#ifndef EHCA_USE_HCALL
+	EDEB_EN(7, "hcp_adapter_handle=%lx pfmw=%p mw_handle.mrwpte=%p"
+		" mw_handle.page_index=%x",
+		hcp_adapter_handle.handle, pfmw, mw_handle->mrwpte,
+		mw_handle->page_index);
+
+	rc = simp_hcz_h_free_resource_mw(hcp_adapter_handle, pfmw, mw_handle);
+#else
+	EDEB_EN(7, "hcp_adapter_handle=%lx pfmw=%p mw_handle=%lx",
+		hcp_adapter_handle.handle, pfmw, mw_handle->handle);
+
+	rc = plpar_hcall_7arg_7ret(H_FREE_RESOURCE,
+				   hcp_adapter_handle.handle, /* r4 */
+				   mw_handle->handle,         /* r5 */
+				   0, 0, 0, 0, 0,
+				   &dummy,
+				   &dummy,
+				   &dummy,
+				   &dummy,
+				   &dummy,
+				   &dummy,
+				   &dummy);
+#endif /* EHCA_USE_HCALL */
+	EDEB_EX(7, "rc=%lx", rc);
+
+	return rc;
+}
+
+static inline u64 hipz_h_error_data(const struct ipz_adapter_handle
+					       adapter_handle,
+					       const u64 ressource_handle,
+					       void *rblock,
+					       unsigned long *byte_count)
+{
+	u64 rc = H_Success;
+	u64 dummy;
+	u64 r_cb;
+
+	EDEB_EN(7, "adapter_handle=%lx ressource_handle=%lx  rblock=%p",
+		adapter_handle.handle, ressource_handle, rblock);
+
+	if ((((u64)rblock) & 0xfff) != 0) {
+		EDEB_ERR(4, "rblock not page aligned.");
+		rc = H_Parameter;
+		return rc;
+	}
+
+	r_cb = ehca_kv_to_g(rblock);
+
+	rc = plpar_hcall_7arg_7ret(H_ERROR_DATA,
+				   adapter_handle.handle,
+				   ressource_handle,
+				   r_cb,
+				   0, 0, 0, 0,
+				   &dummy,
+				   &dummy,
+				   &dummy,
+				   &dummy,
+				   &dummy,
+				   &dummy,
+				   &dummy);
+
+	EDEB_EX(7, "rc=%lx", rc);
+
+	return rc;
+}
+
+#endif /* __HCP_IF_H__ */
