Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932275AbWGRPNE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932275AbWGRPNE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jul 2006 11:13:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932270AbWGRPMl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jul 2006 11:12:41 -0400
Received: from mtagate1.uk.ibm.com ([195.212.29.134]:40377 "EHLO
	mtagate1.uk.ibm.com") by vger.kernel.org with ESMTP id S932272AbWGRPMh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jul 2006 11:12:37 -0400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 2 of 2] x86-64: Calgary IOMMU - Multi-Node NULL pointer
	dereference fix
X-Mercurial-Node: 30907640653333b354a19c8d2118264aa6d70097
Message-Id: <30907640653333b354a1.1153235478@rhun.haifa.ibm.com>
In-Reply-To: <patchbomb.1153235476@rhun.haifa.ibm.com>
Date: Tue, 18 Jul 2006 18:11:18 +0300
From: Muli Ben-Yehuda <muli@il.ibm.com>
To: ak@suse.de
Cc: jdmason@us.ibm.com, discuss@x86-64.org, linux-kernel@vger.kernel.org,
       konradr@redhat.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# HG changeset patch
# User Muli Ben-Yehuda <muli@il.ibm.com>
# Date 1153235016 -10800
# Node ID 30907640653333b354a19c8d2118264aa6d70097
# Parent  81635ec2e677165285c2a483958899217f9631d8
x86-64: Calgary IOMMU - Multi-Node NULL pointer dereference fix

[Jon Mason says:]

Calgary hits a NULL pointer dereference when booting in a
multi-chassis NUMA system.  See Redhat bugzilla number 198498, found
by Konrad Rzeszutek (konradr@redhat.com).

There are many issues that had to be resolved to fix this problem.
Firstly when I originally wrote the code to handle NUMA systems, I had
a large misunderstanding that was not corrected until now.  That was
that I thought the "number of nodes online" referred to number of
physical systems connected.  So that if NUMA was disabled, there would
only be 1 node and it would only show that node's PCI bus.  In reality
if NUMA is disabled, the system displays all of the connected chassis
as one node but is only ignorant of the delays in accessing main
memory.  Therefore, references to num_online_nodes() and MAX_NUMNODES
are incorrect and need to be set to the maximum number of nodes that
can be accessed (which are 8).  I created a variable, MAX_NUM_CHASSIS,
and set it to 8 to fix this.

Secondly, when walking the PCI in detect_calgary, the code only
checked the first "slot" when looking to see if a device is present.
This will work for most cases, but unfortunately it isn't always the
case.  In the NUMA MXE drawers, there are USB devices present on the
3rd slot (with slot 1 being empty).  So, to work around this, all
slots (up to 8) are scanned to see if there are any devices present.

Lastly, the bus is being enumerated on large systems in a different
way the we originally thought.  This throws the ugly logic we had out
the window.  To more elegantly handle this, I reorganized the kva
array to be sparse (which removed the need to have any bus number to
kva slot logic in tce.c) and created a secondary space array to
contain the bus number to phb mapping.

With these changes Calgary boots on an x460 with 4 nodes with and
without NUMA enabled.

Signed-Off-By: Jon Mason <jdmason@us.ibm.com>
Signed-Off-By: Muli Ben-Yehuda <muli@il.ibm.com>

diff -r 81635ec2e677 -r 309076406533 arch/x86_64/kernel/pci-calgary.c
--- a/arch/x86_64/kernel/pci-calgary.c	Tue Jul 18 18:03:08 2006 +0300
+++ b/arch/x86_64/kernel/pci-calgary.c	Tue Jul 18 18:03:36 2006 +0300
@@ -85,7 +85,8 @@
 #define CSR_AGENT_MASK		0xffe0ffff
 
 #define MAX_NUM_OF_PHBS		8 /* how many PHBs in total? */
-#define MAX_PHB_BUS_NUM		(MAX_NUM_OF_PHBS * 2) /* max dev->bus->number */
+#define MAX_NUM_CHASSIS		8 /* max number of chassis */
+#define MAX_PHB_BUS_NUM		(MAX_NUM_OF_PHBS * MAX_NUM_CHASSIS * 2) /* max dev->bus->number */
 #define PHBS_PER_CALGARY	4
 
 /* register offsets in Calgary's internal register space */
@@ -110,7 +111,8 @@ static const unsigned long phb_offsets[]
 	0xB000 /* PHB3 */
 };
 
-void* tce_table_kva[MAX_NUM_OF_PHBS * MAX_NUMNODES];
+static char bus_to_phb[MAX_PHB_BUS_NUM];
+void* tce_table_kva[MAX_PHB_BUS_NUM];
 unsigned int specified_table_size = TCE_TABLE_SIZE_UNSPECIFIED;
 static int translate_empty_slots __read_mostly = 0;
 static int calgary_detected __read_mostly = 0;
@@ -119,7 +121,7 @@ static int calgary_detected __read_mostl
  * the bitmap of PHBs the user requested that we disable
  * translation on.
  */
-static DECLARE_BITMAP(translation_disabled, MAX_NUMNODES * MAX_PHB_BUS_NUM);
+static DECLARE_BITMAP(translation_disabled, MAX_PHB_BUS_NUM);
 
 static void tce_cache_blast(struct iommu_table *tbl);
 
@@ -452,7 +454,7 @@ static struct dma_mapping_ops calgary_dm
 
 static inline int busno_to_phbid(unsigned char num)
 {
-	return bus_to_phb(num) % PHBS_PER_CALGARY;
+	return bus_to_phb[num];
 }
 
 static inline unsigned long split_queue_offset(unsigned char num)
@@ -812,7 +814,7 @@ static int __init calgary_init(void)
 	int i, ret = -ENODEV;
 	struct pci_dev *dev = NULL;
 
-	for (i = 0; i < num_online_nodes() * MAX_NUM_OF_PHBS; i++) {
+	for (i = 0; i < MAX_PHB_BUS_NUM; i++) {
 		dev = pci_get_device(PCI_VENDOR_ID_IBM,
 				     PCI_DEVICE_ID_IBM_CALGARY,
 				     dev);
@@ -822,7 +824,7 @@ static int __init calgary_init(void)
 			calgary_init_one_nontraslated(dev);
 			continue;
 		}
-		if (!tce_table_kva[i] && !translate_empty_slots) {
+		if (!tce_table_kva[dev->bus->number] && !translate_empty_slots) {
 			pci_dev_put(dev);
 			continue;
 		}
@@ -842,7 +844,7 @@ error:
 			pci_dev_put(dev);
 			continue;
 		}
-		if (!tce_table_kva[i] && !translate_empty_slots)
+		if (!tce_table_kva[dev->bus->number] && !translate_empty_slots)
 			continue;
 		calgary_disable_translation(dev);
 		calgary_free_tar(dev);
@@ -876,9 +878,10 @@ void __init detect_calgary(void)
 void __init detect_calgary(void)
 {
 	u32 val;
-	int bus, table_idx;
+	int bus;
 	void *tbl;
-	int detected = 0;
+	int calgary_found = 0;
+	int phb = -1;
 
 	/*
 	 * if the user specified iommu=off or iommu=soft or we found
@@ -889,37 +892,46 @@ void __init detect_calgary(void)
 
 	specified_table_size = determine_tce_table_size(end_pfn * PAGE_SIZE);
 
-	for (bus = 0, table_idx = 0;
-	     bus < num_online_nodes() * MAX_PHB_BUS_NUM;
-	     bus++) {
+	for (bus = 0; bus < MAX_PHB_BUS_NUM; bus++) {
+		int dev;
+
+		tce_table_kva[bus] = NULL;
+		bus_to_phb[bus] = -1;
+
 		if (read_pci_config(bus, 0, 0, 0) != PCI_VENDOR_DEVICE_ID_CALGARY)
 			continue;
+
+		/* 
+		 * There are 4 PHBs per Calgary chip.  Set phb to which phb (0-3)
+		 * it is connected to releative to the clagary chip.
+		 */
+		phb = (phb + 1) % PHBS_PER_CALGARY;
+
 		if (test_bit(bus, translation_disabled)) {
 			printk(KERN_INFO "Calgary: translation is disabled for "
 			       "PHB 0x%x\n", bus);
 			/* skip this phb, don't allocate a tbl for it */
-			tce_table_kva[table_idx] = NULL;
-			table_idx++;
 			continue;
 		}
 		/*
-		 * scan the first slot of the PCI bus to see if there
-		 * are any devices present
+		 * Scan the slots of the PCI bus to see if there is a device present.
+		 * The parent bus will be the zero-ith device, so start at 1.
 		 */
-		val = read_pci_config(bus, 1, 0, 0);
-		if (val != 0xffffffff || translate_empty_slots) {
-			tbl = alloc_tce_table();
-			if (!tbl)
-				goto cleanup;
-			detected = 1;
-		} else
-			tbl = NULL;
-
-		tce_table_kva[table_idx] = tbl;
-		table_idx++;
-	}
-
-	if (detected) {
+		for (dev = 1; dev < 8; dev++) {
+			val = read_pci_config(bus, dev, 0, 0);
+			if (val != 0xffffffff || translate_empty_slots) {
+				tbl = alloc_tce_table();
+				if (!tbl)
+					goto cleanup;
+				tce_table_kva[bus] = tbl;
+				bus_to_phb[bus] = phb;
+				calgary_found = 1;
+				break;
+			}
+		}
+	}
+
+	if (calgary_found) {
 		iommu_detected = 1;
 		calgary_detected = 1;
 		printk(KERN_INFO "PCI-DMA: Calgary IOMMU detected. "
@@ -928,9 +940,9 @@ void __init detect_calgary(void)
 	return;
 
 cleanup:
-	for (--table_idx; table_idx >= 0; --table_idx)
-		if (tce_table_kva[table_idx])
-			free_tce_table(tce_table_kva[table_idx]);
+	for (--bus; bus >= 0; --bus)
+		if (tce_table_kva[bus])
+			free_tce_table(tce_table_kva[bus]);
 }
 
 int __init calgary_iommu_init(void)
@@ -1001,7 +1013,7 @@ static int __init calgary_parse_options(
 			if (p == endp)
 				break;
 
-			if (bridge < (num_online_nodes() * MAX_PHB_BUS_NUM)) {
+			if (bridge < MAX_PHB_BUS_NUM) {
 				printk(KERN_INFO "Calgary: disabling "
 				       "translation for PHB 0x%x\n", bridge);
 				set_bit(bridge, translation_disabled);
diff -r 81635ec2e677 -r 309076406533 arch/x86_64/kernel/tce.c
--- a/arch/x86_64/kernel/tce.c	Tue Jul 18 18:03:08 2006 +0300
+++ b/arch/x86_64/kernel/tce.c	Tue Jul 18 18:03:36 2006 +0300
@@ -96,7 +96,6 @@ static int tce_table_setparms(struct pci
 static int tce_table_setparms(struct pci_dev *dev, struct iommu_table *tbl)
 {
 	unsigned int bitmapsz;
-	unsigned int tce_table_index;
 	unsigned long bmppages;
 	int ret;
 
@@ -105,8 +104,7 @@ static int tce_table_setparms(struct pci
 	/* set the tce table size - measured in entries */
 	tbl->it_size = table_size_to_number_of_entries(specified_table_size);
 
-	tce_table_index = bus_to_phb(tbl->it_busno);
-	tbl->it_base = (unsigned long)tce_table_kva[tce_table_index];
+	tbl->it_base = (unsigned long)tce_table_kva[dev->bus->number];
 	if (!tbl->it_base) {
 		printk(KERN_ERR "Calgary: iommu_table_setparms: "
 		       "no table allocated?!\n");
diff -r 81635ec2e677 -r 309076406533 include/asm-x86_64/calgary.h
--- a/include/asm-x86_64/calgary.h	Tue Jul 18 18:03:08 2006 +0300
+++ b/include/asm-x86_64/calgary.h	Tue Jul 18 18:03:36 2006 +0300
@@ -60,9 +60,4 @@ static inline void detect_calgary(void) 
 static inline void detect_calgary(void) { return; }
 #endif
 
-static inline unsigned int bus_to_phb(unsigned char busno)
-{
-	return ((busno % 15 == 0) ? 0 : busno / 2 + 1);
-}
-
 #endif /* _ASM_X86_64_CALGARY_H */
