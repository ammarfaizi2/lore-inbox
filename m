Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422778AbWA1DmD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422778AbWA1DmD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 22:42:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422819AbWA1DmD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 22:42:03 -0500
Received: from mail.gmx.de ([213.165.64.21]:23438 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1422778AbWA1DmB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 22:42:01 -0500
X-Authenticated: #14349625
Subject: Re: [SCHED] wrong priority calc - SIMPLE test case
From: MIke Galbraith <efault@gmx.de>
To: Con Kolivas <kernel@kolivas.org>
Cc: Paolo Ornati <ornati@fastwebnet.it>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <200601281018.52121.kernel@kolivas.org>
References: <5.2.1.1.2.20060127175530.00c3db30@pop.gmx.net>
	 <1138392368.7770.72.camel@homer>  <200601281018.52121.kernel@kolivas.org>
Content-Type: text/plain
Date: Sat, 28 Jan 2006 04:43:54 +0100
Message-Id: <1138419834.7773.57.camel@homer>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-01-28 at 10:18 +1100, Con Kolivas wrote:
> On Saturday 28 January 2006 07:06, MIke Galbraith wrote:
> > 
> > The strategy works well enough to take the wind out of irman2's sails,
> > and interactive tasks can still do a nice reasonable burst of activity
> > without being evicted.  Down side to starvation control is that X is
> > sometimes a serious cpu user, and _can_ end up in the expired array (not
> > nice under load).  I personally don't think that's a show stopper
> > though... all you have to do is tell the scheduler that what it already
> > noticed, that X is a piggy, but an OK piggy by renicing it. It becomes
> > immune from active throttling, and all is well.  I know that's not going
> > to be popular, but you just can't let X have free rein without leaving
> > the barn door wide open.  (maybe that switch should stay since the
> > majority of boxen are workstations, and default to off?).
> 
> Sounds good but I have to disagree on the X renice thing. It's not that I have 
> a religious objection to renicing things. The problem is that our mainline 
> scheduler determines latency also by nice level. This means that if you 
> -renice a bursty cpu hog like X, then audio applications will fail unless 
> they too are reniced. Try it on your patch.

True.  If I renice, X can/will stomp all over xmms.  However, I can use
up to 30% cpu sustained before I would need to renice, so in the general
case, this patch actually improves latency because it will pull X out of
prio 16 much much sooner than before.  In this regard, it makes sense to
increase the scope, and throttle kernel threads as well.  What really
_should_ happen from the latency perspective is that as soon as we
detect a prio boundary crossing, we should downgrade the task a level
immediately, and then wait to see how things develope.  That would allow
the truely low latency tasks to preempt. When I compile a kernel for my
PIII/500 over nfs with my P4, knfsd eats about 40% of the PIII's cpu,
and all of it is there along side xmms.

What would be nice for the X case is a scheduling class that only meant
I'm always in the active array.  Open multimedia hardware, and you stay
active, but can be throttled under load without turning the box into a
brick.

Oh, while I'm thinking of it, if this thing makes it past discussion and
evaluation, I think my definition of idle task boost should be used
whether the active measures are applied or not.  The comments on that
code say idle tasks will only be promoted into the very bottom of the
interactive priority range via one long sleep. INTERACTIVE_SLEEP_AVG()
does that, and it helps.  That's not enough however.  What allows me to
defeat [1] irman2 isn't scrubbing to perfectly match how much it sleeps,
it is designed to sleep long between burns and hand over the baton to
the next partner in crime, so if I measured slice_avg purely from issue
time, slice_avg would match sleep_avg, and it would still be deadly.
Detecting the beginning of a new slice and moving the stamp forward to
match beginning of execution is what defeats it... the time he spends
trading the cpu with his evil twins doesn't count.


	-Mike

1.  Defeat is actually too strong a word, it is still one hell of an
unpleasant cpu hog in it's total... as any threaded app may be.


