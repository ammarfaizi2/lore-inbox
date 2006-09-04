Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964884AbWIDPjO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964884AbWIDPjO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 11:39:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964880AbWIDPjO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 11:39:14 -0400
Received: from calculon.skynet.ie ([193.1.99.88]:6575 "EHLO calculon.skynet.ie")
	by vger.kernel.org with ESMTP id S964877AbWIDPjM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 11:39:12 -0400
Date: Mon, 4 Sep 2006 16:39:10 +0100
To: Keith Mannthey <kmannth@gmail.com>
Cc: akpm@osdl.org, tony.luck@intel.com,
       Linux Memory Management List <linux-mm@kvack.org>, ak@suse.de,
       bob.picco@hp.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linuxppc-dev@ozlabs.org
Subject: Allow an arch to expand node boundaries
Message-ID: <20060904153910.GC14263@skynet.ie>
References: <20060821134518.22179.46355.sendpatchset@skynet.skynet.ie> <20060821134638.22179.44471.sendpatchset@skynet.skynet.ie> <a762e240608301357n3915250bk8546dd340d5d4d77@mail.gmail.com> <20060831154903.GA7011@skynet.ie> <a762e240608311052h28843b2ege651e9fa82c49f2a@mail.gmail.com> <Pine.LNX.4.64.0608311906300.13392@skynet.skynet.ie> <a762e240608312008v3e35b63ay46c95fbb6c3f15ec@mail.gmail.com> <20060904153613.GA14263@skynet.ie>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20060904153613.GA14263@skynet.ie>
User-Agent: Mutt/1.5.9i
From: mel@skynet.ie (Mel Gorman)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arch-independent zone-sizing determines the size of a node
(pgdat->node_spanned_pages) based on the physical memory that was registered
by the architecture. However, when CONFIG_MEMORY_HOTPLUG_RESERVE is set,
the architecture expects that the spanned_pages will be much larger and that
mem_map will be allocated that is used lated on memory hot-add.

This patch allows an architecture that sets CONFIG_MEMORY_HOTPLUG_RESERVE
to call push_node_boundaries() which will set the node beginning and end to
at *least* the requested boundary.

diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.18-rc4-mm3-001_account_holes_range/arch/x86_64/mm/srat.c linux-2.6.18-rc4-mm3-002_push_node_boundaries/arch/x86_64/mm/srat.c
--- linux-2.6.18-rc4-mm3-001_account_holes_range/arch/x86_64/mm/srat.c	2006-09-01 13:29:25.000000000 +0100
+++ linux-2.6.18-rc4-mm3-002_push_node_boundaries/arch/x86_64/mm/srat.c	2006-09-01 13:30:57.000000000 +0100
@@ -334,6 +334,8 @@ acpi_numa_memory_affinity_init(struct ac
 	       nd->start, nd->end);
 	e820_register_active_regions(node, nd->start >> PAGE_SHIFT,
 						nd->end >> PAGE_SHIFT);
+	push_node_boundaries(node, nd->start >> PAGE_SHIFT,
+						nd->end >> PAGE_SHIFT);
 
  	if (ma->flags.hot_pluggable && !reserve_hotadd(node, start, end) < 0) {
 		/* Ignore hotadd region. Undo damage */
diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.18-rc4-mm3-001_account_holes_range/include/linux/mm.h linux-2.6.18-rc4-mm3-002_push_node_boundaries/include/linux/mm.h
--- linux-2.6.18-rc4-mm3-001_account_holes_range/include/linux/mm.h	2006-08-28 15:05:30.000000000 +0100
+++ linux-2.6.18-rc4-mm3-002_push_node_boundaries/include/linux/mm.h	2006-09-01 13:30:57.000000000 +0100
@@ -1007,6 +1007,8 @@ extern void add_active_range(unsigned in
 					unsigned long end_pfn);
 extern void shrink_active_range(unsigned int nid, unsigned long old_end_pfn,
 						unsigned long new_end_pfn);
+extern void push_node_boundaries(unsigned int nid, unsigned long start_pfn,
+					unsigned long end_pfn);
 extern void remove_all_active_ranges(void);
 extern unsigned long absent_pages_in_range(unsigned long start_pfn,
 						unsigned long end_pfn);
diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.18-rc4-mm3-001_account_holes_range/mm/page_alloc.c linux-2.6.18-rc4-mm3-002_push_node_boundaries/mm/page_alloc.c
--- linux-2.6.18-rc4-mm3-001_account_holes_range/mm/page_alloc.c	2006-09-01 13:29:25.000000000 +0100
+++ linux-2.6.18-rc4-mm3-002_push_node_boundaries/mm/page_alloc.c	2006-09-01 13:30:57.000000000 +0100
@@ -131,6 +131,10 @@ static unsigned long __initdata dma_rese
   int __initdata nr_nodemap_entries;
   unsigned long __initdata arch_zone_lowest_possible_pfn[MAX_NR_ZONES];
   unsigned long __initdata arch_zone_highest_possible_pfn[MAX_NR_ZONES];
+#ifdef CONFIG_MEMORY_HOTPLUG_RESERVE
+  unsigned long __initdata node_boundary_start_pfn[MAX_NUMNODES];
+  unsigned long __initdata node_boundary_end_pfn[MAX_NUMNODES];
+#endif /* CONFIG_MEMORY_HOTPLUG_RESERVE */
 #endif /* CONFIG_ARCH_POPULATES_NODE_MAP */
 
 #ifdef CONFIG_DEBUG_VM
@@ -2186,6 +2190,62 @@ void __init sparse_memory_present_with_a
 }
 
 /**
+ * push_node_boundaries - Push node boundaries to at least the requested boundary
+ * @nid: The nid of the node to push the boundary for
+ * @start_pfn: The start pfn of the node
+ * @end_pfn: The end pfn of the node
+ *
+ * In reserve-based hot-add, mem_map is allocated that is unused until hotadd
+ * time. Specifically, on x86_64, SRAT will report ranges that can potentially
+ * be hotplugged even though no physical memory exists. This function allows
+ * an arch to push out the node boundaries so mem_map is allocated that can
+ * be used later.
+ */
+#ifdef CONFIG_MEMORY_HOTPLUG_RESERVE
+void __init push_node_boundaries(unsigned int nid,
+		unsigned long start_pfn, unsigned long end_pfn)
+{
+	printk(KERN_DEBUG "Entering push_node_boundaries(%u, %lu, %lu)\n",
+			nid, start_pfn, end_pfn);
+
+	/* Initialise the boundary for this node if necessary */
+	if (node_boundary_end_pfn[nid] == 0)
+		node_boundary_start_pfn[nid] = -1UL;
+
+	/* Update the boundaries */
+	if (node_boundary_start_pfn[nid] > start_pfn)
+		node_boundary_start_pfn[nid] = start_pfn;
+	if (node_boundary_end_pfn[nid] < end_pfn)
+		node_boundary_end_pfn[nid] = end_pfn;
+}
+
+/* If necessary, push the node boundary out for reserve hotadd */
+static void __init account_node_boundary(unsigned int nid,
+		unsigned long *start_pfn, unsigned long *end_pfn)
+{
+	printk(KERN_DEBUG "Entering account_node_boundary(%u, %lu, %lu)\n",
+			nid, *start_pfn, *end_pfn);
+
+	/* Return if boundary information has not been provided */
+	if (node_boundary_end_pfn[nid] == 0)
+		return;
+
+	/* Check the boundaries and update if necessary */
+	if (node_boundary_start_pfn[nid] < *start_pfn)
+		*start_pfn = node_boundary_start_pfn[nid];
+	if (node_boundary_end_pfn[nid] > *end_pfn)
+		*end_pfn = node_boundary_end_pfn[nid];
+}
+#else
+void __init push_node_boundaries(unsigned int nid,
+		unsigned long start_pfn, unsigned long end_pfn) {}
+
+static void __init account_node_boundary(unsigned int nid,
+		unsigned long *start_pfn, unsigned long *end_pfn) {}
+#endif
+
+
+/**
  * get_pfn_range_for_nid - Return the start and end page frames for a node
  * @nid: The nid to return the range for. If MAX_NUMNODES, the min and max PFN are returned
  * @start_pfn: Passed by reference. On return, it will have the node start_pfn
@@ -2212,6 +2272,9 @@ void __init get_pfn_range_for_nid(unsign
 		printk(KERN_WARNING "Node %u active with no memory\n", nid);
 		*start_pfn = 0;
 	}
+
+	/* Push the node boundaries out if requested */
+	account_node_boundary(nid, start_pfn, end_pfn);
 }
 
 /*
@@ -2655,6 +2718,10 @@ void __init remove_all_active_ranges()
 {
 	memset(early_node_map, 0, sizeof(early_node_map));
 	nr_nodemap_entries = 0;
+#ifdef CONFIG_MEMORY_HOTPLUG_RESERVE
+	memset(node_boundary_start_pfn, 0, sizeof(node_boundary_start_pfn));
+	memset(node_boundary_end_pfn, 0, sizeof(node_boundary_end_pfn));
+#endif /* CONFIG_MEMORY_HOTPLUG_RESERVE */
 }
 
 /* Compare two active node_active_regions */
