Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932292AbVK1X4t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932292AbVK1X4t (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Nov 2005 18:56:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932290AbVK1X4t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Nov 2005 18:56:49 -0500
Received: from sj-iport-2-in.cisco.com ([171.71.176.71]:61875 "EHLO
	sj-iport-2.cisco.com") by vger.kernel.org with ESMTP
	id S932292AbVK1X4t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Nov 2005 18:56:49 -0500
Subject: [git patch review 1/2] IB/mthca: reset QP's last pointers when
	transitioning to reset state
From: Roland Dreier <rolandd@cisco.com>
Date: Mon, 28 Nov 2005 23:56:40 +0000
To: linux-kernel@vger.kernel.org, openib-general@openib.org
X-Mailer: IB-patch-reviewer
Content-Transfer-Encoding: 8bit
Message-ID: <1133222200079-44d9989c7d031b8b@cisco.com>
X-OriginalArrivalTime: 28 Nov 2005 23:56:40.0421 (UTC) FILETIME=[60522950:01C5F477]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

last pointer is not updated when QP is modified to reset state.  This
causes data corruption if WQEs are already posted on the queue.

Signed-off-by: Michael S. Tsirkin <mst@mellanox.co.il>
Signed-off-by: Roland Dreier <rolandd@cisco.com>

---

 drivers/infiniband/hw/mthca/mthca_qp.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

applies-to: 1e8504d2a91579756c89ef2d65ebd526f973cde8
187a25863fe014486ee834164776b2a587d6934d
diff --git a/drivers/infiniband/hw/mthca/mthca_qp.c b/drivers/infiniband/hw/mthca/mthca_qp.c
index dd4e133..f9c8eb9 100644
--- a/drivers/infiniband/hw/mthca/mthca_qp.c
+++ b/drivers/infiniband/hw/mthca/mthca_qp.c
@@ -871,7 +871,10 @@ int mthca_modify_qp(struct ib_qp *ibqp, 
 				       qp->ibqp.srq ? to_msrq(qp->ibqp.srq) : NULL);
 
 		mthca_wq_init(&qp->sq);
+		qp->sq.last = get_send_wqe(qp, qp->sq.max - 1);
+
 		mthca_wq_init(&qp->rq);
+		qp->rq.last = get_recv_wqe(qp, qp->rq.max - 1);
 
 		if (mthca_is_memfree(dev)) {
 			*qp->sq.db = 0;
---
0.99.9k
