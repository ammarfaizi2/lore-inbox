Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292383AbSCDOIV>; Mon, 4 Mar 2002 09:08:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292375AbSCDOIN>; Mon, 4 Mar 2002 09:08:13 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:16763 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S292383AbSCDOIA>; Mon, 4 Mar 2002 09:08:00 -0500
Date: Mon, 4 Mar 2002 15:05:45 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Daniel Phillips <phillips@bonn-fries.net>,
        Bill Davidsen <davidsen@tmr.com>, Mike Fedyk <mfedyk@matchmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: 2.4.19pre1aa1
Message-ID: <20020304150545.J20606@dualathlon.random>
In-Reply-To: <20020304032535.F20606@dualathlon.random> <Pine.LNX.4.44L.0203040934100.2181-100000@imladris.surriel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L.0203040934100.2181-100000@imladris.surriel.com>
User-Agent: Mutt/1.3.22.1i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 04, 2002 at 09:41:40AM -0300, Rik van Riel wrote:
> On Mon, 4 Mar 2002, Andrea Arcangeli wrote:
> 
> > > having to scan two page tables to unmap it.  In theory.  Do you see a hole
> > > in that?
> >
> > Just the fact you never need the reverse lookup during lots of
> > important production usages (first that cames to mind is when you have
> > enough ram to do your job, all number crunching/fileserving, and most
> > servers are setup that way).  This is the whole point. Note that this
> > has nothing to do with the "cache" part, this is only about the
> > pageout/swapout stage, only a few servers really needs heavy swapout.
> 
> Ahhh, but it's not necessarily about making this common case
> better. It's about making sure Linux doesn't die horribly in
> some worst cases.

rmap is only about making pagout/swapout activities more efficient,
there's no stability issue to solve as far I can tell.

> The case of "system has more than enough memory" won't suffer
> with -rmap anyway since the amount of activity in the VM part
> of the system will be relatively low.

I don't see anything significant to save in that area. During heavy
paging the system load is something like 1/2% of the cpu.

> > And on the other case (heavy swapout/pageouts like in some hard DBMS
> > usage, simualtions and laptops or legacy desktops) we would mostly save
> > CPU and reduce complexity, but I really don't see system load during
> > heavy pageouts/swapouts yet, so I don't see an obvious need of save cpu
> > there either.
> 
> The thing here is that -rmap is able to easily balance the
> reclaiming of cache with the swapout of anonymous pages.
> 
> Even though you tried to get rid of the magic numbers in
> the old VM when you introduced your changes, you're already
> back up to 4 magic numbers for the cache/swapout balancing.
> 
> This is not your fault, being difficult to balance is just
> a fundamental property of the partially physical, partially
> virtual scanning.

Those numbers also control how aggressive is the swap_out pass. That is
partly a feature I think. Do you plan to unmap and put anonymous pages
into the swapcache when you reach them in the inactive lru, despite you
may have 99% of ram into freeable cache? I think you'll still need some
number/heuristic to know when the lru pass should start to be aggressive
unmapping and pagingout stuff. So I believe this issue about the "number
thing" is quite unrelated to the complexity reduction of the paging
algorithm with the removal of the swap_out pass.

Andrea
