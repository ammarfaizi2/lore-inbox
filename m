Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314551AbSEYNOJ>; Sat, 25 May 2002 09:14:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314553AbSEYNOI>; Sat, 25 May 2002 09:14:08 -0400
Received: from rwcrmhc52.attbi.com ([216.148.227.88]:8922 "EHLO
	rwcrmhc52.attbi.com") by vger.kernel.org with ESMTP
	id <S314551AbSEYNOH>; Sat, 25 May 2002 09:14:07 -0400
Message-ID: <3CEF8D31.8020606@didntduck.org>
Date: Sat, 25 May 2002 09:10:09 -0400
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc2) Gecko/20020510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] i386 mm init cleanup part 1
Content-Type: multipart/mixed;
 boundary="------------030006010502010101050503"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030006010502010101050503
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

This revised patch starts untangling the mess in arch/i386/mm/init.c
- Pull setting bits in cr4 out of the loop
- Make __PAGE_KERNEL a variable and cache the global bit there.
- New pfn_pmd() for large pages.

-- 

						Brian Gerst

--------------030006010502010101050503
Content-Type: text/plain;
 name="mminit-3a"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mminit-3a"

diff -urN linux-bk/arch/i386/kernel/i386_ksyms.c linux-bg1/arch/i386/kernel/i386_ksyms.c
--- linux-bk/arch/i386/kernel/i386_ksyms.c	Wed May 15 10:27:19 2002
+++ linux-bg1/arch/i386/kernel/i386_ksyms.c	Fri May 24 20:43:49 2002
@@ -174,3 +174,5 @@
 
 extern int is_sony_vaio_laptop;
 EXPORT_SYMBOL(is_sony_vaio_laptop);
+
+EXPORT_SYMBOL(__PAGE_KERNEL);
diff -urN linux-bk/arch/i386/mm/init.c linux-bg1/arch/i386/mm/init.c
--- linux-bk/arch/i386/mm/init.c	Fri May 24 19:43:34 2002
+++ linux-bg1/arch/i386/mm/init.c	Fri May 24 20:44:14 2002
@@ -177,6 +177,8 @@
 	}
 }
 
+unsigned long __PAGE_KERNEL = _PAGE_KERNEL;
+
 static void __init pagetable_init (void)
 {
 	unsigned long vaddr, end;
@@ -196,6 +198,14 @@
 	for (i = 0; i < PTRS_PER_PGD; i++)
 		set_pgd(pgd_base + i, __pgd(1 + __pa(empty_zero_page)));
 #endif
+	if (cpu_has_pse) {
+		set_in_cr4(X86_CR4_PSE);
+	}
+	if (cpu_has_pge) {
+		set_in_cr4(X86_CR4_PGE);
+		__PAGE_KERNEL |= _PAGE_GLOBAL;
+	}
+
 	i = __pgd_offset(PAGE_OFFSET);
 	pgd = pgd_base + i;
 
@@ -216,17 +226,7 @@
 			if (end && (vaddr >= end))
 				break;
 			if (cpu_has_pse) {
-				unsigned long __pe;
-
-				set_in_cr4(X86_CR4_PSE);
-				boot_cpu_data.wp_works_ok = 1;
-				__pe = _KERNPG_TABLE + _PAGE_PSE + __pa(vaddr);
-				/* Make it "global" too if supported */
-				if (cpu_has_pge) {
-					set_in_cr4(X86_CR4_PGE);
-					__pe += _PAGE_GLOBAL;
-				}
-				set_pmd(pmd, __pmd(__pe));
+				set_pmd(pmd, pfn_pmd(__pa(vaddr) >> PAGE_SHIFT, PAGE_KERNEL_LARGE));
 				continue;
 			}
 
@@ -358,14 +358,17 @@
 
 void __init test_wp_bit(void)
 {
-/*
- * Ok, all PSE-capable CPUs are definitely handling the WP bit right.
- */
 	const unsigned long vaddr = PAGE_OFFSET;
 	pgd_t *pgd;
 	pmd_t *pmd;
 	pte_t *pte, old_pte;
 
+	if (cpu_has_pse) {
+		/* Ok, all PSE-capable CPUs are definitely handling the WP bit right. */
+		boot_cpu_data.wp_works_ok = 1;
+		return;
+	}
+
 	printk("Checking if this processor honours the WP bit even in supervisor mode... ");
 
 	pgd = swapper_pg_dir + __pgd_offset(vaddr);
diff -urN linux-bk/include/asm-i386/pgtable-2level.h linux-bg1/include/asm-i386/pgtable-2level.h
--- linux-bk/include/asm-i386/pgtable-2level.h	Wed May 15 10:27:26 2002
+++ linux-bg1/include/asm-i386/pgtable-2level.h	Fri May 24 10:11:46 2002
@@ -60,5 +60,6 @@
 #define pte_none(x)		(!(x).pte_low)
 #define pte_pfn(x)		((unsigned long)(((x).pte_low >> PAGE_SHIFT)))
 #define pfn_pte(pfn, prot)	__pte(((pfn) << PAGE_SHIFT) | pgprot_val(prot))
+#define pfn_pmd(pfn, prot)	__pmd(((pfn) << PAGE_SHIFT) | pgprot_val(prot))
 
 #endif /* _I386_PGTABLE_2LEVEL_H */
diff -urN linux-bk/include/asm-i386/pgtable-3level.h linux-bg1/include/asm-i386/pgtable-3level.h
--- linux-bk/include/asm-i386/pgtable-3level.h	Wed May 15 10:27:26 2002
+++ linux-bg1/include/asm-i386/pgtable-3level.h	Fri May 24 10:42:32 2002
@@ -99,4 +99,9 @@
 	return pte;
 }
 
+static inline pmd_t pfn_pmd(unsigned long page_nr, pgprot_t pgprot)
+{
+	return __pmd(((unsigned long long)page_nr << PAGE_SHIFT) | pgprot_val(pgprot));
+}
+
 #endif /* _I386_PGTABLE_3LEVEL_H */
diff -urN linux-bk/include/asm-i386/pgtable.h linux-bg1/include/asm-i386/pgtable.h
--- linux-bk/include/asm-i386/pgtable.h	Fri May 24 01:26:07 2002
+++ linux-bg1/include/asm-i386/pgtable.h	Fri May 24 20:45:08 2002
@@ -132,27 +132,18 @@
 #define PAGE_COPY	__pgprot(_PAGE_PRESENT | _PAGE_USER | _PAGE_ACCESSED)
 #define PAGE_READONLY	__pgprot(_PAGE_PRESENT | _PAGE_USER | _PAGE_ACCESSED)
 
-#define __PAGE_KERNEL \
+#define _PAGE_KERNEL \
 	(_PAGE_PRESENT | _PAGE_RW | _PAGE_DIRTY | _PAGE_ACCESSED)
-#define __PAGE_KERNEL_NOCACHE \
-	(_PAGE_PRESENT | _PAGE_RW | _PAGE_DIRTY | _PAGE_PCD | _PAGE_ACCESSED)
-#define __PAGE_KERNEL_RO \
-	(_PAGE_PRESENT | _PAGE_DIRTY | _PAGE_ACCESSED)
 
-# define MAKE_GLOBAL(x)						\
-	({							\
-		pgprot_t __ret;					\
-								\
-		if (cpu_has_pge)				\
-			__ret = __pgprot((x) | _PAGE_GLOBAL);	\
-		else						\
-			__ret = __pgprot(x);			\
-		__ret;						\
-	})
+extern unsigned long __PAGE_KERNEL;
+#define __PAGE_KERNEL_RO	(__PAGE_KERNEL & ~_PAGE_RW)
+#define __PAGE_KERNEL_NOCACHE	(__PAGE_KERNEL | _PAGE_PCD)
+#define __PAGE_KERNEL_LARGE	(__PAGE_KERNEL | _PAGE_PSE)
 
-#define PAGE_KERNEL MAKE_GLOBAL(__PAGE_KERNEL)
-#define PAGE_KERNEL_RO MAKE_GLOBAL(__PAGE_KERNEL_RO)
-#define PAGE_KERNEL_NOCACHE MAKE_GLOBAL(__PAGE_KERNEL_NOCACHE)
+#define PAGE_KERNEL		__pgprot(__PAGE_KERNEL)
+#define PAGE_KERNEL_RO		__pgprot(__PAGE_KERNEL_RO)
+#define PAGE_KERNEL_NOCACHE	__pgprot(__PAGE_KERNEL_NOCACHE)
+#define PAGE_KERNEL_LARGE	__pgprot(__PAGE_KERNEL_LARGE)
 
 /*
  * The i386 can't do page protection for execute, and considers that

--------------030006010502010101050503--

