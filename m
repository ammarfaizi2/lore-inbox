Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275732AbRI0B4v>; Wed, 26 Sep 2001 21:56:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275733AbRI0B4m>; Wed, 26 Sep 2001 21:56:42 -0400
Received: from femail37.sdc1.sfba.home.com ([24.254.60.31]:62618 "EHLO
	femail37.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S275732AbRI0B43>; Wed, 26 Sep 2001 21:56:29 -0400
Message-ID: <3BB28649.108B734B@didntduck.org>
Date: Wed, 26 Sep 2001 21:52:09 -0400
From: Brian Gerst <bgerst@didntduck.org>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH] Cleanup f00f bug code
Content-Type: multipart/mixed;
 boundary="------------6E85D59EAD95670EE3FEFE8D"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------6E85D59EAD95670EE3FEFE8D
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

This patch changes the f00f bug workaround code to use a fixed mapping
instead of touching the page tables directly.  It also removes the
assumption that only 686's don't have the bug.  It has been tested for
normal operation of the relocated IDT, but I don't have a processor with
the bug to do a real test.  Could someone with such a processor please
verify that the workaround still works?

-- 

						Brian Gerst
--------------6E85D59EAD95670EE3FEFE8D
Content-Type: text/plain; charset=us-ascii;
 name="diff-f00f"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff-f00f"

diff -urN linux-2.4.10/arch/i386/config.in linux/arch/i386/config.in
--- linux-2.4.10/arch/i386/config.in	Mon Sep 24 09:24:08 2001
+++ linux/arch/i386/config.in	Wed Sep 26 13:28:38 2001
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
+++ linux/arch/i386/kernel/setup.c	Wed Sep 26 19:41:13 2001
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
+++ linux/arch/i386/kernel/traps.c	Wed Sep 26 13:47:04 2001
@@ -719,25 +719,12 @@
 
 #endif /* CONFIG_MATH_EMULATION */
 
-#ifndef CONFIG_M686
+#ifdef CONFIG_X86_F00F_BUG
 void __init trap_init_f00f_bug(void)
 {
-	unsigned long page;
-	pgd_t * pgd;
-	pmd_t * pmd;
-	pte_t * pte;
+	__set_fixmap(FIX_F00F_IDT, __pa(&idt_table), PAGE_KERNEL_RO);
 
 	/*
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
 	 * Not that any PGE-capable kernel should have the f00f bug ...
 	 */
 	__flush_tlb_all();
@@ -747,7 +734,7 @@
 	 * variable so that updating idt will automatically
 	 * update the idt descriptor..
 	 */
-	idt = (struct desc_struct *)page;
+	idt = (struct desc_struct *) fix_to_virt(FIX_F00F_IDT);
 	__asm__ __volatile__("lidt %0": "=m" (idt_descr));
 }
 #endif
diff -urN linux-2.4.10/include/asm-i386/fixmap.h linux/include/asm-i386/fixmap.h
--- linux-2.4.10/include/asm-i386/fixmap.h	Wed Sep 19 08:09:51 2001
+++ linux/include/asm-i386/fixmap.h	Wed Sep 26 19:15:25 2001
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

--------------6E85D59EAD95670EE3FEFE8D--

