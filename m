Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270487AbTGPMPY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 08:15:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270545AbTGPMPY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 08:15:24 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:47950 "EHLO
	mtvmime02.veritas.com") by vger.kernel.org with ESMTP
	id S270487AbTGPMPT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 08:15:19 -0400
Date: Wed, 16 Jul 2003 13:31:39 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Ron Niles <Ron.Niles@falconstor.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Question about free_one_pgd() changes in these 3.5G patches
In-Reply-To: <E79B8AB303080F4096068F046CD1D89B01247A45@exchange1.FalconStor.Net>
Message-ID: <Pine.LNX.4.44.0307161242280.1549-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Jul 2003, Ron Niles wrote:
> 
> I'm trying to expand my kernel memory space to 3GB and am checking out these
> patches. I'm kind of mystified by the changes to free_one_pgd in these
> patches, both the one that Chuck Luciano recently posted and the one in AA
> (00_3.5G-address-space-4). Both of these seem to change the loop from:
> 
> 	int j;
> 	...
> 
> 	for (j = 0; j < PTRS_PER_PMD ; j++) {
>  		prefetchw(pmd+j+(PREFETCH_STRIDE/16));
> 		free_one_pmd(pmd+j);
> 	}
> to:
> 
> 	pmd_t * pmd, * md, * emd;
> 	...
> 
> 	/*
> 	 * Beware if changing the loop below.  It once used int j,
> 	 *	for (j = 0; j < PTRS_PER_PMD; j++)
> 	 *		free_one_pmd(pmd+j);
> 	 * but some older i386 compilers (e.g. egcs-2.91.66, gcc-2.95.3)
> 	 * terminated the loop with a _signed_ address comparison
> 	 * using "jle", when configured for HIGHMEM64GB (X86_PAE).
> 	 * If also configured for 3GB of kernel virtual address space,
> 	 * if page at physical 0x3ffff000 virtual 0x7ffff000 is used as
> 	 * a pmd, when that mm exits the loop goes on to free "entries"
> 	 * found at 0x80000000 onwards.  The loop below compiles instead
> 	 * to be terminated by unsigned address comparison using "jb". 
> 
> 	for (md = pmd, emd = pmd + PTRS_PER_PMD; md < emd; md++) {
> 		prefetchw(md+(PREFETCH_STRIDE/16));
> 		free_one_pmd(md);
>  	}
> 
> The comment (found in the AA patch) makes no sense to me. Since j is an int,
> you would expect the loop to exit with jle. If you want it to exit on jb,
> just change j to unsigned, right? Also PTRS_PER_PMD is never very large,
> around 512 I think, so it really doesn't matter unless PTRS_PER_PMD exceeds
> 0x7fffffff, which is really far from reality.

That comment (and the rewritten loop) originally came from me.
I thought it was a champion comment, I'm saddened that you disagree!

I've tried to cover the point by saying they terminated the loop with
"a _signed_ address comparison": the loop got optimized in such a way
that it wasn't testing int j as the C shows, but the address pmd+j.

Even so, it's conceivable that your proposed change, to unsigned j,
might be enough to jolt those compilers into doing the right thing.
But I never tried that, preferring to code the pointers explicitly.

> Secondly, the new code is dangerous if the pmd happens to be on the page at
> the top of memory. In this case pmd is something like 0xfffff000, emd = pmd
> + PTRS_PER_PMD rolls over to zero, and the loop never gets executed since md
> is never less than zero.
> 
> It seems to me the change is unnecessary, but if it is needed, it should
> protect against rollover on the top of memory page, assuming PTRS_PER_PMD is
> never zero:
> 
> 	for (md = pmd, emd = pmd + PTRS_PER_PMD - 1; md <= emd; md++)
> 
> Do we guarantee that the top of memory page is never used and the rollover
> is impossible? Even so, am I missing something as to why this change is
> necessary?

It is the case that we don't use the page-worth of virtual addresses at
the very top of virtual memory (I'm trying to phrase that pedantically to
make the point that it is virtual not physical addresses relevant here).

I know that to be true of i386, I believe it to be true of all arches,
you're right to pose the question.

In 2.5 Linus did very briefly use it for the FIX_VSYSCALL page, but
quickly accepted the value of keeping that page unmapped, and it's now
dignified as FIX_HOLE.  Not that we'd be using the fixmap area for pmds,
which have to come from directly mapped lowmem (or be temporarily
kmapped in wli's highmem pmd patch in -mm).

Hugh

