Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751424AbVJKI7N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751424AbVJKI7N (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Oct 2005 04:59:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751428AbVJKI7N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Oct 2005 04:59:13 -0400
Received: from smtp207.mail.sc5.yahoo.com ([216.136.129.97]:49315 "HELO
	smtp207.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S1751424AbVJKI7L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Oct 2005 04:59:11 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:Subject:Content-Type;
  b=C3PVb4FPkGwWqNLsU4csBWxWeA3Mi5uLK1IaTdGiRwKDOWgnnyZOluJjq3dDbr4LaolIpU8JoTex7MlWa5J1bCEd2tc1hHEBWoIPPw0c7uXfF4+qpbuJo1auqB73maWfbawMP+Pz4ALPYYFTR7zEC2j5O8ACGC3xq4s1mShT+pU=  ;
Message-ID: <434B7F19.5040808@yahoo.com.au>
Date: Tue, 11 Oct 2005 19:00:09 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.11) Gecko/20050914 Debian/1.7.11-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>, Hugh Dickins <hugh@veritas.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.6.14-rc2-mm2] core remove PageReserved
Content-Type: multipart/mixed;
 boundary="------------080509000105000401080605"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080509000105000401080605
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

This patch removes usage of PageReserved from the core kernel.
Comments, testing, discussion all welcome.

Nick

-- 
SUSE Labs, Novell Inc.


--------------080509000105000401080605
Content-Type: text/plain;
 name="mm-core-remove-PageReserved-2.6.14-rc2-mm2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mm-core-remove-PageReserved-2.6.14-rc2-mm2.patch"

Remove PageReserved() calls from core code by tightening VM_RESERVED
handling in mm/ to cover PageReserved functionality.

PageReserved special casing is removed from get_page and put_page.

All setting and clearing of PageReserved is retained, and it is now
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
still needs to be addressed (a generic page_is_ram() should work).

A last caveat: the ZERO_PAGE is now refcounted and managed with rmap
(and thus mapcounted and count towards shared rss). These writes to the
struct page could cause excessive cacheline bouncing on big systems.
There are a number of ways this could be addressed if it is an issue.

Signed-off-by: Nick Piggin <npiggin@suse.de>


Refcount bug fix for filemap_xip.c

Signed-off-by: Carsten Otte <cotte@de.ibm.com>

Index: linux-2.6/include/linux/mm.h
===================================================================
--- linux-2.6.orig/include/linux/mm.h
+++ linux-2.6/include/linux/mm.h
@@ -157,7 +157,7 @@ extern unsigned int kobjsize(const void 
 
 #define VM_DONTCOPY	0x00020000      /* Do not copy this vma on fork */
 #define VM_DONTEXPAND	0x00040000	/* Cannot expand with mremap() */
-#define VM_RESERVED	0x00080000	/* Don't unmap it from swap_out */
+#define VM_RESERVED	0x00080000	/* Pages managed in a special way */
 #define VM_ACCOUNT	0x00100000	/* Is a VM accounted object */
 #define VM_HUGETLB	0x00400000	/* Huge TLB Page VM */
 #define VM_NONLINEAR	0x00800000	/* Is non-linear (remap_file_pages) */
@@ -343,7 +343,7 @@ static inline void get_page(struct page 
 
 static inline void put_page(struct page *page)
 {
-	if (!PageReserved(page) && put_page_testzero(page))
+	if (put_page_testzero(page))
 		__page_cache_release(page);
 }
 
@@ -728,6 +728,7 @@ void install_arg_page(struct vm_area_str
 
 int get_user_pages(struct task_struct *tsk, struct mm_struct *mm, unsigned long start,
 		int len, int write, int force, struct page **pages, struct vm_area_struct **vmas);
+void print_bad_pte(struct vm_area_struct *, pte_t, unsigned long);
 
 int __set_page_dirty_buffers(struct page *page);
 int __set_page_dirty_nobuffers(struct page *page);
Index: linux-2.6/mm/madvise.c
===================================================================
--- linux-2.6.orig/mm/madvise.c
+++ linux-2.6/mm/madvise.c
@@ -123,7 +123,7 @@ static long madvise_dontneed(struct vm_a
 			     unsigned long start, unsigned long end)
 {
 	*prev = vma;
-	if ((vma->vm_flags & VM_LOCKED) || is_vm_hugetlb_page(vma))
+	if (vma->vm_flags & (VM_LOCKED|VM_HUGETLB|VM_RESERVED))
 		return -EINVAL;
 
 	if (unlikely(vma->vm_flags & VM_NONLINEAR)) {
Index: linux-2.6/mm/memory.c
===================================================================
--- linux-2.6.orig/mm/memory.c
+++ linux-2.6/mm/memory.c
@@ -343,6 +343,23 @@ static inline void add_mm_rss(struct mm_
 #define NO_RSS 2	/* Increment neither file_rss nor anon_rss */
 
 /*
+ * This function is called to print an error when a pte in a
+ * !VM_RESERVED region is found pointing to an invalid pfn (which
+ * is an error.
+ *
+ * The calling function must still handle the error.
+ */
+void print_bad_pte(struct vm_area_struct *vma, pte_t pte, unsigned long vaddr)
+{
+	printk(KERN_ERR "Bad pte = %08llx, process = %s, "
+			"vm_flags = %lx, vaddr = %lx\n",
+		(long long)pte_val(pte),
+		(vma->vm_mm == current->mm ? current->comm : "???"),
+		vma->vm_flags, vaddr);
+	dump_stack();
+}
+
+/*
  * copy one vm_area from one task to the other. Assumes the page tables
  * already present in the new task to be cleared in the whole range
  * covered by this vma.
@@ -353,9 +370,10 @@ static inline void add_mm_rss(struct mm_
 
 static inline int
 copy_one_pte(struct mm_struct *dst_mm, struct mm_struct *src_mm,
-		pte_t *dst_pte, pte_t *src_pte, unsigned long vm_flags,
+		pte_t *dst_pte, pte_t *src_pte, struct vm_area_struct *vma,
 		unsigned long addr)
 {
+	unsigned long vm_flags = vma->vm_flags;
 	pte_t pte = *src_pte;
 	struct page *page;
 	unsigned long pfn;
@@ -375,18 +393,22 @@ copy_one_pte(struct mm_struct *dst_mm, s
 		goto out_set_pte;
 	}
 
+	/* If the region is VM_RESERVED, the mapping is not
+	 * mapped via rmap - duplicate the pte as is.
+	 */
+	if (vm_flags & VM_RESERVED)
+		goto out_set_pte;
+
 	pfn = pte_pfn(pte);
-	/* the pte points outside of valid memory, the
-	 * mapping is assumed to be good, meaningful
-	 * and not mapped via rmap - duplicate the
-	 * mapping as is.
-	 */
-	page = NULL;
-	if (pfn_valid(pfn))
-		page = pfn_to_page(pfn);
+	/* If the pte points outside of valid memory but
+	 * the region is not VM_RESERVED, we have a problem.
+	 */
+	if (unlikely(!pfn_valid(pfn))) {
+		print_bad_pte(vma, pte, addr);
+		goto out_set_pte; /* try to do something sane */
+	}
 
-	if (!page || PageReserved(page))
-		goto out_set_pte;
+	page = pfn_to_page(pfn);
 
 	/*
 	 * If it's a COW mapping, write protect it both
@@ -418,7 +440,6 @@ static int copy_pte_range(struct mm_stru
 		unsigned long addr, unsigned long end)
 {
 	pte_t *src_pte, *dst_pte;
-	unsigned long vm_flags = vma->vm_flags;
 	int progress = 0;
 	int rss[NO_RSS+1], anon;
 
@@ -446,8 +467,7 @@ again:
 			progress++;
 			continue;
 		}
-		anon = copy_one_pte(dst_mm, src_mm, dst_pte, src_pte,
-							vm_flags, addr);
+		anon = copy_one_pte(dst_mm, src_mm, dst_pte, src_pte, vma,addr);
 		rss[anon]++;
 		progress += 8;
 	} while (dst_pte++, src_pte++, addr += PAGE_SIZE, addr != end);
@@ -541,10 +561,12 @@ int copy_page_range(struct mm_struct *ds
 	return 0;
 }
 
-static void zap_pte_range(struct mmu_gather *tlb, pmd_t *pmd,
+static void zap_pte_range(struct mmu_gather *tlb,
+				struct vm_area_struct *vma, pmd_t *pmd,
 				unsigned long addr, unsigned long end,
 				struct zap_details *details)
 {
+	struct mm_struct *mm = tlb->mm;
 	pte_t *pte;
 	int file_rss = 0;
 	int anon_rss = 0;
@@ -556,11 +578,12 @@ static void zap_pte_range(struct mmu_gat
 			continue;
 		if (pte_present(ptent)) {
 			struct page *page = NULL;
-			unsigned long pfn = pte_pfn(ptent);
-			if (pfn_valid(pfn)) {
-				page = pfn_to_page(pfn);
-				if (PageReserved(page))
-					page = NULL;
+			if (!(vma->vm_flags & VM_RESERVED)) {
+				unsigned long pfn = pte_pfn(ptent);
+				if (unlikely(!pfn_valid(pfn)))
+					print_bad_pte(vma, ptent, addr);
+				else
+					page = pfn_to_page(pfn);
 			}
 			if (unlikely(details) && page) {
 				/*
@@ -580,7 +603,7 @@ static void zap_pte_range(struct mmu_gat
 				     page->index > details->last_index))
 					continue;
 			}
-			ptent = ptep_get_and_clear_full(tlb->mm, addr, pte,
+			ptent = ptep_get_and_clear_full(mm, addr, pte,
 							tlb->fullmm);
 			tlb_remove_tlb_entry(tlb, pte, addr);
 			if (unlikely(!page))
@@ -588,7 +611,7 @@ static void zap_pte_range(struct mmu_gat
 			if (unlikely(details) && details->nonlinear_vma
 			    && linear_page_index(details->nonlinear_vma,
 						addr) != page->index)
-				set_pte_at(tlb->mm, addr, pte,
+				set_pte_at(mm, addr, pte,
 					   pgoff_to_pte(page->index));
 			if (PageAnon(page))
 				anon_rss++;
@@ -611,14 +634,15 @@ static void zap_pte_range(struct mmu_gat
 			continue;
 		if (!pte_file(ptent))
 			free_swap_and_cache(pte_to_swp_entry(ptent));
-		pte_clear_full(tlb->mm, addr, pte, tlb->fullmm);
+		pte_clear_full(mm, addr, pte, tlb->fullmm);
 	} while (pte++, addr += PAGE_SIZE, addr != end);
 
-	add_mm_rss(tlb->mm, -file_rss, -anon_rss);
+	add_mm_rss(mm, -file_rss, -anon_rss);
 	pte_unmap(pte - 1);
 }
 
-static inline void zap_pmd_range(struct mmu_gather *tlb, pud_t *pud,
+static inline void zap_pmd_range(struct mmu_gather *tlb,
+				struct vm_area_struct *vma, pud_t *pud,
 				unsigned long addr, unsigned long end,
 				struct zap_details *details)
 {
@@ -630,11 +654,12 @@ static inline void zap_pmd_range(struct 
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
@@ -646,7 +671,7 @@ static inline void zap_pud_range(struct 
 		next = pud_addr_end(addr, end);
 		if (pud_none_or_clear_bad(pud))
 			continue;
-		zap_pmd_range(tlb, pud, addr, next, details);
+		zap_pmd_range(tlb, vma, pud, addr, next, details);
 	} while (pud++, addr = next, addr != end);
 }
 
@@ -667,7 +692,7 @@ static void unmap_page_range(struct mmu_
 		next = pgd_addr_end(addr, end);
 		if (pgd_none_or_clear_bad(pgd))
 			continue;
-		zap_pud_range(tlb, pgd, addr, next, details);
+		zap_pud_range(tlb, vma, pgd, addr, next, details);
 	} while (pgd++, addr = next, addr != end);
 	tlb_end_vma(tlb, vma);
 }
@@ -967,7 +992,7 @@ int get_user_pages(struct task_struct *t
 			continue;
 		}
 
-		if (!vma || (vma->vm_flags & VM_IO)
+		if (!vma || (vma->vm_flags & (VM_IO | VM_RESERVED))
 				|| !(flags & vma->vm_flags))
 			return i ? : -EFAULT;
 
@@ -1027,8 +1052,7 @@ int get_user_pages(struct task_struct *t
 			if (pages) {
 				pages[i] = page;
 				flush_dcache_page(page);
-				if (!PageReserved(page))
-					page_cache_get(page);
+				page_cache_get(page);
 			}
 			if (vmas)
 				vmas[i] = vma;
@@ -1051,7 +1075,11 @@ static int zeromap_pte_range(struct mm_s
 	if (!pte)
 		return -ENOMEM;
 	do {
-		pte_t zero_pte = pte_wrprotect(mk_pte(ZERO_PAGE(addr), prot));
+		struct page *page = ZERO_PAGE(addr);
+		pte_t zero_pte = pte_wrprotect(mk_pte(page, prot));
+		page_cache_get(page);
+		page_add_file_rmap(page);
+		inc_mm_counter(mm, file_rss);
 		BUG_ON(!pte_none(*pte));
 		set_pte_at(mm, addr, pte, zero_pte);
 	} while (pte++, addr += PAGE_SIZE, addr != end);
@@ -1132,8 +1160,7 @@ static int remap_pte_range(struct mm_str
 		return -ENOMEM;
 	do {
 		BUG_ON(!pte_none(*pte));
-		if (!pfn_valid(pfn) || PageReserved(pfn_to_page(pfn)))
-			set_pte_at(mm, addr, pte, pfn_pte(pfn, prot));
+		set_pte_at(mm, addr, pte, pfn_pte(pfn, prot));
 		pfn++;
 	} while (pte++, addr += PAGE_SIZE, addr != end);
 	pte_unmap(pte - 1);
@@ -1256,11 +1283,13 @@ static int do_wp_page(struct mm_struct *
 	pte_t entry;
 	int ret = VM_FAULT_MINOR;
 
+	BUG_ON(vma->vm_flags & VM_RESERVED);
+
 	if (unlikely(!pfn_valid(pfn))) {
 		/*
 		 * Page table corrupted: show pte and kill process.
 		 */
-		pte_ERROR(orig_pte);
+		print_bad_pte(vma, orig_pte, address);
 		ret = VM_FAULT_OOM;
 		goto unlock;
 	}
@@ -1284,8 +1313,7 @@ static int do_wp_page(struct mm_struct *
 	/*
 	 * Ok, we need to copy. Oh, well..
 	 */
-	if (!PageReserved(old_page))
-		page_cache_get(old_page);
+	page_cache_get(old_page);
 	pte_unmap(page_table);
 	spin_unlock(&mm->page_table_lock);
 
@@ -1308,14 +1336,10 @@ static int do_wp_page(struct mm_struct *
 	spin_lock(&mm->page_table_lock);
 	page_table = pte_offset_map(pmd, address);
 	if (likely(pte_same(*page_table, orig_pte))) {
-		if (PageReserved(old_page))
+		page_remove_rmap(old_page);
+		if (!PageAnon(old_page)) {
 			inc_mm_counter(mm, anon_rss);
-		else {
-			page_remove_rmap(old_page);
-			if (!PageAnon(old_page)) {
-				inc_mm_counter(mm, anon_rss);
-				dec_mm_counter(mm, file_rss);
-			}
+			dec_mm_counter(mm, file_rss);
 		}
 		flush_cache_page(vma, address, pfn);
 		entry = mk_pte(new_page, vma->vm_page_prot);
@@ -1769,14 +1793,13 @@ static int do_anonymous_page(struct mm_s
 		unsigned long address, pte_t *page_table, pmd_t *pmd,
 		int write_access)
 {
+	struct page *page = ZERO_PAGE(addr);
 	pte_t entry;
 
 	/* Mapping of ZERO_PAGE - vm_page_prot is readonly */
-	entry = mk_pte(ZERO_PAGE(addr), vma->vm_page_prot);
+	entry = mk_pte(page, vma->vm_page_prot);
 
 	if (write_access) {
-		struct page *page;
-
 		/* Allocate our own private page. */
 		pte_unmap(page_table);
 		spin_unlock(&mm->page_table_lock);
@@ -1800,6 +1823,10 @@ static int do_anonymous_page(struct mm_s
 		lru_cache_add_active(page);
 		SetPageReferenced(page);
 		page_add_anon_rmap(page, vma, address);
+	} else {
+		inc_mm_counter(mm, file_rss);
+		page_add_file_rmap(page);
+		page_cache_get(page);
 	}
 
 	set_pte_at(mm, address, page_table, entry);
@@ -1916,7 +1943,7 @@ retry:
 			inc_mm_counter(mm, anon_rss);
 			lru_cache_add_active(new_page);
 			page_add_anon_rmap(new_page, vma, address);
-		} else if (!PageReserved(new_page)) {
+		} else if (!(vma->vm_flags & VM_RESERVED)) {
 			inc_mm_counter(mm, file_rss);
 			page_add_file_rmap(new_page);
 		}
@@ -1957,7 +1984,7 @@ static int do_file_page(struct mm_struct
 		/*
 		 * Page table corrupted: show pte and kill process.
 		 */
-		pte_ERROR(orig_pte);
+		print_bad_pte(vma, orig_pte, address);
 		return VM_FAULT_OOM;
 	}
 	/* We can then assume vm->vm_ops && vma->vm_ops->populate */
@@ -2232,7 +2259,7 @@ static int __init gate_vma_init(void)
 	gate_vma.vm_start = FIXADDR_USER_START;
 	gate_vma.vm_end = FIXADDR_USER_END;
 	gate_vma.vm_page_prot = PAGE_READONLY;
-	gate_vma.vm_flags = 0;
+	gate_vma.vm_flags = VM_RESERVED;
 	return 0;
 }
 __initcall(gate_vma_init);
Index: linux-2.6/mm/page_alloc.c
===================================================================
--- linux-2.6.orig/mm/page_alloc.c
+++ linux-2.6/mm/page_alloc.c
@@ -140,7 +140,8 @@ static void bad_page(const char *functio
 			1 << PG_reclaim |
 			1 << PG_slab    |
 			1 << PG_swapcache |
-			1 << PG_writeback);
+			1 << PG_writeback |
+			1 << PG_reserved );
 	set_page_count(page, 0);
 	reset_page_mapcount(page);
 	page->mapping = NULL;
@@ -270,7 +271,6 @@ static inline int page_is_buddy(struct p
 {
        if (PagePrivate(page)           &&
            (page_order(page) == order) &&
-           !PageReserved(page)         &&
             page_count(page) == 0)
                return 1;
        return 0;
@@ -353,7 +353,8 @@ static inline void free_pages_check(cons
 			1 << PG_reclaim	|
 			1 << PG_slab	|
 			1 << PG_swapcache |
-			1 << PG_writeback )))
+			1 << PG_writeback |
+			1 << PG_reserved )))
 		bad_page(function, page);
 	if (PageDirty(page))
 		__ClearPageDirty(page);
@@ -481,7 +482,8 @@ static void prep_new_page(struct page *p
 			1 << PG_reclaim	|
 			1 << PG_slab    |
 			1 << PG_swapcache |
-			1 << PG_writeback )))
+			1 << PG_writeback |
+			1 << PG_reserved )))
 		bad_page(__FUNCTION__, page);
 
 	page->flags &= ~(1 << PG_uptodate | 1 << PG_error |
@@ -1098,7 +1100,7 @@ void __pagevec_free(struct pagevec *pvec
 
 fastcall void __free_pages(struct page *page, unsigned int order)
 {
-	if (!PageReserved(page) && put_page_testzero(page)) {
+	if (put_page_testzero(page)) {
 		if (order == 0)
 			free_hot_page(page);
 		else
@@ -1766,7 +1768,7 @@ void __devinit memmap_init_zone(unsigned
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
@@ -29,19 +29,20 @@ static inline void zap_pte(struct mm_str
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
-				dec_mm_counter(mm, file_rss);
-			}
+		if (unlikely(!pfn_valid(pfn))) {
+			print_bad_pte(vma, pte, addr);
+			return;
 		}
+		page = pfn_to_page(pfn);
+		if (pte_dirty(pte))
+			set_page_dirty(page);
+		page_remove_rmap(page);
+		page_cache_release(page);
+		dec_mm_counter(mm, file_rss);
 	} else {
 		if (!pte_file(pte))
 			free_swap_and_cache(pte_to_swp_entry(pte));
@@ -65,6 +66,8 @@ int install_page(struct mm_struct *mm, s
 	pgd_t *pgd;
 	pte_t pte_val;
 
+	BUG_ON(vma->vm_flags & VM_RESERVED);
+
 	pgd = pgd_offset(mm, addr);
 	spin_lock(&mm->page_table_lock);
 	
@@ -122,6 +125,8 @@ int install_file_pte(struct mm_struct *m
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
@@ -25,6 +25,7 @@
 static void msync_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
 				unsigned long addr, unsigned long end)
 {
+	struct mm_struct *mm = vma->vm_mm;
 	pte_t *pte;
 	int progress = 0;
 
@@ -37,7 +38,7 @@ again:
 		if (progress >= 64) {
 			progress = 0;
 			if (need_resched() ||
-			    need_lockbreak(&vma->vm_mm->page_table_lock))
+			    need_lockbreak(&mm->page_table_lock))
 				break;
 		}
 		progress++;
@@ -46,11 +47,11 @@ again:
 		if (!pte_maybe_dirty(*pte))
 			continue;
 		pfn = pte_pfn(*pte);
-		if (!pfn_valid(pfn))
+		if (unlikely(!pfn_valid(pfn))) {
+			print_bad_pte(vma, *pte, addr);
 			continue;
+		}
 		page = pfn_to_page(pfn);
-		if (PageReserved(page))
-			continue;
 
 		if (ptep_clear_flush_dirty(vma, addr, pte) ||
 		    page_test_and_clear_dirty(page))
@@ -58,7 +59,7 @@ again:
 		progress += 3;
 	} while (pte++, addr += PAGE_SIZE, addr != end);
 	pte_unmap(pte - 1);
-	cond_resched_lock(&vma->vm_mm->page_table_lock);
+	cond_resched_lock(&mm->page_table_lock);
 	if (addr != end)
 		goto again;
 }
@@ -102,8 +103,10 @@ static void msync_page_range(struct vm_a
 
 	/* For hugepages we can't go walking the page table normally,
 	 * but that's ok, hugetlbfs is memory based, so we don't need
-	 * to do anything more on an msync() */
-	if (is_vm_hugetlb_page(vma))
+	 * to do anything more on an msync().
+	 * Can't do anything with VM_RESERVED regions either.
+	 */
+	if (vma->vm_flags & (VM_HUGETLB|VM_RESERVED))
 		return;
 
 	BUG_ON(addr >= end);
Index: linux-2.6/mm/rmap.c
===================================================================
--- linux-2.6.orig/mm/rmap.c
+++ linux-2.6/mm/rmap.c
@@ -443,8 +443,6 @@ int page_referenced(struct page *page, i
 void page_add_anon_rmap(struct page *page,
 	struct vm_area_struct *vma, unsigned long address)
 {
-	BUG_ON(PageReserved(page));
-
 	if (atomic_inc_and_test(&page->_mapcount)) {
 		struct anon_vma *anon_vma = vma->anon_vma;
 
@@ -468,8 +466,7 @@ void page_add_anon_rmap(struct page *pag
 void page_add_file_rmap(struct page *page)
 {
 	BUG_ON(PageAnon(page));
-	if (!pfn_valid(page_to_pfn(page)) || PageReserved(page))
-		return;
+	BUG_ON(!pfn_valid(page_to_pfn(page)));
 
 	if (atomic_inc_and_test(&page->_mapcount))
 		inc_page_state(nr_mapped);
@@ -483,8 +480,6 @@ void page_add_file_rmap(struct page *pag
  */
 void page_remove_rmap(struct page *page)
 {
-	BUG_ON(PageReserved(page));
-
 	if (atomic_add_negative(-1, &page->_mapcount)) {
 		BUG_ON(page_mapcount(page) < 0);
 		/*
@@ -640,13 +635,13 @@ static void try_to_unmap_cluster(unsigne
 			continue;
 
 		pfn = pte_pfn(*pte);
-		if (!pfn_valid(pfn))
+		if (unlikely(!pfn_valid(pfn))) {
+			print_bad_pte(vma, *pte, address);
 			continue;
+		}
 
 		page = pfn_to_page(pfn);
 		BUG_ON(PageAnon(page));
-		if (PageReserved(page))
-			continue;
 
 		if (ptep_clear_flush_young(vma, address, pte))
 			continue;
@@ -808,7 +803,6 @@ int try_to_unmap(struct page *page)
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
@@ -4524,12 +4524,16 @@ static int sgl_unmap_user_pages(struct s
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
@@ -2949,8 +2949,7 @@ static struct page * snd_pcm_mmap_status
 		return NOPAGE_OOM;
 	runtime = substream->runtime;
 	page = virt_to_page(runtime->status);
-	if (!PageReserved(page))
-		get_page(page);
+	get_page(page);
 	if (type)
 		*type = VM_FAULT_MINOR;
 	return page;
@@ -2992,8 +2991,7 @@ static struct page * snd_pcm_mmap_contro
 		return NOPAGE_OOM;
 	runtime = substream->runtime;
 	page = virt_to_page(runtime->control);
-	if (!PageReserved(page))
-		get_page(page);
+	get_page(page);
 	if (type)
 		*type = VM_FAULT_MINOR;
 	return page;
@@ -3066,8 +3064,7 @@ static struct page *snd_pcm_mmap_data_no
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
@@ -1084,6 +1084,17 @@ munmap_back:
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
@@ -125,6 +125,14 @@ mprotect_fixup(struct vm_area_struct *vm
 	 * a MAP_NORESERVE private mapping to writable will now reserve.
 	 */
 	if (newflags & VM_WRITE) {
+		if (oldflags & VM_RESERVED) {
+			BUG_ON(oldflags & VM_WRITE);
+			printk(KERN_WARNING "program %s is using MAP_PRIVATE, "
+				"PROT_WRITE mprotect of VM_RESERVED memory, "
+				"which is deprecated. Please report this to "
+				"linux-kernel@vger.kernel.org\n",current->comm);
+			return -EACCES;
+		}
 		if (!(oldflags & (VM_ACCOUNT|VM_WRITE|VM_SHARED|VM_HUGETLB))) {
 			charged = nrpages;
 			if (security_vm_enough_memory(charged))
Index: linux-2.6/mm/bootmem.c
===================================================================
--- linux-2.6.orig/mm/bootmem.c
+++ linux-2.6/mm/bootmem.c
@@ -306,6 +306,7 @@ static unsigned long __init free_all_boo
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
@@ -223,13 +223,13 @@ static struct mempolicy *mpol_new(int mo
 }
 
 /* Ensure all existing pages follow the policy. */
-static int check_pte_range(struct mm_struct *mm, pmd_t *pmd,
+static int check_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
 		unsigned long addr, unsigned long end, nodemask_t *nodes)
 {
 	pte_t *orig_pte;
 	pte_t *pte;
 
-	spin_lock(&mm->page_table_lock);
+	spin_lock(&vma->vm_mm->page_table_lock);
 	orig_pte = pte = pte_offset_map(pmd, addr);
 	do {
 		unsigned long pfn;
@@ -238,18 +238,20 @@ static int check_pte_range(struct mm_str
 		if (!pte_present(*pte))
 			continue;
 		pfn = pte_pfn(*pte);
-		if (!pfn_valid(pfn))
+		if (!pfn_valid(pfn)) {
+			print_bad_pte(vma, *pte, addr);
 			continue;
+		}
 		nid = pfn_to_nid(pfn);
 		if (!node_isset(nid, *nodes))
 			break;
 	} while (pte++, addr += PAGE_SIZE, addr != end);
 	pte_unmap(orig_pte);
-	spin_unlock(&mm->page_table_lock);
+	spin_unlock(&vma->vm_mm->page_table_lock);
 	return addr != end;
 }
 
-static inline int check_pmd_range(struct mm_struct *mm, pud_t *pud,
+static inline int check_pmd_range(struct vm_area_struct *vma, pud_t *pud,
 		unsigned long addr, unsigned long end, nodemask_t *nodes)
 {
 	pmd_t *pmd;
@@ -260,13 +262,13 @@ static inline int check_pmd_range(struct
 		next = pmd_addr_end(addr, end);
 		if (pmd_none_or_clear_bad(pmd))
 			continue;
-		if (check_pte_range(mm, pmd, addr, next, nodes))
+		if (check_pte_range(vma, pmd, addr, next, nodes))
 			return -EIO;
 	} while (pmd++, addr = next, addr != end);
 	return 0;
 }
 
-static inline int check_pud_range(struct mm_struct *mm, pgd_t *pgd,
+static inline int check_pud_range(struct vm_area_struct *vma, pgd_t *pgd,
 		unsigned long addr, unsigned long end, nodemask_t *nodes)
 {
 	pud_t *pud;
@@ -277,24 +279,24 @@ static inline int check_pud_range(struct
 		next = pud_addr_end(addr, end);
 		if (pud_none_or_clear_bad(pud))
 			continue;
-		if (check_pmd_range(mm, pud, addr, next, nodes))
+		if (check_pmd_range(vma, pud, addr, next, nodes))
 			return -EIO;
 	} while (pud++, addr = next, addr != end);
 	return 0;
 }
 
-static inline int check_pgd_range(struct mm_struct *mm,
+static inline int check_pgd_range(struct vm_area_struct *vma,
 		unsigned long addr, unsigned long end, nodemask_t *nodes)
 {
 	pgd_t *pgd;
 	unsigned long next;
 
-	pgd = pgd_offset(mm, addr);
+	pgd = pgd_offset(vma->vm_mm, addr);
 	do {
 		next = pgd_addr_end(addr, end);
 		if (pgd_none_or_clear_bad(pgd))
 			continue;
-		if (check_pud_range(mm, pgd, addr, next, nodes))
+		if (check_pud_range(vma, pgd, addr, next, nodes))
 			return -EIO;
 	} while (pgd++, addr = next, addr != end);
 	return 0;
@@ -311,6 +313,8 @@ check_range(struct mm_struct *mm, unsign
 	first = find_vma(mm, start);
 	if (!first)
 		return ERR_PTR(-EFAULT);
+	if (first->vm_flags & VM_RESERVED)
+		return ERR_PTR(-EACCES);
 	prev = NULL;
 	for (vma = first; vma && vma->vm_start < end; vma = vma->vm_next) {
 		if (!vma->vm_next && vma->vm_end < end)
@@ -323,8 +327,7 @@ check_range(struct mm_struct *mm, unsign
 				endvma = end;
 			if (vma->vm_start > start)
 				start = vma->vm_start;
-			err = check_pgd_range(vma->vm_mm,
-					   start, endvma, nodes);
+			err = check_pgd_range(vma, start, endvma, nodes);
 			if (err) {
 				first = ERR_PTR(err);
 				break;
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
 
@@ -259,7 +259,7 @@ int arch_setup_additional_pages(struct l
 	 * gettimeofday will be totally dead. It's fine to use that for setting
 	 * breakpoints in the vDSO code pages though
 	 */
-	vma->vm_flags = VM_READ | VM_EXEC | VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC;
+	vma->vm_flags = VM_READ | VM_EXEC | VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC | VM_RESERVED;
 	vma->vm_flags |= mm->def_flags;
 	vma->vm_page_prot = protection_map[vma->vm_flags & 0x7];
 	vma->vm_ops = &vdso_vmops;
@@ -603,6 +603,8 @@ void __init vdso_init(void)
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
@@ -578,15 +578,23 @@ static int save_highmem_zone(struct zone
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
@@ -672,10 +680,9 @@ static int saveable(struct zone * zone, 
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
Index: linux-2.6/mm/filemap_xip.c
===================================================================
--- linux-2.6.orig/mm/filemap_xip.c
+++ linux-2.6/mm/filemap_xip.c
@@ -174,6 +174,7 @@ __xip_unmap (struct address_space * mapp
 	unsigned long address;
 	pte_t *pte;
 	pte_t pteval;
+	struct page *page = ZERO_PAGE(address);
 
 	spin_lock(&mapping->i_mmap_lock);
 	vma_prio_tree_foreach(vma, &iter, &mapping->i_mmap, pgoff, pgoff) {
@@ -185,15 +186,17 @@ __xip_unmap (struct address_space * mapp
 		 * We need the page_table_lock to protect us from page faults,
 		 * munmap, fork, etc...
 		 */
-		pte = page_check_address(ZERO_PAGE(address), mm,
-					 address);
+		pte = page_check_address(page, mm, address);
 		if (!IS_ERR(pte)) {
 			/* Nuke the page table entry. */
 			flush_cache_page(vma, address, pte_pfn(*pte));
 			pteval = ptep_clear_flush(vma, address, pte);
+			page_remove_rmap(page);
+			dec_mm_counter(mm, file_rss);
 			BUG_ON(pte_dirty(pteval));
 			pte_unmap(pte);
 			spin_unlock(&mm->page_table_lock);
+			page_cache_release(page);
 		}
 	}
 	spin_unlock(&mapping->i_mmap_lock);
@@ -228,7 +231,7 @@ xip_file_nopage(struct vm_area_struct * 
 
 	page = mapping->a_ops->get_xip_page(mapping, pgoff*(PAGE_SIZE/512), 0);
 	if (!IS_ERR(page)) {
-		return page;
+		goto out;
 	}
 	if (PTR_ERR(page) != -ENODATA)
 		return NULL;
@@ -249,6 +252,8 @@ xip_file_nopage(struct vm_area_struct * 
 		page = ZERO_PAGE(address);
 	}
 
+out:
+	page_cache_get(page);
 	return page;
 }
 
Index: linux-2.6/mm/shmem.c
===================================================================
--- linux-2.6.orig/mm/shmem.c
+++ linux-2.6/mm/shmem.c
@@ -1507,8 +1507,10 @@ static void do_shmem_file_read(struct fi
 			 */
 			if (!offset)
 				mark_page_accessed(page);
-		} else
+		} else {
 			page = ZERO_PAGE(0);
+			page_cache_get(page);
+		}
 
 		/*
 		 * Ok, we have the page, and it's up-to-date, so
Index: linux-2.6/fs/direct-io.c
===================================================================
--- linux-2.6.orig/fs/direct-io.c
+++ linux-2.6/fs/direct-io.c
@@ -162,6 +162,7 @@ static int dio_refill_pages(struct dio *
 	up_read(&current->mm->mmap_sem);
 
 	if (ret < 0 && dio->blocks_available && (dio->rw == WRITE)) {
+		struct page *page = ZERO_PAGE(dio->curr_user_address);
 		/*
 		 * A memory fault, but the filesystem has some outstanding
 		 * mapped blocks.  We need to use those blocks up to avoid
@@ -169,7 +170,8 @@ static int dio_refill_pages(struct dio *
 		 */
 		if (dio->page_errors == 0)
 			dio->page_errors = ret;
-		dio->pages[0] = ZERO_PAGE(dio->curr_user_address);
+		page_cache_get(page);
+		dio->pages[0] = page;
 		dio->head = 0;
 		dio->tail = 1;
 		ret = 0;

--------------080509000105000401080605--
Send instant messages to your online friends http://au.messenger.yahoo.com 
