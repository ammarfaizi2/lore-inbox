Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932088AbVHKB0Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932088AbVHKB0Y (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Aug 2005 21:26:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932067AbVHKB0Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Aug 2005 21:26:24 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:16561 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S932088AbVHKB0X
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Aug 2005 21:26:23 -0400
Subject: [RFC][PATCH - 3/13] NTP cleanup: Remove unused NTP PPS code
From: john stultz <johnstul@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: George Anzinger <george@mvista.com>, frank@tuxrocks.com,
       Anton Blanchard <anton@samba.org>, benh@kernel.crashing.org,
       Nishanth Aravamudan <nacc@us.ibm.com>,
       Roman Zippel <zippel@linux-m68k.org>,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>
In-Reply-To: <1123723534.32330.0.camel@cog.beaverton.ibm.com>
References: <1123723279.30963.267.camel@cog.beaverton.ibm.com>
	 <1123723384.30963.269.camel@cog.beaverton.ibm.com>
	 <1123723534.32330.0.camel@cog.beaverton.ibm.com>
Content-Type: text/plain
Date: Wed, 10 Aug 2005 18:26:18 -0700
Message-Id: <1123723578.32330.2.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All,
	Since the NTP PPS code required an out of tree patch which I don't
believe there is a 2.6 version of, this patch removes the unused PPS
logic in the kernel.

Any comments or feedback would be greatly appreciated.

thanks
-john


linux-2.6.13-rc6_timeofday-ntp-part3_B5.patch
============================================
diff --git a/kernel/ntp.c b/kernel/ntp.c
--- a/kernel/ntp.c
+++ b/kernel/ntp.c
@@ -46,26 +46,9 @@ void time_interpolator_update(long delta
 #define time_interpolator_update(x) do {} while (0)
 #endif
 
-
-static long pps_offset;            /* pps time offset (us) */
-static long pps_jitter = MAXTIME;  /* time dispersion (jitter) (us) */
-
-static long pps_freq;              /* frequency offset (scaled ppm) */
-static long pps_stabil = MAXFREQ;  /* frequency dispersion (scaled ppm) */
-
-static long pps_valid = PPS_VALID; /* pps signal watchdog counter */
-
-static int pps_shift = PPS_SHIFT;  /* interval duration (s) (shift) */
-
-static long pps_jitcnt;            /* jitter limit exceeded */
-static long pps_calcnt;            /* calibration intervals */
-static long pps_errcnt;            /* calibration errors */
-static long pps_stbcnt;            /* stability limit exceeded */
-
 /* Don't completely fail for HZ > 500.  */
 int tickadj = 500/HZ ? : 1;		/* microsecs */
 
-
 /*
  * phase-lock loop variables
  */
@@ -235,21 +218,7 @@ void second_overflow(void)
 		time_adj = ltemp << (SHIFT_SCALE - SHIFT_HZ - SHIFT_UPDATE);
 	}
 
-	/*
-	 * Compute the frequency estimate and additional phase
-	 * adjustment due to frequency error for the next
-	 * second. When the PPS signal is engaged, gnaw on the
-	 * watchdog counter and update the frequency computed by
-	 * the pll and the PPS signal.
-	 */
-	pps_valid++;
-	if (pps_valid == PPS_VALID) {	/* PPS signal lost */
-		pps_jitter = MAXTIME;
-		pps_stabil = MAXFREQ;
-		time_status &= ~(STA_PPSSIGNAL | STA_PPSJITTER |
-			STA_PPSWANDER | STA_PPSERROR);
-	}
-	ltemp = time_freq + pps_freq;
+	ltemp = time_freq;
 	if (ltemp < 0)
 		time_adj -= -ltemp >> (SHIFT_USEC + SHIFT_HZ - SHIFT_SCALE);
 	else
@@ -318,7 +287,7 @@ int ntp_adjtimex(struct timex *txc)
 				result = -EINVAL;
 				goto leave;
 			}
-			time_freq = txc->freq - pps_freq;
+			time_freq = txc->freq;
 		}
 
 		if (txc->modes & ADJ_MAXERROR) {
@@ -352,11 +321,8 @@ int ntp_adjtimex(struct timex *txc)
 				/* adjtime() is independent from ntp_adjtime() */
 				if ((time_next_adjust = txc->offset) == 0)
 					time_adjust = 0;
-			} else if ( time_status & (STA_PLL | STA_PPSTIME) ) {
-				ltemp = (time_status
-					& (STA_PPSTIME | STA_PPSSIGNAL))
-					== (STA_PPSTIME | STA_PPSSIGNAL) ?
-			            pps_offset : txc->offset;
+			} else if (time_status & STA_PLL) {
+				ltemp = txc->offset;
 
 				/*
 				 * Scale the phase adjustment and
@@ -411,7 +377,7 @@ int ntp_adjtimex(struct timex *txc)
 					time_freq = time_tolerance;
 				else if (time_freq < -time_tolerance)
 					time_freq = -time_tolerance;
-			} /* STA_PLL || STA_PPSTIME */
+			} /* STA_PLL */
 		} /* txc->modes & ADJ_OFFSET */
 
 		if (txc->modes & ADJ_TICK) {
@@ -421,17 +387,8 @@ int ntp_adjtimex(struct timex *txc)
 	} /* txc->modes */
 leave:
 
-	if ((time_status & (STA_UNSYNC|STA_CLOCKERR)) != 0
-		|| ((time_status & (STA_PPSFREQ|STA_PPSTIME)) != 0
-		&& (time_status & STA_PPSSIGNAL) == 0)
-		/* p. 24, (b) */
-		|| ((time_status & (STA_PPSTIME|STA_PPSJITTER))
-		== (STA_PPSTIME|STA_PPSJITTER))
-		/* p. 24, (c) */
-		|| ((time_status & STA_PPSFREQ) != 0
-		&& (time_status & (STA_PPSWANDER|STA_PPSERROR)) != 0))
-		/* p. 24, (d) */
-			result = TIME_ERROR;
+	if ((time_status & (STA_UNSYNC|STA_CLOCKERR)) != 0)
+		result = TIME_ERROR;
 
 	if ((txc->modes & ADJ_OFFSET_SINGLESHOT) == ADJ_OFFSET_SINGLESHOT)
 		txc->offset = save_adjust;
@@ -441,7 +398,7 @@ leave:
 		else
 			txc->offset = time_offset >> SHIFT_UPDATE;
 	}
-	txc->freq = time_freq + pps_freq;
+	txc->freq = time_freq;
 	txc->maxerror = time_maxerror;
 	txc->esterror = time_esterror;
 	txc->status = time_status;
@@ -449,14 +406,17 @@ leave:
 	txc->precision = time_precision;
 	txc->tolerance = time_tolerance;
 	txc->tick = tick_usec;
-	txc->ppsfreq = pps_freq;
-	txc->jitter = pps_jitter >> PPS_AVG;
-	txc->shift = pps_shift;
-	txc->stabil = pps_stabil;
-	txc->jitcnt = pps_jitcnt;
-	txc->calcnt = pps_calcnt;
-	txc->errcnt = pps_errcnt;
-	txc->stbcnt = pps_stbcnt;
+
+	/* PPS is not implemented, so these are zero */
+	txc->ppsfreq = 0;
+	txc->jitter = 0;
+	txc->shift = 0;
+	txc->stabil = 0;
+	txc->jitcnt = 0;
+	txc->calcnt = 0;
+	txc->errcnt = 0;
+	txc->stbcnt = 0;
+
 	write_sequnlock_irq(&xtime_lock);
 	do_gettimeofday(&txc->time);
 	return result;


