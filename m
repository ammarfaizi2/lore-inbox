Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262796AbVCDAAC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262796AbVCDAAC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 19:00:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262795AbVCCX6o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 18:58:44 -0500
Received: from umhlanga.stratnet.net ([12.162.17.40]:53494 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S262731AbVCCXWM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 18:22:12 -0500
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: [PATCH][9/26] IB/mthca: dynamic context memory mapping for mem-free mode
In-Reply-To: <2005331520.qwFp6OBqldRd6oo8@topspin.com>
X-Mailer: Roland's Patchbomber
Date: Thu, 3 Mar 2005 15:20:27 -0800
Message-Id: <2005331520.nfKPjEcWG6DlwOqo@topspin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: akpm@osdl.org
Content-Transfer-Encoding: 7BIT
From: Roland Dreier <roland@topspin.com>
X-OriginalArrivalTime: 03 Mar 2005 23:20:27.0550 (UTC) FILETIME=[95A7DBE0:01C52047]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for mapping more memory into HCA's context to cover
context tables when new objects are allocated.  Pass the object
size into mthca_alloc_icm_table(), reference count the ICM chunks,
and add new mthca_table_get() and mthca_table_put() functions to
handle mapping memory when allocating or destroying objects.

Signed-off-by: Roland Dreier <roland@topspin.com>


--- linux-export.orig/drivers/infiniband/hw/mthca/mthca_main.c	2005-03-03 14:12:56.152732681 -0800
+++ linux-export/drivers/infiniband/hw/mthca/mthca_main.c	2005-03-03 14:12:56.772598129 -0800
@@ -363,10 +363,9 @@
 	}
 
 	mdev->mr_table.mtt_table = mthca_alloc_icm_table(mdev, init_hca->mtt_base,
-							 mdev->limits.num_mtt_segs *
 							 init_hca->mtt_seg_sz,
-							 mdev->limits.reserved_mtts *
-							 init_hca->mtt_seg_sz, 1);
+							 mdev->limits.num_mtt_segs,
+							 mdev->limits.reserved_mtts, 1);
 	if (!mdev->mr_table.mtt_table) {
 		mthca_err(mdev, "Failed to map MTT context memory, aborting.\n");
 		err = -ENOMEM;
@@ -374,10 +373,9 @@
 	}
 
 	mdev->mr_table.mpt_table = mthca_alloc_icm_table(mdev, init_hca->mpt_base,
-							 mdev->limits.num_mpts *
 							 dev_lim->mpt_entry_sz,
-							 mdev->limits.reserved_mrws *
-							 dev_lim->mpt_entry_sz, 1);
+							 mdev->limits.num_mpts,
+							 mdev->limits.reserved_mrws, 1);
 	if (!mdev->mr_table.mpt_table) {
 		mthca_err(mdev, "Failed to map MPT context memory, aborting.\n");
 		err = -ENOMEM;
@@ -385,10 +383,9 @@
 	}
 
 	mdev->qp_table.qp_table = mthca_alloc_icm_table(mdev, init_hca->qpc_base,
-							mdev->limits.num_qps *
 							dev_lim->qpc_entry_sz,
-							mdev->limits.reserved_qps *
-							dev_lim->qpc_entry_sz, 1);
+							mdev->limits.num_qps,
+							mdev->limits.reserved_qps, 0);
 	if (!mdev->qp_table.qp_table) {
 		mthca_err(mdev, "Failed to map QP context memory, aborting.\n");
 		err = -ENOMEM;
@@ -396,10 +393,9 @@
 	}
 
 	mdev->qp_table.eqp_table = mthca_alloc_icm_table(mdev, init_hca->eqpc_base,
-							 mdev->limits.num_qps *
 							 dev_lim->eqpc_entry_sz,
-							 mdev->limits.reserved_qps *
-							 dev_lim->eqpc_entry_sz, 1);
+							 mdev->limits.num_qps,
+							 mdev->limits.reserved_qps, 0);
 	if (!mdev->qp_table.eqp_table) {
 		mthca_err(mdev, "Failed to map EQP context memory, aborting.\n");
 		err = -ENOMEM;
@@ -407,10 +403,9 @@
 	}
 
 	mdev->cq_table.table = mthca_alloc_icm_table(mdev, init_hca->cqc_base,
-						     mdev->limits.num_cqs *
 						     dev_lim->cqc_entry_sz,
-						     mdev->limits.reserved_cqs *
-						     dev_lim->cqc_entry_sz, 1);
+						     mdev->limits.num_cqs,
+						     mdev->limits.reserved_cqs, 0);
 	if (!mdev->cq_table.table) {
 		mthca_err(mdev, "Failed to map CQ context memory, aborting.\n");
 		err = -ENOMEM;
--- linux-export.orig/drivers/infiniband/hw/mthca/mthca_memfree.c	2005-01-25 20:46:29.000000000 -0800
+++ linux-export/drivers/infiniband/hw/mthca/mthca_memfree.c	2005-03-03 14:12:56.773597912 -0800
@@ -79,6 +79,7 @@
 	if (!icm)
 		return icm;
 
+	icm->refcount = 0;
 	INIT_LIST_HEAD(&icm->chunk_list);
 
 	cur_order = get_order(MTHCA_ICM_ALLOC_SIZE);
@@ -138,9 +139,62 @@
 	return NULL;
 }
 
+int mthca_table_get(struct mthca_dev *dev, struct mthca_icm_table *table, int obj)
+{
+	int i = (obj & (table->num_obj - 1)) * table->obj_size / MTHCA_TABLE_CHUNK_SIZE;
+	int ret = 0;
+	u8 status;
+
+	down(&table->mutex);
+
+	if (table->icm[i]) {
+		++table->icm[i]->refcount;
+		goto out;
+	}
+
+	table->icm[i] = mthca_alloc_icm(dev, MTHCA_TABLE_CHUNK_SIZE >> PAGE_SHIFT,
+					(table->lowmem ? GFP_KERNEL : GFP_HIGHUSER) |
+					__GFP_NOWARN);
+	if (!table->icm[i]) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	if (mthca_MAP_ICM(dev, table->icm[i], table->virt + i * MTHCA_TABLE_CHUNK_SIZE,
+			  &status) || status) {
+		mthca_free_icm(dev, table->icm[i]);
+		table->icm[i] = NULL;
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	++table->icm[i]->refcount;
+
+out:
+	up(&table->mutex);
+	return ret;
+}
+
+void mthca_table_put(struct mthca_dev *dev, struct mthca_icm_table *table, int obj)
+{
+	int i = (obj & (table->num_obj - 1)) * table->obj_size / MTHCA_TABLE_CHUNK_SIZE;
+	u8 status;
+
+	down(&table->mutex);
+
+	if (--table->icm[i]->refcount == 0) {
+		mthca_UNMAP_ICM(dev, table->virt + i * MTHCA_TABLE_CHUNK_SIZE,
+				MTHCA_TABLE_CHUNK_SIZE >> 12, &status);
+		mthca_free_icm(dev, table->icm[i]);
+		table->icm[i] = NULL;
+	}
+
+	up(&table->mutex);
+}
+
 struct mthca_icm_table *mthca_alloc_icm_table(struct mthca_dev *dev,
-					      u64 virt, unsigned size,
-					      unsigned reserved,
+					      u64 virt, int obj_size,
+					      int nobj, int reserved,
 					      int use_lowmem)
 {
 	struct mthca_icm_table *table;
@@ -148,20 +202,23 @@
 	int i;
 	u8 status;
 
-	num_icm = size / MTHCA_TABLE_CHUNK_SIZE;
+	num_icm = obj_size * nobj / MTHCA_TABLE_CHUNK_SIZE;
 
 	table = kmalloc(sizeof *table + num_icm * sizeof *table->icm, GFP_KERNEL);
 	if (!table)
 		return NULL;
 
-	table->virt    = virt;
-	table->num_icm = num_icm;
-	init_MUTEX(&table->sem);
+	table->virt     = virt;
+	table->num_icm  = num_icm;
+	table->num_obj  = nobj;
+	table->obj_size = obj_size;
+	table->lowmem   = use_lowmem;
+	init_MUTEX(&table->mutex);
 
 	for (i = 0; i < num_icm; ++i)
 		table->icm[i] = NULL;
 
-	for (i = 0; i < (reserved + MTHCA_TABLE_CHUNK_SIZE - 1) / MTHCA_TABLE_CHUNK_SIZE; ++i) {
+	for (i = 0; i * MTHCA_TABLE_CHUNK_SIZE < reserved * obj_size; ++i) {
 		table->icm[i] = mthca_alloc_icm(dev, MTHCA_TABLE_CHUNK_SIZE >> PAGE_SHIFT,
 						(use_lowmem ? GFP_KERNEL : GFP_HIGHUSER) |
 						__GFP_NOWARN);
@@ -173,6 +230,12 @@
 			table->icm[i] = NULL;
 			goto err;
 		}
+
+		/*
+		 * Add a reference to this ICM chunk so that it never
+		 * gets freed (since it contains reserved firmware objects).
+		 */
+		++table->icm[i]->refcount;
 	}
 
 	return table;
--- linux-export.orig/drivers/infiniband/hw/mthca/mthca_memfree.h	2005-01-25 20:46:29.000000000 -0800
+++ linux-export/drivers/infiniband/hw/mthca/mthca_memfree.h	2005-03-03 14:12:56.773597912 -0800
@@ -53,12 +53,16 @@
 
 struct mthca_icm {
 	struct list_head chunk_list;
+	int              refcount;
 };
 
 struct mthca_icm_table {
 	u64               virt;
 	int               num_icm;
-	struct semaphore  sem;
+	int               num_obj;
+	int               obj_size;
+	int               lowmem;
+	struct semaphore  mutex;
 	struct mthca_icm *icm[0];
 };
 
@@ -75,10 +79,12 @@
 void mthca_free_icm(struct mthca_dev *dev, struct mthca_icm *icm);
 
 struct mthca_icm_table *mthca_alloc_icm_table(struct mthca_dev *dev,
-					      u64 virt, unsigned size,
-					      unsigned reserved,
+					      u64 virt, int obj_size,
+					      int nobj, int reserved,
 					      int use_lowmem);
 void mthca_free_icm_table(struct mthca_dev *dev, struct mthca_icm_table *table);
+int mthca_table_get(struct mthca_dev *dev, struct mthca_icm_table *table, int obj);
+void mthca_table_put(struct mthca_dev *dev, struct mthca_icm_table *table, int obj);
 
 static inline void mthca_icm_first(struct mthca_icm *icm,
 				   struct mthca_icm_iter *iter)

