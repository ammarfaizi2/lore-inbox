Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261891AbUDCT3T (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Apr 2004 14:29:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261899AbUDCT3T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Apr 2004 14:29:19 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:17074 "EHLO
	MTVMIME03.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S261891AbUDCT3R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Apr 2004 14:29:17 -0500
Date: Sat, 3 Apr 2004 20:29:15 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrea Arcangeli <andrea@suse.de>
cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       <linux-kernel@vger.kernel.org>
Subject: Re: anon-vma (and now filebacked-mappings too) mprotect vma merging
    [Re:    2.6.5-rc2-aa vma merging]
In-Reply-To: <20040403184639.GN2307@dualathlon.random>
Message-ID: <Pine.LNX.4.44.0404031954250.10509-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 3 Apr 2004, Andrea Arcangeli wrote:
> 
> another relevant advantage of anon-vma compared to anonmm, is the smp
> locking scalability and simplicity. With anonmm you're either forced to
> keep the mm-wide page_table_lock during vma merging and in general
> during all vma modifications (so you can lookup the rbtree from
> try_to_unmap by trylocking on the page_table_lock). While with anon-vma
> the page_table_lock goes away completely from the vma merging and all
> vma manipulations. page_table_lock remains but only for accessing the
> pagetables.

I liked Andrew's vma->page_table_lock suggestion, was imagining we
should migrate in that direction (as you said at the time, needn't
be right now), if only as a discipline to force us away from the
page_table_lock or mmap_sem muddle in (not your version of) mmap.c.

So I had been expecting to shift anonmm in that direction,
needing to do a down_read_trylock around its anon find_vma.

By the way, your and my page_referenced_one do need to take
page_table_lock, but the need for it is very very slender: Dave
took it out a year ago, I persuaded him it had to go back in,
but there's probably some way we can avoid it later on.

> About the ppc page->mapping stuff I don't think the ppc fixes in
> anobjrmap are really going to fix anything, though that tlb.c code is
> very confusing to me, not sure how can it work without it, but OTOH then
> even mainline shouldn't work if that's needed. ppc help?

I just translated what was there before: I thought I could understand
why it did that on user page tables, but I couldn't understand why it
did it to all the kernel page tables too.

I believe it's related to the fact that page_referenced_one does not
flush TLB after ptep_test_and_clear_referenced: so MMU may not notice
that we have cleared it, and not set it again even though referenced;
so pages referenced very frequently may be treated as unreferenced.
We ought to flush TLB there, but I presume it's been thought
to waste more time than its worth (particularly across cpus).
Probably depends rather on architecture, hence the ppc code.

Hugh

