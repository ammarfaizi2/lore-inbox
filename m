Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131968AbRBKHog>; Sun, 11 Feb 2001 02:44:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131995AbRBKHo0>; Sun, 11 Feb 2001 02:44:26 -0500
Received: from www.wen-online.de ([212.223.88.39]:41226 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S131968AbRBKHoW>;
	Sun, 11 Feb 2001 02:44:22 -0500
Date: Sun, 11 Feb 2001 08:43:09 +0100 (CET)
From: Mike Galbraith <mikeg@wen-online.de>
To: Rik van Riel <riel@conectiva.com.br>
cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.1-ac7
In-Reply-To: <Pine.LNX.4.21.0102101942550.2378-100000@duckman.distro.conectiva>
Message-ID: <Pine.Linu.4.10.10102110701300.723-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 10 Feb 2001, Rik van Riel wrote:

> On Sat, 10 Feb 2001, Mike Galbraith wrote:
> > On Sat, 10 Feb 2001, Rik van Riel wrote:
> > > On Sat, 10 Feb 2001, Marcelo Tosatti wrote:
> > > > On Sat, 10 Feb 2001, Mike Galbraith wrote:
> > > > 
> > > > > This change makes my box swap madly under load.
> > > > 
> > > > Swapped out pages were not being counted in the flushing limitation.
> > > > 
> > > > Could you try the following patch? 
> > > 
> > > Marcelo's patch should do the trick wrt. to making page_launder()
> > > well-behaved again.  It should fix the problems some people have
> > > seen with bursty swap behaviour.
> > 
> > It's still reluctant to shrink cache.  I'm hitting I/O saturation
> > at 20 jobs vs 30 with ac5.  (difference seems to be the delta in
> > space taken by cache.. ~same space shows as additional swap volume).
> 
> Indeed, to "fix" that we'll need to work at refill_inactive().

If this reluctance to munch cache can be relaxed a little, I think
we'll see the end of a long standing problem.  I often see a scenario
wherein we flush everything flushable, then steal the entire cache
before doing any paging.  The result (we hit a wall) is a mondo swapout
followed immediately by swapping it all right back in.  We seem to have
done a complete turnaround wrt paging vs flush/cache reap preference,
and that does effectively cure this scenario.. but methinks optimal
(-ENOENT?) lies somewhere in between.

> However, I am very much against tuning the VM for one particular
> workload. If you can show me that this problem also happens under
> other workloads we can work at changing it, but I don't think it's
> right to optimise the VM for a specific workload...

I'll watch behavior under other loads.  (I don't have enough network
capacity to do anything stressful there, and whatever load I pick
has to be compute bound as to not end up benchmarking my modest I/O
capacity.. suggestions welcome.  I use make -j primarily because it
doesn't need much I/O bandwidth for itself, but does allocate quite
a bit.. that leaves most I/O capacity free for vm usage)

Something else I see while watching it run:  MUCH more swapout than
swapin.  Does that mean we're sending pages to swap only to find out
that we never need them again?

	-Mike

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
