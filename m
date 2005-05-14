Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262645AbVENAie@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262645AbVENAie (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 20:38:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262642AbVENAgs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 20:36:48 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:932 "EHLO e34.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S262645AbVENAXs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 20:23:48 -0400
Subject: [RFC][PATCH (6/7)] new timeofday ia64,ppc32,ppc64 and s390
	timesources (v A5)
From: john stultz <johnstul@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Tim Schmielau <tim@physik3.uni-rostock.de>,
       George Anzinger <george@mvista.com>, albert@users.sourceforge.net,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>,
       Christoph Lameter <clameter@sgi.com>,
       Dominik Brodowski <linux@dominikbrodowski.de>,
       David Mosberger <davidm@hpl.hp.com>, Andi Kleen <ak@suse.de>,
       paulus@samba.org, schwidefsky@de.ibm.com,
       keith maanthey <kmannth@us.ibm.com>, Chris McDermott <lcm@us.ibm.com>,
       Max Asbock <masbock@us.ibm.com>, mahuja@us.ibm.com,
       Nishanth Aravamudan <nacc@us.ibm.com>, Darren Hart <darren@dvhart.com>,
       "Darrick J. Wong" <djwong@us.ibm.com>,
       Anton Blanchard <anton@samba.org>, donf@us.ibm.com, mpm@selenic.com,
       benh@kernel.crashing.org
In-Reply-To: <1116030139.26454.13.camel@cog.beaverton.ibm.com>
References: <1116029796.26454.2.camel@cog.beaverton.ibm.com>
	 <1116029872.26454.4.camel@cog.beaverton.ibm.com>
	 <1116029971.26454.7.camel@cog.beaverton.ibm.com>
	 <1116030058.26454.10.camel@cog.beaverton.ibm.com>
	 <1116030139.26454.13.camel@cog.beaverton.ibm.com>
Content-Type: text/plain
Date: Fri, 13 May 2005 17:23:37 -0700
Message-Id: <1116030222.26454.16.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	
All,
	This patch implements the time sources for ppc32, ppc64, s390 and
initial untested sketches of timesources for ia64. The patch should
apply ontop of linux-2.6.12-rc4_timeofday-arch-other_A5. The patch
should be fairly straight forward, only adding the new timesources. 

I'd like to thank the following folks for their work in providing these
arch implementations:
o Darrick Wong for the ppc32 work
o Martin Schwidefsky! for the s390 work

New in this release:
o minor fixes for compile warnings

Items still on the TODO list:
o real ia64 timesources
o all other arch timesources
o lots of cleanups
o lots of testing

I look forward to your comments and feedback.

thanks
-john

linux-2.6.12-rc4_timeofday-timesources-other_A5.patch
======================================================
Index: drivers/timesource/Makefile
===================================================================
--- f86144e80c5de25e7bea135a07a5635205be4cf3/drivers/timesource/Makefile  (mode:100644)
+++ 6f16ba51ef2d9bdf92b90eb3d61785877456e273/drivers/timesource/Makefile  (mode:100644)
@@ -1 +1,9 @@
 obj-y += jiffies.o
+
+obj-$(CONFIG_PPC64) += ppc64_timebase.o
+obj-$(CONFIG_PPC) += ppc_timebase.o
+obj-$(CONFIG_ARCH_S390) += s390_tod.o
+
+# XXX - Untested/Uncompiled
+#obj-$(CONFIG_IA64) += itc.c
+#obj-$(CONFIG_IA64_SGI_SN2) += sn2_rtc.c
Index: drivers/timesource/itc.c
===================================================================
--- /dev/null  (tree:f86144e80c5de25e7bea135a07a5635205be4cf3)
+++ 6f16ba51ef2d9bdf92b90eb3d61785877456e273/drivers/timesource/itc.c  (mode:100644)
@@ -0,0 +1,35 @@
+/* XXX - this is totally untested and uncompiled
+ * TODO:
+ *		o cpufreq issues
+ *		o unsynched ITCs ?
+ */
+#include <linux/timesource.h>
+
+/* XXX - Other includes needed for:
+ *		sal_platform_features, IA64_SAL_PLATFORM_FEATURE_ITC_DRIFT,
+ *		local_cpu_data->itc_freq
+ * See arch/ia64/kernel/time.c for ideas
+ */
+
+static struct timesource_t timesource_itc = {
+	.name = "itc",
+	.priority = 25,
+	.type = TIMESOURCE_CYCLES,
+	.mask = (cycle_t)-1,
+	.mult = 0, /* to be set */
+	.shift = 22,
+};
+
+static int __init init_itc_timesource(void)
+{
+	if (!(sal_platform_features & IA64_SAL_PLATFORM_FEATURE_ITC_DRIFT)) {
+		/* XXX - I'm not really sure if itc_freq is in cyc/sec */
+		timesource_itc.mult = timesource_hz2mult(local_cpu_data->itc_freq,
+									timesource_itc.shift);
+		register_timesource(&timesource_itc);
+	}
+	return 0;
+}
+
+module_init(init_itc_timesource);
+
Index: drivers/timesource/ppc64_timebase.c
===================================================================
--- /dev/null  (tree:f86144e80c5de25e7bea135a07a5635205be4cf3)
+++ 6f16ba51ef2d9bdf92b90eb3d61785877456e273/drivers/timesource/ppc64_timebase.c  (mode:100644)
@@ -0,0 +1,33 @@
+#include <linux/timesource.h>
+#include <asm/time.h>
+
+static cycle_t timebase_read(void)
+{
+	return (cycle_t)get_tb();
+}
+
+struct timesource_t timesource_timebase = {
+	.name = "timebase",
+	.priority = 200,
+	.type = TIMESOURCE_FUNCTION,
+	.read_fnct = timebase_read,
+	.mask = (cycle_t)-1,
+	.mult = 0,
+	.shift = 22,
+};
+
+
+/* XXX - this should be calculated or properly externed! */
+extern unsigned long tb_to_ns_scale;
+extern unsigned long tb_to_ns_shift;
+extern unsigned long tb_ticks_per_sec;
+
+static int __init init_timebase_timesource(void)
+{
+	timesource_timebase.mult = timesource_hz2mult(tb_ticks_per_sec,
+										timesource_timebase.shift);
+	register_timesource(&timesource_timebase);
+	return 0;
+}
+
+module_init(init_timebase_timesource);
Index: drivers/timesource/ppc_timebase.c
===================================================================
--- /dev/null  (tree:f86144e80c5de25e7bea135a07a5635205be4cf3)
+++ 6f16ba51ef2d9bdf92b90eb3d61785877456e273/drivers/timesource/ppc_timebase.c  (mode:100644)
@@ -0,0 +1,56 @@
+#include <linux/timesource.h>
+#include <linux/init.h>
+#include <asm/time.h>
+#ifndef CONFIG_PPC64
+
+/* XXX - this should be calculated or properly externed! */
+
+/* DJWONG: tb_to_ns_scale is supposed to be set in time_init.
+ * No idea if that actually _happens_ on a ppc601, though it
+ * seems to work on a B&W G3. :D */
+extern unsigned long tb_to_ns_scale;
+
+static cycle_t ppc_timebase_read(void)
+{
+	unsigned long lo, hi, hi2;
+	unsigned long long tb;
+
+	do {
+		hi = get_tbu();
+		lo = get_tbl();
+		hi2 = get_tbu();
+	} while (hi2 != hi);
+	tb = ((unsigned long long) hi << 32) | lo;
+
+	return (cycle_t)tb;
+}
+
+struct timesource_t timesource_ppc_timebase = {
+	.name = "ppc_timebase",
+	.priority = 200,
+	.type = TIMESOURCE_FUNCTION,
+	.read_fnct = ppc_timebase_read,
+	.mask = (cycle_t)-1,
+	.mult = 0,
+	.shift = 22,
+};
+
+static int __init init_ppc_timebase_timesource(void)
+{
+	/* DJWONG: Extrapolated from ppc64 code. */
+	unsigned long tb_ticks_per_sec;
+
+	tb_ticks_per_sec = tb_ticks_per_jiffy * HZ;
+
+	timesource_ppc_timebase.mult = timesource_hz2mult(tb_ticks_per_sec,
+										timesource_ppc_timebase.shift);
+
+	printk(KERN_INFO "ppc_timebase: tb_ticks_per_sec = %lu, mult = %lu, tb_to_ns = %lu.\n",
+		tb_ticks_per_sec, (unsigned long)timesource_ppc_timebase.mult , tb_to_ns_scale);
+
+	register_timesource(&timesource_ppc_timebase);
+	return 0;
+}
+
+module_init(init_ppc_timebase_timesource);
+#endif /* CONFIG_PPC64 */
Index: drivers/timesource/s390_tod.c
===================================================================
--- /dev/null  (tree:f86144e80c5de25e7bea135a07a5635205be4cf3)
+++ 6f16ba51ef2d9bdf92b90eb3d61785877456e273/drivers/timesource/s390_tod.c  (mode:100644)
@@ -0,0 +1,37 @@
+/*
+ * linux/drivers/timesource/s390_tod.c
+ *
+ * (C) Copyright IBM Corp. 2004
+ *
+ * Author(s): Martin Schwidefsky (schwidefsky@de.ibm.com),
+ *
+ * s390 TOD clock time source.
+ */
+
+#include <linux/timesource.h>
+#include <linux/timex.h>
+#include <linux/init.h>
+
+static cycle_t s390_tod_read(void)
+{
+	return get_clock();
+}
+
+struct timesource_t timesource_s390_tod = {
+	.name = "TOD",
+	.priority = 100,
+	.type = TIMESOURCE_FUNCTION,
+	.read_fnct = s390_tod_read,
+	.mask = -1ULL,
+	.mult = 1000,
+	.shift = 12
+};
+
+
+static int __init init_s390_timesource(void)
+{
+	register_timesource(&timesource_s390_tod);
+	return 0;
+}
+
+module_init(init_s390_timesource);
Index: drivers/timesource/sn2_rtc.c
===================================================================
--- /dev/null  (tree:f86144e80c5de25e7bea135a07a5635205be4cf3)
+++ 6f16ba51ef2d9bdf92b90eb3d61785877456e273/drivers/timesource/sn2_rtc.c  (mode:100644)
@@ -0,0 +1,29 @@
+#include <linux/timesource.h>
+/* XXX this will need some includes
+ * to find: sn_rtc_cycles_per_second and RTC_COUNTER_ADDR
+ * See arch/ia64/sn/kernel/sn2/timer.c for likely suspects
+ */
+
+#define SN2_RTC_MASK ((1LL << 55) - 1)
+#define SN2_SHIFT 10
+
+struct timesource_t timesource_sn2_rtc = {
+	.name = "sn2_rtc",
+	.priority = 300, /* XXX - not sure what this should be */
+	.type = TIMESOURCE_MMIO_64,
+	.mmio_ptr = NULL,
+	.mask = (cycle_t)SN2_RTC_MASK,
+	.mult = 0, /* set below */
+	.shift = SN2_SHIFT,
+};
+
+static void __init init_sn2_timesource(void)
+{
+	timesource_sn2_rtc.mult = timesource_hz2mult(sn_rtc_cycles_per_second,
+												SN2_SHIFT);
+	timesource_sn2_rtc.mmio_ptr = RTC_COUNTER_ADDR;
+
+	register_time_interpolator(&timesource_sn2_rtc);
+	return 0;
+}
+module_init(init_sn2_timesource);


