Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263626AbUDFF2i (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 01:28:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263629AbUDFF2i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 01:28:38 -0400
Received: from ozlabs.org ([203.10.76.45]:65445 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S263626AbUDFF2e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 01:28:34 -0400
Date: Tue, 6 Apr 2004 15:25:38 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Andrew Morton <akpm@osdl.org>
Cc: Anton Blanchard <anton@samba.org>, Paul Mackerras <paulus@samba.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       linux-kernel@vger.kernel.org, linuxppc64-dev@lists.linuxppc.org
Subject: Yet another PPC64 hugepage bugfix
Message-ID: <20040406052538.GH15981@zax>
Mail-Followup-To: David Gibson <david@gibson.dropbear.id.au>,
	Andrew Morton <akpm@osdl.org>, Anton Blanchard <anton@samba.org>,
	Paul Mackerras <paulus@samba.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	linux-kernel@vger.kernel.org, linuxppc64-dev@lists.linuxppc.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew, please apply.  Found this again while looking at hugepage
extensions.  Haven't actually had it bite yet - the race is small and
the other bug will never be triggered in 32-bit processes, and the
function is rarely called on 64-bit processes.

This patch fixes two bugs in the (same part of the) PPC64 hugepage
code.  First the method we were using to free stale PTE pages was not
safe with some recent changes (race condition).  BenH has fixed this
to work in the new way.  Second, we were not checking for a valid PGD
entry before dereferencing the PMD page when scanning for stale PTE
page pointers.

===== arch/ppc64/mm/hugetlbpage.c 1.14 vs edited =====
Index: working-2.6/arch/ppc64/mm/hugetlbpage.c
===================================================================
--- working-2.6.orig/arch/ppc64/mm/hugetlbpage.c	2004-04-05 17:45:53.000000000 +1000
+++ working-2.6/arch/ppc64/mm/hugetlbpage.c	2004-04-06 15:09:29.383726856 +1000
@@ -247,6 +247,7 @@
 {
 	struct vm_area_struct *vma;
 	unsigned long addr;
+	struct mmu_gather *tlb;
 
 	if (mm->context.low_hpages)
 		return 0; /* The window is already open */
@@ -262,32 +263,39 @@
 
 	/* Clean up any leftover PTE pages in the region */
 	spin_lock(&mm->page_table_lock);
+	tlb = tlb_gather_mmu(mm, 0);
 	for (addr = TASK_HPAGE_BASE_32; addr < TASK_HPAGE_END_32;
 	     addr += PMD_SIZE) {
 		pgd_t *pgd = pgd_offset(mm, addr);
-		pmd_t *pmd = pmd_offset(pgd, addr);
-
-		if (! pmd_none(*pmd)) {
-			struct page *page = pmd_page(*pmd);
-			pte_t *pte = (pte_t *)pmd_page_kernel(*pmd);
-			int i;
-
-			/* No VMAs, so there should be no PTEs, check
-			 * just in case. */
-			for (i = 0; i < PTRS_PER_PTE; i++) {
-				BUG_ON(! pte_none(*pte));
-				pte++;
-			}
+		pmd_t *pmd;
+		struct page *page;
+		pte_t *pte;
+		int i;
 
+		if (pgd_none(*pgd))
+			continue;
+		pmd = pmd_offset(pgd, addr);
+		if (!pmd || pmd_none(*pmd))
+			continue;
+		if (pmd_bad(*pmd)) {
+			pmd_ERROR(*pmd);
 			pmd_clear(pmd);
-			pgtable_remove_rmap(page);
-			pte_free(page);
+			continue;
 		}
+		pte = (pte_t *)pmd_page_kernel(*pmd);
+		/* No VMAs, so there should be no PTEs, check just in case. */
+		for (i = 0; i < PTRS_PER_PTE; i++) {
+			BUG_ON(!pte_none(*pte));
+			pte++;
+		}
+		page = pmd_page(*pmd);
+		pmd_clear(pmd);
+		pgtable_remove_rmap(page);
+		pte_free_tlb(tlb, page);
 	}
+	tlb_finish_mmu(tlb, TASK_HPAGE_BASE_32, TASK_HPAGE_END_32);
 	spin_unlock(&mm->page_table_lock);
 
-	/* FIXME: do we need to scan for PTEs too? */
-
 	mm->context.low_hpages = 1;
 
 	/* the context change must make it to memory before the slbia,


-- 
David Gibson			| For every complex problem there is a
david AT gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson
