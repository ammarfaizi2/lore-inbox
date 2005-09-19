Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932621AbVISUVw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932621AbVISUVw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Sep 2005 16:21:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932625AbVISUVw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Sep 2005 16:21:52 -0400
Received: from motgate8.mot.com ([129.188.136.8]:2746 "EHLO motgate8.mot.com")
	by vger.kernel.org with ESMTP id S932621AbVISUVv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Sep 2005 16:21:51 -0400
Message-ID: <A752C16E6296D711942200065BFCB6942521C78F@il02exm10>
From: Smarduch Mario-CMS063 <CMS063@motorola.com>
To: Linus Torvalds <torvalds@osdl.org>, Hugh Dickins <hugh@veritas.com>
Cc: linux-kernel@vger.kernel.org
Subject: RE: Multi-Threaded fork() correctness on Linux 2.4 & 2.6
Date: Mon, 19 Sep 2005 15:21:32 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On second look 'dup_mmap()' does a 'down_write()
on oldmm->mmap_sem and doesn't release it until
flush_tlb_mm() runs. Intermitent faults while
copy_pte_range() (taking releasing src page_table_lock)
runs should block in various platforms do_page_fault()
until oldmm->mmap_sem is released.
The eventual flush_tlb_mm() gets them to see
the same pte. So at no point can a threaded
task work off 2 different mappings.So I think this seems 
ok in 2.6. But I don't see the samething in 2.4.31 
(which what we're using now).

- Mario



-----Original Message-----
From: Linus Torvalds [mailto:torvalds@osdl.org] 
Sent: Monday, September 19, 2005 2:25 PM
To: Hugh Dickins
Cc: Smarduch Mario-CMS063; linux-kernel@vger.kernel.org
Subject: Re: Multi-Threaded fork() correctness on Linux 2.4 & 2.6



On Mon, 19 Sep 2005, Hugh Dickins wrote:
> On Mon, 19 Sep 2005, Smarduch Mario-CMS063 wrote:
> >     
> >     recently I've been involved in debugging MT forks on IA-64 the 
> > issues found were related to the way IA64 does its TLB invalidation. 
> > But there is still one  issue that appears to be Linux in general 
> > related, and it has to do with MT forks.
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

We hold the page_table_lock when doing the fork(), so T2 can't actually be copying the page until we've done the TLB flush, no? And once the TLB flush is done, all the writes by T3 should be in the page, so we copy the right thing at that point, and there is no consistency problems?

No? What am I missing?

		Linus
