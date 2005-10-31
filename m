Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932480AbVJaWes@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932480AbVJaWes (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 17:34:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932472AbVJaWes
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 17:34:48 -0500
Received: from ams-iport-1.cisco.com ([144.254.224.140]:59658 "EHLO
	ams-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S932166AbVJaWer (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 17:34:47 -0500
Subject: [git patch review 1/5] [IB] mthca: report asynchronous CQ events
From: Roland Dreier <rolandd@cisco.com>
Date: Mon, 31 Oct 2005 22:34:42 +0000
To: linux-kernel@vger.kernel.org, openib-general@openib.org
X-Mailer: IB-patch-reviewer
Content-Transfer-Encoding: 8bit
Message-ID: <1130798082548-646b24d6f405c5f5@cisco.com>
X-OriginalArrivalTime: 31 Oct 2005 22:34:43.0729 (UTC) FILETIME=[4A2D8010:01C5DE6B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Implement reporting asynchronous CQ events in Mellanox HCA driver.

Signed-off-by: Michael S. Tsirkin <mst@mellanox.co.il>
Signed-off-by: Roland Dreier <rolandd@cisco.com>

---

 drivers/infiniband/hw/mthca/mthca_cq.c  |   31 ++++++++++++++++++++++++++++++-
 drivers/infiniband/hw/mthca/mthca_dev.h |    4 +++-
 drivers/infiniband/hw/mthca/mthca_eq.c  |    4 +++-
 3 files changed, 36 insertions(+), 3 deletions(-)

applies-to: d918cd1ba0ef9afa692cef281afee2f6d6634a1e
affcd50546d4788b7849e2b2e2ec7bc50d64c5f8
diff --git a/drivers/infiniband/hw/mthca/mthca_cq.c b/drivers/infiniband/hw/mthca/mthca_cq.c
index 8600b6c..f98e235 100644
--- a/drivers/infiniband/hw/mthca/mthca_cq.c
+++ b/drivers/infiniband/hw/mthca/mthca_cq.c
@@ -208,7 +208,7 @@ static inline void update_cons_index(str
 	}
 }
 
-void mthca_cq_event(struct mthca_dev *dev, u32 cqn)
+void mthca_cq_completion(struct mthca_dev *dev, u32 cqn)
 {
 	struct mthca_cq *cq;
 
@@ -224,6 +224,35 @@ void mthca_cq_event(struct mthca_dev *de
 	cq->ibcq.comp_handler(&cq->ibcq, cq->ibcq.cq_context);
 }
 
+void mthca_cq_event(struct mthca_dev *dev, u32 cqn,
+		    enum ib_event_type event_type)
+{
+	struct mthca_cq *cq;
+	struct ib_event event;
+
+	spin_lock(&dev->cq_table.lock);
+
+	cq = mthca_array_get(&dev->cq_table.cq, cqn & (dev->limits.num_cqs - 1));
+
+	if (cq)
+		atomic_inc(&cq->refcount);
+	spin_unlock(&dev->cq_table.lock);
+
+	if (!cq) {
+		mthca_warn(dev, "Async event for bogus CQ %08x\n", cqn);
+		return;
+	}
+
+	event.device      = &dev->ib_dev;
+	event.event       = event_type;
+	event.element.cq  = &cq->ibcq;
+	if (cq->ibcq.event_handler)
+		cq->ibcq.event_handler(&event, cq->ibcq.cq_context);
+
+	if (atomic_dec_and_test(&cq->refcount))
+		wake_up(&cq->wait);
+}
+
 void mthca_cq_clean(struct mthca_dev *dev, u32 cqn, u32 qpn,
 		    struct mthca_srq *srq)
 {
diff --git a/drivers/infiniband/hw/mthca/mthca_dev.h b/drivers/infiniband/hw/mthca/mthca_dev.h
index 7e68bd4..e7e5d3b 100644
--- a/drivers/infiniband/hw/mthca/mthca_dev.h
+++ b/drivers/infiniband/hw/mthca/mthca_dev.h
@@ -460,7 +460,9 @@ int mthca_init_cq(struct mthca_dev *dev,
 		  struct mthca_cq *cq);
 void mthca_free_cq(struct mthca_dev *dev,
 		   struct mthca_cq *cq);
-void mthca_cq_event(struct mthca_dev *dev, u32 cqn);
+void mthca_cq_completion(struct mthca_dev *dev, u32 cqn);
+void mthca_cq_event(struct mthca_dev *dev, u32 cqn,
+		    enum ib_event_type event_type);
 void mthca_cq_clean(struct mthca_dev *dev, u32 cqn, u32 qpn,
 		    struct mthca_srq *srq);
 
diff --git a/drivers/infiniband/hw/mthca/mthca_eq.c b/drivers/infiniband/hw/mthca/mthca_eq.c
index e5a047a..34d68e5 100644
--- a/drivers/infiniband/hw/mthca/mthca_eq.c
+++ b/drivers/infiniband/hw/mthca/mthca_eq.c
@@ -292,7 +292,7 @@ static int mthca_eq_int(struct mthca_dev
 		case MTHCA_EVENT_TYPE_COMP:
 			disarm_cqn = be32_to_cpu(eqe->event.comp.cqn) & 0xffffff;
 			disarm_cq(dev, eq->eqn, disarm_cqn);
-			mthca_cq_event(dev, disarm_cqn);
+			mthca_cq_completion(dev, disarm_cqn);
 			break;
 
 		case MTHCA_EVENT_TYPE_PATH_MIG:
@@ -364,6 +364,8 @@ static int mthca_eq_int(struct mthca_dev
 				   eqe->event.cq_err.syndrome == 1 ?
 				   "overrun" : "access violation",
 				   be32_to_cpu(eqe->event.cq_err.cqn) & 0xffffff);
+			mthca_cq_event(dev, be32_to_cpu(eqe->event.cq_err.cqn),
+				       IB_EVENT_CQ_ERR);
 			break;
 
 		case MTHCA_EVENT_TYPE_EQ_OVERFLOW:
---
0.99.9
