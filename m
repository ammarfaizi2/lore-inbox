Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292688AbSCRUFp>; Mon, 18 Mar 2002 15:05:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292733AbSCRUFZ>; Mon, 18 Mar 2002 15:05:25 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:48137 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S292688AbSCRUFO>; Mon, 18 Mar 2002 15:05:14 -0500
Date: Mon, 18 Mar 2002 12:04:05 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Cort Dougan <cort@fsmlabs.com>
cc: Paul Mackerras <paulus@samba.org>, <linux-kernel@vger.kernel.org>
Subject: Re: 7.52 second kernel compile
In-Reply-To: <20020318124215.C4155@host110.fsmlabs.com>
Message-ID: <Pine.LNX.4.33.0203181146070.4783-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 18 Mar 2002, Cort Dougan wrote:
>
> I have a counter-proposal.  How about a hardware tlb load (if we must have
> one) that does the right thing?

Well, I actually hink that an x86 comes fairly close.

Hashes simply do not do the right thing. You cannot do a speculative load
from a hash, and the hash overhead gets _bigger_ for TLB loads that miss
(ie they optimize for the hit case, which is the wrong optimization if the
on-chip TLB is big enough - and since Moore's law says that the on-chip
TLB _will_ be big enough, that's just stupid).

Basic premise in caching: hardware gets better, and misses go down.

Which implies that misses due to cache contention are misses that go away
over time, while forced misses (due to program startup etc) matter more
and more over time.

Ergo, you want to make build-up fast, because that's where you can't avoid
the work by trivially just making your caches bigger. So you want to have
architecture support for aggressive TLB pre-loading.

> I still think there are some clever tricks one could do with the VSID's to
> get a much saner system that the current hash table.  It would take some
> serious work I think but the results could be worthwhile.  By carefully
> choosing the VSID scatter algorithm and the size of the hash table I think
> one could get a much better access method.

But the whole point of _scattering_ is so incredibly broken in itself!
Don't do it.

You can load many TLB entries in one go, if you just keep them close-by to
each other. Load them into a prefetch-buffer (so that you don't dirty your
real TLB with speculative TLB loads), and since there tends to be locality
to TLB's, you've just automatically speeded up your hardware walker.

In contrast, a hash algorithm automatically means that you cannot sanely
do this _trivial_ optimization.

Face it, hashes are BAD for things like this.

		Linus

