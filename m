Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932396AbWGGXWV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932396AbWGGXWV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 19:22:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932391AbWGGXTJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 19:19:09 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:976 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932385AbWGGXSw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 19:18:52 -0400
Date: Fri, 7 Jul 2006 16:18:36 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, Hugh Dickins <hugh@veritas.com>,
       Christoph Hellwig <hch@infradead.org>, Con Kolivas <kernel@kolivas.org>,
       Marcelo Tosatti <marcelo@kvack.org>,
       Arjan van de Ven <arjan@infradead.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Christoph Lameter <clameter@sgi.com>, Andi Kleen <ak@suse.de>,
       KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Message-Id: <20060707231835.3790.24954.sendpatchset@schroedinger.engr.sgi.com>
In-Reply-To: <20060707231810.3790.19313.sendpatchset@schroedinger.engr.sgi.com>
References: <20060707231810.3790.19313.sendpatchset@schroedinger.engr.sgi.com>
Subject: [PATCH 05/11] Move HIGHMEM counters into highmem.c/.h
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Move totalhigh_pages and nr_free_highpages() into highmem.c/.h

Move the totalhigh_pages definition into highmem.c/.h.
Move the nr_free_highpages function into highmem.c

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.17-mm6/include/linux/highmem.h
===================================================================
--- linux-2.6.17-mm6.orig/include/linux/highmem.h	2006-07-03 13:47:21.556579985 -0700
+++ linux-2.6.17-mm6/include/linux/highmem.h	2006-07-04 09:22:20.667685574 -0700
@@ -24,11 +24,14 @@ static inline void flush_kernel_dcache_p
 
 /* declarations for linux/mm/highmem.c */
 unsigned int nr_free_highpages(void);
+extern unsigned long totalhigh_pages;
 
 #else /* CONFIG_HIGHMEM */
 
 static inline unsigned int nr_free_highpages(void) { return 0; }
 
+#define totalhigh_pages 0
+
 static inline void *kmap(struct page *page)
 {
 	might_sleep();
Index: linux-2.6.17-mm6/include/linux/swap.h
===================================================================
--- linux-2.6.17-mm6.orig/include/linux/swap.h	2006-07-03 13:47:22.066314085 -0700
+++ linux-2.6.17-mm6/include/linux/swap.h	2006-07-04 08:33:07.461701088 -0700
@@ -162,7 +162,6 @@ extern void swapin_readahead(swp_entry_t
 
 /* linux/mm/page_alloc.c */
 extern unsigned long totalram_pages;
-extern unsigned long totalhigh_pages;
 extern unsigned long totalreserve_pages;
 extern long nr_swap_pages;
 extern unsigned int nr_free_pages(void);
Index: linux-2.6.17-mm6/mm/page_alloc.c
===================================================================
--- linux-2.6.17-mm6.orig/mm/page_alloc.c	2006-07-04 08:32:32.671862242 -0700
+++ linux-2.6.17-mm6/mm/page_alloc.c	2006-07-04 09:21:35.699763226 -0700
@@ -51,7 +51,6 @@ EXPORT_SYMBOL(node_online_map);
 nodemask_t node_possible_map __read_mostly = NODE_MASK_ALL;
 EXPORT_SYMBOL(node_possible_map);
 unsigned long totalram_pages __read_mostly;
-unsigned long totalhigh_pages __read_mostly;
 unsigned long totalreserve_pages __read_mostly;
 long nr_swap_pages;
 int percpu_pagelist_fraction;
@@ -1259,20 +1258,6 @@ unsigned int nr_free_pagecache_pages(voi
 {
 	return nr_free_zone_pages(gfp_zone(GFP_HIGHUSER));
 }
-
-#ifdef CONFIG_HIGHMEM
-unsigned int nr_free_highpages (void)
-{
-	pg_data_t *pgdat;
-	unsigned int pages = 0;
-
-	for_each_online_pgdat(pgdat)
-		pages += pgdat->node_zones[ZONE_HIGHMEM].free_pages;
-
-	return pages;
-}
-#endif
-
 #ifdef CONFIG_NUMA
 static void show_node(struct zone *zone)
 {
Index: linux-2.6.17-mm6/mm/shmem.c
===================================================================
--- linux-2.6.17-mm6.orig/mm/shmem.c	2006-07-03 13:47:22.646356337 -0700
+++ linux-2.6.17-mm6/mm/shmem.c	2006-07-04 08:33:07.464630594 -0700
@@ -45,6 +45,7 @@
 #include <linux/namei.h>
 #include <linux/ctype.h>
 #include <linux/migrate.h>
+#include <linux/highmem.h>
 
 #include <asm/uaccess.h>
 #include <asm/div64.h>
Index: linux-2.6.17-mm6/mm/highmem.c
===================================================================
--- linux-2.6.17-mm6.orig/mm/highmem.c	2006-07-03 13:47:22.613155266 -0700
+++ linux-2.6.17-mm6/mm/highmem.c	2006-07-04 09:22:01.239199517 -0700
@@ -46,6 +46,19 @@ static void *mempool_alloc_pages_isa(gfp
  */
 #ifdef CONFIG_HIGHMEM
 
+unsigned long totalhigh_pages __read_mostly;
+
+unsigned int nr_free_highpages (void)
+{
+	pg_data_t *pgdat;
+	unsigned int pages = 0;
+
+	for_each_online_pgdat(pgdat)
+		pages += pgdat->node_zones[ZONE_HIGHMEM].free_pages;
+
+	return pages;
+}
+
 static int pkmap_count[LAST_PKMAP];
 static unsigned int last_pkmap_nr;
 static  __cacheline_aligned_in_smp DEFINE_SPINLOCK(kmap_lock);
Index: linux-2.6.17-mm6/arch/um/kernel/mem.c
===================================================================
--- linux-2.6.17-mm6.orig/arch/um/kernel/mem.c	2006-06-17 18:49:35.000000000 -0700
+++ linux-2.6.17-mm6/arch/um/kernel/mem.c	2006-07-04 08:33:07.465607096 -0700
@@ -90,8 +90,10 @@ void mem_init(void)
 
 	/* this will put all low memory onto the freelists */
 	totalram_pages = free_all_bootmem();
+#ifdef CONFIG_HIGHMEM
 	totalhigh_pages = highmem >> PAGE_SHIFT;
 	totalram_pages += totalhigh_pages;
+#endif
 	num_physpages = totalram_pages;
 	max_pfn = totalram_pages;
 	printk(KERN_INFO "Memory: %luk available\n", 
