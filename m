Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261303AbSJCUiM>; Thu, 3 Oct 2002 16:38:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261348AbSJCUiL>; Thu, 3 Oct 2002 16:38:11 -0400
Received: from packet.digeo.com ([12.110.80.53]:42938 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S261303AbSJCUiI>;
	Thu, 3 Oct 2002 16:38:08 -0400
Message-ID: <3D9CABF5.BA216802@digeo.com>
Date: Thu, 03 Oct 2002 13:43:33 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Dave Jones <davej@codemonkey.org.uk>
CC: Linus Torvalds <torvalds@transmeta.com>, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: [OT] 2.6 not 3.0 - (WAS Re: [PATCH-RFC] 4 of 4 - New problem logging 
 macros, SCSI RAIDdevice)
References: <200210031551.g93FpwsR000330@darkstar.example.net> <Pine.LNX.4.44.0210030852330.2066-100000@home.transmeta.com> <20021003165142.GA25316@suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 03 Oct 2002 20:43:33.0374 (UTC) FILETIME=[8A0719E0:01C26B1D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones wrote:
> 
> On Thu, Oct 03, 2002 at 08:57:13AM -0700, Linus Torvalds wrote:
> 
>  > The memory management issues would qualify for 3.0, but my argument there
>  > is really that I doubt everybody really is happy yet. Which was why I
>  > asked for people to test it and complain about VM behaviour - and we've
>  > had some ccomplaints ("too swap-happy") although they haven't sounded like
>  > really horrible problems.
> 
> We still need some work for low memory boxes (where low isn't
> necessarily all that low). On my 128MB laptop I can lock up the box
> for a minute or two at a time by doing two things at the same time,
> like a bk pull, and switching desktops.

Specific version info and all the usual how-to-reproduce info
would help here.  Things have changed a _lot_ in the past
week or two.

Comparisons with 2.4 are useful.  Simple "here's how to
reproduce" instructions are 100% golden ;)

> I dread to think how a 16 or 32MB box performs these days..

Well last I looked, a 2.5 kernel with NR_CPUS=8 had 22MB
of unreclaimable memory by the time it reached the console
login prompt.

Yet John Bradford says that in swapless 8MB, 2.5.40 is "springier"
than 2.4.x, so weird.

Jens did some aggressive scaling work against the BIO pools
recently which saved a ton of memory, and 2.5.40 now consumes
slightly less than 2.4.x to get started.

But the major thing we can do for the tiny boxes is to scale back
much harder on the big caches, the mempools, etc.  I hope to
be able to remove the radix-tree and pte_chain mempools altogether,
which will free up a quarter meg or so.


Apart from that, I'm reasonably happy with where the VM stands at
present.  It's very simple, very fast to identify which pages to
replace, and pretty accurate and efficient at doing that.

It should be immune to our traditional catastrophic failure
scenarios, and that's something which we want to keep.  There are
some ten- or twenty-percent regressions in some areas, but at this
time that's a reasonable price to pay for not locking up, not having
five-minute comas, not exhibiting massive stalls when there's a
lot of disk writeout, etc.  I think history teaches us to value
simplicity, predictability and robustness over performance-in-corner-cases.

There are some OOM problems on really big highmem machines which
still need investigation.  I expect they can be largely cleaned
up by making the throttling be per-zone rather than global.  Which
would complete the migration of the VM to being a per-zone thing.
Zone fallbacks then become known only to the page allocator and
the VM proper only cares for individual zones.

The reverse map was a huge conceptual cleanup.  It trumped a
whole class of nasty, fallible when-to-unmap decision making
logic.

Yeah, it swaps a lot.  It's the use-it-or-lose-it VM, and it's
mean.  People (damn them) don't like that.

Right now, I am rather disinclined to fix this via algorithmic changes,
by twiddling with aging-of-mapped-memory versus aging-of-pagecache,
or anything like that.  Because any such algorithmic change tends to
unbalance things, and to cause incorrect latency under sudden load
changes which could cause false OOM failures, or excessive CPU burn.  

What I'm more inclined to do is to leave things conceptually unchanged,
and to bolt a really obvious, bloody great ugly knob on the side;
maybe something as simple as:

	if (mapped_memory / total_memory < sysctl_the_user_is_a_wimp)
		only_reclaim_pagecache()

We shall see...
