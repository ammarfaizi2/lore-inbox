Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750790AbWDXNkP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750790AbWDXNkP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 09:40:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750796AbWDXNkP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 09:40:15 -0400
Received: from wproxy.gmail.com ([64.233.184.232]:17221 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750790AbWDXNkN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 09:40:13 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        b=llq+3n+OcBydxdQf5VAGua6bkTJUtYPziTi/BcIWwgiHNn+9FaiIv6vckIOF2TsI7WxOmJXg8t8s4xA9p4kEne/zSHa/qZseqD0cZOUoyz6VtlUYMgnPGsKdHvCqw8CERx3Yw0Hje5iS7GAFktFdF+nHdmI8FfF9GRQLMuLJtAU=
Message-ID: <444CD536.9080702@gmail.com>
Date: Mon, 24 Apr 2006 09:40:06 -0400
From: Jim Cromie <jim.cromie@gmail.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060420)
MIME-Version: 1.0
To: Linux kernel <linux-kernel@vger.kernel.org>
CC: john stultz <johnstul@us.ibm.com>, Ted Phelps <phelps@gnusto.com>
Subject: [rfc patch 1/1 -17rc1-mm3] time: add clocksource driver for Geode
 SC-1100  Hi-Res Timer
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Heres a patch (on 17rc1-mm3 + John Stultz's 4/21 fn-renames) that adds
a new GTOD-clocksource driver for the hires timer in the Geode
SC-1100.  Ive been running it for most of the last 7 days now, and it
seems to work well.

GTOD is detecting the SC-1100's bad TSC, de-rating it, and selecting
the PIT (w/o patch) or scx200_hrt (with patch, built-in).  In a
modular build, when I modprobe scx200_hrt, GTOD selects it instead of
the PIT.  If I put 'idle=poll' on boot-line, the TSC passes the
stability test, and is preferred.  This all works as hoped.

soekris:~# cat /sys/devices/system/clocksource/clocksource0/*
scx200_hrt jiffies tsc pit
scx200_hrt

Its also keeping NTP lock..

soekris:~# uptime; ntpq -p
 12:07:57 up  3:42,  1 user,  load average: 0.00, 0.00, 0.00
     remote           refid      st t when poll reach   delay   offset  jitter
==============================================================================
+harpo           216.82.75.146    3 u  336 1024  377    1.100    7.972   0.742
*ntp1.us.grundcl 204.123.2.72     2 u  568 1024  377   97.151   -1.173   5.991
 LOCAL(0)        LOCAL(0)        13 l   63   64  377    0.000    0.000   0.004


I sent this patch to soekris-tech ML on 4/19, asking for testers, but
theyre mostly *BSD over there, so Im unsure how much action it'll see
(none yet).  Id like to see this patch join the other GTOD stuff in
-mm-next (for some value of next), to get whatever exposure -mm brings
on Geode based systems.


Other tested bits, random notes

- driver also works at 27 mhz

Tested builtin, w scx200_hrt.mhz27=1 on boot-line.  Should I make this
default, and/or drop the modparam ?
[   31.186358] enabling scx200 high-res timer (27 MHz)

- free-running clock seems to work.

I shut down ntpd immediately after boot, ran ntpdate -q later.

soekris:~# uptime; ntpdate -q harpo
 18:54:56 up  5:29,  2 users,  load average: 0.00, 0.00, 0.00
server 192.168.42.1, stratum 3, offset -5.863304, delay 0.02634

So the time offset is growing a little bit.  Im unsure if this is the
HRT itself, a TOD adjustment/slew thats set up by the initial call to
ntpdate, or something else entirely.

- no module-unloading

None of the current GTOD clocksources have a module_exit() routine.  I
had one for a while, but when I used it, I got oopses and reboots.
John Stultz confirmed its not supported currently, and I dont see the
need to do so; unused clocksources only waste a tiny bit of memory.

OTOH, perhaps the basic clocksources could be optionally configured
out for EMBEDDED configs.  And it would be nice if GTOD could remove
unused clocksource drivers once the best clocksource is selected.


Heres what I see as my TODOs, TBCs

- fix the Kconfig entries

SCx200HR_TIMER is defined in arch/i386/Kconfig, at the top of
Processor type and features.  This seemed un-good, but when I tried
moving it to a new clocksources/Kconfig, I got this error: Any advice?
	
[jimc@harpo linux-2.6.17-rc1-mm3-hrt]$ make
scripts/kconfig/conf -s arch/i386/Kconfig
arch/i386/Kconfig:1051:warning: 'select' used by config symbol 'SCx200' refer to undefined symbol 'SCx200HR_TIMER'

- module on builtin (probly not)

scx200_hrt is selected automatically with scx200, and follows its
[nmy] setting.  This is good, but maybe the setup should allow module
on builtin.  I dont have a compelling reason tho; its not like you'd
want a bad TSC often.

- consider clock tuning  (probly not)

The HRT runs off its own crystal (simpler clock-gen ckts?).  I could
add mod-param to adjust freq to acct for crystal variations, but it
seems wizer not to, thats what NTP is for.  If you see a value to
this, pls also suggest a limit on the correction, forex 100 PPM or +/-
100 counts (easier to code, and user should know how experiment with
it).

- consider converting to platform_device

the timer is on an in-the-chip ISA bus, so maybe platform_driver is
the right way to do this.  Im new at this, so pedagogical feedback is
especially welcome (off-list if you prefer)



Lastly, Id like to thank John Stultz for his off-list help &
orientation, and Ted Phelps, whose 2.6.12-rc6 patch clarified the
problem, and informed the solution.

thanks
Jim Cromie

---

Add new GTOD-clocksource driver for the High Resolution Timer on the
Geode SC-1100 and family.  Driver is automatically selected per scx200
choice.  GTOD chooses scx200_hrt over the unstable and de-rated TSC.

Signed-off-by:  Jim Cromie <jim.cromie@gmail.com>


[jimc@harpo hrt-stuff]$ diffstat time-clksrc-scx200_hrt.patch
 arch/i386/Kconfig                |   12 ++++
 drivers/clocksource/Makefile     |    5 +
 drivers/clocksource/scx200_hrt.c |  110 +++++++++++++++++++++++++++++++++++++++

---

diff -ruNp -X dontdiff -X exclude-diffs mm3-clk-renames/arch/i386/Kconfig hrt2/arch/i386/Kconfig
--- mm3-clk-renames/arch/i386/Kconfig	2006-04-18 07:49:49.000000000 -0400
+++ hrt2/arch/i386/Kconfig	2006-04-23 11:00:28.000000000 -0400
@@ -57,6 +57,17 @@ source "init/Kconfig"
 
 menu "Processor type and features"
 
+config SCx200HR_TIMER
+	tristate "NatSemi SCx200 27MHz High-Resolution Timer Support"
+	help
+	  Some of the AMD (formerly National Semiconductor) Geode
+	  processors, notably the SC1100, suffer from a buggy time
+	  stamp counter which causes them to lose time when the
+	  processor is sleeping.  Enable this option to use the
+	  on-board 27Mz high-resolution timer to keep time instead.
+	depends on (SCx200)
+	default n
+
 config SMP
 	bool "Symmetric multi-processing support"
 	---help---
@@ -1048,6 +1059,7 @@ source "drivers/mca/Kconfig"
 config SCx200
 	tristate "NatSemi SCx200 support"
 	depends on !X86_VOYAGER
+	select SCx200HR_TIMER
 	help
 	  This provides basic support for the National Semiconductor SCx200
 	  processor.  Right now this is just a driver for the GPIO pins.
diff -ruNp -X dontdiff -X exclude-diffs mm3-clk-renames/drivers/clocksource/Makefile hrt2/drivers/clocksource/Makefile
--- mm3-clk-renames/drivers/clocksource/Makefile	2006-04-18 07:50:20.000000000 -0400
+++ hrt2/drivers/clocksource/Makefile	2006-04-23 11:00:28.000000000 -0400
@@ -1,2 +1,3 @@
-obj-$(CONFIG_X86_CYCLONE_TIMER) += cyclone.o
-obj-$(CONFIG_X86_PM_TIMER) += acpi_pm.o
+obj-$(CONFIG_X86_CYCLONE_TIMER)	+= cyclone.o
+obj-$(CONFIG_X86_PM_TIMER)	+= acpi_pm.o
+obj-$(CONFIG_SCx200HR_TIMER)	+= scx200_hrt.o
diff -ruNp -X dontdiff -X exclude-diffs mm3-clk-renames/drivers/clocksource/scx200_hrt.c hrt2/drivers/clocksource/scx200_hrt.c
--- mm3-clk-renames/drivers/clocksource/scx200_hrt.c	1969-12-31 19:00:00.000000000 -0500
+++ hrt2/drivers/clocksource/scx200_hrt.c	2006-04-24 08:42:06.000000000 -0400
@@ -0,0 +1,110 @@
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
+module_param(mhz27, int, 0);
+MODULE_PARM_DESC(mhz27, "count at 27 MHz (default is 1 MHz)\n");
+
+/* High-resolution timer configuration address
+   NB: HR_TM* symbols match corresponding TM* in the datasheet
+   HRT_* are clocksource-related constants for this driver
+*/
+#define SCx200_TMCNFG_OFFSET (SCx200_TIMER_OFFSET + 5)
+
+/* Set this bit to disable the 27 MHz input clock */
+#define HR_TM27MPD (1 << 2)
+
+/* Set this bit to count at 27MHz, clear to count at 1MHz */
+#define HR_TMCLKSEL (1 << 1)
+
+/* Set this bit to enable the high-resolution timer interrupt */
+#define HR_TMEN (1 << 0)
+
+/* The timer frequency; must be 27_000_000 or 1_000_000, depending upon
+   HR_TMCLKSEL bit-value actually used */
+#define HRT_FREQ_1   1000000
+#define HRT_FREQ_27 27000000
+
+static cycle_t read_hrt(void)
+{
+	/* Read the timer value */
+	return (cycle_t) inl(scx200_cb_base + SCx200_TIMER_OFFSET);
+}
+
+#ifndef CLKSRC_MASK
+/* move to clocksource.h ?? */
+#define CLKSRC_MASK(bits)	(cycle_t)((1<<bits)-1)
+#endif
+
+#define HRT_MASK	CLKSRC_MASK(32)
+#define HRT_SHIFT_1	22
+#define HRT_SHIFT_27	24
+
+static struct clocksource cs_hrt = {
+	.name		= "scx200_hrt",
+	.rating		= 250,
+	.read		= read_hrt,
+	.mask		= HRT_MASK,
+	.is_continuous	= 1,
+	/* mult, shift are set during init */
+};
+
+static int __init init_hrt_clocksource(void)
+{
+        /* Make sure the configuration block is present */
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
+	/* Configure the timer: 1 or 27 MHz, no interrupt */
+	outb((mhz27) ? HR_TMCLKSEL : 0,
+	     scx200_cb_base + SCx200_TMCNFG_OFFSET);
+
+	if (mhz27) {
+		cs_hrt.shift = HRT_SHIFT_27;
+		cs_hrt.mult = clocksource_hz2mult(HRT_FREQ_27, HRT_SHIFT_27);
+	} else {
+		cs_hrt.shift = HRT_SHIFT_1;
+		cs_hrt.mult = clocksource_hz2mult(HRT_FREQ_1, HRT_SHIFT_1);
+	}
+	printk(KERN_INFO "enabling scx200 high-res timer (%d MHz)\n",
+	       mhz27 ? 27 : 1);
+
+	return clocksource_register(&cs_hrt);
+}
+
+module_init(init_hrt_clocksource);
+
+MODULE_AUTHOR("Jim Cromie <jim.cromie@gmail.com>");
+MODULE_DESCRIPTION("SCx200 HiRes Timer for Generic Timekeeping System");
+MODULE_LICENSE("GPL");


