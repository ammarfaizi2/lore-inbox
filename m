Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262216AbSJAR7f>; Tue, 1 Oct 2002 13:59:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262217AbSJAR7f>; Tue, 1 Oct 2002 13:59:35 -0400
Received: from packet.digeo.com ([12.110.80.53]:3298 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S262216AbSJAR7e>;
	Tue, 1 Oct 2002 13:59:34 -0400
Message-ID: <3D99E3C5.E0F99E9E@digeo.com>
Date: Tue, 01 Oct 2002 11:04:53 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.38 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Daniel Phillips <phillips@arcor.de>
CC: Lorenzo Allegrucci <l.allegrucci@tiscalinet.it>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: qsbench, interesting results
References: <200209291615.24158.l.allegrucci@tiscalinet.it> <3D97E7D7.442733ED@digeo.com> <E17wNeG-0005th-00@starship>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 01 Oct 2002 18:04:55.0270 (UTC) FILETIME=[0BF83060:01C26975]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips wrote:
> 
> On Monday 30 September 2002 07:57, Andrew Morton wrote:
> > I'll take a look at some preferential throttling later on.  But
> > I must say that I'm not hugely worried about performance regression
> > under wild swapstorms.  The correct fix is to go buy some more
> > RAM, and the kernel should not be trying to cater for underprovisioned
> > machines if that affects the usual case.
> 
> The operative phrase here is "if that affects the usual case".  Actually,
> the quicksort bench is not that bad a model of a usual case, i.e., a
> working set 50% bigger than RAM.  The page replacement algorithm ought to
> do something sane with it, and swap performance ought to be decent in
> general, since desktop users typically have less than 1/2 GB.  With media
> apps, bloated desktops and all, it doesn't go as far as it used to.
> 
> My impression is that page replacement just hasn't gotten a lot of
> attention recently, and there is nothing wrong with that.  It's tuning,
> not a feature.

I don't think this is related to page replacement.  It's to do with
IO scheduling.  Decreasing the page reclaim latency and decreasing
disk read latency both damaged this particular case.

I'm fairly happy with 2.5 page replacement.  It's simple, clean
and very, very quick to build up a large pool of available memory
for what ever's going on at the time.

Problem is, it's cruel.  People don't notice that we shaved 15 seconds
off that three minute session of file bashing which they just did.
But they do notice that when they later wiggle their mouse, it takes
five seconds to pull the old stuff back in. 

The way I'd like to address that is with a "I know that's cool but I
don't like it" policy override knob.  But finding a sensible way of
doing that is taking some head-scratching.  Anything which says
"unmap pages much later" is doomed to failure I suspect.  It will
just increase latency when we really _do_ need to unmap, and will
cause weird OOM failures.

So hm.  Still thinking.

> The sort failure is something to worry about though - that's clearly a
> bug.

Yup. Dropped a dirty bit, or a hardware failure.  I ran it for six
hours or so on SMP, no probs.
