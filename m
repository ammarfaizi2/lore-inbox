Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263187AbTHFONt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 10:13:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263355AbTHFONt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 10:13:49 -0400
Received: from asl-rai.mcs.gac.edu ([138.236.64.152]:898 "EHLO
	asl-rai.mcs.gac.edu") by vger.kernel.org with ESMTP id S263187AbTHFONf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 10:13:35 -0400
Date: Wed, 6 Aug 2003 09:13:32 -0500
Message-Id: <200308061413.h76EDWIH002373@asl-rai.mcs.gac.edu>
From: Max Hailperin <max@gustavus.edu>
To: linux-kernel@vger.kernel.org
Subject: interactivity (measuring + big-picture thoughts)
References: <20030806110001.29163.94475.Mailman@lists.us.dell.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Aug 2003 at 01:12:08 +0100, charlie.baylis@fish.zetnet.co.uk
wrote:

   Actually, if you/someone can write a simple program which can
   replace xmms skips as the standard "scheduler is good/bad"
   benchmark that would be great. It wants to do n milliseconds of
   work every m milliseconds and report the minimum/maximum/average
   time it took to do the sleep and the work. Or something like that

Unless I'm mistaken, this is one of the things John Regehr's Hourglass
program can do.  See http://www.cs.utah.edu/~regehr/hourglass/ 

You'll want to reed the FREENIX 2002 paper linked from there.  More
generally, this looks like it could be a useful tool for those
tweaking the scheduler.

Since I've now broken email silence, I'll chip in my two cents on
design issues like measuring sleep times and differentiating
interruptible from uninterruptible sleep and whether the time spent
waiting on the run queue upon awakening should be included.

My impression is that there is an unstated underlying goal of trying
to guess what the task was waiting for:

 * In a situation where you have two threads tossing a ball back and
   forth using some synchronization mechanism, so that each alternated
   computation with waiting for the other, there is no logical reason
   why you would want to give them boosts, no matter how long one
   waits for the other.  They should compete fairly with other tasks
   of the same niceness.  Note that this is a different conclusion
   than you would reach by reasoning of the form "this thread hasn't
   used any CPU for a long time, so it would be only fair to let it
   use some now."

 * On the other hand, where you have a process waiting for a disk
   drive, you want to give it a boost so as to improve utilization of
   the overall system hardware, and hence throughput.  For example, if
   you have a CPU-bound task and an disk-bound task, you want each to
   progress nearly as fast as if it were alone. Response time may also
   be improved as a consequence, but not always, and that is a
   third-order consequence, by way of utilization and hence
   throughput.

 * On the third hand, if the task been waiting for a human, you want
   to give that task a boost for response-time reasons -- humans don't
   like to be kept waiting, even after keeping the computer waiting.

As far as I can read the historical record, the most traditional
approach to time-sharing schedulers seems to be to directly pay
attention to what is being waited for, and to give large boosts when
waiting for a human-connected I/O device, small boosts when waiting
for a disk drive, and no boost when waiting for another thread.

This approach (directly noting what is being waited for) seems
problematic in the contemporary context, where we have a wide
diversity of I/O devices, humans at the other ends of network
connections, threads (like the X server) mediating between humans and
other threads, so that the main application thread conceptually
waiting for the human may really be waiting for another thread (the X
server), etc.

Thus, we wind up with heuristics to try to infer what is being waited
for.  Sleep time is useful: if you waited for multiple second, chances
are really good it was a human you waited for.  Interruptibility of the
sleep may also have heuristic value, because traditionally sleeps that
were for external agents (like humans or other systems on the
internet) have been engineered to be interruptible and sleeps that were
for internal system hardware (like disks) have been engineered to be
uninterruptible.

Given this perspective -- that the goal is *not* "making up for lost
time" (it hasn't used CPU, so let it now) but rather guessing the
waited-for party -- some conclusions for the design seem to follow.
First of all, one can get a sense of what time scale is appropriate
for the parameters.  Waiting 10s of seconds to declare something fully
interactive seems wrong -- after one or two seconds I would already be
totally convinced I was waiting for a human.  Second, it seems clear
that sleep time should be measured only until the task becomes runable
again, not including any time spent waiting in the run queue to run.
The latter approach seems to lead toward an unstable positive-feedback
situation, and is measuring something unrelated to the waited-for
party.  Third, it seems reasonable to differentiate interruptible and
uninterruptible sleep, even though there is no iron-clad connection
between that and anything that matters, because it may result in a
somewhat less imperfect heuristic.  Fourth, the absolute hardest part,
to the point of impossibility, is going to be distinguishing waiting
for a thread that is waiting for a human (as when an application waits
for an X event) from waiting for a thread that is tossing a
synchronization ball back and forth with you, computing in between
tosses.  The fact that this is impossible suggests that the favoritism
shown to threads that seem to have waited for a human must not be so
great that granting the same favoritism to a pair of threads that
alternately hog the CPU and wait for one another would wedge the
system.
