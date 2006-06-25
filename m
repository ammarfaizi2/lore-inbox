Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932372AbWFYWBm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932372AbWFYWBm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jun 2006 18:01:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932378AbWFYWBm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jun 2006 18:01:42 -0400
Received: from nz-out-0102.google.com ([64.233.162.196]:9097 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932372AbWFYWBl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jun 2006 18:01:41 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        b=RKmBp/1E8JOL/k1eMI4kIUC082dOsDiY5tHd8kmRFBtX2vUuW+Ojt0b5Lic7TNxxyKH2N5SGantdFs28l2aYglgAebe7GQp79sBe5XCYRL5pKklxbQbqCu5+7MudTYWiX5VXh0iS7/orGAtpRA3DtN9mJ/pHx6cRSjIjOvUBSSg=
Message-ID: <449F07C4.5030805@gmail.com>
Date: Sun, 25 Jun 2006 16:01:40 -0600
From: Jim Cromie <jim.cromie@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: john stultz <johnstul@us.ibm.com>,
       Linux kernel <linux-kernel@vger.kernel.org>,
       Ted Phelps <phelps@gnusto.com>
Subject: [ patch -mm ]  GTOD: add-scx200-hrt-clocksource.diff
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

this is a resend of:
http://marc.theaimsgroup.com/?l=linux-kernel&m=114800999113687&w=2

---

This patch adds a GTOD clocksource driver based on the Geode SCx200's 
Hi-Res Timer.

Signed-off-by:  Jim Cromie  <jim.cromie@gmail.com>

---

$ diffstat add-scx200-hrt-clocksource.diff
 arch/i386/Kconfig                |   24 ++++++---
 drivers/clocksource/Makefile     |    5 +
 drivers/clocksource/scx200_hrt.c |  101 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 121 insertions(+), 9 deletions(-)

---

diff -ruNp -X dontdiff -X exclude-diffs linux-2.6.17-mm2/arch/i386/Kconfig linux-2.6.17-mm2-hrt-sk/arch/i386/Kconfig
--- linux-2.6.17-mm2/arch/i386/Kconfig	2006-06-25 01:09:56.000000000 -0600
+++ linux-2.6.17-mm2-hrt-sk/arch/i386/Kconfig	2006-06-25 07:48:18.000000000 -0600
@@ -1073,13 +1073,23 @@ config SCx200
 	tristate "NatSemi SCx200 support"
 	depends on !X86_VOYAGER
 	help
-	  This provides basic support for the National Semiconductor SCx200
-	  processor.  Right now this is just a driver for the GPIO pins.
-
-	  If you don't know what to do here, say N.
-
-	  This support is also available as a module.  If compiled as a
-	  module, it will be called scx200.
+	  This provides basic support for National Semiconductor's
+	  (now AMD's) Geode processors.  The driver probes for the
+	  PCI-IDs of several on-chip devices, so its a good dependency
+	  for other scx200_* drivers.
+
+	  If compiled as a module, the driver is named scx200.
+
+config SCx200HR_TIMER
+	tristate "NatSemi SCx200 27MHz High-Resolution Timer Support"
+	depends on SCx200 && GENERIC_TIME
+	default y
+	help
+	  This driver provides a clocksource built upon the on-chip
+	  27MHz high-resolution timer.  Its also a workaround for
+	  NSC Geode SC-1100's buggy TSC, which loses time when the
+	  processor goes idle (as is done by the scheduler).  The
+	  other workaround is idle=poll boot option.
 
 config K8_NB
 	def_bool y
diff -ruNp -X dontdiff -X exclude-diffs linux-2.6.17-mm2/drivers/clocksource/Makefile linux-2.6.17-mm2-hrt-sk/drivers/clocksource/Makefile
--- linux-2.6.17-mm2/drivers/clocksource/Makefile	2006-06-25 01:11:27.000000000 -0600
+++ linux-2.6.17-mm2-hrt-sk/drivers/clocksource/Makefile	2006-06-25 07:48:18.000000000 -0600
@@ -1,2 +1,3 @@
-obj-$(CONFIG_X86_CYCLONE_TIMER) += cyclone.o
-obj-$(CONFIG_X86_PM_TIMER) += acpi_pm.o
+obj-$(CONFIG_X86_CYCLONE_TIMER)	+= cyclone.o
+obj-$(CONFIG_X86_PM_TIMER)	+= acpi_pm.o
+obj-$(CONFIG_SCx200HR_TIMER)	+= scx200_hrt.o
diff -ruNp -X dontdiff -X exclude-diffs linux-2.6.17-mm2/drivers/clocksource/scx200_hrt.c linux-2.6.17-mm2-hrt-sk/drivers/clocksource/scx200_hrt.c
--- linux-2.6.17-mm2/drivers/clocksource/scx200_hrt.c	1969-12-31 17:00:00.000000000 -0700
+++ linux-2.6.17-mm2-hrt-sk/drivers/clocksource/scx200_hrt.c	2006-06-25 07:48:18.000000000 -0600
@@ -0,0 +1,101 @@
+/*
+ * Copyright (C) 2006 Jim Cromie
+ *
+ * This is a clocksource driver for the Geode SCx200's 1 or 27 MHz
+ * high-resolution timer.  The Geode SC-1100 (at least) has a buggy
+ * time stamp counter (TSC), which loses time unless 'idle=poll' is
+ * given as a boot-arg. In its absence, the Generic Timekeeping code
+ * will detect and de-rate the bad TSC, allowing this timer to take
+ * over timekeeping duties.
+ *
+ * Based on work by John Stultz, and Ted Phelps (in a 2.6.12-rc6 patch)
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of the
+ * License, or (at your option) any later version.
+ */
+
+#include <linux/clocksource.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/ioport.h>
+#include <linux/scx200.h>
+
+#define NAME "scx200_hrt"
+
+static int mhz27;
+module_param(mhz27, int, 0);	/* load time only */
+MODULE_PARM_DESC(mhz27, "count at 27.0 MHz (default is 1.0 MHz)\n");
+
+static int ppm;
+module_param(ppm, int, 0);	/* load time only */
+MODULE_PARM_DESC(ppm, "+-adjust to actual XO freq (ppm)\n");
+
+/* HiRes Timer configuration register address */
+#define SCx200_TMCNFG_OFFSET (SCx200_TIMER_OFFSET + 5)
+
+/* and config settings */
+#define HR_TMEN (1 << 0)	/* timer interrupt enable */
+#define HR_TMCLKSEL (1 << 1)	/* 1|0 counts at 27|1 MHz */
+#define HR_TM27MPD (1 << 2)	/* 1 turns off input clock (power-down) */
+
+/* The base timer frequency, * 27 if selected */
+#define HRT_FREQ   1000000
+
+static cycle_t read_hrt(void)
+{
+	/* Read the timer value */
+	return (cycle_t) inl(scx200_cb_base + SCx200_TIMER_OFFSET);
+}
+
+#define HRT_SHIFT_1	22
+#define HRT_SHIFT_27	26
+
+static struct clocksource cs_hrt = {
+	.name		= "scx200_hrt",
+	.rating		= 250,
+	.read		= read_hrt,
+	.mask		= CLOCKSOURCE_MASK(32),
+	.is_continuous	= 1,
+	/* mult, shift are set based on mhz27 flag */
+};
+
+static int __init init_hrt_clocksource(void)
+{
+	/* Make sure scx200 has initd the configuration block */
+	if (!scx200_cb_present())
+		return -ENODEV;
+
+	/* Reserve the timer's ISA io-region for ourselves */
+	if (!request_region(scx200_cb_base + SCx200_TIMER_OFFSET,
+			    SCx200_TIMER_SIZE,
+			    "NatSemi SCx200 High-Resolution Timer")) {
+		printk(KERN_WARNING NAME ": unable to lock timer region\n");
+		return -ENODEV;
+	}
+
+	/* write timer config */
+	outb(HR_TMEN | (mhz27) ? HR_TMCLKSEL : 0,
+	     scx200_cb_base + SCx200_TMCNFG_OFFSET);
+	
+	if (mhz27) {
+		cs_hrt.shift = HRT_SHIFT_27;
+		cs_hrt.mult = clocksource_hz2mult((HRT_FREQ + ppm) * 27,
+						  cs_hrt.shift);
+	} else {
+		cs_hrt.shift = HRT_SHIFT_1;
+		cs_hrt.mult = clocksource_hz2mult(HRT_FREQ + ppm,
+						  cs_hrt.shift);
+	}
+	printk(KERN_INFO "enabling scx200 high-res timer (%s MHz +%d ppm)\n",
+		mhz27 ? "27":"1", ppm);
+
+	return clocksource_register(&cs_hrt);
+}
+
+module_init(init_hrt_clocksource);
+
+MODULE_AUTHOR("Jim Cromie <jim.cromie@gmail.com>");
+MODULE_DESCRIPTION("clocksource on SCx200 HiRes Timer");
+MODULE_LICENSE("GPL");


