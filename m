Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262886AbVDAUxq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262886AbVDAUxq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 15:53:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262917AbVDAUxp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 15:53:45 -0500
Received: from webmail.topspin.com ([12.162.17.3]:35887 "EHLO
	exch-1.topspincom.com") by vger.kernel.org with ESMTP
	id S262886AbVDAUvA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 15:51:00 -0500
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: [PATCH][1/27] IB/mthca: map MPT/MTT context in mem-free mode
In-Reply-To: 
X-Mailer: Roland's Patchbomber
Date: Fri, 1 Apr 2005 12:49:52 -0800
Message-Id: <2005411249.NCfupdZrkMmfcKnV@topspin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: akpm@osdl.org
Content-Transfer-Encoding: 7BIT
From: Roland Dreier <roland@topspin.com>
X-OriginalArrivalTime: 01 Apr 2005 20:49:52.0231 (UTC) FILETIME=[5A2A5770:01C536FC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In mem-free mode, when allocating memory regions, make sure that the
HCA has context memory mapped to cover the virtual space used for the
MPT and MTTs being used.

Signed-off-by: Roland Dreier <roland@topspin.com>


--- linux-export.orig/drivers/infiniband/hw/mthca/mthca_main.c	2005-03-31 19:06:51.000000000 -0800
+++ linux-export/drivers/infiniband/hw/mthca/mthca_main.c	2005-04-01 12:38:19.884644268 -0800
@@ -390,7 +390,7 @@
 	}
 
 	mdev->mr_table.mtt_table = mthca_alloc_icm_table(mdev, init_hca->mtt_base,
-							 init_hca->mtt_seg_sz,
+							 dev_lim->mtt_seg_sz,
 							 mdev->limits.num_mtt_segs,
 							 mdev->limits.reserved_mtts, 1);
 	if (!mdev->mr_table.mtt_table) {
--- linux-export.orig/drivers/infiniband/hw/mthca/mthca_memfree.c	2005-03-31 19:06:42.000000000 -0800
+++ linux-export/drivers/infiniband/hw/mthca/mthca_memfree.c	2005-04-01 12:38:19.911638409 -0800
@@ -192,6 +192,38 @@
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
--- linux-export.orig/drivers/infiniband/hw/mthca/mthca_memfree.h	2005-03-31 19:06:56.000000000 -0800
+++ linux-export/drivers/infiniband/hw/mthca/mthca_memfree.h	2005-04-01 12:38:19.895641881 -0800
@@ -85,6 +85,10 @@
 void mthca_free_icm_table(struct mthca_dev *dev, struct mthca_icm_table *table);
 int mthca_table_get(struct mthca_dev *dev, struct mthca_icm_table *table, int obj);
 void mthca_table_put(struct mthca_dev *dev, struct mthca_icm_table *table, int obj);
+int mthca_table_get_range(struct mthca_dev *dev, struct mthca_icm_table *table,
+			  int start, int end);
+void mthca_table_put_range(struct mthca_dev *dev, struct mthca_icm_table *table,
+			   int start, int end);
 
 static inline void mthca_icm_first(struct mthca_icm *icm,
 				   struct mthca_icm_iter *iter)
--- linux-export.orig/drivers/infiniband/hw/mthca/mthca_mr.c	2005-03-31 19:07:06.000000000 -0800
+++ linux-export/drivers/infiniband/hw/mthca/mthca_mr.c	2005-04-01 12:38:19.903640145 -0800
@@ -38,6 +38,7 @@
 
 #include "mthca_dev.h"
 #include "mthca_cmd.h"
+#include "mthca_memfree.h"
 
 /*
  * Must be packed because mtt_seg is 64 bits but only aligned to 32 bits.
@@ -71,7 +72,7 @@
  * through the bitmaps)
  */
 
-static u32 mthca_alloc_mtt(struct mthca_dev *dev, int order)
+static u32 __mthca_alloc_mtt(struct mthca_dev *dev, int order)
 {
 	int o;
 	int m;
@@ -105,7 +106,7 @@
 	return seg;
 }
 
-static void mthca_free_mtt(struct mthca_dev *dev, u32 seg, int order)
+static void __mthca_free_mtt(struct mthca_dev *dev, u32 seg, int order)
 {
 	seg >>= order;
 
@@ -122,6 +123,32 @@
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
@@ -141,7 +168,7 @@
 int mthca_mr_alloc_notrans(struct mthca_dev *dev, u32 pd,
 			   u32 access, struct mthca_mr *mr)
 {
-	void *mailbox;
+	void *mailbox = NULL;
 	struct mthca_mpt_entry *mpt_entry;
 	u32 key;
 	int err;
@@ -155,11 +182,17 @@
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
 
@@ -180,16 +213,27 @@
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
@@ -213,6 +257,12 @@
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
@@ -220,7 +270,7 @@
 
 	mr->first_seg = mthca_alloc_mtt(dev, mr->order);
 	if (mr->first_seg == -1)
-		goto err_out_mpt_free;
+		goto err_out_table;
 
 	/*
 	 * If list_len is odd, we add one more dummy entry for
@@ -307,13 +357,17 @@
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
@@ -338,6 +392,9 @@
 	if (mr->order >= 0)
 		mthca_free_mtt(dev, mr->first_seg, mr->order);
 
+	if (dev->hca_type == ARBEL_NATIVE)
+		mthca_table_put(dev, dev->mr_table.mpt_table,
+				key_to_hw_index(dev, mr->ibmr.lkey));
 	mthca_free(&dev->mr_table.mpt_alloc, key_to_hw_index(dev, mr->ibmr.lkey));
 }
 

