Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261481AbVENT7I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261481AbVENT7I (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 May 2005 15:59:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261476AbVENT7I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 May 2005 15:59:08 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:3226 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261479AbVENT5e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 May 2005 15:57:34 -0400
Date: Sat, 14 May 2005 12:55:36 -0700 (PDT)
From: Christoph Lameter <clameter@engr.sgi.com>
To: john stultz <johnstul@us.ibm.com>
cc: lkml <linux-kernel@vger.kernel.org>,
       Tim Schmielau <tim@physik3.uni-rostock.de>,
       George Anzinger <george@mvista.com>, albert@users.sourceforge.net,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>,
       Dominik Brodowski <linux@dominikbrodowski.de>,
       David Mosberger <davidm@hpl.hp.com>, Andi Kleen <ak@suse.de>,
       paulus@samba.org, schwidefsky@de.ibm.com,
       keith maanthey <kmannth@us.ibm.com>, Chris McDermott <lcm@us.ibm.com>,
       Max Asbock <masbock@us.ibm.com>, mahuja@us.ibm.com,
       Nishanth Aravamudan <nacc@us.ibm.com>, Darren Hart <darren@dvhart.com>,
       "Darrick J. Wong" <djwong@us.ibm.com>,
       Anton Blanchard <anton@samba.org>, donf@us.ibm.com, mpm@selenic.com,
       benh@kernel.crashing.org, linux-ia64@vger.kernel.org
Subject: IA64 implementation of timesource for new time of day subsystem
In-Reply-To: <1116030139.26454.13.camel@cog.beaverton.ibm.com>
Message-ID: <Pine.LNX.4.62.0505141251490.18681@schroedinger.engr.sgi.com>
References: <1116029796.26454.2.camel@cog.beaverton.ibm.com> 
 <1116029872.26454.4.camel@cog.beaverton.ibm.com>  <1116029971.26454.7.camel@cog.beaverton.ibm.com>
  <1116030058.26454.10.camel@cog.beaverton.ibm.com>
 <1116030139.26454.13.camel@cog.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 May 2005, john stultz wrote:

> I look forward to your comments and feedback.

Here is the implementation of the IA64 timesources for the new time of 
day subsystem.

This is quite straighforward. Thanks John. However, the ITC
interpolator can no longer use MMIO in SMP situations since there is no 
provision for jitter compensation in the new time of day subsystem. I have
implemented that via a function now which will slow down clock access
for non SGI IA64 hardware significantly since it will not be able to use
the fastcall anymore.

I am working on the fastcall but I would need a couple of changes
to the core code to make the following symbols non-static since they
will need to be accessed from the fast syscall handler:

timesource
system_time
wall_time_offset
offset_base

The asm code is going to be simplified because there will be no need
to support jitter compensation and most values are now single 64 bit values
instead of two 64 bit values with separate seconds and nanoseconds.

However, the asm code is also is going to be a bit more complicated since
the split from 64 bit nanoseconds into seconds and 
nanoseconds/microseconds for gettimeofday and clock_gettime
has to be done in asm as well.

I would recommend to add jitter compensation to the time sources. Otherwise
each ITC/TSC like timesource will have to implement that on its own.

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.12-rc4/drivers/timesource/Makefile
===================================================================
--- linux-2.6.12-rc4.orig/drivers/timesource/Makefile	2005-05-14 11:21:46.000000000 -0700
+++ linux-2.6.12-rc4/drivers/timesource/Makefile	2005-05-14 12:15:08.000000000 -0700
@@ -4,9 +4,8 @@ obj-$(CONFIG_PPC64) += ppc64_timebase.o
 obj-$(CONFIG_PPC) += ppc_timebase.o
 obj-$(CONFIG_ARCH_S390) += s390_tod.o
 
-# XXX - Untested/Uncompiled
-#obj-$(CONFIG_IA64) += itc.c
-#obj-$(CONFIG_IA64_SGI_SN2) += sn2_rtc.c
+obj-$(CONFIG_IA64) += itc.o
+obj-$(CONFIG_IA64_SGI_SN2) += sn2_rtc.o
 obj-$(CONFIG_X86) += tsc.o
 obj-$(CONFIG_X86) += i386_pit.o
 obj-$(CONFIG_X86) += tsc-interp.o
Index: linux-2.6.12-rc4/drivers/timesource/itc.c
===================================================================
--- linux-2.6.12-rc4.orig/drivers/timesource/itc.c	2005-05-14 11:21:46.000000000 -0700
+++ linux-2.6.12-rc4/drivers/timesource/itc.c	2005-05-14 12:20:00.000000000 -0700
@@ -1,31 +1,83 @@
-/* XXX - this is totally untested and uncompiled
- * TODO:
- *		o cpufreq issues
- *		o unsynched ITCs ?
+/*
+ * drivers/timesource/itc.c
+ *
+ * Use of the ITC register on Itanium processors as a time source
+ *
+ * Copyright (C) 2005 Silicon Graphics, Inc.
+ *	Christoph Lameter, <clameter@sgi.com>
  */
+#include <linux/config.h>
 #include <linux/timesource.h>
+#include <linux/jiffies.h>
 
-/* XXX - Other includes needed for:
- *		sal_platform_features, IA64_SAL_PLATFORM_FEATURE_ITC_DRIFT,
- *		local_cpu_data->itc_freq
- * See arch/ia64/kernel/time.c for ideas
- */
+#include <asm/machvec.h>
+#include <asm/sal.h>
+#include <asm/system.h>
 
 static struct timesource_t timesource_itc = {
 	.name = "itc",
 	.priority = 25,
 	.type = TIMESOURCE_CYCLES,
 	.mask = (cycle_t)-1,
-	.mult = 0, /* to be set */
 	.shift = 22,
 };
 
+#ifdef CONFIG_SMP
+static int nojitter;
+
+static __init int nojitter_setup(char *str)
+{
+	nojitter = 1;
+	printk(KERN_INFO "ITC timesource: Jitter checking bypassed.\n");
+	return 1;
+}
+
+__setup("itc_nojitter", nojitter_setup);
+
+cycle_t last_itc;
+
+/*
+ * Insure that ITC is monotonically increasing by comparing
+ * to the last value encountered. Do this in an atomic fashion
+ * by using cmpxchg for synchronization between processors
+ * and at the same time for the updating of the last_itc value;
+ */
+static cycle_t itc_filtered(void) {
+	cycle_t now, last;
+
+	do {
+		last = last_itc;
+		smb_rmb();
+		now = get_cycles();
+		if (time_before(now, last))
+			return last_itc;
+	} while (cmpxchg(&last_itc, last, now) != last);
+	return now;
+}
+#endif
+
 static int __init init_itc_timesource(void)
 {
 	if (!(sal_platform_features & IA64_SAL_PLATFORM_FEATURE_ITC_DRIFT)) {
-		/* XXX - I'm not really sure if itc_freq is in cyc/sec */
 		timesource_itc.mult = timesource_hz2mult(local_cpu_data->itc_freq,
 									timesource_itc.shift);
+#ifdef CONFIG_SMP
+		/* ITCs are never accurately synchronized in an SMP configuration
+		 * even if the ITC_DRIFT bit is not set.
+		 * Jitter compensation requires a cmpxchg which may limit
+		 * the scalability of the syscalls for retrieving time.
+		 * ITC synchronization is usually successful to within a few
+		 * ITC ticks but this is not a sure thing. If you need to improve
+		 * timer performance in SMP situations then boot the kernel with the
+		 * "itc_nojitter" option. However, doing so may result in time fluctuating
+		 * (maybe even appearing to go backward!) if the ITC offsets between the
+		 * individual CPUs are too large.
+		 */
+		if (!nojitter) {
+			timesource_itc.type = TIMESOURCE_FUNCTION;
+			timesource_itc.read_fnct = itc_filtered;
+		}
+#endif
 		register_timesource(&timesource_itc);
 	}
 	return 0;
Index: linux-2.6.12-rc4/arch/ia64/kernel/time.c
===================================================================
--- linux-2.6.12-rc4.orig/arch/ia64/kernel/time.c	2005-05-14 11:21:46.000000000 -0700
+++ linux-2.6.12-rc4/arch/ia64/kernel/time.c	2005-05-14 12:15:08.000000000 -0700
@@ -139,6 +139,7 @@ ia64_cpu_local_tick (void)
 	ia64_set_itm(local_cpu_data->itm_next);
 }
 
+#ifndef CONFIG_NEWTOD
 static int nojitter;
 
 static int __init nojitter_setup(char *str)
@@ -150,6 +151,7 @@ static int __init nojitter_setup(char *s
 
 __setup("nojitter", nojitter_setup);
 
+#endif
 
 void __devinit
 ia64_init_itm (void)
Index: linux-2.6.12-rc4/drivers/timesource/sn2_rtc.c
===================================================================
--- linux-2.6.12-rc4.orig/drivers/timesource/sn2_rtc.c	2005-05-14 11:21:46.000000000 -0700
+++ linux-2.6.12-rc4/drivers/timesource/sn2_rtc.c	2005-05-14 12:15:08.000000000 -0700
@@ -1,29 +1,38 @@
-#include <linux/timesource.h>
-/* XXX this will need some includes
- * to find: sn_rtc_cycles_per_second and RTC_COUNTER_ADDR
- * See arch/ia64/sn/kernel/sn2/timer.c for likely suspects
+/*
+ * linux/drivers/timesource/sn2_rtc.c
+ *
+ * Use the RTC on the SN2 on an Altix system as the time source
+ *
+ * (C) 2005 Silicon Graphics, Inc.
+ *	Christoph Lameter <clameter@sgi.com>
  */
 
+
+#include <linux/timesource.h>
+#include <asm/system.h>
+#include <asm/sn/leds.h>
+#include <asm/sn/shub_mmr.h>
+#include <asm/sn/clksupport.h>
+
+extern unsigned long sn_rtc_cycles_per_second;
+
 #define SN2_RTC_MASK ((1LL << 55) - 1)
 #define SN2_SHIFT 10
 
 struct timesource_t timesource_sn2_rtc = {
 	.name = "sn2_rtc",
-	.priority = 300, /* XXX - not sure what this should be */
+	.priority = 999,
 	.type = TIMESOURCE_MMIO_64,
-	.mmio_ptr = NULL,
 	.mask = (cycle_t)SN2_RTC_MASK,
 	.mult = 0, /* set below */
 	.shift = SN2_SHIFT,
 };
 
-static void __init init_sn2_timesource(void)
+static __init int init_sn2_timesource(void)
 {
-	timesource_sn2_rtc.mult = timesource_hz2mult(sn_rtc_cycles_per_second,
-												SN2_SHIFT);
+	timesource_sn2_rtc.mult = timesource_hz2mult(sn_rtc_cycles_per_second,	SN2_SHIFT);
 	timesource_sn2_rtc.mmio_ptr = RTC_COUNTER_ADDR;
-
-	register_time_interpolator(&timesource_sn2_rtc);
+	register_timesource(&timesource_sn2_rtc);
 	return 0;
 }
 module_init(init_sn2_timesource);

