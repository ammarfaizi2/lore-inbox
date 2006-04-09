Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750746AbWDISdu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750746AbWDISdu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Apr 2006 14:33:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750803AbWDISdu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Apr 2006 14:33:50 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:13772 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750746AbWDISdt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Apr 2006 14:33:49 -0400
Date: Sun, 9 Apr 2006 20:31:21 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Darren Hart <dvhltc@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       "Stultz, John" <johnstul@us.ibm.com>,
       Peter Williams <pwil3058@bigpond.net.au>,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: RT task scheduling
Message-ID: <20060409183121.GA29851@elte.hu>
References: <200604052025.05679.darren@dvhart.com> <20060409131649.GA19082@elte.hu> <200604091025.17518.dvhltc@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200604091025.17518.dvhltc@us.ibm.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Darren Hart <dvhltc@us.ibm.com> wrote:

> > -rt14 tree with this bug fixed - does it fix the failures for you?
> 
> I ran the test 100 times, no failures!  Looks good to me.
> 
> # for ((i=0;i<100;i++)); do ./sched_football 4 10 | grep "Final ball position" 
> | tee sched_football_ball.log; sleep 1; done
> Final ball position: 0
> ...
> Final ball position: 0

cool!

> Looking at the patch, it looks like the problem was a race on the 
> runqueue lock - when we called double_runqueue_lock(a,b) we risked 
> dropping the lock on b, giving another CPU opportunity to grab it and 
> pull our next task.  The API change to double_runqueue_lock() and 
> checking the new return code in balance_rt_tasks() is what fixed the 
> issue.  Is that accurate?

this was one problem, yes. There was another problem too: the code 
checked against rq->curr, while it has to consider the 'next' task (the 
current task might just be about to leave the CPU at the point we do the 
rebalancing). (A third problem was an efficiency issue: the code 
indiscriminately pulled all RT tasks it found eligible - while it should 
only have pulled ones that preempt the next CPU.)

> I was doing some testing to see why the RT tasks don't appear to be 
> evenly distributed across the CPUs (in my earlier post using the 
> output of /proc/stat). [...]

could you explain this in a bit more detailed way? [what is the behavior 
you observe, and what would be your expectation.]

> [...] I was wondering if the load_balancing code might be interfering 
> with the balance_rt_tasks() code.  Should the normal load_balancer 
> even touch RT tasks in the presence of balance_rt_tasks() ?  I'm 
> thinking not.

if there is RT overload then running the highest-prio RT tasks trumps 
any other consideration - including load_balance(). Also, same-prio 
SCHED_FIFO tasks can starve each other indefinitely, so there's not much 
the load-balancer can do.

	Ingo
