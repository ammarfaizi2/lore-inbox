Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262433AbVCIWZ0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262433AbVCIWZ0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 17:25:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262086AbVCIWWw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 17:22:52 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:47895 "EHLO
	MTVMIME03.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S262243AbVCIWKt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 17:10:49 -0500
Date: Wed, 9 Mar 2005 22:10:05 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH 6/15] ptwalk: ioremap_page_range
In-Reply-To: <Pine.LNX.4.61.0503092201070.6070@goblin.wat.veritas.com>
Message-ID: <Pine.LNX.4.61.0503092209300.6070@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0503092201070.6070@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Convert i386 ioremap pagetable walkers to loops using p?d_addr_end.
Rename internal levels ioremap_p??_range.  Don't cheat, give it a real
(but inlined) ioremap_pud_range; uninline lowest level to help debug.
Replace "page already exists" printk and BUG by BUG_ON.

Signed-off-by: Hugh Dickins <hugh@veritas.com>
---

 arch/i386/mm/ioremap.c |  112 +++++++++++++++++++++++--------------------------
 1 files changed, 53 insertions(+), 59 deletions(-)

--- ptwalk5/arch/i386/mm/ioremap.c	2005-03-09 01:12:39.000000000 +0000
+++ ptwalk6/arch/i386/mm/ioremap.c	2005-03-09 01:36:51.000000000 +0000
@@ -20,89 +20,82 @@
 #define ISA_START_ADDRESS	0xa0000
 #define ISA_END_ADDRESS		0x100000
 
-static inline void remap_area_pte(pte_t * pte, unsigned long address, unsigned long size,
-	unsigned long phys_addr, unsigned long flags)
+static int ioremap_pte_range(pmd_t *pmd, unsigned long addr,
+		unsigned long end, unsigned long phys_addr, unsigned long flags)
 {
-	unsigned long end;
+	pte_t *pte;
 	unsigned long pfn;
 
-	address &= ~PMD_MASK;
-	end = address + size;
-	if (end > PMD_SIZE)
-		end = PMD_SIZE;
-	if (address >= end)
-		BUG();
 	pfn = phys_addr >> PAGE_SHIFT;
+	pte = pte_alloc_kernel(&init_mm, pmd, addr);
+	if (!pte)
+		return -ENOMEM;
 	do {
-		if (!pte_none(*pte)) {
-			printk("remap_area_pte: page already exists\n");
-			BUG();
-		}
+		BUG_ON(!pte_none(*pte));
 		set_pte(pte, pfn_pte(pfn, __pgprot(_PAGE_PRESENT | _PAGE_RW | 
 					_PAGE_DIRTY | _PAGE_ACCESSED | flags)));
-		address += PAGE_SIZE;
 		pfn++;
-		pte++;
-	} while (address && (address < end));
+	} while (pte++, addr += PAGE_SIZE, addr != end);
+	return 0;
 }
 
-static inline int remap_area_pmd(pmd_t * pmd, unsigned long address, unsigned long size,
-	unsigned long phys_addr, unsigned long flags)
+static inline int ioremap_pmd_range(pud_t *pud, unsigned long addr,
+		unsigned long end, unsigned long phys_addr, unsigned long flags)
 {
-	unsigned long end;
+	pmd_t *pmd;
+	unsigned long next;
 
-	address &= ~PGDIR_MASK;
-	end = address + size;
-	if (end > PGDIR_SIZE)
-		end = PGDIR_SIZE;
-	phys_addr -= address;
-	if (address >= end)
-		BUG();
+	phys_addr -= addr;
+	pmd = pmd_alloc(&init_mm, pud, addr);
+	if (!pmd)
+		return -ENOMEM;
 	do {
-		pte_t * pte = pte_alloc_kernel(&init_mm, pmd, address);
-		if (!pte)
+		next = pmd_addr_end(addr, end);
+		if (ioremap_pte_range(pmd, addr, next, phys_addr + addr, flags))
 			return -ENOMEM;
-		remap_area_pte(pte, address, end - address, address + phys_addr, flags);
-		address = (address + PMD_SIZE) & PMD_MASK;
-		pmd++;
-	} while (address && (address < end));
+	} while (pmd++, addr = next, addr != end);
 	return 0;
 }
 
-static int remap_area_pages(unsigned long address, unsigned long phys_addr,
-				 unsigned long size, unsigned long flags)
+static inline int ioremap_pud_range(pgd_t *pgd, unsigned long addr,
+		unsigned long end, unsigned long phys_addr, unsigned long flags)
 {
-	int error;
-	pgd_t * dir;
-	unsigned long end = address + size;
+	pud_t *pud;
+	unsigned long next;
 
-	phys_addr -= address;
-	dir = pgd_offset(&init_mm, address);
+	phys_addr -= addr;
+	pud = pud_alloc(&init_mm, pgd, addr);
+	if (!pud)
+		return -ENOMEM;
+	do {
+		next = pud_addr_end(addr, end);
+		if (ioremap_pmd_range(pud, addr, next, phys_addr + addr, flags))
+			return -ENOMEM;
+	} while (pud++, addr = next, addr != end);
+	return 0;
+}
+
+static int ioremap_page_range(unsigned long addr,
+		unsigned long end, unsigned long phys_addr, unsigned long flags)
+{
+	pgd_t *pgd;
+	unsigned long next;
+	int err;
+
+	BUG_ON(addr >= end);
 	flush_cache_all();
-	if (address >= end)
-		BUG();
+	phys_addr -= addr;
+	pgd = pgd_offset_k(addr);
 	spin_lock(&init_mm.page_table_lock);
 	do {
-		pud_t *pud;
-		pmd_t *pmd;
-		
-		error = -ENOMEM;
-		pud = pud_alloc(&init_mm, dir, address);
-		if (!pud)
-			break;
-		pmd = pmd_alloc(&init_mm, pud, address);
-		if (!pmd)
-			break;
-		if (remap_area_pmd(pmd, address, end - address,
-					 phys_addr + address, flags))
+		next = pgd_addr_end(addr, end);
+		err = ioremap_pud_range(pgd, addr, next, phys_addr+addr, flags);
+		if (err)
 			break;
-		error = 0;
-		address = (address + PGDIR_SIZE) & PGDIR_MASK;
-		dir++;
-	} while (address && (address < end));
+	} while (pgd++, addr = next, addr != end);
 	spin_unlock(&init_mm.page_table_lock);
 	flush_tlb_all();
-	return error;
+	return err;
 }
 
 /*
@@ -165,7 +158,8 @@ void __iomem * __ioremap(unsigned long p
 		return NULL;
 	area->phys_addr = phys_addr;
 	addr = (void __iomem *) area->addr;
-	if (remap_area_pages((unsigned long) addr, phys_addr, size, flags)) {
+	if (ioremap_page_range((unsigned long) addr,
+			(unsigned long) addr + size, phys_addr, flags)) {
 		vunmap((void __force *) addr);
 		return NULL;
 	}
