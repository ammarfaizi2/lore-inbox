Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262515AbUKEIbU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262515AbUKEIbU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Nov 2004 03:31:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262571AbUKEIbU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Nov 2004 03:31:20 -0500
Received: from cantor.suse.de ([195.135.220.2]:13495 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262515AbUKEIbI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Nov 2004 03:31:08 -0500
Date: Fri, 5 Nov 2004 09:31:02 +0100
From: Andi Kleen <ak@suse.de>
To: Andrea Arcangeli <andrea@novell.com>
Cc: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>,
       linux-kernel@vger.kernel.org, Dave Hansen <haveblue@us.ibm.com>
Subject: Re: fix iounmap and a pageattr memleak (x86 and x86-64)
Message-ID: <20041105083102.GD16992@wotan.suse.de>
References: <20041028192104.GA3454@dualathlon.random> <20041105080716.GL8229@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041105080716.GL8229@dualathlon.random>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I was overoptimistic that these fixes (both this and Andi's ioremap
> symmetry fix combined) would be enough to fix the real life crash.
> Something is still not right, but I doubt there's any more bug in
> pageattr right now.  More likely ioremap stuff is still buggy (infact an

At least the NX handling is still broken on i386 (when reverting
back it doesn't clear the NX bit for kernel text) 

Also currently I can reproduce another problem on x86-64 with my
latest patch (appended for your reference). The change_page_attr_addr() 
addition is not needed in the stock kernel yet, only together with another
patch.

I still don't like how you remove the reversal handling completely.

> > -           if (pte_same(old,standard))
> > -               get_page(kpte_page);

-Andi

Index: linux/arch/x86_64/mm/ioremap.c
===================================================================
--- linux.orig/arch/x86_64/mm/ioremap.c	2004-10-25 04:47:15.%N +0200
+++ linux/arch/x86_64/mm/ioremap.c	2004-11-02 17:55:45.%N +0100
@@ -16,7 +16,7 @@
 #include <asm/fixmap.h>
 #include <asm/cacheflush.h>
 #include <asm/tlbflush.h>
-
+#include <asm/proto.h>
 
 static inline void remap_area_pte(pte_t * pte, unsigned long address, unsigned long size,
 	unsigned long phys_addr, unsigned long flags)
@@ -98,8 +98,32 @@
 	return error;
 }
 
+/* 
+ * Fix up the linear direct mapping of the kernel to avoid cache attribute 
+ * conflicts.
+ */  
+static int 
+ioremap_change_attr(unsigned long phys_addr, unsigned long size, 
+					unsigned long flags)
+{
+	int err = 0;
+	if (flags && phys_addr + size - 1 < (end_pfn_map << PAGE_SHIFT)) { 
+		unsigned long npages = (size + PAGE_SIZE - 1) >> PAGE_SHIFT;
+		unsigned long vaddr = (unsigned long) __va(phys_addr);
+		
+		/* 
+ 		 * Must use a address here and not struct page because the phys addr
+		 * can be a in hole between nodes and not have an memmap entry. 
+		 */
+		err = change_page_attr_addr(vaddr, npages, __pgprot(flags));
+		if (!err)
+			global_flush_tlb();
+	} 
+	return err;
+}
+
 /*
- * Generic mapping function (not visible outside):
+ * Generic mapping function
  */
 
 /*
@@ -155,12 +179,17 @@
 	/*
 	 * Ok, go for it..
 	 */
-	area = get_vm_area(size, VM_IOREMAP);
+	area = get_vm_area(size, VM_IOREMAP | (flags << 24));
 	if (!area)
 		return NULL;
 	area->phys_addr = phys_addr;
 	addr = area->addr;
 	if (remap_area_pages((unsigned long) addr, phys_addr, size, flags)) {
+		remove_vm_area((void *)(PAGE_MASK & (unsigned long) addr));
+		return NULL;
+	}
+	if (ioremap_change_attr(phys_addr, size, flags) < 0) { 
+		area->flags &= 0xffffff;
 		vunmap(addr);
 		return NULL;
 	}
@@ -191,43 +220,34 @@
 
 void __iomem *ioremap_nocache (unsigned long phys_addr, unsigned long size)
 {
-	void __iomem *p = __ioremap(phys_addr, size, _PAGE_PCD);
-	if (!p) 
-		return p; 
-
-	if (phys_addr + size < virt_to_phys(high_memory)) { 
-		struct page *ppage = virt_to_page(__va(phys_addr));		
-		unsigned long npages = (size + PAGE_SIZE - 1) >> PAGE_SHIFT;
-
-		BUG_ON(phys_addr+size > (unsigned long)high_memory);
-		BUG_ON(phys_addr + size < phys_addr);
-
-		if (change_page_attr(ppage, npages, PAGE_KERNEL_NOCACHE) < 0) { 
-			iounmap(p); 
-			p = NULL;
-		}
-		global_flush_tlb();
-	} 
-
-	return p;					
+	return __ioremap(phys_addr, size, _PAGE_PCD);
 }
 
 void iounmap(volatile void __iomem *addr)
 {
-	struct vm_struct *p;
+	struct vm_struct *p, **pprev;
+	
 	if (addr <= high_memory) 
 		return; 
-	p = remove_vm_area((void *)(PAGE_MASK & (unsigned long) addr)); 
+
+	write_lock(&vmlist_lock);
+	for (p = vmlist, pprev = &vmlist; p != NULL; pprev = &p->next, p = *pprev)
+		if (p->addr == (void *)(PAGE_MASK & (unsigned long)addr)) 
+			break; 
 	if (!p) { 
 		printk("__iounmap: bad address %p\n", addr);
-		return;
-	} 
-
-	if (p->flags && p->phys_addr < virt_to_phys(high_memory)) { 
+		goto out_unlock;
+	}	
+	*pprev = p->next;
+	unmap_vm_area(p);
+	if ((p->flags >> 24) && 
+		p->phys_addr + p->size - 1 < virt_to_phys(high_memory)) { 
 		change_page_attr(virt_to_page(__va(p->phys_addr)),
 				 p->size >> PAGE_SHIFT,
 				 PAGE_KERNEL); 				 
 		global_flush_tlb();
 	} 
+out_unlock:	
+	write_unlock(&vmlist_lock);
 	kfree(p); 
 }
Index: linux/include/asm-x86_64/cacheflush.h
===================================================================
--- linux.orig/include/asm-x86_64/cacheflush.h	2004-06-16 12:23:40.%N +0200
+++ linux/include/asm-x86_64/cacheflush.h	2004-11-02 17:55:45.%N +0100
@@ -25,5 +25,6 @@
 
 void global_flush_tlb(void); 
 int change_page_attr(struct page *page, int numpages, pgprot_t prot);
+int change_page_attr_addr(unsigned long addr, int numpages, pgprot_t prot);
 
 #endif /* _X8664_CACHEFLUSH_H */
Index: linux/arch/x86_64/mm/pageattr.c
===================================================================
--- linux.orig/arch/x86_64/mm/pageattr.c	2004-08-15 19:45:14.%N +0200
+++ linux/arch/x86_64/mm/pageattr.c	2004-11-02 17:55:45.%N +0100
@@ -111,13 +111,12 @@
 }      
 
 static int
-__change_page_attr(unsigned long address, struct page *page, pgprot_t prot, 
-		   pgprot_t ref_prot)
+__change_page_attr(unsigned long address, unsigned long pfn, pgprot_t prot, 
+				   pgprot_t ref_prot)
 { 
 	pte_t *kpte; 
 	struct page *kpte_page;
 	unsigned kpte_flags;
-
 	kpte = lookup_address(address);
 	if (!kpte) return 0;
 	kpte_page = virt_to_page(((unsigned long)kpte) & PAGE_MASK);
@@ -125,20 +124,20 @@
 	if (pgprot_val(prot) != pgprot_val(ref_prot)) { 
 		if ((kpte_flags & _PAGE_PSE) == 0) { 
 			pte_t old = *kpte;
-			pte_t standard = mk_pte(page, ref_prot); 
+			pte_t standard = pfn_pte(pfn, ref_prot); 
 
-			set_pte(kpte, mk_pte(page, prot)); 
+			set_pte(kpte, pfn_pte(pfn, prot)); 
 			if (pte_same(old,standard))
 				get_page(kpte_page);
 		} else {
 			struct page *split = split_large_page(address, prot, ref_prot); 
 			if (!split)
 				return -ENOMEM;
-			get_page(kpte_page);
+			get_page(split);
 			set_pte(kpte,mk_pte(split, ref_prot));
 		}	
 	} else if ((kpte_flags & _PAGE_PSE) == 0) { 
-		set_pte(kpte, mk_pte(page, ref_prot));
+		set_pte(kpte, pfn_pte(pfn, ref_prot));
 		__put_page(kpte_page);
 	}
 
@@ -162,31 +161,38 @@
  * 
  * Caller must call global_flush_tlb() after this.
  */
-int change_page_attr(struct page *page, int numpages, pgprot_t prot)
+int change_page_attr_addr(unsigned long address, int numpages, pgprot_t prot)
 {
 	int err = 0; 
 	int i; 
 
 	down_write(&init_mm.mmap_sem);
-	for (i = 0; i < numpages; !err && i++, page++) { 
-		unsigned long address = (unsigned long)page_address(page); 
-		err = __change_page_attr(address, page, prot, PAGE_KERNEL); 
+	for (i = 0; i < numpages; i++, address += PAGE_SIZE) { 
+		unsigned long pfn = __pa(address) >> PAGE_SHIFT;
+	
+		err = __change_page_attr(address, pfn, prot, PAGE_KERNEL); 
 		if (err) 
 			break; 
 		/* Handle kernel mapping too which aliases part of the
 		 * lowmem */
 		/* Disabled right now. Fixme */ 
-		if (0 && page_to_phys(page) < KERNEL_TEXT_SIZE) {		
+		if (0 && __pa(address) < KERNEL_TEXT_SIZE) {		
 			unsigned long addr2;
-			addr2 = __START_KERNEL_map + page_to_phys(page);
-			err = __change_page_attr(addr2, page, prot, 
-						 PAGE_KERNEL_EXEC);
+			addr2 = __START_KERNEL_map + __pa(address);
+			err = __change_page_attr(addr2, pfn, prot, PAGE_KERNEL_EXEC);
 		} 
 	} 	
 	up_write(&init_mm.mmap_sem); 
 	return err;
 }
 
+/* Don't call this for MMIO areas that may not have a mem_map entry */
+int change_page_attr(struct page *page, int numpages, pgprot_t prot)
+{
+	unsigned long addr = (unsigned long)page_address(page);
+	return change_page_attr_addr(addr, numpages, prot);
+}
+
 void global_flush_tlb(void)
 { 
 	struct deferred_page *df, *next_df;
