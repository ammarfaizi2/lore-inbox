Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261653AbVFFTwW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261653AbVFFTwW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Jun 2005 15:52:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261642AbVFFTuw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Jun 2005 15:50:52 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:16053 "EHLO
	MTVMIME03.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S261650AbVFFTtG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Jun 2005 15:49:06 -0400
Date: Mon, 6 Jun 2005 20:49:38 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Andrew Morton <akpm@osdl.org>
cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] mbind: check_range use standard ptwalk
In-Reply-To: <Pine.LNX.4.61.0506062046590.5000@goblin.wat.veritas.com>
Message-ID: <Pine.LNX.4.61.0506062048430.5000@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0506062046590.5000@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
X-OriginalArrivalTime: 06 Jun 2005 19:48:38.0074 (UTC) 
    FILETIME=[BB75F9A0:01C56AD0]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Strict mbind's check for currently mapped pages being on node has been
using a slow loop which re-evaluates pgd, pud, pmd, pte for each entry:
replace that by a standard four-level page table walk like others in mm.
Since mmap_sem is held for writing, page_table_lock can be taken at the
inner level to limit latency.

Signed-off-by: Hugh Dickins <hugh@veritas.com>
---

 mm/mempolicy.c |  115 ++++++++++++++++++++++++++++++++++-----------------------
 1 files changed, 70 insertions(+), 45 deletions(-)

--- 2.6.12-rc6+/mm/mempolicy.c	2005-06-04 20:41:55.000000000 +0100
+++ linux/mm/mempolicy.c	2005-06-04 20:42:00.000000000 +0100
@@ -238,56 +238,81 @@ static struct mempolicy *mpol_new(int mo
 }
 
 /* Ensure all existing pages follow the policy. */
-static int
-verify_pages(struct mm_struct *mm,
-	     unsigned long addr, unsigned long end, unsigned long *nodes)
+static int check_pte_range(struct mm_struct *mm, pmd_t *pmd,
+		unsigned long addr, unsigned long end, unsigned long *nodes)
 {
-	int err = 0;
+	pte_t *orig_pte;
+	pte_t *pte;
 
 	spin_lock(&mm->page_table_lock);
-	while (addr < end) {
-		struct page *p;
-		pte_t *pte;
-		pmd_t *pmd;
-		pud_t *pud;
-		pgd_t *pgd;
-		pgd = pgd_offset(mm, addr);
-		if (pgd_none(*pgd)) {
-			unsigned long next = (addr + PGDIR_SIZE) & PGDIR_MASK;
-			if (next > addr)
-				break;
-			addr = next;
-			continue;
-		}
-		pud = pud_offset(pgd, addr);
-		if (pud_none(*pud)) {
-			addr = (addr + PUD_SIZE) & PUD_MASK;
+	orig_pte = pte = pte_offset_map(pmd, addr);
+	do {
+		unsigned long pfn;
+		unsigned int nid;
+
+		if (!pte_present(*pte))
 			continue;
-		}
-		pmd = pmd_offset(pud, addr);
-		if (pmd_none(*pmd)) {
-			addr = (addr + PMD_SIZE) & PMD_MASK;
+		pfn = pte_pfn(*pte);
+		if (!pfn_valid(pfn))
 			continue;
-		}
-		p = NULL;
-		pte = pte_offset_map(pmd, addr);
-		if (pte_present(*pte)) {
-			unsigned long pfn = pte_pfn(*pte);
-			if (pfn_valid(pfn))
-				p = pfn_to_page(pfn);
-		}
-		pte_unmap(pte);
-		if (p) {
-			unsigned nid = page_to_nid(p);
-			if (!test_bit(nid, nodes)) {
-				err = -EIO;
-				break;
-			}
-		}
-		addr += PAGE_SIZE;
-	}
+		nid = pfn_to_nid(pfn);
+		if (!test_bit(nid, nodes))
+			break;
+	} while (pte++, addr += PAGE_SIZE, addr != end);
+	pte_unmap(orig_pte);
 	spin_unlock(&mm->page_table_lock);
-	return err;
+	return addr != end;
+}
+
+static inline int check_pmd_range(struct mm_struct *mm, pud_t *pud,
+		unsigned long addr, unsigned long end, unsigned long *nodes)
+{
+	pmd_t *pmd;
+	unsigned long next;
+
+	pmd = pmd_offset(pud, addr);
+	do {
+		next = pmd_addr_end(addr, end);
+		if (pmd_none_or_clear_bad(pmd))
+			continue;
+		if (check_pte_range(mm, pmd, addr, next, nodes))
+			return -EIO;
+	} while (pmd++, addr = next, addr != end);
+	return 0;
+}
+
+static inline int check_pud_range(struct mm_struct *mm, pgd_t *pgd,
+		unsigned long addr, unsigned long end, unsigned long *nodes)
+{
+	pud_t *pud;
+	unsigned long next;
+
+	pud = pud_offset(pgd, addr);
+	do {
+		next = pud_addr_end(addr, end);
+		if (pud_none_or_clear_bad(pud))
+			continue;
+		if (check_pmd_range(mm, pud, addr, next, nodes))
+			return -EIO;
+	} while (pud++, addr = next, addr != end);
+	return 0;
+}
+
+static inline int check_pgd_range(struct mm_struct *mm,
+		unsigned long addr, unsigned long end, unsigned long *nodes)
+{
+	pgd_t *pgd;
+	unsigned long next;
+
+	pgd = pgd_offset(mm, addr);
+	do {
+		next = pgd_addr_end(addr, end);
+		if (pgd_none_or_clear_bad(pgd))
+			continue;
+		if (check_pud_range(mm, pgd, addr, next, nodes))
+			return -EIO;
+	} while (pgd++, addr = next, addr != end);
+	return 0;
 }
 
 /* Step 1: check the range */
@@ -308,7 +333,7 @@ check_range(struct mm_struct *mm, unsign
 		if (prev && prev->vm_end < vma->vm_start)
 			return ERR_PTR(-EFAULT);
 		if ((flags & MPOL_MF_STRICT) && !is_vm_hugetlb_page(vma)) {
-			err = verify_pages(vma->vm_mm,
+			err = check_pgd_range(vma->vm_mm,
 					   vma->vm_start, vma->vm_end, nodes);
 			if (err) {
 				first = ERR_PTR(err);
