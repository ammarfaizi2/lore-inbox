Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161398AbWHJQIb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161398AbWHJQIb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 12:08:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161378AbWHJQEi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 12:04:38 -0400
Received: from nat-132.atmel.no ([80.232.32.132]:18916 "EHLO relay.atmel.no")
	by vger.kernel.org with ESMTP id S1161360AbWHJQES (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 12:04:18 -0400
From: Haavard Skinnemoen <hskinnemoen@atmel.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
       Haavard Skinnemoen <hskinnemoen@atmel.com>,
       Russell King <rmk@arm.linux.org.uk>
Subject: [PATCH 4/14] Generic ioremap_page_range: arm conversion
Reply-To: Haavard Skinnemoen <hskinnemoen@atmel.com>
Date: Thu, 10 Aug 2006 18:03:36 +0200
Message-Id: <11552258272417-git-send-email-hskinnemoen@atmel.com>
X-Mailer: git-send-email 1.4.0
In-Reply-To: <115522582724-git-send-email-hskinnemoen@atmel.com>
References: <1155225826761-git-send-email-hskinnemoen@atmel.com> <1155225827754-git-send-email-hskinnemoen@atmel.com> <11552258271630-git-send-email-hskinnemoen@atmel.com> <115522582724-git-send-email-hskinnemoen@atmel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Russell King <rmk@arm.linux.org.uk>

Convert ARM to use generic ioremap_page_range()

Signed-off-by: Haavard Skinnemoen <hskinnemoen@atmel.com>
---
 arch/arm/mm/ioremap.c |   95 +++----------------------------------------------
 1 files changed, 5 insertions(+), 90 deletions(-)

diff --git a/arch/arm/mm/ioremap.c b/arch/arm/mm/ioremap.c
index 88a999d..942a1ee 100644
--- a/arch/arm/mm/ioremap.c
+++ b/arch/arm/mm/ioremap.c
@@ -22,11 +22,11 @@
  */
 #include <linux/module.h>
 #include <linux/errno.h>
+#include <linux/io.h>
 #include <linux/mm.h>
 #include <linux/vmalloc.h>
 
 #include <asm/cacheflush.h>
-#include <asm/io.h>
 #include <asm/mmu_context.h>
 #include <asm/pgalloc.h>
 #include <asm/tlbflush.h>
@@ -38,94 +38,6 @@ #include <asm/sizes.h>
  */
 #define VM_ARM_SECTION_MAPPING	0x80000000
 
-static inline void
-remap_area_pte(pte_t * pte, unsigned long address, unsigned long size,
-	       unsigned long phys_addr, pgprot_t pgprot)
-{
-	unsigned long end;
-
-	address &= ~PMD_MASK;
-	end = address + size;
-	if (end > PMD_SIZE)
-		end = PMD_SIZE;
-	BUG_ON(address >= end);
-	do {
-		if (!pte_none(*pte))
-			goto bad;
-
-		set_pte(pte, pfn_pte(phys_addr >> PAGE_SHIFT, pgprot));
-		address += PAGE_SIZE;
-		phys_addr += PAGE_SIZE;
-		pte++;
-	} while (address && (address < end));
-	return;
-
- bad:
-	printk("remap_area_pte: page already exists\n");
-	BUG();
-}
-
-static inline int
-remap_area_pmd(pmd_t * pmd, unsigned long address, unsigned long size,
-	       unsigned long phys_addr, unsigned long flags)
-{
-	unsigned long end;
-	pgprot_t pgprot;
-
-	address &= ~PGDIR_MASK;
-	end = address + size;
-
-	if (end > PGDIR_SIZE)
-		end = PGDIR_SIZE;
-
-	phys_addr -= address;
-	BUG_ON(address >= end);
-
-	pgprot = __pgprot(L_PTE_PRESENT | L_PTE_YOUNG | L_PTE_DIRTY | L_PTE_WRITE | flags);
-	do {
-		pte_t * pte = pte_alloc_kernel(pmd, address);
-		if (!pte)
-			return -ENOMEM;
-		remap_area_pte(pte, address, end - address, address + phys_addr, pgprot);
-		address = (address + PMD_SIZE) & PMD_MASK;
-		pmd++;
-	} while (address && (address < end));
-	return 0;
-}
-
-static int
-remap_area_pages(unsigned long start, unsigned long pfn,
-		 unsigned long size, unsigned long flags)
-{
-	unsigned long address = start;
-	unsigned long end = start + size;
-	unsigned long phys_addr = __pfn_to_phys(pfn);
-	int err = 0;
-	pgd_t * dir;
-
-	phys_addr -= address;
-	dir = pgd_offset(&init_mm, address);
-	BUG_ON(address >= end);
-	do {
-		pmd_t *pmd = pmd_alloc(&init_mm, dir, address);
-		if (!pmd) {
-			err = -ENOMEM;
-			break;
-		}
-		if (remap_area_pmd(pmd, address, end - address,
-					 phys_addr + address, flags)) {
-			err = -ENOMEM;
-			break;
-		}
-
-		address = (address + PGDIR_SIZE) & PGDIR_MASK;
-		dir++;
-	} while (address && (address < end));
-
-	return err;
-}
-
-
 void __check_kvm_seq(struct mm_struct *mm)
 {
 	unsigned int seq;
@@ -326,7 +238,10 @@ #ifndef CONFIG_SMP
 		err = remap_area_sections(addr, pfn, size, flags);
 	} else
 #endif
-		err = remap_area_pages(addr, pfn, size, flags);
+		err = ioremap_page_range(addr, addr + size, pfn << PAGE_SHIFT,
+					 __pgprot(L_PTE_PRESENT | L_PTE_YOUNG
+						  | L_PTE_DIRTY | L_PTE_WRITE
+						  | flags));
 
 	if (err) {
  		vunmap((void *)addr);
-- 
1.4.0

