Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932140AbVKJSdD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932140AbVKJSdD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 13:33:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932139AbVKJSck
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 13:32:40 -0500
Received: from ams-iport-1.cisco.com ([144.254.224.140]:45853 "EHLO
	ams-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S932140AbVKJScF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 13:32:05 -0500
Subject: [git patch review 5/7] [IB] mthca: fix wraparound handling in
	mthca_cq_clean()
From: Roland Dreier <rolandd@cisco.com>
Date: Thu, 10 Nov 2005 18:31:55 +0000
To: linux-kernel@vger.kernel.org, openib-general@openib.org
X-Mailer: IB-patch-reviewer
Content-Transfer-Encoding: 8bit
Message-ID: <1131647515831-fb6db61e0af75c4b@cisco.com>
In-Reply-To: <1131647515831-8ba0b803b8214b97@cisco.com>
X-OriginalArrivalTime: 10 Nov 2005 18:31:56.0983 (UTC) FILETIME=[07D9F470:01C5E625]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Handle case where prod_index has wrapped around and become less than
cq->cons_index by checking that their difference as a signed int is
positive rather than comparing directly.

Signed-off-by: Roland Dreier <rolandd@cisco.com>

---

 drivers/infiniband/hw/mthca/mthca_cq.c |   16 ++++++----------
 1 files changed, 6 insertions(+), 10 deletions(-)

applies-to: 704990abeb22a51ed2722e92536d22135f60957f
64044bcf75063cb5a6d42712886a712449df2ce3
diff --git a/drivers/infiniband/hw/mthca/mthca_cq.c b/drivers/infiniband/hw/mthca/mthca_cq.c
index f98e235..4a8adce 100644
--- a/drivers/infiniband/hw/mthca/mthca_cq.c
+++ b/drivers/infiniband/hw/mthca/mthca_cq.c
@@ -258,7 +258,7 @@ void mthca_cq_clean(struct mthca_dev *de
 {
 	struct mthca_cq *cq;
 	struct mthca_cqe *cqe;
-	int prod_index;
+	u32 prod_index;
 	int nfreed = 0;
 
 	spin_lock_irq(&dev->cq_table.lock);
@@ -293,19 +293,15 @@ void mthca_cq_clean(struct mthca_dev *de
 	 * Now sweep backwards through the CQ, removing CQ entries
 	 * that match our QP by copying older entries on top of them.
 	 */
-	while (prod_index > cq->cons_index) {
-		cqe = get_cqe(cq, (prod_index - 1) & cq->ibcq.cqe);
+	while ((int) --prod_index - (int) cq->cons_index >= 0) {
+		cqe = get_cqe(cq, prod_index & cq->ibcq.cqe);
 		if (cqe->my_qpn == cpu_to_be32(qpn)) {
 			if (srq)
 				mthca_free_srq_wqe(srq, be32_to_cpu(cqe->wqe));
 			++nfreed;
-		}
-		else if (nfreed)
-			memcpy(get_cqe(cq, (prod_index - 1 + nfreed) &
-				       cq->ibcq.cqe),
-			       cqe,
-			       MTHCA_CQ_ENTRY_SIZE);
-		--prod_index;
+		} else if (nfreed)
+			memcpy(get_cqe(cq, (prod_index + nfreed) & cq->ibcq.cqe),
+			       cqe, MTHCA_CQ_ENTRY_SIZE);
 	}
 
 	if (nfreed) {
---
0.99.9e
