Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262450AbUDPGYU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 02:24:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262462AbUDPGYU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 02:24:20 -0400
Received: from ozlabs.org ([203.10.76.45]:42139 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S262450AbUDPGYJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 02:24:09 -0400
Date: Fri, 16 Apr 2004 16:22:15 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Kill off hugepage_vma()
Message-ID: <20040416062215.GF26707@zax>
Mail-Followup-To: David Gibson <david@gibson.dropbear.id.au>,
	"Chen, Kenneth W" <kenneth.w.chen@intel.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kenneth, does the patch below look reasonable?  It's close to trivial
on everything except IA64, which I can't easily test on.  Actually, it
occurs to me that this may even fix a bug on IA64 - if follow_page()
was called on an address in region 1 that wasn't in a VMA, then I
think it would attempt to follow it as a normal page, which sounds
bad.

If you think it is sane, I intend to push to akpm.

hugepage_vma() is both misleadingly named and unnecessary.  On most
archs it always returns NULL, and on IA64 the vma it returns is never
used.  The function's real purpose is to determine whether the address
it is passed is a special hugepage address which must be looked up in
hugepage pagetables, rather than being looked up in the normal
pagetables (which might have specially marked hugepage PMDs or PTEs).

This patch kills off hugepage_vma() and folds the logic it really
needs into follow_huge_addr().  That now returns a (page *) if called
on a special hugepage address, and an error encoded with ERR_PTR
otherwise.  This also requires tweaking the IA64 code to check that
the hugepage PTE is present in follow_huge_addr() - previously this
was guaranteed, since it was only called if the address was in an
existing hugepage VMA, and hugepages are always prefaulted.

Index: working-2.6/include/linux/hugetlb.h
===================================================================
--- working-2.6.orig/include/linux/hugetlb.h	2004-04-13 11:42:41.000000000 +1000
+++ working-2.6/include/linux/hugetlb.h	2004-04-16 15:33:18.113820400 +1000
@@ -20,10 +20,8 @@
 int hugetlb_report_meminfo(char *);
 int is_hugepage_mem_enough(size_t);
 unsigned long hugetlb_total_pages(void);
-struct page *follow_huge_addr(struct mm_struct *mm, struct vm_area_struct *vma,
-			unsigned long address, int write);
-struct vm_area_struct *hugepage_vma(struct mm_struct *mm,
-					unsigned long address);
+struct page *follow_huge_addr(struct mm_struct *mm, unsigned long address,
+			      int write);
 struct page *follow_huge_pmd(struct mm_struct *mm, unsigned long address,
 				pmd_t *pmd, int write);
 int is_aligned_hugepage_range(unsigned long addr, unsigned long len);
@@ -65,7 +63,7 @@
 }
 
 #define follow_hugetlb_page(m,v,p,vs,a,b,i)	({ BUG(); 0; })
-#define follow_huge_addr(mm, vma, addr, write)	0
+#define follow_huge_addr(mm, addr, write)	ERR_PTR(-EINVAL)
 #define copy_hugetlb_page_range(src, dst, vma)	({ BUG(); 0; })
 #define hugetlb_prefault(mapping, vma)		({ BUG(); 0; })
 #define zap_hugepage_range(vma, start, len)	BUG()
@@ -73,7 +71,6 @@
 #define huge_page_release(page)			BUG()
 #define is_hugepage_mem_enough(size)		0
 #define hugetlb_report_meminfo(buf)		0
-#define hugepage_vma(mm, addr)			0
 #define mark_mm_hugetlb(mm, vma)		do { } while (0)
 #define follow_huge_pmd(mm, addr, pmd, write)	0
 #define is_aligned_hugepage_range(addr, len)	0
Index: working-2.6/mm/memory.c
===================================================================
--- working-2.6.orig/mm/memory.c	2004-04-13 11:42:42.000000000 +1000
+++ working-2.6/mm/memory.c	2004-04-16 15:32:59.170904152 +1000
@@ -629,11 +629,11 @@
 	pmd_t *pmd;
 	pte_t *ptep, pte;
 	unsigned long pfn;
-	struct vm_area_struct *vma;
+	struct page *page;
 
-	vma = hugepage_vma(mm, address);
-	if (vma)
-		return follow_huge_addr(mm, vma, address, write);
+	page = follow_huge_addr(mm, address, write);
+	if (! IS_ERR(page))
+		return page;
 
 	pgd = pgd_offset(mm, address);
 	if (pgd_none(*pgd) || pgd_bad(*pgd))
Index: working-2.6/arch/ppc64/mm/hugetlbpage.c
===================================================================
--- working-2.6.orig/arch/ppc64/mm/hugetlbpage.c	2004-04-16 15:26:41.000000000 +1000
+++ working-2.6/arch/ppc64/mm/hugetlbpage.c	2004-04-16 15:34:27.000000000 +1000
@@ -335,15 +335,9 @@
 }
 
 struct page *
-follow_huge_addr(struct mm_struct *mm,
-	struct vm_area_struct *vma, unsigned long address, int write)
+follow_huge_addr(struct mm_struct *mm, unsigned long address, int write)
 {
-	return NULL;
-}
-
-struct vm_area_struct *hugepage_vma(struct mm_struct *mm, unsigned long addr)
-{
-	return NULL;
+	return ERR_PTR(-EINVAL);
 }
 
 int pmd_huge(pmd_t pmd)
Index: working-2.6/arch/i386/mm/hugetlbpage.c
===================================================================
--- working-2.6.orig/arch/i386/mm/hugetlbpage.c	2004-04-16 15:26:37.000000000 +1000
+++ working-2.6/arch/i386/mm/hugetlbpage.c	2004-04-16 15:39:55.000000000 +1000
@@ -140,32 +140,31 @@
 
 #if 0	/* This is just for testing */
 struct page *
-follow_huge_addr(struct mm_struct *mm,
-	struct vm_area_struct *vma, unsigned long address, int write)
+follow_huge_addr(struct mm_struct *mm, unsigned long address, int write)
 {
 	unsigned long start = address;
 	int length = 1;
 	int nr;
 	struct page *page;
+	struct vm_area_struct *vma;
 
-	nr = follow_hugetlb_page(mm, vma, &page, NULL, &start, &length, 0);
-	if (nr == 1)
-		return page;
-	return NULL;
-}
+	if (! mm->used_hugetlb)
+		return ERR_PTR(-EINVAL);
 
-/*
- * If virtual address `addr' lies within a huge page, return its controlling
- * VMA, else NULL.
- */
-struct vm_area_struct *hugepage_vma(struct mm_struct *mm, unsigned long addr)
-{
-	if (mm->used_hugetlb) {
-		struct vm_area_struct *vma = find_vma(mm, addr);
-		if (vma && is_vm_hugetlb_page(vma))
-			return vma;
-	}
-	return NULL;
+	vma = find_vma(mm, addr);
+	if (!vma || !is_vm_hugetlb_page(vma))
+		return ERR_PTR(-EINVAL);
+
+	pte = huge_pte_offset(mm, address);
+
+	/* hugetlb should be locked, and hence, prefaulted */
+	WARN_ON(!pte || pte_none(*pte));
+
+	page = &pte_page(*pte)[vpfn % (HPAGE_SIZE/PAGE_SIZE)];
+
+	WARN_ON(!PageCompound(page));
+
+	return page;
 }
 
 int pmd_huge(pmd_t pmd)
@@ -183,15 +182,9 @@
 #else
 
 struct page *
-follow_huge_addr(struct mm_struct *mm,
-	struct vm_area_struct *vma, unsigned long address, int write)
+follow_huge_addr(struct mm_struct *mm, unsigned long address, int write)
 {
-	return NULL;
-}
-
-struct vm_area_struct *hugepage_vma(struct mm_struct *mm, unsigned long addr)
-{
-	return NULL;
+	return ERR_PTR(-EINVAL);
 }
 
 int pmd_huge(pmd_t pmd)
Index: working-2.6/arch/ia64/mm/hugetlbpage.c
===================================================================
--- working-2.6.orig/arch/ia64/mm/hugetlbpage.c	2004-04-16 15:26:37.000000000 +1000
+++ working-2.6/arch/ia64/mm/hugetlbpage.c	2004-04-16 15:43:06.000000000 +1000
@@ -49,8 +49,12 @@
 	pte_t *pte = NULL;
 
 	pgd = pgd_offset(mm, taddr);
-	pmd = pmd_offset(pgd, taddr);
-	pte = pte_offset_map(pmd, taddr);
+	if (pgd_present(*pgd)) {
+		pmd = pmd_offset(pgd, taddr);
+		if (pmd_present(*pmd))
+			pte = pte_offset_map(pmd, taddr);
+	}
+
 	return pte;
 }
 
@@ -150,24 +154,19 @@
 	return i;
 }
 
-struct vm_area_struct *hugepage_vma(struct mm_struct *mm, unsigned long addr)
-{
-	if (mm->used_hugetlb) {
-		if (REGION_NUMBER(addr) == REGION_HPAGE) {
-			struct vm_area_struct *vma = find_vma(mm, addr);
-			if (vma && is_vm_hugetlb_page(vma))
-				return vma;
-		}
-	}
-	return NULL;
-}
-
-struct page *follow_huge_addr(struct mm_struct *mm, struct vm_area_struct *vma, unsigned long addr, int write)
+struct page *follow_huge_addr(struct mm_struct *mm, unsigned long addr, int write)
 {
 	struct page *page;
 	pte_t *ptep;
 
+	if (! mm->used_hugetlb)
+		return ERR_PTR(-EINVAL);
+	if (REGION_NUMBER(addr) != REGION_HPAGE)
+		return ERR_PTR(-EINVAL);
+
 	ptep = huge_pte_offset(mm, addr);
+	if (!ptep || pte_none(*ptep))
+		return NULL;
 	page = pte_page(*ptep);
 	page += ((addr & ~HPAGE_MASK) >> PAGE_SHIFT);
 	return page;
Index: working-2.6/arch/sparc64/mm/hugetlbpage.c
===================================================================
--- working-2.6.orig/arch/sparc64/mm/hugetlbpage.c	2004-04-16 10:43:02.000000000 +1000
+++ working-2.6/arch/sparc64/mm/hugetlbpage.c	2004-04-16 15:48:36.000000000 +1000
@@ -164,15 +164,9 @@
 }
 
 struct page *follow_huge_addr(struct mm_struct *mm,
-			      struct vm_area_struct *vma,
 			      unsigned long address, int write)
 {
-	return NULL;
-}
-
-struct vm_area_struct *hugepage_vma(struct mm_struct *mm, unsigned long addr)
-{
-	return NULL;
+	return ERR_PTR(-EINVAL);
 }
 
 int pmd_huge(pmd_t pmd)
Index: working-2.6/arch/sh/mm/hugetlbpage.c
===================================================================
--- working-2.6.orig/arch/sh/mm/hugetlbpage.c	2004-04-13 11:42:35.000000000 +1000
+++ working-2.6/arch/sh/mm/hugetlbpage.c	2004-04-16 15:48:31.000000000 +1000
@@ -166,15 +166,9 @@
 }
 
 struct page *follow_huge_addr(struct mm_struct *mm,
-			      struct vm_area_struct *vma,
 			      unsigned long address, int write)
 {
-	return NULL;
-}
-
-struct vm_area_struct *hugepage_vma(struct mm_struct *mm, unsigned long addr)
-{
-	return NULL;
+	return ERR_PTR(-EINVAL);
 }
 
 int pmd_huge(pmd_t pmd)



-- 
David Gibson			| For every complex problem there is a
david AT gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson
