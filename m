Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161364AbWHJQHl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161364AbWHJQHl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 12:07:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161391AbWHJQFT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 12:05:19 -0400
Received: from nat-132.atmel.no ([80.232.32.132]:462 "EHLO relay.atmel.no")
	by vger.kernel.org with ESMTP id S1161383AbWHJQFN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 12:05:13 -0400
From: Haavard Skinnemoen <hskinnemoen@atmel.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
       Haavard Skinnemoen <hskinnemoen@atmel.com>, Andi Kleen <ak@suse.de>
Subject: [PATCH 7/14] Generic ioremap_page_range: i386 conversion
Reply-To: Haavard Skinnemoen <hskinnemoen@atmel.com>
Date: Thu, 10 Aug 2006 18:03:39 +0200
Message-Id: <11552258271169-git-send-email-hskinnemoen@atmel.com>
X-Mailer: git-send-email 1.4.0
In-Reply-To: <11552258272265-git-send-email-hskinnemoen@atmel.com>
References: <1155225826761-git-send-email-hskinnemoen@atmel.com> <1155225827754-git-send-email-hskinnemoen@atmel.com> <11552258271630-git-send-email-hskinnemoen@atmel.com> <115522582724-git-send-email-hskinnemoen@atmel.com> <11552258272417-git-send-email-hskinnemoen@atmel.com> <11552258273292-git-send-email-hskinnemoen@atmel.com> <11552258272265-git-send-email-hskinnemoen@atmel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@suse.de>

Convert i386 to use generic ioremap_page_range()

Signed-off-by: Haavard Skinnemoen <hskinnemoen@atmel.com>
Acked-by: Andi Kleen <ak@suse.de>
---
 arch/i386/mm/ioremap.c |   85 +++---------------------------------------------
 1 files changed, 6 insertions(+), 79 deletions(-)

diff --git a/arch/i386/mm/ioremap.c b/arch/i386/mm/ioremap.c
index 247fde7..f773126 100644
--- a/arch/i386/mm/ioremap.c
+++ b/arch/i386/mm/ioremap.c
@@ -12,91 +12,14 @@ #include <linux/vmalloc.h>
 #include <linux/init.h>
 #include <linux/slab.h>
 #include <linux/module.h>
-#include <asm/io.h>
+#include <linux/io.h>
 #include <asm/fixmap.h>
-#include <asm/cacheflush.h>
 #include <asm/tlbflush.h>
 #include <asm/pgtable.h>
 
 #define ISA_START_ADDRESS	0xa0000
 #define ISA_END_ADDRESS		0x100000
 
-static int ioremap_pte_range(pmd_t *pmd, unsigned long addr,
-		unsigned long end, unsigned long phys_addr, unsigned long flags)
-{
-	pte_t *pte;
-	unsigned long pfn;
-
-	pfn = phys_addr >> PAGE_SHIFT;
-	pte = pte_alloc_kernel(pmd, addr);
-	if (!pte)
-		return -ENOMEM;
-	do {
-		BUG_ON(!pte_none(*pte));
-		set_pte(pte, pfn_pte(pfn, __pgprot(_PAGE_PRESENT | _PAGE_RW | 
-					_PAGE_DIRTY | _PAGE_ACCESSED | flags)));
-		pfn++;
-	} while (pte++, addr += PAGE_SIZE, addr != end);
-	return 0;
-}
-
-static inline int ioremap_pmd_range(pud_t *pud, unsigned long addr,
-		unsigned long end, unsigned long phys_addr, unsigned long flags)
-{
-	pmd_t *pmd;
-	unsigned long next;
-
-	phys_addr -= addr;
-	pmd = pmd_alloc(&init_mm, pud, addr);
-	if (!pmd)
-		return -ENOMEM;
-	do {
-		next = pmd_addr_end(addr, end);
-		if (ioremap_pte_range(pmd, addr, next, phys_addr + addr, flags))
-			return -ENOMEM;
-	} while (pmd++, addr = next, addr != end);
-	return 0;
-}
-
-static inline int ioremap_pud_range(pgd_t *pgd, unsigned long addr,
-		unsigned long end, unsigned long phys_addr, unsigned long flags)
-{
-	pud_t *pud;
-	unsigned long next;
-
-	phys_addr -= addr;
-	pud = pud_alloc(&init_mm, pgd, addr);
-	if (!pud)
-		return -ENOMEM;
-	do {
-		next = pud_addr_end(addr, end);
-		if (ioremap_pmd_range(pud, addr, next, phys_addr + addr, flags))
-			return -ENOMEM;
-	} while (pud++, addr = next, addr != end);
-	return 0;
-}
-
-static int ioremap_page_range(unsigned long addr,
-		unsigned long end, unsigned long phys_addr, unsigned long flags)
-{
-	pgd_t *pgd;
-	unsigned long next;
-	int err;
-
-	BUG_ON(addr >= end);
-	flush_cache_all();
-	phys_addr -= addr;
-	pgd = pgd_offset_k(addr);
-	do {
-		next = pgd_addr_end(addr, end);
-		err = ioremap_pud_range(pgd, addr, next, phys_addr+addr, flags);
-		if (err)
-			break;
-	} while (pgd++, addr = next, addr != end);
-	flush_tlb_all();
-	return err;
-}
-
 /*
  * Generic mapping function (not visible outside):
  */
@@ -115,6 +38,7 @@ void __iomem * __ioremap(unsigned long p
 	void __iomem * addr;
 	struct vm_struct * area;
 	unsigned long offset, last_addr;
+	pgprot_t prot;
 
 	/* Don't allow wraparound or zero size */
 	last_addr = phys_addr + size - 1;
@@ -142,6 +66,9 @@ void __iomem * __ioremap(unsigned long p
 				return NULL;
 	}
 
+	prot = __pgprot(_PAGE_PRESENT | _PAGE_RW | _PAGE_DIRTY
+			| _PAGE_ACCESSED | flags);
+
 	/*
 	 * Mappings have to be page-aligned
 	 */
@@ -158,7 +85,7 @@ void __iomem * __ioremap(unsigned long p
 	area->phys_addr = phys_addr;
 	addr = (void __iomem *) area->addr;
 	if (ioremap_page_range((unsigned long) addr,
-			(unsigned long) addr + size, phys_addr, flags)) {
+			(unsigned long) addr + size, phys_addr, prot)) {
 		vunmap((void __force *) addr);
 		return NULL;
 	}
-- 
1.4.0

