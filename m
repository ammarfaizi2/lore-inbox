Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263677AbTH0QLn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Aug 2003 12:11:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263623AbTH0QKO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Aug 2003 12:10:14 -0400
Received: from smtp.bitmover.com ([192.132.92.12]:45194 "EHLO
	smtp.bitmover.com") by vger.kernel.org with ESMTP id S263625AbTH0QJt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Aug 2003 12:09:49 -0400
Date: Wed, 27 Aug 2003 09:09:39 -0700
From: Larry McVoy <lm@bitmover.com>
To: William Lee Irwin III <wli@holomorphy.com>,
       Peter Chubb <peterc@gelato.unsw.edu.au>, akpm@digeo.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6.0-test4 -- add context switch counters
Message-ID: <20030827160939.GA29987@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	William Lee Irwin III <wli@holomorphy.com>,
	Peter Chubb <peterc@gelato.unsw.edu.au>, akpm@digeo.com,
	linux-kernel@vger.kernel.org
References: <16204.520.61149.961640@wombat.disy.cse.unsw.edu.au> <20030827065435.GV4306@holomorphy.com> <20030827155246.GA23609@work.bitmover.com> <20030827160133.GD4306@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030827160133.GD4306@holomorphy.com>
User-Agent: Mutt/1.4i
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam (whitelisted), SpamAssassin (score=0.5,
	required 7, AWL, DATE_IN_PAST_06_12)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 27, 2003 at 09:01:33AM -0700, William Lee Irwin III wrote:
> On Wed, Aug 27, 2003 at 08:52:46AM -0700, Larry McVoy wrote:
> > I normally hate ifdefs but this might be a good place to use a bunch of 
> > macros and make them conditional on config_stats or something.  Updating
> > counters is going to add to the size of the data cache footprint and it
> > would be nice, for those people working on embedded low speed processors,
> > if they could config this out.  I personally would leave it in, I like
> > this stats.  I just know that the path to slowness is paved one cache
> > miss at a time.
> 
> I've profiled this and know the memory stats don't do any harm; the
> rest I'd have to see profiled. AFAICT all the damage is done after
> ticking mm->rss in the various pagetable copying/blitting operations,
> and once we've taken that hit (in mainline!) the other counters are
> noise-level. The integral counters are another story; I've not seen
> those in action.

This is the classic response that I get whenever I raise this sort of
concern.  I got it at Sun, I got it at SGI.  Everyone says "my change
made no difference".  And they are right from one point of view: you
run some micro benchmark and you can't see any difference.

Of course you can't see any difference, in the microbenchmark everything
is in the cache.  But you did increase the amount of cache usage.
Consider a real world case where the application and the kernel now
just exactly fit in the caches for the critical loop.  Adding one
extra cache line will hurt that application but would never be seen in
a microbenchmark.

The only way to really measure this is with real work loads and a cache
miss counter.  And even that won't always show up because if the work load
you choose happened to only use 1/2 of the data cache (for instance) you
need to add enough more than 1/2 of the cache lines to show up in the 
results.

Think of it this way: we can add N extra cache lines and see no
difference.  Then we add the Nth+1 and all of a sudden things get slow.
Is that the fault of the Nth+1 guy?  Nope.  It's the fault of all N,
the Nth+1 guy just had bad timing, he should have gotten his change
in earlier.

I realize that I'm being extreme here but if I can get this point across
that's a good thing.  I'm convinced that it was a lack of understanding
of this point that lead to the bloated commercial operating systems.
Linux needs to stay fast.  Processors have cycle times of a third of a
nanosecond yet memory is still ~130ns away.
-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
