Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964846AbWFNBDa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964846AbWFNBDa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 21:03:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964837AbWFNBDT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 21:03:19 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:1253 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S964843AbWFNBDM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 21:03:12 -0400
Date: Tue, 13 Jun 2006 18:03:04 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, Con Kolivas <kernel@kolivas.org>,
       Christoph Lameter <clameter@sgi.com>, Dave Chinner <dgc@sgi.com>
Message-Id: <20060614010304.859.42218.sendpatchset@schroedinger.engr.sgi.com>
In-Reply-To: <20060614010238.859.4228.sendpatchset@schroedinger.engr.sgi.com>
References: <20060614010238.859.4228.sendpatchset@schroedinger.engr.sgi.com>
Subject: [PATCH 05/21] Conversion of nr_pagecache to per zone counter
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: zoned vm counters: conversion of nr_pagecache to per zone counter
From: Christoph Lameter <clameter@sgi.com>

Currently a single atomic variable is used to establish the size of the page
cache in the whole machine. The zoned VM counters have the same method of
implementation as the nr_pagecache code but also allow the determination of
the pagecache size per zone.

Remove the special implementation for nr_pagecache and make it a zoned
counter.

Updates of the page cache counters are always performed with interrupts off.
We can therefore use the __ variant here.

Signed-off-by: Christoph Lameter <clameter@sgi.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>

Index: linux-2.6.17-rc6-cl/arch/sparc64/kernel/sys_sunos32.c
===================================================================
--- linux-2.6.17-rc6-cl.orig/arch/sparc64/kernel/sys_sunos32.c	2006-06-12 12:42:42.240680230 -0700
+++ linux-2.6.17-rc6-cl/arch/sparc64/kernel/sys_sunos32.c	2006-06-13 10:19:38.470745634 -0700
@@ -155,7 +155,7 @@ asmlinkage int sunos_brk(u32 baddr)
 	 * simple, it hopefully works in most obvious cases.. Easy to
 	 * fool it, but this should catch most mistakes.
 	 */
-	freepages = get_page_cache_size();
+	freepages = global_page_state(NR_PAGECACHE);
 	freepages >>= 1;
 	freepages += nr_free_pages();
 	freepages += nr_swap_pages;
Index: linux-2.6.17-rc6-cl/arch/sparc/kernel/sys_sunos.c
===================================================================
--- linux-2.6.17-rc6-cl.orig/arch/sparc/kernel/sys_sunos.c	2006-06-12 12:42:42.249468748 -0700
+++ linux-2.6.17-rc6-cl/arch/sparc/kernel/sys_sunos.c	2006-06-13 10:19:38.471722136 -0700
@@ -196,7 +196,7 @@ asmlinkage int sunos_brk(unsigned long b
 	 * simple, it hopefully works in most obvious cases.. Easy to
 	 * fool it, but this should catch most mistakes.
 	 */
-	freepages = get_page_cache_size();
+	freepages = global_page_state(NR_PAGECACHE);
 	freepages >>= 1;
 	freepages += nr_free_pages();
 	freepages += nr_swap_pages;
Index: linux-2.6.17-rc6-cl/fs/proc/proc_misc.c
===================================================================
--- linux-2.6.17-rc6-cl.orig/fs/proc/proc_misc.c	2006-06-13 10:19:37.517679599 -0700
+++ linux-2.6.17-rc6-cl/fs/proc/proc_misc.c	2006-06-13 10:19:38.472698639 -0700
@@ -142,7 +142,8 @@ static int meminfo_read_proc(char *page,
 	allowed = ((totalram_pages - hugetlb_total_pages())
 		* sysctl_overcommit_ratio / 100) + total_swap_pages;
 
-	cached = get_page_cache_size() - total_swapcache_pages - i.bufferram;
+	cached = global_page_state(NR_PAGECACHE) -
+			total_swapcache_pages - i.bufferram;
 	if (cached < 0)
 		cached = 0;
 
Index: linux-2.6.17-rc6-cl/include/linux/pagemap.h
===================================================================
--- linux-2.6.17-rc6-cl.orig/include/linux/pagemap.h	2006-06-12 12:42:50.853428498 -0700
+++ linux-2.6.17-rc6-cl/include/linux/pagemap.h	2006-06-13 10:19:38.473675141 -0700
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
Index: linux-2.6.17-rc6-cl/mm/filemap.c
===================================================================
--- linux-2.6.17-rc6-cl.orig/mm/filemap.c	2006-06-12 12:42:52.024254482 -0700
+++ linux-2.6.17-rc6-cl/mm/filemap.c	2006-06-13 10:19:38.475628145 -0700
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
Index: linux-2.6.17-rc6-cl/mm/mmap.c
===================================================================
--- linux-2.6.17-rc6-cl.orig/mm/mmap.c	2006-06-12 12:42:52.037925511 -0700
+++ linux-2.6.17-rc6-cl/mm/mmap.c	2006-06-13 10:19:38.476604647 -0700
@@ -96,7 +96,7 @@ int __vm_enough_memory(long pages, int c
 	if (sysctl_overcommit_memory == OVERCOMMIT_GUESS) {
 		unsigned long n;
 
-		free = get_page_cache_size();
+		free = global_page_state(NR_PAGECACHE);
 		free += nr_swap_pages;
 
 		/*
Index: linux-2.6.17-rc6-cl/mm/nommu.c
===================================================================
--- linux-2.6.17-rc6-cl.orig/mm/nommu.c	2006-06-05 17:57:02.000000000 -0700
+++ linux-2.6.17-rc6-cl/mm/nommu.c	2006-06-13 10:19:38.476604647 -0700
@@ -1122,7 +1122,7 @@ int __vm_enough_memory(long pages, int c
 	if (sysctl_overcommit_memory == OVERCOMMIT_GUESS) {
 		unsigned long n;
 
-		free = get_page_cache_size();
+		free = global_page_state(NR_PAGECACHE);
 		free += nr_swap_pages;
 
 		/*
Index: linux-2.6.17-rc6-cl/mm/page_alloc.c
===================================================================
--- linux-2.6.17-rc6-cl.orig/mm/page_alloc.c	2006-06-13 10:19:37.520609105 -0700
+++ linux-2.6.17-rc6-cl/mm/page_alloc.c	2006-06-13 10:19:38.478557651 -0700
@@ -2231,16 +2231,11 @@ static int page_alloc_cpu_notify(struct 
 				 unsigned long action, void *hcpu)
 {
 	int cpu = (unsigned long)hcpu;
-	long *count;
 	unsigned long *src, *dest;
 
 	if (action == CPU_DEAD) {
 		int i;
 
-		/* Drain local pagecache count. */
-		count = &per_cpu(nr_pagecache_local, cpu);
-		atomic_add(*count, &nr_pagecache);
-		*count = 0;
 		local_irq_disable();
 		__drain_pages(cpu);
 
Index: linux-2.6.17-rc6-cl/mm/swap_state.c
===================================================================
--- linux-2.6.17-rc6-cl.orig/mm/swap_state.c	2006-06-12 12:42:52.062338063 -0700
+++ linux-2.6.17-rc6-cl/mm/swap_state.c	2006-06-13 10:19:38.479534153 -0700
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
 
Index: linux-2.6.17-rc6-cl/include/linux/mmzone.h
===================================================================
--- linux-2.6.17-rc6-cl.orig/include/linux/mmzone.h	2006-06-13 10:19:37.518656101 -0700
+++ linux-2.6.17-rc6-cl/include/linux/mmzone.h	2006-06-13 10:19:38.479534153 -0700
@@ -49,7 +49,7 @@ struct zone_padding {
 enum zone_stat_item {
 	NR_MAPPED,	/* mapped into pagetables.
 			   only modified from process context */
-
+	NR_PAGECACHE,
 	NR_VM_ZONE_STAT_ITEMS };
 
 struct per_cpu_pages {
Index: linux-2.6.17-rc6-cl/arch/s390/appldata/appldata_mem.c
===================================================================
--- linux-2.6.17-rc6-cl.orig/arch/s390/appldata/appldata_mem.c	2006-06-12 12:42:42.183066607 -0700
+++ linux-2.6.17-rc6-cl/arch/s390/appldata/appldata_mem.c	2006-06-13 10:19:38.480510655 -0700
@@ -130,7 +130,8 @@ static void appldata_get_mem_data(void *
 	mem_data->totalhigh = P2K(val.totalhigh);
 	mem_data->freehigh  = P2K(val.freehigh);
 	mem_data->bufferram = P2K(val.bufferram);
-	mem_data->cached    = P2K(atomic_read(&nr_pagecache) - val.bufferram);
+	mem_data->cached    = P2K(global_page_state(NR_PAGECACHE)
+				- val.bufferram);
 
 	si_swapinfo(&val);
 	mem_data->totalswap = P2K(val.totalswap);
Index: linux-2.6.17-rc6-cl/drivers/base/node.c
===================================================================
--- linux-2.6.17-rc6-cl.orig/drivers/base/node.c	2006-06-13 10:19:37.516703097 -0700
+++ linux-2.6.17-rc6-cl/drivers/base/node.c	2006-06-13 10:19:38.481487157 -0700
@@ -69,6 +69,7 @@ static ssize_t node_read_meminfo(struct 
 		       "Node %d LowFree:      %8lu kB\n"
 		       "Node %d Dirty:        %8lu kB\n"
 		       "Node %d Writeback:    %8lu kB\n"
+		       "Node %d PageCache:    %8lu kB\n"
 		       "Node %d Mapped:       %8lu kB\n"
 		       "Node %d Slab:         %8lu kB\n",
 		       nid, K(i.totalram),
@@ -82,6 +83,7 @@ static ssize_t node_read_meminfo(struct 
 		       nid, K(i.freeram - i.freehigh),
 		       nid, K(ps.nr_dirty),
 		       nid, K(ps.nr_writeback),
+		       nid, K(node_page_state(nid, NR_PAGECACHE)),
 		       nid, K(node_page_state(nid, NR_MAPPED)),
 		       nid, K(ps.nr_slab));
 	n += hugetlb_report_node_meminfo(nid, buf + n);
Index: linux-2.6.17-rc6-cl/mm/vmstat.c
===================================================================
--- linux-2.6.17-rc6-cl.orig/mm/vmstat.c	2006-06-13 10:19:37.523538611 -0700
+++ linux-2.6.17-rc6-cl/mm/vmstat.c	2006-06-13 10:44:03.861517159 -0700
@@ -20,12 +20,6 @@
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
@@ -464,6 +458,7 @@ struct seq_operations fragmentation_op =
 static char *vmstat_text[] = {
 	/* Zoned VM counters */
 	"nr_mapped",
+	"nr_pagecache",
 
 	/* Page state */
 	"nr_dirty",
