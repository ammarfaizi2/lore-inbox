Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262071AbVCIWOf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262071AbVCIWOf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 17:14:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262204AbVCIWM7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 17:12:59 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:268 "EHLO
	MTVMIME03.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S262156AbVCIWKK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 17:10:10 -0500
Date: Wed, 9 Mar 2005 22:09:25 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH 5/15] ptwalk: map and unmap_vm_area
In-Reply-To: <Pine.LNX.4.61.0503092201070.6070@goblin.wat.veritas.com>
Message-ID: <Pine.LNX.4.61.0503092208510.6070@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0503092201070.6070@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Convert unmap_vm_area and map_vm_area pagetable walkers to loops using
p?d_addr_end; rename internal levels vunmap_p??_range, vmap_p??_range.
map_vm_area shows the style when allocating: allocs moved down a level.
Replace KERN_CRIT Whee message by boring WARN_ON.

Signed-off-by: Hugh Dickins <hugh@veritas.com>
---

 mm/vmalloc.c |  216 +++++++++++++++++++++--------------------------------------
 1 files changed, 77 insertions(+), 139 deletions(-)

--- ptwalk4/mm/vmalloc.c	2005-03-09 01:35:49.000000000 +0000
+++ ptwalk5/mm/vmalloc.c	2005-03-09 01:36:38.000000000 +0000
@@ -23,199 +23,137 @@
 DEFINE_RWLOCK(vmlist_lock);
 struct vm_struct *vmlist;
 
-static void unmap_area_pte(pmd_t *pmd, unsigned long address,
-				  unsigned long size)
+static void vunmap_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end)
 {
-	unsigned long base, end;
 	pte_t *pte;
 
 	if (pmd_none_or_clear_bad(pmd))
 		return;
 
-	pte = pte_offset_kernel(pmd, address);
-	base = address & PMD_MASK;
-	address &= ~PMD_MASK;
-	end = address + size;
-	if (end > PMD_SIZE)
-		end = PMD_SIZE;
-
+	pte = pte_offset_kernel(pmd, addr);
 	do {
-		pte_t page;
-		page = ptep_get_and_clear(&init_mm, base + address, pte);
-		address += PAGE_SIZE;
-		pte++;
-		if (pte_none(page))
-			continue;
-		if (pte_present(page))
-			continue;
-		printk(KERN_CRIT "Whee.. Swapped out page in kernel page table\n");
-	} while (address < end);
+		pte_t ptent = ptep_get_and_clear(&init_mm, addr, pte);
+		WARN_ON(!pte_none(ptent) && !pte_present(ptent));
+	} while (pte++, addr += PAGE_SIZE, addr != end);
 }
 
-static void unmap_area_pmd(pud_t *pud, unsigned long address,
-				  unsigned long size)
+static void vunmap_pmd_range(pud_t *pud, unsigned long addr, unsigned long end)
 {
-	unsigned long base, end;
 	pmd_t *pmd;
+	unsigned long next;
 
 	if (pud_none_or_clear_bad(pud))
 		return;
 
-	pmd = pmd_offset(pud, address);
-	base = address & PUD_MASK;
-	address &= ~PUD_MASK;
-	end = address + size;
-	if (end > PUD_SIZE)
-		end = PUD_SIZE;
-
+	pmd = pmd_offset(pud, addr);
 	do {
-		unmap_area_pte(pmd, base + address, end - address);
-		address = (address + PMD_SIZE) & PMD_MASK;
-		pmd++;
-	} while (address < end);
+		next = pmd_addr_end(addr, end);
+		vunmap_pte_range(pmd, addr, next);
+	} while (pmd++, addr = next, addr != end);
 }
 
-static void unmap_area_pud(pgd_t *pgd, unsigned long address,
-			   unsigned long size)
+static void vunmap_pud_range(pgd_t *pgd, unsigned long addr, unsigned long end)
 {
 	pud_t *pud;
-	unsigned long base, end;
+	unsigned long next;
 
 	if (pgd_none_or_clear_bad(pgd))
 		return;
 
-	pud = pud_offset(pgd, address);
-	base = address & PGDIR_MASK;
-	address &= ~PGDIR_MASK;
-	end = address + size;
-	if (end > PGDIR_SIZE)
-		end = PGDIR_SIZE;
+	pud = pud_offset(pgd, addr);
+	do {
+		next = pud_addr_end(addr, end);
+		vunmap_pmd_range(pud, addr, next);
+	} while (pud++, addr = next, addr != end);
+}
+
+void unmap_vm_area(struct vm_struct *area)
+{
+	pgd_t *pgd;
+	unsigned long next;
+	unsigned long addr = (unsigned long) area->addr;
+	unsigned long end = addr + area->size;
 
+	BUG_ON(addr >= end);
+	pgd = pgd_offset_k(addr);
+	flush_cache_vunmap(addr, end);
 	do {
-		unmap_area_pmd(pud, base + address, end - address);
-		address = (address + PUD_SIZE) & PUD_MASK;
-		pud++;
-	} while (address && (address < end));
-}
-
-static int map_area_pte(pte_t *pte, unsigned long address,
-			       unsigned long size, pgprot_t prot,
-			       struct page ***pages)
-{
-	unsigned long base, end;
-
-	base = address & PMD_MASK;
-	address &= ~PMD_MASK;
-	end = address + size;
-	if (end > PMD_SIZE)
-		end = PMD_SIZE;
+		next = pgd_addr_end(addr, end);
+		vunmap_pud_range(pgd, addr, next);
+	} while (pgd++, addr = next, addr != end);
+	flush_tlb_kernel_range((unsigned long) area->addr, end);
+}
+
+static int vmap_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end,
+				pgprot_t prot, struct page ***pages)
+{
+	pte_t *pte;
 
+	pte = pte_alloc_kernel(&init_mm, pmd, addr);
+	if (!pte)
+		return -ENOMEM;
 	do {
 		struct page *page = **pages;
 		WARN_ON(!pte_none(*pte));
 		if (!page)
 			return -ENOMEM;
-
-		set_pte_at(&init_mm, base + address, pte, mk_pte(page, prot));
-		address += PAGE_SIZE;
-		pte++;
+		set_pte_at(&init_mm, addr, pte, mk_pte(page, prot));
 		(*pages)++;
-	} while (address < end);
+	} while (pte++, addr += PAGE_SIZE, addr != end);
 	return 0;
 }
 
-static int map_area_pmd(pmd_t *pmd, unsigned long address,
-			       unsigned long size, pgprot_t prot,
-			       struct page ***pages)
-{
-	unsigned long base, end;
-
-	base = address & PUD_MASK;
-	address &= ~PUD_MASK;
-	end = address + size;
-	if (end > PUD_SIZE)
-		end = PUD_SIZE;
+static int vmap_pmd_range(pud_t *pud, unsigned long addr, unsigned long end,
+				pgprot_t prot, struct page ***pages)
+{
+	pmd_t *pmd;
+	unsigned long next;
 
+	pmd = pmd_alloc(&init_mm, pud, addr);
+	if (!pmd)
+		return -ENOMEM;
 	do {
-		pte_t * pte = pte_alloc_kernel(&init_mm, pmd, base + address);
-		if (!pte)
-			return -ENOMEM;
-		if (map_area_pte(pte, base + address, end - address, prot, pages))
+		next = pmd_addr_end(addr, end);
+		if (vmap_pte_range(pmd, addr, next, prot, pages))
 			return -ENOMEM;
-		address = (address + PMD_SIZE) & PMD_MASK;
-		pmd++;
-	} while (address < end);
-
+	} while (pmd++, addr = next, addr != end);
 	return 0;
 }
 
-static int map_area_pud(pud_t *pud, unsigned long address,
-			       unsigned long end, pgprot_t prot,
-			       struct page ***pages)
+static int vmap_pud_range(pgd_t *pgd, unsigned long addr, unsigned long end,
+				pgprot_t prot, struct page ***pages)
 {
+	pud_t *pud;
+	unsigned long next;
+
+	pud = pud_alloc(&init_mm, pgd, addr);
+	if (!pud)
+		return -ENOMEM;
 	do {
-		pmd_t *pmd = pmd_alloc(&init_mm, pud, address);
-		if (!pmd)
+		next = pud_addr_end(addr, end);
+		if (vmap_pmd_range(pud, addr, next, prot, pages))
 			return -ENOMEM;
-		if (map_area_pmd(pmd, address, end - address, prot, pages))
-			return -ENOMEM;
-		address = (address + PUD_SIZE) & PUD_MASK;
-		pud++;
-	} while (address && address < end);
-
+	} while (pud++, addr = next, addr != end);
 	return 0;
 }
 
-void unmap_vm_area(struct vm_struct *area)
-{
-	unsigned long address = (unsigned long) area->addr;
-	unsigned long end = (address + area->size);
-	unsigned long next;
-	pgd_t *pgd;
-	int i;
-
-	pgd = pgd_offset_k(address);
-	flush_cache_vunmap(address, end);
-	for (i = pgd_index(address); i <= pgd_index(end-1); i++) {
-		next = (address + PGDIR_SIZE) & PGDIR_MASK;
-		if (next <= address || next > end)
-			next = end;
-		unmap_area_pud(pgd, address, next - address);
-		address = next;
-	        pgd++;
-	}
-	flush_tlb_kernel_range((unsigned long) area->addr, end);
-}
-
 int map_vm_area(struct vm_struct *area, pgprot_t prot, struct page ***pages)
 {
-	unsigned long address = (unsigned long) area->addr;
-	unsigned long end = address + (area->size-PAGE_SIZE);
-	unsigned long next;
 	pgd_t *pgd;
-	int err = 0;
-	int i;
+	unsigned long next;
+	unsigned long addr = (unsigned long) area->addr;
+	unsigned long end = addr + area->size - PAGE_SIZE;
+	int err;
 
-	pgd = pgd_offset_k(address);
+	BUG_ON(addr >= end);
+	pgd = pgd_offset_k(addr);
 	spin_lock(&init_mm.page_table_lock);
-	for (i = pgd_index(address); i <= pgd_index(end-1); i++) {
-		pud_t *pud = pud_alloc(&init_mm, pgd, address);
-		if (!pud) {
-			err = -ENOMEM;
-			break;
-		}
-		next = (address + PGDIR_SIZE) & PGDIR_MASK;
-		if (next < address || next > end)
-			next = end;
-		if (map_area_pud(pud, address, next, prot, pages)) {
-			err = -ENOMEM;
+	do {
+		next = pgd_addr_end(addr, end);
+		err = vmap_pud_range(pgd, addr, next, prot, pages);
+		if (err)
 			break;
-		}
-
-		address = next;
-		pgd++;
-	}
-
+	} while (pgd++, addr = next, addr != end);
 	spin_unlock(&init_mm.page_table_lock);
 	flush_cache_vmap((unsigned long) area->addr, end);
 	return err;
