Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266505AbRGLXlX>; Thu, 12 Jul 2001 19:41:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266550AbRGLXlN>; Thu, 12 Jul 2001 19:41:13 -0400
Received: from e22.nc.us.ibm.com ([32.97.136.228]:51336 "EHLO
	e22.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S266505AbRGLXlA>; Thu, 12 Jul 2001 19:41:00 -0400
Date: Thu, 12 Jul 2001 16:40:17 -0700
From: Mike Kravetz <mkravetz@sequent.com>
To: linux-kernel@vger.kernel.org
Cc: Andi Kleen <ak@suse.de>, lse-tech@lists.sourceforge.net
Subject: CPU affinity & IPI latency
Message-ID: <20010712164017.C1150@w-mikek2.des.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This discussion was started on 'lse-tech@lists.sourceforge.net'.
I'm widening the distribution in the hope of getting more input.

It started when Andi Kleen noticed that a single 'CPU Hog' task
was being bounced back and forth between the 2 CPUs on his 2-way
system.  I had seen similar behavior when running the context
switching test of LMbench.  When running lat_ctx with only two
threads on an 8 CPU system, one would ?expect? the two threads
to be confined to two of the 8 CPUs in the system.  However, what
I have observed is that the threads are effectively 'round
robined' among all the CPUs and they all end up bearing
an equivalent amount of the CPU load.  To more easily observe
this, increase the number of 'TRIPS' in the benchmark to a really
large number.

After a little investigation, I believe this 'situation' is caused
by the latency of the reschedule IPI used by the scheduler.  Recall
that in lat_ctx all threads are in a tight loop consisting of:

pipe_read()
pipe_write()

Both threads 'start' on the same CPU and are sitting in pipe_read
waiting for data.  A token is written to the pipe and one thread
is awakened.  The awakened thread, then immediately writes the token
back to the pipe which ultimately results in a call to reschedule_idle()
that will 'initiate' the scheduling of the other thread.  In
reschedule_idle() we can not take the 'fast path' because WE are
currently executing on the other thread's preferred CPU.  Therefore,
reschedule_idle() chooses the oldest idle CPU and sends the IPI.
However, before the IPI is received (and schedule() run) on the
remote CPU, the currently running thread calls pipe_read which
blocks and calls schedule().  Since the other task has yet to be
scheduled on the other CPU, it is scheduled to run on the current
CPU.  Both tasks continue to execute on the one CPU until such time
that an IPI induced schedule() on the other CPU hits a window where
it finds one of the tasks to schedule.  We continue in this way,
migrating the tasks to the oldest idle CPU and eventually cycling our
way through all the CPUs.

Does this explanation sound reasonable?

If so, it would then follow that booting with 'idle=poll' would
help alleviate this situation.  However, that is not the case.  With
idle=poll the CPU load is not as evenly distributed among the CPUs,
but is still distributed among all of them.

Does the behavior of the 'benchmark' mean anything?  Should one
expect tasks to stay their preferred CPUs if possible?

Thoughts/comments
-- 
Mike Kravetz                                 mkravetz@sequent.com
IBM Linux Technology Center
