Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317844AbSHCV1w>; Sat, 3 Aug 2002 17:27:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317849AbSHCV1w>; Sat, 3 Aug 2002 17:27:52 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:48144 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S317844AbSHCV1v>;
	Sat, 3 Aug 2002 17:27:51 -0400
Message-ID: <3D4C4DD9.779C057B@zip.com.au>
Date: Sat, 03 Aug 2002 14:40:41 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Daniel Phillips <phillips@arcor.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Rmap speedup
References: <E17aiJv-0007cr-00@starship> <E17aptH-0008DR-00@starship> <3D4B692B.46817AD0@zip.com.au> <E17b3sE-0001T4-00@starship>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips wrote:
> 
> On Saturday 03 August 2002 07:24, Andrew Morton wrote:
> > - page_add_rmap has vanished
> > - page_remove_rmap has halved (80% of the remaining is the
> >   list walk)
> > - we've moved the cost into the new locking site, zap_pte_range
> >   and copy_page_range.
> 
> > So rmap locking is still a 15% slowdown on my soggy quad, which generally
> > seems relatively immune to locking costs.
> 
> What is it about your quad?

Dunno.  I was discussing related things with David M-T yesterday.  A
`lock;incl' on a P4 takes ~120 cycles, everything in-cache.  On my PIII
it's 33 cycles.  12-16 on ia64.   Lots of variation there.

Instrumentation during your 35 second test shows:

- Performed an rmap lock 6.5M times
- Got a hit on the cached lock 9.2M times
- Got a miss on the cached lock 2.6M times.

So the remaining (6.5M - 2.6M) locks were presumably in the 
pagefault handlers.

lockmeter results are at http://www.zip.com.au/~akpm/linux/rmap-lockstat.txt

- We took 3,000,000 rwlocks (mainly pagecache)
- We took 20,000,000 spinlocks
- the locking is spread around copy_mm, copy-page_range,
  do_no_page, handle_mm_fault, page_add_rmap, zap_pte_range
- total amount of CPU time lost spinning on locks is 1%, mainly
  in page_add_rmap and zap_pte_range.

That's not much spintime.   The total system time with this test went
from 71 seconds (2.5.26) to 88 seconds (2.5.30). (4.5 seconds per CPU)
So all the time is presumably spent waiting on cachelines to come from
other CPUs, or from local L2.

lockmeter results for 2.5.26 are at
http://www.zip.com.au/~akpm/linux/2.5.26-lockstat.txt

- 2.5.26 took 17,000,000 spinlocks
- but 3,000,000 of those were kmap_lock and pagemap_lru_lock, which
  have been slaughtered in my tree.  rmap really added 6,000,000
  locks to 2.5.30.


Running the same test on 2.4:

2.4.19-pre7:
	./daniel.sh  35.12s user 65.96s system 363% cpu 27.814 total
	./daniel.sh  35.95s user 64.77s system 362% cpu 27.763 total
	./daniel.sh  34.99s user 66.46s system 364% cpu 27.861 total

2.4.19-pre7+rmap:
	./daniel.sh  36.20s user 106.80s system 363% cpu 39.316 total
	./daniel.sh  38.76s user 118.69s system 399% cpu 39.405 total
	./daniel.sh  35.47s user 106.90s system 364% cpu 39.062 total

2.4.19-pre7+rmap-13b+your patch:
	./daniel.sh  33.72s user 97.20s system 364% cpu 35.904 total
	./daniel.sh  35.18s user 94.48s system 363% cpu 35.690 total
	./daniel.sh  34.83s user 95.66s system 363% cpu 35.921 total

The system time is pretty gross, isn't it?

And it's disproportional to the increased number of lockings.

> ...
> 
> But before we start on the micro-optimization we need to know why your quad
> is so unaffected by the big change.

We need a little test proggy to measure different platforms cache
load latency, locked operations, etc.  I have various bits-n-pieces,
will put something together.

>  Are you sure the slab cache batching of
> pte chain allocation performs as well as my simpleminded inline batching?

Slab is pretty good, I find.  And there's no indication of a problem
in the profiles.

> (I batched the pte chain allocation lock quite nicely.)  What about the bit
> test/set for the direct rmap pointer, how is performance affected by dropping
> the direct lookup optimization?

It didn't show in the instruction-level oprofiling.

>  Note that you are holding the rmap lock
> considerably longer than I was, by holding it across __page_add_rmap instead
> of just across the few instructions where pointers are actually updated.  I'm
> also wondering if gcc is optimizing your cached_rmap_lock inline as well as
> you think it is.
> 
> I really need to be running on 2.5 so I can crosscheck your results.  I'll
> return to the matter of getting the dac960 running now.

Sigh.  No IDE?

> Miscellaneous question: we are apparently adding rmaps to reserved pages, why
> is that?

That's one for Rik...
