Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261322AbUJZQiQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261322AbUJZQiQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 12:38:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261324AbUJZQiQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 12:38:16 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:48058 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S261322AbUJZQhn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 12:37:43 -0400
Subject: Re: [PATCH] ppc64: Fix g5-only build
From: John Rose <johnrose@austin.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       External List <linuxppc64-dev@ozlabs.org>
In-Reply-To: <1098775712.6897.17.camel@gaston>
References: <1098775712.6897.17.camel@gaston>
Content-Type: text/plain
Message-Id: <1098808895.32293.23.camel@sinatra.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 26 Oct 2004 11:41:35 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Forgive me for the cross-post, but I'm trying to answer two list
messages on the same topic.  I think it's more productive to just fix
the bug than to commit a giant comment pointing out a small bug, so I've
attached an alternate fix (build tested for g5 :).

> - It breaks build without CONFIG_PPC_PSERIES (try a pmac-only build).
> There is, more generally, a tendency at calling things in
> pSeries_iommu.c with the prefix "iommu_" without any mention of
> "pSeries" in the name. Hey guys ! pSeries isn't alone anymore ! So
> please call those pSeries-specific things pSeries_* or tce_* or
> whatever, but don't add back confusion where I had such a hard time
> splitting things.

Apologies for the build break.  I mistakenly placed the function in a pSeries 
file.  In our view, this is a generic function, complementary to
iommu_init_table(), so I've moved it to iommu.c.

> - It seems that any call to of_remove_node() will call
> iommu_free_table() on np->iommu_table. That sounds bad. The iommu_table
> pointer is copied at init time from the parent to all child nodes. So if
> we add a phb, and then remove a device from that bus, we end up
> disposing of the phb's iommu table ...

Good catch, although table allocation doesn't always happen at the PHB
level.  On POWER5, it happens at the EADS level.  My fix checks for the
ibm,dma-window property before calling the free function.  This is the
criterion for which the table is alloc'ed in the first place.

Thanks-
John

Signed-off-by: John Rose <johnrose@austin.ibm.com>

diff -Nru a/arch/ppc64/kernel/iommu.c b/arch/ppc64/kernel/iommu.c
--- a/arch/ppc64/kernel/iommu.c	Tue Oct 26 11:36:42 2004
+++ b/arch/ppc64/kernel/iommu.c	Tue Oct 26 11:36:42 2004
@@ -425,6 +425,39 @@
 	return tbl;
 }
 
+void iommu_free_table(struct device_node *dn)
+{
+	struct iommu_table *tbl = dn->iommu_table;
+	unsigned long bitmap_sz, i;
+	unsigned int order;
+
+	if (!tbl || !tbl->it_map) {
+		printk(KERN_ERR "%s: expected TCE map for %s\n", __FUNCTION__,
+				dn->full_name);
+		return;
+	}
+
+	/* verify that table contains no entries */
+	/* it_mapsize is in entries, and we're examining 64 at a time */
+	for (i = 0; i < (tbl->it_mapsize/64); i++) {
+		if (tbl->it_map[i] != 0) {
+			printk(KERN_WARNING "%s: Unexpected TCEs for %s\n",
+				__FUNCTION__, dn->full_name);
+			break;
+		}
+	}
+
+	/* calculate bitmap size in bytes */
+	bitmap_sz = (tbl->it_mapsize + 7) / 8;
+
+	/* free bitmap */
+	order = get_order(bitmap_sz);
+	free_pages((unsigned long) tbl->it_map, order);
+
+	/* free table */
+	kfree(tbl);
+}
+
 /* Creates TCEs for a user provided buffer.  The user buffer must be
  * contiguous real kernel storage (not vmalloc).  The address of the buffer
  * passed here is the kernel (virtual) address of the buffer.  The buffer
diff -Nru a/arch/ppc64/kernel/pSeries_iommu.c b/arch/ppc64/kernel/pSeries_iommu.c
--- a/arch/ppc64/kernel/pSeries_iommu.c	Tue Oct 26 11:36:42 2004
+++ b/arch/ppc64/kernel/pSeries_iommu.c	Tue Oct 26 11:36:42 2004
@@ -412,39 +412,6 @@
 	dn->iommu_table = iommu_init_table(tbl);
 }
 
-void iommu_free_table(struct device_node *dn)
-{
-	struct iommu_table *tbl = dn->iommu_table;
-	unsigned long bitmap_sz, i;
-	unsigned int order;
-
-	if (!tbl || !tbl->it_map) {
-		printk(KERN_ERR "%s: expected TCE map for %s\n", __FUNCTION__,
-				dn->full_name);
-		return;
-	}
-
-	/* verify that table contains no entries */
-	/* it_mapsize is in entries, and we're examining 64 at a time */
-	for (i = 0; i < (tbl->it_mapsize/64); i++) {
-		if (tbl->it_map[i] != 0) {
-			printk(KERN_WARNING "%s: Unexpected TCEs for %s\n",
-				__FUNCTION__, dn->full_name);
-			break;
-		}
-	}
-
-	/* calculate bitmap size in bytes */
-	bitmap_sz = (tbl->it_mapsize + 7) / 8;
-
-	/* free bitmap */
-	order = get_order(bitmap_sz);
-	free_pages((unsigned long) tbl->it_map, order);
-
-	/* free table */
-	kfree(tbl);
-}
-
 void iommu_setup_pSeries(void)
 {
 	struct pci_dev *dev = NULL;
diff -Nru a/arch/ppc64/kernel/prom.c b/arch/ppc64/kernel/prom.c
--- a/arch/ppc64/kernel/prom.c	Tue Oct 26 11:36:42 2004
+++ b/arch/ppc64/kernel/prom.c	Tue Oct 26 11:36:42 2004
@@ -1818,8 +1818,9 @@
 		return -EBUSY;
 	}
 
-	if (np->iommu_table)
+	if ((np->iommu_table) && get_property(np, "ibm,dma-window", NULL)) {
 		iommu_free_table(np);
+	}
 
 	write_lock(&devtree_lock);
 	OF_MARK_STALE(np);

