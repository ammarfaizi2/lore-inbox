Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932564AbVISSnU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932564AbVISSnU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Sep 2005 14:43:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932565AbVISSnU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Sep 2005 14:43:20 -0400
Received: from silver.veritas.com ([143.127.12.111]:31001 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S932564AbVISSnU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Sep 2005 14:43:20 -0400
Date: Mon, 19 Sep 2005 19:42:51 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Smarduch Mario-CMS063 <CMS063@motorola.com>
cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: Multi-Threaded fork() correctness on Linux 2.4 & 2.6
In-Reply-To: <A752C16E6296D711942200065BFCB6942521C43A@il02exm10>
Message-ID: <Pine.LNX.4.61.0509191928080.23718@goblin.wat.veritas.com>
References: <A752C16E6296D711942200065BFCB6942521C43A@il02exm10>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 19 Sep 2005 18:43:18.0569 (UTC) FILETIME=[00A0B990:01C5BD4A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Sep 2005, Smarduch Mario-CMS063 wrote:

> MMU/Kernel experts,
>     
>     recently I've been involved in debugging MT forks on IA-64 the issues
> found were related to the way IA64 does its TLB invalidation. But there
> is still one  issue that appears to be Linux in general related, and it
> has to do with MT forks. 
>  
> For example a process has 3 threads T1, T2, T3.
>  
> 1 - T1 issues a fork()
>     - under page_table_lock write bit is reset in src and dest pte's
> 2 - T2 may have a TLB mis, the new write protected pte is inserted
>     (hw walker or sw tlb hdlr)
> 3 - T2 winds up in do_wp_page() the page is copied to a new one
> 4 - In the mean time T3 may be working off the same page, the
>     TLB invalidation (flush_tlb_mm()) has no occurred yet.
> 5 - Eventually TLB is globally flushed so threads will see the new pte.
> 6 - As a result the MT task may experience inconsisitent state.
>     - During 3 & 4. For example locks may be acquired by both
>       threads depending on the timing of the copy.

I do think you've hit upon something interesting here.  Though it's
not quite as you describe.  We don't have to wait for the flush_tlb_mm
to sort it out: the flush_tlb_page in ptep_establish in break_cow in
do_wp_page resolves the discrepancy much sooner.  But your point is,
that's already too late: T2 inserts a "smudged" copy of the page which
T3 was working on, it does not contain all the data T3 had written there.

> The TLB refill (hw/sw) work independently of the page_table_lock,
> it seems all threads should be forced to see the new pte
> before the new page is copied over by forcing the pte to 0 
> and allowing page_table_lock to synchronize the threads.

I don't get your pte to 0 suggestion.  What we seem to need is to
flush the TLB sooner (as well as in ptep_establish).  A first guess
is that do_wp_page needs (in these circumstances) to flush_tlb_page
before copying the page.

But this stuff is subtle, and TLB flushes shouldn't be added lightly.
I'm certainly not going to rush to propose the fix (and I could easily
be wrong in seeing the problem).  But perhaps others will be surer.

> I come from an SVR4 background and relatively new to
> Linux, any insights or corrections would be greatly appreciated.
> Please copy my email id as its to miss email on this list.

Welcome!

Hugh
