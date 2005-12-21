Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964982AbVLUX1w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964982AbVLUX1w (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 18:27:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964984AbVLUX1w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 18:27:52 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:63114 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S964982AbVLUX1v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 18:27:51 -0500
Date: Thu, 22 Dec 2005 00:27:48 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: johnstul@us.ibm.com, linux-kernel@vger.kernel.org
Subject: [PATCH 8/10] NTP: convert time_freq to nsec
Message-ID: <Pine.LNX.4.61.0512220026510.30924@scrub.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This converts time_freq to a scaled nsec value and adds around 6bit of
extra resolution. This pushes the time_freq to its 32bit limits so the
adjustment checks have to be done with 64bit.

Signed-off-by: Roman Zippel <zippel@linux-m68k.org>

---

 include/linux/timex.h |    4 +++-
 kernel/time.c         |   21 ++++++++++++---------
 kernel/timer.c        |   12 +++++-------
 3 files changed, 20 insertions(+), 17 deletions(-)

Index: linux-2.6-mm/include/linux/timex.h
===================================================================
--- linux-2.6-mm.orig/include/linux/timex.h	2005-12-21 12:12:15.000000000 +0100
+++ linux-2.6-mm/include/linux/timex.h	2005-12-21 12:12:22.000000000 +0100
@@ -93,10 +93,12 @@
 #define SHIFT_SCALE 22		/* phase scale (shift) */
 #define SHIFT_UPDATE (SHIFT_KG + MAXTC) /* time offset scale (shift) */
 #define SHIFT_USEC 16		/* frequency offset scale (shift) */
+#define SHIFT_NSEC 12		/* kernel frequency offset scale */
 #define FINENSEC (1L << SHIFT_SCALE) /* ~1 ns in phase units */
 
 #define MAXPHASE 500000000L	/* max phase error (ns) */
-#define MAXFREQ (512L << SHIFT_USEC)  /* max frequency error (ppm) */
+#define MAXFREQ (500000L << SHIFT_NSEC)		/* max frequency error (ns/s) */
+#define MAXFREQ_USER (500L << SHIFT_USEC)	/* max frequency error (ppm) */
 #define MINSEC 16L              /* min interval between updates (s) */
 #define MAXSEC 1200L            /* max interval between updates (s) */
 #define NTP_PHASE_LIMIT	((MAXPHASE / 1000) << 5) /* beyond max. dispersion */
Index: linux-2.6-mm/kernel/time.c
===================================================================
--- linux-2.6-mm.orig/kernel/time.c	2005-12-21 12:12:15.000000000 +0100
+++ linux-2.6-mm/kernel/time.c	2005-12-21 12:12:22.000000000 +0100
@@ -255,11 +255,12 @@ int do_adjtimex(struct timex *txc)
 			      (time_status & STA_RONLY);
 
 	    if (txc->modes & ADJ_FREQUENCY) {	/* p. 22 */
-		if (txc->freq > MAXFREQ || txc->freq < -MAXFREQ) {
+		if (txc->freq > MAXFREQ_USER ||
+		    txc->freq < -MAXFREQ_USER) {
 		    result = -EINVAL;
 		    goto leave;
 		}
-		time_freq = txc->freq;
+		time_freq = ((s64)txc->freq * 1000) >> (SHIFT_USEC - SHIFT_NSEC);
 	    }
 
 	    if (txc->modes & ADJ_MAXERROR) {
@@ -315,30 +316,32 @@ int do_adjtimex(struct timex *txc)
 		        time_reftime = xtime.tv_sec;
 		    mtemp = xtime.tv_sec - time_reftime;
 		    time_reftime = xtime.tv_sec;
+		    freq_adj = 0;
 		    if (time_status & STA_FLL) {
 		        if (mtemp >= MINSEC) {
 			    if (time_offset < 0) {
 				freq_adj = (s64)-time_offset << SHIFT_USEC;
 				do_div(freq_adj, mtemp);
-				time_freq -= freq_adj >> SHIFT_KH;
+				freq_adj = -(freq_adj >> SHIFT_KH);
 			    } else {
 				freq_adj = (s64)time_offset << SHIFT_USEC;
 				do_div(freq_adj, mtemp);
-				time_freq += freq_adj >> SHIFT_KH;
+				freq_adj = freq_adj >> SHIFT_KH;
 			    }
 			} else /* calibration interval too short (p. 12) */
 				result = TIME_ERROR;
 		    } else {	/* PLL mode */
 		        if (mtemp < MAXSEC) {
 			    freq_adj = (s64)ltemp * mtemp;
-			    time_freq += shift_right(freq_adj,(time_constant +
+			    freq_adj = shift_right(freq_adj,(time_constant +
 						       time_constant +
 						       SHIFT_KF - SHIFT_USEC));
 			} else /* calibration interval too long (p. 12) */
 				result = TIME_ERROR;
 		    }
-		    time_freq = min(time_freq, MAXFREQ);
-		    time_freq = max(time_freq, -MAXFREQ);
+		    freq_adj += time_freq;
+		    freq_adj = min(freq_adj, (s64)MAXFREQ);
+		    time_freq = max(freq_adj, (s64)-MAXFREQ);
 		    time_offset = (time_offset / HZ) << SHIFT_HZ;
 		} /* STA_PLL */
 	    } /* txc->modes & ADJ_OFFSET */
@@ -355,13 +358,13 @@ leave:	if ((time_status & (STA_UNSYNC|ST
 	    txc->offset	   = save_adjust;
 	else
 	    txc->offset    = shift_right(time_offset, SHIFT_HZ) * HZ / 1000;
-	txc->freq	   = time_freq;
+	txc->freq	   = (time_freq / 1000) << (SHIFT_USEC - SHIFT_NSEC);
 	txc->maxerror	   = time_maxerror;
 	txc->esterror	   = time_esterror;
 	txc->status	   = time_status;
 	txc->constant	   = time_constant;
 	txc->precision	   = time_precision;
-	txc->tolerance	   = MAXFREQ;
+	txc->tolerance	   = MAXFREQ_USER;
 	txc->tick	   = tick_usec;
 
 	/* PPS is not implemented, so these are zero */
Index: linux-2.6-mm/kernel/timer.c
===================================================================
--- linux-2.6-mm.orig/kernel/timer.c	2005-12-21 12:12:15.000000000 +0100
+++ linux-2.6-mm/kernel/timer.c	2005-12-21 12:12:22.000000000 +0100
@@ -609,7 +609,6 @@ void ntp_clear(void)
 void ntp_update_frequency(void)
 {
 	long time;
-	s64 freq;
 
 	/*
 	 * Split the frequency value into a nsec value and fraction, which are
@@ -617,17 +616,16 @@ void ntp_update_frequency(void)
 	 * for the next HZ ticks with the remainder in freq (scaled by
 	 * (SHIFT_USEC - 3)).
 	 */
-	freq = (s64)time_freq * 1000;
 	time = tick_usec * 1000 * USER_HZ;
-	time += freq >> SHIFT_USEC;
+	time += time_freq >> SHIFT_NSEC;
 
 	/*
 	 * Now calculate the per tick values.
 	 */
 	tick_nsec = time / HZ;
-	time = (time % HZ) << SHIFT_USEC;
-	time += freq & ((1 << SHIFT_USEC) - 1);
-	time <<= SHIFT_SCALE - SHIFT_USEC;
+	time = (time % HZ) << SHIFT_NSEC;
+	time += time_freq & ((1 << SHIFT_NSEC) - 1);
+	time <<= SHIFT_SCALE - SHIFT_NSEC;
 	time_adj = time / HZ;
 
 	tick_nsec -= NSEC_PER_SEC / HZ - TICK_NSEC;
@@ -647,7 +645,7 @@ static void second_overflow(void)
 	long ltemp;
 
 	/* Bump the maxerror field */
-	time_maxerror += MAXFREQ >> SHIFT_USEC;
+	time_maxerror += MAXFREQ_USER >> SHIFT_USEC;
 	if (time_maxerror > NTP_PHASE_LIMIT) {
 		time_maxerror = NTP_PHASE_LIMIT;
 		time_status |= STA_UNSYNC;
