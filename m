Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262434AbVCJFm6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262434AbVCJFm6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 00:42:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262477AbVCIWTn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 17:19:43 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:62945 "EHLO
	MTVMIME03.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S262097AbVCIWIZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 17:08:25 -0500
Date: Wed, 9 Mar 2005 22:07:20 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2/15] ptwalk: change_protection
In-Reply-To: <Pine.LNX.4.61.0503092201070.6070@goblin.wat.veritas.com>
Message-ID: <Pine.LNX.4.61.0503092206420.6070@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0503092201070.6070@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Begin the pagetable walker cleanup with a straightforward example,
mprotect's change_protection.  Started out from Nick Piggin's for_each
proposal, but I prefer less hidden; and these are all do while loops,
which degrade slightly when converted to for loops.

Firmly agree with Andi and Nick that addr,end is the way to go: size is
good at the user interface level, but unhelpful down in the loops.  And
the habit of an "address" which is actually an offset from some base has
bitten us several times: use proper address at each level, whyever not?

Don't apply each mask at two levels: all we need is a set of macros
pgd_addr_end, pud_addr_end, pmd_addr_end to give the address of the end
of each range.  Which need to take the min of two addresses, with 0 as
the greatest.  Started out with a different macro, assumed end never 0;
but clear_page_range (alone) might be passed end 0 by some out-of-tree
memory layouts: could special case it, but this macro compiles smaller.
Check "addr != end" instead of "addr < end" to work on that end 0 case.

Signed-off-by: Hugh Dickins <hugh@veritas.com>
---

 include/asm-generic/pgtable.h |   21 ++++++++
 mm/mprotect.c                 |  104 +++++++++++++++---------------------------
 2 files changed, 59 insertions(+), 66 deletions(-)

--- ptwalk1/include/asm-generic/pgtable.h	2005-03-09 01:35:49.000000000 +0000
+++ ptwalk2/include/asm-generic/pgtable.h	2005-03-09 01:36:01.000000000 +0000
@@ -135,6 +135,27 @@ static inline void ptep_set_wrprotect(st
 #define pgd_offset_gate(mm, addr)	pgd_offset(mm, addr)
 #endif
 
+/*
+ * When walking page tables, get the address of the next boundary, or
+ * the end address of the range if that comes earlier.  Although end might
+ * wrap to 0 only in clear_page_range, __boundary may wrap to 0 throughout.
+ */
+
+#define pgd_addr_end(addr, end)						\
+({	unsigned long __boundary = ((addr) + PGDIR_SIZE) & PGDIR_MASK;	\
+	(__boundary - 1 < (end) - 1)? __boundary: (end);		\
+})
+
+#define pud_addr_end(addr, end)						\
+({	unsigned long __boundary = ((addr) + PUD_SIZE) & PUD_MASK;	\
+	(__boundary - 1 < (end) - 1)? __boundary: (end);		\
+})
+
+#define pmd_addr_end(addr, end)						\
+({	unsigned long __boundary = ((addr) + PMD_SIZE) & PMD_MASK;	\
+	(__boundary - 1 < (end) - 1)? __boundary: (end);		\
+})
+
 #ifndef __ASSEMBLY__
 /*
  * When walking page tables, we usually want to skip any p?d_none entries;
--- ptwalk1/mm/mprotect.c	2005-03-09 01:35:49.000000000 +0000
+++ ptwalk2/mm/mprotect.c	2005-03-09 01:36:01.000000000 +0000
@@ -25,104 +25,76 @@
 #include <asm/cacheflush.h>
 #include <asm/tlbflush.h>
 
-static inline void
-change_pte_range(struct mm_struct *mm, pmd_t *pmd, unsigned long address,
-		unsigned long size, pgprot_t newprot)
+static inline void change_pte_range(struct mm_struct *mm, pmd_t *pmd,
+		unsigned long addr, unsigned long end, pgprot_t newprot)
 {
-	pte_t * pte;
-	unsigned long base, end;
+	pte_t *pte;
 
 	if (pmd_none_or_clear_bad(pmd))
 		return;
-	pte = pte_offset_map(pmd, address);
-	base = address & PMD_MASK;
-	address &= ~PMD_MASK;
-	end = address + size;
-	if (end > PMD_SIZE)
-		end = PMD_SIZE;
+	pte = pte_offset_map(pmd, addr);
 	do {
 		if (pte_present(*pte)) {
-			pte_t entry;
+			pte_t ptent;
 
 			/* Avoid an SMP race with hardware updated dirty/clean
 			 * bits by wiping the pte and then setting the new pte
 			 * into place.
 			 */
-			entry = ptep_get_and_clear(mm, base + address, pte);
-			set_pte_at(mm, base + address, pte, pte_modify(entry, newprot));
+			ptent = ptep_get_and_clear(mm, addr, pte);
+			set_pte_at(mm, addr, pte, pte_modify(ptent, newprot));
 		}
-		address += PAGE_SIZE;
-		pte++;
-	} while (address && (address < end));
+	} while (pte++, addr += PAGE_SIZE, addr != end);
 	pte_unmap(pte - 1);
 }
 
-static inline void
-change_pmd_range(struct mm_struct *mm, pud_t *pud, unsigned long address,
-		 unsigned long size, pgprot_t newprot)
+static inline void change_pmd_range(struct mm_struct *mm, pud_t *pud,
+		unsigned long addr, unsigned long end, pgprot_t newprot)
 {
-	pmd_t * pmd;
-	unsigned long base, end;
+	pmd_t *pmd;
+	unsigned long next;
 
 	if (pud_none_or_clear_bad(pud))
 		return;
-	pmd = pmd_offset(pud, address);
-	base = address & PUD_MASK;
-	address &= ~PUD_MASK;
-	end = address + size;
-	if (end > PUD_SIZE)
-		end = PUD_SIZE;
+	pmd = pmd_offset(pud, addr);
 	do {
-		change_pte_range(mm, pmd, base + address, end - address, newprot);
-		address = (address + PMD_SIZE) & PMD_MASK;
-		pmd++;
-	} while (address && (address < end));
+		next = pmd_addr_end(addr, end);
+		change_pte_range(mm, pmd, addr, next, newprot);
+	} while (pmd++, addr = next, addr != end);
 }
 
-static inline void
-change_pud_range(struct mm_struct *mm, pgd_t *pgd, unsigned long address,
-		 unsigned long size, pgprot_t newprot)
+static inline void change_pud_range(struct mm_struct *mm, pgd_t *pgd,
+		unsigned long addr, unsigned long end, pgprot_t newprot)
 {
-	pud_t * pud;
-	unsigned long base, end;
+	pud_t *pud;
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
 	do {
-		change_pmd_range(mm, pud, base + address, end - address, newprot);
-		address = (address + PUD_SIZE) & PUD_MASK;
-		pud++;
-	} while (address && (address < end));
+		next = pud_addr_end(addr, end);
+		change_pmd_range(mm, pud, addr, next, newprot);
+	} while (pud++, addr = next, addr != end);
 }
 
-static void
-change_protection(struct vm_area_struct *vma, unsigned long start,
-		unsigned long end, pgprot_t newprot)
+static void change_protection(struct vm_area_struct *vma,
+		unsigned long addr, unsigned long end, pgprot_t newprot)
 {
-	struct mm_struct *mm = current->mm;
+	struct mm_struct *mm = vma->vm_mm;
 	pgd_t *pgd;
-	unsigned long beg = start, next;
-	int i;
+	unsigned long next;
+	unsigned long start = addr;
 
-	pgd = pgd_offset(mm, start);
-	flush_cache_range(vma, beg, end);
-	BUG_ON(start >= end);
+	BUG_ON(addr >= end);
+	pgd = pgd_offset(mm, addr);
+	flush_cache_range(vma, addr, end);
 	spin_lock(&mm->page_table_lock);
-	for (i = pgd_index(start); i <= pgd_index(end-1); i++) {
-		next = (start + PGDIR_SIZE) & PGDIR_MASK;
-		if (next <= start || next > end)
-			next = end;
-		change_pud_range(mm, pgd, start, next - start, newprot);
-		start = next;
-		pgd++;
-	}
-	flush_tlb_range(vma, beg, end);
+	do {
+		next = pgd_addr_end(addr, end);
+		change_pud_range(mm, pgd, addr, next, newprot);
+	} while (pgd++, addr = next, addr != end);
+	flush_tlb_range(vma, start, end);
 	spin_unlock(&mm->page_table_lock);
 }
 
@@ -130,7 +102,7 @@ static int
 mprotect_fixup(struct vm_area_struct *vma, struct vm_area_struct **pprev,
 	unsigned long start, unsigned long end, unsigned long newflags)
 {
-	struct mm_struct * mm = vma->vm_mm;
+	struct mm_struct *mm = vma->vm_mm;
 	unsigned long oldflags = vma->vm_flags;
 	long nrpages = (end - start) >> PAGE_SHIFT;
 	unsigned long charged = 0;
