Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317005AbSEWUln>; Thu, 23 May 2002 16:41:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317006AbSEWUln>; Thu, 23 May 2002 16:41:43 -0400
Received: from [195.223.140.120] ([195.223.140.120]:37136 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S317005AbSEWUll>; Thu, 23 May 2002 16:41:41 -0400
Date: Thu, 23 May 2002 22:41:01 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Q: backport of the free_pgtables tlb fixes to 2.4
Message-ID: <20020523204101.GY21164@dualathlon.random>
In-Reply-To: <20020523195757.GW21164@dualathlon.random> <Pine.LNX.4.33.0205231300530.4338-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 23, 2002 at 01:05:53PM -0700, Linus Torvalds wrote:
> 
> On Thu, 23 May 2002, Andrea Arcangeli wrote:
> > > 	munmap
> > > 	.. speculation starts ..
> > 
> > the question is: can you explain how the speculative tlb fill can start?
> 
> Any indirect branch can be (and will be) predicted using the BTB. The
> speculation starts before the BTB contents have actually been verified,
> resulting in iTLB speculation.
> 
> Since the BTB can (and does) contain mostly user addresses (from previous
> execution in user land), it's apparently quite common to speculatively
> fetch user TLB entries even when you're in kernel mode.
> 
> (This is also, btw, probably anothre reason why you only see this bug in 
> practice on a P4: much bigger BTB)
> 
> > see below.
> > 
> > > 	.. TLB looks up pgd entry ..
> > > 	clear pgd entry
> > > 	free pmd
> > > 
> > > 			alloc page - get old pmd
> > > 			scribble on page
> > > 
> > > 	.. TLB looks up pmd entry ..
> > > 	.. tlb fill ends ...
> > > 	invalidate_tlb
> > 	^^^^^^^^^^^^^^
> > 
> > I assume the userspace access could be imagined right after the
> > invalidate_tlb in the above example, and that's the one supposed to
> > trigger the speculative tlb fill but how can it pass the invalidate_tlb?
> > see below.
> 
> It doesn't pass the invalidate_tlb.
> 
> By the time the invalidate_tlb happens, the TLB fill has already finished, 
> and has already picked up garbage.

If the userspace tlb lookup is started during munmap the tlb can contain
garabge before invalidate_tlb.

What I don't understand is how the BTB can invoke random userspace tlb
fills when we are running do_munmap, there's no point at all in doing
that. If the cpu see a read of an user address after invalidate_tlb,
the tlb must not be started because it's before an invalidate_tlb.

And if it's true not even irq are barriers for the tlb fills invoked by
this p4-BTB thing, so if leave_mm is really necessary, then 2.5 is as
well wrong in UP, because the pagetable can be scribbled by irqs in a UP
machine, and so the fastmode must go away even in 1 cpu systems.

> 
> READ my explanation. The garbage can (and does) contain the Global bit, so
> even though we then flush the TLB, the garbage remains.
> 
> > In all cases either the 2.4 fix is wrong,
> 
> No. Understand the patch, _then_ complain.

Above i'm not saying in absolute that the 2.4 fix is wrong, I'm saying
either 2.4 fix is wrong, or 2.5 must be overkill in using the tlb
shootdown for tasks with mm_users == 1, while releasing the _pages_, not
the _pagetables_. the 2.4 patch infact only enforces the ordering with
the pagetables, never with the pagetables if the mm_users == 1.

I reaffirm all the questions in my previous email except the "how the
tlb fill is stared in case2", if there's this BTB thing in the p4 that
is filling randomly tlb entries for user addresses any time during any
kernel code, that will perfectly explain how case2 triggers (but I'm
pretty sure that's a p4-only peculiarity and I don't think case2 can
happen in any other cpu out there because the tlb flush should forbid
the cpu to go ahead, or in the worst case a smb_mb() before
invalidate_tlb should be enough to forbid the cpu to see userspace
addresses before the pte is clear, and after the pmd entry is clear it
doesn't matter where's the pagetables).

I see contraddictions in the code:

1) between case2 UP-fastmode and case3 leave_mm (if leave_mm is needed
then fastmode is buggy in 2.5)
2) between fastmode == 1cpu used also for the pages in 2.5 and not used for the pages in 2.4
   so either 2.4 is buggy or 2.5 is overkill

So something is definitely still either overkill on one side or wrong on
the other side for both the above things (plus the fact I'm taking as
an assumption that this BTB thing can start tlb fills anytime regardless
if the cpu is allowed to speculate on userspace addresses or not, but
I'm ok to assume it as a p4 peculiarity). If all the code floating
around would be coherent then things would make more sense. At the
current state of things I cannot tell what is right and I am sure
something is still wrong. So I don't feel my questions are superflous,
and this is not a matter of understanding the code, I think I'm not
missing anything in the code, I'm missing something on the hardware
details of the p4 cpus instead and I doubt that's documented in the
specs and anyways it's faster to ask to learn those lowlevel details.

The one definitely "software" thing is the free_pgtables bug (case1),
and that's clear and fixed by both 2.5 and the 2.4 patch via the
quicklists, we're left with the contraddiction with and the fastmode
differences between case2 and case3 in both 2.4 patch and 2.5, and
that's hardware side, not software side. Infact I'm still not excluding
the possibility that what is been found in the traces is case 1, and if
case2 and case3 can really trigger.

Andrea
