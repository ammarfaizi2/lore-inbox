Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310155AbSCPIHS>; Sat, 16 Mar 2002 03:07:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310158AbSCPIHJ>; Sat, 16 Mar 2002 03:07:09 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:18187 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S310155AbSCPIG6>; Sat, 16 Mar 2002 03:06:58 -0500
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: 7.52 second kernel compile
Date: Sat, 16 Mar 2002 08:05:14 +0000 (UTC)
Organization: Transmeta Corporation
Message-ID: <a6uubq$uqr$1@penguin.transmeta.com>
In-Reply-To: <20020313085217.GA11658@krispykreme> <20020316061535.GA16653@krispykreme>
X-Trace: palladium.transmeta.com 1016266000 1506 127.0.0.1 (16 Mar 2002 08:06:40 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 16 Mar 2002 08:06:40 GMT
Cache-Post-Path: palladium.transmeta.com!unknown@penguin.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20020316061535.GA16653@krispykreme>,
Anton Blanchard  <anton@samba.org> wrote:
>
>hardware: 32 way logical partition, 1.1GHz POWER4, 60G RAM

It's interesting to see that scalability doesn't seem to be the #1
problem by a long shot. 

>7.52 seconds is not a bad result for something running under a hypervisor.
>The profile looks much better now. We still spend a lot of time flushing tlb
>entries but we can look into batching them.

I wonder if you wouldn't be better off just getting rid of the TLB range
flush altogether, and instead making it select a new VSID in the segment
register, and just forgetting about the old TLB contents entirely.

Then, when you do a TLB miss, you just re-use any hash table entries
that have a stale VSID.

It seems that you spend _way_ too much time actually trying to
physically invalidate the hashtables, which sounds like a total waste to
me. Especially as going through them to see whether they need to be
invalidated has to be a horribe thing for the dcache.

It would also be interesting to hear if you can just make the hash table
smaller (I forget the details of 64-bit ppc VM horrors, thank God!) or
just bypass it altogether (at least the 604e used to be able to just
disable the stupid hashing altogether and make the whole thing much
saner). 

Note that the official IBM "minimum recommended page table sizes" stuff
looks like total and utter crap.  Those tables have nothing to do with
sanity, and everything to do with a crappy OS called AIX that takes
forever to fill the hashes.  You should probably make them the minimum
size (which, if I remember correctly, is still quite a large amount of
memory thrown away on a TLB) if you can't just disable them altogether. 

			Linus
