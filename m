Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262904AbVDAVPt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262904AbVDAVPt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 16:15:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262914AbVDAVNt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 16:13:49 -0500
Received: from webmail.topspin.com ([12.162.17.3]:37423 "EHLO
	exch-1.topspincom.com") by vger.kernel.org with ESMTP
	id S262915AbVDAUv1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 15:51:27 -0500
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: [PATCH][25/27] IB/mthca: map context for RDMA responder in mem-free mode
In-Reply-To: <2005411249.qaesrlpuSaCRRPRE@topspin.com>
X-Mailer: Roland's Patchbomber
Date: Fri, 1 Apr 2005 12:49:54 -0800
Message-Id: <2005411249.Yyk7PJUeNHG0154S@topspin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: akpm@osdl.org
Content-Transfer-Encoding: 7BIT
From: Roland Dreier <roland@topspin.com>
X-OriginalArrivalTime: 01 Apr 2005 20:49:54.0325 (UTC) FILETIME=[5B69DC50:01C536FC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix RDMA in mem-free mode: we need to make sure that the RDMA context
memory is mapped for the HCA.

Signed-off-by: Roland Dreier <roland@topspin.com>


--- linux-export.orig/drivers/infiniband/hw/mthca/mthca_dev.h	2005-04-01 12:38:30.772280864 -0800
+++ linux-export/drivers/infiniband/hw/mthca/mthca_dev.h	2005-04-01 12:38:31.661087929 -0800
@@ -222,6 +222,7 @@
 	struct mthca_array     	qp;
 	struct mthca_icm_table *qp_table;
 	struct mthca_icm_table *eqp_table;
+	struct mthca_icm_table *rdb_table;
 };
 
 struct mthca_av_table {
--- linux-export.orig/drivers/infiniband/hw/mthca/mthca_main.c	2005-04-01 12:38:30.776279996 -0800
+++ linux-export/drivers/infiniband/hw/mthca/mthca_main.c	2005-04-01 12:38:31.666086844 -0800
@@ -430,14 +430,25 @@
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
@@ -463,6 +474,9 @@
 err_unmap_cq:
 	mthca_free_icm_table(mdev, mdev->cq_table.table);
 
+err_unmap_rdb:
+	mthca_free_icm_table(mdev, mdev->qp_table.rdb_table);
+
 err_unmap_eqp:
 	mthca_free_icm_table(mdev, mdev->qp_table.eqp_table);
 
--- linux-export.orig/drivers/infiniband/hw/mthca/mthca_qp.c	2005-04-01 12:38:30.827268928 -0800
+++ linux-export/drivers/infiniband/hw/mthca/mthca_qp.c	2005-04-01 12:38:31.673085325 -0800
@@ -1025,11 +1025,16 @@
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
@@ -1045,6 +1050,10 @@
 err_rq_db:
 	mthca_free_db(dev, MTHCA_DB_TYPE_RQ, qp->rq.db_index);
 
+err_rdb:
+	mthca_table_put(dev, dev->qp_table.rdb_table,
+			qp->qpn << dev->qp_table.rdb_shift);
+
 err_eqpc:
 	mthca_table_put(dev, dev->qp_table.eqp_table, qp->qpn);
 
@@ -1060,6 +1069,8 @@
 	if (mthca_is_memfree(dev)) {
 		mthca_free_db(dev, MTHCA_DB_TYPE_SQ, qp->sq.db_index);
 		mthca_free_db(dev, MTHCA_DB_TYPE_RQ, qp->rq.db_index);
+		mthca_table_put(dev, dev->qp_table.rdb_table,
+				qp->qpn << dev->qp_table.rdb_shift);
 		mthca_table_put(dev, dev->qp_table.eqp_table, qp->qpn);
 		mthca_table_put(dev, dev->qp_table.qp_table, qp->qpn);
 	}

