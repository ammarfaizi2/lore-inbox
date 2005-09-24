Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932206AbVIXRf6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932206AbVIXRf6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Sep 2005 13:35:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932207AbVIXRf6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Sep 2005 13:35:58 -0400
Received: from anf141.internetdsl.tpnet.pl ([83.17.87.141]:7875 "EHLO
	anf141.internetdsl.tpnet.pl") by vger.kernel.org with ESMTP
	id S932206AbVIXRf4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Sep 2005 13:35:56 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@ucw.cz>
Subject: [PATCH][Fix] Prevent swsusp from corrupting page translation tables during resume on x86-64
Date: Sat, 24 Sep 2005 19:36:11 +0200
User-Agent: KMail/1.8.2
Cc: LKML <linux-kernel@vger.kernel.org>, Andi Kleen <ak@suse.de>,
       Andrew Morton <akpm@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200509241936.12214.rjw@sisk.pl>
X-Length: 1422
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[The previous message has been sent accidentally without the patch]

Hi,

The following patch fixes Bug #4959.  It creates temporary page translation
tables located in the page frames that are not overwritten by swsusp while copying
the image.

The temporary page translation tables are generally based on the existing ones
with the exception that the mappings using 4KB pages are replaced with the
equivalent mappings that use 2MB pages only.  The temporary page tables are
only used for copying the image.

Please consider for applying.

Greetings,
Rafael


Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

Index: linux-2.6.14-rc2-git3/arch/x86_64/kernel/suspend.c
===================================================================
--- linux-2.6.14-rc2-git3.orig/arch/x86_64/kernel/suspend.c	2005-09-23 18:20:41.000000000 +0200
+++ linux-2.6.14-rc2-git3/arch/x86_64/kernel/suspend.c	2005-09-23 18:21:48.000000000 +0200
@@ -11,6 +11,17 @@
 #include <linux/smp.h>
 #include <linux/suspend.h>
 #include <asm/proto.h>
+#include <asm/page.h>
+#include <asm/pgtable.h>
+#include <asm/tlbflush.h>
+
+/* Defined in kernel/power/swsusp.c */
+extern unsigned long get_usable_page(unsigned gfp_mask);
+
+pgd_t *temp_level4_pgt;
+
+#define __PGTABLE_MASK		0x000ffffffffff000UL
+#define __PGTABLE_PSE_MASK	0x000fffffffe00000UL
 
 struct saved_context saved_context;
 
@@ -140,4 +151,69 @@
 
 }
 
+static int __duplicate_page_tables(pgd_t *src_pgd, pgd_t *pgd, unsigned long map_offset)
+{
+	pud_t *src_pud, *pud;
+	pmd_t *src_pmd, *pmd;
+	pte_t *src_pte;
+	int i, j, k;
+
+	pr_debug("Duplicating pagetables for the map 0x%016lx at 0x%016lx\n",
+		map_offset, (unsigned long)src_pgd);
+	i = pgd_index(map_offset);
+	j = pud_index(map_offset);
+	k = pmd_index(map_offset);
+	src_pgd += i;
+	pgd += i;
+	for (; pgd_val(*src_pgd) && i < PTRS_PER_PGD; i++, src_pgd++, pgd++) {
+		pud = (pud_t *)get_usable_page(GFP_ATOMIC);
+		if (!pud)
+			return -ENOMEM;
+		pgd_val(*pgd) = (pgd_val(*src_pgd) & ~__PGTABLE_MASK) |
+			__pa((unsigned long)pud);
+		pud += j;
+		src_pud = (pud_t *)__va(pgd_val(*src_pgd) & __PGTABLE_MASK) + j;
+		for (; pud_val(*src_pud) && j < PTRS_PER_PUD; j++, src_pud++, pud++) {
+			pmd = (pmd_t *)get_usable_page(GFP_ATOMIC);
+			if (!pmd)
+				return -ENOMEM;
+			pud_val(*pud) = (pud_val(*src_pud) & ~__PGTABLE_MASK) |
+				__pa((unsigned long)pmd);
+			pmd += k;
+			src_pmd = (pmd_t *)__va(pud_val(*src_pud) & __PGTABLE_MASK) + k;
+			for (; pmd_val(*src_pmd) && k < PTRS_PER_PMD; k++, src_pmd++, pmd++)
+				if (pmd_val(*src_pmd) & _PAGE_PSE) /* 2MB page */
+					pmd_val(*pmd) = pmd_val(*src_pmd);
+				else { /* 4KB page table -> 2MB page */
+					src_pte = __va(pmd_val(*src_pmd) & __PGTABLE_MASK);
+					pmd_val(*pmd) = ((pmd_val(*src_pmd) & ~__PGTABLE_MASK) |
+						_PAGE_PSE) |
+						(pte_val(*src_pte) & __PGTABLE_PSE_MASK);
+				}
+			k = 0;
+		}
+		j = 0;
+	}
+	return 0;
+}
 
+void duplicate_page_tables(void)
+{
+	int result = 0;
+
+	temp_level4_pgt = (pgd_t *)get_usable_page(GFP_ATOMIC);
+
+	if (!temp_level4_pgt)
+		result = -ENOMEM;
+
+	if (!result)
+		result = __duplicate_page_tables(init_level4_pgt, temp_level4_pgt,
+				PAGE_OFFSET);
+
+	if (!result)
+		result = __duplicate_page_tables(init_level4_pgt, temp_level4_pgt,
+				__START_KERNEL_map);
+
+	if (result)
+		panic("No room for temporary page translation tables!\n");
+}
Index: linux-2.6.14-rc2-git3/kernel/power/swsusp.c
===================================================================
--- linux-2.6.14-rc2-git3.orig/kernel/power/swsusp.c	2005-09-23 18:20:41.000000000 +0200
+++ linux-2.6.14-rc2-git3/kernel/power/swsusp.c	2005-09-23 18:21:48.000000000 +0200
@@ -1092,7 +1092,7 @@
 	*eaten_memory = c;
 }
 
-static unsigned long get_usable_page(unsigned gfp_mask)
+unsigned long get_usable_page(unsigned gfp_mask)
 {
 	unsigned long m;
 
@@ -1478,11 +1478,12 @@
 	/* Allocate memory for the image and read the data from swap */
 
 	error = check_pagedir(pagedir_nosave);
-	free_eaten_memory();
+
 	if (!error)
 		error = data_read(pagedir_nosave);
 
 	if (error) { /* We fail cleanly */
+		free_eaten_memory();
 		for_each_pbe (p, pagedir_nosave)
 			if (p->address) {
 				free_page(p->address);
Index: linux-2.6.14-rc2-git3/arch/x86_64/kernel/suspend_asm.S
===================================================================
--- linux-2.6.14-rc2-git3.orig/arch/x86_64/kernel/suspend_asm.S	2005-09-23 18:20:41.000000000 +0200
+++ linux-2.6.14-rc2-git3/arch/x86_64/kernel/suspend_asm.S	2005-09-23 18:21:48.000000000 +0200
@@ -40,11 +40,14 @@
 	ret
 
 ENTRY(swsusp_arch_resume)
-	/* set up cr3 */	
-	leaq	init_level4_pgt(%rip),%rax
-	subq	$__START_KERNEL_map,%rax
-	movq	%rax,%cr3
+	call	duplicate_page_tables
 
+	/* switch to temporary page tables */
+	movq	$__PAGE_OFFSET, %rdx
+	movq	temp_level4_pgt(%rip), %rax
+	subq	%rdx, %rax
+	movq	%rax, %cr3
+	/* Flush TLB */
 	movq	mmu_cr4_features(%rip), %rax
 	movq	%rax, %rdx
 	andq	$~(1<<7), %rdx	# PGE
@@ -69,6 +72,10 @@
 	movq	pbe_next(%rdx), %rdx
 	jmp	loop
 done:
+	/* go back to the original page tables */
+	leaq	init_level4_pgt(%rip), %rax
+	subq	$__START_KERNEL_map, %rax
+	movq	%rax, %cr3
 	/* Flush TLB, including "global" things (vmalloc) */
 	movq	mmu_cr4_features(%rip), %rax
 	movq	%rax, %rdx


-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
