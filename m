Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262292AbVDLLB1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262292AbVDLLB1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 07:01:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262329AbVDLK55
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 06:57:57 -0400
Received: from fire.osdl.org ([65.172.181.4]:62154 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262292AbVDLKdx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 06:33:53 -0400
Message-Id: <200504121033.j3CAXUSB005899@shell0.pdx.osdl.net>
Subject: [patch 184/198] IB/mthca: add fast memory region implementation
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, mst@mellanox.co.il,
       roland@topspin.com
From: akpm@osdl.org
Date: Tue, 12 Apr 2005 03:33:24 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Michael S. Tsirkin <mst@mellanox.co.il>

Implement fast memory regions (FMRs), where the driver writes directly into
the HCA's translation tables rather than requiring a firmware command.  For
Tavor, MTTs for FMR are separate from regular MTTs, and are reserved at driver
initialization.  This is done to limit the amount of virtual memory needed to
map the MTTs.  For Arbel, there's no such limitation, and all MTTs and MPTs
may be used for FMR or for regular MR.

Signed-off-by: Michael S. Tsirkin <mst@mellanox.co.il>
Signed-off-by: Roland Dreier <roland@topspin.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/drivers/infiniband/hw/mthca/mthca_dev.h      |   25 +
 25-akpm/drivers/infiniband/hw/mthca/mthca_main.c     |   17 
 25-akpm/drivers/infiniband/hw/mthca/mthca_mr.c       |  386 ++++++++++++++++++-
 25-akpm/drivers/infiniband/hw/mthca/mthca_profile.c  |   19 
 25-akpm/drivers/infiniband/hw/mthca/mthca_profile.h  |    1 
 25-akpm/drivers/infiniband/hw/mthca/mthca_provider.c |   79 +++
 25-akpm/drivers/infiniband/hw/mthca/mthca_provider.h |   23 +
 7 files changed, 526 insertions(+), 24 deletions(-)

diff -puN drivers/infiniband/hw/mthca/mthca_dev.h~ib-mthca-add-fast-memory-region-implementation drivers/infiniband/hw/mthca/mthca_dev.h
--- 25/drivers/infiniband/hw/mthca/mthca_dev.h~ib-mthca-add-fast-memory-region-implementation	2005-04-12 03:21:47.136970992 -0700
+++ 25-akpm/drivers/infiniband/hw/mthca/mthca_dev.h	2005-04-12 03:21:47.147969320 -0700
@@ -61,7 +61,8 @@ enum {
 	MTHCA_FLAG_SRQ        = 1 << 2,
 	MTHCA_FLAG_MSI        = 1 << 3,
 	MTHCA_FLAG_MSI_X      = 1 << 4,
-	MTHCA_FLAG_NO_LAM     = 1 << 5
+	MTHCA_FLAG_NO_LAM     = 1 << 5,
+	MTHCA_FLAG_FMR        = 1 << 6
 };
 
 enum {
@@ -134,6 +135,7 @@ struct mthca_limits {
 	int      reserved_eqs;
 	int      num_mpts;
 	int      num_mtt_segs;
+	int      fmr_reserved_mtts;
 	int      reserved_mtts;
 	int      reserved_mrws;
 	int      reserved_uars;
@@ -178,10 +180,17 @@ struct mthca_buddy {
 
 struct mthca_mr_table {
 	struct mthca_alloc      mpt_alloc;
-	struct mthca_buddy	mtt_buddy;
+	struct mthca_buddy      mtt_buddy;
+	struct mthca_buddy     *fmr_mtt_buddy;
 	u64                     mtt_base;
+	u64                     mpt_base;
 	struct mthca_icm_table *mtt_table;
 	struct mthca_icm_table *mpt_table;
+	struct {
+		void __iomem   *mpt_base;
+		void __iomem   *mtt_base;
+		struct mthca_buddy mtt_buddy;
+	} tavor_fmr;
 };
 
 struct mthca_eq_table {
@@ -380,7 +389,17 @@ int mthca_mr_alloc_phys(struct mthca_dev
 			u64 *buffer_list, int buffer_size_shift,
 			int list_len, u64 iova, u64 total_size,
 			u32 access, struct mthca_mr *mr);
-void mthca_free_mr(struct mthca_dev *dev, struct mthca_mr *mr);
+void mthca_free_mr(struct mthca_dev *dev,  struct mthca_mr *mr);
+
+int mthca_fmr_alloc(struct mthca_dev *dev, u32 pd,
+		    u32 access, struct mthca_fmr *fmr);
+int mthca_tavor_map_phys_fmr(struct ib_fmr *ibfmr, u64 *page_list,
+			     int list_len, u64 iova);
+void mthca_tavor_fmr_unmap(struct mthca_dev *dev, struct mthca_fmr *fmr);
+int mthca_arbel_map_phys_fmr(struct ib_fmr *ibfmr, u64 *page_list,
+			     int list_len, u64 iova);
+void mthca_arbel_fmr_unmap(struct mthca_dev *dev, struct mthca_fmr *fmr);
+int mthca_free_fmr(struct mthca_dev *dev,  struct mthca_fmr *fmr);
 
 int mthca_map_eq_icm(struct mthca_dev *dev, u64 icm_virt);
 void mthca_unmap_eq_icm(struct mthca_dev *dev);
diff -puN drivers/infiniband/hw/mthca/mthca_main.c~ib-mthca-add-fast-memory-region-implementation drivers/infiniband/hw/mthca/mthca_main.c
--- 25/drivers/infiniband/hw/mthca/mthca_main.c~ib-mthca-add-fast-memory-region-implementation	2005-04-12 03:21:47.137970840 -0700
+++ 25-akpm/drivers/infiniband/hw/mthca/mthca_main.c	2005-04-12 03:21:47.148969168 -0700
@@ -73,14 +73,15 @@ static const char mthca_version[] __devi
 	DRV_VERSION " (" DRV_RELDATE ")\n";
 
 static struct mthca_profile default_profile = {
-	.num_qp     = 1 << 16,
-	.rdb_per_qp = 4,
-	.num_cq     = 1 << 16,
-	.num_mcg    = 1 << 13,
-	.num_mpt    = 1 << 17,
-	.num_mtt    = 1 << 20,
-	.num_udav   = 1 << 15,	/* Tavor only */
-	.uarc_size  = 1 << 18,	/* Arbel only */
+	.num_qp		   = 1 << 16,
+	.rdb_per_qp	   = 4,
+	.num_cq		   = 1 << 16,
+	.num_mcg	   = 1 << 13,
+	.num_mpt	   = 1 << 17,
+	.num_mtt	   = 1 << 20,
+	.num_udav	   = 1 << 15,	/* Tavor only */
+	.fmr_reserved_mtts = 1 << 18,	/* Tavor only */
+	.uarc_size	   = 1 << 18,	/* Arbel only */
 };
 
 static int __devinit mthca_tune_pci(struct mthca_dev *mdev)
diff -puN drivers/infiniband/hw/mthca/mthca_mr.c~ib-mthca-add-fast-memory-region-implementation drivers/infiniband/hw/mthca/mthca_mr.c
--- 25/drivers/infiniband/hw/mthca/mthca_mr.c~ib-mthca-add-fast-memory-region-implementation	2005-04-12 03:21:47.138970688 -0700
+++ 25-akpm/drivers/infiniband/hw/mthca/mthca_mr.c	2005-04-12 03:21:47.151968712 -0700
@@ -66,6 +66,9 @@ struct mthca_mpt_entry {
 
 #define MTHCA_MTT_FLAG_PRESENT       1
 
+#define MTHCA_MPT_STATUS_SW 0xF0
+#define MTHCA_MPT_STATUS_HW 0x00
+
 /*
  * Buddy allocator for MTT segments (currently not very efficient
  * since it doesn't keep a free list and just searches linearly
@@ -442,6 +445,20 @@ err_out_mpt_free:
 	return err;
 }
 
+/* Free mr or fmr */
+static void mthca_free_region(struct mthca_dev *dev, u32 lkey, int order,
+			      u32 first_seg, struct mthca_buddy *buddy)
+{
+	if (order >= 0)
+		mthca_free_mtt(dev, first_seg, order, buddy);
+
+	if (dev->hca_type == ARBEL_NATIVE)
+		mthca_table_put(dev, dev->mr_table.mpt_table,
+				arbel_key_to_hw_index(lkey));
+
+	mthca_free(&dev->mr_table.mpt_alloc, key_to_hw_index(dev, lkey));
+}
+
 void mthca_free_mr(struct mthca_dev *dev, struct mthca_mr *mr)
 {
 	int err;
@@ -459,18 +476,288 @@ void mthca_free_mr(struct mthca_dev *dev
 		mthca_warn(dev, "HW2SW_MPT returned status 0x%02x\n",
 			   status);
 
-	if (mr->order >= 0)
-		mthca_free_mtt(dev, mr->first_seg, mr->order, &dev->mr_table.mtt_buddy);
+	mthca_free_region(dev, mr->ibmr.lkey, mr->order, mr->first_seg,
+			  &dev->mr_table.mtt_buddy);
+}
+
+int mthca_fmr_alloc(struct mthca_dev *dev, u32 pd,
+		    u32 access, struct mthca_fmr *mr)
+{
+	struct mthca_mpt_entry *mpt_entry;
+	void *mailbox;
+	u64 mtt_seg;
+	u32 key, idx;
+	u8 status;
+	int list_len = mr->attr.max_pages;
+	int err = -ENOMEM;
+	int i;
+
+	might_sleep();
+
+	if (mr->attr.page_size < 12 || mr->attr.page_size >= 32)
+		return -EINVAL;
+
+	/* For Arbel, all MTTs must fit in the same page. */
+	if (dev->hca_type == ARBEL_NATIVE &&
+	    mr->attr.max_pages * sizeof *mr->mem.arbel.mtts > PAGE_SIZE)
+		return -EINVAL;
+
+	mr->maps = 0;
+
+	key = mthca_alloc(&dev->mr_table.mpt_alloc);
+	if (key == -1)
+		return -ENOMEM;
+
+	idx = key & (dev->limits.num_mpts - 1);
+	mr->ibmr.rkey = mr->ibmr.lkey = hw_index_to_key(dev, key);
+
+	if (dev->hca_type == ARBEL_NATIVE) {
+		err = mthca_table_get(dev, dev->mr_table.mpt_table, key);
+		if (err)
+			goto err_out_mpt_free;
+
+		mr->mem.arbel.mpt = mthca_table_find(dev->mr_table.mpt_table, key);
+		BUG_ON(!mr->mem.arbel.mpt);
+	} else
+		mr->mem.tavor.mpt = dev->mr_table.tavor_fmr.mpt_base +
+		       	sizeof *(mr->mem.tavor.mpt) * idx;
+
+	for (i = MTHCA_MTT_SEG_SIZE / 8, mr->order = 0;
+	     i < list_len;
+	     i <<= 1, ++mr->order)
+		; /* nothing */
+
+	mr->first_seg = mthca_alloc_mtt(dev, mr->order,
+				       	dev->mr_table.fmr_mtt_buddy);
+	if (mr->first_seg == -1)
+		goto err_out_table;
+
+	mtt_seg = mr->first_seg * MTHCA_MTT_SEG_SIZE;
+
+	if (dev->hca_type == ARBEL_NATIVE) {
+		mr->mem.arbel.mtts = mthca_table_find(dev->mr_table.mtt_table,
+						      mr->first_seg);
+		BUG_ON(!mr->mem.arbel.mtts);
+	} else
+		mr->mem.tavor.mtts = dev->mr_table.tavor_fmr.mtt_base + mtt_seg;
+
+	mailbox = kmalloc(sizeof *mpt_entry + MTHCA_CMD_MAILBOX_EXTRA,
+			  GFP_KERNEL);
+	if (!mailbox)
+		goto err_out_free_mtt;
+
+	mpt_entry = MAILBOX_ALIGN(mailbox);
+
+	mpt_entry->flags = cpu_to_be32(MTHCA_MPT_FLAG_SW_OWNS     |
+				       MTHCA_MPT_FLAG_MIO         |
+				       MTHCA_MPT_FLAG_REGION      |
+				       access);
+
+	mpt_entry->page_size = cpu_to_be32(mr->attr.page_size - 12);
+	mpt_entry->key       = cpu_to_be32(key);
+	mpt_entry->pd        = cpu_to_be32(pd);
+	memset(&mpt_entry->start, 0,
+	       sizeof *mpt_entry - offsetof(struct mthca_mpt_entry, start));
+	mpt_entry->mtt_seg   = cpu_to_be64(dev->mr_table.mtt_base + mtt_seg);
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
+	err = mthca_SW2HW_MPT(dev, mpt_entry,
+			      key & (dev->limits.num_mpts - 1),
+			      &status);
+	if (err) {
+		mthca_warn(dev, "SW2HW_MPT failed (%d)\n", err);
+		goto err_out_mailbox_free;
+	}
+	if (status) {
+		mthca_warn(dev, "SW2HW_MPT returned status 0x%02x\n",
+			   status);
+		err = -EINVAL;
+		goto err_out_mailbox_free;
+	}
+
+	kfree(mailbox);
+	return 0;
+
+err_out_mailbox_free:
+	kfree(mailbox);
+
+err_out_free_mtt:
+	mthca_free_mtt(dev, mr->first_seg, mr->order,
+		       dev->mr_table.fmr_mtt_buddy);
 
+err_out_table:
 	if (dev->hca_type == ARBEL_NATIVE)
-		mthca_table_put(dev, dev->mr_table.mpt_table,
-				key_to_hw_index(dev, mr->ibmr.lkey));
-	mthca_free(&dev->mr_table.mpt_alloc, key_to_hw_index(dev, mr->ibmr.lkey));
+		mthca_table_put(dev, dev->mr_table.mpt_table, key);
+
+err_out_mpt_free:
+	mthca_free(&dev->mr_table.mpt_alloc, mr->ibmr.lkey);
+	return err;
+}
+
+int mthca_free_fmr(struct mthca_dev *dev, struct mthca_fmr *fmr)
+{
+	if (fmr->maps)
+		return -EBUSY;
+
+	mthca_free_region(dev, fmr->ibmr.lkey, fmr->order, fmr->first_seg,
+			  dev->mr_table.fmr_mtt_buddy);
+	return 0;
+}
+
+static inline int mthca_check_fmr(struct mthca_fmr *fmr, u64 *page_list,
+				  int list_len, u64 iova)
+{
+	int i, page_mask;
+
+	if (list_len > fmr->attr.max_pages)
+		return -EINVAL;
+
+	page_mask = (1 << fmr->attr.page_size) - 1;
+
+	/* We are getting page lists, so va must be page aligned. */
+	if (iova & page_mask)
+		return -EINVAL;
+
+	/* Trust the user not to pass misaligned data in page_list */
+	if (0)
+		for (i = 0; i < list_len; ++i) {
+			if (page_list[i] & ~page_mask)
+				return -EINVAL;
+		}
+
+	if (fmr->maps >= fmr->attr.max_maps)
+		return -EINVAL;
+
+	return 0;
+}
+
+
+int mthca_tavor_map_phys_fmr(struct ib_fmr *ibfmr, u64 *page_list,
+			     int list_len, u64 iova)
+{
+	struct mthca_fmr *fmr = to_mfmr(ibfmr);
+	struct mthca_dev *dev = to_mdev(ibfmr->device);
+	struct mthca_mpt_entry mpt_entry;
+	u32 key;
+	int i, err;
+
+	err = mthca_check_fmr(fmr, page_list, list_len, iova);
+	if (err)
+		return err;
+
+	++fmr->maps;
+
+	key = tavor_key_to_hw_index(fmr->ibmr.lkey);
+	key += dev->limits.num_mpts;
+	fmr->ibmr.lkey = fmr->ibmr.rkey = tavor_hw_index_to_key(key);
+
+	writeb(MTHCA_MPT_STATUS_SW, fmr->mem.tavor.mpt);
+
+	for (i = 0; i < list_len; ++i) {
+		__be64 mtt_entry = cpu_to_be64(page_list[i] |
+					       MTHCA_MTT_FLAG_PRESENT);
+		mthca_write64_raw(mtt_entry, fmr->mem.tavor.mtts + i);
+	}
+
+	mpt_entry.lkey   = cpu_to_be32(key);
+	mpt_entry.length = cpu_to_be64(list_len * (1ull << fmr->attr.page_size));
+	mpt_entry.start  = cpu_to_be64(iova);
+
+	writel(mpt_entry.lkey, &fmr->mem.tavor.mpt->key);
+	memcpy_toio(&fmr->mem.tavor.mpt->start, &mpt_entry.start,
+		    offsetof(struct mthca_mpt_entry, window_count) -
+		    offsetof(struct mthca_mpt_entry, start));
+
+	writeb(MTHCA_MPT_STATUS_HW, fmr->mem.tavor.mpt);
+
+	return 0;
+}
+
+int mthca_arbel_map_phys_fmr(struct ib_fmr *ibfmr, u64 *page_list,
+			     int list_len, u64 iova)
+{
+	struct mthca_fmr *fmr = to_mfmr(ibfmr);
+	struct mthca_dev *dev = to_mdev(ibfmr->device);
+	u32 key;
+	int i, err;
+
+	err = mthca_check_fmr(fmr, page_list, list_len, iova);
+	if (err)
+		return err;
+
+	++fmr->maps;
+
+	key = arbel_key_to_hw_index(fmr->ibmr.lkey);
+	key += dev->limits.num_mpts;
+	fmr->ibmr.lkey = fmr->ibmr.rkey = arbel_hw_index_to_key(key);
+
+	*(u8 *) fmr->mem.arbel.mpt = MTHCA_MPT_STATUS_SW;
+
+	wmb();
+
+	for (i = 0; i < list_len; ++i)
+		fmr->mem.arbel.mtts[i] = cpu_to_be64(page_list[i] |
+						     MTHCA_MTT_FLAG_PRESENT);
+
+	fmr->mem.arbel.mpt->key    = cpu_to_be32(key);
+	fmr->mem.arbel.mpt->lkey   = cpu_to_be32(key);
+	fmr->mem.arbel.mpt->length = cpu_to_be64(list_len * (1ull << fmr->attr.page_size));
+	fmr->mem.arbel.mpt->start  = cpu_to_be64(iova);
+
+	wmb();
+
+	*(u8 *) fmr->mem.arbel.mpt = MTHCA_MPT_STATUS_HW;
+
+	wmb();
+
+	return 0;
+}
+
+void mthca_tavor_fmr_unmap(struct mthca_dev *dev, struct mthca_fmr *fmr)
+{
+	u32 key;
+
+	if (!fmr->maps)
+		return;
+
+	key = tavor_key_to_hw_index(fmr->ibmr.lkey);
+	key &= dev->limits.num_mpts - 1;
+	fmr->ibmr.lkey = fmr->ibmr.rkey = tavor_hw_index_to_key(key);
+
+	fmr->maps = 0;
+
+	writeb(MTHCA_MPT_STATUS_SW, fmr->mem.tavor.mpt);
+}
+
+void mthca_arbel_fmr_unmap(struct mthca_dev *dev, struct mthca_fmr *fmr)
+{
+	u32 key;
+
+	if (!fmr->maps)
+		return;
+
+	key = arbel_key_to_hw_index(fmr->ibmr.lkey);
+	key &= dev->limits.num_mpts - 1;
+	fmr->ibmr.lkey = fmr->ibmr.rkey = arbel_hw_index_to_key(key);
+
+	fmr->maps = 0;
+
+	*(u8 *) fmr->mem.arbel.mpt = MTHCA_MPT_STATUS_SW;
 }
 
 int __devinit mthca_init_mr_table(struct mthca_dev *dev)
 {
-	int err;
+	int err, i;
 
 	err = mthca_alloc_init(&dev->mr_table.mpt_alloc,
 			       dev->limits.num_mpts,
@@ -478,23 +765,93 @@ int __devinit mthca_init_mr_table(struct
 	if (err)
 		return err;
 
+	if (dev->hca_type != ARBEL_NATIVE &&
+	    (dev->mthca_flags & MTHCA_FLAG_DDR_HIDDEN))
+		dev->limits.fmr_reserved_mtts = 0;
+	else
+		dev->mthca_flags |= MTHCA_FLAG_FMR;
+
 	err = mthca_buddy_init(&dev->mr_table.mtt_buddy,
 			       fls(dev->limits.num_mtt_segs - 1));
+
 	if (err)
 		goto err_mtt_buddy;
 
+	dev->mr_table.tavor_fmr.mpt_base = NULL;
+	dev->mr_table.tavor_fmr.mtt_base = NULL;
+
+	if (dev->limits.fmr_reserved_mtts) {
+		i = fls(dev->limits.fmr_reserved_mtts - 1);
+
+		if (i >= 31) {
+			mthca_warn(dev, "Unable to reserve 2^31 FMR MTTs.\n");
+			err = -EINVAL;
+			goto err_fmr_mpt;
+		}
+
+		dev->mr_table.tavor_fmr.mpt_base =
+		       	ioremap(dev->mr_table.mpt_base,
+				(1 << i) * sizeof (struct mthca_mpt_entry));
+
+		if (!dev->mr_table.tavor_fmr.mpt_base) {
+			mthca_warn(dev, "MPT ioremap for FMR failed.\n");
+			err = -ENOMEM;
+			goto err_fmr_mpt;
+		}
+
+		dev->mr_table.tavor_fmr.mtt_base =
+			ioremap(dev->mr_table.mtt_base,
+				(1 << i) * MTHCA_MTT_SEG_SIZE);
+		if (!dev->mr_table.tavor_fmr.mtt_base) {
+			mthca_warn(dev, "MTT ioremap for FMR failed.\n");
+			err = -ENOMEM;
+			goto err_fmr_mtt;
+		}
+
+		err = mthca_buddy_init(&dev->mr_table.tavor_fmr.mtt_buddy, i);
+		if (err)
+			goto err_fmr_mtt_buddy;
+
+		/* Prevent regular MRs from using FMR keys */
+		err = mthca_buddy_alloc(&dev->mr_table.mtt_buddy, i);
+		if (err)
+			goto err_reserve_fmr;
+
+		dev->mr_table.fmr_mtt_buddy =
+		       	&dev->mr_table.tavor_fmr.mtt_buddy;
+	} else
+		dev->mr_table.fmr_mtt_buddy = &dev->mr_table.mtt_buddy;
+
+	/* FMR table is always the first, take reserved MTTs out of there */
 	if (dev->limits.reserved_mtts) {
-		if (mthca_alloc_mtt(dev, fls(dev->limits.reserved_mtts - 1),
-				    &dev->mr_table.mtt_buddy) == -1) {
+		i = fls(dev->limits.reserved_mtts - 1);
+
+		if (mthca_alloc_mtt(dev, i, dev->mr_table.fmr_mtt_buddy) == -1) {
 			mthca_warn(dev, "MTT table of order %d is too small.\n",
-				  dev->mr_table.mtt_buddy.max_order);
+				  dev->mr_table.fmr_mtt_buddy->max_order);
 			err = -ENOMEM;
-			goto err_mtt_buddy;
+			goto err_reserve_mtts;
 		}
 	}
 
 	return 0;
 
+err_reserve_mtts:
+err_reserve_fmr:
+	if (dev->limits.fmr_reserved_mtts)
+		mthca_buddy_cleanup(&dev->mr_table.tavor_fmr.mtt_buddy);
+
+err_fmr_mtt_buddy:
+	if (dev->mr_table.tavor_fmr.mtt_base)
+		iounmap(dev->mr_table.tavor_fmr.mtt_base);
+
+err_fmr_mtt:
+	if (dev->mr_table.tavor_fmr.mpt_base)
+		iounmap(dev->mr_table.tavor_fmr.mpt_base);
+
+err_fmr_mpt:
+	mthca_buddy_cleanup(&dev->mr_table.mtt_buddy);
+
 err_mtt_buddy:
 	mthca_alloc_cleanup(&dev->mr_table.mpt_alloc);
 
@@ -504,6 +861,15 @@ err_mtt_buddy:
 void __devexit mthca_cleanup_mr_table(struct mthca_dev *dev)
 {
 	/* XXX check if any MRs are still allocated? */
+	if (dev->limits.fmr_reserved_mtts)
+		mthca_buddy_cleanup(&dev->mr_table.tavor_fmr.mtt_buddy);
+
 	mthca_buddy_cleanup(&dev->mr_table.mtt_buddy);
+
+	if (dev->mr_table.tavor_fmr.mtt_base)
+		iounmap(dev->mr_table.tavor_fmr.mtt_base);
+	if (dev->mr_table.tavor_fmr.mpt_base)
+		iounmap(dev->mr_table.tavor_fmr.mpt_base);
+
 	mthca_alloc_cleanup(&dev->mr_table.mpt_alloc);
 }
diff -puN drivers/infiniband/hw/mthca/mthca_profile.c~ib-mthca-add-fast-memory-region-implementation drivers/infiniband/hw/mthca/mthca_profile.c
--- 25/drivers/infiniband/hw/mthca/mthca_profile.c~ib-mthca-add-fast-memory-region-implementation	2005-04-12 03:21:47.140970384 -0700
+++ 25-akpm/drivers/infiniband/hw/mthca/mthca_profile.c	2005-04-12 03:21:47.151968712 -0700
@@ -223,9 +223,10 @@ u64 mthca_make_profile(struct mthca_dev 
 			init_hca->mc_hash_sz      = 1 << (profile[i].log_num - 1);
 			break;
 		case MTHCA_RES_MPT:
-			dev->limits.num_mpts = profile[i].num;
-			init_hca->mpt_base   = profile[i].start;
-			init_hca->log_mpt_sz = profile[i].log_num;
+			dev->limits.num_mpts   = profile[i].num;
+			dev->mr_table.mpt_base = profile[i].start;
+			init_hca->mpt_base     = profile[i].start;
+			init_hca->log_mpt_sz   = profile[i].log_num;
 			break;
 		case MTHCA_RES_MTT:
 			dev->limits.num_mtt_segs = profile[i].num;
@@ -259,6 +260,18 @@ u64 mthca_make_profile(struct mthca_dev 
 	 */
 	dev->limits.num_pds = MTHCA_NUM_PDS;
 
+	/*
+	 * For Tavor, FMRs use ioremapped PCI memory. For 32 bit
+	 * systems it may use too much vmalloc space to map all MTT
+	 * memory, so we reserve some MTTs for FMR access, taking them
+	 * out of the MR pool. They don't use additional memory, but
+	 * we assign them as part of the HCA profile anyway.
+	 */
+	if (dev->hca_type == ARBEL_NATIVE)
+		dev->limits.fmr_reserved_mtts = 0;
+	else
+		dev->limits.fmr_reserved_mtts = request->fmr_reserved_mtts;
+
 	kfree(profile);
 	return total_size;
 }
diff -puN drivers/infiniband/hw/mthca/mthca_profile.h~ib-mthca-add-fast-memory-region-implementation drivers/infiniband/hw/mthca/mthca_profile.h
--- 25/drivers/infiniband/hw/mthca/mthca_profile.h~ib-mthca-add-fast-memory-region-implementation	2005-04-12 03:21:47.141970232 -0700
+++ 25-akpm/drivers/infiniband/hw/mthca/mthca_profile.h	2005-04-12 03:21:47.152968560 -0700
@@ -48,6 +48,7 @@ struct mthca_profile {
 	int num_udav;
 	int num_uar;
 	int uarc_size;
+	int fmr_reserved_mtts;
 };
 
 u64 mthca_make_profile(struct mthca_dev *mdev,
diff -puN drivers/infiniband/hw/mthca/mthca_provider.c~ib-mthca-add-fast-memory-region-implementation drivers/infiniband/hw/mthca/mthca_provider.c
--- 25/drivers/infiniband/hw/mthca/mthca_provider.c~ib-mthca-add-fast-memory-region-implementation	2005-04-12 03:21:47.142970080 -0700
+++ 25-akpm/drivers/infiniband/hw/mthca/mthca_provider.c	2005-04-12 03:21:47.153968408 -0700
@@ -574,6 +574,74 @@ static int mthca_dereg_mr(struct ib_mr *
 	return 0;
 }
 
+static struct ib_fmr *mthca_alloc_fmr(struct ib_pd *pd, int mr_access_flags,
+				      struct ib_fmr_attr *fmr_attr)
+{
+	struct mthca_fmr *fmr;
+	int err;
+
+	fmr = kmalloc(sizeof *fmr, GFP_KERNEL);
+	if (!fmr)
+		return ERR_PTR(-ENOMEM);
+
+	memcpy(&fmr->attr, fmr_attr, sizeof *fmr_attr);
+	err = mthca_fmr_alloc(to_mdev(pd->device), to_mpd(pd)->pd_num,
+			     convert_access(mr_access_flags), fmr);
+
+	if (err) {
+		kfree(fmr);
+		return ERR_PTR(err);
+	}
+
+	return &fmr->ibmr;
+}
+
+static int mthca_dealloc_fmr(struct ib_fmr *fmr)
+{
+	struct mthca_fmr *mfmr = to_mfmr(fmr);
+	int err;
+
+	err = mthca_free_fmr(to_mdev(fmr->device), mfmr);
+	if (err)
+		return err;
+
+	kfree(mfmr);
+	return 0;
+}
+
+static int mthca_unmap_fmr(struct list_head *fmr_list)
+{
+	struct ib_fmr *fmr;
+	int err;
+	u8 status;
+	struct mthca_dev *mdev = NULL;
+
+	list_for_each_entry(fmr, fmr_list, list) {
+		if (mdev && to_mdev(fmr->device) != mdev)
+			return -EINVAL;
+		mdev = to_mdev(fmr->device);
+	}
+
+	if (!mdev)
+		return 0;
+
+	if (mdev->hca_type == ARBEL_NATIVE) {
+		list_for_each_entry(fmr, fmr_list, list)
+			mthca_arbel_fmr_unmap(mdev, to_mfmr(fmr));
+
+		wmb();
+	} else
+		list_for_each_entry(fmr, fmr_list, list)
+			mthca_tavor_fmr_unmap(mdev, to_mfmr(fmr));
+
+	err = mthca_SYNC_TPT(mdev, &status);
+	if (err)
+		return err;
+	if (status)
+		return -EINVAL;
+	return 0;
+}
+
 static ssize_t show_rev(struct class_device *cdev, char *buf)
 {
 	struct mthca_dev *dev = container_of(cdev, struct mthca_dev, ib_dev.class_dev);
@@ -637,6 +705,17 @@ int mthca_register_device(struct mthca_d
 	dev->ib_dev.get_dma_mr           = mthca_get_dma_mr;
 	dev->ib_dev.reg_phys_mr          = mthca_reg_phys_mr;
 	dev->ib_dev.dereg_mr             = mthca_dereg_mr;
+
+	if (dev->mthca_flags & MTHCA_FLAG_FMR) {
+		dev->ib_dev.alloc_fmr            = mthca_alloc_fmr;
+		dev->ib_dev.unmap_fmr            = mthca_unmap_fmr;
+		dev->ib_dev.dealloc_fmr          = mthca_dealloc_fmr;
+		if (dev->hca_type == ARBEL_NATIVE)
+			dev->ib_dev.map_phys_fmr = mthca_arbel_map_phys_fmr;
+		else
+			dev->ib_dev.map_phys_fmr = mthca_tavor_map_phys_fmr;
+	}
+
 	dev->ib_dev.attach_mcast         = mthca_multicast_attach;
 	dev->ib_dev.detach_mcast         = mthca_multicast_detach;
 	dev->ib_dev.process_mad          = mthca_process_mad;
diff -puN drivers/infiniband/hw/mthca/mthca_provider.h~ib-mthca-add-fast-memory-region-implementation drivers/infiniband/hw/mthca/mthca_provider.h
--- 25/drivers/infiniband/hw/mthca/mthca_provider.h~ib-mthca-add-fast-memory-region-implementation	2005-04-12 03:21:47.144969776 -0700
+++ 25-akpm/drivers/infiniband/hw/mthca/mthca_provider.h	2005-04-12 03:21:47.153968408 -0700
@@ -60,6 +60,24 @@ struct mthca_mr {
 	u32 first_seg;
 };
 
+struct mthca_fmr {
+	struct ib_fmr ibmr;
+	struct ib_fmr_attr attr;
+	int order;
+	u32 first_seg;
+	int maps;
+	union {
+		struct {
+			struct mthca_mpt_entry __iomem *mpt;
+			u64 __iomem *mtts;
+		} tavor;
+		struct {
+			struct mthca_mpt_entry *mpt;
+			__be64 *mtts;
+		} arbel;
+	} mem;
+};
+
 struct mthca_pd {
 	struct ib_pd    ibpd;
 	u32             pd_num;
@@ -218,6 +236,11 @@ struct mthca_sqp {
 	dma_addr_t      header_dma;
 };
 
+static inline struct mthca_fmr *to_mfmr(struct ib_fmr *ibmr)
+{
+	return container_of(ibmr, struct mthca_fmr, ibmr);
+}
+
 static inline struct mthca_mr *to_mmr(struct ib_mr *ibmr)
 {
 	return container_of(ibmr, struct mthca_mr, ibmr);
_
