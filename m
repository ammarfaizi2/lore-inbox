Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267659AbUHENrJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267659AbUHENrJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 09:47:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267685AbUHENrI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 09:47:08 -0400
Received: from fmr03.intel.com ([143.183.121.5]:52611 "EHLO
	hermes.sc.intel.com") by vger.kernel.org with ESMTP id S267659AbUHENki
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 09:40:38 -0400
Message-Id: <200408051340.i75De0Y26517@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'William Lee Irwin III'" <wli@holomorphy.com>
Cc: <linux-kernel@vger.kernel.org>, <linux-ia64@vger.kernel.org>,
       "Seth, Rohit" <rohit.seth@intel.com>
Subject: RE: Hugetlb demanding paging for -mm tree
Date: Thu, 5 Aug 2004 06:39:59 -0700
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
Thread-Index: AcR68Tzp5BXc7FdKQkOKAyxN9GM3OQAABQdQ
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
In-Reply-To: <20040805133637.GG14358@holomorphy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote on Thursday, August 05, 2004 6:37 AM
> On Thu, Aug 05, 2004 at 06:29:02AM -0700, Chen, Kenneth W wrote:
> > Dusted it off from 3 month ago.  This time re-diffed against 2.6.8-rc3-mm1.
> > One big change compare to previous release is this patch should work for
> > ALL arch that supports hugetlb page.  I have tested it on ia64 and x86.
> > For x86, tested with no highmem config, 4G highmem config and PAE config.
> > I have not tested it on sh, sparc64 and ppc64, but I have no reason to
> > believe that this feature won't work on these arches.
> > Patches are broken into two pieces.  But they should be applied together
> > to have correct functionality for hugetlb demand paging.
> > 00.demandpaging.patch - core hugetlb demand paging
> > 01.overcommit.patch   - hugetlbfs strict overcommit accounting.
> > Testing and comments are welcome.  Thanks.
>
> Could you resend as plaintext?

---------------------
00.demandpaging.patch
---------------------

diff -Nurp linux-2.6.7/arch/i386/mm/hugetlbpage.c linux-2.6.7.hugetlb/arch/i386/mm/hugetlbpage.c
--- linux-2.6.7/arch/i386/mm/hugetlbpage.c	2004-08-04 16:50:31.000000000 -0700
+++ linux-2.6.7.hugetlb/arch/i386/mm/hugetlbpage.c	2004-08-04 17:10:14.000000000 -0700
@@ -18,13 +18,26 @@
 #include <asm/tlb.h>
 #include <asm/tlbflush.h>

-static pte_t *huge_pte_alloc(struct mm_struct *mm, unsigned long addr)
+static void scrub_one_pmd(pmd_t * pmd)
+{
+	struct page *page;
+
+	if (pmd && !pmd_none(*pmd) && !pmd_huge(*pmd)) {
+		page = pmd_page(*pmd);
+		pmd_clear(pmd);
+		dec_page_state(nr_page_table_pages);
+		page_cache_release(page);
+	}
+}
+
+pte_t *huge_pte_alloc(struct mm_struct *mm, unsigned long addr)
 {
 	pgd_t *pgd;
 	pmd_t *pmd = NULL;

 	pgd = pgd_offset(mm, addr);
 	pmd = pmd_alloc(mm, pgd, addr);
+	scrub_one_pmd(pmd);
 	return (pte_t *) pmd;
 }

@@ -34,11 +47,14 @@ static pte_t *huge_pte_offset(struct mm_
 	pmd_t *pmd = NULL;

 	pgd = pgd_offset(mm, addr);
-	pmd = pmd_offset(pgd, addr);
+	if (pgd_present(*pgd)) {
+		pmd = pmd_offset(pgd, addr);
+		scrub_one_pmd(pmd);
+	}
 	return (pte_t *) pmd;
 }

-static void set_huge_pte(struct mm_struct *mm, struct vm_area_struct *vma, struct page *page, pte_t * page_table, int write_access)
+void set_huge_pte(struct mm_struct *mm, struct vm_area_struct *vma, struct page *page, pte_t * page_table, int write_access)
 {
 	pte_t entry;

@@ -73,17 +89,18 @@ int copy_hugetlb_page_range(struct mm_st
 	unsigned long addr = vma->vm_start;
 	unsigned long end = vma->vm_end;

-	while (addr < end) {
+	for (; addr < end; addr+= HPAGE_SIZE) {
+		src_pte = huge_pte_offset(src, addr);
+		if (!src_pte || pte_none(*src_pte))
+			continue;
 		dst_pte = huge_pte_alloc(dst, addr);
 		if (!dst_pte)
 			goto nomem;
-		src_pte = huge_pte_offset(src, addr);
 		entry = *src_pte;
 		ptepage = pte_page(entry);
 		get_page(ptepage);
 		set_pte(dst_pte, entry);
 		dst->rss += (HPAGE_SIZE / PAGE_SIZE);
-		addr += HPAGE_SIZE;
 	}
 	return 0;

@@ -221,63 +238,3 @@ void unmap_hugepage_range(struct vm_area
 	mm->rss -= (end - start) >> PAGE_SHIFT;
 	flush_tlb_range(vma, start, end);
 }
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
-}
diff -Nurp linux-2.6.7/arch/ia64/mm/hugetlbpage.c linux-2.6.7.hugetlb/arch/ia64/mm/hugetlbpage.c
--- linux-2.6.7/arch/ia64/mm/hugetlbpage.c	2004-08-04 16:50:31.000000000 -0700
+++ linux-2.6.7.hugetlb/arch/ia64/mm/hugetlbpage.c	2004-08-04 16:51:54.000000000 -0700
@@ -24,7 +24,7 @@

 unsigned int hpage_shift=HPAGE_SHIFT_DEFAULT;

-static pte_t *
+pte_t *
 huge_pte_alloc (struct mm_struct *mm, unsigned long addr)
 {
 	unsigned long taddr = htlbpage_to_page(addr);
@@ -59,7 +59,7 @@ huge_pte_offset (struct mm_struct *mm, u

 #define mk_pte_huge(entry) { pte_val(entry) |= _PAGE_P; }

-static void
+void
 set_huge_pte (struct mm_struct *mm, struct vm_area_struct *vma,
 	      struct page *page, pte_t * page_table, int write_access)
 {
@@ -99,17 +99,18 @@ int copy_hugetlb_page_range(struct mm_st
 	unsigned long addr = vma->vm_start;
 	unsigned long end = vma->vm_end;

-	while (addr < end) {
+	for (; addr < end; addr += HPAGE_SIZE) {
+		src_pte = huge_pte_offset(src, addr);
+		if (!src_pte || pte_none(*src_pte))
+			continue;
 		dst_pte = huge_pte_alloc(dst, addr);
 		if (!dst_pte)
 			goto nomem;
-		src_pte = huge_pte_offset(src, addr);
 		entry = *src_pte;
 		ptepage = pte_page(entry);
 		get_page(ptepage);
 		set_pte(dst_pte, entry);
 		dst->rss += (HPAGE_SIZE / PAGE_SIZE);
-		addr += HPAGE_SIZE;
 	}
 	return 0;
 nomem:
@@ -243,7 +244,7 @@ void unmap_hugepage_range(struct vm_area

 	for (address = start; address < end; address += HPAGE_SIZE) {
 		pte = huge_pte_offset(mm, address);
-		if (pte_none(*pte))
+		if (!pte || pte_none(*pte))
 			continue;
 		page = pte_page(*pte);
 		put_page(page);
@@ -253,59 +254,6 @@ void unmap_hugepage_range(struct vm_area
 	flush_tlb_range(vma, start, end);
 }

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
diff -Nurp linux-2.6.7/arch/ppc64/mm/hugetlbpage.c linux-2.6.7.hugetlb/arch/ppc64/mm/hugetlbpage.c
--- linux-2.6.7/arch/ppc64/mm/hugetlbpage.c	2004-08-04 16:50:31.000000000 -0700
+++ linux-2.6.7.hugetlb/arch/ppc64/mm/hugetlbpage.c	2004-08-05 04:04:36.000000000 -0700
@@ -413,62 +413,6 @@ void unmap_hugepage_range(struct vm_area
 	mm->rss -= (end - start) >> PAGE_SHIFT;
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
-		hugepte_t *pte = hugepte_alloc(mm, addr);
-		struct page *page;
-
-		BUG_ON(!in_hugepage_area(mm->context, addr));
-
-		if (!pte) {
-			ret = -ENOMEM;
-			goto out;
-		}
-		if (!hugepte_none(*pte))
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
-		setup_huge_pte(mm, page, pte, vma->vm_flags & VM_WRITE);
-	}
-out:
-	spin_unlock(&mm->page_table_lock);
-	return ret;
-}
-
 /* Because we have an exclusive hugepage region which lies within the
  * normal user address space, we have to take special measures to make
  * non-huge mmap()s evade the hugepage reserved regions. */
@@ -760,3 +704,59 @@ static void flush_hash_hugepage(mm_conte

 	ppc_md.hpte_invalidate(slot, va, 1, local);
 }
+
+int
+handle_hugetlb_mm_fault(struct mm_struct *mm, struct vm_area_struct * vma,
+	unsigned long addr, int write_access)
+{
+	hugepte_t *pte;
+	struct page *page;
+	struct address_space *mapping;
+	int idx, ret;
+
+	spin_lock(&mm->page_table_lock);
+	pte = hugepte_alloc(mm, addr & HPAGE_MASK);
+	if (!pte)
+		goto oom;
+	if (!hugepte_none(*pte))
+		goto out;
+	spin_unlock(&mm->page_table_lock);
+
+	mapping = vma->vm_file->f_dentry->d_inode->i_mapping;
+	idx = ((addr - vma->vm_start) >> HPAGE_SHIFT)
+		+ (vma->vm_pgoff >> (HPAGE_SHIFT - PAGE_SHIFT));
+retry:
+	page = find_get_page(mapping, idx);
+	if (!page) {
+		page = alloc_huge_page();
+		if (!page)
+			/*
+			 * with strict overcommit accounting, we should never
+			 * run out of hugetlb page, so must be a fault race
+			 * and let's retry.
+			 */
+			goto retry;
+		ret = add_to_page_cache(page, mapping, idx, GFP_ATOMIC);
+		if (!ret) {
+			unlock_page(page);
+		} else {
+			put_page(page);
+			if (ret == -EEXIST)
+				goto retry;
+			else
+				return VM_FAULT_OOM;
+		}
+	}
+
+	spin_lock(&mm->page_table_lock);
+	if (hugepte_none(*pte))
+		setup_huge_pte(mm, page, pte, vma->vm_flags & VM_WRITE);
+	else
+		put_page(page);
+out:
+	spin_unlock(&mm->page_table_lock);
+	return VM_FAULT_MINOR;
+oom:
+	spin_unlock(&mm->page_table_lock);
+	return VM_FAULT_OOM;
+}
diff -Nurp linux-2.6.7/arch/sh/mm/hugetlbpage.c linux-2.6.7.hugetlb/arch/sh/mm/hugetlbpage.c
--- linux-2.6.7/arch/sh/mm/hugetlbpage.c	2004-06-15 22:19:36.000000000 -0700
+++ linux-2.6.7.hugetlb/arch/sh/mm/hugetlbpage.c	2004-08-04 17:19:25.000000000 -0700
@@ -24,7 +24,7 @@
 #include <asm/tlbflush.h>
 #include <asm/cacheflush.h>

-static pte_t *huge_pte_alloc(struct mm_struct *mm, unsigned long addr)
+pte_t *huge_pte_alloc(struct mm_struct *mm, unsigned long addr)
 {
 	pgd_t *pgd;
 	pmd_t *pmd;
@@ -56,7 +56,7 @@ static pte_t *huge_pte_offset(struct mm_

 #define mk_pte_huge(entry) do { pte_val(entry) |= _PAGE_SZHUGE; } while (0)

-static void set_huge_pte(struct mm_struct *mm, struct vm_area_struct *vma,
+void set_huge_pte(struct mm_struct *mm, struct vm_area_struct *vma,
 			 struct page *page, pte_t * page_table, int write_access)
 {
 	unsigned long i;
@@ -101,12 +101,13 @@ int copy_hugetlb_page_range(struct mm_st
 	unsigned long end = vma->vm_end;
 	int i;

-	while (addr < end) {
+	for (; addr < end; addr += HPAGE_SIZE) {
+		src_pte = huge_pte_offset(src, addr);
+		if (!src_pte || pte_none(*src_pte))
+			continue;
 		dst_pte = huge_pte_alloc(dst, addr);
 		if (!dst_pte)
 			goto nomem;
-		src_pte = huge_pte_offset(src, addr);
-		BUG_ON(!src_pte || pte_none(*src_pte));
 		entry = *src_pte;
 		ptepage = pte_page(entry);
 		get_page(ptepage);
@@ -116,7 +117,6 @@ int copy_hugetlb_page_range(struct mm_st
 			dst_pte++;
 		}
 		dst->rss += (HPAGE_SIZE / PAGE_SIZE);
-		addr += HPAGE_SIZE;
 	}
 	return 0;

@@ -196,8 +196,7 @@ void unmap_hugepage_range(struct vm_area

 	for (address = start; address < end; address += HPAGE_SIZE) {
 		pte = huge_pte_offset(mm, address);
-		BUG_ON(!pte);
-		if (pte_none(*pte))
+		if (!pte || pte_none(*pte))
 			continue;
 		page = pte_page(*pte);
 		put_page(page);
@@ -209,56 +208,3 @@ void unmap_hugepage_range(struct vm_area
 	mm->rss -= (end - start) >> PAGE_SHIFT;
 	flush_tlb_range(vma, start, end);
 }
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
diff -Nurp linux-2.6.7/arch/sparc64/mm/hugetlbpage.c linux-2.6.7.hugetlb/arch/sparc64/mm/hugetlbpage.c
--- linux-2.6.7/arch/sparc64/mm/hugetlbpage.c	2004-06-15 22:19:42.000000000 -0700
+++ linux-2.6.7.hugetlb/arch/sparc64/mm/hugetlbpage.c	2004-08-05 03:31:58.000000000 -0700
@@ -21,7 +21,7 @@
 #include <asm/tlbflush.h>
 #include <asm/cacheflush.h>

-static pte_t *huge_pte_alloc(struct mm_struct *mm, unsigned long addr)
+pte_t *huge_pte_alloc(struct mm_struct *mm, unsigned long addr)
 {
 	pgd_t *pgd;
 	pmd_t *pmd;
@@ -53,7 +53,7 @@ static pte_t *huge_pte_offset(struct mm_

 #define mk_pte_huge(entry) do { pte_val(entry) |= _PAGE_SZHUGE; } while (0)

-static void set_huge_pte(struct mm_struct *mm, struct vm_area_struct *vma,
+void set_huge_pte(struct mm_struct *mm, struct vm_area_struct *vma,
 			 struct page *page, pte_t * page_table, int write_access)
 {
 	unsigned long i;
@@ -98,12 +98,13 @@ int copy_hugetlb_page_range(struct mm_st
 	unsigned long end = vma->vm_end;
 	int i;

-	while (addr < end) {
+	for (; addr < end; addr += HPAGE_SIZE) {
+		src_pte = huge_pte_offset(src, addr);
+		if (!src_pte || pte_none(*src_pte))
+			continue;
 		dst_pte = huge_pte_alloc(dst, addr);
 		if (!dst_pte)
 			goto nomem;
-		src_pte = huge_pte_offset(src, addr);
-		BUG_ON(!src_pte || pte_none(*src_pte));
 		entry = *src_pte;
 		ptepage = pte_page(entry);
 		get_page(ptepage);
@@ -113,7 +114,6 @@ int copy_hugetlb_page_range(struct mm_st
 			dst_pte++;
 		}
 		dst->rss += (HPAGE_SIZE / PAGE_SIZE);
-		addr += HPAGE_SIZE;
 	}
 	return 0;

@@ -193,8 +193,7 @@ void unmap_hugepage_range(struct vm_area

 	for (address = start; address < end; address += HPAGE_SIZE) {
 		pte = huge_pte_offset(mm, address);
-		BUG_ON(!pte);
-		if (pte_none(*pte))
+		if (!pte || pte_none(*pte))
 			continue;
 		page = pte_page(*pte);
 		put_page(page);
@@ -206,56 +205,3 @@ void unmap_hugepage_range(struct vm_area
 	mm->rss -= (end - start) >> PAGE_SHIFT;
 	flush_tlb_range(vma, start, end);
 }
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
diff -Nurp linux-2.6.7/fs/hugetlbfs/inode.c linux-2.6.7.hugetlb/fs/hugetlbfs/inode.c
--- linux-2.6.7/fs/hugetlbfs/inode.c	2004-08-04 16:50:42.000000000 -0700
+++ linux-2.6.7.hugetlb/fs/hugetlbfs/inode.c	2004-08-04 16:51:54.000000000 -0700
@@ -79,10 +79,6 @@ static int hugetlbfs_file_mmap(struct fi
 	if (!(vma->vm_flags & VM_WRITE) && len > inode->i_size)
 		goto out;

-	ret = hugetlb_prefault(mapping, vma);
-	if (ret)
-		goto out;
-
 	if (inode->i_size < len)
 		inode->i_size = len;
 out:
diff -Nurp linux-2.6.7/include/linux/hugetlb.h linux-2.6.7.hugetlb/include/linux/hugetlb.h
--- linux-2.6.7/include/linux/hugetlb.h	2004-08-04 16:50:35.000000000 -0700
+++ linux-2.6.7.hugetlb/include/linux/hugetlb.h	2004-08-05 04:09:51.000000000 -0700
@@ -17,7 +17,10 @@ int copy_hugetlb_page_range(struct mm_st
 int follow_hugetlb_page(struct mm_struct *, struct vm_area_struct *, struct page **, struct vm_area_struct **, unsigned long *, int
*, int);
 void zap_hugepage_range(struct vm_area_struct *, unsigned long, unsigned long);
 void unmap_hugepage_range(struct vm_area_struct *, unsigned long, unsigned long);
-int hugetlb_prefault(struct address_space *, struct vm_area_struct *);
+pte_t *huge_pte_alloc(struct mm_struct *, unsigned long);
+void set_huge_pte(struct mm_struct *, struct vm_area_struct *, struct page *, pte_t *, int);
+int handle_hugetlb_mm_fault(struct mm_struct *, struct vm_area_struct *, unsigned long, int);
+
 int hugetlb_report_meminfo(char *);
 int hugetlb_report_node_meminfo(int, char *);
 int is_hugepage_mem_enough(size_t);
@@ -61,7 +64,7 @@ static inline unsigned long hugetlb_tota
 #define follow_hugetlb_page(m,v,p,vs,a,b,i)	({ BUG(); 0; })
 #define follow_huge_addr(mm, addr, write)	ERR_PTR(-EINVAL)
 #define copy_hugetlb_page_range(src, dst, vma)	({ BUG(); 0; })
-#define hugetlb_prefault(mapping, vma)		({ BUG(); 0; })
+#define handle_hugetlb_mm_fault(mm, vma, addr, write) VM_FAULT_SIGBUS
 #define zap_hugepage_range(vma, start, len)	BUG()
 #define unmap_hugepage_range(vma, start, end)	BUG()
 #define is_hugepage_mem_enough(size)		0
diff -Nurp linux-2.6.7/mm/hugetlb.c linux-2.6.7.hugetlb/mm/hugetlb.c
--- linux-2.6.7/mm/hugetlb.c	2004-08-04 16:50:36.000000000 -0700
+++ linux-2.6.7.hugetlb/mm/hugetlb.c	2004-08-05 03:49:10.000000000 -0700
@@ -8,6 +8,7 @@
 #include <linux/module.h>
 #include <linux/mm.h>
 #include <linux/hugetlb.h>
+#include <linux/pagemap.h>
 #include <linux/sysctl.h>
 #include <linux/highmem.h>

@@ -231,11 +232,65 @@ unsigned long hugetlb_total_pages(void)
 }
 EXPORT_SYMBOL(hugetlb_total_pages);

+int __attribute__ ((weak))
+handle_hugetlb_mm_fault(struct mm_struct *mm, struct vm_area_struct * vma,
+	unsigned long addr, int write_access)
+{
+	pte_t *pte;
+	struct page *page;
+	struct address_space *mapping;
+	int idx, ret;
+
+	spin_lock(&mm->page_table_lock);
+	pte = huge_pte_alloc(mm, addr & HPAGE_MASK);
+	if (!pte)
+		goto oom;
+	if (!pte_none(*pte))
+		goto out;
+	spin_unlock(&mm->page_table_lock);
+
+	mapping = vma->vm_file->f_dentry->d_inode->i_mapping;
+	idx = ((addr - vma->vm_start) >> HPAGE_SHIFT)
+		+ (vma->vm_pgoff >> (HPAGE_SHIFT - PAGE_SHIFT));
+retry:
+	page = find_get_page(mapping, idx);
+	if (!page) {
+		page = alloc_huge_page();
+		if (!page)
+			/*
+			 * with strict overcommit accounting, we should never
+			 * run out of hugetlb page, so must be a fault race
+			 * and let's retry.
+			 */
+			goto retry;
+		ret = add_to_page_cache(page, mapping, idx, GFP_ATOMIC);
+		if (!ret) {
+			unlock_page(page);
+		} else {
+			put_page(page);
+			if (ret == -EEXIST)
+				goto retry;
+			else
+				return VM_FAULT_OOM;
+		}
+	}
+
+	spin_lock(&mm->page_table_lock);
+	if (pte_none(*pte))
+		set_huge_pte(mm, vma, page, pte, vma->vm_flags & VM_WRITE);
+	else
+		put_page(page);
+out:
+	spin_unlock(&mm->page_table_lock);
+	return VM_FAULT_MINOR;
+oom:
+	spin_unlock(&mm->page_table_lock);
+	return VM_FAULT_OOM;
+}
+
 /*
- * We cannot handle pagefaults against hugetlb pages at all.  They cause
- * handle_mm_fault() to try to instantiate regular-sized pages in the
- * hugegpage VMA.  do_page_fault() is supposed to trap this, so BUG is we get
- * this far.
+ * We should not get here because handle_mm_fault() is supposed to trap
+ * hugetlb page fault.  BUG if we get here.
  */
 static struct page *hugetlb_nopage(struct vm_area_struct *vma,
 				unsigned long address, int *unused)
diff -Nurp linux-2.6.7/mm/memory.c linux-2.6.7.hugetlb/mm/memory.c
--- linux-2.6.7/mm/memory.c	2004-08-04 16:50:43.000000000 -0700
+++ linux-2.6.7.hugetlb/mm/memory.c	2004-08-04 16:51:54.000000000 -0700
@@ -764,11 +764,6 @@ int get_user_pages(struct task_struct *t
 		if ((pages && vm_io) || !(flags & vma->vm_flags))
 			return i ? i : -EFAULT;

-		if (is_vm_hugetlb_page(vma)) {
-			i = follow_hugetlb_page(mm, vma, pages, vmas,
-						&start, &len, i);
-			continue;
-		}
 		spin_lock(&mm->page_table_lock);
 		do {
 			struct page *map = NULL;
@@ -1709,7 +1704,7 @@ int handle_mm_fault(struct mm_struct *mm
 	inc_page_state(pgfault);

 	if (is_vm_hugetlb_page(vma))
-		return VM_FAULT_SIGBUS;	/* mapping truncation does this. */
+		return handle_hugetlb_mm_fault(mm, vma, address, write_access);

 	/*
 	 * We need the page table lock to synchronize with kswapd


