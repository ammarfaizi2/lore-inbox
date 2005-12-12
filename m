Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751058AbVLLDKU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751058AbVLLDKU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Dec 2005 22:10:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751059AbVLLDKT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Dec 2005 22:10:19 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:51389 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751056AbVLLDKT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Dec 2005 22:10:19 -0500
Date: Sun, 11 Dec 2005 19:10:53 -0800
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: vatsa@in.ibm.com, linux-kernel@vger.kernel.org,
       Dipankar Sarma <dipankar@in.ibm.com>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] Fix RCU race in access of nohz_cpu_mask
Message-ID: <20051212031053.GA8748@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <439889FA.BB08E5E1@tv-sign.ru> <20051209024623.GA14844@in.ibm.com> <4399D852.47E0BB4E@tv-sign.ru> <20051210151951.GA2798@in.ibm.com> <439B24A7.E2508AAE@tv-sign.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <439B24A7.E2508AAE@tv-sign.ru>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 10, 2005 at 09:55:35PM +0300, Oleg Nesterov wrote:
> Srivatsa Vaddagiri wrote:
> > 
> > On Fri, Dec 09, 2005 at 10:17:38PM +0300, Oleg Nesterov wrote:
> > > >         rcp->cur++;     /* New GP */
> > > >
> > > >         smp_mb();
> > >
> > > I think I need some education on memory barriers.
> > >
> > > Does this mb() garantees that the new value of ->cur will be visible
> > > on other cpus immediately after smp_mb() (so that rcu_pending() will
> > > notice it) ?
> > 
> > AFAIK the new value of ->cur should be visible to other CPUs when smp_mb()
> > returns. Here's a definition of smp_mb() from Paul's article:
> > 
> > smp_mb(): "memory barrier" that orders both loads and stores. This means loads
> > and stores preceding the memory barrier are committed to memory before any
> > loads and stores following the memory barrier.
> 
> Thanks, but this definition talks about ordering, it does not say
> anything about the time when stores are really commited to memory
> (and does it mean also that cache-lines are invalidated on other
> cpus ?).

Think of a pair of CPUs (creatively named "CPU 0" and "CPU 1") with
a cache-coherent interconnect between them.  Then:

1.	wmb() guarantees that any writes preceding the wmb() will
	be seen by the interconnect before any writes following the
	wmb().  But this applies -only- to the writes executed by
	the CPU doing the wmb().

2.	rmb() guarantees that any changes seen by the interconnect
	preceding the rmb() will be seen by any reads following the
	rmb().  Again, this applies only to reads executed by the
	CPU doing the wmb().  However, the changes might be due to
	any CPU.

3.	mb() combines the guarantees made by rmb() and wmb().

All CPUs but Alpha make stronger guarantees.  On those CPUs, you can
replace "interconnect" in #1 above with "all CPUs", and you can replace
"seen by the interconnect" in #2 above with "caused by any CPU".
Rumor has it that more recent Alpha CPUs also have stronger memory
barriers, but I have thus far been unable to confirm this.

On with the rest of the definitions:

4.	smp_wmb(), smp_rmb(), and smb_mb() do nothing in UP kernels,
	but do the corresponding memory barrier in SMP kernels.

5.	read_barrier_depends() is rmb() on Alpha, and nop on other
	CPUs.  Non-Alpha CPUs guarantee that if CPU 0 does the
	following, where p->a is initially zero and global_pointer->a
	is initially 1:

		p->a = 2;
		smp_wmb();
		global_pointer = p;

	and if CPU 1 does:

		x = global_pointer->a;

	then the value of x will be either 1 or 2, never zero.  On Alpha,
	strange though it may seem (and it did seem strange to me when I
	first encountered it!), the value of x could well be zero.
	To get the same guarantee on Alpha as on the other CPUs, the
	assignment to x must instead be as follows:

		tmp = global_pointer;
		read_memory_depends();
		x = tmp->a;

	or, equivalently:

		x = rcu_dereference(global_pointer)->a;

	There is an smp_read_barrier_depends() that takes effect only
	in an SMP kernel, similar to smp_wmb() and friends.

This example may seem quite strange, but the need for the barrier
follows directly from the definition #1, which makes its ordering
guarantee only to the -interconnect-, -not- to the other CPUs.

> > [ http://www.linuxjournal.com/article/8211 ]

Hmm...  That one does look familiar.  ;-)

> And thanks for this link, now I have some understanding about
> read_barrier_depends() ...

Let's just say it required much patience and perseverence on the part
of the Alpha architects to explain it to me the first time around.  ;-)

							Thanx, Paul
