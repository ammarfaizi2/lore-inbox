Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161433AbWBUGVp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161433AbWBUGVp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 01:21:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161438AbWBUGVp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 01:21:45 -0500
Received: from e32.co.us.ibm.com ([32.97.110.150]:46265 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1161437AbWBUGVo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 01:21:44 -0500
Date: Mon, 20 Feb 2006 23:21:40 -0700
From: john stultz <johnstul@us.ibm.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, johnstul@us.ibm.com,
       john stultz <johnstul@us.ibm.com>
Message-Id: <20060221062139.13304.33142.sendpatchset@cog.beaverton.ibm.com>
In-Reply-To: <20060221062102.13304.81613.sendpatchset@cog.beaverton.ibm.com>
References: <20060221062102.13304.81613.sendpatchset@cog.beaverton.ibm.com>
Subject: [-mm PATCH 6/11] Time: generic timekeeping infrastructure - fix ntp_synced
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Call ntp_synced() is frequently enough. This fixes a potential bug where 
when ntp_synced is called, it isn't close enough to the second boundery 
(which is tested inside ntp_synced()). Without this its possible that since 
we only called it once a second, it would never sync the persistent clock.

Signed-off-by: John Stultz <johnstul@us.ibm.com>

 kernel/time/timeofday.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

Index: mm-merge/kernel/time/timeofday.c
===================================================================
--- mm-merge.orig/kernel/time/timeofday.c
+++ mm-merge/kernel/time/timeofday.c
@@ -534,7 +534,7 @@ static void timeofday_periodic_hook(unsi
 	/* advance the ntp state machine by ns interval: */
 	ntp_advance(delta_nsec);
 
-	/* only call ntp_leapsecond and ntp_sync once a sec:  */
+	/* only call ntp_leapsecond once a sec:  */
 	second_check += delta_nsec;
 	if (second_check >= NSEC_PER_SEC) {
 		/* do ntp leap second processing: */
@@ -545,11 +545,11 @@ static void timeofday_periodic_hook(unsi
 			wall_time_ts.tv_sec += leapsecond;
 			monotonic_time_offset_ts.tv_sec += leapsecond;
 		}
-		/* sync the persistent clock: */
-		if (ntp_synced())
-			sync_persistent_clock(wall_time_ts);
 		second_check -= NSEC_PER_SEC;
 	}
+	/* sync the persistent clock: */
+	if (ntp_synced())
+		sync_persistent_clock(wall_time_ts);
 
 	/* if necessary, switch clocksources: */
 	next = get_next_clocksource();
