Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261426AbSKOIia>; Fri, 15 Nov 2002 03:38:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262190AbSKOIia>; Fri, 15 Nov 2002 03:38:30 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:18355 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S261426AbSKOIi3>; Fri, 15 Nov 2002 03:38:29 -0500
Date: Fri, 15 Nov 2002 14:20:31 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Zwane Mwaikambo <zwane@holomorphy.com>
Cc: Corey Minyard <cminyard@mvista.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       "Heater, Daniel (IndSys, GEFanuc, VMIC)" <Daniel.Heater@gefanuc.com>,
       John Levon <levon@movementarian.org>, linux-kernel@vger.kernel.org
Subject: Re: NMI handling rework for x86
Message-ID: <20021115142031.D5088@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20021115134338.C5088@in.ibm.com> <Pine.LNX.4.44.0211150307240.2750-100000@montezuma.mastecende.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0211150307240.2750-100000@montezuma.mastecende.com>; from zwane@holomorphy.com on Fri, Nov 15, 2002 at 03:18:22AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 15, 2002 at 03:18:22AM -0500, Zwane Mwaikambo wrote:
> On Fri, 15 Nov 2002, Dipankar Sarma wrote:
> 
> > Once you remove a handler from the list, any subsequent NMI is *not*
> > going to see the handler. So even if another CPU is executing the same
> > handler, if you wait for the RCU callback, you can guarantee that
> > no-one is executing the deleted handler. RCU will wait for all the
> > CPUs to context switch or execute user-level code atleast once.
> 
> I think you're confusing NMI handling, they aren't like your normal 
> interrupts. You're not going to see that context switch.

Let us examine the race -

CPU #0			CPU #1			CPU #2

(free_nmi P)		execute NMI P		syscall
delete from list

call_rcu					NMI (doesn't see P)

wait for completion	process in kernel	process in kernel
(context switch)

			context switch		context switch

-----------   RCU complete NMI handler P must be complete here --------------

RCU handler tasklet
  callback: complete()

nmi freeing task
wakes up and proceeds.


> > Corey's code doesn't rely on completion() to ensure this, it relies
> > on RCU to make sure that nobody is running the handler. The key is
> > that once the pointers between the prev and the next of the deleted
> 
> Can you change prev and next atomically?

You don't have to, the traversal during __list_for_each_rcu() is done
in only one direction. So writing out the next pointer is sufficiently
atomic for subsequent NMIs not to see the deleted handler. Either you
see the deleted handler or you don't.


> > spin_trylock modifies the lock cacheline, so cacheline bouncing.
> 
> At a fair interrupt rate i'd rather have that fill my caches, less time 
> spent in the NMI handler means more overall system time.

It isn't going to fill your caches, it is going to bounce around from
CPU to CPU on every NMI since every NMI will modify the cache line.
So you hurt performance.

Thanks
-- 
Dipankar Sarma  <dipankar@in.ibm.com> http://lse.sourceforge.net
Linux Technology Center, IBM Software Lab, Bangalore, India.
