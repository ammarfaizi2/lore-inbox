Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270793AbTGPNIy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 09:08:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270803AbTGPNIy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 09:08:54 -0400
Received: from h74.falconstor.com ([63.122.122.74]:4406 "EHLO
	exchange1.FalconStor.Net") by vger.kernel.org with ESMTP
	id S270793AbTGPNIw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 09:08:52 -0400
Message-ID: <E79B8AB303080F4096068F046CD1D89B01247A59@exchange1.FalconStor.Net>
From: Ron Niles <Ron.Niles@falconstor.com>
To: linux-kernel@vger.kernel.org
Cc: Hugh Dickins <hugh@veritas.com>
Subject: RE: Question about free_one_pgd() changes in these 3.5G patches
Date: Wed, 16 Jul 2003 09:23:43 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>On Tue, 15 Jul 2003, Ron Niles wrote:
>> 
>> 	/*
>> 	 * Beware if changing the loop below.  It once used int j,
>> 	 *	for (j = 0; j < PTRS_PER_PMD; j++)
>> 	 *		free_one_pmd(pmd+j);
>> 	 * but some older i386 compilers (e.g. egcs-2.91.66, gcc-2.95.3)
>> 	 * terminated the loop with a _signed_ address comparison
>> 	 * using "jle", when configured for HIGHMEM64GB (X86_PAE).
>> 	 * If also configured for 3GB of kernel virtual address space,
>> 	 * if page at physical 0x3ffff000 virtual 0x7ffff000 is used as
>> 	 * a pmd, when that mm exits the loop goes on to free "entries"
>> 	 * found at 0x80000000 onwards.  The loop below compiles instead
>> 	 * to be terminated by unsigned address comparison using "jb". 
>> 
>> 	for (md = pmd, emd = pmd + PTRS_PER_PMD; md < emd; md++) {
>> 		prefetchw(md+(PREFETCH_STRIDE/16));
>> 		free_one_pmd(md);
>>  	}
>> 
>> The comment (found in the AA patch) makes no sense to me. Since j is an
int,
>> you would expect the loop to exit with jle. If you want it to exit on jb,
>> just change j to unsigned, right? Also PTRS_PER_PMD is never very large,
>> around 512 I think, so it really doesn't matter unless PTRS_PER_PMD
exceeds
>> 0x7fffffff, which is really far from reality.
>
>That comment (and the rewritten loop) originally came from me.
>I thought it was a champion comment, I'm saddened that you disagree!
>
>I've tried to cover the point by saying they terminated the loop with
>"a _signed_ address comparison": the loop got optimized in such a way
>that it wasn't testing int j as the C shows, but the address pmd+j.
>

Thanks, Hugh, it _is_ a champion comment, and it makes perfect sense now
that
I understand the compiler-optimized comparison is on pmd+j, not j.
