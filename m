Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261759AbUJ1TYR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261759AbUJ1TYR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 15:24:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261764AbUJ1TYQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 15:24:16 -0400
Received: from mail-relay-4.tiscali.it ([213.205.33.44]:40148 "EHLO
	mail-relay-4.tiscali.it") by vger.kernel.org with ESMTP
	id S261866AbUJ1TVU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 15:21:20 -0400
Date: Thu, 28 Oct 2004 21:21:04 +0200
From: Andrea Arcangeli <andrea@novell.com>
To: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: fix iounmap and a pageattr memleak (x86 and x86-64)
Message-ID: <20041028192104.GA3454@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This first patch fixes silent memleak in the pageattr code that I found
while searching for the bug Andi fixed in the second patch below
(basically reference counting in split page was done on the pmd instead
of the pte).

Signed-off-by: Andrea Arcangeli <andrea@novell.com>

Index: linux-2.5/arch/i386/mm/pageattr.c
===================================================================
RCS file: /home/andrea/crypto/cvs/linux-2.5/arch/i386/mm/pageattr.c,v
retrieving revision 1.13
diff -u -p -r1.13 pageattr.c
--- linux-2.5/arch/i386/mm/pageattr.c	27 Aug 2004 17:35:39 -0000	1.13
+++ linux-2.5/arch/i386/mm/pageattr.c	28 Oct 2004 19:11:20 -0000
@@ -117,22 +117,23 @@ __change_page_attr(struct page *page, pg
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
+
+	/* memleak and potential failed 2M page regeneration */
+	BUG_ON(!page_count(kpte_page));
 
 	if (cpu_has_pse && (page_count(kpte_page) == 1)) {
 		list_add(&kpte_page->lru, &df_list);
Index: linux-2.5/arch/x86_64/mm/pageattr.c
===================================================================
RCS file: /home/andrea/crypto/cvs/linux-2.5/arch/x86_64/mm/pageattr.c,v
retrieving revision 1.12
diff -u -p -r1.12 pageattr.c
--- linux-2.5/arch/x86_64/mm/pageattr.c	27 Jun 2004 17:54:00 -0000	1.12
+++ linux-2.5/arch/x86_64/mm/pageattr.c	28 Oct 2004 19:11:20 -0000
@@ -124,28 +124,33 @@ __change_page_attr(unsigned long address
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
 


This below patch from Andi is also needed to make the above work on x86
(otherwise one of my new above BUGS() will trigger signalling the fact
a bug was there). The below patch creates a subtle dependency that
(_PAGE_PCD << 24) must not be zero. It's not the cleanest thing ever,
but since it's an hardware bitflag I doubt it's going to break.

I'm not sure if I'm allowed to add the signedoff for Andi but I think I
should since he wrote the x86-64 version, if not please let me know (I
only backported it to x86 to test my above changes that otherwise would
trigger one of my added BUGs, and I did the other worthless cosmetical
fixes).

Signed-off-by: Andi Kleen <ak@suse.de>
Signed-off-by: Andrea Arcangeli <andrea@novell.com>

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


If you give them some beating on -mm let me know if you've any problem.
(running with this stuff on my machines right now, so far so good)
