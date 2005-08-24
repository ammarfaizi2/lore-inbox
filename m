Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932489AbVHXAg0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932489AbVHXAg0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 20:36:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932515AbVHXAg0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 20:36:26 -0400
Received: from mail-red.bigfish.com ([216.148.222.61]:55283 "EHLO
	mail61-red-R.bigfish.com") by vger.kernel.org with ESMTP
	id S932489AbVHXAgZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 20:36:25 -0400
X-BigFish: V
Message-ID: <430BC107.60501@am.sony.com>
Date: Tue, 23 Aug 2005 17:36:23 -0700
From: Tim Bird <tim.bird@am.sony.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: tony.luck@intel.com, linux-kernel@vger.kernel.org, jasonuhl@sgi.com
Subject: Re: CONFIG_PRINTK_TIME woes
References: <20050821021616.6bbf2a14.akpm@osdl.org>
In-Reply-To: <20050821021616.6bbf2a14.akpm@osdl.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Andrew Morton <akpm@osdl.org> wrote:
> 
>>How about we give each arch a printk_clock()?
> 
> 
> Which might be as simple as this..
> 
> 
> --- devel/kernel/printk.c~printk_clock	2005-08-21 02:14:05.000000000
> -0700
> +++ devel-akpm/kernel/printk.c	2005-08-21 02:15:14.000000000 -0700
> @@ -488,6 +488,11 @@ static int __init printk_time_setup(char
>  
>  __setup("time", printk_time_setup);
>  
> +__attribute__((weak)) unsigned long long printk_clock(void)
> +{
> +	return sched_clock();
> +}
> +

It might be good to call it "instrumentation_clock", or "tracing_clock"
or something similar.  Other tracing systems have similar requirements
and I think this would be a generally useful thing to have.

At CELF, we investigated different in-kernel timing interfaces for
tracing, and came up with a proposal for our own API.  See
http://tree.celinuxforum.org/pubwiki/moin.cgi/InstrumentationAPI
This was over a year ago and the information is somewhat dated.
We ended up not pursuing this, and just using sched_clock().

I've been advocating that CE vendors beef up their sched_clock()
implementations to be better than jiffy resolution, but if this
is an abuse, I'd rather steer developers to provide platform
support for an API that is dedicated to this purpose.

It sounds like the requirements are:
 - 64-bit value, sub-microsecond resolution
   - although for tracing we prefer to store only 32-bits
   and microseconds seems to give a decent balance between
   precision and rollover avoidance.
 - lockless
 - (for me) available VERY early
 (On some platforms, we have the firmware set up the clock so
 it can be read immediately from start_kernel() on)
 - (not sure how important is timestamp coherency between
 processors)

My apologies in advance for the following code, which is
sure to make your eyes bleed ;-), but here's some code
from a tracing system that supports several different
embedded boards.  This is from kft.c:

(I'm NOT advocating adopting this code - I'm just posting
for reference for the API it provides, and to show a couple
of different implementation approaches.  This particular code
uses an unsigned long (assumed to be 32-bits), and tries
to defer overflows with funky math.)

+/* control whether a generic or custom clock routine is used */
+#if !defined(CONFIG_MIPS) && !defined(CONFIG_SH)
+#define GENERIC_KFTREADCLOCK 1
+#endif
+
+#ifdef GENERIC_KFTREADCLOCK
+/*
+ * Define a genefic kft_readclock routine.
+ * This should work well enough for platforms where sched_clock()
+ * gives good (sub-microsecond) precision.
+ *
+ * There are valid reasons to use other routines, including:
+ *  - when using kft for boot timings
+ *    - on most platforms, sched_clock() does not work correctly until
+ *    after time_init()
+ *  - reduced overhead for obtaining a microsecond value
+ *    (This may be incorrect, since at most this adds one
+ *    64-bit-by-32-bit divide, in addition to the shift that
+ *    is inside sched_clock(). KFT does enough other stuff
+ *    that this one divide is probably not a major factor
+ *    in KFT overhead.)
+ */
+static inline unsigned long __noinstrument kft_readclock(void)
+{
+	unsigned long long t;
+	
+	t = sched_clock();
+	/* convert to microseconds */
+	do_div(t,1000);
+	return (unsigned long)t;
+}
+
+static inline unsigned long __noinstrument kft_clock_to_usecs(unsigned long clock)
+{
+	return clock;
+}
+
+#endif /* GENERIC_KFTREADCLOCK - non-MIPS, non-SH */
+
+#ifndef GENERIC_KFTREADCLOCK
+/*
+ * Use arch-specific kft_readclock() and kft_clock_to_usecs() routines
+ *
+ * First - define some platform-specific constants
+ *
+ * !! If using a non-generic KFT readclock, you need
+ * to set the following constants for your machine!!
+ *
+ * CLOCK_FREQ is a hardcoded value for the frequency of
+ * whatever clock you are using for kft_readclock()
+ * It would be nice to use a probed clock freq (cpu_hz)
+ * here, but it  isn't set early enough for some boot
+ * measurements.
+ * Hint: for x86, boot once and look at /proc/cpuinfo
+ *
+ * CLOCK_SHIFT is used to bring the clock frequency into
+ * a manageable range.  For my 3 GHz machine, I decided
+ * to divide the cpu cycle clock by 8. This throws
+ * away some clock precision, but makes some of the
+ * other math faster and helps us stay in 32 bits.
+ */
+
+#ifdef CONFIG_X86_TSC
+// Tim's old laptop
+//#define CLOCK_FREQ 645206000ULL
+// Tim's HP desktop
+#define CLOCK_FREQ 2992332000ULL
+#define CLOCK_SHIFT	3
+#endif /* CONFIG_X86_TSC */
+
+#ifdef CONFIG_PPC32
+// Ebony board
+#define CLOCK_FREQ 400000000ULL
+#define CLOCK_SHIFT	3
+#endif /* CONFIG_PPC32 */
+
+#ifdef CONFIG_CPU_SH4
+#define CLOCK_FREQ 15000000ULL	/* =P/4 */
+#define CLOCK_SHIFT	0
+#endif /* CONFIG_CPU_SH4 */
+
+#ifdef CONFIG_MIPS
+/* tx4938 */
+#define CLOCK_FREQ ( 300000000ULL / 2 )
+#define CLOCK_SHIFT	3
+#endif /* CONFIG_MIPS */
+
+
+
+#ifdef CONFIG_X86_TSC
+#include <asm/time.h>	/* for rdtscll macro */
+static inline unsigned long kft_readclock(void)
+{
+	unsigned long long ticks;
+
+	rdtscll(ticks);
+	return (unsigned long)((ticks>>CLOCK_SHIFT) & 0xffffffff);
+}
+#endif /* CONFIG_X86_TSC */
+
+
+#ifdef CONFIG_PPC32
+#include <asm/time.h>	/* for get_tbu macro */
+/* copied from sched_clock for ppc */
+static inline unsigned long kft_readclock(void)
+{
+	unsigned long lo, hi, hi2;
+	unsigned long long ticks;
+
+	do {
+		hi = get_tbu();
+		lo = get_tbl();
+		hi2 = get_tbu();
+	} while (hi2 != hi);
+	ticks = ((unsigned long long) hi << 32) | lo;
+	return (unsigned long)((ticks>>CLOCK_SHIFT) & 0xffffffff);
+}
+#endif /* CONFIG_PPC32 */
+
+#ifdef CONFIG_CPU_SH4
+/*
+ * In advance, start Timer Unit4(TMU4)
+ * ex.
+ *  *TMU4_TCR = 0x0000;
+ *  *TMU4_TCOR = 0;
+ *  *TMU4_TCNT = 0;
+ *  *TMU_TSTR2 = (*TMU_TSTR2|0x02);
+ */
+#define TMU4_TCNT	((volatile unsigned long *)0xFE100018)
+
+static inline unsigned long kft_readclock(void)
+{
+	return (-(*TMU4_TCNT))>>CLOCK_SHIFT;
+}
+#endif /* CONFIG_CPU_SH4 */
+
+#ifdef CONFIG_MIPS
+static inline unsigned long kft_readclock(void)
+{
+	return (unsigned long)read_c0_count();
+}
+#endif /* CONFIG_MIPS */
+
+/*
+ * Now define a generic routine to convert from clock tics to usecs.
+ *
+ * This weird scaling factor makes it possible to use shifts and a
+ * single 32-bit divide, instead of more expensive math,
+ * for the conversion to microseconds.
+ */
+#define CLOCK_SCALE ((((CLOCK_FREQ*1024*1024)/1000000))>>CLOCK_SHIFT)
+
+static inline unsigned long kft_clock_to_usecs(unsigned long clock)
+{
+	/* math to stay in 32 bits. Try to avoid over and underflows */
+	if (clock<4096)
+		return (clock<<20)/CLOCK_SCALE;
+	if (clock<(4096<<5))
+		return (clock<<15)/(CLOCK_SCALE>>5);
+	if (clock<(4096<<10))
+		return (clock<<10)/(CLOCK_SCALE>>10);
+	if (clock<(4096<<15))
+		return (clock<<5)/(CLOCK_SCALE>>15);
+	else
+		return clock/(CLOCK_SCALE>>20);
+}
+
+#endif /* not GENERIC_KFT_READCLOCK */
+
+#if CONFIG_KFT_CLOCK_SCALE
+
+extern void set_cyc2ns_scale(unsigned long cpu_mhz);
+
+/*
+ * Do whatever is required to prepare for calling sched_clock very
+ * early in the boot sequence.
+ */
+extern void setup_early_kft_clock(void)
+{
+	set_cyc2ns_scale(CONFIG_KFT_CLOCK_SCALE);
+}
+#endif /* CONFIG_KFT_CLOCK_SCALE */
+

=============================
Tim Bird
Architecture Group Chair, CE Linux Forum
Senior Staff Engineer, Sony Electronics
=============================

