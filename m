Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263461AbRFREoG>; Mon, 18 Jun 2001 00:44:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263469AbRFREn4>; Mon, 18 Jun 2001 00:43:56 -0400
Received: from axon.amtp.cam.ac.uk ([131.111.16.133]:61874 "EHLO
	axon.amtp.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S263461AbRFREny>; Mon, 18 Jun 2001 00:43:54 -0400
Date: Mon, 18 Jun 2001 05:43:52 +0100 (BST)
Message-Id: <200106180443.FAA15499.declaim.amtp.cam.ac.uk@damtp.cam.ac.uk>
From: Jon Peatfield <J.S.Peatfield@damtp.cam.ac.uk>
To: linux-kernel@vger.kernel.org
Cc: J.S.Peatfield@damtp.cam.ac.uk
Subject: Adjtime patch (to make large offset behavour more like *BSD systems)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is a small patch for the adjtime behavour (strictly adjtimex when
called with ADJ_OFFSET_SINGLESHOT) to make it work more like the
adjtime found in *BSD based kernels where large deltas are allowed to
slew at a greater rate.

In the current Linux code (in 2.2 and 2.4) the slew rate is limited to
500ppm (5us per tick when HZ == 100), which is fine when making small
adjustments, but for larger ones it will take a very long time to take
effect (and one wants to avoid calling settimeofday() to ensure that
the clock is monotonic).  The BSD kernels (well I checked freebsd),
have code to handle large deltas (1000000 us or greater) specially,
allowing a much larger (10 times or 5000ppm), slew.  Of course the BSD
code then spoils it's effort by only moving the time to within one
deltatick of the time we asked for.

I have a small (tested on a dozen machines here for the past few
weeks) patch (against 2.2.19, but the 2.4 patch is fairly trivial to
derive, the code in kernel/sched.c seems to have moved to
kernel/timer.c).

--cut-here--
--- kernel/time.c.orig	Mon May 28 04:12:01 2001
+++ kernel/time.c	Mon May 28 04:19:50 2001
@@ -32,6 +32,10 @@
 
 #include <asm/uaccess.h>
 
+/* Don't completely fail for HZ > 500.  */
+int tickadj = 500/HZ ? : 1;		/* microsecs */
+int bigadj = 1000000;                   /* large adjustment */
+
 /* 
  * The timezone where the local system is located.  Used as a default by some
  * programs who obtain this value by using gettimeofday.
@@ -299,6 +303,11 @@
 		if (txc->modes == ADJ_OFFSET_SINGLESHOT) {
 		    /* adjtime() is independent from ntp_adjtime() */
 		    time_adjust = txc->offset;
+		    if ((time_adjust > bigadj) || (time_adjust < -bigadj)) { /* Big adjust */
+			time_adjust_step = 10 * tickadj ; /* Larger slew rate for big corrections */
+		    } else {
+			time_adjust_step = tickadj ;      /* Max slew rate */
+		    }
 		}
 		else if ( time_status & (STA_PLL | STA_PPSTIME) ) {
 		    ltemp = (time_status & (STA_PPSTIME | STA_PPSSIGNAL)) ==
--- kernel/sched.c.orig	Mon May 28 04:11:53 2001
+++ kernel/sched.c	Mon May 28 04:19:13 2001
@@ -51,9 +51,6 @@
 /* The current time */
 volatile struct timeval xtime __attribute__ ((aligned (16)));
 
-/* Don't completely fail for HZ > 500.  */
-int tickadj = 500/HZ ? : 1;		/* microsecs */
-
 DECLARE_TASK_QUEUE(tq_timer);
 DECLARE_TASK_QUEUE(tq_immediate);
 DECLARE_TASK_QUEUE(tq_scheduler);
@@ -1368,21 +1365,20 @@
 /* in the NTP reference this is called "hardclock()" */
 static void update_wall_time_one_tick(void)
 {
-	if ( (time_adjust_step = time_adjust) != 0 ) {
+	if ( time_adjust != 0 ) {
 	    /* We are doing an adjtime thing. 
 	     *
-	     * Prepare time_adjust_step to be within bounds.
-	     * Note that a positive time_adjust means we want the clock
-	     * to run faster.
-	     *
-	     * Limit the amount of the step to be in the range
-	     * -tickadj .. +tickadj
+	     * Don't overshoot
 	     */
-	     if (time_adjust > tickadj)
-		time_adjust_step = tickadj;
-	     else if (time_adjust < -tickadj)
-		time_adjust_step = -tickadj;
-	     
+	    if (time_adjust > 0) {
+		if (time_adjust_step > time_adjust) {
+		    time_adjust_step = time_adjust;
+		}
+	    } else {
+		if (time_adjust_step < time_adjust) {
+		    time_adjust_step = time_adjust;
+		}
+	    }
 	    /* Reduce by this step the amount of time left  */
 	    time_adjust -= time_adjust_step;
 	}
--- include/linux/timex.h.orig	Sun Jan 21 06:18:30 2001
+++ include/linux/timex.h	Mon May 28 04:25:23 2001
@@ -261,6 +261,7 @@
 extern long time_reftime;	/* time at last adjustment (s) */
 
 extern long time_adjust;	/* The amount of adjtime left */
+extern long time_adjust_step;	/* The skew we are using */
 
 /* interface variables pps->timer interrupt */
 extern long pps_offset;		/* pps time offset (us) */
--cut-here--

As so few things actually use adjtimex in this mode (and even fewer us
it for large deltas) it is unlikely to cause any problems.  The
interface stays the same it just completes the adjustment a bit faster
for large deltas.
-- 
Jon Peatfield,  DAMTP,  Computer Officer,   University of Cambridge
Telephone: +44 1223  3 37852    Mail: J.S.Peatfield@damtp.cam.ac.uk
