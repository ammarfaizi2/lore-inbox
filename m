Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261190AbTL2VRQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Dec 2003 16:17:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264254AbTL2VRQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Dec 2003 16:17:16 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:36190 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S261190AbTL2VRN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Dec 2003 16:17:13 -0500
To: Linus Torvalds <torvalds@osdl.org>
Cc: Anton Ertl <anton@mips.complang.tuwien.ac.at>,
       linux-kernel@vger.kernel.org
Subject: Re: Page Colouring (was: 2.6.0 Huge pages not working as expected)
References: <179fV-1iK-23@gated-at.bofh.it> <179IS-1VD-13@gated-at.bofh.it>
	<2003Dec27.212103@a0.complang.tuwien.ac.at>
	<Pine.LNX.4.58.0312271245370.2274@home.osdl.org>
	<m1smj596t1.fsf@ebiederm.dsl.xmission.com>
	<Pine.LNX.4.58.0312272046400.2274@home.osdl.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 29 Dec 2003 14:11:52 -0700
In-Reply-To: <Pine.LNX.4.58.0312272046400.2274@home.osdl.org>
Message-ID: <m1ekuncorr.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:

> On Sat, 27 Dec 2003, Eric W. Biederman wrote:
> > Linus Torvalds <torvalds@osdl.org> writes:
> > >
> > > Basically: prove me wrong. People have tried before. They have failed. 
> > > Maybe you'll succeed. I doubt it, but hey, I'm not stopping you.
> > 
> > For anyone taking you up on this I'd like to suggest two possible
> > directions.
> > 
> > 1) Increasing PAGE_SIZE in the kernel.
> 
> Yes. This is something I actually want to do anyway for 2.7.x. Dan 
> Phillips had some patches for this six months ago.
> 
> You have to be careful, since you have to be able to mmap "partial pages", 
> which is what makes it less than trivial, but there are tons of reasons to 
> want to do this, and cache coloring is actually very much a secondary 
> concern.
> 
> > 2) Creating zones for the different colors.  Zones were not
> >    implemented last time, this was tried.
> 
> Hey, I can tell you that you _will_ fail.

Given the > order 0 pages it looks to be a long shot at this point.

> > Both of those should be minimal impact to the complexity
> > of the current kernel. 
> 
> Minimal? I don't think so. Zones are basically impossible, and page size 
> changes will hopefully happen during 2.7.x, but not due to page coloring.

I didn't say easy, just simple enough that not everyone in the
kernel would need to know or care.


> > caused by cache conflicts in today's applications are real, and easily
> > measurable.  Giving the growing increase in performance difference
> > between CPUs and memory Amdahl's Law shows this will only grow
> > so I think this is worth looking at.
> 
> Absolutely wrong.

I don't mean to focus exclusively on cache coloring but on anything
that will increase memory performance.  Right now we are at a point
where even the DRAM page size is larger than 4K. 
 
> Why? Because the fact is, that as memory gets further and further away 
> from CPU's, caches have gotten further and further away from being direct 
> mapped. 

Except for L1 caches.  The hit of an associate lookup there is inherently
costly.

> Cache coloring is already a very questionable win for four-way 
> set-associative caches. I doubt you can even _see_ it for eight-way or 
> higher associativity caches.

If I can ever get something that approaches a reliable result out of
something that a memory bandwidth benchmark, I would love it.  I typically
get something like a 25%+ variance.  The most reliably way I have found
to show how variable these things get is to run updatedb.  And run streams
or a similar benchmark at the same time.   The numbers jump all over the place
and a concurrent updatedb as frequently improves as it degrades performance.

When I stop seeing a measurable then I will stop worrying.

Of course it does not help that the current generation of compilers
can only get 50% of the actual performance the memory can provide.

In recent times the variations have been getting worse if anything.

> In other words: the pressures you mention clearly do exist, but they are 
> all driving direct-mapped caches out of the market, and thus making page
> coloring _less_ interesting rather than more.

The other spin is that everything in current architectures is based
around the concept of locality.  While page tables mess up locality.
So everything we can do to preserve locality is a good thing.  Cache
color happens naturally as a result of better page locality.

A variation to the idea of using larger page sizes is to allocate/free/swap
a batch of pages at once.   We do some of that now.  A batch of pages moves
the normal allocation up to order 3 or 4 if we can get them.  While
still working with smaller order pages if we can't. 

Eric
