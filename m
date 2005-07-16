Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262048AbVGPDC2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262048AbVGPDC2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Jul 2005 23:02:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262061AbVGPDAK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Jul 2005 23:00:10 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:63155 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S262063AbVGPC71
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Jul 2005 22:59:27 -0400
Subject: [RFC][PATCH - 4/12] NTP cleanup: Breakup ntp_adjtimex()
From: john stultz <johnstul@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: George Anzinger <george@mvista.com>, frank@tuxrocks.com,
       Anton Blanchard <anton@samba.org>, benh@kernel.crashing.org,
       Nishanth Aravamudan <nacc@us.ibm.com>,
       Roman Zippel <zippel@linux-m68k.org>
In-Reply-To: <1121482713.25236.35.camel@cog.beaverton.ibm.com>
References: <1121482517.25236.29.camel@cog.beaverton.ibm.com>
	 <1121482620.25236.31.camel@cog.beaverton.ibm.com>
	 <1121482672.25236.33.camel@cog.beaverton.ibm.com>
	 <1121482713.25236.35.camel@cog.beaverton.ibm.com>
Content-Type: text/plain
Date: Fri, 15 Jul 2005 19:59:18 -0700
Message-Id: <1121482758.25236.37.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All,
	This patch breaks up the complex nesting of code in ntp_adjtimex() by
creating a ntp_hardupdate() function and simplifying some of the logic.
This also follows the documented NTP spec somewhat better.

Any comments or feedback would be greatly appreciated.

thanks
-john


linux-2.6.13-rc3_timeofday-ntp-part4_B4.patch
============================================
diff --git a/kernel/ntp.c b/kernel/ntp.c
--- a/kernel/ntp.c
+++ b/kernel/ntp.c
@@ -69,6 +69,9 @@ static long time_reftime;               
 long time_adjust;
 static long time_next_adjust;
 
+/* Required to safely shift negative values */
+#define shiftR(x,s) (x < 0) ? (-((-x) >> (s))) : ((x) >> (s))
+
 int ntp_advance(void)
 {
 	long time_adjust_step, delta_nsec;
@@ -244,12 +247,79 @@ void second_overflow(void)
 #endif
 }
 
+/**
+ * ntp_hardupdate - Calculates the offset and freq values
+ * offset: current offset
+ * tv: timeval holding the current time
+ *
+ * Private function, called only by ntp_adjtimex
+ *
+ * This function is called when an offset adjustment is requested.
+ * It calculates the offset adjustment and manipulates the
+ * frequency adjustement accordingly.
+ */
+static int ntp_hardupdate(long offset, struct timespec tv)
+{
+	int ret;
+	long current_offset, interval;
+
+	ret = 0;
+	if (!(time_status & STA_PLL))
+		return ret;
+
+	current_offset = offset;
+	/* Make sure offset is bounded by MAXPHASE */
+	current_offset = min(current_offset, MAXPHASE);
+	current_offset = max(current_offset, -MAXPHASE);
+	time_offset = current_offset << SHIFT_UPDATE;
+
+	if (time_status & STA_FREQHOLD || time_reftime == 0)
+		time_reftime = tv.tv_sec;
+
+	/* calculate seconds since last call to hardupdate */
+	interval = tv.tv_sec - time_reftime;
+	time_reftime = tv.tv_sec;
+
+	/*
+	 * Select whether the frequency is to be controlled
+	 * and in which mode (PLL or FLL). Clamp to the operating
+	 * range. Ugly multiply/divide should be replaced someday.
+	 */
+	if ((time_status & STA_FLL) && (interval >= MINSEC)) {
+		long offset_ppm;
+
+		offset_ppm = time_offset / interval;
+		offset_ppm <<= (SHIFT_USEC - SHIFT_UPDATE);
+
+		time_freq += shiftR(offset_ppm, SHIFT_KH);
+
+	} else if ((time_status & STA_PLL) && (interval < MAXSEC)) {
+		long damping, offset_ppm;
+
+		offset_ppm = offset * interval;
+
+		damping = (2 * time_constant) + SHIFT_KF - SHIFT_USEC;
+
+		time_freq += shiftR(offset_ppm, damping);
+
+	} else { /* calibration interval out of bounds (p. 12) */
+		ret = TIME_ERROR;
+	}
+
+	/* bound time_freq */
+	time_freq = min(time_freq, time_tolerance);
+	time_freq = max(time_freq, -time_tolerance);
+
+	return ret;
+}
+
+
 /* adjtimex mainly allows reading (and writing, if superuser) of
  * kernel time-keeping variables. used by xntpd.
  */
 int ntp_adjtimex(struct timex *txc)
 {
-	long ltemp, mtemp, save_adjust;
+	long save_adjust;
 	int result;
 
 	/* Now we validate the data before disabling interrupts */
@@ -321,63 +391,9 @@ int ntp_adjtimex(struct timex *txc)
 				/* adjtime() is independent from ntp_adjtime() */
 				if ((time_next_adjust = txc->offset) == 0)
 					time_adjust = 0;
-			} else if (time_status & STA_PLL) {
-				ltemp = txc->offset;
-
-				/*
-				 * Scale the phase adjustment and
-				 * clamp to the operating range.
-				 */
-				if (ltemp > MAXPHASE)
-					time_offset = MAXPHASE << SHIFT_UPDATE;
-				else if (ltemp < -MAXPHASE)
-					time_offset = -(MAXPHASE
-							<< SHIFT_UPDATE);
-				else
-					time_offset = ltemp << SHIFT_UPDATE;
-
-				/*
-				 * Select whether the frequency is to be controlled
-				 * and in which mode (PLL or FLL). Clamp to the operating
-				 * range. Ugly multiply/divide should be replaced someday.
-				 */
-
-				if (time_status & STA_FREQHOLD || time_reftime == 0)
-					time_reftime = xtime.tv_sec;
-
-				mtemp = xtime.tv_sec - time_reftime;
-				time_reftime = xtime.tv_sec;
-
-				if (time_status & STA_FLL) {
-					if (mtemp >= MINSEC) {
-						ltemp = (time_offset / mtemp) << (SHIFT_USEC -
-									SHIFT_UPDATE);
-						if (ltemp < 0)
-							time_freq -= -ltemp >> SHIFT_KH;
-						else
-							time_freq += ltemp >> SHIFT_KH;
-					} else /* calibration interval too short (p. 12) */
-						result = TIME_ERROR;
-				} else {	/* PLL mode */
-					if (mtemp < MAXSEC) {
-						ltemp *= mtemp;
-						if (ltemp < 0)
-							time_freq -= -ltemp >> (time_constant +
-									time_constant +
-									SHIFT_KF - SHIFT_USEC);
-					    else
-				    	    time_freq += ltemp >> (time_constant +
-								       time_constant +
-								       SHIFT_KF - SHIFT_USEC);
-					} else /* calibration interval too long (p. 12) */
-						result = TIME_ERROR;
-				}
-
-				if (time_freq > time_tolerance)
-					time_freq = time_tolerance;
-				else if (time_freq < -time_tolerance)
-					time_freq = -time_tolerance;
-			} /* STA_PLL */
+				else if (ntp_hardupdate(txc->offset, xtime))
+					result = TIME_ERROR;
+			}
 		} /* txc->modes & ADJ_OFFSET */
 
 		if (txc->modes & ADJ_TICK) {


