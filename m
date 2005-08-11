Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932067AbVHKB1T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932067AbVHKB1T (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Aug 2005 21:27:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932104AbVHKB1T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Aug 2005 21:27:19 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:11468 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S932067AbVHKB1S
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Aug 2005 21:27:18 -0400
Subject: [RFC][PATCH - 4/13] NTP cleanup: Breakup ntp_adjtimex()
From: john stultz <johnstul@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: George Anzinger <george@mvista.com>, frank@tuxrocks.com,
       Anton Blanchard <anton@samba.org>, benh@kernel.crashing.org,
       Nishanth Aravamudan <nacc@us.ibm.com>,
       Roman Zippel <zippel@linux-m68k.org>,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>
In-Reply-To: <1123723578.32330.2.camel@cog.beaverton.ibm.com>
References: <1123723279.30963.267.camel@cog.beaverton.ibm.com>
	 <1123723384.30963.269.camel@cog.beaverton.ibm.com>
	 <1123723534.32330.0.camel@cog.beaverton.ibm.com>
	 <1123723578.32330.2.camel@cog.beaverton.ibm.com>
Content-Type: text/plain
Date: Wed, 10 Aug 2005 18:27:14 -0700
Message-Id: <1123723634.32330.4.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All,
	This patch breaks up the complex nesting of code in ntp_adjtimex() by
creating a ntp_hardupdate() function and simplifying some of the logic.
This also mimics the documented NTP spec somewhat better.

Any comments or feedback would be greatly appreciated.

thanks
-john


linux-2.6.13-rc6_timeofday-ntp-part4_B5.patch
============================================
diff --git a/include/linux/ntp.h b/include/linux/ntp.h
--- a/include/linux/ntp.h
+++ b/include/linux/ntp.h
@@ -9,6 +9,11 @@
 #include <linux/time.h>
 #include <linux/timex.h>
 
+/* Required to safely shift negative values */
+#define shiftR(x, s) ({ __typeof__(x) __x = x;\
+		__typeof__(s) __s = s; \
+		(__x < 0) ? (-((-__x) >> (__s))) : ((__x) >> (__s));})
+
 /* NTP state machine interfaces */
 void ntp_advance(void);
 int ntp_adjtimex(struct timex*);
diff --git a/kernel/ntp.c b/kernel/ntp.c
--- a/kernel/ntp.c
+++ b/kernel/ntp.c
@@ -244,12 +244,79 @@ void second_overflow(void)
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
@@ -321,63 +388,9 @@ int ntp_adjtimex(struct timex *txc)
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


