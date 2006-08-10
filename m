Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932441AbWHJAQF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932441AbWHJAQF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 20:16:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932407AbWHJAPn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 20:15:43 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:14986 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S932398AbWHJAPi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 20:15:38 -0400
Message-Id: <20060810001115.252037000@linux-m68k.org>
References: <20060810000146.913645000@linux-m68k.org>
User-Agent: quilt/0.45-1
Date: Thu, 10 Aug 2006 02:01:53 +0200
From: zippel@linux-m68k.org
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, john stultz <johnstul@us.ibm.com>
Subject: [NTP 7/9] convert time_freq to nsec value
Content-Disposition: inline; filename=0007-NTP-convert-time_freq-to-nsec-value.txt
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This converts time_freq to a scaled nsec value and adds around 6bit of
extra resolution. This pushes the time_freq to its 32bit limits so the
calculatons have to be done with 64bit.

Signed-off-by: Roman Zippel <zippel@linux-m68k.org>
---
 include/linux/timex.h |    2 ++
 kernel/time/ntp.c     |   36 ++++++++++++++++++++++--------------
 2 files changed, 24 insertions(+), 14 deletions(-)

Index: linux-2.6-mm/include/linux/timex.h
===================================================================
--- linux-2.6-mm.orig/include/linux/timex.h
+++ linux-2.6-mm/include/linux/timex.h
@@ -92,10 +92,12 @@
 #define SHIFT_SCALE 22		/* phase scale (shift) */
 #define SHIFT_UPDATE (SHIFT_HZ + 1) /* time offset scale (shift) */
 #define SHIFT_USEC 16		/* frequency offset scale (shift) */
+#define SHIFT_NSEC 12		/* kernel frequency offset scale */
 #define FINENSEC (1L << (SHIFT_SCALE - 10)) /* ~1 ns in phase units */
 
 #define MAXPHASE 512000L        /* max phase error (us) */
 #define MAXFREQ (512L << SHIFT_USEC)  /* max frequency error (ppm) */
+#define MAXFREQ_NSEC (512000L << SHIFT_NSEC) /* max frequency error (ppb) */
 #define MINSEC 16L              /* min interval between updates (s) */
 #define MAXSEC 1200L            /* max interval between updates (s) */
 #define	NTP_PHASE_LIMIT	(MAXPHASE << 5)	/* beyond max. dispersion */
Index: linux-2.6-mm/kernel/time/ntp.c
===================================================================
--- linux-2.6-mm.orig/kernel/time/ntp.c
+++ linux-2.6-mm/kernel/time/ntp.c
@@ -72,7 +72,7 @@ void ntp_update_frequency(void)
 {
 	tick_length_base = (u64)(tick_usec * NSEC_PER_USEC * USER_HZ) << TICK_LENGTH_SHIFT;
 	tick_length_base += (s64)CLOCK_TICK_ADJUST << TICK_LENGTH_SHIFT;
-	tick_length_base += ((s64)time_freq * NSEC_PER_USEC) << (TICK_LENGTH_SHIFT - SHIFT_USEC);
+	tick_length_base += (s64)time_freq << (TICK_LENGTH_SHIFT - SHIFT_NSEC);
 
 	do_div(tick_length_base, HZ);
 
@@ -206,6 +206,7 @@ void __attribute__ ((weak)) notify_arch_
 int do_adjtimex(struct timex *txc)
 {
 	long ltemp, mtemp, save_adjust;
+	s64 freq_adj;
 	int result;
 
 	/* In order to modify anything, you gotta be super-user! */
@@ -251,7 +252,7 @@ int do_adjtimex(struct timex *txc)
 		    result = -EINVAL;
 		    goto leave;
 		}
-		time_freq = txc->freq;
+		time_freq = ((s64)txc->freq * NSEC_PER_USEC) >> (SHIFT_USEC - SHIFT_NSEC);
 	    }
 
 	    if (txc->modes & ADJ_MAXERROR) {
@@ -284,14 +285,14 @@ int do_adjtimex(struct timex *txc)
 		    time_adjust = txc->offset;
 		}
 		else if (time_status & STA_PLL) {
-		    ltemp = txc->offset;
+		    ltemp = txc->offset * NSEC_PER_USEC;
 
 		    /*
 		     * Scale the phase adjustment and
 		     * clamp to the operating range.
 		     */
-		    time_offset = min(ltemp, MAXPHASE);
-		    time_offset = max(time_offset, -MAXPHASE);
+		    time_offset = min(ltemp, MAXPHASE * NSEC_PER_USEC);
+		    time_offset = max(time_offset, -MAXPHASE * NSEC_PER_USEC);
 
 		    /*
 		     * Select whether the frequency is to be controlled
@@ -303,24 +304,31 @@ int do_adjtimex(struct timex *txc)
 		        time_reftime = xtime.tv_sec;
 		    mtemp = xtime.tv_sec - time_reftime;
 		    time_reftime = xtime.tv_sec;
+		    freq_adj = 0;
 		    if (time_status & STA_FLL) {
 		        if (mtemp >= MINSEC) {
-			    ltemp = ((time_offset << 12) / mtemp) << (SHIFT_USEC - 12);
-			    time_freq += shift_right(ltemp, SHIFT_KH);
+			    freq_adj = (s64)time_offset << (SHIFT_NSEC - SHIFT_KH);
+			    if (time_offset < 0) {
+				freq_adj = -freq_adj;
+				do_div(freq_adj, mtemp);
+				freq_adj = -freq_adj;
+			    } else
+				do_div(freq_adj, mtemp);
 			} else /* calibration interval too short (p. 12) */
 				result = TIME_ERROR;
 		    } else {	/* PLL mode */
 		        if (mtemp < MAXSEC) {
-			    ltemp *= mtemp;
-			    time_freq += shift_right(ltemp,(time_constant +
+			    freq_adj = (s64)ltemp * mtemp;
+			    freq_adj = shift_right(freq_adj,(time_constant +
 						       time_constant +
-						       SHIFT_KF - SHIFT_USEC));
+						       SHIFT_KF - SHIFT_NSEC));
 			} else /* calibration interval too long (p. 12) */
 				result = TIME_ERROR;
 		    }
-		    time_freq = min(time_freq, MAXFREQ);
-		    time_freq = max(time_freq, -MAXFREQ);
-		    time_offset = (time_offset * NSEC_PER_USEC / HZ) << SHIFT_UPDATE;
+		    freq_adj += time_freq;
+		    freq_adj = min(freq_adj, (s64)MAXFREQ_NSEC);
+		    time_freq = max(freq_adj, (s64)-MAXFREQ_NSEC);
+		    time_offset = (time_offset / HZ) << SHIFT_UPDATE;
 		} /* STA_PLL */
 	    } /* txc->modes & ADJ_OFFSET */
 	    if (txc->modes & ADJ_TICK)
@@ -336,7 +344,7 @@ leave:	if ((time_status & (STA_UNSYNC|ST
 	    txc->offset	   = save_adjust;
 	else
 	    txc->offset    = shift_right(time_offset, SHIFT_UPDATE) * HZ / 1000;
-	txc->freq	   = time_freq;
+	txc->freq	   = (time_freq / NSEC_PER_USEC) << (SHIFT_USEC - SHIFT_NSEC);
 	txc->maxerror	   = time_maxerror;
 	txc->esterror	   = time_esterror;
 	txc->status	   = time_status;

--

