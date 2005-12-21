Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964984AbVLUX20@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964984AbVLUX20 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 18:28:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964985AbVLUX20
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 18:28:26 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:63626 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S964984AbVLUX2Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 18:28:25 -0500
Date: Thu, 22 Dec 2005 00:28:22 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: johnstul@us.ibm.com, linux-kernel@vger.kernel.org
Subject: [PATCH 9/10] NTP: convert to the NTP4 model
Message-ID: <Pine.LNX.4.61.0512220027510.30927@scrub.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This converts the kernel ntp model into a model which matches the
nanokernel reference implementations. The previous patches already
increased the resolution and precision of the computations, so that this
conversion becomes quite simple.



Signed-off-by: Roman Zippel <zippel@linux-m68k.org>

---

 include/linux/timex.h |   12 +++++-------
 kernel/time.c         |   40 ++++++++++++++++------------------------
 kernel/timer.c        |   12 ++----------
 3 files changed, 23 insertions(+), 41 deletions(-)

Index: linux-2.6-mm/include/linux/timex.h
===================================================================
--- linux-2.6-mm.orig/include/linux/timex.h	2005-12-21 12:12:22.000000000 +0100
+++ linux-2.6-mm/include/linux/timex.h	2005-12-21 12:12:26.000000000 +0100
@@ -71,10 +71,9 @@
  * zero to MAXTC, the PLL will converge in 15 minutes to 16 hours,
  * respectively.
  */
-#define SHIFT_KG 6		/* phase factor (shift) */
-#define SHIFT_KF 16		/* PLL frequency factor (shift) */
-#define SHIFT_KH 2		/* FLL frequency factor (shift) */
-#define MAXTC 6			/* maximum time constant (shift) */
+#define SHIFT_PLL	4	/* PLL frequency factor (shift) */
+#define SHIFT_FLL	2	/* FLL frequency factor (shift) */
+#define MAXTC		10	/* maximum time constant (shift) */
 
 /*
  * The SHIFT_SCALE define establishes the decimal point of the time_phase
@@ -91,7 +90,6 @@
  * FINENSEC is 1 ns in SHIFT_UPDATE units of the time_phase variable.
  */
 #define SHIFT_SCALE 22		/* phase scale (shift) */
-#define SHIFT_UPDATE (SHIFT_KG + MAXTC) /* time offset scale (shift) */
 #define SHIFT_USEC 16		/* frequency offset scale (shift) */
 #define SHIFT_NSEC 12		/* kernel frequency offset scale */
 #define FINENSEC (1L << SHIFT_SCALE) /* ~1 ns in phase units */
@@ -99,8 +97,8 @@
 #define MAXPHASE 500000000L	/* max phase error (ns) */
 #define MAXFREQ (500000L << SHIFT_NSEC)		/* max frequency error (ns/s) */
 #define MAXFREQ_USER (500L << SHIFT_USEC)	/* max frequency error (ppm) */
-#define MINSEC 16L              /* min interval between updates (s) */
-#define MAXSEC 1200L            /* max interval between updates (s) */
+#define MINSEC 256		/* min interval between updates (s) */
+#define MAXSEC 2048		/* max interval between updates (s) */
 #define NTP_PHASE_LIMIT	((MAXPHASE / 1000) << 5) /* beyond max. dispersion */
 
 /*
Index: linux-2.6-mm/kernel/time.c
===================================================================
--- linux-2.6-mm.orig/kernel/time.c	2005-12-21 12:12:22.000000000 +0100
+++ linux-2.6-mm/kernel/time.c	2005-12-21 12:12:26.000000000 +0100
@@ -212,7 +212,7 @@ void __attribute__ ((weak)) notify_arch_
 int do_adjtimex(struct timex *txc)
 {
         long ltemp, mtemp, save_adjust;
-	s64 freq_adj;
+	s64 freq_adj, temp64;
 	int result;
 
 	/* In order to modify anything, you gotta be super-user! */
@@ -284,7 +284,7 @@ int do_adjtimex(struct timex *txc)
 		    result = -EINVAL;
 		    goto leave;
 		}
-		time_constant = txc->constant;
+		time_constant = min(txc->constant + 4, (long)MAXTC);
 	    }
 
 	    if (txc->modes & ADJ_OFFSET) {	/* values checked earlier */
@@ -316,28 +316,20 @@ int do_adjtimex(struct timex *txc)
 		        time_reftime = xtime.tv_sec;
 		    mtemp = xtime.tv_sec - time_reftime;
 		    time_reftime = xtime.tv_sec;
-		    freq_adj = 0;
-		    if (time_status & STA_FLL) {
-		        if (mtemp >= MINSEC) {
-			    if (time_offset < 0) {
-				freq_adj = (s64)-time_offset << SHIFT_USEC;
-				do_div(freq_adj, mtemp);
-				freq_adj = -(freq_adj >> SHIFT_KH);
-			    } else {
-				freq_adj = (s64)time_offset << SHIFT_USEC;
-				do_div(freq_adj, mtemp);
-				freq_adj = freq_adj >> SHIFT_KH;
-			    }
-			} else /* calibration interval too short (p. 12) */
-				result = TIME_ERROR;
-		    } else {	/* PLL mode */
-		        if (mtemp < MAXSEC) {
-			    freq_adj = (s64)ltemp * mtemp;
-			    freq_adj = shift_right(freq_adj,(time_constant +
-						       time_constant +
-						       SHIFT_KF - SHIFT_USEC));
-			} else /* calibration interval too long (p. 12) */
-				result = TIME_ERROR;
+
+		    freq_adj = (s64)time_offset * mtemp;
+		    freq_adj = shift_right(freq_adj, (time_constant + SHIFT_PLL +
+						      2) * 2 - SHIFT_NSEC);
+		    if (mtemp >= MINSEC && (time_status & STA_FLL || mtemp > MAXSEC)) {
+			if (time_offset < 0) {
+			    temp64 = (s64)-time_offset << SHIFT_NSEC;
+			    do_div(temp64, mtemp << SHIFT_FLL);
+			    freq_adj -= temp64;
+			} else {
+			    temp64 = (s64)time_offset << SHIFT_NSEC;
+			    do_div(temp64, mtemp << SHIFT_FLL);
+			    freq_adj += temp64;
+			}
 		    }
 		    freq_adj += time_freq;
 		    freq_adj = min(freq_adj, (s64)MAXFREQ);
Index: linux-2.6-mm/kernel/timer.c
===================================================================
--- linux-2.6-mm.orig/kernel/timer.c	2005-12-21 12:12:22.000000000 +0100
+++ linux-2.6-mm/kernel/timer.c	2005-12-21 12:12:26.000000000 +0100
@@ -713,11 +713,7 @@ static void second_overflow(void)
 	 * over not more than the number of seconds between updates.
 	 */
 	if (time_offset < 0) {
-		ltemp = -time_offset;
-		if (!(time_status & STA_FLL))
-			ltemp >>= SHIFT_KG + time_constant;
-		if (ltemp > (((MAXPHASE / HZ) << SHIFT_HZ) / MINSEC))
-			ltemp = ((MAXPHASE / HZ) << SHIFT_HZ) / MINSEC;
+		ltemp = -time_offset >> (SHIFT_PLL + time_constant);
 		time_offset += ltemp;
 		tick_nsec_curr -= ltemp >> SHIFT_HZ;
 		time_adj_curr -= (ltemp << (SHIFT_SCALE - SHIFT_HZ)) & (FINENSEC - 1);
@@ -726,11 +722,7 @@ static void second_overflow(void)
 			time_adj_curr += FINENSEC;
 		}
 	} else {
-		ltemp = time_offset;
-		if (!(time_status & STA_FLL))
-			ltemp >>= SHIFT_KG + time_constant;
-		if (ltemp > (((MAXPHASE / HZ) << SHIFT_HZ) / MINSEC))
-			ltemp = ((MAXPHASE / HZ) << SHIFT_HZ) / MINSEC;
+		ltemp = time_offset >> (SHIFT_PLL + time_constant);
 		time_offset -= ltemp;
 		tick_nsec_curr += ltemp >> SHIFT_HZ;
 		time_adj_curr += (ltemp << (SHIFT_SCALE - SHIFT_HZ)) & (FINENSEC - 1);
