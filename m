Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263072AbVGIB4r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263072AbVGIB4r (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 21:56:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263073AbVGIB4q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 21:56:46 -0400
Received: from gold.veritas.com ([143.127.12.110]:59657 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S263072AbVGIB4S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 21:56:18 -0400
Date: Sat, 9 Jul 2005 02:57:39 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Andrew Morton <akpm@osdl.org>
cc: Mauricio Lin <mauriciolin@gmail.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] smaps use new ptwalks
In-Reply-To: <Pine.LNX.4.61.0507090253270.15778@goblin.wat.veritas.com>
Message-ID: <Pine.LNX.4.61.0507090256430.15778@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0507090253270.15778@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 09 Jul 2005 01:56:17.0915 (UTC) FILETIME=[655E94B0:01C58429]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

/proc/$pid/smaps code was based on the old ptwalking style just as we
converted over to the p?d_addr_end style: convert it to the new style.

Do an easy cond_resched_lock at the end of each page table: looking at
the struct page of every pte will be heavy on the cache, and others are
likely to hack on this example, so better limit its still poor latency.

Signed-off-by: Hugh Dickins <hugh@veritas.com>
---

 fs/proc/task_mmu.c |  150 ++++++++++++++++++++---------------------------------
 1 files changed, 58 insertions(+), 92 deletions(-)

--- smaps1/fs/proc/task_mmu.c	2005-07-09 02:14:05.000000000 +0100
+++ smaps2/fs/proc/task_mmu.c	2005-07-09 02:29:33.000000000 +0100
@@ -158,120 +158,88 @@ struct mem_size_stats
 	unsigned long private_dirty;
 };
 
-static void smaps_pte_range(pmd_t *pmd,
-			    unsigned long address,
-			    unsigned long size,
-			    struct mem_size_stats *mss)
+static void smaps_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
+				unsigned long addr, unsigned long end,
+				struct mem_size_stats *mss)
 {
-	pte_t *ptep, pte;
-	unsigned long end;
+	pte_t *pte, ptent;
 	unsigned long pfn;
 	struct page *page;
 
-	if (pmd_none(*pmd))
-		return;
-	if (unlikely(pmd_bad(*pmd))) {
-		pmd_ERROR(*pmd);
-		pmd_clear(pmd);
-		return;
-	}
-	ptep = pte_offset_map(pmd, address);
-	address &= ~PMD_MASK;
-	end = address + size;
-	if (end > PMD_SIZE)
-		end = PMD_SIZE;
+	pte = pte_offset_map(pmd, addr);
 	do {
-		pte = *ptep;
-		address += PAGE_SIZE;
-		ptep++;
-
-		if (pte_none(pte) || (!pte_present(pte)))
+		ptent = *pte;
+		if (pte_none(ptent) || !pte_present(ptent))
 			continue;
 
 		mss->resident += PAGE_SIZE;
-		pfn = pte_pfn(pte);
-		if (pfn_valid(pfn)) {
-			page = pfn_to_page(pfn);
-			if (page_count(page) >= 2) {
-				if (pte_dirty(pte))
-					mss->shared_dirty += PAGE_SIZE;
-				else
-					mss->shared_clean += PAGE_SIZE;
-			} else {
-				if (pte_dirty(pte))
-					mss->private_dirty += PAGE_SIZE;
-				else
-					mss->private_clean += PAGE_SIZE;
-			}
+		pfn = pte_pfn(ptent);
+		if (!pfn_valid(pfn))
+			continue;
+
+		page = pfn_to_page(pfn);
+		if (page_count(page) >= 2) {
+			if (pte_dirty(ptent))
+				mss->shared_dirty += PAGE_SIZE;
+			else
+				mss->shared_clean += PAGE_SIZE;
+		} else {
+			if (pte_dirty(ptent))
+				mss->private_dirty += PAGE_SIZE;
+			else
+				mss->private_clean += PAGE_SIZE;
 		}
-	} while (address < end);
-	pte_unmap(ptep - 1);
+	} while (pte++, addr += PAGE_SIZE, addr != end);
+	pte_unmap(pte - 1);
+	cond_resched_lock(&vma->vm_mm->page_table_lock);
 }
 
-static void smaps_pmd_range(pud_t *pud,
-			    unsigned long address,
-			    unsigned long size,
-			    struct mem_size_stats *mss)
+static inline void smaps_pmd_range(struct vm_area_struct *vma, pud_t *pud,
+				unsigned long addr, unsigned long end,
+				struct mem_size_stats *mss)
 {
 	pmd_t *pmd;
-	unsigned long end;
+	unsigned long next;
 
-	if (pud_none(*pud))
-		return;
-	if (unlikely(pud_bad(*pud))) {
-		pud_ERROR(*pud);
-		pud_clear(pud);
-		return;
-	}
-	pmd = pmd_offset(pud, address);
-	address &= ~PUD_MASK;
-	end = address + size;
-	if (end > PUD_SIZE)
-		end = PUD_SIZE;
+	pmd = pmd_offset(pud, addr);
 	do {
-		smaps_pte_range(pmd, address, end - address, mss);
-		address = (address + PMD_SIZE) & PMD_MASK;
-		pmd++;
-	} while (address < end);
+		next = pmd_addr_end(addr, end);
+		if (pmd_none_or_clear_bad(pmd))
+			continue;
+		smaps_pte_range(vma, pmd, addr, next, mss);
+	} while (pmd++, addr = next, addr != end);
 }
 
-static void smaps_pud_range(pgd_t *pgd,
-			    unsigned long address,
-			    unsigned long size,
-			    struct mem_size_stats *mss)
+static inline void smaps_pud_range(struct vm_area_struct *vma, pgd_t *pgd,
+				unsigned long addr, unsigned long end,
+				struct mem_size_stats *mss)
 {
 	pud_t *pud;
-	unsigned long end;
+	unsigned long next;
 
-	if (pgd_none(*pgd))
-		return;
-	if (unlikely(pgd_bad(*pgd))) {
-		pgd_ERROR(*pgd);
-		pgd_clear(pgd);
-		return;
-	}
-	pud = pud_offset(pgd, address);
-	address &= ~PGDIR_MASK;
-	end = address + size;
-	if (end > PGDIR_SIZE)
-		end = PGDIR_SIZE;
+	pud = pud_offset(pgd, addr);
 	do {
-		smaps_pmd_range(pud, address, end - address, mss);
-		address = (address + PUD_SIZE) & PUD_MASK;
-		pud++;
-	} while (address < end);
+		next = pud_addr_end(addr, end);
+		if (pud_none_or_clear_bad(pud))
+			continue;
+		smaps_pmd_range(vma, pud, addr, next, mss);
+	} while (pud++, addr = next, addr != end);
 }
 
-static void smaps_pgd_range(pgd_t *pgd,
-			    unsigned long start_address,
-			    unsigned long end_address,
-			    struct mem_size_stats *mss)
+static inline void smaps_pgd_range(struct vm_area_struct *vma,
+				unsigned long addr, unsigned long end,
+				struct mem_size_stats *mss)
 {
+	pgd_t *pgd;
+	unsigned long next;
+
+	pgd = pgd_offset(vma->vm_mm, addr);
 	do {
-		smaps_pud_range(pgd, start_address, end_address - start_address, mss);
-		start_address = (start_address + PGDIR_SIZE) & PGDIR_MASK;
-		pgd++;
-	} while (start_address < end_address);
+		next = pgd_addr_end(addr, end);
+		if (pgd_none_or_clear_bad(pgd))
+			continue;
+		smaps_pud_range(vma, pgd, addr, next, mss);
+	} while (pgd++, addr = next, addr != end);
 }
 
 static int show_smap(struct seq_file *m, void *v)
@@ -286,10 +254,8 @@ static int show_smap(struct seq_file *m,
 	memset(&mss, 0, sizeof mss);
 
 	if (mm) {
-		pgd_t *pgd;
 		spin_lock(&mm->page_table_lock);
-		pgd = pgd_offset(mm, vma->vm_start);
-		smaps_pgd_range(pgd, vma->vm_start, vma->vm_end, &mss);
+		smaps_pgd_range(vma, vma->vm_start, vma->vm_end, &mss);
 		spin_unlock(&mm->page_table_lock);
 	}
 
