Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751812AbWBRA67@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751812AbWBRA67 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 19:58:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751826AbWBRA6s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 19:58:48 -0500
Received: from sj-iport-2-in.cisco.com ([171.71.176.71]:59775 "EHLO
	sj-iport-2.cisco.com") by vger.kernel.org with ESMTP
	id S1751812AbWBRA5v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 19:57:51 -0500
From: Roland Dreier <rolandd@cisco.com>
Subject: [PATCH 15/22] ehca queue pair handling
Date: Fri, 17 Feb 2006 16:57:45 -0800
To: linux-kernel@vger.kernel.org, linuxppc64-dev@ozlabs.org,
       openib-general@openib.org
Cc: SCHICKHJ@de.ibm.com, RAISCH@de.ibm.com, HNGUYEN@de.ibm.com,
       MEDER@de.ibm.com
Message-Id: <20060218005745.13620.43256.stgit@localhost.localdomain>
In-Reply-To: <20060218005532.13620.79663.stgit@localhost.localdomain>
References: <20060218005532.13620.79663.stgit@localhost.localdomain>
X-OriginalArrivalTime: 18 Feb 2006 00:57:46.0133 (UTC) FILETIME=[54B72C50:01C63426]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Roland Dreier <rolandd@cisco.com>


---

 drivers/infiniband/hw/ehca/ehca_qp.c | 1528 ++++++++++++++++++++++++++++++++++
 1 files changed, 1528 insertions(+), 0 deletions(-)

diff --git a/drivers/infiniband/hw/ehca/ehca_qp.c b/drivers/infiniband/hw/ehca/ehca_qp.c
new file mode 100644
index 0000000..e5b1b80
--- /dev/null
+++ b/drivers/infiniband/hw/ehca/ehca_qp.c
@@ -0,0 +1,1528 @@
+/*
+ *  IBM eServer eHCA Infiniband device driver for Linux on POWER
+ *
+ *  QP functions
+ *
+ *  Authors: Waleri Fomin <fomin@de.ibm.com>
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
+ *
+ *  $Id: ehca_qp.c,v 1.159 2006/02/15 15:01:24 nguyen Exp $
+ */
+
+
+#define DEB_PREFIX "e_qp"
+
+#include "ehca_kernel.h"
+
+#include "ehca_classes.h"
+#include "ehca_tools.h"
+#include "hcp_if.h"
+#include "ehca_qes.h"
+
+#include "ehca_iverbs.h"
+#include <linux/module.h>
+#include <linux/err.h>
+
+#include <asm/io.h>
+#include <asm/uaccess.h>
+
+/** @brief attributes not supported by query qp
+ */
+#define QP_ATTR_QUERY_NOT_SUPPORTED (IB_QP_MAX_DEST_RD_ATOMIC | \
+				     IB_QP_MAX_QP_RD_ATOMIC   | \
+				     IB_QP_ACCESS_FLAGS       | \
+				     IB_QP_EN_SQD_ASYNC_NOTIFY)
+
+/** @brief ehca (internal) qp state values
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
+/** @brief qp state transitions as defined by IB Arch Rel 1.1 page 431
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
+/** @brief returns ehca qp state corresponding to given ib qp state
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
+/** @brief returns ib qp state corresponding to given ehca qp state
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
+/** @brief qp type
+ * used as index for req_attr and opt_attr of struct ehca_modqp_statetrans
+ */
+enum ehca_qp_type {
+	QPT_RC = 0,
+	QPT_UC = 1,
+	QPT_UD = 2,
+	QPT_SQP = 3,
+	QPT_MAX
+};
+
+/** @brief returns ehca qp type corresponding to ib qp type
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
+		if (ib_fromstate == IB_QPS_RESET) {
+			index = IB_QPST_RESET2INIT;
+		} else if (ib_fromstate == IB_QPS_INIT) {
+			index = IB_QPST_INIT2INIT;
+		}
+		break;
+	case IB_QPS_RTR:
+		if (ib_fromstate == IB_QPS_INIT) {
+			index = IB_QPST_INIT2RTR;
+		}
+		break;
+	case IB_QPS_RTS:
+		if (ib_fromstate == IB_QPS_RTR) {
+			index = IB_QPST_RTR2RTS;
+		} else if (ib_fromstate == IB_QPS_RTS) {
+			index = IB_QPST_RTS2RTS;
+		} else if (ib_fromstate == IB_QPS_SQD) {
+			index = IB_QPST_SQD2RTS;
+		} else if (ib_fromstate == IB_QPS_SQE) {
+			index = IB_QPST_SQE2RTS;
+		}
+		break;
+	case IB_QPS_SQD:
+		if (ib_fromstate == IB_QPS_RTS) {
+			index = IB_QPST_RTS2SQD;
+		}
+		break;
+	case IB_QPS_SQE:
+		/* not allowed via mod qp */
+		break;
+	case IB_QPS_ERR:
+		index = IB_QPST_ANY2ERR;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return index;
+}
+
+/** @brief ehca service types
+ */
+enum ehca_service_type {
+	ST_RC = 0,
+	ST_UC = 1,
+	ST_RD = 2,
+	ST_UD = 3
+};
+
+/** @brief returns hcp service type corresponding to given ib qp type
+ * used by create_qp()
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
+/* init_qp_queues - Initializes/constructs r/squeue and registers queue pages.
+ * returns 0  if successful,
+ *        -EXXXX if not
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
+	u64 hipz_rc = H_Parameter;
+
+	ipz_rc = ipz_queue_ctor(&my_qp->ehca_qp_core.ipz_squeue,
+				nr_sq_pages,
+				EHCA_PAGESIZE, swqe_size, nr_send_sges);
+	if (!ipz_rc) {
+		EDEB_ERR(4, "Cannot allocate page for squeue. ipz_rc=%x",
+			 ipz_rc);
+		ret = -EBUSY;
+		return ret;
+	}
+
+	ipz_rc = ipz_queue_ctor(&my_qp->ehca_qp_core.ipz_rqueue,
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
+		vpage = ipz_QPageit_get_inc(&my_qp->ehca_qp_core.ipz_squeue);
+		if (!vpage) {
+			EDEB_ERR(4, "SQ ipz_QPageit_get_inc() "
+				 "failed p_vpage= %p", vpage);
+			ret = -EINVAL;
+			goto init_qp_queues1;
+		}
+		rpage = ehca_kv_to_g(vpage);
+
+		hipz_rc = hipz_h_register_rpage_qp(ipz_hca_handle,
+						   my_qp->ipz_qp_handle,
+						   &my_qp->pf, 0, 0, /*TODO*/
+						   rpage, 1,
+						   my_qp->ehca_qp_core.galpas.kernel);
+		if (hipz_rc < H_Success) {
+			EDEB_ERR(4,"SQ  hipz_qp_register_rpage() faield "
+				 " rc=%lx", hipz_rc);
+			ret = ehca2ib_return_code(hipz_rc);
+			goto init_qp_queues1;
+		}
+		/* for sq no need to check hipz_rc against
+		   e.g. H_PAGE_REGISTERED */
+	}
+
+	ipz_QEit_reset(&my_qp->ehca_qp_core.ipz_squeue);
+
+	/* register RQ pages */
+	for (cnt = 0; cnt < nr_rq_pages; cnt++) {
+		vpage = ipz_QPageit_get_inc(&my_qp->ehca_qp_core.ipz_rqueue);
+		if (!vpage) {
+			EDEB_ERR(4,"RQ ipz_QPageit_get_inc() "
+				 "failed p_vpage = %p", vpage);
+			hipz_rc = H_Resource;
+			ret = -EINVAL;
+			goto init_qp_queues1;
+		}
+
+		rpage = ehca_kv_to_g(vpage);
+
+		hipz_rc = hipz_h_register_rpage_qp(ipz_hca_handle,
+						   my_qp->ipz_qp_handle,
+						   &my_qp->pf, 0, 1, /*TODO*/
+						   rpage, 1,
+						   my_qp->ehca_qp_core.galpas.
+						   kernel);
+		if (hipz_rc < H_Success) {
+			EDEB_ERR(4, "RQ hipz_qp_register_rpage() failed "
+			     "rc=%lx", hipz_rc);
+			ret = ehca2ib_return_code(hipz_rc);
+			goto init_qp_queues1;
+		}
+		if (cnt == (nr_rq_pages - 1)) {	/* last page! */
+			if (hipz_rc != H_Success) {
+				EDEB_ERR(4,"RQ hipz_qp_register_rpage() "
+					 "hipz_rc= %lx ", hipz_rc);
+				ret = ehca2ib_return_code(hipz_rc);
+				goto init_qp_queues1;
+			}
+			vpage = ipz_QPageit_get_inc(&my_qp->ehca_qp_core.ipz_rqueue);
+			if (vpage != NULL) {
+				EDEB_ERR(4,"ipz_QPageit_get_inc() "
+					 "should not succeed vpage=%p",
+					 vpage);
+				ret = -EINVAL;
+				goto init_qp_queues1;
+			}
+		} else {
+			if (hipz_rc != H_PAGE_REGISTERED) {
+				EDEB_ERR(4,"RQ hipz_qp_register_rpage() "
+					 "hipz_rc= %lx ", hipz_rc);
+				ret = ehca2ib_return_code(hipz_rc);
+				goto init_qp_queues1;
+			}
+		}
+	}
+
+	ipz_QEit_reset(&my_qp->ehca_qp_core.ipz_rqueue);
+
+	return 0;
+
+ init_qp_queues1:
+	ipz_queue_dtor(&my_qp->ehca_qp_core.ipz_rqueue);
+ init_qp_queues0:
+	ipz_queue_dtor(&my_qp->ehca_qp_core.ipz_squeue);
+	return ret;
+}
+
+
+struct ib_qp *ehca_create_qp(struct ib_pd *pd,
+			     struct ib_qp_init_attr *init_attr,
+			     struct ib_udata *udata)
+{
+	static int da_msg_size[]={ 128, 256, 512, 1024, 2048, 4096 };
+	int ret = -EINVAL;
+	int servicetype = 0;
+	int sigtype = 0;
+
+	struct ehca_qp *my_qp = NULL;
+	struct ehca_pd *my_pd = NULL;
+	struct ehca_shca *shca = NULL;
+	struct ehca_cq *recv_ehca_cq = NULL;
+	struct ehca_cq *send_ehca_cq = NULL;
+	struct ib_ucontext *context = NULL;
+	u64 hipz_rc = H_Parameter;
+	int max_send_sge;
+	int max_recv_sge;
+	/* h_call's out parameters */
+	u16 act_nr_send_wqes = 0, act_nr_receive_wqes = 0;
+	u8 act_nr_send_sges = 0, act_nr_receive_sges = 0;
+	u32 qp_nr = 0,
+		nr_sq_pages = 0, swqe_size = 0, rwqe_size = 0, nr_rq_pages = 0;
+	u8 daqp_completion;
+	u8 isdaqp;
+	EDEB_EN(7,"pd=%p init_attr=%p", pd, init_attr);
+
+	EHCA_CHECK_PD_P(pd);
+	EHCA_CHECK_ADR_P(init_attr);
+
+	if (init_attr->sq_sig_type != IB_SIGNAL_REQ_WR &&
+	    init_attr->sq_sig_type != IB_SIGNAL_ALL_WR) {
+		EDEB_ERR(4, "init_attr->sg_sig_type=%x not allowed",
+			 init_attr->sq_sig_type);
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
+	if (pd->uobject && udata != NULL) {
+		context = pd->uobject->context;
+	}
+
+	my_qp = ehca_qp_new();
+	if (!my_qp) {
+		EDEB_ERR(4, "pd=%p not enough memory to alloc qp", pd);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	my_pd = container_of(pd, struct ehca_pd, ib_pd);
+
+	shca = container_of(pd->device, struct ehca_shca, ib_device);
+	recv_ehca_cq = container_of(init_attr->recv_cq, struct ehca_cq, ib_cq);
+	send_ehca_cq = container_of(init_attr->send_cq, struct ehca_cq, ib_cq);
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
+		down_write(&ehca_qp_idr_sem);
+		ret = idr_get_new(&ehca_qp_idr, my_qp, &my_qp->token);
+		up_write(&ehca_qp_idr_sem);
+
+	} while (ret == -EAGAIN);
+
+	if (ret) {
+		ret = -ENOMEM;
+		EDEB_ERR(4, "Can't allocate new idr entry.");
+		goto create_qp_exit0;
+	}
+
+	servicetype = ibqptype2servicetype(init_attr->qp_type);
+	if (servicetype < 0) {
+		ret = -EINVAL;
+		EDEB_ERR(4, "Invalid qp_type=%x", init_attr->qp_type);
+		goto create_qp_exit0;
+	}
+
+	if (init_attr->sq_sig_type == IB_SIGNAL_ALL_WR) {
+		sigtype = HCALL_SIGT_EVERY;
+	} else {
+		sigtype = HCALL_SIGT_BY_WQE;
+	}
+
+	/* UD_AV CIRCUMVENTION */
+	max_send_sge=init_attr->cap.max_send_sge;
+	max_recv_sge=init_attr->cap.max_recv_sge;
+	if (IB_QPT_UD == init_attr->qp_type ||
+	    IB_QPT_GSI == init_attr->qp_type ||
+	    IB_QPT_SMI == init_attr->qp_type) {
+		max_send_sge += 2;
+		max_recv_sge += 2;
+	}
+
+	EDEB(7, "isdaqp=%x daqp_completion=%x", isdaqp, daqp_completion);
+
+	hipz_rc = hipz_h_alloc_resource_qp(shca->ipz_hca_handle,
+					   &my_qp->pf,
+					   servicetype,
+					   isdaqp | daqp_completion,
+					   sigtype, 0, /* no ud ad lkey ctrl */
+					   send_ehca_cq->ipz_cq_handle,
+					   recv_ehca_cq->ipz_cq_handle,
+					   shca->eq.ipz_eq_handle,
+					   my_qp->token,
+					   my_pd->fw_pd,
+					   (u16) init_attr->cap.max_send_wr + 1, /* fixme(+1 ??) */
+					   (u16) init_attr->cap.max_recv_wr + 1, /* fixme(+1 ??) */
+					   (u8) max_send_sge,
+					   (u8) max_recv_sge,
+					   0, /* ignored if ud ad lkey ctrl is 0 */
+					   &my_qp->ipz_qp_handle,
+					   &qp_nr,
+					   &act_nr_send_wqes,
+					   &act_nr_receive_wqes,
+					   &act_nr_send_sges,
+					   &act_nr_receive_sges,
+					   &nr_sq_pages,
+					   &nr_rq_pages,
+					   &my_qp->ehca_qp_core.galpas);
+	if (hipz_rc != H_Success) {
+		EDEB_ERR(4, "h_alloc_resource_qp() failed rc=%lx", hipz_rc);
+		ret = ehca2ib_return_code(hipz_rc);
+		goto create_qp_exit1;
+	}
+
+	/* store real qp_num as we got from ehca */
+	my_qp->ehca_qp_core.real_qp_num = qp_nr;
+
+	switch (init_attr->qp_type) {
+	case IB_QPT_RC:
+	        if (isdaqp == 0) {
+		        swqe_size = offsetof(struct ehca_wqe,
+					     u.nud.sg_list[(act_nr_send_sges)]);
+			rwqe_size = offsetof(struct ehca_wqe,
+					     u.nud.sg_list[(act_nr_receive_sges)]);
+		} else { /* for daqp we need to use msg size, not wqe size */
+		        swqe_size = da_msg_size[max_send_sge];
+			rwqe_size = da_msg_size[max_recv_sge];
+			act_nr_send_sges=1;
+			act_nr_receive_sges=1;
+		}
+		break;
+	case IB_QPT_UC:
+		swqe_size = offsetof(struct ehca_wqe,
+				     u.nud.sg_list[(act_nr_send_sges)]);
+		rwqe_size = offsetof(struct ehca_wqe,
+				     u.nud.sg_list[(act_nr_receive_sges)]);
+		break;
+
+	case IB_QPT_UD:
+	case IB_QPT_GSI:
+	case IB_QPT_SMI:
+		/* UD circumvention */
+	        act_nr_receive_sges -= 2;
+		act_nr_send_sges -= 2;
+		swqe_size = offsetof(struct ehca_wqe,
+				     u.ud_av.sg_list[(act_nr_send_sges)]);
+		rwqe_size = offsetof(struct ehca_wqe,
+				     u.ud_av.sg_list[(act_nr_receive_sges)]);
+
+		if (IB_QPT_GSI == init_attr->qp_type ||
+		    IB_QPT_SMI == init_attr->qp_type) {
+			act_nr_send_wqes = init_attr->cap.max_send_wr;
+			act_nr_receive_wqes = init_attr->cap.max_recv_wr;
+			act_nr_send_sges = init_attr->cap.max_send_sge;
+			act_nr_receive_sges = init_attr->cap.max_recv_sge;
+			qp_nr = (init_attr->qp_type == IB_QPT_SMI) ? 0 : 1;
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
+			     nr_sq_pages, nr_rq_pages,
+			     swqe_size, rwqe_size,
+			     act_nr_send_sges, act_nr_receive_sges);
+	if (ret != 0) {
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
+	my_qp->ib_qp.qp_num = qp_nr;
+	my_qp->ib_qp.qp_type = init_attr->qp_type;
+
+	my_qp->ehca_qp_core.qp_type = init_attr->qp_type;
+	my_qp->ib_qp.srq = init_attr->srq;
+
+	my_qp->ib_qp.qp_context = init_attr->qp_context;
+	my_qp->ib_qp.event_handler = init_attr->event_handler;
+
+	init_attr->cap.max_inline_data = 0; /* not supported? */
+	init_attr->cap.max_recv_sge = act_nr_receive_sges;
+	init_attr->cap.max_recv_wr = act_nr_receive_wqes;
+	init_attr->cap.max_send_sge = act_nr_send_sges;
+	init_attr->cap.max_send_wr = act_nr_send_wqes;
+
+	/* TODO : define_apq0() not supported yet */
+	if (init_attr->qp_type == IB_QPT_GSI) {
+		if ((hipz_rc = ehca_define_sqp(shca, my_qp, init_attr))) {
+			EDEB_ERR(4,  "ehca_define_sqp() failed rc=%lx", hipz_rc);
+			ret = ehca2ib_return_code(hipz_rc);
+			goto create_qp_exit3;
+		}
+	}
+
+	if (init_attr->send_cq != NULL) {
+		struct ehca_cq *cq = container_of(init_attr->send_cq,
+						  struct ehca_cq, ib_cq);
+		ret = ehca_cq_assign_qp(cq, my_qp);
+		if (ret != 0) {
+			EDEB_ERR(4, "Couldn't assign qp to send_cq ret=%x", ret);
+			goto create_qp_exit3;
+		}
+		my_qp->send_cq = cq;
+	}
+
+	/* copy queues, galpa data to user space */
+	if (context != NULL && udata != NULL) {
+		struct ehca_create_qp_resp resp;
+		struct vm_area_struct * vma;
+		resp.qp_num = qp_nr;
+		resp.token = my_qp->token;
+		resp.ehca_qp_core = my_qp->ehca_qp_core;
+
+		ehca_mmap_nopage(((u64) (my_qp->token) << 32) | 0x22000000,
+				 my_qp->ehca_qp_core.ipz_rqueue.queue_length,
+				 ((void**)&resp.ehca_qp_core.ipz_rqueue.queue),
+				 &vma);
+		my_qp->uspace_rqueue = (u64)resp.ehca_qp_core.ipz_rqueue.queue;
+		ehca_mmap_nopage(((u64) (my_qp->token) << 32) | 0x23000000,
+				 my_qp->ehca_qp_core.ipz_squeue.queue_length,
+				 ((void**)&resp.ehca_qp_core.ipz_squeue.queue),
+				 &vma);
+		my_qp->uspace_squeue = (u64)resp.ehca_qp_core.ipz_squeue.queue;
+		ehca_mmap_register(my_qp->ehca_qp_core.galpas.user.fw_handle,
+				   ((void**)&resp.ehca_qp_core.galpas.kernel.fw_handle),
+				   &vma);
+		my_qp->uspace_fwh = (u64)resp.ehca_qp_core.galpas.kernel.fw_handle;
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
+	return (&my_qp->ib_qp);
+
+ create_qp_exit3:
+	ipz_queue_dtor(&my_qp->ehca_qp_core.ipz_rqueue);
+	ipz_queue_dtor(&my_qp->ehca_qp_core.ipz_squeue);
+
+ create_qp_exit2:
+	hipz_h_destroy_qp(shca->ipz_hca_handle, my_qp);
+
+ create_qp_exit1:
+	down_write(&ehca_qp_idr_sem);
+	idr_remove(&ehca_qp_idr, my_qp->token);
+	up_write(&ehca_qp_idr_sem);
+
+ create_qp_exit0:
+	ehca_qp_delete(my_qp);
+	EDEB_EX(4, "failed ret=%x", ret);
+	return ERR_PTR(ret);
+
+}
+
+/** called by internal_modify_qp() at trans sqe -> rts:
+ * set purge bit of bad wqe and subsequent wqes to avoid reentering sqe
+ * @return total number of bad wqes in bad_wqe_cnt
+ */
+static int prepare_sqe_rts(struct ehca_qp *my_qp, struct ehca_shca *shca,
+			   int *bad_wqe_cnt)
+{
+	int ret = 0;
+	u64 hipz_rc = H_Success;
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
+	hipz_rc = hipz_h_disable_and_get_wqe(shca->ipz_hca_handle,
+					     my_qp->ipz_qp_handle, &my_qp->pf,
+					     &bad_send_wqe_p, NULL, 2);
+	if (hipz_rc != H_Success) {
+		EDEB_ERR(4, "hipz_h_disable_and_get_wqe() failed "
+			 "ehca_qp=%p qp_num=%x hipz_rc=%lx",
+			 my_qp, qp_num, hipz_rc);
+		ret = ehca2ib_return_code(hipz_rc);
+		goto prepare_sqe_rts_exit1;
+	}
+	bad_send_wqe_p = (void*)((u64)bad_send_wqe_p & (~(1L<<63)));
+	EDEB(7, "qp_num=%x bad_send_wqe_p=%p", qp_num, bad_send_wqe_p);
+	/* convert wqe pointer to vadr */
+	bad_send_wqe_v = abs_to_virt((u64)bad_send_wqe_p);
+	EDEB_DMP(6, bad_send_wqe_v, 32, "qp_num=%x bad_wqe", qp_num);
+
+	squeue = &my_qp->ehca_qp_core.ipz_squeue;
+	squeue_start_p = (void*)ehca_kv_to_g(squeue->queue);
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
+	} /* eof while wqe */
+	/* bad wqe will be reprocessed and ignored when pol_cq() is called,
+	   i.e. nr of wqes with flush error status is one less */
+	EDEB(6, "qp_num=%x flusherr_wqe_cnt=%x", qp_num, (*bad_wqe_cnt)-1);
+	wqe->wqef = 0;
+
+ prepare_sqe_rts_exit1:
+
+	EDEB_EX(7, "ehca_qp=%p qp_num=%x ret=%x", my_qp, qp_num, ret);
+	return ret;
+}
+
+/** @brief internal modify qp with circumvention to handle aqp0 properly
+ * smi_reset2init indicates if this is an internal reset-to-init-call for
+ * smi. This flag must always be zero if called from ehca_modify_qp()!
+ * This internal func was intorduced to avoid recursion of ehca_modify_qp()!
+ */
+static int internal_modify_qp(struct ib_qp *ibqp,
+			      struct ib_qp_attr *attr,
+			      int attr_mask, int smi_reset2init)
+{
+	enum ib_qp_state qp_cur_state = 0, qp_new_state = 0;
+	int cnt = 0, qp_attr_idx = 0, retcode = 0;
+
+	enum ib_qp_statetrans statetrans;
+	struct hcp_modify_qp_control_block *mqpcb = NULL;
+	struct ehca_qp *my_qp = NULL;
+	struct ehca_shca *shca = NULL;
+	u64 update_mask = 0;
+	u64 hipz_rc = H_Success;
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
+	mqpcb = kmalloc(PAGE_SIZE, GFP_KERNEL);
+	if (mqpcb == NULL) {
+		retcode = -ENOMEM;
+		EDEB_ERR(4, "Could not get zeroed page for mqpcb "
+			 "ehca_qp=%p qp_num=%x ", my_qp, ibqp->qp_num);
+		goto modify_qp_exit0;
+	}
+	memset(mqpcb, 0, PAGE_SIZE);
+
+	hipz_rc = hipz_h_query_qp(shca->ipz_hca_handle,
+				  my_qp->ipz_qp_handle,
+				  &my_qp->pf,
+				  mqpcb, my_qp->ehca_qp_core.galpas.kernel);
+	if (hipz_rc != H_Success) {
+		EDEB_ERR(4, "hipz_h_query_qp() failed "
+			 "ehca_qp=%p qp_num=%x hipz_rc=%lx",
+			 my_qp, ibqp->qp_num, hipz_rc);
+		retcode = ehca2ib_return_code(hipz_rc);
+		goto modify_qp_exit1;
+	}
+	EDEB(7, "ehca_qp=%p qp_num=%x ehca_qp_state=%x",
+	     my_qp, ibqp->qp_num, mqpcb->qp_state);
+
+	qp_cur_state = ehca2ib_qp_state(mqpcb->qp_state);
+
+	if (qp_cur_state == -EINVAL) {	/* invalid qp state */
+		retcode = -EINVAL;
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
+	    (attr_mask & IB_QP_STATE)
+	    && attr->qp_state == IB_QPS_INIT) { /* RESET -> INIT */
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
+		if (smirc != 0) {
+			EDEB_ERR(4, "SMI RESET -> INIT failed. "
+				 "ehca_modify_qp() rc=%x", smirc);
+			retcode = H_Parameter;
+			goto modify_qp_exit1;
+		}
+		qp_cur_state = IB_QPS_INIT;
+		EDEB(7, "SMI RESET -> INIT succeeded");
+	}
+	/* is transmitted current state  equal to "real" current state */
+	if (attr_mask & IB_QP_CUR_STATE) {
+		if (qp_cur_state != attr->cur_qp_state) {
+			retcode = -EINVAL;
+			EDEB_ERR(4, "Invalid IB_QP_CUR_STATE "
+				 "attr->curr_qp_state=%x <> "
+				 "actual cur_qp_state=%x. "
+				 "ehca_qp=%p qp_num=%x",
+				 attr->cur_qp_state, qp_cur_state,
+				 my_qp, ibqp->qp_num);
+			goto modify_qp_exit1;
+		}
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
+		retcode = -EINVAL;
+		EDEB_ERR(4, "Invalid qp transition new_state=%x cur_state=%x "
+			 "ehca_qp=%p qp_num=%x attr_mask=%x",
+			 qp_new_state, qp_cur_state, my_qp, ibqp->qp_num, 
+			 attr_mask);
+		goto modify_qp_exit1;
+	}
+
+	if ((mqpcb->qp_state = ib2ehca_qp_state(qp_new_state))) {
+		update_mask = EHCA_BMASK_SET(MQPCB_MASK_QP_STATE, 1);
+	} else {
+		retcode = -EINVAL;
+		EDEB_ERR(4, "Invalid new qp state=%x "
+			 "ehca_qp=%p qp_num=%x",
+			 qp_new_state, my_qp, ibqp->qp_num);
+		goto modify_qp_exit1;
+	}
+
+	/* retrieve state transition struct to get req and opt attrs */
+	statetrans = get_modqp_statetrans(qp_cur_state, qp_new_state);
+	if (statetrans < 0) {
+		retcode = -EINVAL;
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
+		retcode = qp_attr_idx;
+		EDEB_ERR(4, "Invalid QP type=%x ehca_qp=%p qp_num=%x",
+			 ibqp->qp_type, my_qp, ibqp->qp_num);
+		goto modify_qp_exit1;
+	}
+
+	EDEB(7, "ehca_qp=%p qp_num=%x <VALID STATE CHANGE> qp_state_xsit=%x",
+	     my_qp, ibqp->qp_num, statetrans);
+
+	/* sqe -> rts: set purge bit of bad wqe before actual trans */
+	if ((my_qp->ehca_qp_core.qp_type == IB_QPT_UD
+	     || my_qp->ehca_qp_core.qp_type == IB_QPT_GSI
+	     || my_qp->ehca_qp_core.qp_type == IB_QPT_SMI)
+	    && statetrans == IB_QPST_SQE2RTS) {
+		/* mark next free wqe if kernel */
+		if (my_qp->uspace_squeue == 0) {
+			struct ehca_wqe *wqe = NULL;
+			/* lock send queue */
+			spin_lock_irqsave(&my_qp->spinlock_s, spl_flags);
+			squeue_locked = 1;
+			/* mark next free wqe */
+			wqe=(struct ehca_wqe*)
+				my_qp->ehca_qp_core.ipz_squeue.current_q_addr;
+			wqe->optype = wqe->wqef = 0xff;
+			EDEB(7, "qp_num=%x next_free_wqe=%p",
+			     ibqp->qp_num, wqe);
+		}
+		retcode = prepare_sqe_rts(my_qp, shca, &bad_wqe_cnt);
+		if (retcode != 0) {
+			EDEB_ERR(4, "prepare_sqe_rts() failed "
+				 "ehca_qp=%p qp_num=%x ret=%x",
+				 my_qp, ibqp->qp_num, retcode);
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
+	/* circ. pHyp requires #RDMA/Atomic Responder Resources for UC INIT -> RTR */
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
+			retcode = -EINVAL;
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
+		mqpcb->dlid = attr->ah_attr.dlid;
+		update_mask |= EHCA_BMASK_SET(MQPCB_MASK_DLID, 1);
+		mqpcb->source_path_bits = attr->ah_attr.src_path_bits;
+		update_mask |= EHCA_BMASK_SET(MQPCB_MASK_SOURCE_PATH_BITS, 1);
+		mqpcb->service_level = attr->ah_attr.sl;
+		update_mask |= EHCA_BMASK_SET(MQPCB_MASK_SERVICE_LEVEL, 1);
+		mqpcb->max_static_rate = attr->ah_attr.static_rate;
+		update_mask |= EHCA_BMASK_SET(MQPCB_MASK_MAX_STATIC_RATE, 1);
+
+		/* only if GRH is TRUE we might consider SOURCE_GID_IDX and DEST_GID
+		 * otherwise phype will return H_ATTR_PARM!!!
+		 */
+		if (attr->ah_attr.ah_flags == IB_AH_GRH) {
+			mqpcb->send_grh_flag = 1 << 31;
+			update_mask |=
+				EHCA_BMASK_SET(MQPCB_MASK_SEND_GRH_FLAG, 1);
+			mqpcb->source_gid_idx = attr->ah_attr.grh.sgid_index;
+			update_mask |=
+				EHCA_BMASK_SET(MQPCB_MASK_SOURCE_GID_IDX, 1);
+
+			for (cnt = 0; cnt < 16; cnt++) {
+				mqpcb->dest_gid.byte[cnt] =
+					attr->ah_attr.grh.dgid.raw[cnt];
+			}
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
+	        /*  @TODO CHECK THIS with our spec */
+		mqpcb->rdma_nr_atomic_resp_res = attr->max_dest_rd_atomic;
+		update_mask |=
+			EHCA_BMASK_SET(MQPCB_MASK_RDMA_NR_ATOMIC_RESP_RES, 1);
+		EDEB(7, "ehca_qp=%p qp_num=%x IB_QP_MAX_DEST_RD_ATOMIC "
+		     "update_mask=%lx", my_qp, ibqp->qp_num, update_mask);
+	}
+	if (attr_mask & IB_QP_MAX_QP_RD_ATOMIC) {
+	        /*  @TODO CHECK THIS with our spec */
+		mqpcb->rdma_atomic_outst_dest_qp = attr->max_rd_atomic;
+		update_mask |=
+			EHCA_BMASK_SET
+			(MQPCB_MASK_RDMA_ATOMIC_OUTST_DEST_QP, 1);
+		EDEB(7, "ehca_qp=%p qp_num=%x IB_QP_MAX_QP_RD_ATOMIC "
+		     "update_mask=%lx", my_qp, ibqp->qp_num, update_mask);
+	}
+	if (attr_mask & IB_QP_ALT_PATH) {
+		mqpcb->dlid_al = attr->alt_ah_attr.dlid;
+		update_mask |= EHCA_BMASK_SET(MQPCB_MASK_DLID_AL, 1);
+		mqpcb->source_path_bits_al = attr->alt_ah_attr.src_path_bits;
+		update_mask |=
+			EHCA_BMASK_SET(MQPCB_MASK_SOURCE_PATH_BITS_AL, 1);
+		mqpcb->service_level_al = attr->alt_ah_attr.sl;
+		update_mask |= EHCA_BMASK_SET(MQPCB_MASK_SERVICE_LEVEL_AL, 1);
+		mqpcb->max_static_rate_al = attr->alt_ah_attr.static_rate;
+		update_mask |= EHCA_BMASK_SET(MQPCB_MASK_MAX_STATIC_RATE_AL, 1);
+
+		/* only if GRH is TRUE we might consider SOURCE_GID_IDX and DEST_GID
+		 * otherwise phype will return H_ATTR_PARM!!!
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
+			for (cnt = 0; cnt < 16; cnt++) {
+				mqpcb->dest_gid_al.byte[cnt] =
+					attr->alt_ah_attr.grh.dgid.raw[cnt];
+			}
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
+		EDEB(7, "ehca_qp=%p qp_num=%x "
+		     "IB_QP_ALT_PATH update_mask=%lx",
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
+		/* TODO no support for max_send/recv_sge??? */
+	}
+
+	EDEB_DMP(7, mqpcb, 4*70, "ehca_qp=%p qp_num=%x", my_qp, ibqp->qp_num);
+
+	hipz_rc = hipz_h_modify_qp(shca->ipz_hca_handle,
+				   my_qp->ipz_qp_handle,
+				   &my_qp->pf,
+				   update_mask,
+				   mqpcb, my_qp->ehca_qp_core.galpas.kernel);
+
+	if (hipz_rc != H_Success) {
+		retcode = ehca2ib_return_code(hipz_rc);
+		EDEB_ERR(4, "hipz_h_modify_qp() failed rc=%lx "
+			 "ehca_qp=%p qp_num=%x",
+			 hipz_rc, my_qp, ibqp->qp_num);
+		goto modify_qp_exit2;
+	}
+
+	if ((my_qp->ehca_qp_core.qp_type == IB_QPT_UD
+	     || my_qp->ehca_qp_core.qp_type == IB_QPT_GSI
+	     || my_qp->ehca_qp_core.qp_type == IB_QPT_SMI)
+	    && statetrans == IB_QPST_SQE2RTS) {
+		/* doorbell to reprocessing wqes */
+		iosync(); /* serialize GAL register access */
+		hipz_update_SQA(&my_qp->ehca_qp_core, bad_wqe_cnt-1);
+		EDEB(6, "doorbell for %x wqes", bad_wqe_cnt);
+	}
+
+	if (statetrans == IB_QPST_RESET2INIT ||
+	    statetrans == IB_QPST_INIT2INIT) {
+		mqpcb->qp_enable = TRUE;
+		mqpcb->qp_state = EHCA_QPS_INIT;
+		update_mask = 0;
+		update_mask = EHCA_BMASK_SET(MQPCB_MASK_QP_ENABLE, 1);
+
+		EDEB(7, "ehca_qp=%p qp_num=%x "
+		     "RESET_2_INIT needs an additional enable "
+		     "-> update_mask=%lx", my_qp, ibqp->qp_num, update_mask);
+
+		hipz_rc = hipz_h_modify_qp(shca->ipz_hca_handle,
+					   my_qp->ipz_qp_handle,
+					   &my_qp->pf,
+					   update_mask,
+					   mqpcb,
+					   my_qp->ehca_qp_core.galpas.kernel);
+
+		if (hipz_rc != H_Success) {
+			retcode = ehca2ib_return_code(hipz_rc);
+			EDEB_ERR(4, "ENABLE in context of "
+				 "RESET_2_INIT failed! "
+				 "Maybe you didn't get a LID"
+				 "hipz_rc=%lx ehca_qp=%p qp_num=%x",
+				 hipz_rc, my_qp, ibqp->qp_num);
+			goto modify_qp_exit2;
+		}
+	}
+
+	if (statetrans == IB_QPST_ANY2RESET) {
+		ipz_QEit_reset(&my_qp->ehca_qp_core.ipz_rqueue);
+		ipz_QEit_reset(&my_qp->ehca_qp_core.ipz_squeue);
+	}
+
+	if (attr_mask & IB_QP_QKEY) {
+		my_qp->ehca_qp_core.qkey = attr->qkey;
+	}
+
+ modify_qp_exit2:
+	if (squeue_locked) { /* this means: sqe -> rts */
+		spin_unlock_irqrestore(&my_qp->spinlock_s, spl_flags);
+		my_qp->sqerr_purgeflag = 1;
+	}
+
+ modify_qp_exit1:
+	kfree(mqpcb);
+
+ modify_qp_exit0:
+	EDEB_EX(7, "ehca_qp=%p qp_num=%x ibqp_type=%x retcode=%x",
+		my_qp, ibqp->qp_num, ibqp->qp_type, retcode);
+	return retcode;
+}
+
+int ehca_modify_qp(struct ib_qp *ibqp, struct ib_qp_attr *attr, int attr_mask)
+{
+	int ret = 0;
+	struct ehca_qp *my_qp = NULL;
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
+	ret = internal_modify_qp(ibqp, attr, attr_mask, 0);
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
+
+	struct ipz_adapter_handle adapter_handle;
+	int cnt = 0, retcode = 0;
+	u64 hipz_rc = H_Success;
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
+	shca = container_of(qp->device, struct ehca_shca, ib_device);
+	adapter_handle = shca->ipz_hca_handle;
+
+	if (qp_attr_mask & QP_ATTR_QUERY_NOT_SUPPORTED) {
+		retcode = -EINVAL;
+		EDEB_ERR(4,"Invalid attribute mask "
+			 "ehca_qp=%p qp_num=%x qp_attr_mask=%x ",
+			 my_qp, qp->qp_num, qp_attr_mask);
+		goto query_qp_exit0;
+	}
+
+	qpcb = kmalloc(EHCA_PAGESIZE, GFP_KERNEL );
+
+	if (qpcb == NULL) {
+		retcode = -ENOMEM;
+		EDEB_ERR(4,"Out of memory for qpcb "
+			 "ehca_qp=%p qp_num=%x", my_qp, qp->qp_num);
+		goto query_qp_exit0;
+	}
+	memset(qpcb, 0, sizeof(*qpcb));
+
+	hipz_rc = hipz_h_query_qp(adapter_handle,
+				  my_qp->ipz_qp_handle,
+				  &my_qp->pf,
+				  qpcb, my_qp->ehca_qp_core.galpas.kernel);
+
+	if (hipz_rc != H_Success) {
+		retcode = ehca2ib_return_code(hipz_rc);
+		EDEB_ERR(4,"hipz_h_query_qp() failed "
+			 "ehca_qp=%p qp_num=%x hipz_rc=%lx",
+			 my_qp, qp->qp_num, hipz_rc);
+		goto query_qp_exit1;
+	}
+
+	qp_attr->cur_qp_state = ehca2ib_qp_state(qpcb->qp_state);
+	qp_attr->qp_state = qp_attr->cur_qp_state;
+	if (qp_attr->cur_qp_state == -EINVAL) {
+		retcode = -EINVAL;
+		EDEB_ERR(4,"Got invalid ehca_qp_state=%x "
+			 "ehca_qp=%p qp_num=%x",
+			 qpcb->qp_state, my_qp, qp->qp_num);
+		goto query_qp_exit1;
+	}
+
+	if (qp_attr->qp_state == IB_QPS_SQD) {
+		qp_attr->sq_draining = TRUE;
+	}
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
+	if (my_qp->ehca_qp_core.qp_type == IB_QPT_UD) {
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
+	for (cnt = 0; cnt < 16; cnt++) {
+		qp_attr->ah_attr.grh.dgid.raw[cnt] =
+			qpcb->dest_gid.byte[cnt];
+	}
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
+	for (cnt = 0; cnt < 16; cnt++) {
+		qp_attr->alt_ah_attr.grh.dgid.raw[cnt] =
+			qpcb->dest_gid_al.byte[cnt];
+	}
+
+	/* return init attributes given in ehca_create_qp */
+	if (qp_init_attr != NULL) {
+		*qp_init_attr = my_qp->init_attr;
+	}
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
+ query_qp_exit1:
+	kfree(qpcb);
+
+ query_qp_exit0:
+	EDEB_EX(7, "ehca_qp=%p qp_num=%x retcode=%x",
+		my_qp, qp->qp_num, retcode);
+	return retcode;
+}
+
+int ehca_destroy_qp(struct ib_qp *ibqp)
+{
+	struct ehca_qp *my_qp = NULL;
+	struct ehca_shca *shca = NULL;
+	struct ehca_pfqp *qp_pf = NULL;
+	u32 qp_num = 0;
+	int retcode = 0;
+	u64 hipz_ret = H_Success;
+	u8 port_num = 0;
+	enum ib_qp_type	qp_type;
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
+	if (my_qp->send_cq != NULL) {
+		retcode = ehca_cq_unassign_qp(my_qp->send_cq,
+					      my_qp->ehca_qp_core.real_qp_num);
+		if (retcode != 0) {
+			EDEB_ERR(4, "Couldn't unassign qp from send_cq "
+				 "ret=%x qp_num=%x cq_num=%x",
+				 retcode, my_qp->ib_qp.qp_num,
+				 my_qp->send_cq->cq_number);
+			goto destroy_qp_exit0;
+		}
+	}
+
+	down_write(&ehca_qp_idr_sem);
+	idr_remove(&ehca_qp_idr, my_qp->token);
+	up_write(&ehca_qp_idr_sem);
+
+	/* un-mmap if vma alloc */
+	if (my_qp->uspace_rqueue != 0) {
+		struct ehca_qp_core *qp_core = &my_qp->ehca_qp_core;
+		retcode = ehca_munmap(my_qp->uspace_rqueue,
+				      qp_core->ipz_rqueue.queue_length);
+		retcode = ehca_munmap(my_qp->uspace_squeue,
+				      qp_core->ipz_squeue.queue_length);
+		retcode = ehca_munmap(my_qp->uspace_fwh, 4096);
+	}
+
+	hipz_ret = hipz_h_destroy_qp(shca->ipz_hca_handle, my_qp);
+	if (hipz_ret != H_Success) {
+		EDEB_ERR(4, "hipz_h_destroy_qp() failed "
+			 "rc=%lx ehca_qp=%p qp_num=%x",
+			 hipz_ret, qp_pf, qp_num);
+		goto destroy_qp_exit0;
+	}
+
+	port_num = my_qp->init_attr.port_num;
+	qp_type  = my_qp->init_attr.qp_type;
+
+	/* TODO: later with IB_QPT_SMI */
+	if (qp_type == IB_QPT_GSI) {
+		struct ib_event event;
+
+		EDEB(4, "EHCA port %x is inactive.", port_num);
+		event.device = &shca->ib_device;
+		event.event = IB_EVENT_PORT_ERR;
+		event.element.port_num = port_num;
+		shca->sport[port_num - 1].port_state = IB_PORT_DOWN;
+		ib_dispatch_event(&event);
+	}
+
+	ipz_queue_dtor(&my_qp->ehca_qp_core.ipz_rqueue);
+	ipz_queue_dtor(&my_qp->ehca_qp_core.ipz_squeue);
+	ehca_qp_delete(my_qp);
+
+ destroy_qp_exit0:
+	retcode = ehca2ib_return_code(hipz_ret);
+	EDEB_EX(7,"ret=%x", retcode);
+	return retcode;
+}
+
+/* eof ehca_qp.c */
