Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265542AbUGTLOE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265542AbUGTLOE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jul 2004 07:14:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265784AbUGTLOE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jul 2004 07:14:04 -0400
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:15074 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S265542AbUGTLN4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jul 2004 07:13:56 -0400
MIME-Version: 1.0
Date: Tue, 20 Jul 2004 20:13:54 +0900
Subject: [PATCH] ia64 memory hotplug for hugetlbpages [1/4]
From: Nobuhiko Yoshida <n-yoshida@pst.fujitsu.com>
To: linux-kernel@vger.kernel.org, lhms-devel@lists.sourceforge.net
Message-ID: <JJ200407202013546.32963703@pst.fujitsu.com>
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
X-Mailer: JsvMail 5.5 (Shuriken Pro3)
X-Priority: 3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


diff -dupr linux-2.6.7/arch/ia64/mm/hugetlbpage.c linux-2.6.7-FAULT/arch/ia64/mm/hugetlbpage.c
--- linux-2.6.7/arch/ia64/mm/hugetlbpage.c  2004-06-16 14:19:23.000000000 +0900
+++ linux-2.6.7-FAULT/arch/ia64/mm/hugetlbpage.c    2004-07-09 15:28:25.000000000 +0900
@@ -105,10 +105,12 @@ int copy_hugetlb_page_range(struct mm_st
            goto nomem;
        src_pte = huge_pte_offset(src, addr);
        entry = *src_pte;
-       ptepage = pte_page(entry);
-       get_page(ptepage);
+       if (!pte_none(entry)) {
+           ptepage = pte_page(entry);
+           get_page(ptepage);
+           dst->rss += (HPAGE_SIZE / PAGE_SIZE);
+       }
        set_pte(dst_pte, entry);
-       dst->rss += (HPAGE_SIZE / PAGE_SIZE);
        addr += HPAGE_SIZE;
    }
    return 0;
@@ -130,6 +132,10 @@ follow_hugetlb_page(struct mm_struct *mm
    do {
        pstart = start & HPAGE_MASK;
        ptep = huge_pte_offset(mm, start);
+       if (!ptep || pte_none(*ptep)) {
+           hugetlb_fault(mm, vma, 0, start);
+           ptep = huge_pte_offset(mm, start);
+       }
        pte = *ptep;
 
 back1:
@@ -167,6 +173,13 @@ struct page *follow_huge_addr(struct mm_
    if (!ptep || pte_none(*ptep))
        return NULL;
    page = pte_page(*ptep);
+   if (!page) {
+       struct vm_area_struct *vma = find_vma(mm, addr);
+       if (!vma)
+           return NULL;
+       hugetlb_fault(mm, vma, 0, addr);
+       page = pte_page(*ptep);
+   }
    page += ((addr & ~HPAGE_MASK) >> PAGE_SHIFT);
    return page;
 }
@@ -250,8 +263,8 @@ void unmap_hugepage_range(struct vm_area
        page = pte_page(*pte);
        put_page(page);
        pte_clear(pte);
+       mm->rss -= (HPAGE_SIZE / PAGE_SIZE);
    }
-   mm->rss -= (end - start) >> PAGE_SHIFT;
    flush_tlb_range(vma, start, end);
 }
 
@@ -308,6 +321,68 @@ out:
    return ret;
 }
 
+int hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma, int write_access, unsigned long address)
+{
+   struct file *file = vma->vm_file;
+   struct address_space *mapping = file->f_dentry->d_inode->i_mapping;
+   struct page *page;
+   unsigned long idx;
+   pte_t *pte = huge_pte_alloc(mm, address);
+   int ret;
+
+   BUG_ON(vma->vm_start & ~HPAGE_MASK);
+   BUG_ON(vma->vm_end & ~HPAGE_MASK);
+
+   spin_lock(&mm->page_table_lock);
+
+   if (!pte) {
+       ret = VM_FAULT_SIGBUS;
+       goto out;
+   }
+
+   if (!pte_none(*pte)) {
+       ret = VM_FAULT_MINOR;
+       goto out;
+   }
+
+   idx = ((address - vma->vm_start) >> HPAGE_SHIFT)
+       + (vma->vm_pgoff >> (HPAGE_SHIFT - PAGE_SHIFT));
+again:
+   page = find_get_page(mapping, idx);
+
+   if (!page) {
+       /* charge the fs quota first */
+       if (hugetlb_get_quota(mapping)) {
+           ret = VM_FAULT_SIGBUS;
+           goto out;
+       }
+       page = alloc_huge_page();
+       if (!page) {
+           hugetlb_put_quota(mapping);
+           ret = VM_FAULT_SIGBUS;
+           goto out;
+       }
+       ret = add_to_page_cache(page, mapping, idx, GFP_ATOMIC);
+       if (ret) {
+           hugetlb_put_quota(mapping);
+           put_page(page);
+           goto again;
+       }
+   }
+   if (pte_none(*pte)) {
+       set_huge_pte(mm, vma, page, pte, vma->vm_flags & VM_WRITE);
+       flush_tlb_range(vma, address, address + HPAGE_SIZE);
+       update_mmu_cache(vma, address, *pte);
+   } else {
+       put_page(page);
+   }
+   ret = VM_FAULT_MINOR;
+out:
+   spin_unlock(&mm->page_table_lock);
+   unlock_page(page);
+   return ret;
+}
+
 unsigned long hugetlb_get_unmapped_area(struct file *file, unsigned long addr, unsigned long len,
        unsigned long pgoff, unsigned long flags)
 {
