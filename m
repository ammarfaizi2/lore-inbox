Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964792AbWGYQ50@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964792AbWGYQ50 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 12:57:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964793AbWGYQ5G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 12:57:06 -0400
Received: from mtagate3.uk.ibm.com ([195.212.29.136]:48847 "EHLO
	mtagate3.uk.ibm.com") by vger.kernel.org with ESMTP id S964792AbWGYQ47
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 12:56:59 -0400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 2 of 7] [x86-64] Calgary IOMMU: consolidate per bus data
	structures
X-Mercurial-Node: f85ffa73fb99f4796043a8e50bef1180e36fe582
Message-Id: <f85ffa73fb99f4796043.1153846592@rhun.haifa.ibm.com>
In-Reply-To: <patchbomb.1153846590@rhun.haifa.ibm.com>
Date: Tue, 25 Jul 2006 19:56:32 +0300
From: Muli Ben-Yehuda <muli@il.ibm.com>
To: ak@suse.de
Cc: jdmason@us.ibm.com, linux-kernel@vger.kernel.org, discuss@x86-64.org,
       muli@il.ibm.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

3 files changed, 29 insertions(+), 37 deletions(-)
arch/x86_64/kernel/pci-calgary.c |   55 ++++++++++++++++++++------------------
arch/x86_64/kernel/tce.c         |   10 ------
include/asm-x86_64/tce.h         |    1 


# HG changeset patch
# User Muli Ben-Yehuda <muli@il.ibm.com>
# Date 1153735276 -10800
# Node ID f85ffa73fb99f4796043a8e50bef1180e36fe582
# Parent  bc678333b410a6aa7bf86a97f314a62c300dae3a
[x86-64] Calgary IOMMU: consolidate per bus data structures

Move the tce_table_kva array, disabled bitmap and bus_to_phb array
into a new per bus 'struct calgary_bus_info'. Also slightly reorganize
build_tce_table and tce_table_setparms to avoid exporting bus_info to
tce.c.

Signed-off-by: Muli Ben-Yehuda <muli@il.ibm.com>
Signed-off-by: Jon Mason <jdmason@us.ibm.com>

diff -r bc678333b410 -r f85ffa73fb99 arch/x86_64/kernel/pci-calgary.c
--- a/arch/x86_64/kernel/pci-calgary.c	Mon Jul 24 12:07:22 2006 +0300
+++ b/arch/x86_64/kernel/pci-calgary.c	Mon Jul 24 13:01:16 2006 +0300
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
@@ -630,6 +630,10 @@ static int __init calgary_setup_tar(stru
 	ret = build_tce_table(dev, bbar);
 	if (ret)
 		return ret;
+
+	tbl = dev->sysdata;
+	tbl->it_base = (unsigned long)bus_info[dev->bus->number].tce_space;
+	tce_free(tbl, 0, tbl->it_size);
 
 	calgary_reserve_regions(dev);
 
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
@@ -894,25 +898,21 @@ void __init detect_calgary(void)
 
 	for (bus = 0; bus < MAX_PHB_BUS_NUM; bus++) {
 		int dev;
-
-		tce_table_kva[bus] = NULL;
-		bus_to_phb[bus] = -1;
+		struct calgary_bus_info *info = &bus_info[bus];
+		info->phbid = -1;
 
 		if (read_pci_config(bus, 0, 0, 0) != PCI_VENDOR_DEVICE_ID_CALGARY)
 			continue;
 
-		/* 
+		/*
 		 * There are 4 PHBs per Calgary chip.  Set phb to which phb (0-3)
 		 * it is connected to releative to the clagary chip.
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
 
diff -r bc678333b410 -r f85ffa73fb99 arch/x86_64/kernel/tce.c
--- a/arch/x86_64/kernel/tce.c	Mon Jul 24 12:07:22 2006 +0300
+++ b/arch/x86_64/kernel/tce.c	Mon Jul 24 13:01:16 2006 +0300
@@ -104,14 +104,6 @@ static int tce_table_setparms(struct pci
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
@@ -160,8 +152,6 @@ int build_tce_table(struct pci_dev *dev,
 	if (ret)
 		goto free_tbl;
 
-	tce_free(tbl, 0, tbl->it_size);
-
 	tbl->bbar = bbar;
 
 	/*
diff -r bc678333b410 -r f85ffa73fb99 include/asm-x86_64/tce.h
--- a/include/asm-x86_64/tce.h	Mon Jul 24 12:07:22 2006 +0300
+++ b/include/asm-x86_64/tce.h	Mon Jul 24 13:01:16 2006 +0300
@@ -24,7 +24,6 @@
 #ifndef _ASM_X86_64_TCE_H
 #define _ASM_X86_64_TCE_H
 
-extern void* tce_table_kva[];
 extern unsigned int specified_table_size;
 struct iommu_table;
 
