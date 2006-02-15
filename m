Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422961AbWBOFaJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422961AbWBOFaJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 00:30:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422964AbWBOFaI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 00:30:08 -0500
Received: from ozlabs.org ([203.10.76.45]:49112 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1422961AbWBOFaG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 00:30:06 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17394.48045.253033.885865@cargo.ozlabs.ibm.com>
Date: Wed, 15 Feb 2006 16:27:09 +1100
From: Paul Mackerras <paulus@samba.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Roger Leigh <rleigh@whinlatter.ukfsn.org>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>,
       debian-powerpc@lists.debian.org
Subject: Re: 2.6.16-rc2 powerpc timestamp skew
In-Reply-To: <1139870065.5237.26.camel@localhost.localdomain>
References: <87pslspkj5.fsf@hardknott.home.whinlatter.ukfsn.org>
	<1139779983.5247.39.camel@localhost.localdomain>
	<87irrj85vp.fsf@hardknott.home.whinlatter.ukfsn.org>
	<1139870065.5237.26.camel@localhost.localdomain>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt writes:

> Ok, does not using NTP fixes it ?

Try this patch.  With this the values from gettimeofday() or the VDSO
should stay exactly in sync with xtime even if NTP is adjusting the
clock.

This patch still has quite a few debugging printks in it, so it's not
final by any means.  I'll be interested to hear how it goes, and in
particular whether or not you see any "oops, time got ahead" messages.

Paul.

diff -urN linux-2.6/arch/powerpc/kernel/sys_ppc32.c dynvsid/arch/powerpc/kernel/sys_ppc32.c
--- linux-2.6/arch/powerpc/kernel/sys_ppc32.c	2006-01-11 08:42:09.000000000 +1100
+++ dynvsid/arch/powerpc/kernel/sys_ppc32.c	2006-02-13 15:07:52.000000000 +1100
@@ -176,7 +176,6 @@
 };
 
 extern int do_adjtimex(struct timex *);
-extern void ppc_adjtimex(void);
 
 asmlinkage long compat_sys_adjtimex(struct timex32 __user *utp)
 {
@@ -209,9 +208,6 @@
 
 	ret = do_adjtimex(&txc);
 
-	/* adjust the conversion of TB to time of day to track adjtimex */
-	ppc_adjtimex();
-
 	if(put_user(txc.modes, &utp->modes) ||
 	   __put_user(txc.offset, &utp->offset) ||
 	   __put_user(txc.freq, &utp->freq) ||
diff -urN linux-2.6/arch/powerpc/kernel/time.c dynvsid/arch/powerpc/kernel/time.c
--- linux-2.6/arch/powerpc/kernel/time.c	2006-02-09 11:39:04.000000000 +1100
+++ dynvsid/arch/powerpc/kernel/time.c	2006-02-14 16:24:31.000000000 +1100
@@ -50,6 +50,7 @@
 #include <linux/security.h>
 #include <linux/percpu.h>
 #include <linux/rtc.h>
+#include <linux/jiffies.h>
 
 #include <asm/io.h>
 #include <asm/processor.h>
@@ -99,7 +100,15 @@
 unsigned long tb_ticks_per_sec;
 u64 tb_to_xs;
 unsigned tb_to_us;
-unsigned long processor_freq;
+
+#define TICKLEN_SCALE	(SHIFT_SCALE - 10)
+u64 last_tick_len;	/* units are ns / 2^TICKLEN_SCALE */
+u64 ticklen_to_xs;	/* 0.64 fraction */
+
+/* If last_tick_len corresponds to about 1/HZ seconds, then
+   last_tick_len << TICKLEN_SHIFT will be about 2^63. */
+#define TICKLEN_SHIFT	(63 - 30 - TICKLEN_SCALE + SHIFT_HZ)
+
 DEFINE_SPINLOCK(rtc_lock);
 EXPORT_SYMBOL_GPL(rtc_lock);
 
@@ -113,10 +122,6 @@
 extern struct timezone sys_tz;
 static long timezone_offset;
 
-void ppc_adjtimex(void);
-
-static unsigned adjusting_time = 0;
-
 unsigned long ppc_proc_freq;
 unsigned long ppc_tb_freq;
 
@@ -248,23 +253,6 @@
 
 EXPORT_SYMBOL(do_gettimeofday);
 
-/* Synchronize xtime with do_gettimeofday */ 
-
-static inline void timer_sync_xtime(unsigned long cur_tb)
-{
-#ifdef CONFIG_PPC64
-	/* why do we do this? */
-	struct timeval my_tv;
-
-	__do_gettimeofday(&my_tv, cur_tb);
-
-	if (xtime.tv_sec <= my_tv.tv_sec) {
-		xtime.tv_sec = my_tv.tv_sec;
-		xtime.tv_nsec = my_tv.tv_usec * 1000;
-	}
-#endif
-}
-
 /*
  * There are two copies of tb_to_xs and stamp_xsec so that no
  * lock is needed to access and use these values in
@@ -323,15 +311,49 @@
 {
 	unsigned long offset;
 	u64 new_stamp_xsec;
+	u64 tlen, t2x;
+	static struct timespec last_xtime;
+	static u64 last_tb;
 
 	if (__USE_RTC())
 		return;
+	tlen = current_tick_length();
 	offset = cur_tb - do_gtod.varp->tb_orig_stamp;
-	if ((offset & 0x80000000u) == 0)
-		return;
-	new_stamp_xsec = do_gtod.varp->stamp_xsec
-		+ mulhdu(offset, do_gtod.varp->tb_to_xs);
-	update_gtod(cur_tb, new_stamp_xsec, do_gtod.varp->tb_to_xs);
+	if (tlen == last_tick_len && offset < 0x80000000u) {
+		struct timeval tv;
+		__do_gettimeofday(&tv, cur_tb);
+		if (tv.tv_sec <= xtime.tv_sec &&
+		    (tv.tv_sec < xtime.tv_sec ||
+		     tv.tv_usec * 1000 <= xtime.tv_nsec)) {
+			last_xtime = xtime;
+			last_tb = cur_tb;
+			return;
+		}
+		printk("oops, time got ahead: %ld.%06ld > %ld.%09ld\n",
+		       tv.tv_sec, tv.tv_usec,
+		       xtime.tv_sec, xtime.tv_nsec);
+		printk("  xtime was %ld.%09ld tb was %lld tick %lld\n",
+		       last_xtime.tv_sec, last_xtime.tv_nsec,
+		       last_tb, cur_tb);
+		printk("  tlen 0x%llx tb now %lld tpj %ld\n", tlen, get_tb(),
+		       tb_ticks_per_jiffy);
+		printk("  gtod tbstamp %lld xsec 0x%llx t2x 0x%llx\n",
+		       do_gtod.varp->tb_orig_stamp, do_gtod.varp->stamp_xsec,
+		       do_gtod.varp->tb_to_xs);
+	}
+	if (tlen != last_tick_len) {
+		t2x = mulhdu(tlen << TICKLEN_SHIFT, ticklen_to_xs);
+		printk("tick len 0x%llx -> 0x%llx, t2x now 0x%llx\n",
+		       last_tick_len, tlen, t2x);
+		last_tick_len = tlen;
+	} else
+		t2x = do_gtod.varp->tb_to_xs;
+	new_stamp_xsec = (u64) xtime.tv_nsec * XSEC_PER_SEC;
+	do_div(new_stamp_xsec, 1000000000);
+	new_stamp_xsec += (u64) xtime.tv_sec * XSEC_PER_SEC;
+	update_gtod(cur_tb, new_stamp_xsec, t2x);
+	last_xtime = xtime;
+	last_tb = cur_tb;
 }
 
 #ifdef CONFIG_SMP
@@ -462,13 +484,10 @@
 		write_seqlock(&xtime_lock);
 		tb_last_jiffy += tb_ticks_per_jiffy;
 		tb_last_stamp = per_cpu(last_jiffy, cpu);
-		timer_recalc_offset(tb_last_jiffy);
 		do_timer(regs);
-		timer_sync_xtime(tb_last_jiffy);
+		timer_recalc_offset(tb_last_jiffy);
 		timer_check_rtc();
 		write_sequnlock(&xtime_lock);
-		if (adjusting_time && (time_adjust == 0))
-			ppc_adjtimex();
 	}
 	
 	next_dec = tb_ticks_per_jiffy - ticks;
@@ -492,16 +511,18 @@
 
 void wakeup_decrementer(void)
 {
-	int i;
+	unsigned long ticks;
 
-	set_dec(tb_ticks_per_jiffy);
 	/*
-	 * We don't expect this to be called on a machine with a 601,
-	 * so using get_tbl is fine.
+	 * The timebase gets saved on sleep and restored on wakeup,
+	 * so all we need to do is to reset the decrementer.
 	 */
-	tb_last_stamp = tb_last_jiffy = get_tb();
-	for_each_cpu(i)
-		per_cpu(last_jiffy, i) = tb_last_stamp;
+	ticks = tb_ticks_since(__get_cpu_var(last_jiffy));
+	if (ticks < tb_ticks_per_jiffy)
+		ticks = tb_ticks_per_jiffy - ticks;
+	else
+		ticks = 1;
+	set_dec(ticks);
 }
 
 #ifdef CONFIG_SMP
@@ -541,12 +562,13 @@
 	time_t wtm_sec, new_sec = tv->tv_sec;
 	long wtm_nsec, new_nsec = tv->tv_nsec;
 	unsigned long flags;
-	long int tb_delta;
-	u64 new_xsec, tb_delta_xs;
+	u64 new_xsec;
+	unsigned long tb_delta;
 
 	if ((unsigned long)tv->tv_nsec >= NSEC_PER_SEC)
 		return -EINVAL;
 
+	printk("do_settimeofday(%ld.%09ld)\n", new_sec, new_nsec);
 	write_seqlock_irqsave(&xtime_lock, flags);
 
 	/*
@@ -563,9 +585,15 @@
 		first_settimeofday = 0;
 	}
 #endif
+
+	/*
+	 * Subtract off the number of nanoseconds since the
+	 * beginning of the last tick.
+	 */
 	tb_delta = tb_ticks_since(tb_last_stamp);
 	tb_delta += (jiffies - wall_jiffies) * tb_ticks_per_jiffy;
-	tb_delta_xs = mulhdu(tb_delta, do_gtod.varp->tb_to_xs);
+	tb_delta = mulhdu(tb_delta, do_gtod.varp->tb_to_xs); /* in xsec */
+	new_nsec -= SCALE_XSEC(tb_delta, 1000000000);
 
 	wtm_sec  = wall_to_monotonic.tv_sec + (xtime.tv_sec - new_sec);
 	wtm_nsec = wall_to_monotonic.tv_nsec + (xtime.tv_nsec - new_nsec);
@@ -580,12 +608,12 @@
 
 	ntp_clear();
 
-	new_xsec = 0;
-	if (new_nsec != 0) {
-		new_xsec = (u64)new_nsec * XSEC_PER_SEC;
+	new_xsec = xtime.tv_nsec;
+	if (new_xsec != 0) {
+		new_xsec *= XSEC_PER_SEC;
 		do_div(new_xsec, NSEC_PER_SEC);
 	}
-	new_xsec += (u64)new_sec * XSEC_PER_SEC - tb_delta_xs;
+	new_xsec += (u64)xtime.tv_sec * XSEC_PER_SEC;
 	update_gtod(tb_last_jiffy, new_xsec, do_gtod.varp->tb_to_xs);
 
 	vdso_data->tz_minuteswest = sys_tz.tz_minuteswest;
@@ -671,7 +699,7 @@
 	unsigned long flags;
 	unsigned long tm = 0;
 	struct div_result res;
-	u64 scale;
+	u64 scale, x;
 	unsigned shift;
 
         if (ppc_md.time_init != NULL)
@@ -693,11 +721,45 @@
 	}
 
 	tb_ticks_per_jiffy = ppc_tb_freq / HZ;
-	tb_ticks_per_sec = tb_ticks_per_jiffy * HZ;
+	tb_ticks_per_sec = ppc_tb_freq;
 	tb_ticks_per_usec = ppc_tb_freq / 1000000;
 	tb_to_us = mulhwu_scale_factor(ppc_tb_freq, 1000000);
+
+	/*
+	 * Calculate the length of each tick in ns.  It will not be
+	 * exactly 1e9/HZ unless ppc_tb_freq is divisible by HZ.
+	 * We compute 1e9 * tb_ticks_per_jiffy / ppc_tb_freq,
+	 * rounded up.
+	 */
+	x = (u64) NSEC_PER_SEC * tb_ticks_per_jiffy + ppc_tb_freq - 1;
+	do_div(x, ppc_tb_freq);
+	tick_nsec = x;
+	last_tick_len = x << TICKLEN_SCALE;
+	printk("HZ = %d tb_freq = %lu tick_nsec = %ld\n", HZ, ppc_tb_freq,
+	       tick_nsec);
+
+	/* Compute tb_to_xs the old way, as 2^20 / tb_ticks_per_sec */
 	div128_by_32(1024*1024, 0, tb_ticks_per_sec, &res);
 	tb_to_xs = res.result_low;
+	printk("tb_to_xs = %llx (old way)\n", tb_to_xs);
+
+	/*
+	 * Compute ticklen_to_xs, which is a factor which gets multiplied
+	 * by (last_tick_len << TICKLEN_SHIFT) to get a tb_to_xs value.
+	 * It is computed as:
+	 * ticklen_to_xs = 2^N / (tb_ticks_per_jiffy * 1e9)
+	 * where N = 64 + 20 - TICKLEN_SCALE - TICKLEN_SHIFT
+	 * so as to give the result as a 0.64 fixed-point fraction.
+	 */
+	div128_by_32(1ULL << (64 + 20 - TICKLEN_SCALE - TICKLEN_SHIFT), 0,
+		     tb_ticks_per_jiffy, &res);
+	div128_by_32(res.result_high, res.result_low, NSEC_PER_SEC, &res);
+	printk("ticklen_to_xs = %llx %llx\n", res.result_high, res.result_low);
+	ticklen_to_xs = res.result_low;
+
+	/* Compute tb_to_xs from tick_nsec */
+	tb_to_xs = mulhdu(last_tick_len << TICKLEN_SHIFT, ticklen_to_xs);
+	printk("tb_to_xs = %llx (new way)\n", tb_to_xs);
 
 	/*
 	 * Compute scale factor for sched_clock.
@@ -759,126 +821,6 @@
 	set_dec(tb_ticks_per_jiffy);
 }
 
-/* 
- * After adjtimex is called, adjust the conversion of tb ticks
- * to microseconds to keep do_gettimeofday synchronized 
- * with ntpd.
- *
- * Use the time_adjust, time_freq and time_offset computed by adjtimex to 
- * adjust the frequency.
- */
-
-/* #define DEBUG_PPC_ADJTIMEX 1 */
-
-void ppc_adjtimex(void)
-{
-#ifdef CONFIG_PPC64
-	unsigned long den, new_tb_ticks_per_sec, tb_ticks, old_xsec,
-		new_tb_to_xs, new_xsec, new_stamp_xsec;
-	unsigned long tb_ticks_per_sec_delta;
-	long delta_freq, ltemp;
-	struct div_result divres; 
-	unsigned long flags;
-	long singleshot_ppm = 0;
-
-	/*
-	 * Compute parts per million frequency adjustment to
-	 * accomplish the time adjustment implied by time_offset to be
-	 * applied over the elapsed time indicated by time_constant.
-	 * Use SHIFT_USEC to get it into the same units as
-	 * time_freq.
-	 */
-	if ( time_offset < 0 ) {
-		ltemp = -time_offset;
-		ltemp <<= SHIFT_USEC - SHIFT_UPDATE;
-		ltemp >>= SHIFT_KG + time_constant;
-		ltemp = -ltemp;
-	} else {
-		ltemp = time_offset;
-		ltemp <<= SHIFT_USEC - SHIFT_UPDATE;
-		ltemp >>= SHIFT_KG + time_constant;
-	}
-	
-	/* If there is a single shot time adjustment in progress */
-	if ( time_adjust ) {
-#ifdef DEBUG_PPC_ADJTIMEX
-		printk("ppc_adjtimex: ");
-		if ( adjusting_time == 0 )
-			printk("starting ");
-		printk("single shot time_adjust = %ld\n", time_adjust);
-#endif	
-	
-		adjusting_time = 1;
-		
-		/*
-		 * Compute parts per million frequency adjustment
-		 * to match time_adjust
-		 */
-		singleshot_ppm = tickadj * HZ;	
-		/*
-		 * The adjustment should be tickadj*HZ to match the code in
-		 * linux/kernel/timer.c, but experiments show that this is too
-		 * large. 3/4 of tickadj*HZ seems about right
-		 */
-		singleshot_ppm -= singleshot_ppm / 4;
-		/* Use SHIFT_USEC to get it into the same units as time_freq */
-		singleshot_ppm <<= SHIFT_USEC;
-		if ( time_adjust < 0 )
-			singleshot_ppm = -singleshot_ppm;
-	}
-	else {
-#ifdef DEBUG_PPC_ADJTIMEX
-		if ( adjusting_time )
-			printk("ppc_adjtimex: ending single shot time_adjust\n");
-#endif
-		adjusting_time = 0;
-	}
-	
-	/* Add up all of the frequency adjustments */
-	delta_freq = time_freq + ltemp + singleshot_ppm;
-	
-	/*
-	 * Compute a new value for tb_ticks_per_sec based on
-	 * the frequency adjustment
-	 */
-	den = 1000000 * (1 << (SHIFT_USEC - 8));
-	if ( delta_freq < 0 ) {
-		tb_ticks_per_sec_delta = ( tb_ticks_per_sec * ( (-delta_freq) >> (SHIFT_USEC - 8))) / den;
-		new_tb_ticks_per_sec = tb_ticks_per_sec + tb_ticks_per_sec_delta;
-	}
-	else {
-		tb_ticks_per_sec_delta = ( tb_ticks_per_sec * ( delta_freq >> (SHIFT_USEC - 8))) / den;
-		new_tb_ticks_per_sec = tb_ticks_per_sec - tb_ticks_per_sec_delta;
-	}
-	
-#ifdef DEBUG_PPC_ADJTIMEX
-	printk("ppc_adjtimex: ltemp = %ld, time_freq = %ld, singleshot_ppm = %ld\n", ltemp, time_freq, singleshot_ppm);
-	printk("ppc_adjtimex: tb_ticks_per_sec - base = %ld  new = %ld\n", tb_ticks_per_sec, new_tb_ticks_per_sec);
-#endif
-
-	/*
-	 * Compute a new value of tb_to_xs (used to convert tb to
-	 * microseconds) and a new value of stamp_xsec which is the
-	 * time (in 1/2^20 second units) corresponding to
-	 * tb_orig_stamp.  This new value of stamp_xsec compensates
-	 * for the change in frequency (implied by the new tb_to_xs)
-	 * which guarantees that the current time remains the same.
-	 */
-	write_seqlock_irqsave( &xtime_lock, flags );
-	tb_ticks = get_tb() - do_gtod.varp->tb_orig_stamp;
-	div128_by_32(1024*1024, 0, new_tb_ticks_per_sec, &divres);
-	new_tb_to_xs = divres.result_low;
-	new_xsec = mulhdu(tb_ticks, new_tb_to_xs);
-
-	old_xsec = mulhdu(tb_ticks, do_gtod.varp->tb_to_xs);
-	new_stamp_xsec = do_gtod.varp->stamp_xsec + old_xsec - new_xsec;
-
-	update_gtod(do_gtod.varp->tb_orig_stamp, new_stamp_xsec, new_tb_to_xs);
-
-	write_sequnlock_irqrestore( &xtime_lock, flags );
-#endif /* CONFIG_PPC64 */
-}
-
 
 #define FEBRUARY	2
 #define	STARTOFTIME	1970
diff -urN linux-2.6/include/linux/timex.h dynvsid/include/linux/timex.h
--- linux-2.6/include/linux/timex.h	2005-10-31 13:10:39.000000000 +1100
+++ dynvsid/include/linux/timex.h	2006-02-13 15:07:52.000000000 +1100
@@ -345,6 +345,9 @@
 
 #endif /* !CONFIG_TIME_INTERPOLATION */
 
+/* Returns how long ticks are at present, in ns / 2^(SHIFT_SCALE-10). */
+extern u64 current_tick_length(void);
+
 #endif /* KERNEL */
 
 #endif /* LINUX_TIMEX_H */
diff -urN linux-2.6/kernel/timer.c dynvsid/kernel/timer.c
--- linux-2.6/kernel/timer.c	2006-02-09 11:39:05.000000000 +1100
+++ dynvsid/kernel/timer.c	2006-02-13 15:07:54.000000000 +1100
@@ -759,6 +759,30 @@
 }
 
 /*
+ * Return how long ticks are at the moment, that is, how much time
+ * update_wall_time_one_tick will add to xtime next time we call it
+ * (assuming no calls to do_adjtimex in the meantime).
+ * The return value is in fixed-point nanoseconds with SHIFT_SCALE-10
+ * bits to the right of the binary point.
+ * This function has no side-effects.
+ */
+u64 current_tick_length(void)
+{
+	long time_adjust_step, delta_nsec;
+
+	if ((time_adjust_step = time_adjust) != 0 ) {
+		/*
+		 * Limit the amount of the step to be in the range
+		 * -tickadj .. +tickadj
+		 */
+		time_adjust_step = min(time_adjust_step, (long)tickadj);
+		time_adjust_step = max(time_adjust_step, (long)-tickadj);
+	}
+	delta_nsec = tick_nsec + time_adjust_step * 1000;
+	return ((u64) delta_nsec << (SHIFT_SCALE - 10)) + time_adj;
+}
+
+/*
  * Using a loop looks inefficient, but "ticks" is
  * usually just one (we shouldn't be losing ticks,
  * we're doing this this way mainly for interrupt
