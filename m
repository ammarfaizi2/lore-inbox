Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262368AbVCIWba@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262368AbVCIWba (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 17:31:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262515AbVCIW0H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 17:26:07 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:44497 "EHLO
	MTVMIME03.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S261390AbVCIWH2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 17:07:28 -0500
Date: Wed, 9 Mar 2005 22:06:35 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH 1/15] ptwalk: p?d_none_or_clear_bad
In-Reply-To: <Pine.LNX.4.61.0503092201070.6070@goblin.wat.veritas.com>
Message-ID: <Pine.LNX.4.61.0503092205450.6070@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0503092201070.6070@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Replace the repetitive p?d_none, p?d_bad, p?d_ERROR, p?d_clear clauses
by pgd_none_or_clear_bad, pud_none_or_clear_bad, pmd_none_or_clear_bad
inlines throughout common and i386 - avoids a sprinkling of "unlikely"s.

Tests inline, but unlikely error handling in mm/memory.c - so the ERROR
file and line won't tell much; but it comes too late anyway, and hardly
ever seen outside development.

Let mremap use them in get_one_pte_map, as it already did in _nested;
but leave follow_page and untouched_anonymous page just skipping _bad
as before - they don't have quite the same ownership of the mm.

Signed-off-by: Hugh Dickins <hugh@veritas.com>
---

 arch/i386/kernel/vm86.c       |   21 +--------
 include/asm-generic/pgtable.h |   44 ++++++++++++++++++++
 mm/memory.c                   |   89 +++++++++++++++---------------------------
 mm/mprotect.c                 |   21 +--------
 mm/mremap.c                   |   24 +++--------
 mm/msync.c                    |   21 +--------
 mm/swapfile.c                 |   21 +--------
 mm/vmalloc.c                  |   21 +--------
 8 files changed, 100 insertions(+), 162 deletions(-)

--- 2.6.11-bk5/arch/i386/kernel/vm86.c	2005-03-02 07:38:52.000000000 +0000
+++ ptwalk1/arch/i386/kernel/vm86.c	2005-03-09 01:35:49.000000000 +0000
@@ -145,29 +145,14 @@ static void mark_screen_rdonly(struct ta
 	preempt_disable();
 	spin_lock(&tsk->mm->page_table_lock);
 	pgd = pgd_offset(tsk->mm, 0xA0000);
-	if (pgd_none(*pgd))
+	if (pgd_none_or_clear_bad(pgd))
 		goto out;
-	if (pgd_bad(*pgd)) {
-		pgd_ERROR(*pgd);
-		pgd_clear(pgd);
-		goto out;
-	}
 	pud = pud_offset(pgd, 0xA0000);
-	if (pud_none(*pud))
-		goto out;
-	if (pud_bad(*pud)) {
-		pud_ERROR(*pud);
-		pud_clear(pud);
+	if (pud_none_or_clear_bad(pud))
 		goto out;
-	}
 	pmd = pmd_offset(pud, 0xA0000);
-	if (pmd_none(*pmd))
-		goto out;
-	if (pmd_bad(*pmd)) {
-		pmd_ERROR(*pmd);
-		pmd_clear(pmd);
+	if (pmd_none_or_clear_bad(pmd))
 		goto out;
-	}
 	pte = mapped = pte_offset_map(pmd, 0xA0000);
 	for (i = 0; i < 32; i++) {
 		if (pte_present(*pte))
--- 2.6.11-bk5/include/asm-generic/pgtable.h	2005-03-09 01:12:48.000000000 +0000
+++ ptwalk1/include/asm-generic/pgtable.h	2005-03-09 01:35:49.000000000 +0000
@@ -135,4 +135,48 @@ static inline void ptep_set_wrprotect(st
 #define pgd_offset_gate(mm, addr)	pgd_offset(mm, addr)
 #endif
 
+#ifndef __ASSEMBLY__
+/*
+ * When walking page tables, we usually want to skip any p?d_none entries;
+ * and any p?d_bad entries - reporting the error before resetting to none.
+ * Do the tests inline, but report and clear the bad entry in mm/memory.c.
+ */
+void pgd_clear_bad(pgd_t *);
+void pud_clear_bad(pud_t *);
+void pmd_clear_bad(pmd_t *);
+
+static inline int pgd_none_or_clear_bad(pgd_t *pgd)
+{
+	if (pgd_none(*pgd))
+		return 1;
+	if (unlikely(pgd_bad(*pgd))) {
+		pgd_clear_bad(pgd);
+		return 1;
+	}
+	return 0;
+}
+
+static inline int pud_none_or_clear_bad(pud_t *pud)
+{
+	if (pud_none(*pud))
+		return 1;
+	if (unlikely(pud_bad(*pud))) {
+		pud_clear_bad(pud);
+		return 1;
+	}
+	return 0;
+}
+
+static inline int pmd_none_or_clear_bad(pmd_t *pmd)
+{
+	if (pmd_none(*pmd))
+		return 1;
+	if (unlikely(pmd_bad(*pmd))) {
+		pmd_clear_bad(pmd);
+		return 1;
+	}
+	return 0;
+}
+#endif /* !__ASSEMBLY__ */
+
 #endif /* _ASM_GENERIC_PGTABLE_H */
--- 2.6.11-bk5/mm/memory.c	2005-03-09 01:12:53.000000000 +0000
+++ ptwalk1/mm/memory.c	2005-03-09 01:35:49.000000000 +0000
@@ -83,6 +83,30 @@ EXPORT_SYMBOL(high_memory);
 EXPORT_SYMBOL(vmalloc_earlyreserve);
 
 /*
+ * If a p?d_bad entry is found while walking page tables, report
+ * the error, before resetting entry to p?d_none.  Usually (but
+ * very seldom) called out from the p?d_none_or_clear_bad macros.
+ */
+
+void pgd_clear_bad(pgd_t *pgd)
+{
+	pgd_ERROR(*pgd);
+	pgd_clear(pgd);
+}
+
+void pud_clear_bad(pud_t *pud)
+{
+	pud_ERROR(*pud);
+	pud_clear(pud);
+}
+
+void pmd_clear_bad(pmd_t *pmd)
+{
+	pmd_ERROR(*pmd);
+	pmd_clear(pmd);
+}
+
+/*
  * Note: this doesn't free the actual pages themselves. That
  * has been handled earlier when unmapping all the memory regions.
  */
@@ -90,13 +114,8 @@ static inline void clear_pmd_range(struc
 {
 	struct page *page;
 
-	if (pmd_none(*pmd))
+	if (pmd_none_or_clear_bad(pmd))
 		return;
-	if (unlikely(pmd_bad(*pmd))) {
-		pmd_ERROR(*pmd);
-		pmd_clear(pmd);
-		return;
-	}
 	if (!((start | end) & ~PMD_MASK)) {
 		/* Only clear full, aligned ranges */
 		page = pmd_page(*pmd);
@@ -112,14 +131,8 @@ static inline void clear_pud_range(struc
 	unsigned long addr = start, next;
 	pmd_t *pmd, *__pmd;
 
-	if (pud_none(*pud))
+	if (pud_none_or_clear_bad(pud))
 		return;
-	if (unlikely(pud_bad(*pud))) {
-		pud_ERROR(*pud);
-		pud_clear(pud);
-		return;
-	}
-
 	pmd = __pmd = pmd_offset(pud, start);
 	do {
 		next = (addr + PMD_SIZE) & PMD_MASK;
@@ -144,14 +157,8 @@ static inline void clear_pgd_range(struc
 	unsigned long addr = start, next;
 	pud_t *pud, *__pud;
 
-	if (pgd_none(*pgd))
+	if (pgd_none_or_clear_bad(pgd))
 		return;
-	if (unlikely(pgd_bad(*pgd))) {
-		pgd_ERROR(*pgd);
-		pgd_clear(pgd);
-		return;
-	}
-
 	pud = __pud = pud_offset(pgd, start);
 	do {
 		next = (addr + PUD_SIZE) & PUD_MASK;
@@ -374,13 +381,8 @@ static int copy_pmd_range(struct mm_stru
 		next = (addr + PMD_SIZE) & PMD_MASK;
 		if (next > end || next <= addr)
 			next = end;
-		if (pmd_none(*src_pmd))
-			continue;
-		if (pmd_bad(*src_pmd)) {
-			pmd_ERROR(*src_pmd);
-			pmd_clear(src_pmd);
+		if (pmd_none_or_clear_bad(src_pmd))
 			continue;
-		}
 		err = copy_pte_range(dst_mm, src_mm, dst_pmd, src_pmd,
 							vma, addr, next);
 		if (err)
@@ -406,13 +408,8 @@ static int copy_pud_range(struct mm_stru
 		next = (addr + PUD_SIZE) & PUD_MASK;
 		if (next > end || next <= addr)
 			next = end;
-		if (pud_none(*src_pud))
-			continue;
-		if (pud_bad(*src_pud)) {
-			pud_ERROR(*src_pud);
-			pud_clear(src_pud);
+		if (pud_none_or_clear_bad(src_pud))
 			continue;
-		}
 		err = copy_pmd_range(dst_mm, src_mm, dst_pud, src_pud,
 							vma, addr, next);
 		if (err)
@@ -441,13 +438,8 @@ int copy_page_range(struct mm_struct *ds
 		next = (addr + PGDIR_SIZE) & PGDIR_MASK;
 		if (next > end || next <= addr)
 			next = end;
-		if (pgd_none(*src_pgd))
+		if (pgd_none_or_clear_bad(src_pgd))
 			goto next_pgd;
-		if (pgd_bad(*src_pgd)) {
-			pgd_ERROR(*src_pgd);
-			pgd_clear(src_pgd);
-			goto next_pgd;
-		}
 		err = copy_pud_range(dst, src, dst_pgd, src_pgd,
 							vma, addr, next);
 		if (err)
@@ -469,13 +461,8 @@ static void zap_pte_range(struct mmu_gat
 	unsigned long offset;
 	pte_t *ptep;
 
-	if (pmd_none(*pmd))
+	if (pmd_none_or_clear_bad(pmd))
 		return;
-	if (unlikely(pmd_bad(*pmd))) {
-		pmd_ERROR(*pmd);
-		pmd_clear(pmd);
-		return;
-	}
 	ptep = pte_offset_map(pmd, address);
 	offset = address & ~PMD_MASK;
 	if (offset + size > PMD_SIZE)
@@ -553,13 +540,8 @@ static void zap_pmd_range(struct mmu_gat
 	pmd_t * pmd;
 	unsigned long end;
 
-	if (pud_none(*pud))
-		return;
-	if (unlikely(pud_bad(*pud))) {
-		pud_ERROR(*pud);
-		pud_clear(pud);
+	if (pud_none_or_clear_bad(pud))
 		return;
-	}
 	pmd = pmd_offset(pud, address);
 	end = address + size;
 	if (end > ((address + PUD_SIZE) & PUD_MASK))
@@ -577,13 +559,8 @@ static void zap_pud_range(struct mmu_gat
 {
 	pud_t * pud;
 
-	if (pgd_none(*pgd))
-		return;
-	if (unlikely(pgd_bad(*pgd))) {
-		pgd_ERROR(*pgd);
-		pgd_clear(pgd);
+	if (pgd_none_or_clear_bad(pgd))
 		return;
-	}
 	pud = pud_offset(pgd, address);
 	do {
 		zap_pmd_range(tlb, pud, address, end - address, details);
--- 2.6.11-bk5/mm/mprotect.c	2005-03-09 01:12:53.000000000 +0000
+++ ptwalk1/mm/mprotect.c	2005-03-09 01:35:49.000000000 +0000
@@ -32,13 +32,8 @@ change_pte_range(struct mm_struct *mm, p
 	pte_t * pte;
 	unsigned long base, end;
 
-	if (pmd_none(*pmd))
+	if (pmd_none_or_clear_bad(pmd))
 		return;
-	if (pmd_bad(*pmd)) {
-		pmd_ERROR(*pmd);
-		pmd_clear(pmd);
-		return;
-	}
 	pte = pte_offset_map(pmd, address);
 	base = address & PMD_MASK;
 	address &= ~PMD_MASK;
@@ -69,13 +64,8 @@ change_pmd_range(struct mm_struct *mm, p
 	pmd_t * pmd;
 	unsigned long base, end;
 
-	if (pud_none(*pud))
-		return;
-	if (pud_bad(*pud)) {
-		pud_ERROR(*pud);
-		pud_clear(pud);
+	if (pud_none_or_clear_bad(pud))
 		return;
-	}
 	pmd = pmd_offset(pud, address);
 	base = address & PUD_MASK;
 	address &= ~PUD_MASK;
@@ -96,13 +86,8 @@ change_pud_range(struct mm_struct *mm, p
 	pud_t * pud;
 	unsigned long base, end;
 
-	if (pgd_none(*pgd))
-		return;
-	if (pgd_bad(*pgd)) {
-		pgd_ERROR(*pgd);
-		pgd_clear(pgd);
+	if (pgd_none_or_clear_bad(pgd))
 		return;
-	}
 	pud = pud_offset(pgd, address);
 	base = address & PGDIR_MASK;
 	address &= ~PGDIR_MASK;
--- 2.6.11-bk5/mm/mremap.c	2005-03-09 01:12:53.000000000 +0000
+++ ptwalk1/mm/mremap.c	2005-03-09 01:35:49.000000000 +0000
@@ -30,26 +30,16 @@ static pte_t *get_one_pte_map_nested(str
 	pte_t *pte = NULL;
 
 	pgd = pgd_offset(mm, addr);
-	if (pgd_none(*pgd))
+	if (pgd_none_or_clear_bad(pgd))
 		goto end;
 
 	pud = pud_offset(pgd, addr);
-	if (pud_none(*pud))
+	if (pud_none_or_clear_bad(pud))
 		goto end;
-	if (pud_bad(*pud)) {
-		pud_ERROR(*pud);
-		pud_clear(pud);
-		goto end;
-	}
 
 	pmd = pmd_offset(pud, addr);
-	if (pmd_none(*pmd))
-		goto end;
-	if (pmd_bad(*pmd)) {
-		pmd_ERROR(*pmd);
-		pmd_clear(pmd);
+	if (pmd_none_or_clear_bad(pmd))
 		goto end;
-	}
 
 	pte = pte_offset_map_nested(pmd, addr);
 	if (pte_none(*pte)) {
@@ -67,15 +57,17 @@ static pte_t *get_one_pte_map(struct mm_
 	pmd_t *pmd;
 
 	pgd = pgd_offset(mm, addr);
-	if (pgd_none(*pgd))
+	if (pgd_none_or_clear_bad(pgd))
 		return NULL;
 
 	pud = pud_offset(pgd, addr);
-	if (pud_none(*pud))
+	if (pud_none_or_clear_bad(pud))
 		return NULL;
+
 	pmd = pmd_offset(pud, addr);
-	if (!pmd_present(*pmd))
+	if (pmd_none_or_clear_bad(pmd))
 		return NULL;
+
 	return pte_offset_map(pmd, addr);
 }
 
--- 2.6.11-bk5/mm/msync.c	2005-03-02 07:38:55.000000000 +0000
+++ ptwalk1/mm/msync.c	2005-03-09 01:35:49.000000000 +0000
@@ -45,13 +45,8 @@ static int filemap_sync_pte_range(pmd_t 
 	pte_t *pte;
 	int error;
 
-	if (pmd_none(*pmd))
+	if (pmd_none_or_clear_bad(pmd))
 		return 0;
-	if (pmd_bad(*pmd)) {
-		pmd_ERROR(*pmd);
-		pmd_clear(pmd);
-		return 0;
-	}
 	pte = pte_offset_map(pmd, address);
 	if ((address & PMD_MASK) != (end & PMD_MASK))
 		end = (address & PMD_MASK) + PMD_SIZE;
@@ -74,13 +69,8 @@ static inline int filemap_sync_pmd_range
 	pmd_t * pmd;
 	int error;
 
-	if (pud_none(*pud))
-		return 0;
-	if (pud_bad(*pud)) {
-		pud_ERROR(*pud);
-		pud_clear(pud);
+	if (pud_none_or_clear_bad(pud))
 		return 0;
-	}
 	pmd = pmd_offset(pud, address);
 	if ((address & PUD_MASK) != (end & PUD_MASK))
 		end = (address & PUD_MASK) + PUD_SIZE;
@@ -100,13 +90,8 @@ static inline int filemap_sync_pud_range
 	pud_t *pud;
 	int error;
 
-	if (pgd_none(*pgd))
-		return 0;
-	if (pgd_bad(*pgd)) {
-		pgd_ERROR(*pgd);
-		pgd_clear(pgd);
+	if (pgd_none_or_clear_bad(pgd))
 		return 0;
-	}
 	pud = pud_offset(pgd, address);
 	if ((address & PGDIR_MASK) != (end & PGDIR_MASK))
 		end = (address & PGDIR_MASK) + PGDIR_SIZE;
--- 2.6.11-bk5/mm/swapfile.c	2005-03-09 01:12:53.000000000 +0000
+++ ptwalk1/mm/swapfile.c	2005-03-09 01:35:49.000000000 +0000
@@ -441,13 +441,8 @@ static unsigned long unuse_pmd(struct vm
 	pte_t *pte;
 	pte_t swp_pte = swp_entry_to_pte(entry);
 
-	if (pmd_none(*dir))
+	if (pmd_none_or_clear_bad(dir))
 		return 0;
-	if (pmd_bad(*dir)) {
-		pmd_ERROR(*dir);
-		pmd_clear(dir);
-		return 0;
-	}
 	pte = pte_offset_map(dir, address);
 	do {
 		/*
@@ -483,13 +478,8 @@ static unsigned long unuse_pud(struct vm
 	unsigned long next;
 	unsigned long foundaddr;
 
-	if (pud_none(*pud))
-		return 0;
-	if (pud_bad(*pud)) {
-		pud_ERROR(*pud);
-		pud_clear(pud);
+	if (pud_none_or_clear_bad(pud))
 		return 0;
-	}
 	pmd = pmd_offset(pud, address);
 	do {
 		next = (address + PMD_SIZE) & PMD_MASK;
@@ -513,13 +503,8 @@ static unsigned long unuse_pgd(struct vm
 	unsigned long next;
 	unsigned long foundaddr;
 
-	if (pgd_none(*pgd))
-		return 0;
-	if (pgd_bad(*pgd)) {
-		pgd_ERROR(*pgd);
-		pgd_clear(pgd);
+	if (pgd_none_or_clear_bad(pgd))
 		return 0;
-	}
 	pud = pud_offset(pgd, address);
 	do {
 		next = (address + PUD_SIZE) & PUD_MASK;
--- 2.6.11-bk5/mm/vmalloc.c	2005-03-09 01:12:53.000000000 +0000
+++ ptwalk1/mm/vmalloc.c	2005-03-09 01:35:49.000000000 +0000
@@ -29,13 +29,8 @@ static void unmap_area_pte(pmd_t *pmd, u
 	unsigned long base, end;
 	pte_t *pte;
 
-	if (pmd_none(*pmd))
+	if (pmd_none_or_clear_bad(pmd))
 		return;
-	if (pmd_bad(*pmd)) {
-		pmd_ERROR(*pmd);
-		pmd_clear(pmd);
-		return;
-	}
 
 	pte = pte_offset_kernel(pmd, address);
 	base = address & PMD_MASK;
@@ -63,13 +58,8 @@ static void unmap_area_pmd(pud_t *pud, u
 	unsigned long base, end;
 	pmd_t *pmd;
 
-	if (pud_none(*pud))
-		return;
-	if (pud_bad(*pud)) {
-		pud_ERROR(*pud);
-		pud_clear(pud);
+	if (pud_none_or_clear_bad(pud))
 		return;
-	}
 
 	pmd = pmd_offset(pud, address);
 	base = address & PUD_MASK;
@@ -91,13 +81,8 @@ static void unmap_area_pud(pgd_t *pgd, u
 	pud_t *pud;
 	unsigned long base, end;
 
-	if (pgd_none(*pgd))
-		return;
-	if (pgd_bad(*pgd)) {
-		pgd_ERROR(*pgd);
-		pgd_clear(pgd);
+	if (pgd_none_or_clear_bad(pgd))
 		return;
-	}
 
 	pud = pud_offset(pgd, address);
 	base = address & PGDIR_MASK;
