Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756242AbWKVSHa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756242AbWKVSHa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 13:07:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756296AbWKVSH3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 13:07:29 -0500
Received: from e31.co.us.ibm.com ([32.97.110.149]:61357 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1756292AbWKVSH2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 13:07:28 -0500
Date: Wed, 22 Nov 2006 10:08:42 -0800
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
       Oleg Nesterov <oleg@tv-sign.ru>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [patch] cpufreq: mark cpufreq_tsc() as core_initcall_sync
Message-ID: <20061122180842.GG1755@us.ibm.com>
Reply-To: paulmck@linux.vnet.ibm.com
References: <20061121191338.GB2013@us.ibm.com> <Pine.LNX.4.44L0.0611211532340.6410-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0611211532340.6410-100000@iolanthe.rowland.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 21, 2006 at 03:40:50PM -0500, Alan Stern wrote:
> On Tue, 21 Nov 2006, Paul E. McKenney wrote:
> 
> > On Tue, Nov 21, 2006 at 12:56:21PM -0500, Alan Stern wrote:
> > > Here's another potential problem with the fast path approach.  It's not
> > > very serious, but you might want to keep it in mind.
> > >
> > > The idea is that a reader can start up on one CPU and finish on another,
> > > and a writer might see the finish event but not the start event.  For
> > > example:
> ...
> > > This requires two context switches to take place while the cpu loop in
> > > srcu_readers_active_idx() runs, so perhaps it isn't realistic.  Is it
> > > worth worrying about?
> >
> > Thank you -very- -much- for finding the basis behind my paranoia!
> > I guess my intuition is still in good working order.  ;-)
> 
> Are you sure _this_ was the basis behind your paranoia?  Maybe it had
> something else in mind...  :-)

OK, I stand corrected, you found -one- basis for my paranoia.  There might
indeed be others.  However, only -one- counter-example is required to
invalidate a proposed algorithm.  ;-)

> > It might be unlikely, but that makes it even worse -- a strange memory
> > corruption problem that happens only under heavy load, and even then only
> > sometimes.  No thank you!!!
> >
> > I suspect that this affects Jens as well, though I don't claim to
> > completely understand his usage.
> >
> > One approach to get around this would be for the the "idx" returned from
> > srcu_read_lock() to keep track of the CPU as well as the index within
> > the CPU.  This would require atomic_inc()/atomic_dec() on the fast path,
> > but would not add much to the overhead on x86 because the smp_mb() imposes
> > an atomic operation anyway.  There would be little cache thrashing in the
> > case where there is no preemption -- but if the readers almost always sleep,
> > and where it is common for the srcu_read_unlock() to run on a different CPU
> > than the srcu_read_lock(), then the additional cache thrashing could add
> > significant overhead.
> >
> > Thoughts?
> 
> I don't like the thought of extra overhead from cache thrashing.  Also it
> seems silly to allocate per-cpu data and then write to another CPU's
> element.

I am concerned about this as well, and am beginning to suspect that I
need to make a special-purpose primitive specifically for Jens that he
can include with his code.

That said, some potential advantages of per-CPU elements that might see
cache thrashing are:

1.	the cross-CPU references might be rare.

2.	memory contention is reduced compared to a single variable that
	all CPUs are modifying.

Unfortunately, #1 seems unlikely in Jens's case -- why would the completion
be so lucky as to show up on the same CPU as did the request most of the
time?  #2 could be important in I/O heavy workloads with fast devices.

> How about making srcu_readers_active_idx() so fast that there isn't time
> for 2 context switches?  Disabling interrupts ought to be good enough
> (except in virtualized environments perhaps).

NMIs?  ECC errors?  Cache misses?  And, as you say, virtualized
environments.

							Thanx, Paul
