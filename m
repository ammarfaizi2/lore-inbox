Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262794AbVCCXzW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262794AbVCCXzW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 18:55:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262735AbVCCXyQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 18:54:16 -0500
Received: from umhlanga.stratnet.net ([12.162.17.40]:53494 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S262733AbVCCXWP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 18:22:15 -0500
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: [PATCH][10/26] IB/mthca: mem-free memory region support
In-Reply-To: <2005331520.nfKPjEcWG6DlwOqo@topspin.com>
X-Mailer: Roland's Patchbomber
Date: Thu, 3 Mar 2005 15:20:27 -0800
Message-Id: <2005331520.6xlwh79w94Kl0EpH@topspin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: akpm@osdl.org
Content-Transfer-Encoding: 7BIT
From: Roland Dreier <roland@topspin.com>
X-OriginalArrivalTime: 03 Mar 2005 23:20:27.0613 (UTC) FILETIME=[95B178D0:01C52047]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for mem-free mode to memory region code.  This mostly
amounts to properly munging between keys and indices.

Signed-off-by: Roland Dreier <roland@topspin.com>


--- linux-export.orig/drivers/infiniband/hw/mthca/mthca_mr.c	2005-01-15 15:16:11.000000000 -0800
+++ linux-export/drivers/infiniband/hw/mthca/mthca_mr.c	2005-03-03 14:12:57.165512841 -0800
@@ -53,7 +53,8 @@
 	u32 window_count;
 	u32 window_count_limit;
 	u64 mtt_seg;
-	u32 reserved[3];
+	u32 mtt_sz;		/* Arbel only */
+	u32 reserved[2];
 } __attribute__((packed));
 
 #define MTHCA_MPT_FLAG_SW_OWNS       (0xfUL << 28)
@@ -121,21 +122,38 @@
 	spin_unlock(&dev->mr_table.mpt_alloc.lock);
 }
 
+static inline u32 hw_index_to_key(struct mthca_dev *dev, u32 ind)
+{
+	if (dev->hca_type == ARBEL_NATIVE)
+		return (ind >> 24) | (ind << 8);
+	else
+		return ind;
+}
+
+static inline u32 key_to_hw_index(struct mthca_dev *dev, u32 key)
+{
+	if (dev->hca_type == ARBEL_NATIVE)
+		return (key << 24) | (key >> 8);
+	else
+		return key;
+}
+
 int mthca_mr_alloc_notrans(struct mthca_dev *dev, u32 pd,
 			   u32 access, struct mthca_mr *mr)
 {
 	void *mailbox;
 	struct mthca_mpt_entry *mpt_entry;
+	u32 key;
 	int err;
 	u8 status;
 
 	might_sleep();
 
 	mr->order = -1;
-	mr->ibmr.lkey = mthca_alloc(&dev->mr_table.mpt_alloc);
-	if (mr->ibmr.lkey == -1)
+	key = mthca_alloc(&dev->mr_table.mpt_alloc);
+	if (key == -1)
 		return -ENOMEM;
-	mr->ibmr.rkey = mr->ibmr.lkey;
+	mr->ibmr.rkey = mr->ibmr.lkey = hw_index_to_key(dev, key);
 
 	mailbox = kmalloc(sizeof *mpt_entry + MTHCA_CMD_MAILBOX_EXTRA,
 			  GFP_KERNEL);
@@ -151,7 +169,7 @@
 				       MTHCA_MPT_FLAG_REGION      |
 				       access);
 	mpt_entry->page_size = 0;
-	mpt_entry->key       = cpu_to_be32(mr->ibmr.lkey);
+	mpt_entry->key       = cpu_to_be32(key);
 	mpt_entry->pd        = cpu_to_be32(pd);
 	mpt_entry->start     = 0;
 	mpt_entry->length    = ~0ULL;
@@ -160,7 +178,7 @@
 	       sizeof *mpt_entry - offsetof(struct mthca_mpt_entry, lkey));
 
 	err = mthca_SW2HW_MPT(dev, mpt_entry,
-			      mr->ibmr.lkey & (dev->limits.num_mpts - 1),
+			      key & (dev->limits.num_mpts - 1),
 			      &status);
 	if (err)
 		mthca_warn(dev, "SW2HW_MPT failed (%d)\n", err);
@@ -182,6 +200,7 @@
 	void *mailbox;
 	u64 *mtt_entry;
 	struct mthca_mpt_entry *mpt_entry;
+	u32 key;
 	int err = -ENOMEM;
 	u8 status;
 	int i;
@@ -189,10 +208,10 @@
 	might_sleep();
 	WARN_ON(buffer_size_shift >= 32);
 
-	mr->ibmr.lkey = mthca_alloc(&dev->mr_table.mpt_alloc);
-	if (mr->ibmr.lkey == -1)
+	key = mthca_alloc(&dev->mr_table.mpt_alloc);
+	if (key == -1)
 		return -ENOMEM;
-	mr->ibmr.rkey = mr->ibmr.lkey;
+	mr->ibmr.rkey = mr->ibmr.lkey = hw_index_to_key(dev, key);
 
 	for (i = dev->limits.mtt_seg_size / 8, mr->order = 0;
 	     i < list_len;
@@ -254,7 +273,7 @@
 				       access);
 
 	mpt_entry->page_size = cpu_to_be32(buffer_size_shift - 12);
-	mpt_entry->key       = cpu_to_be32(mr->ibmr.lkey);
+	mpt_entry->key       = cpu_to_be32(key);
 	mpt_entry->pd        = cpu_to_be32(pd);
 	mpt_entry->start     = cpu_to_be64(iova);
 	mpt_entry->length    = cpu_to_be64(total_size);
@@ -275,7 +294,7 @@
 	}
 
 	err = mthca_SW2HW_MPT(dev, mpt_entry,
-			      mr->ibmr.lkey & (dev->limits.num_mpts - 1),
+			      key & (dev->limits.num_mpts - 1),
 			      &status);
 	if (err)
 		mthca_warn(dev, "SW2HW_MPT failed (%d)\n", err);
@@ -307,7 +326,8 @@
 	might_sleep();
 
 	err = mthca_HW2SW_MPT(dev, NULL,
-			      mr->ibmr.lkey & (dev->limits.num_mpts - 1),
+			      key_to_hw_index(dev, mr->ibmr.lkey) &
+			      (dev->limits.num_mpts - 1),
 			      &status);
 	if (err)
 		mthca_warn(dev, "HW2SW_MPT failed (%d)\n", err);
@@ -318,7 +338,7 @@
 	if (mr->order >= 0)
 		mthca_free_mtt(dev, mr->first_seg, mr->order);
 
-	mthca_free(&dev->mr_table.mpt_alloc, mr->ibmr.lkey);
+	mthca_free(&dev->mr_table.mpt_alloc, key_to_hw_index(dev, mr->ibmr.lkey));
 }
 
 int __devinit mthca_init_mr_table(struct mthca_dev *dev)

