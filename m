Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268650AbUH3Roe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268650AbUH3Roe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 13:44:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268660AbUH3Rod
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 13:44:33 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:10206 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S268650AbUH3Rmo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 13:42:44 -0400
Date: Mon, 30 Aug 2004 23:08:53 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Jim Houston <jim.houston@comcast.net>
Cc: paulmck@us.ibm.com, linux-kernel@vger.kernel.org,
       Manfred Spraul <manfred@colorfullife.com>,
       Andrew Morton <akpm@osdl.org>,
       William Lee Irwin III <wli@holomorphy.com>,
       Jack Steiner <steiner@sgi.com>, Jesse Barnes <jbarnes@engr.sgi.com>,
       rusty@rustcorp.com.au
Subject: Re: [RFC&PATCH] Alternative RCU implementation
Message-ID: <20040830173853.GB4639@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <m3brgwgi30.fsf@new.localdomain> <20040830004322.GA2060@us.ibm.com> <1093886020.984.238.camel@new.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1093886020.984.238.camel@new.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 30, 2004 at 01:13:41PM -0400, Jim Houston wrote:
> On Sun, 2004-08-29 at 20:43, Paul E. McKenney wrote:
> > Are these critical realtime processes user-mode only, or do they
> > also execute kernel code?  If they are user-mode only, a much more
> > straightforward approach might be to have RCU pretend that they do
> > not exist.
> > 
> > This approach would have the added benefit of keeping rcu_read_unlock()
> > atomic-instruction free.  In some cases, the overhead of the atomic
> > exchange would overwhelm that of the read-side RCU critical section.
> > 
> > Taking this further, if the realtime CPUs are not allowed to execute in
> > the kernel at all, you can avoid overhead from smp_call_function() and
> > the like -- and avoid confusing those parts of the kernel that expect to
> > be able to send IPIs and the like to the realtime CPU (or do you leave
> > IPIs enabled on the realtime CPU?).
> 
> Our customers applications vary but, in general, the realtime processes
> will do the usual system calls to synchronize with other processes and
> do I/O.
> 
> I considered tracking the user<->kernel mode transitions extending the
> idea of the nohz_cpu_mask.  I gave up on this idea mostly because it
> required hooking into assembly code.  Just extending the idea of this
> bitmap has its own scaling issues.  We may have several cpus running
> realtime processes. The obvious answer is to keep the information in
> a per-cpu variable and pay the price of polling this from another cpu.

Tracking user<->kernel transitions and putting smarts in scheduler
about RCU is the right way to go IMO.

Anything that poll other cpus and has read-side overheads will likely
not be scalable. I think that is not the right way to go about solving
the issue of dependency on local timer interrupt. It is a worthy goal
and we need to do this anyway, but we need to do it right without
hurting the current advantages as much as possible.


> I know that I'm questioning one of your design goals for RCU by adding
> overhead to the read-side.  I have read everything I could find on RCU.
> My belief is that the cost of the xchg() instruction is small 
> compared to the cache benifit of freeing memory more quickly.
> I think it's more interesting to look at the impact of the xchg() at the
> level of an entire system call.  Adding 30 nanoseconds to a open/close
> path that tasks 3 microseconds seems reasonable.  It is hard to measure
> the benefit of reusing the a dcache entry more quickly.
> 
> I would be interested in suggestions for testing.  I would be very
> interested to hear how my patch does on a large machine.

I will get you some numbers on a large machine. But I remain opposed
to this approach. I believe it can be done without the read-side
overheads. 


> I'm also trying to figure out if I need the call_rcu_bh() changes.
> Since my patch will recognize a grace periods as soon as any 
> pending read-side critical sections complete, I suspect that I
> don't need this change.

Except that under a softirq flood, a reader in a different read-side
critical section may get delayed a lot holding up RCU. Let me know
if I am missing something here.

Thanks
Dipankar
