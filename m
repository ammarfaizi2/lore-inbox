Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932236AbVIYP5h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932236AbVIYP5h (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Sep 2005 11:57:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932237AbVIYP5h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Sep 2005 11:57:37 -0400
Received: from gold.veritas.com ([143.127.12.110]:55211 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S932238AbVIYP5g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Sep 2005 11:57:36 -0400
Date: Sun, 25 Sep 2005 16:57:10 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH 11/21] mm: move_page_tables by extents
In-Reply-To: <Pine.LNX.4.61.0509251644100.3490@goblin.wat.veritas.com>
Message-ID: <Pine.LNX.4.61.0509251656310.3490@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0509251644100.3490@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 25 Sep 2005 15:57:35.0984 (UTC) FILETIME=[D8DD2700:01C5C1E9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Speeding up mremap's moving of ptes has never been a priority, but the
locking will get more complicated shortly, and is already too baroque.

Scrap the current one-by-one moving, do an extent at a time: curtailed
by end of src and dst pmds (have to use PMD_SIZE: the way pmd_addr_end
gets elided doesn't match this usage), and by latency considerations.

One nice property of the old method is lost: it never allocated a page
table unless absolutely necessary, so you could free empty page tables
by mremapping to and fro.  Whereas this way, it allocates a dst table
wherever there was a src table.  I keep diving in to reinstate the old
behaviour, then come out preferring not to clutter how it now is.

Signed-off-by: Hugh Dickins <hugh@veritas.com>
---

 mm/mremap.c |  166 +++++++++++++++++++++++++-----------------------------------
 1 files changed, 71 insertions(+), 95 deletions(-)

--- mm10/mm/mremap.c	2005-09-24 19:27:33.000000000 +0100
+++ mm11/mm/mremap.c	2005-09-24 19:28:42.000000000 +0100
@@ -22,40 +22,15 @@
 #include <asm/cacheflush.h>
 #include <asm/tlbflush.h>
 
-static pte_t *get_one_pte_map_nested(struct mm_struct *mm, unsigned long addr)
-{
-	pgd_t *pgd;
-	pud_t *pud;
-	pmd_t *pmd;
-	pte_t *pte = NULL;
-
-	pgd = pgd_offset(mm, addr);
-	if (pgd_none_or_clear_bad(pgd))
-		goto end;
-
-	pud = pud_offset(pgd, addr);
-	if (pud_none_or_clear_bad(pud))
-		goto end;
-
-	pmd = pmd_offset(pud, addr);
-	if (pmd_none_or_clear_bad(pmd))
-		goto end;
-
-	pte = pte_offset_map_nested(pmd, addr);
-	if (pte_none(*pte)) {
-		pte_unmap_nested(pte);
-		pte = NULL;
-	}
-end:
-	return pte;
-}
-
-static pte_t *get_one_pte_map(struct mm_struct *mm, unsigned long addr)
+static pmd_t *get_old_pmd(struct mm_struct *mm, unsigned long addr)
 {
 	pgd_t *pgd;
 	pud_t *pud;
 	pmd_t *pmd;
 
+	/*
+	 * We don't need page_table_lock: we have mmap_sem exclusively.
+	 */
 	pgd = pgd_offset(mm, addr);
 	if (pgd_none_or_clear_bad(pgd))
 		return NULL;
@@ -68,35 +43,48 @@ static pte_t *get_one_pte_map(struct mm_
 	if (pmd_none_or_clear_bad(pmd))
 		return NULL;
 
-	return pte_offset_map(pmd, addr);
+	return pmd;
 }
 
-static inline pte_t *alloc_one_pte_map(struct mm_struct *mm, unsigned long addr)
+static pmd_t *alloc_new_pmd(struct mm_struct *mm, unsigned long addr)
 {
 	pgd_t *pgd;
 	pud_t *pud;
-	pmd_t *pmd;
-	pte_t *pte = NULL;
+	pmd_t *pmd = NULL;
+	pte_t *pte;
 
+	/*
+	 * We do need page_table_lock: because allocators expect that.
+	 */
+	spin_lock(&mm->page_table_lock);
 	pgd = pgd_offset(mm, addr);
-
 	pud = pud_alloc(mm, pgd, addr);
 	if (!pud)
-		return NULL;
+		goto out;
+
 	pmd = pmd_alloc(mm, pud, addr);
-	if (pmd)
-		pte = pte_alloc_map(mm, pmd, addr);
-	return pte;
+	if (!pmd)
+		goto out;
+
+	pte = pte_alloc_map(mm, pmd, addr);
+	if (!pte) {
+		pmd = NULL;
+		goto out;
+	}
+	pte_unmap(pte);
+out:
+	spin_unlock(&mm->page_table_lock);
+	return pmd;
 }
 
-static int
-move_one_page(struct vm_area_struct *vma, unsigned long old_addr,
-		struct vm_area_struct *new_vma, unsigned long new_addr)
+static void move_ptes(struct vm_area_struct *vma, pmd_t *old_pmd,
+		unsigned long old_addr, unsigned long old_end,
+		struct vm_area_struct *new_vma, pmd_t *new_pmd,
+		unsigned long new_addr)
 {
 	struct address_space *mapping = NULL;
 	struct mm_struct *mm = vma->vm_mm;
-	int error = 0;
-	pte_t *src, *dst;
+	pte_t *old_pte, *new_pte, pte;
 
 	if (vma->vm_file) {
 		/*
@@ -111,74 +99,62 @@ move_one_page(struct vm_area_struct *vma
 		    new_vma->vm_truncate_count != vma->vm_truncate_count)
 			new_vma->vm_truncate_count = 0;
 	}
+
 	spin_lock(&mm->page_table_lock);
+	old_pte = pte_offset_map(old_pmd, old_addr);
+	new_pte = pte_offset_map_nested(new_pmd, new_addr);
 
-	src = get_one_pte_map_nested(mm, old_addr);
-	if (src) {
-		/*
-		 * Look to see whether alloc_one_pte_map needs to perform a
-		 * memory allocation.  If it does then we need to drop the
-		 * atomic kmap
-		 */
-		dst = get_one_pte_map(mm, new_addr);
-		if (unlikely(!dst)) {
-			pte_unmap_nested(src);
-			if (mapping)
-				spin_unlock(&mapping->i_mmap_lock);
-			dst = alloc_one_pte_map(mm, new_addr);
-			if (mapping && !spin_trylock(&mapping->i_mmap_lock)) {
-				spin_unlock(&mm->page_table_lock);
-				spin_lock(&mapping->i_mmap_lock);
-				spin_lock(&mm->page_table_lock);
-			}
-			src = get_one_pte_map_nested(mm, old_addr);
-		}
-		/*
-		 * Since alloc_one_pte_map can drop and re-acquire
-		 * page_table_lock, we should re-check the src entry...
-		 */
-		if (src) {
-			if (dst) {
-				pte_t pte;
-				pte = ptep_clear_flush(vma, old_addr, src);
-
-				/* ZERO_PAGE can be dependant on virtual addr */
-				pte = move_pte(pte, new_vma->vm_page_prot,
-							old_addr, new_addr);
-				set_pte_at(mm, new_addr, dst, pte);
-			} else
-				error = -ENOMEM;
-			pte_unmap_nested(src);
-		}
-		if (dst)
-			pte_unmap(dst);
+	for (; old_addr < old_end; old_pte++, old_addr += PAGE_SIZE,
+				   new_pte++, new_addr += PAGE_SIZE) {
+		if (pte_none(*old_pte))
+			continue;
+		pte = ptep_clear_flush(vma, old_addr, old_pte);
+		/* ZERO_PAGE can be dependant on virtual addr */
+		pte = move_pte(pte, new_vma->vm_page_prot, old_addr, new_addr);
+		set_pte_at(mm, new_addr, new_pte, pte);
 	}
+
+	pte_unmap_nested(new_pte - 1);
+	pte_unmap(old_pte - 1);
 	spin_unlock(&mm->page_table_lock);
 	if (mapping)
 		spin_unlock(&mapping->i_mmap_lock);
-	return error;
 }
 
+#define LATENCY_LIMIT	(64 * PAGE_SIZE)
+
 static unsigned long move_page_tables(struct vm_area_struct *vma,
 		unsigned long old_addr, struct vm_area_struct *new_vma,
 		unsigned long new_addr, unsigned long len)
 {
-	unsigned long offset;
+	unsigned long extent, next, old_end;
+	pmd_t *old_pmd, *new_pmd;
 
-	flush_cache_range(vma, old_addr, old_addr + len);
+	old_end = old_addr + len;
+	flush_cache_range(vma, old_addr, old_end);
 
-	/*
-	 * This is not the clever way to do this, but we're taking the
-	 * easy way out on the assumption that most remappings will be
-	 * only a few pages.. This also makes error recovery easier.
-	 */
-	for (offset = 0; offset < len; offset += PAGE_SIZE) {
-		if (move_one_page(vma, old_addr + offset,
-				new_vma, new_addr + offset) < 0)
-			break;
+	for (; old_addr < old_end; old_addr += extent, new_addr += extent) {
 		cond_resched();
+		next = (old_addr + PMD_SIZE) & PMD_MASK;
+		if (next - 1 > old_end)
+			next = old_end;
+		extent = next - old_addr;
+		old_pmd = get_old_pmd(vma->vm_mm, old_addr);
+		if (!old_pmd)
+			continue;
+		new_pmd = alloc_new_pmd(vma->vm_mm, new_addr);
+		if (!new_pmd)
+			break;
+		next = (new_addr + PMD_SIZE) & PMD_MASK;
+		if (extent > next - new_addr)
+			extent = next - new_addr;
+		if (extent > LATENCY_LIMIT)
+			extent = LATENCY_LIMIT;
+		move_ptes(vma, old_pmd, old_addr, old_addr + extent,
+				new_vma, new_pmd, new_addr);
 	}
-	return offset;
+
+	return len + old_addr - old_end;	/* how much done */
 }
 
 static unsigned long move_vma(struct vm_area_struct *vma,
