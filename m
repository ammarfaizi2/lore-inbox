Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262772AbUDAJM5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 04:12:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262807AbUDAJM5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 04:12:57 -0500
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:31702 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S262772AbUDAJKb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 04:10:31 -0500
MIME-Version: 1.0
Date: Thu, 01 Apr 2004 18:10:38 +0900
Subject: Re: Hugetlbpages in very large memory machines.......
From: Nobuhiko Yoshida <n-yoshida@pst.fujitsu.com>
To: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Cc: raybry@sgi.com, lse-tech@lists.sourceforge.net, linux-ia64@vger.kernel.org,
       Hirokazu Takahashi <taka@valinux.co.jp>,
       lhms-devel@lists.sourceforge.net
Message-ID: <JL20040401181038.26780140@pst.fujitsu.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
In-Reply-To: <JM20040316121508.13008671@pst.fujitsu.com>
References: <JM20040316121508.13008671@pst.fujitsu.com>
X-Mailer: JsvMail 5.0 (Shuriken Pro3)
X-Priority: 3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nobuhiko Yoshida <n-yoshida@pst.fujitsu.com> wroteF
> Hello,
> 
> > > +/*      update_mmu_cache(vma, address, *pte); */
> > 
> > I have not studied low level IA64 VM in detail, but don't you need
> > some kind of TLB flush here?
> 
> Oh! Yes.
> Perhaps, TLB flush is needed here.

- Below is the patch that revised what I contributed before.
- I added the flush of TLB and icache. 

How To Use:
   1. Download linux-2.6.0 source tree
   2. Apply the below patch for linux-2.6.0

Thank you,
Nobuhiko Yoshida

diff -dupr linux-2.6.0/arch/i386/mm/hugetlbpage.c linux-2.6.0.HugeTLB/arch/i386/mm/hugetlbpage.c
--- linux-2.6.0/arch/i386/mm/hugetlbpage.c  2003-12-18 11:59:38.000000000 +0900
+++ linux-2.6.0.HugeTLB/arch/i386/mm/hugetlbpage.c  2004-04-01 11:48:56.000000000 +0900
@@ -142,8 +142,10 @@ int copy_hugetlb_page_range(struct mm_st
            goto nomem;
        src_pte = huge_pte_offset(src, addr);
        entry = *src_pte;
-       ptepage = pte_page(entry);
-       get_page(ptepage);
+       if (!pte_none(entry)) {
+           ptepage = pte_page(entry);
+           get_page(ptepage);
+       }
        set_pte(dst_pte, entry);
        dst->rss += (HPAGE_SIZE / PAGE_SIZE);
        addr += HPAGE_SIZE;
@@ -173,6 +175,11 @@ follow_hugetlb_page(struct mm_struct *mm
 
            pte = huge_pte_offset(mm, vaddr);
 
+           if (!pte || pte_none(*pte)) {
+               hugetlb_fault(mm, vma, 0, vaddr);
+               pte = huge_pte_offset(mm, vaddr);
+           }
+
            /* hugetlb should be locked, and hence, prefaulted */
            WARN_ON(!pte || pte_none(*pte));
 
@@ -261,12 +268,17 @@ int pmd_huge(pmd_t pmd)
 }
 
 struct page *
-follow_huge_pmd(struct mm_struct *mm, unsigned long address,
-       pmd_t *pmd, int write)
+follow_huge_pmd(struct mm_struct *mm, struct vm_area_struct *vma,
+       unsigned long address, pmd_t *pmd, int write)
 {
    struct page *page;
 
    page = pte_page(*(pte_t *)pmd);
+
+   if (!page) {
+       hugetlb_fault(mm, vma, write, address);
+       page = pte_page(*(pte_t *)pmd);
+   }
    if (page) {
        page += ((address & ~HPAGE_MASK) >> PAGE_SHIFT);
        get_page(page);
@@ -527,6 +539,48 @@ int is_hugepage_mem_enough(size_t size)
    return (size + ~HPAGE_MASK)/HPAGE_SIZE <= htlbpagemem;
 }
 
+
+int hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma, int write_access, unsigned long address)
+{
+   struct file *file = vma->vm_file;
+   struct address_space *mapping = file->f_dentry->d_inode->i_mapping;
+   struct page *page;
+   unsigned long idx;
+   pte_t *pte;
+   int ret = VM_FAULT_MINOR;
+
+   BUG_ON(vma->vm_start & ~HPAGE_MASK);
+   BUG_ON(vma->vm_end & ~HPAGE_MASK);
+
+   spin_lock(&mm->page_table_lock);
+
+   idx = ((address - vma->vm_start) >> HPAGE_SHIFT)
+       + (vma->vm_pgoff >> (HPAGE_SHIFT - PAGE_SHIFT));
+   page = find_get_page(mapping, idx);
+
+   if (!page) {
+       page = alloc_hugetlb_page();
+       if (!page) {
+           ret = VM_FAULT_SIGBUS;
+           goto out;
+       }
+       ret = add_to_page_cache(page, mapping, idx, GFP_ATOMIC);
+       unlock_page(page);
+       if (ret) {
+           free_huge_page(page);
+           ret = VM_FAULT_SIGBUS;
+           goto out;
+       }
+   }
+   pte = huge_pte_alloc(mm, address);
+   set_huge_pte(mm, vma, page, pte, vma->vm_flags & VM_WRITE);
+/*     update_mmu_cache(vma, address, *pte); */
+out:
+   spin_unlock(&mm->page_table_lock);
+   return ret;
+}
+
+
 /*
  * We cannot handle pagefaults against hugetlb pages at all.  They cause
  * handle_mm_fault() to try to instantiate regular-sized pages in the
diff -dupr linux-2.6.0/arch/ia64/mm/hugetlbpage.c linux-2.6.0.HugeTLB/arch/ia64/mm/hugetlbpage.c
--- linux-2.6.0/arch/ia64/mm/hugetlbpage.c  2003-12-18 11:58:56.000000000 +0900
+++ linux-2.6.0.HugeTLB/arch/ia64/mm/hugetlbpage.c  2004-03-22 11:29:01.000000000 +0900
@@ -170,8 +170,10 @@ int copy_hugetlb_page_range(struct mm_st
            goto nomem;
        src_pte = huge_pte_offset(src, addr);
        entry = *src_pte;
-       ptepage = pte_page(entry);
-       get_page(ptepage);
+       if (!pte_none(entry)) {
+           ptepage = pte_page(entry);
+           get_page(ptepage);
+       }   
        set_pte(dst_pte, entry);
        dst->rss += (HPAGE_SIZE / PAGE_SIZE);
        addr += HPAGE_SIZE;
@@ -195,6 +197,12 @@ follow_hugetlb_page(struct mm_struct *mm
    do {
        pstart = start & HPAGE_MASK;
        ptep = huge_pte_offset(mm, start);
+
+       if (!ptep || pte_none(*ptep)) {
+           hugetlb_fault(mm, vma, 0, start);
+           ptep = huge_pte_offset(mm, start);
+       }
+
        pte = *ptep;
 
 back1:
@@ -236,6 +244,12 @@ struct page *follow_huge_addr(struct mm_
    pte_t *ptep;
 
    ptep = huge_pte_offset(mm, addr);
+
+   if (!ptep || pte_none(*ptep)) {
+       hugetlb_fault(mm, vma, 0, addr);
+       ptep = huge_pte_offset(mm, addr);
+   }
+
    page = pte_page(*ptep);
    page += ((addr & ~HPAGE_MASK) >> PAGE_SHIFT);
    get_page(page);
@@ -246,7 +260,8 @@ int pmd_huge(pmd_t pmd)
    return 0;
 }
 struct page *
-follow_huge_pmd(struct mm_struct *mm, unsigned long address, pmd_t *pmd, int write)
+follow_huge_pmd(struct mm_struct *mm, struct vm_area_struct *vma,
+       unsigned long address, pmd_t *pmd, int write)
 {
    return NULL;
 }
@@ -518,6 +533,49 @@ int is_hugepage_mem_enough(size_t size)
    return 1;
 }
 
+
+int hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma, int write_access, unsigned long address)
+{
+   struct file *file = vma->vm_file;
+   struct address_space *mapping = file->f_dentry->d_inode->i_mapping;
+   struct page *page;
+   unsigned long idx;
+   pte_t *pte;
+   int ret = VM_FAULT_MINOR;
+
+   BUG_ON(vma->vm_start & ~HPAGE_MASK);
+   BUG_ON(vma->vm_end & ~HPAGE_MASK);
+
+   spin_lock(&mm->page_table_lock);
+
+   idx = ((address - vma->vm_start) >> HPAGE_SHIFT)
+       + (vma->vm_pgoff >> (HPAGE_SHIFT - PAGE_SHIFT));
+   page = find_get_page(mapping, idx);
+
+   if (!page) {
+       page = alloc_hugetlb_page();
+       if (!page) {
+           ret = VM_FAULT_SIGBUS;
+           goto out;
+       }
+       ret = add_to_page_cache(page, mapping, idx, GFP_ATOMIC);
+       unlock_page(page);
+       if (ret) {
+           free_huge_page(page);
+           ret = VM_FAULT_SIGBUS;
+           goto out;
+       }
+   }
+   pte = huge_pte_alloc(mm, address);
+   set_huge_pte(mm, vma, page, pte, vma->vm_flags & VM_WRITE);
+   flush_tlb_range(vma, address, address + HPAGE_SIZE);
+   update_mmu_cache(vma, address, *pte);
+out:
+   spin_unlock(&mm->page_table_lock);
+   return ret;
+}
+
+
 static struct page *hugetlb_nopage(struct vm_area_struct * area, unsigned long address, int unused)
 {
    BUG();
diff -dupr linux-2.6.0/include/linux/hugetlb.h linux-2.6.0.HugeTLB/include/linux/hugetlb.h
--- linux-2.6.0/include/linux/hugetlb.h 2003-12-18 11:58:49.000000000 +0900
+++ linux-2.6.0.HugeTLB/include/linux/hugetlb.h 2003-12-19 09:47:25.000000000 +0900
@@ -23,10 +23,12 @@ struct page *follow_huge_addr(struct mm_
            unsigned long address, int write);
 struct vm_area_struct *hugepage_vma(struct mm_struct *mm,
                    unsigned long address);
-struct page *follow_huge_pmd(struct mm_struct *mm, unsigned long address,
-               pmd_t *pmd, int write);
+struct page *follow_huge_pmd(struct mm_struct *mm, struct vm_area_struct *,
+               unsigned long address, pmd_t *pmd, int write);
 int is_aligned_hugepage_range(unsigned long addr, unsigned long len);
 int pmd_huge(pmd_t pmd);
+extern int hugetlb_fault(struct mm_struct *, struct vm_area_struct *,
+               int, unsigned long);
 
 extern int htlbpage_max;
 
@@ -63,6 +65,7 @@ static inline int is_vm_hugetlb_page(str
 #define is_aligned_hugepage_range(addr, len)   0
 #define pmd_huge(x)    0
 #define is_hugepage_only_range(addr, len)  0
+#define hugetlb_fault(mm, vma, write, addr)    0
 
 #ifndef HPAGE_MASK
 #define HPAGE_MASK 0       /* Keep the compiler happy */
diff -dupr linux-2.6.0/mm/memory.c linux-2.6.0.HugeTLB/mm/memory.c
--- linux-2.6.0/mm/memory.c 2003-12-18 11:58:48.000000000 +0900
+++ linux-2.6.0.HugeTLB/mm/memory.c 2003-12-19 09:47:46.000000000 +0900
@@ -640,7 +640,7 @@ follow_page(struct mm_struct *mm, unsign
    if (pmd_none(*pmd))
        goto out;
    if (pmd_huge(*pmd))
-       return follow_huge_pmd(mm, address, pmd, write);
+       return follow_huge_pmd(mm, vma, address, pmd, write);
    if (pmd_bad(*pmd))
        goto out;
 
@@ -1603,7 +1603,7 @@ int handle_mm_fault(struct mm_struct *mm
    inc_page_state(pgfault);
 
    if (is_vm_hugetlb_page(vma))
-       return VM_FAULT_SIGBUS; /* mapping truncation does this. */
+       return hugetlb_fault(mm, vma, write_access, address);
 
    /*
     * We need the page table lock to synchronize with kswapd
