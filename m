Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129138AbRBPAz1>; Thu, 15 Feb 2001 19:55:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129183AbRBPAzR>; Thu, 15 Feb 2001 19:55:17 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:13318 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129138AbRBPAzO>; Thu, 15 Feb 2001 19:55:14 -0500
Date: Thu, 15 Feb 2001 16:55:02 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Jamie Lokier <lk@tantalophile.demon.co.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: x86 ptep_get_and_clear question
In-Reply-To: <20010216005742.B3207@pcep-jamie.cern.ch>
Message-ID: <Pine.LNX.4.10.10102151644580.12656-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 16 Feb 2001, Jamie Lokier wrote:
> 
> If you want to take it really far, it _could_ be that the TLB data
> contains both the pointer and the original pte contents.  Then "mark
> dirty" becomes
> 
>        val |= D
>        write *ptr

No. This is forbidden by the intel documentation. First off, the
documentation clearly states that it's a locked r-m-w cycle.

Secondly, the documentation also makes it clear that the CPU page table
accesses work correctly in SMP environments, which the above simply would
not do. It doesn't allow for people marking the entry invalid, which is
documented to work (see the very part I quoted).

So while the above could be a valid TLB writeback strategy in general for
some hypothetical architecture, it would _not_ be an x86 CPU any more if
it acted that way. 

So a plain "just write out our cached value" is definitely not legal.

> > Now, I will agree that I suspect most x86 _implementations_ will not do
> > this. TLB's are too timing-critical, and nobody tends to want to make
> > them bigger than necessary - so saving off the source address is
> > unlikely.
> 
> Then again, these hypothetical addresses etc. aren't part of the
> associative lookup, so could be located in something like an ordinary
> cache ram, with just an index in the TLB itself.

True. I'd still consider it unlikely for the other reasons (ie this is not
a timing-critical part of the normal CPU behaviour), but you're right - it
could be done without making the actual TLB any bigger or different, by
just having the TLB fill routine having a separate "source cache" that the
dirty-marking can use.

			Linus

