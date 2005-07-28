Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261427AbVG1MSg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261427AbVG1MSg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 08:18:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261435AbVG1MSf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 08:18:35 -0400
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:25073 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S261449AbVG1MSJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 08:18:09 -0400
Subject: Re: [RFC][PATCH] Make MAX_RT_PRIO and MAX_USER_RT_PRIO configurable
From: Steven Rostedt <rostedt@goodmis.org>
To: Esben Nielsen <simlo@phys.au.dk>
Cc: "K.R. Foley" <kr@cybsft.com>, Ingo Molnar <mingo@elte.hu>,
       LKML <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <Pine.OSF.4.05.10507272247580.848-100000@da410.phys.au.dk>
References: <Pine.OSF.4.05.10507272247580.848-100000@da410.phys.au.dk>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Thu, 28 Jul 2005 08:17:50 -0400
Message-Id: <1122553070.29823.223.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-07-27 at 23:32 +0200, Esben Nielsen wrote:

> 
> This is rate monotonic scheduling
> (http://en.wikipedia.org/wiki/Rate-monotonic_scheduling).

Bingo! you win the cigar!

> ((Notice: The article gets it wrong on the priority inheritance/ceiling
> stuff...))
It's too early in the morning for me.  What's wrong with this?

> (Notice: The fewer tasks the higher the theoretical max to the CPU
> utialization :-)
> In theory it works fine, but there is some drawbacks when you go to
> reality:
> 1) You have to know the running time of all your tasks.

We look at the maximum running time to finish the job.

> 2) The running time is assumed contant.

Just the maximum.

> 3) You don't take into account the time it takes to perform a task switch.

We add that on top of the running time.

> 4) Mutual exclution isn't considered.

We also add a buffer on top of running time for all locks held.

> 5) What if things aren't periodic?

They are not given a high priority.

> 
> To make this work according to the theory you have to make a really,
> really detailled analysis of your system. It is not really posible for
> more than a few tasks. In practise you will have to be very much below the
> theoretical limit for CPU utialization to be safe. 

I just write the code, my customers are the expert on their system :-)

But I do know that we do not go to the limit of CPU utilization. There
is always a buffer on all RT projects I've been on.

> 
> And my claim is:
> All the different periodic jobs you want to perform can most often easily
> be put into groups like 1ms, 5ms, 20ms, 100ms groups. In each group you
> can easily run with fifo preemption - and even within one OS thread.
> 
> Think about it: If you have two tasks with close to the same period and
> one runs too long for the other to meets it's deadlines within fifo setup,
> you are bound to be very close to the limits no matter which one you give
> the highest priority.

Sounds reasonable. We do do something similar. But we still use
different priorities with threads with the same period.  It's when the
real word priority comes in, and you forget the math.  We really do want
that nuclear power plant running even if the washing machine should run!

> 
> > Doug also mentioned that you really want to have every task with a
> > different priority, so it makes sense to have a lot of priorities.  I
> > can't remember why he said this, but I'm sure you and I can find out by
> > searching through his papers.
> > 
> 
> On the contrary. Especially if you have mutual exclustion. If you run two
> tasks at the same priority with fifo you don't hit congestion on you
> mutexes (between those two tasks at least). If you give one of them just
> one higher priority it will preempt the other. You thus risk congestion -
> which is an expensive thing. Thus by giving your tasks different
> priorities you risk that you system can't meet the deadlines due to the
> extra CPU used!!

I wont argue here.  I let my customers analyze the system and I just
write the code for them. I only make suggestions, and just do what I'm
told. You brought up some interesting points, and if I ever get time, I
will need to write some utilities to show the pros and cons of each
approach.

-- Steve

