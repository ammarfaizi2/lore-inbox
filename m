Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422637AbWBVC0g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422637AbWBVC0g (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 21:26:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422642AbWBVC0e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 21:26:34 -0500
Received: from ozlabs.org ([203.10.76.45]:26574 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1750857AbWBVC0b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 21:26:31 -0500
Date: Wed, 22 Feb 2006 13:25:58 +1100
From: "'David Gibson'" <david@gibson.dropbear.id.au>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Cc: linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: IA64 non-contiguous memory space bugs
Message-ID: <20060222022558.GE23574@localhost.localdomain>
Mail-Followup-To: 'David Gibson' <david@gibson.dropbear.id.au>,
	"Chen, Kenneth W" <kenneth.w.chen@intel.com>,
	linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
References: <200602220132.k1M1Vxg09552@unix-os.sc.intel.com> <200602220151.k1M1pqg09761@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200602220151.k1M1pqg09761@unix-os.sc.intel.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 21, 2006 at 05:51:52PM -0800, Chen, Kenneth W wrote:
> David Gibson wrote on Tuesday, February 21, 2006 4:14 PM
> > Second problem is in the hugepage logic in free_pgtables()
> > (mm/memory.c).  As far as I can tell it's complete crap, and only
> > works by accident, for different accidental reasons on ppc64 and ia64,
> > the only archs that have a non-trivial is_hugepage_only_range().
> > Except that I'm not sure it does entirely work by accident on ia64:
> > suppose a process has a hugepage mapping that begins some way after
> > the beginning of the hugepage address range.  Before
> > hugetlb_free_pgd_range() gets called on that area, it will be called
> > on the next normal page VMA down - but with an end address at the
> > beginning of the hugepage VMA and so extending into the hugepage
> > address range.  I don't really understand the ia64 pagetable mapping
> > stuff well enough to tell if that's dangerous or not.
> 
> Chen, Kenneth W wrote on Tuesday, February 21, 2006 5:32 PM
> > I don't see any problem in the ia64 code.  The start and end address is
> > what the vma specified.  Floor and ceiling is just a hint for free_pgtables()
> > to free any left over page tables between vma holes (to prev and next).
> > As far as I can tell, the code looks fine.
> 
> 
> free_pgtables() has partial crap that the check of is_hugepage_only_range()
> should be done on the entire vma range, not just the first hugetlb page.
> Though, it's not possible to have a hugetlb vma while having normal page
> instantiated inside that vma.  So the bug is mostly phantom.  For
> correctness, it should be fixed.

Actually, from ppc64's point of view, the problem with the test is
that the whole vma could be *less* than HPAGE_SIZE - we don't test
that the address is aligned before checking is_hugepage_only_range().
We thus can call hugetlb_free_pgd_range() on normal page VMAs - which
we only get away with because the ppc64 hugetlb_free_pgd_range() is
(so far) an alias for the normal free_pgd_range().

Your patch below is insufficient, because there's a second test of
is_hugepage_only_range() further down.  However, instead of tweaking
the tested ranges, I think what we really want to do is check for
is_vm_hugetlb_page() instead.

I was worried before, but now that you point out it's the 'end'
address which really matters, not the ceiling, that might be
sufficient.  Um.. except that hugepages, unlike normal pages these
days don't necessarily clean up all possible pagetable pages on
unmap...  crud.  Still the patch below ought to be an improvement.

Index: working-2.6/mm/memory.c
===================================================================
--- working-2.6.orig/mm/memory.c	2006-02-22 10:42:14.000000000 +1100
+++ working-2.6/mm/memory.c	2006-02-22 13:22:07.000000000 +1100
@@ -277,7 +277,7 @@ void free_pgtables(struct mmu_gather **t
 		anon_vma_unlink(vma);
 		unlink_file_vma(vma);
 
-		if (is_hugepage_only_range(vma->vm_mm, addr, HPAGE_SIZE)) {
+		if (is_vm_hugetlb_page(vma)) {
 			hugetlb_free_pgd_range(tlb, addr, vma->vm_end,
 				floor, next? next->vm_start: ceiling);
 		} else {
@@ -285,8 +285,7 @@ void free_pgtables(struct mmu_gather **t
 			 * Optimization: gather nearby vmas into one call down
 			 */
 			while (next && next->vm_start <= vma->vm_end + PMD_SIZE
-			  && !is_hugepage_only_range(vma->vm_mm, next->vm_start,
-							HPAGE_SIZE)) {
+			       && !is_vm_hugetlb_page(vma->vm_mm)) {
 				vma = next;
 				next = vma->vm_next;
 				anon_vma_unlink(vma);


-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
