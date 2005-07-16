Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262102AbVGPDKL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262102AbVGPDKL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Jul 2005 23:10:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262161AbVGPDHe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Jul 2005 23:07:34 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:9625 "EHLO e33.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S262063AbVGPDFH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Jul 2005 23:05:07 -0400
Subject: [RFC][PATCH - 8/12] NTP cleanup: Integrate second_overflow() logic
From: john stultz <johnstul@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: George Anzinger <george@mvista.com>, frank@tuxrocks.com,
       Anton Blanchard <anton@samba.org>, benh@kernel.crashing.org,
       Nishanth Aravamudan <nacc@us.ibm.com>,
       Roman Zippel <zippel@linux-m68k.org>
In-Reply-To: <1121483064.28638.0.camel@cog.beaverton.ibm.com>
References: <1121482517.25236.29.camel@cog.beaverton.ibm.com>
	 <1121482620.25236.31.camel@cog.beaverton.ibm.com>
	 <1121482672.25236.33.camel@cog.beaverton.ibm.com>
	 <1121482713.25236.35.camel@cog.beaverton.ibm.com>
	 <1121482758.25236.37.camel@cog.beaverton.ibm.com>
	 <1121482804.25236.39.camel@cog.beaverton.ibm.com>
	 <1121482925.25236.42.camel@cog.beaverton.ibm.com>
	 <1121483064.28638.0.camel@cog.beaverton.ibm.com>
Content-Type: text/plain
Date: Fri, 15 Jul 2005 20:05:01 -0700
Message-Id: <1121483101.28638.2.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All,
	This patch removes the second_overflow() logic integrating it into the
ntp_advance() function. This provides a single interface to advance the
internal NTP state machine.

Any comments or feedback would be greatly appreciated.

thanks
-john


linux-2.6.13-rc3_timeofday-ntp-part8_B4.patch
============================================
diff --git a/include/linux/ntp.h b/include/linux/ntp.h
--- a/include/linux/ntp.h
+++ b/include/linux/ntp.h
@@ -10,9 +10,8 @@
 #include <linux/timex.h>
 
 /* NTP state machine interfaces */
-int ntp_advance(void);
+int ntp_advance(unsigned long interval_nsec);
 int ntp_adjtimex(struct timex*);
-void second_overflow(void);
 int ntp_leapsecond(struct timespec now);
 void ntp_clear(void);
 int ntp_synced(void);
diff --git a/kernel/ntp.c b/kernel/ntp.c
--- a/kernel/ntp.c
+++ b/kernel/ntp.c
@@ -30,6 +30,11 @@
 *  http://www.eecis.udel.edu/~mills/database/rfc/rfc1589.txt
 *  http://www.eecis.udel.edu/~mills/database/reports/kern/kernb.pdf
 *
+* The tricky bits of code to handle the accurate clock support
+* were provided by Dave Mills (Mills@UDEL.EDU) of NTP fame.
+* They were originally developed for SUN and DEC kernels.
+* All the kudos should go to Dave for this stuff.
+*
 * NOTE:	To simplify the code, we do not implement any of
 * the PPS code, as the code that uses it never was merged.
 *                             -johnstul@us.ibm.com
@@ -68,10 +73,69 @@ static long time_next_adjust;
 /* Required to safely shift negative values */
 #define shiftR(x,s) (x < 0) ? (-((-x) >> (s))) : ((x) >> (s))
 
-int ntp_advance(void)
+int ntp_advance(unsigned long interval_nsec)
 {
+	static unsigned long interval_sum = 0;
 	long time_adjust_step, delta_nsec;
 
+
+	/* Some components of the NTP state machine are advanced
+	 * in full second increments (this is a hold-over from
+	 * the old second_overflow() code)
+	 *
+	 * XXX - I'd prefer to smoothly apply this math at each
+	 * call to ntp_advance() rather then each second.
+	 */
+	interval_sum += interval_nsec;
+	while (interval_sum > NSEC_PER_SEC) {
+		long next_adj;
+		interval_sum -= NSEC_PER_SEC;
+
+		/* Bump the maxerror field */
+		time_maxerror += time_tolerance >> SHIFT_USEC;
+		if ( time_maxerror > NTP_PHASE_LIMIT ) {
+			time_maxerror = NTP_PHASE_LIMIT;
+			time_status |= STA_UNSYNC;
+		}
+
+		/*
+		 * Compute the phase adjustment for the next second. In
+		 * PLL mode, the offset is reduced by a fixed factor
+		 * times the time constant. In FLL mode the offset is
+		 * used directly. In either mode, the maximum phase
+		 * adjustment for each second is clamped so as to spread
+		 * the adjustment over not more than the number of
+		 * seconds between updates.
+		 */
+		next_adj = time_offset;
+		if (!(time_status & STA_FLL))
+			next_adj = shiftR(next_adj, SHIFT_KG + time_constant);
+		next_adj = min(next_adj, (MAXPHASE / MINSEC) << SHIFT_UPDATE);
+		next_adj = max(next_adj, -(MAXPHASE / MINSEC) << SHIFT_UPDATE);
+		time_offset -= next_adj;
+
+		time_adj = next_adj << (SHIFT_SCALE - SHIFT_HZ - SHIFT_UPDATE);
+
+		time_adj += shiftR(time_freq, (SHIFT_USEC + SHIFT_HZ - SHIFT_SCALE));
+
+#if HZ == 100
+    	/* Compensate for (HZ==100) != (1 << SHIFT_HZ).
+	     * Add 25% and 3.125% to get 128.125;
+		 * => only 0.125% error (p. 14)
+    	 */
+		time_adj += shiftR(time_adj,2) + shiftR(time_adj,5);
+#endif
+#if HZ == 1000
+	    /* Compensate for (HZ==1000) != (1 << SHIFT_HZ).
+    	 * Add 1.5625% and 0.78125% to get 1023.4375;
+		 * => only 0.05% error (p. 14)
+	     */
+		time_adj += shiftR(time_adj,6) + shiftR(time_adj,7);
+#endif
+
+	}
+
+
 	if ( (time_adjust_step = time_adjust) != 0 ) {
 	    /* We are doing an adjtime thing.
 	     *
@@ -116,71 +180,6 @@ int ntp_advance(void)
 	return delta_nsec;
 }
 
-
-/*
- * this routine handles the overflow of the microsecond field
- *
- * The tricky bits of code to handle the accurate clock support
- * were provided by Dave Mills (Mills@UDEL.EDU) of NTP fame.
- * They were originally developed for SUN and DEC kernels.
- * All the kudos should go to Dave for this stuff.
- *
- */
-void second_overflow(void)
-{
-	long ltemp;
-
-	/* Bump the maxerror field */
-	time_maxerror += time_tolerance >> SHIFT_USEC;
-	if ( time_maxerror > NTP_PHASE_LIMIT ) {
-		time_maxerror = NTP_PHASE_LIMIT;
-		time_status |= STA_UNSYNC;
-	}
-
-	/*
-	 * Compute the phase adjustment for the next second. In
-	 * PLL mode, the offset is reduced by a fixed factor
-	 * times the time constant. In FLL mode the offset is
-	 * used directly. In either mode, the maximum phase
-	 * adjustment for each second is clamped so as to spread
-	 * the adjustment over not more than the number of
-	 * seconds between updates.
-	 */
-	if (time_offset < 0) {
-		ltemp = -time_offset;
-		if (!(time_status & STA_FLL))
-			ltemp >>= SHIFT_KG + time_constant;
-		if (ltemp > (MAXPHASE / MINSEC) << SHIFT_UPDATE)
-			ltemp = (MAXPHASE / MINSEC) << SHIFT_UPDATE;
-		time_offset += ltemp;
-		time_adj = -ltemp << (SHIFT_SCALE - SHIFT_HZ - SHIFT_UPDATE);
-	} else {
-		ltemp = time_offset;
-		if (!(time_status & STA_FLL))
-			ltemp >>= SHIFT_KG + time_constant;
-		if (ltemp > (MAXPHASE / MINSEC) << SHIFT_UPDATE)
-			ltemp = (MAXPHASE / MINSEC) << SHIFT_UPDATE;
-		time_offset -= ltemp;
-		time_adj = ltemp << (SHIFT_SCALE - SHIFT_HZ - SHIFT_UPDATE);
-	}
-
-	ltemp = time_freq;
-	time_adj += shiftR(ltemp, (SHIFT_USEC + SHIFT_HZ - SHIFT_SCALE));
-
-#if HZ == 100
-    /* Compensate for (HZ==100) != (1 << SHIFT_HZ).
-     * Add 25% and 3.125% to get 128.125; => only 0.125% error (p. 14)
-     */
-	time_adj += shiftR(time_adj,2) + shiftR(time_adj,5);
-#endif
-#if HZ == 1000
-    /* Compensate for (HZ==1000) != (1 << SHIFT_HZ).
-     * Add 1.5625% and 0.78125% to get 1023.4375; => only 0.05% error (p. 14)
-     */
-	time_adj += shiftR(time_adj,6) + shiftR(time_adj,7);
-#endif
-}
-
 /**
  * ntp_hardupdate - Calculates the offset and freq values
  * offset: current offset
diff --git a/kernel/timer.c b/kernel/timer.c
--- a/kernel/timer.c
+++ b/kernel/timer.c
@@ -604,7 +604,7 @@ static void update_wall_time_one_tick(vo
 {
 	long delta_nsec;
 
-	delta_nsec = tick_nsec + ntp_advance();
+	delta_nsec = tick_nsec + ntp_advance(tick_nsec);
 
 	xtime.tv_nsec += delta_nsec;
 	time_interpolator_update(delta_nsec);
@@ -627,7 +627,6 @@ static void update_wall_time(unsigned lo
 			int leapsecond;
 			xtime.tv_nsec -= 1000000000;
 			xtime.tv_sec++;
-			second_overflow();
 
 			/* apply leapsecond if appropriate */
 			leapsecond = ntp_leapsecond(xtime);


