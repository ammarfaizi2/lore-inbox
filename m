Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751810AbWBRBBV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751810AbWBRBBV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 20:01:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751831AbWBRA6W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 19:58:22 -0500
Received: from sj-iport-1-in.cisco.com ([171.71.176.70]:47881 "EHLO
	sj-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S1751845AbWBRA6E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 19:58:04 -0500
From: Roland Dreier <rolandd@cisco.com>
Subject: [PATCH 16/22] ehca post send/receive and poll CQ
Date: Fri, 17 Feb 2006 16:57:48 -0800
To: linux-kernel@vger.kernel.org, linuxppc64-dev@ozlabs.org,
       openib-general@openib.org
Cc: SCHICKHJ@de.ibm.com, RAISCH@de.ibm.com, HNGUYEN@de.ibm.com,
       MEDER@de.ibm.com
Message-Id: <20060218005748.13620.45620.stgit@localhost.localdomain>
In-Reply-To: <20060218005532.13620.79663.stgit@localhost.localdomain>
References: <20060218005532.13620.79663.stgit@localhost.localdomain>
X-OriginalArrivalTime: 18 Feb 2006 00:57:48.0273 (UTC) FILETIME=[55FDB610:01C63426]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Roland Dreier <rolandd@cisco.com>

There are an awful lot of magic numbers scattered around.  Probably
they should become enums somewhere.

The compatibility defines for using the kernel file in userspace
shouldn't go into the kernel.
---

 drivers/infiniband/hw/ehca/ehca_reqs.c      |  401 ++++++++++++++++++++++++++
 drivers/infiniband/hw/ehca/ehca_reqs_core.c |  420 +++++++++++++++++++++++++++
 2 files changed, 821 insertions(+), 0 deletions(-)

diff --git a/drivers/infiniband/hw/ehca/ehca_reqs.c b/drivers/infiniband/hw/ehca/ehca_reqs.c
new file mode 100644
index 0000000..659e6ba
--- /dev/null
+++ b/drivers/infiniband/hw/ehca/ehca_reqs.c
@@ -0,0 +1,401 @@
+/*
+ *  IBM eServer eHCA Infiniband device driver for Linux on POWER
+ *
+ *  post_send/recv, poll_cq, req_notify
+ *
+ *  Authors: Waleri Fomin <fomin@de.ibm.com>
+ *           Reinhard Ernst <rernst@de.ibm.com>
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
+ *  $Id: ehca_reqs.c,v 1.41 2006/02/06 10:17:34 schickhj Exp $
+ */
+
+
+#define DEB_PREFIX "reqs"
+
+#include "ehca_kernel.h"
+#include "ehca_classes.h"
+#include "ehca_tools.h"
+#include "hcp_if.h"
+#include "ehca_qes.h"
+#include "ehca_iverbs.h"
+
+/* include some inline service routines */
+#include "ehca_asm.h"
+#include "ehca_reqs_core.c"
+
+int ehca_post_send(struct ib_qp *qp,
+		   struct ib_send_wr *send_wr,
+		   struct ib_send_wr **bad_send_wr)
+{
+	struct ehca_qp *my_qp = NULL;
+	struct ib_send_wr *cur_send_wr = NULL;
+	struct ehca_wqe *wqe_p = NULL;
+	int wqe_cnt = 0;
+	int retcode = 0;
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
+		void *start_addr =
+			&my_qp->ehca_qp_core.ipz_squeue.current_q_addr;
+		/* get pointer next to free WQE */
+		wqe_p = ipz_QEit_get_inc(&my_qp->ehca_qp_core.ipz_squeue);
+		if (unlikely(wqe_p == NULL)) {
+			/* too many posted work requests: queue overflow */
+			if (bad_send_wr != NULL) {
+				*bad_send_wr = cur_send_wr;
+			}
+			if (wqe_cnt==0) {
+				retcode = -ENOMEM;
+				EDEB_ERR(4, "Too many posted WQEs qp_num=%x",
+					 qp->qp_num);
+			}
+			goto post_send_exit0;
+		}
+		/* write a SEND WQE into the QUEUE */
+		retcode = ehca_write_swqe(&my_qp->ehca_qp_core,
+					  wqe_p, cur_send_wr);
+		/* if something failed,
+		   reset the free entry pointer to the start value
+		*/
+		if (unlikely(retcode != 0)) {
+			my_qp->ehca_qp_core.ipz_squeue.current_q_addr =
+				start_addr;
+			*bad_send_wr = cur_send_wr;
+			if (wqe_cnt==0) {
+				retcode = -EINVAL;
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
+ post_send_exit0:
+	/* UNLOCK the QUEUE */
+	spin_unlock_irqrestore(&my_qp->spinlock_s, spl_flags);
+	iosync(); /* serialize GAL register access */
+	hipz_update_SQA(&my_qp->ehca_qp_core, wqe_cnt);
+	EDEB_EX(7, "ehca_qp=%p qp_num=%x ret=%x wqe_cnt=%d",
+		my_qp, qp->qp_num, retcode, wqe_cnt);
+	return retcode;
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
+	int retcode = 0;
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
+		void *start_addr =
+			&my_qp->ehca_qp_core.ipz_rqueue.current_q_addr;
+		/* get pointer next to free WQE */
+		wqe_p = ipz_QEit_get_inc(&my_qp->ehca_qp_core.ipz_rqueue);
+		if (unlikely(wqe_p == NULL)) {
+			/* too many posted work requests: queue overflow */
+			if (bad_recv_wr != NULL) {
+				*bad_recv_wr = cur_recv_wr;
+			}
+			if (wqe_cnt==0) {
+				retcode = -ENOMEM;
+				EDEB_ERR(4, "Too many posted WQEs qp_num=%x",
+					 qp->qp_num);
+			}
+			goto post_recv_exit0;
+		}
+		/* write a RECV WQE into the QUEUE */
+		retcode =
+			ehca_write_rwqe(&my_qp->ehca_qp_core, wqe_p, cur_recv_wr);
+		/* if something failed,
+		   reset the free entry pointer to the start value
+		*/
+		if (unlikely(retcode != 0)) {
+			my_qp->ehca_qp_core.ipz_rqueue.current_q_addr =
+				start_addr;
+			*bad_recv_wr = cur_recv_wr;
+			if (wqe_cnt==0) {
+				retcode = -EINVAL;
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
+ post_recv_exit0:
+	spin_unlock_irqrestore(&my_qp->spinlock_r, spl_flags);
+	iosync(); /* serialize GAL register access */
+	hipz_update_RQA(&my_qp->ehca_qp_core, wqe_cnt);
+	EDEB_EX(7, "ehca_qp=%p qp_num=%x ret=%x wqe_cnt=%d",
+		my_qp, qp->qp_num, retcode, wqe_cnt);
+	return retcode;
+}
+
+/**
+ * Table converts ehca wc opcode to ib
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
+/** @brief internal function to poll one entry of cq
+ */
+static inline int ehca_poll_cq_one(struct ib_cq *cq, struct ib_wc *wc)
+{
+	int retcode = 0;
+	struct ehca_cq *my_cq = container_of(cq, struct ehca_cq, ib_cq);
+	struct ehca_cqe *cqe = NULL;
+	int cqe_count = 0;
+
+	EDEB_EN(7, "ehca_cq=%p cq_num=%x wc=%p", my_cq, my_cq->cq_number, wc);
+
+ poll_cq_one_read_cqe:
+	cqe = (struct ehca_cqe *)
+		ipz_QEit_get_inc_valid(&my_cq->ehca_cq_core.ipz_queue);
+	if (cqe == NULL) {
+		retcode = -EAGAIN;
+		EDEB(7, "Completion queue is empty ehca_cq=%p cq_num=%x "
+		     "retcode=%x", my_cq, my_cq->cq_number, retcode);
+		goto  poll_cq_one_exit0;
+	}
+	cqe_count++;
+	if (unlikely(cqe->status & 0x10)) { /* purge bit set */
+		struct ehca_qp *qp=ehca_cq_get_qp(my_cq, cqe->local_qp_number);
+		int purgeflag = 0;
+		unsigned long spl_flags = 0;
+		if (qp==NULL) { /* should not happen */
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
+		if (purgeflag!=0) {
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
+		EDEB_DMP(4, cqe, 64, "ehca_cq=%p cq_num=%x", my_cq, my_cq->cq_number);
+		/* update also queue adder to throw away this entry!!! */
+		goto poll_cq_one_exit0;
+	}
+	/* eval ib_wc_status */
+	if (unlikely(cqe->status & 0x80000000)) { /* complete with errors */
+		map_ib_wc_status(cqe->status, &wc->status);
+		wc->vendor_err = wc->status;
+	} else {
+		wc->status = IB_WC_SUCCESS;
+	}
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
+	if (wc->status != IB_WC_SUCCESS) {
+		EDEB(6, "ehca_cq=%p cq_num=%x WARNING unsuccessful cqe "
+		     "OPType=%x status=%x qp_num=%x src_qp=%x wr_id=%lx cqe=%p",
+		     my_cq, my_cq->cq_number, cqe->optype, cqe->status,
+		     cqe->local_qp_number, cqe->remote_qp_number,
+		     cqe->work_request_id, cqe);
+	}
+
+ poll_cq_one_exit0:
+	if (cqe_count>0) {
+		hipz_update_FECA(&my_cq->ehca_cq_core, cqe_count);
+	}
+
+	EDEB_EX(7, "retcode=%x ehca_cq=%p cq_number=%x wc=%p "
+		"status=%x opcode=%x qp_num=%x byte_len=%x",
+		retcode, my_cq, my_cq->cq_number, wc, wc->status,
+		wc->opcode, wc->qp_num, wc->byte_len);
+	return (retcode);
+}
+
+int ehca_poll_cq(struct ib_cq *cq, int num_entries, struct ib_wc *wc)
+{
+	struct ehca_cq *my_cq = NULL;
+	int nr = 0;
+	struct ib_wc *current_wc = NULL;
+	int retcode = 0;
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
+		retcode = -EINVAL;
+		goto poll_cq_exit0;
+	}
+
+	current_wc = wc;
+	spin_lock_irqsave(&my_cq->spinlock, spl_flags);
+	for (nr = 0; nr < num_entries; nr++) {
+		retcode = ehca_poll_cq_one(cq, current_wc);
+		if (0 != retcode) {
+			break;
+		}
+		current_wc++;
+	} /* eof for nr */
+	spin_unlock_irqrestore(&my_cq->spinlock, spl_flags);
+	if (-EAGAIN == retcode || 0 == retcode) {
+		retcode = nr;
+	}
+
+ poll_cq_exit0:
+	EDEB_EX(7, "ehca_cq=%p cq_num=%x retcode=%x wc=%p nr_entries=%d",
+		my_cq, my_cq->cq_number, retcode, wc, nr);
+	return (retcode);
+}
+
+int ehca_req_notify_cq(struct ib_cq *cq, enum ib_cq_notify cq_notify)
+{
+	struct ehca_cq *my_cq = NULL;
+	int retcode = 0;
+
+	EHCA_CHECK_CQ(cq);
+	my_cq = container_of(cq, struct ehca_cq, ib_cq);
+	EHCA_CHECK_CQ(my_cq);
+	EDEB_EN(7, "ehca_cq=%p cq_num=%x cq_notif=%x",
+		my_cq, my_cq->cq_number, cq_notify);
+
+	switch (cq_notify) {
+	case IB_CQ_SOLICITED:
+		hipz_set_CQx_N0(&my_cq->ehca_cq_core, 1);
+		break;
+	case IB_CQ_NEXT_COMP:
+		hipz_set_CQx_N1(&my_cq->ehca_cq_core, 1);
+		break;
+	default:
+		retcode = -EINVAL;
+	}
+
+	EDEB_EX(7, "ehca_cq=%p cq_num=%x retcode=%x",
+		my_cq, my_cq->cq_number, retcode);
+
+	return (retcode);
+}
+
+/* eof ehca_reqs.c */
diff --git a/drivers/infiniband/hw/ehca/ehca_reqs_core.c b/drivers/infiniband/hw/ehca/ehca_reqs_core.c
new file mode 100644
index 0000000..c0b7281
--- /dev/null
+++ b/drivers/infiniband/hw/ehca/ehca_reqs_core.c
@@ -0,0 +1,420 @@
+/*
+ *  IBM eServer eHCA Infiniband device driver for Linux on POWER
+ *
+ *  post_send/recv, poll_cq, req_notify
+ *  Common code to be included statically in respective user/kernel
+ *  modules, i.e. ehca_ureqs.c/ehca_reqs.c
+ *  This module contains C code only. Including modules must include
+ *  all required header files.
+ *
+ *  Authors: Waleri Fomin <fomin@de.ibm.com>
+ *           Reinhard Ernst <rernst@de.ibm.com>
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
+ *  $Id: ehca_reqs_core.c,v 1.40 2006/02/06 10:17:34 schickhj Exp $
+ */
+
+/** THIS following block of defines
+ * replaces ib types of kernel space to corresponding ones in user space,
+ * so that the implemented inline functions below can be compiled and
+ * work in both user and kernel space.
+ * However this ASSUMES that there is no functional differences between ib
+ * types in kernel e.g. ib_send_wr and user space e.g. ibv_send_wr.
+ */
+
+#ifndef __KERNEL__
+#define ib_recv_wr ibv_recv_wr
+#define ib_send_wr ibv_send_wr
+#define ehca_av ehcau_av
+/* ib_wr_opcode */
+#define IB_WR_SEND IBV_WR_SEND
+#define IB_WR_SEND_WITH_IMM IBV_WR_SEND_WITH_IMM
+#define IB_WR_RDMA_WRITE IBV_WR_RDMA_WRITE
+#define IB_WR_RDMA_WRITE_WITH_IMM IBV_WR_RDMA_WRITE_WITH_IMM
+#define IB_WR_RDMA_READ IBV_WR_RDMA_READ
+/* ib_qp_type */
+#define IB_QPT_RC IBV_QPT_RC
+#define IB_QPT_UC IBV_QPT_UC
+#define IB_QPT_UD IBV_QPT_UD
+/* ib_wc_opcode */
+#define ib_wc_opcode ibv_wc_opcode
+#define IB_WC_SEND IBV_WC_SEND
+#define IB_WC_RDMA_WRITE IBV_WC_RDMA_WRITE
+#define IB_WC_RDMA_READ IBV_WC_RDMA_READ
+#define IB_WC_COMP_SWAP IBV_WC_COMP_SWAP
+#define IB_WC_FETCH_ADD IBV_WC_FETCH_ADD
+#define IB_WC_BIND_MW IBV_WC_BIND_MW
+#define IB_WC_RECV IBV_WC_RECV
+#define IB_WC_RECV_RDMA_WITH_IMM IBV_WC_RECV_RDMA_WITH_IMM
+/* ib_wc_status */
+#define ib_wc_status ibv_wc_status
+#define IB_WC_LOC_LEN_ERR IBV_WC_LOC_LEN_ERR
+#define IB_WC_LOC_QP_OP_ERR IBV_WC_LOC_QP_OP_ERR
+#define IB_WC_LOC_EEC_OP_ERR IBV_WC_LOC_EEC_OP_ERR
+#define IB_WC_LOC_PROT_ERR IBV_WC_LOC_PROT_ERR
+#define IB_WC_WR_FLUSH_ERR IBV_WC_WR_FLUSH_ERR
+#define IB_WC_MW_BIND_ERR IBV_WC_MW_BIND_ERR
+#define IB_WC_GENERAL_ERR IBV_WC_GENERAL_ERR
+#define IB_WC_REM_INV_REQ_ERR IBV_WC_REM_INV_REQ_ERR
+#define IB_WC_REM_ACCESS_ERR IBV_WC_REM_ACCESS_ERR
+#define IB_WC_REM_OP_ERR IBV_WC_REM_OP_ERR
+#define IB_WC_REM_INV_RD_REQ_ERR IBV_WC_REM_INV_RD_REQ_ERR
+#define IB_WC_RETRY_EXC_ERR IBV_WC_RETRY_EXC_ERR
+#define IB_WC_RNR_RETRY_EXC_ERR IBV_WC_RNR_RETRY_EXC_ERR
+#define IB_WC_REM_ABORT_ERR IBV_WC_REM_ABORT_ERR
+#define IB_WC_INV_EECN_ERR IBV_WC_INV_EECN_ERR
+#define IB_WC_INV_EEC_STATE_ERR IBV_WC_INV_EEC_STATE_ERR
+#define IB_WC_BAD_RESP_ERR IBV_WC_BAD_RESP_ERR
+#define IB_WC_FATAL_ERR IBV_WC_FATAL_ERR
+#define IB_WC_SUCCESS IBV_WC_SUCCESS
+/* ib_send_flags */
+#define IB_SEND_FENCE IBV_SEND_FENCE
+#define IB_SEND_SIGNALED IBV_SEND_SIGNALED
+#define IB_SEND_SOLICITED IBV_SEND_SOLICITED
+#define IB_SEND_INLINE IBV_SEND_INLINE
+#endif
+
+static inline int ehca_write_rwqe(struct ehca_qp_core *qp_core,
+				  struct ehca_wqe *wqe_p,
+				  struct ib_recv_wr *recv_wr)
+{
+	u8 cnt_ds;
+	if (unlikely((recv_wr->num_sge < 0) ||
+		     (recv_wr->num_sge > qp_core->ipz_rqueue.act_nr_of_sg))) {
+		EDEB_ERR(4, "Invalid number of WQE SGE. "
+			 "num_sqe=%x max_nr_of_sg=%x",
+			 recv_wr->num_sge, qp_core->ipz_rqueue.act_nr_of_sg);
+		return (-EINVAL); /* invalid SG list length */
+	}
+
+	clear_cacheline(wqe_p);
+	clear_cacheline((u8 *) wqe_p + 32);
+	clear_cacheline((u8 *) wqe_p + 64);
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
+		EDEB(7, "RECEIVE WQE written into queue qp_core=%p", qp_core);
+		EDEB_DMP(7, wqe_p, 16*(6 + wqe_p->nr_of_data_seg),
+			 "qp_core=%p", qp_core);
+	}
+
+	return (0);
+}
+
+/* internal use only
+   uncomment this line to enable trace output of GSI send wr */
+/* #define DEBUG_GSI_SEND_WR 1 */
+#if defined(__KERNEL__) && defined(DEBUG_GSI_SEND_WR)
+
+/* need ib_mad struct */
+#include <rdma/ib_mad.h>
+
+static void trace_send_wr_ud(const struct ib_send_wr *send_wr)
+{
+	int idx = 0;
+	int j = 0;
+	while (send_wr != NULL) {
+		struct ib_mad_hdr *mad_hdr = send_wr->wr.ud.mad_hdr;
+		struct ib_sge *sge = send_wr->sg_list;
+		EDEB(4, "send_wr#%x wr_id=%lx num_sge=%x "
+		     "send_flags=%x opcode=%x",idx, send_wr->wr_id,
+		     send_wr->num_sge, send_wr->send_flags, send_wr->opcode);
+		if (mad_hdr != NULL) {
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
+#ifdef EHCA_USERDRIVER
+			u8 *data = (u8 *) sge->addr;
+#else
+			u8 *data = (u8 *) abs_to_virt(sge->addr);
+#endif
+			EDEB(4, "send_wr#%x sge#%x addr=%p length=%x lkey=%x",
+			     idx, j, data, sge->length, sge->lkey);
+			/* assume length is n*16 */
+			EDEB_DMP(4, data, sge->length, "send_wr#%x sge#%x", idx, j);
+			sge++;
+		} /* eof for j */
+		idx++;
+		send_wr = send_wr->next;
+	} /* eof while send_wr */
+}
+
+#endif /* __KERNEL__ && DEBUG_GSI_SEND_WR */
+
+static inline int ehca_write_swqe(struct ehca_qp_core *qp_core,
+				  struct ehca_wqe *wqe_p,
+				  const struct ib_send_wr *send_wr)
+{
+	u32 idx;
+	u64 dma_length;
+	struct ehca_av *my_av;
+	u32 remote_qkey = send_wr->wr.ud.remote_qkey;
+
+	clear_cacheline(wqe_p);
+	clear_cacheline((u8 *) wqe_p + 32);
+
+	if (unlikely((send_wr->num_sge < 0) ||
+		     (send_wr->num_sge > qp_core->ipz_squeue.act_nr_of_sg))) {
+		EDEB_ERR(4, "Invalid number of WQE SGE. "
+			 "num_sqe=%x max_nr_of_sg=%x",
+			 send_wr->num_sge, qp_core->ipz_rqueue.act_nr_of_sg);
+		return (-EINVAL); /* invalid SG list length */
+	}
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
+		return (-EINVAL); /* invalid opcode */
+	}
+
+	wqe_p->wqef = (send_wr->opcode) & 0xF0;
+
+	wqe_p->wr_flag = 0;
+	if (send_wr->send_flags & IB_SEND_SIGNALED) {
+		wqe_p->wr_flag |= WQE_WRFLAG_REQ_SIGNAL_COM;
+	}
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
+	switch (qp_core->qp_type) {
+#ifdef __KERNEL__
+	case IB_QPT_SMI:
+	case IB_QPT_GSI:
+#endif /* __KERNEL__ */
+		/* no break is intential here */
+	case IB_QPT_UD:
+		/* IB 1.2 spec C10-15 compliance */
+		if (send_wr->wr.ud.remote_qkey & 0x80000000) {
+			remote_qkey = qp_core->qkey;
+		}
+		wqe_p->destination_qp_number =
+		    ntohl(send_wr->wr.ud.remote_qpn << 8);
+		wqe_p->local_ee_context_qkey = ntohl(remote_qkey);
+		if (send_wr->wr.ud.ah==NULL) {
+			EDEB_ERR(4, "wr.ud.ah is NULL. qp_core=%p", qp_core);
+			return (-EINVAL);
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
+#ifdef __KERNEL__
+		if (qp_core->qp_type == IB_QPT_SMI ||
+		    qp_core->qp_type == IB_QPT_GSI) {
+			wqe_p->u.ud_av.ud_av.pmtu = 1;
+		}
+		if (qp_core->qp_type == IB_QPT_GSI) {
+			wqe_p->pkeyi =
+			    ntohs(send_wr->wr.ud.pkey_index);
+#ifdef DEBUG_GSI_SEND_WR
+			trace_send_wr_ud(send_wr);
+#endif /* DEBUG_GSI_SEND_WR */
+		}
+#endif /* __KERNEL__ */
+		break;
+
+	case IB_QPT_UC:
+		if (send_wr->send_flags & IB_SEND_FENCE) {
+			wqe_p->wr_flag |= WQE_WRFLAG_FENCE;
+		}
+		/* no break is intential here */
+	case IB_QPT_RC:
+		/*@@TODO atomic???*/
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
+		EDEB_ERR(4, "Invalid qptype=%x", qp_core->qp_type);
+		return (-EINVAL);
+	}
+
+	if (IS_EDEB_ON(7)) {
+		EDEB(7, "SEND WQE written into queue qp_core=%p ", qp_core);
+		EDEB_DMP(7, wqe_p, 16*(6 + wqe_p->nr_of_data_seg),
+			 "qp_core=%p", qp_core);
+	}
+	return (0);
+}
+
+/** @brief convert cqe_status to ib_wc_status
+ */
+static inline void map_ib_wc_status(u32 cqe_status,
+				    enum ib_wc_status *wc_status)
+{
+	if (unlikely(cqe_status & 0x80000000)) { /* complete with errors */
+		switch (cqe_status & 0x0000003F) {
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
+			switch ((cqe_status & 0x0000F800) >> 11) {
+			case 0x0:
+				/* PSN Sequence Error!
+				   couldn't find a matching VAPI status! */
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
+	} else {
+		*wc_status = IB_WC_SUCCESS;
+	}
+}
+
