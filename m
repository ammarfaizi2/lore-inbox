Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287333AbSBCPqS>; Sun, 3 Feb 2002 10:46:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287337AbSBCPqJ>; Sun, 3 Feb 2002 10:46:09 -0500
Received: from tomts23.bellnexxia.net ([209.226.175.185]:17292 "EHLO
	tomts23-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S287333AbSBCPqF>; Sun, 3 Feb 2002 10:46:05 -0500
Content-Type: text/plain; charset=US-ASCII
From: Ed Tomlinson <tomlins@cam.org>
Organization: me
To: <mingo@elte.hu>
Subject: Re: [PATCH] improving O(1)-J9 in heavily threaded situations
Date: Sun, 3 Feb 2002 10:46:03 -0500
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0202031220510.2020-100000@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.33.0202031220510.2020-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020203154603.BDDDB9251@oscar.casa.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On February 3, 2002 06:32 am, Ingo Molnar wrote:
> On Sat, 2 Feb 2002, Ed Tomlinson wrote:
> > The following patch improves the performance of O(1) when under load
> > and threaded programs are running.  For this patch, threaded is taken
> > to mean processes sharing their vm (p->mm).  While this type of
> > programming is usually not optimal it is very common (ie. java).
>
> generally we do not make any distinction between Linux threads that share
> or do not share their VM. We certainly do not want to handle them
> differently wrt. timeslices distributed.

My changes only defers the execution of 'threaded' tasks when they are placing
a heavy load on a cpu - its does not change the timeslices at all.  Also, if 
the tuneable patch is installed, the behaviour is completely controlable -
up THREAD_PENALTY to a high number, and it reverts to the J9 behaviour.

> > Under load, with threaded tasks running niced, and a cpu bound task at
> > normal priority we quickly notice the load average shooting up.  What
> > is happening is all the threads are trying to run.  Due to the nature
> > of O(1) all the process in the current array must run to get on to the
> > inactive array.  This quickly leads to the higher priority cpu bound
> > task starving.  Running the threaded application at nice +19 can help
> > but does not solve the base issue.  On UP, I have observed loads of
> > between 20 and 40 when this is happening,
>
> the problem of lower priority tasks taking away CPU time from a higher
> priority task is not new, it's present in the old scheduler as well. In no
> way is this symptom related to threads that share their VM. The same
> workload with forked processes will show the same symptoms.

Yes, and O(1) is already doing a better job.  The reason this sort of 
workload worries me is mainly java.  Creating hundreds of threads is
not uncommon with java.  The 1 to 1 relation ship between kernel and
java threads makes this an issue.  I do not think that there are that
many applications forking hundreds of active tasks (excepting fork bombs).

> i'd suggest to do the following tunings on stock -J9:
>
>  - increase HZ to 1024, in include/asm/param.h
>  - decrease MIN_TIMESLICE to 1 msec in sched.h.
>  - decrease PRIO_BONUS_RATIO from 70 to 40.

I am sure this will help.

> these changes do two things: they decrease the timeslice of nice +19 tasks
> (pretty dramatically, relative to current kernels), and they make sure
> that heavily reniced tasks cannot reach interactive status easily.
>
> do you still see higher priority CPU-bound task starving?

The other half of this is does the java application remain responsive?
Remember it is interactive it that parts of it feed a local browser.

> > I tried various approaches to correcting this. Neither reducing the
> > timeslices or playing the the effective prio of the threaded tasks
> > helped much. What does seems quite effective is to monitor the total
> > time _all_ the tasks sharing a vm use. Once a threshold is exceeded we
> > move any tasks in the same group directly to the inactive array
> > temporarily increasing their effective prio.
>
> this in essence punishes threads that share their VM - including system
> threads such as eg. kswapd or bdflush as well. This concept is broken
> because the problem is not that the threads share their VM, that is just a
> property of your particular workload. The problem is that while you have
> lowered the priority of your java threads, they still show interactive
> behavior and get a higher proportion of the CPU share they got previously.

If system tasks are a problem its easy to exclude them.  I did not do
this since monitoring who was triggering this code did not show system
tasks.

What happens when the java threads really _are_ interactive?  In my case
the test application is a freenet node.  Part of it is acting as a http
proxy.  Starving this results in an unresponsive system.  Why should I
have to renice at all?  

There is another why this could be coded.  We could divide the normal 
prorites into N buckets.  Say -20, -12, -4, +4, +12, +19.  Then we 
limit the total execution time spent by tasks in each using the same
sort of logic I am use except its by bucket not mm.  Time for each
bucket would be <tuneable> * NICE_TO_TIMESLICE(-20), <tuneable> *
NICE_TO_TIMESLICE(-12) etc.  

> i think your workload shows a weakness in the current handling of reniced
> workloads, which can be fixed without adding any new mechanizm.

Are you sure we really want renice to be needed get good response for 
common workloads?  I understand the effect of priorities, will Aunt
Martha?  I did not code using the bucket approach since it implies 
more use of nice than the by mm mechanism.

> > With this change the cpu bound tasks can get over 80% of the cpu.
>
> please also try the tunings i suggested, and compare the two kernels.

Will do.

Ed Tomlinson
