Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267415AbUGNOOk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267415AbUGNOOk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 10:14:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267427AbUGNOOB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 10:14:01 -0400
Received: from sv1.valinux.co.jp ([210.128.90.2]:9148 "EHLO sv1.valinux.co.jp")
	by vger.kernel.org with ESMTP id S267415AbUGNOFY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 10:05:24 -0400
Date: Wed, 14 Jul 2004 23:05:08 +0900 (JST)
Message-Id: <20040714.230508.17596924.taka@valinux.co.jp>
To: linux-kernel@vger.kernel.org, lhms-devel@lists.sourceforge.net
Cc: linux-mm@kvack.org
Subject: [PATCH] memory hotremoval for linux-2.6.7 [9/16]
From: Hirokazu Takahashi <taka@valinux.co.jp>
In-Reply-To: <20040714.224138.95803956.taka@valinux.co.jp>
References: <20040714.224138.95803956.taka@valinux.co.jp>
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.0 (HANANOEN)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--- linux-2.6.7.ORG/include/linux/hugetlb.h	Mon Jul  5 14:01:34 2032
+++ linux-2.6.7/include/linux/hugetlb.h	Mon Jul  5 14:00:53 2032
@@ -25,6 +25,8 @@ struct page *follow_huge_addr(struct mm_
 			      int write);
 struct page *follow_huge_pmd(struct mm_struct *mm, unsigned long address,
 				pmd_t *pmd, int write);
+extern int hugetlb_fault(struct mm_struct *, struct vm_area_struct *,
+				int, unsigned long);
 int is_aligned_hugepage_range(unsigned long addr, unsigned long len);
 int pmd_huge(pmd_t pmd);
 struct page *alloc_huge_page(void);
@@ -81,6 +83,7 @@ static inline unsigned long hugetlb_tota
 #define hugetlb_free_pgtables(tlb, prev, start, end) do { } while (0)
 #define alloc_huge_page()			({ NULL; })
 #define free_huge_page(p)			({ (void)(p); BUG(); })
+#define hugetlb_fault(mm, vma, write, addr)	0
 
 #ifndef HPAGE_MASK
 #define HPAGE_MASK	0		/* Keep the compiler happy */
--- linux-2.6.7.ORG/mm/memory.c	Mon Jul  5 14:01:34 2032
+++ linux-2.6.7/mm/memory.c	Mon Jul  5 13:55:53 2032
@@ -1683,7 +1683,7 @@ int handle_mm_fault(struct mm_struct *mm
 	inc_page_state(pgfault);
 
 	if (is_vm_hugetlb_page(vma))
-		return VM_FAULT_SIGBUS;	/* mapping truncation does this. */
+		return hugetlb_fault(mm, vma, write_access, address);
 
 	/*
 	 * We need the page table lock to synchronize with kswapd
--- linux-2.6.7.ORG/arch/i386/mm/hugetlbpage.c	Mon Jul  5 14:01:34 2032
+++ linux-2.6.7/arch/i386/mm/hugetlbpage.c	Mon Jul  5 14:02:37 2032
@@ -80,10 +80,12 @@ int copy_hugetlb_page_range(struct mm_st
 			goto nomem;
 		src_pte = huge_pte_offset(src, addr);
 		entry = *src_pte;
-		ptepage = pte_page(entry);
-		get_page(ptepage);
+		if (!pte_none(entry)) {
+			ptepage = pte_page(entry);
+			get_page(ptepage);
+			dst->rss += (HPAGE_SIZE / PAGE_SIZE);
+		}
 		set_pte(dst_pte, entry);
-		dst->rss += (HPAGE_SIZE / PAGE_SIZE);
 		addr += HPAGE_SIZE;
 	}
 	return 0;
@@ -111,6 +113,11 @@ follow_hugetlb_page(struct mm_struct *mm
 
 			pte = huge_pte_offset(mm, vaddr);
 
+			if (!pte || pte_none(*pte)) {
+				hugetlb_fault(mm, vma, 0, vaddr);
+				pte = huge_pte_offset(mm, vaddr);
+			}
+
 			/* hugetlb should be locked, and hence, prefaulted */
 			WARN_ON(!pte || pte_none(*pte));
 
@@ -198,6 +205,13 @@ follow_huge_pmd(struct mm_struct *mm, un
 	struct page *page;
 
 	page = pte_page(*(pte_t *)pmd);
+	if (!page) {
+		struct vm_area_struct *vma = find_vma(mm, address);
+		if (!vma)
+			return NULL;
+		hugetlb_fault(mm, vma, write, address);
+		page = pte_page(*(pte_t *)pmd);
+	}
 	if (page)
 		page += ((address & ~HPAGE_MASK) >> PAGE_SHIFT);
 	return page;
@@ -221,11 +235,71 @@ void unmap_hugepage_range(struct vm_area
 			continue;
 		page = pte_page(pte);
 		put_page(page);
+		mm->rss -= (HPAGE_SIZE / PAGE_SIZE);
 	}
-	mm->rss -= (end - start) >> PAGE_SHIFT;
 	flush_tlb_range(vma, start, end);
 }
 
+int hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma, int write_access, unsigned long address)
+{
+	struct file *file = vma->vm_file;
+	struct address_space *mapping = file->f_dentry->d_inode->i_mapping;
+	struct page *page;
+	unsigned long idx;
+	pte_t *pte = huge_pte_alloc(mm, address);
+	int ret;
+
+	BUG_ON(vma->vm_start & ~HPAGE_MASK);
+	BUG_ON(vma->vm_end & ~HPAGE_MASK);
+
+	if (!pte) {
+		ret = VM_FAULT_SIGBUS;
+		goto out;
+	}
+
+	if (!pte_none(*pte)) {
+		ret = VM_FAULT_MINOR;
+		goto out;
+	}
+
+	idx = ((address - vma->vm_start) >> HPAGE_SHIFT)
+		+ (vma->vm_pgoff >> (HPAGE_SHIFT - PAGE_SHIFT));
+again:
+	page = find_lock_page(mapping, idx);
+
+	if (!page) {
+		if (hugetlb_get_quota(mapping)) {
+			ret = VM_FAULT_SIGBUS;
+			goto out;
+		}
+		page = alloc_huge_page();
+		if (!page) {
+			hugetlb_put_quota(mapping);
+			ret = VM_FAULT_SIGBUS;
+			goto out;
+		}
+		ret = add_to_page_cache(page, mapping, idx, GFP_ATOMIC);
+		if (ret) {
+			hugetlb_put_quota(mapping);
+			put_page(page);
+			goto again;
+		}
+	}
+	spin_lock(&mm->page_table_lock);
+	if (pte_none(*pte)) {
+		set_huge_pte(mm, vma, page, pte, vma->vm_flags & VM_WRITE);
+		flush_tlb_page(vma, address);
+		update_mmu_cache(vma, address, *pte);
+	} else {
+		put_page(page);
+	}
+	spin_unlock(&mm->page_table_lock);
+	unlock_page(page);
+	ret = VM_FAULT_MINOR;
+out:
+	return ret;
+}
+
 int hugetlb_prefault(struct address_space *mapping, struct vm_area_struct *vma)
 {
 	struct mm_struct *mm = current->mm;
@@ -235,46 +309,26 @@ int hugetlb_prefault(struct address_spac
 	BUG_ON(vma->vm_start & ~HPAGE_MASK);
 	BUG_ON(vma->vm_end & ~HPAGE_MASK);
 
+#if 0
 	spin_lock(&mm->page_table_lock);
 	for (addr = vma->vm_start; addr < vma->vm_end; addr += HPAGE_SIZE) {
-		unsigned long idx;
-		pte_t *pte = huge_pte_alloc(mm, addr);
-		struct page *page;
-
-		if (!pte) {
-			ret = -ENOMEM;
-			goto out;
+		if (addr < vma->vm_start)
+			addr = vma->vm_start;
+		if (addr >= vma->vm_end) {
+			ret = 0;
+			break;
 		}
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
+		spin_unlock(&mm->page_table_lock);
+		ret = hugetlb_fault(mm, vma, 1, addr);
+		schedule();
+		spin_lock(&mm->page_table_lock);
+		if (ret == VM_FAULT_SIGBUS) {
+			ret = -ENOMEM;
+			break;
 		}
-		set_huge_pte(mm, vma, page, pte, vma->vm_flags & VM_WRITE);
+		ret = 0;
 	}
-out:
 	spin_unlock(&mm->page_table_lock);
+#endif
 	return ret;
 }
