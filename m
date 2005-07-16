Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262061AbVGPDC2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262061AbVGPDC2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Jul 2005 23:02:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262069AbVGPC77
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Jul 2005 22:59:59 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:26769 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S262061AbVGPC6h
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Jul 2005 22:58:37 -0400
Subject: [RFC][PATCH - 3/12] NTP cleanup: Remove unused NTP PPS code
From: john stultz <johnstul@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: George Anzinger <george@mvista.com>, frank@tuxrocks.com,
       Anton Blanchard <anton@samba.org>, benh@kernel.crashing.org,
       Nishanth Aravamudan <nacc@us.ibm.com>,
       Roman Zippel <zippel@linux-m68k.org>
In-Reply-To: <1121482672.25236.33.camel@cog.beaverton.ibm.com>
References: <1121482517.25236.29.camel@cog.beaverton.ibm.com>
	 <1121482620.25236.31.camel@cog.beaverton.ibm.com>
	 <1121482672.25236.33.camel@cog.beaverton.ibm.com>
Content-Type: text/plain
Date: Fri, 15 Jul 2005 19:58:32 -0700
Message-Id: <1121482713.25236.35.camel@cog.beaverton.ibm.com>
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


linux-2.6.13-rc3_timeofday-ntp-part3_B4.patch
============================================
diff --git a/kernel/ntp.c b/kernel/ntp.c
--- a/kernel/ntp.c
+++ b/kernel/ntp.c
@@ -46,26 +46,9 @@ void time_interpolator_update(long delta
 #define time_interpolator_update(x)
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
@@ -307,10 +276,6 @@ int ntp_adjtimex(struct timex *txc)
 	/* Save for later - semantics of adjtime is to return old value */
 	save_adjust = time_next_adjust ? time_next_adjust : time_adjust;
 
-#if 0	/* STA_CLOCKERR is never set yet */
-	time_status &= ~STA_CLOCKERR;		/* reset STA_CLOCKERR */
-#endif
-
 	/* If there are input parameters, then process them */
 	if (txc->modes)	{
 		if (txc->modes & ADJ_STATUS)	/* only set allowed bits */
@@ -322,7 +287,7 @@ int ntp_adjtimex(struct timex *txc)
 				result = -EINVAL;
 				goto leave;
 			}
-			time_freq = txc->freq - pps_freq;
+			time_freq = txc->freq;
 		}
 
 		if (txc->modes & ADJ_MAXERROR) {
@@ -356,11 +321,8 @@ int ntp_adjtimex(struct timex *txc)
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
@@ -415,7 +377,7 @@ int ntp_adjtimex(struct timex *txc)
 					time_freq = time_tolerance;
 				else if (time_freq < -time_tolerance)
 					time_freq = -time_tolerance;
-			} /* STA_PLL || STA_PPSTIME */
+			} /* STA_PLL */
 		} /* txc->modes & ADJ_OFFSET */
 
 		if (txc->modes & ADJ_TICK) {
@@ -425,17 +387,8 @@ int ntp_adjtimex(struct timex *txc)
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
@@ -445,7 +398,7 @@ leave:
 		else
 			txc->offset = time_offset >> SHIFT_UPDATE;
 	}
-	txc->freq = time_freq + pps_freq;
+	txc->freq = time_freq;
 	txc->maxerror = time_maxerror;
 	txc->esterror = time_esterror;
 	txc->status = time_status;
@@ -453,14 +406,17 @@ leave:
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


