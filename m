Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317757AbSGKEiv>; Thu, 11 Jul 2002 00:38:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317759AbSGKEiu>; Thu, 11 Jul 2002 00:38:50 -0400
Received: from pool-129-44-58-21.ny325.east.verizon.net ([129.44.58.21]:38408
	"EHLO arizona.localdomain") by vger.kernel.org with ESMTP
	id <S317757AbSGKEit>; Thu, 11 Jul 2002 00:38:49 -0400
Date: Thu, 11 Jul 2002 00:41:59 -0400
From: "Kevin O'Connor" <kevin@koconnor.net>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] Re: O(1) batch scheduler
Message-ID: <20020711004159.A5356@arizona.localdomain>
References: <20020709223021.A4567@arizona.localdomain> <Pine.LNX.4.44.0207110817160.2263-100000@localhost.localdomain> <20020709223021.A4567@arizona.localdomain> <Pine.LNX.4.44.0207110842520.3580-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0207110842520.3580-100000@localhost.localdomain>; from mingo@elte.hu on Thu, Jul 11, 2002 at 09:05:35AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 11, 2002 at 08:27:13AM +0200, Ingo Molnar wrote:
> 
> the problem with a pure weighted average (ie. no ->idle_count, just a
> weighted average calculated in the scheduler tick) is that with HZ=1000
> and a 32-bit word length the sampling gets too inaccurate. For the average
> to be meaningful it needs to be at least 'a few seconds worth' - which is
> 'a few thousands of events' - the rounding errors are pretty severe in
> that case.

Yes, I see where truncation could be a problem.  However, one should be
able to offset this with a larger base unit and with appropriate rounding.

On Thu, Jul 11, 2002 at 09:05:35AM +0200, Ingo Molnar wrote:
> 
> you can find my latest scheduler tree, against 2.5.25-vanilla, at:
> 
>         http://redhat.com/~mingo/O(1)-scheduler/sched-2.5.25-A7
> 
> note that in addition to the bugfix i've further simplified the
> idle-average calculation - simple, weightless running average is
> more than enough.

I looked through the A8 code, and I see that it is using a weighted average
with the last second having as much "weight" as all previous seconds.  This
is understandable (as a second is an eternity to a computer), but I wonder
how this interacts with the idle_ticks_left calculation.

Since idle_avg is only updated once a second, it will basically be around a
half-second outdated whenever it is queried.  With the smaller time
duration on idle_avg calculations, idle_avg will only describe the last 2
to 3 seconds of the CPU.  This means the statistic describes about two
seconds and is a half-second outdated - I wonder how useful this statistic
is.

Just for kicks, I wrote up a patch with a pure weighted average
calculation.  Again, I wasn't able to test this on a real kernel (I don't
have a development box I can risk 2.5 on yet).  However, I did run a bunch
of data through the two different algorithms.  The "hybrid" code matches
the pure weighted average code right after the hybrid code updates
idle_avg.  However, the pure weighted average code responds quicker to a
changing environment.  YMMV.

-Kevin


--- linux-2.5.25-b/kernel/sched.c	Wed Jul 10 23:55:47 2002
+++ linux-2.5.25-a/kernel/sched.c	Thu Jul 11 00:33:22 2002
@@ -166,14 +166,10 @@
 
 	/*
 	 * Per-CPU idle CPU time tracking:
-	 *
-	 * - idle_ticks_left counts back from HZ to 0.
-	 * - idle_count is the number of idle ticks in the last second.
-	 * - once it reaches 0, a new idle_avg is calculated.
 	 */
 	#define IDLE_TICKS (HZ)
 
-	unsigned int idle_ticks_left, idle_count, idle_avg;
+	unsigned int idle_avg;
 
 } ____cacheline_aligned;
 
@@ -926,21 +922,14 @@
 #if CONFIG_SMP
 	if (user_ticks || sys_ticks) {
 		/*
-		 * This code is rare, triggered only once per second:
+		 * Maintain a weighted average between 0 and 100000:
 		 */
-		if (--rq->idle_ticks_left <= 0) {
-			/*
-			 * Maintain a simple running average:
-			 */
-			rq->idle_avg += rq->idle_count;
-			rq->idle_avg >>= 1;
-
-			rq->idle_ticks_left = IDLE_TICKS;
-			rq->idle_count = 0;
-		}
+		int idle_count = 0;
+		if (p == rq->idle || p->policy == SCHED_BATCH)
+			idle_count = 100000;
+		rq->idle_avg = (rq->idle_avg * (IDLE_TICKS - 1)
+				+ idle_count + IDLE_TICKS/2) / IDLE_TICKS;
 	}
-	if (p == rq->idle || p->policy == SCHED_BATCH)
-		rq->idle_count++;
 #endif
 	if (p == rq->idle) {
 		if (local_bh_count(cpu) || local_irq_count(cpu) > 1)
@@ -2085,7 +2074,6 @@
 		spin_lock_init(&rq->lock);
 		INIT_LIST_HEAD(&rq->migration_queue);
 		INIT_LIST_HEAD(&rq->batch_queue);
-		rq->idle_ticks_left = IDLE_TICKS;
 
 		for (j = 0; j < 2; j++) {
 			array = rq->arrays + j;



-- 
 ------------------------------------------------------------------------
 | Kevin O'Connor                     "BTW, IMHO we need a FAQ for      |
 | kevin@koconnor.net                  'IMHO', 'FAQ', 'BTW', etc. !"    |
 ------------------------------------------------------------------------
