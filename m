Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932508AbWI1QC0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932508AbWI1QC0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 12:02:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932505AbWI1QC0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 12:02:26 -0400
Received: from mx.pathscale.com ([64.160.42.68]:3254 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S1751928AbWI1QBY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 12:01:24 -0400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 18 of 28] IB/ipath - flush RWQEs if access error or invalid
	error seen
X-Mercurial-Node: de99d6fb2d1db47c1048fdbe7a346ef3e060adc5
Message-Id: <de99d6fb2d1db47c1048.1159459214@eng-12.pathscale.com>
In-Reply-To: <patchbomb.1159459196@eng-12.pathscale.com>
Date: Thu, 28 Sep 2006 09:00:14 -0700
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: rdreier@cisco.com
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If the receiver goes into the error state, we need to flush the
posted receive WQEs.

Signed-off-by: Bryan O'Sullivan <bryan.osullivan@qlogic.com>

diff -r f6794c8289ab -r de99d6fb2d1d drivers/infiniband/hw/ipath/ipath_qp.c
--- a/drivers/infiniband/hw/ipath/ipath_qp.c	Thu Sep 28 08:57:12 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_qp.c	Thu Sep 28 08:57:12 2006 -0700
@@ -335,6 +335,7 @@ static void ipath_reset_qp(struct ipath_
 	qp->s_ack_state = IB_OPCODE_RC_ACKNOWLEDGE;
 	qp->r_ack_state = IB_OPCODE_RC_ACKNOWLEDGE;
 	qp->r_nak_state = 0;
+	qp->r_wrid_valid = 0;
 	qp->s_rnr_timeout = 0;
 	qp->s_head = 0;
 	qp->s_tail = 0;
@@ -353,12 +354,13 @@ static void ipath_reset_qp(struct ipath_
 /**
  * ipath_error_qp - put a QP into an error state
  * @qp: the QP to put into an error state
+ * @err: the receive completion error to signal if a RWQE is active
  *
  * Flushes both send and receive work queues.
  * QP s_lock should be held and interrupts disabled.
  */
 
-void ipath_error_qp(struct ipath_qp *qp)
+void ipath_error_qp(struct ipath_qp *qp, enum ib_wc_status err)
 {
 	struct ipath_ibdev *dev = to_idev(qp->ibqp.device);
 	struct ib_wc wc;
@@ -374,7 +376,6 @@ void ipath_error_qp(struct ipath_qp *qp)
 		list_del_init(&qp->piowait);
 	spin_unlock(&dev->pending_lock);
 
-	wc.status = IB_WC_WR_FLUSH_ERR;
 	wc.vendor_err = 0;
 	wc.byte_len = 0;
 	wc.imm_data = 0;
@@ -386,6 +387,12 @@ void ipath_error_qp(struct ipath_qp *qp)
 	wc.sl = 0;
 	wc.dlid_path_bits = 0;
 	wc.port_num = 0;
+	if (qp->r_wrid_valid) {
+		qp->r_wrid_valid = 0;
+		wc.status = err;
+		ipath_cq_enter(to_icq(qp->ibqp.send_cq), &wc, 1);
+	}
+	wc.status = IB_WC_WR_FLUSH_ERR;
 
 	while (qp->s_last != qp->s_head) {
 		struct ipath_swqe *wqe = get_swqe_ptr(qp, qp->s_last);
@@ -502,7 +509,7 @@ int ipath_modify_qp(struct ib_qp *ibqp, 
 		break;
 
 	case IB_QPS_ERR:
-		ipath_error_qp(qp);
+		ipath_error_qp(qp, IB_WC_GENERAL_ERR);
 		break;
 
 	default:
diff -r f6794c8289ab -r de99d6fb2d1d drivers/infiniband/hw/ipath/ipath_rc.c
--- a/drivers/infiniband/hw/ipath/ipath_rc.c	Thu Sep 28 08:57:12 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_rc.c	Thu Sep 28 08:57:12 2006 -0700
@@ -1293,6 +1293,14 @@ done:
 	return 1;
 }
 
+static void ipath_rc_error(struct ipath_qp *qp, enum ib_wc_status err)
+{
+	spin_lock_irq(&qp->s_lock);
+	qp->state = IB_QPS_ERR;
+	ipath_error_qp(qp, err);
+	spin_unlock_irq(&qp->s_lock);
+}
+
 /**
  * ipath_rc_rcv - process an incoming RC packet
  * @dev: the device this packet came in on
@@ -1385,8 +1393,7 @@ void ipath_rc_rcv(struct ipath_ibdev *de
 		 */
 		if (qp->r_ack_state >= OP(COMPARE_SWAP))
 			goto send_ack;
-		/* XXX Flush WQEs */
-		qp->state = IB_QPS_ERR;
+		ipath_rc_error(qp, IB_WC_REM_INV_REQ_ERR);
 		qp->r_ack_state = OP(SEND_ONLY);
 		qp->r_nak_state = IB_NAK_INVALID_REQUEST;
 		qp->r_ack_psn = qp->r_psn;
@@ -1492,9 +1499,9 @@ void ipath_rc_rcv(struct ipath_ibdev *de
 			goto nack_inv;
 		ipath_copy_sge(&qp->r_sge, data, tlen);
 		qp->r_msn++;
-		if (opcode == OP(RDMA_WRITE_LAST) ||
-		    opcode == OP(RDMA_WRITE_ONLY))
+		if (!qp->r_wrid_valid)
 			break;
+		qp->r_wrid_valid = 0;
 		wc.wr_id = qp->r_wr_id;
 		wc.status = IB_WC_SUCCESS;
 		wc.opcode = IB_WC_RECV;
@@ -1685,8 +1692,7 @@ nack_acc:
 	 * is pending though.
 	 */
 	if (qp->r_ack_state < OP(COMPARE_SWAP)) {
-		/* XXX Flush WQEs */
-		qp->state = IB_QPS_ERR;
+		ipath_rc_error(qp, IB_WC_REM_ACCESS_ERR);
 		qp->r_ack_state = OP(RDMA_WRITE_ONLY);
 		qp->r_nak_state = IB_NAK_REMOTE_ACCESS_ERROR;
 		qp->r_ack_psn = qp->r_psn;
diff -r f6794c8289ab -r de99d6fb2d1d drivers/infiniband/hw/ipath/ipath_ruc.c
--- a/drivers/infiniband/hw/ipath/ipath_ruc.c	Thu Sep 28 08:57:12 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_ruc.c	Thu Sep 28 08:57:12 2006 -0700
@@ -229,6 +229,7 @@ int ipath_get_rwqe(struct ipath_qp *qp, 
 		}
 	}
 	spin_unlock_irqrestore(&rq->lock, flags);
+	qp->r_wrid_valid = 1;
 
 bail:
 	return ret;
diff -r f6794c8289ab -r de99d6fb2d1d drivers/infiniband/hw/ipath/ipath_verbs.h
--- a/drivers/infiniband/hw/ipath/ipath_verbs.h	Thu Sep 28 08:57:12 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_verbs.h	Thu Sep 28 08:57:12 2006 -0700
@@ -365,6 +365,7 @@ struct ipath_qp {
 	u8 r_min_rnr_timer;	/* retry timeout value for RNR NAKs */
 	u8 r_reuse_sge;		/* for UC receive errors */
 	u8 r_sge_inx;		/* current index into sg_list */
+	u8 r_wrid_valid;	/* r_wrid set but CQ entry not yet made */
 	u8 qp_access_flags;
 	u8 s_max_sge;		/* size of s_wq->sg_list */
 	u8 s_retry_cnt;		/* number of times to retry */
@@ -639,6 +640,8 @@ struct ib_qp *ipath_create_qp(struct ib_
 
 int ipath_destroy_qp(struct ib_qp *ibqp);
 
+void ipath_error_qp(struct ipath_qp *qp, enum ib_wc_status err);
+
 int ipath_modify_qp(struct ib_qp *ibqp, struct ib_qp_attr *attr,
 		    int attr_mask, struct ib_udata *udata);
 
