Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu id <971893-18554>; Thu, 9 Jul 1998 19:48:58 -0400
Received: from neon-best.transmeta.com ([206.184.214.10]:29870 "EHLO neon.transmeta.com" ident: "NO-IDENT-SERVICE[2]") by vger.rutgers.edu with ESMTP id <970843-18554>; Thu, 9 Jul 1998 19:48:44 -0400
Date: Thu, 9 Jul 1998 17:54:21 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: "Stephen C. Tweedie" <sct@redhat.com>
cc: ganesh.sittampalam@magd.ox.ac.uk, Virtual Memory problem report list <linux-kernel@vger.rutgers.edu>, mingo@valerie.inf.elte.hu, Bill Hawes <whawes@star.net>, Alan Cox <number6@the-village.bc.nu>, "David S. Miller" <davem@dm.cobaltmicro.com>
Subject: Re: Progress! was: Re: Yet more VM writable swap-cached pages
In-Reply-To: <199807100042.BAA07833@dax.dcs.ed.ac.uk>
Message-ID: <Pine.LNX.3.96.980709174951.431E-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-kernel@vger.rutgers.edu



On Fri, 10 Jul 1998, Stephen C. Tweedie wrote:
> with no rwe currently enabled.  Page flags are normal for a resident
> swap-cached anonymous page with no IO in flight.  The page count, 2, is
> also normal for a cached anonymous page.  The pte, 6a8042, is not normal
> at all.  It is marked non-present (the lowest bit is clear) but
> _PAGE_PROTNONE.  That changes everything.

Cool. This does indeed explain it.

The _PAGE_PROTNONE was a clever way to get the correct unreadability on an
x86, but I did indeed miss the fact that now a page can be marked
"present" as far as the Linux memory management is concerned, yet not be
writable by looking at _PAGE_RW. 

Your suggestion not only should fix this, but is also the RightThing(tm)
to do. 

It also explains why so few people saw this - PROT_NONE is not something
that is normally used.

>							  What are
> the implications for other architectures which organise their ptes
> differently?

Other architectures may have the same bug, but it's actually fairly
unlikely. Most other architectures tend to have a nicer way to do
PROT_NONE anyway, and the x86 thing is a hack (but a very nice hack,
because it leaves the mm layer completely unaware of the fact that the x86
page tables are fairly deficient in this area). 

So it's not a conceptual problem, it might just be something that needs to
be looked at. Certainly the alpha does not have this problem.

		Linus


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
