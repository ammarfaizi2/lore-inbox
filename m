Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265313AbUE0Vgl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265313AbUE0Vgl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 May 2004 17:36:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265325AbUE0Vgl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 May 2004 17:36:41 -0400
Received: from [213.196.40.106] ([213.196.40.106]:12716 "EHLO
	eljakim.netsystem.nl") by vger.kernel.org with ESMTP
	id S265313AbUE0Vgh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 May 2004 17:36:37 -0400
Date: Thu, 27 May 2004 23:35:23 +0200 (CEST)
From: Joris van Rantwijk <joris@eljakim.nl>
X-X-Sender: joris@eljakim.netsystem.nl
To: akpm@osdl.org
cc: lkml <linux-kernel@vger.kernel.org>, john stultz <johnstul@us.ibm.com>,
       Dominik Brodowski <linux@brodo.de>
Subject: [PATCH] 2.6.6 Validate PM-Timer rate at boot time
In-Reply-To: <1085612915.8653.42.camel@cog.beaverton.ibm.com>
Message-ID: <Pine.LNX.4.58.0405272323150.23136@eljakim.netsystem.nl>
References: <1E4zj-77w-69@gated-at.bofh.it>  <Pine.LNX.4.58.0405251112040.30050@eljakim.netsystem.nl>
  <1085518688.8653.19.camel@cog.beaverton.ibm.com> 
 <Pine.LNX.4.58.0405270020080.1496@eljakim.netsystem.nl>
 <1085612915.8653.42.camel@cog.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The patch below adds a check to the PM-Timer initialization code.
It validates the PM-Timer rate against PIT channel 2 and rejects
the PM-Timer if its rate is not withing 5% of the expected number.

Rationale:
The PMTMR timers of certain (older) mainboards are running at invalid
rates, often much faster than the rate expected by the PM-Timer code.
This causes the system clock to run much too fast.
See also http://bugme.osdl.org/show_bug.cgi?id=2375

Possible workarounds are disabling the PM-Timer in the kernel config
or disabling the PM-Timer at boot time through the "clock=tsc" parameter.
However, we believe it is more user friendly to automatically validate
the PM-Timer rate at boot time before using it as the system time source.

Patch is against linux 2.6.6.
Tested by me (with broken timer) and John Stultz (with good timer)
and believed to be ok.
Please consider applying.

Bye,
  Joris.

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
