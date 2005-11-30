Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750748AbVK3A55@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750748AbVK3A55 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Nov 2005 19:57:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750755AbVK3A54
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Nov 2005 19:57:56 -0500
Received: from ams-iport-1.cisco.com ([144.254.224.140]:51752 "EHLO
	ams-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S1750753AbVK3A5k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Nov 2005 19:57:40 -0500
Subject: [git patch review 7/8] IB/mthca: fix posting of send lists of length
	>= 255 on mem-free HCAs
From: Roland Dreier <rolandd@cisco.com>
Date: Wed, 30 Nov 2005 00:57:25 +0000
To: linux-kernel@vger.kernel.org, openib-general@openib.org
X-Mailer: IB-patch-reviewer
Content-Transfer-Encoding: 8bit
Message-ID: <1133312245799-fb80cd19aa5b232b@cisco.com>
In-Reply-To: <1133312245799-51b50fe9f024aec5@cisco.com>
X-OriginalArrivalTime: 30 Nov 2005 00:57:27.0971 (UTC) FILETIME=[08D7DF30:01C5F549]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On mem-free HCAs, when posting a long list of send requests, a
doorbell must be rung every 255 requests.  Add code to handle this.

Signed-off-by: Michael S. Tsirkin <mst@mellanox.co.il>
Signed-off-by: Roland Dreier <rolandd@cisco.com>

---

 drivers/infiniband/hw/mthca/mthca_qp.c  |   31 +++++++++++++++++++++++++++++--
 drivers/infiniband/hw/mthca/mthca_wqe.h |    3 ++-
 2 files changed, 31 insertions(+), 3 deletions(-)

applies-to: 1f53cd0db55372192cc088788dadbed102845a17
e0ae9ecf469fdd3c1ad999efbf4fe6b782f49900
diff --git a/drivers/infiniband/hw/mthca/mthca_qp.c b/drivers/infiniband/hw/mthca/mthca_qp.c
index f9c8eb9..7450550 100644
--- a/drivers/infiniband/hw/mthca/mthca_qp.c
+++ b/drivers/infiniband/hw/mthca/mthca_qp.c
@@ -1822,6 +1822,7 @@ int mthca_arbel_post_send(struct ib_qp *
 {
 	struct mthca_dev *dev = to_mdev(ibqp->device);
 	struct mthca_qp *qp = to_mqp(ibqp);
+	__be32 doorbell[2];
 	void *wqe;
 	void *prev_wqe;
 	unsigned long flags;
@@ -1841,6 +1842,34 @@ int mthca_arbel_post_send(struct ib_qp *
 	ind = qp->sq.head & (qp->sq.max - 1);
 
 	for (nreq = 0; wr; ++nreq, wr = wr->next) {
+		if (unlikely(nreq == MTHCA_ARBEL_MAX_WQES_PER_SEND_DB)) {
+			nreq = 0;
+
+			doorbell[0] = cpu_to_be32((MTHCA_ARBEL_MAX_WQES_PER_SEND_DB << 24) |
+						  ((qp->sq.head & 0xffff) << 8) |
+						  f0 | op0);
+			doorbell[1] = cpu_to_be32((qp->qpn << 8) | size0);
+
+			qp->sq.head += MTHCA_ARBEL_MAX_WQES_PER_SEND_DB;
+			size0 = 0;
+
+			/*
+			 * Make sure that descriptors are written before
+			 * doorbell record.
+			 */
+			wmb();
+			*qp->sq.db = cpu_to_be32(qp->sq.head & 0xffff);
+
+			/*
+			 * Make sure doorbell record is written before we
+			 * write MMIO send doorbell.
+			 */
+			wmb();
+			mthca_write64(doorbell,
+				      dev->kar + MTHCA_SEND_DOORBELL,
+				      MTHCA_GET_DOORBELL_LOCK(&dev->doorbell_lock));
+		}
+
 		if (mthca_wq_overflow(&qp->sq, nreq, qp->ibqp.send_cq)) {
 			mthca_err(dev, "SQ %06x full (%u head, %u tail,"
 					" %d max, %d nreq)\n", qp->qpn,
@@ -2017,8 +2046,6 @@ int mthca_arbel_post_send(struct ib_qp *
 
 out:
 	if (likely(nreq)) {
-		__be32 doorbell[2];
-
 		doorbell[0] = cpu_to_be32((nreq << 24)                  |
 					  ((qp->sq.head & 0xffff) << 8) |
 					  f0 | op0);
diff --git a/drivers/infiniband/hw/mthca/mthca_wqe.h b/drivers/infiniband/hw/mthca/mthca_wqe.h
index 73f1c0b..e7d2c1e 100644
--- a/drivers/infiniband/hw/mthca/mthca_wqe.h
+++ b/drivers/infiniband/hw/mthca/mthca_wqe.h
@@ -50,7 +50,8 @@ enum {
 
 enum {
 	MTHCA_INVAL_LKEY			= 0x100,
-	MTHCA_TAVOR_MAX_WQES_PER_RECV_DB	= 256
+	MTHCA_TAVOR_MAX_WQES_PER_RECV_DB	= 256,
+	MTHCA_ARBEL_MAX_WQES_PER_SEND_DB	= 255
 };
 
 struct mthca_next_seg {
---
0.99.9k
