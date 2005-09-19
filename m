Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932604AbVISTZG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932604AbVISTZG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Sep 2005 15:25:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932603AbVISTZF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Sep 2005 15:25:05 -0400
Received: from smtp.osdl.org ([65.172.181.4]:10472 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932604AbVISTZB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Sep 2005 15:25:01 -0400
Date: Mon, 19 Sep 2005 12:24:51 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Hugh Dickins <hugh@veritas.com>
cc: Smarduch Mario-CMS063 <CMS063@motorola.com>, linux-kernel@vger.kernel.org
Subject: Re: Multi-Threaded fork() correctness on Linux 2.4 & 2.6
In-Reply-To: <Pine.LNX.4.61.0509191928080.23718@goblin.wat.veritas.com>
Message-ID: <Pine.LNX.4.58.0509191216050.2553@g5.osdl.org>
References: <A752C16E6296D711942200065BFCB6942521C43A@il02exm10>
 <Pine.LNX.4.61.0509191928080.23718@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 19 Sep 2005, Hugh Dickins wrote:
> On Mon, 19 Sep 2005, Smarduch Mario-CMS063 wrote:
> >     
> >     recently I've been involved in debugging MT forks on IA-64 the issues
> > found were related to the way IA64 does its TLB invalidation. But there
> > is still one  issue that appears to be Linux in general related, and it
> > has to do with MT forks. 
> >  
> > For example a process has 3 threads T1, T2, T3.
> >  
> > 1 - T1 issues a fork()
> >     - under page_table_lock write bit is reset in src and dest pte's
> > 2 - T2 may have a TLB mis, the new write protected pte is inserted
> >     (hw walker or sw tlb hdlr)
> > 3 - T2 winds up in do_wp_page() the page is copied to a new one
> > 4 - In the mean time T3 may be working off the same page, the
> >     TLB invalidation (flush_tlb_mm()) has no occurred yet.
> > 5 - Eventually TLB is globally flushed so threads will see the new pte.
> > 6 - As a result the MT task may experience inconsisitent state.
> >     - During 3 & 4. For example locks may be acquired by both
> >       threads depending on the timing of the copy.
> 
> I do think you've hit upon something interesting here.  Though it's
> not quite as you describe.  We don't have to wait for the flush_tlb_mm
> to sort it out: the flush_tlb_page in ptep_establish in break_cow in
> do_wp_page resolves the discrepancy much sooner.  But your point is,
> that's already too late: T2 inserts a "smudged" copy of the page which
> T3 was working on, it does not contain all the data T3 had written there.

Hmm. 

We hold the page_table_lock when doing the fork(), so T2 can't actually be 
copying the page until we've done the TLB flush, no? And once the TLB 
flush is done, all the writes by T3 should be in the page, so we copy the 
right thing at that point, and there is no consistency problems?

No? What am I missing?

		Linus
