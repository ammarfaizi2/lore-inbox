Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131083AbRARTm4>; Thu, 18 Jan 2001 14:42:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131150AbRARTmh>; Thu, 18 Jan 2001 14:42:37 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:25358 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S131083AbRARTmc>; Thu, 18 Jan 2001 14:42:32 -0500
Date: Thu, 18 Jan 2001 11:42:03 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Roman Zippel <zippel@fh-brandenburg.de>
cc: Andreas Dilger <adilger@turbolinux.com>,
        Rogier Wolff <R.E.Wolff@bitwizard.nl>, linux-kernel@vger.kernel.org
Subject: Re: Is sendfile all that sexy?
In-Reply-To: <Pine.GSO.4.10.10101181938310.25170-100000@zeus.fh-brandenburg.de>
Message-ID: <Pine.LNX.4.10.10101181120070.18387-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 18 Jan 2001, Roman Zippel wrote:
> > 
> > Not going to happen.
> 
> device-to-device is not the same as disk-to-disk. A better example would
> be a streaming file server.

No, it wouldn't be.

[ Crystal ball mode: ON ]

It's too damn device-dependent, and it's not worth it. There's no way to
make it general with any current hardware, and there probably isn't going
to be for at least another decade or so. And because it's expensive and
slow to do even on a hardware level, it probably won't be done even then.

Which means that it will continue to be a pure localized hack for the
forseeable future.

Quite frankly, show me a setup where the network bandwidth is even _close_
to big enough that it would make sense to try to stream directly from the
disk? The only one I can think of is basically DoD-type installations with
big satellite pictures on a huge server, and gigabit ethernet everywhere.
Quite frankly, if that huge server is so borderline that it cannot handle
the double copy, the system administrators have big problems.

Streaming local video to disk? Sure, I can see that people might want
that. But if you can't see that people might want to _see_ it while they
are streaming, then you're missing a big part of the picture called
"psychology". So you'd still want to have a in-memory buffer for things
like that.

Come back to this in ten years, when devices and buses are smarter. MAYBE
they'll support it (but see later about why I don't think they will).
Today, you're living in a pipe dream. You can't practically do it with any
real devices of today - even when both parts support busmastering, they do
NOT tend to support "busmaster to the disk", or "busmaster from the disk".
I don't know of any disk interfaces that do that kind of interfaces
(they'd basically need to have some way to busmaster directly to the
controller caches, and do cache management in software. Can be done, but 
probably exposes more of the hardware than most people want to see),

Right now the only special case might be some very specific embedded
devices, things like routers, video recorders etc. And for them it would
be very much a special case, with special drivers and everything. This is
NOT a generic kernel issue, and we have not reached the point where it's
even worth it trying to design the interfaces for it yet.

An important point in interface design is to know when you don't know
enough. We do not have the internal interfaces for doing anything like
this, and I seriously doubt they'll be around soon.

And you have to realize that it's not at all a given that device protocols
will even move towards this kind of environment. It's equally likely that
device protocols in the future will be more memory-intensive, where the
basic protocol will all be "read from memory" and "write to memory", and
nobody will even have a notion of mapping memory into device space like
PCI kind of does now.

I haven't looked at what infiniband/NGIO etc spec out, but I'd actually be
surprised if they allow you to effectively short-circuit the IO networks
together. It is not an operation that lends itself well to a network
topology - it happens to work on PCI due to the traditional "shared bus"
kind of logic that PCI inherited. And even on PCI, there are just a LOT of
PCI bridges that apparently do not like seeing PCI-PCI transfers.

(Short and sweet: most hogh-performance people want point-to-point serial
line IO with no hops, because it's a known art to make that go fast.  No
general-case routing in hardware - if you want to go as fast as the
devices and the link can go, you just don't have time to route. Trying to
support device->device transfers easily slows down the _common_ case,
which is why I personally doubt it will even be supported 10-15 years from
now. Better hardware does NOT mean "more features").

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
