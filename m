Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270546AbRHHSSz>; Wed, 8 Aug 2001 14:18:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270548AbRHHSSp>; Wed, 8 Aug 2001 14:18:45 -0400
Received: from sdsl-208-184-147-195.dsl.sjc.megapath.net ([208.184.147.195]:13400
	"EHLO bitmover.com") by vger.kernel.org with ESMTP
	id <S270546AbRHHSSd>; Wed, 8 Aug 2001 14:18:33 -0400
Date: Wed, 8 Aug 2001 11:18:44 -0700
From: Larry McVoy <lm@bitmover.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Hubertus Franke <frankeh@us.ibm.com>,
        Mike Kravetz <mkravetz@beaverton.ibm.com>,
        linux-kernel@vger.kernel.org, wscott@bitmover.com
Subject: Re: [RFC][PATCH] Scalable Scheduling
Message-ID: <20010808111844.S23718@work.bitmover.com>
Mail-Followup-To: Linus Torvalds <torvalds@transmeta.com>,
	Hubertus Franke <frankeh@us.ibm.com>,
	Mike Kravetz <mkravetz@beaverton.ibm.com>,
	linux-kernel@vger.kernel.org, wscott@bitmover.com
In-Reply-To: <Pine.LNX.4.33.0108081041260.8047-100000@penguin.transmeta.com> <Pine.LNX.4.33.0108081058420.8103-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <Pine.LNX.4.33.0108081058420.8103-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Wed, Aug 08, 2001 at 11:00:50AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 08, 2001 at 11:00:50AM -0700, Linus Torvalds wrote:
> Oh, and as I didn't actually run it, I have no idea about what performance
> is really like. I assume you've done lmbench runs across wide variety (ie
> UP to SMP) of machines with and without this?

I'd really really really like to see before/after cache miss counters for
lat_ctx runs.  LMbench is not fine enough grained to catch the addition
of cache misses unless the call path is so short that a 200ns cache miss
dominates.  Very few are.  

Someobdy really ought to take the time to make a cache miss counter program
that works like /bin/time.  So I could do

	$ cachemiss lat_ctx 2
	10123 instruction, 22345 data, 50432 TLB flushes

Has anyone done that?  If so, then what would be cool is if each of these
wonderful new features that people propose come with cachemiss results for
the related part of LMbench or some other benchmark.

Then we need to get smart about looking at the results.  It's quite easy to
convince yourself that all is well when running a microbenchmark (LMbench
is mostly microbenchmarks) because if the benchmark uses up < 100% of the
cache then you can add cache footprint up 100% of the cache and still see
really great cachemiss results.

The lat_ctx benchmark tries to address this.  For scheduler changes, I'd
want to see cachmiss results for runs with different numbers and sizes
of processes.  The lat_ctx benchmark has the ability to add to the cache
footprint in powers of 2.  I.e., it touches a power of 2 sized chunk of 
mem before context switching.

I don't remember if it touches or reads the data, we should certainly have
one that just reads to get around the write through cache problem.

Does all this make sense to most performance people out there?  It is good
to have lots of people understand the points here, argue them out and get
on the same page about them and then police the various perf changes that
people want to make.  I know Alan likes to call me "the man who says no"
but my voice is but one tiny one and I think we all really rely on Linus
to make these calls.  Let's give him a little help.  Try and develop a
mental picture of Linus leaning back on a nice rocking chair, smoking
a stogy, nodding sagely at the collective good judgement of the list.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
