Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932438AbWHJARY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932438AbWHJARY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 20:17:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932416AbWHJARF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 20:17:05 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:17034 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S932438AbWHJAPk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 20:15:40 -0400
Message-Id: <20060810001114.420535000@linux-m68k.org>
References: <20060810000146.913645000@linux-m68k.org>
User-Agent: quilt/0.45-1
Date: Thu, 10 Aug 2006 02:01:50 +0200
From: zippel@linux-m68k.org
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, john stultz <johnstul@us.ibm.com>
Subject: [NTP 4/9] prescale time_offset
Content-Disposition: inline; filename=0004-NTP-prescale-time_offset.txt
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This converts time_offset into a scaled per tick value. This avoids now
completely the crude compensation in second_overflow().

Signed-off-by: Roman Zippel <zippel@linux-m68k.org>
---
 include/linux/timex.h |    2 -
 kernel/time/ntp.c     |   64 ++++++++++++--------------------------------------
 2 files changed, 17 insertions(+), 49 deletions(-)

Index: linux-2.6-mm/include/linux/timex.h
===================================================================
--- linux-2.6-mm.orig/include/linux/timex.h
+++ linux-2.6-mm/include/linux/timex.h
@@ -90,7 +90,7 @@
  * FINENSEC is 1 ns in SHIFT_UPDATE units of the time_phase variable.
  */
 #define SHIFT_SCALE 22		/* phase scale (shift) */
-#define SHIFT_UPDATE (SHIFT_KG + MAXTC) /* time offset scale (shift) */
+#define SHIFT_UPDATE (SHIFT_HZ + 1) /* time offset scale (shift) */
 #define SHIFT_USEC 16		/* frequency offset scale (shift) */
 #define FINENSEC (1L << (SHIFT_SCALE - 10)) /* ~1 ns in phase units */
 
Index: linux-2.6-mm/kernel/time/ntp.c
===================================================================
--- linux-2.6-mm.orig/kernel/time/ntp.c
+++ linux-2.6-mm/kernel/time/ntp.c
@@ -37,7 +37,7 @@ int tickadj = 500/HZ ? : 1;		/* microsec
 /* TIME_ERROR prevents overwriting the CMOS clock */
 int time_state = TIME_OK;		/* clock synchronization status	*/
 int time_status = STA_UNSYNC;		/* clock status bits		*/
-long time_offset;			/* time adjustment (us)		*/
+long time_offset;			/* time adjustment (ns)		*/
 long time_constant = 2;			/* pll time constant		*/
 long time_tolerance = MAXFREQ;		/* frequency tolerance (ppm)	*/
 long time_precision = 1;		/* clock precision (us)		*/
@@ -63,6 +63,7 @@ void ntp_clear(void)
 	ntp_update_frequency();
 
 	tick_length = tick_length_base;
+	time_offset = 0;
 }
 
 #define CLOCK_TICK_OVERFLOW	(LATCH * HZ - CLOCK_TICK_RATE)
@@ -89,7 +90,7 @@ void ntp_update_frequency(void)
  */
 void second_overflow(void)
 {
-	long ltemp, time_adj;
+	long time_adj;
 
 	/* Bump the maxerror field */
 	time_maxerror += time_tolerance >> SHIFT_USEC;
@@ -157,42 +158,14 @@ void second_overflow(void)
 	 * adjustment for each second is clamped so as to spread the adjustment
 	 * over not more than the number of seconds between updates.
 	 */
-	ltemp = time_offset;
-	if (!(time_status & STA_FLL))
-		ltemp = shift_right(ltemp, SHIFT_KG + time_constant);
-	ltemp = min(ltemp, (MAXPHASE / MINSEC) << SHIFT_UPDATE);
-	ltemp = max(ltemp, -(MAXPHASE / MINSEC) << SHIFT_UPDATE);
-	time_offset -= ltemp;
-	time_adj = ltemp << (SHIFT_SCALE - SHIFT_HZ - SHIFT_UPDATE);
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
-	time_adj += shift_right(time_adj, 2) + shift_right(time_adj, 5);
-#endif
-#if HZ == 250
-	/*
-	 * Compensate for (HZ==250) != (1 << SHIFT_HZ).  Add 1.5625% and
-	 * 0.78125% to get 255.85938; => only 0.05% error (p. 14)
-	 */
-	time_adj += shift_right(time_adj, 6) + shift_right(time_adj, 7);
-#endif
-#if HZ == 1000
-	/*
-	 * Compensate for (HZ==1000) != (1 << SHIFT_HZ).  Add 1.5625% and
-	 * 0.78125% to get 1023.4375; => only 0.05% error (p. 14)
-	 */
-	time_adj += shift_right(time_adj, 6) + shift_right(time_adj, 7);
-#endif
 	tick_length = tick_length_base;
-	tick_length += (s64)time_adj << (TICK_LENGTH_SHIFT - (SHIFT_SCALE - 10));
+	time_adj = time_offset;
+	if (!(time_status & STA_FLL))
+		time_adj = shift_right(time_adj, SHIFT_KG + time_constant);
+	time_adj = min(time_adj, -((MAXPHASE / HZ) << SHIFT_UPDATE) / MINSEC);
+	time_adj = max(time_adj, ((MAXPHASE / HZ) << SHIFT_UPDATE) / MINSEC);
+	time_offset -= time_adj;
+	tick_length += (s64)time_adj << (TICK_LENGTH_SHIFT - SHIFT_UPDATE);
 }
 
 /*
@@ -353,12 +326,8 @@ int do_adjtimex(struct timex *txc)
 		     * Scale the phase adjustment and
 		     * clamp to the operating range.
 		     */
-		    if (ltemp > MAXPHASE)
-		        time_offset = MAXPHASE << SHIFT_UPDATE;
-		    else if (ltemp < -MAXPHASE)
-			time_offset = -(MAXPHASE << SHIFT_UPDATE);
-		    else
-		        time_offset = ltemp << SHIFT_UPDATE;
+		    time_offset = min(ltemp, MAXPHASE);
+		    time_offset = max(time_offset, -MAXPHASE);
 
 		    /*
 		     * Select whether the frequency is to be controlled
@@ -372,8 +341,7 @@ int do_adjtimex(struct timex *txc)
 		    time_reftime = xtime.tv_sec;
 		    if (time_status & STA_FLL) {
 		        if (mtemp >= MINSEC) {
-			    ltemp = (time_offset / mtemp) << (SHIFT_USEC -
-							      SHIFT_UPDATE);
+			    ltemp = ((time_offset << 12) / mtemp) << (SHIFT_USEC - 12);
 			    time_freq += shift_right(ltemp, SHIFT_KH);
 			} else /* calibration interval too short (p. 12) */
 				result = TIME_ERROR;
@@ -388,6 +356,7 @@ int do_adjtimex(struct timex *txc)
 		    }
 		    time_freq = min(time_freq, time_tolerance);
 		    time_freq = max(time_freq, -time_tolerance);
+		    time_offset = (time_offset * NSEC_PER_USEC / HZ) << SHIFT_UPDATE;
 		} /* STA_PLL */
 	    } /* txc->modes & ADJ_OFFSET */
 	    if (txc->modes & ADJ_TICK)
@@ -401,9 +370,8 @@ leave:	if ((time_status & (STA_UNSYNC|ST
 
 	if ((txc->modes & ADJ_OFFSET_SINGLESHOT) == ADJ_OFFSET_SINGLESHOT)
 	    txc->offset	   = save_adjust;
-	else {
-	    txc->offset = shift_right(time_offset, SHIFT_UPDATE);
-	}
+	else
+	    txc->offset    = shift_right(time_offset, SHIFT_UPDATE) * HZ / 1000;
 	txc->freq	   = time_freq;
 	txc->maxerror	   = time_maxerror;
 	txc->esterror	   = time_esterror;

--

