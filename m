Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132678AbRDCWo3>; Tue, 3 Apr 2001 18:44:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132711AbRDCWoU>; Tue, 3 Apr 2001 18:44:20 -0400
Received: from gateway.sequent.com ([192.148.1.10]:28489 "EHLO
	gateway.sequent.com") by vger.kernel.org with ESMTP
	id <S132678AbRDCWoI>; Tue, 3 Apr 2001 18:44:08 -0400
Date: Tue, 3 Apr 2001 15:43:14 -0700
From: Mike Kravetz <mkravetz@sequent.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: frankeh@us.ibm.com, Fabio Riccardi <fabio@chromium.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: a quest for a better scheduler
Message-ID: <20010403154314.E1054@w-mikek2.sequent.com>
In-Reply-To: <20010403121308.A1054@w-mikek2.sequent.com> <Pine.LNX.4.30.0104032024290.9285-100000@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <Pine.LNX.4.30.0104032024290.9285-100000@elte.hu>; from mingo@elte.hu on Tue, Apr 03, 2001 at 08:47:52PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 03, 2001 at 08:47:52PM +0200, Ingo Molnar wrote:
> 
> this restriction (independence of the priority from the previous process)
> is a fundamentally bad property, scheduling is nonlinear and affinity
> decisions depend on the previous context. [i had a priority-queue SMP
> scheduler running 2-3 years ago but dropped the idea due to this issue.]
> IMO it's more important to have a generic and flexible scheduler, and
> arbitrary, nonnatural restrictions tend to bite us later on.


It seems like we may be talking about two different things.

Our 'priority queue' implementation uses almost the same
goodness function as the current scheduler.  The main
difference between our 'priority queue' scheduler and the
current scheduler is the structure of the runqueue.  We
break up the single runqueue into a set of priority based
runqueues.  The 'goodness' of a task determines what sub-queue
a task is placed in.  Tasks with higher goodness values
are placed in higher priority queues than tasks with lower
goodness values.  This allows us to limit the scan of runnable
tasks to the highest priority sub-queue, as opposed to the
entire runquue.  When scanning the highest priority sub-queue
we use almost the same goodness function as that which is
used today (it does take CPU affinity into account).  In fact,
if we used the same goodness function I'm pretty sure we
would exactly match the behavior of the existing scheduler.

Hopefully, Hubertus Franke will speak up and provide more
details, as he is much more familiar with this implementation
than I am.

In any case, I think we have almost reached the conclusion
that our priority queue implementation may not be acceptable
due to the extra overhead in low thread counts.

> one issue regarding multiqueues is the ability of interactive processes to
> preempt other, lower priority processes on other CPUs. These sort of
> things tend to happen while using X. In a system where process priorities
> are different, scheduling decisions cannot be localized per-CPU
> (unfortunately), and 'the right to run' as such is a global thing.


Agreed.  This is why our multi-queue scheduler always attempts
to make global decisions.  It will preempt lower priority tasks
on other CPUs.  This implementation tends to make 'more
localized' scheduling decisions as contention on the runqueue
locks increase.  However, at this point one could argue that
we have moved away from a 'realistic' low task count system load.

> lmbench's lat_ctx for example, and other tools in lmbench trigger various
> scheduler workloads as well.

Thanks, I'll add these to our list.

-- 
Mike Kravetz                                 mkravetz@sequent.com
IBM Linux Technology Center
