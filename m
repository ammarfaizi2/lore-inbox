Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263872AbUDOHTr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 03:19:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263862AbUDOHTr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 03:19:47 -0400
Received: from ozlabs.org ([203.10.76.45]:47832 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S263865AbUDOHTV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 03:19:21 -0400
Date: Thu, 15 Apr 2004 17:17:28 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org,
       lse-tech@lists.sourceforge.net, raybry@sgi.com,
       "'Andy Whitcroft'" <apw@shadowen.org>,
       "'Andrew Morton'" <akpm@osdl.org>
Subject: Re: hugetlb demand paging patch part [2/3]
Message-ID: <20040415071728.GE25560@zax>
Mail-Followup-To: David Gibson <david@gibson.dropbear.id.au>,
	"Chen, Kenneth W" <kenneth.w.chen@intel.com>,
	linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org,
	lse-tech@lists.sourceforge.net, raybry@sgi.com,
	'Andy Whitcroft' <apw@shadowen.org>, 'Andrew Morton' <akpm@osdl.org>
References: <200404132322.i3DNMuF21215@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200404132322.i3DNMuF21215@unix-os.sc.intel.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[snip]
> -int follow_hugetlb_page(struct mm_struct *, struct vm_area_struct *, struct page **, struct vm_area_struct **, unsigned long *, int

[snip]

> diff -Nurp linux-2.6.5/mm/memory.c linux-2.6.5.htlb/mm/memory.c
> +++ linux-2.6.5.htlb/mm/memory.c	2004-04-13 12:02:31.000000000 -0700
> @@ -769,11 +769,6 @@ int get_user_pages(struct task_struct *t
>  		if ((pages && vm_io) || !(flags & vma->vm_flags))
>  			return i ? : -EFAULT;
> 
> -		if (is_vm_hugetlb_page(vma)) {
> -			i = follow_hugetlb_page(mm, vma, pages, vmas,
> -						&start, &len, i);
> -			continue;
> -		}
>  		spin_lock(&mm->page_table_lock);
>  		do {
>  			struct page *map = NULL;

Ok, I notice that you've removed the follow_hugtlb_page() function
(and from the arch specific stuff, as well).  As far as I can tell,
this isn't actually related to demand-paging, in fact as far as I can
tell this function is unnecessary right now, because follow_page()
should already work for huge pages.  In particular the path in
get_user_pages() which can call handle_mm_fault() (which won't work on
hugepages without your patch) should never get triggered, since
hugepages are all prefaulted.

Does that sound right?  In other words, do you think the patch below,
which just kills off follow_hugetlb_page() is safe, or have I missed
something?

Index: working-2.6/mm/memory.c
===================================================================
--- working-2.6.orig/mm/memory.c	2004-04-13 11:42:42.000000000 +1000
+++ working-2.6/mm/memory.c	2004-04-15 17:03:01.421905400 +1000
@@ -766,16 +766,13 @@
 				|| !(flags & vma->vm_flags))
 			return i ? : -EFAULT;
 
-		if (is_vm_hugetlb_page(vma)) {
-			i = follow_hugetlb_page(mm, vma, pages, vmas,
-						&start, &len, i);
-			continue;
-		}
 		spin_lock(&mm->page_table_lock);
 		do {
 			struct page *map;
 			int lookup_write = write;
 			while (!(map = follow_page(mm, start, lookup_write))) {
+				/* hugepages should always be prefaulted */
+				BUG_ON(is_vm_hugetlb_page(vma));
 				/*
 				 * Shortcut for anonymous pages. We don't want
 				 * to force the creation of pages tables for
Index: working-2.6/include/linux/hugetlb.h
===================================================================
--- working-2.6.orig/include/linux/hugetlb.h	2004-04-13 11:42:41.000000000 +1000
+++ working-2.6/include/linux/hugetlb.h	2004-04-15 17:03:22.847834536 +1000
@@ -12,7 +12,6 @@
 
 int hugetlb_sysctl_handler(struct ctl_table *, int, struct file *, void *, size_t *);
 int copy_hugetlb_page_range(struct mm_struct *, struct mm_struct *, struct vm_area_struct *);
-int follow_hugetlb_page(struct mm_struct *, struct vm_area_struct *, struct page **, struct vm_area_struct **, unsigned long *, int *, int);
 void zap_hugepage_range(struct vm_area_struct *, unsigned long, unsigned long);
 void unmap_hugepage_range(struct vm_area_struct *, unsigned long, unsigned long);
 int hugetlb_prefault(struct address_space *, struct vm_area_struct *);
@@ -64,7 +63,6 @@
 	return 0;
 }
 
-#define follow_hugetlb_page(m,v,p,vs,a,b,i)	({ BUG(); 0; })
 #define follow_huge_addr(mm, vma, addr, write)	0
 #define copy_hugetlb_page_range(src, dst, vma)	({ BUG(); 0; })
 #define hugetlb_prefault(mapping, vma)		({ BUG(); 0; })
Index: working-2.6/arch/ppc64/mm/hugetlbpage.c
===================================================================
--- working-2.6.orig/arch/ppc64/mm/hugetlbpage.c	2004-04-13 11:42:35.000000000 +1000
+++ working-2.6/arch/ppc64/mm/hugetlbpage.c	2004-04-15 17:03:43.052825264 +1000
@@ -288,52 +288,6 @@
 	return 0;
 }
 
-int
-follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
-		    struct page **pages, struct vm_area_struct **vmas,
-		    unsigned long *position, int *length, int i)
-{
-	unsigned long vpfn, vaddr = *position;
-	int remainder = *length;
-
-	WARN_ON(!is_vm_hugetlb_page(vma));
-
-	vpfn = vaddr/PAGE_SIZE;
-	while (vaddr < vma->vm_end && remainder) {
-		BUG_ON(!in_hugepage_area(mm->context, vaddr));
-
-		if (pages) {
-			hugepte_t *pte;
-			struct page *page;
-
-			pte = hugepte_offset(mm, vaddr);
-
-			/* hugetlb should be locked, and hence, prefaulted */
-			WARN_ON(!pte || hugepte_none(*pte));
-
-			page = &hugepte_page(*pte)[vpfn % (HPAGE_SIZE/PAGE_SIZE)];
-
-			WARN_ON(!PageCompound(page));
-
-			get_page(page);
-			pages[i] = page;
-		}
-
-		if (vmas)
-			vmas[i] = vma;
-
-		vaddr += PAGE_SIZE;
-		++vpfn;
-		--remainder;
-		++i;
-	}
-
-	*length = remainder;
-	*position = vaddr;
-
-	return i;
-}
-
 struct page *
 follow_huge_addr(struct mm_struct *mm,
 	struct vm_area_struct *vma, unsigned long address, int write)
Index: working-2.6/arch/i386/mm/hugetlbpage.c
===================================================================
--- working-2.6.orig/arch/i386/mm/hugetlbpage.c	2004-04-13 11:42:35.000000000 +1000
+++ working-2.6/arch/i386/mm/hugetlbpage.c	2004-04-15 17:07:42.813857792 +1000
@@ -93,65 +93,26 @@
 	return -ENOMEM;
 }
 
-int
-follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
-		    struct page **pages, struct vm_area_struct **vmas,
-		    unsigned long *position, int *length, int i)
-{
-	unsigned long vpfn, vaddr = *position;
-	int remainder = *length;
-
-	WARN_ON(!is_vm_hugetlb_page(vma));
-
-	vpfn = vaddr/PAGE_SIZE;
-	while (vaddr < vma->vm_end && remainder) {
-
-		if (pages) {
-			pte_t *pte;
-			struct page *page;
-
-			pte = huge_pte_offset(mm, vaddr);
-
-			/* hugetlb should be locked, and hence, prefaulted */
-			WARN_ON(!pte || pte_none(*pte));
-
-			page = &pte_page(*pte)[vpfn % (HPAGE_SIZE/PAGE_SIZE)];
-
-			WARN_ON(!PageCompound(page));
-
-			get_page(page);
-			pages[i] = page;
-		}
-
-		if (vmas)
-			vmas[i] = vma;
-
-		vaddr += PAGE_SIZE;
-		++vpfn;
-		--remainder;
-		++i;
-	}
-
-	*length = remainder;
-	*position = vaddr;
-
-	return i;
-}
-
 #if 0	/* This is just for testing */
 struct page *
 follow_huge_addr(struct mm_struct *mm,
 	struct vm_area_struct *vma, unsigned long address, int write)
 {
-	unsigned long start = address;
-	int length = 1;
-	int nr;
+	int vpfn = vaddr / PAGE_SIZE;
 	struct page *page;
+	pte_t *pte;
 
-	nr = follow_hugetlb_page(mm, vma, &page, NULL, &start, &length, 0);
-	if (nr == 1)
-		return page;
-	return NULL;
+	pte = huge_pte_offset(mm, address);
+
+	/* hugetlb should be locked, and hence, prefaulted */
+	WARN_ON(!pte || pte_none(*pte));
+
+	page = &pte_page(*pte)[vpfn % (HPAGE_SIZE/PAGE_SIZE)];
+
+	WARN_ON(!PageCompound(page));
+
+	get_page(page);
+	return page;
 }
 
 /*
Index: working-2.6/arch/sparc64/mm/hugetlbpage.c
===================================================================
--- working-2.6.orig/arch/sparc64/mm/hugetlbpage.c	2004-04-13 11:42:35.000000000 +1000
+++ working-2.6/arch/sparc64/mm/hugetlbpage.c	2004-04-15 17:08:08.815900136 +1000
@@ -121,47 +121,6 @@
 	return -ENOMEM;
 }
 
-int follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
-			struct page **pages, struct vm_area_struct **vmas,
-			unsigned long *position, int *length, int i)
-{
-	unsigned long vaddr = *position;
-	int remainder = *length;
-
-	WARN_ON(!is_vm_hugetlb_page(vma));
-
-	while (vaddr < vma->vm_end && remainder) {
-		if (pages) {
-			pte_t *pte;
-			struct page *page;
-
-			pte = huge_pte_offset(mm, vaddr);
-
-			/* hugetlb should be locked, and hence, prefaulted */
-			BUG_ON(!pte || pte_none(*pte));
-
-			page = pte_page(*pte);
-
-			WARN_ON(!PageCompound(page));
-
-			get_page(page);
-			pages[i] = page;
-		}
-
-		if (vmas)
-			vmas[i] = vma;
-
-		vaddr += PAGE_SIZE;
-		--remainder;
-		++i;
-	}
-
-	*length = remainder;
-	*position = vaddr;
-
-	return i;
-}
-
 struct page *follow_huge_addr(struct mm_struct *mm,
 			      struct vm_area_struct *vma,
 			      unsigned long address, int write)
Index: working-2.6/arch/ia64/mm/hugetlbpage.c
===================================================================
--- working-2.6.orig/arch/ia64/mm/hugetlbpage.c	2004-04-14 12:22:48.000000000 +1000
+++ working-2.6/arch/ia64/mm/hugetlbpage.c	2004-04-15 17:08:30.667905672 +1000
@@ -113,43 +113,6 @@
 	return -ENOMEM;
 }
 
-int
-follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
-		    struct page **pages, struct vm_area_struct **vmas,
-		    unsigned long *st, int *length, int i)
-{
-	pte_t *ptep, pte;
-	unsigned long start = *st;
-	unsigned long pstart;
-	int len = *length;
-	struct page *page;
-
-	do {
-		pstart = start & HPAGE_MASK;
-		ptep = huge_pte_offset(mm, start);
-		pte = *ptep;
-
-back1:
-		page = pte_page(pte);
-		if (pages) {
-			page += ((start & ~HPAGE_MASK) >> PAGE_SHIFT);
-			get_page(page);
-			pages[i] = page;
-		}
-		if (vmas)
-			vmas[i] = vma;
-		i++;
-		len--;
-		start += PAGE_SIZE;
-		if (((start & HPAGE_MASK) == pstart) && len &&
-				(start < vma->vm_end))
-			goto back1;
-	} while (len && start < vma->vm_end);
-	*length = len;
-	*st = start;
-	return i;
-}
-
 struct vm_area_struct *hugepage_vma(struct mm_struct *mm, unsigned long addr)
 {
 	if (mm->used_hugetlb) {
Index: working-2.6/arch/sh/mm/hugetlbpage.c
===================================================================
--- working-2.6.orig/arch/sh/mm/hugetlbpage.c	2004-04-13 11:42:35.000000000 +1000
+++ working-2.6/arch/sh/mm/hugetlbpage.c	2004-04-15 17:08:49.216881808 +1000
@@ -124,47 +124,6 @@
 	return -ENOMEM;
 }
 
-int follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
-			struct page **pages, struct vm_area_struct **vmas,
-			unsigned long *position, int *length, int i)
-{
-	unsigned long vaddr = *position;
-	int remainder = *length;
-
-	WARN_ON(!is_vm_hugetlb_page(vma));
-
-	while (vaddr < vma->vm_end && remainder) {
-		if (pages) {
-			pte_t *pte;
-			struct page *page;
-
-			pte = huge_pte_offset(mm, vaddr);
-
-			/* hugetlb should be locked, and hence, prefaulted */
-			BUG_ON(!pte || pte_none(*pte));
-
-			page = pte_page(*pte);
-
-			WARN_ON(!PageCompound(page));
-
-			get_page(page);
-			pages[i] = page;
-		}
-
-		if (vmas)
-			vmas[i] = vma;
-
-		vaddr += PAGE_SIZE;
-		--remainder;
-		++i;
-	}
-
-	*length = remainder;
-	*position = vaddr;
-
-	return i;
-}
-
 struct page *follow_huge_addr(struct mm_struct *mm,
 			      struct vm_area_struct *vma,
 			      unsigned long address, int write)


-- 
David Gibson			| For every complex problem there is a
david AT gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson
