Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310579AbSCPUQB>; Sat, 16 Mar 2002 15:16:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310580AbSCPUPx>; Sat, 16 Mar 2002 15:15:53 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:56584 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S310579AbSCPUPl>; Sat, 16 Mar 2002 15:15:41 -0500
Date: Sat, 16 Mar 2002 12:14:06 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: <yodaiken@fsmlabs.com>
cc: Andi Kleen <ak@suse.de>, Paul Mackerras <paulus@samba.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [Lse-tech] Re: 10.31 second kernel compile
In-Reply-To: <20020316125711.B20436@hq.fsmlabs.com>
Message-ID: <Pine.LNX.4.33.0203161203050.31971-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 16 Mar 2002 yodaiken@fsmlabs.com wrote:
> 
> What about 2M pages?

Not useful for generic loads right now, and the latencies for clearing or
copying them them etc (ie single page faults - nopage or COW) are still
big enough that it would likely be a performance problem at that level.  
And while doing IO in 2MB chunks sounds like fun, since most files are
still just a few kB, your page cache memory overhead would be prohibitive
(ie even if you had 64GB of memory, you might want to cache more than a
few thousand files at the same time).

So then you'd need to do page caching at a finer granularity than you do
mmap, which imples absolutely horrible things from a coherency standpoint
(mmap/read/write are supposed to be coherent in a nice UNIX - even if
there are some of non-nice unixes still around).

We may get there some day, but right now 2M pages are not usable for use 
access.

64kB would be fine, though.

Oh, and in the specific case of hammer, one of the main advantages of the 
thing is of course running old binaries unchanged. And old binaries 
certainly do mmap's at smaller granularity than 2M (and have to, because a 
3G user address space won't fit all that many 2M chunks).

Give up on large pages - it's just not happening. Even when a 64kB page 
would make sense from a technology standpoint these days, backwards 
compatibility makes people stay at 4kB.

Instead of large pages, you should be asking for larger and wider TLB's
(for example, nothign says that a TLB entry has to be a single page:
people already do the kind of "super-entries", where one TLB entry
actually contains data for 4 or 8 aligned pages, so you get the _effect_
of a 32kB page that really is 8 consecutive 4kB pages).

Such a "wide" TLB entry has all the advantages of small pages (no 
memory fragmentation, backwards compatibility etc), while still being able 
to load 64kB worth of translations in one go.

(One of the advantages of a page table tree over a hashed setup becomes
clear in this kind of situation: you cannot usefully load multiple entries
from the same cacheline into one TLB entry in a hashed table, while in a
tree it's truly trivial)

		Linus

