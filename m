Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314659AbSEYPVo>; Sat, 25 May 2002 11:21:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314675AbSEYPVn>; Sat, 25 May 2002 11:21:43 -0400
Received: from rwcrmhc52.attbi.com ([216.148.227.88]:18878 "EHLO
	rwcrmhc52.attbi.com") by vger.kernel.org with ESMTP
	id <S314659AbSEYPVm>; Sat, 25 May 2002 11:21:42 -0400
Message-ID: <3CEFAB1F.102@didntduck.org>
Date: Sat, 25 May 2002 11:17:51 -0400
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc2) Gecko/20020510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] i386 mm init cleanup part 2
Content-Type: multipart/mixed;
 boundary="------------030304080705020200050500"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030304080705020200050500
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

The remaining cleanups are to switch to using pfn instead of vaddr, and 
improve readability.

-- 

						Brian Gerst

--------------030304080705020200050500
Content-Type: text/plain;
 name="mminit-3b"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mminit-3b"

diff -urN linux-mm1/arch/i386/mm/init.c linux/arch/i386/mm/init.c
--- linux-mm1/arch/i386/mm/init.c	Sat May 25 09:30:21 2002
+++ linux/arch/i386/mm/init.c	Sat May 25 10:46:11 2002
@@ -181,22 +181,16 @@
 
 static void __init pagetable_init (void)
 {
-	unsigned long vaddr, end;
+	unsigned long vaddr, pfn;
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
-		set_pgd(pgd_base + i, __pgd(1 + __pa(empty_zero_page)));
+		set_pgd(pgd_base + i, __pgd(__pa(empty_zero_page) | _PAGE_PRESENT));
 #endif
 	if (cpu_has_pse) {
 		set_in_cr4(X86_CR4_PSE);
@@ -207,41 +201,28 @@
 	}
 
 	i = __pgd_offset(PAGE_OFFSET);
+	pfn = 0;
 	pgd = pgd_base + i;
 
-	for (; i < PTRS_PER_PGD; pgd++, i++) {
-		vaddr = i*PGDIR_SIZE;
-		if (end && (vaddr >= end))
-			break;
+	for (; i < PTRS_PER_PGD && pfn < max_low_pfn; pgd++, i++) {
 #if CONFIG_X86_PAE
 		pmd = (pmd_t *) alloc_bootmem_low_pages(PAGE_SIZE);
-		set_pgd(pgd, __pgd(__pa(pmd) + 0x1));
+		set_pgd(pgd, __pgd(__pa(pmd) | _PAGE_PRESENT));
 #else
-		pmd = (pmd_t *)pgd;
+		pmd = (pmd_t *) pgd;
 #endif
-		if (pmd != pmd_offset(pgd, 0))
-			BUG();
-		for (j = 0; j < PTRS_PER_PMD; pmd++, j++) {
-			vaddr = i*PGDIR_SIZE + j*PMD_SIZE;
-			if (end && (vaddr >= end))
-				break;
+		for (j = 0; j < PTRS_PER_PMD && pfn < max_low_pfn; pmd++, j++) {
 			if (cpu_has_pse) {
-				set_pmd(pmd, pfn_pmd(__pa(vaddr) >> PAGE_SHIFT, PAGE_KERNEL_LARGE));
-				continue;
-			}
+				set_pmd(pmd, pfn_pmd(pfn, PAGE_KERNEL_LARGE));
+				pfn += PTRS_PER_PTE;
+			} else {
+				pte_base = pte = (pte_t *) alloc_bootmem_low_pages(PAGE_SIZE);
 
-			pte_base = pte = (pte_t *) alloc_bootmem_low_pages(PAGE_SIZE);
+				for (k = 0; k < PTRS_PER_PTE && pfn < max_low_pfn; pte++, pfn++, k++)
+					set_pte(pte, pfn_pte(pfn, PAGE_KERNEL));
 
-			for (k = 0; k < PTRS_PER_PTE; pte++, k++) {
-				vaddr = i*PGDIR_SIZE + j*PMD_SIZE + k*PAGE_SIZE;
-				if (end && (vaddr >= end))
-					break;
-				*pte = pfn_pte(__pa(vaddr) >> PAGE_SHIFT, PAGE_KERNEL);
+				set_pmd(pmd, __pmd(__pa(pte_base) | _KERNPG_TABLE));
 			}
-			set_pmd(pmd, __pmd(_KERNPG_TABLE + __pa(pte_base)));
-			if (pte_base != pte_offset_kernel(pmd, 0))
-				BUG();
-
 		}
 	}
 

--------------030304080705020200050500--

