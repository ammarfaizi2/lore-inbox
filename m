Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964952AbVLUXUM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964952AbVLUXUM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 18:20:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964957AbVLUXUL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 18:20:11 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:59018 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S964956AbVLUXUJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 18:20:09 -0500
Date: Thu, 22 Dec 2005 00:20:07 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: johnstul@us.ibm.com, linux-kernel@vger.kernel.org
Subject: [PATCH 1/10] NTP: Remove pps support
Message-ID: <Pine.LNX.4.61.0512220019330.30882@scrub.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This removes the support for pps. It's completely unused within the
kernel and is basically in the way for further cleanups. It should be
easier to readd proper support for it after the rest has been converted
to NTP4.
Patch is originally done by John Stultz, I did some minor cleanups and
updated it.

Signed-off-by: Roman Zippel <zippel@linux-m68k.org>

---

 include/linux/timex.h |   41 ----------------------------------
 kernel/time.c         |   59 +++++++++++++-------------------------------------
 kernel/timer.c        |   13 +----------
 3 files changed, 18 insertions(+), 95 deletions(-)

Index: linux-2.6-mm/include/linux/timex.h
===================================================================
--- linux-2.6-mm.orig/include/linux/timex.h	2005-12-21 12:10:36.000000000 +0100
+++ linux-2.6-mm/include/linux/timex.h	2005-12-21 12:11:48.000000000 +0100
@@ -97,38 +97,11 @@
 
 #define MAXPHASE 512000L        /* max phase error (us) */
 #define MAXFREQ (512L << SHIFT_USEC)  /* max frequency error (ppm) */
-#define MAXTIME (200L << PPS_AVG) /* max PPS error (jitter) (200 us) */
 #define MINSEC 16L              /* min interval between updates (s) */
 #define MAXSEC 1200L            /* max interval between updates (s) */
 #define	NTP_PHASE_LIMIT	(MAXPHASE << 5)	/* beyond max. dispersion */
 
 /*
- * The following defines are used only if a pulse-per-second (PPS)
- * signal is available and connected via a modem control lead, such as
- * produced by the optional ppsclock feature incorporated in the Sun
- * asynch driver. They establish the design parameters of the frequency-
- * lock loop used to discipline the CPU clock oscillator to the PPS
- * signal.
- *
- * PPS_AVG is the averaging factor for the frequency loop, as well as
- * the time and frequency dispersion.
- *
- * PPS_SHIFT and PPS_SHIFTMAX specify the minimum and maximum
- * calibration intervals, respectively, in seconds as a power of two.
- *
- * PPS_VALID is the maximum interval before the PPS signal is considered
- * invalid and protocol updates used directly instead.
- *
- * MAXGLITCH is the maximum interval before a time offset of more than
- * MAXTIME is believed.
- */
-#define PPS_AVG 2		/* pps averaging constant (shift) */
-#define PPS_SHIFT 2		/* min interval duration (s) (shift) */
-#define PPS_SHIFTMAX 8		/* max interval duration (s) (shift) */
-#define PPS_VALID 120		/* pps signal watchdog max (s) */
-#define MAXGLITCH 30		/* pps signal glitch max (s) */
-
-/*
  * syscall interface - used (mainly by NTP daemon)
  * to discipline kernel clock oscillator
  */
@@ -246,20 +219,6 @@ extern long time_reftime;	/* time at las
 extern long time_adjust;	/* The amount of adjtime left */
 extern long time_next_adjust;	/* Value for time_adjust at next tick */
 
-/* interface variables pps->timer interrupt */
-extern long pps_offset;		/* pps time offset (us) */
-extern long pps_jitter;		/* time dispersion (jitter) (us) */
-extern long pps_freq;		/* frequency offset (scaled ppm) */
-extern long pps_stabil;		/* frequency dispersion (scaled ppm) */
-extern long pps_valid;		/* pps signal watchdog counter */
-
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
Index: linux-2.6-mm/kernel/time.c
===================================================================
--- linux-2.6-mm.orig/kernel/time.c	2005-12-21 12:10:37.000000000 +0100
+++ linux-2.6-mm/kernel/time.c	2005-12-21 12:11:48.000000000 +0100
@@ -198,24 +198,6 @@ asmlinkage long sys_settimeofday(struct 
 	return do_sys_settimeofday(tv ? &new_ts : NULL, tz ? &new_tz : NULL);
 }
 
-long pps_offset;		/* pps time offset (us) */
-long pps_jitter = MAXTIME;	/* time dispersion (jitter) (us) */
-
-long pps_freq;			/* frequency offset (scaled ppm) */
-long pps_stabil = MAXFREQ;	/* frequency dispersion (scaled ppm) */
-
-long pps_valid = PPS_VALID;	/* pps signal watchdog counter */
-
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
@@ -275,7 +257,7 @@ int do_adjtimex(struct timex *txc)
 		    result = -EINVAL;
 		    goto leave;
 		}
-		time_freq = txc->freq - pps_freq;
+		time_freq = txc->freq;
 	    }
 
 	    if (txc->modes & ADJ_MAXERROR) {
@@ -308,10 +290,8 @@ int do_adjtimex(struct timex *txc)
 		    if ((time_next_adjust = txc->offset) == 0)
 			 time_adjust = 0;
 		}
-		else if ( time_status & (STA_PLL | STA_PPSTIME) ) {
-		    ltemp = (time_status & (STA_PPSTIME | STA_PPSSIGNAL)) ==
-		            (STA_PPSTIME | STA_PPSSIGNAL) ?
-		            pps_offset : txc->offset;
+		else if (time_status & STA_PLL) {
+		    ltemp = txc->offset;
 
 		    /*
 		     * Scale the phase adjustment and
@@ -352,23 +332,14 @@ int do_adjtimex(struct timex *txc)
 		    }
 		    time_freq = min(time_freq, time_tolerance);
 		    time_freq = max(time_freq, -time_tolerance);
-		} /* STA_PLL || STA_PPSTIME */
+		} /* STA_PLL */
 	    } /* txc->modes & ADJ_OFFSET */
 	    if (txc->modes & ADJ_TICK) {
 		tick_usec = txc->tick;
 		tick_nsec = TICK_USEC_TO_NSEC(tick_usec);
 	    }
 	} /* txc->modes */
-leave:	if ((time_status & (STA_UNSYNC|STA_CLOCKERR)) != 0
-	    || ((time_status & (STA_PPSFREQ|STA_PPSTIME)) != 0
-		&& (time_status & STA_PPSSIGNAL) == 0)
-	    /* p. 24, (b) */
-	    || ((time_status & (STA_PPSTIME|STA_PPSJITTER))
-		== (STA_PPSTIME|STA_PPSJITTER))
-	    /* p. 24, (c) */
-	    || ((time_status & STA_PPSFREQ) != 0
-		&& (time_status & (STA_PPSWANDER|STA_PPSERROR)) != 0))
-	    /* p. 24, (d) */
+leave:	if ((time_status & (STA_UNSYNC|STA_CLOCKERR)) != 0)
 		result = TIME_ERROR;
 	
 	if ((txc->modes & ADJ_OFFSET_SINGLESHOT) == ADJ_OFFSET_SINGLESHOT)
@@ -376,7 +347,7 @@ leave:	if ((time_status & (STA_UNSYNC|ST
 	else {
 	    txc->offset = shift_right(time_offset, SHIFT_UPDATE);
 	}
-	txc->freq	   = time_freq + pps_freq;
+	txc->freq	   = time_freq;
 	txc->maxerror	   = time_maxerror;
 	txc->esterror	   = time_esterror;
 	txc->status	   = time_status;
@@ -384,14 +355,16 @@ leave:	if ((time_status & (STA_UNSYNC|ST
 	txc->precision	   = time_precision;
 	txc->tolerance	   = time_tolerance;
 	txc->tick	   = tick_usec;
-	txc->ppsfreq	   = pps_freq;
-	txc->jitter	   = pps_jitter >> PPS_AVG;
-	txc->shift	   = pps_shift;
-	txc->stabil	   = pps_stabil;
-	txc->jitcnt	   = pps_jitcnt;
-	txc->calcnt	   = pps_calcnt;
-	txc->errcnt	   = pps_errcnt;
-	txc->stbcnt	   = pps_stbcnt;
+
+	/* PPS is not implemented, so these are zero */
+	txc->ppsfreq	   = 0;
+	txc->jitter	   = 0;
+	txc->shift	   = 0;
+	txc->stabil	   = 0;
+	txc->jitcnt	   = 0;
+	txc->calcnt	   = 0;
+	txc->errcnt	   = 0;
+	txc->stbcnt	   = 0;
 	write_sequnlock_irq(&xtime_lock);
 	do_gettimeofday(&txc->time);
 	notify_arch_cmos_timer();
Index: linux-2.6-mm/kernel/timer.c
===================================================================
--- linux-2.6-mm.orig/kernel/timer.c	2005-12-21 12:10:37.000000000 +0100
+++ linux-2.6-mm/kernel/timer.c	2005-12-21 12:11:48.000000000 +0100
@@ -679,18 +679,9 @@ static void second_overflow(void)
 
 	/*
 	 * Compute the frequency estimate and additional phase adjustment due
-	 * to frequency error for the next second. When the PPS signal is
-	 * engaged, gnaw on the watchdog counter and update the frequency
-	 * computed by the pll and the PPS signal.
+	 * to frequency error for the next second.
 	 */
-	pps_valid++;
-	if (pps_valid == PPS_VALID) {	/* PPS signal lost */
-		pps_jitter = MAXTIME;
-		pps_stabil = MAXFREQ;
-		time_status &= ~(STA_PPSSIGNAL | STA_PPSJITTER |
-				STA_PPSWANDER | STA_PPSERROR);
-	}
-	ltemp = time_freq + pps_freq;
+	ltemp = time_freq;
 	time_adj += shift_right(ltemp,(SHIFT_USEC + SHIFT_HZ - SHIFT_SCALE));
 
 #if HZ == 100
