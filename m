Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262454AbUDHUD5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Apr 2004 16:03:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262418AbUDHUAy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Apr 2004 16:00:54 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:3047 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S262454AbUDHTvH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Apr 2004 15:51:07 -0400
Date: Thu, 8 Apr 2004 12:50:30 -0700
From: Paul Jackson <pj@sgi.com>
To: Paul Jackson <pj@sgi.com>
Cc: colpatch@us.ibm.com, wli@holomorphy.com, rusty@rustcorp.com.au,
       linux-kernel@vger.kernel.org
Subject: Patch 20/23 - Bitmaps, Cpumasks and Nodemasks
Message-Id: <20040408125030.2b710efa.pj@sgi.com>
In-Reply-To: <20040408115050.2c67311a.pj@sgi.com>
References: <20040408115050.2c67311a.pj@sgi.com>
Organization: SGI
X-Mailer: Sylpheed version 0.9.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

P20.nodemask_pp64 - Matthew Dobson's [PATCH]_nodemask_t_pp64_changes_[4_7]
        Changes to ppc64 specific code.  Untested.
        Code review & testing requested.

Index: 2.6.5.bitmap/arch/ppc64/kernel/smp.c
===================================================================
--- 2.6.5.bitmap.orig/arch/ppc64/kernel/smp.c	2004-04-05 02:41:32.000000000 -0700
+++ 2.6.5.bitmap/arch/ppc64/kernel/smp.c	2004-04-08 04:46:10.000000000 -0700
@@ -737,19 +737,17 @@
 	int i;
 	int ret;
 
-	for (i = 0; i < MAX_NUMNODES; i++) {
-		if (node_online(i)) {
-			int p_node = parent_node(i);
-			struct node *parent = NULL;
-
-			if (p_node != i)
-				parent = &node_devices[p_node];
-
-			ret = register_node(&node_devices[i], i, parent);
-			if (ret)
-				printk(KERN_WARNING "register_nodes: "
-				       "register_node %d failed (%d)", i, ret);
-		}
+	for_each_online_node(i) {
+		int p_node = parent_node(i);
+		struct node *parent = NULL;
+
+		if (p_node != i)
+			parent = &node_devices[p_node];
+
+		ret = register_node(&node_devices[i], i, parent);
+		if (ret)
+			printk(KERN_WARNING "register_nodes: "
+			       "register_node %d failed (%d)", i, ret);
 	}
 }
 #else
Index: 2.6.5.bitmap/arch/ppc64/mm/hugetlbpage.c
===================================================================
--- 2.6.5.bitmap.orig/arch/ppc64/mm/hugetlbpage.c	2004-04-05 02:41:32.000000000 -0700
+++ 2.6.5.bitmap/arch/ppc64/mm/hugetlbpage.c	2004-04-08 04:46:10.000000000 -0700
@@ -56,10 +56,10 @@
 	if (!largepage_roundrobin)
 		nid = numa_node_id();
 
-	for (i = 0; i < numnodes; i++) {
+	for_each_online_node(i) {
 		if (!list_empty(&hugepage_freelists[nid]))
 			break;
-		nid = (nid + 1) % numnodes;
+		nid = (nid + 1) % num_online_nodes();
 	}
 
 	if (!list_empty(&hugepage_freelists[nid])) {
@@ -68,7 +68,7 @@
 	}
 
 	if (largepage_roundrobin)
-		nid = (nid + 1) % numnodes;
+		nid = (nid + 1) % num_online_nodes();
 
 	return page;
 }
@@ -83,7 +83,7 @@
 		return NULL;
 
 	nid = page_zone(page)->zone_pgdat->node_id;
-	nid = (nid + 1) % numnodes;
+	nid = (nid + 1) % num_online_nodes();
 	return page;
 }
 
@@ -887,7 +887,7 @@
 	struct page *page;
 
 	if (cur_cpu_spec->cpu_features & CPU_FTR_16M_PAGE) {
-		for (i = 0; i < MAX_NUMNODES; ++i)
+		for_each_node(i)
 			INIT_LIST_HEAD(&hugepage_freelists[i]);
 
 		for (i = 0; i < htlbpage_max; ++i) {
Index: 2.6.5.bitmap/arch/ppc64/mm/init.c
===================================================================
--- 2.6.5.bitmap.orig/arch/ppc64/mm/init.c	2004-04-05 02:41:32.000000000 -0700
+++ 2.6.5.bitmap/arch/ppc64/mm/init.c	2004-04-08 04:46:10.000000000 -0700
@@ -637,7 +637,7 @@
 {
 	int nid;
 
-        for (nid = 0; nid < numnodes; nid++) {
+	for_each_online_node(nid) {
 		if (node_data[nid].node_spanned_pages != 0) {
 			printk("freeing bootmem node %x\n", nid);
 			totalram_pages +=
Index: 2.6.5.bitmap/arch/ppc64/mm/numa.c
===================================================================
--- 2.6.5.bitmap.orig/arch/ppc64/mm/numa.c	2004-04-05 02:41:32.000000000 -0700
+++ 2.6.5.bitmap/arch/ppc64/mm/numa.c	2004-04-08 04:46:10.000000000 -0700
@@ -64,7 +64,6 @@
 	int *cpu_associativity;
 	int *memory_associativity;
 	int depth;
-	int max_domain = 0;
 
 	if (strstr(saved_command_line, "numa=off")) {
 		printk(KERN_WARNING "NUMA disabled by user\n");
@@ -115,14 +114,11 @@
 			numa_domain = 0;
 		}
 
-		if (numa_domain >= MAX_NUMNODES)
+		if (!node_possible(numa_domain))
 			BUG();
 
 		node_set_online(numa_domain);
 
-		if (max_domain < numa_domain)
-			max_domain = numa_domain;
-
 		map_cpu_to_node(cpu_nr, numa_domain);
 	}
 
@@ -171,11 +167,10 @@
 			numa_domain = 0;
 		}
 
-		if (numa_domain >= MAX_NUMNODES)
+		if (!node_possible(numa_domain))
 			BUG();
 
-		if (max_domain < numa_domain)
-			max_domain = numa_domain;
+		node_set_online(numa_domain);
 
 		/* 
 		 * For backwards compatibility, OF splits the first node
@@ -212,8 +207,6 @@
 			goto new_range;
 	}
 
-	numnodes = max_domain + 1;
-
 	return 0;
 err:
 	of_node_put(cpu);
@@ -256,7 +249,7 @@
 	if (parse_numa_properties())
 		setup_nonnuma();
 
-	for (nid = 0; nid < numnodes; nid++) {
+	for_each_online_node(nid) {
 		unsigned long start_paddr, end_paddr;
 		int i;
 		unsigned long bootmem_paddr;
@@ -343,7 +336,7 @@
 	memset(zones_size, 0, sizeof(zones_size));
 	memset(zholes_size, 0, sizeof(zholes_size));
 
-	for (nid = 0; nid < numnodes; nid++) {
+	for_each_online_node(nid) {
 		unsigned long start_pfn;
 		unsigned long end_pfn;
 


-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
