Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262771AbTFDEAA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 00:00:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262776AbTFDEAA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 00:00:00 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:29967 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S262771AbTFDD76
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jun 2003 23:59:58 -0400
Date: Wed, 4 Jun 2003 00:07:18 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Ingo Molnar <mingo@elte.hu>
cc: Mike Galbraith <efault@gmx.de>, Olivier Galibert <galibert@pobox.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [Linux-ia64] Re: web page on O(1) scheduler
In-Reply-To: <Pine.LNX.4.44.0306020949520.3375-100000@localhost.localdomain>
Message-ID: <Pine.LNX.3.96.1030603235339.16495D-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2 Jun 2003, Ingo Molnar wrote:

> 
> On Thu, 29 May 2003, Mike Galbraith wrote:
> 
> > [...] What makes more sense to me than the current implementation is to
> > rotate the entire peer queue when a thread expires... ie pull in the
> > head of the expired queue into the tail of the active queue at the same
> > time so you always have a player if one exists.  (you'd have to select
> > queues based on used cpu time to make that work right though)
> 
> we have tried all sorts of more complex yield() schemes before - they
> sucked for one or another workload. So in 2.5 i took the following path:  
> make yield() _simple_ and effective, ie. expire the yielding task (push it
> down the runqueue roughly halfway, statistically) and dont try to be too
> smart doing it. All the real yield() users (mostly in the kernel) want it
> to be an efficient way to avoid livelocks. The old 2.4 yield
> implementation had the problem of enabling a ping-pong between two
> higher-prio yielding processes, until they use up their full timeslice.
> 
> (we could do one more thing that still keeps the thing simple: we could
> re-set the yielding task's timeslice instead of the current 'keep the
> previous timeslice' logic.)
> 
> OpenOffice used to use yield() as a legacy of 'green thread'
> implementation - where userspace threads needed to do periodic yield()s to
> get any sort of multitasking behavior.

The way I use it is in cases when I fork processes which communicate
through a state machine (I'm simplifying) gated by a spinlock, both in
shared memory. On SMP machines the lock time is trivial and the processes
run really well. On uniprocessor you can get hangs for a full timeslice
unless a shed_yeild() is used if the lock is not available.

Since the processes have no shared data other than the small bit of shared
memory, it seems that threads give no benefit over fork, and for some o/s
much worse. Use of a mutex seems slightly slower in Linux, and quite
slower elsewhere.

The method you describe seems far more useful than some other discussion
which seems to advocate making the yeild process the lowest priority thing
in the system. That really doesn't seem to fit SuS, although I think they
had a single queue in mind. Perhaps not, in any case you seem to provide a
workable solution.

I'm not sure if there would any any significant difference by pushing down
halfway, all the way in the same queue, or just down one. The further down
it goes the better chance there is that the blocking process will run, but
the slower the access to the shared resource and the more chance that
another process will grab the resource. Perhaps down one the first time
and then to the end of the queue if there has not been a timeslice end or
i/o block before another yeild. That would prevent looping between any
number of competitors delaying dispatch to the holder of the lock.

Feel free to disagree, that just came to me as I typed.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

