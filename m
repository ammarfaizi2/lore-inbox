Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262089AbVEREau@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262089AbVEREau (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 00:30:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262079AbVERE3e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 00:29:34 -0400
Received: from lakshmi.addtoit.com ([198.99.130.6]:26381 "EHLO
	lakshmi.solana.com") by vger.kernel.org with ESMTP id S262085AbVERE0B
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 00:26:01 -0400
Message-Id: <200505180420.j4I4KXrD017344@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org, torvalds@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Subject: [PATCH 8/9] UML - fixrange_init 3-level page table support
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 18 May 2005 00:20:33 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From Al Viro - add three-level page table support to fixrange_init.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.12-rc/arch/um/kernel/mem.c
===================================================================
--- linux-2.6.12-rc.orig/arch/um/kernel/mem.c	2005-05-17 18:02:25.000000000 -0400
+++ linux-2.6.12-rc/arch/um/kernel/mem.c	2005-05-17 18:21:32.000000000 -0400
@@ -100,12 +100,37 @@ void mem_init(void)
 #endif
 }
 
+/*
+ * Create a page table and place a pointer to it in a middle page
+ * directory entry.
+ */
+static void __init one_page_table_init(pmd_t *pmd)
+{
+	if (pmd_none(*pmd)) {
+		pte_t *pte = (pte_t *) alloc_bootmem_low_pages(PAGE_SIZE);
+		set_pmd(pmd, __pmd(_KERNPG_TABLE + 
+					   (unsigned long) __pa(pte)));
+		if (pte != pte_offset_kernel(pmd, 0))
+			BUG();
+	}
+}
+
+static void __init one_md_table_init(pud_t *pud)
+{
+#ifdef CONFIG_3_LEVEL_PGTABLES
+	pmd_t *pmd_table = (pmd_t *) alloc_bootmem_low_pages(PAGE_SIZE);
+	set_pud(pud, __pud(_KERNPG_TABLE + (unsigned long) __pa(pmd_table)));
+	if (pmd_table != pmd_offset(pud, 0)) 
+		BUG();
+#endif
+}
+
 static void __init fixrange_init(unsigned long start, unsigned long end, 
 				 pgd_t *pgd_base)
 {
 	pgd_t *pgd;
+	pud_t *pud;
 	pmd_t *pmd;
-	pte_t *pte;
 	int i, j;
 	unsigned long vaddr;
 
@@ -115,15 +140,12 @@ static void __init fixrange_init(unsigne
 	pgd = pgd_base + i;
 
 	for ( ; (i < PTRS_PER_PGD) && (vaddr < end); pgd++, i++) {
-		pmd = (pmd_t *)pgd;
+		pud = pud_offset(pgd, vaddr);
+		if (pud_none(*pud)) 
+			one_md_table_init(pud);
+		pmd = pmd_offset(pud, vaddr);
 		for (; (j < PTRS_PER_PMD) && (vaddr != end); pmd++, j++) {
-			if (pmd_none(*pmd)) {
-				pte = (pte_t *) alloc_bootmem_low_pages(PAGE_SIZE);
-				set_pmd(pmd, __pmd(_KERNPG_TABLE + 
-						   (unsigned long) __pa(pte)));
-				if (pte != pte_offset_kernel(pmd, 0))
-					BUG();
-			}
+			one_page_table_init(pmd);
 			vaddr += PMD_SIZE;
 		}
 		j = 0;

