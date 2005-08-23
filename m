Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932270AbVHWSLi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932270AbVHWSLi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 14:11:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932269AbVHWSLi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 14:11:38 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.146]:11151 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932270AbVHWSLh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 14:11:37 -0400
Subject: Re: [Hugetlb x86] 2/3 Move stale pte check into huge_pte_alloc()
From: Adam Litke <agl@us.ibm.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1124819866.4415.13.camel@localhost.localdomain>
References: <1124819866.4415.13.camel@localhost.localdomain>
Content-Type: text/plain
Organization: IBM
Date: Tue, 23 Aug 2005 13:06:07 -0500
Message-Id: <1124820367.4415.18.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Initial Post (Wed, 17 Aug 2005)

This patch moves the
	if (! pte_none(*pte))
		hugetlb_clean_stale_pgtable(pte);
logic into huge_pte_alloc() so all of its callers can be immune to the bug
described by Kenneth Chen at http://lkml.org/lkml/2004/6/16/246

> It turns out there is a bug in hugetlb_prefault(): with 3 level page table,
> huge_pte_alloc() might return a pmd that points to a PTE page. It happens
> if the virtual address for hugetlb mmap is recycled from previously used
> normal page mmap. free_pgtables() might not scrub the pmd entry on
> munmap and hugetlb_prefault skips on any pmd presence regardless what type 
> it is.

Unless I am missing something, it seems more correct to place the check inside
huge_pte_alloc() to prevent a the same bug wherever a huge pte is allocated.
It also allows checking for this condition when lazily faulting huge pages
later in the series.

Diffed against 2.6.13-rc6

Signed-off-by: Adam Litke <agl@us.ibm.com>
---
 arch/i386/mm/hugetlbpage.c |   13 +++++++++++--
 mm/hugetlb.c               |    2 --
 2 files changed, 11 insertions(+), 4 deletions(-)
diff -upN reference/arch/i386/mm/hugetlbpage.c current/arch/i386/mm/hugetlbpage.c
--- reference/arch/i386/mm/hugetlbpage.c
+++ current/arch/i386/mm/hugetlbpage.c
@@ -22,12 +22,21 @@ pte_t *huge_pte_alloc(struct mm_struct *
 {
 	pgd_t *pgd;
 	pud_t *pud;
-	pmd_t *pmd = NULL;
+	pmd_t *pmd;
+	pte_t *pte = NULL;
 
 	pgd = pgd_offset(mm, addr);
 	pud = pud_alloc(mm, pgd, addr);
 	pmd = pmd_alloc(mm, pud, addr);
-	return (pte_t *) pmd;
+
+	if (!pmd)
+		goto out;
+	
+	pte = (pte_t *) pmd;
+	if (!pte_none(*pte) && !pte_huge(*pte))
+		hugetlb_clean_stale_pgtable(pte);
+out:
+	return pte;
 }
 
 pte_t *huge_pte_offset(struct mm_struct *mm, unsigned long addr)
diff -upN reference/mm/hugetlb.c current/mm/hugetlb.c
--- reference/mm/hugetlb.c
+++ current/mm/hugetlb.c
@@ -360,8 +360,6 @@ int hugetlb_prefault(struct address_spac
 			ret = -ENOMEM;
 			goto out;
 		}
-		if (! pte_none(*pte))
-			hugetlb_clean_stale_pgtable(pte);
 
 		idx = ((addr - vma->vm_start) >> HPAGE_SHIFT)
 			+ (vma->vm_pgoff >> (HPAGE_SHIFT - PAGE_SHIFT));


