Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290715AbSBTBSF>; Tue, 19 Feb 2002 20:18:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290722AbSBTBR5>; Tue, 19 Feb 2002 20:17:57 -0500
Received: from rwcrmhc53.attbi.com ([204.127.198.39]:51141 "EHLO
	rwcrmhc53.attbi.com") by vger.kernel.org with ESMTP
	id <S290715AbSBTBRm>; Tue, 19 Feb 2002 20:17:42 -0500
Message-ID: <3C72F946.5F6E220C@didntduck.org>
Date: Tue, 19 Feb 2002 20:17:58 -0500
From: Brian Gerst <bgerst@didntduck.org>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.5.5-pre1-bg1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH] Cleanup F00F bug code
Content-Type: multipart/mixed;
 boundary="------------635B052432A4A4262F6BC982"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------635B052432A4A4262F6BC982
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

This patch changes the F00F bug workaround code to use a fixed mapping
instead of touching the page tables directly.  It also removes the
assumption that only 686's don't have the bug.  It has been tested for
normal operation of the relocated IDT, but I don't have a processor with
the bug to do a real test.  Could someone with such a processor please
verify that the workaround still works?

The patch includes a fix to the set_pte_phys() function which was
forcing the writable bit set.

-- 

						Brian Gerst
--------------635B052432A4A4262F6BC982
Content-Type: text/plain; charset=us-ascii;
 name="f00f-3"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="f00f-3"

diff -urN linux-2.5.5-pre1/arch/i386/config.in linux/arch/i386/config.in
--- linux-2.5.5-pre1/arch/i386/config.in	Wed Feb 13 19:02:42 2002
+++ linux/arch/i386/config.in	Tue Feb 19 19:19:11 2002
@@ -41,6 +41,7 @@
    define_bool CONFIG_RWSEM_GENERIC_SPINLOCK y
    define_bool CONFIG_RWSEM_XCHGADD_ALGORITHM n
    define_bool CONFIG_X86_PPRO_FENCE y
+   define_bool CONFIG_X86_F00F_BUG y
 else
    define_bool CONFIG_X86_WP_WORKS_OK y
    define_bool CONFIG_X86_INVLPG y
@@ -56,12 +57,14 @@
    define_bool CONFIG_X86_USE_STRING_486 y
    define_bool CONFIG_X86_ALIGNMENT_16 y
    define_bool CONFIG_X86_PPRO_FENCE y
+   define_bool CONFIG_X86_F00F_BUG y
 fi
 if [ "$CONFIG_M586" = "y" ]; then
    define_int  CONFIG_X86_L1_CACHE_SHIFT 5
    define_bool CONFIG_X86_USE_STRING_486 y
    define_bool CONFIG_X86_ALIGNMENT_16 y
    define_bool CONFIG_X86_PPRO_FENCE y
+   define_bool CONFIG_X86_F00F_BUG y
 fi
 if [ "$CONFIG_M586TSC" = "y" ]; then
    define_int  CONFIG_X86_L1_CACHE_SHIFT 5
@@ -69,6 +72,7 @@
    define_bool CONFIG_X86_ALIGNMENT_16 y
    define_bool CONFIG_X86_TSC y
    define_bool CONFIG_X86_PPRO_FENCE y
+   define_bool CONFIG_X86_F00F_BUG y
 fi
 if [ "$CONFIG_M586MMX" = "y" ]; then
    define_int  CONFIG_X86_L1_CACHE_SHIFT 5
@@ -77,6 +81,7 @@
    define_bool CONFIG_X86_TSC y
    define_bool CONFIG_X86_GOOD_APIC y
    define_bool CONFIG_X86_PPRO_FENCE y
+   define_bool CONFIG_X86_F00F_BUG y
 fi
 if [ "$CONFIG_M686" = "y" ]; then
    define_int  CONFIG_X86_L1_CACHE_SHIFT 5
diff -urN linux-2.5.5-pre1/arch/i386/kernel/setup.c linux/arch/i386/kernel/setup.c
--- linux-2.5.5-pre1/arch/i386/kernel/setup.c	Mon Feb 11 10:21:43 2002
+++ linux/arch/i386/kernel/setup.c	Tue Feb 19 19:19:11 2002
@@ -1920,13 +1920,10 @@
 
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
@@ -1934,6 +1931,8 @@
 	 */
 	c->f00f_bug = 0;
 	if ( c->x86 == 5 ) {
+		static int f00f_workaround_enabled = 0;
+
 		c->f00f_bug = 1;
 		if ( !f00f_workaround_enabled ) {
 			trap_init_f00f_bug();
diff -urN linux-2.5.5-pre1/arch/i386/kernel/traps.c linux/arch/i386/kernel/traps.c
--- linux-2.5.5-pre1/arch/i386/kernel/traps.c	Mon Feb 11 10:21:43 2002
+++ linux/arch/i386/kernel/traps.c	Tue Feb 19 19:19:11 2002
@@ -737,35 +737,17 @@
 
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
+	__set_fixmap(FIX_F00F_IDT, __pa(&idt_table), PAGE_KERNEL_RO);
 
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
diff -urN linux-2.5.5-pre1/arch/i386/mm/fault.c linux/arch/i386/mm/fault.c
--- linux-2.5.5-pre1/arch/i386/mm/fault.c	Wed Feb  6 11:46:55 2002
+++ linux/arch/i386/mm/fault.c	Tue Feb 19 19:19:11 2002
@@ -288,6 +288,7 @@
 		return;
 	}
 
+#ifdef CONFIG_X86_F00F_BUG
 	/*
 	 * Pentium F0 0F C7 C8 bug workaround.
 	 */
@@ -301,6 +302,7 @@
 			return;
 		}
 	}
+#endif
 
 no_context:
 	/* Are we prepared to handle this kernel fault?  */
diff -urN linux-2.5.5-pre1/arch/i386/mm/init.c linux/arch/i386/mm/init.c
--- linux-2.5.5-pre1/arch/i386/mm/init.c	Wed Feb  6 11:46:54 2002
+++ linux/arch/i386/mm/init.c	Tue Feb 19 19:19:11 2002
@@ -126,9 +126,8 @@
 extern char __init_begin, __init_end;
 
 static inline void set_pte_phys (unsigned long vaddr,
-			unsigned long phys, pgprot_t flags)
+			unsigned long phys, pgprot_t prot)
 {
-	pgprot_t prot;
 	pgd_t *pgd;
 	pmd_t *pmd;
 	pte_t *pte;
@@ -146,7 +145,6 @@
 	pte = pte_offset(pmd, vaddr);
 	if (pte_val(*pte))
 		pte_ERROR(*pte);
-	pgprot_val(prot) = pgprot_val(PAGE_KERNEL) | pgprot_val(flags);
 	set_pte(pte, mk_pte_phys(phys, prot));
 
 	/*
diff -urN linux-2.5.5-pre1/include/asm-i386/fixmap.h linux/include/asm-i386/fixmap.h
--- linux-2.5.5-pre1/include/asm-i386/fixmap.h	Tue Feb 19 19:04:05 2002
+++ linux/include/asm-i386/fixmap.h	Tue Feb 19 19:27:53 2002
@@ -61,6 +61,9 @@
 	FIX_LI_PCIA,	/* Lithium PCI Bridge A */
 	FIX_LI_PCIB,	/* Lithium PCI Bridge B */
 #endif
+#ifdef CONFIG_X86_F00F_BUG
+	FIX_F00F_IDT,	/* Virtual mapping for IDT */
+#endif
 #ifdef CONFIG_HIGHMEM
 	FIX_KMAP_BEGIN,	/* reserved pte's for temporary kernel mappings */
 	FIX_KMAP_END = FIX_KMAP_BEGIN+(KM_TYPE_NR*NR_CPUS)-1,

--------------635B052432A4A4262F6BC982--

