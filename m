Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317352AbSHJWh3>; Sat, 10 Aug 2002 18:37:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317354AbSHJWh3>; Sat, 10 Aug 2002 18:37:29 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:41734 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S317352AbSHJWh2>; Sat, 10 Aug 2002 18:37:28 -0400
Date: Sat, 10 Aug 2002 15:42:29 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Jamie Lokier <lk@tantalophile.demon.co.uk>
cc: Andrew Morton <akpm@zip.com.au>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch 6/12] hold atomic kmaps across generic_file_read
In-Reply-To: <20020810201027.E306@kushida.apsleyroad.org>
Message-ID: <Pine.LNX.4.44.0208101529490.2401-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 10 Aug 2002, Jamie Lokier wrote:
> 
> You've rightly pointed out that memcpy() is faster for a page, rather
> than VM tweaking.  But this isn't true of large reads, is it?
> Then the TLB invalidation cost could, in principle, be amortised over
> the whole large read.

Yes. We could make the special case be just for large reads, and amortise 
the cost of VM handling etc. That's especially true since a single page 
table lookup can look up a lot of pages, so you amortise more than just 
the TLB invalidation cost.

I have no idea where the cut-off point would be, and it will probably
depend quite a lot on whether the reader will write to the pages it read
from (causing COW faults) or not. If the read()'er will write to them, VM
tricks probably never pay off (since you will just be delaying the copy
and adding more page faults), so the question is what the common behaviour
is.

I _suspect_ that the common behaviour is to read just a few kB at a time
and that is basically doesn't ever really pay to play VM games.

(The "repeated read of a few kB" case is also likely to be the
best-performing behaviour, simply because it's usually _better_ to do many
small reads that re-use the cache than it is to do one large read that
blows your cache and TLB. Of course, that all depends on what your
patterns are after the read - do you want to have the whole file
accessible or not).

Anyway, this really is more food for thought than anything else, since
this is definitely not anything for 2.6.x. The page cache impact of doing
VM games is going to be noticeable too (because of the COW-by-hand
issues), and the VM behaviour in general changes.

For example, what do you do when somebody has a COW-page mapped into it's
VM space and you want to start paging stuff out? There are "interesting"
cases that just may mean that doing the COW thing is a really stupid thing
to do, even if it is intriguing to _think_ about it.

			Linus

