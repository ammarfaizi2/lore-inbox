Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262084AbVCIWfc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262084AbVCIWfc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 17:35:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262293AbVCIWd3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 17:33:29 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:61473 "EHLO
	MTVMIME01.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S262393AbVCIWLb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 17:11:31 -0500
Date: Wed, 9 Mar 2005 22:10:44 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH 7/15] ptwalk: remap_pfn_range
In-Reply-To: <Pine.LNX.4.61.0503092201070.6070@goblin.wat.veritas.com>
Message-ID: <Pine.LNX.4.61.0503092210090.6070@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0503092201070.6070@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Convert remap_pfn_range pagetable walkers to loops using p?d_addr_end.
Remove the redundant flush_tlb_range from afterwards: as its comment
noted, there's already a BUG_ON(!pte_none).

Signed-off-by: Hugh Dickins <hugh@veritas.com>
---

 mm/memory.c |  151 +++++++++++++++++++++++-------------------------------------
 1 files changed, 59 insertions(+), 92 deletions(-)

--- ptwalk6/mm/memory.c	2005-03-09 01:35:49.000000000 +0000
+++ ptwalk7/mm/memory.c	2005-03-09 01:37:02.000000000 +0000
@@ -1089,97 +1089,74 @@ int zeromap_page_range(struct vm_area_st
  * mappings are removed. any references to nonexistent pages results
  * in null mappings (currently treated as "copy-on-access")
  */
-static inline void
-remap_pte_range(struct mm_struct *mm, pte_t * pte,
-		unsigned long address, unsigned long size,
-		unsigned long pfn, pgprot_t prot)
-{
-	unsigned long base, end;
-
-	base = address & PMD_MASK;
-	address &= ~PMD_MASK;
-	end = address + size;
-	if (end > PMD_SIZE)
-		end = PMD_SIZE;
+static inline int remap_pte_range(struct mm_struct *mm, pmd_t *pmd,
+			unsigned long addr, unsigned long end,
+			unsigned long pfn, pgprot_t prot)
+{
+	pte_t *pte;
+
+	pte = pte_alloc_map(mm, pmd, addr);
+	if (!pte)
+		return -ENOMEM;
 	do {
 		BUG_ON(!pte_none(*pte));
 		if (!pfn_valid(pfn) || PageReserved(pfn_to_page(pfn)))
-			set_pte_at(mm, base+address, pte, pfn_pte(pfn, prot));
-		address += PAGE_SIZE;
+			set_pte_at(mm, addr, pte, pfn_pte(pfn, prot));
 		pfn++;
-		pte++;
-	} while (address && (address < end));
+	} while (pte++, addr += PAGE_SIZE, addr != end);
+	pte_unmap(pte - 1);
+	return 0;
 }
 
-static inline int
-remap_pmd_range(struct mm_struct *mm, pmd_t * pmd, unsigned long address,
-		unsigned long size, unsigned long pfn, pgprot_t prot)
-{
-	unsigned long base, end;
-
-	base = address & PUD_MASK;
-	address &= ~PUD_MASK;
-	end = address + size;
-	if (end > PUD_SIZE)
-		end = PUD_SIZE;
-	pfn -= (address >> PAGE_SHIFT);
+static inline int remap_pmd_range(struct mm_struct *mm, pud_t *pud,
+			unsigned long addr, unsigned long end,
+			unsigned long pfn, pgprot_t prot)
+{
+	pmd_t *pmd;
+	unsigned long next;
+
+	pfn -= addr >> PAGE_SHIFT;
+	pmd = pmd_alloc(mm, pud, addr);
+	if (!pmd)
+		return -ENOMEM;
 	do {
-		pte_t * pte = pte_alloc_map(mm, pmd, base + address);
-		if (!pte)
+		next = pmd_addr_end(addr, end);
+		if (remap_pte_range(mm, pmd, addr, next,
+				pfn + (addr >> PAGE_SHIFT), prot))
 			return -ENOMEM;
-		remap_pte_range(mm, pte, base + address, end - address,
-				(address >> PAGE_SHIFT) + pfn, prot);
-		pte_unmap(pte);
-		address = (address + PMD_SIZE) & PMD_MASK;
-		pmd++;
-	} while (address && (address < end));
+	} while (pmd++, addr = next, addr != end);
 	return 0;
 }
 
-static inline int remap_pud_range(struct mm_struct *mm, pud_t * pud,
-				  unsigned long address, unsigned long size,
-				  unsigned long pfn, pgprot_t prot)
-{
-	unsigned long base, end;
-	int error;
-
-	base = address & PGDIR_MASK;
-	address &= ~PGDIR_MASK;
-	end = address + size;
-	if (end > PGDIR_SIZE)
-		end = PGDIR_SIZE;
-	pfn -= address >> PAGE_SHIFT;
+static inline int remap_pud_range(struct mm_struct *mm, pgd_t *pgd,
+			unsigned long addr, unsigned long end,
+			unsigned long pfn, pgprot_t prot)
+{
+	pud_t *pud;
+	unsigned long next;
+
+	pfn -= addr >> PAGE_SHIFT;
+	pud = pud_alloc(mm, pgd, addr);
+	if (!pud)
+		return -ENOMEM;
 	do {
-		pmd_t *pmd = pmd_alloc(mm, pud, base+address);
-		error = -ENOMEM;
-		if (!pmd)
-			break;
-		error = remap_pmd_range(mm, pmd, base + address, end - address,
-				(address >> PAGE_SHIFT) + pfn, prot);
-		if (error)
-			break;
-		address = (address + PUD_SIZE) & PUD_MASK;
-		pud++;
-	} while (address && (address < end));
-	return error;
+		next = pud_addr_end(addr, end);
+		if (remap_pmd_range(mm, pud, addr, next,
+				pfn + (addr >> PAGE_SHIFT), prot))
+			return -ENOMEM;
+	} while (pud++, addr = next, addr != end);
+	return 0;
 }
 
 /*  Note: this is only safe if the mm semaphore is held when called. */
-int remap_pfn_range(struct vm_area_struct *vma, unsigned long from,
+int remap_pfn_range(struct vm_area_struct *vma, unsigned long addr,
 		    unsigned long pfn, unsigned long size, pgprot_t prot)
 {
-	int error = 0;
 	pgd_t *pgd;
-	unsigned long beg = from;
-	unsigned long end = from + size;
 	unsigned long next;
+	unsigned long end = addr + size;
 	struct mm_struct *mm = vma->vm_mm;
-	int i;
-
-	pfn -= from >> PAGE_SHIFT;
-	pgd = pgd_offset(mm, from);
-	flush_cache_range(vma, beg, end);
-	BUG_ON(from >= end);
+	int err;
 
 	/*
 	 * Physically remapped pages are special. Tell the
@@ -1191,31 +1168,21 @@ int remap_pfn_range(struct vm_area_struc
 	 */
 	vma->vm_flags |= VM_IO | VM_RESERVED;
 
+	BUG_ON(addr >= end);
+	pfn -= addr >> PAGE_SHIFT;
+	pgd = pgd_offset(mm, addr);
+	flush_cache_range(vma, addr, end);
 	spin_lock(&mm->page_table_lock);
-	for (i = pgd_index(beg); i <= pgd_index(end-1); i++) {
-		pud_t *pud = pud_alloc(mm, pgd, from);
-		error = -ENOMEM;
-		if (!pud)
-			break;
-		next = (from + PGDIR_SIZE) & PGDIR_MASK;
-		if (next > end || next <= from)
-			next = end;
-		error = remap_pud_range(mm, pud, from, end - from,
-					pfn + (from >> PAGE_SHIFT), prot);
-		if (error)
+	do {
+		next = pgd_addr_end(addr, end);
+		err = remap_pud_range(mm, pgd, addr, next,
+				pfn + (addr >> PAGE_SHIFT), prot);
+		if (err)
 			break;
-		from = next;
-		pgd++;
-	}
-	/*
-	 * Why flush? remap_pte_range has a BUG_ON for !pte_none()
-	 */
-	flush_tlb_range(vma, beg, end);
+	} while (pgd++, addr = next, addr != end);
 	spin_unlock(&mm->page_table_lock);
-
-	return error;
+	return err;
 }
-
 EXPORT_SYMBOL(remap_pfn_range);
 
 /*
