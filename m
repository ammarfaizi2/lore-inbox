Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264468AbTH1Xqo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Aug 2003 19:46:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264493AbTH1Xqn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Aug 2003 19:46:43 -0400
Received: from fmr09.intel.com ([192.52.57.35]:6124 "EHLO hermes.hd.intel.com")
	by vger.kernel.org with ESMTP id S264468AbTH1XpG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Aug 2003 19:45:06 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C36DBE.61E6F576"
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Subject: [PATCH][2.6-test4][5/6]Support for HPET based timer
Date: Thu, 28 Aug 2003 16:44:55 -0700
Message-ID: <C8C38546F90ABF408A5961FC01FDBF1902C7D216@fmsmsx405.fm.intel.com>
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH][2.6-test4][5/6]Support for HPET based timer
Thread-Index: AcNtvmHMeC9zwY38SIu1AuxbZ6iPMQ==
From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
To: <torvalds@osdl.org>, <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>, "Nakajima, Jun" <jun.nakajima@intel.com>
X-OriginalArrivalTime: 28 Aug 2003 23:44:55.0407 (UTC) FILETIME=[62214FF0:01C36DBE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C36DBE.61E6F576
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

5/6 - hpet5.patch - All changes required to support timer services
                    (gettimeofday) with HPET.




diff -purN linux-2.6.0-test4/arch/i386/kernel/timers/timer.c =
linux-2.6.0-test4-hpet/arch/i386/kernel/timers/timer.c
--- linux-2.6.0-test4/arch/i386/kernel/timers/timer.c	2003-08-22 =
17:01:02.000000000 -0700
+++ linux-2.6.0-test4-hpet/arch/i386/kernel/timers/timer.c	2003-08-28 =
12:18:15.000000000 -0700
@@ -3,11 +3,22 @@
 #include <linux/string.h>
 #include <asm/timer.h>
=20
+#ifdef CONFIG_HPET_TIMER
+/*=20
+ * HPET memory read is slower than tsc reads, but is more dependable as =
it=20
+ * always runs at constant frequency and reduces complexity due to
+ * cpufreq. So, we prefer HPET timer to tsc based one. Also, we cannot =
use
+ * timer_pit when HPET is active. So, we default to timer_tsc.
+ */
+#endif
 /* list of timers, ordered by preference, NULL terminated */
 static struct timer_opts* timers[] =3D {
 #ifdef CONFIG_X86_CYCLONE_TIMER
 	&timer_cyclone,
 #endif
+#ifdef CONFIG_HPET_TIMER
+	&timer_hpet,
+#endif
 	&timer_tsc,
 	&timer_pit,
 	NULL,
diff -purN linux-2.6.0-test4/arch/i386/kernel/timers/timer_hpet.c =
linux-2.6.0-test4-hpet/arch/i386/kernel/timers/timer_hpet.c
--- linux-2.6.0-test4/arch/i386/kernel/timers/timer_hpet.c	1969-12-31 =
16:00:00.000000000 -0800
+++ linux-2.6.0-test4-hpet/arch/i386/kernel/timers/timer_hpet.c	=
2003-08-28 12:18:15.000000000 -0700
@@ -0,0 +1,243 @@
+/*
+ * This code largely moved from arch/i386/kernel/time.c.
+ * See comments there for proper credits.
+ */
+
+#include <linux/spinlock.h>
+#include <linux/init.h>
+#include <linux/timex.h>
+#include <linux/errno.h>
+#include <linux/string.h>
+
+#include <asm/timer.h>
+#include <asm/io.h>
+#include <asm/processor.h>
+
+#include "io_ports.h"
+#include "mach_timer.h"
+#include <asm/hpet.h>
+
+extern volatile unsigned long jiffies;
+
+static unsigned long hpet_usec_quotient;	/* convert hpet clks to usec =
*/
+static unsigned long tsc_hpet_quotient;		/* convert tsc to hpet clks */
+static unsigned long hpet_last; 	/* hpet counter value at last tick*/
+static unsigned long last_tsc_low;	/* lsb 32 bits of Time Stamp Counter =
*/
+static unsigned long last_tsc_high; 	/* msb 32 bits of Time Stamp =
Counter */
+static unsigned long long monotonic_base;
+static rwlock_t monotonic_lock =3D RW_LOCK_UNLOCKED;
+
+/* convert from cycles(64bits) =3D> nanoseconds (64bits)
+ *  basic equation:
+ *		ns =3D cycles / (freq / ns_per_sec)
+ *		ns =3D cycles * (ns_per_sec / freq)
+ *		ns =3D cycles * (10^9 / (cpu_mhz * 10^6))
+ *		ns =3D cycles * (10^3 / cpu_mhz)
+ *
+ *	Then we use scaling math (suggested by george@mvista.com) to get:
+ *		ns =3D cycles * (10^3 * SC / cpu_mhz) / SC
+ *		ns =3D cycles * cyc2ns_scale / SC
+ *
+ *	And since SC is a constant power of two, we can convert the div
+ *  into a shift.  =20
+ *			-johnstul@us.ibm.com "math is hard, lets go shopping!"
+ */
+static unsigned long cyc2ns_scale;=20
+#define CYC2NS_SCALE_FACTOR 10 /* 2^10, carefully chosen */
+
+static inline void set_cyc2ns_scale(unsigned long cpu_mhz)
+{
+	cyc2ns_scale =3D (1000 << CYC2NS_SCALE_FACTOR)/cpu_mhz;
+}
+
+static inline unsigned long long cycles_2_ns(unsigned long long cyc)
+{
+	return (cyc * cyc2ns_scale) >> CYC2NS_SCALE_FACTOR;
+}
+
+static unsigned long long monotonic_clock_hpet(void)
+{
+	unsigned long long last_offset, this_offset, base;
+=09
+	/* atomically read monotonic base & last_offset */
+	read_lock_irq(&monotonic_lock);
+	last_offset =3D ((unsigned long long)last_tsc_high<<32)|last_tsc_low;
+	base =3D monotonic_base;
+	read_unlock_irq(&monotonic_lock);
+
+	/* Read the Time Stamp Counter */
+	rdtscll(this_offset);
+
+	/* return the value in ns */
+	return base + cycles_2_ns(this_offset - last_offset);
+}
+
+static unsigned long get_offset_hpet(void)
+{
+	register unsigned long eax, edx;
+
+	eax =3D hpet_readl(HPET_COUNTER);
+	eax -=3D hpet_last;	/* hpet delta */
+
+	/*
+         * Time offset =3D (hpet delta) * ( usecs per HPET clock )
+	 *             =3D (hpet delta) * ( usecs per tick / HPET clocks per =
tick)
+	 *             =3D (hpet delta) * ( hpet_usec_quotient ) / (2^32)
+	 *
+	 * Where,
+	 * hpet_usec_quotient =3D (2^32 * usecs per tick)/HPET clocks per tick
+	 *=20
+	 * Using a mull instead of a divl saves some cycles in critical path.
+         */
+	ASM_MUL64_REG(eax, edx, hpet_usec_quotient, eax);
+
+	/* our adjusted time offset in microseconds */
+	return edx;
+}
+
+static void mark_offset_hpet(void)
+{
+	unsigned long long this_offset, last_offset;
+	unsigned long offset;
+
+	write_lock(&monotonic_lock);
+	last_offset =3D ((unsigned long long)last_tsc_high<<32)|last_tsc_low;
+	rdtsc(last_tsc_low, last_tsc_high);
+
+	offset =3D hpet_readl(HPET_T0_CMP) - hpet_tick;
+	if (unlikely(((offset - hpet_last) > hpet_tick) && (hpet_last !=3D =
0))) {
+		int lost_ticks =3D (offset - hpet_last) / hpet_tick;
+		jiffies +=3D lost_ticks;
+	}
+	hpet_last =3D offset;
+
+	/* update the monotonic base value */
+	this_offset =3D ((unsigned long long)last_tsc_high<<32)|last_tsc_low;
+	monotonic_base +=3D cycles_2_ns(this_offset - last_offset);
+	write_unlock(&monotonic_lock);
+}
+
+void delay_hpet(unsigned long loops)
+{
+	unsigned long hpet_start, hpet_end;
+	unsigned long eax;
+
+	/* loops is the number of cpu cycles. Convert it to hpet clocks */
+	ASM_MUL64_REG(eax, loops, tsc_hpet_quotient, loops);
+
+	hpet_start =3D hpet_readl(HPET_COUNTER);
+	do {
+		rep_nop();
+		hpet_end =3D hpet_readl(HPET_COUNTER);
+	} while ((hpet_end - hpet_start) < (loops));
+}
+
+/* ------ Calibrate the TSC -------=20
+ * Return 2^32 * (1 / (TSC clocks per usec)) for getting the CPU freq.
+ * Set 2^32 * (1 / (tsc per HPET clk)) for delay_hpet().
+ * calibrate_tsc() calibrates the processor TSC by comparing
+ * it to the HPET timer of known frequency.
+ * Too much 64-bit arithmetic here to do this cleanly in C
+ */
+#define CALIBRATE_CNT_HPET 	(5 * hpet_tick)
+#define CALIBRATE_TIME_HPET 	(5 * KERNEL_TICK_USEC)
+
+static unsigned long __init calibrate_tsc(void)
+{
+	unsigned long tsc_startlow, tsc_starthigh;
+	unsigned long tsc_endlow, tsc_endhigh;
+	unsigned long hpet_start, hpet_end;
+	unsigned long result, remain;
+
+	hpet_start =3D hpet_readl(HPET_COUNTER);
+	rdtsc(tsc_startlow, tsc_starthigh);
+	do {
+		hpet_end =3D hpet_readl(HPET_COUNTER);
+	} while ((hpet_end - hpet_start) < CALIBRATE_CNT_HPET);
+	rdtsc(tsc_endlow, tsc_endhigh);
+
+	/* 64-bit subtract - gcc just messes up with long longs */
+	__asm__("subl %2,%0\n\t"
+		"sbbl %3,%1"
+		:"=3Da" (tsc_endlow), "=3Dd" (tsc_endhigh)
+		:"g" (tsc_startlow), "g" (tsc_starthigh),
+		 "0" (tsc_endlow), "1" (tsc_endhigh));
+
+	/* Error: ECPUTOOFAST */
+	if (tsc_endhigh)
+		goto bad_calibration;
+
+	/* Error: ECPUTOOSLOW */
+	if (tsc_endlow <=3D CALIBRATE_TIME_HPET)
+		goto bad_calibration;
+
+	ASM_DIV64_REG(result, remain, tsc_endlow, 0, CALIBRATE_TIME_HPET);
+	if (remain > (tsc_endlow >> 1))
+		result++; /* rounding the result */
+
+	ASM_DIV64_REG(tsc_hpet_quotient, remain, tsc_endlow, 0,=20
+			CALIBRATE_CNT_HPET);
+	if (remain > (tsc_endlow >> 1))
+		tsc_hpet_quotient++; /* rounding the result */
+
+	return result;
+bad_calibration:
+	/*
+	 * the CPU was so fast/slow that the quotient wouldn't fit in
+	 * 32 bits..
+	 */
+	return 0;
+}
+
+static int __init init_hpet(char* override)
+{
+
+	/* check clock override */
+	if (override[0] && strncmp(override,"hpet",4))
+		return -ENODEV;
+
+	if (!is_hpet_enabled())
+		return -ENODEV;
+
+	printk("Using HPET for gettimeofday\n");
+	if (cpu_has_tsc) {
+		unsigned long tsc_quotient =3D calibrate_tsc();
+		if (tsc_quotient) {
+			/* report CPU clock rate in Hz.
+			 * The formula is (10^6 * 2^32) / (2^32 * 1 / (clocks/us)) =3D
+			 * clock/second. Our precision is about 100 ppm.
+			 */
+			{	unsigned long eax=3D0, edx=3D1000;
+				ASM_DIV64_REG(cpu_khz, edx, tsc_quotient,=20
+						eax, edx);
+				printk("Detected %lu.%03lu MHz processor.\n", cpu_khz / 1000, =
cpu_khz % 1000);
+			}
+			set_cyc2ns_scale(cpu_khz/1000);
+		}
+	}
+	{
+		/*
+		 * Math to calculate hpet to usec multiplier=20
+		 * Look for the comments at get_offset_hpet()
+		 */
+		unsigned long result, remain;
+		ASM_DIV64_REG(result, remain, hpet_tick, 0, KERNEL_TICK_USEC);
+		if (remain > (hpet_tick >> 1))
+			result++; /* rounding the result */
+
+		hpet_usec_quotient =3D result;
+	}
+	return 0;
+}
+
+/************************************************************/
+
+/* tsc timer_opts struct */
+struct timer_opts timer_hpet =3D {
+	.init =3D			init_hpet,
+	.mark_offset =3D		mark_offset_hpet,=20
+	.get_offset =3D		get_offset_hpet,
+	.monotonic_clock =3D	monotonic_clock_hpet,
+	.delay =3D 		delay_hpet,
+};
+
diff -purN linux-2.6.0-test4/arch/i386/kernel/timers/timer_tsc.c =
linux-2.6.0-test4-hpet/arch/i386/kernel/timers/timer_tsc.c
--- linux-2.6.0-test4/arch/i386/kernel/timers/timer_tsc.c	2003-08-22 =
16:57:48.000000000 -0700
+++ linux-2.6.0-test4-hpet/arch/i386/kernel/timers/timer_tsc.c	=
2003-08-28 12:18:15.000000000 -0700
@@ -19,9 +19,18 @@
 #include "io_ports.h"
 #include "mach_timer.h"
=20
+#include <asm/hpet.h>
+
+#ifdef CONFIG_HPET_TIMER
+static unsigned long hpet_usec_quotient;
+static unsigned long hpet_last;
+struct timer_opts timer_tsc;
+#endif
+
 int tsc_disable __initdata =3D 0;
=20
 extern spinlock_t i8253_lock;
+extern volatile unsigned long jiffies;
=20
 static int use_tsc;
 /* Number of usecs that the last interrupt was delayed */
@@ -232,7 +241,7 @@ static void delay_tsc(unsigned long loop
=20
 #define CALIBRATE_TIME	(5 * 1000020/HZ)
=20
-unsigned long __init calibrate_tsc(void)
+static unsigned long __init calibrate_tsc(void)
 {
 	mach_prepare_counter();
=20
@@ -282,6 +291,107 @@ bad_ctc:
 	return 0;
 }
=20
+#ifdef CONFIG_HPET_TIMER
+static void mark_offset_tsc_hpet(void)
+{
+	unsigned long long this_offset, last_offset;
+ 	unsigned long offset, temp, hpet_current;
+
+	write_lock(&monotonic_lock);
+	last_offset =3D ((unsigned long long)last_tsc_high<<32)|last_tsc_low;
+	/*
+	 * It is important that these two operations happen almost at
+	 * the same time. We do the RDTSC stuff first, since it's
+	 * faster. To avoid any inconsistencies, we need interrupts
+	 * disabled locally.
+	 */
+	/*
+	 * Interrupts are just disabled locally since the timer irq
+	 * has the SA_INTERRUPT flag set. -arca
+	 */
+	/* read Pentium cycle counter */
+
+	hpet_current =3D hpet_readl(HPET_COUNTER);
+	rdtsc(last_tsc_low, last_tsc_high);
+
+	/* lost tick compensation */
+	offset =3D hpet_readl(HPET_T0_CMP) - hpet_tick;
+	if (unlikely(((offset - hpet_last) > hpet_tick) && (hpet_last !=3D =
0))) {
+		int lost_ticks =3D (offset - hpet_last) / hpet_tick;
+		jiffies +=3D lost_ticks;
+	}
+	hpet_last =3D hpet_current;
+
+	/* update the monotonic base value */
+	this_offset =3D ((unsigned long long)last_tsc_high<<32)|last_tsc_low;
+	monotonic_base +=3D cycles_2_ns(this_offset - last_offset);
+	write_unlock(&monotonic_lock);
+
+	/* calculate delay_at_last_interrupt */
+	/*
+	 * Time offset =3D (hpet delta) * ( usecs per HPET clock )
+	 *             =3D (hpet delta) * ( usecs per tick / HPET clocks per =
tick)
+	 *             =3D (hpet delta) * ( hpet_usec_quotient ) / (2^32)
+	 * Where,
+	 * hpet_usec_quotient =3D (2^32 * usecs per tick)/HPET clocks per tick
+	 */
+	delay_at_last_interrupt =3D hpet_current - offset;
+	ASM_MUL64_REG(temp, delay_at_last_interrupt,=20
+			hpet_usec_quotient, delay_at_last_interrupt);
+}
+
+/* ------ Calibrate the TSC based on HPET timer -------=20
+ * Return 2^32 * (1 / (TSC clocks per usec)) for =
do_fast_gettimeoffset().
+ * calibrate_tsc() calibrates the processor TSC by comparing
+ * it to the HPET timer of known frequency.
+ * Too much 64-bit arithmetic here to do this cleanly in C
+ */
+
+#define CALIBRATE_CNT_HPET 	(5 * hpet_tick)
+#define CALIBRATE_TIME_HPET 	(5 * KERNEL_TICK_USEC)
+
+unsigned long __init calibrate_tsc_hpet(void)
+{
+	unsigned long tsc_startlow, tsc_starthigh;
+	unsigned long tsc_endlow, tsc_endhigh;
+	unsigned long hpet_start, hpet_end;
+	unsigned long result, remain;
+
+	hpet_start =3D hpet_readl(HPET_COUNTER);
+	rdtsc(tsc_startlow, tsc_starthigh);
+	do {
+		hpet_end =3D hpet_readl(HPET_COUNTER);
+	} while ((hpet_end - hpet_start) < CALIBRATE_CNT_HPET);
+	rdtsc(tsc_endlow, tsc_endhigh);
+
+	/* 64-bit subtract - gcc just messes up with long longs */
+	__asm__("subl %2,%0\n\t"
+		"sbbl %3,%1"
+		:"=3Da" (tsc_endlow), "=3Dd" (tsc_endhigh)
+		:"g" (tsc_startlow), "g" (tsc_starthigh),
+		 "0" (tsc_endlow), "1" (tsc_endhigh));
+
+	/* Error: ECPUTOOFAST */
+	if (tsc_endhigh)
+		goto bad_calibration;
+
+	/* Error: ECPUTOOSLOW */
+	if (tsc_endlow <=3D CALIBRATE_TIME_HPET)
+		goto bad_calibration;
+
+	ASM_DIV64_REG(result, remain, tsc_endlow, 0, CALIBRATE_TIME_HPET);
+	if (remain > (tsc_endlow >> 1))
+		result++; /* rounding the result */
+
+	return result;
+bad_calibration:
+	/*
+	 * the CPU was so fast/slow that the quotient wouldn't fit in
+	 * 32 bits..
+	 */
+	return 0;
+}
+#endif
=20
 #ifdef CONFIG_CPU_FREQ
 static unsigned int  ref_freq =3D 0;
@@ -333,8 +443,16 @@ static int __init init_tsc(char* overrid
 {
=20
 	/* check clock override */
-	if (override[0] && strncmp(override,"tsc",3))
+	if (override[0] && strncmp(override,"tsc",3)) {
+#ifdef CONFIG_HPET_TIMER
+		if (is_hpet_enabled()) {
+			printk(KERN_ERR "Warning: clock=3D override failed. Defaulting to =
tsc\n");
+		} else
+#endif
+		{
 			return -ENODEV;
+		}
+	}
=20
 	/*
 	 * If we have APM enabled or the CPU clock speed is variable
@@ -368,7 +486,29 @@ static int __init init_tsc(char* overrid
 	count2 =3D LATCH; /* initialize counter for mark_offset_tsc() */
=20
 	if (cpu_has_tsc) {
-		unsigned long tsc_quotient =3D calibrate_tsc();
+		unsigned long tsc_quotient;
+#ifdef CONFIG_HPET_TIMER
+		if (is_hpet_enabled()){
+			unsigned long result, remain;
+			printk("Using TSC for gettimeofday\n");
+			tsc_quotient =3D calibrate_tsc_hpet();
+			timer_tsc.mark_offset =3D &mark_offset_tsc_hpet;
+			/*
+			 * Math to calculate hpet to usec multiplier=20
+			 * Look for the comments at get_offset_tsc_hpet()
+			 */
+			ASM_DIV64_REG(result, remain, hpet_tick,=20
+					0, KERNEL_TICK_USEC);
+			if (remain > (hpet_tick >> 1))
+				result++; /* rounding the result */
+
+			hpet_usec_quotient =3D result;
+		} else
+#endif
+		{
+			tsc_quotient =3D calibrate_tsc();
+		}
+
 		if (tsc_quotient) {
 			fast_gettimeoffset_quotient =3D tsc_quotient;
 			use_tsc =3D 1;
diff -purN linux-2.6.0-test4/include/asm-i386/timer.h =
linux-2.6.0-test4-hpet/include/asm-i386/timer.h
--- linux-2.6.0-test4/include/asm-i386/timer.h	2003-08-22 =
16:53:38.000000000 -0700
+++ linux-2.6.0-test4-hpet/include/asm-i386/timer.h	2003-08-28 =
12:18:15.000000000 -0700
@@ -38,4 +38,8 @@ extern struct timer_opts timer_tsc;
 extern struct timer_opts timer_cyclone;
 #endif
=20
+#ifdef CONFIG_HPET_TIMER
+extern struct timer_opts timer_hpet;
+#endif
+
 #endif



------_=_NextPart_001_01C36DBE.61E6F576
Content-Type: application/x-zip-compressed;
	name="hpet05.ZIP"
Content-Transfer-Encoding: base64
Content-Description: hpet05.ZIP
Content-Disposition: attachment;
	filename="hpet05.ZIP"

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
AAAAAQABADoAAACQDwAAAAA=

------_=_NextPart_001_01C36DBE.61E6F576--
