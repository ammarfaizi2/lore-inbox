Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265225AbTFROL4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 10:11:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265234AbTFROKj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 10:10:39 -0400
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:54027 "EHLO
	small.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S265225AbTFROJC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 10:09:02 -0400
Subject: Re: O(1) scheduler starvation
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Mike Galbraith <efault@gmx.de>
Cc: davidm@hpl.hp.com, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <5.2.0.9.2.20030618113653.0277d780@pop.gmx.net>
References: <5.2.0.9.2.20030618113653.0277d780@pop.gmx.net>
Content-Type: text/plain
Message-Id: <1055946173.834.12.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 
Date: 18 Jun 2003 16:22:53 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-06-18 at 14:04, Mike Galbraith wrote:
> At 09:53 AM 6/18/2003 +0200, Felipe Alfaro Solana wrote:
> >Hi!
> >
> >I've been poking around and found the following link on O(1) scheduler
> >starvation problems:
> >
> >http://www.hpl.hp.com/research/linux/kernel/o1-starve.php
> >
> >The web page contains a small test program which supposedly is able to
> >make two processes starvate. However, I've been unable to reproduce what
> >is described in the above link. In fact, the CPU usage ratio ranges
> >between 60-40% or 70-30% in the worst cases.
> 
> (you're talking about with my monotinic_clock() diff in your kernel right?)

Don't know exactly its name. wli posted to LKLM a few days ago. In a few
words, the patch creates

+inline void __scheduler_tick(runqueue_t *rq, task_t *p)

and

+#define SCHED_NANOSECOND       1
+#define SCHED_SECOND           (1000000000 * SCHED_NANOSECOND)
+#define SCHED_TICK             (SCHED_SECOND / HZ)
+#define TICKS_PER_SECOND       (SCHED_SECOND / SCHED_TICK)

Don't know if this is the patch you're talking about. It's not thud,
anyways.

> If you examine the priorities vs cpu usage, therein lies a big fat bug.
> 
> I think the fundamental problem is that you can only execute in series, but 
> can sleep in parallel, which makes for more sleep time existing than all 
> execution time combined.  If you're running test-starve with my 
> monotonic_clock() diff, you should notice that one task is at maximum 
> priority and eating ~75% cpu, while the other is at minumum and getting the 
> rest minus what top gets.  In a sane universe, that should be 
> impossible.  In my current tree, this _is_ now impossible, but I haven't 
> worked out some nasty kinks.

Exactly. This is more or less what was happening, roughly a 70-30
balance of CPU usage.

> >I'm running 2.5.72-mm1 with Mike Galbraith's scheduler patches and a
> >small patch I made myself to improve interactivity (mainly, to stop XMMS
> >from skipping by adjusting some scheduler parameters).
> 
> Please show me your xmms hack, and show me how you make xmms skip without 
> doing something that puts tons of stress on the cache.  I built xmms here, 
> and the only time the audio thread gets starved is when starting a new 
> song.  That's because of CHILD_PENALTY when starting a new copy of xmms 
> while something of prio < 20 is hogging cpu (process_load <grrrr>).  Once 
> playing, it's rock solid here.

No, I wasn't talking about an XMMS hack. I was talking about changing
scheduler defaults, as shown in the following patch:

--- old/kernel/sched.c  2003-06-17 21:04:21.240902000 +0200
+++ new/kernel/sched.c  2003-06-17 20:58:54.840902000 +0200
@@ -66,14 +66,14 @@
  * they expire.
  */
 #define MIN_TIMESLICE          ( 10 * HZ / 1000)
-#define MAX_TIMESLICE          (200 * HZ / 1000)
+#define MAX_TIMESLICE          ( 20 * HZ / 1000)
 #define CHILD_PENALTY          50
 #define PARENT_PENALTY         100
 #define EXIT_WEIGHT            3
-#define PRIO_BONUS_RATIO       25
+#define PRIO_BONUS_RATIO       20
 #define INTERACTIVE_DELTA      2
-#define MAX_SLEEP_AVG          (10*HZ)
-#define STARVATION_LIMIT       (10*HZ)
+#define MAX_SLEEP_AVG          (2*HZ)
+#define STARVATION_LIMIT       (2*HZ)
 #define NODE_THRESHOLD         125
 #define SCHED_NANOSECOND       1
 #define SCHED_SECOND           (1000000000 * SCHED_NANOSECOND)

To make XMMS skip, just force the X server to do a lot of repainting,
for example, by dragging a big window slowly enough over another one
which requires a lot of painting (Evolution, for example, is a good
candidate as it requires a lot of CPU to repaint uncovered areas). It's
easy to reproduce just after launching XMMS. However, after a while, it
gets difficult to make XMMS to skip sound (it seems the scheduler
adjusts priorities well enough). This is on a PIII 700Mhz laptop with no
niced processes at all.

With your patch and my scheduler changes, I've been unable to make XMMS
skip audio, even when the X server is reniced to -20, or another CPU hog
is running.

