Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262116AbVCIWUP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262116AbVCIWUP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 17:20:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262076AbVCIWRP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 17:17:15 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:2046 "EHLO
	MTVMIME03.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S262117AbVCIWJd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 17:09:33 -0500
Date: Wed, 9 Mar 2005 22:08:46 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH 4/15] ptwalk: unuse_mm
In-Reply-To: <Pine.LNX.4.61.0503092201070.6070@goblin.wat.veritas.com>
Message-ID: <Pine.LNX.4.61.0503092208170.6070@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0503092201070.6070@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Convert unuse_process pagetable walkers to loops using p?d_addr_end; but
correct its name to unuse_mm, rename its levels to _range as elsewhere.

Leave unuse_pte out-of-line since it's so rarely called; but move the
funny activate_page inside it.  foundaddr was a leftover from before: we
still want to break out once page is found, but no need to pass addr up.
And we need not comment on the page_table_lock at every level.

Whereas most objects shrink ~200 bytes text, swapfile.o grows slightly:
it had earlier been converted to the addr,end style to fix a 4level bug.

Signed-off-by: Hugh Dickins <hugh@veritas.com>
---

 mm/swapfile.c |  148 +++++++++++++++++++++-------------------------------------
 1 files changed, 56 insertions(+), 92 deletions(-)

--- ptwalk3/mm/swapfile.c	2005-03-09 01:35:49.000000000 +0000
+++ ptwalk4/mm/swapfile.c	2005-03-09 01:36:25.000000000 +0000
@@ -412,154 +412,121 @@ void free_swap_and_cache(swp_entry_t ent
 }
 
 /*
- * The swap entry has been read in advance, and we return 1 to indicate
- * that the page has been used or is no longer needed.
- *
  * Always set the resulting pte to be nowrite (the same as COW pages
  * after one process has exited).  We don't know just how many PTEs will
  * share this swap entry, so be cautious and let do_wp_page work out
  * what to do if a write is requested later.
+ *
+ * vma->vm_mm->page_table_lock is held.
  */
-/* vma->vm_mm->page_table_lock is held */
-static void
-unuse_pte(struct vm_area_struct *vma, unsigned long address, pte_t *dir,
-	swp_entry_t entry, struct page *page)
+static void unuse_pte(struct vm_area_struct *vma, pte_t *pte,
+		unsigned long addr, swp_entry_t entry, struct page *page)
 {
 	vma->vm_mm->rss++;
 	get_page(page);
-	set_pte_at(vma->vm_mm, address, dir,
+	set_pte_at(vma->vm_mm, addr, pte,
 		   pte_mkold(mk_pte(page, vma->vm_page_prot)));
-	page_add_anon_rmap(page, vma, address);
+	page_add_anon_rmap(page, vma, addr);
 	swap_free(entry);
+	/*
+	 * Move the page to the active list so it is not
+	 * immediately swapped out again after swapon.
+	 */
+	activate_page(page);
 }
 
-/* vma->vm_mm->page_table_lock is held */
-static unsigned long unuse_pmd(struct vm_area_struct *vma, pmd_t *dir,
-	unsigned long address, unsigned long end,
-	swp_entry_t entry, struct page *page)
+static int unuse_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
+				unsigned long addr, unsigned long end,
+				swp_entry_t entry, struct page *page)
 {
 	pte_t *pte;
 	pte_t swp_pte = swp_entry_to_pte(entry);
 
-	if (pmd_none_or_clear_bad(dir))
+	if (pmd_none_or_clear_bad(pmd))
 		return 0;
-	pte = pte_offset_map(dir, address);
+	pte = pte_offset_map(pmd, addr);
 	do {
 		/*
 		 * swapoff spends a _lot_ of time in this loop!
 		 * Test inline before going to call unuse_pte.
 		 */
 		if (unlikely(pte_same(*pte, swp_pte))) {
-			unuse_pte(vma, address, pte, entry, page);
+			unuse_pte(vma, pte, addr, entry, page);
 			pte_unmap(pte);
-
-			/*
-			 * Move the page to the active list so it is not
-			 * immediately swapped out again after swapon.
-			 */
-			activate_page(page);
-
-			/* add 1 since address may be 0 */
-			return 1 + address;
+			return 1;
 		}
-		address += PAGE_SIZE;
-		pte++;
-	} while (address < end);
+	} while (pte++, addr += PAGE_SIZE, addr != end);
 	pte_unmap(pte - 1);
 	return 0;
 }
 
-/* vma->vm_mm->page_table_lock is held */
-static unsigned long unuse_pud(struct vm_area_struct *vma, pud_t *pud,
-        unsigned long address, unsigned long end,
-	swp_entry_t entry, struct page *page)
+static int unuse_pmd_range(struct vm_area_struct *vma, pud_t *pud,
+				unsigned long addr, unsigned long end,
+				swp_entry_t entry, struct page *page)
 {
 	pmd_t *pmd;
 	unsigned long next;
-	unsigned long foundaddr;
 
 	if (pud_none_or_clear_bad(pud))
 		return 0;
-	pmd = pmd_offset(pud, address);
+	pmd = pmd_offset(pud, addr);
 	do {
-		next = (address + PMD_SIZE) & PMD_MASK;
-		if (next > end || !next)
-			next = end;
-		foundaddr = unuse_pmd(vma, pmd, address, next, entry, page);
-		if (foundaddr)
-			return foundaddr;
-		address = next;
-		pmd++;
-	} while (address < end);
+		next = pmd_addr_end(addr, end);
+		if (unuse_pte_range(vma, pmd, addr, next, entry, page))
+			return 1;
+	} while (pmd++, addr = next, addr != end);
 	return 0;
 }
 
-/* vma->vm_mm->page_table_lock is held */
-static unsigned long unuse_pgd(struct vm_area_struct *vma, pgd_t *pgd,
-	unsigned long address, unsigned long end,
-	swp_entry_t entry, struct page *page)
+static int unuse_pud_range(struct vm_area_struct *vma, pgd_t *pgd,
+				unsigned long addr, unsigned long end,
+				swp_entry_t entry, struct page *page)
 {
 	pud_t *pud;
 	unsigned long next;
-	unsigned long foundaddr;
 
 	if (pgd_none_or_clear_bad(pgd))
 		return 0;
-	pud = pud_offset(pgd, address);
+	pud = pud_offset(pgd, addr);
 	do {
-		next = (address + PUD_SIZE) & PUD_MASK;
-		if (next > end || !next)
-			next = end;
-		foundaddr = unuse_pud(vma, pud, address, next, entry, page);
-		if (foundaddr)
-			return foundaddr;
-		address = next;
-		pud++;
-	} while (address < end);
+		next = pud_addr_end(addr, end);
+		if (unuse_pmd_range(vma, pud, addr, next, entry, page))
+			return 1;
+	} while (pud++, addr = next, addr != end);
 	return 0;
 }
 
-/* vma->vm_mm->page_table_lock is held */
-static unsigned long unuse_vma(struct vm_area_struct *vma,
-	swp_entry_t entry, struct page *page)
+static int unuse_vma(struct vm_area_struct *vma,
+				swp_entry_t entry, struct page *page)
 {
 	pgd_t *pgd;
-	unsigned long address, next, end;
-	unsigned long foundaddr;
+	unsigned long addr, end, next;
 
 	if (page->mapping) {
-		address = page_address_in_vma(page, vma);
-		if (address == -EFAULT)
+		addr = page_address_in_vma(page, vma);
+		if (addr == -EFAULT)
 			return 0;
 		else
-			end = address + PAGE_SIZE;
+			end = addr + PAGE_SIZE;
 	} else {
-		address = vma->vm_start;
+		addr = vma->vm_start;
 		end = vma->vm_end;
 	}
-	pgd = pgd_offset(vma->vm_mm, address);
+
+	pgd = pgd_offset(vma->vm_mm, addr);
 	do {
-		next = (address + PGDIR_SIZE) & PGDIR_MASK;
-		if (next > end || !next)
-			next = end;
-		foundaddr = unuse_pgd(vma, pgd, address, next, entry, page);
-		if (foundaddr)
-			return foundaddr;
-		address = next;
-		pgd++;
-	} while (address < end);
+		next = pgd_addr_end(addr, end);
+		if (unuse_pud_range(vma, pgd, addr, next, entry, page))
+			return 1;
+	} while (pgd++, addr = next, addr != end);
 	return 0;
 }
 
-static int unuse_process(struct mm_struct * mm,
-			swp_entry_t entry, struct page* page)
+static int unuse_mm(struct mm_struct *mm,
+				swp_entry_t entry, struct page *page)
 {
-	struct vm_area_struct* vma;
-	unsigned long foundaddr = 0;
+	struct vm_area_struct *vma;
 
-	/*
-	 * Go through process' page directory.
-	 */
 	if (!down_read_trylock(&mm->mmap_sem)) {
 		/*
 		 * Our reference to the page stops try_to_unmap_one from
@@ -571,16 +538,13 @@ static int unuse_process(struct mm_struc
 	}
 	spin_lock(&mm->page_table_lock);
 	for (vma = mm->mmap; vma; vma = vma->vm_next) {
-		if (vma->anon_vma) {
-			foundaddr = unuse_vma(vma, entry, page);
-			if (foundaddr)
-				break;
-		}
+		if (vma->anon_vma && unuse_vma(vma, entry, page))
+			break;
 	}
 	spin_unlock(&mm->page_table_lock);
 	up_read(&mm->mmap_sem);
 	/*
-	 * Currently unuse_process cannot fail, but leave error handling
+	 * Currently unuse_mm cannot fail, but leave error handling
 	 * at call sites for now, since we change it from time to time.
 	 */
 	return 0;
@@ -724,7 +688,7 @@ static int try_to_unuse(unsigned int typ
 			if (start_mm == &init_mm)
 				shmem = shmem_unuse(entry, page);
 			else
-				retval = unuse_process(start_mm, entry, page);
+				retval = unuse_mm(start_mm, entry, page);
 		}
 		if (*swap_map > 1) {
 			int set_start_mm = (*swap_map >= swcount);
@@ -756,7 +720,7 @@ static int try_to_unuse(unsigned int typ
 					set_start_mm = 1;
 					shmem = shmem_unuse(entry, page);
 				} else
-					retval = unuse_process(mm, entry, page);
+					retval = unuse_mm(mm, entry, page);
 				if (set_start_mm && *swap_map < swcount) {
 					mmput(new_start_mm);
 					atomic_inc(&mm->mm_users);
