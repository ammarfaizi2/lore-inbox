Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262919AbVDAVps@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262919AbVDAVps (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 16:45:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262922AbVDAU7z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 15:59:55 -0500
Received: from webmail.topspin.com ([12.162.17.3]:37423 "EHLO
	exch-1.topspincom.com") by vger.kernel.org with ESMTP
	id S262907AbVDAUvR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 15:51:17 -0500
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: [PATCH][17/27] IB/mthca: encapsulate MTT buddy allocator
In-Reply-To: <2005411249.gEJosMqrkm8KOH4C@topspin.com>
X-Mailer: Roland's Patchbomber
Date: Fri, 1 Apr 2005 12:49:53 -0800
Message-Id: <2005411249.S2hhmQaEpM8vK71i@topspin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: akpm@osdl.org
Content-Transfer-Encoding: 7BIT
From: Roland Dreier <roland@topspin.com>
X-OriginalArrivalTime: 01 Apr 2005 20:49:53.0481 (UTC) FILETIME=[5AE91390:01C536FC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael S. Tsirkin <mst@mellanox.co.il>

Encapsulate the buddy allocator used for MTT segments.  This cleans up
the code and also gets us ready to add FMR support.

Signed-off-by: Michael S. Tsirkin <mst@mellanox.co.il>
Signed-off-by: Roland Dreier <roland@topspin.com>


--- linux-export.orig/drivers/infiniband/hw/mthca/mthca_dev.h	2005-04-01 12:38:26.173279180 -0800
+++ linux-export/drivers/infiniband/hw/mthca/mthca_dev.h	2005-04-01 12:38:27.068084943 -0800
@@ -170,10 +170,15 @@
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
--- linux-export.orig/drivers/infiniband/hw/mthca/mthca_mr.c	2005-04-01 12:38:25.582407442 -0800
+++ linux-export/drivers/infiniband/hw/mthca/mthca_mr.c	2005-04-01 12:38:27.075083423 -0800
@@ -72,60 +72,108 @@
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
@@ -133,16 +181,17 @@
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
@@ -268,7 +317,8 @@
 	     i <<= 1, ++mr->order)
 		; /* nothing */
 
-	mr->first_seg = mthca_alloc_mtt(dev, mr->order);
+	mr->first_seg = mthca_alloc_mtt(dev, mr->order,
+				       	&dev->mr_table.mtt_buddy);
 	if (mr->first_seg == -1)
 		goto err_out_table;
 
@@ -361,7 +411,7 @@
 	kfree(mailbox);
 
 err_out_free_mtt:
-	mthca_free_mtt(dev, mr->first_seg, mr->order);
+	mthca_free_mtt(dev, mr->first_seg, mr->order, &dev->mr_table.mtt_buddy);
 
 err_out_table:
 	if (dev->hca_type == ARBEL_NATIVE)
@@ -390,7 +440,7 @@
 			   status);
 
 	if (mr->order >= 0)
-		mthca_free_mtt(dev, mr->first_seg, mr->order);
+		mthca_free_mtt(dev, mr->first_seg, mr->order, &dev->mr_table.mtt_buddy);
 
 	if (dev->hca_type == ARBEL_NATIVE)
 		mthca_table_put(dev, dev->mr_table.mpt_table,
@@ -401,7 +451,6 @@
 int __devinit mthca_init_mr_table(struct mthca_dev *dev)
 {
 	int err;
-	int i, s;
 
 	err = mthca_alloc_init(&dev->mr_table.mpt_alloc,
 			       dev->limits.num_mpts,
@@ -409,53 +458,24 @@
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
@@ -463,11 +483,7 @@
 
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

