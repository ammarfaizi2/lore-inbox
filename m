Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292402AbSCDO6u>; Mon, 4 Mar 2002 09:58:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292407AbSCDO6m>; Mon, 4 Mar 2002 09:58:42 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:16645 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S292399AbSCDO6Q>;
	Mon, 4 Mar 2002 09:58:16 -0500
Date: Mon, 4 Mar 2002 11:23:57 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Andrea Arcangeli <andrea@suse.de>
Cc: Daniel Phillips <phillips@bonn-fries.net>,
        Bill Davidsen <davidsen@tmr.com>, Mike Fedyk <mfedyk@matchmail.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.19pre1aa1
In-Reply-To: <20020304150545.J20606@dualathlon.random>
Message-ID: <Pine.LNX.4.44L.0203041116120.2181-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Mar 2002, Andrea Arcangeli wrote:
> On Mon, Mar 04, 2002 at 09:41:40AM -0300, Rik van Riel wrote:
> > On Mon, 4 Mar 2002, Andrea Arcangeli wrote:
> >
> > > has nothing to do with the "cache" part, this is only about the
> > > pageout/swapout stage, only a few servers really needs heavy swapout.
> >
> > Ahhh, but it's not necessarily about making this common case
> > better. It's about making sure Linux doesn't die horribly in
> > some worst cases.
>
> rmap is only about making pagout/swapout activities more efficient,
> there's no stability issue to solve as far I can tell.

Not stability per se, but you have to admit the VM tends to
behave badly when there's a shortage in just one memory zone.
I believe NUMA will only make this situation worse.

It helps a lot when the VM can just free pages from those
zones where it has a memory shortage and skip scanning the
others.

> > The case of "system has more than enough memory" won't suffer
> > with -rmap anyway since the amount of activity in the VM part
> > of the system will be relatively low.
>
> I don't see anything significant to save in that area. During heavy
> paging the system load is something like 1/2% of the cpu.

During heavy paging you don't really care about how much system
time the VM takes (within reasonable limits, of course), instead
you care about how well the VM chooses which pages to swap out
and which pages to keep in RAM.

> > > And on the other case (heavy swapout/pageouts like in some hard DBMS
> > > usage, simualtions and laptops or legacy desktops) we would mostly save
> > > CPU and reduce complexity, but I really don't see system load during
> > > heavy pageouts/swapouts yet, so I don't see an obvious need of save cpu
> > > there either.
> >
> > The thing here is that -rmap is able to easily balance the
> > reclaiming of cache with the swapout of anonymous pages.
> >
> > Even though you tried to get rid of the magic numbers in
> > the old VM when you introduced your changes, you're already
> > back up to 4 magic numbers for the cache/swapout balancing.
> >
> > This is not your fault, being difficult to balance is just
> > a fundamental property of the partially physical, partially
> > virtual scanning.
>
> Those numbers also control how aggressive is the swap_out pass. That is
> partly a feature I think. Do you plan to unmap and put anonymous pages
> into the swapcache when you reach them in the inactive lru, despite you
> may have 99% of ram into freeable cache? I think you'll still need some
> number/heuristic to know when the lru pass should start to be aggressive
> unmapping and pagingout stuff. So I believe this issue about the "number
> thing" is quite unrelated to the complexity reduction of the paging
> algorithm with the removal of the swap_out pass.

It's harder to balance a combined virtual/physical scanning VM
than it is to balance a pure physical scanning VM.

I do have some tunables planned for -rmap, but those will be
more along the lines of a switch called "defer_swapout" which
the user can switch on or off.  No need for the user to know
how the VM works internally, the VM has enough info to work
out the details by itself.

regards,

Rik
-- 
"Linux holds advantages over the single-vendor commercial OS"
    -- Microsoft's "Competing with Linux" document

http://www.surriel.com/		http://distro.conectiva.com/

