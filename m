Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262912AbTCYQuz>; Tue, 25 Mar 2003 11:50:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262933AbTCYQuz>; Tue, 25 Mar 2003 11:50:55 -0500
Received: from holomorphy.com ([66.224.33.161]:22946 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S262912AbTCYQuv>;
	Tue, 25 Mar 2003 11:50:51 -0500
Date: Tue, 25 Mar 2003 09:01:39 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: akpm@zip.com.au
Cc: linux-kernel@vger.kernel.org
Subject: fix unuse_pmd() OOM handling
Message-ID: <20030325170139.GK1350@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	akpm@zip.com.au, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix unuse_pmd() OOM handling for pte_chain_alloc() failures.
Unfortunately I'm not able to trigger anything more than light
swapping loads to test this with.


diff -urpN merge-2.5.66-8/mm/swapfile.c merge-2.5.66-9/mm/swapfile.c
--- merge-2.5.66-8/mm/swapfile.c	2003-03-24 14:00:09.000000000 -0800
+++ merge-2.5.66-9/mm/swapfile.c	2003-03-25 08:30:03.000000000 -0800
@@ -400,11 +400,10 @@ unuse_pte(struct vm_area_struct *vma, un
 /* mmlist_lock and vma->vm_mm->page_table_lock are held */
 static void unuse_pmd(struct vm_area_struct * vma, pmd_t *dir,
 	unsigned long address, unsigned long size, unsigned long offset,
-	swp_entry_t entry, struct page* page)
+	swp_entry_t entry, struct page* page, struct pte_chain **pte_chainp)
 {
 	pte_t * pte;
 	unsigned long end;
-	struct pte_chain *pte_chain = NULL;
 
 	if (pmd_none(*dir))
 		return;
@@ -420,24 +419,24 @@ static void unuse_pmd(struct vm_area_str
 	if (end > PMD_SIZE)
 		end = PMD_SIZE;
 	do {
-		/*
-		 * FIXME: handle pte_chain_alloc() failures
-		 */
-		if (pte_chain == NULL)
-			pte_chain = pte_chain_alloc(GFP_ATOMIC);
 		unuse_pte(vma, offset+address-vma->vm_start,
-				pte, entry, page, &pte_chain);
+				pte, entry, page, pte_chainp);
 		address += PAGE_SIZE;
 		pte++;
+		if (!*pte_chainp)
+			*pte_chainp = pte_chain_alloc(GFP_ATOMIC);
+		if (!*pte_chainp) {
+			pte_unmap(pte-1);
+			return;
+		}
 	} while (address && (address < end));
 	pte_unmap(pte - 1);
-	pte_chain_free(pte_chain);
 }
 
 /* mmlist_lock and vma->vm_mm->page_table_lock are held */
 static void unuse_pgd(struct vm_area_struct * vma, pgd_t *dir,
 	unsigned long address, unsigned long size,
-	swp_entry_t entry, struct page* page)
+	swp_entry_t entry, struct page* page, struct pte_chain **pte_chainp)
 {
 	pmd_t * pmd;
 	unsigned long offset, end;
@@ -459,7 +458,9 @@ static void unuse_pgd(struct vm_area_str
 		BUG();
 	do {
 		unuse_pmd(vma, pmd, address, end - address, offset, entry,
-			  page);
+			  page, pte_chainp);
+		if (!*pte_chainp)
+			return;
 		address = (address + PMD_SIZE) & PMD_MASK;
 		pmd++;
 	} while (address && (address < end));
@@ -467,21 +468,24 @@ static void unuse_pgd(struct vm_area_str
 
 /* mmlist_lock and vma->vm_mm->page_table_lock are held */
 static void unuse_vma(struct vm_area_struct * vma, pgd_t *pgdir,
-			swp_entry_t entry, struct page* page)
+			swp_entry_t entry, struct page* page,
+			struct pte_chain **pte_chainp)
 {
 	unsigned long start = vma->vm_start, end = vma->vm_end;
 
 	if (start >= end)
 		BUG();
 	do {
-		unuse_pgd(vma, pgdir, start, end - start, entry, page);
+		unuse_pgd(vma, pgdir, start, end - start, entry, page, pte_chainp);
+		if (!*pte_chainp)
+			return;
 		start = (start + PGDIR_SIZE) & PGDIR_MASK;
 		pgdir++;
 	} while (start && (start < end));
 }
 
-static void unuse_process(struct mm_struct * mm,
-			swp_entry_t entry, struct page* page)
+static void unuse_process(struct mm_struct *mm, swp_entry_t entry,
+			struct page *page, struct pte_chain **pte_chainp)
 {
 	struct vm_area_struct* vma;
 
@@ -491,7 +495,9 @@ static void unuse_process(struct mm_stru
 	spin_lock(&mm->page_table_lock);
 	for (vma = mm->mmap; vma; vma = vma->vm_next) {
 		pgd_t * pgd = pgd_offset(mm, vma->vm_start);
-		unuse_vma(vma, pgd, entry, page);
+		unuse_vma(vma, pgd, entry, page, pte_chainp);
+		if (!*pte_chainp)
+			break;
 	}
 	spin_unlock(&mm->page_table_lock);
 	return;
@@ -551,6 +557,11 @@ static int try_to_unuse(unsigned int typ
 	int retval = 0;
 	int reset_overflow = 0;
 	int shmem;
+	struct pte_chain *pte_chain = pte_chain_alloc(GFP_KERNEL);
+
+	/* if we can't get one to start with we appear to be screwed */
+	if (!pte_chain)
+		return -ENOMEM;
 
 	/*
 	 * When searching mms for an entry, a good strategy is to
@@ -638,7 +649,14 @@ static int try_to_unuse(unsigned int typ
 			if (start_mm == &init_mm)
 				shmem = shmem_unuse(entry, page);
 			else
-				unuse_process(start_mm, entry, page);
+				unuse_process(start_mm, entry, page, &pte_chain);
+			if (!pte_chain)
+				pte_chain = pte_chain_alloc(GFP_KERNEL);
+			if (!pte_chain) {
+				retval = -ENOMEM;
+				unlock_page(page);
+				break;
+			}
 		}
 		if (*swap_map > 1) {
 			int set_start_mm = (*swap_map >= swcount);
@@ -656,8 +674,22 @@ static int try_to_unuse(unsigned int typ
 					spin_unlock(&mmlist_lock);
 					shmem = shmem_unuse(entry, page);
 					spin_lock(&mmlist_lock);
-				} else
-					unuse_process(mm, entry, page);
+				} else {
+					unuse_process(mm, entry, page, &pte_chain);
+					if (!pte_chain)
+						pte_chain = pte_chain_alloc(GFP_ATOMIC);
+					if (!pte_chain) {
+						/* we hold a reference to mm */
+						spin_unlock(&mmlist_lock);
+						pte_chain = pte_chain_alloc(GFP_KERNEL);
+						if (!pte_chain) {
+							retval = -ENOMEM;
+							unlock_page(page);
+							goto swap_map_check;
+						}
+						spin_lock(&mmlist_lock);
+					}
+				}
 				if (set_start_mm && *swap_map < swcount) {
 					new_start_mm = mm;
 					set_start_mm = 0;
@@ -741,6 +773,8 @@ static int try_to_unuse(unsigned int typ
 		cond_resched();
 	}
 
+swap_map_check:
+	pte_chain_free(pte_chain);
 	mmput(start_mm);
 	if (reset_overflow) {
 		printk(KERN_WARNING "swapoff: cleared swap entry overflow\n");
