Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261319AbULWWfW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261319AbULWWfW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Dec 2004 17:35:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261320AbULWWfV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Dec 2004 17:35:21 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:35033 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S261319AbULWWfI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Dec 2004 17:35:08 -0500
Subject: [RFC PATCH 1/10] Replace 'numnodes' with 'node_online_map' - alpha
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
To: LKML <linux-kernel@vger.kernel.org>
Cc: LSE Tech <lse-tech@lists.sourceforge.net>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <1103838712.3945.12.camel@arrakis>
References: <1103838712.3945.12.camel@arrakis>
Content-Type: text/plain
Organization: IBM LTC
Message-Id: <1103841305.3945.15.camel@arrakis>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Thu, 23 Dec 2004 14:35:05 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

1/10 - Replace numnodes with node_online_map for alpha

[mcd@arrakis node_online_map]$ diffstat arch-alpha.patch
 numa.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

-Matt

diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.10-rc3-mm1/arch/alpha/mm/numa.c linux-2.6.10-rc3-mm1-nom.alpha/arch/alpha/mm/numa.c
--- linux-2.6.10-rc3-mm1/arch/alpha/mm/numa.c	2004-12-13 16:22:45.000000000 -0800
+++ linux-2.6.10-rc3-mm1-nom.alpha/arch/alpha/mm/numa.c	2004-12-14 11:57:16.000000000 -0800
@@ -246,7 +246,7 @@ setup_memory_node(int nid, void *kernel_
 	reserve_bootmem_node(NODE_DATA(nid), PFN_PHYS(bootmap_start), bootmap_size);
 	printk(" reserving pages %ld:%ld\n", bootmap_start, bootmap_start+PFN_UP(bootmap_size));
 
-	numnodes++;
+	node_set_online(nid);
 }
 
 void __init
@@ -256,7 +256,7 @@ setup_memory(void *kernel_end)
 
 	show_mem_layout();
 
-	numnodes = 0;
+	nodes_clear(node_online_map);
 
 	min_low_pfn = ~0UL;
 	max_low_pfn = 0UL;
@@ -303,7 +303,7 @@ void __init paging_init(void)
 	 */
 	dma_local_pfn = virt_to_phys((char *)MAX_DMA_ADDRESS) >> PAGE_SHIFT;
 
-	for (nid = 0; nid < numnodes; nid++) {
+	for_each_online_node(nid) {
 		unsigned long start_pfn = node_bdata[nid].node_boot_start >> PAGE_SHIFT;
 		unsigned long end_pfn = node_bdata[nid].node_low_pfn;
 
@@ -332,7 +332,7 @@ void __init mem_init(void)
 	high_memory = (void *) __va(max_low_pfn << PAGE_SHIFT);
 
 	reservedpages = 0;
-	for (nid = 0; nid < numnodes; nid++) {
+	for_each_online_node(nid) {
 		/*
 		 * This will free up the bootmem, ie, slot 0 memory
 		 */
@@ -372,7 +372,7 @@ show_mem(void)
 	printk("\nMem-info:\n");
 	show_free_areas();
 	printk("Free swap:       %6ldkB\n", nr_swap_pages<<(PAGE_SHIFT-10));
-	for (nid = 0; nid < numnodes; nid++) {
+	for_each_online_node(nid) {
 		struct page * lmem_map = node_mem_map(nid);
 		i = node_spanned_pages(nid);
 		while (i-- > 0) {


