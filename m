Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289873AbSAKEvQ>; Thu, 10 Jan 2002 23:51:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287711AbSAKEvB>; Thu, 10 Jan 2002 23:51:01 -0500
Received: from nat.transgeek.com ([66.92.79.28]:18424 "HELO smtp.transgeek.com")
	by vger.kernel.org with SMTP id <S289873AbSAKEum>;
	Thu, 10 Jan 2002 23:50:42 -0500
Content-Type: text/plain; charset=US-ASCII
From: Craig Christophel <merlin@transgeek.com>
To: linux-kernel@vger.kernel.org
Subject: if() BUG(); to BUG_ON(); in linux/mm
Date: Thu, 10 Jan 2002 23:51:15 -0500
X-Mailer: KMail [version 1.3.1]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020111004804.AD8A8C73A5@smtp.transgeek.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

same type of patch as the fs patches.   This one works it's magic in the mm 
system.  against 2.5.2-pre11.





Index: linux/mm//bootmem.c
===================================================================
RCS file: /home/Media/cvs/linux/mm/bootmem.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 bootmem.c
--- linux/mm//bootmem.c	11 Jan 2002 03:10:50 -0000	1.1.1.1
+++ linux/mm//bootmem.c	11 Jan 2002 04:27:03 -0000
@@ -82,18 +82,13 @@
 							PAGE_SIZE-1)/PAGE_SIZE;
 	unsigned long end = (addr + size + PAGE_SIZE-1)/PAGE_SIZE;
 
-	if (!size) BUG();
+	BUG_ON(!size);
+	BUG_ON(sidx < 0);
+	BUG_ON(eidx < 0);
+	BUG_ON(sidx >= eidx);
+	BUG_ON((addr >> PAGE_SHIFT) >= bdata->node_low_pfn);
+	BUG_ON(end > bdata->node_low_pfn);
 
-	if (sidx < 0)
-		BUG();
-	if (eidx < 0)
-		BUG();
-	if (sidx >= eidx)
-		BUG();
-	if ((addr >> PAGE_SHIFT) >= bdata->node_low_pfn)
-		BUG();
-	if (end > bdata->node_low_pfn)
-		BUG();
 	for (i = sidx; i < eidx; i++)
 		if (test_and_set_bit(i, bdata->node_bootmem_map))
 			printk("hm, page %08lx reserved twice.\n", i*PAGE_SIZE);
@@ -111,9 +106,8 @@
 	unsigned long eidx = (addr + size - bdata->node_boot_start)/PAGE_SIZE;
 	unsigned long end = (addr + size)/PAGE_SIZE;
 
-	if (!size) BUG();
-	if (end > bdata->node_low_pfn)
-		BUG();
+	BUG_ON(!size);
+	BUG_ON(end > bdata->node_low_pfn);
 
 	/*
 	 * Round up the beginning of the address.
@@ -122,8 +116,7 @@
 	sidx = start - (bdata->node_boot_start/PAGE_SIZE);
 
 	for (i = sidx; i < eidx; i++) {
-		if (!test_and_clear_bit(i, bdata->node_bootmem_map))
-			BUG();
+		BUG_ON(!test_and_clear_bit(i, bdata->node_bootmem_map));
 	}
 }
 
@@ -150,10 +143,8 @@
 	unsigned long eidx = bdata->node_low_pfn - (bdata->node_boot_start >>
 							PAGE_SHIFT);
 
-	if (!size) BUG();
-
-	if (align & (align-1))
-		BUG();
+	BUG_ON(!size);
+	BUG_ON(align & (align-1));
 
 	/*
 	 * We try to allocate bootmem pages above 'goal'
@@ -190,8 +181,7 @@
 	}
 	return NULL;
 found:
-	if (start >= eidx)
-		BUG();
+	BUG_ON(start >= eidx);
 
 	/*
 	 * Is the next page of the previous allocation-end the start
@@ -201,8 +191,7 @@
 	if (align <= PAGE_SIZE
 	    && bdata->last_offset && bdata->last_pos+1 == start) {
 		offset = (bdata->last_offset+align-1) & ~(align-1);
-		if (offset > PAGE_SIZE)
-			BUG();
+		BUG_ON(offset > PAGE_SIZE);
 		remaining_size = PAGE_SIZE-offset;
 		if (size < remaining_size) {
 			areasize = 0;
@@ -228,8 +217,8 @@
 	 * Reserve the area now:
 	 */
 	for (i = start; i < start+areasize; i++)
-		if (test_and_set_bit(i, bdata->node_bootmem_map))
-			BUG();
+		BUG_ON(test_and_set_bit(i, bdata->node_bootmem_map));
+
 	memset(ret, 0, size);
 	return ret;
 }
@@ -241,7 +230,7 @@
 	unsigned long i, count, total = 0;
 	unsigned long idx;
 
-	if (!bdata->node_bootmem_map) BUG();
+	BUG_ON(!bdata->node_bootmem_map);
 
 	count = 0;
 	idx = bdata->node_low_pfn - (bdata->node_boot_start >> PAGE_SHIFT);
Index: linux/mm//filemap.c
===================================================================
RCS file: /home/Media/cvs/linux/mm/filemap.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 filemap.c
--- linux/mm//filemap.c	11 Jan 2002 03:10:50 -0000	1.1.1.1
+++ linux/mm//filemap.c	11 Jan 2002 04:27:50 -0000
@@ -114,7 +114,7 @@
  */
 void __remove_inode_page(struct page *page)
 {
-	if (PageDirty(page)) BUG();
+	BUG_ON(PageDirty(page));
 	remove_page_from_inode_queue(page);
 	remove_page_from_hash_queue(page);
 }
@@ -647,8 +647,7 @@
  */
 void add_to_page_cache_locked(struct page * page, struct address_space 
*mapping, unsigned long index)
 {
-	if (!PageLocked(page))
-		BUG();
+	BUG_ON(!PageLocked(page));
 
 	page->index = index;
 	page_cache_get(page);
@@ -792,8 +791,7 @@
 {
 	clear_bit(PG_launder, &(page)->flags);
 	smp_mb__before_clear_bit();
-	if (!test_and_clear_bit(PG_locked, &(page)->flags))
-		BUG();
+	BUG_ON(!test_and_clear_bit(PG_locked, &(page)->flags));
 	smp_mb__after_clear_bit(); 
 	if (waitqueue_active(&(page)->wait))
 	wake_up(&(page)->wait);
@@ -2095,8 +2093,7 @@
 
 	dir = pgd_offset(vma->vm_mm, address);
 	flush_cache_range(vma->vm_mm, end - size, end);
-	if (address >= end)
-		BUG();
+	BUG_ON(address >= end);
 	do {
 		error |= filemap_sync_pmd_range(dir, address, end - address, vma, flags);
 		address = (address + PGDIR_SIZE) & PGDIR_MASK;
Index: linux/mm//highmem.c
===================================================================
RCS file: /home/Media/cvs/linux/mm/highmem.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 highmem.c
--- linux/mm//highmem.c	11 Jan 2002 03:10:50 -0000	1.1.1.1
+++ linux/mm//highmem.c	11 Jan 2002 04:28:46 -0000
@@ -72,8 +72,7 @@
 		pkmap_count[i] = 0;
 
 		/* sanity check */
-		if (pte_none(pkmap_page_table[i]))
-			BUG();
+		BUG_ON(pte_none(pkmap_page_table[i]));
 
 		/*
 		 * Don't need an atomic fetch-and-clear op here;
@@ -154,8 +153,7 @@
 	if (!vaddr)
 		vaddr = map_new_virtual(page);
 	pkmap_count[PKMAP_NR(vaddr)]++;
-	if (pkmap_count[PKMAP_NR(vaddr)] < 2)
-		BUG();
+	BUG_ON(pkmap_count[PKMAP_NR(vaddr)] < 2);
 	spin_unlock(&kmap_lock);
 	return (void*) vaddr;
 }
@@ -168,8 +166,7 @@
 
 	spin_lock(&kmap_lock);
 	vaddr = (unsigned long) page->virtual;
-	if (!vaddr)
-		BUG();
+	BUG_ON(!vaddr);
 	nr = PKMAP_NR(vaddr);
 
 	/*
@@ -212,8 +209,7 @@
 		return 0;
 
 	page_pool = mempool_create(POOL_SIZE, page_pool_alloc, page_pool_free, 
NULL);
-	if (!page_pool)
-		BUG();
+	BUG_ON(!page_pool);
 	printk("highmem bounce pool size: %d pages\n", POOL_SIZE);
 
 	return 0;
@@ -255,8 +251,7 @@
 		return 0;
 
 	isa_page_pool = mempool_create(ISA_POOL_SIZE, page_pool_alloc, 
page_pool_free, (void *) __GFP_DMA);
-	if (!isa_page_pool)
-		BUG();
+	BUG_ON(!isa_page_pool);
 
 	printk("isa bounce pool size: %d pages\n", ISA_POOL_SIZE);
 	return 0;
Index: linux/mm//memory.c
===================================================================
RCS file: /home/Media/cvs/linux/mm/memory.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 memory.c
--- linux/mm//memory.c	11 Jan 2002 03:10:50 -0000	1.1.1.1
+++ linux/mm//memory.c	11 Jan 2002 04:29:56 -0000
@@ -283,7 +283,7 @@
  */
 static inline void forget_pte(pte_t page)
 {
-	if (!pte_none(page)) {
+	if (unlikely(!pte_none(page))) {
 		printk("forget_pte: old mapping existed!\n");
 		BUG();
 	}
@@ -371,8 +371,7 @@
 	 * even if kswapd happened to be looking at this
 	 * process we _want_ it to get stuck.
 	 */
-	if (address >= end)
-		BUG();
+	BUG_ON(address >= end);
 	spin_lock(&mm->page_table_lock);
 	flush_cache_range(mm, address, end);
 	tlb = tlb_gather_mmu(mm);
@@ -520,7 +519,7 @@
 	
 	pgcount = (va + len + PAGE_SIZE - 1)/PAGE_SIZE - va/PAGE_SIZE;
 	/* mapping 0 bytes is not permitted */
-	if (!pgcount) BUG();
+	BUG_ON(!pgcount);
 	err = expand_kiobuf(iobuf, pgcount);
 	if (err)
 		return err;
@@ -767,8 +766,7 @@
 
 	dir = pgd_offset(mm, address);
 	flush_cache_range(mm, beg, end);
-	if (address >= end)
-		BUG();
+	BUG_ON(address >= end);
 
 	spin_lock(&mm->page_table_lock);
 	do {
@@ -849,8 +847,7 @@
 	phys_addr -= from;
 	dir = pgd_offset(mm, from);
 	flush_cache_range(mm, beg, end);
-	if (from >= end)
-		BUG();
+	BUG_ON(from >= end);
 
 	spin_lock(&mm->page_table_lock);
 	do {
@@ -1434,10 +1431,8 @@
 
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
Index: linux/mm//mempool.c
===================================================================
RCS file: /home/Media/cvs/linux/mm/mempool.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 mempool.c
--- linux/mm//mempool.c	11 Jan 2002 03:10:50 -0000	1.1.1.1
+++ linux/mm//mempool.c	11 Jan 2002 04:30:22 -0000
@@ -98,8 +98,7 @@
 	unsigned long flags;
 	struct list_head *tmp;
 
-	if (new_min_nr <= 0)
-		BUG();
+	BUG_ON(new_min_nr <= 0);
 
 	spin_lock_irqsave(&pool->lock, flags);
 	if (new_min_nr < pool->min_nr) {
@@ -109,8 +108,7 @@
 		 */
 		while (pool->curr_nr > pool->min_nr) {
 			tmp = pool->elements.next;
-			if (tmp == &pool->elements)
-				BUG();
+			BUG_ON(tmp == &pool->elements);
 			list_del(tmp);
 			element = tmp;
 			pool->curr_nr--;
@@ -164,8 +162,7 @@
 		pool->free(element, pool->pool_data);
 		pool->curr_nr--;
 	}
-	if (pool->curr_nr)
-		BUG();
+	BUG_ON(pool->curr_nr);
 	kfree(pool);
 }
 
Index: linux/mm//mmap.c
===================================================================
RCS file: /home/Media/cvs/linux/mm/mmap.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 mmap.c
--- linux/mm//mmap.c	11 Jan 2002 03:10:50 -0000	1.1.1.1
+++ linux/mm//mmap.c	11 Jan 2002 04:31:32 -0000
@@ -235,8 +235,7 @@
 	i = browse_rb(mm->mm_rb.rb_node);
 	if (i != mm->map_count)
 		printk("map_count %d rb %d\n", mm->map_count, i), bug = 1;
-	if (bug)
-		BUG();
+	BUG_ON(bug);
 }
 #else
 #define validate_mm(mm) do { } while (0)
@@ -705,8 +704,7 @@
 			*pprev = NULL;
 			if (rb_prev)
 				*pprev = rb_entry(rb_prev, struct vm_area_struct, vm_rb);
-			if ((rb_prev ? (*pprev)->vm_next : mm->mmap) != vma)
-				BUG();
+			BUG_ON((rb_prev ? (*pprev)->vm_next : mm->mmap) != vma);
 			return vma;
 		}
 	}
@@ -1136,8 +1134,7 @@
 	flush_tlb_mm(mm);
 
 	/* This is just debugging */
-	if (mm->map_count)
-		BUG();
+	BUG_ON(mm->map_count);
 
 	clear_page_tables(mm, FIRST_USER_PGD_NR, USER_PTRS_PER_PGD);
 }
@@ -1152,8 +1149,7 @@
 	rb_node_t ** rb_link, * rb_parent;
 
 	__vma = find_vma_prepare(mm, vma->vm_start, &prev, &rb_link, &rb_parent);
-	if (__vma && __vma->vm_start < vma->vm_end)
-		BUG();
+	BUG_ON(__vma && __vma->vm_start < vma->vm_end);
 	__vma_link(mm, vma, prev, rb_link, rb_parent);
 	mm->map_count++;
 	validate_mm(mm);
@@ -1165,8 +1161,7 @@
 	rb_node_t ** rb_link, * rb_parent;
 
 	__vma = find_vma_prepare(mm, vma->vm_start, &prev, &rb_link, &rb_parent);
-	if (__vma && __vma->vm_start < vma->vm_end)
-		BUG();
+	BUG_ON(__vma && __vma->vm_start < vma->vm_end);
 	vma_link(mm, vma, prev, rb_link, rb_parent);
 	validate_mm(mm);
 }
Index: linux/mm//mprotect.c
===================================================================
RCS file: /home/Media/cvs/linux/mm/mprotect.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 mprotect.c
--- linux/mm//mprotect.c	11 Jan 2002 03:10:50 -0000	1.1.1.1
+++ linux/mm//mprotect.c	11 Jan 2002 04:31:46 -0000
@@ -79,8 +79,7 @@
 
 	dir = pgd_offset(current->mm, start);
 	flush_cache_range(current->mm, beg, end);
-	if (start >= end)
-		BUG();
+	BUG_ON(start >= end);
 	spin_lock(&current->mm->page_table_lock);
 	do {
 		change_pmd_range(dir, start, end - start, newprot);
Index: linux/mm//mremap.c
===================================================================
RCS file: /home/Media/cvs/linux/mm/mremap.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 mremap.c
--- linux/mm//mremap.c	11 Jan 2002 03:10:50 -0000	1.1.1.1
+++ linux/mm//mremap.c	11 Jan 2002 04:31:59 -0000
@@ -140,8 +140,7 @@
 			prev->vm_end = new_addr + new_len;
 			spin_unlock(&mm->page_table_lock);
 			new_vma = prev;
-			if (next != prev->vm_next)
-				BUG();
+			BUG_ON(next != prev->vm_next);
 			if (prev->vm_end == next->vm_start && can_vma_merge(next, 
prev->vm_flags)) {
 				spin_lock(&mm->page_table_lock);
 				prev->vm_end = next->vm_end;
Index: linux/mm//page_alloc.c
===================================================================
RCS file: /home/Media/cvs/linux/mm/page_alloc.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 page_alloc.c
--- linux/mm//page_alloc.c	11 Jan 2002 03:10:50 -0000	1.1.1.1
+++ linux/mm//page_alloc.c	11 Jan 2002 04:38:25 -0000
@@ -70,20 +70,14 @@
 	struct page *base;
 	zone_t *zone;
 
-	if (page->buffers)
-		BUG();
-	if (page->mapping)
-		BUG();
-	if (!VALID_PAGE(page))
-		BUG();
-	if (PageSwapCache(page))
-		BUG();
-	if (PageLocked(page))
-		BUG();
-	if (PageLRU(page))
-		BUG();
-	if (PageActive(page))
-		BUG();
+	BUG_ON(page->buffers);
+	BUG_ON(page->mapping);
+	BUG_ON(!VALID_PAGE(page));
+	BUG_ON(PageSwapCache(page));
+	BUG_ON(PageLocked(page));
+	BUG_ON(PageLRU(page));
+	BUG_ON(PageActive(page));
+
 	page->flags &= ~((1<<PG_referenced) | (1<<PG_dirty));
 
 	if (current->flags & PF_FREE_PAGES)
@@ -95,8 +89,7 @@
 	mask = (~0UL) << order;
 	base = zone->zone_mem_map;
 	page_idx = page - base;
-	if (page_idx & ~mask)
-		BUG();
+	BUG_ON(page_idx & ~mask);
 	index = page_idx >> (1 + order);
 
 	area = zone->free_area + order;
@@ -108,8 +101,7 @@
 	while (mask + (1 << (MAX_ORDER-1))) {
 		struct page *buddy1, *buddy2;
 
-		if (area >= zone->free_area + MAX_ORDER)
-			BUG();
+		BUG_ON(area >= zone->free_area + MAX_ORDER);
 		if (!__test_and_change_bit(index, area->map))
 			/*
 			 * the buddy page is still allocated.
@@ -120,10 +112,8 @@
 		 */
 		buddy1 = base + (page_idx ^ -mask);
 		buddy2 = base + page_idx;
-		if (BAD_RANGE(zone,buddy1))
-			BUG();
-		if (BAD_RANGE(zone,buddy2))
-			BUG();
+		BUG_ON(BAD_RANGE(zone,buddy1));
+		BUG_ON(BAD_RANGE(zone,buddy2));
 
 		memlist_del(&buddy1->list);
 		mask <<= 1;
@@ -156,8 +146,7 @@
 	unsigned long size = 1 << high;
 
 	while (high > low) {
-		if (BAD_RANGE(zone,page))
-			BUG();
+		BUG_ON(BAD_RANGE(zone,page));
 		area--;
 		high--;
 		size >>= 1;
@@ -166,8 +155,7 @@
 		index += size;
 		page += size;
 	}
-	if (BAD_RANGE(zone,page))
-		BUG();
+	BUG_ON(BAD_RANGE(zone,page));
 	return page;
 }
 
@@ -189,8 +177,7 @@
 			unsigned int index;
 
 			page = memlist_entry(curr, struct page, list);
-			if (BAD_RANGE(zone,page))
-				BUG();
+			BUG_ON(BAD_RANGE(zone,page));
 			memlist_del(curr);
 			index = page - zone->zone_mem_map;
 			if (curr_order != MAX_ORDER-1)
@@ -201,12 +188,9 @@
 			spin_unlock_irqrestore(&zone->lock, flags);
 
 			set_page_count(page, 1);
-			if (BAD_RANGE(zone,page))
-				BUG();
-			if (PageLRU(page))
-				BUG();
-			if (PageActive(page))
-				BUG();
+			BUG_ON(BAD_RANGE(zone,page));
+			BUG_ON(PageLRU(page));
+			BUG_ON(PageActive(page));
 			return page;	
 		}
 		curr_order++;
@@ -233,8 +217,7 @@
 
 	if (!(gfp_mask & __GFP_WAIT))
 		goto out;
-	if (in_interrupt())
-		BUG();
+	BUG_ON(in_interrupt());
 
 	current->allocation_order = order;
 	current->flags |= PF_MEMALLOC | PF_FREE_PAGES;
@@ -261,22 +244,14 @@
 					set_page_count(tmp, 1);
 					page = tmp;
 
-					if (page->buffers)
-						BUG();
-					if (page->mapping)
-						BUG();
-					if (!VALID_PAGE(page))
-						BUG();
-					if (PageSwapCache(page))
-						BUG();
-					if (PageLocked(page))
-						BUG();
-					if (PageLRU(page))
-						BUG();
-					if (PageActive(page))
-						BUG();
-					if (PageDirty(page))
-						BUG();
+					BUG_ON(page->buffers);
+					BUG_ON(page->mapping);
+					BUG_ON(!VALID_PAGE(page));
+					BUG_ON(PageSwapCache(page));
+					BUG_ON(PageLocked(page));
+					BUG_ON(PageLRU(page));
+					BUG_ON(PageActive(page));
+					BUG_ON(PageDirty(page));
 
 					break;
 				}
@@ -289,8 +264,7 @@
 			list_del(entry);
 			tmp = list_entry(entry, struct page, list);
 			__free_pages_ok(tmp, tmp->index);
-			if (!nr_pages--)
-				BUG();
+			BUG_ON(!nr_pages--);
 		}
 		current->nr_local_pages = 0;
 	}
@@ -642,8 +616,7 @@
 	unsigned long totalpages, offset, realtotalpages;
 	const unsigned long zone_required_alignment = 1UL << (MAX_ORDER-1);
 
-	if (zone_start_paddr & ~PAGE_MASK)
-		BUG();
+	BUG_ON(zone_start_paddr & ~PAGE_MASK);
 
 	totalpages = 0;
 	for (i = 0; i < MAX_NR_ZONES; i++) {
Index: linux/mm//shmem.c
===================================================================
RCS file: /home/Media/cvs/linux/mm/shmem.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 shmem.c
--- linux/mm//shmem.c	11 Jan 2002 03:10:50 -0000	1.1.1.1
+++ linux/mm//shmem.c	11 Jan 2002 04:39:22 -0000
@@ -291,8 +291,7 @@
 		len = max+1;
 	} else {
 		max -= ENTRIES_PER_PAGE*ENTRIES_PER_PAGE/2+SHMEM_NR_DIRECT;
-		if (max >= ENTRIES_PER_PAGE*ENTRIES_PER_PAGE*ENTRIES_PER_PAGE/2)
-			BUG();
+		BUG_ON(max >= ENTRIES_PER_PAGE*ENTRIES_PER_PAGE*ENTRIES_PER_PAGE/2);
 
 		baseidx = max & ~(ENTRIES_PER_PAGE*ENTRIES_PER_PAGE-1);
 		base = (swp_entry_t ***) info->i_indirect + ENTRIES_PER_PAGE/2 + 
baseidx/ENTRIES_PER_PAGE/ENTRIES_PER_PAGE ;
@@ -426,8 +425,7 @@
 	unsigned long index;
 	struct inode *inode;
 
-	if (!PageLocked(page))
-		BUG();
+	BUG_ON(!PageLocked(page));
 	if (!PageLaunder(page))
 		return fail_writepage(page);
 
@@ -444,11 +442,9 @@
 
 	spin_lock(&info->lock);
 	entry = shmem_swp_entry(info, index, 0);
-	if (IS_ERR(entry))	/* this had been allocated on page allocation */
-		BUG();
+	BUG_ON(IS_ERR(entry));	/* this had been allocated on page allocation */
 	shmem_recalc_inode(inode);
-	if (entry->val)
-		BUG();
+	BUG_ON(entry->val);
 
 	/* Remove it from the page cache */
 	remove_inode_page(page);
Index: linux/mm//slab.c
===================================================================
RCS file: /home/Media/cvs/linux/mm/slab.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 slab.c
--- linux/mm//slab.c	11 Jan 2002 03:10:50 -0000	1.1.1.1
+++ linux/mm//slab.c	11 Jan 2002 04:45:28 -0000
@@ -423,8 +423,7 @@
 
 	kmem_cache_estimate(0, cache_cache.objsize, 0,
 			&left_over, &cache_cache.num);
-	if (!cache_cache.num)
-		BUG();
+	BUG_ON(!cache_cache.num);
 
 	cache_cache.colour = left_over/cache_cache.colour_off;
 	cache_cache.colour_next = 0;
@@ -451,11 +450,9 @@
 		 * Note for systems short on memory removing the alignment will
 		 * allow tighter packing of the smaller caches. */
 		sprintf(name,"size-%Zd",sizes->cs_size);
-		if (!(sizes->cs_cachep =
+		BUG_ON(!(sizes->cs_cachep =
 			kmem_cache_create(name, sizes->cs_size,
-					0, SLAB_HWCACHE_ALIGN, NULL, NULL))) {
-			BUG();
-		}
+					0, SLAB_HWCACHE_ALIGN, NULL, NULL)));
 
 		/* Inc off-slab bufctl limit until the ceiling is hit. */
 		if (!(OFF_SLAB(sizes->cs_cachep))) {
@@ -465,8 +462,7 @@
 		sprintf(name, "size-%Zd(DMA)",sizes->cs_size);
 		sizes->cs_dmacachep = kmem_cache_create(name, sizes->cs_size, 0,
 			      SLAB_CACHE_DMA|SLAB_HWCACHE_ALIGN, NULL, NULL);
-		if (!sizes->cs_dmacachep)
-			BUG();
+		BUG_ON(!sizes->cs_dmacachep);
 		sizes++;
 	} while (sizes->cs_size);
 }
@@ -565,11 +561,9 @@
 			void* objp = slabp->s_mem+cachep->objsize*i;
 #if DEBUG
 			if (cachep->flags & SLAB_RED_ZONE) {
-				if (*((unsigned long*)(objp)) != RED_MAGIC1)
-					BUG();
-				if (*((unsigned long*)(objp + cachep->objsize
-						-BYTES_PER_WORD)) != RED_MAGIC1)
-					BUG();
+				BUG_ON(*((unsigned long*)(objp)) != RED_MAGIC1);
+				BUG_ON(*((unsigned long*)(objp + cachep->objsize
+						-BYTES_PER_WORD)) != RED_MAGIC1);
 				objp += BYTES_PER_WORD;
 			}
 #endif
@@ -579,9 +573,8 @@
 			if (cachep->flags & SLAB_RED_ZONE) {
 				objp -= BYTES_PER_WORD;
 			}	
-			if ((cachep->flags & SLAB_POISON)  &&
-				kmem_check_poison_obj(cachep, objp))
-				BUG();
+			BUG_ON((cachep->flags & SLAB_POISON)  &&
+				kmem_check_poison_obj(cachep, objp));
 #endif
 		}
 	}
@@ -631,14 +624,13 @@
 	/*
 	 * Sanity checks... these are all serious usage bugs.
 	 */
-	if ((!name) ||
+	BUG_ON((!name) ||
 		((strlen(name) >= CACHE_NAMELEN - 1)) ||
 		in_interrupt() ||
 		(size < BYTES_PER_WORD) ||
 		(size > (1<<MAX_OBJ_ORDER)*PAGE_SIZE) ||
 		(dtor && !ctor) ||
-		(offset < 0 || offset > size))
-			BUG();
+		(offset < 0 || offset > size));
 
 #if DEBUG
 	if ((flags & SLAB_DEBUG_INITIAL) && !ctor) {
@@ -668,8 +660,7 @@
 	 * Always checks flags, a caller might be expecting debug
 	 * support which isn't available.
 	 */
-	if (flags & ~CREATE_MASK)
-		BUG();
+	BUG_ON(flags & ~CREATE_MASK);
 
 	/* Get cache's description obj. */
 	cachep = (kmem_cache_t *) kmem_cache_alloc(&cache_cache, SLAB_KERNEL);
@@ -813,8 +804,7 @@
 			kmem_cache_t *pc = list_entry(p, kmem_cache_t, next);
 
 			/* The name field is constant - no lock needed. */
-			if (!strcmp(pc->name, name))
-				BUG();
+			BUG_ON(!strcmp(pc->name, name));
 		}
 	}
 
@@ -864,8 +854,7 @@
 	func(arg);
 	local_irq_enable();
 
-	if (smp_call_function(func, arg, 1, 1))
-		BUG();
+	BUG_ON(smp_call_function(func, arg, 1, 1));
 }
 typedef struct ccupdate_struct_s
 {
@@ -932,8 +921,7 @@
 
 		slabp = list_entry(cachep->slabs_free.prev, slab_t, list);
 #if DEBUG
-		if (slabp->inuse)
-			BUG();
+		BUG_ON(slabp->inuse);
 #endif
 		list_del(&slabp->list);
 
@@ -955,8 +943,7 @@
  */
 int kmem_cache_shrink(kmem_cache_t *cachep)
 {
-	if (!cachep || in_interrupt() || !is_chained_kmem_cache(cachep))
-		BUG();
+	BUG_ON(!cachep || in_interrupt() || !is_chained_kmem_cache(cachep));
 
 	return __kmem_cache_shrink(cachep);
 }
@@ -978,8 +965,7 @@
  */
 int kmem_cache_destroy (kmem_cache_t * cachep)
 {
-	if (!cachep || in_interrupt() || cachep->growing)
-		BUG();
+	BUG_ON(!cachep || in_interrupt() || cachep->growing);
 
 	/* Find the cache in the chain of caches. */
 	down(&cache_chain_sem);
@@ -1067,11 +1053,9 @@
 			/* need to poison the objs */
 			kmem_poison_obj(cachep, objp);
 		if (cachep->flags & SLAB_RED_ZONE) {
-			if (*((unsigned long*)(objp)) != RED_MAGIC1)
-				BUG();
-			if (*((unsigned long*)(objp + cachep->objsize -
-					BYTES_PER_WORD)) != RED_MAGIC1)
-				BUG();
+			BUG_ON(*((unsigned long*)(objp)) != RED_MAGIC1);
+			BUG_ON(*((unsigned long*)(objp + cachep->objsize -
+					BYTES_PER_WORD)) != RED_MAGIC1);
 		}
 #endif
 		slab_bufctl(slabp)[i] = i+1;
@@ -1097,8 +1081,7 @@
 	/* Be lazy and only check for valid flags here,
  	 * keeping it out of the critical path in kmem_cache_alloc().
 	 */
-	if (flags & ~(SLAB_DMA|SLAB_LEVEL_MASK|SLAB_NO_GROW))
-		BUG();
+	BUG_ON(flags & ~(SLAB_DMA|SLAB_LEVEL_MASK|SLAB_NO_GROW));
 	if (flags & SLAB_NO_GROW)
 		return 0;
 
@@ -1108,8 +1091,7 @@
 	 * in kmem_cache_alloc(). If a caller is seriously mis-behaving they
 	 * will eventually be caught here (where it matters).
 	 */
-	if (in_interrupt() && (flags & SLAB_LEVEL_MASK) != SLAB_ATOMIC)
-		BUG();
+	BUG_ON(in_interrupt() && (flags & SLAB_LEVEL_MASK) != SLAB_ATOMIC);
 
 	ctor_flags = SLAB_CTOR_CONSTRUCTOR;
 	local_flags = (flags & SLAB_LEVEL_MASK);
@@ -1196,15 +1178,12 @@
 	int i;
 	unsigned int objnr = (objp-slabp->s_mem)/cachep->objsize;
 
-	if (objnr >= cachep->num)
-		BUG();
-	if (objp != slabp->s_mem + objnr*cachep->objsize)
-		BUG();
+	BUG_ON(objnr >= cachep->num);
+	BUG_ON(objp != slabp->s_mem + objnr*cachep->objsize);
 
 	/* Check slab's freelist to see if this obj is there. */
 	for (i = slabp->free; i != BUFCTL_END; i = slab_bufctl(slabp)[i]) {
-		if (i == objnr)
-			BUG();
+		BUG_ON(i == objnr);
 	}
 	return 0;
 }
@@ -1213,11 +1192,9 @@
 static inline void kmem_cache_alloc_head(kmem_cache_t *cachep, int flags)
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
 
@@ -1241,16 +1218,13 @@
 	}
 #if DEBUG
 	if (cachep->flags & SLAB_POISON)
-		if (kmem_check_poison_obj(cachep, objp))
-			BUG();
+		BUG_ON(kmem_check_poison_obj(cachep, objp));
 	if (cachep->flags & SLAB_RED_ZONE) {
 		/* Set alloc red-zone, and check old one. */
-		if (xchg((unsigned long *)objp, RED_MAGIC2) !=
-							 RED_MAGIC1)
-			BUG();
-		if (xchg((unsigned long *)(objp+cachep->objsize -
-			  BYTES_PER_WORD), RED_MAGIC2) != RED_MAGIC1)
-			BUG();
+		BUG_ON(xchg((unsigned long *)objp, RED_MAGIC2) !=
+							 RED_MAGIC1);
+		BUG_ON(xchg((unsigned long *)(objp+cachep->objsize -
+			  BYTES_PER_WORD), RED_MAGIC2) != RED_MAGIC1);
 		objp += BYTES_PER_WORD;
 	}
 #endif
@@ -1374,7 +1348,7 @@
 #if DEBUG
 # define CHECK_NR(pg)						\
 	do {							\
-		if (!VALID_PAGE(pg)) {				\
+		if (unlikely(!VALID_PAGE(pg))) {				\
 			printk(KERN_ERR "kfree: out of range ptr %lxh.\n", \
 				(unsigned long)objp);		\
 			BUG();					\
@@ -1383,7 +1357,7 @@
 # define CHECK_PAGE(page)					\
 	do {							\
 		CHECK_NR(page);					\
-		if (!PageSlab(page)) {				\
+		if (unlikely(!PageSlab(page))) {				\
 			printk(KERN_ERR "kfree: bad ptr %lxh.\n", \
 				(unsigned long)objp);		\
 			BUG();					\
@@ -1417,13 +1391,11 @@
 
 	if (cachep->flags & SLAB_RED_ZONE) {
 		objp -= BYTES_PER_WORD;
-		if (xchg((unsigned long *)objp, RED_MAGIC1) != RED_MAGIC2)
+		BUG_ON(xchg((unsigned long *)objp, RED_MAGIC1) != RED_MAGIC2);
 			/* Either write before start, or a double free. */
-			BUG();
-		if (xchg((unsigned long *)(objp+cachep->objsize -
-				BYTES_PER_WORD), RED_MAGIC1) != RED_MAGIC2)
+		BUG_ON(xchg((unsigned long *)(objp+cachep->objsize -
+				BYTES_PER_WORD), RED_MAGIC1) != RED_MAGIC2);
 			/* Either write past end, or a double free. */
-			BUG();
 	}
 	if (cachep->flags & SLAB_POISON)
 		kmem_poison_obj(cachep, objp);
@@ -1561,8 +1533,7 @@
 	unsigned long flags;
 #if DEBUG
 	CHECK_PAGE(virt_to_page(objp));
-	if (cachep != GET_PAGE_CACHE(virt_to_page(objp)))
-		BUG();
+	BUG_ON(cachep != GET_PAGE_CACHE(virt_to_page(objp)));
 #endif
 
 	local_irq_save(flags);
@@ -1760,8 +1731,7 @@
 		while (p != &searchp->slabs_free) {
 			slabp = list_entry(p, slab_t, list);
 #if DEBUG
-			if (slabp->inuse)
-				BUG();
+			BUG_ON(slabp->inuse);
 #endif
 			full_free++;
 			p = p->next;
@@ -1813,8 +1783,7 @@
 			break;
 		slabp = list_entry(p,slab_t,list);
 #if DEBUG
-		if (slabp->inuse)
-			BUG();
+		BUG_ON(slabp->inuse);
 #endif
 		list_del(&slabp->list);
 		STATS_INC_REAPED(best_cachep);
@@ -1885,22 +1854,19 @@
 		num_slabs = 0;
 		list_for_each(q,&cachep->slabs_full) {
 			slabp = list_entry(q, slab_t, list);
-			if (slabp->inuse != cachep->num)
-				BUG();
+			BUG_ON(slabp->inuse != cachep->num);
 			active_objs += cachep->num;
 			active_slabs++;
 		}
 		list_for_each(q,&cachep->slabs_partial) {
 			slabp = list_entry(q, slab_t, list);
-			if (slabp->inuse == cachep->num || !slabp->inuse)
-				BUG();
+			BUG_ON(slabp->inuse == cachep->num || !slabp->inuse);
 			active_objs += slabp->inuse;
 			active_slabs++;
 		}
 		list_for_each(q,&cachep->slabs_free) {
 			slabp = list_entry(q, slab_t, list);
-			if (slabp->inuse)
-				BUG();
+			BUG_ON(slabp->inuse);
 			num_slabs++;
 		}
 		num_slabs+=active_slabs;
Index: linux/mm//swap_state.c
===================================================================
RCS file: /home/Media/cvs/linux/mm/swap_state.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 swap_state.c
--- linux/mm//swap_state.c	11 Jan 2002 03:10:50 -0000	1.1.1.1
+++ linux/mm//swap_state.c	11 Jan 2002 04:47:22 -0000
@@ -69,8 +69,7 @@
 
 int add_to_swap_cache(struct page *page, swp_entry_t entry)
 {
-	if (page->mapping)
-		BUG();
+	BUG_ON(page->mapping);
 	if (!swap_duplicate(entry)) {
 		INC_CACHE_INFO(noent_race);
 		return -ENOENT;
@@ -81,10 +80,8 @@
 		INC_CACHE_INFO(exist_race);
 		return -EEXIST;
 	}
-	if (!PageLocked(page))
-		BUG();
-	if (!PageSwapCache(page))
-		BUG();
+	BUG_ON(!PageLocked(page));
+	BUG_ON(!PageSwapCache(page));
 	INC_CACHE_INFO(add_total);
 	return 0;
 }
@@ -95,10 +92,8 @@
  */
 void __delete_from_swap_cache(struct page *page)
 {
-	if (!PageLocked(page))
-		BUG();
-	if (!PageSwapCache(page))
-		BUG();
+	BUG_ON(!PageLocked(page));
+	BUG_ON(!PageSwapCache(page));
 	ClearPageDirty(page);
 	__remove_inode_page(page);
 	INC_CACHE_INFO(del_total);
@@ -114,8 +109,7 @@
 {
 	swp_entry_t entry;
 
-	if (!PageLocked(page))
-		BUG();
+	BUG_ON(!PageLocked(page));
 
 	block_flushpage(page, 0);
 
Index: linux/mm//swapfile.c
===================================================================
RCS file: /home/Media/cvs/linux/mm/swapfile.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 swapfile.c
--- linux/mm//swapfile.c	11 Jan 2002 03:10:50 -0000	1.1.1.1
+++ linux/mm//swapfile.c	11 Jan 2002 04:46:27 -0000
@@ -262,8 +262,7 @@
 {
 	int retval = 0;
 
-	if (!PageLocked(page))
-		BUG();
+	BUG_ON(!PageLocked(page));
 	switch (page_count(page)) {
 	case 3:
 		if (!page->buffers)
@@ -292,8 +291,7 @@
 	struct swap_info_struct * p;
 	swp_entry_t entry;
 
-	if (!PageLocked(page))
-		BUG();
+	BUG_ON(!PageLocked(page));
 	if (!PageSwapCache(page))
 		return 0;
 	if (page_count(page) - !!page->buffers != 2)	/* 2: us + cache */
@@ -428,8 +426,7 @@
 	end = address + size;
 	if (end > PGDIR_SIZE)
 		end = PGDIR_SIZE;
-	if (address >= end)
-		BUG();
+	BUG_ON(address >= end);
 	do {
 		unuse_pmd(vma, pmd, address, end - address, offset, entry,
 			  page);
@@ -444,8 +441,7 @@
 {
 	unsigned long start = vma->vm_start, end = vma->vm_end;
 
-	if (start >= end)
-		BUG();
+	BUG_ON(start >= end);
 	do {
 		unuse_pgd(vma, pgdir, start, end - start, entry, page);
 		start = (start + PGDIR_SIZE) & PGDIR_MASK;
@@ -674,8 +670,7 @@
 		 * Note shmem_unuse already deleted its from swap cache.
 		 */
 		swcount = *swap_map;
-		if ((swcount > 0) != PageSwapCache(page))
-			BUG();
+		BUG_ON((swcount > 0) != PageSwapCache(page));
 		if ((swcount > 1) && PageDirty(page)) {
 			rw_swap_page(WRITE, page);
 			lock_page(page);
Index: linux/mm//vmalloc.c
===================================================================
RCS file: /home/Media/cvs/linux/mm/vmalloc.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 vmalloc.c
--- linux/mm//vmalloc.c	11 Jan 2002 03:10:50 -0000	1.1.1.1
+++ linux/mm//vmalloc.c	11 Jan 2002 04:47:39 -0000
@@ -230,7 +230,7 @@
 	struct vm_struct *area;
 
 	size = PAGE_ALIGN(size);
-	if (!size || (size >> PAGE_SHIFT) > num_physpages) {
+	if (unlikely(!size || (size >> PAGE_SHIFT) > num_physpages)) {
 		BUG();
 		return NULL;
 	}
Index: linux/mm//vmscan.c
===================================================================
RCS file: /home/Media/cvs/linux/mm/vmscan.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 vmscan.c
--- linux/mm//vmscan.c	11 Jan 2002 03:10:50 -0000	1.1.1.1
+++ linux/mm//vmscan.c	11 Jan 2002 04:48:41 -0000
@@ -235,8 +235,7 @@
 	pgdir = pgd_offset(mm, address);
 
 	end = vma->vm_end;
-	if (address >= end)
-		BUG();
+	BUG_ON(address >= end);
 	do {
 		count = swap_out_pgd(mm, vma, pgdir, address, end, count, classzone);
 		if (!count)
@@ -355,10 +354,8 @@
 
 		page = list_entry(entry, struct page, lru);
 
-		if (unlikely(!PageLRU(page)))
-			BUG();
-		if (unlikely(PageActive(page)))
-			BUG();
+		BUG_ON(!PageLRU(page));
+		BUG_ON(PageActive(page));
 
 		list_del(entry);
 		list_add(entry, &inactive_list);
