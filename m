Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262674AbRE3JdC>; Wed, 30 May 2001 05:33:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262680AbRE3Jcw>; Wed, 30 May 2001 05:32:52 -0400
Received: from [212.1.33.3] ([212.1.33.3]:12840 "EHLO borg4.zapnet.de")
	by vger.kernel.org with ESMTP id <S262674AbRE3Jcj>;
	Wed, 30 May 2001 05:32:39 -0400
From: Ivan Schreter <is@zapwerk.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [patch] sched_yield in 2.2.x
Date: Wed, 30 May 2001 11:07:00 +0200
X-Mailer: KMail [version 1.0.29.2]
Content-Type: text/plain; charset=US-ASCII
In-Reply-To: <01053002030500.01197@linux> <3B146125.77845217@mvista.com>
In-Reply-To: <3B146125.77845217@mvista.com>
Cc: george anzinger <george@mvista.com>
MIME-Version: 1.0
Message-Id: <01053011323600.01230@linux>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I'm not subscribed, so replies please CC: to me.

[...]

> > (I changed it to -1 just to be sure this process isn't accidentally
> > picked when there is other process to run - maybe I'm wrong here, but
> > 2.4.5 gives it also goodness -1, so it should be OK).
[...]
> The -1 is better than 0 since 0 will trigger a recalc if no other tasks
> have any time left.  (Or do you want this to happen?  As you have it,
> the yielding task will get control if all other tasks in the run list
> have zero counters.  Seems like the recalculation should happen to find
> a better candidate.)

Yes, I think that is OK according to specs. If we get a recalc, then we get
control anyway, since we have some time left when calling sched_yield(). Or am
I wrong here? Anyway, it performs quite well in tests...

> The real problem with this patch is that if a real time task yields, the
> patch will cause the scheduler to pick a lower priority task or a
> SCHED_OTHER task.  This one is not so easy to solve.  You want to scan
> the run_list in the proper order so that the real time task will be the
> last pick at its priority.  Problem is, the pre load with the prev task
> is out of order.  You might try: http://rtsched.sourceforge.net/

Well, let's look at it this way: real-time tasks may want to yield when they
are waiting for something to happen that is not system-controlled (like a
user-mode spinlock). Otherwise they would be waiting in (un)interruptible sleep
controlled by the kernel. So when a RR task yields, then it yields because some
condition isn't met. So it has to wait anyway. Scheduling a lower
priority task in the meantime will do only good to the system IMHO.

I know this is not quite standard, but to make it work standards-compliant
(task will continue to run if there are no other tasks blabla) it is enough to
check # of runnable tasks in the run queue in sys_sched_yield() and return
immediately if we are the only task running. I can implement that. Anybody
thinks it's worth it?

Ivan Schreter
is@zapwerk.com
