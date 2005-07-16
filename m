Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262084AbVGPDEg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262084AbVGPDEg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Jul 2005 23:04:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262068AbVGPDCr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Jul 2005 23:02:47 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:48052 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S262063AbVGPDAL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Jul 2005 23:00:11 -0400
Subject: [RFC][PATCH - 5/12] NTP cleanup: Break out leapsecond processing
From: john stultz <johnstul@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: George Anzinger <george@mvista.com>, frank@tuxrocks.com,
       Anton Blanchard <anton@samba.org>, benh@kernel.crashing.org,
       Nishanth Aravamudan <nacc@us.ibm.com>,
       Roman Zippel <zippel@linux-m68k.org>
In-Reply-To: <1121482758.25236.37.camel@cog.beaverton.ibm.com>
References: <1121482517.25236.29.camel@cog.beaverton.ibm.com>
	 <1121482620.25236.31.camel@cog.beaverton.ibm.com>
	 <1121482672.25236.33.camel@cog.beaverton.ibm.com>
	 <1121482713.25236.35.camel@cog.beaverton.ibm.com>
	 <1121482758.25236.37.camel@cog.beaverton.ibm.com>
Content-Type: text/plain
Date: Fri, 15 Jul 2005 20:00:04 -0700
Message-Id: <1121482804.25236.39.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All,
	This patch breaks the leapsecond processing logic into its own
function. By making the NTP code avoid making any direct changes to
time, instead allowing the time code to use NTP to decide when to change
time, we better isolate the NTP subsystem.

Any comments or feedback would be greatly appreciated.

thanks
-john


linux-2.6.13-rc3_timeofday-ntp-part5_B4.patch
============================================
diff --git a/include/linux/ntp.h b/include/linux/ntp.h
--- a/include/linux/ntp.h
+++ b/include/linux/ntp.h
@@ -13,6 +13,7 @@
 int ntp_advance(void);
 int ntp_adjtimex(struct timex*);
 void second_overflow(void);
+int ntp_leapsecond(struct timespec now);
 void ntp_clear(void);
 int ntp_synced(void);
 
diff --git a/kernel/ntp.c b/kernel/ntp.c
--- a/kernel/ntp.c
+++ b/kernel/ntp.c
@@ -40,12 +40,6 @@
 #include <linux/jiffies.h>
 #include <linux/errno.h>
 
-#ifdef CONFIG_TIME_INTERPOLATION
-void time_interpolator_update(long delta_nsec);
-#else
-#define time_interpolator_update(x)
-#endif
-
 /* Don't completely fail for HZ > 500.  */
 int tickadj = 500/HZ ? : 1;		/* microsecs */
 
@@ -69,6 +63,8 @@ static long time_reftime;               
 long time_adjust;
 static long time_next_adjust;
 
+#define SEC_PER_DAY 86400
+
 /* Required to safely shift negative values */
 #define shiftR(x,s) (x < 0) ? (-((-x) >> (s))) : ((x) >> (s))
 
@@ -142,59 +138,6 @@ void second_overflow(void)
 	}
 
 	/*
-	 * Leap second processing. If in leap-insert state at
-	 * the end of the day, the system clock is set back one
-	 * second; if in leap-delete state, the system clock is
-	 * set ahead one second. The microtime() routine or
-	 * external clock driver will insure that reported time
-	 * is always monotonic. The ugly divides should be
-	 * replaced.
-	 */
-	switch (time_state) {
-
-	case TIME_OK:
-		if (time_status & STA_INS)
-			time_state = TIME_INS;
-		else if (time_status & STA_DEL)
-			time_state = TIME_DEL;
-		break;
-
-	case TIME_INS:
-		if (xtime.tv_sec % 86400 == 0) {
-			xtime.tv_sec--;
-			wall_to_monotonic.tv_sec++;
-			/* The timer interpolator will make time change gradually instead
-			 * of an immediate jump by one second.
-			 */
-			time_interpolator_update(-NSEC_PER_SEC);
-			time_state = TIME_OOP;
-			clock_was_set();
-			printk(KERN_NOTICE "Clock: inserting leap second 23:59:60 UTC\n");
-		}
-		break;
-
-	case TIME_DEL:
-		if ((xtime.tv_sec + 1) % 86400 == 0) {
-			xtime.tv_sec++;
-			wall_to_monotonic.tv_sec--;
-			/* Use of time interpolator for a gradual change of time */
-			time_interpolator_update(NSEC_PER_SEC);
-			time_state = TIME_WAIT;
-			clock_was_set();
-			printk(KERN_NOTICE "Clock: deleting leap second 23:59:59 UTC\n");
-		}
-		break;
-
-	case TIME_OOP:
-		time_state = TIME_WAIT;
-		break;
-
-	case TIME_WAIT:
-		if (!(time_status & (STA_INS | STA_DEL)))
-			time_state = TIME_OK;
-	}
-
-	/*
 	 * Compute the phase adjustment for the next second. In
 	 * PLL mode, the offset is reduced by a fixed factor
 	 * times the time constant. In FLL mode the offset is
@@ -438,6 +381,70 @@ leave:
 	return result;
 }
 
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
+		break;
+
+	case TIME_WAIT:
+		if (!(time_status & (STA_INS | STA_DEL)))
+			time_state = TIME_OK;
+	}
+
+	return 0;
+}
+
+
 /**
  * ntp_clear - Clears the NTP state machine.
  *
diff --git a/kernel/timer.c b/kernel/timer.c
--- a/kernel/timer.c
+++ b/kernel/timer.c
@@ -42,7 +42,7 @@
 #include <asm/io.h>
 
 #ifdef CONFIG_TIME_INTERPOLATION
-void time_interpolator_update(long delta_nsec);
+static void time_interpolator_update(long delta_nsec);
 #else
 #define time_interpolator_update(x)
 #endif
@@ -624,9 +624,19 @@ static void update_wall_time(unsigned lo
 		ticks--;
 		update_wall_time_one_tick();
 		if (xtime.tv_nsec >= 1000000000) {
+			int leapsecond;
 			xtime.tv_nsec -= 1000000000;
 			xtime.tv_sec++;
 			second_overflow();
+
+			/* apply leapsecond if appropriate */
+			leapsecond = ntp_leapsecond(xtime);
+			if (leapsecond) {
+				xtime.tv_sec += leapsecond;
+				wall_to_monotonic.tv_sec -= leapsecond;
+				time_interpolator_update(leapsecond * NSEC_PER_SEC);
+				clock_was_set();
+			}
 		}
 	} while (ticks);
 }
@@ -1272,7 +1282,7 @@ unsigned long time_interpolator_get_offs
 #define INTERPOLATOR_ADJUST 65536
 #define INTERPOLATOR_MAX_SKIP 10*INTERPOLATOR_ADJUST
 
-void time_interpolator_update(long delta_nsec)
+static void time_interpolator_update(long delta_nsec)
 {
 	u64 counter;
 	unsigned long offset;


