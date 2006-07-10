Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964814AbWGJVPR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964814AbWGJVPR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 17:15:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965208AbWGJVPR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 17:15:17 -0400
Received: from mxl145v68.mxlogic.net ([208.65.145.68]:13263 "EHLO
	p02c11o145.mxlogic.net") by vger.kernel.org with ESMTP
	id S964814AbWGJVPP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 17:15:15 -0400
Date: Tue, 11 Jul 2006 00:15:42 +0300
From: "Michael S. Tsirkin" <mst@mellanox.co.il>
To: Andrew Morton <akpm@osdl.org>
Cc: Arjan van de Ven <arjan@infradead.org>, Ingo Molnar <mingo@elte.hu>,
       Zach Brown <zach.brown@oracle.com>, openib-general@openib.org,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       Roland Dreier <rolandd@cisco.com>
Subject: [PATCHv2] IB/mthca: comment fix
Message-ID: <20060710211542.GA30898@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
References: <20060710111412.GD24705@mellanox.co.il> <20060710151824.GL24705@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060710151824.GL24705@mellanox.co.il>
User-Agent: Mutt/1.4.2.1i
X-OriginalArrivalTime: 10 Jul 2006 21:20:20.0828 (UTC) FILETIME=[A62DD9C0:01C6A466]
X-Spam: [F=0.0100000000; S=0.010(2006062901)]
X-MAIL-FROM: <mst@mellanox.co.il>
X-SOURCE-IP: [194.90.237.34]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OK, this is fine with both Arjan van de Ven and Roland Dreier, so -
Andrew, could you take this into -mm please?

---

After recent changes, mthca_wq_init does not actually initialize the WQ as it
used to - it simply resets all index fields to their initial values. So,
let's rename it to mthca_wq_reset.

Signed-off-by: Michael S. Tsirkin <mst@mellanox.co.il>

diff --git a/drivers/infiniband/hw/mthca/mthca_qp.c b/drivers/infiniband/hw/mthca/mthca_qp.c
index 490fc78..cd8b672 100644
--- a/drivers/infiniband/hw/mthca/mthca_qp.c
+++ b/drivers/infiniband/hw/mthca/mthca_qp.c
@@ -222,9 +222,8 @@ static void *get_send_wqe(struct mthca_q
 			 (PAGE_SIZE - 1));
 }
 
-static void mthca_wq_init(struct mthca_wq *wq)
+static void mthca_wq_reset(struct mthca_wq *wq)
 {
-	/* mthca_alloc_qp_common() initializes the locks */
 	wq->next_ind  = 0;
 	wq->last_comp = wq->max - 1;
 	wq->head      = 0;
@@ -845,10 +844,10 @@ int mthca_modify_qp(struct ib_qp *ibqp, 
 			mthca_cq_clean(dev, to_mcq(qp->ibqp.recv_cq), qp->qpn,
 				       qp->ibqp.srq ? to_msrq(qp->ibqp.srq) : NULL);
 
-		mthca_wq_init(&qp->sq);
+		mthca_wq_reset(&qp->sq);
 		qp->sq.last = get_send_wqe(qp, qp->sq.max - 1);
 
-		mthca_wq_init(&qp->rq);
+		mthca_wq_reset(&qp->rq);
 		qp->rq.last = get_recv_wqe(qp, qp->rq.max - 1);
 
 		if (mthca_is_memfree(dev)) {
@@ -1112,9 +1111,9 @@ static int mthca_alloc_qp_common(struct 
 	qp->atomic_rd_en = 0;
 	qp->resp_depth   = 0;
 	qp->sq_policy    = send_policy;
-	mthca_wq_init(&qp->sq);
-	mthca_wq_init(&qp->rq);
-	/* these are initialized separately so lockdep can tell them apart */
+	mthca_wq_reset(&qp->sq);
+	mthca_wq_reset(&qp->rq);
+
 	spin_lock_init(&qp->sq.lock);
 	spin_lock_init(&qp->rq.lock);
 
-- 
MST
