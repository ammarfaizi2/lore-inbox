Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264668AbUJWHux@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264668AbUJWHux (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Oct 2004 03:50:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265900AbUJWHux
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Oct 2004 03:50:53 -0400
Received: from ozlabs.org ([203.10.76.45]:38084 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S264668AbUJWHun (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Oct 2004 03:50:43 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16762.3398.870099.541817@cargo.ozlabs.ibm.com>
Date: Sat, 23 Oct 2004 17:50:30 +1000
From: Paul Mackerras <paulus@samba.org>
To: akpm@osdl.org
Cc: John Rose <johnrose@austin.ibm.com>, anton@samba.org,
       linux-kernel@vger.kernel.org
Subject: [PATCH] ppc64 create iommu_free_table()
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is from John Rose <johnrose@austin.ibm.com>.

The patch below creates iommu_free_table().  Iommu tables are not currently
freed in PPC64.  This could cause a memory leak for DLPAR of an EADS slot.  The
function verifies that there are no outstanding TCE entries for the range of
the table before freeing it.  I added a call to iommu_free_table() to the code
that dynamically removes a device node.  This should be fairly symmetrical with
the table allocation, which happens during dynamic addition of a device node.

Signed-off-by: John Rose <johnrose@austin.ibm.com>
Signed-off-by: Paul Mackerras <paulus@samba.org>

diff -Nru a/arch/ppc64/kernel/pSeries_iommu.c b/arch/ppc64/kernel/pSeries_iommu.c
--- a/arch/ppc64/kernel/pSeries_iommu.c	Fri Oct 22 13:03:21 2004
+++ b/arch/ppc64/kernel/pSeries_iommu.c	Fri Oct 22 13:03:21 2004
@@ -412,6 +412,38 @@
 	dn->iommu_table = iommu_init_table(tbl);
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
 
 void iommu_setup_pSeries(void)
 {
diff -Nru a/arch/ppc64/kernel/prom.c b/arch/ppc64/kernel/prom.c
--- a/arch/ppc64/kernel/prom.c	Fri Oct 22 13:03:21 2004
+++ b/arch/ppc64/kernel/prom.c	Fri Oct 22 13:03:21 2004
@@ -1818,6 +1818,9 @@
 		return -EBUSY;
 	}
 
+	if (np->iommu_table)
+		iommu_free_table(np);
+
 	write_lock(&devtree_lock);
 	OF_MARK_STALE(np);
 	remove_node_proc_entries(np);
diff -Nru a/include/asm-ppc64/iommu.h b/include/asm-ppc64/iommu.h
--- a/include/asm-ppc64/iommu.h	Fri Oct 22 13:03:21 2004
+++ b/include/asm-ppc64/iommu.h	Fri Oct 22 13:03:21 2004
@@ -113,6 +113,9 @@
 /* Creates table for an individual device node */
 extern void iommu_devnode_init(struct device_node *dn);
 
+/* Frees table for an individual device node */
+extern void iommu_free_table(struct device_node *dn);
+
 #endif /* CONFIG_PPC_MULTIPLATFORM */
 
 #ifdef CONFIG_PPC_ISERIES
