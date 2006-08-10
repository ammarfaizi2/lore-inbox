Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161386AbWHJQGn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161386AbWHJQGn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 12:06:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161397AbWHJQGK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 12:06:10 -0400
Received: from nat-132.atmel.no ([80.232.32.132]:43257 "EHLO relay.atmel.no")
	by vger.kernel.org with ESMTP id S1161386AbWHJQFY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 12:05:24 -0400
From: Haavard Skinnemoen <hskinnemoen@atmel.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
       Haavard Skinnemoen <hskinnemoen@atmel.com>, Andi Kleen <ak@suse.de>
Subject: [PATCH 14/14] Generic ioremap_page_range: x86_64 conversion
Reply-To: Haavard Skinnemoen <hskinnemoen@atmel.com>
Date: Thu, 10 Aug 2006 18:03:46 +0200
Message-Id: <1155225827154-git-send-email-hskinnemoen@atmel.com>
X-Mailer: git-send-email 1.4.0
In-Reply-To: <11552258273079-git-send-email-hskinnemoen@atmel.com>
References: <1155225826761-git-send-email-hskinnemoen@atmel.com> <1155225827754-git-send-email-hskinnemoen@atmel.com> <11552258271630-git-send-email-hskinnemoen@atmel.com> <115522582724-git-send-email-hskinnemoen@atmel.com> <11552258272417-git-send-email-hskinnemoen@atmel.com> <11552258273292-git-send-email-hskinnemoen@atmel.com> <11552258272265-git-send-email-hskinnemoen@atmel.com> <11552258271169-git-send-email-hskinnemoen@atmel.com> <11552258273246-git-send-email-hskinnemoen@atmel.com> <11552258271464-git-send-email-hskinnemoen@atmel.com> <11552258272884-git-send-email-hskinnemoen@atmel.com> <11552258273005-git-send-email-hskinnemoen@atmel.com> <11552258273304-git-send-email-hskinnemoen@atmel.com> <11552258273079-git-send-email-hskinnemoen@atmel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@suse.de>

Convert x86_64 to use generic ioremap_page_range()

Signed-off-by: Haavard Skinnemoen <hskinnemoen@atmel.com>
Acked-by: Andi Kleen <ak@suse.de>
---
 arch/x86_64/mm/ioremap.c |  110 +++-------------------------------------------
 1 files changed, 6 insertions(+), 104 deletions(-)

diff --git a/arch/x86_64/mm/ioremap.c b/arch/x86_64/mm/ioremap.c
index 45d7d82..6bb0712 100644
--- a/arch/x86_64/mm/ioremap.c
+++ b/arch/x86_64/mm/ioremap.c
@@ -12,117 +12,15 @@ #include <linux/vmalloc.h>
 #include <linux/init.h>
 #include <linux/slab.h>
 #include <linux/module.h>
-#include <asm/io.h>
+#include <linux/io.h>
 #include <asm/pgalloc.h>
 #include <asm/fixmap.h>
-#include <asm/cacheflush.h>
 #include <asm/tlbflush.h>
 #include <asm/proto.h>
 
 #define ISA_START_ADDRESS      0xa0000
 #define ISA_END_ADDRESS                0x100000
 
-static inline void remap_area_pte(pte_t * pte, unsigned long address, unsigned long size,
-	unsigned long phys_addr, unsigned long flags)
-{
-	unsigned long end;
-	unsigned long pfn;
-
-	address &= ~PMD_MASK;
-	end = address + size;
-	if (end > PMD_SIZE)
-		end = PMD_SIZE;
-	if (address >= end)
-		BUG();
-	pfn = phys_addr >> PAGE_SHIFT;
-	do {
-		if (!pte_none(*pte)) {
-			printk("remap_area_pte: page already exists\n");
-			BUG();
-		}
-		set_pte(pte, pfn_pte(pfn, __pgprot(_PAGE_PRESENT | _PAGE_RW | 
-					_PAGE_GLOBAL | _PAGE_DIRTY | _PAGE_ACCESSED | flags)));
-		address += PAGE_SIZE;
-		pfn++;
-		pte++;
-	} while (address && (address < end));
-}
-
-static inline int remap_area_pmd(pmd_t * pmd, unsigned long address, unsigned long size,
-	unsigned long phys_addr, unsigned long flags)
-{
-	unsigned long end;
-
-	address &= ~PUD_MASK;
-	end = address + size;
-	if (end > PUD_SIZE)
-		end = PUD_SIZE;
-	phys_addr -= address;
-	if (address >= end)
-		BUG();
-	do {
-		pte_t * pte = pte_alloc_kernel(pmd, address);
-		if (!pte)
-			return -ENOMEM;
-		remap_area_pte(pte, address, end - address, address + phys_addr, flags);
-		address = (address + PMD_SIZE) & PMD_MASK;
-		pmd++;
-	} while (address && (address < end));
-	return 0;
-}
-
-static inline int remap_area_pud(pud_t * pud, unsigned long address, unsigned long size,
-	unsigned long phys_addr, unsigned long flags)
-{
-	unsigned long end;
-
-	address &= ~PGDIR_MASK;
-	end = address + size;
-	if (end > PGDIR_SIZE)
-		end = PGDIR_SIZE;
-	phys_addr -= address;
-	if (address >= end)
-		BUG();
-	do {
-		pmd_t * pmd = pmd_alloc(&init_mm, pud, address);
-		if (!pmd)
-			return -ENOMEM;
-		remap_area_pmd(pmd, address, end - address, address + phys_addr, flags);
-		address = (address + PUD_SIZE) & PUD_MASK;
-		pud++;
-	} while (address && (address < end));
-	return 0;
-}
-
-static int remap_area_pages(unsigned long address, unsigned long phys_addr,
-				 unsigned long size, unsigned long flags)
-{
-	int error;
-	pgd_t *pgd;
-	unsigned long end = address + size;
-
-	phys_addr -= address;
-	pgd = pgd_offset_k(address);
-	flush_cache_all();
-	if (address >= end)
-		BUG();
-	do {
-		pud_t *pud;
-		pud = pud_alloc(&init_mm, pgd, address);
-		error = -ENOMEM;
-		if (!pud)
-			break;
-		if (remap_area_pud(pud, address, end - address,
-					 phys_addr + address, flags))
-			break;
-		error = 0;
-		address = (address + PGDIR_SIZE) & PGDIR_MASK;
-		pgd++;
-	} while (address && (address < end));
-	flush_tlb_all();
-	return error;
-}
-
 /*
  * Fix up the linear direct mapping of the kernel to avoid cache attribute
  * conflicts.
@@ -165,6 +63,7 @@ void __iomem * __ioremap(unsigned long p
 	void * addr;
 	struct vm_struct * area;
 	unsigned long offset, last_addr;
+	pgprot_t pgprot;
 
 	/* Don't allow wraparound or zero size */
 	last_addr = phys_addr + size - 1;
@@ -194,6 +93,8 @@ #ifdef CONFIG_FLATMEM
 	}
 #endif
 
+	pgprot = __pgprot(_PAGE_PRESENT | _PAGE_RW | _PAGE_GLOBAL
+			  | _PAGE_DIRTY | _PAGE_ACCESSED | flags);
 	/*
 	 * Mappings have to be page-aligned
 	 */
@@ -209,7 +110,8 @@ #endif
 		return NULL;
 	area->phys_addr = phys_addr;
 	addr = area->addr;
-	if (remap_area_pages((unsigned long) addr, phys_addr, size, flags)) {
+	if (ioremap_page_range((unsigned long)addr, (unsigned long)addr + size,
+			       phys_addr, pgprot)) {
 		remove_vm_area((void *)(PAGE_MASK & (unsigned long) addr));
 		return NULL;
 	}
-- 
1.4.0

