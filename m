Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310953AbSDXM5B>; Wed, 24 Apr 2002 08:57:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311211AbSDXM5A>; Wed, 24 Apr 2002 08:57:00 -0400
Received: from rwcrmhc52.attbi.com ([216.148.227.88]:50126 "EHLO
	rwcrmhc52.attbi.com") by vger.kernel.org with ESMTP
	id <S310953AbSDXM46>; Wed, 24 Apr 2002 08:56:58 -0400
Message-ID: <3CC6AB04.8040601@didntduck.org>
Date: Wed, 24 Apr 2002 08:54:28 -0400
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020311
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] x86 mm/init.c
Content-Type: multipart/mixed;
 boundary="------------070405090805060107050705"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070405090805060107050705
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

This patch cleans up pagetable_init by
- pulling the setting of %cr4 out of the loops, only set them once.
- improve readability of the loops.
- change PAGE_KERNEL and friends to variables to avoid checking 
cpu_has_pge all the time.

All pageing modes (PAE/PSE) have been tested.

-- 

						Brian Gerst

--------------070405090805060107050705
Content-Type: text/plain;
 name="mminit-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mminit-2"

diff -urN linux-2.5.9/arch/i386/kernel/i386_ksyms.c linux/arch/i386/kernel/i386_ksyms.c
--- linux-2.5.9/arch/i386/kernel/i386_ksyms.c	Sun Apr 14 23:48:18 2002
+++ linux/arch/i386/kernel/i386_ksyms.c	Tue Apr 23 22:31:25 2002
@@ -174,3 +174,7 @@
 
 extern int is_sony_vaio_laptop;
 EXPORT_SYMBOL(is_sony_vaio_laptop);
+
+EXPORT_SYMBOL(PAGE_KERNEL);
+EXPORT_SYMBOL(PAGE_KERNEL_RO);
+EXPORT_SYMBOL(PAGE_KERNEL_NOCACHE);
diff -urN linux-2.5.9/arch/i386/mm/init.c linux/arch/i386/mm/init.c
--- linux-2.5.9/arch/i386/mm/init.c	Sun Apr 14 23:48:18 2002
+++ linux/arch/i386/mm/init.c	Tue Apr 23 21:29:39 2002
@@ -180,32 +180,43 @@
 	}
 }
 
+pgprot_t PAGE_KERNEL = __pgprot(__PAGE_KERNEL);
+pgprot_t PAGE_KERNEL_RO = __pgprot(__PAGE_KERNEL_RO);
+pgprot_t PAGE_KERNEL_NOCACHE = __pgprot(__PAGE_KERNEL_NOCACHE);
+
 static void __init pagetable_init (void)
 {
-	unsigned long vaddr, end;
+	unsigned long vaddr, pfn, prot;
 	pgd_t *pgd, *pgd_base;
 	int i, j, k;
 	pmd_t *pmd;
 	pte_t *pte, *pte_base;
 
-	/*
-	 * This can be zero as well - no problem, in that case we exit
-	 * the loops anyway due to the PTRS_PER_* conditions.
-	 */
-	end = (unsigned long)__va(max_low_pfn*PAGE_SIZE);
-
 	pgd_base = swapper_pg_dir;
 #if CONFIG_X86_PAE
 	for (i = 0; i < PTRS_PER_PGD; i++)
 		set_pgd(pgd_base + i, __pgd(1 + __pa(empty_zero_page)));
 #endif
+
+	prot = _KERNPG_TABLE;
+	if (cpu_has_pse) {
+		set_in_cr4(X86_CR4_PSE);
+		prot |= _PAGE_PSE;
+		boot_cpu_data.wp_works_ok = 1;
+	}
+	if (cpu_has_pge) {
+		set_in_cr4(X86_CR4_PGE);
+		prot |= _PAGE_GLOBAL;
+		PAGE_KERNEL.pgprot |= _PAGE_GLOBAL;
+		PAGE_KERNEL_RO.pgprot |= _PAGE_GLOBAL;
+		PAGE_KERNEL_NOCACHE.pgprot |= _PAGE_GLOBAL;
+	}
+
+	pfn = 0;
 	i = __pgd_offset(PAGE_OFFSET);
 	pgd = pgd_base + i;
 
-	for (; i < PTRS_PER_PGD; pgd++, i++) {
-		vaddr = i*PGDIR_SIZE;
-		if (end && (vaddr >= end))
-			break;
+	for (; i < PTRS_PER_PGD && pfn < max_low_pfn; pgd++, i++) {
 #if CONFIG_X86_PAE
 		pmd = (pmd_t *) alloc_bootmem_low_pages(PAGE_SIZE);
 		set_pgd(pgd, __pgd(__pa(pmd) + 0x1));
@@ -214,37 +225,21 @@
 #endif
 		if (pmd != pmd_offset(pgd, 0))
 			BUG();
-		for (j = 0; j < PTRS_PER_PMD; pmd++, j++) {
-			vaddr = i*PGDIR_SIZE + j*PMD_SIZE;
-			if (end && (vaddr >= end))
-				break;
+		for (j = 0; j < PTRS_PER_PMD && pfn < max_low_pfn; pmd++, j++) {
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
+				set_pmd(pmd, __pmd(prot + (pfn << PAGE_SHIFT)));
+				pfn += PMD_SIZE >> PAGE_SHIFT;
+			} else {
+				pte_base = pte = (pte_t *) alloc_bootmem_low_pages(PAGE_SIZE);
+
+				for (k = 0; k < PTRS_PER_PTE && pfn < max_low_pfn; pte++, k++) {
+					*pte = __mk_pte(pfn, PAGE_KERNEL);
+					pfn++;
 				}
-				set_pmd(pmd, __pmd(__pe));
-				continue;
+				set_pmd(pmd, __pmd(prot + __pa(pte_base)));
+				if (pte_base != pte_offset_kernel(pmd, 0))
+					BUG();
 			}
-
-			pte_base = pte = (pte_t *) alloc_bootmem_low_pages(PAGE_SIZE);
-
-			for (k = 0; k < PTRS_PER_PTE; pte++, k++) {
-				vaddr = i*PGDIR_SIZE + j*PMD_SIZE + k*PAGE_SIZE;
-				if (end && (vaddr >= end))
-					break;
-				*pte = mk_pte_phys(__pa(vaddr), PAGE_KERNEL);
-			}
-			set_pmd(pmd, __pmd(_KERNPG_TABLE + __pa(pte_base)));
-			if (pte_base != pte_offset_kernel(pmd, 0))
-				BUG();
-
 		}
 	}
 
diff -urN linux-2.5.9/include/asm-i386/pgtable.h linux/include/asm-i386/pgtable.h
--- linux-2.5.9/include/asm-i386/pgtable.h	Mon Apr 22 19:35:31 2002
+++ linux/include/asm-i386/pgtable.h	Tue Apr 23 22:25:48 2002
@@ -139,20 +139,7 @@
 #define __PAGE_KERNEL_RO \
 	(_PAGE_PRESENT | _PAGE_DIRTY | _PAGE_ACCESSED)
 
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
-
-#define PAGE_KERNEL MAKE_GLOBAL(__PAGE_KERNEL)
-#define PAGE_KERNEL_RO MAKE_GLOBAL(__PAGE_KERNEL_RO)
-#define PAGE_KERNEL_NOCACHE MAKE_GLOBAL(__PAGE_KERNEL_NOCACHE)
+extern pgprot_t PAGE_KERNEL, PAGE_KERNEL_RO, PAGE_KERNEL_NOCACHE;
 
 /*
  * The i386 can't do page protection for execute, and considers that

--------------070405090805060107050705--

