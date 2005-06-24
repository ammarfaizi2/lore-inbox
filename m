Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263109AbVFXEWb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263109AbVFXEWb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Jun 2005 00:22:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263108AbVFXEJh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Jun 2005 00:09:37 -0400
Received: from webmail.topspin.com ([12.162.17.3]:33605 "EHLO
	exch-1.topspincom.com") by vger.kernel.org with ESMTP
	id S263099AbVFXEEY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Jun 2005 00:04:24 -0400
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: [PATCH 09/14] IB/mthca: Move mthca_is_memfree checks
In-Reply-To: <2005623214.G1df9mxuEjBWFXr4@topspin.com>
X-Mailer: Roland's Patchbomber
Date: Thu, 23 Jun 2005 21:04:20 -0700
Message-Id: <2005623214.PWhRmdueOgH2vhWW@topspin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: akpm@osdl.org
Content-Transfer-Encoding: 7BIT
From: Roland Dreier <roland@topspin.com>
X-OriginalArrivalTime: 24 Jun 2005 04:04:21.0073 (UTC) FILETIME=[CCB13410:01C57871]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Make mthca_table_put() and mthca_table_put_range() NOPs if the device
is not mem-free, so that we don't have to have "if (mthca_is_memfree())"
tests in the callers of these functions.  This makes our code more
readable and maintainable, and saves a couple dozen bytes of text in
ib_mthca.ko as well.

Signed-off-by: Roland Dreier <roland@topspin.com>

---

 linux.git/drivers/infiniband/hw/mthca/mthca_cq.c      |    2 +-
 linux.git/drivers/infiniband/hw/mthca/mthca_memfree.c |   10 +++++++++-
 linux.git/drivers/infiniband/hw/mthca/mthca_mr.c      |   20 +++++++-------------
 linux.git/drivers/infiniband/hw/mthca/mthca_qp.c      |    9 +++++----
 4 files changed, 22 insertions(+), 19 deletions(-)



--- linux.git.orig/drivers/infiniband/hw/mthca/mthca_cq.c	2005-06-23 13:03:04.752088550 -0700
+++ linux.git/drivers/infiniband/hw/mthca/mthca_cq.c	2005-06-23 13:03:06.793646706 -0700
@@ -918,9 +918,9 @@ void mthca_free_cq(struct mthca_dev *dev
 	if (mthca_is_memfree(dev)) {
 		mthca_free_db(dev, MTHCA_DB_TYPE_CQ_ARM,    cq->arm_db_index);
 		mthca_free_db(dev, MTHCA_DB_TYPE_CQ_SET_CI, cq->set_ci_db_index);
-		mthca_table_put(dev, dev->cq_table.table, cq->cqn);
 	}
 
+	mthca_table_put(dev, dev->cq_table.table, cq->cqn);
 	mthca_free(&dev->cq_table.alloc, cq->cqn);
 	kfree(mailbox);
 }
--- linux.git.orig/drivers/infiniband/hw/mthca/mthca_memfree.c	2005-06-23 13:03:01.610768408 -0700
+++ linux.git/drivers/infiniband/hw/mthca/mthca_memfree.c	2005-06-23 13:03:06.791647139 -0700
@@ -179,9 +179,14 @@ out:
 
 void mthca_table_put(struct mthca_dev *dev, struct mthca_icm_table *table, int obj)
 {
-	int i = (obj & (table->num_obj - 1)) * table->obj_size / MTHCA_TABLE_CHUNK_SIZE;
+	int i;
 	u8 status;
 
+	if (!mthca_is_memfree(dev))
+		return;
+
+	i = (obj & (table->num_obj - 1)) * table->obj_size / MTHCA_TABLE_CHUNK_SIZE;
+
 	down(&table->mutex);
 
 	if (--table->icm[i]->refcount == 0) {
@@ -256,6 +261,9 @@ void mthca_table_put_range(struct mthca_
 {
 	int i;
 
+	if (!mthca_is_memfree(dev))
+		return;
+
 	for (i = start; i <= end; i += MTHCA_TABLE_CHUNK_SIZE / table->obj_size)
 		mthca_table_put(dev, table, i);
 }
--- linux.git.orig/drivers/infiniband/hw/mthca/mthca_mr.c	2005-06-23 13:03:01.610768408 -0700
+++ linux.git/drivers/infiniband/hw/mthca/mthca_mr.c	2005-06-23 13:03:06.792646922 -0700
@@ -195,10 +195,8 @@ static void mthca_free_mtt(struct mthca_
 			   struct mthca_buddy* buddy)
 {
 	mthca_buddy_free(buddy, seg, order);
-
-	if (mthca_is_memfree(dev))
-		mthca_table_put_range(dev, dev->mr_table.mtt_table, seg,
-				      seg + (1 << order) - 1);
+	mthca_table_put_range(dev, dev->mr_table.mtt_table, seg,
+			      seg + (1 << order) - 1);
 }
 
 static inline u32 tavor_hw_index_to_key(u32 ind)
@@ -299,8 +297,7 @@ int mthca_mr_alloc_notrans(struct mthca_
 	return err;
 
 err_out_table:
-	if (mthca_is_memfree(dev))
-		mthca_table_put(dev, dev->mr_table.mpt_table, key);
+	mthca_table_put(dev, dev->mr_table.mpt_table, key);
 
 err_out_mpt_free:
 	mthca_free(&dev->mr_table.mpt_alloc, key);
@@ -437,8 +434,7 @@ err_out_free_mtt:
 	mthca_free_mtt(dev, mr->first_seg, mr->order, &dev->mr_table.mtt_buddy);
 
 err_out_table:
-	if (mthca_is_memfree(dev))
-		mthca_table_put(dev, dev->mr_table.mpt_table, key);
+	mthca_table_put(dev, dev->mr_table.mpt_table, key);
 
 err_out_mpt_free:
 	mthca_free(&dev->mr_table.mpt_alloc, key);
@@ -452,9 +448,8 @@ static void mthca_free_region(struct mth
 	if (order >= 0)
 		mthca_free_mtt(dev, first_seg, order, buddy);
 
-	if (mthca_is_memfree(dev))
-		mthca_table_put(dev, dev->mr_table.mpt_table,
-				arbel_key_to_hw_index(lkey));
+	mthca_table_put(dev, dev->mr_table.mpt_table,
+			arbel_key_to_hw_index(lkey));
 
 	mthca_free(&dev->mr_table.mpt_alloc, key_to_hw_index(dev, lkey));
 }
@@ -596,8 +591,7 @@ err_out_free_mtt:
 		       dev->mr_table.fmr_mtt_buddy);
 
 err_out_table:
-	if (mthca_is_memfree(dev))
-		mthca_table_put(dev, dev->mr_table.mpt_table, key);
+	mthca_table_put(dev, dev->mr_table.mpt_table, key);
 
 err_out_mpt_free:
 	mthca_free(&dev->mr_table.mpt_alloc, mr->ibmr.lkey);
--- linux.git.orig/drivers/infiniband/hw/mthca/mthca_qp.c	2005-06-23 13:03:06.027812451 -0700
+++ linux.git/drivers/infiniband/hw/mthca/mthca_qp.c	2005-06-23 13:03:06.792646922 -0700
@@ -1111,11 +1111,12 @@ static void mthca_free_memfree(struct mt
 	if (mthca_is_memfree(dev)) {
 		mthca_free_db(dev, MTHCA_DB_TYPE_SQ, qp->sq.db_index);
 		mthca_free_db(dev, MTHCA_DB_TYPE_RQ, qp->rq.db_index);
-		mthca_table_put(dev, dev->qp_table.rdb_table,
-				qp->qpn << dev->qp_table.rdb_shift);
-		mthca_table_put(dev, dev->qp_table.eqp_table, qp->qpn);
-		mthca_table_put(dev, dev->qp_table.qp_table, qp->qpn);
 	}
+
+	mthca_table_put(dev, dev->qp_table.rdb_table,
+			qp->qpn << dev->qp_table.rdb_shift);
+	mthca_table_put(dev, dev->qp_table.eqp_table, qp->qpn);
+	mthca_table_put(dev, dev->qp_table.qp_table, qp->qpn);
 }
 
 static void mthca_wq_init(struct mthca_wq* wq)

