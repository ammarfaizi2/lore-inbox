Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263794AbUDFMpT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 08:45:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263798AbUDFMpS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 08:45:18 -0400
Received: from sv1.valinux.co.jp ([210.128.90.2]:9899 "EHLO sv1.valinux.co.jp")
	by vger.kernel.org with ESMTP id S263794AbUDFMov (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 08:44:51 -0400
Date: Tue, 06 Apr 2004 21:45:01 +0900 (JST)
Message-Id: <20040406.214501.123281227.taka@valinux.co.jp>
To: linux-kernel@vger.kernel.org, lhms-devel@lists.sourceforge.net
Subject: [patch 2/6] memory hotplug for hugetlbpages
From: Hirokazu Takahashi <taka@valinux.co.jp>
In-Reply-To: <20040406.214123.129013798.taka@valinux.co.jp>
References: <20040406105353.9BDE8705DE@sv1.valinux.co.jp>
	<20040406.214123.129013798.taka@valinux.co.jp>
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.0 (HANANOEN)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a part 2 of memory hotplug patches for hugetlbpages.

$Id: va-hugepagefault.patch,v 1.8 2004/04/05 06:13:36 taka Exp $

--- linux-2.6.5.ORG/include/linux/hugetlb.h	Mon Apr  5 16:13:27 2032
+++ linux-2.6.5/include/linux/hugetlb.h	Mon Apr  5 16:15:15 2032
@@ -24,10 +24,12 @@ struct page *follow_huge_addr(struct mm_
 			unsigned long address, int write);
 struct vm_area_struct *hugepage_vma(struct mm_struct *mm,
 					unsigned long address);
-struct page *follow_huge_pmd(struct mm_struct *mm, unsigned long address,
-				pmd_t *pmd, int write);
+struct page *follow_huge_pmd(struct mm_struct *mm, struct vm_area_struct *,
+				unsigned long address, pmd_t *pmd, int write);
 int is_aligned_hugepage_range(unsigned long addr, unsigned long len);
 int pmd_huge(pmd_t pmd);
+extern int hugetlb_fault(struct mm_struct *, struct vm_area_struct *,
+				int, unsigned long);
 
 extern int htlbpage_max;
 
@@ -72,12 +74,13 @@ static inline unsigned long hugetlb_tota
 #define hugetlb_report_meminfo(buf)		0
 #define hugepage_vma(mm, addr)			0
 #define mark_mm_hugetlb(mm, vma)		do { } while (0)
-#define follow_huge_pmd(mm, addr, pmd, write)	0
+#define follow_huge_pmd(mm, vma, addr, pmd, write)	0
 #define is_aligned_hugepage_range(addr, len)	0
 #define prepare_hugepage_range(addr, len)	(-EINVAL)
 #define pmd_huge(x)	0
 #define is_hugepage_only_range(addr, len)	0
 #define hugetlb_free_pgtables(tlb, prev, start, end) do { } while (0)
+#define hugetlb_fault(mm, vma, write, addr)	0
 
 #ifndef HPAGE_MASK
 #define HPAGE_MASK	0		/* Keep the compiler happy */
--- linux-2.6.5.ORG/mm/memory.c	Mon Apr  5 16:13:38 2032
+++ linux-2.6.5/mm/memory.c	Mon Apr  5 16:14:02 2032
@@ -643,7 +643,7 @@ follow_page(struct mm_struct *mm, unsign
 	if (pmd_none(*pmd))
 		goto out;
 	if (pmd_huge(*pmd))
-		return follow_huge_pmd(mm, address, pmd, write);
+		return follow_huge_pmd(mm, vma, address, pmd, write);
 	if (pmd_bad(*pmd))
 		goto out;
 
@@ -1628,7 +1628,7 @@ int handle_mm_fault(struct mm_struct *mm
 	inc_page_state(pgfault);
 
 	if (is_vm_hugetlb_page(vma))
-		return VM_FAULT_SIGBUS;	/* mapping truncation does this. */
+		return hugetlb_fault(mm, vma, write_access, address);
 
 	/*
 	 * We need the page table lock to synchronize with kswapd
--- linux-2.6.5.ORG/arch/i386/mm/hugetlbpage.c	Mon Apr  5 16:13:30 2032
+++ linux-2.6.5/arch/i386/mm/hugetlbpage.c	Mon Apr  5 16:14:02 2032
@@ -142,8 +142,10 @@ int copy_hugetlb_page_range(struct mm_st
 			goto nomem;
 		src_pte = huge_pte_offset(src, addr);
 		entry = *src_pte;
-		ptepage = pte_page(entry);
-		get_page(ptepage);
+		if (!pte_none(entry)) {
+			ptepage = pte_page(entry);
+			get_page(ptepage);
+		}
 		set_pte(dst_pte, entry);
 		dst->rss += (HPAGE_SIZE / PAGE_SIZE);
 		addr += HPAGE_SIZE;
@@ -173,6 +175,11 @@ follow_hugetlb_page(struct mm_struct *mm
 
 			pte = huge_pte_offset(mm, vaddr);
 
+			if (!pte || pte_none(*pte)) {
+				hugetlb_fault(mm, vma, 0, vaddr);
+				pte = huge_pte_offset(mm, vaddr);
+			}
+
 			/* hugetlb should be locked, and hence, prefaulted */
 			WARN_ON(!pte || pte_none(*pte));
 
@@ -261,12 +268,17 @@ int pmd_huge(pmd_t pmd)
 }
 
 struct page *
-follow_huge_pmd(struct mm_struct *mm, unsigned long address,
-		pmd_t *pmd, int write)
+follow_huge_pmd(struct mm_struct *mm, struct vm_area_struct *vma,
+		unsigned long address, pmd_t *pmd, int write)
 {
 	struct page *page;
 
 	page = pte_page(*(pte_t *)pmd);
+
+	if (!page) {
+		hugetlb_fault(mm, vma, write, address);
+		page = pte_page(*(pte_t *)pmd);
+	}
 	if (page) {
 		page += ((address & ~HPAGE_MASK) >> PAGE_SHIFT);
 		get_page(page);
@@ -329,54 +341,94 @@ zap_hugepage_range(struct vm_area_struct
 	spin_unlock(&mm->page_table_lock);
 }
 
-int hugetlb_prefault(struct address_space *mapping, struct vm_area_struct *vma)
+int hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma, int write_access, unsigned long address)
 {
-	struct mm_struct *mm = current->mm;
-	unsigned long addr;
-	int ret = 0;
+	struct file *file = vma->vm_file;
+	struct address_space *mapping = file->f_dentry->d_inode->i_mapping;
+	struct page *page;
+	unsigned long idx;
+	pte_t *pte = huge_pte_alloc(mm, address);
+	int ret;
 
 	BUG_ON(vma->vm_start & ~HPAGE_MASK);
 	BUG_ON(vma->vm_end & ~HPAGE_MASK);
 
-	spin_lock(&mm->page_table_lock);
-	for (addr = vma->vm_start; addr < vma->vm_end; addr += HPAGE_SIZE) {
-		unsigned long idx;
-		pte_t *pte = huge_pte_alloc(mm, addr);
-		struct page *page;
+	if (!pte) {
+		ret = VM_FAULT_SIGBUS;
+		goto out;
+	}
 
-		if (!pte) {
-			ret = -ENOMEM;
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
 			goto out;
 		}
-		if (!pte_none(*pte))
-			continue;
-
-		idx = ((addr - vma->vm_start) >> HPAGE_SHIFT)
-			+ (vma->vm_pgoff >> (HPAGE_SHIFT - PAGE_SHIFT));
-		page = find_get_page(mapping, idx);
+		page = alloc_hugetlb_page();
 		if (!page) {
-			/* charge the fs quota first */
-			if (hugetlb_get_quota(mapping)) {
-				ret = -ENOMEM;
-				goto out;
-			}
-			page = alloc_hugetlb_page();
-			if (!page) {
-				hugetlb_put_quota(mapping);
-				ret = -ENOMEM;
-				goto out;
-			}
-			ret = add_to_page_cache(page, mapping, idx, GFP_ATOMIC);
+			hugetlb_put_quota(mapping);
+			ret = VM_FAULT_SIGBUS;
+			goto out;
+		}
+		ret = add_to_page_cache(page, mapping, idx, GFP_ATOMIC);
+		if (ret) {
+			hugetlb_put_quota(mapping);
+			free_huge_page(page);
 			unlock_page(page);
-			if (ret) {
-				hugetlb_put_quota(mapping);
-				free_huge_page(page);
-				goto out;
-			}
+			goto again;
 		}
+	}
+	spin_lock(&mm->page_table_lock);
+	if (pte_none(*pte)) {
 		set_huge_pte(mm, vma, page, pte, vma->vm_flags & VM_WRITE);
+		flush_tlb_page(vma, address);
+		update_mmu_cache(vma, address, *pte);
+	} else {
+		huge_page_release(page);
 	}
+	spin_unlock(&mm->page_table_lock);
+	unlock_page(page);
+	ret = VM_FAULT_MINOR;
 out:
+	return ret;
+}
+
+int hugetlb_prefault(struct address_space *mapping, struct vm_area_struct *vma)
+{
+	struct mm_struct *mm = current->mm;
+	unsigned long addr;
+	int ret = 0;
+
+	BUG_ON(vma->vm_start & ~HPAGE_MASK);
+	BUG_ON(vma->vm_end & ~HPAGE_MASK);
+
+	spin_lock(&mm->page_table_lock);
+	for (addr = vma->vm_start; addr < vma->vm_end; addr += HPAGE_SIZE) {
+		if (addr < vma->vm_start)
+			addr = vma->vm_start;
+		if (addr >= vma->vm_end) {
+			ret = 0;
+			break;
+		}
+		spin_unlock(&mm->page_table_lock);
+		ret = hugetlb_fault(mm, vma, 1, addr);
+		schedule();
+		spin_lock(&mm->page_table_lock);
+		if (ret == VM_FAULT_SIGBUS) {
+			ret = -ENOMEM;
+			break;
+		}
+		ret = 0;
+	}
 	spin_unlock(&mm->page_table_lock);
 	return ret;
 }
