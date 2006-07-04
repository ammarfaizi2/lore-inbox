Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750861AbWGDJBx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750861AbWGDJBx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 05:01:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750859AbWGDJBx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 05:01:53 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:33988 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750722AbWGDJBx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 05:01:53 -0400
Date: Tue, 4 Jul 2006 10:56:53 +0200
From: Ingo Molnar <mingo@elte.hu>
To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Cc: Zach Brown <zach.brown@oracle.com>, Arjan van de Ven <arjan@infradead.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       openib-general@openib.org
Subject: Re: [PATCH] mthca: initialize send and receive queue locks separately
Message-ID: <20060704085653.GA13426@elte.hu>
References: <20060703225019.7379.96075.sendpatchset@tetsuo.zabbo.net> <20060704070328.GG21049@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060704070328.GG21049@mellanox.co.il>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.1 required=5.9 tests=AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	0.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Michael S. Tsirkin <mst@mellanox.co.il> wrote:

> > Initializing the locks separately in mthca_alloc_qp_common() stops the warning
> > and will let lockdep enforce proper ordering on paths that acquire both locks.
> > 
> > Signed-off-by: Zach Brown <zach.brown@oracle.com>
> 
> This moves code out of a common function and so results in code 
> duplication and has memory cost.

the patch below does the same via the lockdep_set_class() method, which 
has no cost on non-lockdep kernels.

	Ingo

---------------->
Subject: lockdep: annotate drivers/infiniband/hw/mthca/mthca_qp.c
From: Ingo Molnar <mingo@elte.hu>

annotate mthca queue locks: split them into send and receive locks.

(both can be held at once, but there is ordering between them which
lockdep enforces)

Has no effect on non-lockdep kernels.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
---
 drivers/infiniband/hw/mthca/mthca_qp.c |   16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

Index: linux/drivers/infiniband/hw/mthca/mthca_qp.c
===================================================================
--- linux.orig/drivers/infiniband/hw/mthca/mthca_qp.c
+++ linux/drivers/infiniband/hw/mthca/mthca_qp.c
@@ -222,9 +222,15 @@ static void *get_send_wqe(struct mthca_q
 			 (PAGE_SIZE - 1));
 }
 
-static void mthca_wq_init(struct mthca_wq *wq)
+/*
+ * Send and receive queues for two different lock classes:
+ */
+static struct lock_class_key mthca_wq_send_lock_class, mthca_wq_recv_lock_class;
+
+static void mthca_wq_init(struct mthca_wq *wq, struct lock_class_key *key)
 {
 	spin_lock_init(&wq->lock);
+	lockdep_set_class(&wq->lock, key);
 	wq->next_ind  = 0;
 	wq->last_comp = wq->max - 1;
 	wq->head      = 0;
@@ -845,10 +851,10 @@ int mthca_modify_qp(struct ib_qp *ibqp, 
 			mthca_cq_clean(dev, to_mcq(qp->ibqp.recv_cq), qp->qpn,
 				       qp->ibqp.srq ? to_msrq(qp->ibqp.srq) : NULL);
 
-		mthca_wq_init(&qp->sq);
+		mthca_wq_init(&qp->sq, &mthca_wq_send_lock_class);
 		qp->sq.last = get_send_wqe(qp, qp->sq.max - 1);
 
-		mthca_wq_init(&qp->rq);
+		mthca_wq_init(&qp->rq, &mthca_wq_recv_lock_class);
 		qp->rq.last = get_recv_wqe(qp, qp->rq.max - 1);
 
 		if (mthca_is_memfree(dev)) {
@@ -1112,8 +1118,8 @@ static int mthca_alloc_qp_common(struct 
 	qp->atomic_rd_en = 0;
 	qp->resp_depth   = 0;
 	qp->sq_policy    = send_policy;
-	mthca_wq_init(&qp->sq);
-	mthca_wq_init(&qp->rq);
+	mthca_wq_init(&qp->sq, &mthca_wq_send_lock_class);
+	mthca_wq_init(&qp->rq, &mthca_wq_recv_lock_class);
 
 	ret = mthca_map_memfree(dev, qp);
 	if (ret)
