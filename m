Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751116AbVHSGk0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751116AbVHSGk0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Aug 2005 02:40:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751120AbVHSGk0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Aug 2005 02:40:26 -0400
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:51115 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751116AbVHSGkZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Aug 2005 02:40:25 -0400
Subject: Re: 2.6.13-rc6-rt9
From: Steven Rostedt <rostedt@goodmis.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       "Paul E. McKenney" <paulmck@us.ibm.com>
In-Reply-To: <20050818060126.GA13152@elte.hu>
References: <20050818060126.GA13152@elte.hu>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Fri, 19 Aug 2005 02:39:46 -0400
Message-Id: <1124433586.5186.119.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Deadlock finally found!!! 

I've been debugging this all week. And at 2:30 in the morning I finally
found where it is. It really sucks when you need to debug on something
that doesn't have a serial, and netconsole doesn't work that reliably.

This also explains why this only happened on my laptop. It is caused by
the dependent_sleeper, which is used quite a bit when you have SCHED_HT
turned on.  Although I wouldn't be surprised if this deadlock exists
elsewhere.

The dependent_sleeper (used by SCHED_HT) grabs all the run queue locks
for the physical CPU.  Then it calls trace_stop_sched_switched. So this
is the calling chain.

dependent_sleeper
    +==> grabs CPU0 rq and CPU1 rq lock (saying CPU 0 and 1 are on the
same physical CPU)
   -> trace_stop_sched_switched
      -> check_wakeup_timing
          -> down_trylock(max_mutex)
                -> rt_down_trylock
                    -> __down_trylock
                       +==> grabs trace_lock

Now lets look at something at the same time that is unlocking.

rt_up
  -> __up_mutex_nosavestate_inline
    ->  ___up_mutex_nosavestate
       -> ____up_mutex
          +==> grabs trace_lock
         -> __up_mutex_waiter_nosavestate
            -> wake_up_process
               -> try_to_wake_up
                 +==> grabs rq lock

Here we can see that there's a reverse order here and we have a
deadlock.  I actually witness this using my logger to show the traces.
All I needed was the last few lines, so the console was fine here.

Ingo, can't you get rt.c to be more confusing. I mean it is too simple.
We need to add a few more underscores here and there :-)  Seriously,
that rt.c is mind boggling. It was nice before, now it is just screaming
for a cleanup (come now, do we really need the four underscores?).  Same
with latency.c. 

Well, there's the deadlock, I'm too tired to figure out all the paths,
and what the heck is going on. So I'll give you the honour of writing
the patch. ;-)

Thanks,

-- Steve



