Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269030AbTGPAhs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 20:37:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269933AbTGPAhs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 20:37:48 -0400
Received: from [66.105.142.2] ([66.105.142.2]:8500 "EHLO
	exchange1.FalconStor.Net") by vger.kernel.org with ESMTP
	id S269030AbTGPAhr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 20:37:47 -0400
Message-ID: <E79B8AB303080F4096068F046CD1D89B01247A45@exchange1.FalconStor.Net>
From: Ron Niles <Ron.Niles@falconstor.com>
To: linux-kernel@vger.kernel.org
Subject: Question about free_one_pgd() changes in these 3.5G patches
Date: Tue, 15 Jul 2003 20:52:36 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'm trying to expand my kernel memory space to 3GB and am checking out these
patches. I'm kind of mystified by the changes to free_one_pgd in these
patches, both the one that Chuck Luciano recently posted and the one in AA
(00_3.5G-address-space-4). Both of these seem to change the loop from:

	int j;
	...

	for (j = 0; j < PTRS_PER_PMD ; j++) {
 		prefetchw(pmd+j+(PREFETCH_STRIDE/16));
		free_one_pmd(pmd+j);
	}
to:

	pmd_t * pmd, * md, * emd;
	...

	/*
	 * Beware if changing the loop below.  It once used int j,
	 *	for (j = 0; j < PTRS_PER_PMD; j++)
	 *		free_one_pmd(pmd+j);
	 * but some older i386 compilers (e.g. egcs-2.91.66, gcc-2.95.3)
	 * terminated the loop with a _signed_ address comparison
	 * using "jle", when configured for HIGHMEM64GB (X86_PAE).
	 * If also configured for 3GB of kernel virtual address space,
	 * if page at physical 0x3ffff000 virtual 0x7ffff000 is used as
	 * a pmd, when that mm exits the loop goes on to free "entries"
	 * found at 0x80000000 onwards.  The loop below compiles instead
	 * to be terminated by unsigned address comparison using "jb". 

	for (md = pmd, emd = pmd + PTRS_PER_PMD; md < emd; md++) {
		prefetchw(md+(PREFETCH_STRIDE/16));
		free_one_pmd(md);
 	}

The comment (found in the AA patch) makes no sense to me. Since j is an int,
you would expect the loop to exit with jle. If you want it to exit on jb,
just change j to unsigned, right? Also PTRS_PER_PMD is never very large,
around 512 I think, so it really doesn't matter unless PTRS_PER_PMD exceeds
0x7fffffff, which is really far from reality.

Secondly, the new code is dangerous if the pmd happens to be on the page at
the top of memory. In this case pmd is something like 0xfffff000, emd = pmd
+ PTRS_PER_PMD rolls over to zero, and the loop never gets executed since md
is never less than zero.

It seems to me the change is unnecessary, but if it is needed, it should
protect against rollover on the top of memory page, assuming PTRS_PER_PMD is
never zero:

	for (md = pmd, emd = pmd + PTRS_PER_PMD - 1; md <= emd; md++)

Do we guarantee that the top of memory page is never used and the rollover
is impossible? Even so, am I missing something as to why this change is
necessary?
