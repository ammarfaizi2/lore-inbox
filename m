Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751055AbVKRWXM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751055AbVKRWXM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 17:23:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751073AbVKRWXM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 17:23:12 -0500
Received: from ams-iport-1.cisco.com ([144.254.224.140]:43115 "EHLO
	ams-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S1751055AbVKRWXK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 17:23:10 -0500
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: [git pull] IB updates for 2.6.15
X-Message-Flag: Warning: May contain useful information
From: Roland Dreier <rolandd@cisco.com>
Date: Fri, 18 Nov 2005 14:23:04 -0800
Message-ID: <52fypt38af.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.17 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
X-OriginalArrivalTime: 18 Nov 2005 22:23:05.0445 (UTC) FILETIME=[A5675150:01C5EC8E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please pull from

    master.kernel.org:/pub/scm/linux/kernel/git/roland/infiniband.git for-linus

This tree is also available from kernel.org mirrors at:

    git://git.kernel.org/pub/scm/linux/kernel/git/roland/infiniband.git for-linus

The pull will get the following changes:

Michael S. Tsirkin:
      IB/mthca: Safer max_send_sge/max_recv_sge calculation

Roland Dreier:
      [IB] srp: increase max_luns
      [IB] srp: don't post receive if no send buf available
      [IB] mthca: don't disable RDMA writes if no responder resources
      IB/umad: make sure write()s have sufficient data

 drivers/infiniband/core/user_mad.c     |    2 +-
 drivers/infiniband/hw/mthca/mthca_qp.c |   37 ++++++++++++++++----------------
 drivers/infiniband/ulp/srp/ib_srp.c    |   17 ++++++++++-----
 drivers/infiniband/ulp/srp/ib_srp.h    |    1 +
 4 files changed, 31 insertions(+), 26 deletions(-)

diff --git a/drivers/infiniband/core/user_mad.c b/drivers/infiniband/core/user_mad.c
index 5ea741f..e73f81c 100644
--- a/drivers/infiniband/core/user_mad.c
+++ b/drivers/infiniband/core/user_mad.c
@@ -312,7 +312,7 @@ static ssize_t ib_umad_write(struct file
 	int ret, length, hdr_len, copy_offset;
 	int rmpp_active = 0;
 
-	if (count < sizeof (struct ib_user_mad))
+	if (count < sizeof (struct ib_user_mad) + IB_MGMT_RMPP_HDR)
 		return -EINVAL;
 
 	length = count - sizeof (struct ib_user_mad);
diff --git a/drivers/infiniband/hw/mthca/mthca_qp.c b/drivers/infiniband/hw/mthca/mthca_qp.c
index 760c418..dd4e133 100644
--- a/drivers/infiniband/hw/mthca/mthca_qp.c
+++ b/drivers/infiniband/hw/mthca/mthca_qp.c
@@ -730,15 +730,16 @@ int mthca_modify_qp(struct ib_qp *ibqp, 
 	}
 
 	if (attr_mask & IB_QP_ACCESS_FLAGS) {
+		qp_context->params2 |=
+			cpu_to_be32(attr->qp_access_flags & IB_ACCESS_REMOTE_WRITE ?
+				    MTHCA_QP_BIT_RWE : 0);
+
 		/*
-		 * Only enable RDMA/atomics if we have responder
-		 * resources set to a non-zero value.
+		 * Only enable RDMA reads and atomics if we have
+		 * responder resources set to a non-zero value.
 		 */
 		if (qp->resp_depth) {
 			qp_context->params2 |=
-				cpu_to_be32(attr->qp_access_flags & IB_ACCESS_REMOTE_WRITE ?
-					    MTHCA_QP_BIT_RWE : 0);
-			qp_context->params2 |=
 				cpu_to_be32(attr->qp_access_flags & IB_ACCESS_REMOTE_READ ?
 					    MTHCA_QP_BIT_RRE : 0);
 			qp_context->params2 |=
@@ -759,31 +760,27 @@ int mthca_modify_qp(struct ib_qp *ibqp, 
 		if (qp->resp_depth && !attr->max_dest_rd_atomic) {
 			/*
 			 * Lowering our responder resources to zero.
-			 * Turn off RDMA/atomics as responder.
-			 * (RWE/RRE/RAE in params2 already zero)
+			 * Turn off reads RDMA and atomics as responder.
+			 * (RRE/RAE in params2 already zero)
 			 */
-			qp_param->opt_param_mask |= cpu_to_be32(MTHCA_QP_OPTPAR_RWE |
-								MTHCA_QP_OPTPAR_RRE |
+			qp_param->opt_param_mask |= cpu_to_be32(MTHCA_QP_OPTPAR_RRE |
 								MTHCA_QP_OPTPAR_RAE);
 		}
 
 		if (!qp->resp_depth && attr->max_dest_rd_atomic) {
 			/*
 			 * Increasing our responder resources from
-			 * zero.  Turn on RDMA/atomics as appropriate.
+			 * zero.  Turn on RDMA reads and atomics as
+			 * appropriate.
 			 */
 			qp_context->params2 |=
-				cpu_to_be32(qp->atomic_rd_en & IB_ACCESS_REMOTE_WRITE ?
-					    MTHCA_QP_BIT_RWE : 0);
-			qp_context->params2 |=
 				cpu_to_be32(qp->atomic_rd_en & IB_ACCESS_REMOTE_READ ?
 					    MTHCA_QP_BIT_RRE : 0);
 			qp_context->params2 |=
 				cpu_to_be32(qp->atomic_rd_en & IB_ACCESS_REMOTE_ATOMIC ?
 					    MTHCA_QP_BIT_RAE : 0);
 
-			qp_param->opt_param_mask |= cpu_to_be32(MTHCA_QP_OPTPAR_RWE |
-								MTHCA_QP_OPTPAR_RRE |
+			qp_param->opt_param_mask |= cpu_to_be32(MTHCA_QP_OPTPAR_RRE |
 								MTHCA_QP_OPTPAR_RAE);
 		}
 
@@ -921,10 +918,12 @@ static void mthca_adjust_qp_caps(struct 
         else
 		qp->max_inline_data = max_data_size - MTHCA_INLINE_HEADER_SIZE;
 
-	qp->sq.max_gs = max_data_size / sizeof (struct mthca_data_seg);
-	qp->rq.max_gs = (min(dev->limits.max_desc_sz, 1 << qp->rq.wqe_shift) -
-			sizeof (struct mthca_next_seg)) /
-			sizeof (struct mthca_data_seg);
+	qp->sq.max_gs = min_t(int, dev->limits.max_sg,
+			      max_data_size / sizeof (struct mthca_data_seg));
+	qp->rq.max_gs = min_t(int, dev->limits.max_sg,
+			       (min(dev->limits.max_desc_sz, 1 << qp->rq.wqe_shift) -
+				sizeof (struct mthca_next_seg)) /
+			       sizeof (struct mthca_data_seg));
 }
 
 /*
diff --git a/drivers/infiniband/ulp/srp/ib_srp.c b/drivers/infiniband/ulp/srp/ib_srp.c
index 321a3a1..ee9fe22 100644
--- a/drivers/infiniband/ulp/srp/ib_srp.c
+++ b/drivers/infiniband/ulp/srp/ib_srp.c
@@ -802,13 +802,21 @@ static int srp_post_recv(struct srp_targ
 
 /*
  * Must be called with target->scsi_host->host_lock held to protect
- * req_lim and tx_head.
+ * req_lim and tx_head.  Lock cannot be dropped between call here and
+ * call to __srp_post_send().
  */
 static struct srp_iu *__srp_get_tx_iu(struct srp_target_port *target)
 {
 	if (target->tx_head - target->tx_tail >= SRP_SQ_SIZE)
 		return NULL;
 
+	if (unlikely(target->req_lim < 1)) {
+		if (printk_ratelimit())
+			printk(KERN_DEBUG PFX "Target has req_lim %d\n",
+			       target->req_lim);
+		return NULL;
+	}
+
 	return target->tx_ring[target->tx_head & SRP_SQ_SIZE];
 }
 
@@ -823,11 +831,6 @@ static int __srp_post_send(struct srp_ta
 	struct ib_send_wr wr, *bad_wr;
 	int ret = 0;
 
-	if (target->req_lim < 1) {
-		printk(KERN_ERR PFX "Target has req_lim %d\n", target->req_lim);
-		return -EAGAIN;
-	}
-
 	list.addr   = iu->dma;
 	list.length = len;
 	list.lkey   = target->srp_host->mr->lkey;
@@ -1417,6 +1420,8 @@ static ssize_t srp_create_target(struct 
 	if (!target_host)
 		return -ENOMEM;
 
+	target_host->max_lun = SRP_MAX_LUN;
+
 	target = host_to_target(target_host);
 	memset(target, 0, sizeof *target);
 
diff --git a/drivers/infiniband/ulp/srp/ib_srp.h b/drivers/infiniband/ulp/srp/ib_srp.h
index 4fec28a..b564f18 100644
--- a/drivers/infiniband/ulp/srp/ib_srp.h
+++ b/drivers/infiniband/ulp/srp/ib_srp.h
@@ -54,6 +54,7 @@ enum {
 	SRP_PORT_REDIRECT	= 1,
 	SRP_DLID_REDIRECT	= 2,
 
+	SRP_MAX_LUN		= 512,
 	SRP_MAX_IU_LEN		= 256,
 
 	SRP_RQ_SHIFT    	= 6,
