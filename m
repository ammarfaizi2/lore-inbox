Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267699AbTCFDMV>; Wed, 5 Mar 2003 22:12:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267708AbTCFDMV>; Wed, 5 Mar 2003 22:12:21 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:19726 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S267699AbTCFDMT>; Wed, 5 Mar 2003 22:12:19 -0500
Date: Wed, 5 Mar 2003 19:20:34 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andrew Morton <akpm@digeo.com>
cc: Robert Love <rml@tech9.net>, <mingo@elte.hu>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [patch] "HT scheduler", sched-2.5.63-B3
In-Reply-To: <20030228202555.4391bf87.akpm@digeo.com>
Message-ID: <Pine.LNX.4.44.0303051910380.1429-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 28 Feb 2003, Andrew Morton wrote:
> > 
> > Andrew, if you drop this patch, your X desktop usability drops?
> 
> hm, you're right.  It's still really bad.  I forgot that I was using distcc.
> 
> And I also forgot that tbench starves everything else only on CONFIG_SMP=n.
> That problem remains with us as well.

Andrew, I always thought that the scheduler interactivity was bogus, since
it didn't give any bonus to processes that _help_ interactive users
(notably the X server, but it could be other things).

To fix that, some people nice up their X servers, which has its own set of 
problems.

How about something more like this (yeah, untested, but you get the idea): 
the person who wakes up an interactive task gets the interactivity bonus 
if the interactive task is already maxed out. I dunno how well this plays 
with the X server, but assuming most clients use UNIX domain sockets, the 
wake-ups _should_ be synchronous, so it should work well to say "waker 
gets bonus".

This should result in:

 - if X ends up using all of its time to handle clients, obviously X will 
   not count as interactive on its own. HOWEVER, if an xterm or something 
   gets an X event, the fact that the xterm has been idle means that _it_ 
   gets a interactivity boost at wakeup.

 - after a few such boosts (or assuming lots of idleness of xterm), the 
   process that caused the wakeup (ie the X server) will get the 
   "extraneous interactivity".

This all depends on whether the unix domain socket code runs in bottom 
half or process context. If it runs in bottom half context we're screwed, 
I haven't checked.

Does this make any difference for you? I don't know what your load test 
is, and considering that my regular desktop has 4 fast CPU's I doubt I can 
see the effect very clearly anyway ("Awww, poor Linus!")

NOTE! This doesn't help a "chain" of interactive helpers. It could be 
extended to that, by just allowing the waker to "steal" interactivity 
points from a sleeping process, but then we'd need to start being careful 
about fairness and in particular we'd have to disallow this for signal 
handling.

		Linus

----
===== kernel/sched.c 1.161 vs edited =====
--- 1.161/kernel/sched.c	Thu Feb 20 20:33:52 2003
+++ edited/kernel/sched.c	Wed Mar  5 19:09:45 2003
@@ -337,8 +337,15 @@
 		 * boost gets as well.
 		 */
 		p->sleep_avg += sleep_time;
-		if (p->sleep_avg > MAX_SLEEP_AVG)
+		if (p->sleep_avg > MAX_SLEEP_AVG) {
+			int ticks = p->sleep_avg - MAX_SLEEP_AVG + current->sleep_avg;
 			p->sleep_avg = MAX_SLEEP_AVG;
+			if (ticks > MAX_SLEEP_AVG)
+				ticks = MAX_SLEEP_AVG;
+			if (!in_interrupt())
+				current->sleep_avg = ticks;
+		}
+			
 		p->prio = effective_prio(p);
 	}
 	enqueue_task(p, array);

