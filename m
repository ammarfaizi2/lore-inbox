Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289415AbSAJMWn>; Thu, 10 Jan 2002 07:22:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289419AbSAJMWe>; Thu, 10 Jan 2002 07:22:34 -0500
Received: from mx2.elte.hu ([157.181.151.9]:13765 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S289415AbSAJMW2>;
	Thu, 10 Jan 2002 07:22:28 -0500
Date: Thu, 10 Jan 2002 15:19:49 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: <linux-kernel@vger.kernel.org>, Mike Kravetz <kravetz@us.ibm.com>,
        Anton Blanchard <anton@samba.org>, george anzinger <george@mvista.com>,
        Davide Libenzi <davidel@xmailserver.org>,
        Rusty Russell <rusty@rustcorp.com.au>
Subject: [patch] O(1) scheduler, -G1, 2.5.2-pre10, 2.4.17 (fwd)
Message-ID: <Pine.LNX.4.33.0201101457390.4885-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


this is my latest update of the O(1) scheduler:

    http://redhat.com/~mingo/O(1)-scheduler/sched-O1-2.5.2-pre11-H1.patch

(i'll release the -H1 2.4 patch later today.)

this patch does two things:

First it cleans up the load balancer's interaction with the timer tick.
There are now two functions called from the timer tick: busy_cpu_tick()
and idle_cpu_tick(). It's completely up to the scheduler to use them
appropriately. There is IDLE_REBALANCE_TICK and BUSY_REBALANCE_TICK. We do
a busy rebalance every 250 msecs, and we do an idle rebalance on idle CPUs
every 1 msec. (or 10 msec on HZ=100 systems.) The point is to not leave
CPUs idle for a long time, but still not take tasks from well-affinized
runqueues at a too high frequency.

the other change is to use the 'interactivity' output of the load
estimator more agressively. This results in a usable X while more extreme
compilation jobs like 'make -j40 bzImage' are running. In fact i'm writing
this email while an infinite loop of 'make -j40' kernel compilation was
running (default priority, not reniced), on a dual-CPU box, and completely
forgot about it - until i tried to recompile the -H1 tree :-|

Changes in -H1 relative to 2.5.2-pre11:

 - Rusty Russel: get the alignment of the runqueues right and reduce array
   indexing overhead.

 - Kevin O'Connor, Robert Love: fix locking order bug in set_cpus_allowed()
   which bug is able to cause boot-time lockups on SMP systems.

 - Rusty Russell: fix rebalance tick definition if HZ < 100 in UML.

 - Rusty Russell: check for new_mask in set_cpus_allowed(), to be sure.

 - Rusty Russell: clean up rq_ macros so that HT can be done by changing
   just one of the macros.

 - Rusty Russell: remove rq->cpu.

 - Rusty Russell: remove cacheline padding from runqueue_t, it's pointless
   now.

 - Rusty Russell: sched.c comment fixes.

 - increase minimum timeslice length by 10 msec.

 - fix comments in sched.h

 - make rq->bitmap big-endian safe. (Anton Blanchard)

 - documented and cleaned up the load estimator bits, no functional
   changes apart from small speedups.

 - do init_idle() before starting up the init thread, this removes a race
   where we'd run the init thread on CPU#0 before init_idle() has been
   called.

(please let me know if i dropped any patch from anyone along the way, or
forgot to credit anyone.)

Comments, bug reports, suggestions welcome,

	Ingo

