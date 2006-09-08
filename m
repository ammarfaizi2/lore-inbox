Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751928AbWIHAOI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751928AbWIHAOI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 20:14:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751931AbWIHAOI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 20:14:08 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:27013 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751928AbWIHAOB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 20:14:01 -0400
Date: Thu, 7 Sep 2006 17:14:45 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: David Howells <dhowells@redhat.com>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: Uses for memory barriers
Message-ID: <20060908001445.GG1293@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <Pine.LNX.4.44L0.0609071549340.6535-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0609071549340.6535-100000@iolanthe.rowland.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 07, 2006 at 05:25:51PM -0400, Alan Stern wrote:
> Paul:
> 
> Here's something I had been thinking about back in July but never got 
> around to discussing:  Under what circumstances would one ever want to use 
> "mb()" rather than "rmb()" or "wmb()"?

If there were reads needing to be separated from writes, for example
in spinlocks.  The spinlock-acquisition primitive could not use either
wmb() or rmb(), since reads in the critical section must remain ordered
with respect to the write to the spinlock itself.

> The canonical application for memory barriers is where one CPU writes two 
> locations and another reads them, to make certain that the ordering is 
> preserved (assume everything is initially equal to 0):
> 
> 	CPU 0			CPU 1
> 	-----			-----
> 	a = 1;			y = b;
> 	wmb();			rmb();
> 	b = 1;			x = a;
> 				assert(x==1 || y==0);
> 
> In this situation the first CPU only needs wmb() and the second only needs 
> rmb().  So when would we need a full mb()?...

Right, the above example does not need mb().

> The obvious extension of the canonical example is to have CPU 0 write
> one location and read another, while CPU 1 reads and writes the same
> locations.  Example:
> 
> 	CPU 0			CPU 1
> 	-----			-----
> 	while (y==0) relax();	y = -1;
> 	a = 1;			b = 1;
> 	mb();			mb();
> 	y = b;			x = a;
> 				while (y < 0) relax();
> 				assert(x==1 || y==1);	//???
> 
> Apart from the extra stuff needed to make sure that CPU 1 sees the proper
> value stored in y by CPU 0, this is just like the first example except for
> the pattern of reads and writes.  Naively one would think that if the
> first half of the assertion fails, so x==0, then CPU 1 must have completed
> all of the first four lines above by the time CPU 0 completed its mb().  
> Hence the assignment to b would have to be visible to CPU 0, since the
> read of b occurs after the mb().  But of course we know that naive 
> reasoning isn't always right when it comes to the operation of memory 
> caches.

In the above code, there is nothing stopping CPU 1 from executing through
the "x=a" before CPU 0 starts, so that x==0.  In addition, CPU 1 imposes
no ordering between the assignment to y and b, so there is nothing stopping
CPU 0 from seeing the new value of y, but failing to see the new value of
b, so that y==0 (assuming the initial value of b is zero).

Something like the following might illustrate your point:

	CPU 0			CPU 1
	-----			-----
				b = 1;
				wmb();
	while (y==0) relax();	y = -1;
	a = 1;
	wmb();
	y = b;			while (y < 0) relax();
				rmb();
				x = a;
				assert(x==1 || y==1);	//???

Except that the memory barriers have all turned into rmb()s or wmb()s...

> The opposite approach would use reads followed by writes:
> 
> 	CPU 0			CPU 1
> 	-----			-----
> 	while (x==0) relax();	x = -1;
> 	x = a;			y = b;
> 	mb();			mb();
> 	b = 1;			a = 1;
> 				while (x < 0) relax();
> 				assert(x==0 || y==0);	//???
> 
> Similar reasoning can be applied here.  However IIRC, you decided that
> neither of these assertions is actually guaranteed to hold.  If that's the
> case, then it looks like mb() is useless for coordinating two CPUs.

Yep, similar problems as with the earlier example.

> Am I correct?  Or are there some easily-explained situations where mb()  
> really should be used for inter-CPU synchronization?

Consider the following (lame) definitions for spinlock primitives,
but in an alternate universe where atomic_xchg() did not imply a
memory barrier, and on a weak-memory CPU:

	typedef spinlock_t atomic_t;

	void spin_lock(spinlock_t *l)
	{
		for (;;) {
			if (atomic_xchg(l, 1) == 0) {
				smp_mb();
				return;
			}
			while (atomic_read(l) != 0) barrier();
		}

	}

	void spin_unlock(spinlock_t *l)
	{
		smp_mb();
		atomic_set(l, 0);
	}

The spin_lock() primitive needs smp_mb() to ensure that all loads and
stores in the following critical section happen only -after- the lock
is acquired.  Similarly for the spin_unlock() primitive.

						Thanx, Paul
