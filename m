Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932398AbWHJAQE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932398AbWHJAQE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 20:16:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932441AbWHJAPp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 20:15:45 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:15754 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S932416AbWHJAPj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 20:15:39 -0400
Message-Id: <20060810001115.525351000@linux-m68k.org>
References: <20060810000146.913645000@linux-m68k.org>
User-Agent: quilt/0.45-1
Date: Thu, 10 Aug 2006 02:01:54 +0200
From: zippel@linux-m68k.org
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, john stultz <johnstul@us.ibm.com>
Subject: [NTP 8/9] convert to the NTP4 reference model
Content-Disposition: inline; filename=0008-NTP-convert-to-the-NTP4-reference-model.txt
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This converts the kernel ntp model into a model which matches the
nanokernel reference implementations. The previous patches already
increased the resolution and precision of the computations, so that this
conversion becomes quite simple.

Signed-off-by: Roman Zippel <zippel@linux-m68k.org>
---
 include/linux/timex.h |   11 ++++------
 kernel/time/ntp.c     |   51 ++++++++++++++++++--------------------------------
 2 files changed, 24 insertions(+), 38 deletions(-)

Index: linux-2.6-mm/include/linux/timex.h
===================================================================
--- linux-2.6-mm.orig/include/linux/timex.h
+++ linux-2.6-mm/include/linux/timex.h
@@ -70,10 +70,9 @@
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
@@ -98,8 +97,8 @@
 #define MAXPHASE 512000L        /* max phase error (us) */
 #define MAXFREQ (512L << SHIFT_USEC)  /* max frequency error (ppm) */
 #define MAXFREQ_NSEC (512000L << SHIFT_NSEC) /* max frequency error (ppb) */
-#define MINSEC 16L              /* min interval between updates (s) */
-#define MAXSEC 1200L            /* max interval between updates (s) */
+#define MINSEC 256		/* min interval between updates (s) */
+#define MAXSEC 2048		/* max interval between updates (s) */
 #define	NTP_PHASE_LIMIT	(MAXPHASE << 5)	/* beyond max. dispersion */
 
 /*
Index: linux-2.6-mm/kernel/time/ntp.c
===================================================================
--- linux-2.6-mm.orig/kernel/time/ntp.c
+++ linux-2.6-mm/kernel/time/ntp.c
@@ -151,18 +151,11 @@ void second_overflow(void)
 	}
 
 	/*
-	 * Compute the phase adjustment for the next second. In PLL mode, the
-	 * offset is reduced by a fixed factor times the time constant. In FLL
-	 * mode the offset is used directly. In either mode, the maximum phase
-	 * adjustment for each second is clamped so as to spread the adjustment
-	 * over not more than the number of seconds between updates.
+	 * Compute the phase adjustment for the next second. The offset is
+	 * reduced by a fixed factor times the time constant.
 	 */
 	tick_length = tick_length_base;
-	time_adj = time_offset;
-	if (!(time_status & STA_FLL))
-		time_adj = shift_right(time_adj, SHIFT_KG + time_constant);
-	time_adj = min(time_adj, -((MAXPHASE / HZ) << SHIFT_UPDATE) / MINSEC);
-	time_adj = max(time_adj, ((MAXPHASE / HZ) << SHIFT_UPDATE) / MINSEC);
+	time_adj = shift_right(time_offset, SHIFT_PLL + time_constant);
 	time_offset -= time_adj;
 	tick_length += (s64)time_adj << (TICK_LENGTH_SHIFT - SHIFT_UPDATE);
 
@@ -206,7 +199,7 @@ void __attribute__ ((weak)) notify_arch_
 int do_adjtimex(struct timex *txc)
 {
 	long ltemp, mtemp, save_adjust;
-	s64 freq_adj;
+	s64 freq_adj, temp64;
 	int result;
 
 	/* In order to modify anything, you gotta be super-user! */
@@ -276,7 +269,7 @@ int do_adjtimex(struct timex *txc)
 		    result = -EINVAL;
 		    goto leave;
 		}
-		time_constant = txc->constant;
+		time_constant = min(txc->constant + 4, (long)MAXTC);
 	    }
 
 	    if (txc->modes & ADJ_OFFSET) {	/* values checked earlier */
@@ -304,26 +297,20 @@ int do_adjtimex(struct timex *txc)
 		        time_reftime = xtime.tv_sec;
 		    mtemp = xtime.tv_sec - time_reftime;
 		    time_reftime = xtime.tv_sec;
-		    freq_adj = 0;
-		    if (time_status & STA_FLL) {
-		        if (mtemp >= MINSEC) {
-			    freq_adj = (s64)time_offset << (SHIFT_NSEC - SHIFT_KH);
-			    if (time_offset < 0) {
-				freq_adj = -freq_adj;
-				do_div(freq_adj, mtemp);
-				freq_adj = -freq_adj;
-			    } else
-				do_div(freq_adj, mtemp);
-			} else /* calibration interval too short (p. 12) */
-				result = TIME_ERROR;
-		    } else {	/* PLL mode */
-		        if (mtemp < MAXSEC) {
-			    freq_adj = (s64)ltemp * mtemp;
-			    freq_adj = shift_right(freq_adj,(time_constant +
-						       time_constant +
-						       SHIFT_KF - SHIFT_NSEC));
-			} else /* calibration interval too long (p. 12) */
-				result = TIME_ERROR;
+
+		    freq_adj = (s64)time_offset * mtemp;
+		    freq_adj = shift_right(freq_adj, time_constant * 2 +
+					   (SHIFT_PLL + 2) * 2 - SHIFT_NSEC);
+		    if (mtemp >= MINSEC && (time_status & STA_FLL || mtemp > MAXSEC)) {
+			temp64 = (s64)time_offset << (SHIFT_NSEC - SHIFT_FLL);
+			if (time_offset < 0) {
+			    temp64 = -temp64;
+			    do_div(temp64, mtemp);
+			    freq_adj -= temp64;
+			} else {
+			    do_div(temp64, mtemp);
+			    freq_adj += temp64;
+			}
 		    }
 		    freq_adj += time_freq;
 		    freq_adj = min(freq_adj, (s64)MAXFREQ_NSEC);

--

