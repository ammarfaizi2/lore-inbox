Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964782AbVKZOxI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964782AbVKZOxI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Nov 2005 09:53:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964785AbVKZOxH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Nov 2005 09:53:07 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:51156 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S964782AbVKZOxB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Nov 2005 09:53:01 -0500
Date: Sat, 26 Nov 2005 15:53:01 +0100
From: Ingo Molnar <mingo@elte.hu>
To: john stultz <johnstul@us.ibm.com>
Cc: lkml <linux-kernel@vger.kernel.org>, Darren Hart <dvhltc@us.ibm.com>,
       Nishanth Aravamudan <nacc@us.ibm.com>,
       Frank Sorenson <frank@tuxrocks.com>,
       George Anzinger <george@mvista.com>,
       Roman Zippel <zippel@linux-m68k.org>,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>,
       Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 2/13] Time: Reduced NTP Rework (part 2)
Message-ID: <20051126145301.GD12999@elte.hu>
References: <20051122013515.18537.76463.sendpatchset@cog.beaverton.ibm.com> <20051122013528.18537.70270.sendpatchset@cog.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051122013528.18537.70270.sendpatchset@cog.beaverton.ibm.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


- clean up code impacted by timeofday-ntp-part2.patch
- fix ntp_leapsecond() return

Signed-off-by: Ingo Molnar <mingo@elte.hu>

 include/linux/timex.h |   12 -
 kernel/time.c         |  347 ++++++++++++++++++++++++++++----------------------
 kernel/timer.c        |   20 +-
 3 files changed, 212 insertions(+), 167 deletions(-)

Index: linux/include/linux/timex.h
===================================================================
--- linux.orig/include/linux/timex.h
+++ linux/include/linux/timex.h
@@ -261,6 +261,7 @@ extern long pps_errcnt;		/* calibration 
 extern long pps_stbcnt;		/* stability limit exceeded */
 
 extern seqlock_t ntp_lock;
+
 /**
  * ntp_clear - Clears the NTP state variables
  *
@@ -269,13 +270,13 @@ extern seqlock_t ntp_lock;
 static inline void ntp_clear(void)
 {
 	unsigned long flags;
+
 	write_seqlock_irqsave(&ntp_lock, flags);
 	time_adjust = 0;		/* stop active adjtime() */
 	time_status |= STA_UNSYNC;
 	time_maxerror = NTP_PHASE_LIMIT;
 	time_esterror = NTP_PHASE_LIMIT;
 	write_sequnlock_irqrestore(&ntp_lock, flags);
-
 }
 
 /**
@@ -289,21 +290,18 @@ static inline int ntp_synced(void)
 
 /**
  * ntp_get_ppm_adjustment - Returns Shifted PPM adjustment
- *
  */
-long ntp_get_ppm_adjustment(void);
+extern long ntp_get_ppm_adjustment(void);
 
 /**
  * ntp_advance - Advances the NTP state machine by interval_ns
- *
  */
-void ntp_advance(unsigned long interval_ns);
+extern void ntp_advance(unsigned long interval_ns);
 
 /**
  * ntp_leapsecond - NTP leapsecond processing code.
- *
  */
-int ntp_leapsecond(struct timespec now);
+extern int ntp_leapsecond(struct timespec now);
 
 
 /* Required to safely shift negative values */
Index: linux/kernel/time.c
===================================================================
--- linux.orig/kernel/time.c
+++ linux/kernel/time.c
@@ -241,201 +241,246 @@ void __attribute__ ((weak)) notify_arch_
 	return;
 }
 
-/* adjtimex mainly allows reading (and writing, if superuser) of
- * kernel time-keeping variables. used by xntpd.
+static inline int
+process_adj_offset(const struct timex *txc, const struct timespec now,
+		   int result)
+{
+	long ltemp, mtemp;
+
+	/* note: txc values were checked earlier. */
+
+	if (txc->modes == ADJ_OFFSET_SINGLESHOT) {
+		/* adjtime() is independent from ntp_adjtime() */
+		time_next_adjust = txc->offset;
+		if (time_next_adjust == 0)
+			time_adjust = 0;
+		return result;
+	}
+
+	if (!(time_status & (STA_PLL | STA_PPSTIME)))
+		return result;
+
+	if ((time_status & (STA_PPSTIME | STA_PPSSIGNAL)) ==
+				(STA_PPSTIME | STA_PPSSIGNAL))
+		ltemp = pps_offset;
+	else
+		ltemp = txc->offset;
+
+	/* scale the phase adjustment and clamp to the operating range: */
+	if (ltemp > MAXPHASE)
+		time_offset = MAXPHASE << SHIFT_UPDATE;
+	else {
+		if (ltemp < -MAXPHASE)
+			time_offset = -(MAXPHASE << SHIFT_UPDATE);
+		else
+			time_offset = ltemp << SHIFT_UPDATE;
+	}
+
+	/*
+	 * select whether the frequency is to be controlled
+	 * and in which mode (PLL or FLL). Clamp to the operating
+	 * range. Ugly multiply/divide should be replaced someday.
+	 */
+	if ((time_status & STA_FREQHOLD) || (time_reftime == 0))
+		time_reftime = now.tv_sec;
+
+	mtemp = now.tv_sec - time_reftime;
+	time_reftime = now.tv_sec;
+
+	if (time_status & STA_FLL) { /* FLL mode: */
+		if (mtemp >= MINSEC) {
+			ltemp = (time_offset / mtemp) <<
+						(SHIFT_USEC - SHIFT_UPDATE);
+			time_freq += shift_right(ltemp, SHIFT_KH);
+		} else /* calibration interval too short (p. 12): */
+			result = TIME_ERROR;
+	} else { /* PLL mode: */
+		if (mtemp < MAXSEC) {
+			ltemp *= mtemp;
+			/* TODO: is 2*time_constant correct? --mingo */
+			time_freq += shift_right(ltemp, 2*time_constant +
+						SHIFT_KF - SHIFT_USEC);
+		} else /* calibration interval too long (p. 12) */
+			result = TIME_ERROR;
+	}
+
+	time_freq = min(time_freq, time_tolerance);
+	time_freq = max(time_freq, -time_tolerance);
+
+	return result;
+}
+
+static inline int
+process_input_params(const struct timex *txc, const struct timespec now,
+		     int result)
+{
+	if (txc->modes & ADJ_STATUS)
+		/* only set allowed bits: */
+		time_status = (txc->status & ~STA_RONLY) |
+				(time_status & STA_RONLY);
+
+	if (txc->modes & ADJ_FREQUENCY) {	/* p. 22 */
+		if (txc->freq > MAXFREQ || txc->freq < -MAXFREQ)
+			return -EINVAL;
+		time_freq = txc->freq - pps_freq;
+	}
+
+	if (txc->modes & ADJ_MAXERROR) {
+		if (txc->maxerror < 0 || txc->maxerror >= NTP_PHASE_LIMIT)
+			return -EINVAL;
+		time_maxerror = txc->maxerror;
+	}
+
+	if (txc->modes & ADJ_ESTERROR) {
+		if (txc->esterror < 0 || txc->esterror >= NTP_PHASE_LIMIT)
+			return -EINVAL;
+		time_esterror = txc->esterror;
+	}
+
+	if (txc->modes & ADJ_TIMECONST) {	/* p. 24 */
+		/* NTP v4 uses values > 6 */
+		if (txc->constant < 0)
+			return -EINVAL;
+		time_constant = txc->constant;
+	}
+
+	if (txc->modes & ADJ_OFFSET)
+		result = process_adj_offset(txc, now, result);
+
+	if (txc->modes & ADJ_TICK) {
+		tick_usec = txc->tick;
+		tick_nsec = TICK_USEC_TO_NSEC(tick_usec);
+	}
+
+	return result;
+}
+
+/**
+ * do_adjtimex - allows reading (and writing, if superuser) of
+ *		 kernel time-keeping variables. Used by xntpd.
+ * @txc: time-adjustments settings structure
  */
 int do_adjtimex(struct timex *txc)
 {
-        long ltemp, mtemp, save_adjust;
+	unsigned long flags, seq;
+	struct timespec now;
+	long save_adjust;
 	int result;
-	unsigned long flags;
-	struct timespec now_ts;
-	unsigned long seq;
-	/* In order to modify anything, you gotta be super-user! */
+
+	/* in order to modify anything, you gotta be super-user! */
 	if (txc->modes && !capable(CAP_SYS_TIME))
 		return -EPERM;
 		
-	/* Now we validate the data before disabling interrupts */
-
+	/* now we validate the data before disabling interrupts: */
 	if ((txc->modes & ADJ_OFFSET_SINGLESHOT) == ADJ_OFFSET_SINGLESHOT)
-	  /* singleshot must not be used with any other mode bits */
+		/* singleshot must not be used with any other mode bits: */
 		if (txc->modes != ADJ_OFFSET_SINGLESHOT)
 			return -EINVAL;
 
 	if (txc->modes != ADJ_OFFSET_SINGLESHOT && (txc->modes & ADJ_OFFSET))
-	  /* adjustment Offset limited to +- .512 seconds */
+		/* adjustment offset limited to +- .512 seconds: */
 		if (txc->offset <= - MAXPHASE || txc->offset >= MAXPHASE )
 			return -EINVAL;	
 
 	/* if the quartz is off by more than 10% something is VERY wrong ! */
 	if (txc->modes & ADJ_TICK)
-		if (txc->tick <  900000/USER_HZ ||
-		    txc->tick > 1100000/USER_HZ)
+		if (txc->tick < 900000/USER_HZ || txc->tick > 1100000/USER_HZ)
 			return -EINVAL;
 
-	do { /* save off current xtime */
+	/*
+	 * TODO: shouldnt we write-lock xtime_lock below, and then
+	 * lock the ntp lock, and do the whole adjustment from under
+	 * the xtime lock and the ntp lock? --mingo
+	 */
+
+	/* save current xtime: */
+	do {
 		seq = read_seqbegin(&xtime_lock);
-		now_ts = xtime;
+		now = xtime;
 	} while (read_seqretry(&xtime_lock, seq));
 
 	write_seqlock_irqsave(&ntp_lock, flags);
 
 	result = time_state;	/* mostly `TIME_OK' */
 
-	/* Save for later - semantics of adjtime is to return old value */
-	save_adjust = time_next_adjust ? time_next_adjust : time_adjust;
+	/* save for later - semantics of adjtime is to return old value: */
+	if (time_next_adjust)
+		save_adjust = time_next_adjust;
+	else
+		save_adjust = time_adjust;
 
-#if 0	/* STA_CLOCKERR is never set yet */
-	time_status &= ~STA_CLOCKERR;		/* reset STA_CLOCKERR */
-#endif
-	/* If there are input parameters, then process them */
+	/* process input parameters: */
 	if (txc->modes)
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
+		result = process_input_params(txc, now, result);
 
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
-		        time_reftime = now_ts.tv_sec;
-		    mtemp = now_ts.tv_sec - time_reftime;
-		    time_reftime = now_ts.tv_sec;
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
+	if ((time_status & (STA_UNSYNC|STA_CLOCKERR)) != 0
+		|| ((time_status & (STA_PPSFREQ|STA_PPSTIME)) != 0
+			&& (time_status & STA_PPSSIGNAL) == 0)
+		/* p. 24, (b) */
+		|| ((time_status & (STA_PPSTIME|STA_PPSJITTER))
+			== (STA_PPSTIME|STA_PPSJITTER))
+		/* p. 24, (c) */
+		|| ((time_status & STA_PPSFREQ) != 0
+			&& (time_status & (STA_PPSWANDER|STA_PPSERROR)) != 0))
+		/* p. 24, (d) */
 		result = TIME_ERROR;
 	
 	if ((txc->modes & ADJ_OFFSET_SINGLESHOT) == ADJ_OFFSET_SINGLESHOT)
-	    txc->offset	   = save_adjust;
-	else {
-	    txc->offset = shift_right(time_offset, SHIFT_UPDATE);
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
+		txc->offset = save_adjust;
+	else
+		txc->offset = shift_right(time_offset, SHIFT_UPDATE);
+
+	txc->freq	= time_freq + pps_freq;
+	txc->maxerror	= time_maxerror;
+	txc->esterror	= time_esterror;
+	txc->status	= time_status;
+	txc->constant	= time_constant;
+	txc->precision	= time_precision;
+	txc->tolerance	= time_tolerance;
+	/*
+	 * TODO: shouldnt txc->time be filled in here, within ntp_lock and
+	 * xtime_lock, to get an atomic snapshot of time state? --mingo
+	 */
+	txc->tick	= tick_usec;
+	txc->ppsfreq	= pps_freq;
+	txc->jitter	= pps_jitter >> PPS_AVG;
+	txc->shift	= pps_shift;
+	txc->stabil	= pps_stabil;
+	txc->jitcnt	= pps_jitcnt;
+	txc->calcnt	= pps_calcnt;
+	txc->errcnt	= pps_errcnt;
+	txc->stbcnt	= pps_stbcnt;
+
 	write_sequnlock_irqrestore(&ntp_lock, flags);
+
 	do_gettimeofday(&txc->time);
+
 	notify_arch_cmos_timer();
-	return(result);
+
+	return result;
 }
 
 asmlinkage long sys_adjtimex(struct timex __user *txc_p)
 {
-	struct timex txc;		/* Local copy of parameter */
+	struct timex txc;
 	int ret;
 
-	/* Copy the user data space into the kernel copy
-	 * structure. But bear in mind that the structures
-	 * may change
+	/*
+	 * copy the user data space into the kernel copy
+	 * structure:
 	 */
-	if(copy_from_user(&txc, txc_p, sizeof(struct timex)))
+	if (copy_from_user(&txc, txc_p, sizeof(struct timex)))
 		return -EFAULT;
+
 	ret = do_adjtimex(&txc);
-	return copy_to_user(txc_p, &txc, sizeof(struct timex)) ? -EFAULT : ret;
+
+	/*
+	 * copy the results back to userspace (even if there was an error):
+	 */
+	if (copy_to_user(txc_p, &txc, sizeof(struct timex)))
+		ret = -EFAULT;
+
+	return ret;
 }
 
 inline struct timespec current_kernel_time(void)
Index: linux/kernel/timer.c
===================================================================
--- linux.orig/kernel/timer.c
+++ linux/kernel/timer.c
@@ -630,9 +630,9 @@ long offset_adj_ppm;
 long tick_adj_ppm;
 long singleshot_adj_ppm;
 
-#define MAX_SINGLESHOT_ADJ 500 /* (ppm) */
-#define SEC_PER_DAY 86400
-#define END_OF_DAY(x) (x + SEC_PER_DAY - (x % SEC_PER_DAY) - 1)
+#define MAX_SINGLESHOT_ADJ	500	/* (ppm) */
+#define SEC_PER_DAY		86400
+#define END_OF_DAY(x)		((x) + SEC_PER_DAY - ((x) % SEC_PER_DAY) - 1)
 
 /* NTP lock, protects NTP state machine */
 seqlock_t ntp_lock = SEQLOCK_UNLOCKED;
@@ -645,10 +645,8 @@ seqlock_t ntp_lock = SEQLOCK_UNLOCKED;
  * should be added to the current time to properly
  * adjust for leapseconds.
  */
-
 int ntp_leapsecond(struct timespec now)
 {
-	unsigned long flags;
 	/*
 	 * Leap second processing. If in leap-insert state at
 	 * the end of the day, the system clock is set back one
@@ -656,9 +654,12 @@ int ntp_leapsecond(struct timespec now)
 	 * set ahead one second.
 	 */
 	static time_t leaptime = 0;
+
+	unsigned long flags;
 	int ret = 0;
 
 	write_seqlock_irqsave(&ntp_lock, flags);
+
 	switch (time_state) {
 
 	case TIME_OK:
@@ -690,7 +691,7 @@ int ntp_leapsecond(struct timespec now)
 		break;
 
 	case TIME_OOP:
-		/*  Wait for the end of the leap second*/
+		/* Wait for the end of the leap second*/
 		if (now.tv_sec > (leaptime + 1))
 			time_state = TIME_WAIT;
 		time_state = TIME_WAIT;
@@ -703,7 +704,8 @@ int ntp_leapsecond(struct timespec now)
 	}
 
 	write_sequnlock_irqrestore(&ntp_lock, flags);
-	return 0;
+
+	return ret;
 }
 
 /*
@@ -802,9 +804,9 @@ static void second_overflow(void)
 
 	offset_adj_ppm = shift_right(ltemp, SHIFT_UPDATE); /* ppm */
 
-	/* first calculate usec/user_tick offset */
+	/* first calculate usec/user_tick offset: */
 	tick_adj_ppm = ((USEC_PER_SEC + USER_HZ/2)/USER_HZ) - tick_usec;
-	/* multiply by user_hz to get usec/sec => ppm */
+	/* multiply by user_hz to get usec/sec => ppm: */
 	tick_adj_ppm *= USER_HZ;
 
 	/*
