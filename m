Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317470AbSGJC1X>; Tue, 9 Jul 2002 22:27:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317472AbSGJC1W>; Tue, 9 Jul 2002 22:27:22 -0400
Received: from pool-129-44-58-21.ny325.east.verizon.net ([129.44.58.21]:11271
	"EHLO arizona.localdomain") by vger.kernel.org with ESMTP
	id <S317470AbSGJC1V>; Tue, 9 Jul 2002 22:27:21 -0400
Date: Tue, 9 Jul 2002 22:30:21 -0400
From: "Kevin O'Connor" <kevin@koconnor.net>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org
Subject: O(1) batch scheduler
Message-ID: <20020709223021.A4567@arizona.localdomain>
References: <Pine.LNX.4.44.0207011137330.4167-100000@e2>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0207011137330.4167-100000@e2>; from mingo@elte.hu on Mon, Jul 01, 2002 at 11:45:32AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo,

I looked through your sched-2.5.25-A5 patch, and I'm confused by the
idle_count array.  It calculates the idle average of the last 9 seconds -
but why not just use a weighted average.  A weighted average is going to be
very close to the true average, and where it differs the weighted average
should be preferable.

Incremental patch (untested):

--- kernel/sched.c	Tue Jul  9 22:06:38 2002
+++ ../linux-2.5.25-a/kernel/sched.c	Tue Jul  9 22:23:41 2002
@@ -171,7 +171,7 @@
 	#define IDLE_TICKS (HZ)
 
 	int idle_ticks_left;
-	int idle_count[IDLE_SLOTS];
+	int idle_count;
 	int idle_avg;
 
 } ____cacheline_aligned;
@@ -886,17 +886,6 @@
 #define BUSY_REBALANCE_TICK (HZ/4 ?: 1)
 #define IDLE_REBALANCE_TICK (HZ/1000 ?: 1)
 
-static inline int recalc_idle_avg(runqueue_t *rq)
-{
-	int i, count = 0, avg;
-
-	for (i = 1; i < IDLE_SLOTS; i++)
-		count += rq->idle_count[i];
-
-	avg = count / (IDLE_SLOTS - 1);
-	return avg;
-}
-
 static inline void idle_tick(runqueue_t *rq)
 {
 	if (jiffies % IDLE_REBALANCE_TICK)
@@ -938,17 +927,13 @@
 		 * This code is rare, triggered only once per second:
 		 */
 		if (--rq->idle_ticks_left <= 0) {
-			int i;
-
-			rq->idle_ticks_left = IDLE_TICKS;
-			for (i = IDLE_SLOTS-1; i > 0; i--)
-				rq->idle_count[i] = rq->idle_count[i-1];
-			rq->idle_count[0] = 0;
-			rq->idle_avg = recalc_idle_avg(rq);
+			rq->idle_avg = (rq->idle_avg * (IDLE_SLOTS - 1)
+					+ rq->idle_count) / IDLE_SLOTS;
+			rq->idle_count = 0;
 		}
 	}
 	if (p == rq->idle || p->policy == SCHED_BATCH)
-		rq->idle_count[0]++;
+		rq->idle_count++;
 #endif
 	if (p == rq->idle) {
 		if (local_bh_count(cpu) || local_irq_count(cpu) > 1)

-- 
 ------------------------------------------------------------------------
 | Kevin O'Connor                     "BTW, IMHO we need a FAQ for      |
 | kevin@koconnor.net                  'IMHO', 'FAQ', 'BTW', etc. !"    |
 ------------------------------------------------------------------------
