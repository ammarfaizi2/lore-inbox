Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262937AbTHUX7e (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Aug 2003 19:59:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262939AbTHUX7e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Aug 2003 19:59:34 -0400
Received: from c210-49-248-224.thoms1.vic.optusnet.com.au ([210.49.248.224]:51911
	"EHLO mail.kolivas.org") by vger.kernel.org with ESMTP
	id S262937AbTHUX7b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Aug 2003 19:59:31 -0400
Message-ID: <1061510363.3f455cdb079d4@kolivas.org>
Date: Fri, 22 Aug 2003 09:59:23 +1000
From: Con Kolivas <kernel@kolivas.org>
To: Mike Galbraith <efault@gmx.de>
Cc: Voluspa <lista1@comhem.se>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] O17int
References: <5.2.1.1.2.20030821090657.00b45af8@pop.gmx.net> <200308210723.42789.kernel@kolivas.org> <5.2.1.1.2.20030821090657.00b45af8@pop.gmx.net> <5.2.1.1.2.20030821154224.01990b48@pop.gmx.net>
In-Reply-To: <5.2.1.1.2.20030821154224.01990b48@pop.gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Mike Galbraith <efault@gmx.de>:

> At 09:46 PM 8/21/2003 +1000, Con Kolivas wrote:
> >On Thu, 21 Aug 2003 17:53, Mike Galbraith wrote:
> > > At 03:26 PM 8/21/2003 +1000, Con Kolivas wrote:
> > > >Unhappy with this latest O16.3-O17int patch I'm withdrawing it, and
> > > >recommending nothing on top of O16.3 yet.
> > > >
> > > >More and more it just seems to be a bandaid to the priority inverting
> spin
> > > > on waiters, and it does seem to be of detriment to general
> interacivity.
> > > > I can now reproduce some loss of interactive feel with O17.
> > > >
> > > >Something specific for the spin on waiters is required that doesn't
> affect
> > > >general performance. The fact that I can reproduce the same starvation
> in
> > > >vanilla 2.6.0-test3 but to a lesser extent means this is an intrinsic
> > > > problem that needs a specific solution.
> > >
> > > I can see only one possible answer to this - never allow a normal task
> to
> > > hold the cpu for long stretches (define) while there are other tasks
> > > runnable.  (see attachment)
> >
> >I assume you mean the strace ? That was the only attachment, and it just 
> >looks
> >like shiploads of schedule() from the get time of day. Yes?
> 
> (no, ~2 seconds of X being awol)
> 
> > > I think the _easiest_ fix for this particular starvation (without
> tossing
> > > baby out with bath water;) is to try to "down-shift" in schedule() when
> > > next == prev.  This you can do very cheaply with a find_next_bit(). 
> That
> > > won't help the case where there are multiple tasks involved, but should
> fix
> > > the most common case for dirt cheap.  (another simple alternative is to
> > > globally "down-shift" periodically)
> >
> >Err funny you should say that; that's what O17 did. But it hurt because it
> >would never allow a task that used a full timeslice to be next==prev. The
> 
> If someone is marked for resched, it means we want to give someone else the 
> cpu right?  In this case at least, re-selecting blender is not the right 
> thing to do.  Looks like he's burning rubber... going nowhere fast.
> 
> >  less I throttled that, the less effective the antistarvation was. However
> >this is clearly a problem without using up full timeslices. I originally
> >thought they weren't trying to schedule lots because of the drop in ctx
> >during starvation but I forgot that rescheduling the same task doesnt count
> >as a ctx.
> 
> Hmm.  In what way did it hurt interactivity?  I know that if you pass the 
> cpu off to non-gui task who's going to use his full 100 ms slice, you'll 
> definitely feel it.  (made workaround, will spare delicate tummies;)  If 

Well I made it so that if full timeslice is used, and then the same task is 
next==prev, let next candidate for scheduling get up to TIMESLICE_GRANULARITY 
timeslice; not a full task timeslice. Even this was palpable as losing the X 
waving around smoothness with anything else burning (kernel compile, bunzip or 
whatever). Basically X is somewhere between a frequent sleeper with short 
periods of cpu time, or a burst of full timeslices when used heavily. When it's 
full timeslices, it suffers under the same things that throttle spinners.

> you mean that, say X releases the cpu and has only a couple of ms left on 
> it's slice and is alone in it's queue, that preempting it at the end of 
> it's slice after having only had the cpu for such a short time after wakeup 
> hurts, you can qualify the preempt decision with a cpu possession time
> check.

I was letting it run out the full timeslice unabated, and only preventing it 
from getting immediately rescheduled.

> 
> >  Also I recall that winegames got much better in O10 when everything was
> >charged at least one jiffy (pre nanosecond timing) suggesting those that
> were
> >waking up for minute amounts of time repeatedly were being penalised; thus
> >taking out the possibility of the starving task staying high priority for
> >long.
> 
> (unsure what you mean here)

Ok I think blender (we say blenndah in .au) is waking up, polling for X, then 
going back to sleep only to do it all over again. I don't think it's wasting a 
full timeslice at all. There seem to be two variants of this spin on wait; one 
is the task that uses a full timeslice spinning (wine games), and the other is 
waking up, rescheduling and going back to sleep only to do it all over again. 

> 
> > > The most generally effective form of the "down-shift" anti-starvation
> > > tactic that I've tried, is to periodically check the head of all queues
> > > below current position (can do very quickly), and actively select the
> > > oldest task who hasn't run since some defined deadline.  Queues are
> > > serviced based upon priority most of the time, and based upon age some
> of
> > > the time.
> >
> >Hmm also sounds fudgy.
> 
> Yeah.  I crossbred it with a ~deadline scheduler, and created a mutt.

But how did this mutt perform?

>          -Mike (2'6"") 

+ another 2'6"" doesn't quite get us tall enough. Maybe we need another 
munchkin.

Con
