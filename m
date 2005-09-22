Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030286AbVIVUAI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030286AbVIVUAI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 16:00:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030303AbVIVUAH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 16:00:07 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:37523 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030286AbVIVUAB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 16:00:01 -0400
Subject: [RFC][PATCH 2/2] Reduced NTP rework (part 2)
From: john stultz <johnstul@us.ibm.com>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: lkml <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
       George Anzinger <george@mvista.com>,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>
In-Reply-To: <1127419120.8195.7.camel@cog.beaverton.ibm.com>
References: <1127419120.8195.7.camel@cog.beaverton.ibm.com>
Content-Type: text/plain
Date: Thu, 22 Sep 2005 12:59:58 -0700
Message-Id: <1127419198.8195.10.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roman, All,

	Here is the second of two patches which try a minimized version of my
ntp rework patches. 
	
This patch further changes the interrupt time NTP code, breaking out the
leapsecond processing and introduces an accessor to a shifted ppm
adjustment value.  

Again, this patch should not affect the existing behavior, but just
separate the logical functionality so it can be re-used by my timeofday
patches.

thanks
-john

linux-2.6.14-rc2_timeofday-ntp-part2_B6test.patch
============================================
diff --git a/kernel/timer.c b/kernel/timer.c
--- a/kernel/timer.c
+++ b/kernel/timer.c
@@ -620,6 +620,78 @@ static long time_adj;			/* tick adjust (
 long time_reftime;			/* time at last adjustment (s)	*/
 long time_adjust;
 long time_next_adjust;
+long time_adjust_step;	/* per tick time_adjust step */
+
+long total_sppm;	/* shifted ppm sum of all NTP adjustments */
+long offset_adj_ppm;
+long tick_adj_ppm;
+long singleshot_adj_ppm;
+
+#define MAX_SINGLESHOT_ADJ 500 /* (ppm) */
+#define SEC_PER_DAY 86400
+
+/**
+ * ntp_leapsecond - NTP leapsecond processing code.
+ * now: the current time
+ *
+ * Returns the number of seconds (-1, 0, or 1) that
+ * should be added to the current time to properly
+ * adjust for leapseconds.
+ */
+int ntp_leapsecond(struct timespec now)
+{
+	/*
+	 * Leap second processing. If in leap-insert state at
+	 * the end of the day, the system clock is set back one
+	 * second; if in leap-delete state, the system clock is
+	 * set ahead one second.
+	 */
+	static time_t leaptime = 0;
+
+	switch (time_state) {
+
+	case TIME_OK:
+		if (time_status & STA_INS)
+			time_state = TIME_INS;
+		else if (time_status & STA_DEL)
+			time_state = TIME_DEL;
+
+		/* calculate end of today (23:59:59)*/
+		leaptime = now.tv_sec + SEC_PER_DAY -
+					(now.tv_sec % SEC_PER_DAY) - 1;
+		break;
+
+	case TIME_INS:
+		/* Once we are at (or past) leaptime, insert the second */
+		if (now.tv_sec >= leaptime) {
+			time_state = TIME_OOP;
+			printk(KERN_NOTICE "Clock: inserting leap second 23:59:60 UTC\n");
+			return -1;
+		}
+		break;
+
+	case TIME_DEL:
+		/* Once we are at (or past) leaptime, delete the second */
+		if (now.tv_sec >= leaptime) {
+			time_state = TIME_WAIT;
+			printk(KERN_NOTICE "Clock: deleting leap second 23:59:59 UTC\n");
+			return 1;
+		}
+		break;
+
+	case TIME_OOP:
+		/*  Wait for the end of the leap second*/
+		if (now.tv_sec > (leaptime + 1))
+			time_state = TIME_WAIT;
+		time_state = TIME_WAIT;
+		break;
+
+	case TIME_WAIT:
+		if (!(time_status & (STA_INS | STA_DEL)))
+			time_state = TIME_OK;
+	}
+	return 0;
+}
 
 /*
  * this routine handles the overflow of the microsecond field
@@ -642,59 +714,6 @@ static void second_overflow(void)
     }
 
     /*
-     * Leap second processing. If in leap-insert state at
-     * the end of the day, the system clock is set back one
-     * second; if in leap-delete state, the system clock is
-     * set ahead one second. The microtime() routine or
-     * external clock driver will insure that reported time
-     * is always monotonic. The ugly divides should be
-     * replaced.
-     */
-    switch (time_state) {
-
-    case TIME_OK:
-	if (time_status & STA_INS)
-	    time_state = TIME_INS;
-	else if (time_status & STA_DEL)
-	    time_state = TIME_DEL;
-	break;
-
-    case TIME_INS:
-	if (xtime.tv_sec % 86400 == 0) {
-	    xtime.tv_sec--;
-	    wall_to_monotonic.tv_sec++;
-	    /* The timer interpolator will make time change gradually instead
-	     * of an immediate jump by one second.
-	     */
-	    time_interpolator_update(-NSEC_PER_SEC);
-	    time_state = TIME_OOP;
-	    clock_was_set();
-	    printk(KERN_NOTICE "Clock: inserting leap second 23:59:60 UTC\n");
-	}
-	break;
-
-    case TIME_DEL:
-	if ((xtime.tv_sec + 1) % 86400 == 0) {
-	    xtime.tv_sec++;
-	    wall_to_monotonic.tv_sec--;
-	    /* Use of time interpolator for a gradual change of time */
-	    time_interpolator_update(NSEC_PER_SEC);
-	    time_state = TIME_WAIT;
-	    clock_was_set();
-	    printk(KERN_NOTICE "Clock: deleting leap second 23:59:59 UTC\n");
-	}
-	break;
-
-    case TIME_OOP:
-	time_state = TIME_WAIT;
-	break;
-
-    case TIME_WAIT:
-	if (!(time_status & (STA_INS | STA_DEL)))
-	    time_state = TIME_OK;
-    }
-
-    /*
      * Compute the phase adjustment for the next second. In
      * PLL mode, the offset is reduced by a fixed factor
      * times the time constant. In FLL mode the offset is
@@ -711,6 +730,13 @@ static void second_overflow(void)
 	time_offset -= ltemp;
 	time_adj = ltemp << (SHIFT_SCALE - SHIFT_HZ - SHIFT_UPDATE);
 
+	offset_adj_ppm = shift_right(ltemp, SHIFT_UPDATE); /* ppm */
+
+	/* first calculate usec/user_tick offset */
+	tick_adj_ppm = ((USEC_PER_SEC + USER_HZ/2)/USER_HZ) - tick_usec;
+	/* multiply by user_hz to get usec/sec => ppm */
+	tick_adj_ppm *= USER_HZ;
+
     /*
      * Compute the frequency estimate and additional phase
      * adjustment due to frequency error for the next
@@ -742,9 +768,17 @@ static void second_overflow(void)
 #endif
 }
 
-long time_adjust_step;
 
-static void ntp_advance(unsigned long interval_ns)
+/**
+ * ntp_get_ppm_adjustment - Returns Shifted PPM adjustment
+ *
+ */
+long ntp_get_ppm_adjustment(void)
+{
+	return total_sppm;
+}
+
+void ntp_advance(unsigned long interval_ns)
 {
 	static unsigned long interval_sum;
 
@@ -772,6 +806,7 @@ static void ntp_advance(unsigned long in
 		}
 		interval_ns -= tick_nsec;
 	}
+	singleshot_adj_ppm = time_adjust_step*(1000000/HZ); /* usec/tick => ppm */
 
 	/* Changes by adjtime() do not take effect till next tick. */
 	if (time_next_adjust) {
@@ -783,6 +818,12 @@ static void ntp_advance(unsigned long in
 		interval_sum -= NSEC_PER_SEC;
 		second_overflow();
 	}
+
+	/* calculate the total continuous ppm adjustment */
+	total_sppm = time_freq; /* already shifted by SHIFT_USEC */
+	total_sppm += offset_adj_ppm << SHIFT_USEC;
+	total_sppm += tick_adj_ppm << SHIFT_USEC;
+	total_sppm += singleshot_adj_ppm << SHIFT_USEC;
 }
 
 /*
@@ -817,8 +858,18 @@ static void update_wall_time(unsigned lo
 
 		xtime.tv_nsec += delta_nsec;
 		if (xtime.tv_nsec >= 1000000000) {
+			int leapsecond;
 			xtime.tv_nsec -= 1000000000;
 			xtime.tv_sec++;
+			/* process leapsecond */
+			leapsecond = ntp_leapsecond(xtime);
+			if (leapsecond) {
+				xtime.tv_sec += leapsecond;
+				wall_to_monotonic.tv_sec -= leapsecond;
+				/* Use of time interpolator for a gradual change of time */
+				time_interpolator_update(leapsecond*NSEC_PER_SEC);
+				clock_was_set();
+			}
 		}
 		ntp_advance(tick_nsec);
 		time_interpolator_update(delta_nsec);


