Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265009AbUEZWnS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265009AbUEZWnS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 May 2004 18:43:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265841AbUEZWnS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 May 2004 18:43:18 -0400
Received: from [213.196.40.106] ([213.196.40.106]:23455 "EHLO
	eljakim.netsystem.nl") by vger.kernel.org with ESMTP
	id S265009AbUEZWnJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 May 2004 18:43:09 -0400
Date: Thu, 27 May 2004 00:43:05 +0200 (CEST)
From: Joris van Rantwijk <joris@eljakim.nl>
X-X-Sender: joris@eljakim.netsystem.nl
To: john stultz <johnstul@us.ibm.com>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: System clock speed too high - 2.6.3 kernel
In-Reply-To: <1085518688.8653.19.camel@cog.beaverton.ibm.com>
Message-ID: <Pine.LNX.4.58.0405270020080.1496@eljakim.netsystem.nl>
References: <1E4zj-77w-69@gated-at.bofh.it>  <Pine.LNX.4.58.0405251112040.30050@eljakim.netsystem.nl>
 <1085518688.8653.19.camel@cog.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 25 May 2004, john stultz wrote:
> On Tue, 2004-05-25 at 02:22, Joris van Rantwijk wrote:
> > If there are many systems with this problem, then calibrating the PM timer
> > against the PIT timer at boot time (possibly rejecting invalid rates)
> > might be an option.

> I'll put it on my todo list, but if you'd like to take a swing at ti and
> beat me to the implementation, I wouldn't complain.

Sounds fair. I tried something and it even seems to work here.
My dmesg now says:
  PM-Timer running at invalid rate: 199% of normal - aborting.
  Detected 400.816 MHz processor.
  Using tsc for high-res timesource

Hmm, I think I'm enjoying this :-)
My patch is included below and also submitted at the Kernel Bugzilla
thing. I would appreciate it if someone else could also test it a bit.

Yesterday, I ran into a (hopefully) completely seperate issue with the
timer. This happened before I even started messing with the kernel and
while running with "clock=tsc". The kernel suddenly logged:
  Losing too many ticks!
  TSC cannot be used as a timesource
   ...
  Falling back to a sane timesource now.

And from that point on my system clock was running at about one third of
normal speed. The fallback timesource is just the PIT timer, so it seems
that my PIT had spontaneously dropped speed (thereby also causing the lost
ticks). Anyone else seen this before ?

Bye,
  Joris.

Patch: Verify PMTMR rate against PIT Ch2 at boot time before using it
Against: linux-2.6.6

--- linux-2.6.6/arch/i386/kernel/timers/timer_pm.orig.c	Sun Apr  4 05:36:18 2004
+++ linux-2.6.6/arch/i386/kernel/timers/timer_pm.c	Thu May 27 00:11:22 2004
@@ -19,10 +19,18 @@
 #include <asm/timer.h>
 #include <asm/smp.h>
 #include <asm/io.h>
 #include <asm/arch_hooks.h>

+#include <linux/timex.h>
+#include "mach_timer.h"
+
+/* Number of PMTMR ticks expected during calibration run */
+#define PMTMR_TICKS_PER_SEC 3579545
+#define PMTMR_EXPECTED_RATE \
+  ((CALIBRATE_LATCH * (PMTMR_TICKS_PER_SEC >> 10)) / (CLOCK_TICK_RATE>>10))
+

 /* The I/O port the PMTMR resides at.
  * The location is detected during setup_arch(),
  * in arch/i386/acpi/boot.c */
 u32 pmtmr_ioport = 0;
@@ -55,10 +63,37 @@

 	/* mask the output to 24 bits */
 	return v2 & ACPI_PM_MASK;
 }

+
+/*
+ * Some boards have the PMTMR running way too fast. We check
+ * the PMTMR rate against PIT channel 2 to catch these cases.
+ */
+static int verify_pmtmr_rate(void)
+{
+	u32 value1, value2;
+	unsigned long count, delta;
+
+	mach_prepare_counter();
+	value1 = read_pmtmr();
+	mach_countup(&count);
+	value2 = read_pmtmr();
+	delta = (value2 - value1) & ACPI_PM_MASK;
+
+	/* Check that the PMTMR delta is within 5% of what we expect */
+	if (delta < (PMTMR_EXPECTED_RATE * 19) / 20 ||
+	    delta > (PMTMR_EXPECTED_RATE * 21) / 20) {
+		printk(KERN_INFO "PM-Timer running at invalid rate: %lu%% of normal - aborting.\n", 100UL * delta / PMTMR_EXPECTED_RATE);
+		return -1;
+	}
+
+	return 0;
+}
+
+
 static int init_pmtmr(char* override)
 {
 	u32 value1, value2;
 	unsigned int i;

@@ -87,10 +122,13 @@
 	}
 	printk(KERN_INFO "PM-Timer had no reasonable result: 0x%#x - aborting.\n", value1);
 	return -ENODEV;

 pm_good:
+	if (verify_pmtmr_rate() != 0)
+		return -ENODEV;
+
 	init_cpu_khz();
 	return 0;
 }

 static inline u32 cyc2us(u32 cycles)
