Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270854AbUJVFLb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270854AbUJVFLb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 01:11:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270354AbUJVFB3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 01:01:29 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:27027 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S269085AbUJVE41 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 00:56:27 -0400
Date: Thu, 21 Oct 2004 21:56:27 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
cc: William Lee Irwin III <wli@holomorphy.com>, raybry@sgi.com,
       linux-kernel@vger.kernel.org
Subject: Hugepages demand paging V1 [1/4]: demand paging core
In-Reply-To: <Pine.LNX.4.58.0410212151310.3524@schroedinger.engr.sgi.com>
Message-ID: <Pine.LNX.4.58.0410212155170.3524@schroedinger.engr.sgi.com>
References: <B05667366EE6204181EABE9C1B1C0EB501F2ADFB@scsmsx401.amr.corp.intel.com>
 <Pine.LNX.4.58.0410212151310.3524@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeLog
	* provide huge page fault handler

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.9/arch/i386/mm/hugetlbpage.c
===================================================================
--- linux-2.6.9.orig/arch/i386/mm/hugetlbpage.c	2004-10-21 12:01:21.000000000 -0700
+++ linux-2.6.9/arch/i386/mm/hugetlbpage.c	2004-10-21 20:02:52.000000000 -0700
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

@@ -34,11 +47,14 @@
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

@@ -73,17 +89,18 @@
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

@@ -217,68 +234,8 @@
 			continue;
 		page = pte_page(pte);
 		put_page(page);
+		mm->rss -= (HPAGE_SIZE / PAGE_SIZE);
 	}
-	mm->rss -= (end - start) >> PAGE_SHIFT;
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
-}
Index: linux-2.6.9/arch/ia64/mm/hugetlbpage.c
===================================================================
--- linux-2.6.9.orig/arch/ia64/mm/hugetlbpage.c	2004-10-18 14:54:27.000000000 -0700
+++ linux-2.6.9/arch/ia64/mm/hugetlbpage.c	2004-10-21 20:02:52.000000000 -0700
@@ -24,7 +24,7 @@

 unsigned int hpage_shift=HPAGE_SHIFT_DEFAULT;

-static pte_t *
+pte_t *
 huge_pte_alloc (struct mm_struct *mm, unsigned long addr)
 {
 	unsigned long taddr = htlbpage_to_page(addr);
@@ -59,7 +59,7 @@

 #define mk_pte_huge(entry) { pte_val(entry) |= _PAGE_P; }

-static void
+void
 set_huge_pte (struct mm_struct *mm, struct vm_area_struct *vma,
 	      struct page *page, pte_t * page_table, int write_access)
 {
@@ -99,17 +99,18 @@
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
@@ -243,69 +244,16 @@

 	for (address = start; address < end; address += HPAGE_SIZE) {
 		pte = huge_pte_offset(mm, address);
-		if (pte_none(*pte))
+		if (!pte || pte_none(*pte))
 			continue;
 		page = pte_page(*pte);
 		put_page(page);
 		pte_clear(pte);
+		mm->rss -= (HPAGE_SIZE / PAGE_SIZE);
 	}
-	mm->rss -= (end - start) >> PAGE_SHIFT;
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
Index: linux-2.6.9/arch/ppc64/mm/hugetlbpage.c
===================================================================
--- linux-2.6.9.orig/arch/ppc64/mm/hugetlbpage.c	2004-10-21 12:01:21.000000000 -0700
+++ linux-2.6.9/arch/ppc64/mm/hugetlbpage.c	2004-10-21 20:02:52.000000000 -0700
@@ -408,66 +408,9 @@
 					    pte, local);

 		put_page(page);
+		mm->rss -= (HPAGE_SIZE / PAGE_SIZE);
 	}
 	put_cpu();
-
-	mm->rss -= (end - start) >> PAGE_SHIFT;
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
 }

 /* Because we have an exclusive hugepage region which lies within the
@@ -863,3 +806,59 @@

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
Index: linux-2.6.9/arch/sh/mm/hugetlbpage.c
===================================================================
--- linux-2.6.9.orig/arch/sh/mm/hugetlbpage.c	2004-10-18 14:54:32.000000000 -0700
+++ linux-2.6.9/arch/sh/mm/hugetlbpage.c	2004-10-21 20:02:52.000000000 -0700
@@ -24,7 +24,7 @@
 #include <asm/tlbflush.h>
 #include <asm/cacheflush.h>

-static pte_t *huge_pte_alloc(struct mm_struct *mm, unsigned long addr)
+pte_t *huge_pte_alloc(struct mm_struct *mm, unsigned long addr)
 {
 	pgd_t *pgd;
 	pmd_t *pmd;
@@ -56,7 +56,7 @@

 #define mk_pte_huge(entry) do { pte_val(entry) |= _PAGE_SZHUGE; } while (0)

-static void set_huge_pte(struct mm_struct *mm, struct vm_area_struct *vma,
+void set_huge_pte(struct mm_struct *mm, struct vm_area_struct *vma,
 			 struct page *page, pte_t * page_table, int write_access)
 {
 	unsigned long i;
@@ -101,12 +101,13 @@
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
@@ -116,7 +117,6 @@
 			dst_pte++;
 		}
 		dst->rss += (HPAGE_SIZE / PAGE_SIZE);
-		addr += HPAGE_SIZE;
 	}
 	return 0;

@@ -196,8 +196,7 @@

 	for (address = start; address < end; address += HPAGE_SIZE) {
 		pte = huge_pte_offset(mm, address);
-		BUG_ON(!pte);
-		if (pte_none(*pte))
+		if (!pte || pte_none(*pte))
 			continue;
 		page = pte_page(*pte);
 		put_page(page);
@@ -205,60 +204,7 @@
 			pte_clear(pte);
 			pte++;
 		}
+		mm->rss -= (HPAGE_SIZE / PAGE_SIZE);
 	}
-	mm->rss -= (end - start) >> PAGE_SHIFT;
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
Index: linux-2.6.9/arch/sparc64/mm/hugetlbpage.c
===================================================================
--- linux-2.6.9.orig/arch/sparc64/mm/hugetlbpage.c	2004-10-18 14:54:38.000000000 -0700
+++ linux-2.6.9/arch/sparc64/mm/hugetlbpage.c	2004-10-21 20:02:52.000000000 -0700
@@ -21,7 +21,7 @@
 #include <asm/tlbflush.h>
 #include <asm/cacheflush.h>

-static pte_t *huge_pte_alloc(struct mm_struct *mm, unsigned long addr)
+pte_t *huge_pte_alloc(struct mm_struct *mm, unsigned long addr)
 {
 	pgd_t *pgd;
 	pmd_t *pmd;
@@ -53,7 +53,7 @@

 #define mk_pte_huge(entry) do { pte_val(entry) |= _PAGE_SZHUGE; } while (0)

-static void set_huge_pte(struct mm_struct *mm, struct vm_area_struct *vma,
+void set_huge_pte(struct mm_struct *mm, struct vm_area_struct *vma,
 			 struct page *page, pte_t * page_table, int write_access)
 {
 	unsigned long i;
@@ -98,12 +98,13 @@
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
@@ -113,7 +114,6 @@
 			dst_pte++;
 		}
 		dst->rss += (HPAGE_SIZE / PAGE_SIZE);
-		addr += HPAGE_SIZE;
 	}
 	return 0;

@@ -193,8 +193,7 @@

 	for (address = start; address < end; address += HPAGE_SIZE) {
 		pte = huge_pte_offset(mm, address);
-		BUG_ON(!pte);
-		if (pte_none(*pte))
+		if (!pte || pte_none(*pte))
 			continue;
 		page = pte_page(*pte);
 		put_page(page);
@@ -202,60 +201,7 @@
 			pte_clear(pte);
 			pte++;
 		}
+		mm->rss -= (HPAGE_SIZE / PAGE_SIZE);
 	}
-	mm->rss -= (end - start) >> PAGE_SHIFT;
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
Index: linux-2.6.9/fs/hugetlbfs/inode.c
===================================================================
--- linux-2.6.9.orig/fs/hugetlbfs/inode.c	2004-10-18 14:55:07.000000000 -0700
+++ linux-2.6.9/fs/hugetlbfs/inode.c	2004-10-21 14:50:14.000000000 -0700
@@ -79,10 +79,6 @@
 	if (!(vma->vm_flags & VM_WRITE) && len > inode->i_size)
 		goto out;

-	ret = hugetlb_prefault(mapping, vma);
-	if (ret)
-		goto out;
-
 	if (inode->i_size < len)
 		inode->i_size = len;
 out:
Index: linux-2.6.9/include/linux/hugetlb.h
===================================================================
--- linux-2.6.9.orig/include/linux/hugetlb.h	2004-10-18 14:54:08.000000000 -0700
+++ linux-2.6.9/include/linux/hugetlb.h	2004-10-21 14:50:14.000000000 -0700
@@ -17,7 +17,10 @@
 int follow_hugetlb_page(struct mm_struct *, struct vm_area_struct *, struct page **, struct vm_area_struct **, unsigned long *, int *, int);
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
@@ -61,7 +64,7 @@
 #define follow_hugetlb_page(m,v,p,vs,a,b,i)	({ BUG(); 0; })
 #define follow_huge_addr(mm, addr, write)	ERR_PTR(-EINVAL)
 #define copy_hugetlb_page_range(src, dst, vma)	({ BUG(); 0; })
-#define hugetlb_prefault(mapping, vma)		({ BUG(); 0; })
+#define handle_hugetlb_mm_fault(mm, vma, addr, write) VM_FAULT_SIGBUS
 #define zap_hugepage_range(vma, start, len)	BUG()
 #define unmap_hugepage_range(vma, start, end)	BUG()
 #define is_hugepage_mem_enough(size)		0
Index: linux-2.6.9/mm/hugetlb.c
===================================================================
--- linux-2.6.9.orig/mm/hugetlb.c	2004-10-18 14:54:37.000000000 -0700
+++ linux-2.6.9/mm/hugetlb.c	2004-10-21 20:39:50.000000000 -0700
@@ -8,6 +8,7 @@
 #include <linux/module.h>
 #include <linux/mm.h>
 #include <linux/hugetlb.h>
+#include <linux/pagemap.h>
 #include <linux/sysctl.h>
 #include <linux/highmem.h>

@@ -231,11 +232,65 @@
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
+		set_huge_pte(mm, vma, page, pte, vma->vm_flags & VM_WRITE, addr);
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
Index: linux-2.6.9/mm/memory.c
===================================================================
--- linux-2.6.9.orig/mm/memory.c	2004-10-21 12:01:24.000000000 -0700
+++ linux-2.6.9/mm/memory.c	2004-10-21 14:50:14.000000000 -0700
@@ -765,11 +765,6 @@
 				|| !(flags & vma->vm_flags))
 			return i ? : -EFAULT;

-		if (is_vm_hugetlb_page(vma)) {
-			i = follow_hugetlb_page(mm, vma, pages, vmas,
-						&start, &len, i);
-			continue;
-		}
 		spin_lock(&mm->page_table_lock);
 		do {
 			struct page *map;
@@ -1693,7 +1688,7 @@
 	inc_page_state(pgfault);

 	if (is_vm_hugetlb_page(vma))
-		return VM_FAULT_SIGBUS;	/* mapping truncation does this. */
+		return handle_hugetlb_mm_fault(mm, vma, address, write_access);

 	/*
 	 * We need the page table lock to synchronize with kswapd

