Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964838AbVKVBii@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964838AbVKVBii (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 20:38:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964826AbVKVBgJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 20:36:09 -0500
Received: from e32.co.us.ibm.com ([32.97.110.150]:62944 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S964832AbVKVBfu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 20:35:50 -0500
Date: Mon, 21 Nov 2005 18:35:48 -0700
From: john stultz <johnstul@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Ingo Molnar <mingo@elte.hu>, Darren Hart <dvhltc@us.ibm.com>,
       Nishanth Aravamudan <nacc@us.ibm.com>,
       Frank Sorenson <frank@tuxrocks.com>,
       George Anzinger <george@mvista.com>,
       Roman Zippel <zippel@linux-m68k.org>,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>,
       Thomas Gleixner <tglx@linutronix.de>, john stultz <johnstul@us.ibm.com>,
       john stultz <johnstul@us.ibm.com>
Message-Id: <20051122013548.18537.97737.sendpatchset@cog.beaverton.ibm.com>
In-Reply-To: <20051122013515.18537.76463.sendpatchset@cog.beaverton.ibm.com>
References: <20051122013515.18537.76463.sendpatchset@cog.beaverton.ibm.com>
Subject: [PATCH 5/13] Time: i386 Conversion - part 1: Move timer_pit.c to i8253.c
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All,
	The conversion of i386 to use the generic timeofday subsystem has been
split into 6 parts. This patch, the first of six, is just a simple
cleanup for the i386 arch in preparation of moving to the generic
timeofday infrastructure. It simply moves some code from timer_pit.c to
i8253.c.
	
It applies on top of my timeofday-core patch. This patch is part the
timeofday-arch-i386 patchset, so without the following parts it is not
expected to compile (although just this one should).
	
thanks
-john

Signed-off-by: John Stultz <johnstul@us.ibm.com>

linux-2.6.15-rc1-mm2_timeofday-arch-i386-part1_B11.patch
============================================
diff -ruN tod-mm_1/arch/i386/kernel/i8253.c tod-mm_2/arch/i386/kernel/i8253.c
--- tod-mm_1/arch/i386/kernel/i8253.c	1969-12-31 16:00:00.000000000 -0800
+++ tod-mm_2/arch/i386/kernel/i8253.c	2005-11-21 16:48:22.000000000 -0800
@@ -0,0 +1,57 @@
+/*
+ * i8253.c  8253/PIT functions
+ *
+ */
+#include <linux/init.h>
+#include <linux/jiffies.h>
+#include <linux/spinlock.h>
+#include <linux/sysdev.h>
+#include <linux/module.h>
+
+#include <asm/delay.h>
+#include <asm/i8253.h>
+#include <asm/io.h>
+
+#include "io_ports.h"
+
+DEFINE_SPINLOCK(i8253_lock);
+EXPORT_SYMBOL(i8253_lock);
+
+void setup_pit_timer(void)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&i8253_lock, flags);
+	outb_p(0x34,PIT_MODE);		/* binary, mode 2, LSB/MSB, ch 0 */
+	udelay(10);
+	outb_p(LATCH & 0xff , PIT_CH0);	/* LSB */
+	udelay(10);
+	outb(LATCH >> 8 , PIT_CH0);	/* MSB */
+	spin_unlock_irqrestore(&i8253_lock, flags);
+}
+
+static int timer_resume(struct sys_device *dev)
+{
+	setup_pit_timer();
+	return 0;
+}
+
+static struct sysdev_class timer_sysclass = {
+	set_kset_name("timer_pit"),
+	.resume	= timer_resume,
+};
+
+static struct sys_device device_timer = {
+	.id	= 0,
+	.cls	= &timer_sysclass,
+};
+
+static int __init init_timer_sysfs(void)
+{
+	int error = sysdev_class_register(&timer_sysclass);
+	if (!error)
+		error = sysdev_register(&device_timer);
+	return error;
+}
+
+device_initcall(init_timer_sysfs);
diff -ruN tod-mm_1/arch/i386/kernel/Makefile tod-mm_2/arch/i386/kernel/Makefile
--- tod-mm_1/arch/i386/kernel/Makefile	2005-11-21 16:39:09.000000000 -0800
+++ tod-mm_2/arch/i386/kernel/Makefile	2005-11-21 16:48:37.000000000 -0800
@@ -7,7 +7,7 @@
 obj-y	:= process.o semaphore.o signal.o entry.o traps.o irq.o vm86.o \
 		ptrace.o time.o ioport.o ldt.o setup.o i8259.o sys_i386.o \
 		pci-dma.o i386_ksyms.o i387.o dmi_scan.o bootflag.o \
-		quirks.o i8237.o
+		quirks.o i8237.o i8253.o
 
 obj-y				+= cpu/
 obj-y				+= timers/
diff -ruN tod-mm_1/arch/i386/kernel/time.c tod-mm_2/arch/i386/kernel/time.c
--- tod-mm_1/arch/i386/kernel/time.c	2005-11-21 16:39:09.000000000 -0800
+++ tod-mm_2/arch/i386/kernel/time.c	2005-11-21 16:48:22.000000000 -0800
@@ -82,11 +82,6 @@
 DEFINE_SPINLOCK(rtc_lock);
 EXPORT_SYMBOL(rtc_lock);
 
-#include <asm/i8253.h>
-
-DEFINE_SPINLOCK(i8253_lock);
-EXPORT_SYMBOL(i8253_lock);
-
 struct timer_opts *cur_timer __read_mostly = &timer_none;
 
 /*
@@ -400,7 +395,6 @@
 	if (is_hpet_enabled())
 		hpet_reenable();
 #endif
-	setup_pit_timer();
 	sec = get_cmos_time() + clock_cmos_diff;
 	sleep_length = (get_cmos_time() - sleep_start) * HZ;
 	write_seqlock_irqsave(&xtime_lock, flags);
diff -ruN tod-mm_1/arch/i386/kernel/timers/timer_pit.c tod-mm_2/arch/i386/kernel/timers/timer_pit.c
--- tod-mm_1/arch/i386/kernel/timers/timer_pit.c	2005-11-21 16:39:09.000000000 -0800
+++ tod-mm_2/arch/i386/kernel/timers/timer_pit.c	2005-11-21 16:48:22.000000000 -0800
@@ -162,16 +162,3 @@
 	.init = init_pit, 
 	.opts = &timer_pit,
 };
-
-void setup_pit_timer(void)
-{
-	unsigned long flags;
-
-	spin_lock_irqsave(&i8253_lock, flags);
-	outb_p(0x34,PIT_MODE);		/* binary, mode 2, LSB/MSB, ch 0 */
-	udelay(10);
-	outb_p(LATCH & 0xff , PIT_CH0);	/* LSB */
-	udelay(10);
-	outb(LATCH >> 8 , PIT_CH0);	/* MSB */
-	spin_unlock_irqrestore(&i8253_lock, flags);
-}
