Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277161AbRJ3RoN>; Tue, 30 Oct 2001 12:44:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277152AbRJ3RoD>; Tue, 30 Oct 2001 12:44:03 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:28432 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S277119AbRJ3Rnw>; Tue, 30 Oct 2001 12:43:52 -0500
Date: Tue, 30 Oct 2001 09:41:56 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: <linux-kernel@vger.kernel.org>, "David S. Miller" <davem@redhat.com>,
        Andrea Arcangeli <andrea@suse.de>, Benjamin LaHaise <bcrl@redhat.com>,
        <paulus@samba.org>
Subject: Re: please revert bogus patch to vmscan.c
In-Reply-To: <20011030172352.16727@smtp.adsl.oleane.com>
Message-ID: <Pine.LNX.4.33.0110300929290.8603-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 30 Oct 2001, Benjamin Herrenschmidt wrote:
>
> Well, I lack experience to state which scheme is better, but there is
> definitely overhead intruduced by our hash management in linux on ppc,
> since we have to evicts pages from the hash as soon as we test&clear
> PAGE_ACCESSED or PAGE_DIRTY.
> That means we keep flushing pages out of the hash table, which seems
> to be defeat the purpose of that big hash table supposed to hold the
> PTEs for everybody out there more/less permanently.

Exactly. The problem with the hash chains is that they were designed for
_large_ jobs. For physicists that run a few copies of the same _huge_ load
over and over, where the jobs take minutes, hours or even days to
complete.

These jobs also have a very noticeable memory footprint (and thus TLB
component), and benchmarks like this sell systems.

And hash chains work _wonderfully_ for them - they are basically an
almost infinitely sized TLB, and the fact that cache locality is crap for
them doesn't matter because you use a LOT of entries and you have a LOT of
cache.

However, most people don't use their machines that way. Unix is pretty
much built up around running small, quick processes, and in _most_ normal
usage patterns (sorry, physicists ;), the cost of tearing down and
building up mappings is quite noticeable - often more so than the TLB
misses themselves.

In fact, I bet that for many apps, the number of TLB misses and the number
of faults to populate the VM space are not different by more than an order
of magnitude or so. They come, they eat, they go.

And in that kind of schenario, where mappings don't have lifetimes on the
order of minutes and hours at a time, hash chains suck. They make for
horrible cache behaviour, and building them up and tearing them down more
than makes up for any dubious win they had at TLB miss time.

And I stress _dubious_. A tree-based TLB lookup has a lot better cache
behaviour, and you can do a tree-based lookup in hardware quite
efficiently.

Yeah, if you didn't guess already, I despise hash chains. I'll take a
bigger on-chip secondary TLB and proper address space identifiers any day
over stupid hash chains. I think the Athlon does the former, but obviously
you can't do the latter with Intel-compatibility.

> Since we can't (AFAIK) have linux use larger PTEs (in which case we
> could store a pointer to the hash PTE in the linux PTE), We could
> instead layout an array of pointer (one for each page) that would
> hold these.

You can make Linux use any size PTE you wish - the Linux VM (including the
page tables) is entirely software-driven (with the current limitation of
having three levels of lookup - we'll probably change that when 42 bits
of virtual user space gets tight and there are enough machines out there
to matter, which is about another five years, I suspect).

So storing a pointer to the hardware hash table if you want to is
certainly possible. It has memory overhead, though, and decreased cache
compactness etc, so...

		Linus

