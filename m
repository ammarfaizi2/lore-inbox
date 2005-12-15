Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932654AbVLOATL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932654AbVLOATL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 19:19:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965056AbVLOAO6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 19:14:58 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:62895 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932634AbVLOAOs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 19:14:48 -0500
Date: Wed, 14 Dec 2005 16:14:35 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, Hugh Dickins <hugh@veritas.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>, linux-mm@kvack.org,
       Andi Kleen <ak@suse.de>, Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Christoph Lameter <clameter@sgi.com>
Message-Id: <20051215001435.31405.5939.sendpatchset@schroedinger.engr.sgi.com>
In-Reply-To: <20051215001415.31405.24898.sendpatchset@schroedinger.engr.sgi.com>
References: <20051215001415.31405.24898.sendpatchset@schroedinger.engr.sgi.com>
Subject: [RFC3 04/14] Convert nr_pagecache
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Convert nr_pagecache a zoned counter

Currently a single atomic variable is used to establish the size of the page cache
in the whole machine. The zoned VM counters have the same method of implementation
as the nr_pagecache code. Remove the special implementation for nr_pagecache and make
it a zoned counter. We will then be able to figure out how much of the memory in a
zone is used by the pagecache.

Updates of the page cache counters are always performed with interrupts off.
We can therefore use the __ variant here.

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.15-rc5-mm2/include/linux/pagemap.h
===================================================================
--- linux-2.6.15-rc5-mm2.orig/include/linux/pagemap.h	2005-12-12 09:10:34.000000000 -0800
+++ linux-2.6.15-rc5-mm2/include/linux/pagemap.h	2005-12-14 14:57:33.000000000 -0800
@@ -99,51 +99,6 @@ int add_to_page_cache_lru(struct page *p
 extern void remove_from_page_cache(struct page *page);
 extern void __remove_from_page_cache(struct page *page);
 
-extern atomic_t nr_pagecache;
-
-#ifdef CONFIG_SMP
-
-#define PAGECACHE_ACCT_THRESHOLD        max(16, NR_CPUS * 2)
-DECLARE_PER_CPU(long, nr_pagecache_local);
-
-/*
- * pagecache_acct implements approximate accounting for pagecache.
- * vm_enough_memory() do not need high accuracy. Writers will keep
- * an offset in their per-cpu arena and will spill that into the
- * global count whenever the absolute value of the local count
- * exceeds the counter's threshold.
- *
- * MUST be protected from preemption.
- * current protection is mapping->page_lock.
- */
-static inline void pagecache_acct(int count)
-{
-	long *local;
-
-	local = &__get_cpu_var(nr_pagecache_local);
-	*local += count;
-	if (*local > PAGECACHE_ACCT_THRESHOLD || *local < -PAGECACHE_ACCT_THRESHOLD) {
-		atomic_add(*local, &nr_pagecache);
-		*local = 0;
-	}
-}
-
-#else
-
-static inline void pagecache_acct(int count)
-{
-	atomic_add(count, &nr_pagecache);
-}
-#endif
-
-static inline unsigned long get_page_cache_size(void)
-{
-	int ret = atomic_read(&nr_pagecache);
-	if (unlikely(ret < 0))
-		ret = 0;
-	return ret;
-}
-
 /*
  * Return byte-offset into filesystem object for page.
  */
Index: linux-2.6.15-rc5-mm2/mm/swap_state.c
===================================================================
--- linux-2.6.15-rc5-mm2.orig/mm/swap_state.c	2005-12-13 20:41:05.000000000 -0800
+++ linux-2.6.15-rc5-mm2/mm/swap_state.c	2005-12-14 14:57:33.000000000 -0800
@@ -87,7 +87,7 @@ static int __add_to_swap_cache(struct pa
 			SetPageSwapCache(page);
 			set_page_private(page, entry.val);
 			total_swapcache_pages++;
-			pagecache_acct(1);
+			__inc_zone_page_state(page, NR_PAGECACHE);
 		}
 		write_unlock_irq(&swapper_space.tree_lock);
 		radix_tree_preload_end();
@@ -133,7 +133,7 @@ void __delete_from_swap_cache(struct pag
 	set_page_private(page, 0);
 	ClearPageSwapCache(page);
 	total_swapcache_pages--;
-	pagecache_acct(-1);
+	__dec_zone_page_state(page, NR_PAGECACHE);
 	INC_CACHE_INFO(del_total);
 }
 
Index: linux-2.6.15-rc5-mm2/mm/filemap.c
===================================================================
--- linux-2.6.15-rc5-mm2.orig/mm/filemap.c	2005-12-12 09:10:34.000000000 -0800
+++ linux-2.6.15-rc5-mm2/mm/filemap.c	2005-12-14 14:57:33.000000000 -0800
@@ -115,7 +115,7 @@ void __remove_from_page_cache(struct pag
 	radix_tree_delete(&mapping->page_tree, page->index);
 	page->mapping = NULL;
 	mapping->nrpages--;
-	pagecache_acct(-1);
+	__dec_zone_page_state(page, NR_PAGECACHE);
 }
 EXPORT_SYMBOL(__remove_from_page_cache);
 
@@ -406,7 +406,7 @@ int add_to_page_cache(struct page *page,
 			page->mapping = mapping;
 			page->index = offset;
 			mapping->nrpages++;
-			pagecache_acct(1);
+			__inc_zone_page_state(page, NR_PAGECACHE);
 		}
 		write_unlock_irq(&mapping->tree_lock);
 		radix_tree_preload_end();
Index: linux-2.6.15-rc5-mm2/mm/page_alloc.c
===================================================================
--- linux-2.6.15-rc5-mm2.orig/mm/page_alloc.c	2005-12-14 14:57:29.000000000 -0800
+++ linux-2.6.15-rc5-mm2/mm/page_alloc.c	2005-12-14 14:57:33.000000000 -0800
@@ -1578,12 +1578,6 @@ static void show_node(struct zone *zone)
  */
 static DEFINE_PER_CPU(struct page_state, page_states) = {0};
 
-atomic_t nr_pagecache = ATOMIC_INIT(0);
-EXPORT_SYMBOL(nr_pagecache);
-#ifdef CONFIG_SMP
-DEFINE_PER_CPU(long, nr_pagecache_local) = 0;
-#endif
-
 static void __get_page_state(struct page_state *ret, int nr, cpumask_t *cpumask)
 {
 	int cpu = 0;
Index: linux-2.6.15-rc5-mm2/mm/mmap.c
===================================================================
--- linux-2.6.15-rc5-mm2.orig/mm/mmap.c	2005-12-03 21:10:42.000000000 -0800
+++ linux-2.6.15-rc5-mm2/mm/mmap.c	2005-12-14 14:57:33.000000000 -0800
@@ -95,7 +95,7 @@ int __vm_enough_memory(long pages, int c
 	if (sysctl_overcommit_memory == OVERCOMMIT_GUESS) {
 		unsigned long n;
 
-		free = get_page_cache_size();
+		free = global_page_state(NR_PAGECACHE);
 		free += nr_swap_pages;
 
 		/*
Index: linux-2.6.15-rc5-mm2/mm/nommu.c
===================================================================
--- linux-2.6.15-rc5-mm2.orig/mm/nommu.c	2005-12-12 09:10:34.000000000 -0800
+++ linux-2.6.15-rc5-mm2/mm/nommu.c	2005-12-14 14:57:33.000000000 -0800
@@ -1114,7 +1114,7 @@ int __vm_enough_memory(long pages, int c
 	if (sysctl_overcommit_memory == OVERCOMMIT_GUESS) {
 		unsigned long n;
 
-		free = get_page_cache_size();
+		free = global_page_state(NR_PAGECACHE);
 		free += nr_swap_pages;
 
 		/*
Index: linux-2.6.15-rc5-mm2/arch/sparc64/kernel/sys_sunos32.c
===================================================================
--- linux-2.6.15-rc5-mm2.orig/arch/sparc64/kernel/sys_sunos32.c	2005-12-03 21:10:42.000000000 -0800
+++ linux-2.6.15-rc5-mm2/arch/sparc64/kernel/sys_sunos32.c	2005-12-14 14:57:33.000000000 -0800
@@ -154,7 +154,7 @@ asmlinkage int sunos_brk(u32 baddr)
 	 * simple, it hopefully works in most obvious cases.. Easy to
 	 * fool it, but this should catch most mistakes.
 	 */
-	freepages = get_page_cache_size();
+	freepages = global_page_state(NR_PAGECACHE);
 	freepages >>= 1;
 	freepages += nr_free_pages();
 	freepages += nr_swap_pages;
Index: linux-2.6.15-rc5-mm2/arch/sparc/kernel/sys_sunos.c
===================================================================
--- linux-2.6.15-rc5-mm2.orig/arch/sparc/kernel/sys_sunos.c	2005-12-03 21:10:42.000000000 -0800
+++ linux-2.6.15-rc5-mm2/arch/sparc/kernel/sys_sunos.c	2005-12-14 14:57:33.000000000 -0800
@@ -195,7 +195,7 @@ asmlinkage int sunos_brk(unsigned long b
 	 * simple, it hopefully works in most obvious cases.. Easy to
 	 * fool it, but this should catch most mistakes.
 	 */
-	freepages = get_page_cache_size();
+	freepages = global_page_state(NR_PAGECACHE);
 	freepages >>= 1;
 	freepages += nr_free_pages();
 	freepages += nr_swap_pages;
Index: linux-2.6.15-rc5-mm2/fs/proc/proc_misc.c
===================================================================
--- linux-2.6.15-rc5-mm2.orig/fs/proc/proc_misc.c	2005-12-14 14:57:29.000000000 -0800
+++ linux-2.6.15-rc5-mm2/fs/proc/proc_misc.c	2005-12-14 14:57:33.000000000 -0800
@@ -142,7 +142,7 @@ static int meminfo_read_proc(char *page,
 	allowed = ((totalram_pages - hugetlb_total_pages())
 		* sysctl_overcommit_ratio / 100) + total_swap_pages;
 
-	cached = get_page_cache_size() - total_swapcache_pages - i.bufferram;
+	cached = global_page_state(NR_PAGECACHE) - total_swapcache_pages - i.bufferram;
 	if (cached < 0)
 		cached = 0;
 
Index: linux-2.6.15-rc5-mm2/include/linux/mmzone.h
===================================================================
--- linux-2.6.15-rc5-mm2.orig/include/linux/mmzone.h	2005-12-14 14:57:29.000000000 -0800
+++ linux-2.6.15-rc5-mm2/include/linux/mmzone.h	2005-12-14 14:57:33.000000000 -0800
@@ -44,8 +44,8 @@ struct zone_padding {
 #define ZONE_PADDING(name)
 #endif
 
-enum zone_stat_item { NR_MAPPED };
-#define NR_STAT_ITEMS 1
+enum zone_stat_item { NR_MAPPED, NR_PAGECACHE };
+#define NR_STAT_ITEMS 2
 
 struct per_cpu_pages {
 	int count;		/* number of pages in the list */
