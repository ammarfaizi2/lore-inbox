Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263680AbTJ0XMf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Oct 2003 18:12:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263681AbTJ0XMf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Oct 2003 18:12:35 -0500
Received: from natsmtp00.rzone.de ([81.169.145.165]:9191 "EHLO
	natsmtp00.webmailer.de") by vger.kernel.org with ESMTP
	id S263680AbTJ0XM0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Oct 2003 18:12:26 -0500
Date: Tue, 28 Oct 2003 00:01:13 +0100
From: Dominik Brodowski <linux@brodo.de>
To: john stultz <johnstul@us.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, albert@users.sourceforge.net
Subject: ACPI PM-Timer rev.2 [Was: Re: ACPI PM-Timer [Was: Re: [RFC][PATCH] must fix lists]]
Message-ID: <20031027230113.GA701@brodo.de>
References: <3F94C833.8040204@cyberone.com.au> <1066943359.6102.14.camel@dhcp23.swansea.linux.org.uk> <20031023172323.A10588@osdlab.pdx.osdl.net> <1067113087.10272.4.camel@dhcp23.swansea.linux.org.uk> <3F9D1557.4050404@cyberone.com.au> <20031027182416.GA3905@brodo.de> <1067280154.1113.334.camel@cog.beaverton.ibm.com> <20031027184908.GA4240@brodo.de> <1067281639.1122.358.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1067281639.1122.358.camel@cog.beaverton.ibm.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 27, 2003 at 11:07:19AM -0800, john stultz wrote:
> Ah, OK. Well, I'd prefer the manual ACPI parsing personally, but having
> tried and failed to implement it once myself, I'd more prefer not to do
> it myself. ;)

Here it is, and it is soooo much nicer than my previous implementation. It
lacks the "lost-ticks compensation" and math cleanup John is working on, but
otherwise:

 arch/i386/Kconfig                  |   18 ++++
 arch/i386/kernel/acpi/boot.c       |   31 ++++++++
 arch/i386/kernel/timers/Makefile   |    1
 arch/i386/kernel/timers/timer.c    |    3
 arch/i386/kernel/timers/timer_pm.c |  139 +++++++++++++++++++++++++++++++++++++
 include/asm-i386/timer.h           |    3
 6 files changed, 195 insertions(+)

	Dominik

diff -ruN linux-original/arch/i386/Kconfig linux/arch/i386/Kconfig
--- linux-original/arch/i386/Kconfig	2003-10-27 16:45:25.000000000 +0100
+++ linux/arch/i386/Kconfig	2003-10-27 23:51:07.364168640 +0100
@@ -411,6 +411,24 @@
 config HPET_EMULATE_RTC
 	def_bool HPET_TIMER && RTC=y
 
+config X86_PM_TIMER
+	bool "Power Management Timer Support"
+	depends on (!X86_VISWS && !X86_VISWS) && EXPERIMENTAL
+	default n
+	help
+	  The Power Management Timer is available on all ACPI-capable,
+	  in most cases even if ACPI is unusable or blacklisted.
+
+	  This timing source is not affected by powermanagement features
+	  like aggressive processor idling, throttling, frequency and/or
+	  voltage scaling, unlike the commonly used Time Stamp Counter 
+	  (TSC) timing source.
+
+	  So, if you see messages like 'Losing too many ticks!' in the 
+	  kernel logs, and/or you are using a this on a notebook which
+	  does not yet have an HPET (see above), you should say "Y" 
+	  here. Otherwise, say "N".
+
 config SMP
 	bool "Symmetric multi-processing support"
 	---help---
diff -ruN linux-original/arch/i386/kernel/acpi/boot.c linux/arch/i386/kernel/acpi/boot.c
--- linux-original/arch/i386/kernel/acpi/boot.c	2003-10-27 16:45:25.000000000 +0100
+++ linux/arch/i386/kernel/acpi/boot.c	2003-10-27 23:48:07.873455376 +0100
@@ -319,6 +319,33 @@
 }
 #endif
 
+/* detect the location of the ACPI PM Timer
+#ifdef CONFIG_X86_PM_TIMER
+extern u32 pmtmr_ioport;
+
+static int __init acpi_parse_fadt(unsigned long phys, unsigned long size)
+{
+	struct fadt_descriptor_rev2 *fadt;
+
+	fadt = __va(phys);
+
+	if (fadt->revision >= FADT2_REVISION_ID) {
+		/* FADT rev. 2 */
+		if (fadt->xpm_tmr_blk.address_space_id != ACPI_ADR_SPACE_SYSTEM_IO)
+			return 0;
+
+		pmtmr_ioport = fadt->xpm_tmr_blk.address;
+	} else {
+		/* FADT rev. 1 */
+		pmtmr_ioport = fadt->V1_pm_tmr_blk;
+	}
+	if (pmtmr_ioport)
+		printk(KERN_INFO PREFIX "PM-Timer IO Port: %#x\n", pmtmr_ioport);
+	return 0;
+}
+#endif
+
+
 unsigned long __init
 acpi_find_rsdp (void)
 {
@@ -512,5 +539,9 @@
 	acpi_table_parse(ACPI_HPET, acpi_parse_hpet);
 #endif
 
+#ifdef CONFIG_X86_PM_TIMER
+	acpi_table_parse(ACPI_FADT, acpi_parse_fadt);
+#endif
+
 	return 0;
 }
diff -ruN linux-original/arch/i386/kernel/timers/Makefile linux/arch/i386/kernel/timers/Makefile
--- linux-original/arch/i386/kernel/timers/Makefile	2003-10-27 16:45:25.000000000 +0100
+++ linux/arch/i386/kernel/timers/Makefile	2003-10-27 23:48:07.937445648 +0100
@@ -6,3 +6,4 @@
 
 obj-$(CONFIG_X86_CYCLONE_TIMER)	+= timer_cyclone.o
 obj-$(CONFIG_HPET_TIMER)	+= timer_hpet.o
+obj-$(CONFIG_X86_PM_TIMER)	+= timer_pm.o
diff -ruN linux-original/arch/i386/kernel/timers/timer.c linux/arch/i386/kernel/timers/timer.c
--- linux-original/arch/i386/kernel/timers/timer.c	2003-10-27 23:33:34.695198648 +0100
+++ linux/arch/i386/kernel/timers/timer.c	2003-10-27 23:48:07.938445496 +0100
@@ -19,6 +19,9 @@
 #ifdef CONFIG_HPET_TIMER
 	&timer_hpet,
 #endif
+#ifdef CONFIG_X86_PM_TIMER
+	&timer_pmtmr,
+#endif
 	&timer_tsc,
 	&timer_pit,
 	NULL,
diff -ruN linux-original/arch/i386/kernel/timers/timer_pm.c linux/arch/i386/kernel/timers/timer_pm.c
--- linux-original/arch/i386/kernel/timers/timer_pm.c	1970-01-01 01:00:00.000000000 +0100
+++ linux/arch/i386/kernel/timers/timer_pm.c	2003-10-27 23:48:08.002435768 +0100
@@ -0,0 +1,139 @@
+/*
+ * (C) Dominik Brodowski <linux@brodo.de> 2003
+ *
+ * Driver to use the Power Management Timer (PMTMR) available in some
+ * southbridges as primary timing source for the Linux kernel.
+ *
+ * Based on parts of linux/drivers/acpi/hardware/hwtimer.c, timer_pit.c,
+ * timer_hpet.c, and on Arjan van de Ven's implementation for 2.4. 
+ *
+ * This file is licensed under the GPL v2.
+ */
+
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/device.h>
+#include <linux/init.h>
+#include <asm/types.h>
+#include <asm/timer.h>
+#include <asm/smp.h>
+#include <asm/io.h>
+#include <asm/arch_hooks.h>
+
+
+/* The I/O port the PMTMR resides at.
+ * The location is detected during setup_arch(),
+ * in arch/i386/acpi/boot.c */
+u32 pmtmr_ioport = 0;
+
+
+/* value of the Power timer at last timer interrupt */
+static u32 offset_tick;
+
+
+static int init_pmtmr(char* override)
+{
+	u32 value1, value2;
+	unsigned int i;
+
+ 	if (override[0] && strncmp(override,"pmtmr",5))
+		return -ENODEV;
+
+	if (!pmtmr_ioport)
+		return -ENODEV;
+
+	/* "verify" this timing source */
+	value1 = inl(pmtmr_ioport);
+	value1 &= 0xFFFFFF;
+	for (i=0; i < 10000; i++) {
+		value2 = inl(pmtmr_ioport);
+		value2 &= 0xFFFFFF;
+		if (value2 == value1) 
+			continue;
+		if (value2 > value1)
+			return 0;
+		if ((value2 < value1) && ((value2) < 0xFFF))
+			return 0;
+		printk(KERN_INFO "PM-Timer had inconsistent results: 0x%#x, 0x%#x - aborting.\n", value1, value2);
+		return -EINVAL;
+	}
+	printk(KERN_INFO "PM-Timer had no reasonable result: 0x%#x - aborting.\n", value1);
+	return -ENODEV;
+}
+
+
+/*
+ * this gets called during each timer interrupt
+ */
+static void mark_offset_pmtmr(void)
+{
+	offset_tick = inl(pmtmr_ioport);
+	offset_tick &= 0xFFFFFF; /* limit it to 24 bits */
+	return;
+}
+
+
+static unsigned long long monotonic_clock_pmtmr(void)
+{
+	return 0;
+}
+
+
+/*
+ * copied from delay_pit
+ */
+static void delay_pmtmr(unsigned long loops)
+{
+	int d0;
+	__asm__ __volatile__(
+		"\tjmp 1f\n"
+		".align 16\n"
+		"1:\tjmp 2f\n"
+		".align 16\n"
+		"2:\tdecl %0\n\tjns 2b"
+		:"=&a" (d0)
+		:"0" (loops));
+}
+
+
+/*
+ * get the offset (in microseconds) from the last call to mark_offset()
+ */
+static unsigned long get_offset_pmtmr(void)
+{
+	u32 now, offset, delta = 0;
+
+	offset = offset_tick;
+	now = inl(pmtmr_ioport);
+	now &= 0xFFFFFF;
+	if (likely(offset < now))
+		delta = now - offset;
+	else if (offset > now)
+		delta = (0xFFFFFF - offset) + now;
+
+	/* The Power Management Timer ticks at 3.579545 ticks per microsecond.
+	 * 1 / PM_TIMER_FREQUENCY == 0.27936511 =~ 286/1024 [error: 0.024%]
+	 *
+	 * Even with HZ = 100, delta is at maximum 35796 ticks, so it can 
+	 * easily be multiplied with 286 (=0x11E) without having to fear
+	 * u32 overflows.
+	 */
+	delta *= 286;
+	return (unsigned long) (delta >> 10);
+}
+
+
+/* acpi timer_opts struct */
+struct timer_opts timer_pmtmr = {
+	.init 			= init_pmtmr,
+	.mark_offset		= mark_offset_pmtmr, 
+	.get_offset		= get_offset_pmtmr,
+	.monotonic_clock 	= monotonic_clock_pmtmr,
+	.delay 			= delay_pmtmr,
+};
+
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Dominik Brodowski <linux@brodo.de>");
+MODULE_DESCRIPTION("Power Management Timer (PMTMR) as primary timing source for x86");
diff -ruN linux-original/include/asm-i386/timer.h linux/include/asm-i386/timer.h
--- linux-original/include/asm-i386/timer.h	2003-10-27 23:33:34.696198496 +0100
+++ linux/include/asm-i386/timer.h	2003-10-27 23:48:08.036430600 +0100
@@ -44,4 +44,7 @@
 extern unsigned long calibrate_tsc_hpet(unsigned long *tsc_hpet_quotient_ptr);
 #endif
 
+#ifdef CONFIG_X86_PM_TIMER
+extern struct timer_opts timer_pmtmr;
+#endif
 #endif


