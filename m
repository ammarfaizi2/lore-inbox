Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261589AbUJ2Dls@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261589AbUJ2Dls (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 23:41:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262893AbUJ2Dlr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 23:41:47 -0400
Received: from ozlabs.org ([203.10.76.45]:63391 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261589AbUJ2Dic (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 23:38:32 -0400
Date: Fri, 29 Oct 2004 13:37:08 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: linux-kernel@vger.kernel.org, linuxppc64-dev@ozlabs.org
Cc: Adam Litke <agl@us.ibm.com>, Andy Whitworth <apw@shadowen.org>,
       William Lee Irwin <wli@holomorphy.com>
Subject: [RFC] Consolidate lots of hugepage code
Message-ID: <20041029033708.GF12247@zax>
Mail-Followup-To: David Gibson <david@gibson.dropbear.id.au>,
	linux-kernel@vger.kernel.org, linuxppc64-dev@ozlabs.org,
	Adam Litke <agl@us.ibm.com>, Andy Whitworth <apw@shadowen.org>,
	William Lee Irwin <wli@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

wA lot of the code in arch/*/mm/hugetlbpage.c is quite similar.  This
patch attempts to consolidate a lot of the code across the arch's,
putting the combined version in mm/hugetlb.c.  There are a couple of
uglyish hacks in order to cover all the hugepage archs, but the result
is a very large reduction in the total amount of code.  It also means
things like hugepage lazy allocation could be implemented in one
place, instead of six.

As yet this is entirely untested, except on ppc64.  Comments?
Objections?  Testing acks?

Notes:
	- this patch changes the meaning of set_huge_pte() to be more
	  analagous to set_pte()
	- does SH4 need special huge_ptep_get_and_clear()??

Index: working-2.6/mm/hugetlb.c
===================================================================
--- working-2.6.orig/mm/hugetlb.c	2004-09-07 10:38:00.000000000 +1000
+++ working-2.6/mm/hugetlb.c	2004-10-29 11:38:27.132145776 +1000
@@ -7,9 +7,13 @@
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/mm.h>
-#include <linux/hugetlb.h>
 #include <linux/sysctl.h>
 #include <linux/highmem.h>
+#include <linux/pagemap.h>
+#include <asm/page.h>
+#include <asm/pgtable.h>
+
+#include <linux/hugetlb.h>
 
 const unsigned long hugetlb_zero = 0, hugetlb_infinity = ~0UL;
 static unsigned long nr_huge_pages, free_huge_pages;
@@ -248,6 +252,75 @@
 	.nopage = hugetlb_nopage,
 };
 
+pte_t *huge_pte_alloc(struct mm_struct *mm, unsigned long addr);
+pte_t *huge_pte_offset(struct mm_struct *mm, unsigned long addr);
+
+pte_t make_huge_pte(struct vm_area_struct *vma, struct page *page)
+{
+	pte_t entry;
+
+	if (vma->vm_flags & VM_WRITE) {
+		entry =
+		    pte_mkwrite(pte_mkdirty(mk_pte(page, vma->vm_page_prot)));
+	} else {
+		entry = pte_wrprotect(mk_pte(page, vma->vm_page_prot));
+	}
+	entry = pte_mkyoung(entry);
+	entry = pte_mkhuge(entry);
+
+	return entry;
+}
+
+int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
+			    struct vm_area_struct *vma)
+{
+	pte_t *src_pte, *dst_pte, entry;
+	struct page *ptepage;
+	unsigned long addr = vma->vm_start;
+	unsigned long end = vma->vm_end;
+
+	while (addr < end) {
+		dst_pte = huge_pte_alloc(dst, addr);
+		if (!dst_pte)
+			goto nomem;
+		src_pte = huge_pte_offset(src, addr);
+		BUG_ON(!src_pte || pte_none(*src_pte)); /* prefaulted */
+		entry = *src_pte;
+		ptepage = pte_page(entry);
+		get_page(ptepage);
+		set_huge_pte(dst_pte, entry);
+		dst->rss += (HPAGE_SIZE / PAGE_SIZE);
+		addr += HPAGE_SIZE;
+	}
+	return 0;
+
+nomem:
+	return -ENOMEM;
+}
+
+void unmap_hugepage_range(struct vm_area_struct *vma, unsigned long start,
+			  unsigned long end)
+{
+	struct mm_struct *mm = vma->vm_mm;
+	unsigned long address;
+	pte_t pte;
+	struct page *page;
+
+	WARN_ON(!is_vm_hugetlb_page(vma));
+	BUG_ON(start & ~HPAGE_MASK);
+	BUG_ON(end & ~HPAGE_MASK);
+
+	for (address = start; address < end; address += HPAGE_SIZE) {
+		pte = huge_ptep_get_and_clear(huge_pte_offset(mm, address));
+		if (pte_none(pte))
+			continue;
+		page = pte_page(pte);
+		put_page(page);
+	}
+	mm->rss -= (end - start) >> PAGE_SHIFT;
+	flush_tlb_range(vma, start, end);
+}
+
 void zap_hugepage_range(struct vm_area_struct *vma,
 			unsigned long start, unsigned long length)
 {
@@ -257,3 +330,106 @@
 	unmap_hugepage_range(vma, start, start + length);
 	spin_unlock(&mm->page_table_lock);
 }
+
+int hugetlb_prefault(struct address_space *mapping, struct vm_area_struct *vma)
+{
+	struct mm_struct *mm = current->mm;
+	unsigned long addr;
+	int ret = 0;
+
+	WARN_ON(!is_vm_hugetlb_page(vma));
+	BUG_ON(vma->vm_start & ~HPAGE_MASK);
+	BUG_ON(vma->vm_end & ~HPAGE_MASK);
+
+	spin_lock(&mm->page_table_lock);
+	for (addr = vma->vm_start; addr < vma->vm_end; addr += HPAGE_SIZE) {
+		unsigned long idx;
+		pte_t *pte = huge_pte_alloc(mm, addr);
+		struct page *page;
+
+		if (!pte) {
+			ret = -ENOMEM;
+			goto out;
+		}
+		if (! pte_none(*pte))
+			hugetlb_clean_stale_pgtable(pte);
+
+		idx = ((addr - vma->vm_start) >> HPAGE_SHIFT)
+			+ (vma->vm_pgoff >> (HPAGE_SHIFT - PAGE_SHIFT));
+		page = find_get_page(mapping, idx);
+		if (!page) {
+			/* charge the fs quota first */
+			if (hugetlb_get_quota(mapping)) {
+				ret = -ENOMEM;
+				goto out;
+			}
+			page = alloc_huge_page();
+			if (!page) {
+				hugetlb_put_quota(mapping);
+				ret = -ENOMEM;
+				goto out;
+			}
+			ret = add_to_page_cache(page, mapping, idx, GFP_ATOMIC);
+			if (! ret) {
+				unlock_page(page);
+			} else {
+				hugetlb_put_quota(mapping);
+				free_huge_page(page);
+				goto out;
+			}
+		}
+		mm->rss += (HPAGE_SIZE / PAGE_SIZE);
+		set_huge_pte(pte, make_huge_pte(vma, page));
+	}
+out:
+	spin_unlock(&mm->page_table_lock);
+	return ret;
+}
+
+int follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
+			struct page **pages, struct vm_area_struct **vmas,
+			unsigned long *position, int *length, int i)
+{
+	unsigned long vpfn, vaddr = *position;
+	int remainder = *length;
+
+	BUG_ON(!is_vm_hugetlb_page(vma));
+
+	vpfn = vaddr/PAGE_SIZE;
+	while (vaddr < vma->vm_end && remainder) {
+
+		if (pages) {
+			pte_t *pte;
+			struct page *page;
+
+			/* Some archs (sparc64, sh*) have multiple
+			 * pte_ts to each hugepage.  We have to make
+			 * sure we get the first, for the page
+			 * indexing below to work. */
+			pte = huge_pte_offset(mm, vaddr & HPAGE_MASK);
+
+			/* hugetlb should be locked, and hence, prefaulted */
+			WARN_ON(!pte || pte_none(*pte));
+
+			page = &pte_page(*pte)[vpfn % (HPAGE_SIZE/PAGE_SIZE)];
+
+			WARN_ON(!PageCompound(page));
+
+			get_page(page);
+			pages[i] = page;
+		}
+
+		if (vmas)
+			vmas[i] = vma;
+
+		vaddr += PAGE_SIZE;
+		++vpfn;
+		--remainder;
+		++i;
+	}
+
+	*length = remainder;
+	*position = vaddr;
+
+	return i;
+}
Index: working-2.6/arch/ppc64/mm/hugetlbpage.c
===================================================================
--- working-2.6.orig/arch/ppc64/mm/hugetlbpage.c	2004-10-29 11:37:48.139082848 +1000
+++ working-2.6/arch/ppc64/mm/hugetlbpage.c	2004-10-29 11:38:27.133145624 +1000
@@ -122,7 +122,7 @@
 	return hugepte_offset(dir, addr);
 }
 
-static pte_t *huge_pte_offset(struct mm_struct *mm, unsigned long addr)
+pte_t *huge_pte_offset(struct mm_struct *mm, unsigned long addr)
 {
 	pgd_t *pgd;
 
@@ -135,7 +135,7 @@
 	return hugepte_offset(pgd, addr);
 }
 
-static pte_t *huge_pte_alloc(struct mm_struct *mm, unsigned long addr)
+pte_t *huge_pte_alloc(struct mm_struct *mm, unsigned long addr)
 {
 	pgd_t *pgd;
 
@@ -148,24 +148,6 @@
 	return hugepte_alloc(mm, pgd, addr);
 }
 
-static void set_huge_pte(struct mm_struct *mm, struct vm_area_struct *vma,
-			 struct page *page, pte_t *ptep, int write_access)
-{
-	pte_t entry;
-
-	mm->rss += (HPAGE_SIZE / PAGE_SIZE);
-	if (write_access) {
-		entry =
-		    pte_mkwrite(pte_mkdirty(mk_pte(page, vma->vm_page_prot)));
-	} else {
-		entry = pte_wrprotect(mk_pte(page, vma->vm_page_prot));
-	}
-	entry = pte_mkyoung(entry);
-	entry = pte_mkhuge(entry);
-
-	set_pte(ptep, entry);
-}
-
 /*
  * This function checks for proper alignment of input addr and len parameters.
  */
@@ -292,80 +274,6 @@
 	return -EINVAL;
 }
 
-int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
-			struct vm_area_struct *vma)
-{
-	pte_t *src_pte, *dst_pte, entry;
-	struct page *ptepage;
-	unsigned long addr = vma->vm_start;
-	unsigned long end = vma->vm_end;
-	int err = -ENOMEM;
-
-	while (addr < end) {
-		dst_pte = huge_pte_alloc(dst, addr);
-		if (!dst_pte)
-			goto out;
-
-		src_pte = huge_pte_offset(src, addr);
-		entry = *src_pte;
-		
-		ptepage = pte_page(entry);
-		get_page(ptepage);
-		dst->rss += (HPAGE_SIZE / PAGE_SIZE);
-		set_pte(dst_pte, entry);
-
-		addr += HPAGE_SIZE;
-	}
-
-	err = 0;
- out:
-	return err;
-}
-
-int
-follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
-		    struct page **pages, struct vm_area_struct **vmas,
-		    unsigned long *position, int *length, int i)
-{
-	unsigned long vpfn, vaddr = *position;
-	int remainder = *length;
-
-	WARN_ON(!is_vm_hugetlb_page(vma));
-
-	vpfn = vaddr/PAGE_SIZE;
-	while (vaddr < vma->vm_end && remainder) {
-		if (pages) {
-			pte_t *pte;
-			struct page *page;
-
-			pte = huge_pte_offset(mm, vaddr);
-
-			/* hugetlb should be locked, and hence, prefaulted */
-			WARN_ON(!pte || pte_none(*pte));
-
-			page = &pte_page(*pte)[vpfn % (HPAGE_SIZE/PAGE_SIZE)];
-
-			WARN_ON(!PageCompound(page));
-
-			get_page(page);
-			pages[i] = page;
-		}
-
-		if (vmas)
-			vmas[i] = vma;
-
-		vaddr += PAGE_SIZE;
-		++vpfn;
-		--remainder;
-		++i;
-	}
-
-	*length = remainder;
-	*position = vaddr;
-
-	return i;
-}
-
 struct page *
 follow_huge_addr(struct mm_struct *mm, unsigned long address, int write)
 {
@@ -396,35 +304,6 @@
 	return NULL;
 }
 
-void unmap_hugepage_range(struct vm_area_struct *vma,
-			  unsigned long start, unsigned long end)
-{
-	struct mm_struct *mm = vma->vm_mm;
-	unsigned long addr;
-	pte_t *ptep;
-	struct page *page;
-
-	WARN_ON(!is_vm_hugetlb_page(vma));
-	BUG_ON((start % HPAGE_SIZE) != 0);
-	BUG_ON((end % HPAGE_SIZE) != 0);
-
-	for (addr = start; addr < end; addr += HPAGE_SIZE) {
-		pte_t pte;
-
-		ptep = huge_pte_offset(mm, addr);
-		if (!ptep || pte_none(*ptep))
-			continue;
-
-		pte = *ptep;
-		page = pte_page(pte);
-		pte_clear(ptep);
-
-		put_page(page);
-	}
-	mm->rss -= (end - start) >> PAGE_SHIFT;
-	flush_tlb_pending();
-}
-
 void hugetlb_free_pgtables(struct mmu_gather *tlb, struct vm_area_struct *prev,
 			   unsigned long start, unsigned long end)
 {
@@ -435,60 +314,6 @@
 	 * destroy_context() to clean up the lot. */
 }
 
-int hugetlb_prefault(struct address_space *mapping, struct vm_area_struct *vma)
-{
-	struct mm_struct *mm = current->mm;
-	unsigned long addr;
-	int ret = 0;
-
-	WARN_ON(!is_vm_hugetlb_page(vma));
-	BUG_ON((vma->vm_start % HPAGE_SIZE) != 0);
-	BUG_ON((vma->vm_end % HPAGE_SIZE) != 0);
-
-	spin_lock(&mm->page_table_lock);
-	for (addr = vma->vm_start; addr < vma->vm_end; addr += HPAGE_SIZE) {
-		unsigned long idx;
-		pte_t *pte = huge_pte_alloc(mm, addr);
-		struct page *page;
-
-		if (!pte) {
-			ret = -ENOMEM;
-			goto out;
-		}
-		if (! pte_none(*pte))
-			continue;
-
-		idx = ((addr - vma->vm_start) >> HPAGE_SHIFT)
-			+ (vma->vm_pgoff >> (HPAGE_SHIFT - PAGE_SHIFT));
-		page = find_get_page(mapping, idx);
-		if (!page) {
-			/* charge the fs quota first */
-			if (hugetlb_get_quota(mapping)) {
-				ret = -ENOMEM;
-				goto out;
-			}
-			page = alloc_huge_page();
-			if (!page) {
-				hugetlb_put_quota(mapping);
-				ret = -ENOMEM;
-				goto out;
-			}
-			ret = add_to_page_cache(page, mapping, idx, GFP_ATOMIC);
-			if (! ret) {
-				unlock_page(page);
-			} else {
-				hugetlb_put_quota(mapping);
-				free_huge_page(page);
-				goto out;
-			}
-		}
-		set_huge_pte(mm, vma, page, pte, vma->vm_flags & VM_WRITE);
-	}
-out:
-	spin_unlock(&mm->page_table_lock);
-	return ret;
-}
-
 /* Because we have an exclusive hugepage region which lies within the
  * normal user address space, we have to take special measures to make
  * non-huge mmap()s evade the hugepage reserved regions. */
Index: working-2.6/arch/ia64/mm/hugetlbpage.c
===================================================================
--- working-2.6.orig/arch/ia64/mm/hugetlbpage.c	2004-08-09 09:51:26.000000000 +1000
+++ working-2.6/arch/ia64/mm/hugetlbpage.c	2004-10-29 11:38:27.134145472 +1000
@@ -24,7 +24,7 @@
 
 unsigned int hpage_shift=HPAGE_SHIFT_DEFAULT;
 
-static pte_t *
+pte_t *
 huge_pte_alloc (struct mm_struct *mm, unsigned long addr)
 {
 	unsigned long taddr = htlbpage_to_page(addr);
@@ -39,7 +39,7 @@
 	return pte;
 }
 
-static pte_t *
+pte_t *
 huge_pte_offset (struct mm_struct *mm, unsigned long addr)
 {
 	unsigned long taddr = htlbpage_to_page(addr);
@@ -57,25 +57,6 @@
 	return pte;
 }
 
-#define mk_pte_huge(entry) { pte_val(entry) |= _PAGE_P; }
-
-static void
-set_huge_pte (struct mm_struct *mm, struct vm_area_struct *vma,
-	      struct page *page, pte_t * page_table, int write_access)
-{
-	pte_t entry;
-
-	mm->rss += (HPAGE_SIZE / PAGE_SIZE);
-	if (write_access) {
-		entry =
-		    pte_mkwrite(pte_mkdirty(mk_pte(page, vma->vm_page_prot)));
-	} else
-		entry = pte_wrprotect(mk_pte(page, vma->vm_page_prot));
-	entry = pte_mkyoung(entry);
-	mk_pte_huge(entry);
-	set_pte(page_table, entry);
-	return;
-}
 /*
  * This function checks for proper alignment of input addr and len parameters.
  */
@@ -91,68 +72,6 @@
 	return 0;
 }
 
-int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
-			struct vm_area_struct *vma)
-{
-	pte_t *src_pte, *dst_pte, entry;
-	struct page *ptepage;
-	unsigned long addr = vma->vm_start;
-	unsigned long end = vma->vm_end;
-
-	while (addr < end) {
-		dst_pte = huge_pte_alloc(dst, addr);
-		if (!dst_pte)
-			goto nomem;
-		src_pte = huge_pte_offset(src, addr);
-		entry = *src_pte;
-		ptepage = pte_page(entry);
-		get_page(ptepage);
-		set_pte(dst_pte, entry);
-		dst->rss += (HPAGE_SIZE / PAGE_SIZE);
-		addr += HPAGE_SIZE;
-	}
-	return 0;
-nomem:
-	return -ENOMEM;
-}
-
-int
-follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
-		    struct page **pages, struct vm_area_struct **vmas,
-		    unsigned long *st, int *length, int i)
-{
-	pte_t *ptep, pte;
-	unsigned long start = *st;
-	unsigned long pstart;
-	int len = *length;
-	struct page *page;
-
-	do {
-		pstart = start & HPAGE_MASK;
-		ptep = huge_pte_offset(mm, start);
-		pte = *ptep;
-
-back1:
-		page = pte_page(pte);
-		if (pages) {
-			page += ((start & ~HPAGE_MASK) >> PAGE_SHIFT);
-			get_page(page);
-			pages[i] = page;
-		}
-		if (vmas)
-			vmas[i] = vma;
-		i++;
-		len--;
-		start += PAGE_SIZE;
-		if (((start & HPAGE_MASK) == pstart) && len &&
-				(start < vma->vm_end))
-			goto back1;
-	} while (len && start < vma->vm_end);
-	*length = len;
-	*st = start;
-	return i;
-}
-
 struct page *follow_huge_addr(struct mm_struct *mm, unsigned long addr, int write)
 {
 	struct page *page;
@@ -231,81 +150,6 @@
 	}
 }
 
-void unmap_hugepage_range(struct vm_area_struct *vma, unsigned long start, unsigned long end)
-{
-	struct mm_struct *mm = vma->vm_mm;
-	unsigned long address;
-	pte_t *pte;
-	struct page *page;
-
-	BUG_ON(start & (HPAGE_SIZE - 1));
-	BUG_ON(end & (HPAGE_SIZE - 1));
-
-	for (address = start; address < end; address += HPAGE_SIZE) {
-		pte = huge_pte_offset(mm, address);
-		if (pte_none(*pte))
-			continue;
-		page = pte_page(*pte);
-		put_page(page);
-		pte_clear(pte);
-	}
-	mm->rss -= (end - start) >> PAGE_SHIFT;
-	flush_tlb_range(vma, start, end);
-}
-
-int hugetlb_prefault(struct address_space *mapping, struct vm_area_struct *vma)
-{
-	struct mm_struct *mm = current->mm;
-	unsigned long addr;
-	int ret = 0;
-
-	BUG_ON(vma->vm_start & ~HPAGE_MASK);
-	BUG_ON(vma->vm_end & ~HPAGE_MASK);
-
-	spin_lock(&mm->page_table_lock);
-	for (addr = vma->vm_start; addr < vma->vm_end; addr += HPAGE_SIZE) {
-		unsigned long idx;
-		pte_t *pte = huge_pte_alloc(mm, addr);
-		struct page *page;
-
-		if (!pte) {
-			ret = -ENOMEM;
-			goto out;
-		}
-		if (!pte_none(*pte))
-			continue;
-
-		idx = ((addr - vma->vm_start) >> HPAGE_SHIFT)
-			+ (vma->vm_pgoff >> (HPAGE_SHIFT - PAGE_SHIFT));
-		page = find_get_page(mapping, idx);
-		if (!page) {
-			/* charge the fs quota first */
-			if (hugetlb_get_quota(mapping)) {
-				ret = -ENOMEM;
-				goto out;
-			}
-			page = alloc_huge_page();
-			if (!page) {
-				hugetlb_put_quota(mapping);
-				ret = -ENOMEM;
-				goto out;
-			}
-			ret = add_to_page_cache(page, mapping, idx, GFP_ATOMIC);
-			if (! ret) {
-				unlock_page(page);
-			} else {
-				hugetlb_put_quota(mapping);
-				page_cache_release(page);
-				goto out;
-			}
-		}
-		set_huge_pte(mm, vma, page, pte, vma->vm_flags & VM_WRITE);
-	}
-out:
-	spin_unlock(&mm->page_table_lock);
-	return ret;
-}
-
 unsigned long hugetlb_get_unmapped_area(struct file *file, unsigned long addr, unsigned long len,
 		unsigned long pgoff, unsigned long flags)
 {
Index: working-2.6/arch/i386/mm/hugetlbpage.c
===================================================================
--- working-2.6.orig/arch/i386/mm/hugetlbpage.c	2004-10-27 10:43:46.000000000 +1000
+++ working-2.6/arch/i386/mm/hugetlbpage.c	2004-10-29 11:44:43.541035816 +1000
@@ -18,7 +18,7 @@
 #include <asm/tlb.h>
 #include <asm/tlbflush.h>
 
-static pte_t *huge_pte_alloc(struct mm_struct *mm, unsigned long addr)
+pte_t *huge_pte_alloc(struct mm_struct *mm, unsigned long addr)
 {
 	pgd_t *pgd;
 	pmd_t *pmd = NULL;
@@ -28,7 +28,7 @@
 	return (pte_t *) pmd;
 }
 
-static pte_t *huge_pte_offset(struct mm_struct *mm, unsigned long addr)
+pte_t *huge_pte_offset(struct mm_struct *mm, unsigned long addr)
 {
 	pgd_t *pgd;
 	pmd_t *pmd = NULL;
@@ -38,21 +38,6 @@
 	return (pte_t *) pmd;
 }
 
-static void set_huge_pte(struct mm_struct *mm, struct vm_area_struct *vma, struct page *page, pte_t * page_table, int write_access)
-{
-	pte_t entry;
-
-	mm->rss += (HPAGE_SIZE / PAGE_SIZE);
-	if (write_access) {
-		entry =
-		    pte_mkwrite(pte_mkdirty(mk_pte(page, vma->vm_page_prot)));
-	} else
-		entry = pte_wrprotect(mk_pte(page, vma->vm_page_prot));
-	entry = pte_mkyoung(entry);
-	mk_pte_huge(entry);
-	set_pte(page_table, entry);
-}
-
 /*
  * This function checks for proper alignment of input addr and len parameters.
  */
@@ -65,77 +50,6 @@
 	return 0;
 }
 
-int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
-			struct vm_area_struct *vma)
-{
-	pte_t *src_pte, *dst_pte, entry;
-	struct page *ptepage;
-	unsigned long addr = vma->vm_start;
-	unsigned long end = vma->vm_end;
-
-	while (addr < end) {
-		dst_pte = huge_pte_alloc(dst, addr);
-		if (!dst_pte)
-			goto nomem;
-		src_pte = huge_pte_offset(src, addr);
-		entry = *src_pte;
-		ptepage = pte_page(entry);
-		get_page(ptepage);
-		set_pte(dst_pte, entry);
-		dst->rss += (HPAGE_SIZE / PAGE_SIZE);
-		addr += HPAGE_SIZE;
-	}
-	return 0;
-
-nomem:
-	return -ENOMEM;
-}
-
-int
-follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
-		    struct page **pages, struct vm_area_struct **vmas,
-		    unsigned long *position, int *length, int i)
-{
-	unsigned long vpfn, vaddr = *position;
-	int remainder = *length;
-
-	WARN_ON(!is_vm_hugetlb_page(vma));
-
-	vpfn = vaddr/PAGE_SIZE;
-	while (vaddr < vma->vm_end && remainder) {
-
-		if (pages) {
-			pte_t *pte;
-			struct page *page;
-
-			pte = huge_pte_offset(mm, vaddr);
-
-			/* hugetlb should be locked, and hence, prefaulted */
-			WARN_ON(!pte || pte_none(*pte));
-
-			page = &pte_page(*pte)[vpfn % (HPAGE_SIZE/PAGE_SIZE)];
-
-			WARN_ON(!PageCompound(page));
-
-			get_page(page);
-			pages[i] = page;
-		}
-
-		if (vmas)
-			vmas[i] = vma;
-
-		vaddr += PAGE_SIZE;
-		++vpfn;
-		--remainder;
-		++i;
-	}
-
-	*length = remainder;
-	*position = vaddr;
-
-	return i;
-}
-
 #if 0	/* This is just for testing */
 struct page *
 follow_huge_addr(struct mm_struct *mm, unsigned long address, int write)
@@ -200,87 +114,15 @@
 }
 #endif
 
-void unmap_hugepage_range(struct vm_area_struct *vma,
-		unsigned long start, unsigned long end)
+void hugetlb_clean_stale_pgtable(pte_t *pte)
 {
-	struct mm_struct *mm = vma->vm_mm;
-	unsigned long address;
-	pte_t pte;
+	pmd_t *pmd = (pmd_t *) pte;
 	struct page *page;
 
-	BUG_ON(start & (HPAGE_SIZE - 1));
-	BUG_ON(end & (HPAGE_SIZE - 1));
-
-	for (address = start; address < end; address += HPAGE_SIZE) {
-		pte = ptep_get_and_clear(huge_pte_offset(mm, address));
-		if (pte_none(pte))
-			continue;
-		page = pte_page(pte);
-		put_page(page);
-	}
-	mm->rss -= (end - start) >> PAGE_SHIFT;
-	flush_tlb_range(vma, start, end);
-}
-
-int hugetlb_prefault(struct address_space *mapping, struct vm_area_struct *vma)
-{
-	struct mm_struct *mm = current->mm;
-	unsigned long addr;
-	int ret = 0;
-
-	BUG_ON(vma->vm_start & ~HPAGE_MASK);
-	BUG_ON(vma->vm_end & ~HPAGE_MASK);
-
-	spin_lock(&mm->page_table_lock);
-	for (addr = vma->vm_start; addr < vma->vm_end; addr += HPAGE_SIZE) {
-		unsigned long idx;
-		pte_t *pte = huge_pte_alloc(mm, addr);
-		struct page *page;
-
-		if (!pte) {
-			ret = -ENOMEM;
-			goto out;
-		}
-
-		if (!pte_none(*pte)) {
-			pmd_t *pmd = (pmd_t *) pte;
-
-			page = pmd_page(*pmd);
-			pmd_clear(pmd);
-			mm->nr_ptes--;
-			dec_page_state(nr_page_table_pages);
-			page_cache_release(page);
-		}
-
-		idx = ((addr - vma->vm_start) >> HPAGE_SHIFT)
-			+ (vma->vm_pgoff >> (HPAGE_SHIFT - PAGE_SHIFT));
-		page = find_get_page(mapping, idx);
-		if (!page) {
-			/* charge the fs quota first */
-			if (hugetlb_get_quota(mapping)) {
-				ret = -ENOMEM;
-				goto out;
-			}
-			page = alloc_huge_page();
-			if (!page) {
-				hugetlb_put_quota(mapping);
-				ret = -ENOMEM;
-				goto out;
-			}
-			ret = add_to_page_cache(page, mapping, idx, GFP_ATOMIC);
-			if (! ret) {
-				unlock_page(page);
-			} else {
-				hugetlb_put_quota(mapping);
-				free_huge_page(page);
-				goto out;
-			}
-		}
-		set_huge_pte(mm, vma, page, pte, vma->vm_flags & VM_WRITE);
-	}
-out:
-	spin_unlock(&mm->page_table_lock);
-	return ret;
+	page = pmd_page(*pmd);
+	pmd_clear(pmd);
+	dec_page_state(nr_page_table_pages);
+	page_cache_release(page);
 }
 
 /* x86_64 also uses this file */
Index: working-2.6/arch/sh64/mm/hugetlbpage.c
===================================================================
--- working-2.6.orig/arch/sh64/mm/hugetlbpage.c	2004-08-09 09:51:41.000000000 +1000
+++ working-2.6/arch/sh64/mm/hugetlbpage.c	2004-10-29 11:38:27.137145016 +1000
@@ -24,7 +24,7 @@
 #include <asm/tlbflush.h>
 #include <asm/cacheflush.h>
 
-static pte_t *huge_pte_alloc(struct mm_struct *mm, unsigned long addr)
+pte_t *huge_pte_alloc(struct mm_struct *mm, unsigned long addr)
 {
 	pgd_t *pgd;
 	pmd_t *pmd;
@@ -39,7 +39,7 @@
 	return pte;
 }
 
-static pte_t *huge_pte_offset(struct mm_struct *mm, unsigned long addr)
+pte_t *huge_pte_offset(struct mm_struct *mm, unsigned long addr)
 {
 	pgd_t *pgd;
 	pmd_t *pmd;
@@ -54,23 +54,9 @@
 	return pte;
 }
 
-#define mk_pte_huge(entry) do { pte_val(entry) |= _PAGE_SZHUGE; } while (0)
-
-static void set_huge_pte(struct mm_struct *mm, struct vm_area_struct *vma,
-			 struct page *page, pte_t * page_table, int write_access)
+void set_huge_pte(pte_t *page_table, pte_t entry)
 {
 	unsigned long i;
-	pte_t entry;
-
-	mm->rss += (HPAGE_SIZE / PAGE_SIZE);
-
-	if (write_access)
-		entry = pte_mkwrite(pte_mkdirty(mk_pte(page,
-						       vma->vm_page_prot)));
-	else
-		entry = pte_wrprotect(mk_pte(page, vma->vm_page_prot));
-	entry = pte_mkyoung(entry);
-	mk_pte_huge(entry);
 
 	for (i = 0; i < (1 << HUGETLB_PAGE_ORDER); i++) {
 		set_pte(page_table, entry);
@@ -80,6 +66,20 @@
 	}
 }
 
+pte_t huge_ptep_get_and_clear(pte_t *ptep)
+{
+	pte_t entry;
+
+	entry = *ptep;
+
+	for (i = 0; i < (1 << HUGETLB_PAGE_ORDER); i++) {
+		pte_clear(pte);
+		pte++;
+	}
+
+	return entry;
+}
+
 /*
  * This function checks for proper alignment of input addr and len parameters.
  */
@@ -92,79 +92,6 @@
 	return 0;
 }
 
-int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
-			    struct vm_area_struct *vma)
-{
-	pte_t *src_pte, *dst_pte, entry;
-	struct page *ptepage;
-	unsigned long addr = vma->vm_start;
-	unsigned long end = vma->vm_end;
-	int i;
-
-	while (addr < end) {
-		dst_pte = huge_pte_alloc(dst, addr);
-		if (!dst_pte)
-			goto nomem;
-		src_pte = huge_pte_offset(src, addr);
-		BUG_ON(!src_pte || pte_none(*src_pte));
-		entry = *src_pte;
-		ptepage = pte_page(entry);
-		get_page(ptepage);
-		for (i = 0; i < (1 << HUGETLB_PAGE_ORDER); i++) {
-			set_pte(dst_pte, entry);
-			pte_val(entry) += PAGE_SIZE;
-			dst_pte++;
-		}
-		dst->rss += (HPAGE_SIZE / PAGE_SIZE);
-		addr += HPAGE_SIZE;
-	}
-	return 0;
-
-nomem:
-	return -ENOMEM;
-}
-
-int follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
-			struct page **pages, struct vm_area_struct **vmas,
-			unsigned long *position, int *length, int i)
-{
-	unsigned long vaddr = *position;
-	int remainder = *length;
-
-	WARN_ON(!is_vm_hugetlb_page(vma));
-
-	while (vaddr < vma->vm_end && remainder) {
-		if (pages) {
-			pte_t *pte;
-			struct page *page;
-
-			pte = huge_pte_offset(mm, vaddr);
-
-			/* hugetlb should be locked, and hence, prefaulted */
-			BUG_ON(!pte || pte_none(*pte));
-
-			page = pte_page(*pte);
-
-			WARN_ON(!PageCompound(page));
-
-			get_page(page);
-			pages[i] = page;
-		}
-
-		if (vmas)
-			vmas[i] = vma;
-
-		vaddr += PAGE_SIZE;
-		--remainder;
-		++i;
-	}
-
-	*length = remainder;
-	*position = vaddr;
-
-	return i;
-}
-
 struct page *follow_huge_addr(struct mm_struct *mm,
 			      unsigned long address, int write)
 {
@@ -181,84 +108,3 @@
 {
 	return NULL;
 }
-
-void unmap_hugepage_range(struct vm_area_struct *vma,
-			  unsigned long start, unsigned long end)
-{
-	struct mm_struct *mm = vma->vm_mm;
-	unsigned long address;
-	pte_t *pte;
-	struct page *page;
-	int i;
-
-	BUG_ON(start & (HPAGE_SIZE - 1));
-	BUG_ON(end & (HPAGE_SIZE - 1));
-
-	for (address = start; address < end; address += HPAGE_SIZE) {
-		pte = huge_pte_offset(mm, address);
-		BUG_ON(!pte);
-		if (pte_none(*pte))
-			continue;
-		page = pte_page(*pte);
-		put_page(page);
-		for (i = 0; i < (1 << HUGETLB_PAGE_ORDER); i++) {
-			pte_clear(pte);
-			pte++;
-		}
-	}
-	mm->rss -= (end - start) >> PAGE_SHIFT;
-	flush_tlb_range(vma, start, end);
-}
-
-int hugetlb_prefault(struct address_space *mapping, struct vm_area_struct *vma)
-{
-	struct mm_struct *mm = current->mm;
-	unsigned long addr;
-	int ret = 0;
-
-	BUG_ON(vma->vm_start & ~HPAGE_MASK);
-	BUG_ON(vma->vm_end & ~HPAGE_MASK);
-
-	spin_lock(&mm->page_table_lock);
-	for (addr = vma->vm_start; addr < vma->vm_end; addr += HPAGE_SIZE) {
-		unsigned long idx;
-		pte_t *pte = huge_pte_alloc(mm, addr);
-		struct page *page;
-
-		if (!pte) {
-			ret = -ENOMEM;
-			goto out;
-		}
-		if (!pte_none(*pte))
-			continue;
-
-		idx = ((addr - vma->vm_start) >> HPAGE_SHIFT)
-			+ (vma->vm_pgoff >> (HPAGE_SHIFT - PAGE_SHIFT));
-		page = find_get_page(mapping, idx);
-		if (!page) {
-			/* charge the fs quota first */
-			if (hugetlb_get_quota(mapping)) {
-				ret = -ENOMEM;
-				goto out;
-			}
-			page = alloc_huge_page();
-			if (!page) {
-				hugetlb_put_quota(mapping);
-				ret = -ENOMEM;
-				goto out;
-			}
-			ret = add_to_page_cache(page, mapping, idx, GFP_ATOMIC);
-			if (! ret) {
-				unlock_page(page);
-			} else {
-				hugetlb_put_quota(mapping);
-				free_huge_page(page);
-				goto out;
-			}
-		}
-		set_huge_pte(mm, vma, page, pte, vma->vm_flags & VM_WRITE);
-	}
-out:
-	spin_unlock(&mm->page_table_lock);
-	return ret;
-}
Index: working-2.6/arch/sh/mm/hugetlbpage.c
===================================================================
--- working-2.6.orig/arch/sh/mm/hugetlbpage.c	2004-08-09 09:51:40.000000000 +1000
+++ working-2.6/arch/sh/mm/hugetlbpage.c	2004-10-29 11:38:27.138144864 +1000
@@ -24,7 +24,7 @@
 #include <asm/tlbflush.h>
 #include <asm/cacheflush.h>
 
-static pte_t *huge_pte_alloc(struct mm_struct *mm, unsigned long addr)
+pte_t *huge_pte_alloc(struct mm_struct *mm, unsigned long addr)
 {
 	pgd_t *pgd;
 	pmd_t *pmd;
@@ -39,7 +39,7 @@
 	return pte;
 }
 
-static pte_t *huge_pte_offset(struct mm_struct *mm, unsigned long addr)
+pte_t *huge_pte_offset(struct mm_struct *mm, unsigned long addr)
 {
 	pgd_t *pgd;
 	pmd_t *pmd;
@@ -54,23 +54,9 @@
 	return pte;
 }
 
-#define mk_pte_huge(entry) do { pte_val(entry) |= _PAGE_SZHUGE; } while (0)
-
-static void set_huge_pte(struct mm_struct *mm, struct vm_area_struct *vma,
-			 struct page *page, pte_t * page_table, int write_access)
+void set_huge_pte(pte_t *page_table, pte_t entry)
 {
 	unsigned long i;
-	pte_t entry;
-
-	mm->rss += (HPAGE_SIZE / PAGE_SIZE);
-
-	if (write_access)
-		entry = pte_mkwrite(pte_mkdirty(mk_pte(page,
-						       vma->vm_page_prot)));
-	else
-		entry = pte_wrprotect(mk_pte(page, vma->vm_page_prot));
-	entry = pte_mkyoung(entry);
-	mk_pte_huge(entry);
 
 	for (i = 0; i < (1 << HUGETLB_PAGE_ORDER); i++) {
 		set_pte(page_table, entry);
@@ -80,6 +66,20 @@
 	}
 }
 
+pte_t huge_ptep_get_and_clear(pte_t *ptep)
+{
+	pte_t entry;
+
+	entry = *ptep;
+
+	for (i = 0; i < (1 << HUGETLB_PAGE_ORDER); i++) {
+		pte_clear(pte);
+		pte++;
+	}
+
+	return entry;
+}
+
 /*
  * This function checks for proper alignment of input addr and len parameters.
  */
@@ -92,79 +92,6 @@
 	return 0;
 }
 
-int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
-			    struct vm_area_struct *vma)
-{
-	pte_t *src_pte, *dst_pte, entry;
-	struct page *ptepage;
-	unsigned long addr = vma->vm_start;
-	unsigned long end = vma->vm_end;
-	int i;
-
-	while (addr < end) {
-		dst_pte = huge_pte_alloc(dst, addr);
-		if (!dst_pte)
-			goto nomem;
-		src_pte = huge_pte_offset(src, addr);
-		BUG_ON(!src_pte || pte_none(*src_pte));
-		entry = *src_pte;
-		ptepage = pte_page(entry);
-		get_page(ptepage);
-		for (i = 0; i < (1 << HUGETLB_PAGE_ORDER); i++) {
-			set_pte(dst_pte, entry);
-			pte_val(entry) += PAGE_SIZE;
-			dst_pte++;
-		}
-		dst->rss += (HPAGE_SIZE / PAGE_SIZE);
-		addr += HPAGE_SIZE;
-	}
-	return 0;
-
-nomem:
-	return -ENOMEM;
-}
-
-int follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
-			struct page **pages, struct vm_area_struct **vmas,
-			unsigned long *position, int *length, int i)
-{
-	unsigned long vaddr = *position;
-	int remainder = *length;
-
-	WARN_ON(!is_vm_hugetlb_page(vma));
-
-	while (vaddr < vma->vm_end && remainder) {
-		if (pages) {
-			pte_t *pte;
-			struct page *page;
-
-			pte = huge_pte_offset(mm, vaddr);
-
-			/* hugetlb should be locked, and hence, prefaulted */
-			BUG_ON(!pte || pte_none(*pte));
-
-			page = pte_page(*pte);
-
-			WARN_ON(!PageCompound(page));
-
-			get_page(page);
-			pages[i] = page;
-		}
-
-		if (vmas)
-			vmas[i] = vma;
-
-		vaddr += PAGE_SIZE;
-		--remainder;
-		++i;
-	}
-
-	*length = remainder;
-	*position = vaddr;
-
-	return i;
-}
-
 struct page *follow_huge_addr(struct mm_struct *mm,
 			      unsigned long address, int write)
 {
@@ -181,84 +108,3 @@
 {
 	return NULL;
 }
-
-void unmap_hugepage_range(struct vm_area_struct *vma,
-			  unsigned long start, unsigned long end)
-{
-	struct mm_struct *mm = vma->vm_mm;
-	unsigned long address;
-	pte_t *pte;
-	struct page *page;
-	int i;
-
-	BUG_ON(start & (HPAGE_SIZE - 1));
-	BUG_ON(end & (HPAGE_SIZE - 1));
-
-	for (address = start; address < end; address += HPAGE_SIZE) {
-		pte = huge_pte_offset(mm, address);
-		BUG_ON(!pte);
-		if (pte_none(*pte))
-			continue;
-		page = pte_page(*pte);
-		put_page(page);
-		for (i = 0; i < (1 << HUGETLB_PAGE_ORDER); i++) {
-			pte_clear(pte);
-			pte++;
-		}
-	}
-	mm->rss -= (end - start) >> PAGE_SHIFT;
-	flush_tlb_range(vma, start, end);
-}
-
-int hugetlb_prefault(struct address_space *mapping, struct vm_area_struct *vma)
-{
-	struct mm_struct *mm = current->mm;
-	unsigned long addr;
-	int ret = 0;
-
-	BUG_ON(vma->vm_start & ~HPAGE_MASK);
-	BUG_ON(vma->vm_end & ~HPAGE_MASK);
-
-	spin_lock(&mm->page_table_lock);
-	for (addr = vma->vm_start; addr < vma->vm_end; addr += HPAGE_SIZE) {
-		unsigned long idx;
-		pte_t *pte = huge_pte_alloc(mm, addr);
-		struct page *page;
-
-		if (!pte) {
-			ret = -ENOMEM;
-			goto out;
-		}
-		if (!pte_none(*pte))
-			continue;
-
-		idx = ((addr - vma->vm_start) >> HPAGE_SHIFT)
-			+ (vma->vm_pgoff >> (HPAGE_SHIFT - PAGE_SHIFT));
-		page = find_get_page(mapping, idx);
-		if (!page) {
-			/* charge the fs quota first */
-			if (hugetlb_get_quota(mapping)) {
-				ret = -ENOMEM;
-				goto out;
-			}
-			page = alloc_huge_page();
-			if (!page) {
-				hugetlb_put_quota(mapping);
-				ret = -ENOMEM;
-				goto out;
-			}
-			ret = add_to_page_cache(page, mapping, idx, GFP_ATOMIC);
-			if (! ret) {
-				unlock_page(page);
-			} else {
-				hugetlb_put_quota(mapping);
-				free_huge_page(page);
-				goto out;
-			}
-		}
-		set_huge_pte(mm, vma, page, pte, vma->vm_flags & VM_WRITE);
-	}
-out:
-	spin_unlock(&mm->page_table_lock);
-	return ret;
-}
Index: working-2.6/arch/sparc64/mm/hugetlbpage.c
===================================================================
--- working-2.6.orig/arch/sparc64/mm/hugetlbpage.c	2004-08-09 09:51:42.000000000 +1000
+++ working-2.6/arch/sparc64/mm/hugetlbpage.c	2004-10-29 11:38:27.138144864 +1000
@@ -21,7 +21,7 @@
 #include <asm/tlbflush.h>
 #include <asm/cacheflush.h>
 
-static pte_t *huge_pte_alloc(struct mm_struct *mm, unsigned long addr)
+pte_t *huge_pte_alloc(struct mm_struct *mm, unsigned long addr)
 {
 	pgd_t *pgd;
 	pmd_t *pmd;
@@ -36,7 +36,7 @@
 	return pte;
 }
 
-static pte_t *huge_pte_offset(struct mm_struct *mm, unsigned long addr)
+pte_t *huge_pte_offset(struct mm_struct *mm, unsigned long addr)
 {
 	pgd_t *pgd;
 	pmd_t *pmd;
@@ -51,23 +51,9 @@
 	return pte;
 }
 
-#define mk_pte_huge(entry) do { pte_val(entry) |= _PAGE_SZHUGE; } while (0)
-
-static void set_huge_pte(struct mm_struct *mm, struct vm_area_struct *vma,
-			 struct page *page, pte_t * page_table, int write_access)
+void set_huge_pte(pte_t *page_table, pte_t entry)
 {
 	unsigned long i;
-	pte_t entry;
-
-	mm->rss += (HPAGE_SIZE / PAGE_SIZE);
-
-	if (write_access)
-		entry = pte_mkwrite(pte_mkdirty(mk_pte(page,
-						       vma->vm_page_prot)));
-	else
-		entry = pte_wrprotect(mk_pte(page, vma->vm_page_prot));
-	entry = pte_mkyoung(entry);
-	mk_pte_huge(entry);
 
 	for (i = 0; i < (1 << HUGETLB_PAGE_ORDER); i++) {
 		set_pte(page_table, entry);
@@ -77,6 +63,20 @@
 	}
 }
 
+pte_t huge_ptep_get_and_clear(pte_t *ptep)
+{
+	pte_t entry;
+
+	entry = *ptep;
+
+	for (i = 0; i < (1 << HUGETLB_PAGE_ORDER); i++) {
+		pte_clear(pte);
+		pte++;
+	}
+
+	return entry;
+}
+
 /*
  * This function checks for proper alignment of input addr and len parameters.
  */
@@ -89,79 +89,6 @@
 	return 0;
 }
 
-int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
-			    struct vm_area_struct *vma)
-{
-	pte_t *src_pte, *dst_pte, entry;
-	struct page *ptepage;
-	unsigned long addr = vma->vm_start;
-	unsigned long end = vma->vm_end;
-	int i;
-
-	while (addr < end) {
-		dst_pte = huge_pte_alloc(dst, addr);
-		if (!dst_pte)
-			goto nomem;
-		src_pte = huge_pte_offset(src, addr);
-		BUG_ON(!src_pte || pte_none(*src_pte));
-		entry = *src_pte;
-		ptepage = pte_page(entry);
-		get_page(ptepage);
-		for (i = 0; i < (1 << HUGETLB_PAGE_ORDER); i++) {
-			set_pte(dst_pte, entry);
-			pte_val(entry) += PAGE_SIZE;
-			dst_pte++;
-		}
-		dst->rss += (HPAGE_SIZE / PAGE_SIZE);
-		addr += HPAGE_SIZE;
-	}
-	return 0;
-
-nomem:
-	return -ENOMEM;
-}
-
-int follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
-			struct page **pages, struct vm_area_struct **vmas,
-			unsigned long *position, int *length, int i)
-{
-	unsigned long vaddr = *position;
-	int remainder = *length;
-
-	WARN_ON(!is_vm_hugetlb_page(vma));
-
-	while (vaddr < vma->vm_end && remainder) {
-		if (pages) {
-			pte_t *pte;
-			struct page *page;
-
-			pte = huge_pte_offset(mm, vaddr);
-
-			/* hugetlb should be locked, and hence, prefaulted */
-			BUG_ON(!pte || pte_none(*pte));
-
-			page = pte_page(*pte);
-
-			WARN_ON(!PageCompound(page));
-
-			get_page(page);
-			pages[i] = page;
-		}
-
-		if (vmas)
-			vmas[i] = vma;
-
-		vaddr += PAGE_SIZE;
-		--remainder;
-		++i;
-	}
-
-	*length = remainder;
-	*position = vaddr;
-
-	return i;
-}
-
 struct page *follow_huge_addr(struct mm_struct *mm,
 			      unsigned long address, int write)
 {
@@ -178,84 +105,3 @@
 {
 	return NULL;
 }
-
-void unmap_hugepage_range(struct vm_area_struct *vma,
-			  unsigned long start, unsigned long end)
-{
-	struct mm_struct *mm = vma->vm_mm;
-	unsigned long address;
-	pte_t *pte;
-	struct page *page;
-	int i;
-
-	BUG_ON(start & (HPAGE_SIZE - 1));
-	BUG_ON(end & (HPAGE_SIZE - 1));
-
-	for (address = start; address < end; address += HPAGE_SIZE) {
-		pte = huge_pte_offset(mm, address);
-		BUG_ON(!pte);
-		if (pte_none(*pte))
-			continue;
-		page = pte_page(*pte);
-		put_page(page);
-		for (i = 0; i < (1 << HUGETLB_PAGE_ORDER); i++) {
-			pte_clear(pte);
-			pte++;
-		}
-	}
-	mm->rss -= (end - start) >> PAGE_SHIFT;
-	flush_tlb_range(vma, start, end);
-}
-
-int hugetlb_prefault(struct address_space *mapping, struct vm_area_struct *vma)
-{
-	struct mm_struct *mm = current->mm;
-	unsigned long addr;
-	int ret = 0;
-
-	BUG_ON(vma->vm_start & ~HPAGE_MASK);
-	BUG_ON(vma->vm_end & ~HPAGE_MASK);
-
-	spin_lock(&mm->page_table_lock);
-	for (addr = vma->vm_start; addr < vma->vm_end; addr += HPAGE_SIZE) {
-		unsigned long idx;
-		pte_t *pte = huge_pte_alloc(mm, addr);
-		struct page *page;
-
-		if (!pte) {
-			ret = -ENOMEM;
-			goto out;
-		}
-		if (!pte_none(*pte))
-			continue;
-
-		idx = ((addr - vma->vm_start) >> HPAGE_SHIFT)
-			+ (vma->vm_pgoff >> (HPAGE_SHIFT - PAGE_SHIFT));
-		page = find_get_page(mapping, idx);
-		if (!page) {
-			/* charge the fs quota first */
-			if (hugetlb_get_quota(mapping)) {
-				ret = -ENOMEM;
-				goto out;
-			}
-			page = alloc_huge_page();
-			if (!page) {
-				hugetlb_put_quota(mapping);
-				ret = -ENOMEM;
-				goto out;
-			}
-			ret = add_to_page_cache(page, mapping, idx, GFP_ATOMIC);
-			if (! ret) {
-				unlock_page(page);
-			} else {
-				hugetlb_put_quota(mapping);
-				free_huge_page(page);
-				goto out;
-			}
-		}
-		set_huge_pte(mm, vma, page, pte, vma->vm_flags & VM_WRITE);
-	}
-out:
-	spin_unlock(&mm->page_table_lock);
-	return ret;
-}
Index: working-2.6/include/asm-sh/pgtable.h
===================================================================
--- working-2.6.orig/include/asm-sh/pgtable.h	2004-10-29 10:15:21.000000000 +1000
+++ working-2.6/include/asm-sh/pgtable.h	2004-10-29 11:38:27.139144712 +1000
@@ -194,6 +194,7 @@
 static inline pte_t pte_mkdirty(pte_t pte)	{ set_pte(&pte, __pte(pte_val(pte) | _PAGE_DIRTY)); return pte; }
 static inline pte_t pte_mkyoung(pte_t pte)	{ set_pte(&pte, __pte(pte_val(pte) | _PAGE_ACCESSED)); return pte; }
 static inline pte_t pte_mkwrite(pte_t pte)	{ set_pte(&pte, __pte(pte_val(pte) | _PAGE_RW)); return pte; }
+static inline pte_t pte_mkhuge(pte_t pte)	{ set_pte(&pte, __pte(pte_val(pte) | _PAGE_SZHUGE)); return pte; }
 
 /*
  * Macro and implementation to make a page protection as uncachable.
Index: working-2.6/include/asm-ia64/pgtable.h
===================================================================
--- working-2.6.orig/include/asm-ia64/pgtable.h	2004-10-29 10:15:20.000000000 +1000
+++ working-2.6/include/asm-ia64/pgtable.h	2004-10-29 11:38:27.140144560 +1000
@@ -281,6 +281,7 @@
 #define pte_mkyoung(pte)	(__pte(pte_val(pte) | _PAGE_A))
 #define pte_mkclean(pte)	(__pte(pte_val(pte) & ~_PAGE_D))
 #define pte_mkdirty(pte)	(__pte(pte_val(pte) | _PAGE_D))
+#define pte_mkhuge(entry)	(__pte(pte_val(pte) | _PAGE_P))
 
 /*
  * Macro to a page protection value as "uncacheable".  Note that "protection" is really a
Index: working-2.6/include/asm-i386/pgtable.h
===================================================================
--- working-2.6.orig/include/asm-i386/pgtable.h	2004-10-21 11:55:01.000000000 +1000
+++ working-2.6/include/asm-i386/pgtable.h	2004-10-29 11:38:27.141144408 +1000
@@ -236,6 +236,7 @@
 static inline pte_t pte_mkdirty(pte_t pte)	{ (pte).pte_low |= _PAGE_DIRTY; return pte; }
 static inline pte_t pte_mkyoung(pte_t pte)	{ (pte).pte_low |= _PAGE_ACCESSED; return pte; }
 static inline pte_t pte_mkwrite(pte_t pte)	{ (pte).pte_low |= _PAGE_RW; return pte; }
+static inline pte_t pte_mkhuge(pte_t pte)	{ (pte).pte_low |= _PAGE_PRESENT | _PAGE_PSE; return pte; }
 
 #ifdef CONFIG_X86_PAE
 # include <asm/pgtable-3level.h>
@@ -273,7 +274,6 @@
  */
 
 #define mk_pte(page, pgprot)	pfn_pte(page_to_pfn(page), (pgprot))
-#define mk_pte_huge(entry) ((entry).pte_low |= _PAGE_PRESENT | _PAGE_PSE)
 
 static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
 {
Index: working-2.6/include/asm-sparc64/page.h
===================================================================
--- working-2.6.orig/include/asm-sparc64/page.h	2004-08-09 09:52:58.000000000 +1000
+++ working-2.6/include/asm-sparc64/page.h	2004-10-29 11:38:27.141144408 +1000
@@ -93,6 +93,7 @@
 #define HPAGE_SIZE		(_AC(1,UL) << HPAGE_SHIFT)
 #define HPAGE_MASK		(~(HPAGE_SIZE - 1UL))
 #define HUGETLB_PAGE_ORDER	(HPAGE_SHIFT - PAGE_SHIFT)
+#define ARCH_HAS_SETCLEAR_HUGE_PTE
 #endif
 
 #define TASK_UNMAPPED_BASE	(test_thread_flag(TIF_32BIT) ? \
Index: working-2.6/include/asm-sparc64/pgtable.h
===================================================================
--- working-2.6.orig/include/asm-sparc64/pgtable.h	2004-08-11 10:28:33.000000000 +1000
+++ working-2.6/include/asm-sparc64/pgtable.h	2004-10-29 11:38:27.142144256 +1000
@@ -302,6 +302,7 @@
 #define pte_mkyoung(pte)	(__pte(pte_val(pte) | _PAGE_ACCESSED | _PAGE_R))
 #define pte_mkwrite(pte)	(__pte(pte_val(pte) | _PAGE_WRITE))
 #define pte_mkdirty(pte)	(__pte(pte_val(pte) | _PAGE_MODIFIED | _PAGE_W))
+#define pte_mkhuge(pte)		(__pte(pte_val(pte) | _PAGE_SZHUGE))
 
 /* to find an entry in a page-table-directory. */
 #define pgd_index(address)	(((address) >> PGDIR_SHIFT) & (PTRS_PER_PGD))
Index: working-2.6/include/asm-sh/page.h
===================================================================
--- working-2.6.orig/include/asm-sh/page.h	2004-10-19 17:17:04.000000000 +1000
+++ working-2.6/include/asm-sh/page.h	2004-10-29 11:38:27.142144256 +1000
@@ -31,6 +31,7 @@
 #define HPAGE_SIZE		(1UL << HPAGE_SHIFT)
 #define HPAGE_MASK		(~(HPAGE_SIZE-1))
 #define HUGETLB_PAGE_ORDER	(HPAGE_SHIFT-PAGE_SHIFT)
+#define ARCH_HAS_SETCLEAR_HUGE_PTE
 #endif
 
 #ifdef __KERNEL__
Index: working-2.6/include/asm-sh64/pgtable.h
===================================================================
--- working-2.6.orig/include/asm-sh64/pgtable.h	2004-10-21 11:55:01.000000000 +1000
+++ working-2.6/include/asm-sh64/pgtable.h	2004-10-29 11:38:27.143144104 +1000
@@ -429,6 +429,8 @@
 extern inline pte_t pte_mkexec(pte_t pte)	{ set_pte(&pte, __pte(pte_val(pte) | _PAGE_EXECUTE)); return pte; }
 extern inline pte_t pte_mkdirty(pte_t pte)	{ set_pte(&pte, __pte(pte_val(pte) | _PAGE_DIRTY)); return pte; }
 extern inline pte_t pte_mkyoung(pte_t pte)	{ set_pte(&pte, __pte(pte_val(pte) | _PAGE_ACCESSED)); return pte; }
+extern inline pte_t pte_mkhuge(pte_t pte)	{ set_pte(&pte, __pte(pte_val(pte) | _PAGE_SZHUGE)); return pte; }
+
 
 /*
  * Conversion functions: convert a page and protection to a page entry.
Index: working-2.6/include/asm-sh64/page.h
===================================================================
--- working-2.6.orig/include/asm-sh64/page.h	2004-08-09 09:52:55.000000000 +1000
+++ working-2.6/include/asm-sh64/page.h	2004-10-29 11:38:27.144143952 +1000
@@ -41,6 +41,7 @@
 #define HPAGE_SIZE		(1UL << HPAGE_SHIFT)
 #define HPAGE_MASK		(~(HPAGE_SIZE-1))
 #define HUGETLB_PAGE_ORDER	(HPAGE_SHIFT-PAGE_SHIFT)
+#define ARCH_HAS_SETCLEAR_HUGE_PTE
 #endif
 
 #ifdef __KERNEL__
Index: working-2.6/include/linux/hugetlb.h
===================================================================
--- working-2.6.orig/include/linux/hugetlb.h	2004-08-09 09:53:01.000000000 +1000
+++ working-2.6/include/linux/hugetlb.h	2004-10-29 11:38:27.144143952 +1000
@@ -47,6 +47,20 @@
 int prepare_hugepage_range(unsigned long addr, unsigned long len);
 #endif
 
+#ifndef ARCH_HAS_SETCLEAR_HUGE_PTE
+#define set_huge_pte(ptep, pte)	set_pte(ptep, pte)
+#define huge_ptep_get_and_clear(ptep) ptep_get_and_clear(ptep)
+#else
+void set_huge_pte(pte_t *ptep, pte_t pte);
+pte_t huge_ptep_get_and_clear(pte_t *ptep);
+#endif
+
+#ifndef ARCH_HAS_HUGETLB_CLEAN_STALE_PGTABLE
+#define hugetlb_clean_stale_pgtable(pte)	BUG()
+#else
+void hugetlb_clean_stale_pgtable(pte_t *pte);
+#endif
+
 #else /* !CONFIG_HUGETLB_PAGE */
 
 static inline int is_vm_hugetlb_page(struct vm_area_struct *vma)
Index: working-2.6/include/asm-i386/page.h
===================================================================
--- working-2.6.orig/include/asm-i386/page.h	2004-10-27 10:43:47.000000000 +1000
+++ working-2.6/include/asm-i386/page.h	2004-10-29 11:39:01.817064456 +1000
@@ -64,6 +64,7 @@
 #define HPAGE_MASK	(~(HPAGE_SIZE - 1))
 #define HUGETLB_PAGE_ORDER	(HPAGE_SHIFT - PAGE_SHIFT)
 #define HAVE_ARCH_HUGETLB_UNMAPPED_AREA
+#define ARCH_HAS_HUGETLB_CLEAN_STALE_PGTABLE
 #endif
 
 

-- 
David Gibson			| For every complex problem there is a
david AT gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson
