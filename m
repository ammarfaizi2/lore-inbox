Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932387AbWI2Vhz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932387AbWI2Vhz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 17:37:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932386AbWI2Vhz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 17:37:55 -0400
Received: from mx.pathscale.com ([64.160.42.68]:58588 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S932385AbWI2Vhy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 17:37:54 -0400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH] IB/ipath - fix RDMA reads
X-Mercurial-Node: 7b2b5b33a24891601ac168fec6887c20e2edff48
Message-Id: <7b2b5b33a24891601ac1.1159565871@eng-12.pathscale.com>
Date: Fri, 29 Sep 2006 14:37:51 -0700
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: rdreier@cisco.com
Cc: openib-general@openib.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The PSN used to generate the request following a RDMA read was incorrect
and some state booking wasn't maintained correctly.
This patch fixes that.

Signed-off-by: Ralph Campbell <ralph.campbell@qlogic.com>
Signed-off-by: Bryan O'Sullivan <bryan.osullivan@qlogic.com>

diff -r ac3953427dbf -r 7b2b5b33a248 drivers/infiniband/hw/ipath/ipath_rc.c
--- a/drivers/infiniband/hw/ipath/ipath_rc.c	Fri Sep 29 14:20:17 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_rc.c	Fri Sep 29 14:20:40 2006 -0700
@@ -241,10 +241,7 @@ int ipath_make_rc_req(struct ipath_qp *q
 		 * original work request since we may need to resend
 		 * it.
 		 */
-		qp->s_sge.sge = wqe->sg_list[0];
-		qp->s_sge.sg_list = wqe->sg_list + 1;
-		qp->s_sge.num_sge = wqe->wr.num_sge;
-		qp->s_len = len = wqe->length;
+		len = wqe->length;
 		ss = &qp->s_sge;
 		bth2 = 0;
 		switch (wqe->wr.opcode) {
@@ -368,14 +365,23 @@ int ipath_make_rc_req(struct ipath_qp *q
 		default:
 			goto done;
 		}
+		qp->s_sge.sge = wqe->sg_list[0];
+		qp->s_sge.sg_list = wqe->sg_list + 1;
+		qp->s_sge.num_sge = wqe->wr.num_sge;
+		qp->s_len = wqe->length;
 		if (newreq) {
 			qp->s_tail++;
 			if (qp->s_tail >= qp->s_size)
 				qp->s_tail = 0;
 		}
-		bth2 |= qp->s_psn++ & IPATH_PSN_MASK;
-		if ((int)(qp->s_psn - qp->s_next_psn) > 0)
-			qp->s_next_psn = qp->s_psn;
+		bth2 |= qp->s_psn & IPATH_PSN_MASK;
+		if (wqe->wr.opcode == IB_WR_RDMA_READ)
+			qp->s_psn = wqe->lpsn + 1;
+		else {
+			qp->s_psn++;
+			if ((int)(qp->s_psn - qp->s_next_psn) > 0)
+				qp->s_next_psn = qp->s_psn;
+		}
 		/*
 		 * Put the QP on the pending list so lost ACKs will cause
 		 * a retry.  More than one request can be pending so the
@@ -690,13 +696,6 @@ void ipath_restart_rc(struct ipath_qp *q
 	struct ipath_swqe *wqe = get_swqe_ptr(qp, qp->s_last);
 	struct ipath_ibdev *dev;
 
-	/*
-	 * If there are no requests pending, we are done.
-	 */
-	if (ipath_cmp24(psn, qp->s_next_psn) >= 0 ||
-	    qp->s_last == qp->s_tail)
-		goto done;
-
 	if (qp->s_retry == 0) {
 		wc->wr_id = wqe->wr.wr_id;
 		wc->status = IB_WC_RETRY_EXC_ERR;
@@ -731,8 +730,6 @@ void ipath_restart_rc(struct ipath_qp *q
 		dev->n_rc_resends += (int)qp->s_psn - (int)psn;
 
 	reset_psn(qp, psn);
-
-done:
 	tasklet_hi_schedule(&qp->s_task);
 
 bail:
@@ -765,6 +762,7 @@ static int do_rc_ack(struct ipath_qp *qp
 	struct ib_wc wc;
 	struct ipath_swqe *wqe;
 	int ret = 0;
+	u32 ack_psn;
 
 	/*
 	 * Remove the QP from the timeout queue (or RNR timeout queue).
@@ -777,26 +775,26 @@ static int do_rc_ack(struct ipath_qp *qp
 		list_del_init(&qp->timerwait);
 	spin_unlock(&dev->pending_lock);
 
+	/* Nothing is pending to ACK/NAK. */
+	if (unlikely(qp->s_last == qp->s_tail))
+		goto bail;
+
 	/*
 	 * Note that NAKs implicitly ACK outstanding SEND and RDMA write
 	 * requests and implicitly NAK RDMA read and atomic requests issued
 	 * before the NAK'ed request.  The MSN won't include the NAK'ed
 	 * request but will include an ACK'ed request(s).
 	 */
+	ack_psn = psn;
+	if (aeth >> 29)
+		ack_psn--;
 	wqe = get_swqe_ptr(qp, qp->s_last);
-
-	/* Nothing is pending to ACK/NAK. */
-	if (qp->s_last == qp->s_tail)
-		goto bail;
 
 	/*
 	 * The MSN might be for a later WQE than the PSN indicates so
 	 * only complete WQEs that the PSN finishes.
 	 */
-	while (ipath_cmp24(psn, wqe->lpsn) >= 0) {
-		/* If we are ACKing a WQE, the MSN should be >= the SSN. */
-		if (ipath_cmp24(aeth, wqe->ssn) < 0)
-			break;
+	while (ipath_cmp24(ack_psn, wqe->lpsn) >= 0) {
 		/*
 		 * If this request is a RDMA read or atomic, and the ACK is
 		 * for a later operation, this ACK NAKs the RDMA read or
@@ -807,7 +805,8 @@ static int do_rc_ack(struct ipath_qp *qp
 		 * is sent but before the response is received.
 		 */
 		if ((wqe->wr.opcode == IB_WR_RDMA_READ &&
-		     opcode != OP(RDMA_READ_RESPONSE_LAST)) ||
+		     (opcode != OP(RDMA_READ_RESPONSE_LAST) ||
+		       ipath_cmp24(ack_psn, wqe->lpsn) != 0)) ||
 		    ((wqe->wr.opcode == IB_WR_ATOMIC_CMP_AND_SWP ||
 		      wqe->wr.opcode == IB_WR_ATOMIC_FETCH_AND_ADD) &&
 		     (opcode != OP(ATOMIC_ACKNOWLEDGE) ||
@@ -825,6 +824,10 @@ static int do_rc_ack(struct ipath_qp *qp
 			 */
 			goto bail;
 		}
+		if (wqe->wr.opcode == IB_WR_RDMA_READ ||
+		    wqe->wr.opcode == IB_WR_ATOMIC_CMP_AND_SWP ||
+		    wqe->wr.opcode == IB_WR_ATOMIC_FETCH_AND_ADD)
+			tasklet_hi_schedule(&qp->s_task);
 		/* Post a send completion queue entry if requested. */
 		if (!test_bit(IPATH_S_SIGNAL_REQ_WR, &qp->s_flags) ||
 		    (wqe->wr.send_flags & IB_SEND_SIGNALED)) {
@@ -1055,7 +1058,8 @@ static inline void ipath_rc_rcv_resp(str
 		/* no AETH, no ACK */
 		if (unlikely(ipath_cmp24(psn, qp->s_last_psn + 1))) {
 			dev->n_rdma_seq++;
-			ipath_restart_rc(qp, qp->s_last_psn + 1, &wc);
+			if (qp->s_last != qp->s_tail)
+				ipath_restart_rc(qp, qp->s_last_psn + 1, &wc);
 			goto ack_done;
 		}
 	rdma_read:
@@ -1091,7 +1095,8 @@ static inline void ipath_rc_rcv_resp(str
 		/* ACKs READ req. */
 		if (unlikely(ipath_cmp24(psn, qp->s_last_psn + 1))) {
 			dev->n_rdma_seq++;
-			ipath_restart_rc(qp, qp->s_last_psn + 1, &wc);
+			if (qp->s_last != qp->s_tail)
+				ipath_restart_rc(qp, qp->s_last_psn + 1, &wc);
 			goto ack_done;
 		}
 		/* FALLTHROUGH */
