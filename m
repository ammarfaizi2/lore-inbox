Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263815AbUDMXWb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Apr 2004 19:22:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263812AbUDMXWa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Apr 2004 19:22:30 -0400
Received: from fmr04.intel.com ([143.183.121.6]:12201 "EHLO
	caduceus.sc.intel.com") by vger.kernel.org with ESMTP
	id S263810AbUDMXVy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Apr 2004 19:21:54 -0400
Message-Id: <200404132320.i3DNKPF21194@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: <linux-kernel@vger.kernel.org>, <linux-ia64@vger.kernel.org>,
       <lse-tech@lists.sourceforge.net>
Cc: <raybry@sgi.com>, "'Andy Whitcroft'" <apw@shadowen.org>,
       "'Andrew Morton'" <akpm@osdl.org>
Subject: hugetlb demand paging patch part [1/3]
Date: Tue, 13 Apr 2004 16:20:26 -0700
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
Thread-Index: AcQhrebMIjYsrjceSWSIxitPjI1w0w==
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Part 1 of 3

1. hugetlb_fix_pte.patch - with demand paging, we can not unconditionally
   assume valid pmd/pte.  Fix it up in arch specific huge_pge_offset()
   and have all caller check the return value.


 i386/mm/hugetlbpage.c    |   11 +++++++----
 ia64/mm/hugetlbpage.c    |   18 ++++++++++++------
 sh/mm/hugetlbpage.c      |   15 +++++++--------
 sparc64/mm/hugetlbpage.c |   15 +++++++--------
 4 files changed, 33 insertions(+), 26 deletions(-)

diff -Nurp linux-2.6.5/arch/i386/mm/hugetlbpage.c linux-2.6.5.htlb/arch/i386/mm/hugetlbpage.c
--- linux-2.6.5/arch/i386/mm/hugetlbpage.c	2004-04-10 17:05:34.000000000 -0700
+++ linux-2.6.5.htlb/arch/i386/mm/hugetlbpage.c	2004-04-10 17:10:39.000000000 -0700
@@ -36,7 +36,8 @@ static pte_t *huge_pte_offset(struct mm_
 	pmd_t *pmd = NULL;

 	pgd = pgd_offset(mm, addr);
-	pmd = pmd_offset(pgd, addr);
+	if (pgd_present(*pgd))
+		pmd = pmd_offset(pgd, addr);
 	return (pte_t *) pmd;
 }

@@ -75,11 +76,13 @@ int copy_hugetlb_page_range(struct mm_st
 	unsigned long addr = vma->vm_start;
 	unsigned long end = vma->vm_end;

-	while (addr < end) {
+	for (; addr < end; addr+= HPAGE_SIZE) {
+		src_pte = huge_pte_offset(src, addr);
+		if (!src_pte || pte_none(*src_pte))
+			continue;
 		dst_pte = huge_pte_alloc(dst, addr);
 		if (!dst_pte)
 			goto nomem;
-		src_pte = huge_pte_offset(src, addr);
 		entry = *src_pte;
 		ptepage = pte_page(entry);
 		get_page(ptepage);
@@ -227,7 +230,7 @@ void unmap_hugepage_range(struct vm_area

 	for (address = start; address < end; address += HPAGE_SIZE) {
 		pte = huge_pte_offset(mm, address);
-		if (pte_none(*pte))
+		if (!pte || pte_none(*pte))
 			continue;
 		page = pte_page(*pte);
 		huge_page_release(page);
diff -Nurp linux-2.6.5/arch/ia64/mm/hugetlbpage.c linux-2.6.5.htlb/arch/ia64/mm/hugetlbpage.c
--- linux-2.6.5/arch/ia64/mm/hugetlbpage.c	2004-04-10 17:05:34.000000000 -0700
+++ linux-2.6.5.htlb/arch/ia64/mm/hugetlbpage.c	2004-04-10 17:10:29.000000000 -0700
@@ -48,8 +48,11 @@ huge_pte_offset (struct mm_struct *mm, u
 	pte_t *pte = NULL;

 	pgd = pgd_offset(mm, taddr);
-	pmd = pmd_offset(pgd, taddr);
-	pte = pte_offset_map(pmd, taddr);
+	if (pgd_present(*pgd)) {
+		pmd = pmd_offset(pgd, taddr);
+		if (pmd_present(*pmd))
+			pte = pte_offset_map(pmd, taddr);
+	}
 	return pte;
 }

@@ -95,17 +98,18 @@ int copy_hugetlb_page_range(struct mm_st
 	unsigned long addr = vma->vm_start;
 	unsigned long end = vma->vm_end;

-	while (addr < end) {
+	for (; addr < end; addr += HPAGE_SIZE) {
+		src_pte = huge_pte_offset(src, addr);
+		if (!src_pte || pte_none(*src_pte))
+			continue;
 		dst_pte = huge_pte_alloc(dst, addr);
 		if (!dst_pte)
 			goto nomem;
-		src_pte = huge_pte_offset(src, addr);
 		entry = *src_pte;
 		ptepage = pte_page(entry);
 		get_page(ptepage);
 		set_pte(dst_pte, entry);
 		dst->rss += (HPAGE_SIZE / PAGE_SIZE);
-		addr += HPAGE_SIZE;
 	}
 	return 0;
 nomem:
@@ -167,6 +171,8 @@ struct page *follow_huge_addr(struct mm_
 	pte_t *ptep;

 	ptep = huge_pte_offset(mm, addr);
+	if (!ptep || pte_none(*ptep))
+		return NULL;
 	page = pte_page(*ptep);
 	page += ((addr & ~HPAGE_MASK) >> PAGE_SHIFT);
 	get_page(page);
@@ -247,7 +253,7 @@ void unmap_hugepage_range(struct vm_area

 	for (address = start; address < end; address += HPAGE_SIZE) {
 		pte = huge_pte_offset(mm, address);
-		if (pte_none(*pte))
+		if (!pte || pte_none(*pte))
 			continue;
 		page = pte_page(*pte);
 		huge_page_release(page);
diff -Nurp linux-2.6.5/arch/sh/mm/hugetlbpage.c linux-2.6.5.htlb/arch/sh/mm/hugetlbpage.c
--- linux-2.6.5/arch/sh/mm/hugetlbpage.c	2004-04-10 17:05:34.000000000 -0700
+++ linux-2.6.5.htlb/arch/sh/mm/hugetlbpage.c	2004-04-10 17:45:40.000000000 -0700
@@ -46,9 +46,9 @@ static pte_t *huge_pte_offset(struct mm_
 	pte_t *pte = NULL;

 	pgd = pgd_offset(mm, addr);
-	if (pgd) {
+	if (pgd_present(*pgd)) {
 		pmd = pmd_offset(pgd, addr);
-		if (pmd)
+		if (pmd_present(*pmd))
 			pte = pte_offset_map(pmd, addr);
 	}
 	return pte;
@@ -101,12 +101,13 @@ int copy_hugetlb_page_range(struct mm_st
 	unsigned long end = vma->vm_end;
 	int i;

-	while (addr < end) {
+	for (; addr < end; addr += HPAGE_SIZE) {
+		src_pte = huge_pte_offset(src, addr);
+		if (!src_pte || pte_none(*src_pte))
+			continue;
 		dst_pte = huge_pte_alloc(dst, addr);
 		if (!dst_pte)
 			goto nomem;
-		src_pte = huge_pte_offset(src, addr);
-		BUG_ON(!src_pte || pte_none(*src_pte));
 		entry = *src_pte;
 		ptepage = pte_page(entry);
 		get_page(ptepage);
@@ -116,7 +117,6 @@ int copy_hugetlb_page_range(struct mm_st
 			dst_pte++;
 		}
 		dst->rss += (HPAGE_SIZE / PAGE_SIZE);
-		addr += HPAGE_SIZE;
 	}
 	return 0;

@@ -202,8 +202,7 @@ void unmap_hugepage_range(struct vm_area

 	for (address = start; address < end; address += HPAGE_SIZE) {
 		pte = huge_pte_offset(mm, address);
-		BUG_ON(!pte);
-		if (pte_none(*pte))
+		if (!pte || pte_none(*pte))
 			continue;
 		page = pte_page(*pte);
 		huge_page_release(page);
diff -Nurp linux-2.6.5/arch/sparc64/mm/hugetlbpage.c linux-2.6.5.htlb/arch/sparc64/mm/hugetlbpage.c
--- linux-2.6.5/arch/sparc64/mm/hugetlbpage.c	2004-04-10 17:05:34.000000000 -0700
+++ linux-2.6.5.htlb/arch/sparc64/mm/hugetlbpage.c	2004-04-10 17:44:04.000000000 -0700
@@ -43,9 +43,9 @@ static pte_t *huge_pte_offset(struct mm_
 	pte_t *pte = NULL;

 	pgd = pgd_offset(mm, addr);
-	if (pgd) {
+	if (pgd_present(*pgd)) {
 		pmd = pmd_offset(pgd, addr);
-		if (pmd)
+		if (pmd_present(*pmd))
 			pte = pte_offset_map(pmd, addr);
 	}
 	return pte;
@@ -98,12 +98,13 @@ int copy_hugetlb_page_range(struct mm_st
 	unsigned long end = vma->vm_end;
 	int i;

-	while (addr < end) {
+	for (; addr < end; addr += HPAGE_SIZE) {
+		src_pte = huge_pte_offset(src, addr);
+		if (!src_pte || pte_none(*src_pte))
+			continue;
 		dst_pte = huge_pte_alloc(dst, addr);
 		if (!dst_pte)
 			goto nomem;
-		src_pte = huge_pte_offset(src, addr);
-		BUG_ON(!src_pte || pte_none(*src_pte));
 		entry = *src_pte;
 		ptepage = pte_page(entry);
 		get_page(ptepage);
@@ -113,7 +114,6 @@ int copy_hugetlb_page_range(struct mm_st
 			dst_pte++;
 		}
 		dst->rss += (HPAGE_SIZE / PAGE_SIZE);
-		addr += HPAGE_SIZE;
 	}
 	return 0;

@@ -199,8 +199,7 @@ void unmap_hugepage_range(struct vm_area

 	for (address = start; address < end; address += HPAGE_SIZE) {
 		pte = huge_pte_offset(mm, address);
-		BUG_ON(!pte);
-		if (pte_none(*pte))
+		if (!pte || pte_none(*pte))
 			continue;
 		page = pte_page(*pte);
 		huge_page_release(page);


