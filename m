Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964972AbVLUXYa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964972AbVLUXYa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 18:24:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964975AbVLUXY3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 18:24:29 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:61578 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S964972AbVLUXY2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 18:24:28 -0500
Date: Thu, 22 Dec 2005 00:24:24 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: johnstul@us.ibm.com, linux-kernel@vger.kernel.org
Subject: [PATCH 5/10] NTP: convert time_offset to nsec
Message-ID: <Pine.LNX.4.61.0512220022350.30906@scrub.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This converts time_offset into a scaled time_offset value. By scaling
the value it avoids completely the compensation in second_overflow().
Some calculations for the time_freq adjustments are now done using 64bit
values, which allows a better resolution and makes the NTP4 conversion
easier (the nsec resolution and increased time_constant range makes it
hard to keep it 32bit values).


Signed-off-by: Roman Zippel <zippel@linux-m68k.org>

---

 arch/powerpc/kernel/time.c |    6 ++-
 include/linux/timex.h      |    6 +--
 kernel/time.c              |   34 +++++++++++++---------
 kernel/timer.c             |   68 +++++++++++++++++++--------------------------
 4 files changed, 58 insertions(+), 56 deletions(-)

Index: linux-2.6-mm/arch/powerpc/kernel/time.c
===================================================================
--- linux-2.6-mm.orig/arch/powerpc/kernel/time.c	2005-12-21 12:09:49.000000000 +0100
+++ linux-2.6-mm/arch/powerpc/kernel/time.c	2005-12-21 12:12:08.000000000 +0100
@@ -794,12 +794,14 @@ void ppc_adjtimex(void)
 	 */
 	if ( time_offset < 0 ) {
 		ltemp = -time_offset;
-		ltemp <<= SHIFT_USEC - SHIFT_UPDATE;
+		ltemp <<= SHIFT_USEC - SHIFT_HZ;
+		ltemp = ltemp * HZ / 1000;
 		ltemp >>= SHIFT_KG + time_constant;
 		ltemp = -ltemp;
 	} else {
 		ltemp = time_offset;
-		ltemp <<= SHIFT_USEC - SHIFT_UPDATE;
+		ltemp <<= SHIFT_USEC - SHIFT_HZ;
+		ltemp = ltemp * HZ / 1000;
 		ltemp >>= SHIFT_KG + time_constant;
 	}
 	
Index: linux-2.6-mm/include/linux/timex.h
===================================================================
--- linux-2.6-mm.orig/include/linux/timex.h	2005-12-21 12:12:00.000000000 +0100
+++ linux-2.6-mm/include/linux/timex.h	2005-12-21 12:12:08.000000000 +0100
@@ -95,11 +95,11 @@
 #define SHIFT_USEC 16		/* frequency offset scale (shift) */
 #define FINENSEC (1L << SHIFT_SCALE) /* ~1 ns in phase units */
 
-#define MAXPHASE 512000L        /* max phase error (us) */
+#define MAXPHASE 500000000L	/* max phase error (ns) */
 #define MAXFREQ (512L << SHIFT_USEC)  /* max frequency error (ppm) */
 #define MINSEC 16L              /* min interval between updates (s) */
 #define MAXSEC 1200L            /* max interval between updates (s) */
-#define	NTP_PHASE_LIMIT	(MAXPHASE << 5)	/* beyond max. dispersion */
+#define NTP_PHASE_LIMIT	((MAXPHASE / 1000) << 5) /* beyond max. dispersion */
 
 /*
  * syscall interface - used (mainly by NTP daemon)
@@ -206,7 +206,7 @@ extern int tickadj;			/* amount of adjus
  */
 extern int time_state;		/* clock status */
 extern int time_status;		/* clock synchronization status bits */
-extern long time_offset;	/* time adjustment (us) */
+extern long time_offset;	/* time adjustment (ns) */
 extern long time_constant;	/* pll time constant */
 extern long time_tolerance;	/* frequency tolerance (ppm) */
 extern long time_precision;	/* clock precision (us) */
Index: linux-2.6-mm/kernel/time.c
===================================================================
--- linux-2.6-mm.orig/kernel/time.c	2005-12-21 12:12:04.000000000 +0100
+++ linux-2.6-mm/kernel/time.c	2005-12-21 12:12:08.000000000 +0100
@@ -212,6 +212,7 @@ void __attribute__ ((weak)) notify_arch_
 int do_adjtimex(struct timex *txc)
 {
         long ltemp, mtemp, save_adjust;
+	s64 freq_adj;
 	int result;
 
 	/* In order to modify anything, you gotta be super-user! */
@@ -227,7 +228,8 @@ int do_adjtimex(struct timex *txc)
 
 	if (txc->modes != ADJ_OFFSET_SINGLESHOT && (txc->modes & ADJ_OFFSET))
 	  /* adjustment Offset limited to +- .512 seconds */
-		if (txc->offset <= - MAXPHASE || txc->offset >= MAXPHASE )
+		if (txc->offset <= -MAXPHASE / 1000 ||
+		    txc->offset >= MAXPHASE / 1000)
 			return -EINVAL;	
 
 	/* if the quartz is off by more than 10% something is VERY wrong ! */
@@ -291,18 +293,18 @@ int do_adjtimex(struct timex *txc)
 			 time_adjust = 0;
 		}
 		else if (time_status & STA_PLL) {
-		    ltemp = txc->offset;
+		    ltemp = txc->offset * 1000;
 
 		    /*
 		     * Scale the phase adjustment and
 		     * clamp to the operating range.
 		     */
 		    if (ltemp > MAXPHASE)
-		        time_offset = MAXPHASE << SHIFT_UPDATE;
+		        time_offset = MAXPHASE;
 		    else if (ltemp < -MAXPHASE)
-			time_offset = -(MAXPHASE << SHIFT_UPDATE);
+			time_offset = -MAXPHASE;
 		    else
-		        time_offset = ltemp << SHIFT_UPDATE;
+		        time_offset = ltemp;
 
 		    /*
 		     * Select whether the frequency is to be controlled
@@ -316,15 +318,21 @@ int do_adjtimex(struct timex *txc)
 		    time_reftime = xtime.tv_sec;
 		    if (time_status & STA_FLL) {
 		        if (mtemp >= MINSEC) {
-			    ltemp = (time_offset / mtemp) << (SHIFT_USEC -
-							      SHIFT_UPDATE);
-			    time_freq += shift_right(ltemp, SHIFT_KH);
+			    if (time_offset < 0) {
+				freq_adj = (s64)-time_offset << SHIFT_USEC;
+				do_div(freq_adj, mtemp);
+				time_freq -= freq_adj >> SHIFT_KH;
+			    } else {
+				freq_adj = (s64)time_offset << SHIFT_USEC;
+				do_div(freq_adj, mtemp);
+				time_freq += freq_adj >> SHIFT_KH;
+			    }
 			} else /* calibration interval too short (p. 12) */
 				result = TIME_ERROR;
 		    } else {	/* PLL mode */
 		        if (mtemp < MAXSEC) {
-			    ltemp *= mtemp;
-			    time_freq += shift_right(ltemp,(time_constant +
+			    freq_adj = (s64)ltemp * mtemp;
+			    time_freq += shift_right(freq_adj,(time_constant +
 						       time_constant +
 						       SHIFT_KF - SHIFT_USEC));
 			} else /* calibration interval too long (p. 12) */
@@ -332,6 +340,7 @@ int do_adjtimex(struct timex *txc)
 		    }
 		    time_freq = min(time_freq, time_tolerance);
 		    time_freq = max(time_freq, -time_tolerance);
+		    time_offset = (time_offset / HZ) << SHIFT_HZ;
 		} /* STA_PLL */
 	    } /* txc->modes & ADJ_OFFSET */
 	    if (txc->modes & ADJ_TICK)
@@ -345,9 +354,8 @@ leave:	if ((time_status & (STA_UNSYNC|ST
 	
 	if ((txc->modes & ADJ_OFFSET_SINGLESHOT) == ADJ_OFFSET_SINGLESHOT)
 	    txc->offset	   = save_adjust;
-	else {
-	    txc->offset = shift_right(time_offset, SHIFT_UPDATE);
-	}
+	else
+	    txc->offset    = shift_right(time_offset, SHIFT_HZ) * HZ / 1000;
 	txc->freq	   = time_freq;
 	txc->maxerror	   = time_maxerror;
 	txc->esterror	   = time_esterror;
Index: linux-2.6-mm/kernel/timer.c
===================================================================
--- linux-2.6-mm.orig/kernel/timer.c	2005-12-21 12:12:04.000000000 +0100
+++ linux-2.6-mm/kernel/timer.c	2005-12-21 12:12:08.000000000 +0100
@@ -577,7 +577,7 @@ int tickadj = 500/HZ ? : 1;		/* microsec
 /* TIME_ERROR prevents overwriting the CMOS clock */
 int time_state = TIME_OK;		/* clock synchronization status	*/
 int time_status = STA_UNSYNC;		/* clock status bits		*/
-long time_offset;			/* time adjustment (us)		*/
+long time_offset;			/* time adjustment (ns)		*/
 long time_constant = 2;			/* pll time constant		*/
 long time_tolerance = MAXFREQ;		/* frequency tolerance (ppm)	*/
 long time_precision = 1;		/* clock precision (us)		*/
@@ -606,6 +606,7 @@ void ntp_clear(void)
 
 	tick_nsec_curr = tick_nsec;
 	time_adj_curr = time_adj;
+	time_offset = 0;
 }
 
 void ntp_update_frequency(void)
@@ -646,7 +647,7 @@ void ntp_update_frequency(void)
  */
 static void second_overflow(void)
 {
-	long ltemp, adj;
+	long ltemp;
 
 	/* Bump the maxerror field */
 	time_maxerror += time_tolerance >> SHIFT_USEC;
@@ -716,42 +717,33 @@ static void second_overflow(void)
 	 * adjustment for each second is clamped so as to spread the adjustment
 	 * over not more than the number of seconds between updates.
 	 */
-	ltemp = time_offset;
-	if (!(time_status & STA_FLL))
-		ltemp = shift_right(ltemp, SHIFT_KG + time_constant);
-	ltemp = min(ltemp, (MAXPHASE / MINSEC) << SHIFT_UPDATE);
-	ltemp = max(ltemp, -(MAXPHASE / MINSEC) << SHIFT_UPDATE);
-	time_offset -= ltemp;
-	adj = ltemp << (SHIFT_SCALE - SHIFT_HZ - SHIFT_UPDATE);
-
-	/*
-	 * Compute the frequency estimate and additional phase adjustment due
-	 * to frequency error for the next second.
-	 */
-
-#if HZ == 100
-	/*
-	 * Compensate for (HZ==100) != (1 << SHIFT_HZ).  Add 25% and 3.125% to
-	 * get 128.125; => only 0.125% error (p. 14)
-	 */
-	adj += shift_right(adj, 2) + shift_right(adj, 5);
-#endif
-#if HZ == 250
-	/*
-	 * Compensate for (HZ==250) != (1 << SHIFT_HZ).  Add 1.5625% and
-	 * 0.78125% to get 255.85938; => only 0.05% error (p. 14)
-	 */
-	adj += shift_right(adj, 6) + shift_right(adj, 7);
-#endif
-#if HZ == 1000
-	/*
-	 * Compensate for (HZ==1000) != (1 << SHIFT_HZ).  Add 1.5625% and
-	 * 0.78125% to get 1023.4375; => only 0.05% error (p. 14)
-	 */
-	adj += shift_right(adj, 6) + shift_right(adj, 7);
-#endif
-	tick_nsec_curr += adj >> (SHIFT_SCALE - 10);
-	time_adj_curr += (adj << 10) & (FINENSEC - 1);
+	if (time_offset < 0) {
+		ltemp = -time_offset;
+		if (!(time_status & STA_FLL))
+			ltemp >>= SHIFT_KG + time_constant;
+		if (ltemp > (((MAXPHASE / HZ) << SHIFT_HZ) / MINSEC))
+			ltemp = ((MAXPHASE / HZ) << SHIFT_HZ) / MINSEC;
+		time_offset += ltemp;
+		tick_nsec_curr -= ltemp >> SHIFT_HZ;
+		time_adj_curr -= (ltemp << (SHIFT_SCALE - SHIFT_HZ)) & (FINENSEC - 1);
+		if (time_adj_curr < 0) {
+			tick_nsec_curr--;
+			time_adj_curr += FINENSEC;
+		}
+	} else {
+		ltemp = time_offset;
+		if (!(time_status & STA_FLL))
+			ltemp >>= SHIFT_KG + time_constant;
+		if (ltemp > (((MAXPHASE / HZ) << SHIFT_HZ) / MINSEC))
+			ltemp = ((MAXPHASE / HZ) << SHIFT_HZ) / MINSEC;
+		time_offset -= ltemp;
+		tick_nsec_curr += ltemp >> SHIFT_HZ;
+		time_adj_curr += (ltemp << (SHIFT_SCALE - SHIFT_HZ)) & (FINENSEC - 1);
+		if (time_adj_curr >= FINENSEC) {
+			tick_nsec_curr++;
+			time_adj_curr -= FINENSEC;
+		}
+	}
 }
 
 /* in the NTP reference this is called "hardclock()" */
