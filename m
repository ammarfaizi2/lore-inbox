Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261908AbSJJS2d>; Thu, 10 Oct 2002 14:28:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261907AbSJJS2d>; Thu, 10 Oct 2002 14:28:33 -0400
Received: from 12-231-242-11.client.attbi.com ([12.231.242.11]:61965 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S261908AbSJJS2K>;
	Thu, 10 Oct 2002 14:28:10 -0400
Date: Thu, 10 Oct 2002 11:29:39 -0700
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Cc: johnstul@us.ibm.com
Subject: Re: [PATCH] i386 timer changes for 2.5.41
Message-ID: <20021010182938.GC25871@kroah.com>
References: <20021010182652.GA25871@kroah.com> <20021010182756.GB25871@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021010182756.GB25871@kroah.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Note, this patch is messy.  If you look at the bk changeset you will see
that no new code is added, but time.c is copied to timer_pit.c and
timer_tsc.c, and then code is taken away from those files.


# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.749   -> 1.750  
#	arch/i386/kernel/time.c	1.16    -> 1.17   
#	               (new)	        -> 1.18    arch/i386/kernel/timers/timer_pit.c
#	               (new)	        -> 1.18    arch/i386/kernel/timers/timer_tsc.c
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/10/10	johnstul@us.ibm.com	1.750
# i386 timer core: move code out of time.c into timers/timer_pit.c and timers/timer_tsc.c
# --------------------------------------------
#
diff -Nru a/arch/i386/kernel/time.c b/arch/i386/kernel/time.c
--- a/arch/i386/kernel/time.c	Thu Oct 10 11:21:13 2002
+++ b/arch/i386/kernel/time.c	Thu Oct 10 11:21:13 2002
@@ -73,51 +73,11 @@
 
 unsigned long cpu_khz;	/* Detected as we calibrate the TSC */
 
-/* Number of usecs that the last interrupt was delayed */
-static int delay_at_last_interrupt;
-
-static unsigned long last_tsc_low; /* lsb 32 bits of Time Stamp Counter */
-
-/* Cached *multiplier* to convert TSC counts to microseconds.
- * (see the equation below).
- * Equal to 2^32 * (1 / (clocks per usec) ).
- * Initialized in time_init.
- */
-unsigned long fast_gettimeoffset_quotient;
-
 extern rwlock_t xtime_lock;
 extern unsigned long wall_jiffies;
 
 spinlock_t rtc_lock = SPIN_LOCK_UNLOCKED;
 
-static inline unsigned long do_fast_gettimeoffset(void)
-{
-	register unsigned long eax, edx;
-
-	/* Read the Time Stamp Counter */
-
-	rdtsc(eax,edx);
-
-	/* .. relative to previous jiffy (32 bits is enough) */
-	eax -= last_tsc_low;	/* tsc_low delta */
-
-	/*
-         * Time offset = (tsc_low delta) * fast_gettimeoffset_quotient
-         *             = (tsc_low delta) * (usecs_per_clock)
-         *             = (tsc_low delta) * (usecs_per_jiffy / clocks_per_jiffy)
-	 *
-	 * Using a mull instead of a divl saves up to 31 clock cycles
-	 * in the critical path.
-         */
-
-	__asm__("mull %2"
-		:"=a" (eax), "=d" (edx)
-		:"rm" (fast_gettimeoffset_quotient),
-		 "0" (eax));
-
-	/* our adjusted time offset in microseconds */
-	return delay_at_last_interrupt + edx;
-}
 
 #define TICK_SIZE (tick_nsec / 1000)
 
@@ -125,104 +85,6 @@
 EXPORT_SYMBOL(i8253_lock);
 
 #ifndef CONFIG_X86_TSC
-
-/* This function must be called with interrupts disabled 
- * It was inspired by Steve McCanne's microtime-i386 for BSD.  -- jrs
- * 
- * However, the pc-audio speaker driver changes the divisor so that
- * it gets interrupted rather more often - it loads 64 into the
- * counter rather than 11932! This has an adverse impact on
- * do_gettimeoffset() -- it stops working! What is also not
- * good is that the interval that our timer function gets called
- * is no longer 10.0002 ms, but 9.9767 ms. To get around this
- * would require using a different timing source. Maybe someone
- * could use the RTC - I know that this can interrupt at frequencies
- * ranging from 8192Hz to 2Hz. If I had the energy, I'd somehow fix
- * it so that at startup, the timer code in sched.c would select
- * using either the RTC or the 8253 timer. The decision would be
- * based on whether there was any other device around that needed
- * to trample on the 8253. I'd set up the RTC to interrupt at 1024 Hz,
- * and then do some jiggery to have a version of do_timer that 
- * advanced the clock by 1/1024 s. Every time that reached over 1/100
- * of a second, then do all the old code. If the time was kept correct
- * then do_gettimeoffset could just return 0 - there is no low order
- * divider that can be accessed.
- *
- * Ideally, you would be able to use the RTC for the speaker driver,
- * but it appears that the speaker driver really needs interrupt more
- * often than every 120 us or so.
- *
- * Anyway, this needs more thought....		pjsg (1993-08-28)
- * 
- * If you are really that interested, you should be reading
- * comp.protocols.time.ntp!
- */
-
-static unsigned long do_slow_gettimeoffset(void)
-{
-	int count;
-
-	static int count_p = LATCH;    /* for the first call after boot */
-	static unsigned long jiffies_p = 0;
-
-	/*
-	 * cache volatile jiffies temporarily; we have IRQs turned off. 
-	 */
-	unsigned long jiffies_t;
-
-	/* gets recalled with irq locally disabled */
-	spin_lock(&i8253_lock);
-	/* timer count may underflow right here */
-	outb_p(0x00, 0x43);	/* latch the count ASAP */
-
-	count = inb_p(0x40);	/* read the latched count */
-
-	/*
-	 * We do this guaranteed double memory access instead of a _p 
-	 * postfix in the previous port access. Wheee, hackady hack
-	 */
- 	jiffies_t = jiffies;
-
-	count |= inb_p(0x40) << 8;
-	
-        /* VIA686a test code... reset the latch if count > max + 1 */
-        if (count > LATCH) {
-                outb_p(0x34, 0x43);
-                outb_p(LATCH & 0xff, 0x40);
-                outb(LATCH >> 8, 0x40);
-                count = LATCH - 1;
-        }
-	
-	spin_unlock(&i8253_lock);
-
-	/*
-	 * avoiding timer inconsistencies (they are rare, but they happen)...
-	 * there are two kinds of problems that must be avoided here:
-	 *  1. the timer counter underflows
-	 *  2. hardware problem with the timer, not giving us continuous time,
-	 *     the counter does small "jumps" upwards on some Pentium systems,
-	 *     (see c't 95/10 page 335 for Neptun bug.)
-	 */
-
-
-	if( jiffies_t == jiffies_p ) {
-		if( count > count_p ) {
-			/* the nutcase */
-			count = do_timer_overflow(count);
-		}
-	} else
-		jiffies_p = jiffies_t;
-
-	count_p = count;
-
-	count = ((LATCH-1) - count) * TICK_SIZE;
-	count = (count + LATCH/2) / LATCH;
-
-	return count;
-}
-
-static unsigned long (*do_gettimeoffset)(void) = do_slow_gettimeoffset;
-
 #else
 
 #define do_gettimeoffset()	do_fast_gettimeoffset()
@@ -433,34 +295,7 @@
 	 */
 	write_lock(&xtime_lock);
 
-	if (use_tsc)
-	{
-		/*
-		 * It is important that these two operations happen almost at
-		 * the same time. We do the RDTSC stuff first, since it's
-		 * faster. To avoid any inconsistencies, we need interrupts
-		 * disabled locally.
-		 */
-
-		/*
-		 * Interrupts are just disabled locally since the timer irq
-		 * has the SA_INTERRUPT flag set. -arca
-		 */
 	
-		/* read Pentium cycle counter */
-
-		rdtscl(last_tsc_low);
-
-		spin_lock(&i8253_lock);
-		outb_p(0x00, 0x43);     /* latch the count ASAP */
-
-		count = inb_p(0x40);    /* read the latched count */
-		count |= inb(0x40) << 8;
-		spin_unlock(&i8253_lock);
-
-		count = ((LATCH-1) - count) * TICK_SIZE;
-		delay_at_last_interrupt = (count + LATCH/2) / LATCH;
-	}
  
 	do_timer_interrupt(irq, NULL, regs);
 
@@ -510,85 +345,6 @@
 	return mktime(year, mon, day, hour, min, sec);
 }
 
-/* ------ Calibrate the TSC ------- 
- * Return 2^32 * (1 / (TSC clocks per usec)) for do_fast_gettimeoffset().
- * Too much 64-bit arithmetic here to do this cleanly in C, and for
- * accuracy's sake we want to keep the overhead on the CTC speaker (channel 2)
- * output busy loop as low as possible. We avoid reading the CTC registers
- * directly because of the awkward 8-bit access mechanism of the 82C54
- * device.
- */
-
-#define CALIBRATE_LATCH	(5 * LATCH)
-#define CALIBRATE_TIME	(5 * 1000020/HZ)
-
-#ifdef CONFIG_X86_TSC
-static unsigned long __init calibrate_tsc(void)
-{
-       /* Set the Gate high, disable speaker */
-	outb((inb(0x61) & ~0x02) | 0x01, 0x61);
-
-	/*
-	 * Now let's take care of CTC channel 2
-	 *
-	 * Set the Gate high, program CTC channel 2 for mode 0,
-	 * (interrupt on terminal count mode), binary count,
-	 * load 5 * LATCH count, (LSB and MSB) to begin countdown.
-	 */
-	outb(0xb0, 0x43);			/* binary, mode 0, LSB/MSB, Ch 2 */
-	outb(CALIBRATE_LATCH & 0xff, 0x42);	/* LSB of count */
-	outb(CALIBRATE_LATCH >> 8, 0x42);	/* MSB of count */
-
-	{
-		unsigned long startlow, starthigh;
-		unsigned long endlow, endhigh;
-		unsigned long count;
-
-		rdtsc(startlow,starthigh);
-		count = 0;
-		do {
-			count++;
-		} while ((inb(0x61) & 0x20) == 0);
-		rdtsc(endlow,endhigh);
-
-		last_tsc_low = endlow;
-
-		/* Error: ECTCNEVERSET */
-		if (count <= 1)
-			goto bad_ctc;
-
-		/* 64-bit subtract - gcc just messes up with long longs */
-		__asm__("subl %2,%0\n\t"
-			"sbbl %3,%1"
-			:"=a" (endlow), "=d" (endhigh)
-			:"g" (startlow), "g" (starthigh),
-			 "0" (endlow), "1" (endhigh));
-
-		/* Error: ECPUTOOFAST */
-		if (endhigh)
-			goto bad_ctc;
-
-		/* Error: ECPUTOOSLOW */
-		if (endlow <= CALIBRATE_TIME)
-			goto bad_ctc;
-
-		__asm__("divl %2"
-			:"=a" (endlow), "=d" (endhigh)
-			:"r" (endlow), "0" (0), "1" (CALIBRATE_TIME));
-
-		return endlow;
-	}
-
-	/*
-	 * The CTC wasn't reliable: we got a hit on the very first read,
-	 * or the CPU was so fast/slow that the quotient wouldn't fit in
-	 * 32 bits..
-	 */
-bad_ctc:
-	return 0;
-}
-#endif /* CONFIG_X86_TSC */
-
 static struct sys_device device_i8253 = {
 	.name		= "rtc",
 	.id		= 0,
@@ -605,119 +361,12 @@
 device_initcall(time_init_device);
 
 
-#ifdef CONFIG_CPU_FREQ
-
-static int
-time_cpufreq_notifier(struct notifier_block *nb, unsigned long val,
-		       void *data)
-{
-	struct cpufreq_freqs *freq = data;
-	unsigned int i;
-
-	if (!cpu_has_tsc)
-		return 0;
-
-	switch (val) {
-	case CPUFREQ_PRECHANGE:
-		if ((freq->old < freq->new) &&
-		((freq->cpu == CPUFREQ_ALL_CPUS) || (freq->cpu == 0)))  {
-			cpu_khz = cpufreq_scale(cpu_khz, freq->old, freq->new);
-		        fast_gettimeoffset_quotient = cpufreq_scale(fast_gettimeoffset_quotient, freq->new, freq->old);
-		}
-		for (i=0; i<NR_CPUS; i++)
-			if ((freq->cpu == CPUFREQ_ALL_CPUS) || (freq->cpu == i))
-				cpu_data[i].loops_per_jiffy = cpufreq_scale(cpu_data[i].loops_per_jiffy, freq->old, freq->new);
-		break;
-
-	case CPUFREQ_POSTCHANGE:
-		if ((freq->new < freq->old) &&
-		((freq->cpu == CPUFREQ_ALL_CPUS) || (freq->cpu == 0)))  {
-			cpu_khz = cpufreq_scale(cpu_khz, freq->old, freq->new);
-		        fast_gettimeoffset_quotient = cpufreq_scale(fast_gettimeoffset_quotient, freq->new, freq->old);
-		}
-		for (i=0; i<NR_CPUS; i++)
-			if ((freq->cpu == CPUFREQ_ALL_CPUS) || (freq->cpu == i))
-				cpu_data[i].loops_per_jiffy = cpufreq_scale(cpu_data[i].loops_per_jiffy, freq->old, freq->new);
-		break;
-	}
-
-	return 0;
-}
-
-static struct notifier_block time_cpufreq_notifier_block = {
-	notifier_call:	time_cpufreq_notifier
-};
-#endif
-
-
 void __init time_init(void)
 {
-#ifdef CONFIG_X86_TSC
-	extern int x86_udelay_tsc;
-#endif
 	
 	xtime.tv_sec = get_cmos_time();
 	xtime.tv_nsec = 0;
 
-/*
- * If we have APM enabled or the CPU clock speed is variable
- * (CPU stops clock on HLT or slows clock to save power)
- * then the TSC timestamps may diverge by up to 1 jiffy from
- * 'real time' but nothing will break.
- * The most frequent case is that the CPU is "woken" from a halt
- * state by the timer interrupt itself, so we get 0 error. In the
- * rare cases where a driver would "wake" the CPU and request a
- * timestamp, the maximum error is < 1 jiffy. But timestamps are
- * still perfectly ordered.
- * Note that the TSC counter will be reset if APM suspends
- * to disk; this won't break the kernel, though, 'cuz we're
- * smart.  See arch/i386/kernel/apm.c.
- */
-#ifdef CONFIG_X86_TSC
- 	/*
- 	 *	Firstly we have to do a CPU check for chips with
- 	 * 	a potentially buggy TSC. At this point we haven't run
- 	 *	the ident/bugs checks so we must run this hook as it
- 	 *	may turn off the TSC flag.
- 	 *
- 	 *	NOTE: this doesnt yet handle SMP 486 machines where only
- 	 *	some CPU's have a TSC. Thats never worked and nobody has
- 	 *	moaned if you have the only one in the world - you fix it!
- 	 */
- 
- 	dodgy_tsc();
- 	
-	if (cpu_has_tsc) {
-		unsigned long tsc_quotient = calibrate_tsc();
-		if (tsc_quotient) {
-			fast_gettimeoffset_quotient = tsc_quotient;
-			use_tsc = 1;
-			/*
-			 *	We could be more selective here I suspect
-			 *	and just enable this for the next intel chips ?
-			 */
-			x86_udelay_tsc = 1;
-#ifndef do_gettimeoffset
-			do_gettimeoffset = do_fast_gettimeoffset;
-#endif
-
-			/* report CPU clock rate in Hz.
-			 * The formula is (10^6 * 2^32) / (2^32 * 1 / (clocks/us)) =
-			 * clock/second. Our precision is about 100 ppm.
-			 */
-			{	unsigned long eax=0, edx=1000;
-				__asm__("divl %2"
-		       		:"=a" (cpu_khz), "=d" (edx)
-        	       		:"r" (tsc_quotient),
-	                	"0" (eax), "1" (edx));
-				printk("Detected %lu.%03lu MHz processor.\n", cpu_khz / 1000, cpu_khz % 1000);
-			}
-#ifdef CONFIG_CPU_FREQ
-			cpufreq_register_notifier(&time_cpufreq_notifier_block, CPUFREQ_TRANSITION_NOTIFIER);
-#endif
-		}
-	}
-#endif /* CONFIG_X86_TSC */
 
 	time_init_hook();
 }
diff -Nru a/arch/i386/kernel/timers/timer_pit.c b/arch/i386/kernel/timers/timer_pit.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/arch/i386/kernel/timers/timer_pit.c	Thu Oct 10 11:21:13 2002
@@ -0,0 +1,97 @@
+
+/* This function must be called with interrupts disabled 
+ * It was inspired by Steve McCanne's microtime-i386 for BSD.  -- jrs
+ * 
+ * However, the pc-audio speaker driver changes the divisor so that
+ * it gets interrupted rather more often - it loads 64 into the
+ * counter rather than 11932! This has an adverse impact on
+ * do_gettimeoffset() -- it stops working! What is also not
+ * good is that the interval that our timer function gets called
+ * is no longer 10.0002 ms, but 9.9767 ms. To get around this
+ * would require using a different timing source. Maybe someone
+ * could use the RTC - I know that this can interrupt at frequencies
+ * ranging from 8192Hz to 2Hz. If I had the energy, I'd somehow fix
+ * it so that at startup, the timer code in sched.c would select
+ * using either the RTC or the 8253 timer. The decision would be
+ * based on whether there was any other device around that needed
+ * to trample on the 8253. I'd set up the RTC to interrupt at 1024 Hz,
+ * and then do some jiggery to have a version of do_timer that 
+ * advanced the clock by 1/1024 s. Every time that reached over 1/100
+ * of a second, then do all the old code. If the time was kept correct
+ * then do_gettimeoffset could just return 0 - there is no low order
+ * divider that can be accessed.
+ *
+ * Ideally, you would be able to use the RTC for the speaker driver,
+ * but it appears that the speaker driver really needs interrupt more
+ * often than every 120 us or so.
+ *
+ * Anyway, this needs more thought....		pjsg (1993-08-28)
+ * 
+ * If you are really that interested, you should be reading
+ * comp.protocols.time.ntp!
+ */
+
+static unsigned long do_slow_gettimeoffset(void)
+{
+	int count;
+
+	static int count_p = LATCH;    /* for the first call after boot */
+	static unsigned long jiffies_p = 0;
+
+	/*
+	 * cache volatile jiffies temporarily; we have IRQs turned off. 
+	 */
+	unsigned long jiffies_t;
+
+	/* gets recalled with irq locally disabled */
+	spin_lock(&i8253_lock);
+	/* timer count may underflow right here */
+	outb_p(0x00, 0x43);	/* latch the count ASAP */
+
+	count = inb_p(0x40);	/* read the latched count */
+
+	/*
+	 * We do this guaranteed double memory access instead of a _p 
+	 * postfix in the previous port access. Wheee, hackady hack
+	 */
+ 	jiffies_t = jiffies;
+
+	count |= inb_p(0x40) << 8;
+	
+        /* VIA686a test code... reset the latch if count > max + 1 */
+        if (count > LATCH) {
+                outb_p(0x34, 0x43);
+                outb_p(LATCH & 0xff, 0x40);
+                outb(LATCH >> 8, 0x40);
+                count = LATCH - 1;
+        }
+	
+	spin_unlock(&i8253_lock);
+
+	/*
+	 * avoiding timer inconsistencies (they are rare, but they happen)...
+	 * there are two kinds of problems that must be avoided here:
+	 *  1. the timer counter underflows
+	 *  2. hardware problem with the timer, not giving us continuous time,
+	 *     the counter does small "jumps" upwards on some Pentium systems,
+	 *     (see c't 95/10 page 335 for Neptun bug.)
+	 */
+
+
+	if( jiffies_t == jiffies_p ) {
+		if( count > count_p ) {
+			/* the nutcase */
+			count = do_timer_overflow(count);
+		}
+	} else
+		jiffies_p = jiffies_t;
+
+	count_p = count;
+
+	count = ((LATCH-1) - count) * TICK_SIZE;
+	count = (count + LATCH/2) / LATCH;
+
+	return count;
+}
+
+static unsigned long (*do_gettimeoffset)(void) = do_slow_gettimeoffset;
diff -Nru a/arch/i386/kernel/timers/timer_tsc.c b/arch/i386/kernel/timers/timer_tsc.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/arch/i386/kernel/timers/timer_tsc.c	Thu Oct 10 11:21:13 2002
@@ -0,0 +1,262 @@
+/* Number of usecs that the last interrupt was delayed */
+static int delay_at_last_interrupt;
+
+static unsigned long last_tsc_low; /* lsb 32 bits of Time Stamp Counter */
+
+/* Cached *multiplier* to convert TSC counts to microseconds.
+ * (see the equation below).
+ * Equal to 2^32 * (1 / (clocks per usec) ).
+ * Initialized in time_init.
+ */
+unsigned long fast_gettimeoffset_quotient;
+
+static inline unsigned long do_fast_gettimeoffset(void)
+{
+	register unsigned long eax, edx;
+
+	/* Read the Time Stamp Counter */
+
+	rdtsc(eax,edx);
+
+	/* .. relative to previous jiffy (32 bits is enough) */
+	eax -= last_tsc_low;	/* tsc_low delta */
+
+	/*
+         * Time offset = (tsc_low delta) * fast_gettimeoffset_quotient
+         *             = (tsc_low delta) * (usecs_per_clock)
+         *             = (tsc_low delta) * (usecs_per_jiffy / clocks_per_jiffy)
+	 *
+	 * Using a mull instead of a divl saves up to 31 clock cycles
+	 * in the critical path.
+         */
+
+	__asm__("mull %2"
+		:"=a" (eax), "=d" (edx)
+		:"rm" (fast_gettimeoffset_quotient),
+		 "0" (eax));
+
+	/* our adjusted time offset in microseconds */
+	return delay_at_last_interrupt + edx;
+}
+
+
+
+if (use_tsc)
+	{
+		/*
+		 * It is important that these two operations happen almost at
+		 * the same time. We do the RDTSC stuff first, since it's
+		 * faster. To avoid any inconsistencies, we need interrupts
+		 * disabled locally.
+		 */
+
+		/*
+		 * Interrupts are just disabled locally since the timer irq
+		 * has the SA_INTERRUPT flag set. -arca
+		 */
+	
+		/* read Pentium cycle counter */
+
+		rdtscl(last_tsc_low);
+
+		spin_lock(&i8253_lock);
+		outb_p(0x00, 0x43);     /* latch the count ASAP */
+
+		count = inb_p(0x40);    /* read the latched count */
+		count |= inb(0x40) << 8;
+		spin_unlock(&i8253_lock);
+
+		count = ((LATCH-1) - count) * TICK_SIZE;
+		delay_at_last_interrupt = (count + LATCH/2) / LATCH;
+	}
+
+
+/* ------ Calibrate the TSC ------- 
+ * Return 2^32 * (1 / (TSC clocks per usec)) for do_fast_gettimeoffset().
+ * Too much 64-bit arithmetic here to do this cleanly in C, and for
+ * accuracy's sake we want to keep the overhead on the CTC speaker (channel 2)
+ * output busy loop as low as possible. We avoid reading the CTC registers
+ * directly because of the awkward 8-bit access mechanism of the 82C54
+ * device.
+ */
+
+#define CALIBRATE_LATCH	(5 * LATCH)
+#define CALIBRATE_TIME	(5 * 1000020/HZ)
+
+#ifdef CONFIG_X86_TSC
+static unsigned long __init calibrate_tsc(void)
+{
+       /* Set the Gate high, disable speaker */
+	outb((inb(0x61) & ~0x02) | 0x01, 0x61);
+
+	/*
+	 * Now let's take care of CTC channel 2
+	 *
+	 * Set the Gate high, program CTC channel 2 for mode 0,
+	 * (interrupt on terminal count mode), binary count,
+	 * load 5 * LATCH count, (LSB and MSB) to begin countdown.
+	 */
+	outb(0xb0, 0x43);			/* binary, mode 0, LSB/MSB, Ch 2 */
+	outb(CALIBRATE_LATCH & 0xff, 0x42);	/* LSB of count */
+	outb(CALIBRATE_LATCH >> 8, 0x42);	/* MSB of count */
+
+	{
+		unsigned long startlow, starthigh;
+		unsigned long endlow, endhigh;
+		unsigned long count;
+
+		rdtsc(startlow,starthigh);
+		count = 0;
+		do {
+			count++;
+		} while ((inb(0x61) & 0x20) == 0);
+		rdtsc(endlow,endhigh);
+
+		last_tsc_low = endlow;
+
+		/* Error: ECTCNEVERSET */
+		if (count <= 1)
+			goto bad_ctc;
+
+		/* 64-bit subtract - gcc just messes up with long longs */
+		__asm__("subl %2,%0\n\t"
+			"sbbl %3,%1"
+			:"=a" (endlow), "=d" (endhigh)
+			:"g" (startlow), "g" (starthigh),
+			 "0" (endlow), "1" (endhigh));
+
+		/* Error: ECPUTOOFAST */
+		if (endhigh)
+			goto bad_ctc;
+
+		/* Error: ECPUTOOSLOW */
+		if (endlow <= CALIBRATE_TIME)
+			goto bad_ctc;
+
+		__asm__("divl %2"
+			:"=a" (endlow), "=d" (endhigh)
+			:"r" (endlow), "0" (0), "1" (CALIBRATE_TIME));
+
+		return endlow;
+	}
+
+	/*
+	 * The CTC wasn't reliable: we got a hit on the very first read,
+	 * or the CPU was so fast/slow that the quotient wouldn't fit in
+	 * 32 bits..
+	 */
+bad_ctc:
+	return 0;
+}
+#endif /* CONFIG_X86_TSC */
+
+
+#ifdef CONFIG_CPU_FREQ
+
+static int
+time_cpufreq_notifier(struct notifier_block *nb, unsigned long val,
+		       void *data)
+{
+	struct cpufreq_freqs *freq = data;
+	unsigned int i;
+
+	if (!cpu_has_tsc)
+		return 0;
+
+	switch (val) {
+	case CPUFREQ_PRECHANGE:
+		if ((freq->old < freq->new) &&
+		((freq->cpu == CPUFREQ_ALL_CPUS) || (freq->cpu == 0)))  {
+			cpu_khz = cpufreq_scale(cpu_khz, freq->old, freq->new);
+		        fast_gettimeoffset_quotient = cpufreq_scale(fast_gettimeoffset_quotient, freq->new, freq->old);
+		}
+		for (i=0; i<NR_CPUS; i++)
+			if ((freq->cpu == CPUFREQ_ALL_CPUS) || (freq->cpu == i))
+				cpu_data[i].loops_per_jiffy = cpufreq_scale(cpu_data[i].loops_per_jiffy, freq->old, freq->new);
+		break;
+
+	case CPUFREQ_POSTCHANGE:
+		if ((freq->new < freq->old) &&
+		((freq->cpu == CPUFREQ_ALL_CPUS) || (freq->cpu == 0)))  {
+			cpu_khz = cpufreq_scale(cpu_khz, freq->old, freq->new);
+		        fast_gettimeoffset_quotient = cpufreq_scale(fast_gettimeoffset_quotient, freq->new, freq->old);
+		}
+		for (i=0; i<NR_CPUS; i++)
+			if ((freq->cpu == CPUFREQ_ALL_CPUS) || (freq->cpu == i))
+				cpu_data[i].loops_per_jiffy = cpufreq_scale(cpu_data[i].loops_per_jiffy, freq->old, freq->new);
+		break;
+	}
+
+	return 0;
+}
+
+static struct notifier_block time_cpufreq_notifier_block = {
+	notifier_call:	time_cpufreq_notifier
+};
+#endif
+
+
+
+#ifdef CONFIG_X86_TSC
+	extern int x86_udelay_tsc;
+#endif
+
+/*
+ * If we have APM enabled or the CPU clock speed is variable
+ * (CPU stops clock on HLT or slows clock to save power)
+ * then the TSC timestamps may diverge by up to 1 jiffy from
+ * 'real time' but nothing will break.
+ * The most frequent case is that the CPU is "woken" from a halt
+ * state by the timer interrupt itself, so we get 0 error. In the
+ * rare cases where a driver would "wake" the CPU and request a
+ * timestamp, the maximum error is < 1 jiffy. But timestamps are
+ * still perfectly ordered.
+ * Note that the TSC counter will be reset if APM suspends
+ * to disk; this won't break the kernel, though, 'cuz we're
+ * smart.  See arch/i386/kernel/apm.c.
+ */
+#ifdef CONFIG_X86_TSC
+ 	/*
+ 	 *	Firstly we have to do a CPU check for chips with
+ 	 * 	a potentially buggy TSC. At this point we haven't run
+ 	 *	the ident/bugs checks so we must run this hook as it
+ 	 *	may turn off the TSC flag.
+ 	 *
+ 	 *	NOTE: this doesnt yet handle SMP 486 machines where only
+ 	 *	some CPU's have a TSC. Thats never worked and nobody has
+ 	 *	moaned if you have the only one in the world - you fix it!
+ 	 */
+ 
+ 	dodgy_tsc();
+ 	
+	if (cpu_has_tsc) {
+		unsigned long tsc_quotient = calibrate_tsc();
+		if (tsc_quotient) {
+			fast_gettimeoffset_quotient = tsc_quotient;
+			use_tsc = 1;
+			/*
+			 *	We could be more selective here I suspect
+			 *	and just enable this for the next intel chips ?
+			 */
+			x86_udelay_tsc = 1;
+#ifndef do_gettimeoffset
+			do_gettimeoffset = do_fast_gettimeoffset;
+#endif
+
+			/* report CPU clock rate in Hz.
+			 * The formula is (10^6 * 2^32) / (2^32 * 1 / (clocks/us)) =
+			 * clock/second. Our precision is about 100 ppm.
+			 */
+			{	unsigned long eax=0, edx=1000;
+				__asm__("divl %2"
+		       		:"=a" (cpu_khz), "=d" (edx)
+        	       		:"r" (tsc_quotient),
+	                	"0" (eax), "1" (edx));
+				printk("Detected %lu.%03lu MHz processor.\n", cpu_khz / 1000, cpu_khz % 1000);
+			}
+#ifdef CONFIG_CPU_FREQ
+			cpufreq_register_notifier(&time_cpufreq_notifier_block, CPUFREQ_TRANSITION_NOTIFIER);
+#endif
+		}
+	}
+#endif /* CONFIG_X86_TSC */
