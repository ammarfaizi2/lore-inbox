Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261244AbUC3T74 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 14:59:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261263AbUC3T74
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 14:59:56 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:42400 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S261244AbUC3T7i
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 14:59:38 -0500
Subject: Re: [PATCH] mask ADT: ppc64 changes from Matthew's nodemask_t
	Patch 4/7 [13/22]
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
To: Paul Jackson <pj@sgi.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       William Lee Irwin III <wli@holomorphy.com>
In-Reply-To: <20040329041504.689996d5.pj@sgi.com>
References: <20040329041504.689996d5.pj@sgi.com>
Content-Type: multipart/mixed; boundary="=-is5OV+++Pj2R1M2FymVk"
Organization: IBM LTC
Message-Id: <1080676714.6742.167.camel@arrakis>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Tue, 30 Mar 2004 11:58:34 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-is5OV+++Pj2R1M2FymVk
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, 2004-03-29 at 04:15, Paul Jackson wrote:
> Patch_13_of_22 - Matthew Dobson's [PATCH]_nodemask_t_pp64_changes_[4_7]
> 	Changes to ppc64 specific code.  Untested.
> 	Code review & testing requested.
> 
> diffstat Patch_13_of_22:
>  kernel/smp.c     |   20 +++++++++-----------
>  mm/hugetlbpage.c |   10 +++++-----
>  mm/init.c        |    2 +-
>  mm/numa.c        |   11 ++++++-----
>  4 files changed, 21 insertions(+), 22 deletions(-)

Paul,
	As I mentioned earlier in this thread, I did have newer versions of
some of my patches.  Here's the updated version of the PPC64 patch.  The
differences are the complete removal of all references to max_domain in
parse_numa_properties() in arch/ppc64/mm/numa.c.  Upon closer
inspection, this variable and associated code isn't needed.  I also
removed the
	for(i = 0; i <= max_domain; i++)
		node_set_online(i);
loop because the nodes are onlined as we loop over the CPUs that are in
them.

-Matt

--=-is5OV+++Pj2R1M2FymVk
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
 

--=-is5OV+++Pj2R1M2FymVk--

