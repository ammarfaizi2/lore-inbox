Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262043AbVGPC5R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262043AbVGPC5R (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Jul 2005 22:57:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262048AbVGPC5R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Jul 2005 22:57:17 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:42894 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S262043AbVGPC5F
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Jul 2005 22:57:05 -0400
Subject: [RFC][PATCH - 1/12] NTP cleanup: Move NTP code into ntp.c
From: john stultz <johnstul@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: George Anzinger <george@mvista.com>, frank@tuxrocks.com,
       Anton Blanchard <anton@samba.org>, benh@kernel.crashing.org,
       Nishanth Aravamudan <nacc@us.ibm.com>,
       Roman Zippel <zippel@linux-m68k.org>
In-Reply-To: <1121482517.25236.29.camel@cog.beaverton.ibm.com>
References: <1121482517.25236.29.camel@cog.beaverton.ibm.com>
Content-Type: text/plain
Date: Fri, 15 Jul 2005 19:57:00 -0700
Message-Id: <1121482620.25236.31.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All,
	This patch moves the generic NTP code from time.c and timer.c into
ntp.c. It makes most of the NTP variables static providing more
understandable interfaces like ntp_synced() and ntp_clear(). 
	
Since some of the newly made static variables are used in arch generic
code, this patch alone will not compile. Thus this patch requires part 2
of the series which fixes the arch specific uses of the newly static
variables.

Any comments or feedback would be greatly appreciated.

thanks
-john


linux-2.6.13-rc3_timeofday-ntp-part1_B4.patch
============================================
diff --git a/include/linux/ntp.h b/include/linux/ntp.h
new file mode 100644
--- /dev/null
+++ b/include/linux/ntp.h
@@ -0,0 +1,28 @@
+/*  linux/include/linux/ntp.h
+ *
+ *  This file NTP state machine accessor functions.
+ */
+
+#ifndef _LINUX_NTP_H
+#define _LINUX_NTP_H
+#include <linux/types.h>
+#include <linux/time.h>
+#include <linux/timex.h>
+
+/* NTP state machine interfaces */
+int ntp_advance(void);
+int ntp_adjtimex(struct timex*);
+void second_overflow(void);
+void ntp_clear(void);
+int ntp_synced(void);
+
+/* Due to ppc64 having its own NTP  code,
+ * these variables cannot be made static just yet
+ */
+extern int tickadj;
+extern long time_offset;
+extern long time_freq;
+extern long time_adjust;
+extern long time_constant;
+
+#endif
diff --git a/include/linux/timex.h b/include/linux/timex.h
--- a/include/linux/timex.h
+++ b/include/linux/timex.h
@@ -226,39 +226,6 @@ struct timex {
  */
 extern unsigned long tick_usec;		/* USER_HZ period (usec) */
 extern unsigned long tick_nsec;		/* ACTHZ          period (nsec) */
-extern int tickadj;			/* amount of adjustment per tick */
-
-/*
- * phase-lock loop variables
- */
-extern int time_state;		/* clock status */
-extern int time_status;		/* clock synchronization status bits */
-extern long time_offset;	/* time adjustment (us) */
-extern long time_constant;	/* pll time constant */
-extern long time_tolerance;	/* frequency tolerance (ppm) */
-extern long time_precision;	/* clock precision (us) */
-extern long time_maxerror;	/* maximum error */
-extern long time_esterror;	/* estimated error */
-
-extern long time_freq;		/* frequency offset (scaled ppm) */
-extern long time_reftime;	/* time at last adjustment (s) */
-
-extern long time_adjust;	/* The amount of adjtime left */
-extern long time_next_adjust;	/* Value for time_adjust at next tick */
-
-/* interface variables pps->timer interrupt */
-extern long pps_offset;		/* pps time offset (us) */
-extern long pps_jitter;		/* time dispersion (jitter) (us) */
-extern long pps_freq;		/* frequency offset (scaled ppm) */
-extern long pps_stabil;		/* frequency dispersion (scaled ppm) */
-extern long pps_valid;		/* pps signal watchdog counter */
-
-/* interface variables pps->adjtimex */
-extern int pps_shift;		/* interval duration (s) (shift) */
-extern long pps_jitcnt;		/* jitter limit exceeded */
-extern long pps_calcnt;		/* calibration intervals */
-extern long pps_errcnt;		/* calibration errors */
-extern long pps_stbcnt;		/* stability limit exceeded */
 
 #ifdef CONFIG_TIME_INTERPOLATION
 
diff --git a/kernel/Makefile b/kernel/Makefile
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -7,7 +7,7 @@ obj-y     = sched.o fork.o exec_domain.o
 	    sysctl.o capability.o ptrace.o timer.o user.o \
 	    signal.o sys.o kmod.o workqueue.o pid.o \
 	    rcupdate.o intermodule.o extable.o params.o posix-timers.o \
-	    kthread.o wait.o kfifo.o sys_ni.o posix-cpu-timers.o
+	    kthread.o wait.o kfifo.o sys_ni.o posix-cpu-timers.o ntp.o
 
 obj-$(CONFIG_FUTEX) += futex.o
 obj-$(CONFIG_GENERIC_ISA_DMA) += dma.o
diff --git a/kernel/ntp.c b/kernel/ntp.c
new file mode 100644
--- /dev/null
+++ b/kernel/ntp.c
@@ -0,0 +1,490 @@
+/********************************************************************
+* linux/kernel/ntp.c
+*
+* NTP state machine and time scaling code.
+*
+* Code moved from kernel/time.c and kernel/timer.c
+* Please see those files for original copyrights.
+*
+* This program is free software; you can redistribute it and/or modify
+* it under the terms of the GNU General Public License as published by
+* the Free Software Foundation; either version 2 of the License, or
+* (at your option) any later version.
+*
+* This program is distributed in the hope that it will be useful,
+* but WITHOUT ANY WARRANTY; without even the implied warranty of
+* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+* GNU General Public License for more details.
+*
+* You should have received a copy of the GNU General Public License
+* along with this program; if not, write to the Free Software
+* Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+*
+* Notes:
+*
+* Hopefully you should never have to understand or touch
+* any of the code below. but don't let that keep you from trying!
+*
+* This code is loosely based on David Mills' RFC 1589 and its
+* updates. Please see the following for more details:
+*  http://www.eecis.udel.edu/~mills/database/rfc/rfc1589.txt
+*  http://www.eecis.udel.edu/~mills/database/reports/kern/kernb.pdf
+*
+* NOTE:	To simplify the code, we do not implement any of
+* the PPS code, as the code that uses it never was merged.
+*                             -johnstul@us.ibm.com
+*
+*********************************************************************/
+
+#include <linux/ntp.h>
+#include <linux/jiffies.h>
+#include <linux/errno.h>
+
+#ifdef CONFIG_TIME_INTERPOLATION
+void time_interpolator_update(long delta_nsec);
+#else
+#define time_interpolator_update(x)
+#endif
+
+
+static long pps_offset;            /* pps time offset (us) */
+static long pps_jitter = MAXTIME;  /* time dispersion (jitter) (us) */
+
+static long pps_freq;              /* frequency offset (scaled ppm) */
+static long pps_stabil = MAXFREQ;  /* frequency dispersion (scaled ppm) */
+
+static long pps_valid = PPS_VALID; /* pps signal watchdog counter */
+
+static int pps_shift = PPS_SHIFT;  /* interval duration (s) (shift) */
+
+static long pps_jitcnt;            /* jitter limit exceeded */
+static long pps_calcnt;            /* calibration intervals */
+static long pps_errcnt;            /* calibration errors */
+static long pps_stbcnt;            /* stability limit exceeded */
+
+/* Don't completely fail for HZ > 500.  */
+int tickadj = 500/HZ ? : 1;		/* microsecs */
+
+
+/*
+ * phase-lock loop variables
+ */
+/* TIME_ERROR prevents overwriting the CMOS clock */
+static int time_state = TIME_OK;              /* clock synchronization status */
+static int time_status = STA_UNSYNC;          /* clock status bits */
+long time_offset;                      /* time adjustment (us) */
+long time_constant = 2;                /* pll time constant */
+static long time_tolerance = MAXFREQ;         /* frequency tolerance (ppm) */
+static long time_precision = 1;               /* clock precision (us) */
+static long time_maxerror = NTP_PHASE_LIMIT;  /* maximum error (us) */
+static long time_esterror = NTP_PHASE_LIMIT;  /* estimated error (us) */
+static long time_phase;                       /* phase offset (scaled us) */
+long time_freq = (((NSEC_PER_SEC + HZ/2) % HZ - HZ/2) << SHIFT_USEC) / NSEC_PER_USEC;
+                                        /* frequency offset (scaled ppm) */
+static long time_adj;                   /* tick adjust (scaled 1 / HZ) */
+static long time_reftime;                      /* time at last adjustment (s) */
+long time_adjust;
+static long time_next_adjust;
+
+int ntp_advance(void)
+{
+	long time_adjust_step, delta_nsec;
+
+	if ( (time_adjust_step = time_adjust) != 0 ) {
+	    /* We are doing an adjtime thing.
+	     *
+	     * Prepare time_adjust_step to be within bounds.
+	     * Note that a positive time_adjust means we want the clock
+	     * to run faster.
+	     *
+	     * Limit the amount of the step to be in the range
+	     * -tickadj .. +tickadj
+	     */
+		if (time_adjust > tickadj)
+			time_adjust_step = tickadj;
+		else if (time_adjust < -tickadj)
+			time_adjust_step = -tickadj;
+
+	    /* Reduce by this step the amount of time left  */
+	    time_adjust -= time_adjust_step;
+	}
+	delta_nsec = time_adjust_step * 1000;
+
+	/*
+	 * Advance the phase, once it gets to one microsecond, then
+	 * advance the tick more.
+	 */
+	time_phase += time_adj;
+	if (time_phase <= -FINENSEC) {
+		long ltemp = -time_phase >> (SHIFT_SCALE - 10);
+		time_phase += ltemp << (SHIFT_SCALE - 10);
+		delta_nsec -= ltemp;
+	} else if (time_phase >= FINENSEC) {
+		long ltemp = time_phase >> (SHIFT_SCALE - 10);
+		time_phase -= ltemp << (SHIFT_SCALE - 10);
+		delta_nsec += ltemp;
+	}
+
+	/* Changes by adjtime() do not take effect till next tick. */
+	if (time_next_adjust != 0) {
+		time_adjust = time_next_adjust;
+		time_next_adjust = 0;
+	}
+
+	return delta_nsec;
+}
+
+
+/*
+ * this routine handles the overflow of the microsecond field
+ *
+ * The tricky bits of code to handle the accurate clock support
+ * were provided by Dave Mills (Mills@UDEL.EDU) of NTP fame.
+ * They were originally developed for SUN and DEC kernels.
+ * All the kudos should go to Dave for this stuff.
+ *
+ */
+void second_overflow(void)
+{
+	long ltemp;
+
+	/* Bump the maxerror field */
+	time_maxerror += time_tolerance >> SHIFT_USEC;
+	if ( time_maxerror > NTP_PHASE_LIMIT ) {
+		time_maxerror = NTP_PHASE_LIMIT;
+		time_status |= STA_UNSYNC;
+	}
+
+	/*
+	 * Leap second processing. If in leap-insert state at
+	 * the end of the day, the system clock is set back one
+	 * second; if in leap-delete state, the system clock is
+	 * set ahead one second. The microtime() routine or
+	 * external clock driver will insure that reported time
+	 * is always monotonic. The ugly divides should be
+	 * replaced.
+	 */
+	switch (time_state) {
+
+	case TIME_OK:
+		if (time_status & STA_INS)
+			time_state = TIME_INS;
+		else if (time_status & STA_DEL)
+			time_state = TIME_DEL;
+		break;
+
+	case TIME_INS:
+		if (xtime.tv_sec % 86400 == 0) {
+			xtime.tv_sec--;
+			wall_to_monotonic.tv_sec++;
+			/* The timer interpolator will make time change gradually instead
+			 * of an immediate jump by one second.
+			 */
+			time_interpolator_update(-NSEC_PER_SEC);
+			time_state = TIME_OOP;
+			clock_was_set();
+			printk(KERN_NOTICE "Clock: inserting leap second 23:59:60 UTC\n");
+		}
+		break;
+
+	case TIME_DEL:
+		if ((xtime.tv_sec + 1) % 86400 == 0) {
+			xtime.tv_sec++;
+			wall_to_monotonic.tv_sec--;
+			/* Use of time interpolator for a gradual change of time */
+			time_interpolator_update(NSEC_PER_SEC);
+			time_state = TIME_WAIT;
+			clock_was_set();
+			printk(KERN_NOTICE "Clock: deleting leap second 23:59:59 UTC\n");
+		}
+		break;
+
+	case TIME_OOP:
+		time_state = TIME_WAIT;
+		break;
+
+	case TIME_WAIT:
+		if (!(time_status & (STA_INS | STA_DEL)))
+			time_state = TIME_OK;
+	}
+
+	/*
+	 * Compute the phase adjustment for the next second. In
+	 * PLL mode, the offset is reduced by a fixed factor
+	 * times the time constant. In FLL mode the offset is
+	 * used directly. In either mode, the maximum phase
+	 * adjustment for each second is clamped so as to spread
+	 * the adjustment over not more than the number of
+	 * seconds between updates.
+	 */
+	if (time_offset < 0) {
+		ltemp = -time_offset;
+		if (!(time_status & STA_FLL))
+			ltemp >>= SHIFT_KG + time_constant;
+		if (ltemp > (MAXPHASE / MINSEC) << SHIFT_UPDATE)
+			ltemp = (MAXPHASE / MINSEC) << SHIFT_UPDATE;
+		time_offset += ltemp;
+		time_adj = -ltemp << (SHIFT_SCALE - SHIFT_HZ - SHIFT_UPDATE);
+	} else {
+		ltemp = time_offset;
+		if (!(time_status & STA_FLL))
+			ltemp >>= SHIFT_KG + time_constant;
+		if (ltemp > (MAXPHASE / MINSEC) << SHIFT_UPDATE)
+			ltemp = (MAXPHASE / MINSEC) << SHIFT_UPDATE;
+		time_offset -= ltemp;
+		time_adj = ltemp << (SHIFT_SCALE - SHIFT_HZ - SHIFT_UPDATE);
+	}
+
+	/*
+	 * Compute the frequency estimate and additional phase
+	 * adjustment due to frequency error for the next
+	 * second. When the PPS signal is engaged, gnaw on the
+	 * watchdog counter and update the frequency computed by
+	 * the pll and the PPS signal.
+	 */
+	pps_valid++;
+	if (pps_valid == PPS_VALID) {	/* PPS signal lost */
+		pps_jitter = MAXTIME;
+		pps_stabil = MAXFREQ;
+		time_status &= ~(STA_PPSSIGNAL | STA_PPSJITTER |
+			STA_PPSWANDER | STA_PPSERROR);
+	}
+	ltemp = time_freq + pps_freq;
+	if (ltemp < 0)
+		time_adj -= -ltemp >> (SHIFT_USEC + SHIFT_HZ - SHIFT_SCALE);
+	else
+		time_adj += ltemp >> (SHIFT_USEC + SHIFT_HZ - SHIFT_SCALE);
+
+#if HZ == 100
+    /* Compensate for (HZ==100) != (1 << SHIFT_HZ).
+     * Add 25% and 3.125% to get 128.125; => only 0.125% error (p. 14)
+     */
+	if (time_adj < 0)
+		time_adj -= (-time_adj >> 2) + (-time_adj >> 5);
+	else
+		time_adj += (time_adj >> 2) + (time_adj >> 5);
+#endif
+#if HZ == 1000
+    /* Compensate for (HZ==1000) != (1 << SHIFT_HZ).
+     * Add 1.5625% and 0.78125% to get 1023.4375; => only 0.05% error (p. 14)
+     */
+	if (time_adj < 0)
+		time_adj -= (-time_adj >> 6) + (-time_adj >> 7);
+	else
+		time_adj += (time_adj >> 6) + (time_adj >> 7);
+#endif
+}
+
+/* adjtimex mainly allows reading (and writing, if superuser) of
+ * kernel time-keeping variables. used by xntpd.
+ */
+int ntp_adjtimex(struct timex *txc)
+{
+	long ltemp, mtemp, save_adjust;
+	int result;
+
+	/* Now we validate the data before disabling interrupts */
+
+	if ((txc->modes & ADJ_OFFSET_SINGLESHOT) == ADJ_OFFSET_SINGLESHOT)
+		/* singleshot must not be used with any other mode bits */
+		if (txc->modes != ADJ_OFFSET_SINGLESHOT)
+			return -EINVAL;
+
+	if (txc->modes != ADJ_OFFSET_SINGLESHOT && (txc->modes & ADJ_OFFSET))
+		/* adjustment Offset limited to +- .512 seconds */
+		if (txc->offset <= - MAXPHASE || txc->offset >= MAXPHASE )
+			return -EINVAL;
+
+	/* if the quartz is off by more than 10% something is VERY wrong ! */
+	if (txc->modes & ADJ_TICK)
+		if (txc->tick <  900000/USER_HZ ||
+				txc->tick > 1100000/USER_HZ)
+			return -EINVAL;
+
+	write_seqlock_irq(&xtime_lock);
+	result = time_state;       /* mostly `TIME_OK' */
+
+	/* Save for later - semantics of adjtime is to return old value */
+	save_adjust = time_next_adjust ? time_next_adjust : time_adjust;
+
+#if 0	/* STA_CLOCKERR is never set yet */
+	time_status &= ~STA_CLOCKERR;		/* reset STA_CLOCKERR */
+#endif
+
+	/* If there are input parameters, then process them */
+	if (txc->modes)	{
+		if (txc->modes & ADJ_STATUS)	/* only set allowed bits */
+			time_status =  (txc->status & ~STA_RONLY) |
+					(time_status & STA_RONLY);
+
+		if (txc->modes & ADJ_FREQUENCY) {	/* p. 22 */
+			if (txc->freq > MAXFREQ || txc->freq < -MAXFREQ) {
+				result = -EINVAL;
+				goto leave;
+			}
+			time_freq = txc->freq - pps_freq;
+		}
+
+		if (txc->modes & ADJ_MAXERROR) {
+			if (txc->maxerror < 0
+					|| txc->maxerror >= NTP_PHASE_LIMIT) {
+				result = -EINVAL;
+				goto leave;
+			}
+			time_maxerror = txc->maxerror;
+		}
+
+		if (txc->modes & ADJ_ESTERROR) {
+			if (txc->esterror < 0
+					|| txc->esterror >= NTP_PHASE_LIMIT) {
+				result = -EINVAL;
+				goto leave;
+			}
+			time_esterror = txc->esterror;
+		}
+
+		if (txc->modes & ADJ_TIMECONST) {	/* p. 24 */
+			if (txc->constant < 0) { /* NTP v4 uses values > 6 */
+				result = -EINVAL;
+				goto leave;
+			}
+			time_constant = txc->constant;
+		}
+
+		if (txc->modes & ADJ_OFFSET) { /* values checked earlier */
+			if (txc->modes == ADJ_OFFSET_SINGLESHOT) {
+				/* adjtime() is independent from ntp_adjtime() */
+				if ((time_next_adjust = txc->offset) == 0)
+					time_adjust = 0;
+			} else if ( time_status & (STA_PLL | STA_PPSTIME) ) {
+				ltemp = (time_status
+					& (STA_PPSTIME | STA_PPSSIGNAL))
+					== (STA_PPSTIME | STA_PPSSIGNAL) ?
+			            pps_offset : txc->offset;
+
+				/*
+				 * Scale the phase adjustment and
+				 * clamp to the operating range.
+				 */
+				if (ltemp > MAXPHASE)
+					time_offset = MAXPHASE << SHIFT_UPDATE;
+				else if (ltemp < -MAXPHASE)
+					time_offset = -(MAXPHASE
+							<< SHIFT_UPDATE);
+				else
+					time_offset = ltemp << SHIFT_UPDATE;
+
+				/*
+				 * Select whether the frequency is to be controlled
+				 * and in which mode (PLL or FLL). Clamp to the operating
+				 * range. Ugly multiply/divide should be replaced someday.
+				 */
+
+				if (time_status & STA_FREQHOLD || time_reftime == 0)
+					time_reftime = xtime.tv_sec;
+
+				mtemp = xtime.tv_sec - time_reftime;
+				time_reftime = xtime.tv_sec;
+
+				if (time_status & STA_FLL) {
+					if (mtemp >= MINSEC) {
+						ltemp = (time_offset / mtemp) << (SHIFT_USEC -
+									SHIFT_UPDATE);
+						if (ltemp < 0)
+							time_freq -= -ltemp >> SHIFT_KH;
+						else
+							time_freq += ltemp >> SHIFT_KH;
+					} else /* calibration interval too short (p. 12) */
+						result = TIME_ERROR;
+				} else {	/* PLL mode */
+					if (mtemp < MAXSEC) {
+						ltemp *= mtemp;
+						if (ltemp < 0)
+							time_freq -= -ltemp >> (time_constant +
+									time_constant +
+									SHIFT_KF - SHIFT_USEC);
+					    else
+				    	    time_freq += ltemp >> (time_constant +
+								       time_constant +
+								       SHIFT_KF - SHIFT_USEC);
+					} else /* calibration interval too long (p. 12) */
+						result = TIME_ERROR;
+				}
+
+				if (time_freq > time_tolerance)
+					time_freq = time_tolerance;
+				else if (time_freq < -time_tolerance)
+					time_freq = -time_tolerance;
+			} /* STA_PLL || STA_PPSTIME */
+		} /* txc->modes & ADJ_OFFSET */
+
+		if (txc->modes & ADJ_TICK) {
+			tick_usec = txc->tick;
+			tick_nsec = TICK_USEC_TO_NSEC(tick_usec);
+		}
+	} /* txc->modes */
+leave:
+
+	if ((time_status & (STA_UNSYNC|STA_CLOCKERR)) != 0
+		|| ((time_status & (STA_PPSFREQ|STA_PPSTIME)) != 0
+		&& (time_status & STA_PPSSIGNAL) == 0)
+		/* p. 24, (b) */
+		|| ((time_status & (STA_PPSTIME|STA_PPSJITTER))
+		== (STA_PPSTIME|STA_PPSJITTER))
+		/* p. 24, (c) */
+		|| ((time_status & STA_PPSFREQ) != 0
+		&& (time_status & (STA_PPSWANDER|STA_PPSERROR)) != 0))
+		/* p. 24, (d) */
+			result = TIME_ERROR;
+
+	if ((txc->modes & ADJ_OFFSET_SINGLESHOT) == ADJ_OFFSET_SINGLESHOT)
+		txc->offset = save_adjust;
+	else {
+		if (time_offset < 0)
+			txc->offset = -(-time_offset >> SHIFT_UPDATE);
+		else
+			txc->offset = time_offset >> SHIFT_UPDATE;
+	}
+	txc->freq = time_freq + pps_freq;
+	txc->maxerror = time_maxerror;
+	txc->esterror = time_esterror;
+	txc->status = time_status;
+	txc->constant = time_constant;
+	txc->precision = time_precision;
+	txc->tolerance = time_tolerance;
+	txc->tick = tick_usec;
+	txc->ppsfreq = pps_freq;
+	txc->jitter = pps_jitter >> PPS_AVG;
+	txc->shift = pps_shift;
+	txc->stabil = pps_stabil;
+	txc->jitcnt = pps_jitcnt;
+	txc->calcnt = pps_calcnt;
+	txc->errcnt = pps_errcnt;
+	txc->stbcnt = pps_stbcnt;
+	write_sequnlock_irq(&xtime_lock);
+	do_gettimeofday(&txc->time);
+	return result;
+}
+
+/**
+ * ntp_clear - Clears the NTP state machine.
+ *
+ * Must be called while holding a write on the xtime_lock
+ */
+void ntp_clear(void)
+{
+	time_adjust = 0;		/* stop active adjtime() */
+	time_status |= STA_UNSYNC;
+	time_maxerror = NTP_PHASE_LIMIT;
+	time_esterror = NTP_PHASE_LIMIT;
+}
+
+/**
+ * ntp_synced - Returns 1 if the NTP status is not UNSYNC
+ *
+ */
+int ntp_synced(void)
+{
+	return !(time_status & STA_UNSYNC);
+}
+
diff --git a/kernel/time.c b/kernel/time.c
--- a/kernel/time.c
+++ b/kernel/time.c
@@ -35,6 +35,7 @@
 #include <linux/security.h>
 #include <linux/fs.h>
 #include <linux/module.h>
+#include <linux/ntp.h>
 
 #include <asm/uaccess.h>
 #include <asm/unistd.h>
@@ -198,20 +199,6 @@ asmlinkage long sys_settimeofday(struct 
 	return do_sys_settimeofday(tv ? &new_ts : NULL, tz ? &new_tz : NULL);
 }
 
-long pps_offset;		/* pps time offset (us) */
-long pps_jitter = MAXTIME;	/* time dispersion (jitter) (us) */
-
-long pps_freq;			/* frequency offset (scaled ppm) */
-long pps_stabil = MAXFREQ;	/* frequency dispersion (scaled ppm) */
-
-long pps_valid = PPS_VALID;	/* pps signal watchdog counter */
-
-int pps_shift = PPS_SHIFT;	/* interval duration (s) (shift) */
-
-long pps_jitcnt;		/* jitter limit exceeded */
-long pps_calcnt;		/* calibration intervals */
-long pps_errcnt;		/* calibration errors */
-long pps_stbcnt;		/* stability limit exceeded */
 
 /* hook for a loadable hardpps kernel module */
 void (*hardpps_ptr)(struct timeval *);
@@ -229,184 +216,14 @@ void __attribute__ ((weak)) notify_arch_
  */
 int do_adjtimex(struct timex *txc)
 {
-        long ltemp, mtemp, save_adjust;
 	int result;
 
 	/* In order to modify anything, you gotta be super-user! */
 	if (txc->modes && !capable(CAP_SYS_TIME))
 		return -EPERM;
 		
-	/* Now we validate the data before disabling interrupts */
-
-	if ((txc->modes & ADJ_OFFSET_SINGLESHOT) == ADJ_OFFSET_SINGLESHOT)
-	  /* singleshot must not be used with any other mode bits */
-		if (txc->modes != ADJ_OFFSET_SINGLESHOT)
-			return -EINVAL;
-
-	if (txc->modes != ADJ_OFFSET_SINGLESHOT && (txc->modes & ADJ_OFFSET))
-	  /* adjustment Offset limited to +- .512 seconds */
-		if (txc->offset <= - MAXPHASE || txc->offset >= MAXPHASE )
-			return -EINVAL;	
-
-	/* if the quartz is off by more than 10% something is VERY wrong ! */
-	if (txc->modes & ADJ_TICK)
-		if (txc->tick <  900000/USER_HZ ||
-		    txc->tick > 1100000/USER_HZ)
-			return -EINVAL;
-
-	write_seqlock_irq(&xtime_lock);
-	result = time_state;	/* mostly `TIME_OK' */
-
-	/* Save for later - semantics of adjtime is to return old value */
-	save_adjust = time_next_adjust ? time_next_adjust : time_adjust;
-
-#if 0	/* STA_CLOCKERR is never set yet */
-	time_status &= ~STA_CLOCKERR;		/* reset STA_CLOCKERR */
-#endif
-	/* If there are input parameters, then process them */
-	if (txc->modes)
-	{
-	    if (txc->modes & ADJ_STATUS)	/* only set allowed bits */
-		time_status =  (txc->status & ~STA_RONLY) |
-			      (time_status & STA_RONLY);
-
-	    if (txc->modes & ADJ_FREQUENCY) {	/* p. 22 */
-		if (txc->freq > MAXFREQ || txc->freq < -MAXFREQ) {
-		    result = -EINVAL;
-		    goto leave;
-		}
-		time_freq = txc->freq - pps_freq;
-	    }
-
-	    if (txc->modes & ADJ_MAXERROR) {
-		if (txc->maxerror < 0 || txc->maxerror >= NTP_PHASE_LIMIT) {
-		    result = -EINVAL;
-		    goto leave;
-		}
-		time_maxerror = txc->maxerror;
-	    }
-
-	    if (txc->modes & ADJ_ESTERROR) {
-		if (txc->esterror < 0 || txc->esterror >= NTP_PHASE_LIMIT) {
-		    result = -EINVAL;
-		    goto leave;
-		}
-		time_esterror = txc->esterror;
-	    }
-
-	    if (txc->modes & ADJ_TIMECONST) {	/* p. 24 */
-		if (txc->constant < 0) {	/* NTP v4 uses values > 6 */
-		    result = -EINVAL;
-		    goto leave;
-		}
-		time_constant = txc->constant;
-	    }
-
-	    if (txc->modes & ADJ_OFFSET) {	/* values checked earlier */
-		if (txc->modes == ADJ_OFFSET_SINGLESHOT) {
-		    /* adjtime() is independent from ntp_adjtime() */
-		    if ((time_next_adjust = txc->offset) == 0)
-			 time_adjust = 0;
-		}
-		else if ( time_status & (STA_PLL | STA_PPSTIME) ) {
-		    ltemp = (time_status & (STA_PPSTIME | STA_PPSSIGNAL)) ==
-		            (STA_PPSTIME | STA_PPSSIGNAL) ?
-		            pps_offset : txc->offset;
-
-		    /*
-		     * Scale the phase adjustment and
-		     * clamp to the operating range.
-		     */
-		    if (ltemp > MAXPHASE)
-		        time_offset = MAXPHASE << SHIFT_UPDATE;
-		    else if (ltemp < -MAXPHASE)
-			time_offset = -(MAXPHASE << SHIFT_UPDATE);
-		    else
-		        time_offset = ltemp << SHIFT_UPDATE;
-
-		    /*
-		     * Select whether the frequency is to be controlled
-		     * and in which mode (PLL or FLL). Clamp to the operating
-		     * range. Ugly multiply/divide should be replaced someday.
-		     */
-
-		    if (time_status & STA_FREQHOLD || time_reftime == 0)
-		        time_reftime = xtime.tv_sec;
-		    mtemp = xtime.tv_sec - time_reftime;
-		    time_reftime = xtime.tv_sec;
-		    if (time_status & STA_FLL) {
-		        if (mtemp >= MINSEC) {
-			    ltemp = (time_offset / mtemp) << (SHIFT_USEC -
-							      SHIFT_UPDATE);
-			    if (ltemp < 0)
-			        time_freq -= -ltemp >> SHIFT_KH;
-			    else
-			        time_freq += ltemp >> SHIFT_KH;
-			} else /* calibration interval too short (p. 12) */
-				result = TIME_ERROR;
-		    } else {	/* PLL mode */
-		        if (mtemp < MAXSEC) {
-			    ltemp *= mtemp;
-			    if (ltemp < 0)
-			        time_freq -= -ltemp >> (time_constant +
-							time_constant +
-							SHIFT_KF - SHIFT_USEC);
-			    else
-			        time_freq += ltemp >> (time_constant +
-						       time_constant +
-						       SHIFT_KF - SHIFT_USEC);
-			} else /* calibration interval too long (p. 12) */
-				result = TIME_ERROR;
-		    }
-		    if (time_freq > time_tolerance)
-		        time_freq = time_tolerance;
-		    else if (time_freq < -time_tolerance)
-		        time_freq = -time_tolerance;
-		} /* STA_PLL || STA_PPSTIME */
-	    } /* txc->modes & ADJ_OFFSET */
-	    if (txc->modes & ADJ_TICK) {
-		tick_usec = txc->tick;
-		tick_nsec = TICK_USEC_TO_NSEC(tick_usec);
-	    }
-	} /* txc->modes */
-leave:	if ((time_status & (STA_UNSYNC|STA_CLOCKERR)) != 0
-	    || ((time_status & (STA_PPSFREQ|STA_PPSTIME)) != 0
-		&& (time_status & STA_PPSSIGNAL) == 0)
-	    /* p. 24, (b) */
-	    || ((time_status & (STA_PPSTIME|STA_PPSJITTER))
-		== (STA_PPSTIME|STA_PPSJITTER))
-	    /* p. 24, (c) */
-	    || ((time_status & STA_PPSFREQ) != 0
-		&& (time_status & (STA_PPSWANDER|STA_PPSERROR)) != 0))
-	    /* p. 24, (d) */
-		result = TIME_ERROR;
+	result = ntp_adjtimex(txc);
 	
-	if ((txc->modes & ADJ_OFFSET_SINGLESHOT) == ADJ_OFFSET_SINGLESHOT)
-	    txc->offset	   = save_adjust;
-	else {
-	    if (time_offset < 0)
-		txc->offset = -(-time_offset >> SHIFT_UPDATE);
-	    else
-		txc->offset = time_offset >> SHIFT_UPDATE;
-	}
-	txc->freq	   = time_freq + pps_freq;
-	txc->maxerror	   = time_maxerror;
-	txc->esterror	   = time_esterror;
-	txc->status	   = time_status;
-	txc->constant	   = time_constant;
-	txc->precision	   = time_precision;
-	txc->tolerance	   = time_tolerance;
-	txc->tick	   = tick_usec;
-	txc->ppsfreq	   = pps_freq;
-	txc->jitter	   = pps_jitter >> PPS_AVG;
-	txc->shift	   = pps_shift;
-	txc->stabil	   = pps_stabil;
-	txc->jitcnt	   = pps_jitcnt;
-	txc->calcnt	   = pps_calcnt;
-	txc->errcnt	   = pps_errcnt;
-	txc->stbcnt	   = pps_stbcnt;
-	write_sequnlock_irq(&xtime_lock);
-	do_gettimeofday(&txc->time);
 	notify_arch_cmos_timer();
 	return(result);
 }
@@ -522,10 +339,8 @@ int do_settimeofday (struct timespec *tv
 		set_normalized_timespec(&xtime, sec, nsec);
 		set_normalized_timespec(&wall_to_monotonic, wtm_sec, wtm_nsec);
 
-		time_adjust = 0;		/* stop active adjtime() */
-		time_status |= STA_UNSYNC;
-		time_maxerror = NTP_PHASE_LIMIT;
-		time_esterror = NTP_PHASE_LIMIT;
+		ntp_clear();
+
 		time_interpolator_reset();
 	}
 	write_sequnlock_irq(&xtime_lock);
diff --git a/kernel/timer.c b/kernel/timer.c
--- a/kernel/timer.c
+++ b/kernel/timer.c
@@ -33,6 +33,7 @@
 #include <linux/posix-timers.h>
 #include <linux/cpu.h>
 #include <linux/syscalls.h>
+#include <linux/ntp.h>
 
 #include <asm/uaccess.h>
 #include <asm/unistd.h>
@@ -41,7 +42,7 @@
 #include <asm/io.h>
 
 #ifdef CONFIG_TIME_INTERPOLATION
-static void time_interpolator_update(long delta_nsec);
+void time_interpolator_update(long delta_nsec);
 #else
 #define time_interpolator_update(x)
 #endif
@@ -597,219 +598,17 @@ struct timespec wall_to_monotonic __attr
 
 EXPORT_SYMBOL(xtime);
 
-/* Don't completely fail for HZ > 500.  */
-int tickadj = 500/HZ ? : 1;		/* microsecs */
-
-
-/*
- * phase-lock loop variables
- */
-/* TIME_ERROR prevents overwriting the CMOS clock */
-int time_state = TIME_OK;		/* clock synchronization status	*/
-int time_status = STA_UNSYNC;		/* clock status bits		*/
-long time_offset;			/* time adjustment (us)		*/
-long time_constant = 2;			/* pll time constant		*/
-long time_tolerance = MAXFREQ;		/* frequency tolerance (ppm)	*/
-long time_precision = 1;		/* clock precision (us)		*/
-long time_maxerror = NTP_PHASE_LIMIT;	/* maximum error (us)		*/
-long time_esterror = NTP_PHASE_LIMIT;	/* estimated error (us)		*/
-static long time_phase;			/* phase offset (scaled us)	*/
-long time_freq = (((NSEC_PER_SEC + HZ/2) % HZ - HZ/2) << SHIFT_USEC) / NSEC_PER_USEC;
-					/* frequency offset (scaled ppm)*/
-static long time_adj;			/* tick adjust (scaled 1 / HZ)	*/
-long time_reftime;			/* time at last adjustment (s)	*/
-long time_adjust;
-long time_next_adjust;
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
-static void second_overflow(void)
-{
-    long ltemp;
-
-    /* Bump the maxerror field */
-    time_maxerror += time_tolerance >> SHIFT_USEC;
-    if ( time_maxerror > NTP_PHASE_LIMIT ) {
-	time_maxerror = NTP_PHASE_LIMIT;
-	time_status |= STA_UNSYNC;
-    }
-
-    /*
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
-     * Compute the phase adjustment for the next second. In
-     * PLL mode, the offset is reduced by a fixed factor
-     * times the time constant. In FLL mode the offset is
-     * used directly. In either mode, the maximum phase
-     * adjustment for each second is clamped so as to spread
-     * the adjustment over not more than the number of
-     * seconds between updates.
-     */
-    if (time_offset < 0) {
-	ltemp = -time_offset;
-	if (!(time_status & STA_FLL))
-	    ltemp >>= SHIFT_KG + time_constant;
-	if (ltemp > (MAXPHASE / MINSEC) << SHIFT_UPDATE)
-	    ltemp = (MAXPHASE / MINSEC) << SHIFT_UPDATE;
-	time_offset += ltemp;
-	time_adj = -ltemp << (SHIFT_SCALE - SHIFT_HZ - SHIFT_UPDATE);
-    } else {
-	ltemp = time_offset;
-	if (!(time_status & STA_FLL))
-	    ltemp >>= SHIFT_KG + time_constant;
-	if (ltemp > (MAXPHASE / MINSEC) << SHIFT_UPDATE)
-	    ltemp = (MAXPHASE / MINSEC) << SHIFT_UPDATE;
-	time_offset -= ltemp;
-	time_adj = ltemp << (SHIFT_SCALE - SHIFT_HZ - SHIFT_UPDATE);
-    }
-
-    /*
-     * Compute the frequency estimate and additional phase
-     * adjustment due to frequency error for the next
-     * second. When the PPS signal is engaged, gnaw on the
-     * watchdog counter and update the frequency computed by
-     * the pll and the PPS signal.
-     */
-    pps_valid++;
-    if (pps_valid == PPS_VALID) {	/* PPS signal lost */
-	pps_jitter = MAXTIME;
-	pps_stabil = MAXFREQ;
-	time_status &= ~(STA_PPSSIGNAL | STA_PPSJITTER |
-			 STA_PPSWANDER | STA_PPSERROR);
-    }
-    ltemp = time_freq + pps_freq;
-    if (ltemp < 0)
-	time_adj -= -ltemp >>
-	    (SHIFT_USEC + SHIFT_HZ - SHIFT_SCALE);
-    else
-	time_adj += ltemp >>
-	    (SHIFT_USEC + SHIFT_HZ - SHIFT_SCALE);
-
-#if HZ == 100
-    /* Compensate for (HZ==100) != (1 << SHIFT_HZ).
-     * Add 25% and 3.125% to get 128.125; => only 0.125% error (p. 14)
-     */
-    if (time_adj < 0)
-	time_adj -= (-time_adj >> 2) + (-time_adj >> 5);
-    else
-	time_adj += (time_adj >> 2) + (time_adj >> 5);
-#endif
-#if HZ == 1000
-    /* Compensate for (HZ==1000) != (1 << SHIFT_HZ).
-     * Add 1.5625% and 0.78125% to get 1023.4375; => only 0.05% error (p. 14)
-     */
-    if (time_adj < 0)
-	time_adj -= (-time_adj >> 6) + (-time_adj >> 7);
-    else
-	time_adj += (time_adj >> 6) + (time_adj >> 7);
-#endif
-}
 
 /* in the NTP reference this is called "hardclock()" */
 static void update_wall_time_one_tick(void)
 {
-	long time_adjust_step, delta_nsec;
+	long delta_nsec;
 
-	if ( (time_adjust_step = time_adjust) != 0 ) {
-	    /* We are doing an adjtime thing. 
-	     *
-	     * Prepare time_adjust_step to be within bounds.
-	     * Note that a positive time_adjust means we want the clock
-	     * to run faster.
-	     *
-	     * Limit the amount of the step to be in the range
-	     * -tickadj .. +tickadj
-	     */
-	     if (time_adjust > tickadj)
-		time_adjust_step = tickadj;
-	     else if (time_adjust < -tickadj)
-		time_adjust_step = -tickadj;
+	delta_nsec = tick_nsec + ntp_advance();
 
-	    /* Reduce by this step the amount of time left  */
-	    time_adjust -= time_adjust_step;
-	}
-	delta_nsec = tick_nsec + time_adjust_step * 1000;
-	/*
-	 * Advance the phase, once it gets to one microsecond, then
-	 * advance the tick more.
-	 */
-	time_phase += time_adj;
-	if (time_phase <= -FINENSEC) {
-		long ltemp = -time_phase >> (SHIFT_SCALE - 10);
-		time_phase += ltemp << (SHIFT_SCALE - 10);
-		delta_nsec -= ltemp;
-	}
-	else if (time_phase >= FINENSEC) {
-		long ltemp = time_phase >> (SHIFT_SCALE - 10);
-		time_phase -= ltemp << (SHIFT_SCALE - 10);
-		delta_nsec += ltemp;
-	}
 	xtime.tv_nsec += delta_nsec;
 	time_interpolator_update(delta_nsec);
 
-	/* Changes by adjtime() do not take effect till next tick. */
-	if (time_next_adjust != 0) {
-		time_adjust = time_next_adjust;
-		time_next_adjust = 0;
-	}
 }
 
 /*
@@ -1473,7 +1272,7 @@ unsigned long time_interpolator_get_offs
 #define INTERPOLATOR_ADJUST 65536
 #define INTERPOLATOR_MAX_SKIP 10*INTERPOLATOR_ADJUST
 
-static void time_interpolator_update(long delta_nsec)
+void time_interpolator_update(long delta_nsec)
 {
 	u64 counter;
 	unsigned long offset;


