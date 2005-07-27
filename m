Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262193AbVG0VdF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262193AbVG0VdF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 17:33:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262183AbVG0VdB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 17:33:01 -0400
Received: from lirs02.phys.au.dk ([130.225.28.43]:27073 "EHLO
	lirs02.phys.au.dk") by vger.kernel.org with ESMTP id S262193AbVG0Vc2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 17:32:28 -0400
Date: Wed, 27 Jul 2005 23:32:02 +0200 (METDST)
From: Esben Nielsen <simlo@phys.au.dk>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: "K.R. Foley" <kr@cybsft.com>, Ingo Molnar <mingo@elte.hu>,
       LKML <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [RFC][PATCH] Make MAX_RT_PRIO and MAX_USER_RT_PRIO configurable
In-Reply-To: <1122485137.29823.109.camel@localhost.localdomain>
Message-Id: <Pine.OSF.4.05.10507272247580.848-100000@da410.phys.au.dk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Jul 2005, Steven Rostedt wrote:

> On Wed, 2005-07-27 at 19:01 +0200, Esben Nielsen wrote:
> > 
> > What for? Why can't you use FIFO at the same priorities for some of your
> > tasks? I pretty much quess you have a very few tasks which have some high
> > requirements. The rest of you "RT" task could easily share the lowest RT
> > priority. FIFO would also be more effective as you will have context
> > switches.
> > 
> > This about multiple priorities probably comes from an ordering of tasks:
> > You have a lot of task. You have a feeling about which one ought to be
> > more important than the other. Thus you end of with an ordered list of
> > tasks. BUT when you boil it down to what RT is all about, namely
> > meeting your deadlines, it doesn't matter after the 5-10 priorities
> > because the 5-10 priorities have introduced a lot of jitter to the rest
> > of the tasks anyway. You can just as well just put them at the same
> > priority.
> 
> Nope, I wouldn't agree with you here.  If you have tasks that will run
> periodically, at different frequencies, you need to order them. And each
> task would probably need a different priority. FIFO is very dangerous
> since it doesn't release a task until that task voluntarily sleeps.
> 
> A colleague of mine, well actually the VP of my company of the time,
> Doug Locke, gave me a perfect example.  If you have a program that runs
> a nuclear power plant that needs to wake up and run 4 seconds every 10
> seconds, and on that same computer you have a program running a washing
> machine that needs to wake up every 3 seconds and run for one second
> (I'm using seconds just to make the example simple). Which process gets
> the higher priority?  The answer is the washing machine.
> 
> Rational:  If the power plant was higher priority, the washing machine
> would fail almost every time, since the power plant program would run
> for 4 seconds, and since the cycle of the washing machine is 3 seconds,
> it would fail everytime the nuclear power plant program ran.  Now if you
> have the washing machine run in it's cycle, the nuclear power plant can
> easily make the 4 seconds ever 10 seconds, even when it is interrupted
> by the washing machine.
> 

This is rate monotonic scheduling
(http://en.wikipedia.org/wiki/Rate-monotonic_scheduling).
((Notice: The article gets it wrong on the priority inheritance/ceiling
stuff...))
(Notice: The fewer tasks the higher the theoretical max to the CPU
utialization :-)
In theory it works fine, but there is some drawbacks when you go to
reality:
1) You have to know the running time of all your tasks.
2) The running time is assumed contant.
3) You don't take into account the time it takes to perform a task switch.
4) Mutual exclution isn't considered.
5) What if things aren't periodic?

To make this work according to the theory you have to make a really,
really detailled analysis of your system. It is not really posible for
more than a few tasks. In practise you will have to be very much below the
theoretical limit for CPU utialization to be safe. 

And my claim is:
All the different periodic jobs you want to perform can most often easily
be put into groups like 1ms, 5ms, 20ms, 100ms groups. In each group you
can easily run with fifo preemption - and even within one OS thread.

Think about it: If you have two tasks with close to the same period and
one runs too long for the other to meets it's deadlines within fifo setup,
you are bound to be very close to the limits no matter which one you give
the highest priority.

> Doug also mentioned that you really want to have every task with a
> different priority, so it makes sense to have a lot of priorities.  I
> can't remember why he said this, but I'm sure you and I can find out by
> searching through his papers.
> 

On the contrary. Especially if you have mutual exclustion. If you run two
tasks at the same priority with fifo you don't hit congestion on you
mutexes (between those two tasks at least). If you give one of them just
one higher priority it will preempt the other. You thus risk congestion -
which is an expensive thing. Thus by giving your tasks different
priorities you risk that you system can't meet the deadlines due to the
extra CPU used!!

> -- Steve
> 
> 
> 

