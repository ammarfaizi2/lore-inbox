Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263310AbUCPAiR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 19:38:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262962AbUCPAbw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 19:31:52 -0500
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:14010 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S263318AbUCPAaN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 19:30:13 -0500
MIME-Version: 1.0
Date: Tue, 16 Mar 2004 09:30:03 +0900
Subject: Re: Hugetlbpages in very large memory machines.......
From: Nobuhiko Yoshida <n-yoshida@pst.fujitsu.com>
To: raybry@sgi.com, linux-kernel@vger.kernel.org
Cc: lse-tech@lists.sourceforge.net, linux-ia64@vger.kernel.org,
       Hirokazu Takahashi <taka@valinux.co.jp>
Message-ID: <JP20040316093003.3103921@pst.fujitsu.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
In-Reply-To: <20040313.135638.78732994.taka@valinux.co.jp>
References: <20040313.135638.78732994.taka@valinux.co.jp>
X-Mailer: JsvMail 5.0 (Shuriken Pro3)
X-Priority: 3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Hirokazu Takahashi <taka@valinux.co.jp> :
> Hello,
> 
> My following patch might help you. It inclueds pagefault routine
> for hugetlbpages. If you want to use it for your purpose, you need to
> remove some code from hugetlb_prefault() that will call hugetlb_fault().
> http://people.valinux.co.jp/~taka/patches/va01-hugepagefault.patch
> 
> But it's just for IA32.
> 
> I heard that n-yoshida@pst.fujitsu.com was porting this patch
> on IA64.

Below is the patch I ported Takahashi-san's one for IA64.
However, my patch is for kernel 2.6.0 and cannot be
appiled to 2.6.1 or later.

Thank you,
Nobuhiko Yoshida

diff -dupr linux-2.6.0.org/arch/ia64/mm/hugetlbpage.c linux-2.6.0.HugeTLB/arch/ia64/mm/hugetlbpage.c
--- linux-2.6.0.org/arch/ia64/mm/hugetlbpage.c  2003-12-18 11:58:56.000000000 +0900
+++ linux-2.6.0.HugeTLB/arch/ia64/mm/hugetlbpage.c  2004-01-06 14:26:53.000000000 +0900
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
@@ -518,6 +533,48 @@ int is_hugepage_mem_enough(size_t size)
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
+/*      update_mmu_cache(vma, address, *pte); */
+out:
+   spin_unlock(&mm->page_table_lock);
+   return ret;
+}
+
+
 static struct page *hugetlb_nopage(struct vm_area_struct * area, unsigned long address, int unused)
 {
    BUG();
