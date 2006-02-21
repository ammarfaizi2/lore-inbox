Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161395AbWBUGVN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161395AbWBUGVN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 01:21:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161396AbWBUGVN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 01:21:13 -0500
Received: from e31.co.us.ibm.com ([32.97.110.149]:39080 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1161395AbWBUGVL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 01:21:11 -0500
Date: Mon, 20 Feb 2006 23:21:09 -0700
From: john stultz <johnstul@us.ibm.com>
To: akpm@osdl.org
Cc: john stultz <johnstul@us.ibm.com>, linux-kernel@vger.kernel.org,
       johnstul@us.ibm.com
Message-Id: <20060221062108.13304.31735.sendpatchset@cog.beaverton.ibm.com>
In-Reply-To: <20060221062102.13304.81613.sendpatchset@cog.beaverton.ibm.com>
References: <20060221062102.13304.81613.sendpatchset@cog.beaverton.ibm.com>
Subject: [-mm PATCH 1/11] Time: reduced ntp rework part 1 - fix adjtimeadj
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Syncs up the time-reduced-ntp-rework-part1.patch with the adjtime_adjustment() changes.

Signed-off-by: John Stultz <johnstul@us.ibm.com>

 kernel/timer.c |   28 +++++-----------------------
 1 files changed, 5 insertions(+), 23 deletions(-)

Index: mm-merge/kernel/timer.c
===================================================================
--- mm-merge.orig/kernel/timer.c
+++ mm-merge/kernel/timer.c
@@ -590,7 +590,6 @@ static long time_adj;			/* tick adjust (
 long time_reftime;			/* time at last adjustment (s)	*/
 long time_adjust;
 long time_next_adjust;
-long time_adjust_step;			/* per tick time_adjust step */
 
 /*
  * this routine handles the overflow of the microsecond field
@@ -757,25 +756,7 @@ static void ntp_advance(unsigned long in
 
 	/* calculate the per tick singleshot adjtime adjustment step: */
 	while (interval_ns >= tick_nsec) {
-		time_adjust_step = time_adjust;
-		if (time_adjust_step) {
-	    		/*
-			 * We are doing an adjtime thing.
-			 *
-			 * Prepare time_adjust_step to be within bounds.
-			 * Note that a positive time_adjust means we want
-			 * the clock to run faster.
-			 *
-			 * Limit the amount of the step to be in the range
-			 * -tickadj .. +tickadj:
-			 */
-			time_adjust_step = min(time_adjust_step, (long)tickadj);
-			time_adjust_step = max(time_adjust_step,
-							 (long)-tickadj);
-
-			/* Reduce by this step the amount of time left: */
-			time_adjust -= time_adjust_step;
-		}
+		time_adjust -= adjtime_adjustment();
 		interval_ns -= tick_nsec;
 	}
 
@@ -851,11 +833,11 @@ static void update_wall_time(unsigned lo
 {
 	do {
 		/*
-		 * Calculate the nsec delta using the precomputed NTP
+		 * Calculate the nsec delta using the NTP
 		 * adjustments:
-		 *     tick_nsec, time_adjust_step, time_adj
+		 *     tick_nsec, adjtime_adjustment(), phase_advance()
 		 */
-		long delta_nsec = tick_nsec + time_adjust_step * 1000;
+		long delta_nsec = tick_nsec + adjtime_adjustment() * 1000;
 		delta_nsec += phase_advance();
 
 		xtime_advance(delta_nsec);
