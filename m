Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263071AbTDVK62 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 06:58:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263073AbTDVK62
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 06:58:28 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:28846 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263071AbTDVK60 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 06:58:26 -0400
Message-Id: <200304221110.h3MBAE712394@owlet.beaverton.ibm.com>
To: Ingo Molnar <mingo@redhat.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] HT scheduler, sched-2.5.68-A9 
In-reply-to: Your message of "Tue, 22 Apr 2003 06:34:45 EDT."
             <Pine.LNX.4.44.0304220622570.24063-100000@devserv.devel.redhat.com> 
Date: Tue, 22 Apr 2003 04:10:14 -0700
From: Rick Lindsley <ricklind@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo, thanks for clearing up some things.

    yes. This 'un-sharing' of contexts happens unconditionally, whenever
    we notice the situation. (ie. whenever a CPU goes completely idle
    and notices an overloaded physical CPU.) On the HT system i have i
    have measure this to be a beneficial move even for the most trivial
    things like infinite loop-counting.

I have access to a 4-proc HT so I can try it there too. Did you test with
micro-benchmarks like the loop-counting or did you use something bigger?

    the more per-logical-CPU cache a given SMT implementation has,
    the less beneficial this move becomes - in that case the system
    should rather be set up as a NUMA topology and scheduled via the
    NUMA scheduler.

	whew. So why are we perverting the migration thread to push
	rather than pull? If active_load_balance() finds a imbalance,
	why must we use such indirection?  Why decrement nr_running?
	Couldn't we put together a migration_req_t for the target queue's
	migration thread?

    i'm not sure what you mean by perverting the migration thread to
    push rather to pull, as migration threads always push - it's not
    different in this case either.

My bad -- I read the comments around migration_thread(), and they could
probably be improved.  When I looked at the code, yes, it's more of
a push.  The migration thread process occupies the processor so that
you can be sure the process-of-interest is not running and can be more
easily manipulated.

    we could use a migration_req_t for this, in theory, but active
    balancing is independent of ->cpus_allowed, so some special code
    would still be needed.

I'm just looking for the cleanest approach.  Functionally I see no
difference; just seems like we go running through the queues several times
(not all in active_load_balance) before active_load_balance has achieved
its goal.  I was thinking maybe a directed move by the migration thread
("move THAT process to THAT processor/runqueue"), similar to what is done
in set_cpus_allowed(), might be cleaner and faster.  Maybe I'll try that.

    Also, active balancing is non-queued by nature. Is there a big
    difference?

I'm not sure active balancing really is independent of cpus_allowed.
Yes, all the searches are done without that restriction in place, but
then we ultimately call load_balance(), which *will* care. load_balance()
may end up not moving what we wanted (or anything at all.)

Rick
