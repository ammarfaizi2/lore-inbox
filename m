Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264256AbTCYWKv>; Tue, 25 Mar 2003 17:10:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262586AbTCYWJx>; Tue, 25 Mar 2003 17:09:53 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:51681 "EHLO
	mtvmime02.veritas.com") by vger.kernel.org with ESMTP
	id <S261461AbTCYWIr>; Tue, 25 Mar 2003 17:08:47 -0500
Date: Tue, 25 Mar 2003 22:21:51 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrew Morton <akpm@digeo.com>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] swap 11/13 fix unuse_pmd fixme
In-Reply-To: <Pine.LNX.4.44.0303252209070.12636-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0303252220420.12636-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

try_to_unuse drop mmlist_lock across unuse_process (with pretty dance
of atomic_incs and mmputs of various mmlist markers, and a polite new
cond_resched there), so unuse_process can pte_chain_alloc(GFP_KERNEL)
and pass that down and down and down and down to unuse_pte: which
cannot succeed more than once on a given mm (make that explicit by
returning back up once succeeded).  Preliminary checks moved up from
unuse_pte to unuse_pmd, and done more efficiently (avoid that extra
pte_file test added recently), swapoff spends far too long in here.
Updated locking comments and references to try_to_swap_out.

--- swap10/mm/swapfile.c	Sun Mar 23 10:30:15 2003
+++ swap11/mm/swapfile.c	Tue Mar 25 20:44:46 2003
@@ -377,42 +377,34 @@
  * share this swap entry, so be cautious and let do_wp_page work out
  * what to do if a write is requested later.
  */
-/* mmlist_lock and vma->vm_mm->page_table_lock are held */
+/* vma->vm_mm->page_table_lock is held */
 static void
 unuse_pte(struct vm_area_struct *vma, unsigned long address, pte_t *dir,
 	swp_entry_t entry, struct page *page, struct pte_chain **pte_chainp)
 {
-	pte_t pte = *dir;
-
-	if (pte_file(pte))
-		return;
-	if (likely(pte_to_swp_entry(pte).val != entry.val))
-		return;
-	if (unlikely(pte_none(pte) || pte_present(pte)))
-		return;
+	vma->vm_mm->rss++;
 	get_page(page);
 	set_pte(dir, pte_mkold(mk_pte(page, vma->vm_page_prot)));
 	SetPageAnon(page);
 	*pte_chainp = page_add_rmap(page, dir, *pte_chainp);
 	swap_free(entry);
-	++vma->vm_mm->rss;
 }
 
-/* mmlist_lock and vma->vm_mm->page_table_lock are held */
-static void unuse_pmd(struct vm_area_struct * vma, pmd_t *dir,
+/* vma->vm_mm->page_table_lock is held */
+static int unuse_pmd(struct vm_area_struct * vma, pmd_t *dir,
 	unsigned long address, unsigned long size, unsigned long offset,
-	swp_entry_t entry, struct page* page)
+	swp_entry_t entry, struct page *page, struct pte_chain **pte_chainp)
 {
 	pte_t * pte;
 	unsigned long end;
-	struct pte_chain *pte_chain = NULL;
+	pte_t swp_pte = swp_entry_to_pte(entry);
 
 	if (pmd_none(*dir))
-		return;
+		return 0;
 	if (pmd_bad(*dir)) {
 		pmd_ERROR(*dir);
 		pmd_clear(dir);
-		return;
+		return 0;
 	}
 	pte = pte_offset_map(dir, address);
 	offset += address & PMD_MASK;
@@ -422,33 +414,36 @@
 		end = PMD_SIZE;
 	do {
 		/*
-		 * FIXME: handle pte_chain_alloc() failures
+		 * swapoff spends a _lot_ of time in this loop!
+		 * Test inline before going to call unuse_pte.
 		 */
-		if (pte_chain == NULL)
-			pte_chain = pte_chain_alloc(GFP_ATOMIC);
-		unuse_pte(vma, offset+address-vma->vm_start,
-				pte, entry, page, &pte_chain);
+		if (unlikely(pte_same(*pte, swp_pte))) {
+			unuse_pte(vma, offset + address, pte,
+					entry, page, pte_chainp);
+			pte_unmap(pte);
+			return 1;
+		}
 		address += PAGE_SIZE;
 		pte++;
 	} while (address && (address < end));
 	pte_unmap(pte - 1);
-	pte_chain_free(pte_chain);
+	return 0;
 }
 
-/* mmlist_lock and vma->vm_mm->page_table_lock are held */
-static void unuse_pgd(struct vm_area_struct * vma, pgd_t *dir,
+/* vma->vm_mm->page_table_lock is held */
+static int unuse_pgd(struct vm_area_struct * vma, pgd_t *dir,
 	unsigned long address, unsigned long size,
-	swp_entry_t entry, struct page* page)
+	swp_entry_t entry, struct page *page, struct pte_chain **pte_chainp)
 {
 	pmd_t * pmd;
 	unsigned long offset, end;
 
 	if (pgd_none(*dir))
-		return;
+		return 0;
 	if (pgd_bad(*dir)) {
 		pgd_ERROR(*dir);
 		pgd_clear(dir);
-		return;
+		return 0;
 	}
 	pmd = pmd_offset(dir, address);
 	offset = address & PGDIR_MASK;
@@ -459,32 +454,42 @@
 	if (address >= end)
 		BUG();
 	do {
-		unuse_pmd(vma, pmd, address, end - address, offset, entry,
-			  page);
+		if (unuse_pmd(vma, pmd, address, end - address,
+				offset, entry, page, pte_chainp))
+			return 1;
 		address = (address + PMD_SIZE) & PMD_MASK;
 		pmd++;
 	} while (address && (address < end));
+	return 0;
 }
 
-/* mmlist_lock and vma->vm_mm->page_table_lock are held */
-static void unuse_vma(struct vm_area_struct * vma, pgd_t *pgdir,
-			swp_entry_t entry, struct page* page)
+/* vma->vm_mm->page_table_lock is held */
+static int unuse_vma(struct vm_area_struct * vma, pgd_t *pgdir,
+	swp_entry_t entry, struct page *page, struct pte_chain **pte_chainp)
 {
 	unsigned long start = vma->vm_start, end = vma->vm_end;
 
 	if (start >= end)
 		BUG();
 	do {
-		unuse_pgd(vma, pgdir, start, end - start, entry, page);
+		if (unuse_pgd(vma, pgdir, start, end - start,
+				entry, page, pte_chainp))
+			return 1;
 		start = (start + PGDIR_SIZE) & PGDIR_MASK;
 		pgdir++;
 	} while (start && (start < end));
+	return 0;
 }
 
-static void unuse_process(struct mm_struct * mm,
+static int unuse_process(struct mm_struct * mm,
 			swp_entry_t entry, struct page* page)
 {
 	struct vm_area_struct* vma;
+	struct pte_chain *pte_chain;
+
+	pte_chain = pte_chain_alloc(GFP_KERNEL);
+	if (!pte_chain)
+		return -ENOMEM;
 
 	/*
 	 * Go through process' page directory.
@@ -492,10 +497,12 @@
 	spin_lock(&mm->page_table_lock);
 	for (vma = mm->mmap; vma; vma = vma->vm_next) {
 		pgd_t * pgd = pgd_offset(mm, vma->vm_start);
-		unuse_vma(vma, pgd, entry, page);
+		if (unuse_vma(vma, pgd, entry, page, &pte_chain))
+			break;
 	}
 	spin_unlock(&mm->page_table_lock);
-	return;
+	pte_chain_free(pte_chain);
+	return 0;
 }
 
 /*
@@ -639,36 +646,54 @@
 			if (start_mm == &init_mm)
 				shmem = shmem_unuse(entry, page);
 			else
-				unuse_process(start_mm, entry, page);
+				retval = unuse_process(start_mm, entry, page);
 		}
 		if (*swap_map > 1) {
 			int set_start_mm = (*swap_map >= swcount);
 			struct list_head *p = &start_mm->mmlist;
 			struct mm_struct *new_start_mm = start_mm;
+			struct mm_struct *prev_mm = start_mm;
 			struct mm_struct *mm;
 
+			atomic_inc(&new_start_mm->mm_users);
+			atomic_inc(&prev_mm->mm_users);
 			spin_lock(&mmlist_lock);
-			while (*swap_map > 1 &&
+			while (*swap_map > 1 && !retval &&
 					(p = p->next) != &start_mm->mmlist) {
 				mm = list_entry(p, struct mm_struct, mmlist);
+				atomic_inc(&mm->mm_users);
+				spin_unlock(&mmlist_lock);
+				mmput(prev_mm);
+				prev_mm = mm;
+
+				cond_resched();
+
 				swcount = *swap_map;
-				if (mm == &init_mm) {
+				if (swcount <= 1)
+					;
+				else if (mm == &init_mm) {
 					set_start_mm = 1;
-					spin_unlock(&mmlist_lock);
 					shmem = shmem_unuse(entry, page);
-					spin_lock(&mmlist_lock);
 				} else
-					unuse_process(mm, entry, page);
+					retval = unuse_process(mm, entry, page);
 				if (set_start_mm && *swap_map < swcount) {
+					mmput(new_start_mm);
+					atomic_inc(&mm->mm_users);
 					new_start_mm = mm;
 					set_start_mm = 0;
 				}
+				spin_lock(&mmlist_lock);
 			}
-			atomic_inc(&new_start_mm->mm_users);
 			spin_unlock(&mmlist_lock);
+			mmput(prev_mm);
 			mmput(start_mm);
 			start_mm = new_start_mm;
 		}
+		if (retval) {
+			unlock_page(page);
+			page_cache_release(page);
+			break;
+		}
 
 		/*
 		 * How could swap count reach 0x7fff when the maximum
@@ -692,7 +717,7 @@
 
 		/*
 		 * If a reference remains (rare), we would like to leave
-		 * the page in the swap cache; but try_to_swap_out could
+		 * the page in the swap cache; but try_to_unmap could
 		 * then re-duplicate the entry once we drop page lock,
 		 * so we might loop indefinitely; also, that page could
 		 * not be swapped out to other storage meanwhile.  So:
@@ -728,7 +753,7 @@
 		/*
 		 * So we could skip searching mms once swap count went
 		 * to 1, we did not mark any present ptes as dirty: must
-		 * mark page dirty so try_to_swap_out will preserve it.
+		 * mark page dirty so shrink_list will preserve it.
 		 */
 		SetPageDirty(page);
 		unlock_page(page);

