Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262281AbVDLKsZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262281AbVDLKsZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 06:48:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262324AbVDLKsW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 06:48:22 -0400
Received: from fire.osdl.org ([65.172.181.4]:50378 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262281AbVDLKdk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 06:33:40 -0400
Message-Id: <200504121033.j3CAXQHc005877@shell0.pdx.osdl.net>
Subject: [patch 179/198] IB/mthca: encapsulate MTT buddy allocator
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, mst@mellanox.co.il,
       roland@topspin.com
From: akpm@osdl.org
Date: Tue, 12 Apr 2005 03:33:20 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Michael S. Tsirkin <mst@mellanox.co.il>

Encapsulate the buddy allocator used for MTT segments.  This cleans up the
code and also gets us ready to add FMR support.

Signed-off-by: Michael S. Tsirkin <mst@mellanox.co.il>
Signed-off-by: Roland Dreier <roland@topspin.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/drivers/infiniband/hw/mthca/mthca_dev.h |    9 +
 25-akpm/drivers/infiniband/hw/mthca/mthca_mr.c  |  158 +++++++++++++-----------
 2 files changed, 94 insertions(+), 73 deletions(-)

diff -puN drivers/infiniband/hw/mthca/mthca_dev.h~ib-mthca-encapsulate-mtt-buddy-allocator drivers/infiniband/hw/mthca/mthca_dev.h
--- 25/drivers/infiniband/hw/mthca/mthca_dev.h~ib-mthca-encapsulate-mtt-buddy-allocator	2005-04-12 03:21:46.045136976 -0700
+++ 25-akpm/drivers/infiniband/hw/mthca/mthca_dev.h	2005-04-12 03:21:46.050136216 -0700
@@ -170,10 +170,15 @@ struct mthca_pd_table {
 	struct mthca_alloc alloc;
 };
 
+struct mthca_buddy {
+	unsigned long **bits;
+	int             max_order;
+	spinlock_t      lock;
+};
+
 struct mthca_mr_table {
 	struct mthca_alloc      mpt_alloc;
-	int                     max_mtt_order;
-	unsigned long         **mtt_buddy;
+	struct mthca_buddy	mtt_buddy;
 	u64                     mtt_base;
 	struct mthca_icm_table *mtt_table;
 	struct mthca_icm_table *mpt_table;
diff -puN drivers/infiniband/hw/mthca/mthca_mr.c~ib-mthca-encapsulate-mtt-buddy-allocator drivers/infiniband/hw/mthca/mthca_mr.c
--- 25/drivers/infiniband/hw/mthca/mthca_mr.c~ib-mthca-encapsulate-mtt-buddy-allocator	2005-04-12 03:21:46.047136672 -0700
+++ 25-akpm/drivers/infiniband/hw/mthca/mthca_mr.c	2005-04-12 03:21:46.052135912 -0700
@@ -72,60 +72,108 @@ struct mthca_mpt_entry {
  * through the bitmaps)
  */
 
-static u32 __mthca_alloc_mtt(struct mthca_dev *dev, int order)
+static u32 mthca_buddy_alloc(struct mthca_buddy *buddy, int order)
 {
 	int o;
 	int m;
 	u32 seg;
 
-	spin_lock(&dev->mr_table.mpt_alloc.lock);
+	spin_lock(&buddy->lock);
 
-	for (o = order; o <= dev->mr_table.max_mtt_order; ++o) {
-		m = 1 << (dev->mr_table.max_mtt_order - o);
-		seg = find_first_bit(dev->mr_table.mtt_buddy[o], m);
+	for (o = order; o <= buddy->max_order; ++o) {
+		m = 1 << (buddy->max_order - o);
+		seg = find_first_bit(buddy->bits[o], m);
 		if (seg < m)
 			goto found;
 	}
 
-	spin_unlock(&dev->mr_table.mpt_alloc.lock);
+	spin_unlock(&buddy->lock);
 	return -1;
 
  found:
-	clear_bit(seg, dev->mr_table.mtt_buddy[o]);
+	clear_bit(seg, buddy->bits[o]);
 
 	while (o > order) {
 		--o;
 		seg <<= 1;
-		set_bit(seg ^ 1, dev->mr_table.mtt_buddy[o]);
+		set_bit(seg ^ 1, buddy->bits[o]);
 	}
 
-	spin_unlock(&dev->mr_table.mpt_alloc.lock);
+	spin_unlock(&buddy->lock);
 
 	seg <<= order;
 
 	return seg;
 }
 
-static void __mthca_free_mtt(struct mthca_dev *dev, u32 seg, int order)
+static void mthca_buddy_free(struct mthca_buddy *buddy, u32 seg, int order)
 {
 	seg >>= order;
 
-	spin_lock(&dev->mr_table.mpt_alloc.lock);
+	spin_lock(&buddy->lock);
 
-	while (test_bit(seg ^ 1, dev->mr_table.mtt_buddy[order])) {
-		clear_bit(seg ^ 1, dev->mr_table.mtt_buddy[order]);
+	while (test_bit(seg ^ 1, buddy->bits[order])) {
+		clear_bit(seg ^ 1, buddy->bits[order]);
 		seg >>= 1;
 		++order;
 	}
 
-	set_bit(seg, dev->mr_table.mtt_buddy[order]);
+	set_bit(seg, buddy->bits[order]);
 
-	spin_unlock(&dev->mr_table.mpt_alloc.lock);
+	spin_unlock(&buddy->lock);
 }
 
-static u32 mthca_alloc_mtt(struct mthca_dev *dev, int order)
+static int __devinit mthca_buddy_init(struct mthca_buddy *buddy, int max_order)
 {
-	u32 seg = __mthca_alloc_mtt(dev, order);
+	int i, s;
+
+	buddy->max_order = max_order;
+	spin_lock_init(&buddy->lock);
+
+	buddy->bits = kmalloc((buddy->max_order + 1) * sizeof (long *),
+			      GFP_KERNEL);
+	if (!buddy->bits)
+		goto err_out;
+
+	memset(buddy->bits, 0, (buddy->max_order + 1) * sizeof (long *));
+
+	for (i = 0; i <= buddy->max_order; ++i) {
+		s = BITS_TO_LONGS(1 << (buddy->max_order - i));
+		buddy->bits[i] = kmalloc(s * sizeof (long), GFP_KERNEL);
+		if (!buddy->bits[i])
+			goto err_out_free;
+		bitmap_zero(buddy->bits[i],
+			    1 << (buddy->max_order - i));
+	}
+
+	set_bit(0, buddy->bits[buddy->max_order]);
+
+	return 0;
+
+err_out_free:
+	for (i = 0; i <= buddy->max_order; ++i)
+		kfree(buddy->bits[i]);
+
+	kfree(buddy->bits);
+
+err_out:
+	return -ENOMEM;
+}
+
+static void __devexit mthca_buddy_cleanup(struct mthca_buddy *buddy)
+{
+	int i;
+
+	for (i = 0; i <= buddy->max_order; ++i)
+		kfree(buddy->bits[i]);
+
+	kfree(buddy->bits);
+}
+
+static u32 mthca_alloc_mtt(struct mthca_dev *dev, int order,
+			   struct mthca_buddy *buddy)
+{
+	u32 seg = mthca_buddy_alloc(buddy, order);
 
 	if (seg == -1)
 		return -1;
@@ -133,16 +181,17 @@ static u32 mthca_alloc_mtt(struct mthca_
 	if (dev->hca_type == ARBEL_NATIVE)
 		if (mthca_table_get_range(dev, dev->mr_table.mtt_table, seg,
 					  seg + (1 << order) - 1)) {
-			__mthca_free_mtt(dev, seg, order);
+			mthca_buddy_free(buddy, seg, order);
 			seg = -1;
 		}
 
 	return seg;
 }
 
-static void mthca_free_mtt(struct mthca_dev *dev, u32 seg, int order)
+static void mthca_free_mtt(struct mthca_dev *dev, u32 seg, int order,
+			   struct mthca_buddy* buddy)
 {
-	__mthca_free_mtt(dev, seg, order);
+	mthca_buddy_free(buddy, seg, order);
 
 	if (dev->hca_type == ARBEL_NATIVE)
 		mthca_table_put_range(dev, dev->mr_table.mtt_table, seg,
@@ -268,7 +317,8 @@ int mthca_mr_alloc_phys(struct mthca_dev
 	     i <<= 1, ++mr->order)
 		; /* nothing */
 
-	mr->first_seg = mthca_alloc_mtt(dev, mr->order);
+	mr->first_seg = mthca_alloc_mtt(dev, mr->order,
+				       	&dev->mr_table.mtt_buddy);
 	if (mr->first_seg == -1)
 		goto err_out_table;
 
@@ -361,7 +411,7 @@ err_out_mailbox_free:
 	kfree(mailbox);
 
 err_out_free_mtt:
-	mthca_free_mtt(dev, mr->first_seg, mr->order);
+	mthca_free_mtt(dev, mr->first_seg, mr->order, &dev->mr_table.mtt_buddy);
 
 err_out_table:
 	if (dev->hca_type == ARBEL_NATIVE)
@@ -390,7 +440,7 @@ void mthca_free_mr(struct mthca_dev *dev
 			   status);
 
 	if (mr->order >= 0)
-		mthca_free_mtt(dev, mr->first_seg, mr->order);
+		mthca_free_mtt(dev, mr->first_seg, mr->order, &dev->mr_table.mtt_buddy);
 
 	if (dev->hca_type == ARBEL_NATIVE)
 		mthca_table_put(dev, dev->mr_table.mpt_table,
@@ -401,7 +451,6 @@ void mthca_free_mr(struct mthca_dev *dev
 int __devinit mthca_init_mr_table(struct mthca_dev *dev)
 {
 	int err;
-	int i, s;
 
 	err = mthca_alloc_init(&dev->mr_table.mpt_alloc,
 			       dev->limits.num_mpts,
@@ -409,53 +458,24 @@ int __devinit mthca_init_mr_table(struct
 	if (err)
 		return err;
 
-	err = -ENOMEM;
-
-	for (i = 1, dev->mr_table.max_mtt_order = 0;
-	     i < dev->limits.num_mtt_segs;
-	     i <<= 1, ++dev->mr_table.max_mtt_order)
-		; /* nothing */
-
-	dev->mr_table.mtt_buddy = kmalloc((dev->mr_table.max_mtt_order + 1) *
-					  sizeof (long *),
-					  GFP_KERNEL);
-	if (!dev->mr_table.mtt_buddy)
-		goto err_out;
-
-	for (i = 0; i <= dev->mr_table.max_mtt_order; ++i)
-		dev->mr_table.mtt_buddy[i] = NULL;
-
-	for (i = 0; i <= dev->mr_table.max_mtt_order; ++i) {
-		s = BITS_TO_LONGS(1 << (dev->mr_table.max_mtt_order - i));
-		dev->mr_table.mtt_buddy[i] = kmalloc(s * sizeof (long),
-						     GFP_KERNEL);
-		if (!dev->mr_table.mtt_buddy[i])
-			goto err_out_free;
-		bitmap_zero(dev->mr_table.mtt_buddy[i],
-			    1 << (dev->mr_table.max_mtt_order - i));
-	}
-
-	set_bit(0, dev->mr_table.mtt_buddy[dev->mr_table.max_mtt_order]);
-
-	for (i = 0; i < dev->mr_table.max_mtt_order; ++i)
-		if (1 << i >= dev->limits.reserved_mtts)
-			break;
+	err = mthca_buddy_init(&dev->mr_table.mtt_buddy,
+			       fls(dev->limits.num_mtt_segs - 1));
+	if (err)
+		goto err_mtt_buddy;
 
-	if (i == dev->mr_table.max_mtt_order) {
-		mthca_err(dev, "MTT table of order %d is "
-			  "too small.\n", i);
-		goto err_out_free;
+	if (dev->limits.reserved_mtts) {
+		if (mthca_alloc_mtt(dev, fls(dev->limits.reserved_mtts - 1),
+				    &dev->mr_table.mtt_buddy) == -1) {
+			mthca_warn(dev, "MTT table of order %d is too small.\n",
+				  dev->mr_table.mtt_buddy.max_order);
+			err = -ENOMEM;
+			goto err_mtt_buddy;
+		}
 	}
 
-	(void) mthca_alloc_mtt(dev, i);
-
 	return 0;
 
- err_out_free:
-	for (i = 0; i <= dev->mr_table.max_mtt_order; ++i)
-		kfree(dev->mr_table.mtt_buddy[i]);
-
- err_out:
+err_mtt_buddy:
 	mthca_alloc_cleanup(&dev->mr_table.mpt_alloc);
 
 	return err;
@@ -463,11 +483,7 @@ int __devinit mthca_init_mr_table(struct
 
 void __devexit mthca_cleanup_mr_table(struct mthca_dev *dev)
 {
-	int i;
-
 	/* XXX check if any MRs are still allocated? */
-	for (i = 0; i <= dev->mr_table.max_mtt_order; ++i)
-		kfree(dev->mr_table.mtt_buddy[i]);
-	kfree(dev->mr_table.mtt_buddy);
+	mthca_buddy_cleanup(&dev->mr_table.mtt_buddy);
 	mthca_alloc_cleanup(&dev->mr_table.mpt_alloc);
 }
_
