Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266271AbUJAT6S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266271AbUJAT6S (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Oct 2004 15:58:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266296AbUJAT6S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Oct 2004 15:58:18 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:42687 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266271AbUJATyE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Oct 2004 15:54:04 -0400
Date: Fri, 1 Oct 2004 15:22:21 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: linux-mm@kvack.org
Cc: akpm@osdl.org, Nick Piggin <piggin@cyberone.com.au>, arjanv@redhat.com,
       linux-kernel@vger.kernel.org
Subject: [RFC] memory defragmentation to satisfy high order allocations
Message-ID: <20041001182221.GA3191@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi fellows,

So I've been playing with memory defragmentation for the last couple
of weeks.

The following patch implements a "coalesce_memory()" function 
which takes "zone" and "order" as a parameter. 

It tries to move enough physically nearby pages to form a free area
of "order" size.

It does that by checking whether the page can be moved, allocating a new page, 
unmapping the pte's to it, copying data to new page, remapping the ptes, 
and reinserting the page on the radix/LRU.

Its very uncomplete yet - for one SMP concurrent radix lookups will screw file
page unmapping (swapcache lookup should be safe), and lots of other buggies inside. 
For example it doesnt re establishes pte's once it has unmapped them.

I'm working on those.

But it works fine on UP (for a few minutes :)), and easily creates large 
physically contiguous areas of memory.

With such a thing in place we can build a mechanism for kswapd 
(or a separate kernel thread, if needed) to notice when we are low on 
high order pages, and use the coalescing algorithm instead blindly 
freeing unique pages from LRU in the hope to build large physically 
contiguous memory areas.

Comments appreciated.

Lots of this has been copied from rmap.c/etc.

Yes, the code needs to be cleanup up.

--- page_alloc.c.orig	2004-09-19 16:53:52.000000000 -0300
+++ page_alloc.c	2004-10-01 16:26:21.602387344 -0300
@@ -33,6 +33,8 @@
 #include <linux/cpu.h>
 #include <linux/cpuset.h>
 #include <linux/nodemask.h>
+#include <linux/rmap.h>
+#include <linux/mm_inline.h>
 
 #include <asm/tlbflush.h>
 
@@ -97,7 +99,471 @@
 	page->mapping = NULL;
 }
 
-#ifndef CONFIG_HUGETLB_PAGE
+#define REMAP_FAIL 0
+#define REMAP_SUCCESS 1
+
+
+void page_remove_rmap(struct page *page);
+void page_add_anon_rmap(struct page *page,
+        struct vm_area_struct *vma, unsigned long address);
+struct anon_vma *page_lock_anon_vma(struct page *page);
+inline unsigned long avma_address(struct page *page, struct vm_area_struct *vma);
+
+inline unsigned long
+avma_address(struct page *page, struct vm_area_struct *vma)
+{
+        pgoff_t pgoff = page->index << (PAGE_CACHE_SHIFT - PAGE_SHIFT);
+        unsigned long address;
+
+        address = vma->vm_start + ((pgoff - vma->vm_pgoff) << PAGE_SHIFT);
+
+        if (unlikely(address < vma->vm_start || address >= vma->vm_end)) {
+                /* page should be within any vma from prio_tree_next */
+		printk(KERN_ERR "address: %x pgoff:%x vma->start:%x vma->end:%x\n",
+				address, pgoff,vma->vm_start, vma->vm_end );
+                BUG_ON(!PageAnon(page));
+                return -EFAULT;
+        }
+        return address;
+}
+
+
+
+int try_to_remap_file(struct page *page, struct page *newpage, struct vm_area_struct *vma)
+{
+	unsigned long address;
+	struct mm_struct *mm = vma->vm_mm;	
+	pgd_t *pgd;
+        pmd_t *pmd;
+        pte_t *pte;
+        pte_t pteval;
+	int ret;
+
+	printk(KERN_ERR "try_to_remap_file!\n");
+
+	if (!mm->rss) 
+		return REMAP_FAIL;
+
+	address = avma_address(page, vma);
+
+
+	pgd = pgd_offset(mm, address);
+	if (!pgd_present(*pgd))
+		goto out_unlock;
+
+	pmd = pmd_offset(pgd, address);
+	if (!pmd_present(*pmd))
+		goto out_unlock;
+
+
+        pte = pte_offset_map(pmd, address);
+        if (!pte_present(*pte))
+                goto out_unlock;
+
+        if (page_to_pfn(page) != pte_pfn(*pte))
+		goto out_unlock;
+	
+	if ((vma->vm_flags & (VM_LOCKED|VM_RESERVED))) 
+		goto out_unlock;
+
+	/* Nuke the pte */
+
+        flush_cache_page(vma, address);
+
+       pteval = ptep_clear_flush(vma, address, pte);
+
+	page_remove_rmap(page);
+
+	/* transfer the dirty bit to the new page */
+	if (pte_dirty(pteval))
+		set_page_dirty(newpage);
+
+	pteval = mk_pte(newpage, vma->vm_page_prot);
+
+	set_pte(pte, pteval);
+
+	page_add_file_rmap(newpage);
+
+	return REMAP_SUCCESS;
+
+out_unlock:
+	return REMAP_FAIL;
+}
+
+
+
+
+int try_to_remap_anon(struct page *page, struct page *newpage, struct vm_area_struct *vma)
+{
+	unsigned long address;
+	struct mm_struct *mm = vma->vm_mm;	
+	pgd_t *pgd;
+        pmd_t *pmd;
+        pte_t *pte;
+        pte_t pteval;
+	int ret;
+
+
+	if (!vma)
+		printk(KERN_ERR "!vma\n");
+
+	spin_lock(&mm->page_table_lock);
+
+	address = avma_address(page, vma);
+
+	if (address == -EFAULT) 
+		return REMAP_FAIL;
+
+	if (!mm) 
+		return REMAP_FAIL;
+
+	if (!mm->rss) 
+		return REMAP_FAIL;
+
+	pgd = pgd_offset(mm, address);
+	if (!pgd_present(*pgd)) 
+		goto out_unlock;
+
+	pmd = pmd_offset(pgd, address);
+	if (!pmd_present(*pmd))
+		goto out_unlock;
+
+        pte = pte_offset_map(pmd, address);
+        if (!pte_present(*pte))
+                goto out_unlock;
+
+        if (page_to_pfn(page) != pte_pfn(*pte))
+		goto out_unlock;
+	
+	if ((vma->vm_flags & (VM_LOCKED|VM_RESERVED)))
+		ret = REMAP_FAIL;
+
+	/* Nuke the pte */
+
+        flush_cache_page(vma, address);
+        pteval = ptep_clear_flush(vma, address, pte);
+
+	page_remove_rmap(page);
+
+	/* transfer the dirty bit to the new page */
+	if (pte_dirty(pteval))
+		set_page_dirty(newpage);
+
+	pteval = mk_pte(newpage, vma->vm_page_prot);
+
+	set_pte(pte, pteval);
+
+	page_add_anon_rmap(newpage, vma, address);
+
+	spin_unlock(&mm->page_table_lock);
+
+	return REMAP_SUCCESS;
+
+out_unlock:
+	spin_unlock(&mm->page_table_lock);
+	return REMAP_FAIL;
+
+}
+
+/* Move LRU pages to other locations, undo the remapping operation 
+* if any of the mapped pte's fails to be remapped.
+* 
+*/
+
+int can_move_page(struct page *page) 
+{
+	int ret;
+	int ptes_unmapped = 0;
+	struct page *newpage;
+
+	if (PageLocked(page))
+		return 0;
+
+	if (PageReserved(page))
+		return 0;
+
+	if (PageWriteback(page))
+		return 0;
+
+	if (page_count(page) == 0)
+		return 1;
+
+	if (PageLRU(page)) {
+		if (PageAnon(page) && page_count(page) == 1 + PageSwapCache(page)) {
+			struct anon_vma *anon_vma;
+			struct vm_area_struct *vma;
+			unsigned long anon_mapping = (unsigned long) page->mapping;
+			unsigned long savedindex;
+			int error;
+			
+			newpage = alloc_pages(GFP_HIGHUSER, 0);
+
+			if (PageSwapCache(page) &&
+				page_count(page) != page_mapcount(page) + 1) {
+					free_page(newpage);
+					goto out;
+			}
+
+			if (!PageAnon(page) || anon_mapping != page->mapping) {
+				free_page (newpage);
+				goto out;
+			}
+
+			page_cache_get(page);
+
+			if (TestSetPageLocked(page)) {
+				free_page(newpage);
+				page_cache_release(page);
+				goto out;
+			}
+
+			if (PageSwapCache(page)) { 
+				write_lock_irq(&swapper_space.tree_lock);
+				/* recheck under swapper address space tree lock */
+				if (!PageSwapCache(page) || page_count(page) != 3) {
+					write_unlock_irq(&swapper_space.tree_lock);
+					free_page(newpage);
+					unlock_page(page);
+					page_cache_release(page);
+				}
+				radix_tree_delete(&swapper_space.page_tree, page->private);
+				savedindex = page->private;
+			}
+
+			anon_vma = page_lock_anon_vma(page);
+
+			if (!anon_vma)  {
+				free_page(newpage);
+				page_cache_release(page);
+				goto out;
+			}
+			
+			list_for_each_entry(vma, &anon_vma->head, anon_vma_node) {
+				ret = try_to_remap_anon(page, newpage, vma);
+				if (ret == REMAP_FAIL) {
+					if (PageSwapCache(page))
+						write_unlock_irq(&swapper_space
+							.tree_lock);
+					spin_unlock(&anon_vma->lock);
+					free_page(newpage);
+					unlock_page(page);
+					page_cache_release(page);
+					goto redo_unmaps;
+				}
+				ptes_unmapped++;
+			}
+
+			copy_highpage(newpage, page);
+
+			unlock_page(page);
+
+			page_cache_release(page);
+			page_cache_release(page);
+
+			newpage->private = savedindex;
+	
+			if (PageSwapCache(page)) {
+				error = radix_tree_insert(&swapper_space.page_tree,
+                   						savedindex, newpage);
+
+				//if (error) 
+			}
+
+			
+			spin_unlock(&anon_vma->lock);
+			write_unlock_irq(&swapper_space.tree_lock);
+
+			return 1;
+
+		} else if (!PageAnon(page) && 
+				page_count(page) == 1) {
+			struct vm_area_struct *vma;
+			struct prio_tree_iter iter;
+			struct zone *zone = page_zone(page);
+			struct address_space *mapping = page->mapping;
+			struct page *testpage;
+			int mapped;
+			pgoff_t pgoff = page->index << (PAGE_CACHE_SHIFT - 
+					PAGE_SHIFT);
+			pgoff_t savedindex = page->index;
+
+			if (!mapping)
+				goto out;
+
+			if (!list_empty(&mapping->i_mmap_nonlinear)) {
+				spin_unlock(&mapping->i_mmap_lock);
+				goto out;
+			}
+
+			if (PagePrivate(page))
+				printk(KERN_ERR "PagePrivate!\n");
+			if (PageWriteback(page)) {
+				printk(KERN_ERR "PageWriteback! quitting\n");
+				goto out;
+			}
+
+			newpage = alloc_pages(GFP_HIGHUSER, 0);
+
+			if (page_count(page) != 1 ||
+			  !PageLRU(page) || PageAnon(page) ||
+			  page->mapping != mapping ||
+			  page->index != savedindex) {
+				free_page(newpage);
+				goto out;
+			}
+
+			page_cache_get(page);
+
+			if (TestSetPageLocked(page)) {
+				page_cache_release(page);
+				printk(KERN_ERR "page locked!!!\n");
+				goto out;
+			}
+
+			// remove radix entry and block page faults for SMP systems
+
+		        spin_lock(&mapping->i_mmap_lock);
+
+			mapped = page_mapcount(page);
+
+			vma_prio_tree_foreach(vma, &iter, &mapping->i_mmap, 
+				pgoff, pgoff) 
+			{
+				ret = try_to_remap_file(page, newpage, vma);
+				if (ret == REMAP_FAIL) {
+					unlock_page(page);
+					goto redo_unmaps;
+				}
+				ptes_unmapped++;
+				mapped--;
+				if (!mapped)
+					break;
+					
+			}
+
+			if (TestClearPageLRU(page))
+				del_page_from_lru(zone, page);
+			
+			remove_from_page_cache(page);
+
+			copy_highpage(newpage, page);
+
+			newpage->flags = page->flags;
+
+			unlock_page(page);
+
+			add_to_page_cache_lru(newpage, mapping, savedindex, 
+				GFP_KERNEL);
+
+			page_cache_release(page);
+			page_cache_release(page);
+
+			unlock_page(newpage);
+
+		        spin_unlock(&mapping->i_mmap_lock);
+			return 1;
+		}
+
+	}
+
+
+out:
+	preempt_enable();
+	return 0;
+
+redo_unmaps:
+	free_page(newpage);
+	printk(KERN_ERR "unmap PTE failed!@#$^5! ptes_unmapped:%d\n", ptes_unmapped);
+	return 0;
+}
+
+#define MAX_ORDER_DEC	3	/* maximum order decrease */
+
+int coalesce_memory(unsigned int order, struct zone *zone)
+{
+	unsigned int torder;
+	unsigned int nr_freed_pages = 0, nr_pages = 0;
+	
+	if (order < 1) {
+		printk(KERN_ERR "order <= 2");
+		return -1;
+	}
+
+	preempt_disable();
+
+	for (torder = order - 1; torder > order - MAX_ORDER_DEC; torder--) {
+		struct list_head *entry;
+		struct page *pwalk, *page;
+		int walkcount = 0;
+		struct free_area *area = zone->free_area + torder;
+		nr_pages = (1UL << order) - (1UL << torder); 
+
+		entry = area->free_list.next;
+
+		while (entry != &area->free_list) {
+			int ret;
+			page = list_entry(entry, struct page, lru);
+			entry = entry->next;
+
+			pwalk = page;
+
+			/* Look backwards */
+
+			for (walkcount = 1; walkcount<nr_pages; walkcount++) {
+				pwalk = page-walkcount;
+
+				ret = can_move_page(pwalk);
+				if (ret)
+					nr_freed_pages++;
+				else
+					goto forward;
+
+				if (nr_freed_pages == nr_pages)
+					goto success;
+					
+			}
+
+forward:
+
+			pwalk = page;
+
+			/* Look forward, skipping the page frames from this 
+			  high order page we are looking at */
+
+			for (walkcount = (1UL << torder); walkcount<nr_pages; 
+					walkcount++) {
+				pwalk = page+walkcount;
+
+				ret = can_move_page(pwalk);
+
+				if (ret) 
+					nr_freed_pages++;
+				else
+					goto loopey;
+
+				if (nr_freed_pages == nr_pages)
+					goto success;
+			}
+
+loopey:
+	
+//			goto bailout;
+		}
+	}
+
+bailout:
+	preempt_enable();
+	printk(KERN_ERR "failure nr_pages:%d nr_freed_pages:%d!\n", nr_pages,
+nr_freed_pages);
+return 0;
+
+success:
+printk(KERN_ERR "SUCCESS coalesced %d pages!\n", nr_freed_pages);
+return 1;
+	
+}
+
+#ifndef CONFIG_HUGETL _PAGE
 #define prep_compound_page(page, order) do { } while (0)
 #define destroy_compound_page(page, order) do { } while (0)
 #else

