Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265294AbTL0Blp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Dec 2003 20:41:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265295AbTL0Blo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Dec 2003 20:41:44 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:40073
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S265294AbTL0Bll (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Dec 2003 20:41:41 -0500
Date: Sat, 27 Dec 2003 02:41:44 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Rik van Riel <riel@surriel.com>, Andrew Morton <akpm@osdl.org>
Subject: Re: Page aging broken in 2.6
Message-ID: <20031227014144.GE1676@dualathlon.random>
References: <1072423739.15458.62.camel@gaston> <Pine.LNX.4.58.0312260957100.14874@home.osdl.org> <1072482941.15458.90.camel@gaston> <Pine.LNX.4.58.0312261626260.14874@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0312261626260.14874@home.osdl.org>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 26, 2003 at 04:35:56PM -0800, Linus Torvalds wrote:
> 
> 
> On Sat, 27 Dec 2003, Benjamin Herrenschmidt wrote:
> > 
> > Or do what I propose here, that is have ptep_test_and_clear_* be
> > responsible for the flush on archs where it is necessary, but then
> > it would be nice to have more than the ptep as an argument...
> 
> The dirty handling already does the TLB flush (in that case it's a 
> correctness issue, not a hint). So it's only ptep_test_and_clear_young() 
> that matters.
> 
> I don't know whather that ever ends up being performance-critical, and I
> don't see what else could be passed into it. We literally don't _have_
> anythign else than the pte.
> 
> But the ppc architecture could easily decide to walk the hash tables and
> invalidate in ptep_test_and_clear_young(). And if it ends up being a
> performance issue, it _appears_ that all users of "page_referenced()" 
> (which is the only thing that does this) are actually using the return 
> value as just a boolean. And it's entirely possible that we should break 
> out of "page_referenced()" on the _first_ hit of "yes, this has been 
> referenced".
> 
> That would make it much less CPU-intensive to make
> "ptep_test_and_clear_young()" slightly heavier to execute. It would also 
> cause "page_referenced()" to not clear _all_ mapped reference bits at the 
> same time - which might unfairly cause multi-used pages to stay in memory. 
> On the other hand, that might be the _right_ behaviour.
> 
> Rik? Andrea? 

I agree with you about the current code being optimal for x86 despite
it's not accurate, as you said it doesn't need to be accurate since it's
not a correctness matter. I'm not very concerned about the size of the
tlb that Manfred mentioned, the snoops can't get past a cr3 overwrite,
so the first mm flush will make sure the young bit will be marked again
next time the page is accessed, no matter the size of the tlb and no
matter what snooping it does. Snoops can't obviate the lack of ASN in
the x86* arch.

In my opinion flushing the tlb for every page is definitely overkill in
SMP due the flood of broadcast IPIs it generates (I actually did that
and got bitten by the ipi flood in practice some year ago ;).

I believe flushing the tlb for every pte is reasonable only under
#ifndef CONFIG_SMP.

something that can work for both cases SMP and UP is to keep track of
which mm have to be flushed, and to flush the _whole_ mm, only after the
pagetable walk is complete, this reduces the IPI broadcast to 1 per mm,
not 1 per pte. This should improve it of an order of magnitude with
common workloads. Flushing per-pte is probably overkill on UP too.

This is what I have in 2.4:

#ifndef CONFIG_SMP
	/* in SMP is too costly to send further IPIs */
	if (tlb_flush)
		flush_tlb_mm(mm);
#endif

Originally I was flushing the mm even in UP, but then somebody
complained on some 4-way with some 8gigs and so I let it go completely
lazy now in SMP by adding the ifndef around it.

However I've no proof that the #ifndef made any difference, so it could
be the flush_tlb_mm is fine for SMP too. The above is just to go 100%
safe in terms of scalability in the high end, while providing the most
efficient and most accurate behaviour to UP (on UP all but one of those
flush_tlb_mm are noops in terms of tlb cost).

the above flush_tlb_mm executes for every mm scan only if the inner code
had to mark a pte as "old". in 2.4 that's trivial because we scan the mm
in order, but a dumb algorithm to do it in 2.6 could be to add a bitflag
to every mm and walking the mmlist and flush the mm with the bit on
(though this dumb logic is an O(N) one with the number of mm).

I'm unsure if the tlb flushing (if any) should be in the architectural
code or in the common code (there are pros and cons). For this specific
case exactly because the flush should be per-mm (a "should" for UP and a
"must" for SMP) I think doing it in the architectural code isn't
preferable.

As a generic matter (not necessairly specific to the
ptep_test_and_clear_young) I dislike any form cleverness and smartness
and hiding in the architectural pte/tlb lib calls unless it's strictly
necessary. To make an example s390 needs some additional complexity to
exploit their per-physical-page dirty bit, that incidentally broke in
subtle ways with the zero page with get_user_pages (that's fixed by now,
but it took a while to figure out and it sure couldn't be trapped by
reading the code, it bites you when it's too late). The problem is most
people would only read the x86* implementation anyways (that is not a
noop, it is just different), and in turn avoiding smartness and
differences in the archs code increases the probability that the common
code will work correctly everywhere. And you can think simpler by just
reading the common code. For istance I would prefer an additional
"flush_tlb_after_test_and_clear_young" than to hide it in
ptep_test_and_clear_young. That would be self documenting, the hiding
isn't and it could be forgotten by x86* programmers over time.
