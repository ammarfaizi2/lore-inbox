Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263301AbUCRXIQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 18:08:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263192AbUCRXHZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 18:07:25 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:53744 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S263039AbUCRXFZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 18:05:25 -0500
Subject: [PATCH] nodemask_t pp64 changes [4/7]
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
To: linux-kernel@vger.kernel.org, mbligh@aracnet.com, akpm@osdl.org,
       wli@holomorphy.com, haveblue@us.ibm.com
Content-Type: multipart/mixed; boundary="=-jQStYKZRBRkfsFIvJAGg"
Organization: IBM LTC
Message-Id: <1079651080.8149.173.camel@arrakis>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Thu, 18 Mar 2004 15:04:43 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-jQStYKZRBRkfsFIvJAGg
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

nodemask_t-04-ppc64.patch - Changes to ppc64 specific code.  Untested. 
Code review & testing requested.

--=-jQStYKZRBRkfsFIvJAGg
Content-Disposition: attachment; filename=nodemask_t-04-ppc64.patch
Content-Type: text/x-patch; name=nodemask_t-04-ppc64.patch; charset=
Content-Transfer-Encoding: 7bit

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
+++ linux-2.6.4-nodemask_t-ppc64/arch/ppc64/mm/numa.c	Thu Mar 11 16:43:09 2004
@@ -101,7 +101,7 @@ static int __init parse_numa_properties(
 			numa_domain = 0;
 		}
 
-		if (numa_domain >= MAX_NUMNODES)
+		if (!node_possible(numa_domain))
 			BUG();
 
 		node_set_online(numa_domain);
@@ -157,7 +157,7 @@ new_range:
 			numa_domain = 0;
 		}
 
-		if (numa_domain >= MAX_NUMNODES)
+		if (!node_possible(numa_domain))
 			BUG();
 
 		if (max_domain < numa_domain)
@@ -198,7 +198,8 @@ new_range:
 			goto new_range;
 	}
 
-	numnodes = max_domain + 1;
+	for(i = 0; i <= max_domain; i++)
+		node_set_online(i);
 
 	return 0;
 err:
@@ -242,7 +243,7 @@ void __init do_init_bootmem(void)
 	if (parse_numa_properties())
 		setup_nonnuma();
 
-	for (nid = 0; nid < numnodes; nid++) {
+	for_each_online_node(nid) {
 		unsigned long start_paddr, end_paddr;
 		int i;
 		unsigned long bootmem_paddr;
@@ -329,7 +330,7 @@ void __init paging_init(void)
 	memset(zones_size, 0, sizeof(zones_size));
 	memset(zholes_size, 0, sizeof(zholes_size));
 
-	for (nid = 0; nid < numnodes; nid++) {
+	for_each_online_node(nid) {
 		unsigned long start_pfn;
 		unsigned long end_pfn;
 

--=-jQStYKZRBRkfsFIvJAGg--

