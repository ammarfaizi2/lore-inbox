Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275731AbRI0Bqv>; Wed, 26 Sep 2001 21:46:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275732AbRI0Bqm>; Wed, 26 Sep 2001 21:46:42 -0400
Received: from femail26.sdc1.sfba.home.com ([24.254.60.16]:29938 "EHLO
	femail26.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S275731AbRI0Bqb>; Wed, 26 Sep 2001 21:46:31 -0400
Message-ID: <3BB283F3.9E9105AC@didntduck.org>
Date: Wed, 26 Sep 2001 21:42:11 -0400
From: Brian Gerst <bgerst@didntduck.org>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH] Clean up x86 write protect test
Content-Type: multipart/mixed;
 boundary="------------2F38A81CFF23874A4A1D10CF"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------2F38A81CFF23874A4A1D10CF
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

This patch changes the write protect test to use vmalloc instead of
touching the page tables directly.  As a side effect, this allows the
test to be run on processors supporting page size extensions, exercising
the exception handler code.

-- 

						Brian Gerst
--------------2F38A81CFF23874A4A1D10CF
Content-Type: text/plain; charset=us-ascii;
 name="diff-wp"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff-wp"

diff -urN linux-2.4.10/arch/i386/kernel/setup.c linux/arch/i386/kernel/setup.c
--- linux-2.4.10/arch/i386/kernel/setup.c	Mon Sep 24 09:24:08 2001
+++ linux/arch/i386/kernel/setup.c	Wed Sep 26 20:58:23 2001
@@ -113,7 +113,7 @@
  */
 
 char ignore_irq13;		/* set if exception 16 works */
-struct cpuinfo_x86 boot_cpu_data = { 0, 0, 0, 0, -1, 1, 0, 0, -1 };
+struct cpuinfo_x86 boot_cpu_data = { 0, 0, 0, 0, 0, 1, 0, 0, -1 };
 
 unsigned long mmu_cr4_features;
 
diff -urN linux-2.4.10/arch/i386/mm/init.c linux/arch/i386/mm/init.c
--- linux-2.4.10/arch/i386/mm/init.c	Mon Sep 24 09:24:08 2001
+++ linux/arch/i386/mm/init.c	Wed Sep 26 20:57:59 2001
@@ -246,7 +246,6 @@
 				unsigned long __pe;
 
 				set_in_cr4(X86_CR4_PSE);
-				boot_cpu_data.wp_works_ok = 1;
 				__pe = _KERNPG_TABLE + _PAGE_PSE + __pa(vaddr);
 				/* Make it "global" too if supported */
 				if (cpu_has_pge) {
@@ -373,39 +372,25 @@
 
 /*
  * Test if the WP bit works in supervisor mode. It isn't supported on 386's
- * and also on some strange 486's (NexGen etc.). All 586+'s are OK. The jumps
- * before and after the test are here to work-around some nasty CPU bugs.
+ * and also on some strange 486's (NexGen etc.). All 586+'s are OK.
  */
 
 /*
  * This function cannot be __init, since exceptions don't work in that
  * section.
  */
-static int do_test_wp_bit(unsigned long vaddr);
+static int do_test_wp_bit(int *vaddr);
 
 void __init test_wp_bit(void)
 {
-/*
- * Ok, all PSE-capable CPUs are definitely handling the WP bit right.
- */
-	const unsigned long vaddr = PAGE_OFFSET;
-	pgd_t *pgd;
-	pmd_t *pmd;
-	pte_t *pte, old_pte;
+	int *vaddr;
 
 	printk("Checking if this processor honours the WP bit even in supervisor mode... ");
-
-	pgd = swapper_pg_dir + __pgd_offset(vaddr);
-	pmd = pmd_offset(pgd, vaddr);
-	pte = pte_offset(pmd, vaddr);
-	old_pte = *pte;
-	*pte = mk_pte_phys(0, PAGE_READONLY);
-	local_flush_tlb();
-
+	vaddr = __vmalloc(PAGE_SIZE, GFP_KERNEL, PAGE_READONLY);
+	if (!vaddr)
+		panic("Cannot allocate a read only page.\n");
 	boot_cpu_data.wp_works_ok = do_test_wp_bit(vaddr);
-
-	*pte = old_pte;
-	local_flush_tlb();
+	vfree(vaddr);
 
 	if (!boot_cpu_data.wp_works_ok) {
 		printk("No.\n");
@@ -502,14 +487,11 @@
 	if (!cpu_has_pae)
 		panic("cannot execute a PAE-enabled kernel on a PAE-less CPU!");
 #endif
-	if (boot_cpu_data.wp_works_ok < 0)
-		test_wp_bit();
 
 	/*
 	 * Subtle. SMP is doing it's boot stuff late (because it has to
 	 * fork idle threads) - but it also needs low mappings for the
-	 * protected-mode entry to work. We zap these entries only after
-	 * the WP-bit has been tested.
+	 * protected-mode entry to work.
 	 */
 #ifndef CONFIG_SMP
 	zap_low_mappings();
@@ -518,24 +500,22 @@
 }
 
 /* Put this after the callers, so that it cannot be inlined */
-static int do_test_wp_bit(unsigned long vaddr)
+static int do_test_wp_bit(int *vaddr)
 {
 	char tmp_reg;
 	int flag;
 
 	__asm__ __volatile__(
-		"	movb %0,%1	\n"
-		"1:	movb %1,%0	\n"
-		"	xorl %2,%2	\n"
+		"1:	movl %1,%0	\n"
+		"	xorl %1,%1	\n"
 		"2:			\n"
 		".section __ex_table,\"a\"\n"
 		"	.align 4	\n"
 		"	.long 1b,2b	\n"
 		".previous		\n"
-		:"=m" (*(char *) vaddr),
-		 "=q" (tmp_reg),
+		:"=m" (*vaddr),
 		 "=r" (flag)
-		:"2" (1)
+		:"1" (1)
 		:"memory");
 	
 	return flag;
diff -urN linux-2.4.10/include/asm-i386/bugs.h linux/include/asm-i386/bugs.h
--- linux-2.4.10/include/asm-i386/bugs.h	Wed Sep 26 19:25:21 2001
+++ linux/include/asm-i386/bugs.h	Wed Sep 26 20:57:59 2001
@@ -202,6 +202,8 @@
 #endif
 }
 
+extern void __init test_wp_bit(void);
+
 static void __init check_bugs(void)
 {
 	identify_cpu(&boot_cpu_data);
@@ -210,6 +212,7 @@
 	print_cpu_info(&boot_cpu_data);
 #endif
 	check_config();
+	test_wp_bit();
 	check_fpu();
 	check_hlt();
 	check_popad();

--------------2F38A81CFF23874A4A1D10CF--

