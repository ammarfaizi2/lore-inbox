Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285747AbSAUNIn>; Mon, 21 Jan 2002 08:08:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285783AbSAUNIe>; Mon, 21 Jan 2002 08:08:34 -0500
Received: from mx2.elte.hu ([157.181.151.9]:10384 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S285747AbSAUNIT>;
	Mon, 21 Jan 2002 08:08:19 -0500
Date: Mon, 21 Jan 2002 16:05:41 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: <linux-kernel@vger.kernel.org>
Subject: [patch] O(1) scheduler, -J4
Message-ID: <Pine.LNX.4.33.0201211541250.8699-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


the -J4 scheduler patch is available:

    http://redhat.com/~mingo/O(1)-scheduler/sched-O1-2.5.3-pre2-J4.patch
    http://redhat.com/~mingo/O(1)-scheduler/sched-O1-2.4.17-J4.patch

there are no open/reported bugs, and no bugs were found since -J2. The
scheduler appears to be stabilizing steadily.

-J4 includes two changes to further improve interactiveness:

1)  the introduction of 'super-long' timeslices, max timeslice is 500
    msecs - it was 180 msecs before. The new default timeslice is 250
    msecs, it was 90 msecs before.

the reason for super-long timeslices is that IMO we now can afford them.
The scheduler is pretty good at identifying true interactive tasks these
days. So we can increase timeslice length without risking the loss of good
interacte latencies. Long timeslices have a number of advantages:

 - nice +19 CPU hogs take up less CPU time than they used to.

 - interactive tasks can gather a bigger 'reserve' timeslice they can use
   up to do bursts of processing.

 - CPU hogs will get better cache affinity, due to longer timeslices
   and less context-switching.

Long timeslices also have a disadvantage:

 - under high load, if an interactive task manages to fall into the
   CPU-bound hell then it will take longer for it to get the next slice of
   processing.

i have measured the pros to beat the cons under the workloads i tried, but
YMMV - more testing by more people is needed, comparing -J4's interactive
feel (and nice behavior, and kernel compilation performance) against -J2's
interactive feel/performance.


2)  slight shrinking of the bonus/penalty range a task can get.

i've shrunk the bonus/penalty range from +-19 priority levels to +-14
priority levels. (from 90% of the full range to 70% of the full range.)
The reason why this can be done without hurting interactiveness is that
it's no longer a necessity to use the maximum range of priorities - the
interactiviness information is stored in p->sleep_avg, which is not
sensitive to the range of priority levels.

The shrinking has two benefits:

 - slightly denser priority arrays, slightly better cache utilization.

 - more isolation of nice levels from each other. Eg. nice -20 tasks now
   have a 6 priority levels 'buffer zone' which cannot be reached by
   normal interactive tasks. nice -20 audio daemons should benefit from
   this. Also, normal CPU hogs are better isolated from nice +19 CPU hogs,
   with the same 6 priority levels 'buffer zone'.

(by shrinking the bonus/penalty range, the -3 rule in the TASK_INTERACTIVE
definition was shrunk as well, to -2.)

Changelog:

 - Erich Focht: optimize max_load, remove prev_max_load.

 - Robert Love: simplify unlock_task_rq().

 - Robert Love: fix the ->cpu offset value in x86's entry.S, used by the
                preemption patch.

 - me: interactiveness updates.

 - me: sched_rr_get_interval() should return the timeslice value based on
       ->__nice, not based on ->prio.

Bug reports, comments, suggestions welcome. (any patch/fix that is not in
-J4 is lost and should be resent.)

	Ingo

