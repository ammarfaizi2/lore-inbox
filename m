Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292423AbSCDQMg>; Mon, 4 Mar 2002 11:12:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292447AbSCDQM1>; Mon, 4 Mar 2002 11:12:27 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:11544 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S292423AbSCDQMS>; Mon, 4 Mar 2002 11:12:18 -0500
Date: Mon, 4 Mar 2002 17:10:30 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Daniel Phillips <phillips@bonn-fries.net>,
        Bill Davidsen <davidsen@tmr.com>, Mike Fedyk <mfedyk@matchmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: 2.4.19pre1aa1
Message-ID: <20020304171030.K20606@dualathlon.random>
In-Reply-To: <20020304150545.J20606@dualathlon.random> <Pine.LNX.4.44L.0203041116120.2181-100000@imladris.surriel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L.0203041116120.2181-100000@imladris.surriel.com>
User-Agent: Mutt/1.3.22.1i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 04, 2002 at 11:23:57AM -0300, Rik van Riel wrote:
> On Mon, 4 Mar 2002, Andrea Arcangeli wrote:
> > On Mon, Mar 04, 2002 at 09:41:40AM -0300, Rik van Riel wrote:
> > > On Mon, 4 Mar 2002, Andrea Arcangeli wrote:
> > >
> > > > has nothing to do with the "cache" part, this is only about the
> > > > pageout/swapout stage, only a few servers really needs heavy swapout.
> > >
> > > Ahhh, but it's not necessarily about making this common case
> > > better. It's about making sure Linux doesn't die horribly in
> > > some worst cases.
> >
> > rmap is only about making pagout/swapout activities more efficient,
> > there's no stability issue to solve as far I can tell.
> 
> Not stability per se, but you have to admit the VM tends to
> behave badly when there's a shortage in just one memory zone.

I don't think it behaves badly, and I don't see how rmap can help there
except from saving some cpu. The major O(N) complexity when working on
the lwoer zones is in passing over/ignoring the pages in the higher
zones and that's at the page layer so rmap will make no differences
there and the complexity will remain O(N) (where N is the number of
higher-pages).

> It helps a lot when the VM can just free pages from those
> zones where it has a memory shortage and skip scanning the
> others.

I'm not scanning the other/unrelated pagetables just now.

> > > The case of "system has more than enough memory" won't suffer
> > > with -rmap anyway since the amount of activity in the VM part
> > > of the system will be relatively low.
> >
> > I don't see anything significant to save in that area. During heavy
> > paging the system load is something like 1/2% of the cpu.
> 
> During heavy paging you don't really care about how much system
> time the VM takes (within reasonable limits, of course), instead

yes, this is why rmap isn't making a sensible difference in the heavy
swap case either.

> you care about how well the VM chooses which pages to swap out
> and which pages to keep in RAM.

and for that the aging fair scan for the acessed bitflag has a chance to
be better than the unfair accessed bit handling in rmap that can lead to
not evaluating correctly the accessed-virtual-age of the pages.  Also
threating mapped pages in a special manner is beneficial.

> > > > And on the other case (heavy swapout/pageouts like in some hard DBMS
> > > > usage, simualtions and laptops or legacy desktops) we would mostly save
> > > > CPU and reduce complexity, but I really don't see system load during
> > > > heavy pageouts/swapouts yet, so I don't see an obvious need of save cpu
> > > > there either.
> > >
> > > The thing here is that -rmap is able to easily balance the
> > > reclaiming of cache with the swapout of anonymous pages.
> > >
> > > Even though you tried to get rid of the magic numbers in
> > > the old VM when you introduced your changes, you're already
> > > back up to 4 magic numbers for the cache/swapout balancing.
> > >
> > > This is not your fault, being difficult to balance is just
> > > a fundamental property of the partially physical, partially
> > > virtual scanning.
> >
> > Those numbers also control how aggressive is the swap_out pass. That is
> > partly a feature I think. Do you plan to unmap and put anonymous pages
> > into the swapcache when you reach them in the inactive lru, despite you
> > may have 99% of ram into freeable cache? I think you'll still need some
> > number/heuristic to know when the lru pass should start to be aggressive
> > unmapping and pagingout stuff. So I believe this issue about the "number
> > thing" is quite unrelated to the complexity reduction of the paging
> > algorithm with the removal of the swap_out pass.
> 
> It's harder to balance a combined virtual/physical scanning VM
> than it is to balance a pure physical scanning VM.

Depends, you may have to do similar things to balance rmap in a similar
manner. The point again is "when to start unmapping stuff". Once you
tune right and choose "ok, go ahead and unmap" at the right time, it
basically doesn't matter if you do that by calling swap_out or if you
try to unmap the current page in the lru. Plus swap_out will be fair and
mapped pages automatically will get a longer lifetime than unmapped
pages like plain fs cache, both things sounds like positive.

Plus rmap hurts the common fast paths, i.e. when no heavy swapout is
needed like in most servers out there.

Andrea
