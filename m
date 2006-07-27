Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751006AbWG0TyU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751006AbWG0TyU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 15:54:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751007AbWG0TyU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 15:54:20 -0400
Received: from adsl-69-232-92-238.dsl.sndg02.pacbell.net ([69.232.92.238]:6043
	"EHLO gnuppy.monkey.org") by vger.kernel.org with ESMTP
	id S1751004AbWG0TyS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 15:54:18 -0400
Date: Thu, 27 Jul 2006 12:53:56 -0700
To: "Paul E. McKenney" <paulmck@us.ibm.com>
Cc: Esben Nielsen <nielsen.esben@googlemail.com>, linux-kernel@vger.kernel.org,
       compudj@krystal.dyndns.org, rostedt@goodmis.org, tglx@linutronix.de,
       mingo@elte.hu, dipankar@in.ibm.com, rusty@au1.ibm.com,
       "Bill Huey (hui)" <billh@gnuppy.monkey.org>
Subject: Re: [RFC, PATCH -rt] NMI-safe mb- and atomic-free RT RCU
Message-ID: <20060727195355.GA2887@gnuppy.monkey.org>
References: <20060726001733.GA1953@us.ibm.com> <Pine.LNX.4.64.0607262202560.15681@localhost.localdomain> <20060727013943.GE4338@us.ibm.com> <Pine.LNX.4.64.0607270946030.10276@localhost.localdomain> <20060727154637.GA1288@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060727154637.GA1288@us.ibm.com>
User-Agent: Mutt/1.5.11+cvs20060403
From: Bill Huey (hui) <billh@gnuppy.monkey.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 27, 2006 at 08:46:37AM -0700, Paul E. McKenney wrote:
> On Thu, Jul 27, 2006 at 12:00:13PM +0100, Esben Nielsen wrote:
> > No, RT tasks can still preempt the RCU read side lock. But SCHED_OTHER and 
> > SCHED_BATCH can't. You can also the RCU read side boosting prioritiy 
> > dynamic and let the system adjust it or just let the admin adjust it.
> 
> Fair enough -- I misread MAX_RT_PRIO as MAX_PRIO.
> 
> This approach I can get behind -- my thought has been to boost to
> either MAX_RT_PRIO or MAX_RT_PRIO-1 when preempt_schedule() sees that
> it is preempting an RCU read-side critical section.
> 
> So I agree with you on at least one point!  ;-)

This is the approach that I suggested to you, Paul, at OLS after your talk.
Again, if you go about this path then you might think about extending the
scheduler to have an additional parameter regarding a preemption threshold
instead of doing this stuff indirectly with priority manipulations like
the above. It was something that I was considering when I was doing my
Linux kernel preemption project to fix the problems with RCU-ed read side
thread migrating to another CPU.

If folks go down this discussion track, it's going to open a can of
scheduling worms with possiblities (threshold, priority, irq-thread
priority, global run queue for SCHED_FIFO tasks) pushing into global run
queue logic stuff. It's a bit spooky for the Linux kernel. Some of the
thread migration pinning stuff with per CPU locks was rejected by Linus
way back.

> A possible elaboration would be to keep a linked list of tasks preempted
> in their RCU read-side critical sections so that they can be further
> boosted to the highest possible priority (numerical value of zero,
> not sure what the proper symbol is) if the grace period takes too many
> jiffies to complete.  Another piece is priority boosting when blocking
> on a mutex from within an RCU read-side critical section.

I'm not sure how folks feel about putting something like that in the
scheduler path since it's such a specialized cases. Some of the scheduler
folks might come out against this.

> Doing it efficiently is the difficulty, particularly for tickless-idle
> systems where CPUs need to be added and removed on a regular basis.
> Also, what locking design would you use in order to avoid deadlock?
> There is a hotplug mutex, but seems like you might need to acquire some
> number of rq mutexes as well.

I'm not understanding what you exactly mean by tickless idle systems.

Are you talking about isolating a CPU for SCHED_FIFO and friends tasks
only as in the CPU reservation stuff but with ticks off in many proprietary
RTOSes ? Don't mean to be tangental here, I just need clarification.

> Another approach I am looking at does not permit rcu_read_lock() in
> NMI/SMI/hardirq, but is much simpler.  Its downside is that it cannot
> serve as common code between CONFIG_PREEMPT_RT and CONFIG_PREEMPT.

bill

