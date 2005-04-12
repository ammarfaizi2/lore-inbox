Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262273AbVDLKnP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262273AbVDLKnP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 06:43:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262321AbVDLKmM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 06:42:12 -0400
Received: from fire.osdl.org ([65.172.181.4]:39882 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262273AbVDLKdW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 06:33:22 -0400
Message-Id: <200504121033.j3CAXCvJ005819@shell0.pdx.osdl.net>
Subject: [patch 163/198] IB/mthca: map MPT/MTT context in mem-free mode
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, roland@topspin.com
From: akpm@osdl.org
Date: Tue, 12 Apr 2005 03:33:06 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Roland Dreier <roland@topspin.com>

In mem-free mode, when allocating memory regions, make sure that the HCA has
context memory mapped to cover the virtual space used for the MPT and MTTs
being used.

Signed-off-by: Roland Dreier <roland@topspin.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/drivers/infiniband/hw/mthca/mthca_main.c    |    2 
 25-akpm/drivers/infiniband/hw/mthca/mthca_memfree.c |   32 ++++++++
 25-akpm/drivers/infiniband/hw/mthca/mthca_memfree.h |    4 +
 25-akpm/drivers/infiniband/hw/mthca/mthca_mr.c      |   79 +++++++++++++++++---
 4 files changed, 105 insertions(+), 12 deletions(-)

diff -puN drivers/infiniband/hw/mthca/mthca_main.c~ib-mthca-map-mpt-mtt-context-in-mem-free-mode drivers/infiniband/hw/mthca/mthca_main.c
--- 25/drivers/infiniband/hw/mthca/mthca_main.c~ib-mthca-map-mpt-mtt-context-in-mem-free-mode	2005-04-12 03:21:42.388692840 -0700
+++ 25-akpm/drivers/infiniband/hw/mthca/mthca_main.c	2005-04-12 03:21:42.395691776 -0700
@@ -390,7 +390,7 @@ static int __devinit mthca_init_icm(stru
 	}
 
 	mdev->mr_table.mtt_table = mthca_alloc_icm_table(mdev, init_hca->mtt_base,
-							 init_hca->mtt_seg_sz,
+							 dev_lim->mtt_seg_sz,
 							 mdev->limits.num_mtt_segs,
 							 mdev->limits.reserved_mtts, 1);
 	if (!mdev->mr_table.mtt_table) {
diff -puN drivers/infiniband/hw/mthca/mthca_memfree.c~ib-mthca-map-mpt-mtt-context-in-mem-free-mode drivers/infiniband/hw/mthca/mthca_memfree.c
--- 25/drivers/infiniband/hw/mthca/mthca_memfree.c~ib-mthca-map-mpt-mtt-context-in-mem-free-mode	2005-04-12 03:21:42.389692688 -0700
+++ 25-akpm/drivers/infiniband/hw/mthca/mthca_memfree.c	2005-04-12 03:21:42.396691624 -0700
@@ -192,6 +192,38 @@ void mthca_table_put(struct mthca_dev *d
 	up(&table->mutex);
 }
 
+int mthca_table_get_range(struct mthca_dev *dev, struct mthca_icm_table *table,
+			  int start, int end)
+{
+	int inc = MTHCA_TABLE_CHUNK_SIZE / table->obj_size;
+	int i, err;
+
+	for (i = start; i <= end; i += inc) {
+		err = mthca_table_get(dev, table, i);
+		if (err)
+			goto fail;
+	}
+
+	return 0;
+
+fail:
+	while (i > start) {
+		i -= inc;
+		mthca_table_put(dev, table, i);
+	}
+
+	return err;
+}
+
+void mthca_table_put_range(struct mthca_dev *dev, struct mthca_icm_table *table,
+			   int start, int end)
+{
+	int i;
+
+	for (i = start; i <= end; i += MTHCA_TABLE_CHUNK_SIZE / table->obj_size)
+		mthca_table_put(dev, table, i);
+}
+
 struct mthca_icm_table *mthca_alloc_icm_table(struct mthca_dev *dev,
 					      u64 virt, int obj_size,
 					      int nobj, int reserved,
diff -puN drivers/infiniband/hw/mthca/mthca_memfree.h~ib-mthca-map-mpt-mtt-context-in-mem-free-mode drivers/infiniband/hw/mthca/mthca_memfree.h
--- 25/drivers/infiniband/hw/mthca/mthca_memfree.h~ib-mthca-map-mpt-mtt-context-in-mem-free-mode	2005-04-12 03:21:42.391692384 -0700
+++ 25-akpm/drivers/infiniband/hw/mthca/mthca_memfree.h	2005-04-12 03:21:42.397691472 -0700
@@ -85,6 +85,10 @@ struct mthca_icm_table *mthca_alloc_icm_
 void mthca_free_icm_table(struct mthca_dev *dev, struct mthca_icm_table *table);
 int mthca_table_get(struct mthca_dev *dev, struct mthca_icm_table *table, int obj);
 void mthca_table_put(struct mthca_dev *dev, struct mthca_icm_table *table, int obj);
+int mthca_table_get_range(struct mthca_dev *dev, struct mthca_icm_table *table,
+			  int start, int end);
+void mthca_table_put_range(struct mthca_dev *dev, struct mthca_icm_table *table,
+			   int start, int end);
 
 static inline void mthca_icm_first(struct mthca_icm *icm,
 				   struct mthca_icm_iter *iter)
diff -puN drivers/infiniband/hw/mthca/mthca_mr.c~ib-mthca-map-mpt-mtt-context-in-mem-free-mode drivers/infiniband/hw/mthca/mthca_mr.c
--- 25/drivers/infiniband/hw/mthca/mthca_mr.c~ib-mthca-map-mpt-mtt-context-in-mem-free-mode	2005-04-12 03:21:42.392692232 -0700
+++ 25-akpm/drivers/infiniband/hw/mthca/mthca_mr.c	2005-04-12 03:21:42.398691320 -0700
@@ -38,6 +38,7 @@
 
 #include "mthca_dev.h"
 #include "mthca_cmd.h"
+#include "mthca_memfree.h"
 
 /*
  * Must be packed because mtt_seg is 64 bits but only aligned to 32 bits.
@@ -71,7 +72,7 @@ struct mthca_mpt_entry {
  * through the bitmaps)
  */
 
-static u32 mthca_alloc_mtt(struct mthca_dev *dev, int order)
+static u32 __mthca_alloc_mtt(struct mthca_dev *dev, int order)
 {
 	int o;
 	int m;
@@ -105,7 +106,7 @@ static u32 mthca_alloc_mtt(struct mthca_
 	return seg;
 }
 
-static void mthca_free_mtt(struct mthca_dev *dev, u32 seg, int order)
+static void __mthca_free_mtt(struct mthca_dev *dev, u32 seg, int order)
 {
 	seg >>= order;
 
@@ -122,6 +123,32 @@ static void mthca_free_mtt(struct mthca_
 	spin_unlock(&dev->mr_table.mpt_alloc.lock);
 }
 
+static u32 mthca_alloc_mtt(struct mthca_dev *dev, int order)
+{
+	u32 seg = __mthca_alloc_mtt(dev, order);
+
+	if (seg == -1)
+		return -1;
+
+	if (dev->hca_type == ARBEL_NATIVE)
+		if (mthca_table_get_range(dev, dev->mr_table.mtt_table, seg,
+					  seg + (1 << order) - 1)) {
+			__mthca_free_mtt(dev, seg, order);
+			seg = -1;
+		}
+
+	return seg;
+}
+
+static void mthca_free_mtt(struct mthca_dev *dev, u32 seg, int order)
+{
+	__mthca_free_mtt(dev, seg, order);
+
+	if (dev->hca_type == ARBEL_NATIVE)
+		mthca_table_put_range(dev, dev->mr_table.mtt_table, seg,
+				      seg + (1 << order) - 1);
+}
+
 static inline u32 hw_index_to_key(struct mthca_dev *dev, u32 ind)
 {
 	if (dev->hca_type == ARBEL_NATIVE)
@@ -141,7 +168,7 @@ static inline u32 key_to_hw_index(struct
 int mthca_mr_alloc_notrans(struct mthca_dev *dev, u32 pd,
 			   u32 access, struct mthca_mr *mr)
 {
-	void *mailbox;
+	void *mailbox = NULL;
 	struct mthca_mpt_entry *mpt_entry;
 	u32 key;
 	int err;
@@ -155,11 +182,17 @@ int mthca_mr_alloc_notrans(struct mthca_
 		return -ENOMEM;
 	mr->ibmr.rkey = mr->ibmr.lkey = hw_index_to_key(dev, key);
 
+	if (dev->hca_type == ARBEL_NATIVE) {
+		err = mthca_table_get(dev, dev->mr_table.mpt_table, key);
+		if (err)
+			goto err_out_mpt_free;
+	}
+
 	mailbox = kmalloc(sizeof *mpt_entry + MTHCA_CMD_MAILBOX_EXTRA,
 			  GFP_KERNEL);
 	if (!mailbox) {
-		mthca_free(&dev->mr_table.mpt_alloc, mr->ibmr.lkey);
-		return -ENOMEM;
+		err = -ENOMEM;
+		goto err_out_table;
 	}
 	mpt_entry = MAILBOX_ALIGN(mailbox);
 
@@ -180,16 +213,27 @@ int mthca_mr_alloc_notrans(struct mthca_
 	err = mthca_SW2HW_MPT(dev, mpt_entry,
 			      key & (dev->limits.num_mpts - 1),
 			      &status);
-	if (err)
+	if (err) {
 		mthca_warn(dev, "SW2HW_MPT failed (%d)\n", err);
-	else if (status) {
+		goto err_out_table;
+	} else if (status) {
 		mthca_warn(dev, "SW2HW_MPT returned status 0x%02x\n",
 			   status);
 		err = -EINVAL;
+		goto err_out_table;
 	}
 
 	kfree(mailbox);
 	return err;
+
+err_out_table:
+	if (dev->hca_type == ARBEL_NATIVE)
+		mthca_table_put(dev, dev->mr_table.mpt_table, key);
+
+err_out_mpt_free:
+	mthca_free(&dev->mr_table.mpt_alloc, mr->ibmr.lkey);
+	kfree(mailbox);
+	return err;
 }
 
 int mthca_mr_alloc_phys(struct mthca_dev *dev, u32 pd,
@@ -213,6 +257,12 @@ int mthca_mr_alloc_phys(struct mthca_dev
 		return -ENOMEM;
 	mr->ibmr.rkey = mr->ibmr.lkey = hw_index_to_key(dev, key);
 
+	if (dev->hca_type == ARBEL_NATIVE) {
+		err = mthca_table_get(dev, dev->mr_table.mpt_table, key);
+		if (err)
+			goto err_out_mpt_free;
+	}
+
 	for (i = dev->limits.mtt_seg_size / 8, mr->order = 0;
 	     i < list_len;
 	     i <<= 1, ++mr->order)
@@ -220,7 +270,7 @@ int mthca_mr_alloc_phys(struct mthca_dev
 
 	mr->first_seg = mthca_alloc_mtt(dev, mr->order);
 	if (mr->first_seg == -1)
-		goto err_out_mpt_free;
+		goto err_out_table;
 
 	/*
 	 * If list_len is odd, we add one more dummy entry for
@@ -307,13 +357,17 @@ int mthca_mr_alloc_phys(struct mthca_dev
 	kfree(mailbox);
 	return err;
 
- err_out_mailbox_free:
+err_out_mailbox_free:
 	kfree(mailbox);
 
- err_out_free_mtt:
+err_out_free_mtt:
 	mthca_free_mtt(dev, mr->first_seg, mr->order);
 
- err_out_mpt_free:
+err_out_table:
+	if (dev->hca_type == ARBEL_NATIVE)
+		mthca_table_put(dev, dev->mr_table.mpt_table, key);
+
+err_out_mpt_free:
 	mthca_free(&dev->mr_table.mpt_alloc, mr->ibmr.lkey);
 	return err;
 }
@@ -338,6 +392,9 @@ void mthca_free_mr(struct mthca_dev *dev
 	if (mr->order >= 0)
 		mthca_free_mtt(dev, mr->first_seg, mr->order);
 
+	if (dev->hca_type == ARBEL_NATIVE)
+		mthca_table_put(dev, dev->mr_table.mpt_table,
+				key_to_hw_index(dev, mr->ibmr.lkey));
 	mthca_free(&dev->mr_table.mpt_alloc, key_to_hw_index(dev, mr->ibmr.lkey));
 }
 
_
