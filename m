Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751456AbWDPI65@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751456AbWDPI65 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Apr 2006 04:58:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751457AbWDPI65
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Apr 2006 04:58:57 -0400
Received: from mail11.syd.optusnet.com.au ([211.29.132.192]:41185 "EHLO
	mail11.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1751456AbWDPI65 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Apr 2006 04:58:57 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Al Boldi <a1426z@gawab.com>
Subject: Re: [patch][rfc] quell interactive feeding frenzy
Date: Sun, 16 Apr 2006 18:58:23 +1000
User-Agent: KMail/1.9.1
Cc: ck list <ck@vds.kolivas.org>, linux-kernel@vger.kernel.org,
       Mike Galbraith <efault@gmx.de>
References: <200604112100.28725.kernel@kolivas.org> <200604161602.22177.kernel@kolivas.org> <200604161131.02585.a1426z@gawab.com>
In-Reply-To: <200604161131.02585.a1426z@gawab.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604161858.24171.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 16 April 2006 18:31, Al Boldi wrote:
> Con Kolivas wrote:
> > On Thursday 13 April 2006 01:25, Al Boldi wrote:
> > > Con Kolivas wrote:
> > > > mean 68.7 seconds
> > > >
> > > > range 63-73 seconds.
> > >
> > > Could this 10s skew be improved to around 1s to aid smoothness?
> >
> > It turns out to be dependant on accounting of system time which only
> > staircase does at the moment btw. Currently it's done on a jiffy basis.
> > To increase the accuracy of this would incur incredible cost which I
> > don't consider worth it.
>
> Is this also related to that?

No.

> > > Much smoother, but I still get this choke w/ 2 eatm 9999 loops running:
> > >
> > > 9 MB 783 KB eaten in 130 msec (74 MB/s)
> > > 9 MB 783 KB eaten in 2416 msec (3 MB/s)		<<<<<<<<<<<<<
> > > 9 MB 783 KB eaten in 197 msec (48 MB/s)
> > >
> > > You may have to adjust the kb to get the same effect.
> >
> > I've seen it. It's an artefact of timekeeping that it takes an
> > accumulation of data to get all the information. Not much I can do about
> > it except to have timeslices so small that they thrash the crap out of
> > cpu caches and completely destroy throughput.
>
> So why is this not visible in other schedulers?

When I said there's not much I can do about it I mean with respect to the 
design.

> Are you sure this is not a priority boost problem?

Indeed it is related to the way cpu is proportioned out in staircase being 
both priority and slice. Problem? The magnitude of said problem is up to the 
observer to decide. It's a phenomenon of only two infinitely repeating 
concurrent rapidly forking workloads when one forks every less than 100ms and 
the other more; ie your test case. I'm sure there's a real world workload 
somewhere somehow that exhibits this, but it's important to remember that 
overall it's fair with the occasional blip.

> > The current value, 6ms at 1000HZ, is chosen because it's the largest
> > value that can schedule a task in less than normal human perceptible
> > range when two competing heavily cpu bound tasks are the same priority.
> > At 250HZ it works out to 7.5ms and 10ms at 100HZ. Ironically in my
> > experimenting I found the cpu cache improvements become much less
> > significant above 7ms so I'm very happy with this compromise.
>
> Would you think this is dependent on cache-size and cpu-speed?

It is. Cache warmth time varies on architecture and design. Of course you're 
going to tell me to add a tunable and/or autotune this. Then that undoes the 
limiting it to human perception range. It really does cost us to export these 
things which are otherwise compile time constants... sigh.

> Also, what's this iso_cpu thing?

SCHED_ISO cpu usage which you're not using.

-- 
-ck
