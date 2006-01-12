Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161346AbWALWFT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161346AbWALWFT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 17:05:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161347AbWALWFT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 17:05:19 -0500
Received: from e31.co.us.ibm.com ([32.97.110.149]:27089 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1161346AbWALWFR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 17:05:17 -0500
Subject: [PATCH] Time: Timekeeping Fixups for 2.6.15-mm3
From: john stultz <johnstul@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Thu, 12 Jan 2006 14:05:02 -0800
Message-Id: <1137103513.2890.128.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Andrew,
	Below are two quick fixes I found while reviewing the timekeeping
patches currently in -mm. 

The first chunk fixes a missed return in the
time-fix-cpu-frequency-detection.patch which could possibly cause
interrupts to be disabled and never re-enabled (although the failure
case is unlikely, so this probably isn't biting anyone).

The second chunk removes a bit of code that was unnecessarily duplicated
in time-reduced-ntp-rework-part-2.patch that bumps the time_maxerror
variable each second (which is already done at the top of the function).
The code must of slipped in while moving the code in an earlier version
of the patch and didn't get removed as it should have been.

thanks
-john


linux-2.6.15-mm3_timeofday-fixups_B16.patch
===========================================
diff --git a/arch/i386/kernel/tsc.c b/arch/i386/kernel/tsc.c
index c86eba0..cab2546 100644
--- a/arch/i386/kernel/tsc.c
+++ b/arch/i386/kernel/tsc.c
@@ -158,7 +158,7 @@ static unsigned long calculate_cpu_khz(v
 
 	/* cpu freq too slow: */
 	if (delta64 <= CALIBRATE_TIME_MSEC)
-		return 0;
+		goto err;
 
 	delta64 += CALIBRATE_TIME_MSEC/2; /* round for do_div */
 	do_div(delta64,CALIBRATE_TIME_MSEC);
diff --git a/kernel/timer.c b/kernel/timer.c
index 8d10cd5..21efa12 100644
--- a/kernel/timer.c
+++ b/kernel/timer.c
@@ -745,13 +745,6 @@ static void second_overflow(void)
 		time_state = TIME_OK;
 	}
 
-	/* Bump the maxerror field */
-	time_maxerror += time_tolerance >> SHIFT_USEC;
-	if ( time_maxerror > NTP_PHASE_LIMIT ) {
-		time_maxerror = NTP_PHASE_LIMIT;
-		time_status |= STA_UNSYNC;
-	}
-
 	/*
 	 * Compute the phase adjustment for the next second. In PLL mode, the
 	 * offset is reduced by a fixed factor times the time constant. In FLL


