Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132970AbRAVTXY>; Mon, 22 Jan 2001 14:23:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133010AbRAVTXO>; Mon, 22 Jan 2001 14:23:14 -0500
Received: from e22.nc.us.ibm.com ([32.97.136.228]:23787 "EHLO
	e22.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S132970AbRAVTXJ>; Mon, 22 Jan 2001 14:23:09 -0500
Importance: Normal
Subject: Re: [Lse-tech] more on scheduler benchmarks
To: lse-tech@lists.sourceforge.net, linux-kernel@vger.kernel.org
From: "Bill Hartner" <bhartner@us.ibm.com>
Date: Mon, 22 Jan 2001 14:23:05 -0500
Message-ID: <OF6D592D2B.0F27DA28-ON852569DC.0066C241@raleigh.ibm.com>
X-MIMETrack: Serialize by Router on D04NM201/04/M/IBM(Release 5.0.3 (Intl)|21 March 2000) at
 01/22/2001 02:23:06 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike K, wrote :

>
> If the above is accurate, then I am wondering what would be a
> good scheduler benchmark for these low task count situations.
> I could undo the optimizations in sys_sched_yield() (for testing
> purposes only!), and run the existing benchmarks.  Can anyone
> suggest a better solution?

Hacking sys_sched_yield is one way around it.

Also, if you plot the thread count vs. yield times, you might
be able to get an idea of how many microseconds each thread
on the run_queue costs and what is the "base overhead" of just
running through the scheduler.  Could give some indication
of what it costs when small number of threads are on the run_queue.

On an 8-way, try 8, 10, 12, 14, 16, 18, ... threads and see
what the chart looks like when you plot #threads vs. microseconds.

Then there is always cache issues that send your results all over
the place.  You could hack sched_test_yield to start with 32 threads
and get results.  Then kill off (2) threads and get results for 30,
then kill off (2) more threads and get results for 28, ...

-----

One aspect of the scheduler that is not being tested by
the yield tests is wake_up_process() and reschedule_idle().

So, here is another potential scheduler benchmark ...

The benchmark will do the following :

sched_test_semop -c 4 -l 3

The above command parms would create 32 threads or 4 chains of 3
threads.

A1->A2->A3
B1->B2->B3
C1->C2->C3
D1->D2->D3

-c N controls how many chains
-l N controls the length of the chains

Each thread has it's own sema4.

When the test starts, the main thread posts A1 B1 C1 D1 sema4.
Then A1 post A2 sem, B1 posts B2, C1 posts C2, D1 post D2.
At the same time A1, B1, C1, D1 waits on there own sema4.
And around and around and ...

So, you can control the number of threads in the RUN state,
and you exercise the wakeup code.  Your numbers will be
diluted by the overhead in semop().  The metric would be
how many wakeups done by each thread.

Is there a better API that could accomplish the same
wakeup someone up and then sleep semantics ?

Bill Hartner
bhartner@us.ibm.com
Linux Technology Center - Linux Kernel Performance


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
