Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262442AbUKDVx3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262442AbUKDVx3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 16:53:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262447AbUKDVx3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 16:53:29 -0500
Received: from ozlabs.org ([203.10.76.45]:39830 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S262442AbUKDVvd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 16:51:33 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16778.42094.141632.631388@cargo.ozlabs.ibm.com>
Date: Fri, 5 Nov 2004 08:51:42 +1100
From: Paul Mackerras <paulus@samba.org>
To: akpm@osdl.org, torvalds@osdl.org
Cc: johnrose@austin.ibm.com, anton@samba.org, linux-kernel@vger.kernel.org
Subject: [PATCH] PPC64 iommu fixes, round 3
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is from John Rose <johnrose@austin.ibm.com>.

This patch changes the following iommu-related things:

- Renames the [i,p]series versions of iommu_devnode_init(), to keep things 
  logically separate where possible.
  
- Moves iommu_free_table() to generic iommu.c

- Creates of_cleanup_node(), which will directly precede the dynamic removal of
  any device node

Signed-off-by: John Rose <johnrose@austin.ibm.com>
Signed-off-by: Paul Mackerras <paulus@samba.org>

diff -urN linux-2.5/arch/ppc64/kernel/iSeries_iommu.c test/arch/ppc64/kernel/iSeries_iommu.c
--- linux-2.5/arch/ppc64/kernel/iSeries_iommu.c	2004-04-13 09:25:09.000000000 +1000
+++ test/arch/ppc64/kernel/iSeries_iommu.c	2004-11-05 08:47:07.276240544 +1100
@@ -171,7 +171,7 @@
 }
 
 
-void iommu_devnode_init(struct iSeries_Device_Node *dn) {
+void iommu_devnode_init_iSeries(struct iSeries_Device_Node *dn) {
 	struct iommu_table *tbl;
 
 	tbl = (struct iommu_table *)kmalloc(sizeof(struct iommu_table), GFP_KERNEL);
diff -urN linux-2.5/arch/ppc64/kernel/iSeries_pci.c test/arch/ppc64/kernel/iSeries_pci.c
--- linux-2.5/arch/ppc64/kernel/iSeries_pci.c	2004-10-30 09:25:20.000000000 +1000
+++ test/arch/ppc64/kernel/iSeries_pci.c	2004-11-05 08:47:07.281239784 +1100
@@ -329,7 +329,7 @@
 			iSeries_Device_Information(pdev, Buffer,
 					sizeof(Buffer));
 			printk("%d. %s\n", DeviceCount, Buffer);
-			iommu_devnode_init(node);
+			iommu_devnode_init_iSeries(node);
 		} else
 			printk("PCI: Device Tree not found for 0x%016lX\n",
 					(unsigned long)pdev);
diff -urN linux-2.5/arch/ppc64/kernel/iommu.c test/arch/ppc64/kernel/iommu.c
--- linux-2.5/arch/ppc64/kernel/iommu.c	2004-10-21 07:17:18.000000000 +1000
+++ test/arch/ppc64/kernel/iommu.c	2004-11-05 08:47:07.282239632 +1100
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
diff -urN linux-2.5/arch/ppc64/kernel/pSeries_iommu.c test/arch/ppc64/kernel/pSeries_iommu.c
--- linux-2.5/arch/ppc64/kernel/pSeries_iommu.c	2004-10-26 16:06:41.000000000 +1000
+++ test/arch/ppc64/kernel/pSeries_iommu.c	2004-11-05 08:47:07.283239480 +1100
@@ -276,7 +276,7 @@
 		first_phb = 0;
 
 		for (dn = first_dn; dn != NULL; dn = dn->sibling)
-			iommu_devnode_init(dn);
+			iommu_devnode_init_pSeries(dn);
 	}
 }
 
@@ -298,7 +298,7 @@
 			 * Do it now because iommu_table_setparms_lpar needs it.
 			 */
 			busdn->bussubno = bus->number;
-			iommu_devnode_init(busdn);
+			iommu_devnode_init_pSeries(busdn);
 		}
 
 		/* look for a window on a bridge even if the PHB had one */
@@ -397,7 +397,7 @@
 }
 
 
-void iommu_devnode_init(struct device_node *dn)
+void iommu_devnode_init_pSeries(struct device_node *dn)
 {
 	struct iommu_table *tbl;
 
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
@@ -469,7 +436,6 @@
 	}
 }
 
-
 /* These are called very early. */
 void tce_init_pSeries(void)
 {
diff -urN linux-2.5/arch/ppc64/kernel/prom.c test/arch/ppc64/kernel/prom.c
--- linux-2.5/arch/ppc64/kernel/prom.c	2004-10-27 07:32:57.000000000 +1000
+++ test/arch/ppc64/kernel/prom.c	2004-11-05 08:47:07.296237504 +1100
@@ -1740,7 +1740,7 @@
 	if (strcmp(node->name, "pci") == 0 &&
 	    get_property(node, "ibm,dma-window", NULL)) {
 		node->bussubno = node->busno;
-		iommu_devnode_init(node);
+		iommu_devnode_init_pSeries(node);
 	} else
 		node->iommu_table = parent->iommu_table;
 #endif /* CONFIG_PPC_PSERIES */
@@ -1802,6 +1802,15 @@
 }
 
 /*
+ * Prepare an OF node for removal from system
+ */
+static void of_cleanup_node(struct device_node *np)
+{
+	if (np->iommu_table && get_property(np, "ibm,dma-window", NULL))
+		iommu_free_table(np);
+}
+
+/*
  * Remove an OF device node from the system.
  * Caller should have already "gotten" np.
  */
@@ -1818,13 +1827,7 @@
 		return -EBUSY;
 	}
 
-	/* XXX This is a layering violation, should be moved to the caller
-	 * --BenH.
-	 */
-#ifdef CONFIG_PPC_PSERIES
-	if (np->iommu_table)
-		iommu_free_table(np);
-#endif /* CONFIG_PPC_PSERIES */
+	of_cleanup_node(np);
 
 	write_lock(&devtree_lock);
 	OF_MARK_STALE(np);
diff -urN linux-2.5/include/asm-ppc64/iommu.h test/include/asm-ppc64/iommu.h
--- linux-2.5/include/asm-ppc64/iommu.h	2004-10-27 07:32:58.000000000 +1000
+++ test/include/asm-ppc64/iommu.h	2004-11-05 08:47:07.297237352 +1100
@@ -110,22 +110,18 @@
 extern void iommu_setup_pSeries(void);
 extern void iommu_setup_u3(void);
 
-/* Creates table for an individual device node */
-/* XXX: This isn't generic, please name it accordingly or add
- * some ppc_md. hooks for iommu implementations to do what they
- * need to do. --BenH.
- */
-extern void iommu_devnode_init(struct device_node *dn);
-
 /* Frees table for an individual device node */
-/* XXX: This isn't generic, please name it accordingly or add
- * some ppc_md. hooks for iommu implementations to do what they
- * need to do. --BenH.
- */
 extern void iommu_free_table(struct device_node *dn);
 
 #endif /* CONFIG_PPC_MULTIPLATFORM */
 
+#ifdef CONFIG_PPC_PSERIES
+
+/* Creates table for an individual device node */
+extern void iommu_devnode_init_pSeries(struct device_node *dn);
+
+#endif /* CONFIG_PPC_PSERIES */
+
 #ifdef CONFIG_PPC_ISERIES
 
 /* Walks all buses and creates iommu tables */
@@ -136,7 +132,7 @@
 
 struct iSeries_Device_Node;
 /* Creates table for an individual device node */
-extern void iommu_devnode_init(struct iSeries_Device_Node *dn);
+extern void iommu_devnode_init_iSeries(struct iSeries_Device_Node *dn);
 
 #endif /* CONFIG_PPC_ISERIES */
 
