Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291372AbSCHXzh>; Fri, 8 Mar 2002 18:55:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291484AbSCHXz1>; Fri, 8 Mar 2002 18:55:27 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:37094 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S291372AbSCHXzR>;
	Fri, 8 Mar 2002 18:55:17 -0500
Content-Type: text/plain; charset=US-ASCII
From: Hubertus Franke <frankeh@watson.ibm.com>
Reply-To: frankeh@watson.ibm.com
Organization: IBM Research
To: Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH] Futexes IV (Fast Lightweight Userspace Semaphores)
Date: Fri, 8 Mar 2002 18:56:05 -0500
X-Mailer: KMail [version 1.3.1]
Cc: Rusty Russell <rusty@rustcorp.com.au>, <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0203081532550.4421-100000@penguin.transmeta.com>
In-Reply-To: <Pine.LNX.4.33.0203081532550.4421-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020308235510.EBDF83FE06@smtp.linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 08 March 2002 06:41 pm, Linus Torvalds wrote:
> On Fri, 8 Mar 2002, Hubertus Franke wrote:
> > > I think the next step should be to map in one page of kernel code in a
> > > user-readable location, and just do it there.
> >
> > Your kidding .....
> > Seriously, how can we guarantee that we correctly determine the
> > lock holder, due to memory corruption problems. If we can't do
> > it correctly all the times, why do it at all ?
>
> You don't understand. This has nothing to do with lock holders, or
> anything else.
>
Sorry misunderstood your answer with respect to another question.

> I'm saying that we map in a page at a magic offset (just above the stack),
> and that page contains the locking code.
>
> For 386 CPU's (where only UP matters), we can trivially come up with a
> lock that doesn't use cmpxchg8b and that isn't SMP-safe. It might even go
> into the kernel every time if it has to - ie it _works_, it just isn't
> optimal.
>

Ahhhh, in this context, now "I see the light" (actually its dark at the east 
coast).
So you envision this to go through some named "section" or do you
want to go through the futex_region() library call which identifies whether
the code page has been mapped. If not, the kernel then will provide the 
locking code in that page dependent on the architecture (UP or SMP).
Fair enough.

> > Fail to see why that matters. User level locking is mostly beneficial on
> > SMPs.
>
> That's not the issue AT ALL.
>
> Semaphores are absolutely required on UP too, with threads. There is
> _zero_ difference between UP and SMP from a locking perspective in user
> space due to the fact that we can be preempted at any time - except from
> the cache coherency issue.
>

Agreed, my point was wrt providing the functionality only. Only difference 
between UP and SMP would be that a spinning version would default to the 
standard version (no spinning) under UP. 

> > So, you lock the bus for the atomic update. This is UP, nothing's going
> > on on the bus anyway.
>
> That's not the point. Nobody has locked the bus in the last ten years: the
> cache coherency is done on a cacheline basis, not on the bus.
>
> The point being that the difference between a "decl" and a "lock ;  decl"
> is about 1:12 or so in performance.
>

I am no expert in architecture, but if its done through the cache coherency 
mechanism, the overhead shouldn't be 12:1. You simply mark the cache line as 
part of you instruction to avoid a cache line transfer. How can that be 12 
times slower.  .. Ready to be educated....

> > Even if its a few more cycles, still beats the heck out of using other
> > heavyweight kernel APIs
>
> Sure it does. But if the speed of locking matters enough for user-level
> locks to matter, don't you think the 1:12 difference matters as well?
>
> 		Linus

Yipp, I buy that argument.

Overall, it just seems to me the user locking subsystem is becoming quickly 
again a complicated beast.


Anyway, time to go home and play with the kids :-)

-- 
-- Hubertus Franke  (frankeh@watson.ibm.com)
