Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751282AbWGMASi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751282AbWGMASi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 20:18:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751473AbWGMASi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 20:18:38 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:32479 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751282AbWGMASh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 20:18:37 -0400
Subject: [RFC] Move NTP related code to ntp.c
From: john stultz <johnstul@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Roman Zippel <zippel@linux-m68k.org>, Ingo Molnar <mingo@elte.hu>,
       Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain
Date: Wed, 12 Jul 2006 17:18:34 -0700
Message-Id: <1152749914.11963.33.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey all,
	I know I've been moving a bit slowly, but I wanted to get my current
tree out there so folks could see where I'm heading w/ the timekeeping
code now that the largest chunk of logical changes has landed.

You can find the current version (C3 against 2.6.18-rc1) of the
timekeeping tree here: http://sr71.net/~jstultz/tod/

Basically it consists of a few cleanup patches, a paranoid debug patch,
and the x86-64 and ppc conversion patches as well.

On the TODO list:
o Breakup the x86-64 patch and get it -mm bound.
o ia64 patch from Peter Keilty in the works
o I need to dig up the ARM patches that hit the list awhile back.
o Rewrite the ktime_t interfaces patch.


Anyway, here is the first of those cleanups I'd like to push soon-ish.
It just simply moves all of the NTP related code and interfaces from
kernel/timer.c and kernel/time.c into kernel/time/ntp.c. There is still
a bunch of NTP cleanups to be done to the code (Now that we have decent
interfaces we can static the global variables, make do_adjtimex
readable, etc), but this is the first step.

Roman: I know you had some larger NTP changes (getting rid of
update_ntp_one_tick() for second-interval adjustments, etc). Are they
still around?

Anyway, comments or feedback would be appreciated.

thanks
-john


 include/linux/timex.h |    2 
 kernel/time.c         |  173 ---------------------
 kernel/time/Makefile  |    2 
 kernel/time/ntp.c     |  396 ++++++++++++++++++++++++++++++++++++++++++++++++++
 kernel/timer.c        |  203 -------------------------
 5 files changed, 399 insertions(+), 377 deletions(-)

linux-2.6.18-rc1_timeofday-ntp-cleanup_C3.patch
============================================
diff --git a/include/linux/timex.h b/include/linux/timex.h
index 19bb653..73b9cd2 100644
--- a/include/linux/timex.h
+++ b/include/linux/timex.h
@@ -308,6 +308,8 @@ time_interpolator_reset(void)
 /* Returns how long ticks are at present, in ns / 2^(SHIFT_SCALE-10). */
 extern u64 current_tick_length(void);
 
+extern void second_overflow(void);
+extern void update_ntp_one_tick(void);
 extern int do_adjtimex(struct timex *);
 
 #endif /* KERNEL */
diff --git a/kernel/time.c b/kernel/time.c
index 5bd4897..0e017bf 100644
--- a/kernel/time.c
+++ b/kernel/time.c
@@ -202,179 +202,6 @@ asmlinkage long sys_settimeofday(struct 
 	return do_sys_settimeofday(tv ? &new_ts : NULL, tz ? &new_tz : NULL);
 }
 
-/* we call this to notify the arch when the clock is being
- * controlled.  If no such arch routine, do nothing.
- */
-void __attribute__ ((weak)) notify_arch_cmos_timer(void)
-{
-	return;
-}
-
-/* adjtimex mainly allows reading (and writing, if superuser) of
- * kernel time-keeping variables. used by xntpd.
- */
-int do_adjtimex(struct timex *txc)
-{
-        long ltemp, mtemp, save_adjust;
-	int result;
-
-	/* In order to modify anything, you gotta be super-user! */
-	if (txc->modes && !capable(CAP_SYS_TIME))
-		return -EPERM;
-		
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
-		time_freq = txc->freq;
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
-		else if (time_status & STA_PLL) {
-		    ltemp = txc->offset;
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
-			    time_freq += shift_right(ltemp, SHIFT_KH);
-			} else /* calibration interval too short (p. 12) */
-				result = TIME_ERROR;
-		    } else {	/* PLL mode */
-		        if (mtemp < MAXSEC) {
-			    ltemp *= mtemp;
-			    time_freq += shift_right(ltemp,(time_constant +
-						       time_constant +
-						       SHIFT_KF - SHIFT_USEC));
-			} else /* calibration interval too long (p. 12) */
-				result = TIME_ERROR;
-		    }
-		    time_freq = min(time_freq, time_tolerance);
-		    time_freq = max(time_freq, -time_tolerance);
-		} /* STA_PLL */
-	    } /* txc->modes & ADJ_OFFSET */
-	    if (txc->modes & ADJ_TICK) {
-		tick_usec = txc->tick;
-		tick_nsec = TICK_USEC_TO_NSEC(tick_usec);
-	    }
-	} /* txc->modes */
-leave:	if ((time_status & (STA_UNSYNC|STA_CLOCKERR)) != 0)
-		result = TIME_ERROR;
-	
-	if ((txc->modes & ADJ_OFFSET_SINGLESHOT) == ADJ_OFFSET_SINGLESHOT)
-	    txc->offset	   = save_adjust;
-	else {
-	    txc->offset = shift_right(time_offset, SHIFT_UPDATE);
-	}
-	txc->freq	   = time_freq;
-	txc->maxerror	   = time_maxerror;
-	txc->esterror	   = time_esterror;
-	txc->status	   = time_status;
-	txc->constant	   = time_constant;
-	txc->precision	   = time_precision;
-	txc->tolerance	   = time_tolerance;
-	txc->tick	   = tick_usec;
-
-	/* PPS is not implemented, so these are zero */
-	txc->ppsfreq	   = 0;
-	txc->jitter	   = 0;
-	txc->shift	   = 0;
-	txc->stabil	   = 0;
-	txc->jitcnt	   = 0;
-	txc->calcnt	   = 0;
-	txc->errcnt	   = 0;
-	txc->stbcnt	   = 0;
-	write_sequnlock_irq(&xtime_lock);
-	do_gettimeofday(&txc->time);
-	notify_arch_cmos_timer();
-	return(result);
-}
-
 asmlinkage long sys_adjtimex(struct timex __user *txc_p)
 {
 	struct timex txc;		/* Local copy of parameter */
diff --git a/kernel/time/Makefile b/kernel/time/Makefile
index e1dfd8e..61a3907 100644
--- a/kernel/time/Makefile
+++ b/kernel/time/Makefile
@@ -1 +1 @@
-obj-y += clocksource.o jiffies.o
+obj-y += ntp.o clocksource.o jiffies.o
diff --git a/kernel/time/ntp.c b/kernel/time/ntp.c
new file mode 100644
index 0000000..7328bdf
--- /dev/null
+++ b/kernel/time/ntp.c
@@ -0,0 +1,396 @@
+/*
+ * linux/kernel/time/ntp.c
+ *
+ * NTP state machine interfaces and logic.
+ *
+ * This code was mainly moved from kernel/timer.c and kerenl/time.c
+ * Please see those files for relavent copyright info and historical
+ * changelogs.
+ */
+
+#include <linux/mm.h>
+#include <linux/time.h>
+#include <linux/timex.h>
+
+#include <asm/div64.h>
+#include <asm/timex.h>
+
+#ifdef CONFIG_TIME_INTERPOLATION
+void time_interpolator_update(long delta_nsec);
+#else
+#define time_interpolator_update(x)
+#endif
+
+/* Don't completely fail for HZ > 500.  */
+int tickadj = 500/HZ ? : 1;		/* microsecs */
+
+/*
+ * phase-lock loop variables
+ */
+/* TIME_ERROR prevents overwriting the CMOS clock */
+int time_state = TIME_OK;		/* clock synchronization status	*/
+int time_status = STA_UNSYNC;		/* clock status bits		*/
+long time_offset;			/* time adjustment (us)		*/
+long time_constant = 2;			/* pll time constant		*/
+long time_tolerance = MAXFREQ;		/* frequency tolerance (ppm)	*/
+long time_precision = 1;		/* clock precision (us)		*/
+long time_maxerror = NTP_PHASE_LIMIT;	/* maximum error (us)		*/
+long time_esterror = NTP_PHASE_LIMIT;	/* estimated error (us)		*/
+long time_freq = (((NSEC_PER_SEC + HZ/2) % HZ - HZ/2) << SHIFT_USEC) / NSEC_PER_USEC;
+					/* frequency offset (scaled ppm)*/
+static long time_adj;			/* tick adjust (scaled 1 / HZ)	*/
+long time_reftime;			/* time at last adjustment (s)	*/
+long time_adjust;
+long time_next_adjust;
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
+	if (time_maxerror > NTP_PHASE_LIMIT) {
+		time_maxerror = NTP_PHASE_LIMIT;
+		time_status |= STA_UNSYNC;
+	}
+
+	/*
+	 * Leap second processing. If in leap-insert state at the end of the
+	 * day, the system clock is set back one second; if in leap-delete
+	 * state, the system clock is set ahead one second. The microtime()
+	 * routine or external clock driver will insure that reported time is
+	 * always monotonic. The ugly divides should be replaced.
+	 */
+	switch (time_state) {
+	case TIME_OK:
+		if (time_status & STA_INS)
+			time_state = TIME_INS;
+		else if (time_status & STA_DEL)
+			time_state = TIME_DEL;
+		break;
+	case TIME_INS:
+		if (xtime.tv_sec % 86400 == 0) {
+			xtime.tv_sec--;
+			wall_to_monotonic.tv_sec++;
+			/*
+			 * The timer interpolator will make time change
+			 * gradually instead of an immediate jump by one second
+			 */
+			time_interpolator_update(-NSEC_PER_SEC);
+			time_state = TIME_OOP;
+			clock_was_set();
+			printk(KERN_NOTICE "Clock: inserting leap second "
+					"23:59:60 UTC\n");
+		}
+		break;
+	case TIME_DEL:
+		if ((xtime.tv_sec + 1) % 86400 == 0) {
+			xtime.tv_sec++;
+			wall_to_monotonic.tv_sec--;
+			/*
+			 * Use of time interpolator for a gradual change of
+			 * time
+			 */
+			time_interpolator_update(NSEC_PER_SEC);
+			time_state = TIME_WAIT;
+			clock_was_set();
+			printk(KERN_NOTICE "Clock: deleting leap second "
+					"23:59:59 UTC\n");
+		}
+		break;
+	case TIME_OOP:
+		time_state = TIME_WAIT;
+		break;
+	case TIME_WAIT:
+		if (!(time_status & (STA_INS | STA_DEL)))
+		time_state = TIME_OK;
+	}
+
+	/*
+	 * Compute the phase adjustment for the next second. In PLL mode, the
+	 * offset is reduced by a fixed factor times the time constant. In FLL
+	 * mode the offset is used directly. In either mode, the maximum phase
+	 * adjustment for each second is clamped so as to spread the adjustment
+	 * over not more than the number of seconds between updates.
+	 */
+	ltemp = time_offset;
+	if (!(time_status & STA_FLL))
+		ltemp = shift_right(ltemp, SHIFT_KG + time_constant);
+	ltemp = min(ltemp, (MAXPHASE / MINSEC) << SHIFT_UPDATE);
+	ltemp = max(ltemp, -(MAXPHASE / MINSEC) << SHIFT_UPDATE);
+	time_offset -= ltemp;
+	time_adj = ltemp << (SHIFT_SCALE - SHIFT_HZ - SHIFT_UPDATE);
+
+	/*
+	 * Compute the frequency estimate and additional phase adjustment due
+	 * to frequency error for the next second.
+	 */
+	ltemp = time_freq;
+	time_adj += shift_right(ltemp,(SHIFT_USEC + SHIFT_HZ - SHIFT_SCALE));
+
+#if HZ == 100
+	/*
+	 * Compensate for (HZ==100) != (1 << SHIFT_HZ).  Add 25% and 3.125% to
+	 * get 128.125; => only 0.125% error (p. 14)
+	 */
+	time_adj += shift_right(time_adj, 2) + shift_right(time_adj, 5);
+#endif
+#if HZ == 250
+	/*
+	 * Compensate for (HZ==250) != (1 << SHIFT_HZ).  Add 1.5625% and
+	 * 0.78125% to get 255.85938; => only 0.05% error (p. 14)
+	 */
+	time_adj += shift_right(time_adj, 6) + shift_right(time_adj, 7);
+#endif
+#if HZ == 1000
+	/*
+	 * Compensate for (HZ==1000) != (1 << SHIFT_HZ).  Add 1.5625% and
+	 * 0.78125% to get 1023.4375; => only 0.05% error (p. 14)
+	 */
+	time_adj += shift_right(time_adj, 6) + shift_right(time_adj, 7);
+#endif
+}
+
+/*
+ * Returns how many microseconds we need to add to xtime this tick
+ * in doing an adjustment requested with adjtime.
+ */
+static long adjtime_adjustment(void)
+{
+	long time_adjust_step;
+
+	time_adjust_step = time_adjust;
+	if (time_adjust_step) {
+		/*
+		 * We are doing an adjtime thing.  Prepare time_adjust_step to
+		 * be within bounds.  Note that a positive time_adjust means we
+		 * want the clock to run faster.
+		 *
+		 * Limit the amount of the step to be in the range
+		 * -tickadj .. +tickadj
+		 */
+		time_adjust_step = min(time_adjust_step, (long)tickadj);
+		time_adjust_step = max(time_adjust_step, (long)-tickadj);
+	}
+	return time_adjust_step;
+}
+
+/* in the NTP reference this is called "hardclock()" */
+void update_ntp_one_tick(void)
+{
+	long time_adjust_step;
+
+	time_adjust_step = adjtime_adjustment();
+	if (time_adjust_step)
+		/* Reduce by this step the amount of time left  */
+		time_adjust -= time_adjust_step;
+
+	/* Changes by adjtime() do not take effect till next tick. */
+	if (time_next_adjust != 0) {
+		time_adjust = time_next_adjust;
+		time_next_adjust = 0;
+	}
+}
+
+/*
+ * Return how long ticks are at the moment, that is, how much time
+ * update_wall_time_one_tick will add to xtime next time we call it
+ * (assuming no calls to do_adjtimex in the meantime).
+ * The return value is in fixed-point nanoseconds shifted by the
+ * specified number of bits to the right of the binary point.
+ * This function has no side-effects.
+ */
+u64 current_tick_length(void)
+{
+	long delta_nsec;
+	u64 ret;
+
+	/* calculate the finest interval NTP will allow.
+	 *    ie: nanosecond value shifted by (SHIFT_SCALE - 10)
+	 */
+	delta_nsec = tick_nsec + adjtime_adjustment() * 1000;
+	ret = (u64)delta_nsec << TICK_LENGTH_SHIFT;
+	ret += (s64)time_adj << (TICK_LENGTH_SHIFT - (SHIFT_SCALE - 10));
+
+	return ret;
+}
+
+
+void __attribute__ ((weak)) notify_arch_cmos_timer(void)
+{
+	return;
+}
+
+/* adjtimex mainly allows reading (and writing, if superuser) of
+ * kernel time-keeping variables. used by xntpd.
+ */
+int do_adjtimex(struct timex *txc)
+{
+        long ltemp, mtemp, save_adjust;
+	int result;
+
+	/* In order to modify anything, you gotta be super-user! */
+	if (txc->modes && !capable(CAP_SYS_TIME))
+		return -EPERM;
+
+	/* Now we validate the data before disabling interrupts */
+
+	if ((txc->modes & ADJ_OFFSET_SINGLESHOT) == ADJ_OFFSET_SINGLESHOT)
+	  /* singleshot must not be used with any other mode bits */
+		if (txc->modes != ADJ_OFFSET_SINGLESHOT)
+			return -EINVAL;
+
+	if (txc->modes != ADJ_OFFSET_SINGLESHOT && (txc->modes & ADJ_OFFSET))
+	  /* adjustment Offset limited to +- .512 seconds */
+		if (txc->offset <= - MAXPHASE || txc->offset >= MAXPHASE )
+			return -EINVAL;
+
+	/* if the quartz is off by more than 10% something is VERY wrong ! */
+	if (txc->modes & ADJ_TICK)
+		if (txc->tick <  900000/USER_HZ ||
+		    txc->tick > 1100000/USER_HZ)
+			return -EINVAL;
+
+	write_seqlock_irq(&xtime_lock);
+	result = time_state;	/* mostly `TIME_OK' */
+
+	/* Save for later - semantics of adjtime is to return old value */
+	save_adjust = time_next_adjust ? time_next_adjust : time_adjust;
+
+#if 0	/* STA_CLOCKERR is never set yet */
+	time_status &= ~STA_CLOCKERR;		/* reset STA_CLOCKERR */
+#endif
+	/* If there are input parameters, then process them */
+	if (txc->modes)
+	{
+	    if (txc->modes & ADJ_STATUS)	/* only set allowed bits */
+		time_status =  (txc->status & ~STA_RONLY) |
+			      (time_status & STA_RONLY);
+
+	    if (txc->modes & ADJ_FREQUENCY) {	/* p. 22 */
+		if (txc->freq > MAXFREQ || txc->freq < -MAXFREQ) {
+		    result = -EINVAL;
+		    goto leave;
+		}
+		time_freq = txc->freq;
+	    }
+
+	    if (txc->modes & ADJ_MAXERROR) {
+		if (txc->maxerror < 0 || txc->maxerror >= NTP_PHASE_LIMIT) {
+		    result = -EINVAL;
+		    goto leave;
+		}
+		time_maxerror = txc->maxerror;
+	    }
+
+	    if (txc->modes & ADJ_ESTERROR) {
+		if (txc->esterror < 0 || txc->esterror >= NTP_PHASE_LIMIT) {
+		    result = -EINVAL;
+		    goto leave;
+		}
+		time_esterror = txc->esterror;
+	    }
+
+	    if (txc->modes & ADJ_TIMECONST) {	/* p. 24 */
+		if (txc->constant < 0) {	/* NTP v4 uses values > 6 */
+		    result = -EINVAL;
+		    goto leave;
+		}
+		time_constant = txc->constant;
+	    }
+
+	    if (txc->modes & ADJ_OFFSET) {	/* values checked earlier */
+		if (txc->modes == ADJ_OFFSET_SINGLESHOT) {
+		    /* adjtime() is independent from ntp_adjtime() */
+		    if ((time_next_adjust = txc->offset) == 0)
+			 time_adjust = 0;
+		}
+		else if (time_status & STA_PLL) {
+		    ltemp = txc->offset;
+
+		    /*
+		     * Scale the phase adjustment and
+		     * clamp to the operating range.
+		     */
+		    if (ltemp > MAXPHASE)
+		        time_offset = MAXPHASE << SHIFT_UPDATE;
+		    else if (ltemp < -MAXPHASE)
+			time_offset = -(MAXPHASE << SHIFT_UPDATE);
+		    else
+		        time_offset = ltemp << SHIFT_UPDATE;
+
+		    /*
+		     * Select whether the frequency is to be controlled
+		     * and in which mode (PLL or FLL). Clamp to the operating
+		     * range. Ugly multiply/divide should be replaced someday.
+		     */
+
+		    if (time_status & STA_FREQHOLD || time_reftime == 0)
+		        time_reftime = xtime.tv_sec;
+		    mtemp = xtime.tv_sec - time_reftime;
+		    time_reftime = xtime.tv_sec;
+		    if (time_status & STA_FLL) {
+		        if (mtemp >= MINSEC) {
+			    ltemp = (time_offset / mtemp) << (SHIFT_USEC -
+							      SHIFT_UPDATE);
+			    time_freq += shift_right(ltemp, SHIFT_KH);
+			} else /* calibration interval too short (p. 12) */
+				result = TIME_ERROR;
+		    } else {	/* PLL mode */
+		        if (mtemp < MAXSEC) {
+			    ltemp *= mtemp;
+			    time_freq += shift_right(ltemp,(time_constant +
+						       time_constant +
+						       SHIFT_KF - SHIFT_USEC));
+			} else /* calibration interval too long (p. 12) */
+				result = TIME_ERROR;
+		    }
+		    time_freq = min(time_freq, time_tolerance);
+		    time_freq = max(time_freq, -time_tolerance);
+		} /* STA_PLL */
+	    } /* txc->modes & ADJ_OFFSET */
+	    if (txc->modes & ADJ_TICK) {
+		tick_usec = txc->tick;
+		tick_nsec = TICK_USEC_TO_NSEC(tick_usec);
+	    }
+	} /* txc->modes */
+leave:	if ((time_status & (STA_UNSYNC|STA_CLOCKERR)) != 0)
+		result = TIME_ERROR;
+
+	if ((txc->modes & ADJ_OFFSET_SINGLESHOT) == ADJ_OFFSET_SINGLESHOT)
+	    txc->offset	   = save_adjust;
+	else {
+	    txc->offset = shift_right(time_offset, SHIFT_UPDATE);
+	}
+	txc->freq	   = time_freq;
+	txc->maxerror	   = time_maxerror;
+	txc->esterror	   = time_esterror;
+	txc->status	   = time_status;
+	txc->constant	   = time_constant;
+	txc->precision	   = time_precision;
+	txc->tolerance	   = time_tolerance;
+	txc->tick	   = tick_usec;
+
+	/* PPS is not implemented, so these are zero */
+	txc->ppsfreq	   = 0;
+	txc->jitter	   = 0;
+	txc->shift	   = 0;
+	txc->stabil	   = 0;
+	txc->jitcnt	   = 0;
+	txc->calcnt	   = 0;
+	txc->errcnt	   = 0;
+	txc->stbcnt	   = 0;
+	write_sequnlock_irq(&xtime_lock);
+	do_gettimeofday(&txc->time);
+	notify_arch_cmos_timer();
+	return(result);
+}
diff --git a/kernel/timer.c b/kernel/timer.c
index 2a87430..3814053 100644
--- a/kernel/timer.c
+++ b/kernel/timer.c
@@ -581,209 +581,6 @@ struct timespec wall_to_monotonic __attr
 
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
-	long ltemp;
-
-	/* Bump the maxerror field */
-	time_maxerror += time_tolerance >> SHIFT_USEC;
-	if (time_maxerror > NTP_PHASE_LIMIT) {
-		time_maxerror = NTP_PHASE_LIMIT;
-		time_status |= STA_UNSYNC;
-	}
-
-	/*
-	 * Leap second processing. If in leap-insert state at the end of the
-	 * day, the system clock is set back one second; if in leap-delete
-	 * state, the system clock is set ahead one second. The microtime()
-	 * routine or external clock driver will insure that reported time is
-	 * always monotonic. The ugly divides should be replaced.
-	 */
-	switch (time_state) {
-	case TIME_OK:
-		if (time_status & STA_INS)
-			time_state = TIME_INS;
-		else if (time_status & STA_DEL)
-			time_state = TIME_DEL;
-		break;
-	case TIME_INS:
-		if (xtime.tv_sec % 86400 == 0) {
-			xtime.tv_sec--;
-			wall_to_monotonic.tv_sec++;
-			/*
-			 * The timer interpolator will make time change
-			 * gradually instead of an immediate jump by one second
-			 */
-			time_interpolator_update(-NSEC_PER_SEC);
-			time_state = TIME_OOP;
-			clock_was_set();
-			printk(KERN_NOTICE "Clock: inserting leap second "
-					"23:59:60 UTC\n");
-		}
-		break;
-	case TIME_DEL:
-		if ((xtime.tv_sec + 1) % 86400 == 0) {
-			xtime.tv_sec++;
-			wall_to_monotonic.tv_sec--;
-			/*
-			 * Use of time interpolator for a gradual change of
-			 * time
-			 */
-			time_interpolator_update(NSEC_PER_SEC);
-			time_state = TIME_WAIT;
-			clock_was_set();
-			printk(KERN_NOTICE "Clock: deleting leap second "
-					"23:59:59 UTC\n");
-		}
-		break;
-	case TIME_OOP:
-		time_state = TIME_WAIT;
-		break;
-	case TIME_WAIT:
-		if (!(time_status & (STA_INS | STA_DEL)))
-		time_state = TIME_OK;
-	}
-
-	/*
-	 * Compute the phase adjustment for the next second. In PLL mode, the
-	 * offset is reduced by a fixed factor times the time constant. In FLL
-	 * mode the offset is used directly. In either mode, the maximum phase
-	 * adjustment for each second is clamped so as to spread the adjustment
-	 * over not more than the number of seconds between updates.
-	 */
-	ltemp = time_offset;
-	if (!(time_status & STA_FLL))
-		ltemp = shift_right(ltemp, SHIFT_KG + time_constant);
-	ltemp = min(ltemp, (MAXPHASE / MINSEC) << SHIFT_UPDATE);
-	ltemp = max(ltemp, -(MAXPHASE / MINSEC) << SHIFT_UPDATE);
-	time_offset -= ltemp;
-	time_adj = ltemp << (SHIFT_SCALE - SHIFT_HZ - SHIFT_UPDATE);
-
-	/*
-	 * Compute the frequency estimate and additional phase adjustment due
-	 * to frequency error for the next second.
-	 */
-	ltemp = time_freq;
-	time_adj += shift_right(ltemp,(SHIFT_USEC + SHIFT_HZ - SHIFT_SCALE));
-
-#if HZ == 100
-	/*
-	 * Compensate for (HZ==100) != (1 << SHIFT_HZ).  Add 25% and 3.125% to
-	 * get 128.125; => only 0.125% error (p. 14)
-	 */
-	time_adj += shift_right(time_adj, 2) + shift_right(time_adj, 5);
-#endif
-#if HZ == 250
-	/*
-	 * Compensate for (HZ==250) != (1 << SHIFT_HZ).  Add 1.5625% and
-	 * 0.78125% to get 255.85938; => only 0.05% error (p. 14)
-	 */
-	time_adj += shift_right(time_adj, 6) + shift_right(time_adj, 7);
-#endif
-#if HZ == 1000
-	/*
-	 * Compensate for (HZ==1000) != (1 << SHIFT_HZ).  Add 1.5625% and
-	 * 0.78125% to get 1023.4375; => only 0.05% error (p. 14)
-	 */
-	time_adj += shift_right(time_adj, 6) + shift_right(time_adj, 7);
-#endif
-}
-
-/*
- * Returns how many microseconds we need to add to xtime this tick
- * in doing an adjustment requested with adjtime.
- */
-static long adjtime_adjustment(void)
-{
-	long time_adjust_step;
-
-	time_adjust_step = time_adjust;
-	if (time_adjust_step) {
-		/*
-		 * We are doing an adjtime thing.  Prepare time_adjust_step to
-		 * be within bounds.  Note that a positive time_adjust means we
-		 * want the clock to run faster.
-		 *
-		 * Limit the amount of the step to be in the range
-		 * -tickadj .. +tickadj
-		 */
-		time_adjust_step = min(time_adjust_step, (long)tickadj);
-		time_adjust_step = max(time_adjust_step, (long)-tickadj);
-	}
-	return time_adjust_step;
-}
-
-/* in the NTP reference this is called "hardclock()" */
-static void update_ntp_one_tick(void)
-{
-	long time_adjust_step;
-
-	time_adjust_step = adjtime_adjustment();
-	if (time_adjust_step)
-		/* Reduce by this step the amount of time left  */
-		time_adjust -= time_adjust_step;
-
-	/* Changes by adjtime() do not take effect till next tick. */
-	if (time_next_adjust != 0) {
-		time_adjust = time_next_adjust;
-		time_next_adjust = 0;
-	}
-}
-
-/*
- * Return how long ticks are at the moment, that is, how much time
- * update_wall_time_one_tick will add to xtime next time we call it
- * (assuming no calls to do_adjtimex in the meantime).
- * The return value is in fixed-point nanoseconds shifted by the
- * specified number of bits to the right of the binary point.
- * This function has no side-effects.
- */
-u64 current_tick_length(void)
-{
-	long delta_nsec;
-	u64 ret;
-
-	/* calculate the finest interval NTP will allow.
-	 *    ie: nanosecond value shifted by (SHIFT_SCALE - 10)
-	 */
-	delta_nsec = tick_nsec + adjtime_adjustment() * 1000;
-	ret = (u64)delta_nsec << TICK_LENGTH_SHIFT;
-	ret += (s64)time_adj << (TICK_LENGTH_SHIFT - (SHIFT_SCALE - 10));
-
-	return ret;
-}
 
 /* XXX - all of this timekeeping code should be later moved to time.c */
 #include <linux/clocksource.h>


