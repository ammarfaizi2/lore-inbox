Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751334AbWDFWfc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751334AbWDFWfc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Apr 2006 18:35:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751342AbWDFWfc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Apr 2006 18:35:32 -0400
Received: from dvhart.com ([64.146.134.43]:45511 "EHLO dvhart.com")
	by vger.kernel.org with ESMTP id S1751334AbWDFWfc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Apr 2006 18:35:32 -0400
From: Darren Hart <darren@dvhart.com>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: RT task scheduling
Date: Thu, 6 Apr 2006 15:35:27 -0700
User-Agent: KMail/1.8.3
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       "Stultz, John" <johnstul@us.ibm.com>,
       Peter Williams <pwil3058@bigpond.net.au>,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>
References: <200604052025.05679.darren@dvhart.com> <20060406073753.GA18349@elte.hu> <200604061116.02429.darren@dvhart.com>
In-Reply-To: <200604061116.02429.darren@dvhart.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604061535.28952.darren@dvhart.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 06 April 2006 11:16, you wrote:
> On Thursday 06 April 2006 00:37, Ingo Molnar wrote:
> > * Darren Hart <darren@dvhart.com> wrote:
> > > My last mail specifically addresses preempt-rt, but I'd like to know
> > > people's thoughts regarding this issue in the mainline kernel.  Please
> > > see my previous post "realtime-preempt scheduling - rt_overload
> > > behavior" for a testcase that produces unpredictable scheduling
> > > results.
> >
...

> > in any case, i'll check your -rt testcase to see why it fails.
>
> Just as an example, here is the output a failing test case on a 4way
> machine running 2.6.16-rt13 (a successful run would have a final ball
> position of 0).
>
> [root@box sched_football]# ./sched_football 4 10
> Starting 4 offense threads at priority 15
> Starting 4 defense threads at priority 30
> Starting referee thread
> Game On (10 seconds)!
> Game Over!
> Final ball position: 5
> [root@box sched_football]#
>
> --Darren


On a related note, I tried observing the rt stats in /proc/stats while running 
sched_football on 2.6.16-rt13.  The entire log is nearly a MB so I placed it 
on my website for reference 
(http://www.dvhart.com/~dvhart/sched_football_stats.log), an excerpt follows:

---------------------

The following is the output of sched_football run with 1 thread for offense 
and 1 thread for defense on a 4 way machine.  The ball position is irrelevant 
in this case since there are more CPUs than threads (they should all be able 
to run).  What is disturbing is that over the entire run, I never see RT 
tasks on every CPU.  Even though there are usually 5 total runnnable threads, 
we constantly see groupings of 2 and 3 on the runqueues while the others have 
no running rt tasks.

Looking back, I should have added a sleep to the loop - oops - still, I think 
the data is interesting and suggests a problem with sceduling RT tasks across 
all available CPUs.  Does this seem like a valid test to everyone?  Is there 
perhaps some explanation as to why this would be expected (when the cat 
process get's to read the proc information or something) ?

# ./sched_football 1 60
Starting 1 offense threads at priority 15
Starting 1 defense threads at priority 30
Starting referee thread
Game On (60 seconds)!
Game Over!
Final ball position: 20359767

# while true; do clear; cat /proc/stat | grep rt >> sched_football_stats.log; 
done

sched_football_stats.log
------------------------------
rt_overload_schedule: 57768
rt_overload_wakeup:   157501
rt_overload_pulled:   13722934
rt_nr_running(0): 0
rt_nr_running(1): 0
rt_nr_running(2): 0
rt_nr_running(3): 0
rt_overload: 0
rt_overload_schedule: 57769
rt_overload_wakeup:   157514
rt_overload_pulled:   13722937
rt_nr_running(0): 0
rt_nr_running(1): 2
rt_nr_running(2): 3
rt_nr_running(3): 0
rt_overload: 2
...
rt_overload_schedule: 57774
rt_overload_wakeup:   157738
rt_overload_pulled:   13722941
rt_nr_running(0): 0
rt_nr_running(1): 2
rt_nr_running(2): 4
rt_nr_running(3): 0
rt_overload: 2
...
rt_overload_schedule: 57791
rt_overload_wakeup:   158650
rt_overload_pulled:   13722964
rt_nr_running(0): 0
rt_nr_running(1): 2
rt_nr_running(2): 0
rt_nr_running(3): 3
rt_overload: 2
...
rt_overload_schedule: 57808
rt_overload_wakeup:   166924
rt_overload_pulled:   13722973
rt_nr_running(0): 0
rt_nr_running(1): 0
rt_nr_running(2): 0
rt_nr_running(3): 2
rt_overload: 1
rt_overload_schedule: 57808
rt_overload_wakeup:   166927
rt_overload_pulled:   13722973
rt_nr_running(0): 0
rt_nr_running(1): 0
rt_nr_running(2): 0
rt_nr_running(3): 0
rt_overload: 0

---------------------
