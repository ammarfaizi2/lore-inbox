Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289685AbSAOOIU>; Tue, 15 Jan 2002 09:08:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289606AbSAOOIB>; Tue, 15 Jan 2002 09:08:01 -0500
Received: from mx2.elte.hu ([157.181.151.9]:53157 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S289585AbSAOOHw>;
	Tue, 15 Jan 2002 09:07:52 -0500
Date: Tue, 15 Jan 2002 17:04:29 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: <linux-kernel@vger.kernel.org>, Davide Libenzi <davidel@xmailserver.org>
Subject: [patch] O(1) scheduler, -I0
Message-ID: <Pine.LNX.4.33.0201151532290.9349-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


the -I0 patch is available at:

    http://redhat.com/~mingo/O(1)-scheduler/sched-O1-2.5.2-final-I0.patch

stock 2.5.2 includes a 'interactivity estimator' method that includes most
of the things i think to be important for good interactivity:

 - sleep time based priority boost/penalty.

 - constant frequency runqueue sampling instead of recalculation/switch
   based runqueue sampling.

 - interactivity based runqueue insertion on timeslice expire.

I'm very happy about the 2.5.2 solution, it's simpler than the one i used
in -H7 - good work Davide!

There are a number of problems in 2.5.2 that need fixing though:

 - renicing is broken - it does not work at all, neither up nor down, for
   CPU-bound tasks. Renicing fell victim to the attempt to penalize CPU
   hogs as much as possible: every CPU-bound task reaches the lowest
   priority level and stays there. This also makes kernel compile times
   suffer.

 - RT scheduling is broken.

 - the sleep average is hidden in p->prio, which makes it harder to
   recover and use the true interactiveness of the task.

 - the runqueue is sampled at a frequency of 20 HZ, which can misdetect
   periodic user tasks that somehow correlate with 20 HZ.

I've fixed these problems/bugs by taking some of the -H7 solutions:

 - introducing p->sleep_avg, which is updated in a lightweight way. No
   more 'history slots'. A single counter, updated in a very simple way.

 - limiting the bonus/penalty range according to nice levels - a task can
   at most get a 5 priority levels penalty over the default level, in
   stock 2.5.2 it can get to the nice +19 level after a few seconds
   runtime. Nice levels work again.

 - introducing HZ frequency runqueue sampling. Also the MAX_SLEEP_AVG
   constant tells us how long into the past we are looking. This is 2
   seconds right now.

 - separating the RT timeslice code in scheduler_tick(), we used to break
   the RT case way too often, now we can hack the SCHED_OTHER code without
   having to touch the RT part.

 - plus the patch also includes all the fixes and improvements from the
   -H7 patch.

i've also cleaned up and commented the priority management code and have
introduced the prio_effective(p) inline function.

i've tested the patch on UP and SMP boxes. I've measured high-load
interactivity to be on equivalent levels with that of stock 2.5.2.

Bug reports, comments, suggestions welcome.

	Ingo

