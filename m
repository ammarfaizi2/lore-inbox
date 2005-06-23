Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262818AbVFWWG0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262818AbVFWWG0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 18:06:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262766AbVFWWBr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 18:01:47 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:59579 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S262663AbVFWV7a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 17:59:30 -0400
Date: Thu, 23 Jun 2005 23:59:21 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: john stultz <johnstul@us.ibm.com>
cc: lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       George Anzinger <george@mvista.com>,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>
Subject: Re: [PATCH 1/6] new timeofday core subsystem for -mm (v.B3)
In-Reply-To: <1119486592.9947.354.camel@cog.beaverton.ibm.com>
Message-ID: <Pine.LNX.4.61.0506231157180.3728@scrub.home>
References: <1119063400.9663.2.camel@cog.beaverton.ibm.com> 
 <Pine.LNX.4.61.0506181344000.3743@scrub.home>  <1119287354.9947.22.camel@cog.beaverton.ibm.com>
  <Pine.LNX.4.61.0506202231070.3728@scrub.home>  <1119311734.9947.143.camel@cog.beaverton.ibm.com>
  <Pine.LNX.4.61.0506211542580.3728@scrub.home>  <1119401841.9947.255.camel@cog.beaverton.ibm.com>
  <Pine.LNX.4.61.0506221739510.3728@scrub.home> <1119486592.9947.354.camel@cog.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 22 Jun 2005, john stultz wrote:

> Some other architectures try to handle these situations as well. One
> good example is PPC64 (which has greatly influenced my design). For
> correctness PPC64 goes as far as not using interpolation by avoiding
> almost all of the arch generic time code. It even has its own NTP
> adjustment code! 
> 
> I have come to believe the current arch generic tick based timekeeping
> is not sustainable. It seems to me in order to avoid bugs that customers
> are seeing, arches are going to have to avoid the current tick based
> arch generic code and implement their own non-interpolated based
> timekeeping code. So that is why I've created this proposal and
> implementation instead of just "fixing one issue".

I agree with you that the current time code is a problem for machines like 
ppc64, which basically use two different time sources.

We basically have two timer architectures: timer tick and continuous 
timer. The latter currently has to emulate the timer tick. Your patch 
completely reverses the rolls and forces everybody to produce a continuous 
timer, which I think is equally bad, as some simple computations become a 
lot more complex. Why should it not be possible to support both equally?

> So the question becomes: in order to achieve correctness, should every
> architecture implement a full timeofday subsystem of its own? I designed
> a system that would work, but instead of making it i386 and copying it
> for x86-64 and whatever else I end up working on, I propose we make it a
> common implementation.

That might result in the worst of both worlds. If I look at the ppc64 
implementation of gettimeofday, it's really nice and your (current) code 
would make this worse again. So why not leave it to the timer source, if 
it wants to manage a cycle counter or a xtime+offset? The common code can 
provide some helper functions to manage either of this. Converting 
everything to nanoseconds looks like a really bad compromise.

In the ppc64 example the main problem is that the generic tries to adjust 
for the wrong for the time source - the scheduler tick, which is derived 
from the cycle counter, so it has to redo all the work. Your code now 
introduces an abstract concept of nanosecond which adds extra overhead to 
either timer concept. Why not integrating what ppc64 does into the current 
timer code instead of replacing the current code with something else?

For tick based timer sources there is not much to do than incrementing 
xtime by precomputed constant. If I take ppc64 as an example for 
continuous time sources it does a lot less than your 
timeofday_periodic_hook(). Why is all this needed?
John, what I'd really like to see here is some math or code examples, 
which demonstrate how your new code is better compared to the old code. 
Your code makes a _huge_ transformation jump and I'd like you to explain 
some of the steps inbetween.

bye, Roman
