Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750813AbWBVCpc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750813AbWBVCpc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 21:45:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751242AbWBVCpc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 21:45:32 -0500
Received: from fmr21.intel.com ([143.183.121.13]:29067 "EHLO
	scsfmr001.sc.intel.com") by vger.kernel.org with ESMTP
	id S1751221AbWBVCpb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 21:45:31 -0500
Message-Id: <200602220245.k1M2jRg10282@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'David Gibson'" <david@gibson.dropbear.id.au>
Cc: <linux-ia64@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: RE: IA64 non-contiguous memory space bugs
Date: Tue, 21 Feb 2006 18:45:27 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcY3V5BtNd5ajtSeSJGAHCjG2zfKnAAAdjYA
In-Reply-To: <20060222022558.GE23574@localhost.localdomain>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Gibson wrote on Tuesday, February 21, 2006 6:26 PM
> Chen, Kenneth W wrote on Tuesday, February 21, 2006 5:32 PM
> > free_pgtables() has partial crap that the check of is_hugepage_only_range()
> > should be done on the entire vma range, not just the first hugetlb page.
> > Though, it's not possible to have a hugetlb vma while having normal page
> > instantiated inside that vma.  So the bug is mostly phantom.  For
> > correctness, it should be fixed.
> 
> Actually, from ppc64's point of view, the problem with the test is
> that the whole vma could be *less* than HPAGE_SIZE - we don't test
> that the address is aligned before checking is_hugepage_only_range().
> We thus can call hugetlb_free_pgd_range() on normal page VMAs - which
> we only get away with because the ppc64 hugetlb_free_pgd_range() is
> (so far) an alias for the normal free_pgd_range().
> 
> Your patch below is insufficient, because there's a second test of
> is_hugepage_only_range() further down.  However, instead of tweaking
> the tested ranges, I think what we really want to do is check for
> is_vm_hugetlb_page() instead.
> 
> I was worried before, but now that you point out it's the 'end'
> address which really matters, not the ceiling, that might be
> sufficient.  Um.. except that hugepages, unlike normal pages these
> days don't necessarily clean up all possible pagetable pages on
> unmap...  crud.  Still the patch below ought to be an improvement.


I agree.  It's an improvement with your patch.

For ia64:
Acked-by: Ken Chen <kenneth.w.chen@intel.com> 



> Index: working-2.6/mm/memory.c
> ===================================================================
> --- working-2.6.orig/mm/memory.c	2006-02-22 10:42:14.000000000 +1100
> +++ working-2.6/mm/memory.c	2006-02-22 13:22:07.000000000 +1100
> @@ -277,7 +277,7 @@ void free_pgtables(struct mmu_gather **t
>  		anon_vma_unlink(vma);
>  		unlink_file_vma(vma);
>  
> -		if (is_hugepage_only_range(vma->vm_mm, addr, HPAGE_SIZE)) {
> +		if (is_vm_hugetlb_page(vma)) {
>  			hugetlb_free_pgd_range(tlb, addr, vma->vm_end,
>  				floor, next? next->vm_start: ceiling);
>  		} else {
> @@ -285,8 +285,7 @@ void free_pgtables(struct mmu_gather **t
>  			 * Optimization: gather nearby vmas into one call down
>  			 */
>  			while (next && next->vm_start <= vma->vm_end + PMD_SIZE
> -			  && !is_hugepage_only_range(vma->vm_mm, next->vm_start,
> -							HPAGE_SIZE)) {
> +			       && !is_vm_hugetlb_page(vma->vm_mm)) {
>  				vma = next;
>  				next = vma->vm_next;
>  				anon_vma_unlink(vma);

