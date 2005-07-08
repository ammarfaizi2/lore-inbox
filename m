Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262832AbVGHUrB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262832AbVGHUrB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 16:47:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262858AbVGHUoh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 16:44:37 -0400
Received: from atlrel8.hp.com ([156.153.255.206]:50071 "EHLO atlrel8.hp.com")
	by vger.kernel.org with ESMTP id S262893AbVGHUiU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 16:38:20 -0400
Date: Fri, 8 Jul 2005 16:38:07 -0400
From: Bob Picco <bob.picco@hp.com>
To: akpm@osdl.org
Cc: linux-mm@kvack.org, manfred@colorfullife.com, alex.williamson@hp.com,
       bob.picco@hp.com, linux-kernel@vger.kernel.org
Subject: [PATCH] Early kmalloc/kfree
Message-ID: <20050708203807.GG27544@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We have a requirement on IA64 to run the ACPI interpreter in the setup_arch
function before paging_init examines the maximum DMA physical address which
is limited by the IOMMU.  One obstacle is the use of kmalloc/kfree by
ACPI.  Using the bootmem allocator is unacceptable because > 20Mb of memory
is wastefully allocated.  As an alternative, I investigated what
would be required to optionally make the slab allocator available early in
boot and work in an almost seamless way.

The patch below is a solution for early kmalloc/kfree.  An architecture which 
requires kmalloc/kfree use before kmem_cache_init has normally completed can 
perform the initialization as early as pfn_to_page is a valid operation.  Like 
the bootmem allocator this point in execution is well known.  An arch that
requires early kmalloc/kfree chooses the CONFIG_EARLY_KMALLOC option and
must call kmem_cache_init at the appropriate place in setup_arch.

The known deficiencies of this solution are similar to the bootmem allocator.
The placement of the call to kmem_cache_init requires arch dependent code
knowlege and possibly manipulation of arch dependent code for enablement. 
kmalloc/kmfree can't be called between when mem_init calls bootmem to free 
pages and the second call to kmem_cache_init made from start_kernel. A NUMA 
deficiency, like bootmem allocator, exists for CPU only nodes.  The NUMA node 
distance information isn't interrogated by bootmem allocator for memory less 
nodes.

The slab API hasn't been modified.  All hot code paths are untouched by
this patch.  The patch has been tested on a 2 CPU SMP box, two node NUMA
simulated machine with and without memory less nodes. All testing has
been done on ia64 but nothing prevents other architectures from using the
patch.

Manfred provided valuable early review feedback.

Alex is responsible for the early ACPI changes and helping me test the patch.

thanks,

bob

Signed-off-by: Bob Picco <bob.picco@hp.com>

 Kconfig      |    6 +++
 page_alloc.c |    4 ++
 slab.c       |   99 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++---
 3 files changed, 105 insertions(+), 4 deletions(-)

Index: linux-2.6.13-rc2-mm1/mm/Kconfig
===================================================================
--- linux-2.6.13-rc2-mm1.orig/mm/Kconfig	2005-07-08 10:25:35.000000000 -0400
+++ linux-2.6.13-rc2-mm1/mm/Kconfig	2005-07-08 10:42:07.000000000 -0400
@@ -98,3 +98,9 @@ config HAVE_MEMORY_PRESENT
 config ARCH_SPARSEMEM_EXTREME
 	def_bool n
 	depends on SPARSEMEM && 64BIT
+#
+# For early use of kmalloc and kfree.  This requires architecture dependent
+# code calling kmem_cache_init when pfn_to_page is safe to call. 
+#
+config	EARLY_KMALLOC
+	def_bool n
Index: linux-2.6.13-rc2-mm1/mm/page_alloc.c
===================================================================
--- linux-2.6.13-rc2-mm1.orig/mm/page_alloc.c	2005-07-08 10:25:35.000000000 -0400
+++ linux-2.6.13-rc2-mm1/mm/page_alloc.c	2005-07-08 10:42:07.000000000 -0400
@@ -1712,6 +1712,10 @@ void __init memmap_init_zone(unsigned lo
 			continue;
 		page = pfn_to_page(pfn);
 		set_page_links(page, zone, nid, pfn);
+#ifdef CONFIG_EARLY_KMALLOC
+		if (PageSlab(page))
+			continue;
+#endif
 		set_page_count(page, 0);
 		reset_page_mapcount(page);
 		SetPageReserved(page);
Index: linux-2.6.13-rc2-mm1/mm/slab.c
===================================================================
--- linux-2.6.13-rc2-mm1.orig/mm/slab.c	2005-07-08 10:25:35.000000000 -0400
+++ linux-2.6.13-rc2-mm1/mm/slab.c	2005-07-08 10:42:07.000000000 -0400
@@ -103,6 +103,7 @@
 #include	<linux/rcupdate.h>
 #include	<linux/string.h>
 #include	<linux/nodemask.h>
+#include	<linux/bootmem.h>
 
 #include	<asm/uaccess.h>
 #include	<asm/cacheflush.h>
@@ -130,6 +131,28 @@
 #define	FORCED_DEBUG	0
 #endif
 
+#ifdef CONFIG_EARLY_KMALLOC
+static int slab_init;
+static inline int early_kmalloc_init(void)
+{
+	return slab_init++;
+}
+
+static inline int in_early_kmalloc(void)
+{
+	return slab_init == 1;
+}
+#else
+static inline int early_kmalloc_init(void)
+{
+	return 0;
+}
+
+static inline int in_early_kmalloc(void)
+{
+	return 0;
+}
+#endif
 
 /* Shouldn't this be in a header file somewhere? */
 #define	BYTES_PER_WORD		sizeof(void *)
@@ -997,6 +1020,9 @@ void __init kmem_cache_init(void)
 	struct cache_names *names;
 	int i;
 
+	if (early_kmalloc_init())
+		return;
+
 	for (i = 0; i < NUM_INIT_LISTS; i++) {
 		LIST3_INIT(&initkmem_list3[i]);
 		if (i < MAX_NUMNODES)
@@ -1177,6 +1203,35 @@ static int __init cpucache_init(void)
 
 __initcall(cpucache_init);
 
+#ifdef CONFIG_EARLY_KMALLOC
+static __init struct page *early_alloc_pages(unsigned int order, int nodeid)
+{
+	void *ptr;
+	struct page *page;
+	int i = 1 << order, j;
+	unsigned long size = 1UL << (PAGE_SHIFT+order);
+
+	if (nodeid == -1)
+		ptr = __alloc_bootmem(size, size, __pa(MAX_DMA_ADDRESS));
+	else
+		ptr = __alloc_bootmem_node(NODE_DATA(nodeid), size, size,
+				__pa(MAX_DMA_ADDRESS));
+	page = virt_to_page(ptr);
+	set_page_count(page, 1);
+	for (j = 0; j < i; j++) {
+		__ClearPageReserved(page+j);
+		reset_page_mapcount(page+j);
+#ifdef CONFIG_MMU
+		if (j)
+			set_page_count(page+j, 0);
+#else
+		if (j)
+			set_page_count(page+j, 1);
+#endif
+	}
+	return page;
+}
+#endif
 /*
  * Interface to system's page allocator. No need to hold the cache-lock.
  *
@@ -1191,11 +1246,12 @@ static void *kmem_getpages(kmem_cache_t 
 	int i;
 
 	flags |= cachep->gfpflags;
-	if (likely(nodeid == -1)) {
+	if (unlikely(in_early_kmalloc()))
+		page = early_alloc_pages(cachep->gfporder, nodeid);
+ 	else if (likely(nodeid == -1))
 		page = alloc_pages(flags, cachep->gfporder);
-	} else {
+	else
 		page = alloc_pages_node(nodeid, flags, cachep->gfporder);
-	}
 	if (!page)
 		return NULL;
 	addr = page_address(page);
@@ -1211,6 +1267,38 @@ static void *kmem_getpages(kmem_cache_t 
 	return addr;
 }
 
+
+#ifdef CONFIG_EARLY_KMALLOC
+/*
+ * Calls to kmem_freepages aren't allowed between mem_init
+ * and second call to kmem_cache_init.  mem_init uses bootmem
+ * allocator to put pages on zone buddy freelists. This transition
+ * isn't detected until kmem_cache_init is called the second time
+ * which disables the early allocator.  Early allocated pages can
+ * be freed by free_pages at this point. There isn't any
+ * distinction in page structure attributes from early and post early
+ * allocations.
+ */
+static __init void early_free_pages(kmem_cache_t *cachep, void *addr)
+{
+	unsigned long phys = __pa(addr), pfn = phys >> PAGE_SHIFT;
+	struct page *page = pfn_to_page(pfn);
+	int i = 1 << cachep->gfporder;
+
+	free_bootmem_node(NODE_DATA(pfn_to_nid(pfn)), phys, i << PAGE_SHIFT);
+	/*
+	 * This is the state which memmap_init establishes for pages.
+	 */
+	while (i--) {
+		set_page_count(page, 0);
+		reset_page_mapcount(page);
+		SetPageReserved(page);
+		INIT_LIST_HEAD(&page->lru);
+		page++;
+	}
+	return;
+}
+#endif
 /*
  * Interface to system's page release.
  */
@@ -1228,7 +1316,10 @@ static void kmem_freepages(kmem_cache_t 
 	sub_page_state(nr_slab, nr_freed);
 	if (current->reclaim_state)
 		current->reclaim_state->reclaimed_slab += nr_freed;
-	free_pages((unsigned long)addr, cachep->gfporder);
+	if (unlikely(in_early_kmalloc()))
+		early_free_pages(cachep, addr);
+	else
+		free_pages((unsigned long)addr, cachep->gfporder);
 	if (cachep->flags & SLAB_RECLAIM_ACCOUNT) 
 		atomic_sub(1<<cachep->gfporder, &slab_reclaim_pages);
 }
