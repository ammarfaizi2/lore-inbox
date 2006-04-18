Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932202AbWDROcY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932202AbWDROcY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Apr 2006 10:32:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932205AbWDROcY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Apr 2006 10:32:24 -0400
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:61949 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S932202AbWDROcY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Apr 2006 10:32:24 -0400
Subject: Re: [RT] bad BUG_ON in rtmutex.c
From: Steven Rostedt <rostedt@goodmis.org>
To: Daniel Walker <dwalker@mvista.com>
Cc: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1145369381.5447.40.camel@localhost.localdomain>
References: <1145324887.17085.35.camel@localhost.localdomain>
	 <1145362851.5447.12.camel@localhost.localdomain>
	 <Pine.LNX.4.58.0604180831390.9005@gandalf.stny.rr.com>
	 <1145365886.5447.28.camel@localhost.localdomain>
	 <1145368228.17085.85.camel@localhost.localdomain>
	 <1145369381.5447.40.camel@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 18 Apr 2006 10:32:13 -0400
Message-Id: <1145370733.17085.110.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-04-18 at 07:09 -0700, Daniel Walker wrote:
> On Tue, 2006-04-18 at 09:50 -0400, Steven Rostedt wrote:
> > On Tue, 2006-04-18 at 06:11 -0700, Daniel Walker wrote:
> > 
> 
> > 
> > > 
> > > I was looking over the code, and it seems like once all the chain
> > > adjusting bottoms out you would end up with the correct priorities in
> > > the waiter structures .. Cause whatever task made the priority
> > > adjustment would just end up resetting the pi_waiters during it's
> > > adjustment process. (Seems like there's room for optimization
> > > though ..) 
> > 
> > I guess I just reiterated above what you are saying here.  Not sure if
> > this can be optimized.  You're talking about optimizing a case that
> > would seldom happen, but in doing so you stand a great chance of slowing
> > down the normal case.
> 
> I'm not really working on it, but on a bigger SMP machine it might not
> be that uncommon .. PI is running on all tasks now isn't it? It seems
> like a simple check could be at the same point as the BUG_ON() we're
> talking about .. <speculation> If that BUG_ON() triggers , it means the
> task is walking the lock chain at the same time as another task on the
> same chain, so you could make the lower prio chain stop at that point ..
> no?

Actually, where that BUG_ON was is the exiting of the chain walk. So it
does stop.  It's the higher priority task that needs to be continuing
the chain walk for that problem to occur.  So really, it already does
what you suggest :)

> 
> > To keep latencies down, we are letting the PI chain walk be preempted,
> > by releasing locks.  It's understood that the chain can then change
> > while walking (big debate about this between Ingo, tglx and Esben).  But
> > at the end, we decided on it being better to have latencies down, and
> > just make adjustments when they arise.  This also keeps the latencies
> > bounded, since the old way was harder to know the worst case (PI chain
> > creep).
> 
> I can imagine. Seems like PI is always a point of controversy .

But, as PI matures, it seems to be more and more acceptable.

> 
> > BUT!  I need to take another good look at the code, and maybe my
> > previous example of the failed BUG_ON is really a clue that there exists
> > a deeper bug.  If the processes D and E from my last example were of
> > different priorities, but still higher than A, could the end result be
> > setting A to the lower of the two?  This would be a bug, because then A
> > would not inherit the correct priority!
> 
> Did that BUG_ON ever trigger for you? I don't know how you would end up
> in that state without at least two chain walkers on different cpu's ..

Yes it did, but I need to clearify.  I have a custom kernel that is
based on Ingo's -rt patch, and I hit this bug on touching other parts of
the PI list.  When looking at fixing it, I realized that the BUG_ON
condition, was legitimate.

Also, I always test on SMP (then I test on UP) and the chain walkers
were on two CPUs.

-- Steve


