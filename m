Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161393AbWHJQHW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161393AbWHJQHW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 12:07:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161400AbWHJQGq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 12:06:46 -0400
Received: from nat-132.atmel.no ([80.232.32.132]:30924 "EHLO relay.atmel.no")
	by vger.kernel.org with ESMTP id S1161389AbWHJQFX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 12:05:23 -0400
From: Haavard Skinnemoen <hskinnemoen@atmel.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
       Haavard Skinnemoen <hskinnemoen@atmel.com>,
       Paul Mundt <lethal@linux-sh.org>
Subject: [PATCH 12/14] Generic ioremap_page_range: sh conversion
Reply-To: Haavard Skinnemoen <hskinnemoen@atmel.com>
Date: Thu, 10 Aug 2006 18:03:44 +0200
Message-Id: <11552258273304-git-send-email-hskinnemoen@atmel.com>
X-Mailer: git-send-email 1.4.0
In-Reply-To: <11552258273005-git-send-email-hskinnemoen@atmel.com>
References: <1155225826761-git-send-email-hskinnemoen@atmel.com> <1155225827754-git-send-email-hskinnemoen@atmel.com> <11552258271630-git-send-email-hskinnemoen@atmel.com> <115522582724-git-send-email-hskinnemoen@atmel.com> <11552258272417-git-send-email-hskinnemoen@atmel.com> <11552258273292-git-send-email-hskinnemoen@atmel.com> <11552258272265-git-send-email-hskinnemoen@atmel.com> <11552258271169-git-send-email-hskinnemoen@atmel.com> <11552258273246-git-send-email-hskinnemoen@atmel.com> <11552258271464-git-send-email-hskinnemoen@atmel.com> <11552258272884-git-send-email-hskinnemoen@atmel.com> <11552258273005-git-send-email-hskinnemoen@atmel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paul Mundt <lethal@linux-sh.org>

Convert SH to use generic ioremap_page_range()

Signed-off-by: Haavard Skinnemoen <hskinnemoen@atmel.com>
---
 arch/sh/mm/ioremap.c |   97 ++++----------------------------------------------
 1 files changed, 7 insertions(+), 90 deletions(-)

diff --git a/arch/sh/mm/ioremap.c b/arch/sh/mm/ioremap.c
index 96fa4a9..5ef9245 100644
--- a/arch/sh/mm/ioremap.c
+++ b/arch/sh/mm/ioremap.c
@@ -15,98 +15,10 @@
 #include <linux/vmalloc.h>
 #include <linux/module.h>
 #include <linux/mm.h>
-#include <asm/io.h>
+#include <linux/io.h>
 #include <asm/page.h>
 #include <asm/pgalloc.h>
 #include <asm/addrspace.h>
-#include <asm/cacheflush.h>
-#include <asm/tlbflush.h>
-
-static inline void remap_area_pte(pte_t * pte, unsigned long address,
-	unsigned long size, unsigned long phys_addr, unsigned long flags)
-{
-	unsigned long end;
-	unsigned long pfn;
-	pgprot_t pgprot = __pgprot(_PAGE_PRESENT | _PAGE_RW |
-				   _PAGE_DIRTY | _PAGE_ACCESSED |
-				   _PAGE_HW_SHARED | _PAGE_FLAGS_HARD | flags);
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
-		set_pte(pte, pfn_pte(pfn, pgprot));
-		address += PAGE_SIZE;
-		pfn++;
-		pte++;
-	} while (address && (address < end));
-}
-
-static inline int remap_area_pmd(pmd_t * pmd, unsigned long address,
-	unsigned long size, unsigned long phys_addr, unsigned long flags)
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
-int remap_area_pages(unsigned long address, unsigned long phys_addr,
-		     unsigned long size, unsigned long flags)
-{
-	int error;
-	pgd_t * dir;
-	unsigned long end = address + size;
-
-	phys_addr -= address;
-	dir = pgd_offset_k(address);
-	flush_cache_all();
-	if (address >= end)
-		BUG();
-	do {
-		pud_t *pud;
-		pmd_t *pmd;
-
-		error = -ENOMEM;
-
-		pud = pud_alloc(&init_mm, dir, address);
-		if (!pud)
-			break;
-		pmd = pmd_alloc(&init_mm, pud, address);
-		if (!pmd)
-			break;
-		if (remap_area_pmd(pmd, address, end - address,
-					phys_addr + address, flags))
-			break;
-		error = 0;
-		address = (address + PGDIR_SIZE) & PGDIR_MASK;
-		dir++;
-	} while (address && (address < end));
-	flush_tlb_all();
-	return error;
-}
 
 /*
  * Remap an arbitrary physical address space into the kernel virtual
@@ -122,6 +34,7 @@ void __iomem *__ioremap(unsigned long ph
 {
 	struct vm_struct * area;
 	unsigned long offset, last_addr, addr, orig_addr;
+	pgprot_t pgprot;
 
 	/* Don't allow wraparound or zero size */
 	last_addr = phys_addr + size - 1;
@@ -177,8 +90,12 @@ #ifdef CONFIG_32BIT
 	}
 #endif
 
+	pgprot = __pgprot(_PAGE_PRESENT | _PAGE_RW |
+			  _PAGE_DIRTY | _PAGE_ACCESSED |
+			  _PAGE_HW_SHARED | _PAGE_FLAGS_HARD | flags);
+
 	if (likely(size))
-		if (remap_area_pages(addr, phys_addr, size, flags)) {
+		if (ioremap_page_range(addr, addr + size, phys_addr, pgprot)) {
 			vunmap((void *)orig_addr);
 			return NULL;
 		}
-- 
1.4.0

