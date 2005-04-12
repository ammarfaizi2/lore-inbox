Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262147AbVDLUOy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262147AbVDLUOy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 16:14:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262146AbVDLUOr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 16:14:47 -0400
Received: from fire.osdl.org ([65.172.181.4]:27336 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262141AbVDLKbb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 06:31:31 -0400
Message-Id: <200504121031.j3CAVRG8005316@shell0.pdx.osdl.net>
Subject: [patch 048/198] ppc64: Fix semantics of __ioremap
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, benh@kernel.crashing.org
From: akpm@osdl.org
Date: Tue, 12 Apr 2005 03:31:20 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Benjamin Herrenschmidt <benh@kernel.crashing.org>

This patch fixes ppc64 __ioremap() so that it stops adding implicitely
_PAGE_GUARDED when the cache is not writeback, and instead, let the callers
provide the flag they want here.  This allows things like framebuffers to
explicitely request a non-cacheable and non-guarded mapping which is more
efficient for that type of memory without side effects.  The patch also
fixes all current callers to add _PAGE_GUARDED except btext, which is fine
without it.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/arch/ppc64/kernel/maple_setup.c   |    2 +-
 25-akpm/arch/ppc64/kernel/pSeries_setup.c |    2 +-
 25-akpm/arch/ppc64/kernel/pci.c           |   12 +++++++-----
 25-akpm/arch/ppc64/mm/init.c              |   18 +++++++++---------
 4 files changed, 18 insertions(+), 16 deletions(-)

diff -puN arch/ppc64/kernel/maple_setup.c~ppc64-fix-semantics-of-__ioremap arch/ppc64/kernel/maple_setup.c
--- 25/arch/ppc64/kernel/maple_setup.c~ppc64-fix-semantics-of-__ioremap	2005-04-12 03:21:15.021853232 -0700
+++ 25-akpm/arch/ppc64/kernel/maple_setup.c	2005-04-12 03:21:15.028852168 -0700
@@ -142,7 +142,7 @@ static void __init maple_init_early(void
 	if (physport) {
 		void *comport;
 		/* Map the uart for udbg. */
-		comport = (void *)__ioremap(physport, 16, _PAGE_NO_CACHE);
+		comport = (void *)ioremap(physport, 16);
 		udbg_init_uart(comport, default_speed);
 
 		ppc_md.udbg_putc = udbg_putc;
diff -puN arch/ppc64/kernel/pci.c~ppc64-fix-semantics-of-__ioremap arch/ppc64/kernel/pci.c
--- 25/arch/ppc64/kernel/pci.c~ppc64-fix-semantics-of-__ioremap	2005-04-12 03:21:15.022853080 -0700
+++ 25-akpm/arch/ppc64/kernel/pci.c	2005-04-12 03:21:15.029852016 -0700
@@ -547,8 +547,9 @@ static void __devinit pci_process_ISA_OF
 	if (range == NULL || (rlen < sizeof(struct isa_range))) {
 		printk(KERN_ERR "no ISA ranges or unexpected isa range size,"
 		       "mapping 64k\n");
-		__ioremap_explicit(phb_io_base_phys, (unsigned long)phb_io_base_virt, 
-				   0x10000, _PAGE_NO_CACHE);
+		__ioremap_explicit(phb_io_base_phys,
+				   (unsigned long)phb_io_base_virt,
+				   0x10000, _PAGE_NO_CACHE | _PAGE_GUARDED);
 		return;	
 	}
 	
@@ -576,7 +577,7 @@ static void __devinit pci_process_ISA_OF
 
 		__ioremap_explicit(phb_io_base_phys, 
 				   (unsigned long) phb_io_base_virt, 
-				   size, _PAGE_NO_CACHE);
+				   size, _PAGE_NO_CACHE | _PAGE_GUARDED);
 	}
 }
 
@@ -692,7 +693,7 @@ void __devinit pci_setup_phb_io_dynamic(
 	struct resource *res;
 
 	hose->io_base_virt = __ioremap(hose->io_base_phys, size,
-					_PAGE_NO_CACHE);
+					_PAGE_NO_CACHE | _PAGE_GUARDED);
 	DBG("phb%d io_base_phys 0x%lx io_base_virt 0x%lx\n",
 		hose->global_number, hose->io_base_phys,
 		(unsigned long) hose->io_base_virt);
@@ -780,7 +781,8 @@ int remap_bus_range(struct pci_bus *bus)
 	if (get_bus_io_range(bus, &start_phys, &start_virt, &size))
 		return 1;
 	printk("mapping IO %lx -> %lx, size: %lx\n", start_phys, start_virt, size);
-	if (__ioremap_explicit(start_phys, start_virt, size, _PAGE_NO_CACHE))
+	if (__ioremap_explicit(start_phys, start_virt, size,
+			       _PAGE_NO_CACHE | _PAGE_GUARDED))
 		return 1;
 
 	return 0;
diff -puN arch/ppc64/kernel/pSeries_setup.c~ppc64-fix-semantics-of-__ioremap arch/ppc64/kernel/pSeries_setup.c
--- 25/arch/ppc64/kernel/pSeries_setup.c~ppc64-fix-semantics-of-__ioremap	2005-04-12 03:21:15.024852776 -0700
+++ 25-akpm/arch/ppc64/kernel/pSeries_setup.c	2005-04-12 03:21:15.030851864 -0700
@@ -363,7 +363,7 @@ static void __init pSeries_init_early(vo
 		find_udbg_vterm();
 	else if (physport) {
 		/* Map the uart for udbg. */
-		comport = (void *)__ioremap(physport, 16, _PAGE_NO_CACHE);
+		comport = (void *)ioremap(physport, 16);
 		udbg_init_uart(comport, default_speed);
 
 		ppc_md.udbg_putc = udbg_putc;
diff -puN arch/ppc64/mm/init.c~ppc64-fix-semantics-of-__ioremap arch/ppc64/mm/init.c
--- 25/arch/ppc64/mm/init.c~ppc64-fix-semantics-of-__ioremap	2005-04-12 03:21:15.025852624 -0700
+++ 25-akpm/arch/ppc64/mm/init.c	2005-04-12 03:21:15.031851712 -0700
@@ -155,7 +155,8 @@ static void map_io_page(unsigned long ea
 		ptep = pte_alloc_kernel(&ioremap_mm, pmdp, ea);
 
 		pa = abs_to_phys(pa);
-		set_pte_at(&ioremap_mm, ea, ptep, pfn_pte(pa >> PAGE_SHIFT, __pgprot(flags)));
+		set_pte_at(&ioremap_mm, ea, ptep, pfn_pte(pa >> PAGE_SHIFT,
+							  __pgprot(flags)));
 		spin_unlock(&ioremap_mm.page_table_lock);
 	} else {
 		unsigned long va, vpn, hash, hpteg;
@@ -191,12 +192,9 @@ static void __iomem * __ioremap_com(unsi
 
 	if ((flags & _PAGE_PRESENT) == 0)
 		flags |= pgprot_val(PAGE_KERNEL);
-	if (flags & (_PAGE_NO_CACHE | _PAGE_WRITETHRU))
-		flags |= _PAGE_GUARDED;
 
-	for (i = 0; i < size; i += PAGE_SIZE) {
+	for (i = 0; i < size; i += PAGE_SIZE)
 		map_io_page(ea+i, pa+i, flags);
-	}
 
 	return (void __iomem *) (ea + (addr & ~PAGE_MASK));
 }
@@ -205,7 +203,7 @@ static void __iomem * __ioremap_com(unsi
 void __iomem *
 ioremap(unsigned long addr, unsigned long size)
 {
-	return __ioremap(addr, size, _PAGE_NO_CACHE);
+	return __ioremap(addr, size, _PAGE_NO_CACHE | _PAGE_GUARDED);
 }
 
 void __iomem *
@@ -272,7 +270,8 @@ int __ioremap_explicit(unsigned long pa,
 			return 1;
 		}
 		if (ea != (unsigned long) area->addr) {
-			printk(KERN_ERR "unexpected addr return from im_get_area\n");
+			printk(KERN_ERR "unexpected addr return from "
+			       "im_get_area\n");
 			return 1;
 		}
 	}
@@ -315,7 +314,8 @@ static void unmap_im_area_pte(pmd_t *pmd
 			continue;
 		if (pte_present(page))
 			continue;
-		printk(KERN_CRIT "Whee.. Swapped out page in kernel page table\n");
+		printk(KERN_CRIT "Whee.. Swapped out page in kernel page"
+		       " table\n");
 	} while (address < end);
 }
 
@@ -352,7 +352,7 @@ static void unmap_im_area_pmd(pgd_t *dir
  * Access to IO memory should be serialized by driver.
  * This code is modeled after vmalloc code - unmap_vm_area()
  *
- * XXX	what about calls before mem_init_done (ie python_countermeasures())	
+ * XXX	what about calls before mem_init_done (ie python_countermeasures())
  */
 void iounmap(volatile void __iomem *token)
 {
_
