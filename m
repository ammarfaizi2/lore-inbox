Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262124AbULLUKB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262124AbULLUKB (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Dec 2004 15:10:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262119AbULLUH7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Dec 2004 15:07:59 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:51986 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262124AbULLUGO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Dec 2004 15:06:14 -0500
Date: Sun, 12 Dec 2004 21:06:00 +0100
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Subject: [2.6 patch] kernel/time.c: possible cleanups
Message-ID: <20041212200600.GS22324@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below contains some possible cleanups.

I don't claim it's correct, but since all these variables are never 
changed it doesn't make a difference.


diffstat output:
 include/linux/timex.h |    8 --------
 kernel/time.c         |   23 ++++++-----------------
 2 files changed, 6 insertions(+), 25 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc2-mm4-full/include/linux/timex.h.old	2004-12-12 03:27:38.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/include/linux/timex.h	2004-12-12 03:28:09.000000000 +0100
@@ -249,19 +249,11 @@
 extern long time_next_adjust;	/* Value for time_adjust at next tick */
 
 /* interface variables pps->timer interrupt */
-extern long pps_offset;		/* pps time offset (us) */
 extern long pps_jitter;		/* time dispersion (jitter) (us) */
 extern long pps_freq;		/* frequency offset (scaled ppm) */
 extern long pps_stabil;		/* frequency dispersion (scaled ppm) */
 extern long pps_valid;		/* pps signal watchdog counter */
 
-/* interface variables pps->adjtimex */
-extern int pps_shift;		/* interval duration (s) (shift) */
-extern long pps_jitcnt;		/* jitter limit exceeded */
-extern long pps_calcnt;		/* calibration intervals */
-extern long pps_errcnt;		/* calibration errors */
-extern long pps_stbcnt;		/* stability limit exceeded */
-
 #ifdef CONFIG_TIME_INTERPOLATION
 
 #define TIME_SOURCE_CPU 0
--- linux-2.6.10-rc2-mm4-full/kernel/time.c.old	2004-12-12 03:25:37.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/kernel/time.c	2004-12-12 03:31:41.000000000 +0100
@@ -197,7 +197,6 @@
 	return do_sys_settimeofday(tv ? &new_ts : NULL, tz ? &new_tz : NULL);
 }
 
-long pps_offset;		/* pps time offset (us) */
 long pps_jitter = MAXTIME;	/* time dispersion (jitter) (us) */
 
 long pps_freq;			/* frequency offset (scaled ppm) */
@@ -205,16 +204,6 @@
 
 long pps_valid = PPS_VALID;	/* pps signal watchdog counter */
 
-int pps_shift = PPS_SHIFT;	/* interval duration (s) (shift) */
-
-long pps_jitcnt;		/* jitter limit exceeded */
-long pps_calcnt;		/* calibration intervals */
-long pps_errcnt;		/* calibration errors */
-long pps_stbcnt;		/* stability limit exceeded */
-
-/* hook for a loadable hardpps kernel module */
-void (*hardpps_ptr)(struct timeval *);
-
 /* adjtimex mainly allows reading (and writing, if superuser) of
  * kernel time-keeping variables. used by xntpd.
  */
@@ -302,7 +291,7 @@
 		else if ( time_status & (STA_PLL | STA_PPSTIME) ) {
 		    ltemp = (time_status & (STA_PPSTIME | STA_PPSSIGNAL)) ==
 		            (STA_PPSTIME | STA_PPSSIGNAL) ?
-		            pps_offset : txc->offset;
+		            0 : txc->offset;
 
 		    /*
 		     * Scale the phase adjustment and
@@ -390,12 +379,12 @@
 	txc->tick	   = tick_usec;
 	txc->ppsfreq	   = pps_freq;
 	txc->jitter	   = pps_jitter >> PPS_AVG;
-	txc->shift	   = pps_shift;
+	txc->shift	   = PPS_SHIFT;
 	txc->stabil	   = pps_stabil;
-	txc->jitcnt	   = pps_jitcnt;
-	txc->calcnt	   = pps_calcnt;
-	txc->errcnt	   = pps_errcnt;
-	txc->stbcnt	   = pps_stbcnt;
+	txc->jitcnt	   = 0;
+	txc->calcnt	   = 0;
+	txc->errcnt	   = 0;
+	txc->stbcnt	   = 0;
 	write_sequnlock_irq(&xtime_lock);
 	do_gettimeofday(&txc->time);
 	return(result);

