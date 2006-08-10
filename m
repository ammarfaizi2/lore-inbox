Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932479AbWHJUES@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932479AbWHJUES (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 16:04:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932635AbWHJTgi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 15:36:38 -0400
Received: from ns1.suse.de ([195.135.220.2]:51856 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932621AbWHJTgd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 15:36:33 -0400
From: Andi Kleen <ak@suse.de>
References: <20060810 935.775038000@suse.de>
In-Reply-To: <20060810 935.775038000@suse.de>
Subject: [PATCH for review] [75/145] x86_64: Calgary IOMMU: consolidate per bus data structures
Message-Id: <20060810193631.9685213C0B@wotan.suse.de>
Date: Thu, 10 Aug 2006 21:36:31 +0200 (CEST)
To: undisclosed-recipients:;
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

r

From: Muli Ben-Yehuda <muli@il.ibm.com>

Move the tce_table_kva array, disabled bitmap and bus_to_phb array
into a new per bus 'struct calgary_bus_info'. Also slightly reorganize
build_tce_table and tce_table_setparms to avoid exporting bus_info to
tce.c.

Signed-off-by: Muli Ben-Yehuda <muli@il.ibm.com>
Signed-off-by: Jon Mason <jdmason@us.ibm.com>
Signed-off-by: Andi Kleen <ak@suse.de>

---
 arch/x86_64/kernel/pci-calgary.c |   53 ++++++++++++++++++++-------------------
 arch/x86_64/kernel/tce.c         |   10 -------
 include/asm-x86_64/tce.h         |    1 
 3 files changed, 28 insertions(+), 36 deletions(-)

Index: linux/arch/x86_64/kernel/pci-calgary.c
===================================================================
--- linux.orig/arch/x86_64/kernel/pci-calgary.c
+++ linux/arch/x86_64/kernel/pci-calgary.c
@@ -111,17 +111,17 @@ static const unsigned long phb_offsets[]
 	0xB000 /* PHB3 */
 };
 
-static char bus_to_phb[MAX_PHB_BUS_NUM];
-void* tce_table_kva[MAX_PHB_BUS_NUM];
 unsigned int specified_table_size = TCE_TABLE_SIZE_UNSPECIFIED;
 static int translate_empty_slots __read_mostly = 0;
 static int calgary_detected __read_mostly = 0;
 
-/*
- * the bitmap of PHBs the user requested that we disable
- * translation on.
- */
-static DECLARE_BITMAP(translation_disabled, MAX_PHB_BUS_NUM);
+struct calgary_bus_info {
+	void *tce_space;
+	int translation_disabled;
+	signed char phbid;
+};
+
+static struct calgary_bus_info bus_info[MAX_PHB_BUS_NUM] = { { NULL, 0, 0 }, };
 
 static void tce_cache_blast(struct iommu_table *tbl);
 
@@ -149,7 +149,7 @@ static inline unsigned int num_dma_pages
 
 static inline int translate_phb(struct pci_dev* dev)
 {
-	int disabled = test_bit(dev->bus->number, translation_disabled);
+	int disabled = bus_info[dev->bus->number].translation_disabled;
 	return !disabled;
 }
 
@@ -454,7 +454,7 @@ static struct dma_mapping_ops calgary_dm
 
 static inline int busno_to_phbid(unsigned char num)
 {
-	return bus_to_phb[num];
+	return bus_info[num].phbid;
 }
 
 static inline unsigned long split_queue_offset(unsigned char num)
@@ -631,6 +631,10 @@ static int __init calgary_setup_tar(stru
 	if (ret)
 		return ret;
 
+	tbl = dev->sysdata;
+	tbl->it_base = (unsigned long)bus_info[dev->bus->number].tce_space;
+	tce_free(tbl, 0, tbl->it_size);
+
 	calgary_reserve_regions(dev);
 
 	/* set TARs for each PHB */
@@ -824,7 +828,7 @@ static int __init calgary_init(void)
 			calgary_init_one_nontraslated(dev);
 			continue;
 		}
-		if (!tce_table_kva[dev->bus->number] && !translate_empty_slots) {
+		if (!bus_info[dev->bus->number].tce_space && !translate_empty_slots) {
 			pci_dev_put(dev);
 			continue;
 		}
@@ -844,7 +848,7 @@ error:
 			pci_dev_put(dev);
 			continue;
 		}
-		if (!tce_table_kva[dev->bus->number] && !translate_empty_slots)
+		if (!bus_info[dev->bus->number].tce_space && !translate_empty_slots)
 			continue;
 		calgary_disable_translation(dev);
 		calgary_free_tar(dev);
@@ -894,9 +898,8 @@ void __init detect_calgary(void)
 
 	for (bus = 0; bus < MAX_PHB_BUS_NUM; bus++) {
 		int dev;
-
-		tce_table_kva[bus] = NULL;
-		bus_to_phb[bus] = -1;
+		struct calgary_bus_info *info = &bus_info[bus];
+		info->phbid = -1;
 
 		if (read_pci_config(bus, 0, 0, 0) != PCI_VENDOR_DEVICE_ID_CALGARY)
 			continue;
@@ -907,12 +910,9 @@ void __init detect_calgary(void)
 		 */
 		phb = (phb + 1) % PHBS_PER_CALGARY;
 
-		if (test_bit(bus, translation_disabled)) {
-			printk(KERN_INFO "Calgary: translation is disabled for "
-			       "PHB 0x%x\n", bus);
-			/* skip this phb, don't allocate a tbl for it */
+		if (info->translation_disabled)
 			continue;
-		}
+
 		/*
 		 * Scan the slots of the PCI bus to see if there is a device present.
 		 * The parent bus will be the zero-ith device, so start at 1.
@@ -923,8 +923,8 @@ void __init detect_calgary(void)
 				tbl = alloc_tce_table();
 				if (!tbl)
 					goto cleanup;
-				tce_table_kva[bus] = tbl;
-				bus_to_phb[bus] = phb;
+				info->tce_space = tbl;
+				info->phbid = phb;
 				calgary_found = 1;
 				break;
 			}
@@ -940,9 +940,12 @@ void __init detect_calgary(void)
 	return;
 
 cleanup:
-	for (--bus; bus >= 0; --bus)
-		if (tce_table_kva[bus])
-			free_tce_table(tce_table_kva[bus]);
+	for (--bus; bus >= 0; --bus) {
+		struct calgary_bus_info *info = &bus_info[bus];
+
+		if (info->tce_space)
+			free_tce_table(info->tce_space);
+	}
 }
 
 int __init calgary_iommu_init(void)
@@ -1016,7 +1019,7 @@ static int __init calgary_parse_options(
 			if (bridge < MAX_PHB_BUS_NUM) {
 				printk(KERN_INFO "Calgary: disabling "
 				       "translation for PHB 0x%x\n", bridge);
-				set_bit(bridge, translation_disabled);
+				bus_info[bridge].translation_disabled = 1;
 			}
 		}
 
Index: linux/arch/x86_64/kernel/tce.c
===================================================================
--- linux.orig/arch/x86_64/kernel/tce.c
+++ linux/arch/x86_64/kernel/tce.c
@@ -106,14 +106,6 @@ static int tce_table_setparms(struct pci
 	/* set the tce table size - measured in entries */
 	tbl->it_size = table_size_to_number_of_entries(specified_table_size);
 
-	tbl->it_base = (unsigned long)tce_table_kva[dev->bus->number];
-	if (!tbl->it_base) {
-		printk(KERN_ERR "Calgary: iommu_table_setparms: "
-		       "no table allocated?!\n");
-		ret = -ENOMEM;
-		goto done;
-	}
-
 	/*
 	 * number of bytes needed for the bitmap size in number of
 	 * entries; we need one bit per entry
@@ -162,8 +154,6 @@ int build_tce_table(struct pci_dev *dev,
 	if (ret)
 		goto free_tbl;
 
-	tce_free(tbl, 0, tbl->it_size);
-
 	tbl->bbar = bbar;
 
 	/*
Index: linux/include/asm-x86_64/tce.h
===================================================================
--- linux.orig/include/asm-x86_64/tce.h
+++ linux/include/asm-x86_64/tce.h
@@ -24,7 +24,6 @@
 #ifndef _ASM_X86_64_TCE_H
 #define _ASM_X86_64_TCE_H
 
-extern void* tce_table_kva[];
 extern unsigned int specified_table_size;
 struct iommu_table;
 
