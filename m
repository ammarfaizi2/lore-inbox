Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261335AbULWWvX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261335AbULWWvX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Dec 2004 17:51:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261325AbULWWt0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Dec 2004 17:49:26 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.141]:19338 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261329AbULWWpY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Dec 2004 17:45:24 -0500
Subject: [RFC PATCH 8/10] Replace 'numnodes' with 'node_online_map' - ppc64
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
To: LKML <linux-kernel@vger.kernel.org>
Cc: LSE Tech <lse-tech@lists.sourceforge.net>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <1103838712.3945.12.camel@arrakis>
References: <1103838712.3945.12.camel@arrakis>
Content-Type: text/plain
Organization: IBM LTC
Message-Id: <1103841915.3945.34.camel@arrakis>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Thu, 23 Dec 2004 14:45:15 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

8/10 - Replace numnodes with node_online_map for ppc64

[mcd@arrakis node_online_map]$ diffstat arch-ppc64.patch
 init.c |    2 +-
 numa.c |   14 ++++++--------
 2 files changed, 7 insertions(+), 9 deletions(-)


-Matt

diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.10-rc3-mm1/arch/ppc64/mm/init.c linux-2.6.10-rc3-mm1-nom.ppc64/arch/ppc64/mm/init.c
--- linux-2.6.10-rc3-mm1/arch/ppc64/mm/init.c	2004-12-13 16:22:53.000000000 -0800
+++ linux-2.6.10-rc3-mm1-nom.ppc64/arch/ppc64/mm/init.c	2004-12-14 11:57:17.000000000 -0800
@@ -703,7 +703,7 @@ void __init mem_init(void)
 	high_memory = (void *) __va(max_low_pfn * PAGE_SIZE);
 
 #ifdef CONFIG_DISCONTIGMEM
-        for (nid = 0; nid < numnodes; nid++) {
+        for_each_online_node(nid) {
 		if (NODE_DATA(nid)->node_spanned_pages != 0) {
 			printk("freeing bootmem node %x\n", nid);
 			totalram_pages +=
diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.10-rc3-mm1/arch/ppc64/mm/numa.c linux-2.6.10-rc3-mm1-nom.ppc64/arch/ppc64/mm/numa.c
--- linux-2.6.10-rc3-mm1/arch/ppc64/mm/numa.c	2004-12-13 16:22:53.000000000 -0800
+++ linux-2.6.10-rc3-mm1-nom.ppc64/arch/ppc64/mm/numa.c	2004-12-15 13:29:14.000000000 -0800
@@ -216,7 +216,7 @@ static int numa_setup_cpu(unsigned long 
 
 	numa_domain = of_node_numa_domain(cpu);
 
-	if (numa_domain >= numnodes) {
+	if (numa_domain >= num_online_nodes()) {
 		/*
 		 * POWER4 LPAR uses 0xffff as invalid node,
 		 * dont warn in this case.
@@ -384,7 +384,8 @@ new_range:
 			goto new_range;
 	}
 
-	numnodes = max_domain + 1;
+	for (i = 0; i <= max_domain; i++)
+		node_set_online(i);
 
 	return 0;
 }
@@ -430,12 +431,9 @@ static void __init dump_numa_topology(vo
 	if (min_common_depth == -1 || !numa_enabled)
 		return;
 
-	for (node = 0; node < MAX_NUMNODES; node++) {
+	for_each_online_node(node) {
 		unsigned long i;
 
-		if (!node_online(node))
-			continue;
-
 		printk(KERN_INFO "Node %d Memory:", node);
 
 		count = 0;
@@ -519,7 +517,7 @@ void __init do_init_bootmem(void)
 
 	register_cpu_notifier(&ppc64_numa_nb);
 
-	for (nid = 0; nid < numnodes; nid++) {
+	for_each_online_node(nid) {
 		unsigned long start_paddr, end_paddr;
 		int i;
 		unsigned long bootmem_paddr;
@@ -619,7 +617,7 @@ void __init paging_init(void)
 	memset(zones_size, 0, sizeof(zones_size));
 	memset(zholes_size, 0, sizeof(zholes_size));
 
-	for (nid = 0; nid < numnodes; nid++) {
+	for_each_online_node(nid) {
 		unsigned long start_pfn;
 		unsigned long end_pfn;
 


