Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262497AbVCIWj4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262497AbVCIWj4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 17:39:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262392AbVCIWiR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 17:38:17 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:43567 "EHLO
	MTVMIME03.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S262416AbVCIWMO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 17:12:14 -0500
Date: Wed, 9 Mar 2005 22:11:23 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH 8/15] ptwalk: zeromap_page_range
In-Reply-To: <Pine.LNX.4.61.0503092201070.6070@goblin.wat.veritas.com>
Message-ID: <Pine.LNX.4.61.0503092210480.6070@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0503092201070.6070@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Convert zeromap_page_range pagetable walkers to loops using p?d_addr_end.
Remove the redundant flush_tlb_range from afterwards: as its comment
noted, there's already a BUG_ON(!pte_none).

Signed-off-by: Hugh Dickins <hugh@veritas.com>
---

 mm/memory.c |  143 ++++++++++++++++++++++--------------------------------------
 1 files changed, 54 insertions(+), 89 deletions(-)

--- ptwalk7/mm/memory.c	2005-03-09 01:37:02.000000000 +0000
+++ ptwalk8/mm/memory.c	2005-03-09 01:37:15.000000000 +0000
@@ -975,113 +975,78 @@ out:
 
 EXPORT_SYMBOL(get_user_pages);
 
-static void zeromap_pte_range(struct mm_struct *mm, pte_t * pte,
-			      unsigned long address,
-			      unsigned long size, pgprot_t prot)
-{
-	unsigned long base, end;
-
-	base = address & PMD_MASK;
-	address &= ~PMD_MASK;
-	end = address + size;
-	if (end > PMD_SIZE)
-		end = PMD_SIZE;
+static int zeromap_pte_range(struct mm_struct *mm, pmd_t *pmd,
+			unsigned long addr, unsigned long end, pgprot_t prot)
+{
+	pte_t *pte;
+
+	pte = pte_alloc_map(mm, pmd, addr);
+	if (!pte)
+		return -ENOMEM;
 	do {
-		pte_t zero_pte = pte_wrprotect(mk_pte(ZERO_PAGE(base+address), prot));
+		pte_t zero_pte = pte_wrprotect(mk_pte(ZERO_PAGE(addr), prot));
 		BUG_ON(!pte_none(*pte));
-		set_pte_at(mm, base+address, pte, zero_pte);
-		address += PAGE_SIZE;
-		pte++;
-	} while (address && (address < end));
-}
-
-static inline int zeromap_pmd_range(struct mm_struct *mm, pmd_t * pmd,
-		unsigned long address, unsigned long size, pgprot_t prot)
-{
-	unsigned long base, end;
-
-	base = address & PUD_MASK;
-	address &= ~PUD_MASK;
-	end = address + size;
-	if (end > PUD_SIZE)
-		end = PUD_SIZE;
+		set_pte_at(mm, addr, pte, zero_pte);
+	} while (pte++, addr += PAGE_SIZE, addr != end);
+	pte_unmap(pte - 1);
+	return 0;
+}
+
+static inline int zeromap_pmd_range(struct mm_struct *mm, pud_t *pud,
+			unsigned long addr, unsigned long end, pgprot_t prot)
+{
+	pmd_t *pmd;
+	unsigned long next;
+
+	pmd = pmd_alloc(mm, pud, addr);
+	if (!pmd)
+		return -ENOMEM;
 	do {
-		pte_t * pte = pte_alloc_map(mm, pmd, base + address);
-		if (!pte)
+		next = pmd_addr_end(addr, end);
+		if (zeromap_pte_range(mm, pmd, addr, next, prot))
 			return -ENOMEM;
-		zeromap_pte_range(mm, pte, base + address, end - address, prot);
-		pte_unmap(pte);
-		address = (address + PMD_SIZE) & PMD_MASK;
-		pmd++;
-	} while (address && (address < end));
+	} while (pmd++, addr = next, addr != end);
 	return 0;
 }
 
-static inline int zeromap_pud_range(struct mm_struct *mm, pud_t * pud,
-				    unsigned long address,
-                                    unsigned long size, pgprot_t prot)
-{
-	unsigned long base, end;
-	int error = 0;
-
-	base = address & PGDIR_MASK;
-	address &= ~PGDIR_MASK;
-	end = address + size;
-	if (end > PGDIR_SIZE)
-		end = PGDIR_SIZE;
+static inline int zeromap_pud_range(struct mm_struct *mm, pgd_t *pgd,
+			unsigned long addr, unsigned long end, pgprot_t prot)
+{
+	pud_t *pud;
+	unsigned long next;
+
+	pud = pud_alloc(mm, pgd, addr);
+	if (!pud)
+		return -ENOMEM;
 	do {
-		pmd_t * pmd = pmd_alloc(mm, pud, base + address);
-		error = -ENOMEM;
-		if (!pmd)
-			break;
-		error = zeromap_pmd_range(mm, pmd, base + address,
-					  end - address, prot);
-		if (error)
-			break;
-		address = (address + PUD_SIZE) & PUD_MASK;
-		pud++;
-	} while (address && (address < end));
+		next = pud_addr_end(addr, end);
+		if (zeromap_pmd_range(mm, pud, addr, next, prot))
+			return -ENOMEM;
+	} while (pud++, addr = next, addr != end);
 	return 0;
 }
 
-int zeromap_page_range(struct vm_area_struct *vma, unsigned long address,
-					unsigned long size, pgprot_t prot)
+int zeromap_page_range(struct vm_area_struct *vma,
+			unsigned long addr, unsigned long size, pgprot_t prot)
 {
-	int i;
-	int error = 0;
-	pgd_t * pgd;
-	unsigned long beg = address;
-	unsigned long end = address + size;
+	pgd_t *pgd;
 	unsigned long next;
+	unsigned long end = addr + size;
 	struct mm_struct *mm = vma->vm_mm;
+	int err;
 
-	pgd = pgd_offset(mm, address);
-	flush_cache_range(vma, beg, end);
-	BUG_ON(address >= end);
-	BUG_ON(end > vma->vm_end);
-
+	BUG_ON(addr >= end);
+	pgd = pgd_offset(mm, addr);
+	flush_cache_range(vma, addr, end);
 	spin_lock(&mm->page_table_lock);
-	for (i = pgd_index(address); i <= pgd_index(end-1); i++) {
-		pud_t *pud = pud_alloc(mm, pgd, address);
-		error = -ENOMEM;
-		if (!pud)
-			break;
-		next = (address + PGDIR_SIZE) & PGDIR_MASK;
-		if (next <= beg || next > end)
-			next = end;
-		error = zeromap_pud_range(mm, pud, address,
-						next - address, prot);
-		if (error)
+	do {
+		next = pgd_addr_end(addr, end);
+		err = zeromap_pud_range(mm, pgd, addr, next, prot);
+		if (err)
 			break;
-		address = next;
-		pgd++;
-	}
-	/*
-	 * Why flush? zeromap_pte_range has a BUG_ON for !pte_none()
-	 */
-	flush_tlb_range(vma, beg, end);
+	} while (pgd++, addr = next, addr != end);
 	spin_unlock(&mm->page_table_lock);
-	return error;
+	return err;
 }
 
 /*
