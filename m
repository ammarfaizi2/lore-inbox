Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266890AbUH1PUe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266890AbUH1PUe (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Aug 2004 11:20:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267199AbUH1PUd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Aug 2004 11:20:33 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:47065 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S266890AbUH1PSn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Aug 2004 11:18:43 -0400
Date: Sat, 28 Aug 2004 17:18:37 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch][3/3] mm/ BUG -> BUG_ON conversions
Message-ID: <20040828151837.GD12772@fs.tum.de>
References: <20040828151137.GA12772@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040828151137.GA12772@fs.tum.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below does BUG -> BUG_ON conversions in mm/ .

diffstat output:
 mm/bootmem.c    |    6 ++----
 mm/filemap.c    |    6 ++----
 mm/highmem.c    |   15 +++++----------
 mm/memory.c     |   12 ++++--------
 mm/mempool.c    |    5 +++--
 mm/mmap.c       |   12 ++++--------
 mm/mprotect.c   |    3 +--
 mm/msync.c      |    3 +--
 mm/page_alloc.c |    3 +--
 mm/pdflush.c    |    3 +--
 mm/shmem.c      |    3 +--
 mm/slab.c       |   30 ++++++++++--------------------
 mm/swap.c       |   12 ++++--------
 mm/swap_state.c |    6 ++----
 mm/swapfile.c   |    6 ++----
 mm/vmalloc.c    |    3 +--
 mm/vmscan.c     |   18 ++++++------------
 17 files changed, 50 insertions(+), 96 deletions(-)


Signed-off-by: Adrian Bunk <bunk@fs.tum.de>

--- linux-2.6.9-rc1-mm1-full-3.4/mm/bootmem.c.old	2004-08-28 16:25:18.000000000 +0200
+++ linux-2.6.9-rc1-mm1-full-3.4/mm/bootmem.c	2004-08-28 16:26:48.000000000 +0200
@@ -125,8 +125,7 @@
 	sidx = start - (bdata->node_boot_start/PAGE_SIZE);
 
 	for (i = sidx; i < eidx; i++) {
-		if (unlikely(!test_and_clear_bit(i, bdata->node_bootmem_map)))
-			BUG();
+		BUG_ON(!test_and_clear_bit(i, bdata->node_bootmem_map));
 	}
 }
 
@@ -246,8 +245,7 @@
 	 * Reserve the area now:
 	 */
 	for (i = start; i < start+areasize; i++)
-		if (unlikely(test_and_set_bit(i, bdata->node_bootmem_map)))
-			BUG();
+		BUG_ON(test_and_set_bit(i, bdata->node_bootmem_map));
 	memset(ret, 0, size);
 	return ret;
 }
--- linux-2.6.9-rc1-mm1-full-3.4/mm/filemap.c.old	2004-08-28 16:25:18.000000000 +0200
+++ linux-2.6.9-rc1-mm1-full-3.4/mm/filemap.c	2004-08-28 16:27:22.000000000 +0200
@@ -440,8 +440,7 @@
 void fastcall unlock_page(struct page *page)
 {
 	smp_mb__before_clear_bit();
-	if (!TestClearPageLocked(page))
-		BUG();
+	BUG_ON(!TestClearPageLocked(page));
 	smp_mb__after_clear_bit(); 
 	wake_up_page(page);
 }
@@ -455,8 +454,7 @@
 void end_page_writeback(struct page *page)
 {
 	if (!TestClearPageReclaim(page) || rotate_reclaimable_page(page)) {
-		if (!test_clear_page_writeback(page))
-			BUG();
+		BUG_ON(!test_clear_page_writeback(page));
 		smp_mb__after_clear_bit();
 	}
 	wake_up_page(page);
--- linux-2.6.9-rc1-mm1-full-3.4/mm/highmem.c.old	2004-08-28 16:25:18.000000000 +0200
+++ linux-2.6.9-rc1-mm1-full-3.4/mm/highmem.c	2004-08-28 16:28:22.000000000 +0200
@@ -79,8 +79,7 @@
 		pkmap_count[i] = 0;
 
 		/* sanity check */
-		if (pte_none(pkmap_page_table[i]))
-			BUG();
+		BUG_ON(pte_none(pkmap_page_table[i]));
 
 		/*
 		 * Don't need an atomic fetch-and-clear op here;
@@ -161,8 +160,7 @@
 	if (!vaddr)
 		vaddr = map_new_virtual(page);
 	pkmap_count[PKMAP_NR(vaddr)]++;
-	if (pkmap_count[PKMAP_NR(vaddr)] < 2)
-		BUG();
+	BUG_ON(pkmap_count[PKMAP_NR(vaddr)] < 2);
 	spin_unlock(&kmap_lock);
 	return (void*) vaddr;
 }
@@ -177,8 +175,7 @@
 
 	spin_lock(&kmap_lock);
 	vaddr = (unsigned long)page_address(page);
-	if (!vaddr)
-		BUG();
+	BUG_ON(!vaddr);
 	nr = PKMAP_NR(vaddr);
 
 	/*
@@ -223,8 +220,7 @@
 		return 0;
 
 	page_pool = mempool_create(POOL_SIZE, page_pool_alloc, page_pool_free, NULL);
-	if (!page_pool)
-		BUG();
+	BUG_ON(!page_pool);
 	printk("highmem bounce pool size: %d pages\n", POOL_SIZE);
 
 	return 0;
@@ -266,8 +262,7 @@
 		return 0;
 
 	isa_page_pool = mempool_create(ISA_POOL_SIZE, page_pool_alloc, page_pool_free, (void *) __GFP_DMA);
-	if (!isa_page_pool)
-		BUG();
+	BUG_ON(!isa_page_pool);
 
 	printk("isa bounce pool size: %d pages\n", ISA_POOL_SIZE);
 	return 0;
--- linux-2.6.9-rc1-mm1-full-3.4/mm/memory.c.old	2004-08-28 16:25:18.000000000 +0200
+++ linux-2.6.9-rc1-mm1-full-3.4/mm/memory.c	2004-08-28 16:29:24.000000000 +0200
@@ -902,8 +902,7 @@
 
 	dir = pgd_offset(mm, address);
 	flush_cache_range(vma, beg, end);
-	if (address >= end)
-		BUG();
+	BUG_ON(address >= end);
 
 	spin_lock(&mm->page_table_lock);
 	do {
@@ -986,8 +985,7 @@
 	phys_addr -= from;
 	dir = pgd_offset(mm, from);
 	flush_cache_range(vma, beg, end);
-	if (from >= end)
-		BUG();
+	BUG_ON(from >= end);
 
 	spin_lock(&mm->page_table_lock);
 	do {
@@ -1766,10 +1764,8 @@
 
 	vma = find_vma(current->mm, addr);
 	write = (vma->vm_flags & VM_WRITE) != 0;
-	if (addr >= end)
-		BUG();
-	if (end > vma->vm_end)
-		BUG();
+	BUG_ON(addr >= end);
+	BUG_ON(end > vma->vm_end);
 	len = (end+PAGE_SIZE-1)/PAGE_SIZE-addr/PAGE_SIZE;
 	ret = get_user_pages(current, current->mm, addr,
 			len, write, 0, NULL, NULL);
--- linux-2.6.9-rc1-mm1-full-3.4/mm/mempool.c.old	2004-08-28 16:25:18.000000000 +0200
+++ linux-2.6.9-rc1-mm1-full-3.4/mm/mempool.c	2004-08-28 16:30:34.000000000 +0200
@@ -170,8 +170,9 @@
  */
 void mempool_destroy(mempool_t *pool)
 {
-	if (pool->curr_nr != pool->min_nr)
-		BUG();		/* There were outstanding elements */
+	/* There were outstanding elements */
+	BUG_ON(pool->curr_nr != pool->min_nr);
+
 	free_pool(pool);
 }
 EXPORT_SYMBOL(mempool_destroy);
--- linux-2.6.9-rc1-mm1-full-3.4/mm/mmap.c.old	2004-08-28 16:25:18.000000000 +0200
+++ linux-2.6.9-rc1-mm1-full-3.4/mm/mmap.c	2004-08-28 16:31:30.000000000 +0200
@@ -197,8 +197,7 @@
 	i = browse_rb(&mm->mm_rb);
 	if (i != mm->map_count)
 		printk("map_count %d rb %d\n", mm->map_count, i), bug = 1;
-	if (bug)
-		BUG();
+	BUG_ON(bug);
 }
 #else
 #define validate_mm(mm) do { } while (0)
@@ -333,8 +332,7 @@
 	struct rb_node ** rb_link, * rb_parent;
 
 	__vma = find_vma_prepare(mm, vma->vm_start,&prev, &rb_link, &rb_parent);
-	if (__vma && __vma->vm_start < vma->vm_end)
-		BUG();
+	BUG_ON(__vma && __vma->vm_start < vma->vm_end);
 	__vma_link(mm, vma, prev, rb_link, rb_parent);
 	mm->map_count++;
 }
@@ -704,8 +702,7 @@
 	 * (e.g. stash info in next's anon_vma_node when assigning
 	 * an anon_vma, or when trying vma_merge).  Another time.
 	 */
-	if (find_vma_prev(vma->vm_mm, vma->vm_start, &near) != vma)
-		BUG();
+	BUG_ON(find_vma_prev(vma->vm_mm, vma->vm_start, &near) != vma);
 	if (!near)
 		goto none;
 
@@ -1886,8 +1883,7 @@
 		vma->vm_pgoff = vma->vm_start >> PAGE_SHIFT;
 	}
 	__vma = find_vma_prepare(mm,vma->vm_start,&prev,&rb_link,&rb_parent);
-	if (__vma && __vma->vm_start < vma->vm_end)
-		BUG();
+	BUG_ON(__vma && __vma->vm_start < vma->vm_end);
 	vma_link(mm, vma, prev, rb_link, rb_parent);
 }
 
--- linux-2.6.9-rc1-mm1-full-3.4/mm/mprotect.c.old	2004-08-28 16:25:18.000000000 +0200
+++ linux-2.6.9-rc1-mm1-full-3.4/mm/mprotect.c	2004-08-28 16:31:49.000000000 +0200
@@ -95,8 +95,7 @@
 
 	dir = pgd_offset(current->mm, start);
 	flush_cache_range(vma, beg, end);
-	if (start >= end)
-		BUG();
+	BUG_ON(start >= end);
 	spin_lock(&current->mm->page_table_lock);
 	do {
 		change_pmd_range(dir, start, end - start, newprot);
--- linux-2.6.9-rc1-mm1-full-3.4/mm/msync.c.old	2004-08-28 16:25:18.000000000 +0200
+++ linux-2.6.9-rc1-mm1-full-3.4/mm/msync.c	2004-08-28 16:32:13.000000000 +0200
@@ -113,8 +113,7 @@
 	if (is_vm_hugetlb_page(vma))
 		goto out;
 
-	if (address >= end)
-		BUG();
+	BUG_ON(address >= end);
 	do {
 		error |= filemap_sync_pmd_range(dir, address, end, vma, flags);
 		address = (address + PGDIR_SIZE) & PGDIR_MASK;
--- linux-2.6.9-rc1-mm1-full-3.4/mm/page_alloc.c.old	2004-08-28 16:25:18.000000000 +0200
+++ linux-2.6.9-rc1-mm1-full-3.4/mm/page_alloc.c	2004-08-28 16:32:49.000000000 +0200
@@ -188,8 +188,7 @@
 		destroy_compound_page(page, order);
 	mask = (~0UL) << order;
 	page_idx = page - base;
-	if (page_idx & ~mask)
-		BUG();
+	BUG_ON(page_idx & ~mask);
 	index = page_idx >> (1 + order);
 
 	zone->free_pages += 1 << order;
--- linux-2.6.9-rc1-mm1-full-3.4/mm/pdflush.c.old	2004-08-28 16:25:18.000000000 +0200
+++ linux-2.6.9-rc1-mm1-full-3.4/mm/pdflush.c	2004-08-28 16:33:22.000000000 +0200
@@ -191,8 +191,7 @@
 	unsigned long flags;
 	int ret = 0;
 
-	if (fn == NULL)
-		BUG();		/* Hard to diagnose if it's deferred */
+	BUG_ON(fn == NULL);	/* Hard to diagnose if it's deferred */
 
 	spin_lock_irqsave(&pdflush_lock, flags);
 	if (list_empty(&pdflush_list)) {
--- linux-2.6.9-rc1-mm1-full-3.4/mm/shmem.c.old	2004-08-28 16:25:18.000000000 +0200
+++ linux-2.6.9-rc1-mm1-full-3.4/mm/shmem.c	2004-08-28 16:33:49.000000000 +0200
@@ -1696,8 +1696,7 @@
 		struct page *page;
 
 		page = find_get_page(dentry->d_inode->i_mapping, 0);
-		if (!page)
-			BUG();
+		BUG_ON(!page);
 		kunmap(page);
 		mark_page_accessed(page);
 		page_cache_release(page);
--- linux-2.6.9-rc1-mm1-full-3.4/mm/slab.c.old	2004-08-28 16:25:18.000000000 +0200
+++ linux-2.6.9-rc1-mm1-full-3.4/mm/slab.c	2004-08-28 16:36:04.000000000 +0200
@@ -743,8 +743,7 @@
 
 	cache_estimate(0, cache_cache.objsize, cache_line_size(), 0,
 				&left_over, &cache_cache.num);
-	if (!cache_cache.num)
-		BUG();
+	BUG_ON(!cache_cache.num);
 
 	cache_cache.colour = left_over/cache_cache.colour_off;
 	cache_cache.colour_next = 0;
@@ -887,8 +886,7 @@
 	const unsigned long nr_freed = i;
 
 	while (i--) {
-		if (!TestClearPageSlab(page))
-			BUG();
+		BUG_ON(!TestClearPageSlab(page));
 		page++;
 	}
 	sub_page_state(nr_slab, nr_freed);
@@ -1199,8 +1197,7 @@
 	 * Always checks flags, a caller might be expecting debug
 	 * support which isn't available.
 	 */
-	if (flags & ~CREATE_MASK)
-		BUG();
+	BUG_ON(flags & ~CREATE_MASK);
 
 	if (align) {
 		/* combinations of forced alignment and advanced debugging is
@@ -1476,8 +1473,7 @@
 	func(arg);
 	local_irq_enable();
 
-	if (smp_call_function(func, arg, 1, 1))
-		BUG();
+	BUG_ON(smp_call_function(func, arg, 1, 1));
 
 	preempt_enable();
 }
@@ -1529,8 +1525,7 @@
 
 		slabp = list_entry(cachep->lists.slabs_free.prev, struct slab, list);
 #if DEBUG
-		if (slabp->inuse)
-			BUG();
+		BUG_ON(slabp->inuse);
 #endif
 		list_del(&slabp->list);
 
@@ -1554,8 +1549,7 @@
  */
 int kmem_cache_shrink(kmem_cache_t *cachep)
 {
-	if (!cachep || in_interrupt())
-		BUG();
+	BUG_ON(!cachep || in_interrupt());
 
 	return __cache_shrink(cachep);
 }
@@ -1583,8 +1577,7 @@
 {
 	int i;
 
-	if (!cachep || in_interrupt())
-		BUG();
+	BUG_ON(!cachep || in_interrupt());
 
 	/* Don't let CPUs to come and go */
 	lock_cpu_hotplug();
@@ -1703,11 +1696,9 @@
 static void kmem_flagcheck(kmem_cache_t *cachep, int flags)
 {
 	if (flags & SLAB_DMA) {
-		if (!(cachep->gfpflags & GFP_DMA))
-			BUG();
+		BUG_ON(!(cachep->gfpflags & GFP_DMA));
 	} else {
-		if (cachep->gfpflags & GFP_DMA)
-			BUG();
+		BUG_ON(cachep->gfpflags & GFP_DMA);
 	}
 }
 
@@ -1741,8 +1732,7 @@
 	/* Be lazy and only check for valid flags here,
  	 * keeping it out of the critical path in kmem_cache_alloc().
 	 */
-	if (flags & ~(SLAB_DMA|SLAB_LEVEL_MASK|SLAB_NO_GROW))
-		BUG();
+	BUG_ON(flags & ~(SLAB_DMA|SLAB_LEVEL_MASK|SLAB_NO_GROW));
 	if (flags & SLAB_NO_GROW)
 		return 0;
 
--- linux-2.6.9-rc1-mm1-full-3.4/mm/swap.c.old	2004-08-28 16:25:18.000000000 +0200
+++ linux-2.6.9-rc1-mm1-full-3.4/mm/swap.c	2004-08-28 16:36:55.000000000 +0200
@@ -90,8 +90,7 @@
 		list_add_tail(&page->lru, &zone->inactive_list);
 		inc_page_state(pgrotated);
 	}
-	if (!test_clear_page_writeback(page))
-		BUG();
+	BUG_ON(!test_clear_page_writeback(page));
 	spin_unlock_irqrestore(&zone->lru_lock, flags);
 	return 0;
 }
@@ -302,8 +301,7 @@
 			zone = pagezone;
 			spin_lock_irq(&zone->lru_lock);
 		}
-		if (TestSetPageLRU(page))
-			BUG();
+		BUG_ON(TestSetPageLRU(page));
 		add_page_to_inactive_list(zone, page);
 	}
 	if (zone)
@@ -329,10 +327,8 @@
 			zone = pagezone;
 			spin_lock_irq(&zone->lru_lock);
 		}
-		if (TestSetPageLRU(page))
-			BUG();
-		if (TestSetPageActive(page))
-			BUG();
+		BUG_ON(TestSetPageLRU(page));
+		BUG_ON(TestSetPageActive(page));
 		add_page_to_active_list(zone, page);
 	}
 	if (zone)
--- linux-2.6.9-rc1-mm1-full-3.4/mm/swap_state.c.old	2004-08-28 16:25:18.000000000 +0200
+++ linux-2.6.9-rc1-mm1-full-3.4/mm/swap_state.c	2004-08-28 16:37:23.000000000 +0200
@@ -144,8 +144,7 @@
 	int pf_flags;
 	int err;
 
-	if (!PageLocked(page))
-		BUG();
+	BUG_ON(!PageLocked(page));
 
 	for (;;) {
 		entry = get_swap_page();
@@ -229,8 +228,7 @@
 	if (!err) {
 		remove_from_page_cache(page);
 		page_cache_release(page);	/* pagecache ref */
-		if (!swap_duplicate(entry))
-			BUG();
+		BUG_ON(!swap_duplicate(entry));
 		SetPageDirty(page);
 		INC_CACHE_INFO(add_total);
 	} else if (err == -EEXIST)
--- linux-2.6.9-rc1-mm1-full-3.4/mm/swapfile.c.old	2004-08-28 16:25:18.000000000 +0200
+++ linux-2.6.9-rc1-mm1-full-3.4/mm/swapfile.c	2004-08-28 16:37:50.000000000 +0200
@@ -312,8 +312,7 @@
 {
 	int retval = 0;
 
-	if (!PageLocked(page))
-		BUG();
+	BUG_ON(!PageLocked(page));
 	switch (page_count(page)) {
 	case 3:
 		if (!PagePrivate(page))
@@ -506,8 +505,7 @@
 	end = address + size;
 	if (end > PGDIR_SIZE)
 		end = PGDIR_SIZE;
-	if (address >= end)
-		BUG();
+	BUG_ON(address >= end);
 	do {
 		foundaddr = unuse_pmd(vma, pmd, address, end - address,
 						offset, entry, page);
--- linux-2.6.9-rc1-mm1-full-3.4/mm/vmalloc.c.old	2004-08-28 16:25:18.000000000 +0200
+++ linux-2.6.9-rc1-mm1-full-3.4/mm/vmalloc.c	2004-08-28 16:38:14.000000000 +0200
@@ -318,8 +318,7 @@
 		int i;
 
 		for (i = 0; i < area->nr_pages; i++) {
-			if (unlikely(!area->pages[i]))
-				BUG();
+			BUG_ON(!area->pages[i]);
 			__free_page(area->pages[i]);
 		}
 
--- linux-2.6.9-rc1-mm1-full-3.4/mm/vmscan.c.old	2004-08-28 16:25:18.000000000 +0200
+++ linux-2.6.9-rc1-mm1-full-3.4/mm/vmscan.c	2004-08-28 16:39:28.000000000 +0200
@@ -564,8 +564,7 @@
 			prefetchw_prev_lru_page(page,
 						&zone->inactive_list, flags);
 
-			if (!TestClearPageLRU(page))
-				BUG();
+			BUG_ON(!TestClearPageLRU(page));
 			list_del(&page->lru);
 			if (get_page_testone(page)) {
 				/*
@@ -603,8 +602,7 @@
 		 */
 		while (!list_empty(&page_list)) {
 			page = lru_to_page(&page_list);
-			if (TestSetPageLRU(page))
-				BUG();
+			BUG_ON(TestSetPageLRU(page));
 			list_del(&page->lru);
 			if (PageActive(page))
 				add_page_to_active_list(zone, page);
@@ -662,8 +660,7 @@
 	while (pgscanned < nr_pages && !list_empty(&zone->active_list)) {
 		page = lru_to_page(&zone->active_list);
 		prefetchw_prev_lru_page(page, &zone->active_list, flags);
-		if (!TestClearPageLRU(page))
-			BUG();
+		BUG_ON(!TestClearPageLRU(page));
 		list_del(&page->lru);
 		if (get_page_testone(page)) {
 			/*
@@ -735,10 +732,8 @@
 	while (!list_empty(&l_inactive)) {
 		page = lru_to_page(&l_inactive);
 		prefetchw_prev_lru_page(page, &l_inactive, flags);
-		if (TestSetPageLRU(page))
-			BUG();
-		if (!TestClearPageActive(page))
-			BUG();
+		BUG_ON(TestSetPageLRU(page));
+		BUG_ON(!TestClearPageActive(page));
 		list_move(&page->lru, &zone->inactive_list);
 		pgmoved++;
 		if (!pagevec_add(&pvec, page)) {
@@ -764,8 +759,7 @@
 	while (!list_empty(&l_active)) {
 		page = lru_to_page(&l_active);
 		prefetchw_prev_lru_page(page, &l_active, flags);
-		if (TestSetPageLRU(page))
-			BUG();
+		BUG_ON(TestSetPageLRU(page));
 		BUG_ON(!PageActive(page));
 		list_move(&page->lru, &zone->active_list);
 		pgmoved++;

