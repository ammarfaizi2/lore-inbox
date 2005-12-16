Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932119AbVLPEAo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932119AbVLPEAo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 23:00:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932115AbVLPEAW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 23:00:22 -0500
Received: from sj-iport-2-in.cisco.com ([171.71.176.71]:49295 "EHLO
	sj-iport-2.cisco.com") by vger.kernel.org with ESMTP
	id S932116AbVLPEAU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 23:00:20 -0500
Subject: [git patch review 5/7] IB/mthca: Fix SRQ cleanup during QP destroy
From: Roland Dreier <rolandd@cisco.com>
Date: Fri, 16 Dec 2005 04:00:17 +0000
To: linux-kernel@vger.kernel.org, openib-general@openib.org
X-Mailer: IB-patch-reviewer
Content-Transfer-Encoding: 8bit
Message-ID: <1134705617068-ccaf1fa200ee1176@cisco.com>
In-Reply-To: <1134705617068-92874cd0c1ec02ff@cisco.com>
X-OriginalArrivalTime: 16 Dec 2005 04:00:17.0838 (UTC) FILETIME=[3A00BCE0:01C601F5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When cleaning up a CQ for a QP attached to SRQ, need to free an SRQ
WQE only if the CQE is a receive completion.

Signed-off-by: Jack Morgenstein <jackm@mellanox.co.il>
Signed-off-by: Roland Dreier <rolandd@cisco.com>

---

 drivers/infiniband/hw/mthca/mthca_cq.c |   11 ++++++++++-
 1 files changed, 10 insertions(+), 1 deletions(-)

576d2e4e40315e8140c04be99cd057720d8a3817
diff --git a/drivers/infiniband/hw/mthca/mthca_cq.c b/drivers/infiniband/hw/mthca/mthca_cq.c
index 4a8adce..fcef8dc 100644
--- a/drivers/infiniband/hw/mthca/mthca_cq.c
+++ b/drivers/infiniband/hw/mthca/mthca_cq.c
@@ -253,6 +253,15 @@ void mthca_cq_event(struct mthca_dev *de
 		wake_up(&cq->wait);
 }
 
+static inline int is_recv_cqe(struct mthca_cqe *cqe)
+{
+	if ((cqe->opcode & MTHCA_ERROR_CQE_OPCODE_MASK) ==
+	    MTHCA_ERROR_CQE_OPCODE_MASK)
+		return !(cqe->opcode & 0x01);
+	else
+		return !(cqe->is_send & 0x80);
+}
+
 void mthca_cq_clean(struct mthca_dev *dev, u32 cqn, u32 qpn,
 		    struct mthca_srq *srq)
 {
@@ -296,7 +305,7 @@ void mthca_cq_clean(struct mthca_dev *de
 	while ((int) --prod_index - (int) cq->cons_index >= 0) {
 		cqe = get_cqe(cq, prod_index & cq->ibcq.cqe);
 		if (cqe->my_qpn == cpu_to_be32(qpn)) {
-			if (srq)
+			if (srq && is_recv_cqe(cqe))
 				mthca_free_srq_wqe(srq, be32_to_cpu(cqe->wqe));
 			++nfreed;
 		} else if (nfreed)
-- 
0.99.9n
