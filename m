Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276497AbRI2NkJ>; Sat, 29 Sep 2001 09:40:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276498AbRI2Nju>; Sat, 29 Sep 2001 09:39:50 -0400
Received: from femail24.sdc1.sfba.home.com ([24.0.95.149]:8403 "EHLO
	femail24.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S276497AbRI2Njk>; Sat, 29 Sep 2001 09:39:40 -0400
Message-ID: <3BB5CE13.4CEBD246@didntduck.org>
Date: Sat, 29 Sep 2001 09:35:15 -0400
From: Brian Gerst <bgerst@didntduck.org>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.9-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: torvalds@transmeta.com
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Cleanup f00f bug code
In-Reply-To: <200109272313.BAA16620@harpo.it.uu.se>
Content-Type: multipart/mixed;
 boundary="------------1618D00D52F18C42719AF755"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------1618D00D52F18C42719AF755
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Mikael Pettersson wrote:
> 
> On Wed, 26 Sep 2001 21:52:09 -0400, Brian Gerst wrote:
> 
> >This patch changes the f00f bug workaround code to use a fixed mapping
> >instead of touching the page tables directly.  It also removes the
> >assumption that only 686's don't have the bug.  It has been tested for
> >normal operation of the relocated IDT, but I don't have a processor with
> >the bug to do a real test.  Could someone with such a processor please
> >verify that the workaround still works?
> 
> It doesn't. 2.4.9-ac16 + your patch booted ok on my P5MMX, and the
> kernel printed that it applied the F0 0F workaround, but executing
> F0 0F C7 C8 in user-space caused an instant lockup.
> 
> /Mikael

Here is an updated patch that Mikael has verified as working.  There was
a bug in set_pte_phys() which forced the read/write bit set in the page
table entry.

-- 

						Brian Gerst
--------------1618D00D52F18C42719AF755
Content-Type: text/plain; charset=us-ascii;
 name="diff-f00f-3"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff-f00f-3"

diff -urN linux-2.4.10/arch/i386/config.in linux/arch/i386/config.in
--- linux-2.4.10/arch/i386/config.in	Mon Sep 24 09:24:08 2001
+++ linux/arch/i386/config.in	Thu Sep 27 20:15:31 2001
@@ -52,6 +52,7 @@
    define_int  CONFIG_X86_L1_CACHE_SHIFT 4
    define_bool CONFIG_RWSEM_GENERIC_SPINLOCK y
    define_bool CONFIG_RWSEM_XCHGADD_ALGORITHM n
+   define_bool CONFIG_X86_F00F_BUG y
 else
    define_bool CONFIG_X86_WP_WORKS_OK y
    define_bool CONFIG_X86_INVLPG y
@@ -66,17 +67,20 @@
    define_int  CONFIG_X86_L1_CACHE_SHIFT 4
    define_bool CONFIG_X86_USE_STRING_486 y
    define_bool CONFIG_X86_ALIGNMENT_16 y
+   define_bool CONFIG_X86_F00F_BUG y
 fi
 if [ "$CONFIG_M586" = "y" ]; then
    define_int  CONFIG_X86_L1_CACHE_SHIFT 5
    define_bool CONFIG_X86_USE_STRING_486 y
    define_bool CONFIG_X86_ALIGNMENT_16 y
+   define_bool CONFIG_X86_F00F_BUG y
 fi
 if [ "$CONFIG_M586TSC" = "y" ]; then
    define_int  CONFIG_X86_L1_CACHE_SHIFT 5
    define_bool CONFIG_X86_USE_STRING_486 y
    define_bool CONFIG_X86_ALIGNMENT_16 y
    define_bool CONFIG_X86_TSC y
+   define_bool CONFIG_X86_F00F_BUG y
 fi
 if [ "$CONFIG_M586MMX" = "y" ]; then
    define_int  CONFIG_X86_L1_CACHE_SHIFT 5
@@ -84,6 +88,7 @@
    define_bool CONFIG_X86_ALIGNMENT_16 y
    define_bool CONFIG_X86_TSC y
    define_bool CONFIG_X86_GOOD_APIC y
+   define_bool CONFIG_X86_F00F_BUG y
 fi
 if [ "$CONFIG_M686" = "y" ]; then
    define_int  CONFIG_X86_L1_CACHE_SHIFT 5
diff -urN linux-2.4.10/arch/i386/kernel/setup.c linux/arch/i386/kernel/setup.c
--- linux-2.4.10/arch/i386/kernel/setup.c	Mon Sep 24 09:24:08 2001
+++ linux/arch/i386/kernel/setup.c	Fri Sep 28 19:11:51 2001
@@ -1712,13 +1712,10 @@
 
 static void __init init_intel(struct cpuinfo_x86 *c)
 {
-#ifndef CONFIG_M686
-	static int f00f_workaround_enabled = 0;
-#endif
 	char *p = NULL;
 	unsigned int l1i = 0, l1d = 0, l2 = 0, l3 = 0; /* Cache sizes */
 
-#ifndef CONFIG_M686
+#ifdef CONFIG_X86_F00F_BUG
 	/*
 	 * All current models of Pentium and Pentium with MMX technology CPUs
 	 * have the F0 0F bug, which lets nonpriviledged users lock up the system.
@@ -1726,6 +1723,8 @@
 	 */
 	c->f00f_bug = 0;
 	if ( c->x86 == 5 ) {
+		static int f00f_workaround_enabled = 0;
+
 		c->f00f_bug = 1;
 		if ( !f00f_workaround_enabled ) {
 			trap_init_f00f_bug();
diff -urN linux-2.4.10/arch/i386/kernel/traps.c linux/arch/i386/kernel/traps.c
--- linux-2.4.10/arch/i386/kernel/traps.c	Mon Sep 24 09:24:08 2001
+++ linux/arch/i386/kernel/traps.c	Fri Sep 28 19:11:46 2001
@@ -719,35 +719,17 @@
 
 #endif /* CONFIG_MATH_EMULATION */
 
-#ifndef CONFIG_M686
+#ifdef CONFIG_X86_F00F_BUG
 void __init trap_init_f00f_bug(void)
 {
-	unsigned long page;
-	pgd_t * pgd;
-	pmd_t * pmd;
-	pte_t * pte;
-
-	/*
-	 * Allocate a new page in virtual address space, 
-	 * move the IDT into it and write protect this page.
-	 */
-	page = (unsigned long) vmalloc(PAGE_SIZE);
-	pgd = pgd_offset(&init_mm, page);
-	pmd = pmd_offset(pgd, page);
-	pte = pte_offset(pmd, page);
-	__free_page(pte_page(*pte));
-	*pte = mk_pte_phys(__pa(&idt_table), PAGE_KERNEL_RO);
-	/*
-	 * Not that any PGE-capable kernel should have the f00f bug ...
-	 */
-	__flush_tlb_all();
+	set_fixmap_readonly(FIX_F00F_IDT, __pa(&idt_table));
 
 	/*
 	 * "idt" is magic - it overlaps the idt_descr
 	 * variable so that updating idt will automatically
 	 * update the idt descriptor..
 	 */
-	idt = (struct desc_struct *)page;
+	idt = (struct desc_struct *) fix_to_virt(FIX_F00F_IDT);
 	__asm__ __volatile__("lidt %0": "=m" (idt_descr));
 }
 #endif
diff -urN linux-2.4.10/arch/i386/mm/init.c linux/arch/i386/mm/init.c
--- linux-2.4.10/arch/i386/mm/init.c	Mon Sep 24 09:24:08 2001
+++ linux/arch/i386/mm/init.c	Fri Sep 28 16:28:13 2001
@@ -125,9 +125,8 @@
 extern char __init_begin, __init_end;
 
 static inline void set_pte_phys (unsigned long vaddr,
-			unsigned long phys, pgprot_t flags)
+			unsigned long phys, pgprot_t prot)
 {
-	pgprot_t prot;
 	pgd_t *pgd;
 	pmd_t *pmd;
 	pte_t *pte;
@@ -145,7 +144,6 @@
 	pte = pte_offset(pmd, vaddr);
 	if (pte_val(*pte))
 		pte_ERROR(*pte);
-	pgprot_val(prot) = pgprot_val(PAGE_KERNEL) | pgprot_val(flags);
 	set_pte(pte, mk_pte_phys(phys, prot));
 
 	/*
diff -urN linux-2.4.10/include/asm-i386/fixmap.h linux/include/asm-i386/fixmap.h
--- linux-2.4.10/include/asm-i386/fixmap.h	Wed Sep 26 20:34:06 2001
+++ linux/include/asm-i386/fixmap.h	Fri Sep 28 18:52:48 2001
@@ -51,6 +51,9 @@
 #ifdef CONFIG_X86_LOCAL_APIC
 	FIX_APIC_BASE,	/* local (CPU) APIC) -- required for SMP or not */
 #endif
+#ifdef CONFIG_X86_F00F_BUG
+	FIX_F00F_IDT,	/* Virtual mapping for IDT */
+#endif
 #ifdef CONFIG_X86_IO_APIC
 	FIX_IO_APIC_BASE_0,
 	FIX_IO_APIC_BASE_END = FIX_IO_APIC_BASE_0 + MAX_IO_APICS-1,
@@ -73,6 +76,8 @@
 
 #define set_fixmap(idx, phys) \
 		__set_fixmap(idx, phys, PAGE_KERNEL)
+#define set_fixmap_readonly(idx, phys) \
+		__set_fixmap(idx, phys, PAGE_KERNEL_RO)
 /*
  * Some hardware wants to get fixmapped without caching.
  */

--------------1618D00D52F18C42719AF755--

