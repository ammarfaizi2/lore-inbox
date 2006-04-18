Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932263AbWDRPH7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932263AbWDRPH7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Apr 2006 11:07:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932260AbWDRPGy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Apr 2006 11:06:54 -0400
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:30943 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S932263AbWDRPGk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Apr 2006 11:06:40 -0400
Date: Tue, 18 Apr 2006 11:06:17 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To: Daniel Walker <dwalker@mvista.com>
cc: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RT] bad BUG_ON in rtmutex.c
In-Reply-To: <1145371913.5447.48.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.58.0604181058430.12720@gandalf.stny.rr.com>
References: <1145324887.17085.35.camel@localhost.localdomain> 
 <1145362851.5447.12.camel@localhost.localdomain> 
 <Pine.LNX.4.58.0604180831390.9005@gandalf.stny.rr.com> 
 <1145365886.5447.28.camel@localhost.localdomain> 
 <1145368228.17085.85.camel@localhost.localdomain> 
 <1145369381.5447.40.camel@localhost.localdomain> 
 <1145370733.17085.110.camel@localhost.localdomain>
 <1145371913.5447.48.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 18 Apr 2006, Daniel Walker wrote:

> On Tue, 2006-04-18 at 10:32 -0400, Steven Rostedt wrote:
>
> >
> > Actually, where that BUG_ON was is the exiting of the chain walk. So it
> > does stop.  It's the higher priority task that needs to be continuing
> > the chain walk for that problem to occur.  So really, it already does
> > what you suggest :)
>
> I bet you could test for that condition in some other spots too . Like
> when it adds to the pi_waiters , you could test if the priorities are
> out of sync ..

You mean the other places in rt_mutex_adjust_prio_chain?  It already
checks once an iteration, anything more is just over kill.

>
> > >
> > > > To keep latencies down, we are letting the PI chain walk be preempted,
> > > > by releasing locks.  It's understood that the chain can then change
> > > > while walking (big debate about this between Ingo, tglx and Esben).  But
> > > > at the end, we decided on it being better to have latencies down, and
> > > > just make adjustments when they arise.  This also keeps the latencies
> > > > bounded, since the old way was harder to know the worst case (PI chain
> > > > creep).
> > >
> > > I can imagine. Seems like PI is always a point of controversy .
> >
> > But, as PI matures, it seems to be more and more acceptable.
>
> 	I read an article on priority ceiling as another method of doing this.
> Priority ceiling doesn't seem better, but at the same time I can't
> imagine how you'd implement it in Linux, or not in a straight forward
> way .

Actually, I always thought that running PREEMPT_DESKTOP with soft and hard
IRQS as threads was priority ceiling.  It's just that all locks have the
priority of MAX_RT_PRIO (no preemption allowed).  OK, this doesn't apply
to mutexes, but it does apply for spin_locks. :)

-- Steve

