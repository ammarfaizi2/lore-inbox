Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269804AbRIECen>; Tue, 4 Sep 2001 22:34:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270075AbRIECec>; Tue, 4 Sep 2001 22:34:32 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:14086 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S269804AbRIECe0>; Tue, 4 Sep 2001 22:34:26 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Andrea Arcangeli <andrea@suse.de>
Subject: Re: page_launder() on 2.4.9/10 issue
Date: Wed, 5 Sep 2001 04:41:32 +0200
X-Mailer: KMail [version 1.3.1]
Cc: Jan Harkes <jaharkes@cs.cmu.edu>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org
In-Reply-To: <20010904131349.B29711@cs.cmu.edu> <20010904200348Z16581-32383+3477@humbolt.nl.linux.org> <20010905000437.T699@athlon.random>
In-Reply-To: <20010905000437.T699@athlon.random>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010905023436Z16026-32383+3520@humbolt.nl.linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On September 5, 2001 12:04 am, Andrea Arcangeli wrote:
> On Tue, Sep 04, 2001 at 10:10:42PM +0200, Daniel Phillips wrote:
> > Which reproducible deadlocks did you have in mind, and how do I reproduce
> > them?
> 
> I meant the various known oom deadlocks. I've one showstopper report
> with the blkdev in pagecache patch with in use also a small ramdisk
> pagecache backed, the pagecache backed works like ramfs etc.. marks the
> page dirty again in writepage, somebody must have broken page_launder or
> something else in the memory managment because exactly the same code was
> working fine in 2.4.7. Now it probably loops or breaks totally when
> somebody marks the page dirty again, but the vm problems are much much
> wider, starting from the kswapd loop on gfp dma or gfp normal, the
> overkill swapping when there's tons of ram in freeable cache and you are
> taking advantage of the cache, lack of defragmentation, lack of
> knowledge of the classzone to balance in the memory balancing (this in
> turn is why kswapd goes mad),  very imprecise estimation of the freeable
> ram, overkill code in the allocator (the limit stuff is senseless), tons
> magic numbers that doesn't make any sensible difference, tons of cpu
> wasted, performance that decreases at every run of the benchmarks,
> etc...
> 
> If you believe I'm dreaming just forget about this email, this is my
> last email about this until I've finished.

Sure.  You mentioned one deadlock - oom - and a bunch of suckages.  The oom 
problem is related to imprecise knowledge of freeable memory, you could group 
those two together.  Active defragmentation isn't going to be that hard, I 
think.  We'll see...

Don't forget all the stuff that works pretty well now.  Most of the problem 
reports we're getting now are concerned with the fact that we're loading up 
logs with allocation failure messages.  We probably wouldn't get those 
reports if we just turned of the messages now.  Bounce buffer allocation was 
the stopper there and Marcelo's patch has put that one away.  I think I found 
a practical solution to the 0 order atomic failures, subject to more 
confirmation.  Balancing and aging, while not perfect, are at least 
servicable.  Hugh Dickins rooted out a bunch of genuine bugs in swap.  Rik 
seems to have defanged the swap space allocation problem.  Other bugs were 
rooted out and killed by Ben and Linus.  All in all, things are much improved.

The biggest issue we need to tackle before calling it a servicable vm system 
is the freeable memory accounting.

--
Daniel
