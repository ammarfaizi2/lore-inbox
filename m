Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263097AbVFXEU2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263097AbVFXEU2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Jun 2005 00:20:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263113AbVFXEMI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Jun 2005 00:12:08 -0400
Received: from webmail.topspin.com ([12.162.17.3]:33605 "EHLO
	exch-1.topspincom.com") by vger.kernel.org with ESMTP
	id S263098AbVFXEEZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Jun 2005 00:04:25 -0400
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: [PATCH 10/14] IB/mthca: Split off MTT allocation
In-Reply-To: <2005623214.PWhRmdueOgH2vhWW@topspin.com>
X-Mailer: Roland's Patchbomber
Date: Thu, 23 Jun 2005 21:04:20 -0700
Message-Id: <2005623214.fUJVvXKwjz2o8abB@topspin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: akpm@osdl.org
Content-Transfer-Encoding: 7BIT
From: Roland Dreier <roland@topspin.com>
X-OriginalArrivalTime: 24 Jun 2005 04:04:21.0089 (UTC) FILETIME=[CCB3A510:01C57871]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Split allocation of MTT range from creation of MR.  This will be
useful for implementing shared memory regions and userspace verbs.

Signed-off-by: Roland Dreier <roland@topspin.com>

---

 linux.git/drivers/infiniband/hw/mthca/mthca_dev.h      |    6 
 linux.git/drivers/infiniband/hw/mthca/mthca_mr.c       |  325 +++++++++++++--------------
 linux.git/drivers/infiniband/hw/mthca/mthca_provider.h |   14 -
 3 files changed, 177 insertions(+), 168 deletions(-)



--- linux.git.orig/drivers/infiniband/hw/mthca/mthca_dev.h	2005-06-23 13:03:02.630547703 -0700
+++ linux.git/drivers/infiniband/hw/mthca/mthca_dev.h	2005-06-23 13:03:07.308535271 -0700
@@ -380,6 +380,12 @@ void mthca_uar_free(struct mthca_dev *de
 int mthca_pd_alloc(struct mthca_dev *dev, struct mthca_pd *pd);
 void mthca_pd_free(struct mthca_dev *dev, struct mthca_pd *pd);
 
+struct mthca_mtt *mthca_alloc_mtt(struct mthca_dev *dev, int size);
+void mthca_free_mtt(struct mthca_dev *dev, struct mthca_mtt *mtt);
+int mthca_write_mtt(struct mthca_dev *dev, struct mthca_mtt *mtt,
+		    int start_index, u64 *buffer_list, int list_len);
+int mthca_mr_alloc(struct mthca_dev *dev, u32 pd, int buffer_size_shift,
+		   u64 iova, u64 total_size, u32 access, struct mthca_mr *mr);
 int mthca_mr_alloc_notrans(struct mthca_dev *dev, u32 pd,
 			   u32 access, struct mthca_mr *mr);
 int mthca_mr_alloc_phys(struct mthca_dev *dev, u32 pd,
--- linux.git.orig/drivers/infiniband/hw/mthca/mthca_mr.c	2005-06-23 13:03:06.792646922 -0700
+++ linux.git/drivers/infiniband/hw/mthca/mthca_mr.c	2005-06-23 13:03:07.308535271 -0700
@@ -40,6 +40,12 @@
 #include "mthca_cmd.h"
 #include "mthca_memfree.h"
 
+struct mthca_mtt {
+	struct mthca_buddy *buddy;
+	int                 order;
+	u32                 first_seg;
+};
+
 /*
  * Must be packed because mtt_seg is 64 bits but only aligned to 32 bits.
  */
@@ -173,8 +179,8 @@ static void __devexit mthca_buddy_cleanu
 	kfree(buddy->bits);
 }
 
-static u32 mthca_alloc_mtt(struct mthca_dev *dev, int order,
-			   struct mthca_buddy *buddy)
+static u32 mthca_alloc_mtt_range(struct mthca_dev *dev, int order,
+				 struct mthca_buddy *buddy)
 {
 	u32 seg = mthca_buddy_alloc(buddy, order);
 
@@ -191,12 +197,100 @@ static u32 mthca_alloc_mtt(struct mthca_
 	return seg;
 }
 
-static void mthca_free_mtt(struct mthca_dev *dev, u32 seg, int order,
-			   struct mthca_buddy* buddy)
+static struct mthca_mtt *__mthca_alloc_mtt(struct mthca_dev *dev, int size,
+					   struct mthca_buddy *buddy)
+{
+	struct mthca_mtt *mtt;
+	int i;
+
+	if (size <= 0)
+		return ERR_PTR(-EINVAL);
+
+	mtt = kmalloc(sizeof *mtt, GFP_KERNEL);
+	if (!mtt)
+		return ERR_PTR(-ENOMEM);
+
+	mtt->buddy = buddy;
+	mtt->order = 0;
+	for (i = MTHCA_MTT_SEG_SIZE / 8; i < size; i <<= 1)
+		++mtt->order;
+
+	mtt->first_seg = mthca_alloc_mtt_range(dev, mtt->order, buddy);
+	if (mtt->first_seg == -1) {
+		kfree(mtt);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	return mtt;
+}
+
+struct mthca_mtt *mthca_alloc_mtt(struct mthca_dev *dev, int size)
+{
+	return __mthca_alloc_mtt(dev, size, &dev->mr_table.mtt_buddy);
+}
+
+void mthca_free_mtt(struct mthca_dev *dev, struct mthca_mtt *mtt)
+{
+	if (!mtt)
+		return;
+
+	mthca_buddy_free(mtt->buddy, mtt->first_seg, mtt->order);
+
+	mthca_table_put_range(dev, dev->mr_table.mtt_table,
+			      mtt->first_seg,
+			      mtt->first_seg + (1 << mtt->order) - 1);
+
+	kfree(mtt);
+}
+
+int mthca_write_mtt(struct mthca_dev *dev, struct mthca_mtt *mtt,
+		    int start_index, u64 *buffer_list, int list_len)
 {
-	mthca_buddy_free(buddy, seg, order);
-	mthca_table_put_range(dev, dev->mr_table.mtt_table, seg,
-			      seg + (1 << order) - 1);
+	u64 *mtt_entry;
+	int err = 0;
+	u8 status;
+	int i;
+
+	mtt_entry = (u64 *) __get_free_page(GFP_KERNEL);
+	if (!mtt_entry)
+		return -ENOMEM;
+
+	while (list_len > 0) {
+		mtt_entry[0] = cpu_to_be64(dev->mr_table.mtt_base +
+					   mtt->first_seg * MTHCA_MTT_SEG_SIZE +
+					   start_index * 8);
+		mtt_entry[1] = 0;
+		for (i = 0; i < list_len && i < PAGE_SIZE / 8 - 2; ++i)
+			mtt_entry[i + 2] = cpu_to_be64(buffer_list[i] |
+						       MTHCA_MTT_FLAG_PRESENT);
+
+		/*
+		 * If we have an odd number of entries to write, add
+		 * one more dummy entry for firmware efficiency.
+		 */
+		if (i & 1)
+			mtt_entry[i + 2] = 0;
+
+		err = mthca_WRITE_MTT(dev, mtt_entry, (i + 1) & ~1, &status);
+		if (err) {
+			mthca_warn(dev, "WRITE_MTT failed (%d)\n", err);
+			goto out;
+		}
+		if (status) {
+			mthca_warn(dev, "WRITE_MTT returned status 0x%02x\n",
+				   status);
+			err = -EINVAL;
+			goto out;
+		}
+
+		list_len    -= i;
+		start_index += i;
+		buffer_list += i;
+	}
+
+out:
+	free_page((unsigned long) mtt_entry);
+	return err;
 }
 
 static inline u32 tavor_hw_index_to_key(u32 ind)
@@ -235,18 +329,20 @@ static inline u32 key_to_hw_index(struct
 		return tavor_key_to_hw_index(key);
 }
 
-int mthca_mr_alloc_notrans(struct mthca_dev *dev, u32 pd,
-			   u32 access, struct mthca_mr *mr)
+int mthca_mr_alloc(struct mthca_dev *dev, u32 pd, int buffer_size_shift,
+		   u64 iova, u64 total_size, u32 access, struct mthca_mr *mr)
 {
-	void *mailbox = NULL;
+	void *mailbox;
 	struct mthca_mpt_entry *mpt_entry;
 	u32 key;
+	int i;
 	int err;
 	u8 status;
 
 	might_sleep();
 
-	mr->order = -1;
+	WARN_ON(buffer_size_shift >= 32);
+
 	key = mthca_alloc(&dev->mr_table.mpt_alloc);
 	if (key == -1)
 		return -ENOMEM;
@@ -268,186 +364,98 @@ int mthca_mr_alloc_notrans(struct mthca_
 
 	mpt_entry->flags = cpu_to_be32(MTHCA_MPT_FLAG_SW_OWNS     |
 				       MTHCA_MPT_FLAG_MIO         |
-				       MTHCA_MPT_FLAG_PHYSICAL    |
 				       MTHCA_MPT_FLAG_REGION      |
 				       access);
-	mpt_entry->page_size = 0;
+	if (!mr->mtt)
+		mpt_entry->flags |= cpu_to_be32(MTHCA_MPT_FLAG_PHYSICAL);
+
+	mpt_entry->page_size = cpu_to_be32(buffer_size_shift - 12);
 	mpt_entry->key       = cpu_to_be32(key);
 	mpt_entry->pd        = cpu_to_be32(pd);
-	mpt_entry->start     = 0;
-	mpt_entry->length    = ~0ULL;
+	mpt_entry->start     = cpu_to_be64(iova);
+	mpt_entry->length    = cpu_to_be64(total_size);
 
 	memset(&mpt_entry->lkey, 0,
 	       sizeof *mpt_entry - offsetof(struct mthca_mpt_entry, lkey));
 
+	if (mr->mtt)
+		mpt_entry->mtt_seg =
+			cpu_to_be64(dev->mr_table.mtt_base +
+				    mr->mtt->first_seg * MTHCA_MTT_SEG_SIZE);
+
+	if (0) {
+		mthca_dbg(dev, "Dumping MPT entry %08x:\n", mr->ibmr.lkey);
+		for (i = 0; i < sizeof (struct mthca_mpt_entry) / 4; ++i) {
+			if (i % 4 == 0)
+				printk("[%02x] ", i * 4);
+			printk(" %08x", be32_to_cpu(((u32 *) mpt_entry)[i]));
+			if ((i + 1) % 4 == 0)
+				printk("\n");
+		}
+	}
+
 	err = mthca_SW2HW_MPT(dev, mpt_entry,
 			      key & (dev->limits.num_mpts - 1),
 			      &status);
 	if (err) {
 		mthca_warn(dev, "SW2HW_MPT failed (%d)\n", err);
-		goto err_out_table;
+		goto err_out_mailbox;
 	} else if (status) {
 		mthca_warn(dev, "SW2HW_MPT returned status 0x%02x\n",
 			   status);
 		err = -EINVAL;
-		goto err_out_table;
+		goto err_out_mailbox;
 	}
 
 	kfree(mailbox);
 	return err;
 
+err_out_mailbox:
+	kfree(mailbox);
+
 err_out_table:
 	mthca_table_put(dev, dev->mr_table.mpt_table, key);
 
 err_out_mpt_free:
 	mthca_free(&dev->mr_table.mpt_alloc, key);
-	kfree(mailbox);
 	return err;
 }
 
+int mthca_mr_alloc_notrans(struct mthca_dev *dev, u32 pd,
+			   u32 access, struct mthca_mr *mr)
+{
+	mr->mtt = NULL;
+	return mthca_mr_alloc(dev, pd, 12, 0, ~0ULL, access, mr);
+}
+
 int mthca_mr_alloc_phys(struct mthca_dev *dev, u32 pd,
 			u64 *buffer_list, int buffer_size_shift,
 			int list_len, u64 iova, u64 total_size,
 			u32 access, struct mthca_mr *mr)
 {
-	void *mailbox;
-	u64 *mtt_entry;
-	struct mthca_mpt_entry *mpt_entry;
-	u32 key;
-	int err = -ENOMEM;
-	u8 status;
-	int i;
-
-	might_sleep();
-	WARN_ON(buffer_size_shift >= 32);
-
-	key = mthca_alloc(&dev->mr_table.mpt_alloc);
-	if (key == -1)
-		return -ENOMEM;
-	mr->ibmr.rkey = mr->ibmr.lkey = hw_index_to_key(dev, key);
-
-	if (mthca_is_memfree(dev)) {
-		err = mthca_table_get(dev, dev->mr_table.mpt_table, key);
-		if (err)
-			goto err_out_mpt_free;
-	}
-
-	for (i = MTHCA_MTT_SEG_SIZE / 8, mr->order = 0;
-	     i < list_len;
-	     i <<= 1, ++mr->order)
-		; /* nothing */
-
-	mr->first_seg = mthca_alloc_mtt(dev, mr->order,
-				       	&dev->mr_table.mtt_buddy);
-	if (mr->first_seg == -1)
-		goto err_out_table;
-
-	/*
-	 * If list_len is odd, we add one more dummy entry for
-	 * firmware efficiency.
-	 */
-	mailbox = kmalloc(max(sizeof *mpt_entry,
-			      (size_t) 8 * (list_len + (list_len & 1) + 2)) +
-			  MTHCA_CMD_MAILBOX_EXTRA,
-			  GFP_KERNEL);
-	if (!mailbox)
-		goto err_out_free_mtt;
-
-	mtt_entry = MAILBOX_ALIGN(mailbox);
+	int err;
 
-	mtt_entry[0] = cpu_to_be64(dev->mr_table.mtt_base +
-				   mr->first_seg * MTHCA_MTT_SEG_SIZE);
-	mtt_entry[1] = 0;
-	for (i = 0; i < list_len; ++i)
-		mtt_entry[i + 2] = cpu_to_be64(buffer_list[i] |
-					       MTHCA_MTT_FLAG_PRESENT);
-	if (list_len & 1) {
-		mtt_entry[i + 2] = 0;
-		++list_len;
-	}
+	mr->mtt = mthca_alloc_mtt(dev, list_len);
+	if (IS_ERR(mr->mtt))
+		return PTR_ERR(mr->mtt);
 
-	if (0) {
-		mthca_dbg(dev, "Dumping MPT entry\n");
-		for (i = 0; i < list_len + 2; ++i)
-			printk(KERN_ERR "[%2d] %016llx\n",
-			       i, (unsigned long long) be64_to_cpu(mtt_entry[i]));
-	}
-
-	err = mthca_WRITE_MTT(dev, mtt_entry, list_len, &status);
+	err = mthca_write_mtt(dev, mr->mtt, 0, buffer_list, list_len);
 	if (err) {
-		mthca_warn(dev, "WRITE_MTT failed (%d)\n", err);
-		goto err_out_mailbox_free;
-	}
-	if (status) {
-		mthca_warn(dev, "WRITE_MTT returned status 0x%02x\n",
-			   status);
-		err = -EINVAL;
-		goto err_out_mailbox_free;
-	}
-
-	mpt_entry = MAILBOX_ALIGN(mailbox);
-
-	mpt_entry->flags = cpu_to_be32(MTHCA_MPT_FLAG_SW_OWNS     |
-				       MTHCA_MPT_FLAG_MIO         |
-				       MTHCA_MPT_FLAG_REGION      |
-				       access);
-
-	mpt_entry->page_size = cpu_to_be32(buffer_size_shift - 12);
-	mpt_entry->key       = cpu_to_be32(key);
-	mpt_entry->pd        = cpu_to_be32(pd);
-	mpt_entry->start     = cpu_to_be64(iova);
-	mpt_entry->length    = cpu_to_be64(total_size);
-	memset(&mpt_entry->lkey, 0,
-	       sizeof *mpt_entry - offsetof(struct mthca_mpt_entry, lkey));
-	mpt_entry->mtt_seg   = cpu_to_be64(dev->mr_table.mtt_base +
-					   mr->first_seg * MTHCA_MTT_SEG_SIZE);
-
-	if (0) {
-		mthca_dbg(dev, "Dumping MPT entry %08x:\n", mr->ibmr.lkey);
-		for (i = 0; i < sizeof (struct mthca_mpt_entry) / 4; ++i) {
-			if (i % 4 == 0)
-				printk("[%02x] ", i * 4);
-			printk(" %08x", be32_to_cpu(((u32 *) mpt_entry)[i]));
-			if ((i + 1) % 4 == 0)
-				printk("\n");
-		}
+		mthca_free_mtt(dev, mr->mtt);
+		return err;
 	}
 
-	err = mthca_SW2HW_MPT(dev, mpt_entry,
-			      key & (dev->limits.num_mpts - 1),
-			      &status);
+	err = mthca_mr_alloc(dev, pd, buffer_size_shift, iova,
+			     total_size, access, mr);
 	if (err)
-		mthca_warn(dev, "SW2HW_MPT failed (%d)\n", err);
-	else if (status) {
-		mthca_warn(dev, "SW2HW_MPT returned status 0x%02x\n",
-			   status);
-		err = -EINVAL;
-	}
+		mthca_free_mtt(dev, mr->mtt);
 
-	kfree(mailbox);
-	return err;
-
-err_out_mailbox_free:
-	kfree(mailbox);
-
-err_out_free_mtt:
-	mthca_free_mtt(dev, mr->first_seg, mr->order, &dev->mr_table.mtt_buddy);
-
-err_out_table:
-	mthca_table_put(dev, dev->mr_table.mpt_table, key);
-
-err_out_mpt_free:
-	mthca_free(&dev->mr_table.mpt_alloc, key);
 	return err;
 }
 
 /* Free mr or fmr */
-static void mthca_free_region(struct mthca_dev *dev, u32 lkey, int order,
-			      u32 first_seg, struct mthca_buddy *buddy)
+static void mthca_free_region(struct mthca_dev *dev, u32 lkey)
 {
-	if (order >= 0)
-		mthca_free_mtt(dev, first_seg, order, buddy);
-
 	mthca_table_put(dev, dev->mr_table.mpt_table,
 			arbel_key_to_hw_index(lkey));
 
@@ -471,8 +479,8 @@ void mthca_free_mr(struct mthca_dev *dev
 		mthca_warn(dev, "HW2SW_MPT returned status 0x%02x\n",
 			   status);
 
-	mthca_free_region(dev, mr->ibmr.lkey, mr->order, mr->first_seg,
-			  &dev->mr_table.mtt_buddy);
+	mthca_free_region(dev, mr->ibmr.lkey);
+	mthca_free_mtt(dev, mr->mtt);
 }
 
 int mthca_fmr_alloc(struct mthca_dev *dev, u32 pd,
@@ -517,21 +525,15 @@ int mthca_fmr_alloc(struct mthca_dev *de
 		mr->mem.tavor.mpt = dev->mr_table.tavor_fmr.mpt_base +
 		       	sizeof *(mr->mem.tavor.mpt) * idx;
 
-	for (i = MTHCA_MTT_SEG_SIZE / 8, mr->order = 0;
-	     i < list_len;
-	     i <<= 1, ++mr->order)
-		; /* nothing */
-
-	mr->first_seg = mthca_alloc_mtt(dev, mr->order,
-				       	dev->mr_table.fmr_mtt_buddy);
-	if (mr->first_seg == -1)
+	mr->mtt = __mthca_alloc_mtt(dev, list_len, dev->mr_table.fmr_mtt_buddy);
+	if (IS_ERR(mr->mtt))
 		goto err_out_table;
 
-	mtt_seg = mr->first_seg * MTHCA_MTT_SEG_SIZE;
+	mtt_seg = mr->mtt->first_seg * MTHCA_MTT_SEG_SIZE;
 
 	if (mthca_is_memfree(dev)) {
 		mr->mem.arbel.mtts = mthca_table_find(dev->mr_table.mtt_table,
-						      mr->first_seg);
+						      mr->mtt->first_seg);
 		BUG_ON(!mr->mem.arbel.mtts);
 	} else
 		mr->mem.tavor.mtts = dev->mr_table.tavor_fmr.mtt_base + mtt_seg;
@@ -587,8 +589,7 @@ err_out_mailbox_free:
 	kfree(mailbox);
 
 err_out_free_mtt:
-	mthca_free_mtt(dev, mr->first_seg, mr->order,
-		       dev->mr_table.fmr_mtt_buddy);
+	mthca_free_mtt(dev, mr->mtt);
 
 err_out_table:
 	mthca_table_put(dev, dev->mr_table.mpt_table, key);
@@ -603,8 +604,9 @@ int mthca_free_fmr(struct mthca_dev *dev
 	if (fmr->maps)
 		return -EBUSY;
 
-	mthca_free_region(dev, fmr->ibmr.lkey, fmr->order, fmr->first_seg,
-			  dev->mr_table.fmr_mtt_buddy);
+	mthca_free_region(dev, fmr->ibmr.lkey);
+	mthca_free_mtt(dev, fmr->mtt);
+
 	return 0;
 }
 
@@ -820,7 +822,8 @@ int __devinit mthca_init_mr_table(struct
 	if (dev->limits.reserved_mtts) {
 		i = fls(dev->limits.reserved_mtts - 1);
 
-		if (mthca_alloc_mtt(dev, i, dev->mr_table.fmr_mtt_buddy) == -1) {
+		if (mthca_alloc_mtt_range(dev, i,
+					  dev->mr_table.fmr_mtt_buddy) == -1) {
 			mthca_warn(dev, "MTT table of order %d is too small.\n",
 				  dev->mr_table.fmr_mtt_buddy->max_order);
 			err = -ENOMEM;
--- linux.git.orig/drivers/infiniband/hw/mthca/mthca_provider.h	2005-06-23 13:03:01.490794374 -0700
+++ linux.git/drivers/infiniband/hw/mthca/mthca_provider.h	2005-06-23 13:03:07.308535271 -0700
@@ -54,18 +54,18 @@ struct mthca_uar {
 	int           index;
 };
 
+struct mthca_mtt;
+
 struct mthca_mr {
-	struct ib_mr ibmr;
-	int order;
-	u32 first_seg;
+	struct ib_mr      ibmr;
+	struct mthca_mtt *mtt;
 };
 
 struct mthca_fmr {
-	struct ib_fmr ibmr;
+	struct ib_fmr      ibmr;
 	struct ib_fmr_attr attr;
-	int order;
-	u32 first_seg;
-	int maps;
+	struct mthca_mtt  *mtt;
+	int                maps;
 	union {
 		struct {
 			struct mthca_mpt_entry __iomem *mpt;

