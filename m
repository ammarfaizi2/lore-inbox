Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288565AbSAQL4C>; Thu, 17 Jan 2002 06:56:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288575AbSAQLzx>; Thu, 17 Jan 2002 06:55:53 -0500
Received: from harpo.it.uu.se ([130.238.12.34]:58032 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S288565AbSAQLzp>;
	Thu, 17 Jan 2002 06:55:45 -0500
Date: Thu, 17 Jan 2002 12:55:41 +0100 (MET)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200201171155.MAA13604@harpo.it.uu.se>
To: jamesclv@us.ibm.com, torvalds@transmeta.com
Subject: Re: [PATCH] i386/kernel/acpitable.c mapping problems
Cc: linux-kernel@vger.kernel.org, marcelo@conectiva.com.br
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Jan 2002 18:34:20 -0800, James Cleverdon wrote:
>This fixes two bugs in the 2.4.17 acpitable.c.  Marcello and Linus please 
>apply:
>...
>2) The authors didn't realize that fixmap pages count down from the fixed 
>base, so they ran off the end of virtual memory for any table over 2 pages 
>long.

[patch with FIX_IO_APIC_BASE (ab)use deleted]

This could probably be done more cleanly using my boot-time-ioremap
patch. I've posted it previously as part of a larger patch set (subject
"[PATCH] DMI/APIC updates"), but Linus didn't take it: it extends the
fixmap mechanism with a number of temporary boot-time maps and then
implements early boot-time versions of ioremap and iounmap using them.

It's pretty well tested by now. I'm including the 2.5.2 version
below for Linus' benefit; the 2.4.18-pre4 version can be fetched from
http://www.csd.uu.se/~mikpe/linux/kernel-patches/2.4/

Linus: If you have a suggestion for a better approach I'm all ears.
If not, consider this a request for including this patch in 2.5.3.

/Mikael

diff -ruN linux-2.5.2/arch/i386/mm/init.c linux-2.5.2.boot-time-ioremap/arch/i386/mm/init.c
--- linux-2.5.2/arch/i386/mm/init.c	Tue Dec 18 00:40:11 2001
+++ linux-2.5.2.boot-time-ioremap/arch/i386/mm/init.c	Thu Jan 17 09:29:54 2002
@@ -128,7 +128,6 @@
 static inline void set_pte_phys (unsigned long vaddr,
 			unsigned long phys, pgprot_t flags)
 {
-	pgprot_t prot;
 	pgd_t *pgd;
 	pmd_t *pmd;
 	pte_t *pte;
@@ -144,10 +143,8 @@
 		return;
 	}
 	pte = pte_offset(pmd, vaddr);
-	if (pte_val(*pte))
-		pte_ERROR(*pte);
-	pgprot_val(prot) = pgprot_val(PAGE_KERNEL) | pgprot_val(flags);
-	set_pte(pte, mk_pte_phys(phys, prot));
+	/* <phys,flags> stored as-is, to permit clearing entries */
+	set_pte(pte, mk_pte_phys(phys, flags));
 
 	/*
 	 * It's enough to flush this one mapping.
diff -ruN linux-2.5.2/arch/i386/mm/ioremap.c linux-2.5.2.boot-time-ioremap/arch/i386/mm/ioremap.c
--- linux-2.5.2/arch/i386/mm/ioremap.c	Tue Mar 20 17:13:33 2001
+++ linux-2.5.2.boot-time-ioremap/arch/i386/mm/ioremap.c	Thu Jan 17 09:29:58 2002
@@ -161,3 +161,68 @@
 	if (addr > high_memory)
 		return vfree((void *) (PAGE_MASK & (unsigned long) addr));
 }
+
+void __init *bt_ioremap(unsigned long phys_addr, unsigned long size)
+{
+	unsigned long offset, last_addr;
+	unsigned int nrpages;
+	enum fixed_addresses idx;
+
+	/* Don't allow wraparound or zero size */
+	last_addr = phys_addr + size - 1;
+	if (!size || last_addr < phys_addr)
+		return NULL;
+
+	/*
+	 * Don't remap the low PCI/ISA area, it's always mapped..
+	 */
+	if (phys_addr >= 0xA0000 && last_addr < 0x100000)
+		return phys_to_virt(phys_addr);
+
+	/*
+	 * Mappings have to be page-aligned
+	 */
+	offset = phys_addr & ~PAGE_MASK;
+	phys_addr &= PAGE_MASK;
+	size = PAGE_ALIGN(last_addr) - phys_addr;
+
+	/*
+	 * Mappings have to fit in the FIX_BTMAP area.
+	 */
+	nrpages = size >> PAGE_SHIFT;
+	if (nrpages > NR_FIX_BTMAPS)
+		return NULL;
+
+	/*
+	 * Ok, go for it..
+	 */
+	idx = FIX_BTMAP_BEGIN;
+	while (nrpages > 0) {
+		set_fixmap(idx, phys_addr);
+		phys_addr += PAGE_SIZE;
+		--idx;
+		--nrpages;
+	}
+	return (void*) (offset + fix_to_virt(FIX_BTMAP_BEGIN));
+}
+
+void __init bt_iounmap(void *addr, unsigned long size)
+{
+	unsigned long virt_addr;
+	unsigned long offset;
+	unsigned int nrpages;
+	enum fixed_addresses idx;
+
+	virt_addr = (unsigned long)addr;
+	if (virt_addr < fix_to_virt(FIX_BTMAP_BEGIN))
+		return;
+	offset = virt_addr & ~PAGE_MASK;
+	nrpages = PAGE_ALIGN(offset + size - 1) >> PAGE_SHIFT;
+
+	idx = FIX_BTMAP_BEGIN;
+	while (nrpages > 0) {
+		__set_fixmap(idx, 0, __pgprot(0));
+		--idx;
+		--nrpages;
+	}
+}
diff -ruN linux-2.5.2/include/asm-i386/fixmap.h linux-2.5.2.boot-time-ioremap/include/asm-i386/fixmap.h
--- linux-2.5.2/include/asm-i386/fixmap.h	Thu Nov 22 20:46:19 2001
+++ linux-2.5.2.boot-time-ioremap/include/asm-i386/fixmap.h	Thu Jan 17 09:29:54 2002
@@ -65,6 +65,11 @@
 	FIX_KMAP_BEGIN,	/* reserved pte's for temporary kernel mappings */
 	FIX_KMAP_END = FIX_KMAP_BEGIN+(KM_TYPE_NR*NR_CPUS)-1,
 #endif
+	__end_of_permanent_fixed_addresses,
+	/* temporary boot-time mappings, used before ioremap() is functional */
+#define NR_FIX_BTMAPS	16
+	FIX_BTMAP_END = __end_of_permanent_fixed_addresses,
+	FIX_BTMAP_BEGIN = FIX_BTMAP_END + NR_FIX_BTMAPS - 1,
 	__end_of_fixed_addresses
 };
 
@@ -86,8 +91,8 @@
  * at the top of mem..
  */
 #define FIXADDR_TOP	(0xffffe000UL)
-#define FIXADDR_SIZE	(__end_of_fixed_addresses << PAGE_SHIFT)
-#define FIXADDR_START	(FIXADDR_TOP - FIXADDR_SIZE)
+#define __FIXADDR_SIZE	(__end_of_permanent_fixed_addresses << PAGE_SHIFT)
+#define FIXADDR_START	(FIXADDR_TOP - __FIXADDR_SIZE)
 
 #define __fix_to_virt(x)	(FIXADDR_TOP - ((x) << PAGE_SHIFT))
 
diff -ruN linux-2.5.2/include/asm-i386/io.h linux-2.5.2.boot-time-ioremap/include/asm-i386/io.h
--- linux-2.5.2/include/asm-i386/io.h	Tue Dec 18 00:40:12 2001
+++ linux-2.5.2.boot-time-ioremap/include/asm-i386/io.h	Thu Jan 17 09:29:58 2002
@@ -95,6 +95,14 @@
 extern void iounmap(void *addr);
 
 /*
+ * bt_ioremap() and bt_iounmap() are for temporary early boot-time
+ * mappings, before the real ioremap() is functional.
+ * A boot-time mapping is currently limited to at most 16 pages.
+ */
+extern void *bt_ioremap(unsigned long offset, unsigned long size);
+extern void bt_iounmap(void *addr, unsigned long size);
+
+/*
  * IO bus memory addresses are also 1:1 with the physical address
  */
 #define virt_to_bus virt_to_phys
