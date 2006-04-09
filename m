Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750819AbWDIRZr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750819AbWDIRZr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Apr 2006 13:25:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750823AbWDIRZr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Apr 2006 13:25:47 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.146]:26036 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750819AbWDIRZq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Apr 2006 13:25:46 -0400
From: Darren Hart <dvhltc@us.ibm.com>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: RT task scheduling
Date: Sun, 9 Apr 2006 10:25:16 -0700
User-Agent: KMail/1.8.3
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       "Stultz, John" <johnstul@us.ibm.com>,
       Peter Williams <pwil3058@bigpond.net.au>,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>
References: <200604052025.05679.darren@dvhart.com> <20060409131649.GA19082@elte.hu>
In-Reply-To: <20060409131649.GA19082@elte.hu>
Organization: IBM Linux Technology Center
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604091025.17518.dvhltc@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 09 April 2006 06:16, Ingo Molnar wrote:
> * Darren Hart <darren@dvhart.com> wrote:
> > My last mail specifically addresses preempt-rt, but I'd like to know
> > people's thoughts regarding this issue in the mainline kernel.  Please
> > see my previous post "realtime-preempt scheduling - rt_overload
> > behavior" for a testcase that produces unpredictable scheduling
> > results.
>
> thanks for the testcase! It indeed triggered a bug in the -rt tree's
> "RT-overload" balancing feature. The nature of the bug made it trigger
> much less likely on 2-way boxes (where i do most of my -rt testing),
> probably that's why it didnt get discovered before. I've uploaded the
> -rt14 tree with this bug fixed - does it fix the failures for you?

I ran the test 100 times, no failures!  Looks good to me.

# for ((i=0;i<100;i++)); do ./sched_football 4 10 | grep "Final ball position" 
| tee sched_football_ball.log; sleep 1; done
Final ball position: 0
...
Final ball position: 0

Looking at the patch, it looks like the problem was a race on the runqueue 
lock - when we called double_runqueue_lock(a,b) we risked dropping the lock 
on b, giving another CPU opportunity to grab it and pull our next task.  The 
API change to double_runqueue_lock() and checking the new return code in 
balance_rt_tasks() is what fixed the issue.  Is that accurate?

I was doing some testing to see why the RT tasks don't appear to be evenly 
distributed across the CPUs (in my earlier post using the output 
of /proc/stat).  I was wondering if the load_balancing code might be 
interfering with the balance_rt_tasks() code.  Should the normal 
load_balancer even touch RT tasks in the presence of balance_rt_tasks() ?  
I'm thinking not.

Thanks,

--
Darren Hart
IBM Linux Technology Center
Realtime Linux Team
Phone: 503 578 3185
  T/L: 775 3185
