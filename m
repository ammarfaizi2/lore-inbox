Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265297AbTL0CiN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Dec 2003 21:38:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265299AbTL0CiN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Dec 2003 21:38:13 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:10378
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S265297AbTL0Chv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Dec 2003 21:37:51 -0500
Date: Sat, 27 Dec 2003 03:37:53 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Rik van Riel <riel@surriel.com>, Andrew Morton <akpm@osdl.org>
Subject: Re: Page aging broken in 2.6
Message-ID: <20031227023752.GF1676@dualathlon.random>
References: <1072423739.15458.62.camel@gaston> <Pine.LNX.4.58.0312260957100.14874@home.osdl.org> <1072482941.15458.90.camel@gaston> <Pine.LNX.4.58.0312261626260.14874@home.osdl.org> <1072485899.15456.96.camel@gaston> <Pine.LNX.4.58.0312261649070.14874@home.osdl.org> <1072487027.15476.105.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1072487027.15476.105.camel@gaston>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 27, 2003 at 12:03:48PM +1100, Benjamin Herrenschmidt wrote:
> For accessed, we currently do not use the HW bit neither. Accessed = in
> the hash, not accessed = not in the hash. A bit basic, but the cost of
> faulting them back in isn't that bad. Still, I always found it a bit
> stupid that we end up having the harvesting of accessed bits actually
> evict pages that _are_ accessed, and thus potentially here to be
> accessed again ;)

It's hard for me to evaluate how much the young bit matters by only
thinking about it,  I know for sure the heavily swapping behaviour on
the alpha was noticeably less smooth than on x86 (alpha has^Hd no way to
implement the young bit, not even like you do in software through hash
faults). So I guess it's worthwhile for you to account for it even if in
software (i.e. ppc not ppc64).

> Paul did some experiments using the HW bits and didn't see a great
> perf increase (or what is even a decrease ?), but I should try that

It should be an I/O dominated workload anyways and it sounds like the
hardware way involves hash manipulation too (it only avoids the fault to
set it back on).

> > I'll let Rik and Andrea argue that part - it's entirely possible that 
> > getting lots of positive results is a _good_ thing, if the same page is 
> > mapped multiple times. That would just make us less eager to unmap it, 

that sounds correct behaviour to me, if a page is mapped multiple times
we should be eager in unmapping it. More precisely we should give every
user the opportunity to increase the youngness of the page, so a page
with multiple users will go away after a page with just a single user,
assuming all users access their pages at the same frequency.

Returning to the "how to flush the tlb after clearing the young bit", at
least on the x86 I find more desiderable to flush based on mm (in UP
that's the most efficient and it provides an accurate behaviour, in SMP
it maybe still to costly but sure a lot less costly than a broadcast per
pte).  In 2.4 with the pagetable scan the flush per mm is
strightforward and  it provides a very high probability of optimizing
away an huge lot of spurious IPI broadcast. But even in 2.6 the vm is
unmapping stuff with some aggressive clustering algorithm so that when
it starts umapping stuff it drops quite some stuff and there's still a
relevant probability that only a few mm have to be flushed, which in SMP
can decrease a lot the need of IPIs.  Not sure how these flush_tlb_mm
ideas translates for ppc though.

The dirty and accessed bitflags instead are quite a different matter
w.r.t to tlb flushing, we can't defer the tlb flush after atomically
clearing the pte in smp while we clear the dirty bit. the tlb shootdown
is the clustered version of that. the shootdown run a broadcast IPI
not more than every 508 pte freed per mm. For the same reason we can try
to coalesce the tlb flush post-clear-young with an mm flush, we can
achieve a similar coalescing without the no need of an exact tlb
shootdown like in the pte freeing.
