Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263033AbUCMDyg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Mar 2004 22:54:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263040AbUCMDyd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Mar 2004 22:54:33 -0500
Received: from ns.suse.de ([195.135.220.2]:51354 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S263033AbUCMDyU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Mar 2004 22:54:20 -0500
Date: Sat, 13 Mar 2004 04:48:40 +0100
From: Andi Kleen <ak@suse.de>
To: Ray Bryant <raybry@sgi.com>
Cc: lse-tech@lists.sourceforge.net,
       "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
       linux-kernel@vger.kernel.org
Subject: Re: Hugetlbpages in very large memory machines.......
Message-ID: <20040313034840.GF4638@wotan.suse.de>
References: <40528383.10305@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40528383.10305@sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 12, 2004 at 09:44:03PM -0600, Ray Bryant wrote:
> We've run into a scaling problem using hugetlbpages in very large memory 
> machines, e. g. machines with 1TB or more of main memory.  The problem is 
> that hugetlbpage pages are not faulted in, rather they are zeroed and 
> mapped in in by hugetlb_prefault() (at least on ia64), which is called in 
> response to the user's mmap() request.  The net is that all of the hugetlb 
> pages end up being allocated and zeroed by a single thread, and if most of 
> the machine's memory is allocated to hugetlb pages, and there is 1 TB or 
> more of main memory, zeroing and allocating all of those pages can take a 
> long time (500 s or more).
> 
> We've looked at allocating and zeroing hugetlbpages at fault time, which 
> would at least allow multiple processors to be thrown at the problem.  
> Question is, has anyone else been working on
> this problem and might they have prototype code they could share with us?

Yes. I ran into exactly this problem with NUMA API too. 
mbind() runs after mmap, but it cannot work anymore when
the pages are already allocated.

I fixed it on x86-64/i386 by allocating the pages lazily.
Doing it for IA64 has been on the todo list too.

i386/x86-64 Code as an example attached.

One drawback is that the out of memory handling is lot less nicer
than it was before - when you run out of hugepages you get SIGBUS
now instead of a ENOMEM from mmap. Maybe some prereservation would
make sense, but that would be somewhat harder. Alternatively
fall back to smaller pages if possible (I was told it isn't easily
possible on IA64)

-Andi


diff -burpN -X ../KDIFX linux-2.6.2/arch/i386/mm/hugetlbpage.c linux-2.6.2-numa/arch/i386/mm/hugetlbpage.c
--- linux-2.6.2/arch/i386/mm/hugetlbpage.c	2004-02-24 20:48:10.000000000 +0100
+++ linux-2.6.2-numa/arch/i386/mm/hugetlbpage.c	2004-02-20 18:52:57.000000000 +0100
@@ -329,41 +333,43 @@ zap_hugepage_range(struct vm_area_struct
 	spin_unlock(&mm->page_table_lock);
 }
 
-int hugetlb_prefault(struct address_space *mapping, struct vm_area_struct *vma)
+/* page_table_lock hold on entry. */
+static int 
+hugetlb_alloc_fault(struct mm_struct *mm, struct vm_area_struct *vma, 
+			       unsigned long addr, int write_access)
 {
-	struct mm_struct *mm = current->mm;
-	unsigned long addr;
-	int ret = 0;
-
-	BUG_ON(vma->vm_start & ~HPAGE_MASK);
-	BUG_ON(vma->vm_end & ~HPAGE_MASK);
-
-	spin_lock(&mm->page_table_lock);
-	for (addr = vma->vm_start; addr < vma->vm_end; addr += HPAGE_SIZE) {
 		unsigned long idx;
-		pte_t *pte = huge_pte_alloc(mm, addr);
-		struct page *page;
+	int ret;
+	pte_t *pte;
+	struct page *page = NULL;
+	struct address_space *mapping = vma->vm_file->f_mapping;
 
+	pte = huge_pte_alloc(mm, addr); 
 		if (!pte) {
-			ret = -ENOMEM;
+		ret = VM_FAULT_OOM;
 			goto out;
 		}
-		if (!pte_none(*pte))
-			continue;
 
 		idx = ((addr - vma->vm_start) >> HPAGE_SHIFT)
 			+ (vma->vm_pgoff >> (HPAGE_SHIFT - PAGE_SHIFT));
 		page = find_get_page(mapping, idx);
 		if (!page) {
-			/* charge the fs quota first */
-			if (hugetlb_get_quota(mapping)) {
-				ret = -ENOMEM;
+		/* Should do this at prefault time, but that gets us into
+		   trouble with freeing right now. */
+		ret = hugetlb_get_quota(mapping);
+		if (ret) {
+			ret = VM_FAULT_OOM;
 				goto out;
 			}
-			page = alloc_hugetlb_page();
+
+		page = alloc_hugetlb_page(vma);
 			if (!page) {
 				hugetlb_put_quota(mapping);
-				ret = -ENOMEM;
+			
+			/* Instead of OOMing here could just transparently use
+			   small pages. */
+			
+			ret = VM_FAULT_OOM;
 				goto out;
 			}
 			ret = add_to_page_cache(page, mapping, idx, GFP_ATOMIC);
@@ -371,23 +377,62 @@ int hugetlb_prefault(struct address_spac
 			if (ret) {
 				hugetlb_put_quota(mapping);
 				free_huge_page(page);
+			ret = VM_FAULT_SIGBUS;
 				goto out;
 			}
-		}
+		ret = VM_FAULT_MAJOR; 
+	} else
+		ret = VM_FAULT_MINOR;
+		
 		set_huge_pte(mm, vma, page, pte, vma->vm_flags & VM_WRITE);
-	}
-out:
+	/* Don't need to flush other CPUs. They will just do a page
+	   fault and flush it lazily. */
+	__flush_tlb_one(addr);
+	
+ out:
 	spin_unlock(&mm->page_table_lock);
 	return ret;
 }
 
+int arch_hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma, 
+		       unsigned long address, int write_access)
+{ 
+	pmd_t *pmd;
+	pgd_t *pgd;
+
+	if (write_access && !(vma->vm_flags & VM_WRITE))
+		return VM_FAULT_SIGBUS;
+
+	spin_lock(&mm->page_table_lock);	
+	pgd = pgd_offset(mm, address); 
+	if (pgd_none(*pgd)) 
+		return hugetlb_alloc_fault(mm, vma, address, write_access); 
+
+	pmd = pmd_offset(pgd, address);
+	if (pmd_none(*pmd))
+		return hugetlb_alloc_fault(mm, vma, address, write_access); 
+
+	BUG_ON(!pmd_large(*pmd)); 
+
+	/* must have been a race. Flush the TLB. NX not supported yet. */ 
+
+	__flush_tlb_one(address); 
+	spin_lock(&mm->page_table_lock);	
+	return VM_FAULT_MINOR;
+} 
+
+int hugetlb_prefault(struct address_space *mapping, struct vm_area_struct *vma)
+{
+	return 0;
+}
+
 static void update_and_free_page(struct page *page)
 {
 	int j;
 	struct page *map;
 
 	map = page;
-	htlbzone_pages--;
+	htlbzone_pages--;
 	for (j = 0; j < (HPAGE_SIZE / PAGE_SIZE); j++) {
 		map->flags &= ~(1 << PG_locked | 1 << PG_error | 1 << PG_referenced |
 				1 << PG_dirty | 1 << PG_active | 1 << PG_reserved |
diff -burpN -X ../KDIFX linux-2.6.2/mm/memory.c linux-2.6.2-numa/mm/memory.c
--- linux-2.6.2/mm/memory.c	2004-02-20 18:31:32.000000000 +0100
+++ linux-2.6.2-numa/mm/memory.c	2004-02-18 20:08:40.000000000 +0100
@@ -1576,6 +1593,15 @@ static inline int handle_pte_fault(struc
 	return VM_FAULT_MINOR;
 }
 
+
+/* Can be overwritten by the architecture */
+int __attribute__((weak)) arch_hugetlb_fault(struct mm_struct *mm, 
+					     struct vm_area_struct *vma, 
+					     unsigned long address, int write_access)
+{
+	return VM_FAULT_SIGBUS;
+}
+
 /*
  * By the time we get here, we already hold the mm semaphore
  */
@@ -1591,7 +1617,7 @@ int handle_mm_fault(struct mm_struct *mm
 	inc_page_state(pgfault);
 
 	if (is_vm_hugetlb_page(vma))
-		return VM_FAULT_SIGBUS;	/* mapping truncation does this. */
+		return arch_hugetlb_fault(mm, vma, address, write_access);
 
 	/*
 	 * We need the page table lock to synchronize with kswapd
