Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750726AbWCVKlE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750726AbWCVKlE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 05:41:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750817AbWCVKlE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 05:41:04 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:57870 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750726AbWCVKlC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 05:41:02 -0500
Date: Wed, 22 Mar 2006 11:40:59 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] kernel/time.c: remove unused pps_* variables
Message-ID: <20060322104059.GA3771@stusta.de>
References: <20060318044056.350a2931.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060318044056.350a2931.akpm@osdl.org>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 18, 2006 at 04:40:56AM -0800, Andrew Morton wrote:
>...
> Changes since 2.6.16-rc6-mm1:
>...
> -kernel-timec-remove-unused-pps_-variables.patch
> 
>  Dropped - being redone.
>...

This patch was unrelated, but seems to have been dropped due to context 
changes.

A version that applies against 2.6.16-rc6-mm2 is below.

cu
Adrian


<--  snip  -->


From: Adrian Bunk <bunk@stusta.de>

AFAIR there is a patch floating around that might use these variables, 
but this patch is still unmerged and my patch can easily be undone.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 include/linux/timex.h |    8 --------
 kernel/time.c         |   23 ++++++-----------------
 2 files changed, 6 insertions(+), 25 deletions(-)

--- linux-2.6.16-rc6-mm2-full/include/linux/timex.h.old	2006-03-21 23:30:45.000000000 +0100
+++ linux-2.6.16-rc6-mm2-full/include/linux/timex.h	2006-03-21 23:31:20.000000000 +0100
@@ -247,19 +247,11 @@
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
 /**
  * ntp_clear - Clears the NTP state variables
  *
--- linux-2.6.16-rc6-mm2-full/kernel/time.c.old	2006-03-21 23:30:57.000000000 +0100
+++ linux-2.6.16-rc6-mm2-full/kernel/time.c	2006-03-21 23:31:58.000000000 +0100
@@ -202,7 +202,6 @@
 	return do_sys_settimeofday(tv ? &new_ts : NULL, tz ? &new_tz : NULL);
 }
 
-long pps_offset;		/* pps time offset (us) */
 long pps_jitter = MAXTIME;	/* time dispersion (jitter) (us) */
 
 long pps_freq;			/* frequency offset (scaled ppm) */
@@ -210,16 +209,6 @@
 
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
 /* we call this to notify the arch when the clock is being
  * controlled.  If no such arch routine, do nothing.
  */
@@ -315,7 +304,7 @@
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
+	txc->shift	   = 0;
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
 	notify_arch_cmos_timer();

