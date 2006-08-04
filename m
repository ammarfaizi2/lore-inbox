Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161052AbWHDNOO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161052AbWHDNOO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 09:14:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030329AbWHDNOO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 09:14:14 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:63446 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030323AbWHDNOM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 09:14:12 -0400
Date: Fri, 4 Aug 2006 07:14:09 -0600
From: Keith Mannthey <kmannth@us.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, discuss@x86-64.org, Keith Mannthey <kmannth@us.ibm.com>,
       ak@suse.de, lhms-devel@lists.sourceforge.net,
       kamezawa.hiroyu@jp.fujitsu.com
Message-Id: <20060804131409.21401.58904.sendpatchset@localhost.localdomain>
In-Reply-To: <20060804131351.21401.4877.sendpatchset@localhost.localdomain>
References: <20060804131351.21401.4877.sendpatchset@localhost.localdomain>
Subject: [PATCH 4/10] hot-add-mem x86_64: Enable SPARSEMEM in srat.c
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Keith Mannthey <kmannth@us.ibm.com>

 Enable x86_64 srat.c to share code between both reserve and sparsemem based add memory
paths.  Both paths need the hot-add area node locality infomration (nodes_add).  This 
code refactors the code path to allow this. 

Signed-off-by: Keith Mannthey<kmannth@us.ibm.com>
---
 srat.c |   51 +++++++++++++++++++++++++++++----------------------
 1 files changed, 29 insertions(+), 22 deletions(-)

Files orig/arch/x86_64/mm/.srat.c.swp and current/arch/x86_64/mm/.srat.c.swp differ
diff -urN orig/arch/x86_64/mm/srat.c current/arch/x86_64/mm/srat.c
--- orig/arch/x86_64/mm/srat.c	2006-08-04 00:41:17.000000000 -0400
+++ current/arch/x86_64/mm/srat.c	2006-08-04 01:02:25.000000000 -0400
@@ -21,12 +21,6 @@
 #include <asm/numa.h>
 #include <asm/e820.h>
 
-#if (defined(CONFIG_ACPI_HOTPLUG_MEMORY) || \
-	defined(CONFIG_ACPI_HOTPLUG_MEMORY_MODULE)) \
-		&& !defined(CONFIG_MEMORY_HOTPLUG)
-#define RESERVE_HOTADD 1
-#endif
-
 static struct acpi_table_slit *acpi_slit;
 
 static nodemask_t nodes_parsed __initdata;
@@ -34,9 +28,6 @@
 static struct bootnode nodes_add[MAX_NUMNODES] __initdata;
 static int found_add_area __initdata;
 int hotadd_percent __initdata = 0;
-#ifndef RESERVE_HOTADD
-#define hotadd_percent 0	/* Ignore all settings */
-#endif
 
 /* Too small nodes confuse the VM badly. Usually they result
    from BIOS bugs. */
@@ -157,7 +148,7 @@
 	       pxm, pa->apic_id, node);
 }
 
-#ifdef RESERVE_HOTADD
+#ifdef CONFIG_MEMORY_HOTPLUG_RESERVE
 /*
  * Protect against too large hotadd areas that would fill up memory.
  */
@@ -200,15 +191,37 @@
 	return 1;
 }
 
+static int update_end_of_memory(unsigned long end)
+{
+	found_add_area = 1;
+	if ((end >> PAGE_SHIFT) > end_pfn)
+		end_pfn = end >> PAGE_SHIFT;
+	return 1;
+}
+
+static inline int save_add_info(void)
+{
+	return hotadd_percent > 0;
+}
+#else
+int update_end_of_memory(unsigned long end) {return 0;}
+static int hotadd_enough_memory(struct bootnode *nd) {return 1;}
+#ifdef CONFIG_MEMORY_HOTPLUG_SPARSE
+static inline int save_add_info(void) {return 1;}
+#else
+static inline int save_add_info(void) {return 0;}
+#endif 
+#endif 
 /*
- * It is fine to add this area to the nodes data it will be used later
+ * Update nodes_add and decide if to include add are in the zone.  
+ * Both SPARSE and RESERVE need nodes_add infomation.
  * This code supports one contigious hot add area per node.
  */
 static int reserve_hotadd(int node, unsigned long start, unsigned long end)
 {
 	unsigned long s_pfn = start >> PAGE_SHIFT;
 	unsigned long e_pfn = end >> PAGE_SHIFT;
-	int changed = 0;
+	int ret = 0, changed = 0;
 	struct bootnode *nd = &nodes_add[node];
 
 	/* I had some trouble with strange memory hotadd regions breaking
@@ -235,7 +248,6 @@
 
 	/* Looks good */
 
- 	found_add_area = 1;
 	if (nd->start == nd->end) {
  		nd->start = start;
  		nd->end = end;
@@ -253,14 +265,12 @@
 			printk(KERN_ERR "SRAT: Hotplug zone not continuous. Partly ignored\n");
  	}
 
- 	if ((nd->end >> PAGE_SHIFT) > end_pfn)
- 		end_pfn = nd->end >> PAGE_SHIFT;
+	ret = update_end_of_memory(nd->end);
 
 	if (changed)
 	 	printk(KERN_INFO "SRAT: hot plug zone found %Lx - %Lx\n", nd->start, nd->end);
-	return 0;
+	return ret;
 }
-#endif
 
 /* Callback for parsing of the Proximity Domain <-> Memory Area mappings */
 void __init
@@ -279,7 +289,7 @@
 	}
 	if (ma->flags.enabled == 0)
 		return;
- 	if (ma->flags.hot_pluggable && hotadd_percent == 0)
+ 	if (ma->flags.hot_pluggable && !save_add_info())
 		return;
 	start = ma->base_addr_lo | ((u64)ma->base_addr_hi << 32);
 	end = start + (ma->length_lo | ((u64)ma->length_hi << 32));
@@ -318,15 +328,13 @@
 	printk(KERN_INFO "SRAT: Node %u PXM %u %Lx-%Lx\n", node, pxm,
 	       nd->start, nd->end);
 
-#ifdef RESERVE_HOTADD
- 	if (ma->flags.hot_pluggable && reserve_hotadd(node, start, end) < 0) {
+ 	if (ma->flags.hot_pluggable && !reserve_hotadd(node, start, end) < 0) {
 		/* Ignore hotadd region. Undo damage */
 		printk(KERN_NOTICE "SRAT: Hotplug region ignored\n");
 		*nd = oldnode;
 		if ((nd->start | nd->end) == 0)
 			node_clear(node, nodes_parsed);
 	}
-#endif
 }
 
 /* Sanity check to catch more bad SRATs (they are amazingly common).
@@ -342,7 +350,6 @@
 		unsigned long e = nodes[i].end >> PAGE_SHIFT;
 		pxmram += e - s;
 		pxmram -= e820_hole_size(s, e);
-		pxmram -= nodes_add[i].end - nodes_add[i].start;
 		if ((long)pxmram < 0)
 			pxmram = 0;
 	}
