Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265326AbUBFJ2E (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Feb 2004 04:28:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265321AbUBFJ2E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Feb 2004 04:28:04 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:25554 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S265338AbUBFJ1R
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Feb 2004 04:27:17 -0500
Message-Id: <200402060924.i169OWx30517@owlet.beaverton.ibm.com>
To: piggin@cyberone.com.au, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, mjbligh@us.ibm.com, dvhltc@us.ibm.com
Subject: [PATCH] Load balancing problem in 2.6.2-mm1
Date: Fri, 06 Feb 2004 01:24:32 -0800
From: Rick Lindsley <ricklind@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick, Andrew --

Found a problem in Nick's code which had it way overbalancing much of
the time.  I've included a patch below.

I had been porting my schedstats patch to the -mm tree and noticed some
huge imbalances (on the order of 33 million) being "corrected" and at
first I thought it was a mis-port. But it was right.  We really were
deciding 33 million processes had to move.  Of course, we never found
that many, but we still moved as many as can_migrate_task() would allow.

In find_busiest_group(), after we exit the do/while, we select our
imbalance.  But max_load, avg_load, and this_load are all unsigned,
so min(x,y) will make a bad choice if max_load < avg_load < this_load
(that is, a choice between two negative [very large] numbers).

Unfortunately, there is a bug when max_load never gets changed from zero
(look in the loop and think what happens if the only load on the machine
is being created by cpu groups of which we are a member). And you have
a recipe for some really bogus values for imbalance.

Even if you fix the max_load == 0 bug, there will still be times when
avg_load - this_load will be negative (thus very large) and you'll make
the decision to move stuff when you shouldn't have.

This patch allows for this_load to set max_load, which if I understand
the logic properly is correct.  It then adds a check to imbalance to make
sure a negative number hasn't been coerced into a large positive number.
With this patch applied, the algorithm is *much* more conservative ...
maybe *too* conservative but that's for another round of testing ...

Rick

diff -rup linux-2.6.2-mm1/kernel/sched.c linux-2.6.2-mm1-fix/kernel/sched.c
--- linux-2.6.2-mm1/kernel/sched.c	Thu Feb  5 14:47:17 2004
+++ linux-2.6.2-mm1-fix/kernel/sched.c	Thu Feb  5 21:44:04 2004
@@ -1352,7 +1624,7 @@ static struct sched_group *
 find_busiest_group(struct sched_domain *domain, int this_cpu,
 				unsigned long *imbalance, enum idle_type idle)
 {
-	unsigned long max_load, avg_load, total_load, this_load;
+	unsigned long max_load, avg_load, total_load, this_load, load_diff;
 	int modify, total_nr_cpus, busiest_nr_cpus = 0;
 	enum idle_type package_idle = IDLE;
 	struct sched_group *busiest = NULL, *group = domain->groups;
@@ -1407,14 +1679,13 @@ find_busiest_group(struct sched_domain *
 		total_nr_cpus += nr_cpus;
 		avg_load /= nr_cpus;
 
+		if (avg_load > max_load)
+			max_load = avg_load;
+
 		if (local_group) {
 			this_load = avg_load;
-			goto nextgroup;
-		}
-
-		if (avg_load >= max_load) {
+		} else if (avg_load >= max_load) {
 			busiest = group;
-			max_load = avg_load;
 			busiest_nr_cpus = nr_cpus;
 		}
 nextgroup:
@@ -1437,8 +1708,19 @@ nextgroup:
 	 * reduce the max loaded cpu below the average load, as either of these
 	 * actions would just result in more rebalancing later, and ping-pong
 	 * tasks around. Thus we look for the minimum possible imbalance.
+	 * Negative imbalances (*we* are more loaded than anyone else) will
+	 * be counted as no imbalance for these purposes -- we can't fix that
+	 * by pulling tasks to us.  Be careful of negative numbers as they'll
+	 * appear as very large values with unsigned longs.
 	 */
-	*imbalance = min(max_load - avg_load, avg_load - this_load);
+	if (avg_load > this_load)
+		load_diff = avg_load - this_load;
+	else
+		load_diff = 0;
+
+	*imbalance = min(max_load - avg_load, load_diff);
+	if ((long)*imbalance < 0)
+		*imbalance = 0;
 
 	/* Get rid of the scaling factor now, rounding *up* as we divide */
 	*imbalance = (*imbalance + SCHED_LOAD_SCALE - 1) >> SCHED_LOAD_SHIFT;
