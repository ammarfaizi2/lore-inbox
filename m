Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965065AbWFHXDo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965065AbWFHXDo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 19:03:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965056AbWFHXDZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 19:03:25 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:46049 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S965054AbWFHXDJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 19:03:09 -0400
Date: Thu, 8 Jun 2006 16:03:00 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, Hugh Dickins <hugh@veritas.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>, linux-mm@kvack.org,
       Andi Kleen <ak@suse.de>, Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Christoph Lameter <clameter@sgi.com>
Message-Id: <20060608230300.25121.75048.sendpatchset@schroedinger.engr.sgi.com>
In-Reply-To: <20060608230239.25121.83503.sendpatchset@schroedinger.engr.sgi.com>
References: <20060608230239.25121.83503.sendpatchset@schroedinger.engr.sgi.com>
Subject: [PATCH 04/14] Conversion of nr_pagecache to per zone counter
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Conversion of nr_pagecache to a per zone counter

Currently a single atomic variable is used to establish the size of the page
cache in the whole machine. The zoned VM counters have the same method of
implementation as the nr_pagecache code but also allow the determination
of the pagecache size per zone.

Remove the special implementation for nr_pagecache and make it a zoned
counter.

Updates of the page cache counters are always performed with interrupts off.
We can therefore use the __ variant here.

This will make UP no longer require atomic operations for nr_pagecache.

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.17-rc6-mm1/include/linux/pagemap.h
===================================================================
--- linux-2.6.17-rc6-mm1.orig/include/linux/pagemap.h	2006-06-08 13:03:39.304520730 -0700
+++ linux-2.6.17-rc6-mm1/include/linux/pagemap.h	2006-06-08 14:07:35.879548728 -0700
@@ -115,51 +115,6 @@ int add_to_page_cache_lru(struct page *p
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
Index: linux-2.6.17-rc6-mm1/mm/swap_state.c
===================================================================
--- linux-2.6.17-rc6-mm1.orig/mm/swap_state.c	2006-06-08 13:03:39.924599579 -0700
+++ linux-2.6.17-rc6-mm1/mm/swap_state.c	2006-06-08 14:07:35.880525230 -0700
@@ -89,7 +89,7 @@ static int __add_to_swap_cache(struct pa
 			SetPageSwapCache(page);
 			set_page_private(page, entry.val);
 			total_swapcache_pages++;
-			pagecache_acct(1);
+			__inc_zone_page_state(page, NR_PAGECACHE);
 		}
 		write_unlock_irq(&swapper_space.tree_lock);
 		radix_tree_preload_end();
@@ -135,7 +135,7 @@ void __delete_from_swap_cache(struct pag
 	set_page_private(page, 0);
 	ClearPageSwapCache(page);
 	total_swapcache_pages--;
-	pagecache_acct(-1);
+	__dec_zone_page_state(page, NR_PAGECACHE);
 	INC_CACHE_INFO(del_total);
 }
 
Index: linux-2.6.17-rc6-mm1/mm/filemap.c
===================================================================
--- linux-2.6.17-rc6-mm1.orig/mm/filemap.c	2006-06-08 13:03:39.864056448 -0700
+++ linux-2.6.17-rc6-mm1/mm/filemap.c	2006-06-08 14:07:35.881501732 -0700
@@ -126,7 +126,7 @@ void __remove_from_page_cache(struct pag
 	radix_tree_delete(&mapping->page_tree, page->index);
 	page->mapping = NULL;
 	mapping->nrpages--;
-	pagecache_acct(-1);
+	__dec_zone_page_state(page, NR_PAGECACHE);
 }
 EXPORT_SYMBOL(__remove_from_page_cache);
 
@@ -424,7 +424,7 @@ int add_to_page_cache(struct page *page,
 			page->mapping = mapping;
 			page->index = offset;
 			mapping->nrpages++;
-			pagecache_acct(1);
+			__inc_zone_page_state(page, NR_PAGECACHE);
 		}
 		write_unlock_irq(&mapping->tree_lock);
 		radix_tree_preload_end();
Index: linux-2.6.17-rc6-mm1/mm/page_alloc.c
===================================================================
--- linux-2.6.17-rc6-mm1.orig/mm/page_alloc.c	2006-06-08 13:55:23.119232821 -0700
+++ linux-2.6.17-rc6-mm1/mm/page_alloc.c	2006-06-08 14:07:35.883454737 -0700
@@ -1583,12 +1583,6 @@ static void show_node(struct zone *zone)
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
 	unsigned cpu;
@@ -2802,6 +2796,7 @@ struct seq_operations zoneinfo_op = {
 static char *vmstat_text[] = {
 	/* Zoned VM counters */
 	"nr_mapped",
+	"nr_pagecache",
 
 	/* Page state */
 	"nr_dirty",
Index: linux-2.6.17-rc6-mm1/mm/mmap.c
===================================================================
--- linux-2.6.17-rc6-mm1.orig/mm/mmap.c	2006-06-08 13:03:39.900187026 -0700
+++ linux-2.6.17-rc6-mm1/mm/mmap.c	2006-06-08 14:07:35.884431239 -0700
@@ -96,7 +96,7 @@ int __vm_enough_memory(long pages, int c
 	if (sysctl_overcommit_memory == OVERCOMMIT_GUESS) {
 		unsigned long n;
 
-		free = get_page_cache_size();
+		free = global_page_state(NR_PAGECACHE);
 		free += nr_swap_pages;
 
 		/*
Index: linux-2.6.17-rc6-mm1/mm/nommu.c
===================================================================
--- linux-2.6.17-rc6-mm1.orig/mm/nommu.c	2006-06-05 17:57:02.000000000 -0700
+++ linux-2.6.17-rc6-mm1/mm/nommu.c	2006-06-08 14:07:36.292609102 -0700
@@ -1122,7 +1122,7 @@ int __vm_enough_memory(long pages, int c
 	if (sysctl_overcommit_memory == OVERCOMMIT_GUESS) {
 		unsigned long n;
 
-		free = get_page_cache_size();
+		free = global_page_state(NR_PAGECACHE);
 		free += nr_swap_pages;
 
 		/*
Index: linux-2.6.17-rc6-mm1/arch/sparc64/kernel/sys_sunos32.c
===================================================================
--- linux-2.6.17-rc6-mm1.orig/arch/sparc64/kernel/sys_sunos32.c	2006-06-08 13:03:31.354816936 -0700
+++ linux-2.6.17-rc6-mm1/arch/sparc64/kernel/sys_sunos32.c	2006-06-08 14:07:36.469355975 -0700
@@ -155,7 +155,7 @@ asmlinkage int sunos_brk(u32 baddr)
 	 * simple, it hopefully works in most obvious cases.. Easy to
 	 * fool it, but this should catch most mistakes.
 	 */
-	freepages = get_page_cache_size();
+	freepages = global_page_state(NR_PAGECACHE);
 	freepages >>= 1;
 	freepages += nr_free_pages();
 	freepages += nr_swap_pages;
Index: linux-2.6.17-rc6-mm1/arch/sparc/kernel/sys_sunos.c
===================================================================
--- linux-2.6.17-rc6-mm1.orig/arch/sparc/kernel/sys_sunos.c	2006-06-08 13:03:31.362628953 -0700
+++ linux-2.6.17-rc6-mm1/arch/sparc/kernel/sys_sunos.c	2006-06-08 14:07:36.481074000 -0700
@@ -196,7 +196,7 @@ asmlinkage int sunos_brk(unsigned long b
 	 * simple, it hopefully works in most obvious cases.. Easy to
 	 * fool it, but this should catch most mistakes.
 	 */
-	freepages = get_page_cache_size();
+	freepages = global_page_state(NR_PAGECACHE);
 	freepages >>= 1;
 	freepages += nr_free_pages();
 	freepages += nr_swap_pages;
Index: linux-2.6.17-rc6-mm1/fs/proc/proc_misc.c
===================================================================
--- linux-2.6.17-rc6-mm1.orig/fs/proc/proc_misc.c	2006-06-08 13:55:23.115326813 -0700
+++ linux-2.6.17-rc6-mm1/fs/proc/proc_misc.c	2006-06-08 14:07:36.482050502 -0700
@@ -142,7 +142,7 @@ static int meminfo_read_proc(char *page,
 	allowed = ((totalram_pages - hugetlb_total_pages())
 		* sysctl_overcommit_ratio / 100) + total_swap_pages;
 
-	cached = get_page_cache_size() - total_swapcache_pages - i.bufferram;
+	cached = global_page_state(NR_PAGECACHE) - total_swapcache_pages - i.bufferram;
 	if (cached < 0)
 		cached = 0;
 
Index: linux-2.6.17-rc6-mm1/include/linux/mmzone.h
===================================================================
--- linux-2.6.17-rc6-mm1.orig/include/linux/mmzone.h	2006-06-08 13:55:23.121185825 -0700
+++ linux-2.6.17-rc6-mm1/include/linux/mmzone.h	2006-06-08 14:07:36.482050502 -0700
@@ -49,7 +49,7 @@ struct zone_padding {
 enum zone_stat_item {
 	NR_MAPPED,	/* mapped into pagetables.
 			   only modified from process context */
-
+	NR_PAGECACHE,	/* file backed pages */
 	NR_STAT_ITEMS };
 
 #ifdef CONFIG_SMP
