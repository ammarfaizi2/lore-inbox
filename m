Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267390AbUGNOel@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267390AbUGNOel (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 10:34:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267429AbUGNOPl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 10:15:41 -0400
Received: from sv1.valinux.co.jp ([210.128.90.2]:11196 "EHLO sv1.valinux.co.jp")
	by vger.kernel.org with ESMTP id S267416AbUGNOF6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 10:05:58 -0400
Date: Wed, 14 Jul 2004 23:05:43 +0900 (JST)
Message-Id: <20040714.230543.13595439.taka@valinux.co.jp>
To: linux-kernel@vger.kernel.org, lhms-devel@lists.sourceforge.net
Cc: linux-mm@kvack.org
Subject: [PATCH] memory hotremoval for linux-2.6.7 [11/16]
From: Hirokazu Takahashi <taka@valinux.co.jp>
In-Reply-To: <20040714.224138.95803956.taka@valinux.co.jp>
References: <20040714.224138.95803956.taka@valinux.co.jp>
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.0 (HANANOEN)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--- linux-2.6.7.ORG/include/linux/hugetlb.h	Mon Jul  5 14:05:39 2032
+++ linux-2.6.7/include/linux/hugetlb.h	Mon Jul  5 14:06:19 2032
@@ -27,6 +27,7 @@ struct page *follow_huge_pmd(struct mm_s
 				pmd_t *pmd, int write);
 extern int hugetlb_fault(struct mm_struct *, struct vm_area_struct *,
 				int, unsigned long);
+int try_to_unmap_hugepage(struct page *page, struct vm_area_struct *vma, struct list_head *force);
 int is_aligned_hugepage_range(unsigned long addr, unsigned long len);
 int pmd_huge(pmd_t pmd);
 struct page *alloc_huge_page(void);
@@ -84,6 +85,7 @@ static inline unsigned long hugetlb_tota
 #define alloc_huge_page()			({ NULL; })
 #define free_huge_page(p)			({ (void)(p); BUG(); })
 #define hugetlb_fault(mm, vma, write, addr)	0
+#define try_to_unmap_hugepage(page, vma, force)	0
 
 #ifndef HPAGE_MASK
 #define HPAGE_MASK	0		/* Keep the compiler happy */
--- linux-2.6.7.ORG/mm/rmap.c	Mon Jul  5 14:01:22 2032
+++ linux-2.6.7/mm/rmap.c	Mon Jul  5 14:06:19 2032
@@ -27,6 +27,7 @@
  *   on the mm->page_table_lock
  */
 #include <linux/mm.h>
+#include <linux/hugetlb.h>
 #include <linux/pagemap.h>
 #include <linux/swap.h>
 #include <linux/swapops.h>
@@ -441,6 +442,13 @@ static int try_to_unmap_one(struct page 
 	address = vma_address(page, vma);
 	if (address == -EFAULT)
 		goto out;
+
+	/*
+	 * Is there any better way to check whether the page is
+	 * HugePage or not?
+	 */
+	if (vma && is_vm_hugetlb_page(vma))
+		return try_to_unmap_hugepage(page, vma, force);
 
 	/*
 	 * We need the page_table_lock to protect us from page faults,
--- linux-2.6.7.ORG/arch/i386/mm/hugetlbpage.c	Mon Jul  5 14:05:39 2032
+++ linux-2.6.7/arch/i386/mm/hugetlbpage.c	Mon Jul  5 14:06:19 2032
@@ -10,6 +10,7 @@
 #include <linux/mm.h>
 #include <linux/hugetlb.h>
 #include <linux/pagemap.h>
+#include <linux/rmap.h>
 #include <linux/smp_lock.h>
 #include <linux/slab.h>
 #include <linux/err.h>
@@ -83,6 +84,7 @@ int copy_hugetlb_page_range(struct mm_st
 		if (!pte_none(entry)) {
 			ptepage = pte_page(entry);
 			get_page(ptepage);
+			page_dup_rmap(ptepage);
 			dst->rss += (HPAGE_SIZE / PAGE_SIZE);
 		}
 		set_pte(dst_pte, entry);
@@ -234,6 +236,7 @@ void unmap_hugepage_range(struct vm_area
 		if (pte_none(pte))
 			continue;
 		page = pte_page(pte);
+		page_remove_rmap(page);
 		put_page(page);
 		mm->rss -= (HPAGE_SIZE / PAGE_SIZE);
 	}
@@ -288,6 +291,7 @@ again:
 	spin_lock(&mm->page_table_lock);
 	if (pte_none(*pte)) {
 		set_huge_pte(mm, vma, page, pte, vma->vm_flags & VM_WRITE);
+		page_add_file_rmap(page);
 		flush_tlb_page(vma, address);
 		update_mmu_cache(vma, address, *pte);
 	} else {
@@ -332,3 +336,87 @@ int hugetlb_prefault(struct address_spac
 #endif
 	return ret;
 }
+
+/*
+ * At what user virtual address is page expected in vma?
+ */
+static inline unsigned long
+huge_vma_address(struct page *page, struct vm_area_struct *vma)
+{
+	pgoff_t pgoff = page->index << (PAGE_CACHE_SHIFT - PAGE_SHIFT);
+	unsigned long address;
+
+	address = vma->vm_start + ((pgoff - vma->vm_pgoff) << HPAGE_SHIFT);
+	if (unlikely(address < vma->vm_start || address >= vma->vm_end)) {
+		/* page should be within any vma from prio_tree_next */
+		BUG_ON(!PageAnon(page));
+		return -EFAULT;
+	}
+	return address;
+}
+
+/*
+ * Try to clear the PTE which map the hugepage.
+ */
+int try_to_unmap_hugepage(struct page *page, struct vm_area_struct *vma,
+				struct list_head *force)
+{
+	pte_t *pte;
+	pte_t pteval;
+	int ret = SWAP_AGAIN;
+	struct mm_struct *mm = vma->vm_mm;
+	unsigned long address;
+
+	address = huge_vma_address(page, vma);
+	if (address == -EFAULT)
+		goto out;
+
+	/*
+	 * We need the page_table_lock to protect us from page faults,
+	 * munmap, fork, etc...
+	 */
+	if (!spin_trylock(&mm->page_table_lock))
+		goto out;
+
+	pte = huge_pte_offset(mm, address);
+	if (!pte || pte_none(*pte))
+		goto out_unlock;
+	if (!pte_present(*pte))
+		goto out_unlock;
+
+	if (page_to_pfn(page) != pte_pfn(*pte))
+		goto out_unlock;
+
+	BUG_ON(!vma);
+
+#if 0 
+	if ((vma->vm_flags & (VM_LOCKED|VM_RESERVED)) ||
+			ptep_test_and_clear_young(pte)) {
+		ret = SWAP_FAIL;
+		goto out_unlock;
+	}
+#endif
+
+	/* Nuke the page table entry. */
+	flush_cache_page(vma, address);
+	pteval = ptep_get_and_clear(pte);
+	flush_tlb_range(vma, address, address + HPAGE_SIZE);
+
+	/* Move the dirty bit to the physical page now the pte is gone. */
+	if (pte_dirty(pteval))
+		set_page_dirty(page);
+
+	BUG_ON(PageAnon(page));
+
+	mm->rss -= (HPAGE_SIZE / PAGE_SIZE);
+	BUG_ON(!page->mapcount);
+	page->mapcount--;
+	page_cache_release(page);
+
+out_unlock:
+	spin_unlock(&mm->page_table_lock);
+
+out:
+	return ret;
+}
+
