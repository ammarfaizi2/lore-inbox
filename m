Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752052AbWCBTnJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752052AbWCBTnJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 14:43:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752055AbWCBTnJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 14:43:09 -0500
Received: from fmr23.intel.com ([143.183.121.15]:59024 "EHLO
	scsfmr003.sc.intel.com") by vger.kernel.org with ESMTP
	id S1752052AbWCBTnH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 14:43:07 -0500
Message-Id: <200603021942.k22JgFg13221@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Hugh Dickins'" <hugh@veritas.com>,
       "'David Gibson'" <david@gibson.dropbear.id.au>
Cc: "Andrew Morton" <akpm@osdl.org>, "William Irwin" <wli@holomorphy.com>,
       <linux-ia64@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: RE: hugepage: Fix hugepage logic in free_pgtables()
Date: Thu, 2 Mar 2006 11:42:15 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcY+KqZj/2Ytyat1RiG3FYljmeARIAAAirWA
In-Reply-To: <Pine.LNX.4.61.0603021836090.22007@goblin.wat.veritas.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins wrote on Thursday, March 02, 2006 10:53 AM
> On Thu, 2 Mar 2006, 'David Gibson' wrote:
> > free_pgtables() has special logic to call hugetlb_free_pgd_range()
> > instead of the normal free_pgd_range() on hugepage VMAs.  However, the
> > test it uses to do so is incorrect: it calls is_hugepage_only_range on
> > a hugepage sized range at the start of the vma.
> > is_hugepage_only_range() will return true if the given range has any
> > intersection with a hugepage address region, and in this case the
> > given region need not be hugepage aligned.  So, for example, this test
> > can return true if called on, say, a 4k VMA immediately preceding a
> > (nicely aligned) hugepage VMA.
> > 
> > At present we get away with this because the powerpc version of
> > hugetlb_free_pgd_range() is just a call to free_pgd_range().  On ia64
> > (the only other arch with a non-trivial is_hugepage_only_range()) we
> > get away with it for a different reason; the hugepage area is not
> > contiguous with the rest of the user address space, and VMAs are not
> > permitted in between, so the test can't return a false positive there.
> > 
> > Nonetheless this should be fixed.  We do that in the patch below by
> > replacing the is_hugepage_only_range() test with an explicit test of
> > the VMA using is_vm_hugetlb_page().
> > 
> Yes, okay, you can add my
> 
> Acked-by: Hugh Dickins <hugh@veritas.com>
> 
> (ARCH_HAS... and HAVE_ARCH... have fallen into disfavour, but I
> don't think you're doing wrong by splitting the old one into two.)
> 
> But let me emphasize again, in case Andrew wonders, that no current bug
> is fixed by this (as indeed you indicate in your "we get away with this"
> comments).


I've double checked that David's patch is OK for ia64.


> Whereas there's still a real ia64 get_unmapped_area bug to be fixed,
> arising from the same confusion, that is_hugepage_only_range needs
> to mean overlaps_hugepage_only_range (as on PowerPC) rather than
> within_hugepage_only_range (as on IA64).  Is Ken fixing that one?


Yes, I'm fixing it.  See patch below.


[patch] ia64: fix is_hugepage_only_range() definition to be overlaps
        instead of within architectural restricted hugetlb address
        range.  Fix all affected usages.

Signed-off-by: Ken Chen <kenneth.w.chen@intel.com>

--- ./include/asm-ia64/page.h.orig	2006-03-02 12:16:00.636688455 -0800
+++ ./include/asm-ia64/page.h	2006-03-02 12:23:30.151331386 -0800
@@ -147,7 +147,7 @@ typedef union ia64_va {
 				 | (REGION_OFFSET(x) >> (HPAGE_SHIFT-PAGE_SHIFT)))
 # define HUGETLB_PAGE_ORDER	(HPAGE_SHIFT - PAGE_SHIFT)
 # define is_hugepage_only_range(mm, addr, len)		\
-	 (REGION_NUMBER(addr) == RGN_HPAGE &&	\
+	 (REGION_NUMBER(addr) == RGN_HPAGE ||	\
 	  REGION_NUMBER((addr)+(len)-1) == RGN_HPAGE)
 extern unsigned int hpage_shift;
 #endif
--- ./arch/ia64/mm/hugetlbpage.c.orig	2006-03-02 12:31:12.020466353 -0800
+++ ./arch/ia64/mm/hugetlbpage.c	2006-03-02 12:31:02.944294589 -0800
@@ -112,8 +112,7 @@ void hugetlb_free_pgd_range(struct mmu_g
 			unsigned long floor, unsigned long ceiling)
 {
 	/*
-	 * This is called only when is_hugepage_only_range(addr,),
-	 * and it follows that is_hugepage_only_range(end,) also.
+	 * This is called to free hugetlb page tables.
 	 *
 	 * The offset of these addresses from the base of the hugetlb
 	 * region must be scaled down by HPAGE_SIZE/PAGE_SIZE so that
@@ -125,9 +124,9 @@ void hugetlb_free_pgd_range(struct mmu_g
 
 	addr = htlbpage_to_page(addr);
 	end  = htlbpage_to_page(end);
-	if (is_hugepage_only_range(tlb->mm, floor, HPAGE_SIZE))
+	if (REGION_NUMBER(floor) == RGN_HPAGE)
 		floor = htlbpage_to_page(floor);
-	if (is_hugepage_only_range(tlb->mm, ceiling, HPAGE_SIZE))
+	if (REGION_NUMBER(ceiling) == RGN_HPAGE)
 		ceiling = htlbpage_to_page(ceiling);
 
 	free_pgd_range(tlb, addr, end, floor, ceiling);





