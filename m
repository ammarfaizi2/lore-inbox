Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <S154378AbQAYR1V>; Tue, 25 Jan 2000 12:27:21 -0500
Received: by vger.rutgers.edu id <S154519AbQAYRWh>; Tue, 25 Jan 2000 12:22:37 -0500
Received: from smtp10.atl.mindspring.net ([207.69.200.246]:12929 "EHLO smtp10.atl.mindspring.net") by vger.rutgers.edu with ESMTP id <S154423AbQAYRVB>; Tue, 25 Jan 2000 12:21:01 -0500
Message-ID: <388E14FD.FE9BA1C1@10xinc.com>
Date: Tue, 25 Jan 2000 13:26:21 -0800
From: Iain McClatchie <iain@10xinc.com>
Organization: 10x
X-Mailer: Mozilla 4.6 [en] (X11; I; Linux 2.2.12 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Jeff V. Merkey" <jmerkey@timpanogas.com>
Cc: Larry McVoy <lm@bitmover.com>, linux-kernel@vger.rutgers.edu
Subject: Re: SMP Theory (was: Re: Interesting analysis of linux kernel threading  by IBM)
References: <388DFBD8.5A89B100@10xinc.com> <388DFF0F.8E7784A1@timpanogas.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-kernel@vger.rutgers.edu

Jeff> How do you do fault tolerance on Shared-Everything (like what you
Jeff> describe)?

Disclaimer: I worked on CPUs, not the system controller, so I didn't
actually look at the Verilog.

At an electrical level, the links were designed to be hot-pluggable.
Each O2000 cabinet had I think 8 CPU cards in it (16 CPUs), and had
its own power supply and plug.  Within a cabinet, the I/O cables were
hot pluggable, as were the power supplies, fans, etc.  CPU cards were
not hot pluggable.

The hub chip on each CPU card connected to the shared memory network,
as well as the memory and the two CPUs.  I think the hub had hardware
registers which granted memory access and I/O access to other hubs.  A
CPU could deny access to its local resources from another CPU.  IRIX
could use these capabilities to completely partition the machine, but
I don't think they got any better than a shared-everything vs
shared-nothing toggle, at least, not while I was there.

[I think I'm using the word image wrongly, but you know what I mean.]

The idea was to write an operating system that could transfer
processes between O/S images, reboot O/S images independently, and
tolerate different O/S revisions on different partitions of the
machine.  That would allow online O/S upgrades, and perhaps even
replacement of whole cabinets of hardware.

I know the I/O system was set up to connect two different hub chips to
each I/O crossbar, to maintain access to the I/O resources should a
CPU card go down.  You could (of course) have multiple network
adapters going to the same network, and spread the adapters across
different cabinets.  I think you could also arrange to have fiber
channel disk arrays driven from two different cabinets.  This could
have made it possible to hot plug a cabinet while the machine was
online, without taking down any more processes or disks or whatever
than had already been taken down by the failing hardware.

The I/O stuff sounds heavyweight, but I would imagine you'd have to do
the very same thing on a "shared-nothing" cluster.

Jeff> Sounds like COMA or SCI?

COMA: Cache Only Memory Architecture.  Whenever you look at such a
thing, ask when cache lines are invalidated.  That's the hard problem,
and I haven't yet heard a reasonable answer.

SCI: Rings are bad for latency.  Latency is bad for CPUs.  SCI is all
rings - in the hardware, and in the coherency protocols.  Kendall
Square Research did something like this; it was a disaster.

SGI did neither of these things.  ccNUMA was most similar to the DASH
project from Stanford.  Not surprising -- SGI has very close ties to
Stanford.  Note that the Flash work is done on a mutated Origin.

Jeff> Most folks dismiss shared-everything architectures as
Jeff> non-resilent (Intel and Microsoft > have traditionally been
Jeff> shared-nothing bigots on this point).

Hmm.  Do people actually use NT for big clusters?  I thought clusters
were all done with VMS, Unix, and O/S 360 (or whatever it's called
these days).  I'm not sure how Microsoft's opinion on the matter would
affect anyone.

After working at SGI, I'm convinced that most of the MP problem is a
software problem.  Granted, if the CPU is integrated with the memory
controller, you'll need some good hooks to make MP work, but that's 3
to 10 man-years of work.  I'm not familiar with what Intel does in the
O/S and libraries/application area (iWarp?), but I would imagine any
bigotry on their part comes from the marketing guys selling what they
have.

And yes, I've heard about Intel's ASCI offering.  What was it, 9000
Pentium Pros in a single room?  Has Intel Oregon sold much to anyone
else?

-Iain McClatchie
www.10xinc.com
iain@10xinc.com
650-364-0520 voice
650-364-0530 FAX

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
