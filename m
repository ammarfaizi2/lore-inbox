Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263905AbUDPWTI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 18:19:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263919AbUDPWQt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 18:16:49 -0400
Received: from fmr04.intel.com ([143.183.121.6]:54663 "EHLO
	caduceus.sc.intel.com") by vger.kernel.org with ESMTP
	id S263905AbUDPWOy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 18:14:54 -0400
Message-Id: <200404162214.i3GMEdF22343@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'David Gibson'" <david@gibson.dropbear.id.au>
Cc: "Andrew Morton" <akpm@osdl.org>, <linux-kernel@vger.kernel.org>,
       <linux-ia64@vger.kernel.org>
Subject: RE: Kill off hugepage_vma()
Date: Fri, 16 Apr 2004 15:14:39 -0700
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
Thread-Index: AcQje23lAlGzYsvpT5+9cPXVvTfYhAAfTcdg
In-Reply-To: <20040416062215.GF26707@zax>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Original post on LKML:
http://www.ussg.iu.edu/hypermail/linux/kernel/0404.2/0017.html

>>>> David Gibson wrote on Thursday, April 15, 2004 11:22 PM
> Kenneth, does the patch below look reasonable?  It's close to trivial
> on everything except IA64, which I can't easily test on.  Actually, it
> occurs to me that this may even fix a bug on IA64 - if follow_page()
> was called on an address in region 1 that wasn't in a VMA, then I
> think it would attempt to follow it as a normal page, which sounds
> bad.

Thanks to well written code in the caller of follow_page(), that they
always call find_extend_vma() to make sure address belongs to a vma
before calling down to follow_page().  So there is no bug here.

Minor FYI: on ia64, huge page address is in region 4.


> hugepage_vma() is both misleadingly named and unnecessary.  On most
> archs it always returns NULL, and on IA64 the vma it returns is never
> used.  The function's real purpose is to determine whether the address
> it is passed is a special hugepage address which must be looked up in
> hugepage pagetables, rather than being looked up in the normal
> pagetables (which might have specially marked hugepage PMDs or PTEs).


One way or the other, the check has to be there.  If the name is vague,
a new name can be proposed.


> This patch kills off hugepage_vma() and folds the logic it really
> needs into follow_huge_addr().  That now returns a (page *) if called
> on a special hugepage address, and an error encoded with ERR_PTR
> otherwise.  This also requires tweaking the IA64 code to check that
> the hugepage PTE is present in follow_huge_addr() - previously this
> was guaranteed, since it was only called if the address was in an
> existing hugepage VMA, and hugepages are always prefaulted.

Why not do one step further? Instead of call a dummy function that
always return false, why not stub it out in the header file for arch
that don't need follow_huge_addr? This would speedup everyone.

I propose the following patch:


diff -Nur linux-2.6.5/arch/i386/mm/hugetlbpage.c linux-2.6.5.htlb/arch/i386/mm/hugetlbpage.c
--- linux-2.6.5/arch/i386/mm/hugetlbpage.c	2004-04-16 13:23:22.000000000 -0700
+++ linux-2.6.5.htlb/arch/i386/mm/hugetlbpage.c	2004-04-16 14:15:28.000000000 -0700
@@ -182,18 +182,6 @@

 #else

-struct page *
-follow_huge_addr(struct mm_struct *mm,
-	struct vm_area_struct *vma, unsigned long address, int write)
-{
-	return NULL;
-}
-
-struct vm_area_struct *hugepage_vma(struct mm_struct *mm, unsigned long addr)
-{
-	return NULL;
-}
-
 int pmd_huge(pmd_t pmd)
 {
 	return !!(pmd_val(pmd) & _PAGE_PSE);
diff -Nur linux-2.6.5/arch/ia64/mm/hugetlbpage.c linux-2.6.5.htlb/arch/ia64/mm/hugetlbpage.c
--- linux-2.6.5/arch/ia64/mm/hugetlbpage.c	2004-04-16 13:23:22.000000000 -0700
+++ linux-2.6.5.htlb/arch/ia64/mm/hugetlbpage.c	2004-04-16 14:20:35.000000000 -0700
@@ -149,19 +149,7 @@
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
diff -Nur linux-2.6.5/arch/ppc64/mm/hugetlbpage.c linux-2.6.5.htlb/arch/ppc64/mm/hugetlbpage.c
--- linux-2.6.5/arch/ppc64/mm/hugetlbpage.c	2004-04-16 13:23:22.000000000 -0700
+++ linux-2.6.5.htlb/arch/ppc64/mm/hugetlbpage.c	2004-04-16 14:37:19.000000000 -0700
@@ -334,18 +334,6 @@
 	return i;
 }

-struct page *
-follow_huge_addr(struct mm_struct *mm,
-	struct vm_area_struct *vma, unsigned long address, int write)
-{
-	return NULL;
-}
-
-struct vm_area_struct *hugepage_vma(struct mm_struct *mm, unsigned long addr)
-{
-	return NULL;
-}
-
 int pmd_huge(pmd_t pmd)
 {
 	return pmd_hugepage(pmd);
diff -Nur linux-2.6.5/arch/sh/mm/hugetlbpage.c linux-2.6.5.htlb/arch/sh/mm/hugetlbpage.c
--- linux-2.6.5/arch/sh/mm/hugetlbpage.c	2004-04-16 13:23:22.000000000 -0700
+++ linux-2.6.5.htlb/arch/sh/mm/hugetlbpage.c	2004-04-16 14:16:09.000000000 -0700
@@ -165,18 +165,6 @@
 	return i;
 }

-struct page *follow_huge_addr(struct mm_struct *mm,
-			      struct vm_area_struct *vma,
-			      unsigned long address, int write)
-{
-	return NULL;
-}
-
-struct vm_area_struct *hugepage_vma(struct mm_struct *mm, unsigned long addr)
-{
-	return NULL;
-}
-
 int pmd_huge(pmd_t pmd)
 {
 	return 0;
diff -Nur linux-2.6.5/arch/sparc64/mm/hugetlbpage.c linux-2.6.5.htlb/arch/sparc64/mm/hugetlbpage.c
--- linux-2.6.5/arch/sparc64/mm/hugetlbpage.c	2004-04-16 13:23:22.000000000 -0700
+++ linux-2.6.5.htlb/arch/sparc64/mm/hugetlbpage.c	2004-04-16 14:16:24.000000000 -0700
@@ -162,18 +162,6 @@
 	return i;
 }

-struct page *follow_huge_addr(struct mm_struct *mm,
-			      struct vm_area_struct *vma,
-			      unsigned long address, int write)
-{
-	return NULL;
-}
-
-struct vm_area_struct *hugepage_vma(struct mm_struct *mm, unsigned long addr)
-{
-	return NULL;
-}
-
 int pmd_huge(pmd_t pmd)
 {
 	return 0;
diff -Nur linux-2.6.5/include/asm-ia64/page.h linux-2.6.5.htlb/include/asm-ia64/page.h
--- linux-2.6.5/include/asm-ia64/page.h	2004-04-03 19:36:19.000000000 -0800
+++ linux-2.6.5.htlb/include/asm-ia64/page.h	2004-04-16 14:07:52.000000000 -0700
@@ -47,6 +47,7 @@

 # define HAVE_ARCH_HUGETLB_UNMAPPED_AREA
 # define ARCH_HAS_HUGEPAGE_ONLY_RANGE
+# define ARCH_HAS_FOLLOW_HUGE_ADDR
 #endif /* CONFIG_HUGETLB_PAGE */

 #ifdef __ASSEMBLY__
@@ -123,6 +124,7 @@
 # define is_hugepage_only_range(addr, len)		\
 	 (REGION_NUMBER(addr) == REGION_HPAGE &&	\
 	  REGION_NUMBER((addr)+(len)) == REGION_HPAGE)
+# define prepare_follow_huge_addr(addr)	(REGION_NUMBER(addr) == REGION_HPAGE)
 extern unsigned int hpage_shift;
 #endif

diff -Nur linux-2.6.5/include/linux/hugetlb.h linux-2.6.5.htlb/include/linux/hugetlb.h
--- linux-2.6.5/include/linux/hugetlb.h	2004-04-16 13:23:25.000000000 -0700
+++ linux-2.6.5.htlb/include/linux/hugetlb.h	2004-04-16 14:14:16.000000000 -0700
@@ -22,10 +22,6 @@
 int hugetlb_report_meminfo(char *);
 int is_hugepage_mem_enough(size_t);
 unsigned long hugetlb_total_pages(void);
-struct page *follow_huge_addr(struct mm_struct *mm, struct vm_area_struct *vma,
-			unsigned long address, int write);
-struct vm_area_struct *hugepage_vma(struct mm_struct *mm,
-					unsigned long address);
 struct page *follow_huge_pmd(struct mm_struct *mm, unsigned long address,
 				pmd_t *pmd, int write);
 int is_aligned_hugepage_range(unsigned long addr, unsigned long len);
@@ -55,6 +51,13 @@
 int prepare_hugepage_range(unsigned long addr, unsigned long len);
 #endif

+#ifndef ARCH_HAS_FOLLOW_HUGE_ADDR
+#define prepare_follow_huge_addr(addr)		0
+#define follow_huge_addr(mm, addr, write)	0
+#else
+struct page *follow_huge_addr(struct mm_struct *mm, unsigned long address, int write);
+#endif
+
 #else /* !CONFIG_HUGETLB_PAGE */

 static inline int is_vm_hugetlb_page(struct vm_area_struct *vma)
@@ -67,7 +70,8 @@
 }

 #define follow_hugetlb_page(m,v,p,vs,a,b,i)	({ BUG(); 0; })
-#define follow_huge_addr(mm, vma, addr, write)	0
+#define prepare_follow_huge_addr(addr)		0
+#define follow_huge_addr(mm, addr, write)	0
 #define copy_hugetlb_page_range(src, dst, vma)	({ BUG(); 0; })
 #define hugetlb_prefault(mapping, vma)		({ BUG(); 0; })
 #define zap_hugepage_range(vma, start, len)	BUG()
@@ -75,7 +79,6 @@
 #define huge_page_release(page)			BUG()
 #define is_hugepage_mem_enough(size)		0
 #define hugetlb_report_meminfo(buf)		0
-#define hugepage_vma(mm, addr)			0
 #define mark_mm_hugetlb(mm, vma)		do { } while (0)
 #define follow_huge_pmd(mm, addr, pmd, write)	0
 #define is_aligned_hugepage_range(addr, len)	0
diff -Nur linux-2.6.5/mm/memory.c linux-2.6.5.htlb/mm/memory.c
--- linux-2.6.5/mm/memory.c	2004-04-16 13:23:25.000000000 -0700
+++ linux-2.6.5.htlb/mm/memory.c	2004-04-16 14:20:49.000000000 -0700
@@ -629,11 +629,9 @@
 	pmd_t *pmd;
 	pte_t *ptep, pte;
 	unsigned long pfn;
-	struct vm_area_struct *vma;

-	vma = hugepage_vma(mm, address);
-	if (vma)
-		return follow_huge_addr(mm, vma, address, write);
+	if (prepare_follow_huge_addr(address))
+		return follow_huge_addr(mm, address, write);

 	pgd = pgd_offset(mm, address);
 	if (pgd_none(*pgd) || pgd_bad(*pgd))


