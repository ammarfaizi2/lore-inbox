Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261692AbTHTBVo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 21:21:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261695AbTHTBVo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 21:21:44 -0400
Received: from fmr09.intel.com ([192.52.57.35]:60918 "EHLO hermes.hd.intel.com")
	by vger.kernel.org with ESMTP id S261692AbTHTBVU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 21:21:20 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C366B9.4F6435D2"
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Subject: [PATCH][2.6][3/5]Support for HPET based timer
Date: Tue, 19 Aug 2003 18:20:58 -0700
Message-ID: <C8C38546F90ABF408A5961FC01FDBF1902C7D1CD@fmsmsx405.fm.intel.com>
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH][2.6][3/5]Support for HPET based timer
Thread-Index: AcNmuU9QXI51BirlQp6poU/S7BrTkw==
From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
To: <linux-kernel@vger.kernel.org>
Cc: <torvalds@osdl.org>, "Nakajima, Jun" <jun.nakajima@intel.com>,
       "Mallick, Asit K" <asit.k.mallick@intel.com>
X-OriginalArrivalTime: 20 Aug 2003 01:20:58.0717 (UTC) FILETIME=[4F9CE0D0:01C366B9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C366B9.4F6435D2
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[Resend - The original mail hasn't yet appeared on lkml, even 5 hours=20
after posting]

3/5 - hpet3.patch - All changes required to support timer services
                    (gettimeofday) with HPET.

diff -purN linux-2.6.0-test1/arch/i386/kernel/timers/timer.c =
linux-2.6.0-test1-hpet/arch/i386/kernel/timers/timer.c
--- linux-2.6.0-test1/arch/i386/kernel/timers/timer.c	2003-07-13 =
20:38:41.000000000 -0700
+++ linux-2.6.0-test1-hpet/arch/i386/kernel/timers/timer.c	2003-08-18 =
14:09:26.000000000 -0700
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
diff -purN linux-2.6.0-test1/arch/i386/kernel/timers/timer_hpet.c =
linux-2.6.0-test1-hpet/arch/i386/kernel/timers/timer_hpet.c
--- linux-2.6.0-test1/arch/i386/kernel/timers/timer_hpet.c	1969-12-31 =
16:00:00.000000000 -0800
+++ linux-2.6.0-test1-hpet/arch/i386/kernel/timers/timer_hpet.c	=
2003-08-18 17:20:36.000000000 -0700
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
diff -purN linux-2.6.0-test1/arch/i386/kernel/timers/timer_tsc.c =
linux-2.6.0-test1-hpet/arch/i386/kernel/timers/timer_tsc.c
--- linux-2.6.0-test1/arch/i386/kernel/timers/timer_tsc.c	2003-07-13 =
20:35:57.000000000 -0700
+++ linux-2.6.0-test1-hpet/arch/i386/kernel/timers/timer_tsc.c	=
2003-08-18 17:25:50.000000000 -0700
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
diff -purN linux-2.6.0-test1/include/asm-i386/timer.h =
linux-2.6.0-test1-hpet/include/asm-i386/timer.h
--- linux-2.6.0-test1/include/asm-i386/timer.h	2003-07-13 =
20:32:28.000000000 -0700
+++ linux-2.6.0-test1-hpet/include/asm-i386/timer.h	2003-08-18 =
13:52:52.000000000 -0700
@@ -38,4 +38,8 @@ extern struct timer_opts timer_tsc;
 extern struct timer_opts timer_cyclone;
 #endif
=20
+#ifdef CONFIG_HPET_TIMER
+extern struct timer_opts timer_hpet;
+#endif
+
 #endif



------_=_NextPart_001_01C366B9.4F6435D2
Content-Type: application/x-zip-compressed;
	name="hpet3.ZIP"
Content-Transfer-Encoding: base64
Content-Description: hpet3.ZIP
Content-Disposition: attachment;
	filename="hpet3.ZIP"

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

------_=_NextPart_001_01C366B9.4F6435D2--
