Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286647AbSBCJft>; Sun, 3 Feb 2002 04:35:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286692AbSBCJf2>; Sun, 3 Feb 2002 04:35:28 -0500
Received: from mx2.elte.hu ([157.181.151.9]:7855 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S286647AbSBCJfH>;
	Sun, 3 Feb 2002 04:35:07 -0500
Date: Sun, 3 Feb 2002 12:32:42 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Ed Tomlinson <tomlins@cam.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] improving O(1)-J9 in heavily threaded situations
In-Reply-To: <20020202155013.28C4615CFC@oscar.casa.dyndns.org>
Message-ID: <Pine.LNX.4.33.0202031220510.2020-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 2 Feb 2002, Ed Tomlinson wrote:

> The following patch improves the performance of O(1) when under load
> and threaded programs are running.  For this patch, threaded is taken
> to mean processes sharing their vm (p->mm).  While this type of
> programming is usually not optimal it is very common (ie. java).

generally we do not make any distinction between Linux threads that share
or do not share their VM. We certainly do not want to handle them
differently wrt. timeslices distributed.

> Under load, with threaded tasks running niced, and a cpu bound task at
> normal priority we quickly notice the load average shooting up.  What
> is happening is all the threads are trying to run.  Due to the nature
> of O(1) all the process in the current array must run to get on to the
> inactive array.  This quickly leads to the higher priority cpu bound
> task starving.  Running the threaded application at nice +19 can help
> but does not solve the base issue.  On UP, I have observed loads of
> between 20 and 40 when this is happening,

the problem of lower priority tasks taking away CPU time from a higher
priority task is not new, it's present in the old scheduler as well. In no
way is this symptom related to threads that share their VM. The same
workload with forked processes will show the same symptoms.

i'd suggest to do the following tunings on stock -J9:

 - increase HZ to 1024, in include/asm/param.h
 - decrease MIN_TIMESLICE to 1 msec in sched.h.
 - decrease PRIO_BONUS_RATIO from 70 to 40.

these changes do two things: they decrease the timeslice of nice +19 tasks
(pretty dramatically, relative to current kernels), and they make sure
that heavily reniced tasks cannot reach interactive status easily.

do you still see higher priority CPU-bound task starving?

> I tried various approaches to correcting this. Neither reducing the
> timeslices or playing the the effective prio of the threaded tasks
> helped much. What does seems quite effective is to monitor the total
> time _all_ the tasks sharing a vm use. Once a threshold is exceeded we
> move any tasks in the same group directly to the inactive array
> temporarily increasing their effective prio.

this in essence punishes threads that share their VM - including system
threads such as eg. kswapd or bdflush as well. This concept is broken
because the problem is not that the threads share their VM, that is just a
property of your particular workload. The problem is that while you have
lowered the priority of your java threads, they still show interactive
behavior and get a higher proportion of the CPU share they got previously.

i think your workload shows a weakness in the current handling of reniced
workloads, which can be fixed without adding any new mechanizm.

> With this change the cpu bound tasks can get over 80% of the cpu.

please also try the tunings i suggested, and compare the two kernels.

	Ingo

