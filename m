Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263461AbTJ0Sa5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Oct 2003 13:30:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263462AbTJ0Sa5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Oct 2003 13:30:57 -0500
Received: from natsmtp00.rzone.de ([81.169.145.165]:4276 "EHLO
	natsmtp00.webmailer.de") by vger.kernel.org with ESMTP
	id S263461AbTJ0Saq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Oct 2003 13:30:46 -0500
Date: Mon, 27 Oct 2003 19:24:16 +0100
From: Dominik Brodowski <linux@brodo.de>
To: johnstul@us.ibm.com, akpm@osdl.org, linux-kernel@vger.kernel.org,
       alan@lxorguk.ukuu.org.uk, albert@users.sourceforge.net
Subject: ACPI PM-Timer [Was: Re: [RFC][PATCH] must fix lists]
Message-ID: <20031027182416.GA3905@brodo.de>
References: <3F94C833.8040204@cyberone.com.au> <1066943359.6102.14.camel@dhcp23.swansea.linux.org.uk> <20031023172323.A10588@osdlab.pdx.osdl.net> <1067113087.10272.4.camel@dhcp23.swansea.linux.org.uk> <3F9D1557.4050404@cyberone.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F9D1557.4050404@cyberone.com.au>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 27, 2003 at 11:53:43PM +1100, Nick Piggin wrote:
> +o alan, Albert Cahalan: 1000 HZ timer increases the need for a stable time
> +  source. Many laptops, SMI can lose ticks. ACPI timers? TSC?

A few months ago, I proposed to make the ACPI "Powermanagement" timer, a 
reliable timing source with  ~3.6MHz resolution, available as a timer_opts
for arch/i386/kernel/timers/timer.c. [1]

The major difficulty with this ACPI PM-Timer is that the I/O-port it is
located at is unknown during time_init.[2] So, it becomes necessary to use a
different timing source in the beginning, and switch to the ACPI PM-Timer
later.

Here are two different methods to replace one timing source with another.
First, the simple (and buggy) one -- the timing is broken until the next
timer "tick" == the next call to mark_offset().

diff -ruN linux-original/arch/i386/kernel/timers/timer.c linux/arch/i386/kernel/timers/timer.c
--- linux-original/arch/i386/kernel/timers/timer.c	2003-10-27 16:45:25.071848960 +0100
+++ linux/arch/i386/kernel/timers/timer.c	2003-10-27 18:59:23.904760600 +0100
@@ -35,12 +35,20 @@
 __setup("clock=", clock_setup);
 
 
+/* Switch to other timesource. */
+int replace_timer_opts(struct timer_opts *replacement)
+{
+	replacement->mark_offset();
+	cur_timer = replacement;
+	return 0;
+}
+
 /* The chosen timesource has been found to be bad.
  * Fall back to a known good timesource (the PIT)
  */
 void clock_fallback(void)
 {
-	cur_timer = &timer_pit;
+	replace_timer_opts(&timer_pit);
 }
 
 /* iterates through the list of timers, returning the first 
diff -ruN linux-original/include/asm-i386/timer.h linux/include/asm-i386/timer.h
--- linux-original/include/asm-i386/timer.h	2003-10-27 16:45:34.000000000 +0100
+++ linux/include/asm-i386/timer.h	2003-10-27 18:57:06.345672760 +0100
@@ -22,6 +22,7 @@
 
 extern struct timer_opts* select_timer(void);
 extern void clock_fallback(void);
+extern int replace_timer_opts(struct timer_opts *replacement);
 
 /* Modifiers for buggy PIT handling */
 

||| END OF PATCH |||


A different, more sensible approach is this:

diff -ruN linux-original/arch/i386/kernel/timers/timer.c linux/arch/i386/kernel/timers/timer.c
--- linux-original/arch/i386/kernel/timers/timer.c	2003-10-27 16:45:25.071848960 +0100
+++ linux/arch/i386/kernel/timers/timer.c	2003-10-27 18:43:56.644725552 +0100
@@ -1,7 +1,10 @@
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/string.h>
+#include <linux/spinlock.h>
+#include <linux/errno.h>
 #include <asm/timer.h>
+#include <linux/delay.h>
 
 #ifdef CONFIG_HPET_TIMER
 /*
@@ -35,12 +38,83 @@
 __setup("clock=", clock_setup);
 
 
+/* Switch to other timesource.
+ * This is tricky as it must be done during the next "mark_offset",
+ * to assure that get_offset() is correct.
+ */
+
+struct timer_opts intermediate_timer_opts;
+struct timer_opts *replacement_timer_opts = NULL;
+static spinlock_t replace_timer_lock = SPIN_LOCK_UNLOCKED;
+
+static void mark_offset_and_replace(void)
+{
+	/* in interrupt... */
+	spin_lock(&replace_timer_lock);
+
+	/* replace... */
+	cur_timer = replacement_timer_opts;
+	replacement_timer_opts = NULL;
+
+	/* and mark the offset with the new timer */
+	cur_timer->mark_offset();
+
+	spin_unlock(&replace_timer_lock);
+}
+
+
+int replace_timer_opts(struct timer_opts *replacement)
+{
+	unsigned long flags;
+	unsigned long counter = 0;
+
+	might_sleep();
+	spin_lock_irqsave(&replace_timer_lock, flags);
+
+	/* verify nobody else is trying to replace right now */
+	if (replacement_timer_opts)
+	{
+		spin_unlock_irqrestore(&replace_timer_lock, flags);
+		return -EBUSY;
+	}
+	replacement_timer_opts = replacement;
+
+	/* copy the current timer source operations to a new timer_opts struct,
+	 * but use our special own mark_offset funciton which replaces the
+	 * time source. */
+
+	memcpy(&intermediate_timer_opts, cur_timer, sizeof(struct timer_opts));
+	intermediate_timer_opts.mark_offset = mark_offset_and_replace;
+	cur_timer = &intermediate_timer_opts;
+	spin_unlock_irqrestore(&replace_timer_lock, flags);	
+
+	/* wait until the change is done. Can't rely on mdelay and/or friends
+	 * here, as we don't really trust the previous timing source any longer. */
+
+	for (;;) {
+		spin_lock_irqsave(&replace_timer_lock, flags);
+		if (replacement_timer_opts != cur_timer) {
+			spin_unlock_irqrestore(&replace_timer_lock, flags);
+			return 0;
+		}
+		counter++;
+		if (counter > loops_per_jiffy) {
+			/* lose temper */
+			cur_timer = replacement_timer_opts;
+			replacement_timer_opts = NULL;
+		}
+		spin_unlock_irqrestore(&replace_timer_lock, flags);
+	}
+
+	return 1;
+}
+
 /* The chosen timesource has been found to be bad.
  * Fall back to a known good timesource (the PIT)
  */
 void clock_fallback(void)
 {
-	cur_timer = &timer_pit;
+	replace_timer_opts(&timer_pit);
 }
 
 /* iterates through the list of timers, returning the first 
diff -ruN linux-original/include/asm-i386/timer.h linux/include/asm-i386/timer.h
--- linux-original/include/asm-i386/timer.h	2003-10-27 16:45:34.000000000 +0100
+++ linux/include/asm-i386/timer.h	2003-10-27 18:21:46.341962312 +0100
@@ -22,6 +22,7 @@
 
 extern struct timer_opts* select_timer(void);
 extern void clock_fallback(void);
+extern int replace_timer_opts(struct timer_opts *replacement);
 
 /* Modifiers for buggy PIT handling */
 

||| END OF PATCH |||


And, last but not least, here's the actual timer code:

diff -ruN linux-original/arch/i386/Kconfig linux/arch/i386/Kconfig
--- linux-original/arch/i386/Kconfig	2003-10-27 16:45:25.074848504 +0100
+++ linux/arch/i386/Kconfig	2003-10-27 18:45:04.259446552 +0100
@@ -510,6 +510,18 @@
 	depends on (MWINCHIP3D || MWINCHIP2 || MCRUSOE || MCYRIXIII || MK7 || MK6 || MPENTIUM4 || MPENTIUMIII || MPENTIUMII || M686 || M586MMX || M586TSC || MK8 || MVIAC3_2) && !X86_NUMAQ
 	default y
 
+config X86_PM_TIMER
+	bool "Use Power Management Timer (PMTMR) as primary timing source"
+	depends on ACPI_BUS
+	help
+	  The Power Management Timer (PMTMR) is available on all 
+	  ACPI-capable systems. it provides a reliable timing source 
+	  which does not get affected by powermanagement features 
+	  (e.g. aggressive idling, throttling or frequency scaling), 
+	  unlike the commonly used Time Stamp Counter (TSC) timing source.
+	  If you see messages like 'Losing too many ticks!' in the kernel
+	  logs, you may want to say "Y" here.
+
 config X86_MCE
 	bool "Machine Check Exception"
 	---help---
diff -ruN linux-original/arch/i386/kernel/timers/Makefile linux/arch/i386/kernel/timers/Makefile
--- linux-original/arch/i386/kernel/timers/Makefile	2003-10-27 16:45:25.071848960 +0100
+++ linux/arch/i386/kernel/timers/Makefile	2003-10-27 18:34:49.717871072 +0100
@@ -6,3 +6,4 @@
 
 obj-$(CONFIG_X86_CYCLONE_TIMER)	+= timer_cyclone.o
 obj-$(CONFIG_HPET_TIMER)	+= timer_hpet.o
+obj-$(CONFIG_X86_PM_TIMER)	+= timer_pm.o
diff -ruN linux-original/arch/i386/kernel/timers/timer_pm.c linux/arch/i386/kernel/timers/timer_pm.c
--- linux-original/arch/i386/kernel/timers/timer_pm.c	1970-01-01 01:00:00.000000000 +0100
+++ linux/arch/i386/kernel/timers/timer_pm.c	2003-10-27 18:46:13.944852760 +0100
@@ -0,0 +1,168 @@
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
+struct timer_opts timer_pmtmr;
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
+ *    This method has not been implemented yet.
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
+ *    This method has not been implemented yet.
+ */
+
+/* method b) */
+
+#include <acpi/acpi.h>
+#include <acpi/acpi_bus.h>
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
+	printk(KERN_INFO "Trying to switch to ACPI PM timer at 0x%x as timing source\n.", pmtmr_ioport);
+
+	replace_timer_opts(&timer_pmtmr);
+	
+	return 0;
+}
+fs_initcall(pmtimer_init);
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
+MODULE_DESCRIPTION("Power Management Timer (PMTMR) as primary timing source for x86");

||| END OF PATCH |||

These patches have been tested on two i386 systems with 2.6.0-test9.

John? Albert?

	Dominik

[1] http://marc.theaimsgroup.com/?l=linux-kernel&m=105860269801212&w=2
[2] For details, see the comment in the third patch, below "detection
    of the I/O Port".
