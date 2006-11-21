Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030848AbWKUTMX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030848AbWKUTMX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 14:12:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031326AbWKUTMX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 14:12:23 -0500
Received: from e31.co.us.ibm.com ([32.97.110.149]:16333 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030848AbWKUTMW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 14:12:22 -0500
Date: Tue, 21 Nov 2006 11:13:39 -0800
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
       Oleg Nesterov <oleg@tv-sign.ru>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [patch] cpufreq: mark cpufreq_tsc() as core_initcall_sync
Message-ID: <20061121191338.GB2013@us.ibm.com>
Reply-To: paulmck@linux.vnet.ibm.com
References: <20061119214315.GI4427@us.ibm.com> <Pine.LNX.4.44L0.0611211244200.6140-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0611211244200.6140-100000@iolanthe.rowland.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 21, 2006 at 12:56:21PM -0500, Alan Stern wrote:
> Here's another potential problem with the fast path approach.  It's not
> very serious, but you might want to keep it in mind.
> 
> The idea is that a reader can start up on one CPU and finish on another,
> and a writer might see the finish event but not the start event.  For
> example:
> 
> 	Reader A enters the critical section on CPU 0 and starts
> 	accessing the old data area.
> 
> 	Writer B updates the data pointer and starts executing
> 	srcu_readers_active_idx() to check if the fast path can be
> 	used.  It sees per_cpu_ptr(0)->c[idx] == 1 because of
> 	Reader A.
> 
> 	Reader C runs srcu_read_lock() on CPU 0, setting
> 	per_cpu_ptr[0]->c[idx] to 2.
> 
> 	Reader C migrates to CPU 1 and leaves the critical section;
> 	srcu_read_unlock() sets per_cpu_ptr(1)->c[idx] to -1.
> 
> 	Writer B finishes the cpu loop in srcu_readers_active_idx(),
> 	seeing per_cpu_ptr(1)->c[idx] == -1.  It computes sum =
> 	1 + -1 == 0, takes the fast path, and exits immediately
> 	from synchronize_srcu().
> 
> 	Writer B deallocates the old data area while Reader A is still
> 	using it.
> 
> This requires two context switches to take place while the cpu loop in
> srcu_readers_active_idx() runs, so perhaps it isn't realistic.  Is it
> worth worrying about?

Thank you -very- -much- for finding the basis behind my paranoia!
I guess my intuition is still in good working order.  ;-)

It might be unlikely, but that makes it even worse -- a strange memory
corruption problem that happens only under heavy load, and even then only
sometimes.  No thank you!!!

I suspect that this affects Jens as well, though I don't claim to
completely understand his usage.

One approach to get around this would be for the the "idx" returned from
srcu_read_lock() to keep track of the CPU as well as the index within
the CPU.  This would require atomic_inc()/atomic_dec() on the fast path,
but would not add much to the overhead on x86 because the smp_mb() imposes
an atomic operation anyway.  There would be little cache thrashing in the
case where there is no preemption -- but if the readers almost always sleep,
and where it is common for the srcu_read_unlock() to run on a different CPU
than the srcu_read_lock(), then the additional cache thrashing could add
significant overhead.

Thoughts?

							Thanx, Paul
