Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262535AbVDLSoe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262535AbVDLSoe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 14:44:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262534AbVDLSlv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 14:41:51 -0400
Received: from fire.osdl.org ([65.172.181.4]:1483 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262298AbVDLKd5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 06:33:57 -0400
Message-Id: <200504121033.j3CAXXc0005911@shell0.pdx.osdl.net>
Subject: [patch 187/198] IB/mthca: map context for RDMA responder in mem-free mode
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, roland@topspin.com
From: akpm@osdl.org
Date: Tue, 12 Apr 2005 03:33:27 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Roland Dreier <roland@topspin.com>

Fix RDMA in mem-free mode: we need to make sure that the RDMA context memory
is mapped for the HCA.

Signed-off-by: Roland Dreier <roland@topspin.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/drivers/infiniband/hw/mthca/mthca_dev.h  |    1 +
 25-akpm/drivers/infiniband/hw/mthca/mthca_main.c |   18 ++++++++++++++++--
 25-akpm/drivers/infiniband/hw/mthca/mthca_qp.c   |   13 ++++++++++++-
 3 files changed, 29 insertions(+), 3 deletions(-)

diff -puN drivers/infiniband/hw/mthca/mthca_dev.h~ib-mthca-map-context-for-rdma-responder-in-mem-free-mode drivers/infiniband/hw/mthca/mthca_dev.h
--- 25/drivers/infiniband/hw/mthca/mthca_dev.h~ib-mthca-map-context-for-rdma-responder-in-mem-free-mode	2005-04-12 03:21:47.983842248 -0700
+++ 25-akpm/drivers/infiniband/hw/mthca/mthca_dev.h	2005-04-12 03:21:47.989841336 -0700
@@ -222,6 +222,7 @@ struct mthca_qp_table {
 	struct mthca_array     	qp;
 	struct mthca_icm_table *qp_table;
 	struct mthca_icm_table *eqp_table;
+	struct mthca_icm_table *rdb_table;
 };
 
 struct mthca_av_table {
diff -puN drivers/infiniband/hw/mthca/mthca_main.c~ib-mthca-map-context-for-rdma-responder-in-mem-free-mode drivers/infiniband/hw/mthca/mthca_main.c
--- 25/drivers/infiniband/hw/mthca/mthca_main.c~ib-mthca-map-context-for-rdma-responder-in-mem-free-mode	2005-04-12 03:21:47.984842096 -0700
+++ 25-akpm/drivers/infiniband/hw/mthca/mthca_main.c	2005-04-12 03:21:47.990841184 -0700
@@ -430,14 +430,25 @@ static int __devinit mthca_init_icm(stru
 		goto err_unmap_qp;
 	}
 
-	mdev->cq_table.table = mthca_alloc_icm_table(mdev, init_hca->cqc_base,
+	mdev->qp_table.rdb_table = mthca_alloc_icm_table(mdev, init_hca->rdb_base,
+							 MTHCA_RDB_ENTRY_SIZE,
+							 mdev->limits.num_qps <<
+							 mdev->qp_table.rdb_shift,
+							 0, 0);
+	if (!mdev->qp_table.rdb_table) {
+		mthca_err(mdev, "Failed to map RDB context memory, aborting\n");
+		err = -ENOMEM;
+		goto err_unmap_eqp;
+	}
+
+       mdev->cq_table.table = mthca_alloc_icm_table(mdev, init_hca->cqc_base,
 						     dev_lim->cqc_entry_sz,
 						     mdev->limits.num_cqs,
 						     mdev->limits.reserved_cqs, 0);
 	if (!mdev->cq_table.table) {
 		mthca_err(mdev, "Failed to map CQ context memory, aborting.\n");
 		err = -ENOMEM;
-		goto err_unmap_eqp;
+		goto err_unmap_rdb;
 	}
 
 	/*
@@ -463,6 +474,9 @@ static int __devinit mthca_init_icm(stru
 err_unmap_cq:
 	mthca_free_icm_table(mdev, mdev->cq_table.table);
 
+err_unmap_rdb:
+	mthca_free_icm_table(mdev, mdev->qp_table.rdb_table);
+
 err_unmap_eqp:
 	mthca_free_icm_table(mdev, mdev->qp_table.eqp_table);
 
diff -puN drivers/infiniband/hw/mthca/mthca_qp.c~ib-mthca-map-context-for-rdma-responder-in-mem-free-mode drivers/infiniband/hw/mthca/mthca_qp.c
--- 25/drivers/infiniband/hw/mthca/mthca_qp.c~ib-mthca-map-context-for-rdma-responder-in-mem-free-mode	2005-04-12 03:21:47.986841792 -0700
+++ 25-akpm/drivers/infiniband/hw/mthca/mthca_qp.c	2005-04-12 03:21:47.992840880 -0700
@@ -1025,11 +1025,16 @@ static int mthca_alloc_memfree(struct mt
 		if (ret)
 			goto err_qpc;
 
+		ret = mthca_table_get(dev, dev->qp_table.rdb_table,
+				      qp->qpn << dev->qp_table.rdb_shift);
+		if (ret)
+			goto err_eqpc;
+
 		qp->rq.db_index = mthca_alloc_db(dev, MTHCA_DB_TYPE_RQ,
 						 qp->qpn, &qp->rq.db);
 		if (qp->rq.db_index < 0) {
 			ret = -ENOMEM;
-			goto err_eqpc;
+			goto err_rdb;
 		}
 
 		qp->sq.db_index = mthca_alloc_db(dev, MTHCA_DB_TYPE_SQ,
@@ -1045,6 +1050,10 @@ static int mthca_alloc_memfree(struct mt
 err_rq_db:
 	mthca_free_db(dev, MTHCA_DB_TYPE_RQ, qp->rq.db_index);
 
+err_rdb:
+	mthca_table_put(dev, dev->qp_table.rdb_table,
+			qp->qpn << dev->qp_table.rdb_shift);
+
 err_eqpc:
 	mthca_table_put(dev, dev->qp_table.eqp_table, qp->qpn);
 
@@ -1060,6 +1069,8 @@ static void mthca_free_memfree(struct mt
 	if (mthca_is_memfree(dev)) {
 		mthca_free_db(dev, MTHCA_DB_TYPE_SQ, qp->sq.db_index);
 		mthca_free_db(dev, MTHCA_DB_TYPE_RQ, qp->rq.db_index);
+		mthca_table_put(dev, dev->qp_table.rdb_table,
+				qp->qpn << dev->qp_table.rdb_shift);
 		mthca_table_put(dev, dev->qp_table.eqp_table, qp->qpn);
 		mthca_table_put(dev, dev->qp_table.qp_table, qp->qpn);
 	}
_
