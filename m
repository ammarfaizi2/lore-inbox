Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261628AbVGZI4n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261628AbVGZI4n (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 04:56:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261651AbVGZI4n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 04:56:43 -0400
Received: from smtp209.mail.sc5.yahoo.com ([216.136.130.117]:28303 "HELO
	smtp209.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261628AbVGZI4k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 04:56:40 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type;
  b=LinjdqWt4iw36F/z9rgH+k+6IUtSboyU3eGUprWAdJuvzuq6MH5I72oljnSqa6Zcj+qAWdiR2Y+804C9XsLwoLnQ0DaV4ar1hm3/Ji+XXMgrkINTTWUUV8Swnqpbu5Gwr4aur8NywinT2cB2aX0cKn/IGyhENBXEBiN/KxnDijk=  ;
Message-ID: <42E5FABA.50407@yahoo.com.au>
Date: Tue, 26 Jul 2005 18:56:26 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050324 Debian/1.7.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Hugh Dickins <hugh@veritas.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: [patch 6/6] mm: core remove PageReserved (take 2)
References: <42E5F139.70002@yahoo.com.au> <42E5F173.3010409@yahoo.com.au> <42E5F19A.6050407@yahoo.com.au> <42E5F1BF.7060604@yahoo.com.au> <42E5F21B.8090900@yahoo.com.au> <42E5F238.4020302@yahoo.com.au> <42E5F254.9000309@yahoo.com.au>
In-Reply-To: <42E5F254.9000309@yahoo.com.au>
Content-Type: multipart/mixed;
 boundary="------------080405030104040704000508"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080405030104040704000508
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Nick Piggin wrote:
> 6/6
> 

Actually I think Hugh gave me some feedback about the introduced
`print_invalid_pfn` function, which I ignored.

So here is patch 6 again, with print_invalid_pfn renamed invalid_pfn,
and using a macro to alleviate the requirement of passing in the
function name by hand.


--------------080405030104040704000508
Content-Type: text/plain;
 name="mm-core-remove-PageReserved.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mm-core-remove-PageReserved.patch"

Remove PageReserved() calls from core code by tightening VM_RESERVED
handling in mm/ to cover PageReserved functionality.

PageReserved special casing is removed from get_page and put_page.

All setting and clearning of PageReserved is retained, and it is now
flagged in the page_alloc checks to help ensure we don't introduce
any refcount based freeing of Reserved pages.

MAP_PRIVATE, PROT_WRITE of VM_RESERVED regions is tentatively being
deprecated. We never completely handled it correctly anyway, and is
difficult to handle nicely - difficult but not impossible, it could
be reintroduced in future if required (Hugh has a proof of concept).

Once PageReserved() calls are removed from kernel/power/swsusp.c, and
all arch/ and driver code, the Set and Clear calls, and the PG_reserved
bit can be trivially removed.

Last real user of PageReserved is swsusp, which uses PageReserved to
determine whether a struct page points to valid memory or not. This
still needs to be addressed.

Many thanks to Hugh Dickins for input.

Signed-off-by: Nick Piggin <npiggin@suse.de>


Index: linux-2.6/include/linux/mm.h
===================================================================
--- linux-2.6.orig/include/linux/mm.h
+++ linux-2.6/include/linux/mm.h
@@ -156,7 +156,8 @@ extern unsigned int kobjsize(const void 
 
 #define VM_DONTCOPY	0x00020000      /* Do not copy this vma on fork */
 #define VM_DONTEXPAND	0x00040000	/* Cannot expand with mremap() */
-#define VM_RESERVED	0x00080000	/* Don't unmap it from swap_out */
+#define VM_RESERVED	0x00080000	/* Pages and ptes in region aren't managed with regular pagecache or rmap routines */
+
 #define VM_ACCOUNT	0x00100000	/* Is a VM accounted object */
 #define VM_HUGETLB	0x00400000	/* Huge TLB Page VM */
 #define VM_NONLINEAR	0x00800000	/* Is non-linear (remap_file_pages) */
@@ -337,7 +338,7 @@ static inline void get_page(struct page 
 
 static inline void put_page(struct page *page)
 {
-	if (!PageReserved(page) && put_page_testzero(page))
+	if (put_page_testzero(page))
 		__page_cache_release(page);
 }
 
@@ -711,6 +712,9 @@ void install_arg_page(struct vm_area_str
 
 int get_user_pages(struct task_struct *tsk, struct mm_struct *mm, unsigned long start,
 		int len, int write, int force, struct page **pages, struct vm_area_struct **vmas);
+#define invalid_pfn(pte, vm_flags, vaddr)		\
+		__invalid_pfn(__FUNCTION__, pte, vm_flags, vaddr)
+void __invalid_pfn(const char *, pte_t, unsigned long, unsigned long);
 
 int __set_page_dirty_buffers(struct page *page);
 int __set_page_dirty_nobuffers(struct page *page);
Index: linux-2.6/mm/madvise.c
===================================================================
--- linux-2.6.orig/mm/madvise.c
+++ linux-2.6/mm/madvise.c
@@ -126,7 +126,7 @@ static long madvise_dontneed(struct vm_a
 			     unsigned long start, unsigned long end)
 {
 	*prev = vma;
-	if ((vma->vm_flags & VM_LOCKED) || is_vm_hugetlb_page(vma))
+	if ((vma->vm_flags & (VM_LOCKED|VM_RESERVED)) || is_vm_hugetlb_page(vma))
 		return -EINVAL;
 
 	if (unlikely(vma->vm_flags & VM_NONLINEAR)) {
Index: linux-2.6/mm/memory.c
===================================================================
--- linux-2.6.orig/mm/memory.c
+++ linux-2.6/mm/memory.c
@@ -333,6 +333,21 @@ out:
 }
 
 /*
+ * This function is called to print an error when a pte in a
+ * !VM_RESERVED region is found pointing to an invalid pfn (which
+ * is an error.
+ *
+ * The calling function must still handle the error.
+ */
+void __invalid_pfn(const char *errfunc, pte_t pte,
+				unsigned long vm_flags, unsigned long vaddr)
+{
+	printk(KERN_ERR "%s: pte does not point to valid memory. "
+		"process = %s, pte = %08lx, vm_flags = %lx, vaddr = %lx\n",
+		errfunc, current->comm, (long)pte_val(pte), vm_flags, vaddr);
+}
+
+/*
  * copy one vm_area from one task to the other. Assumes the page tables
  * already present in the new task to be cleared in the whole range
  * covered by this vma.
@@ -361,25 +376,29 @@ copy_one_pte(struct mm_struct *dst_mm, s
 				spin_unlock(&mmlist_lock);
 			}
 		}
-		set_pte_at(dst_mm, addr, dst_pte, pte);
-		return;
+		goto out_set_pte;
 	}
 
+	/* If the region is VM_RESERVED, the mapping is not
+	 * mapped via rmap - duplicate the pte as is.
+	 */
+	if (vm_flags & VM_RESERVED)
+		goto out_set_pte;
+
+	/* If the pte points outside of valid memory but
+	 * the region is not VM_RESERVED, we have a problem.
+	 */
 	pfn = pte_pfn(pte);
-	/* the pte points outside of valid memory, the
-	 * mapping is assumed to be good, meaningful
-	 * and not mapped via rmap - duplicate the
-	 * mapping as is.
-	 */
-	page = NULL;
-	if (pfn_valid(pfn))
-		page = pfn_to_page(pfn);
-
-	if (!page || PageReserved(page)) {
-		set_pte_at(dst_mm, addr, dst_pte, pte);
-		return;
+	if (unlikely(!pfn_valid(pfn))) {
+		invalid_pfn(pte, vm_flags, addr);
+		goto out_set_pte; /* try to do something sane */
 	}
 
+	page = pfn_to_page(pfn);
+	/* Mappings to zero pages aren't covered by rmap either. */
+	if (page == ZERO_PAGE(addr))
+		goto out_set_pte;
+
 	/*
 	 * If it's a COW mapping, write protect it both
 	 * in the parent and the child
@@ -400,8 +419,9 @@ copy_one_pte(struct mm_struct *dst_mm, s
 	inc_mm_counter(dst_mm, rss);
 	if (PageAnon(page))
 		inc_mm_counter(dst_mm, anon_rss);
-	set_pte_at(dst_mm, addr, dst_pte, pte);
 	page_dup_rmap(page);
+out_set_pte:
+	set_pte_at(dst_mm, addr, dst_pte, pte);
 }
 
 static int copy_pte_range(struct mm_struct *dst_mm, struct mm_struct *src_mm,
@@ -514,7 +534,8 @@ int copy_page_range(struct mm_struct *ds
 	return 0;
 }
 
-static void zap_pte_range(struct mmu_gather *tlb, pmd_t *pmd,
+static void zap_pte_range(struct mmu_gather *tlb,
+				struct vm_area_struct *vma, pmd_t *pmd,
 				unsigned long addr, unsigned long end,
 				struct zap_details *details)
 {
@@ -528,10 +549,14 @@ static void zap_pte_range(struct mmu_gat
 		if (pte_present(ptent)) {
 			struct page *page = NULL;
 			unsigned long pfn = pte_pfn(ptent);
-			if (pfn_valid(pfn)) {
-				page = pfn_to_page(pfn);
-				if (PageReserved(page))
-					page = NULL;
+			if (!(vma->vm_flags & VM_RESERVED)) {
+				if (unlikely(!pfn_valid(pfn))) {
+					invalid_pfn(ptent, vma->vm_flags, addr);
+				} else {
+					page = pfn_to_page(pfn);
+					if (page == ZERO_PAGE(addr))
+						page = NULL;
+				}
 			}
 			if (unlikely(details) && page) {
 				/*
@@ -584,7 +609,8 @@ static void zap_pte_range(struct mmu_gat
 	pte_unmap(pte - 1);
 }
 
-static inline void zap_pmd_range(struct mmu_gather *tlb, pud_t *pud,
+static inline void zap_pmd_range(struct mmu_gather *tlb,
+				struct vm_area_struct *vma, pud_t *pud,
 				unsigned long addr, unsigned long end,
 				struct zap_details *details)
 {
@@ -596,11 +622,12 @@ static inline void zap_pmd_range(struct 
 		next = pmd_addr_end(addr, end);
 		if (pmd_none_or_clear_bad(pmd))
 			continue;
-		zap_pte_range(tlb, pmd, addr, next, details);
+		zap_pte_range(tlb, vma, pmd, addr, next, details);
 	} while (pmd++, addr = next, addr != end);
 }
 
-static inline void zap_pud_range(struct mmu_gather *tlb, pgd_t *pgd,
+static inline void zap_pud_range(struct mmu_gather *tlb,
+				struct vm_area_struct *vma, pgd_t *pgd,
 				unsigned long addr, unsigned long end,
 				struct zap_details *details)
 {
@@ -612,7 +639,7 @@ static inline void zap_pud_range(struct 
 		next = pud_addr_end(addr, end);
 		if (pud_none_or_clear_bad(pud))
 			continue;
-		zap_pmd_range(tlb, pud, addr, next, details);
+		zap_pmd_range(tlb, vma, pud, addr, next, details);
 	} while (pud++, addr = next, addr != end);
 }
 
@@ -633,7 +660,7 @@ static void unmap_page_range(struct mmu_
 		next = pgd_addr_end(addr, end);
 		if (pgd_none_or_clear_bad(pgd))
 			continue;
-		zap_pud_range(tlb, pgd, addr, next, details);
+		zap_pud_range(tlb, vma, pgd, addr, next, details);
 	} while (pgd++, addr = next, addr != end);
 	tlb_end_vma(tlb, vma);
 }
@@ -924,7 +951,7 @@ int get_user_pages(struct task_struct *t
 			continue;
 		}
 
-		if (!vma || (vma->vm_flags & VM_IO)
+		if (!vma || (vma->vm_flags & (VM_IO | VM_RESERVED))
 				|| !(flags & vma->vm_flags))
 			return i ? : -EFAULT;
 
@@ -980,8 +1007,7 @@ int get_user_pages(struct task_struct *t
 			if (pages) {
 				pages[i] = page;
 				flush_dcache_page(page);
-				if (!PageReserved(page))
-					page_cache_get(page);
+				page_cache_get(page);
 			}
 			if (vmas)
 				vmas[i] = vma;
@@ -1085,8 +1111,7 @@ static int remap_pte_range(struct mm_str
 		return -ENOMEM;
 	do {
 		BUG_ON(!pte_none(*pte));
-		if (!pfn_valid(pfn) || PageReserved(pfn_to_page(pfn)))
-			set_pte_at(mm, addr, pte, pfn_pte(pfn, prot));
+		set_pte_at(mm, addr, pte, pfn_pte(pfn, prot));
 		pfn++;
 	} while (pte++, addr += PAGE_SIZE, addr != end);
 	pte_unmap(pte - 1);
@@ -1225,6 +1250,8 @@ static int do_wp_page(struct mm_struct *
 	unsigned long pfn = pte_pfn(pte);
 	pte_t entry;
 
+	BUG_ON(vma->vm_flags & VM_RESERVED);
+
 	if (unlikely(!pfn_valid(pfn))) {
 		/*
 		 * This should really halt the system so it can be debugged or
@@ -1232,9 +1259,8 @@ static int do_wp_page(struct mm_struct *
 		 * data, but for the moment just pretend this is OOM.
 		 */
 		pte_unmap(page_table);
-		printk(KERN_ERR "do_wp_page: bogus page at address %08lx\n",
-				address);
 		spin_unlock(&mm->page_table_lock);
+		invalid_pfn(pte, vma->vm_flags, address);
 		return VM_FAULT_OOM;
 	}
 	old_page = pfn_to_page(pfn);
@@ -1259,13 +1285,16 @@ static int do_wp_page(struct mm_struct *
 	/*
 	 * Ok, we need to copy. Oh, well..
 	 */
-	if (!PageReserved(old_page))
+	if (old_page == ZERO_PAGE(address))
+		old_page = NULL;
+	else
 		page_cache_get(old_page);
+
 	spin_unlock(&mm->page_table_lock);
 
 	if (unlikely(anon_vma_prepare(vma)))
 		goto no_new_page;
-	if (old_page == ZERO_PAGE(address)) {
+	if (old_page == NULL) {
 		new_page = alloc_zeroed_user_highpage(vma, address);
 		if (!new_page)
 			goto no_new_page;
@@ -1281,12 +1310,13 @@ static int do_wp_page(struct mm_struct *
 	spin_lock(&mm->page_table_lock);
 	page_table = pte_offset_map(pmd, address);
 	if (likely(pte_same(*page_table, pte))) {
-		if (PageAnon(old_page))
-			dec_mm_counter(mm, anon_rss);
-		if (PageReserved(old_page))
+		if (old_page == NULL)
 			inc_mm_counter(mm, rss);
-		else
+		else {
 			page_remove_rmap(old_page);
+			if (PageAnon(old_page))
+				dec_mm_counter(mm, anon_rss);
+		}
 		flush_cache_page(vma, address, pfn);
 		break_cow(vma, new_page, address, page_table);
 		lru_cache_add_active(new_page);
@@ -1296,13 +1326,16 @@ static int do_wp_page(struct mm_struct *
 		new_page = old_page;
 	}
 	pte_unmap(page_table);
-	page_cache_release(new_page);
-	page_cache_release(old_page);
 	spin_unlock(&mm->page_table_lock);
+	if (old_page) {
+		page_cache_release(new_page);
+		page_cache_release(old_page);
+	}
 	return VM_FAULT_MINOR;
 
 no_new_page:
-	page_cache_release(old_page);
+	if (old_page)
+		page_cache_release(old_page);
 	return VM_FAULT_OOM;
 }
 
@@ -1739,7 +1772,7 @@ do_anonymous_page(struct mm_struct *mm, 
 	struct page * page = ZERO_PAGE(addr);
 
 	/* Read-only mapping of ZERO_PAGE. */
-	entry = pte_wrprotect(mk_pte(ZERO_PAGE(addr), vma->vm_page_prot));
+	entry = pte_wrprotect(mk_pte(page, vma->vm_page_prot));
 
 	/* ..except if it's a write access */
 	if (write_access) {
@@ -1878,9 +1911,6 @@ retry:
 	 */
 	/* Only go through if we didn't race with anybody else... */
 	if (pte_none(*page_table)) {
-		if (!PageReserved(new_page))
-			inc_mm_counter(mm, rss);
-
 		flush_icache_page(vma, new_page);
 		entry = mk_pte(new_page, vma->vm_page_prot);
 		if (write_access)
@@ -1889,8 +1919,10 @@ retry:
 		if (anon) {
 			lru_cache_add_active(new_page);
 			page_add_anon_rmap(new_page, vma, address);
-		} else
+		} else if (!(vma->vm_flags & VM_RESERVED)) {
 			page_add_file_rmap(new_page);
+			inc_mm_counter(mm, rss);
+		}
 		pte_unmap(page_table);
 	} else {
 		/* One of our sibling threads was faster, back out. */
Index: linux-2.6/mm/page_alloc.c
===================================================================
--- linux-2.6.orig/mm/page_alloc.c
+++ linux-2.6/mm/page_alloc.c
@@ -113,7 +113,8 @@ static void bad_page(const char *functio
 			1 << PG_reclaim |
 			1 << PG_slab    |
 			1 << PG_swapcache |
-			1 << PG_writeback);
+			1 << PG_writeback |
+			1 << PG_reserved );
 	set_page_count(page, 0);
 	reset_page_mapcount(page);
 	page->mapping = NULL;
@@ -243,7 +244,6 @@ static inline int page_is_buddy(struct p
 {
        if (PagePrivate(page)           &&
            (page_order(page) == order) &&
-           !PageReserved(page)         &&
             page_count(page) == 0)
                return 1;
        return 0;
@@ -326,7 +326,8 @@ static inline void free_pages_check(cons
 			1 << PG_reclaim	|
 			1 << PG_slab	|
 			1 << PG_swapcache |
-			1 << PG_writeback )))
+			1 << PG_writeback |
+			1 << PG_reserved )))
 		bad_page(function, page);
 	if (PageDirty(page))
 		__ClearPageDirty(page);
@@ -454,7 +455,8 @@ static void prep_new_page(struct page *p
 			1 << PG_reclaim	|
 			1 << PG_slab    |
 			1 << PG_swapcache |
-			1 << PG_writeback )))
+			1 << PG_writeback |
+			1 << PG_reserved )))
 		bad_page(__FUNCTION__, page);
 
 	page->flags &= ~(1 << PG_uptodate | 1 << PG_error |
@@ -1011,7 +1013,7 @@ void __pagevec_free(struct pagevec *pvec
 
 fastcall void __free_pages(struct page *page, unsigned int order)
 {
-	if (!PageReserved(page) && put_page_testzero(page)) {
+	if (put_page_testzero(page)) {
 		if (order == 0)
 			free_hot_page(page);
 		else
@@ -1654,7 +1656,7 @@ void __init memmap_init_zone(unsigned lo
 			continue;
 		page = pfn_to_page(pfn);
 		set_page_links(page, zone, nid, pfn);
-		set_page_count(page, 0);
+		set_page_count(page, 1);
 		reset_page_mapcount(page);
 		SetPageReserved(page);
 		INIT_LIST_HEAD(&page->lru);
Index: linux-2.6/mm/swap.c
===================================================================
--- linux-2.6.orig/mm/swap.c
+++ linux-2.6/mm/swap.c
@@ -48,7 +48,7 @@ void put_page(struct page *page)
 		}
 		return;
 	}
-	if (!PageReserved(page) && put_page_testzero(page))
+	if (put_page_testzero(page))
 		__page_cache_release(page);
 }
 EXPORT_SYMBOL(put_page);
@@ -215,7 +215,7 @@ void release_pages(struct page **pages, 
 		struct page *page = pages[i];
 		struct zone *pagezone;
 
-		if (PageReserved(page) || !put_page_testzero(page))
+		if (!put_page_testzero(page))
 			continue;
 
 		pagezone = page_zone(page);
Index: linux-2.6/mm/fremap.c
===================================================================
--- linux-2.6.orig/mm/fremap.c
+++ linux-2.6/mm/fremap.c
@@ -29,18 +29,21 @@ static inline void zap_pte(struct mm_str
 		return;
 	if (pte_present(pte)) {
 		unsigned long pfn = pte_pfn(pte);
+		struct page *page;
 
 		flush_cache_page(vma, addr, pfn);
 		pte = ptep_clear_flush(vma, addr, ptep);
-		if (pfn_valid(pfn)) {
-			struct page *page = pfn_to_page(pfn);
-			if (!PageReserved(page)) {
-				if (pte_dirty(pte))
-					set_page_dirty(page);
-				page_remove_rmap(page);
-				page_cache_release(page);
-				dec_mm_counter(mm, rss);
-			}
+		if (unlikely(!pfn_valid(pfn))) {
+			invalid_pfn(pte, vma->vm_flags, addr);
+			return;
+		}
+		page = pfn_to_page(pfn);
+		if (page != ZERO_PAGE(addr)) {
+			if (pte_dirty(pte))
+				set_page_dirty(page);
+			page_remove_rmap(page);
+			dec_mm_counter(mm, rss);
+			page_cache_release(page);
 		}
 	} else {
 		if (!pte_file(pte))
@@ -65,6 +68,8 @@ int install_page(struct mm_struct *mm, s
 	pgd_t *pgd;
 	pte_t pte_val;
 
+	BUG_ON(vma->vm_flags & VM_RESERVED);
+
 	pgd = pgd_offset(mm, addr);
 	spin_lock(&mm->page_table_lock);
 	
@@ -122,6 +127,8 @@ int install_file_pte(struct mm_struct *m
 	pgd_t *pgd;
 	pte_t pte_val;
 
+	BUG_ON(vma->vm_flags & VM_RESERVED);
+
 	pgd = pgd_offset(mm, addr);
 	spin_lock(&mm->page_table_lock);
 	
Index: linux-2.6/mm/msync.c
===================================================================
--- linux-2.6.orig/mm/msync.c
+++ linux-2.6/mm/msync.c
@@ -37,11 +37,11 @@ static void sync_pte_range(struct vm_are
 		if (!pte_maybe_dirty(*pte))
 			continue;
 		pfn = pte_pfn(*pte);
-		if (!pfn_valid(pfn))
+		if (unlikely(!pfn_valid(pfn))) {
+			invalid_pfn(*pte, vma->vm_flags, addr);
 			continue;
+		}
 		page = pfn_to_page(pfn);
-		if (PageReserved(page))
-			continue;
 
 		if (ptep_clear_flush_dirty(vma, addr, pte) ||
 		    page_test_and_clear_dirty(page))
@@ -149,6 +149,9 @@ static int msync_interval(struct vm_area
 	if ((flags & MS_INVALIDATE) && (vma->vm_flags & VM_LOCKED))
 		return -EBUSY;
 
+	if (vma->vm_flags & VM_RESERVED)
+		return -EINVAL;
+
 	if (file && (vma->vm_flags & VM_SHARED)) {
 		filemap_sync(vma, addr, end);
 
Index: linux-2.6/mm/rmap.c
===================================================================
--- linux-2.6.orig/mm/rmap.c
+++ linux-2.6/mm/rmap.c
@@ -442,8 +442,6 @@ int page_referenced(struct page *page, i
 void page_add_anon_rmap(struct page *page,
 	struct vm_area_struct *vma, unsigned long address)
 {
-	BUG_ON(PageReserved(page));
-
 	inc_mm_counter(vma->vm_mm, anon_rss);
 
 	if (atomic_inc_and_test(&page->_mapcount)) {
@@ -469,8 +467,7 @@ void page_add_anon_rmap(struct page *pag
 void page_add_file_rmap(struct page *page)
 {
 	BUG_ON(PageAnon(page));
-	if (!pfn_valid(page_to_pfn(page)) || PageReserved(page))
-		return;
+	BUG_ON(!pfn_valid(page_to_pfn(page)));
 
 	if (atomic_inc_and_test(&page->_mapcount))
 		inc_page_state(nr_mapped);
@@ -484,8 +481,6 @@ void page_add_file_rmap(struct page *pag
  */
 void page_remove_rmap(struct page *page)
 {
-	BUG_ON(PageReserved(page));
-
 	if (atomic_add_negative(-1, &page->_mapcount)) {
 		BUG_ON(page_mapcount(page) < 0);
 		/*
@@ -643,13 +638,13 @@ static void try_to_unmap_cluster(unsigne
 			continue;
 
 		pfn = pte_pfn(*pte);
-		if (!pfn_valid(pfn))
+		if (unlikely(!pfn_valid(pfn))) {
+			invalid_pfn(*pte, vma->vm_flags, address);
 			continue;
+		}
 
 		page = pfn_to_page(pfn);
 		BUG_ON(PageAnon(page));
-		if (PageReserved(page))
-			continue;
 
 		if (ptep_clear_flush_young(vma, address, pte))
 			continue;
@@ -812,7 +807,6 @@ int try_to_unmap(struct page *page)
 {
 	int ret;
 
-	BUG_ON(PageReserved(page));
 	BUG_ON(!PageLocked(page));
 
 	if (PageAnon(page))
Index: linux-2.6/drivers/scsi/sg.c
===================================================================
--- linux-2.6.orig/drivers/scsi/sg.c
+++ linux-2.6/drivers/scsi/sg.c
@@ -1887,13 +1887,17 @@ st_unmap_user_pages(struct scatterlist *
 	int i;
 
 	for (i=0; i < nr_pages; i++) {
-		if (dirtied && !PageReserved(sgl[i].page))
-			SetPageDirty(sgl[i].page);
-		/* unlock_page(sgl[i].page); */
+		struct page *page = sgl[i].page;
+
+		/* XXX: just for debug. Remove when PageReserved is removed */
+		BUG_ON(PageReserved(page));
+		if (dirtied)
+			SetPageDirty(page);
+		/* unlock_page(page); */
 		/* FIXME: cache flush missing for rw==READ
 		 * FIXME: call the correct reference counting function
 		 */
-		page_cache_release(sgl[i].page);
+		page_cache_release(page);
 	}
 
 	return 0;
Index: linux-2.6/drivers/scsi/st.c
===================================================================
--- linux-2.6.orig/drivers/scsi/st.c
+++ linux-2.6/drivers/scsi/st.c
@@ -4435,12 +4435,16 @@ static int sgl_unmap_user_pages(struct s
 	int i;
 
 	for (i=0; i < nr_pages; i++) {
-		if (dirtied && !PageReserved(sgl[i].page))
-			SetPageDirty(sgl[i].page);
+		struct page *page = sgl[i].page;
+
+		/* XXX: just for debug. Remove when PageReserved is removed */
+		BUG_ON(PageReserved(page));
+		if (dirtied)
+			SetPageDirty(page);
 		/* FIXME: cache flush missing for rw==READ
 		 * FIXME: call the correct reference counting function
 		 */
-		page_cache_release(sgl[i].page);
+		page_cache_release(page);
 	}
 
 	return 0;
Index: linux-2.6/sound/core/pcm_native.c
===================================================================
--- linux-2.6.orig/sound/core/pcm_native.c
+++ linux-2.6/sound/core/pcm_native.c
@@ -2944,8 +2944,7 @@ static struct page * snd_pcm_mmap_status
 		return NOPAGE_OOM;
 	runtime = substream->runtime;
 	page = virt_to_page(runtime->status);
-	if (!PageReserved(page))
-		get_page(page);
+	get_page(page);
 	if (type)
 		*type = VM_FAULT_MINOR;
 	return page;
@@ -2987,8 +2986,7 @@ static struct page * snd_pcm_mmap_contro
 		return NOPAGE_OOM;
 	runtime = substream->runtime;
 	page = virt_to_page(runtime->control);
-	if (!PageReserved(page))
-		get_page(page);
+	get_page(page);
 	if (type)
 		*type = VM_FAULT_MINOR;
 	return page;
@@ -3061,8 +3059,7 @@ static struct page *snd_pcm_mmap_data_no
 		vaddr = runtime->dma_area + offset;
 		page = virt_to_page(vaddr);
 	}
-	if (!PageReserved(page))
-		get_page(page);
+	get_page(page);
 	if (type)
 		*type = VM_FAULT_MINOR;
 	return page;
Index: linux-2.6/mm/mmap.c
===================================================================
--- linux-2.6.orig/mm/mmap.c
+++ linux-2.6/mm/mmap.c
@@ -1073,6 +1073,17 @@ munmap_back:
 		error = file->f_op->mmap(file, vma);
 		if (error)
 			goto unmap_and_free_vma;
+		if ((vma->vm_flags & (VM_SHARED | VM_WRITE | VM_RESERVED))
+						== (VM_WRITE | VM_RESERVED)) {
+			printk(KERN_WARNING "program %s is using MAP_PRIVATE, "
+				"PROT_WRITE mmap of VM_RESERVED memory, which "
+				"is deprecated. Please report this to "
+				"linux-kernel@vger.kernel.org\n",current->comm);
+			if (vma->vm_ops && vma->vm_ops->close)
+				vma->vm_ops->close(vma);
+			error = -EACCES;
+			goto unmap_and_free_vma;
+		}
 	} else if (vm_flags & VM_SHARED) {
 		error = shmem_zero_setup(vma);
 		if (error)
Index: linux-2.6/mm/mprotect.c
===================================================================
--- linux-2.6.orig/mm/mprotect.c
+++ linux-2.6/mm/mprotect.c
@@ -131,6 +131,14 @@ mprotect_fixup(struct vm_area_struct *vm
 				return -ENOMEM;
 			newflags |= VM_ACCOUNT;
 		}
+		if (oldflags & VM_RESERVED) {
+			BUG_ON(oldflags & VM_WRITE);
+			printk(KERN_WARNING "program %s is using MAP_PRIVATE, "
+				"PROT_WRITE mprotect of VM_RESERVED memory, "
+				"which is deprecated. Please report this to "
+				"linux-kernel@vger.kernel.org\n",current->comm);
+			return -EACCES;
+		}
 	}
 
 	newprot = protection_map[newflags & 0xf];
Index: linux-2.6/mm/bootmem.c
===================================================================
--- linux-2.6.orig/mm/bootmem.c
+++ linux-2.6/mm/bootmem.c
@@ -297,6 +297,7 @@ static unsigned long __init free_all_boo
 				if (j + 16 < BITS_PER_LONG)
 					prefetchw(page + j + 16);
 				__ClearPageReserved(page + j);
+				set_page_count(page + j, 0);
 			}
 			__free_pages(page, order);
 			i += BITS_PER_LONG;
Index: linux-2.6/mm/mempolicy.c
===================================================================
--- linux-2.6.orig/mm/mempolicy.c
+++ linux-2.6/mm/mempolicy.c
@@ -253,8 +253,10 @@ static int check_pte_range(struct mm_str
 		if (!pte_present(*pte))
 			continue;
 		pfn = pte_pfn(*pte);
-		if (!pfn_valid(pfn))
+		if (unlikely(!pfn_valid(pfn))) {
+			invalid_pfn(*pte, -1UL, addr);
 			continue;
+		}
 		nid = pfn_to_nid(pfn);
 		if (!test_bit(nid, nodes))
 			break;
@@ -326,6 +328,8 @@ check_range(struct mm_struct *mm, unsign
 	first = find_vma(mm, start);
 	if (!first)
 		return ERR_PTR(-EFAULT);
+	if (first->vm_flags & VM_RESERVED)
+		return ERR_PTR(-EACCES);
 	prev = NULL;
 	for (vma = first; vma && vma->vm_start < end; vma = vma->vm_next) {
 		if (!vma->vm_next && vma->vm_end < end)
Index: linux-2.6/arch/ppc64/kernel/vdso.c
===================================================================
--- linux-2.6.orig/arch/ppc64/kernel/vdso.c
+++ linux-2.6/arch/ppc64/kernel/vdso.c
@@ -176,13 +176,13 @@ static struct page * vdso_vma_nopage(str
 		return NOPAGE_SIGBUS;
 
 	/*
-	 * Last page is systemcfg, special handling here, no get_page() a
-	 * this is a reserved page
+	 * Last page is systemcfg.
 	 */
 	if ((vma->vm_end - address) <= PAGE_SIZE)
-		return virt_to_page(systemcfg);
+		pg = virt_to_page(systemcfg);
+	else
+		pg = virt_to_page(vbase + offset);
 
-	pg = virt_to_page(vbase + offset);
 	get_page(pg);
 	DBG(" ->page count: %d\n", page_count(pg));
 
@@ -600,6 +600,8 @@ void __init vdso_init(void)
 		ClearPageReserved(pg);
 		get_page(pg);
 	}
+
+	get_page(virt_to_page(systemcfg));
 }
 
 int in_gate_area_no_task(unsigned long addr)
Index: linux-2.6/kernel/power/swsusp.c
===================================================================
--- linux-2.6.orig/kernel/power/swsusp.c
+++ linux-2.6/kernel/power/swsusp.c
@@ -434,15 +434,23 @@ static int save_highmem_zone(struct zone
 			continue;
 		page = pfn_to_page(pfn);
 		/*
-		 * This condition results from rvmalloc() sans vmalloc_32()
-		 * and architectural memory reservations. This should be
-		 * corrected eventually when the cases giving rise to this
-		 * are better understood.
+		 * PageReserved results from rvmalloc() sans vmalloc_32()
+		 * and architectural memory reservations.
+		 *
+		 * rvmalloc should not cause this, because all implementations
+		 * appear to always be using vmalloc_32 on architectures with
+		 * highmem. This is a good thing, because we would like to save
+		 * rvmalloc pages.
+		 *
+		 * It appears to be triggered by pages which do not point to
+		 * valid memory (see arch/i386/mm/init.c:one_highpage_init(),
+		 * which sets PageReserved if the page does not point to valid
+		 * RAM.
+		 *
+		 * XXX: must remove usage of PageReserved!
 		 */
-		if (PageReserved(page)) {
-			printk("highmem reserved page?!\n");
+		if (PageReserved(page))
 			continue;
-		}
 		BUG_ON(PageNosave(page));
 		if (PageNosaveFree(page))
 			continue;
@@ -528,10 +536,9 @@ static int saveable(struct zone * zone, 
 		return 0;
 
 	page = pfn_to_page(pfn);
-	BUG_ON(PageReserved(page) && PageNosave(page));
 	if (PageNosave(page))
 		return 0;
-	if (PageReserved(page) && pfn_is_nosave(pfn)) {
+	if (pfn_is_nosave(pfn)) {
 		pr_debug("[nosave pfn 0x%lx]", pfn);
 		return 0;
 	}
Index: linux-2.6/mm/shmem.c
===================================================================
--- linux-2.6.orig/mm/shmem.c
+++ linux-2.6/mm/shmem.c
@@ -1523,7 +1523,8 @@ static void do_shmem_file_read(struct fi
 		index += offset >> PAGE_CACHE_SHIFT;
 		offset &= ~PAGE_CACHE_MASK;
 
-		page_cache_release(page);
+		if (page != ZERO_PAGE(0))
+			page_cache_release(page);
 		if (ret != nr || !desc->count)
 			break;
 

--------------080405030104040704000508--
Send instant messages to your online friends http://au.messenger.yahoo.com 
