Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263619AbTETHOB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 May 2003 03:14:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263620AbTETHOB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 May 2003 03:14:01 -0400
Received: from palrel13.hp.com ([156.153.255.238]:26496 "EHLO palrel13.hp.com")
	by vger.kernel.org with ESMTP id S263619AbTETHNj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 May 2003 03:13:39 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16073.55453.520704.383349@napali.hpl.hp.com>
Date: Tue, 20 May 2003 00:26:21 -0700
To: Andrew Morton <akpm@digeo.com>
Cc: davidm@hpl.hp.com, arjanv@redhat.com, davem@redhat.com, ak@muc.de,
       johnstul@us.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: time interpolation hooks
In-Reply-To: <20030519115709.0701a1c3.akpm@digeo.com>
References: <20030516142311.3844ee97.akpm@digeo.com>
	<16069.24454.349874.198470@napali.hpl.hp.com>
	<1053139080.7308.6.camel@rth.ninka.net>
	<16073.5555.158600.61609@napali.hpl.hp.com>
	<20030519174203.A7061@devserv.devel.redhat.com>
	<16073.9205.641605.741130@napali.hpl.hp.com>
	<20030519115709.0701a1c3.akpm@digeo.com>
X-Mailer: VM 7.07 under Emacs 21.2.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OK, here is an updated patch relative to 2.5.69.  I think it
incorporates all the feedback I received so far.  I included the
ia64-specific portions for illustration only.  There is some
extraneous changes in the ia64 patches and if you'd rather look at the
final files, you can do so at:

	http://lia64.bkbits.net:8080/linux-ia64-2.5/src

In this patch, I use the following (simple) heuristic in choosing the
best time interpolator: an interpolator which runs at more than twice
the frequency of the existing interpolator or has a smaller drift is
considered "better" (yeah, this needs to be improved, but it's good
enough to get started...).

I don't have any hardware where I could use a time-interpolation
driver, so unregister_time_interpolator() is completely untested at
the moment and hence probably broken.

I'd be very much interested in hearing how this works for others
(especially on non-ia64 platforms).  If you have any questions on how
the callbacks need to work, let me know.

	--david

diff -Nru a/include/linux/timex.h b/include/linux/timex.h
--- a/include/linux/timex.h	Tue May 20 00:03:28 2003
+++ b/include/linux/timex.h	Tue May 20 00:03:28 2003
@@ -51,6 +51,9 @@
 #ifndef _LINUX_TIMEX_H
 #define _LINUX_TIMEX_H
 
+#include <linux/config.h>
+#include <linux/compiler.h>
+
 #include <asm/param.h>
 
 /*
@@ -309,6 +312,105 @@
 extern long pps_calcnt;		/* calibration intervals */
 extern long pps_errcnt;		/* calibration errors */
 extern long pps_stbcnt;		/* stability limit exceeded */
+
+#ifdef CONFIG_TIME_INTERPOLATION
+
+struct time_interpolator {
+	/* cache-hot stuff first: */
+	unsigned long (*get_offset) (void);
+	void (*update) (long);
+	void (*reset) (void);
+
+	/* cache-cold stuff follows here: */
+	struct time_interpolator *next;
+	unsigned long frequency;	/* frequency in counts/second */
+	long drift;			/* drift in parts-per-million (or -1) */
+};
+
+extern volatile unsigned long last_nsec_offset;
+#ifndef __HAVE_ARCH_CMPXCHG
+extern spin_lock_t last_nsec_offset_lock;
+#endif
+extern struct time_interpolator *time_interpolator;
+
+extern void register_time_interpolator (struct time_interpolator *);
+extern void unregister_time_interpolator (struct time_interpolator *);
+
+/* Called with xtime WRITE-lock acquired.  */
+static inline void
+time_interpolator_update (long delta_nsec)
+{
+	struct time_interpolator *ti = time_interpolator;
+
+	if (last_nsec_offset > 0) {
+#ifdef __HAVE_ARCH_CMPXCHG
+		unsigned long new, old;
+
+		do {
+			old = last_nsec_offset;
+			if (old > delta_nsec)
+				new = old - delta_nsec;
+			else
+				new = 0;
+		} while (cmpxchg(&last_nsec_offset, old, new) != old);
+#else
+		/*
+		 * This really hurts, because it serializes gettimeofday(), but without an
+		 * atomic single-word compare-and-exchange, there isn't all that much else
+		 * we can do.
+		 */
+		spin_lock(&last_nsec_offset_lock);
+		{
+			last_nsec_offset -= min(last_nsec_offset, delta_nsec);
+		}
+		spin_unlock(&last_nsec_offset_lock);
+#endif
+	}
+
+	if (ti)
+		(*ti->update)(delta_nsec);
+}
+
+/* Called with xtime WRITE-lock acquired.  */
+static inline void
+time_interpolator_reset (void)
+{
+	struct time_interpolator *ti = time_interpolator;
+
+	last_nsec_offset = 0;
+	if (ti)
+		(*ti->reset)();
+}
+
+/* Called with xtime READ-lock acquired.  */
+static inline unsigned long
+time_interpolator_get_offset (void)
+{
+	struct time_interpolator *ti = time_interpolator;
+	if (ti)
+		return (*ti->get_offset)();
+	return last_nsec_offset;
+}
+
+#else /* !CONFIG_TIME_INTERPOLATION */
+
+static inline void
+time_interpolator_update (long delta_nsec)
+{
+}
+
+static inline void
+time_interpolator_reset (void)
+{
+}
+
+static inline unsigned long
+time_interpolator_get_offset (void)
+{
+	return 0;
+}
+
+#endif /* !CONFIG_TIME_INTERPOLATION */
 
 #endif /* KERNEL */
 
diff -Nru a/kernel/time.c b/kernel/time.c
--- a/kernel/time.c	Tue May 20 00:03:29 2003
+++ b/kernel/time.c	Tue May 20 00:03:29 2003
@@ -35,8 +35,6 @@
  */
 struct timezone sys_tz;
 
-extern unsigned long last_time_offset;
-
 #if !defined(__alpha__) && !defined(__ia64__)
 
 /*
@@ -77,9 +75,10 @@
 	if (get_user(value, tptr))
 		return -EFAULT;
 	write_seqlock_irq(&xtime_lock);
+
+	time_interpolator_reset();
 	xtime.tv_sec = value;
 	xtime.tv_nsec = 0;
-	last_time_offset = 0;
 	time_adjust = 0;	/* stop active adjtime() */
 	time_status |= STA_UNSYNC;
 	time_maxerror = NTP_PHASE_LIMIT;
@@ -125,7 +124,7 @@
 {
 	write_seqlock_irq(&xtime_lock);
 	xtime.tv_sec += sys_tz.tz_minuteswest * 60;
-	last_time_offset = 0;
+	time_interpolator_update(sys_tz.tz_minuteswest * 60 * NSEC_PER_SEC);
 	write_sequnlock_irq(&xtime_lock);
 }
 
@@ -381,7 +380,6 @@
 	txc->calcnt	   = pps_calcnt;
 	txc->errcnt	   = pps_errcnt;
 	txc->stbcnt	   = pps_stbcnt;
-	last_time_offset = 0;
 	write_sequnlock_irq(&xtime_lock);
 	do_gettimeofday(&txc->time);
 	return(result);
diff -Nru a/kernel/timer.c b/kernel/timer.c
--- a/kernel/timer.c	Tue May 20 00:03:29 2003
+++ b/kernel/timer.c	Tue May 20 00:03:29 2003
@@ -517,6 +517,7 @@
 	if (xtime.tv_sec % 86400 == 0) {
 	    xtime.tv_sec--;
 	    wall_to_monotonic.tv_sec++;
+	    time_interpolator_update(-NSEC_PER_SEC);
 	    time_state = TIME_OOP;
 	    clock_was_set();
 	    printk(KERN_NOTICE "Clock: inserting leap second 23:59:60 UTC\n");
@@ -527,6 +528,7 @@
 	if ((xtime.tv_sec + 1) % 86400 == 0) {
 	    xtime.tv_sec++;
 	    wall_to_monotonic.tv_sec--;
+	    time_interpolator_update(NSEC_PER_SEC);
 	    time_state = TIME_WAIT;
 	    clock_was_set();
 	    printk(KERN_NOTICE "Clock: deleting leap second 23:59:59 UTC\n");
@@ -605,7 +607,7 @@
 /* in the NTP reference this is called "hardclock()" */
 static void update_wall_time_one_tick(void)
 {
-	long time_adjust_step;
+	long time_adjust_step, delta_nsec;
 
 	if ( (time_adjust_step = time_adjust) != 0 ) {
 	    /* We are doing an adjtime thing. 
@@ -621,11 +623,11 @@
 		time_adjust_step = tickadj;
 	     else if (time_adjust < -tickadj)
 		time_adjust_step = -tickadj;
-	     
+
 	    /* Reduce by this step the amount of time left  */
 	    time_adjust -= time_adjust_step;
 	}
-	xtime.tv_nsec += tick_nsec + time_adjust_step * 1000;
+	delta_nsec = tick_nsec + time_adjust_step * 1000;
 	/*
 	 * Advance the phase, once it gets to one microsecond, then
 	 * advance the tick more.
@@ -634,13 +636,15 @@
 	if (time_phase <= -FINEUSEC) {
 		long ltemp = -time_phase >> (SHIFT_SCALE - 10);
 		time_phase += ltemp << (SHIFT_SCALE - 10);
-		xtime.tv_nsec -= ltemp;
+		delta_nsec -= ltemp;
 	}
 	else if (time_phase >= FINEUSEC) {
 		long ltemp = time_phase >> (SHIFT_SCALE - 10);
 		time_phase -= ltemp << (SHIFT_SCALE - 10);
-		xtime.tv_nsec += ltemp;
+		delta_nsec += ltemp;
 	}
+	xtime.tv_nsec += delta_nsec;
+	time_interpolator_update(delta_nsec);
 }
 
 /*
@@ -660,6 +664,7 @@
 	if (xtime.tv_nsec >= 1000000000) {
 	    xtime.tv_nsec -= 1000000000;
 	    xtime.tv_sec++;
+	    time_interpolator_update(NSEC_PER_SEC);
 	    second_overflow();
 	}
 }
@@ -777,7 +782,6 @@
 #ifndef ARCH_HAVE_XTIME_LOCK
 seqlock_t xtime_lock __cacheline_aligned_in_smp = SEQLOCK_UNLOCKED;
 #endif
-unsigned long last_time_offset;
 
 /*
  * This function runs timers and the timer-tq in bottom half context.
@@ -811,7 +815,6 @@
 		wall_jiffies += ticks;
 		update_wall_time(ticks);
 	}
-	last_time_offset = 0;
 	calc_load(ticks);
 }
   
@@ -1221,3 +1224,80 @@
 	register_cpu_notifier(&timers_nb);
 	open_softirq(TIMER_SOFTIRQ, run_timer_softirq, NULL);
 }
+
+#ifdef CONFIG_TIME_INTERPOLATION
+
+volatile unsigned long last_nsec_offset;
+
+struct time_interpolator *time_interpolator;
+
+#ifndef __HAVE_ARCH_CMPXCHG
+spinlock_t last_nsec_offset_lock = SPIN_LOCK_UNLOCKED;
+#endif
+
+static struct {
+	spinlock_t lock;		/* lock protecting list */
+	struct time_interpolator *list;	/* list of registered interpolators */
+} ti_global = {
+	.lock = SPIN_LOCK_UNLOCKED
+};
+
+static inline int
+is_better_time_interpolator (struct time_interpolator *new)
+{
+	if (!time_interpolator)
+		return 1;
+	return new->frequency > 2*time_interpolator->frequency
+		|| (unsigned long) new->drift < (unsigned long) time_interpolator->drift;
+}
+
+void
+register_time_interpolator (struct time_interpolator *ti)
+{
+	spin_lock(&ti_global.lock);
+	{
+		write_seqlock_irq(&xtime_lock);
+		{
+			if (is_better_time_interpolator(ti))
+				time_interpolator = ti;
+		}
+		write_sequnlock_irq(&xtime_lock);
+
+		ti->next = ti_global.list;
+		ti_global.list = ti;
+	}
+	spin_unlock(&ti_global.lock);
+}
+
+void
+unregister_time_interpolator (struct time_interpolator *ti)
+{
+	struct time_interpolator *curr, **prev;
+
+	spin_lock(&ti_global.lock);
+	{
+		prev = &ti_global.list;
+		for (curr = *prev; curr; curr = curr->next) {
+			if (curr == ti) {
+				*prev = curr->next;
+				break;
+			}
+			prev = &curr->next;
+		}
+		write_seqlock_irq(&xtime_lock);
+		{
+			if (ti == time_interpolator) {
+				/* we lost the best time-interpolator: */
+				time_interpolator = NULL;
+				/* find the next-best interpolator */
+				for (curr = ti_global.list; curr; curr = curr->next)
+					if (is_better_time_interpolator(curr))
+						time_interpolator = curr;
+			}
+		}
+		write_sequnlock_irq(&xtime_lock);
+	}
+	spin_unlock(&ti_global.lock);
+}
+
+#endif /* CONFIG_TIME_INTERPOLATION */
diff -Nru a/arch/ia64/Kconfig b/arch/ia64/Kconfig
--- a/arch/ia64/Kconfig	Tue May 20 00:03:30 2003
+++ b/arch/ia64/Kconfig	Tue May 20 00:03:30 2003
@@ -26,6 +26,10 @@
 	bool
 	default y
 
+config TIME_INTERPOLATION
+	bool
+	default y
+
 choice
 	prompt "IA-64 processor type"
 	default ITANIUM
diff -Nru a/arch/ia64/kernel/time.c b/arch/ia64/kernel/time.c
--- a/arch/ia64/kernel/time.c	Tue May 20 00:03:28 2003
+++ b/arch/ia64/kernel/time.c	Tue May 20 00:03:28 2003
@@ -17,6 +17,7 @@
 #include <linux/time.h>
 #include <linux/interrupt.h>
 #include <linux/efi.h>
+#include <linux/timex.h>
 
 #include <asm/delay.h>
 #include <asm/hw_irq.h>
@@ -25,10 +26,11 @@
 #include <asm/system.h>
 
 extern unsigned long wall_jiffies;
-extern unsigned long last_nsec_offset;
 
 u64 jiffies_64 = INITIAL_JIFFIES;
 
+#define TIME_KEEPER_ID	0	/* smp_processor_id() of time-keeper */
+
 #ifdef CONFIG_IA64_DEBUG_IRQ
 
 unsigned long last_cli_ip;
@@ -59,19 +61,32 @@
 	atomic_inc((atomic_t *) &prof_buffer[ip]);
 }
 
+static void
+itc_reset (void)
+{
+}
+
+/*
+ * Adjust for the fact that xtime has been advanced by delta_nsec (may be negative and/or
+ * larger than NSEC_PER_SEC.
+ */
+static void
+itc_update (long delta_nsec)
+{
+}
+
 /*
  * Return the number of nano-seconds that elapsed since the last update to jiffy.  The
  * xtime_lock must be at least read-locked when calling this routine.
  */
-static inline unsigned long
-gettimeoffset (void)
+unsigned long
+itc_get_offset (void)
 {
 	unsigned long elapsed_cycles, lost = jiffies - wall_jiffies;
 	unsigned long now, last_tick;
-#	define time_keeper_id	0	/* smp_processor_id() of time-keeper */
 
-	last_tick = (cpu_data(time_keeper_id)->itm_next
-		     - (lost + 1)*cpu_data(time_keeper_id)->itm_delta);
+	last_tick = (cpu_data(TIME_KEEPER_ID)->itm_next
+		     - (lost + 1)*cpu_data(TIME_KEEPER_ID)->itm_delta);
 
 	now = ia64_get_itc();
 	if (unlikely((long) (now - last_tick) < 0)) {
@@ -83,11 +98,32 @@
 	return (elapsed_cycles*local_cpu_data->nsec_per_cyc) >> IA64_NSEC_PER_CYC_SHIFT;
 }
 
+static struct time_interpolator itc_interpolator = {
+	.get_offset =	itc_get_offset,
+	.update =	itc_update,
+	.reset =	itc_reset
+};
+
+static inline void
+set_normalized_timespec (struct timespec *ts, time_t sec, long nsec)
+{
+	while (nsec > NSEC_PER_SEC) {
+		nsec -= NSEC_PER_SEC;
+		++sec;
+	}
+	while (nsec < 0) {
+		nsec += NSEC_PER_SEC;
+		--sec;
+	}
+	ts->tv_sec = sec;
+	ts->tv_nsec = nsec;
+}
+
 void
 do_settimeofday (struct timeval *tv)
 {
-	time_t sec = tv->tv_sec;
-	long nsec = tv->tv_usec * 1000;
+	time_t wtm_sec, sec = tv->tv_sec;
+	long wtm_nsec, nsec = tv->tv_usec * 1000;
 
 	write_seqlock_irq(&xtime_lock);
 	{
@@ -97,19 +133,19 @@
 		 * Discover what correction gettimeofday would have done, and then undo
 		 * it!
 		 */
-		nsec -= gettimeoffset();
+		nsec -= time_interpolator_get_offset();
 
-		while (nsec < 0) {
-			nsec += 1000000000;
-			sec--;
-		}
+		wtm_sec  = wall_to_monotonic.tv_sec + (xtime.tv_sec - sec);
+		wtm_nsec = wall_to_monotonic.tv_nsec + (xtime.tv_nsec - nsec);
+
+		set_normalized_timespec(&xtime, sec, nsec);
+		set_normalized_timespec(&wall_to_monotonic, wtm_sec, wtm_nsec);
 
-		xtime.tv_sec = sec;
-		xtime.tv_nsec = nsec;
 		time_adjust = 0;		/* stop active adjtime() */
 		time_status |= STA_UNSYNC;
 		time_maxerror = NTP_PHASE_LIMIT;
 		time_esterror = NTP_PHASE_LIMIT;
+		time_interpolator_reset();
 	}
 	write_sequnlock_irq(&xtime_lock);
 	clock_was_set();
@@ -124,7 +160,7 @@
 		seq = read_seqbegin(&xtime_lock);
 		{
 			old = last_nsec_offset;
-			offset = gettimeoffset();
+			offset = time_interpolator_get_offset();
 			sec = xtime.tv_sec;
 			nsec = xtime.tv_nsec;
 		}
@@ -166,8 +202,8 @@
 
 	usec = (nsec + offset) / 1000;
 
-	while (unlikely(usec >= 1000000)) {
-		usec -= 1000000;
+	while (unlikely(usec >= USEC_PER_SEC)) {
+		usec -= USEC_PER_SEC;
 		++sec;
 	}
 
@@ -175,8 +211,8 @@
 	tv->tv_usec = usec;
 }
 
-static void
-timer_interrupt(int irq, void *dev_id, struct pt_regs *regs)
+static irqreturn_t
+timer_interrupt (int irq, void *dev_id, struct pt_regs *regs)
 {
 	unsigned long new_itm;
 
@@ -200,7 +236,7 @@
 #endif
 		new_itm += local_cpu_data->itm_delta;
 
-		if (smp_processor_id() == 0) {
+		if (smp_processor_id() == TIME_KEEPER_ID) {
 			/*
 			 * Here we are in the timer irq handler. We have irqs locally
 			 * disabled, but we don't know if the timer_bh is running on
@@ -221,7 +257,7 @@
 	do {
 	    /*
 	     * If we're too close to the next clock tick for comfort, we increase the
-	     * saftey margin by intentionally dropping the next tick(s).  We do NOT update
+	     * safety margin by intentionally dropping the next tick(s).  We do NOT update
 	     * itm.next because that would force us to call do_timer() which in turn would
 	     * let our clock run too fast (with the potentially devastating effect of
 	     * losing monotony of time).
@@ -231,12 +267,13 @@
 	    ia64_set_itm(new_itm);
 	    /* double check, in case we got hit by a (slow) PMI: */
 	} while (time_after_eq(ia64_get_itc(), new_itm));
+	return IRQ_HANDLED;
 }
 
 /*
  * Encapsulate access to the itm structure for SMP.
  */
-void __init
+void
 ia64_cpu_local_tick (void)
 {
 	int cpu = smp_processor_id();
@@ -261,16 +298,17 @@
 void __init
 ia64_init_itm (void)
 {
-	unsigned long platform_base_freq, itc_freq, drift;
+	unsigned long platform_base_freq, itc_freq;
 	struct pal_freq_ratio itc_ratio, proc_ratio;
-	long status;
+	long status, platform_base_drift, itc_drift;
 
 	/*
 	 * According to SAL v2.6, we need to use a SAL call to determine the platform base
 	 * frequency and then a PAL call to determine the frequency ratio between the ITC
 	 * and the base frequency.
 	 */
-	status = ia64_sal_freq_base(SAL_FREQ_BASE_PLATFORM, &platform_base_freq, &drift);
+	status = ia64_sal_freq_base(SAL_FREQ_BASE_PLATFORM,
+				    &platform_base_freq, &platform_base_drift);
 	if (status != 0) {
 		printk(KERN_ERR "SAL_FREQ_BASE_PLATFORM failed: %s\n", ia64_sal_strerror(status));
 	} else {
@@ -281,8 +319,9 @@
 	if (status != 0) {
 		/* invent "random" values */
 		printk(KERN_ERR
-		       "SAL/PAL failed to obtain frequency info---inventing reasonably values\n");
+		       "SAL/PAL failed to obtain frequency info---inventing reasonable values\n");
 		platform_base_freq = 100000000;
+		platform_base_drift = -1;	/* no drift info */
 		itc_ratio.num = 3;
 		itc_ratio.den = 1;
 	}
@@ -290,6 +329,7 @@
 		printk(KERN_ERR "Platform base frequency %lu bogus---resetting to 75MHz!\n",
 		       platform_base_freq);
 		platform_base_freq = 75000000;
+		platform_base_drift = -1;
 	}
 	if (!proc_ratio.den)
 		proc_ratio.den = 1;	/* avoid division by zero */
@@ -297,18 +337,30 @@
 		itc_ratio.den = 1;	/* avoid division by zero */
 
 	itc_freq = (platform_base_freq*itc_ratio.num)/itc_ratio.den;
+	if (platform_base_drift != -1)
+		itc_drift = platform_base_drift*itc_ratio.num/itc_ratio.den;
+	else
+		itc_drift = -1;
+
 	local_cpu_data->itm_delta = (itc_freq + HZ/2) / HZ;
 	printk(KERN_INFO "CPU %d: base freq=%lu.%03luMHz, ITC ratio=%lu/%lu, "
-	       "ITC freq=%lu.%03luMHz\n", smp_processor_id(),
+	       "ITC freq=%lu.%03luMHz+/-%ldppm\n", smp_processor_id(),
 	       platform_base_freq / 1000000, (platform_base_freq / 1000) % 1000,
-	       itc_ratio.num, itc_ratio.den, itc_freq / 1000000, (itc_freq / 1000) % 1000);
+	       itc_ratio.num, itc_ratio.den, itc_freq / 1000000, (itc_freq / 1000) % 1000,
+	       itc_drift);
 
 	local_cpu_data->proc_freq = (platform_base_freq*proc_ratio.num)/proc_ratio.den;
 	local_cpu_data->itc_freq = itc_freq;
-	local_cpu_data->cyc_per_usec = (itc_freq + 500000) / 1000000;
-	local_cpu_data->nsec_per_cyc = ((1000000000UL<<IA64_NSEC_PER_CYC_SHIFT)
+	local_cpu_data->cyc_per_usec = (itc_freq + USEC_PER_SEC/2) / USEC_PER_SEC;
+	local_cpu_data->nsec_per_cyc = ((NSEC_PER_SEC<<IA64_NSEC_PER_CYC_SHIFT)
 					+ itc_freq/2)/itc_freq;
 
+	if (!(sal_platform_features & IA64_SAL_PLATFORM_FEATURE_ITC_DRIFT)) {
+		itc_interpolator.frequency = local_cpu_data->itc_freq;
+		itc_interpolator.drift = itc_drift;
+		register_time_interpolator(&itc_interpolator);
+	}
+
 	/* Setup the CPU local timer tick */
 	ia64_cpu_local_tick();
 }
@@ -323,6 +375,12 @@
 time_init (void)
 {
 	register_percpu_irq(IA64_TIMER_VECTOR, &timer_irqaction);
-	efi_gettimeofday((struct timeval *) &xtime);
+	efi_gettimeofday(&xtime);
 	ia64_init_itm();
+
+	/*
+	 * Initialize wall_to_monotonic such that adding it to xtime will yield zero, the
+	 * tv_nsec field must be normalized (i.e., 0 <= nsec < NSEC_PER_SEC).
+	 */
+	set_normalized_timespec(&wall_to_monotonic, -xtime.tv_sec, -xtime.tv_nsec);
 }
diff -Nru a/arch/ia64/sn/kernel/sn2/timer.c b/arch/ia64/sn/kernel/sn2/timer.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/arch/ia64/sn/kernel/sn2/timer.c	Tue May 20 00:03:31 2003
@@ -0,0 +1,76 @@
+/*
+ * linux/arch/ia64/sn/kernel/sn2/timer.c
+ *
+ * Copyright (C) 2003 Silicon Graphics, Inc.
+ * Copyright (C) 2003 Hewlett-Packard Co
+ *	David Mosberger <davidm@hpl.hp.com>: updated for new timer-interpolation infrastructure
+ */
+
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/sched.h>
+#include <linux/time.h>
+#include <linux/interrupt.h>
+
+#include <asm/hw_irq.h>
+#include <asm/system.h>
+
+#include <asm/sn/leds.h>
+#include <asm/sn/clksupport.h>
+
+
+extern unsigned long sn_rtc_cycles_per_second;
+static volatile unsigned long last_wall_rtc;
+
+static unsigned long rtc_offset;	/* updated only when xtime write-lock is held! */
+static long rtc_nsecs_per_cycle;
+static long rtc_per_timer_tick;
+
+static unsigned long
+getoffset(void)
+{
+	return rtc_offset + (GET_RTC_COUNTER() - last_wall_rtc)*rtc_nsecs_per_cycle;
+}
+
+
+static void
+update(long delta_nsec)
+{
+	unsigned long rtc_counter = GET_RTC_COUNTER();
+	unsigned long offset = rtc_offset + (rtc_counter - last_wall_rtc)*rtc_nsecs_per_cycle;
+
+	/* Be careful about signed/unsigned comparisons here: */
+	if (delta_nsec < 0 || (unsigned long) delta_nsec < offset)
+		rtc_offset = offset - delta_nsec;
+	else
+		rtc_offset = 0;
+	last_wall_rtc = rtc_counter;
+}
+
+
+static void
+reset(void)
+{
+	rtc_offset = 0;
+	last_wall_rtc = GET_RTC_COUNTER();
+}
+
+
+static struct time_interpolator sn2_interpolator = {
+	.get_offset =	getoffset,
+	.update =	update,
+	.reset =	reset
+};
+
+void __init
+sn_timer_init(void)
+{
+	sn2_interpolator.frequency = sn_rtc_cycles_per_second;
+	sn2_interpolator.drift = -1;	/* unknown */
+	register_time_interpolator(&sn2_interpolator);
+
+	rtc_per_timer_tick = sn_rtc_cycles_per_second / HZ;
+	rtc_nsecs_per_cycle = 1000000000 / sn_rtc_cycles_per_second;
+
+	last_wall_rtc = GET_RTC_COUNTER();
+}
