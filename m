Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265288AbTL0BEk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Dec 2003 20:04:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265290AbTL0BEj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Dec 2003 20:04:39 -0500
Received: from pentafluge.infradead.org ([213.86.99.235]:64946 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S265288AbTL0BEh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Dec 2003 20:04:37 -0500
Subject: Re: Page aging broken in 2.6
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Rik van Riel <riel@surriel.com>, Andrew Morton <akpm@osdl.org>,
       Andrea Arcangeli <andrea@suse.de>
In-Reply-To: <Pine.LNX.4.58.0312261649070.14874@home.osdl.org>
References: <1072423739.15458.62.camel@gaston>
	 <Pine.LNX.4.58.0312260957100.14874@home.osdl.org>
	 <1072482941.15458.90.camel@gaston>
	 <Pine.LNX.4.58.0312261626260.14874@home.osdl.org>
	 <1072485899.15456.96.camel@gaston>
	 <Pine.LNX.4.58.0312261649070.14874@home.osdl.org>
Content-Type: text/plain
Message-Id: <1072487027.15476.105.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sat, 27 Dec 2003 12:03:48 +1100
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-12-27 at 11:53, Linus Torvalds wrote:
> On Sat, 27 Dec 2003, Benjamin Herrenschmidt wrote:
> > > 
> > > The dirty handling already does the TLB flush (in that case it's a 
> > > correctness issue, not a hint). So it's only ptep_test_and_clear_young() 
> > > that matters.
> > 
> > Yes, but it would be possible to optimize it some way on our
> > beloved hash tables ;) (By marking the entry read-only in the
> > hash instead of evicting it). Maybe not worth the pain though...
> 
> I don't think you should evict it, since
>  - you know the value it should have
>  - if you do the hash lookup anyway, you might as well just update the 
>    entry.

Yup, that is my point.

> And it's not "read-only" - it's the "A" bit, not the "W" bit you should be 
> clearing in "ptep_test_and_clear_young()".

In the above I was talking about dirty.

For accessed, we currently do not use the HW bit neither. Accessed = in
the hash, not accessed = not in the hash. A bit basic, but the cost of
faulting them back in isn't that bad. Still, I always found it a bit
stupid that we end up having the harvesting of accessed bits actually
evict pages that _are_ accessed, and thus potentially here to be
accessed again ;)

Paul did some experiments using the HW bits and didn't see a great
perf increase (or what is even a decrease ?), but I should try that
again on ppc64 since there, we can much more quickly hit the proper
hash slot (we store its index in one group within the PTE).

Another problem with using real A & D hash bits is that we may evict
entries from the hash table (because both groups are full for a given
hash value). In this case, we need to go back to the linux PTE to
update the bits in there before we lose the A/D information from the
hash. But I don't think the overhead here matters much, we only rarely
do evicts.

> I'll let Rik and Andrea argue that part - it's entirely possible that 
> getting lots of positive results is a _good_ thing, if the same page is 
> mapped multiple times. That would just make us less eager to unmap it, 
> which sounds like potentially the right thign to do (it's also how the old 
> non-rmap code worked, and I know Rik thought it was "unfair", but 
> whatever).
> 
> > Ok, right now, Anton is testing a patch from paulus where we do our
> > own flush batching and do the flush inside ptep_test_and_clear_* That
> > will at least fix the problem for us now.
> 
> Yeah, and it's unlikely to be a performance problem anyway. That function 
> should be called only when we're low on memory..
> 
> 		Linus
-- 
Benjamin Herrenschmidt <benh@kernel.crashing.org>

