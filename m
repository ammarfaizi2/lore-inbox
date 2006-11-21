Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031421AbWKUUkw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031421AbWKUUkw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 15:40:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031420AbWKUUkw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 15:40:52 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:17797 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP
	id S1031421AbWKUUkv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 15:40:51 -0500
Date: Tue, 21 Nov 2006 15:40:50 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
cc: Oleg Nesterov <oleg@tv-sign.ru>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [patch] cpufreq: mark cpufreq_tsc() as core_initcall_sync
In-Reply-To: <20061121191338.GB2013@us.ibm.com>
Message-ID: <Pine.LNX.4.44L0.0611211532340.6410-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Nov 2006, Paul E. McKenney wrote:

> On Tue, Nov 21, 2006 at 12:56:21PM -0500, Alan Stern wrote:
> > Here's another potential problem with the fast path approach.  It's not
> > very serious, but you might want to keep it in mind.
> > 
> > The idea is that a reader can start up on one CPU and finish on another,
> > and a writer might see the finish event but not the start event.  For
> > example:
...
> > This requires two context switches to take place while the cpu loop in
> > srcu_readers_active_idx() runs, so perhaps it isn't realistic.  Is it
> > worth worrying about?
> 
> Thank you -very- -much- for finding the basis behind my paranoia!
> I guess my intuition is still in good working order.  ;-)

Are you sure _this_ was the basis behind your paranoia?  Maybe it had 
something else in mind...  :-)

> It might be unlikely, but that makes it even worse -- a strange memory
> corruption problem that happens only under heavy load, and even then only
> sometimes.  No thank you!!!
> 
> I suspect that this affects Jens as well, though I don't claim to
> completely understand his usage.
> 
> One approach to get around this would be for the the "idx" returned from
> srcu_read_lock() to keep track of the CPU as well as the index within
> the CPU.  This would require atomic_inc()/atomic_dec() on the fast path,
> but would not add much to the overhead on x86 because the smp_mb() imposes
> an atomic operation anyway.  There would be little cache thrashing in the
> case where there is no preemption -- but if the readers almost always sleep,
> and where it is common for the srcu_read_unlock() to run on a different CPU
> than the srcu_read_lock(), then the additional cache thrashing could add
> significant overhead.
> 
> Thoughts?

I don't like the thought of extra overhead from cache thrashing.  Also it 
seems silly to allocate per-cpu data and then write to another CPU's 
element.

How about making srcu_readers_active_idx() so fast that there isn't time
for 2 context switches?  Disabling interrupts ought to be good enough
(except in virtualized environments perhaps).

Alan

