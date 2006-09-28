Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932359AbWI1QBs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932359AbWI1QBs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 12:01:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751933AbWI1QBZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 12:01:25 -0400
Received: from mx.pathscale.com ([64.160.42.68]:56757 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S1751328AbWI1QBW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 12:01:22 -0400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 1 of 28] IB/ipath - limit # of packets sent without an ACK
	received
X-Mercurial-Node: c46292ccb0f54abc77f71247caf4e1c26d5261e2
Message-Id: <c46292ccb0f54abc77f7.1159459197@eng-12.pathscale.com>
In-Reply-To: <patchbomb.1159459196@eng-12.pathscale.com>
Date: Thu, 28 Sep 2006 08:59:57 -0700
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: rdreier@cisco.com
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The sender requests an ACK every 1/2 MB to avoid retransmit timeouts that
were causing MVAPICH mod_bw to fail after a predictable number of sends.

Signed-off-by: Bryan O'Sullivan <bryan.osullivan@qlogic.com>

diff -r f1b431dca1f9 -r c46292ccb0f5 drivers/infiniband/hw/ipath/ipath_qp.c
--- a/drivers/infiniband/hw/ipath/ipath_qp.c	Thu Sep 28 08:57:12 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_qp.c	Thu Sep 28 08:57:12 2006 -0700
@@ -342,6 +342,7 @@ static void ipath_reset_qp(struct ipath_
 	qp->s_last = 0;
 	qp->s_ssn = 1;
 	qp->s_lsn = 0;
+	qp->s_wait_credit = 0;
 	if (qp->r_rq.wq) {
 		qp->r_rq.wq->head = 0;
 		qp->r_rq.wq->tail = 0;
@@ -516,7 +517,7 @@ int ipath_modify_qp(struct ib_qp *ibqp, 
 		qp->remote_qpn = attr->dest_qp_num;
 
 	if (attr_mask & IB_QP_SQ_PSN) {
-		qp->s_next_psn = attr->sq_psn;
+		qp->s_psn = qp->s_next_psn = attr->sq_psn;
 		qp->s_last_psn = qp->s_next_psn - 1;
 	}
 
diff -r f1b431dca1f9 -r c46292ccb0f5 drivers/infiniband/hw/ipath/ipath_rc.c
--- a/drivers/infiniband/hw/ipath/ipath_rc.c	Thu Sep 28 08:57:12 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_rc.c	Thu Sep 28 08:57:12 2006 -0700
@@ -201,6 +201,18 @@ int ipath_make_rc_req(struct ipath_qp *q
 	    qp->s_rnr_timeout)
 		goto done;
 
+	/* Limit the number of packets sent without an ACK. */
+	if (ipath_cmp24(qp->s_psn, qp->s_last_psn + IPATH_PSN_CREDIT) > 0) {
+		qp->s_wait_credit = 1;
+		dev->n_rc_stalls++;
+		spin_lock(&dev->pending_lock);
+		if (list_empty(&qp->timerwait))
+			list_add_tail(&qp->timerwait,
+				      &dev->pending[dev->pending_index]);
+		spin_unlock(&dev->pending_lock);
+		goto done;
+	}
+
 	/* header size in 32-bit words LRH+BTH = (8+12)/4. */
 	hwords = 5;
 	bth0 = 0;
@@ -221,7 +233,7 @@ int ipath_make_rc_req(struct ipath_qp *q
 			/* Check if send work queue is empty. */
 			if (qp->s_tail == qp->s_head)
 				goto done;
-			qp->s_psn = wqe->psn = qp->s_next_psn;
+			wqe->psn = qp->s_next_psn;
 			newreq = 1;
 		}
 		/*
@@ -393,12 +405,6 @@ int ipath_make_rc_req(struct ipath_qp *q
 		ss = &qp->s_sge;
 		len = qp->s_len;
 		if (len > pmtu) {
-			/*
-			 * Request an ACK every 1/2 MB to avoid retransmit
-			 * timeouts.
-			 */
-			if (((wqe->length - len) % (512 * 1024)) == 0)
-				bth2 |= 1 << 31;
 			len = pmtu;
 			break;
 		}
@@ -435,12 +441,6 @@ int ipath_make_rc_req(struct ipath_qp *q
 		ss = &qp->s_sge;
 		len = qp->s_len;
 		if (len > pmtu) {
-			/*
-			 * Request an ACK every 1/2 MB to avoid retransmit
-			 * timeouts.
-			 */
-			if (((wqe->length - len) % (512 * 1024)) == 0)
-				bth2 |= 1 << 31;
 			len = pmtu;
 			break;
 		}
@@ -498,6 +498,8 @@ int ipath_make_rc_req(struct ipath_qp *q
 		 */
 		goto done;
 	}
+	if (ipath_cmp24(qp->s_psn, qp->s_last_psn + IPATH_PSN_CREDIT - 1) >= 0)
+		bth2 |= 1 << 31;	/* Request ACK. */
 	qp->s_len -= len;
 	qp->s_hdrwords = hwords;
 	qp->s_cur_sge = ss;
@@ -737,6 +739,15 @@ bail:
 	return;
 }
 
+static inline void update_last_psn(struct ipath_qp *qp, u32 psn)
+{
+	if (qp->s_wait_credit) {
+		qp->s_wait_credit = 0;
+		tasklet_hi_schedule(&qp->s_task);
+	}
+	qp->s_last_psn = psn;
+}
+
 /**
  * do_rc_ack - process an incoming RC ACK
  * @qp: the QP the ACK came in on
@@ -805,7 +816,7 @@ static int do_rc_ack(struct ipath_qp *qp
 			 * The last valid PSN seen is the previous
 			 * request's.
 			 */
-			qp->s_last_psn = wqe->psn - 1;
+			update_last_psn(qp, wqe->psn - 1);
 			/* Retry this request. */
 			ipath_restart_rc(qp, wqe->psn, &wc);
 			/*
@@ -864,7 +875,7 @@ static int do_rc_ack(struct ipath_qp *qp
 		ipath_get_credit(qp, aeth);
 		qp->s_rnr_retry = qp->s_rnr_retry_cnt;
 		qp->s_retry = qp->s_retry_cnt;
-		qp->s_last_psn = psn;
+		update_last_psn(qp, psn);
 		ret = 1;
 		goto bail;
 
@@ -883,7 +894,7 @@ static int do_rc_ack(struct ipath_qp *qp
 			goto bail;
 
 		/* The last valid PSN is the previous PSN. */
-		qp->s_last_psn = psn - 1;
+		update_last_psn(qp, psn - 1);
 
 		dev->n_rc_resends += (int)qp->s_psn - (int)psn;
 
@@ -898,7 +909,7 @@ static int do_rc_ack(struct ipath_qp *qp
 	case 3:		/* NAK */
 		/* The last valid PSN seen is the previous request's. */
 		if (qp->s_last != qp->s_tail)
-			qp->s_last_psn = wqe->psn - 1;
+			update_last_psn(qp, wqe->psn - 1);
 		switch ((aeth >> IPATH_AETH_CREDIT_SHIFT) &
 			IPATH_AETH_CREDIT_MASK) {
 		case 0:	/* PSN sequence error */
@@ -1071,7 +1082,7 @@ static inline void ipath_rc_rcv_resp(str
 		 * since we don't want s_sge modified.
 		 */
 		qp->s_len -= pmtu;
-		qp->s_last_psn = psn;
+		update_last_psn(qp, psn);
 		spin_unlock_irqrestore(&qp->s_lock, flags);
 		ipath_copy_sge(&qp->s_sge, data, pmtu);
 		goto bail;
diff -r f1b431dca1f9 -r c46292ccb0f5 drivers/infiniband/hw/ipath/ipath_verbs.c
--- a/drivers/infiniband/hw/ipath/ipath_verbs.c	Thu Sep 28 08:57:12 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_verbs.c	Thu Sep 28 08:57:12 2006 -0700
@@ -1683,6 +1683,7 @@ static ssize_t show_stats(struct class_d
 		      "RC OTH NAKs %d\n"
 		      "RC timeouts %d\n"
 		      "RC RDMA dup %d\n"
+		      "RC stalls   %d\n"
 		      "piobuf wait %d\n"
 		      "no piobuf   %d\n"
 		      "PKT drops   %d\n"
@@ -1690,7 +1691,7 @@ static ssize_t show_stats(struct class_d
 		      dev->n_rc_resends, dev->n_rc_qacks, dev->n_rc_acks,
 		      dev->n_seq_naks, dev->n_rdma_seq, dev->n_rnr_naks,
 		      dev->n_other_naks, dev->n_timeouts,
-		      dev->n_rdma_dup_busy, dev->n_piowait,
+		      dev->n_rdma_dup_busy, dev->n_rc_stalls, dev->n_piowait,
 		      dev->n_no_piobuf, dev->n_pkt_drops, dev->n_wqe_errs);
 	for (i = 0; i < ARRAY_SIZE(dev->opstats); i++) {
 		const struct ipath_opcode_stats *si = &dev->opstats[i];
diff -r f1b431dca1f9 -r c46292ccb0f5 drivers/infiniband/hw/ipath/ipath_verbs.h
--- a/drivers/infiniband/hw/ipath/ipath_verbs.h	Thu Sep 28 08:57:12 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_verbs.h	Thu Sep 28 08:57:12 2006 -0700
@@ -370,6 +370,7 @@ struct ipath_qp {
 	u8 s_rnr_retry_cnt;
 	u8 s_retry;		/* requester retry counter */
 	u8 s_rnr_retry;		/* requester RNR retry counter */
+	u8 s_wait_credit;	/* limit number of unacked packets sent */
 	u8 s_pkey_index;	/* PKEY index to use */
 	u8 timeout;		/* Timeout for this QP */
 	enum ib_mtu path_mtu;
@@ -392,6 +393,8 @@ struct ipath_qp {
  */
 #define IPATH_S_BUSY		0
 #define IPATH_S_SIGNAL_REQ_WR	1
+
+#define IPATH_PSN_CREDIT	2048
 
 /*
  * Since struct ipath_swqe is not a fixed size, we can't simply index into
@@ -521,6 +524,7 @@ struct ipath_ibdev {
 	u32 n_rnr_naks;
 	u32 n_other_naks;
 	u32 n_timeouts;
+	u32 n_rc_stalls;
 	u32 n_pkt_drops;
 	u32 n_vl15_dropped;
 	u32 n_wqe_errs;
