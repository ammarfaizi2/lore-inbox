Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030417AbWHICSI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030417AbWHICSI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 22:18:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030396AbWHICRy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 22:17:54 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:23189 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1030417AbWHICRm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 22:17:42 -0400
Date: Tue, 8 Aug 2006 22:17:40 -0400
From: john stultz <johnstul@us.ibm.com>
To: ak@suse.de
Cc: john stultz <johnstul@us.ibm.com>, linux-kernel@vger.kernel.org
Message-Id: <20060809021739.23103.98698.sendpatchset@cog.beaverton.ibm.com>
In-Reply-To: <20060809021707.23103.5607.sendpatchset@cog.beaverton.ibm.com>
References: <20060809021707.23103.5607.sendpatchset@cog.beaverton.ibm.com>
Subject: [RFC][PATCH 5/6] x86_64: Clocksources for x86-64
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Re-add TSC and HPET support to x86_64 via clocksource infrastructure.

Signed-off-by: John Stultz <johnstul@us.ibm.com>

 arch/x86_64/kernel/time.c  |  133 +++++++++++++++++++++++++++++++++++++++++++--
 include/asm-x86_64/timex.h |    3 +
 2 files changed, 133 insertions(+), 3 deletions(-)

linux-2.6.18-rc4_timeofday-arch-x86-64-part4_C5.patch
============================================
diff --git a/arch/x86_64/kernel/time.c b/arch/x86_64/kernel/time.c
index d18230a..546abc7 100644
--- a/arch/x86_64/kernel/time.c
+++ b/arch/x86_64/kernel/time.c
@@ -39,6 +39,7 @@
 #include <asm/sections.h>
 #include <linux/cpufreq.h>
 #include <linux/hpet.h>
+#include <linux/clocksource.h>
 #ifdef CONFIG_X86_LOCAL_APIC
 #include <asm/apic.h>
 #endif
@@ -60,8 +61,9 @@ static int notsc __initdata = 0;
 #define NS_SCALE	10 /* 2^10, carefully chosen */
 #define US_SCALE	32 /* 2^32, arbitralrily chosen */
 
-unsigned int cpu_khz;					/* TSC clocks / usec, not used here */
+unsigned int cpu_khz;					/* CPU clocks / usec, not used here */
 EXPORT_SYMBOL(cpu_khz);
+unsigned int tsc_khz;					/* TSC clocks / usec, not used here */
 unsigned long hpet_address;
 static unsigned long hpet_period;			/* fsecs / HPET clock */
 unsigned long hpet_tick;				/* HPET clocks / interrupt */
@@ -382,8 +384,9 @@ static int time_cpufreq_notifier(struct 
 		cpufreq_scale(loops_per_jiffy_ref, ref_freq, freq->new);
 
 		cpu_khz = cpufreq_scale(cpu_khz_ref, ref_freq, freq->new);
-		if (!(freq->flags & CPUFREQ_CONST_LOOPS))
-			vxtime.tsc_quot = (USEC_PER_MSEC << US_SCALE) / cpu_khz;
+		if (!(freq->flags & CPUFREQ_CONST_LOOPS)) {
+			tsc_khz = cpu_khz;
+		}
 	}
 	
 	set_cyc2ns_scale(cpu_khz_ref);
@@ -659,6 +662,10 @@ void __init time_init(void)
 		cpu_khz = pit_calibrate_tsc();
 		timename = "PIT";
 	}
+	tsc_khz = cpu_khz;
+
+	if (unsynchronized_tsc())
+		mark_tsc_unstable();
 
 	printk(KERN_INFO "time.c: Detected %d.%03d MHz processor.\n",
 		cpu_khz / 1000, cpu_khz % 1000);
@@ -999,3 +1006,123 @@ int __init notsc_setup(char *s)
 }
 
 __setup("notsc", notsc_setup);
+
+
+/* clock source code: */
+
+static unsigned long current_tsc_khz = 0;
+
+static int tsc_update_callback(void);
+
+static cycle_t read_tsc(void)
+{
+	cycle_t ret;
+	rdtscll(ret);
+	return ret;
+}
+
+static struct clocksource clocksource_tsc = {
+	.name			= "tsc",
+	.rating			= 300,
+	.read			= read_tsc,
+	.mask			= (cycle_t)-1,
+	.mult			= 0, /* to be set */
+	.shift			= 22,
+	.update_callback	= tsc_update_callback,
+	.is_continuous		= 1,
+};
+
+static int tsc_update_callback(void)
+{
+	int change = 0;
+
+	/* check to see if we should switch to the safe clocksource: */
+	if (clocksource_tsc.rating != 50 && check_tsc_unstable()) {
+		clocksource_tsc.rating = 50;
+		clocksource_reselect();
+		change = 1;
+	}
+
+	/* only update if tsc_khz has changed: */
+	if (current_tsc_khz != tsc_khz){
+		current_tsc_khz = tsc_khz;
+		clocksource_tsc.mult = clocksource_khz2mult(current_tsc_khz,
+							clocksource_tsc.shift);
+		change = 1;
+	}
+	return change;
+}
+
+static int __init init_tsc_clocksource(void)
+{
+	if (!notsc && tsc_khz) {
+		current_tsc_khz = tsc_khz;
+		clocksource_tsc.mult = clocksource_khz2mult(current_tsc_khz,
+							clocksource_tsc.shift);
+		return clocksource_register(&clocksource_tsc);
+	}
+	return 0;
+}
+
+module_init(init_tsc_clocksource);
+
+
+#define HPET_MASK	0xFFFFFFFF
+#define HPET_SHIFT	22
+
+/* FSEC = 10^-15 NSEC = 10^-9 */
+#define FSEC_PER_NSEC	1000000
+
+static void *hpet_ptr;
+
+static cycle_t read_hpet(void)
+{
+	return (cycle_t)readl(hpet_ptr);
+}
+
+struct clocksource clocksource_hpet = {
+	.name		= "hpet",
+	.rating		= 250,
+	.read		= read_hpet,
+	.mask		= (cycle_t)HPET_MASK,
+	.mult		= 0, /* set below */
+	.shift		= HPET_SHIFT,
+	.is_continuous	= 1,
+};
+
+static int __init init_hpet_clocksource(void)
+{
+	unsigned long hpet_period;
+	void __iomem *hpet_base;
+	u64 tmp;
+
+	if (!hpet_address)
+		return -ENODEV;
+
+	/* calculate the hpet address: */
+	hpet_base =
+		(void __iomem*)ioremap_nocache(hpet_address, HPET_MMAP_SIZE);
+	hpet_ptr = hpet_base + HPET_COUNTER;
+
+	/* calculate the frequency: */
+	hpet_period = readl(hpet_base + HPET_PERIOD);
+
+	/*
+	 * hpet period is in femto seconds per cycle
+	 * so we need to convert this to ns/cyc units
+	 * aproximated by mult/2^shift
+	 *
+	 *  fsec/cyc * 1nsec/1000000fsec = nsec/cyc = mult/2^shift
+	 *  fsec/cyc * 1ns/1000000fsec * 2^shift = mult
+	 *  fsec/cyc * 2^shift * 1nsec/1000000fsec = mult
+	 *  (fsec/cyc << shift)/1000000 = mult
+	 *  (hpet_period << shift)/FSEC_PER_NSEC = mult
+	 */
+	tmp = (u64)hpet_period << HPET_SHIFT;
+	do_div(tmp, FSEC_PER_NSEC);
+	clocksource_hpet.mult = (u32)tmp;
+
+	return clocksource_register(&clocksource_hpet);
+}
+
+module_init(init_hpet_clocksource);
diff --git a/include/asm-x86_64/timex.h b/include/asm-x86_64/timex.h
index b9e5320..11c6820 100644
--- a/include/asm-x86_64/timex.h
+++ b/include/asm-x86_64/timex.h
@@ -40,6 +40,9 @@ static __always_inline cycles_t get_cycl
 }
 
 extern unsigned int cpu_khz;
+extern unsigned int tsc_khz;
+
+extern void mark_tsc_unstable(void);
 
 extern int read_current_timer(unsigned long *timer_value);
 #define ARCH_HAS_READ_CURRENT_TIMER	1
