Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280410AbRKEJRw>; Mon, 5 Nov 2001 04:17:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280415AbRKEJRm>; Mon, 5 Nov 2001 04:17:42 -0500
Received: from posta2.elte.hu ([157.181.151.9]:37076 "HELO posta2.elte.hu")
	by vger.kernel.org with SMTP id <S280410AbRKEJRh>;
	Mon, 5 Nov 2001 04:17:37 -0500
Date: Mon, 5 Nov 2001 11:15:14 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Tux mailing list <tux-list@redhat.com>
Cc: Roy Sigurd Karlsbakk <roy@karlsbakk.net>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Thomas Lussnig <tlussnig@bewegungsmelder.de>,
        <linux-kernel@vger.kernel.org>,
        khttpd mailing list <khttpd-users@zgp.org>
Subject: Re: [khttpd-users] khttpd vs tux
In-Reply-To: <3BE4460F.97FAD9CE@pobox.com>
Message-ID: <Pine.LNX.4.33.0111051013230.2914-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 3 Nov 2001, J Sloan wrote:

> Nobody scales better 1-4 CPUs, as indicated
> by specweb99 - at 8 CPUs linux is OK, but not
> as dominating....

This is a common misinterpretation of the TUX SPECweb99 numbers.
Performance and scalability are two distinct things. Also, maximum
performance on a given hardware, and the true scalability of the software
running on it are two different things as well. You can have a very slow
webserver that scales very well - and you can have a fast webserver that
scales poorly, but if the fast one beats the slow one even with the
highest number of CPUs used, the 'good' scalability of the slow webserver
does not matter much, does it? Also, TUX will max out an i486 pretty
quickly, and it will scale very badly on 4-way i486 systems (yes such
beasts do exist), simply because the hardware itself is pushed to the
maximum, more CPUs simply do not help - performance does not increase.

Ideally we want to have a very fast and very scalable webserver - TUX is
an attempt to be just that, and nothing more.

TUX maxes out the hardware on all systems tested so far - so the true
'scalability' of the Linux kernel and TUX simply cannot be measured: it's
the hardware (CPU, networking card, etc.) that is slowing TUX down, not
TUX's scalability faults. Algorithmically and SMP caching/locking-wise the
kernel and TUX is doing the right thing already, under these read-mostly
pagecache & TCP/IP loads. [well, this is not some black art, we simply
fixed every limit that showed up on the way.]

TUX maxes out 2-way and 4-way systems as well, while IIS does not appear
to do a good job there. So we can say that it's proven that IIS does not
scale well. I can still not say whether Linux+TUX scales well, i can only
say that it's too fast for the given hardware :-)

why does it look like as if TUX scaled well on 1, 2, 4 CPUs? Because
hardware designers are sizing up systems with more CPUs, so the true
limits of the hardware show a similar scalability graph as the scalability
graph would be of a scalable webserver.

Scalability of the software can only be judged on hardware where every
component (CPU, system board, cards) is faster than what TUX can push - so
it can be measured exactly how TUX (and the kernel) reacts to the addition
of more CPUs. Once a webserver pushes to the limits of the hardware, the
true scalability of the code gets distorted.

> When the high end specialists from IBM etc
> can send in patches that enhance high end
> performance without hurting the low end case
> the numbers on 8-32 CPUs should really start
> to shine. [...]

sadly, the TUX workloads scale 'perfectly' already both within TUX and
within the kernel (to the best of my knowledge), from an algorithmic point
of view - i dont think anyone could claim to be able to improve that
significantly, even on 32 way systems. My main development box is an 8-way
ia32 box (and a fair number of other kernel hackers have such boxes as
well), so we know the 8-way limits pretty well. Note that the TUX patches
include 3 extra scalability patches to the stock kernel:

 - the pagecache SMP-scalability patch [gets rid of pagecache_lock]
 - the smptimers patch [makes timers completely per-CPU.]
 - the per-CPU page allocator

There might be other areas in the kernel that could scale better under
non-TUX workloads (especially the block IO code has some scalability
problems), but none of them affects TUX in any measurable way on the
systems we measured. I'd say that TUX should scale pretty well to 16 or 32
CPUs, and SGI's tests appear to prove this in part: the pagecache
scalability patch alone helped their (non-TUX) NUMA cached-dbench
performance measurably. [on an 8-way system the pagecache scalability
patch is only a small but measurable win.] And if any kernel scalability
limit pops up on bigger boxes, we can fix it - there are few fundamental
issues left.

	Ingo

