Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287909AbSABTHk>; Wed, 2 Jan 2002 14:07:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287908AbSABTHa>; Wed, 2 Jan 2002 14:07:30 -0500
Received: from harpo.it.uu.se ([130.238.12.34]:32742 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S287905AbSABTHW>;
	Wed, 2 Jan 2002 14:07:22 -0500
Date: Wed, 2 Jan 2002 20:07:20 +0100 (MET)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200201021907.UAA18833@harpo.it.uu.se>
To: torvalds@transmeta.com
Subject: [PATCH] DMI/APIC updates 1 of 4: boot-time-fixmaps
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

This is part 1 of 4 of a patch set for 2.5.2-pre6 to move the
x86 DMI scan to an earlier point in the boot sequence. This is
motivated by the UP APIC code, which must be disabled on some
machines with broken BIOSen, but there are also other cases that
would benefit from it. Tested. Please apply.

This first patch (patch-boot-time-fixmaps) augments the FIXMAP
mechanism with a set of temporary boot-time maps. These maps are
recycled later, so the address space is not lost permanently.
arch/i386/mm/init.c:set_pte_phys() [used by __set_fixmap()] is
changed to permit reassigning temporary boot-time maps. PAGE_KERNEL
is no longer added automatically, but this is safe since all
callers include it anyway (see <asm-i386/fixmap.h>).

/Mikael

diff -ruN linux-2.5.2-pre6/arch/i386/mm/init.c linux-2.5.2-pre6.boot-time-fixmaps/arch/i386/mm/init.c
--- linux-2.5.2-pre6/arch/i386/mm/init.c	Tue Dec 18 00:40:11 2001
+++ linux-2.5.2-pre6.boot-time-fixmaps/arch/i386/mm/init.c	Wed Jan  2 00:54:04 2002
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
diff -ruN linux-2.5.2-pre6/include/asm-i386/fixmap.h linux-2.5.2-pre6.boot-time-fixmaps/include/asm-i386/fixmap.h
--- linux-2.5.2-pre6/include/asm-i386/fixmap.h	Thu Nov 22 20:46:19 2001
+++ linux-2.5.2-pre6.boot-time-fixmaps/include/asm-i386/fixmap.h	Wed Jan  2 00:54:04 2002
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
 
