Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262525AbULDDrT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262525AbULDDrT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Dec 2004 22:47:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262527AbULDDrT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Dec 2004 22:47:19 -0500
Received: from mail-relay-4.tiscali.it ([213.205.33.44]:27534 "EHLO
	mail-relay-4.tiscali.it") by vger.kernel.org with ESMTP
	id S262525AbULDDqv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Dec 2004 22:46:51 -0500
Date: Sat, 4 Dec 2004 04:46:41 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: more pageattr/ioremap fixes
Message-ID: <20041204034641.GY32635@dualathlon.random>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="eqp4TxRxnD4KrmFZ"
Content-Disposition: inline
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--eqp4TxRxnD4KrmFZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

There are more pageattr/ioremap bugs I've fixed recently. Such machine
didn't work even after the last round of fixes.

Now I found the last bug and machine works again, that is the p->size
returned by remove_vm_area is off by one, since it includes the guard
page, and this lead to every iounmap to execute change_page_attr on one
more page than ioremap_nocache. This is really a bug in mm/vmalloc.c, we
sure don't want to expose the size of the guard page to the caller.

While looking for the above, I found a missing tlb flush if more than
page was being released by change_page_attr before a global_flush_tlb
call (shouldn't normally happen). x86 didn't have the flushing bug,
while the change_page_attr bug above was for both x86 and x86-64.

I attached all the pending fixes in order against mainline.

(other archs aren't checking p->size returned by remove_vm_area, only
x86 and x86-64 were bitten by the bug)

--eqp4TxRxnD4KrmFZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=iounmap

Index: linux-2.5/arch/i386/mm/ioremap.c
===================================================================
RCS file: /home/andrea/crypto/cvs/linux-2.5/arch/i386/mm/ioremap.c,v
retrieving revision 1.23
diff -u -p -r1.23 ioremap.c
--- linux-2.5/arch/i386/mm/ioremap.c	11 Sep 2004 02:01:36 -0000	1.23
+++ linux-2.5/arch/i386/mm/ioremap.c	28 Oct 2004 19:11:20 -0000
@@ -152,7 +152,7 @@ void __iomem * __ioremap(unsigned long p
 	/*
 	 * Ok, go for it..
 	 */
-	area = get_vm_area(size, VM_IOREMAP);
+	area = get_vm_area(size, VM_IOREMAP | (flags << 24));
 	if (!area)
 		return NULL;
 	area->phys_addr = phys_addr;
@@ -232,7 +232,7 @@ void iounmap(volatile void __iomem *addr
 		return;
 	} 
 
-	if (p->flags && p->phys_addr < virt_to_phys(high_memory)) { 
+	if ((p->flags >> 24) && p->phys_addr < virt_to_phys(high_memory)) { 
 		change_page_attr(virt_to_page(__va(p->phys_addr)),
 				 p->size >> PAGE_SHIFT,
 				 PAGE_KERNEL); 				 
Index: linux-2.5/arch/x86_64/mm/ioremap.c
===================================================================
RCS file: /home/andrea/crypto/cvs/linux-2.5/arch/x86_64/mm/ioremap.c,v
retrieving revision 1.16
diff -u -p -r1.16 ioremap.c
--- linux-2.5/arch/x86_64/mm/ioremap.c	22 Oct 2004 15:01:03 -0000	1.16
+++ linux-2.5/arch/x86_64/mm/ioremap.c	28 Oct 2004 19:11:20 -0000
@@ -128,11 +128,11 @@ void __iomem * __ioremap(unsigned long p
 	if (phys_addr >= 0xA0000 && last_addr < 0x100000)
 		return (__force void __iomem *)phys_to_virt(phys_addr);
 
+#ifndef CONFIG_DISCONTIGMEM
 	/*
 	 * Don't allow anybody to remap normal RAM that we're using..
 	 */
 	if (phys_addr < virt_to_phys(high_memory)) {
-#ifndef CONFIG_DISCONTIGMEM
 		char *t_addr, *t_end;
  		struct page *page;
 
@@ -142,8 +142,8 @@ void __iomem * __ioremap(unsigned long p
 		for(page = virt_to_page(t_addr); page <= virt_to_page(t_end); page++)
 			if(!PageReserved(page))
 				return NULL;
-#endif
 	}
+#endif
 
 	/*
 	 * Mappings have to be page-aligned
@@ -155,7 +155,7 @@ void __iomem * __ioremap(unsigned long p
 	/*
 	 * Ok, go for it..
 	 */
-	area = get_vm_area(size, VM_IOREMAP);
+	area = get_vm_area(size, VM_IOREMAP | (flags << 24));
 	if (!area)
 		return NULL;
 	area->phys_addr = phys_addr;
@@ -195,12 +195,12 @@ void __iomem *ioremap_nocache (unsigned 
 	if (!p) 
 		return p; 
 
-	if (phys_addr + size < virt_to_phys(high_memory)) { 
+	if (phys_addr + size - 1 < virt_to_phys(high_memory)) { 
 		struct page *ppage = virt_to_page(__va(phys_addr));		
 		unsigned long npages = (size + PAGE_SIZE - 1) >> PAGE_SHIFT;
 
-		BUG_ON(phys_addr+size > (unsigned long)high_memory);
-		BUG_ON(phys_addr + size < phys_addr);
+		BUG_ON(phys_addr+size >= (unsigned long)high_memory);
+		BUG_ON(phys_addr + size <= phys_addr);
 
 		if (change_page_attr(ppage, npages, PAGE_KERNEL_NOCACHE) < 0) { 
 			iounmap(p); 
@@ -223,7 +223,7 @@ void iounmap(volatile void __iomem *addr
 		return;
 	} 
 
-	if (p->flags && p->phys_addr < virt_to_phys(high_memory)) { 
+	if ((p->flags >> 24) && p->phys_addr + p->size < virt_to_phys(high_memory)) { 
 		change_page_attr(virt_to_page(__va(p->phys_addr)),
 				 p->size >> PAGE_SHIFT,
 				 PAGE_KERNEL); 				 

--eqp4TxRxnD4KrmFZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=pageattr

Index: linux-2.5/arch/i386/mm/pageattr.c
===================================================================
RCS file: /home/andrea/crypto/cvs/linux-2.5/arch/i386/mm/pageattr.c,v
retrieving revision 1.13
diff -u -p -r1.13 pageattr.c
--- linux-2.5/arch/i386/mm/pageattr.c	27 Aug 2004 17:35:39 -0000	1.13
+++ linux-2.5/arch/i386/mm/pageattr.c	5 Nov 2004 07:54:25 -0000
@@ -117,27 +117,35 @@ __change_page_attr(struct page *page, pg
 	kpte_page = virt_to_page(kpte);
 	if (pgprot_val(prot) != pgprot_val(PAGE_KERNEL)) { 
 		if ((pte_val(*kpte) & _PAGE_PSE) == 0) { 
-			pte_t old = *kpte;
-			pte_t standard = mk_pte(page, PAGE_KERNEL); 
 			set_pte_atomic(kpte, mk_pte(page, prot)); 
-			if (pte_same(old,standard))
-				get_page(kpte_page);
 		} else {
 			struct page *split = split_large_page(address, prot); 
 			if (!split)
 				return -ENOMEM;
-			get_page(kpte_page);
 			set_pmd_pte(kpte,address,mk_pte(split, PAGE_KERNEL));
+			kpte_page = split;
 		}	
+		get_page(kpte_page);
 	} else if ((pte_val(*kpte) & _PAGE_PSE) == 0) { 
 		set_pte_atomic(kpte, mk_pte(page, PAGE_KERNEL));
 		__put_page(kpte_page);
-	}
+	} else
+		BUG();
 
-	if (cpu_has_pse && (page_count(kpte_page) == 1)) {
-		list_add(&kpte_page->lru, &df_list);
-		revert_page(kpte_page, address);
-	} 
+	/*
+	 * If the pte was reserved, it means it was created at boot
+	 * time (not via split_large_page) and in turn we must not
+	 * replace it with a largepage.
+	 */
+	if (!PageReserved(kpte_page)) {
+		/* memleak and potential failed 2M page regeneration */
+		BUG_ON(!page_count(kpte_page));
+
+		if (cpu_has_pse && (page_count(kpte_page) == 1)) {
+			list_add(&kpte_page->lru, &df_list);
+			revert_page(kpte_page, address);
+		}
+	}
 	return 0;
 } 
 
Index: linux-2.5/arch/x86_64/mm/pageattr.c
===================================================================
RCS file: /home/andrea/crypto/cvs/linux-2.5/arch/x86_64/mm/pageattr.c,v
retrieving revision 1.12
diff -u -p -r1.12 pageattr.c
--- linux-2.5/arch/x86_64/mm/pageattr.c	27 Jun 2004 17:54:00 -0000	1.12
+++ linux-2.5/arch/x86_64/mm/pageattr.c	5 Nov 2004 07:54:25 -0000
@@ -124,28 +124,36 @@ __change_page_attr(unsigned long address
 	kpte_flags = pte_val(*kpte); 
 	if (pgprot_val(prot) != pgprot_val(ref_prot)) { 
 		if ((kpte_flags & _PAGE_PSE) == 0) { 
-			pte_t old = *kpte;
-			pte_t standard = mk_pte(page, ref_prot); 
-
 			set_pte(kpte, mk_pte(page, prot)); 
-			if (pte_same(old,standard))
-				get_page(kpte_page);
 		} else {
+			/*
+			 * split_large_page will take the reference for this change_page_attr
+			 * on the split page.
+			 */
 			struct page *split = split_large_page(address, prot, ref_prot); 
 			if (!split)
 				return -ENOMEM;
-			get_page(kpte_page);
 			set_pte(kpte,mk_pte(split, ref_prot));
+			kpte_page = split;
 		}	
+		get_page(kpte_page);
 	} else if ((kpte_flags & _PAGE_PSE) == 0) { 
 		set_pte(kpte, mk_pte(page, ref_prot));
 		__put_page(kpte_page);
-	}
+	} else
+		BUG();
+
+	/* on x86-64 the direct mapping set at boot is not using 4k pages */
+	BUG_ON(PageReserved(kpte_page));
 
-	if (page_count(kpte_page) == 1) {
+	switch (page_count(kpte_page)) {
+	case 1:
 		save_page(address, kpte_page); 		     
 		revert_page(address, ref_prot);
-	} 
+		break;
+	case 0:
+		BUG(); /* memleak and failed 2M page regeneration */
+	}
 	return 0;
 } 
 

--eqp4TxRxnD4KrmFZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="pageattr-flush-tlb.ho7ISG"

From: Andrea Arcangeli <andrea@suse.de>
Subject: if more than one page was in the list
 the kernel was not flushing the tlb at all
Patch-mainline: no
References: 46920

Signed-off-by: Andrea Arcangeli <andrea@suse.de>

--- sl9.2/arch/x86_64/mm/pageattr.c.~1~	2004-12-04 01:44:28.356655368 +0100
+++ sl9.2/arch/x86_64/mm/pageattr.c	2004-12-04 02:23:35.622816672 +0100
@@ -61,7 +61,10 @@ static void flush_kernel_map(void *addre
 			asm volatile("clflush (%0)" :: "r" (address + i)); 
 	} else
 		asm volatile("wbinvd":::"memory"); 
-	__flush_tlb_one(address);
+	if (address)
+		__flush_tlb_one(address);
+	else
+		__flush_tlb_all();
 }
 
 
@@ -202,13 +205,18 @@ void global_flush_tlb(void)
 	down_read(&init_mm.mmap_sem);
 	df = xchg(&df_list, NULL);
 	up_read(&init_mm.mmap_sem);
-	flush_map((df && !df->next) ? df->address : 0);
-	for (; df; df = next_df) { 
-		next_df = df->next;
-		if (df->fpage) 
-			__free_page(df->fpage);
-		kfree(df);
-	} 
+	if (df) {
+		if (!df->next)
+			flush_map(df->address);
+		else
+			flush_map(0); /* flush everything */
+		for (; df; df = next_df) { 
+			next_df = df->next;
+			if (df->fpage) 
+				__free_page(df->fpage);
+			kfree(df);
+		}
+	}
 } 
 
 EXPORT_SYMBOL(change_page_attr);

--eqp4TxRxnD4KrmFZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="pageattr-guard-page.11o59z"

From: Andrea Arcangeli <andrea@suse.de>
Subject: reject zero page vm-area request, align size properly
 and hide the guard page from the callers like ioremap - this avoids
 a kernel crash due one more page being passed to change_page_attr
Patch-mainline: no
References: 46920

Signed-off-by: Andrea Arcangeli <andrea@suse.de>

--- sl9.2/arch/i386/mm/ioremap.c.~1~	2004-12-04 01:44:28.354655672 +0100
+++ sl9.2/arch/i386/mm/ioremap.c	2004-12-04 03:34:30.171027032 +0100
@@ -195,9 +195,9 @@ void __iomem *ioremap_nocache (unsigned 
 		return p; 
 
 	/* Guaranteed to be > phys_addr, as per __ioremap() */
-	last_addr = phys_addr + size - 1;
+	last_addr = phys_addr + size;
 
-	if (last_addr < virt_to_phys(high_memory)) { 
+	if (last_addr <= virt_to_phys(high_memory)) { 
 		struct page *ppage = virt_to_page(__va(phys_addr));		
 		unsigned long npages;
 
@@ -232,7 +232,7 @@ void iounmap(volatile void __iomem *addr
 		return;
 	} 
 
-	if ((p->flags >> 24) && p->phys_addr < virt_to_phys(high_memory)) { 
+	if ((p->flags >> 24) && p->phys_addr + p->size <= virt_to_phys(high_memory)) { 
 		change_page_attr(virt_to_page(__va(p->phys_addr)),
 				 p->size >> PAGE_SHIFT,
 				 PAGE_KERNEL); 				 
--- sl9.2/arch/x86_64/mm/ioremap.c.~1~	2004-12-04 01:44:28.356655368 +0100
+++ sl9.2/arch/x86_64/mm/ioremap.c	2004-12-04 03:34:52.032703552 +0100
@@ -195,7 +195,7 @@ void *ioremap_nocache (unsigned long phy
 	if (!p) 
 		return p; 
 
-	if (phys_addr + size - 1 < virt_to_phys(high_memory)) { 
+	if (phys_addr + size <= virt_to_phys(high_memory)) { 
 		struct page *ppage = virt_to_page(__va(phys_addr));		
 		unsigned long npages = (size + PAGE_SIZE - 1) >> PAGE_SHIFT;
 
@@ -223,7 +223,7 @@ void iounmap(void *addr)
 		return;
 	} 
 
-	if ((p->flags >> 24) && p->phys_addr + p->size < virt_to_phys(high_memory)) { 
+	if ((p->flags >> 24) && p->phys_addr + p->size <= virt_to_phys(high_memory)) { 
 		change_page_attr(virt_to_page(__va(p->phys_addr)),
 				 p->size >> PAGE_SHIFT,
 				 PAGE_KERNEL); 				 
--- sl9.2/mm/vmalloc.c.~1~	2004-12-04 01:44:23.352416128 +0100
+++ sl9.2/mm/vmalloc.c	2004-12-04 03:02:37.299827656 +0100
@@ -199,20 +199,22 @@ struct vm_struct *__get_vm_area(unsigned
 		align = 1ul << bit;
 	}
 	addr = ALIGN(start, align);
+	size = PAGE_ALIGN(size);
 
 	area = kmalloc(sizeof(*area), GFP_KERNEL);
 	if (unlikely(!area))
 		return NULL;
 
-	/*
-	 * We always allocate a guard page.
-	 */
-	size += PAGE_SIZE;
 	if (unlikely(!size)) {
 		kfree (area);
 		return NULL;
 	}
 
+	/*
+	 * We always allocate a guard page.
+	 */
+	size += PAGE_SIZE;
+
 	write_lock(&vmlist_lock);
 	for (p = &vmlist; (tmp = *p) != NULL ;p = &tmp->next) {
 		if ((unsigned long)tmp->addr < addr) {
@@ -290,6 +292,11 @@ found:
 	unmap_vm_area(tmp);
 	*p = tmp->next;
 	write_unlock(&vmlist_lock);
+
+	/*
+	 * Remove the guard page.
+	 */
+	tmp->size -= PAGE_SIZE;
 	return tmp;
 }
 

--eqp4TxRxnD4KrmFZ--
