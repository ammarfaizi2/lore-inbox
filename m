Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318935AbSIIXLe>; Mon, 9 Sep 2002 19:11:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318929AbSIIXLe>; Mon, 9 Sep 2002 19:11:34 -0400
Received: from vti01.vertis.nl ([145.66.4.26]:11017 "EHLO vti01.vertis.nl")
	by vger.kernel.org with ESMTP id <S318923AbSIIXL0>;
	Mon, 9 Sep 2002 19:11:26 -0400
Date: Tue, 10 Sep 2002 01:14:49 +0200
From: Rolf Fokkens <fokkensr@fokkensr.vertis.nl>
Message-Id: <200209092314.g89NEnA05992@fokkensr.vertis.nl>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] USER_HZ & NTP problems
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I've been playing with different HZ values in the 2.4 kernel for a while now,
and apparantly Linus also has decided to introduce a USER_HZ constant (I used
CLOCKS_PER_SEC) while raising the HZ value on x86 to 1000.

On x86 timekeeping has shown to be relative fragile when raising HZ (OK, I
tried HZ=2048 which is quite high) because of the way the interrupt timer is
configured to fire HZ times each second. This is done by configuring a divisor
in the timer chip (LATCH) which divides a certain clock (1193180) and
makes the chip fire interrupts at the resulting frequency.

Now comes the catch: NTP requires a clock accuracy of 500 ppm. For some HZ
values the clock is not accurate enough to meet this requirement, hence NTP
won't work well.

An example HZ value is 1020 which exceeds the 500 ppm requirement. In this case
the best approximation is 1019.8 Hz. the xtime.tv_usec value is raised with
a value of 980 each tick which means that after one second the tv_usec value
has increased with 999404 (should be 1000000) which is an accuracy of 596 ppm.

Some more examples:
  HZ Accuracy (ppm)
---- --------------
 100             17
1000            151
1024            632
2000            687
2008            343
2011             18
2048           1249

What I've been doing is replace tv_usec by tv_nsec, meaning xtime is now a
timespec instead of a timeval. This allows the accuracy to be improved by a
factor of 1000 for any (well ... any?) HZ value.

Of course all kinds of calculations had te be improved as well. The ACTHZ
constantant is introduced to approximate the actual HZ value, it's used to
do some approximations of other related values.

Well, both my problem analysis and the solution may me flawed, but here they
are anyway. (Let the flames begin :-) )

Cheers!

Rolf

diff -ruN linux-2.5.33.orig/arch/i386/kernel/time.c linux-2.5.33/arch/i386/kernel/time.c
--- linux-2.5.33.orig/arch/i386/kernel/time.c	Sun Sep  8 09:00:07 2002
+++ linux-2.5.33/arch/i386/kernel/time.c	Sun Sep  8 18:24:21 2002
@@ -115,7 +115,7 @@
 	return delay_at_last_interrupt + edx;
 }
 
-#define TICK_SIZE tick
+#define TICK_SIZE (tick_nsec / 1000)
 
 spinlock_t i8253_lock = SPIN_LOCK_UNLOCKED;
 EXPORT_SYMBOL(i8253_lock);
@@ -280,7 +280,7 @@
 			usec += lost * (1000000 / HZ);
 	}
 	sec = xtime.tv_sec;
-	usec += xtime.tv_usec;
+	usec += (xtime.tv_nsec / 1000);
 	read_unlock_irqrestore(&xtime_lock, flags);
 
 	while (usec >= 1000000) {
@@ -309,7 +309,8 @@
 		tv->tv_sec--;
 	}
 
-	xtime = *tv;
+	xtime.tv_sec = tv->tv_sec;
+	xtime.tv_nsec = (tv->tv_usec * 1000);
 	time_adjust = 0;		/* stop active adjtime() */
 	time_status |= STA_UNSYNC;
 	time_maxerror = NTP_PHASE_LIMIT;
@@ -437,8 +438,8 @@
 	 */
 	if ((time_status & STA_UNSYNC) == 0 &&
 	    xtime.tv_sec > last_rtc_update + 660 &&
-	    xtime.tv_usec >= 500000 - ((unsigned) tick) / 2 &&
-	    xtime.tv_usec <= 500000 + ((unsigned) tick) / 2) {
+	    (xtime.tv_nsec / 1000) >= 500000 - ((unsigned) TICK_SIZE) / 2 &&
+	    (xtime.tv_nsec / 1000) <= 500000 + ((unsigned) TICK_SIZE) / 2) {
 		if (set_rtc_mmss(xtime.tv_sec) == 0)
 			last_rtc_update = xtime.tv_sec;
 		else
@@ -655,7 +656,7 @@
 	extern int x86_udelay_tsc;
 	
 	xtime.tv_sec = get_cmos_time();
-	xtime.tv_usec = 0;
+	xtime.tv_nsec = 0;
 
 /*
  * If we have APM enabled or the CPU clock speed is variable
diff -ruN linux-2.5.33.orig/fs/udf/udfdecl.h linux-2.5.33/fs/udf/udfdecl.h
--- linux-2.5.33.orig/fs/udf/udfdecl.h	Sun Aug 11 03:41:27 2002
+++ linux-2.5.33/fs/udf/udfdecl.h	Sun Sep  8 18:24:21 2002
@@ -32,7 +32,7 @@
 #define UDF_NAME_LEN		255
 #define UDF_PATH_LEN		1023
 
-#define CURRENT_UTIME	(xtime.tv_usec)
+#define CURRENT_UTIME	(xtime.tv_nsec / 1000)
 
 #define udf_file_entry_alloc_offset(inode)\
 	((UDF_I_EXTENDED_FE(inode) ?\
diff -ruN linux-2.5.33.orig/include/linux/time.h linux-2.5.33/include/linux/time.h
--- linux-2.5.33.orig/include/linux/time.h	Sun Aug 11 03:41:42 2002
+++ linux-2.5.33/include/linux/time.h	Sun Sep  8 18:24:21 2002
@@ -113,7 +113,7 @@
 	)*60 + sec; /* finally seconds */
 }
 
-extern struct timeval xtime;
+extern struct timespec xtime;
 
 #define CURRENT_TIME (xtime.tv_sec)
 
diff -ruN linux-2.5.33.orig/include/linux/timex.h linux-2.5.33/include/linux/timex.h
--- linux-2.5.33.orig/include/linux/timex.h	Sun Aug 11 03:41:18 2002
+++ linux-2.5.33/include/linux/timex.h	Sun Sep  8 18:24:21 2002
@@ -155,6 +155,28 @@
 /* LATCH is used in the interval timer and ftape setup. */
 #define LATCH  ((CLOCK_TICK_RATE + HZ/2) / HZ)	/* For divider */
 
+/* Suppose we want to devide two numbers NOM and DEN: NOM/DEN, the we can
+ * improve accuracy by shifting LSH bits, hence calculating:
+ *     (NOM << LSH) / DEN
+ * This however means trouble for large NOM, because (NOM << LSH) may no
+ * longer fit in 32 bits. The following way of calculating this gives us
+ * some slack, under the following onditions:
+ *   - (NOM / DEN) fits in (32 - LSH) bits.
+ *   - (NOM % DEN) fits in (32 - LSH) bits.
+ */
+#define SH_DIV(NOM,DEN,LSH) (   ((NOM / DEN) << LSH)                    \
+                             + (((NOM % DEN) << LSH) + DEN / 2) / DEN)
+
+/* HZ is the requested value. ACTHZ is actual HZ ("<< 8" is for accuracy) */
+#define ACTHZ (SH_DIV (CLOCK_TICK_RATE, LATCH, 8))
+
+/* TICK_USEC is the time between ticks in usec assuming fake USER_HZ */
+#define TICK_USEC ((1000000UL + USER_HZ/2) / USER_HZ)
+
+/* TICK_NSEC is the time between ticks in nsec assuming real ACTHZ and	*/
+/* a value TUSEC for TICK_USEC (can be set bij adjtimex)		*/
+#define TICK_NSEC(TUSEC) (SH_DIV (TUSEC * USER_HZ * 1000, ACTHZ, 8))
+
 /*
  * syscall interface - used (mainly by NTP daemon)
  * to discipline kernel clock oscillator
@@ -251,7 +273,8 @@
  * Note: maximum error = NTP synch distance = dispersion + delay / 2;
  * estimated error = NTP dispersion.
  */
-extern long tick;                      /* timer interrupt period */
+extern unsigned long tick_usec;		/* USER_HZ period (usec) */
+extern unsigned long tick_nsec;		/* ACTHZ          period (nsec) */
 extern int tickadj;			/* amount of adjustment per tick */
 
 /*
diff -ruN linux-2.5.33.orig/kernel/time.c linux-2.5.33/kernel/time.c
--- linux-2.5.33.orig/kernel/time.c	Sun Aug 11 03:41:23 2002
+++ linux-2.5.33/kernel/time.c	Sun Sep  8 18:25:59 2002
@@ -82,7 +82,7 @@
 		return -EFAULT;
 	write_lock_irq(&xtime_lock);
 	xtime.tv_sec = value;
-	xtime.tv_usec = 0;
+	xtime.tv_nsec = 0;
 	last_time_offset = 0;
 	time_adjust = 0;	/* stop active adjtime() */
 	time_status |= STA_UNSYNC;
@@ -231,7 +231,8 @@
 
 	/* if the quartz is off by more than 10% something is VERY wrong ! */
 	if (txc->modes & ADJ_TICK)
-		if (txc->tick < 900000/HZ || txc->tick > 1100000/HZ)
+		if (txc->tick <  900000/USER_HZ ||
+		    txc->tick > 1100000/USER_HZ)
 			return -EINVAL;
 
 	write_lock_irq(&xtime_lock);
@@ -344,13 +345,8 @@
 		} /* STA_PLL || STA_PPSTIME */
 	    } /* txc->modes & ADJ_OFFSET */
 	    if (txc->modes & ADJ_TICK) {
-		/* if the quartz is off by more than 10% something is
-		   VERY wrong ! */
-		if (txc->tick < 900000/HZ || txc->tick > 1100000/HZ) {
-		    result = -EINVAL;
-		    goto leave;
-		}
-		tick = txc->tick;
+		tick_usec = txc->tick;
+		tick_nsec = TICK_NSEC(tick_usec);
 	    }
 	} /* txc->modes */
 leave:	if ((time_status & (STA_UNSYNC|STA_CLOCKERR)) != 0
@@ -380,7 +376,7 @@
 	txc->constant	   = time_constant;
 	txc->precision	   = time_precision;
 	txc->tolerance	   = time_tolerance;
-	txc->tick	   = tick;
+	txc->tick	   = tick_usec;
 	txc->ppsfreq	   = pps_freq;
 	txc->jitter	   = pps_jitter >> PPS_AVG;
 	txc->shift	   = pps_shift;
diff -ruN linux-2.5.33.orig/kernel/timer.c linux-2.5.33/kernel/timer.c
--- linux-2.5.33.orig/kernel/timer.c	Sun Aug 11 03:41:25 2002
+++ linux-2.5.33/kernel/timer.c	Sun Sep  8 18:24:21 2002
@@ -33,10 +33,11 @@
  * Timekeeping variables
  */
 
-long tick = (1000000 + HZ/2) / HZ;	/* timer interrupt period */
+unsigned long tick_usec = TICK_USEC; 		/* ACTHZ          period (usec) */
+unsigned long tick_nsec = TICK_NSEC(TICK_USEC);	/* USER_HZ period (nsec) */
 
 /* The current time */
-struct timeval xtime __attribute__ ((aligned (16)));
+struct timespec xtime __attribute__ ((aligned (16)));
 
 /* Don't completely fail for HZ > 500.  */
 int tickadj = 500/HZ ? : 1;		/* microsecs */
@@ -63,7 +64,6 @@
 long time_reftime;			/* time at last adjustment (s)	*/
 
 long time_adjust;
-long time_adjust_step;
 
 unsigned long event;
 
@@ -465,6 +465,8 @@
 /* in the NTP reference this is called "hardclock()" */
 static void update_wall_time_one_tick(void)
 {
+	long time_adjust_step;
+
 	if ( (time_adjust_step = time_adjust) != 0 ) {
 	    /* We are doing an adjtime thing. 
 	     *
@@ -483,21 +485,21 @@
 	    /* Reduce by this step the amount of time left  */
 	    time_adjust -= time_adjust_step;
 	}
-	xtime.tv_usec += tick + time_adjust_step;
+	xtime.tv_nsec += tick_nsec + time_adjust_step * 1000;
 	/*
 	 * Advance the phase, once it gets to one microsecond, then
 	 * advance the tick more.
 	 */
 	time_phase += time_adj;
 	if (time_phase <= -FINEUSEC) {
-		long ltemp = -time_phase >> SHIFT_SCALE;
-		time_phase += ltemp << SHIFT_SCALE;
-		xtime.tv_usec -= ltemp;
+		long ltemp = -time_phase >> (SHIFT_SCALE - 10);
+		time_phase += ltemp << (SHIFT_SCALE - 10);
+		xtime.tv_nsec -= ltemp;
 	}
 	else if (time_phase >= FINEUSEC) {
-		long ltemp = time_phase >> SHIFT_SCALE;
-		time_phase -= ltemp << SHIFT_SCALE;
-		xtime.tv_usec += ltemp;
+		long ltemp = time_phase >> (SHIFT_SCALE - 10);
+		time_phase -= ltemp << (SHIFT_SCALE - 10);
+		xtime.tv_nsec += ltemp;
 	}
 }
 
@@ -515,8 +517,8 @@
 		update_wall_time_one_tick();
 	} while (ticks);
 
-	if (xtime.tv_usec >= 1000000) {
-	    xtime.tv_usec -= 1000000;
+	if (xtime.tv_nsec >= 1000000000) {
+	    xtime.tv_nsec -= 1000000000;
 	    xtime.tv_sec++;
 	    second_overflow();
 	}
