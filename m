Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270517AbTGSIBU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jul 2003 04:01:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270515AbTGSIBU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jul 2003 04:01:20 -0400
Received: from natsmtp00.webmailer.de ([192.67.198.74]:28839 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP id S270519AbTGSIAx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jul 2003 04:00:53 -0400
Date: Sat, 19 Jul 2003 10:14:07 +0200
From: Dominik Brodowski <linux@brodo.de>
To: linux-kernel@vger.kernel.org, arjanv@redhat.com, johnstul@us.ibm.com
Subject: [RFC][PATCH 2.6] PM Timer as primary timing source on i386
Message-ID: <20030719081407.GA2665@brodo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch implements support for a different timing source for the i386
architecture, the Power Management Timer (PMTMR). It offers correct results
with a ~3.6MHz resolution even during aggressive Powermanagement like ACPI
C-State transitions, throttling and/or frequency scaling. It is based partly 
on Arjan's patch for 2.4.

 arch/i386/Kconfig                  |   10 +
 arch/i386/kernel/time.c            |    1
 arch/i386/kernel/timers/Makefile   |    1
 arch/i386/kernel/timers/timer_pm.c |  188 +++++++++++++++++++++++++++++++++++++
 4 files changed, 200 insertions(+)

diff -ruN linux-original/arch/i386/Kconfig linux/arch/i386/Kconfig
--- linux-original/arch/i386/Kconfig	2003-07-14 17:13:27.000000000 +0200
+++ linux/arch/i386/Kconfig	2003-07-19 09:42:33.000000000 +0200
@@ -506,6 +506,16 @@
 	depends on (MWINCHIP3D || MWINCHIP2 || MCRUSOE || MCYRIXIII || MK7 || MK6 || MPENTIUM4 || MPENTIUMIII || MPENTIUMII || M686 || M586MMX || M586TSC || MK8 || MVIAC3_2) && !X86_NUMAQ
 	default y
 
+config X86_PM_TIMER
+	tristate "Use Power Management Timer (PMTMR) as primary timing source"
+	depends on ACPI_BUS
+	help
+	  The Power Management Timer (PMTMR) is available on all 
+	  ACPI-capable systems. it provides a reliable timing source 
+	  which does not get affected by powermanagement features 
+	  (e.g. aggressive idling, throttling or frequency scaling), 
+	  unlike the commonly used Time Stamp Counter (TSC) timing source.
+
 config X86_MCE
 	bool "Machine Check Exception"
 	---help---
diff -ruN linux-original/arch/i386/kernel/time.c linux/arch/i386/kernel/time.c
--- linux-original/arch/i386/kernel/time.c	2003-07-14 17:13:27.000000000 +0200
+++ linux/arch/i386/kernel/time.c	2003-07-18 17:50:12.000000000 +0200
@@ -81,6 +81,7 @@
 EXPORT_SYMBOL(i8253_lock);
 
 struct timer_opts *cur_timer = &timer_none;
+EXPORT_SYMBOL(cur_timer);
 
 /*
  * This version of gettimeofday has microsecond resolution
diff -ruN linux-original/arch/i386/kernel/timers/Makefile linux/arch/i386/kernel/timers/Makefile
--- linux-original/arch/i386/kernel/timers/Makefile	2003-06-15 12:16:15.000000000 +0200
+++ linux/arch/i386/kernel/timers/Makefile	2003-07-19 09:22:39.000000000 +0200
@@ -5,3 +5,4 @@
 obj-y := timer.o timer_none.o timer_tsc.o timer_pit.o
 
 obj-$(CONFIG_X86_CYCLONE_TIMER)	+= timer_cyclone.o
+obj-$(CONFIG_X86_PM_TIMER) += timer_pm.o
diff -ruN linux-original/arch/i386/kernel/timers/timer_pm.c linux/arch/i386/kernel/timers/timer_pm.c
--- linux-original/arch/i386/kernel/timers/timer_pm.c	1970-01-01 01:00:00.000000000 +0100
+++ linux/arch/i386/kernel/timers/timer_pm.c	2003-07-19 09:50:57.000000000 +0200
@@ -0,0 +1,188 @@
+/*
+ * (C) Dominik Brodowski <linux@brodo.de> 2003
+ *
+ * Driver to use the Power Management Timer (PMTMR) available in some
+ * southbridges as primary timing source for the Linux kernel.
+ *
+ * based on parts of linux/drivers/acpi/hardware/hwtimer.c and of timer_pit.c,
+ * and on Arjan van de Ven's implementation for 2.4. 
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
+/* The I/O port the PMTMR resides at */
+static u32 pmtmr_ioport = 0;
+
+/* value of the Power timer at last timer interrupt */
+static u32 offset_tick;
+
+/* forward declaration of our timer_opts struct */
+struct timer_opts timer_pmtmr;
+static void mark_offset_pmtmr(void);
+
+/************ detection of the I/O port *****************/
+
+/*
+ * The PMTMR I/O port can be detected using the following methods:
+ *
+ * a) Scan the PCI bus for the device the PMTMR is located at [e.g. PIIX4 southbridge],
+ *    locate its I/O port range, and then use a table-lookup to find the I/O port 
+ *    (offset) for the PMTMR for this device. 
+ *    While this provides some safety from buggy BIOSes, it is also very chipset-specific
+ *    and only available once the PCI devices are properly enabled, e.g. very late during
+ *    the boot process. Another timing source needs to be used in between. However, as this
+ *    approach is independent of ACPI and CONFIG_ACPI, it might be a good solution for some
+ *    very broken systems.
+ *    This method is not implemented yet.
+ *
+ * b) Ask the ACPI subsystem's FADT. While this is the easiest approach, it also means that
+ *    this timer is only available _late_ in the boot process, only after the ACPI subsystem
+ *    has been initialized (which is a subsys_initcall). However, the timing sources are set
+ *    up already earlier. This means that we need to use the TSC or the PIT intermediately until
+ *    this code replaces the earlier used timer with the PMTMR [see mark_offset_and_replace() foir
+ *    details on this].
+ *    This method is implemented.
+ *
+ * c) Parse the ACPI FADT here, too. This means that this code could be independend of CONFIG_ACPI,
+ *    but it would cause a lot of code duplication between the ACPI subsystem and this file. However,
+ *    as this could mean that the PMTMR can be used immediately, without having to rely on alternate
+ *    timing sources first.
+ *    This method is not implemented yet.
+ */
+
+static void mark_offset_and_replace(void)
+{
+	cur_timer = &timer_pmtmr;
+	mark_offset_pmtmr();
+}
+
+/* method b) */
+
+#include <acpi/acpi.h>
+#include <acpi/acpi_bus.h>
+
+struct timer_opts *prev_timer;
+
+static int __init pmtimer_init(void)
+{
+	int ret;
+
+	ret = acpi_get_timer(&offset_tick);
+	if (ret) {
+		printk(KERN_ERR "acpi_get_timer failed\n");
+		return -EINVAL;
+	}
+
+	if (acpi_fadt.xpm_tmr_blk.address_space_id != ACPI_ADR_SPACE_SYSTEM_IO) {
+		printk(KERN_INFO "ACPI PM timer is not at IO port -- error\n");
+		return -EINVAL;
+	}
+
+	pmtmr_ioport = acpi_fadt.xpm_tmr_blk.address;
+	if (!pmtmr_ioport) {
+		printk(KERN_INFO "ACPI PM timer invalid IO port\n");
+		return -EINVAL;
+	}
+		
+	printk(KERN_INFO "Using ACPI PM timer at 0x%x as timing source.\n", pmtmr_ioport);
+
+	prev_timer = cur_timer;
+	cur_timer->mark_offset = mark_offset_and_replace;
+	
+	return 0;
+}
+fs_initcall(pmtimer_init);
+
+static void __exit pmtimer_exit(void)
+{
+	cur_timer = prev_timer;
+}
+module_exit(pmtimer_exit);
+
+
+/************ actual timing code *****************/
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
+/*
+ * would it be desirable to have a ~279 nanosecond resolution?
+ */
+static unsigned long long monotonic_clock_pmtmr(void)
+{
+	return 0;
+}
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
+	if (offset < now)
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
+/* acpi timer_opts struct */
+struct timer_opts timer_pmtmr = {
+	.init =		NULL,
+	.mark_offset =	mark_offset_pmtmr, 
+	.get_offset =	get_offset_pmtmr,
+	.monotonic_clock = monotonic_clock_pmtmr,
+	.delay = delay_pmtmr,
+};
+
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Dominik Brodowski <linux@brodo.de>");
+MODULE_DESCRIPTION("Power Management Timer (PMTMR) as primary timing source for i386");
