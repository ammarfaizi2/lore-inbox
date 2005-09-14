Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932534AbVINSEt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932534AbVINSEt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 14:04:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932564AbVINSEt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 14:04:49 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:45007 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932525AbVINSEs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 14:04:48 -0400
Subject: [RFC][PATCH] NTP shift_right cleanup (v. A1)
From: john stultz <johnstul@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: yoshfuji@linux-ipv6.org, Roman Zippel <zippel@linux-m68k.org>,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>,
       George Anzinger <george@mvista.com>, joe-lkml@rameria.de
Content-Type: text/plain
Date: Wed, 14 Sep 2005 10:48:10 -0700
Message-Id: <1126720091.3455.56.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All,
        Here is the updated and hopefully uncontroversial cleanup for
the NTP code. It uses min/max to simplify some conditionals and creates
a macro shift_right() that avoids the numerous ugly conditionals in the
NTP code that look like:
        
        if(a < 0)
                b = -(-a >> shift);
        else
                b = a >> shift;

Replacing it with:

        b = shift_right(a, shift);

This should have zero effect on the logic, however it should probably
have a bit of testing just to be sure. I've compiled it for alpha, arm,
i386, ppc, ppc64, and s390 and its been running fine on my laptop all
day. It applies against Linus' tree from this morning.

Also Thanks to Ingo Oeser and YOSHIFUJI Hideaki for catching bugs in
earlier releases.

Please let me know if you have any comments or feedback.


thanks
-john

linux-2.6.14-rc1_ntp-shiftr-cleanup_A1.patch
============================================
diff --git a/include/linux/timex.h b/include/linux/timex.h
--- a/include/linux/timex.h
+++ b/include/linux/timex.h
@@ -282,6 +282,13 @@ static inline int ntp_synced(void)
 	return !(time_status & STA_UNSYNC);
 }
 
+/* Required to safely shift negative values */
+#define shift_right(x, s) ({	\
+	__typeof__(x) __x = x;	\
+	__typeof__(s) __s = s;	\
+	(__x < 0) ? (-((-__x) >> (__s))) : ((__x) >> (__s));	\
+})
+
 
 #ifdef CONFIG_TIME_INTERPOLATION
 
diff --git a/kernel/time.c b/kernel/time.c
--- a/kernel/time.c
+++ b/kernel/time.c
@@ -338,30 +338,20 @@ int do_adjtimex(struct timex *txc)
 		        if (mtemp >= MINSEC) {
 			    ltemp = (time_offset / mtemp) << (SHIFT_USEC -
 							      SHIFT_UPDATE);
-			    if (ltemp < 0)
-			        time_freq -= -ltemp >> SHIFT_KH;
-			    else
-			        time_freq += ltemp >> SHIFT_KH;
+			    time_freq += shift_right(ltemp, SHIFT_KH);
 			} else /* calibration interval too short (p. 12) */
 				result = TIME_ERROR;
 		    } else {	/* PLL mode */
 		        if (mtemp < MAXSEC) {
 			    ltemp *= mtemp;
-			    if (ltemp < 0)
-			        time_freq -= -ltemp >> (time_constant +
-							time_constant +
-							SHIFT_KF - SHIFT_USEC);
-			    else
-			        time_freq += ltemp >> (time_constant +
+			    time_freq += shift_right(ltemp,(time_constant +
 						       time_constant +
-						       SHIFT_KF - SHIFT_USEC);
+						       SHIFT_KF - SHIFT_USEC));
 			} else /* calibration interval too long (p. 12) */
 				result = TIME_ERROR;
 		    }
-		    if (time_freq > time_tolerance)
-		        time_freq = time_tolerance;
-		    else if (time_freq < -time_tolerance)
-		        time_freq = -time_tolerance;
+		    time_freq = min(time_freq, time_tolerance);
+		    time_freq = max(time_freq, -time_tolerance);
 		} /* STA_PLL || STA_PPSTIME */
 	    } /* txc->modes & ADJ_OFFSET */
 	    if (txc->modes & ADJ_TICK) {
@@ -384,10 +374,7 @@ leave:	if ((time_status & (STA_UNSYNC|ST
 	if ((txc->modes & ADJ_OFFSET_SINGLESHOT) == ADJ_OFFSET_SINGLESHOT)
 	    txc->offset	   = save_adjust;
 	else {
-	    if (time_offset < 0)
-		txc->offset = -(-time_offset >> SHIFT_UPDATE);
-	    else
-		txc->offset = time_offset >> SHIFT_UPDATE;
+	    txc->offset = shift_right(time_offset, SHIFT_UPDATE);
 	}
 	txc->freq	   = time_freq + pps_freq;
 	txc->maxerror	   = time_maxerror;
diff --git a/kernel/timer.c b/kernel/timer.c
--- a/kernel/timer.c
+++ b/kernel/timer.c
@@ -703,23 +703,13 @@ static void second_overflow(void)
      * the adjustment over not more than the number of
      * seconds between updates.
      */
-    if (time_offset < 0) {
-	ltemp = -time_offset;
-	if (!(time_status & STA_FLL))
-	    ltemp >>= SHIFT_KG + time_constant;
-	if (ltemp > (MAXPHASE / MINSEC) << SHIFT_UPDATE)
-	    ltemp = (MAXPHASE / MINSEC) << SHIFT_UPDATE;
-	time_offset += ltemp;
-	time_adj = -ltemp << (SHIFT_SCALE - SHIFT_HZ - SHIFT_UPDATE);
-    } else {
 	ltemp = time_offset;
 	if (!(time_status & STA_FLL))
-	    ltemp >>= SHIFT_KG + time_constant;
+		ltemp = shift_right(ltemp, SHIFT_KG + time_constant);
 	if (ltemp > (MAXPHASE / MINSEC) << SHIFT_UPDATE)
-	    ltemp = (MAXPHASE / MINSEC) << SHIFT_UPDATE;
+		ltemp = (MAXPHASE / MINSEC) << SHIFT_UPDATE;
 	time_offset -= ltemp;
 	time_adj = ltemp << (SHIFT_SCALE - SHIFT_HZ - SHIFT_UPDATE);
-    }
 
     /*
      * Compute the frequency estimate and additional phase
@@ -736,30 +726,19 @@ static void second_overflow(void)
 			 STA_PPSWANDER | STA_PPSERROR);
     }
     ltemp = time_freq + pps_freq;
-    if (ltemp < 0)
-	time_adj -= -ltemp >>
-	    (SHIFT_USEC + SHIFT_HZ - SHIFT_SCALE);
-    else
-	time_adj += ltemp >>
-	    (SHIFT_USEC + SHIFT_HZ - SHIFT_SCALE);
+    time_adj += shift_right(ltemp,(SHIFT_USEC + SHIFT_HZ - SHIFT_SCALE));
 
 #if HZ == 100
     /* Compensate for (HZ==100) != (1 << SHIFT_HZ).
      * Add 25% and 3.125% to get 128.125; => only 0.125% error (p. 14)
      */
-    if (time_adj < 0)
-	time_adj -= (-time_adj >> 2) + (-time_adj >> 5);
-    else
-	time_adj += (time_adj >> 2) + (time_adj >> 5);
+    time_adj += shift_right(time_adj, 2) + shift_right(time_adj, 5);
 #endif
 #if HZ == 1000
     /* Compensate for (HZ==1000) != (1 << SHIFT_HZ).
      * Add 1.5625% and 0.78125% to get 1023.4375; => only 0.05% error (p. 14)
      */
-    if (time_adj < 0)
-	time_adj -= (-time_adj >> 6) + (-time_adj >> 7);
-    else
-	time_adj += (time_adj >> 6) + (time_adj >> 7);
+    time_adj += shift_right(time_adj, 6) + shift_right(time_adj, 7);
 #endif
 }
 
@@ -778,10 +757,8 @@ static void update_wall_time_one_tick(vo
 	     * Limit the amount of the step to be in the range
 	     * -tickadj .. +tickadj
 	     */
-	     if (time_adjust > tickadj)
-		time_adjust_step = tickadj;
-	     else if (time_adjust < -tickadj)
-		time_adjust_step = -tickadj;
+	     time_adjust_step = min(time_adjust_step, (long)tickadj);
+	     time_adjust_step = max(time_adjust_step, (long)-tickadj);
 
 	    /* Reduce by this step the amount of time left  */
 	    time_adjust -= time_adjust_step;
@@ -792,13 +769,8 @@ static void update_wall_time_one_tick(vo
 	 * advance the tick more.
 	 */
 	time_phase += time_adj;
-	if (time_phase <= -FINENSEC) {
-		long ltemp = -time_phase >> (SHIFT_SCALE - 10);
-		time_phase += ltemp << (SHIFT_SCALE - 10);
-		delta_nsec -= ltemp;
-	}
-	else if (time_phase >= FINENSEC) {
-		long ltemp = time_phase >> (SHIFT_SCALE - 10);
+	if (abs(time_phase) >= FINENSEC) {
+		long ltemp = shift_right(time_phase, (SHIFT_SCALE - 10));
 		time_phase -= ltemp << (SHIFT_SCALE - 10);
 		delta_nsec += ltemp;
 	}


