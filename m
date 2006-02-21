Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161397AbWBUGV3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161397AbWBUGV3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 01:21:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161398AbWBUGV3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 01:21:29 -0500
Received: from e33.co.us.ibm.com ([32.97.110.151]:62149 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1161397AbWBUGVY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 01:21:24 -0500
Date: Mon, 20 Feb 2006 23:21:21 -0700
From: john stultz <johnstul@us.ibm.com>
To: akpm@osdl.org
Cc: john stultz <johnstul@us.ibm.com>, linux-kernel@vger.kernel.org,
       johnstul@us.ibm.com
Message-Id: <20060221062121.13304.14825.sendpatchset@cog.beaverton.ibm.com>
In-Reply-To: <20060221062102.13304.81613.sendpatchset@cog.beaverton.ibm.com>
References: <20060221062102.13304.81613.sendpatchset@cog.beaverton.ibm.com>
Subject: [-mm PATCH 3/11] Time: reduced ntp rework part 2 - fix adjtimeadj
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Syncs up the time-reduced-ntp-rework-part2.patch with the adjtime_adjustment() changes.


 kernel/timer.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

Index: mm-merge/kernel/timer.c
===================================================================
--- mm-merge.orig/kernel/timer.c
+++ mm-merge/kernel/timer.c
@@ -589,7 +589,6 @@ static long time_adj;			/* tick adjust (
 long time_reftime;			/* time at last adjustment (s)	*/
 long time_adjust;
 long time_next_adjust;
-static long time_adjust_step;		/* per tick time_adjust step */
 
 static long total_sppm;			/* shifted ppm sum of all adjustments */
 static long offset_adj_ppm;
@@ -846,7 +845,7 @@ long ntp_get_ppm_adjustment(void)
 void ntp_advance(unsigned long interval_ns)
 {
 	static unsigned long interval_sum;
-
+	long time_adjust_step;
 	unsigned long flags;
 
 	write_seqlock_irqsave(&ntp_lock, flags);
@@ -854,9 +853,10 @@ void ntp_advance(unsigned long interval_
 	/* increment the interval sum: */
 	interval_sum += interval_ns;
 
+	time_adjust_step = adjtime_adjustment();
 	/* calculate the per tick singleshot adjtime adjustment step: */
 	while (interval_ns >= tick_nsec) {
-		time_adjust -= adjtime_adjustment();
+		time_adjust -= time_adjust_step;
 		interval_ns -= tick_nsec;
 	}
 	/* usec/tick => ppm: */
