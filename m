Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261639AbVCRPvv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261639AbVCRPvv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Mar 2005 10:51:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261648AbVCRPvv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Mar 2005 10:51:51 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:16772 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S261639AbVCRPvs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Mar 2005 10:51:48 -0500
Date: Fri, 18 Mar 2005 07:33:25 -0800
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: Real-Time Preemption and RCU
Message-ID: <20050318153325.GA1299@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20050318002026.GA2693@us.ibm.com> <20050318091303.GB9188@elte.hu> <20050318092816.GA12032@elte.hu> <20050318095327.GA15190@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050318095327.GA15190@elte.hu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 18, 2005 at 10:53:27AM +0100, Ingo Molnar wrote:
> 
> * Ingo Molnar <mingo@elte.hu> wrote:
> 
> > there's one detail on PREEMPT_RT though (which i think you noticed too). 
> > 
> > Priority inheritance handling can be done in a pretty straightforward
> > way as long as no true read-side nesting is allowed for rwsems and
> > rwlocks - i.e. there's only one owner of a lock at a time. So
> > PREEMPT_RT restricts rwsem and rwlock concurrency: readers are
> > writers, with the only exception that they are allowed to 'self-nest'.
> > [...]
> 
> this does not affect read-side RCU, because read-side RCU can never
> block a higher-prio thread. (as long as callback processing is pushed
> into a separate kernel thread.)
> 
> so RCU will be pretty much the only mechanism (besides lock-free code)
> that allows reader concurrency on PREEMPT_RT.

This is a relief!  I was wondering how on earth I was going to solve
the multi-task priority-inheritance problem!

But...  How do we handle the following scenario?

0.	A bunch of low-priority threads are preempted in the
	middle of various RCU read-side critical sections.

1.	High-priority thread does kmalloc(), but there is no
	memory, so it blocks.

2.	OOM handling notices, and decides to clean up the outstanding
	RCU callbacks.  It therefore invokes _synchronize_kernel()
	(in implementation #5).

3.	The _synchronize_kernel() function tries to acquire all of
	the read-side locks, which are held by numerous preempted
	low-priority threads.

4.	What now???

Or does the current patch do priority inheritance across the memory
allocator?  In other words, can we get away with ignoring this one?  ;-)

						Thanx, Paul
