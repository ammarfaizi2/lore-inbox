Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161406AbWG2CwT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161406AbWG2CwT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 22:52:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161407AbWG2CwT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 22:52:19 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:34445 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1161406AbWG2CwS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 22:52:18 -0400
Subject: [Patch] 1/5 in support of hot-add memory x86_64 nodes_add cleanup
From: keith mannthey <kmannth@us.ibm.com>
Reply-To: kmannth@us.ibm.com
To: lkml <linux-kernel@vger.kernel.org>
Cc: lhms-devel <lhms-devel@lists.sourceforge.net>,
       discuss <discuss@x86-64.org>, Andi Kleen <ak@suse.de>,
       andrew <akpm@osdl.org>, dave hansen <haveblue@us.ibm.com>,
       kame <kamezawa.hiroyu@jp.fujitsu.com>, konrad <darnok@us.ibm.com>
Content-Type: multipart/mixed; boundary="=-T46+SJBogk2NkP029uPc"
Organization: Linux Technology Center IBM
Date: Fri, 28 Jul 2006 19:52:15 -0700
Message-Id: <1154141535.5874.145.camel@keithlap>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-T46+SJBogk2NkP029uPc
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

  This patch cleans up the srat.c file with respects to the 2 hot-add
paths available.  It creates Kconfig options to represent the desired
functionality and implements their usage. 

  The current code already saves the information need (NUMA locality of
hot-add memory ranges) for MEMORY_HOTPLUG in the RESERVE_MEMORY path.  I
amend the memory parsing code to support the needs of both and save the
nodes_add data for use at runtime.  

Built against 2.6.18-rc2 

Signed-off-by:  Keith Mannthey <kmannth@us.ibm.com>


--=-T46+SJBogk2NkP029uPc
Content-Disposition: attachment; filename=patch-2.6.18-rc2-nodesadd
Content-Type: text/x-patch; name=patch-2.6.18-rc2-nodesadd; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -urN orig/arch/x86_64/Kconfig work/arch/x86_64/Kconfig
--- orig/arch/x86_64/Kconfig	2006-07-28 13:57:35.000000000 -0400
+++ work/arch/x86_64/Kconfig	2006-07-28 21:17:03.000000000 -0400
@@ -349,6 +349,17 @@
 
 source "mm/Kconfig"
 
+config RESERVE_HOTADD
+	bool "Reserve based hot-add memory" 
+	depends on DISCONTIGMEM && X86_64_ACPI_NUMA
+	default n
+	help
+	  This allows a reserved based approach to hot add memory.
+	  Select this option if your hardware supports hot-add memroy 
+	  via ACPI and the SRAT table.  You will need to still build in 
+	  the ACPI hot plug memory driver to do the actual add. 
+
+
 config HAVE_ARCH_EARLY_PFN_TO_NID
 	def_bool y
 	depends on NUMA
diff -urN orig/arch/x86_64/mm/srat.c work/arch/x86_64/mm/srat.c
--- orig/arch/x86_64/mm/srat.c	2006-07-28 13:57:35.000000000 -0400
+++ work/arch/x86_64/mm/srat.c	2006-07-28 21:17:23.000000000 -0400
@@ -21,22 +21,13 @@
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
 static struct bootnode nodes[MAX_NUMNODES] __initdata;
 static struct bootnode nodes_add[MAX_NUMNODES] __initdata;
-static int found_add_area __initdata;
+static int reserve_add_area __initdata;
 int hotadd_percent __initdata = 0;
-#ifndef RESERVE_HOTADD
-#define hotadd_percent 0	/* Ignore all settings */
-#endif
 
 /* Too small nodes confuse the VM badly. Usually they result
    from BIOS bugs. */
@@ -66,7 +57,7 @@
 {
 	struct bootnode *nd = &nodes[i];
 
-	if (found_add_area)
+	if (reserve_add_area)
 		return;
 
 	if (nd->start < start) {
@@ -86,7 +77,7 @@
 	int i;
 	printk(KERN_ERR "SRAT: SRAT not used.\n");
 	acpi_numa = -1;
-	found_add_area = 0;
+	reserve_add_area = 0;
 	for (i = 0; i < MAX_LOCAL_APIC; i++)
 		apicid_to_node[i] = NUMA_NO_NODE;
 	for (i = 0; i < MAX_NUMNODES; i++)
@@ -157,7 +148,7 @@
 	       pxm, pa->apic_id, node);
 }
 
-#ifdef RESERVE_HOTADD
+#ifdef CONFIG_RESERVE_HOTADD
 /*
  * Protect against too large hotadd areas that would fill up memory.
  */
@@ -200,15 +191,38 @@
 	return 1;
 }
 
+int update_end_of_memory(unsigned long end) 
+{
+	reserve_add_area = 1;
+ 	if ((end >> PAGE_SHIFT) > end_pfn)
+		end_pfn = end >> PAGE_SHIFT;
+	return 1;
+}
+
+static inline int save_add_info(void) 
+{
+	return hotadd_percent > 0;
+}
+#else /* !CONFIG_RESERVE_HOTADD */
+int update_end_of_memory(unsigned long end) {return 0;}
+static int hotadd_enough_memory(struct bootnode *nd) {return 1;}
+#ifdef CONFIG_MEMORY_HOTPLUG
+static inline int save_add_info(void) {return 1;}
+#else /* !CONFIG_MEMORY_HOTPLUG */
+static inline int save_add_info(void) {return 0;}
+#endif 
+#endif 
+ 
 /*
- * It is fine to add this area to the nodes data it will be used later
+ * Udate nodes_add and decide if to save info in the real nodes sturcture
+ * Both MEMORY_HOTPLUG and RESERVE_HOTADD need the nodes_add info
  * This code supports one contigious hot add area per node.
  */
 static int reserve_hotadd(int node, unsigned long start, unsigned long end)
 {
 	unsigned long s_pfn = start >> PAGE_SHIFT;
 	unsigned long e_pfn = end >> PAGE_SHIFT;
-	int changed = 0;
+	int ret = 0 , changed = 0;
 	struct bootnode *nd = &nodes_add[node];
 
 	/* I had some trouble with strange memory hotadd regions breaking
@@ -235,7 +249,6 @@
 
 	/* Looks good */
 
- 	found_add_area = 1;
 	if (nd->start == nd->end) {
  		nd->start = start;
  		nd->end = end;
@@ -252,15 +265,14 @@
 		if (!changed)
 			printk(KERN_ERR "SRAT: Hotplug zone not continuous. Partly ignored\n");
  	}
-
- 	if ((nd->end >> PAGE_SHIFT) > end_pfn)
- 		end_pfn = nd->end >> PAGE_SHIFT;
+	
+	ret = update_end_of_memory(nd->end);
 
 	if (changed)
-	 	printk(KERN_INFO "SRAT: hot plug zone found %Lx - %Lx\n", nd->start, nd->end);
-	return 0;
+	 	printk(KERN_INFO "SRAT: hot plug zone found %Lx - %Lx\n",  
+							nd->start, nd->end);
+	return ret;
 }
-#endif
 
 /* Callback for parsing of the Proximity Domain <-> Memory Area mappings */
 void __init
@@ -279,7 +291,7 @@
 	}
 	if (ma->flags.enabled == 0)
 		return;
- 	if (ma->flags.hot_pluggable && hotadd_percent == 0)
+ 	if (ma->flags.hot_pluggable && !save_add_info())
 		return;
 	start = ma->base_addr_lo | ((u64)ma->base_addr_hi << 32);
 	end = start + (ma->length_lo | ((u64)ma->length_hi << 32));
@@ -318,15 +330,13 @@
 	printk(KERN_INFO "SRAT: Node %u PXM %u %Lx-%Lx\n", node, pxm,
 	       nd->start, nd->end);
 
-#ifdef RESERVE_HOTADD
- 	if (ma->flags.hot_pluggable && reserve_hotadd(node, start, end) < 0) {
-		/* Ignore hotadd region. Undo damage */
+ 	if (ma->flags.hot_pluggable && !reserve_hotadd(node, start, end)) {
+		/* Don't reserve hotadd region. Undo damage */
 		printk(KERN_NOTICE "SRAT: Hotplug region ignored\n");
 		*nd = oldnode;
 		if ((nd->start | nd->end) == 0)
 			node_clear(node, nodes_parsed);
 	}
-#endif
 }
 
 /* Sanity check to catch more bad SRATs (they are amazingly common).
@@ -342,7 +352,6 @@
 		unsigned long e = nodes[i].end >> PAGE_SHIFT;
 		pxmram += e - s;
 		pxmram -= e820_hole_size(s, e);
-		pxmram -= nodes_add[i].end - nodes_add[i].start;
 		if ((long)pxmram < 0)
 			pxmram = 0;
 	}
@@ -422,7 +431,7 @@
 
 void __init srat_reserve_add_area(int nodeid)
 {
-	if (found_add_area && nodes_add[nodeid].end) {
+	if (reserve_add_area && nodes_add[nodeid].end) {
 		u64 total_mb;
 
 		printk(KERN_INFO "SRAT: Reserving hot-add memory space "

--=-T46+SJBogk2NkP029uPc--

