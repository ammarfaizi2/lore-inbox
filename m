Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263252AbVFXLDy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263252AbVFXLDy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Jun 2005 07:03:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263249AbVFXK7s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Jun 2005 06:59:48 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:30911 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S263253AbVFXK6W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Jun 2005 06:58:22 -0400
Date: Fri, 24 Jun 2005 12:58:09 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: john stultz <johnstul@us.ibm.com>
cc: lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       George Anzinger <george@mvista.com>,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>
Subject: Re: [PATCH 1/6] new timeofday core subsystem for -mm (v.B3)
In-Reply-To: <1119573191.24889.110.camel@cog.beaverton.ibm.com>
Message-ID: <Pine.LNX.4.61.0506241147180.3728@scrub.home>
References: <1119063400.9663.2.camel@cog.beaverton.ibm.com> 
 <Pine.LNX.4.61.0506181344000.3743@scrub.home>  <1119287354.9947.22.camel@cog.beaverton.ibm.com>
  <Pine.LNX.4.61.0506202231070.3728@scrub.home>  <1119311734.9947.143.camel@cog.beaverton.ibm.com>
  <Pine.LNX.4.61.0506211542580.3728@scrub.home>  <1119401841.9947.255.camel@cog.beaverton.ibm.com>
  <Pine.LNX.4.61.0506221739510.3728@scrub.home>  <1119486592.9947.354.camel@cog.beaverton.ibm.com>
  <Pine.LNX.4.61.0506231157180.3728@scrub.home> <1119573191.24889.110.camel@cog.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 23 Jun 2005, john stultz wrote:

> > We basically have two timer architectures: timer tick and continuous 
> > timer. The latter currently has to emulate the timer tick. Your patch 
> > completely reverses the rolls and forces everybody to produce a continuous 
> > timer, which I think is equally bad, as some simple computations become a 
> > lot more complex. Why should it not be possible to support both equally?
> 
> Yep, I think this is really the core contention. 
> 
> In my design I've reworked the time subsystem to assume time flows
> continuously as provided by the timesource. On systems that do not have
> a continuous counters like the PPC timebase, they can use a similar tick
> based interpolation method to provide continuous time. However this
> interpolation is done in the timesource driver instead of in the generic
> code.

By introducing extra overhead, which is difficult to get rid of again.

> > That might result in the worst of both worlds. If I look at the ppc64 
> > implementation of gettimeofday, it's really nice and your (current) code 
> > would make this worse again. 
> 
> Could you be more specific about how you feel the ppc64 is nice and how
> my code is worse? My code is actually quite influenced by the ppc64
> code, so specific details might help me respond.

The ppc64 converts the timebase directly to a timeval, your code puts the 
nanosecond step inbetween.

> > So why not leave it to the timer source, if 
> > it wants to manage a cycle counter or a xtime+offset? The common code can 
> > provide some helper functions to manage either of this. Converting 
> > everything to nanoseconds looks like a really bad compromise.
> > 
> > In the ppc64 example the main problem is that the generic tries to adjust 
> > for the wrong for the time source - the scheduler tick, which is derived 
> > from the cycle counter, so it has to redo all the work. Your code now 
> > introduces an abstract concept of nanosecond which adds extra overhead to 
> > either timer concept. Why not integrating what ppc64 does into the current 
> > timer code instead of replacing the current code with something else?
> 
> I'm not sure I followed that paragraph. Would you clarify a bit?

What exactly?

> Computationally, there are two 64bit mult/shifts (in the interval
> calculations) and a 64 bit divide that occurs in my code. However this
> is only done every 50ms instead of every tick, so I don't believe there
> is much of a performance impact.

You forgot the cyc2ns conversions. Compare this now to some simple 32bit 
math executed every 100ms. Just look at all 32bit archs which use the 
generic do_div and you get an idea, who will not be happy with your new 
code.

Why do you do the adjustment at _every_ call? Why don't you take advantage 
of the fact, that you can be called regularly? In a tick based system you 
can be called every n*tick_nsec ns (without even the need to read a 
possibly expensive timer offset), in a cycle counter system you can 
trigger a call when the counter is past a certain value. In either case 
you know the callback function is called on average in a regular interval, 
so you can precompute adjustments based on this. Ignoring this possibility 
looks like a huge step back to me.

bye, Roman
