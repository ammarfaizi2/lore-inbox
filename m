Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932142AbVKJScj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932142AbVKJScj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 13:32:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932132AbVKJScI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 13:32:08 -0500
Received: from ams-iport-1.cisco.com ([144.254.224.140]:22336 "EHLO
	ams-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S1751057AbVKJScD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 13:32:03 -0500
Subject: [git patch review 6/7] [IB] mthca: fix posting long lists of receive
	work requests
From: Roland Dreier <rolandd@cisco.com>
Date: Thu, 10 Nov 2005 18:31:55 +0000
To: linux-kernel@vger.kernel.org, openib-general@openib.org
X-Mailer: IB-patch-reviewer
Content-Transfer-Encoding: 8bit
Message-ID: <1131647515831-7161f73f404fbe76@cisco.com>
In-Reply-To: <1131647515831-fb6db61e0af75c4b@cisco.com>
X-OriginalArrivalTime: 10 Nov 2005 18:31:57.0855 (UTC) FILETIME=[085F02F0:01C5E625]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In Tavor mode, when posting a long list of receive work requests, a
doorbell must be rung every 256 requests.  Add code to do this when
required.

Signed-off-by: Michael S. Tsirkin <mst@mellanox.co.il>
Signed-off-by: Roland Dreier <rolandd@cisco.com>

---

 drivers/infiniband/hw/mthca/mthca_qp.c  |   19 +++++++++++++++++--
 drivers/infiniband/hw/mthca/mthca_srq.c |   22 ++++++++++++++++++++--
 drivers/infiniband/hw/mthca/mthca_wqe.h |    3 ++-
 3 files changed, 39 insertions(+), 5 deletions(-)

applies-to: 984d2fc62c548af3d01450135f33b5b97aecf00b
ae57e24a4006fd46b73d842ee99db9580ef74a02
diff --git a/drivers/infiniband/hw/mthca/mthca_qp.c b/drivers/infiniband/hw/mthca/mthca_qp.c
index 190c1dc..760c418 100644
--- a/drivers/infiniband/hw/mthca/mthca_qp.c
+++ b/drivers/infiniband/hw/mthca/mthca_qp.c
@@ -1707,6 +1707,7 @@ int mthca_tavor_post_receive(struct ib_q
 {
 	struct mthca_dev *dev = to_mdev(ibqp->device);
 	struct mthca_qp *qp = to_mqp(ibqp);
+	__be32 doorbell[2];
 	unsigned long flags;
 	int err = 0;
 	int nreq;
@@ -1724,6 +1725,22 @@ int mthca_tavor_post_receive(struct ib_q
 	ind = qp->rq.next_ind;
 
 	for (nreq = 0; wr; ++nreq, wr = wr->next) {
+		if (unlikely(nreq == MTHCA_TAVOR_MAX_WQES_PER_RECV_DB)) {
+			nreq = 0;
+
+			doorbell[0] = cpu_to_be32((qp->rq.next_ind << qp->rq.wqe_shift) | size0);
+			doorbell[1] = cpu_to_be32(qp->qpn << 8);
+
+			wmb();
+
+			mthca_write64(doorbell,
+				      dev->kar + MTHCA_RECEIVE_DOORBELL,
+				      MTHCA_GET_DOORBELL_LOCK(&dev->doorbell_lock));
+
+			qp->rq.head += MTHCA_TAVOR_MAX_WQES_PER_RECV_DB;
+			size0 = 0;
+		}
+
 		if (mthca_wq_overflow(&qp->rq, nreq, qp->ibqp.recv_cq)) {
 			mthca_err(dev, "RQ %06x full (%u head, %u tail,"
 					" %d max, %d nreq)\n", qp->qpn,
@@ -1781,8 +1798,6 @@ int mthca_tavor_post_receive(struct ib_q
 
 out:
 	if (likely(nreq)) {
-		__be32 doorbell[2];
-
 		doorbell[0] = cpu_to_be32((qp->rq.next_ind << qp->rq.wqe_shift) | size0);
 		doorbell[1] = cpu_to_be32((qp->qpn << 8) | nreq);
 
diff --git a/drivers/infiniband/hw/mthca/mthca_srq.c b/drivers/infiniband/hw/mthca/mthca_srq.c
index 292f55b..c3c0331 100644
--- a/drivers/infiniband/hw/mthca/mthca_srq.c
+++ b/drivers/infiniband/hw/mthca/mthca_srq.c
@@ -414,6 +414,7 @@ int mthca_tavor_post_srq_recv(struct ib_
 {
 	struct mthca_dev *dev = to_mdev(ibsrq->device);
 	struct mthca_srq *srq = to_msrq(ibsrq);
+	__be32 doorbell[2];
 	unsigned long flags;
 	int err = 0;
 	int first_ind;
@@ -429,6 +430,25 @@ int mthca_tavor_post_srq_recv(struct ib_
 	first_ind = srq->first_free;
 
 	for (nreq = 0; wr; ++nreq, wr = wr->next) {
+		if (unlikely(nreq == MTHCA_TAVOR_MAX_WQES_PER_RECV_DB)) {
+			nreq = 0;
+
+			doorbell[0] = cpu_to_be32(first_ind << srq->wqe_shift);
+			doorbell[1] = cpu_to_be32(srq->srqn << 8);
+
+			/*
+			 * Make sure that descriptors are written
+			 * before doorbell is rung.
+			 */
+			wmb();
+
+			mthca_write64(doorbell,
+				      dev->kar + MTHCA_RECEIVE_DOORBELL,
+				      MTHCA_GET_DOORBELL_LOCK(&dev->doorbell_lock));
+
+			first_ind = srq->first_free;
+		}
+
 		ind = srq->first_free;
 
 		if (ind < 0) {
@@ -491,8 +511,6 @@ int mthca_tavor_post_srq_recv(struct ib_
 	}
 
 	if (likely(nreq)) {
-		__be32 doorbell[2];
-
 		doorbell[0] = cpu_to_be32(first_ind << srq->wqe_shift);
 		doorbell[1] = cpu_to_be32((srq->srqn << 8) | nreq);
 
diff --git a/drivers/infiniband/hw/mthca/mthca_wqe.h b/drivers/infiniband/hw/mthca/mthca_wqe.h
index 1f4c0ff..73f1c0b 100644
--- a/drivers/infiniband/hw/mthca/mthca_wqe.h
+++ b/drivers/infiniband/hw/mthca/mthca_wqe.h
@@ -49,7 +49,8 @@ enum {
 };
 
 enum {
-	MTHCA_INVAL_LKEY = 0x100
+	MTHCA_INVAL_LKEY			= 0x100,
+	MTHCA_TAVOR_MAX_WQES_PER_RECV_DB	= 256
 };
 
 struct mthca_next_seg {
---
0.99.9e
