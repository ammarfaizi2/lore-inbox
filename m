Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289652AbSAJUOF>; Thu, 10 Jan 2002 15:14:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289656AbSAJUN5>; Thu, 10 Jan 2002 15:13:57 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:17400 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S289652AbSAJUNs>; Thu, 10 Jan 2002 15:13:48 -0500
Message-ID: <3C3DF575.7ABDC213@mvista.com>
Date: Thu, 10 Jan 2002 12:11:33 -0800
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
        Mike Kravetz <kravetz@us.ibm.com>, Anton Blanchard <anton@samba.org>,
        Davide Libenzi <davidel@xmailserver.org>,
        Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [patch] O(1) scheduler, -G1, 2.5.2-pre10, 2.4.17 (fwd)
In-Reply-To: <Pine.LNX.4.33.0201101017380.2723-100000@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Thu, 10 Jan 2002, Ingo Molnar wrote:
> >
> > First it cleans up the load balancer's interaction with the timer tick.
> > There are now two functions called from the timer tick: busy_cpu_tick()
> > and idle_cpu_tick(). It's completely up to the scheduler to use them
> > appropriately.
> 
> This is _wrong_. The timer doesn't even know whether something is an idle
> task or not.
> 
> Proof: kapmd (right now the scheduler doesn't know this either, but at
> least we could teach it to know).
> 
> Don't try to make the timer code know stuff that the timer code should not
> and does not know about. Just call the scheduler on each tick, and let the
> scheduler make its decision.
> 
>                 Linus

Currently this code is called from the interrupt code in timer.  At this
time the xtime(write) lock is held and interrupts are off.

It could also be called from the "bh" section of timer.c at which time
the interrupts are on and the xtime lock is not held.

In either case, the state of the interrupt system is known and the the
irq_save version of the spin lock need not be used.  (Hay a cycle is a
cycle.)  

But more to the point, could the call(s) be made from the "bh" section
and thus inprove interrupt latency, not to mention xtime lock
contention.

Also, if a 250ms tick is needed, you might consider a timer (which is
also called from the "bh" code).
-- 
George           george@mvista.com
High-res-timers: http://sourceforge.net/projects/high-res-timers/
Real time sched: http://sourceforge.net/projects/rtsched/
