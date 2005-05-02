Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261621AbVEBEcu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261621AbVEBEcu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 May 2005 00:32:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261626AbVEBEcu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 May 2005 00:32:50 -0400
Received: from ozlabs.org ([203.10.76.45]:47037 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261621AbVEBEap (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 May 2005 00:30:45 -0400
Date: Mon, 2 May 2005 14:30:35 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Andrew Morton <akpm@osdl.org>
Cc: Adam Litke <agl@us.ibm.com>, Andy Whitcroft <apw@shadowen.org>,
       William Lee Irwin <wli@holomorphy.com>,
       Paul Mackerras <paulus@samba.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       linux-kernel@vger.kernel.org
Subject: Hugepage consolidation
Message-ID: <20050502043035.GB12670@localhost.localdomain>
Mail-Followup-To: David Gibson <david@gibson.dropbear.id.au>,
	Andrew Morton <akpm@osdl.org>, Adam Litke <agl@us.ibm.com>,
	Andy Whitcroft <apw@shadowen.org>,
	William Lee Irwin <wli@holomorphy.com>,
	Paul Mackerras <paulus@samba.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew, please apply to -mm (for now).  Last time I posted this patch
wli objected on the grounds that he wanted to sort out some hugepage
bugs first.  I hope he's made some progress there, but if not, I'm
inclined to think that reducing the amount of code those bugs could be
living in in can only be a good thing...

A lot of the code in arch/*/mm/hugetlbpage.c is quite similar.  This
patch attempts to consolidate a lot of the code across the arch's,
putting the combined version in mm/hugetlb.c.  There are a couple of
uglyish hacks in order to covert all the hugepage archs, but the
result is a very large reduction in the total amount of code.  It also
means things like hugepage lazy allocation could be implemented in one
place, instead of six.

Tested, at least a little, on ppc64, i386 and x86_64.

Notes:
	- this patch changes the meaning of set_huge_pte() to be more
	  analagous to set_pte()
	- does SH4 need s special huge_ptep_get_and_clear()??

Index: working-2.6/mm/hugetlb.c
===================================================================
--- working-2.6.orig/mm/hugetlb.c	2005-04-26 15:38:03.000000000 +1000
+++ working-2.6/mm/hugetlb.c	2005-05-02 13:24:19.000000000 +1000
@@ -7,10 +7,14 @@
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/mm.h>
-#include <linux/hugetlb.h>
 #include <linux/sysctl.h>
 #include <linux/highmem.h>
 #include <linux/nodemask.h>
+#include <linux/pagemap.h>
+#include <asm/page.h>
+#include <asm/pgtable.h>
+
+#include <linux/hugetlb.h>
 
 const unsigned long hugetlb_zero = 0, hugetlb_infinity = ~0UL;
 static unsigned long nr_huge_pages, free_huge_pages;
@@ -249,6 +253,72 @@
 	.nopage = hugetlb_nopage,
 };
 
+static pte_t make_huge_pte(struct vm_area_struct *vma, struct page *page)
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
+		add_mm_counter(dst, rss, HPAGE_SIZE / PAGE_SIZE);
+		set_huge_pte_at(dst, addr, dst_pte, entry);
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
+		pte = huge_ptep_get_and_clear(mm, address, huge_pte_offset(mm, address));
+		if (pte_none(pte))
+			continue;
+		page = pte_page(pte);
+		put_page(page);
+	}
+	add_mm_counter(mm, rss,  -((end - start) >> PAGE_SHIFT));
+	flush_tlb_range(vma, start, end);
+}
+
 void zap_hugepage_range(struct vm_area_struct *vma,
 			unsigned long start, unsigned long length)
 {
@@ -258,3 +328,106 @@
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
+		add_mm_counter(mm, rss, HPAGE_SIZE / PAGE_SIZE);
+		set_huge_pte_at(mm, addr, pte, make_huge_pte(vma, page));
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
--- working-2.6.orig/arch/ppc64/mm/hugetlbpage.c	2005-05-02 08:57:20.000000000 +1000
+++ working-2.6/arch/ppc64/mm/hugetlbpage.c	2005-05-02 13:24:19.000000000 +1000
@@ -121,7 +121,7 @@
 	return hugepte_offset(dir, addr);
 }
 
-static pte_t *huge_pte_offset(struct mm_struct *mm, unsigned long addr)
+pte_t *huge_pte_offset(struct mm_struct *mm, unsigned long addr)
 {
 	pud_t *pud;
 
@@ -134,7 +134,7 @@
 	return hugepte_offset(pud, addr);
 }
 
-static pte_t *huge_pte_alloc(struct mm_struct *mm, unsigned long addr)
+pte_t *huge_pte_alloc(struct mm_struct *mm, unsigned long addr)
 {
 	pud_t *pud;
 
@@ -147,25 +147,6 @@
 	return hugepte_alloc(mm, pud, addr);
 }
 
-static void set_huge_pte(struct mm_struct *mm, struct vm_area_struct *vma,
-			 unsigned long addr, struct page *page,
-			 pte_t *ptep, int write_access)
-{
-	pte_t entry;
-
-	add_mm_counter(mm, rss, HPAGE_SIZE / PAGE_SIZE);
-	if (write_access) {
-		entry =
-		    pte_mkwrite(pte_mkdirty(mk_pte(page, vma->vm_page_prot)));
-	} else {
-		entry = pte_wrprotect(mk_pte(page, vma->vm_page_prot));
-	}
-	entry = pte_mkyoung(entry);
-	entry = pte_mkhuge(entry);
-
-	set_pte_at(mm, addr, ptep, entry);
-}
-
 /*
  * This function checks for proper alignment of input addr and len parameters.
  */
@@ -259,80 +240,6 @@
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
-		add_mm_counter(dst, rss, HPAGE_SIZE / PAGE_SIZE);
-		set_pte_at(dst, addr, dst_pte, entry);
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
@@ -363,89 +270,6 @@
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
-		pte_clear(mm, addr, ptep);
-
-		put_page(page);
-	}
-	add_mm_counter(mm, rss, -((end - start) >> PAGE_SHIFT));
-	flush_tlb_pending();
-}
-
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
-		set_huge_pte(mm, vma, addr, page, pte, vma->vm_flags & VM_WRITE);
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
--- working-2.6.orig/arch/ia64/mm/hugetlbpage.c	2005-04-26 15:37:54.000000000 +1000
+++ working-2.6/arch/ia64/mm/hugetlbpage.c	2005-05-02 13:24:19.000000000 +1000
@@ -24,7 +24,7 @@
 
 unsigned int hpage_shift=HPAGE_SHIFT_DEFAULT;
 
-static pte_t *
+pte_t *
 huge_pte_alloc (struct mm_struct *mm, unsigned long addr)
 {
 	unsigned long taddr = htlbpage_to_page(addr);
@@ -43,7 +43,7 @@
 	return pte;
 }
 
-static pte_t *
+pte_t *
 huge_pte_offset (struct mm_struct *mm, unsigned long addr)
 {
 	unsigned long taddr = htlbpage_to_page(addr);
@@ -67,23 +67,6 @@
 
 #define mk_pte_huge(entry) { pte_val(entry) |= _PAGE_P; }
 
-static void
-set_huge_pte (struct mm_struct *mm, struct vm_area_struct *vma,
-	      struct page *page, pte_t * page_table, int write_access)
-{
-	pte_t entry;
-
-	add_mm_counter(mm, rss, HPAGE_SIZE / PAGE_SIZE);
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
@@ -99,68 +82,6 @@
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
-		add_mm_counter(dst, rss, HPAGE_SIZE / PAGE_SIZE);
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
@@ -212,81 +133,6 @@
 	free_pgd_range(tlb, addr, end, floor, ceiling);
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
-		pte_clear(mm, address, pte);
-	}
-	add_mm_counter(mm, rss, - ((end - start) >> PAGE_SHIFT));
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
--- working-2.6.orig/arch/i386/mm/hugetlbpage.c	2005-04-26 15:37:54.000000000 +1000
+++ working-2.6/arch/i386/mm/hugetlbpage.c	2005-05-02 13:24:19.000000000 +1000
@@ -18,7 +18,7 @@
 #include <asm/tlb.h>
 #include <asm/tlbflush.h>
 
-static pte_t *huge_pte_alloc(struct mm_struct *mm, unsigned long addr)
+pte_t *huge_pte_alloc(struct mm_struct *mm, unsigned long addr)
 {
 	pgd_t *pgd;
 	pud_t *pud;
@@ -30,7 +30,7 @@
 	return (pte_t *) pmd;
 }
 
-static pte_t *huge_pte_offset(struct mm_struct *mm, unsigned long addr)
+pte_t *huge_pte_offset(struct mm_struct *mm, unsigned long addr)
 {
 	pgd_t *pgd;
 	pud_t *pud;
@@ -42,21 +42,6 @@
 	return (pte_t *) pmd;
 }
 
-static void set_huge_pte(struct mm_struct *mm, struct vm_area_struct *vma, struct page *page, pte_t * page_table, int write_access)
-{
-	pte_t entry;
-
-	add_mm_counter(mm, rss, HPAGE_SIZE / PAGE_SIZE);
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
@@ -69,77 +54,6 @@
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
-		add_mm_counter(dst, rss, HPAGE_SIZE / PAGE_SIZE);
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
@@ -204,83 +118,15 @@
 }
 #endif
 
-void unmap_hugepage_range(struct vm_area_struct *vma,
-		unsigned long start, unsigned long end)
+void hugetlb_clean_stale_pgtable(pte_t *pte)
 {
-	struct mm_struct *mm = vma->vm_mm;
-	unsigned long address;
-	pte_t pte, *ptep;
+	pmd_t *pmd = (pmd_t *) pte;
 	struct page *page;
 
-	BUG_ON(start & (HPAGE_SIZE - 1));
-	BUG_ON(end & (HPAGE_SIZE - 1));
-
-	for (address = start; address < end; address += HPAGE_SIZE) {
-		ptep = huge_pte_offset(mm, address);
-		if (!ptep)
-			continue;
-		pte = ptep_get_and_clear(mm, address, ptep);
-		if (pte_none(pte))
-			continue;
-		page = pte_page(pte);
-		put_page(page);
-	}
-	add_mm_counter(mm ,rss, -((end - start) >> PAGE_SHIFT));
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
+	page = pmd_page(*pmd);
+	pmd_clear(pmd);
+	dec_page_state(nr_page_table_pages);
+	page_cache_release(page);
 }
 
 /* x86_64 also uses this file */
Index: working-2.6/arch/sh64/mm/hugetlbpage.c
===================================================================
--- working-2.6.orig/arch/sh64/mm/hugetlbpage.c	2005-04-26 15:37:55.000000000 +1000
+++ working-2.6/arch/sh64/mm/hugetlbpage.c	2005-05-02 13:24:19.000000000 +1000
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
@@ -80,6 +80,20 @@
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
Index: working-2.6/arch/sh/mm/hugetlbpage.c
===================================================================
--- working-2.6.orig/arch/sh/mm/hugetlbpage.c	2005-04-26 15:37:55.000000000 +1000
+++ working-2.6/arch/sh/mm/hugetlbpage.c	2005-05-02 13:24:19.000000000 +1000
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
@@ -56,30 +56,35 @@
 
 #define mk_pte_huge(entry) do { pte_val(entry) |= _PAGE_SZHUGE; } while (0)
 
-static void set_huge_pte(struct mm_struct *mm, struct vm_area_struct *vma,
-			 struct page *page, pte_t * page_table, int write_access)
+static void set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
+			    pte_t entry)
 {
 	unsigned long i;
-	pte_t entry;
-
-	add_mm_counter(mm, rss, HPAGE_SIZE / PAGE_SIZE);
-
-	if (write_access)
-		entry = pte_mkwrite(pte_mkdirty(mk_pte(page,
-						       vma->vm_page_prot)));
-	else
-		entry = pte_wrprotect(mk_pte(page, vma->vm_page_prot));
-	entry = pte_mkyoung(entry);
-	mk_pte_huge(entry);
 
 	for (i = 0; i < (1 << HUGETLB_PAGE_ORDER); i++) {
-		set_pte(page_table, entry);
+		set_pte_at(mm, addr, page_table, entry);
 		page_table++;
-
+		addr += PAGE_SIZE;
 		pte_val(entry) += PAGE_SIZE;
 	}
 }
 
+pte_t huge_ptep_get_and_clear(struct mm_struct *mm, unsigned long addr,
+			      pte_t *ptep)
+{
+	pte_t entry;
+
+	entry = *ptep;
+
+	for (i = 0; i < (1 << HUGETLB_PAGE_ORDER); i++) {
+		pte_clear(mm, addr, pte);
+		addr += PAGE_SIZE;
+		pte++;
+	}
+
+	return entry;
+}
+
 /*
  * This function checks for proper alignment of input addr and len parameters.
  */
@@ -92,79 +97,6 @@
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
-		add_mm_counter(dst, rss, HPAGE_SIZE / PAGE_SIZE);
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
@@ -181,84 +113,3 @@
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
-			pte_clear(mm, address+(i*PAGE_SIZE), pte);
-			pte++;
-		}
-	}
-	add_mm_counter(mm, rss, -((end - start) >> PAGE_SHIFT));
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
--- working-2.6.orig/arch/sparc64/mm/hugetlbpage.c	2005-04-26 15:37:56.000000000 +1000
+++ working-2.6/arch/sparc64/mm/hugetlbpage.c	2005-05-02 13:24:19.000000000 +1000
@@ -22,7 +22,7 @@
 #include <asm/cacheflush.h>
 #include <asm/mmu_context.h>
 
-static pte_t *huge_pte_alloc(struct mm_struct *mm, unsigned long addr)
+pte_t *huge_pte_alloc(struct mm_struct *mm, unsigned long addr)
 {
 	pgd_t *pgd;
 	pud_t *pud;
@@ -41,7 +41,7 @@
 	return pte;
 }
 
-static pte_t *huge_pte_offset(struct mm_struct *mm, unsigned long addr)
+pte_t *huge_pte_offset(struct mm_struct *mm, unsigned long addr)
 {
 	pgd_t *pgd;
 	pud_t *pud;
@@ -62,32 +62,33 @@
 
 #define mk_pte_huge(entry) do { pte_val(entry) |= _PAGE_SZHUGE; } while (0)
 
-static void set_huge_pte(struct mm_struct *mm, struct vm_area_struct *vma,
-			 unsigned long addr,
-			 struct page *page, pte_t * page_table, int write_access)
+static void set_huge_pte(struct mm_struct *mm, unsigned long addr,
+			 pte_t entry)
 {
 	unsigned long i;
-	pte_t entry;
-
-	add_mm_counter(mm, rss, HPAGE_SIZE / PAGE_SIZE);
-
-	if (write_access)
-		entry = pte_mkwrite(pte_mkdirty(mk_pte(page,
-						       vma->vm_page_prot)));
-	else
-		entry = pte_wrprotect(mk_pte(page, vma->vm_page_prot));
-	entry = pte_mkyoung(entry);
-	mk_pte_huge(entry);
 
 	for (i = 0; i < (1 << HUGETLB_PAGE_ORDER); i++) {
 		set_pte_at(mm, addr, page_table, entry);
 		page_table++;
 		addr += PAGE_SIZE;
-
 		pte_val(entry) += PAGE_SIZE;
 	}
 }
 
+pte_t huge_ptep_get_and_clear(struct mm_struct *mm, unsigned long addr, pte_t *ptep)
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
@@ -100,79 +101,6 @@
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
-			set_pte_at(dst, addr, dst_pte, entry);
-			pte_val(entry) += PAGE_SIZE;
-			dst_pte++;
-			addr += PAGE_SIZE;
-		}
-		add_mm_counter(dst, rss, HPAGE_SIZE / PAGE_SIZE);
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
@@ -190,34 +118,6 @@
 	return NULL;
 }
 
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
-			pte_clear(mm, address+(i*PAGE_SIZE), pte);
-			pte++;
-		}
-	}
-	add_mm_counter(mm, rss, -((end - start) >> PAGE_SHIFT));
-	flush_tlb_range(vma, start, end);
-}
-
 static void context_reload(void *__data)
 {
 	struct mm_struct *mm = __data;
@@ -225,86 +125,3 @@
 	if (mm == current->mm)
 		load_secondary_context(mm);
 }
-
-int hugetlb_prefault(struct address_space *mapping, struct vm_area_struct *vma)
-{
-	struct mm_struct *mm = current->mm;
-	unsigned long addr;
-	int ret = 0;
-
-	/* On UltraSPARC-III+ and later, configure the second half of
-	 * the Data-TLB for huge pages.
-	 */
-	if (tlb_type == cheetah_plus) {
-		unsigned long ctx;
-
-		spin_lock(&ctx_alloc_lock);
-		ctx = mm->context.sparc64_ctx_val;
-		ctx &= ~CTX_PGSZ_MASK;
-		ctx |= CTX_PGSZ_BASE << CTX_PGSZ0_SHIFT;
-		ctx |= CTX_PGSZ_HUGE << CTX_PGSZ1_SHIFT;
-
-		if (ctx != mm->context.sparc64_ctx_val) {
-			/* When changing the page size fields, we
-			 * must perform a context flush so that no
-			 * stale entries match.  This flush must
-			 * occur with the original context register
-			 * settings.
-			 */
-			do_flush_tlb_mm(mm);
-
-			/* Reload the context register of all processors
-			 * also executing in this address space.
-			 */
-			mm->context.sparc64_ctx_val = ctx;
-			on_each_cpu(context_reload, mm, 0, 0);
-		}
-		spin_unlock(&ctx_alloc_lock);
-	}
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
-		set_huge_pte(mm, vma, addr, page, pte, vma->vm_flags & VM_WRITE);
-	}
-out:
-	spin_unlock(&mm->page_table_lock);
-	return ret;
-}
Index: working-2.6/include/asm-sh/pgtable.h
===================================================================
--- working-2.6.orig/include/asm-sh/pgtable.h	2005-04-26 15:38:02.000000000 +1000
+++ working-2.6/include/asm-sh/pgtable.h	2005-05-02 13:24:19.000000000 +1000
@@ -196,6 +196,7 @@
 static inline pte_t pte_mkdirty(pte_t pte)	{ set_pte(&pte, __pte(pte_val(pte) | _PAGE_DIRTY)); return pte; }
 static inline pte_t pte_mkyoung(pte_t pte)	{ set_pte(&pte, __pte(pte_val(pte) | _PAGE_ACCESSED)); return pte; }
 static inline pte_t pte_mkwrite(pte_t pte)	{ set_pte(&pte, __pte(pte_val(pte) | _PAGE_RW)); return pte; }
+static inline pte_t pte_mkhuge(pte_t pte)	{ set_pte(&pte, __pte(pte_val(pte) | _PAGE_SZHUGE)); return pte; }
 
 /*
  * Macro and implementation to make a page protection as uncachable.
Index: working-2.6/include/asm-ia64/pgtable.h
===================================================================
--- working-2.6.orig/include/asm-ia64/pgtable.h	2005-04-26 15:38:01.000000000 +1000
+++ working-2.6/include/asm-ia64/pgtable.h	2005-05-02 13:24:19.000000000 +1000
@@ -283,6 +283,7 @@
 #define pte_mkyoung(pte)	(__pte(pte_val(pte) | _PAGE_A))
 #define pte_mkclean(pte)	(__pte(pte_val(pte) & ~_PAGE_D))
 #define pte_mkdirty(pte)	(__pte(pte_val(pte) | _PAGE_D))
+#define pte_mkhuge(entry)	(__pte(pte_val(pte) | _PAGE_P))
 
 /*
  * Macro to a page protection value as "uncacheable".  Note that "protection" is really a
Index: working-2.6/include/asm-i386/pgtable.h
===================================================================
--- working-2.6.orig/include/asm-i386/pgtable.h	2005-05-02 08:57:22.000000000 +1000
+++ working-2.6/include/asm-i386/pgtable.h	2005-05-02 13:24:19.000000000 +1000
@@ -236,6 +236,7 @@
 static inline pte_t pte_mkdirty(pte_t pte)	{ (pte).pte_low |= _PAGE_DIRTY; return pte; }
 static inline pte_t pte_mkyoung(pte_t pte)	{ (pte).pte_low |= _PAGE_ACCESSED; return pte; }
 static inline pte_t pte_mkwrite(pte_t pte)	{ (pte).pte_low |= _PAGE_RW; return pte; }
+static inline pte_t pte_mkhuge(pte_t pte)	{ (pte).pte_low |= _PAGE_PRESENT | _PAGE_PSE; return pte; }
 
 #ifdef CONFIG_X86_PAE
 # include <asm/pgtable-3level.h>
@@ -275,7 +276,6 @@
  */
 
 #define mk_pte(page, pgprot)	pfn_pte(page_to_pfn(page), (pgprot))
-#define mk_pte_huge(entry) ((entry).pte_low |= _PAGE_PRESENT | _PAGE_PSE)
 
 static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
 {
Index: working-2.6/include/asm-sparc64/page.h
===================================================================
--- working-2.6.orig/include/asm-sparc64/page.h	2005-04-26 15:38:02.000000000 +1000
+++ working-2.6/include/asm-sparc64/page.h	2005-05-02 13:24:19.000000000 +1000
@@ -95,6 +95,7 @@
 #define HPAGE_SIZE		(_AC(1,UL) << HPAGE_SHIFT)
 #define HPAGE_MASK		(~(HPAGE_SIZE - 1UL))
 #define HUGETLB_PAGE_ORDER	(HPAGE_SHIFT - PAGE_SHIFT)
+#define ARCH_HAS_SETCLEAR_HUGE_PTE
 #endif
 
 #define TASK_UNMAPPED_BASE	(test_thread_flag(TIF_32BIT) ? \
Index: working-2.6/include/asm-sparc64/pgtable.h
===================================================================
--- working-2.6.orig/include/asm-sparc64/pgtable.h	2005-04-26 15:38:02.000000000 +1000
+++ working-2.6/include/asm-sparc64/pgtable.h	2005-05-02 13:24:19.000000000 +1000
@@ -286,6 +286,7 @@
 #define pte_mkyoung(pte)	(__pte(pte_val(pte) | _PAGE_ACCESSED | _PAGE_R))
 #define pte_mkwrite(pte)	(__pte(pte_val(pte) | _PAGE_WRITE))
 #define pte_mkdirty(pte)	(__pte(pte_val(pte) | _PAGE_MODIFIED | _PAGE_W))
+#define pte_mkhuge(pte)		(__pte(pte_val(pte) | _PAGE_SZHUGE))
 
 /* to find an entry in a page-table-directory. */
 #define pgd_index(address)	(((address) >> PGDIR_SHIFT) & (PTRS_PER_PGD - 1))
Index: working-2.6/include/asm-sh/page.h
===================================================================
--- working-2.6.orig/include/asm-sh/page.h	2005-04-26 15:38:02.000000000 +1000
+++ working-2.6/include/asm-sh/page.h	2005-05-02 13:24:19.000000000 +1000
@@ -31,6 +31,7 @@
 #define HPAGE_SIZE		(1UL << HPAGE_SHIFT)
 #define HPAGE_MASK		(~(HPAGE_SIZE-1))
 #define HUGETLB_PAGE_ORDER	(HPAGE_SHIFT-PAGE_SHIFT)
+#define ARCH_HAS_SETCLEAR_HUGE_PTE
 #endif
 
 #ifdef __KERNEL__
Index: working-2.6/include/asm-sh64/pgtable.h
===================================================================
--- working-2.6.orig/include/asm-sh64/pgtable.h	2005-04-26 15:38:02.000000000 +1000
+++ working-2.6/include/asm-sh64/pgtable.h	2005-05-02 13:24:19.000000000 +1000
@@ -430,6 +430,8 @@
 extern inline pte_t pte_mkexec(pte_t pte)	{ set_pte(&pte, __pte(pte_val(pte) | _PAGE_EXECUTE)); return pte; }
 extern inline pte_t pte_mkdirty(pte_t pte)	{ set_pte(&pte, __pte(pte_val(pte) | _PAGE_DIRTY)); return pte; }
 extern inline pte_t pte_mkyoung(pte_t pte)	{ set_pte(&pte, __pte(pte_val(pte) | _PAGE_ACCESSED)); return pte; }
+extern inline pte_t pte_mkhuge(pte_t pte)	{ set_pte(&pte, __pte(pte_val(pte) | _PAGE_SZHUGE)); return pte; }
+
 
 /*
  * Conversion functions: convert a page and protection to a page entry.
Index: working-2.6/include/asm-sh64/page.h
===================================================================
--- working-2.6.orig/include/asm-sh64/page.h	2005-04-26 15:38:02.000000000 +1000
+++ working-2.6/include/asm-sh64/page.h	2005-05-02 13:24:19.000000000 +1000
@@ -41,6 +41,7 @@
 #define HPAGE_SIZE		(1UL << HPAGE_SHIFT)
 #define HPAGE_MASK		(~(HPAGE_SIZE-1))
 #define HUGETLB_PAGE_ORDER	(HPAGE_SHIFT-PAGE_SHIFT)
+#define ARCH_HAS_SETCLEAR_HUGE_PTE
 #endif
 
 #ifdef __KERNEL__
Index: working-2.6/include/linux/hugetlb.h
===================================================================
--- working-2.6.orig/include/linux/hugetlb.h	2005-04-26 15:38:02.000000000 +1000
+++ working-2.6/include/linux/hugetlb.h	2005-05-02 13:24:19.000000000 +1000
@@ -4,6 +4,7 @@
 #ifdef CONFIG_HUGETLB_PAGE
 
 #include <linux/mempolicy.h>
+#include <asm/tlbflush.h>
 
 struct ctl_table;
 
@@ -22,12 +23,6 @@
 int hugetlb_report_node_meminfo(int, char *);
 int is_hugepage_mem_enough(size_t);
 unsigned long hugetlb_total_pages(void);
-struct page *follow_huge_addr(struct mm_struct *mm, unsigned long address,
-			      int write);
-struct page *follow_huge_pmd(struct mm_struct *mm, unsigned long address,
-				pmd_t *pmd, int write);
-int is_aligned_hugepage_range(unsigned long addr, unsigned long len);
-int pmd_huge(pmd_t pmd);
 struct page *alloc_huge_page(void);
 void free_huge_page(struct page *);
 
@@ -35,6 +30,17 @@
 extern const unsigned long hugetlb_zero, hugetlb_infinity;
 extern int sysctl_hugetlb_shm_group;
 
+/* arch callbacks */
+
+pte_t *huge_pte_alloc(struct mm_struct *mm, unsigned long addr);
+pte_t *huge_pte_offset(struct mm_struct *mm, unsigned long addr);
+struct page *follow_huge_addr(struct mm_struct *mm, unsigned long address,
+			      int write);
+struct page *follow_huge_pmd(struct mm_struct *mm, unsigned long address,
+				pmd_t *pmd, int write);
+int is_aligned_hugepage_range(unsigned long addr, unsigned long len);
+int pmd_huge(pmd_t pmd);
+
 #ifndef ARCH_HAS_HUGEPAGE_ONLY_RANGE
 #define is_hugepage_only_range(mm, addr, len)	0
 #define hugetlb_free_pgd_range(tlb, addr, end, floor, ceiling) \
@@ -48,6 +54,22 @@
 int prepare_hugepage_range(unsigned long addr, unsigned long len);
 #endif
 
+#ifndef ARCH_HAS_SETCLEAR_HUGE_PTE
+#define set_huge_pte_at(mm, addr, ptep, pte)	set_pte_at(mm, addr, ptep, pte)
+#define huge_ptep_get_and_clear(mm, addr, ptep) ptep_get_and_clear(mm, addr, ptep)
+#else
+void set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
+		     pte_t *ptep, pte_t pte);
+pte_t huge_ptep_get_and_clear(struct mm_struct *mm, unsigned long addr,
+			      pte_t *ptep);
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
--- working-2.6.orig/include/asm-i386/page.h	2005-04-26 15:38:01.000000000 +1000
+++ working-2.6/include/asm-i386/page.h	2005-05-02 13:24:19.000000000 +1000
@@ -68,6 +68,7 @@
 #define HPAGE_MASK	(~(HPAGE_SIZE - 1))
 #define HUGETLB_PAGE_ORDER	(HPAGE_SHIFT - PAGE_SHIFT)
 #define HAVE_ARCH_HUGETLB_UNMAPPED_AREA
+#define ARCH_HAS_HUGETLB_CLEAN_STALE_PGTABLE
 #endif
 
 #define pgd_val(x)	((x).pgd)
Index: working-2.6/include/asm-x86_64/pgtable.h
===================================================================
--- working-2.6.orig/include/asm-x86_64/pgtable.h	2005-04-26 15:38:02.000000000 +1000
+++ working-2.6/include/asm-x86_64/pgtable.h	2005-05-02 13:24:19.000000000 +1000
@@ -253,6 +253,7 @@
 extern inline int pte_write(pte_t pte)		{ return pte_val(pte) & _PAGE_RW; }
 static inline int pte_file(pte_t pte)		{ return pte_val(pte) & _PAGE_FILE; }
 
+#define __LARGE_PTE (_PAGE_PSE|_PAGE_PRESENT) 
 extern inline pte_t pte_rdprotect(pte_t pte)	{ set_pte(&pte, __pte(pte_val(pte) & ~_PAGE_USER)); return pte; }
 extern inline pte_t pte_exprotect(pte_t pte)	{ set_pte(&pte, __pte(pte_val(pte) & ~_PAGE_USER)); return pte; }
 extern inline pte_t pte_mkclean(pte_t pte)	{ set_pte(&pte, __pte(pte_val(pte) & ~_PAGE_DIRTY)); return pte; }
@@ -263,6 +264,7 @@
 extern inline pte_t pte_mkdirty(pte_t pte)	{ set_pte(&pte, __pte(pte_val(pte) | _PAGE_DIRTY)); return pte; }
 extern inline pte_t pte_mkyoung(pte_t pte)	{ set_pte(&pte, __pte(pte_val(pte) | _PAGE_ACCESSED)); return pte; }
 extern inline pte_t pte_mkwrite(pte_t pte)	{ set_pte(&pte, __pte(pte_val(pte) | _PAGE_RW)); return pte; }
+extern inline pte_t pte_mkhuge(pte_t pte)	{ set_pte(&pte, __pte(pte_val(pte) | __LARGE_PTE)); return pte; }
 
 struct vm_area_struct;
 
@@ -290,7 +292,6 @@
  */
 #define pgprot_noncached(prot)	(__pgprot(pgprot_val(prot) | _PAGE_PCD | _PAGE_PWT))
 
-#define __LARGE_PTE (_PAGE_PSE|_PAGE_PRESENT) 
 static inline int pmd_large(pmd_t pte) { 
 	return (pmd_val(pte) & __LARGE_PTE) == __LARGE_PTE; 
 } 	
Index: working-2.6/include/asm-x86_64/page.h
===================================================================
--- working-2.6.orig/include/asm-x86_64/page.h	2005-04-26 15:38:02.000000000 +1000
+++ working-2.6/include/asm-x86_64/page.h	2005-05-02 13:24:19.000000000 +1000
@@ -28,6 +28,7 @@
 #define HPAGE_SIZE	((1UL) << HPAGE_SHIFT)
 #define HPAGE_MASK	(~(HPAGE_SIZE - 1))
 #define HUGETLB_PAGE_ORDER	(HPAGE_SHIFT - PAGE_SHIFT)
+#define ARCH_HAS_HUGETLB_CLEAN_STALE_PGTABLE
 
 #ifdef __KERNEL__
 #ifndef __ASSEMBLY__


-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/people/dgibson
