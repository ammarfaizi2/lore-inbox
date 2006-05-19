Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932209AbWESDjZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932209AbWESDjZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 23:39:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932213AbWESDjZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 23:39:25 -0400
Received: from nz-out-0102.google.com ([64.233.162.195]:22198 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932209AbWESDjY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 23:39:24 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:subject:content-type:content-transfer-encoding;
        b=M7xJ8oVxcUzsok4KaDjioRnRjSBAe48pGeLsAd5W6+IzgjYkEn0JXI21MeDFPaIq1gz78zzw46irByObFg5GHOt8JyCVXZfNIQu/Mkl/dbR8xGCzEFdX9M9D0yuZc9fyNZ68+g9wB66hjBAIURUYtCcDRtICBLvxjOb+3vm/kUQ=
Message-ID: <446D3DE7.4070202@gmail.com>
Date: Thu, 18 May 2006 21:39:19 -0600
From: Jim Cromie <jim.cromie@gmail.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060420)
MIME-Version: 1.0
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: [patch -mm] generic-time: add clocksource based upon scx200's 27
 MHz hires timer
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



This patch adds a clocksource driver for the Generic Time Subsystem
which uses the Hi-Res Timer hardware on Geode SCx200 integrated CPU.
against 17-rc3-mm1 + clocksource-mask patch which has since been added
to the generic-time patch-set, C2 rev.

It is a rework of previously sent patch:
  http://marc.theaimsgroup.com/?l=linux-kernel&m=114588665115350&w=2

Ive been testing it for most of the time since I 1st posted, Ive been
unable to replicate the hang-on-boot on a fresh tree.  I'm blaming it
on a bad build tree, and other developer errors.

New patch is also compile tested on rc4-mm1, and previously tested
with allmod, allno + scx200-* builtins and loadable modules.  Ive had
no response to my call-for-testers message to soekris-tech@, perhaps
I'll have more success getting testers once its in -mm.


Mod-Params

- ppm clock tweak

Allows tuning clocksource to match XTAL freq.  arg is unclamped, so
you could adjust the clock by + 1MHz, sensible if youve got a
different XTAL, not great otherwise.  I used this to verify that ntpq
-pcrv's frequency=<number> changed in relation to the ppm=<complement>
I started the test with.

The modparam has some value for rough adjustment of a free-running
clocksource, but since XTALs (sample 1) have manufacturing tolerance
and temp-stability of +-30ppm and +-50ppm respectively, you cannot
expect to correct for temps, but you can normalize error for your
crystal.

This mod-param can only be set during initialization, and the module
cannot be unloaded, so changing this param requires a reboot; it is
not a mechanism to track corrections, ntpd is far better for that.

- mhz27

This flag determines count speed, hence timer rollover rate.  At
27mhz, timer rolls every 2.6 min.  I almost dumped this option, and
hardcoded the timer for 27mhz operation, but that loses some
flexibility.

Its not clear to me why the circuit is desiged for a 27 MHz crystal
instead of an on-chip derived clock, but I suspect theres some
reason for it.  TV/video ?


wrt the Todos:
- kconfig entry now immediately after SCx200
- module on built-in (no)
- platform_driver (irrelevant?)

Please consider for -mmNext

Im trying to do the thunderbird shuffle here, perhaps it will work.
will resend final version w fixes as attachment if necessary.

thanks

---

Add new GTOD-clocksource driver for the High Resolution Timer on the
Geode SC-1100 and family.  Driver is dependent on scx200.  When
scx200_hrt is loaded, GTOD chooses it over the unstable and de-rated
TSC, unless idle=poll is given on boot-line (the workaround)

Signed-off-by:  Jim Cromie <jim.cromie@gmail.com>


$ diffstat time-clksrc-add-scx200-hrt.patch
 arch/i386/Kconfig                |   24 ++++++---
 drivers/clocksource/Makefile     |    5 +
 drivers/clocksource/scx200_hrt.c |  101 +++++++++++++++++++++++++++++++++++++++
 localversion                     |    1 (trimmed from patch)
 localversion-clk                 |    1
 5 files changed, 122 insertions(+), 10 deletions(-)

---




diff -ruNp -X dontdiff -X exclude-diffs clksrc-mask/arch/i386/Kconfig hrt-tune/arch/i386/Kconfig
--- clksrc-mask/arch/i386/Kconfig	2006-05-03 06:29:48.000000000 -0600
+++ hrt-tune/arch/i386/Kconfig	2006-05-18 11:24:02.000000000 -0600
@@ -1049,13 +1049,23 @@ config SCx200
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
diff -ruNp -X dontdiff -X exclude-diffs clksrc-mask/drivers/clocksource/Makefile hrt-tune/drivers/clocksource/Makefile
--- clksrc-mask/drivers/clocksource/Makefile	2006-05-03 06:29:58.000000000 -0600
+++ hrt-tune/drivers/clocksource/Makefile	2006-05-14 01:12:54.000000000 -0600
@@ -1,2 +1,3 @@
-obj-$(CONFIG_X86_CYCLONE_TIMER) += cyclone.o
-obj-$(CONFIG_X86_PM_TIMER) += acpi_pm.o
+obj-$(CONFIG_X86_CYCLONE_TIMER)	+= cyclone.o
+obj-$(CONFIG_X86_PM_TIMER)	+= acpi_pm.o
+obj-$(CONFIG_SCx200HR_TIMER)	+= scx200_hrt.o
diff -ruNp -X dontdiff -X exclude-diffs clksrc-mask/drivers/clocksource/scx200_hrt.c hrt-tune/drivers/clocksource/scx200_hrt.c
--- clksrc-mask/drivers/clocksource/scx200_hrt.c	1969-12-31 17:00:00.000000000 -0700
+++ hrt-tune/drivers/clocksource/scx200_hrt.c	2006-05-18 09:47:25.000000000 -0600
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
+ * Based on work by John Stultz and Ted Phelps (in a 2.6.12-rc6 patch)
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
+        /* Make sure scx200 has initd the configuration block */
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
+	       mhz27 ? "27":"1", ppm);
+
+	return clocksource_register(&cs_hrt);
+}
+
+module_init(init_hrt_clocksource);
+
+MODULE_AUTHOR("Jim Cromie <jim.cromie@gmail.com>");
+MODULE_DESCRIPTION("clocksource on SCx200 HiRes Timer");
+MODULE_LICENSE("GPL");


