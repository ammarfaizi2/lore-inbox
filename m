Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291148AbSCHXmP>; Fri, 8 Mar 2002 18:42:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291192AbSCHXmF>; Fri, 8 Mar 2002 18:42:05 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:27910 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S291148AbSCHXlw>; Fri, 8 Mar 2002 18:41:52 -0500
Date: Fri, 8 Mar 2002 15:41:11 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Hubertus Franke <frankeh@watson.ibm.com>
cc: Rusty Russell <rusty@rustcorp.com.au>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Futexes IV (Fast Lightweight Userspace Semaphores)
In-Reply-To: <20020308231405.CADDC3FE06@smtp.linux.ibm.com>
Message-ID: <Pine.LNX.4.33.0203081532550.4421-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 8 Mar 2002, Hubertus Franke wrote:
> >
> > I think the next step should be to map in one page of kernel code in a
> > user-readable location, and just do it there.
> 
> Your kidding .....
> Seriously, how can we guarantee that we correctly determine the 
> lock holder, due to memory corruption problems. If we can't do 
> it correctly all the times, why do it at all ?

You don't understand. This has nothing to do with lock holders, or 
anything else.

I'm saying that we map in a page at a magic offset (just above the stack), 
and that page contains the locking code.

For 386 CPU's (where only UP matters), we can trivially come up with a
lock that doesn't use cmpxchg8b and that isn't SMP-safe. It might even go
into the kernel every time if it has to - ie it _works_, it just isn't 
optimal.

> Fail to see why that matters. User level locking is mostly beneficial on SMPs.

That's not the issue AT ALL.

Semaphores are absolutely required on UP too, with threads. There is
_zero_ difference between UP and SMP from a locking perspective in user
space due to the fact that we can be preempted at any time - except from
the cache coherency issue.

> So, you lock the bus for the atomic update. This is UP, nothing's going on 
> on the bus anyway.

That's not the point. Nobody has locked the bus in the last ten years: the 
cache coherency is done on a cacheline basis, not on the bus.

The point being that the difference between a "decl" and a "lock ;  decl"
is about 1:12 or so in performance.

> Even if its a few more cycles, still beats the heck out of using other 
> heavyweight kernel APIs

Sure it does. But if the speed of locking matters enough for user-level 
locks to matter, don't you think the 1:12 difference matters as well?

		Linus

