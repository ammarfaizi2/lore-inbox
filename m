Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263184AbUDAVOe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 16:14:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263209AbUDAVOd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 16:14:33 -0500
Received: from mtvcafw.sgi.com ([192.48.171.6]:45619 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S263184AbUDAVNC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 16:13:02 -0500
Date: Thu, 1 Apr 2004 13:12:27 -0800
From: Paul Jackson <pj@sgi.com>
To: Paul Jackson <pj@sgi.com>
Cc: colpatch@us.ibm.com, wli@holomorphy.com, linux-kernel@vger.kernel.org
Subject: [Patch 15/23] mask v2 - [4/7] nodemask_t_pp64_changes
Message-Id: <20040401131227.07ab65b0.pj@sgi.com>
In-Reply-To: <20040401122802.23521599.pj@sgi.com>
References: <20040401122802.23521599.pj@sgi.com>
Organization: SGI
X-Mailer: Sylpheed version 0.9.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch_15_of_23 - Matthew Dobson's [PATCH]_nodemask_t_pp64_changes_[4_7]
        Changes to ppc64 specific code.  Untested.
        Code review & testing requested.

Diffstat Patch_15_of_23:
 kernel/smp.c                   |   20 +++++++++-----------
 mm/hugetlbpage.c               |   10 +++++-----
 mm/init.c                      |    2 +-
 mm/numa.c                      |   17 +++++------------
 4 files changed, 20 insertions(+), 29 deletions(-)


diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.4-vanilla/arch/ppc64/kernel/smp.c linux-2.6.4-nodemask_t-ppc64/arch/ppc64/kernel/smp.c
--- linux-2.6.4-vanilla/arch/ppc64/kernel/smp.c	Wed Mar 10 18:55:37 2004
+++ linux-2.6.4-nodemask_t-ppc64/arch/ppc64/kernel/smp.c	Thu Mar 11 16:46:15 2004
@@ -737,19 +737,17 @@ static void register_nodes(void)
 	int i;
 	int ret;
 
-	for (i = 0; i < MAX_NUMNODES; i++) {
-		if (node_online(i)) {
-			int p_node = parent_node(i);
-			struct node *parent = NULL;
+	for_each_online_node(i) {
+		int p_node = parent_node(i);
+		struct node *parent = NULL;
 
-			if (p_node != i)
-				parent = &node_devices[p_node];
+		if (p_node != i)
+			parent = &node_devices[p_node];
 
-			ret = register_node(&node_devices[i], i, parent);
-			if (ret)
-				printk(KERN_WARNING "register_nodes: "
-				       "register_node %d failed (%d)", i, ret);
-		}
+		ret = register_node(&node_devices[i], i, parent);
+		if (ret)
+			printk(KERN_WARNING "register_nodes: "
+			       "register_node %d failed (%d)", i, ret);
 	}
 }
 #else
diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.4-vanilla/arch/ppc64/mm/hugetlbpage.c linux-2.6.4-nodemask_t-ppc64/arch/ppc64/mm/hugetlbpage.c
--- linux-2.6.4-vanilla/arch/ppc64/mm/hugetlbpage.c	Wed Mar 10 18:55:27 2004
+++ linux-2.6.4-nodemask_t-ppc64/arch/ppc64/mm/hugetlbpage.c	Thu Mar 11 12:00:08 2004
@@ -56,10 +56,10 @@ static struct page *dequeue_huge_page(vo
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
@@ -68,7 +68,7 @@ static struct page *dequeue_huge_page(vo
 	}
 
 	if (largepage_roundrobin)
-		nid = (nid + 1) % numnodes;
+		nid = (nid + 1) % num_online_nodes();
 
 	return page;
 }
@@ -83,7 +83,7 @@ static struct page *alloc_fresh_huge_pag
 		return NULL;
 
 	nid = page_zone(page)->zone_pgdat->node_id;
-	nid = (nid + 1) % numnodes;
+	nid = (nid + 1) % num_online_nodes();
 	return page;
 }
 
@@ -871,7 +871,7 @@ static int __init hugetlb_init(void)
 	struct page *page;
 
 	if (cur_cpu_spec->cpu_features & CPU_FTR_16M_PAGE) {
-		for (i = 0; i < MAX_NUMNODES; ++i)
+		for_each_node(i)
 			INIT_LIST_HEAD(&hugepage_freelists[i]);
 
 		for (i = 0; i < htlbpage_max; ++i) {
diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.4-vanilla/arch/ppc64/mm/init.c linux-2.6.4-nodemask_t-ppc64/arch/ppc64/mm/init.c
--- linux-2.6.4-vanilla/arch/ppc64/mm/init.c	Wed Mar 10 18:55:33 2004
+++ linux-2.6.4-nodemask_t-ppc64/arch/ppc64/mm/init.c	Thu Mar 11 12:00:08 2004
@@ -639,7 +639,7 @@ void __init mem_init(void)
 {
 	int nid;
 
-        for (nid = 0; nid < numnodes; nid++) {
+	for_each_online_node(nid) {
 		if (node_data[nid].node_spanned_pages != 0) {
 			printk("freeing bootmem node %x\n", nid);
 			totalram_pages +=
diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.4-vanilla/arch/ppc64/mm/numa.c linux-2.6.4-nodemask_t-ppc64/arch/ppc64/mm/numa.c
--- linux-2.6.4-vanilla/arch/ppc64/mm/numa.c	Wed Mar 10 18:55:36 2004
+++ linux-2.6.4-nodemask_t-ppc64/arch/ppc64/mm/numa.c	Mon Mar 22 15:41:15 2004
@@ -55,7 +55,6 @@ static int __init parse_numa_properties(
 	int *cpu_associativity;
 	int *memory_associativity;
 	int depth;
-	int max_domain = 0;
 
 	cpu = of_find_node_by_type(NULL, "cpu");
 	if (!cpu)
@@ -101,14 +100,11 @@ static int __init parse_numa_properties(
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
 
@@ -157,11 +153,10 @@ new_range:
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
@@ -198,8 +193,6 @@ new_range:
 			goto new_range;
 	}
 
-	numnodes = max_domain + 1;
-
 	return 0;
 err:
 	of_node_put(cpu);
@@ -242,7 +235,7 @@ void __init do_init_bootmem(void)
 	if (parse_numa_properties())
 		setup_nonnuma();
 
-	for (nid = 0; nid < numnodes; nid++) {
+	for_each_online_node(nid) {
 		unsigned long start_paddr, end_paddr;
 		int i;
 		unsigned long bootmem_paddr;
@@ -329,7 +322,7 @@ void __init paging_init(void)
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
