Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268588AbUH3RQt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268588AbUH3RQt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 13:16:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268582AbUH3RQt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 13:16:49 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:21969 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S268578AbUH3RQk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 13:16:40 -0400
Subject: Re: [RFC&PATCH] Alternative RCU implementation
From: Jim Houston <jim.houston@comcast.net>
Reply-To: jim.houston@comcast.net
To: paulmck@us.ibm.com
Cc: linux-kernel@vger.kernel.org, Dipankar Sarma <dipankar@in.ibm.com>,
       Manfred Spraul <manfred@colorfullife.com>,
       Andrew Morton <akpm@osdl.org>,
       William Lee Irwin III <wli@holomorphy.com>,
       Jack Steiner <steiner@sgi.com>, Jesse Barnes <jbarnes@engr.sgi.com>,
       rusty@rustcorp.com.au
In-Reply-To: <20040830004322.GA2060@us.ibm.com>
References: <m3brgwgi30.fsf@new.localdomain>
	 <20040830004322.GA2060@us.ibm.com>
Content-Type: text/plain
Organization: 
Message-Id: <1093886020.984.238.camel@new.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 30 Aug 2004 13:13:41 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-08-29 at 20:43, Paul E. McKenney wrote:
> On Fri, Aug 27, 2004 at 09:35:47PM -0400, Jim Houston wrote:
> > 
> > The attached patch against linux-2.6.8.1-mm4 is an experimental
> > implementation of RCU.
> > 
> > It uses an active synchronization between the rcu_read_lock(),
> > rcu_read_unlock(), and the code which starts a new RCU batch.  A RCU
> > batch can be started at an arbitrary point, and it will complete without
> > waiting for a timer driven poll.  This should help avoid large batches
> > and their adverse cache and latency effects.
> > 
> > I did this work because Concurrent encourages its customers to 
> > isolate critical realtime processes to their own cpu and shield
> > them from other processes and interrupts.  This includes disabling
> > the local timer interrupt.  The current RCU code relies on the local
> > timer to recognize quiescent states.  If it is disabled on any cpu,
> > RCU callbacks are never called and the system bleeds memory and hangs
> > on calls to synchronize_kernel().
> 
> Are these critical realtime processes user-mode only, or do they
> also execute kernel code?  If they are user-mode only, a much more
> straightforward approach might be to have RCU pretend that they do
> not exist.
> 
> This approach would have the added benefit of keeping rcu_read_unlock()
> atomic-instruction free.  In some cases, the overhead of the atomic
> exchange would overwhelm that of the read-side RCU critical section.
> 
> Taking this further, if the realtime CPUs are not allowed to execute in
> the kernel at all, you can avoid overhead from smp_call_function() and
> the like -- and avoid confusing those parts of the kernel that expect to
> be able to send IPIs and the like to the realtime CPU (or do you leave
> IPIs enabled on the realtime CPU?).
> 
> 							Thanx, Paul

Hi Paul,

Our customers applications vary but, in general, the realtime processes
will do the usual system calls to synchronize with other processes and
do I/O.

I considered tracking the user<->kernel mode transitions extending the
idea of the nohz_cpu_mask.  I gave up on this idea mostly because it
required hooking into assembly code.  Just extending the idea of this
bitmap has its own scaling issues.  We may have several cpus running
realtime processes. The obvious answer is to keep the information in
a per-cpu variable and pay the price of polling this from another cpu.

I know that I'm questioning one of your design goals for RCU by adding
overhead to the read-side.  I have read everything I could find on RCU.
My belief is that the cost of the xchg() instruction is small 
compared to the cache benifit of freeing memory more quickly.
I think it's more interesting to look at the impact of the xchg() at the
level of an entire system call.  Adding 30 nanoseconds to a open/close
path that tasks 3 microseconds seems reasonable.  It is hard to measure
the benefit of reusing the a dcache entry more quickly.

I would be interested in suggestions for testing.  I would be very
interested to hear how my patch does on a large machine.

I'm also trying to figure out if I need the call_rcu_bh() changes.
Since my patch will recognize a grace periods as soon as any 
pending read-side critical sections complete, I suspect that I
don't need this change.


Jim Houston - Concurrent Computer


