Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751264AbVLPBH4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751264AbVLPBH4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 20:07:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751255AbVLPBHu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 20:07:50 -0500
Received: from e35.co.us.ibm.com ([32.97.110.153]:35468 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751264AbVLPBHf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 20:07:35 -0500
Date: Thu, 15 Dec 2005 18:07:33 -0700
From: john stultz <johnstul@us.ibm.com>
To: akpm@osdl.org
Cc: lkml <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       George Anzinger <george@mvista.com>,
       Roman Zippel <zippel@linux-m68k.org>,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>,
       Thomas Gleixner <tglx@linutronix.de>, johnstul@us.ibm.com,
       john stultz <johnstul@us.ibm.com>
Message-Id: <20051216010732.19280.54900.sendpatchset@cog.beaverton.ibm.com>
In-Reply-To: <20051216010700.19280.66934.sendpatchset@cog.beaverton.ibm.com>
References: <20051216010700.19280.66934.sendpatchset@cog.beaverton.ibm.com>
Subject: [PATCH 5/11] Time: i386 Conversion - part 1: Move timer_pit.c to i8253.c
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew, All,
	The conversion of i386 to use the generic timeofday subsystem 
has been split into 6 parts. This patch, the first of six, is just a 
simple cleanup for the i386 arch in preparation of moving to the 
generic timeofday infrastructure. It simply moves some code from 
timer_pit.c to i8253.c.
	
It applies on top of my timeofday-core patch. This patch is part the 
timeofday-arch-i386 patchset, so without the following parts it is not 
expected to compile (although just this one should).
	
Andrew, please consider for inclusion into your tree.

thanks
-john

Signed-off-by: John Stultz <johnstul@us.ibm.com>

 Makefile           |    2 -
 i8253.c            |   59 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 time.c             |    6 -----
 timers/timer_pit.c |   13 -----------
 4 files changed, 60 insertions(+), 20 deletions(-)

linux-2.6.15-rc5_timeofday-arch-i386-part1_B14.patch
============================================
diff --git a/arch/i386/kernel/Makefile b/arch/i386/kernel/Makefile
index f10de0f..7bc053f 100644
--- a/arch/i386/kernel/Makefile
+++ b/arch/i386/kernel/Makefile
@@ -7,7 +7,7 @@ extra-y := head.o init_task.o vmlinux.ld
 obj-y	:= process.o semaphore.o signal.o entry.o traps.o irq.o vm86.o \
 		ptrace.o time.o ioport.o ldt.o setup.o i8259.o sys_i386.o \
 		pci-dma.o i386_ksyms.o i387.o dmi_scan.o bootflag.o \
-		doublefault.o quirks.o i8237.o
+		doublefault.o quirks.o i8237.o i8253.o
 
 obj-y				+= cpu/
 obj-y				+= timers/
diff --git a/arch/i386/kernel/i8253.c b/arch/i386/kernel/i8253.c
new file mode 100644
index 0000000..e4b7f7d
--- /dev/null
+++ b/arch/i386/kernel/i8253.c
@@ -0,0 +1,59 @@
+/*
+ * i8253.c  8253/PIT functions
+ *
+ */
+#include <linux/spinlock.h>
+#include <linux/jiffies.h>
+#include <linux/sysdev.h>
+#include <linux/module.h>
+#include <linux/init.h>
+
+#include <asm/smp.h>
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
+
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
diff --git a/arch/i386/kernel/time.c b/arch/i386/kernel/time.c
index 41c5b2d..5a9f253 100644
--- a/arch/i386/kernel/time.c
+++ b/arch/i386/kernel/time.c
@@ -82,11 +82,6 @@ extern unsigned long wall_jiffies;
 DEFINE_SPINLOCK(rtc_lock);
 EXPORT_SYMBOL(rtc_lock);
 
-#include <asm/i8253.h>
-
-DEFINE_SPINLOCK(i8253_lock);
-EXPORT_SYMBOL(i8253_lock);
-
 struct timer_opts *cur_timer __read_mostly = &timer_none;
 
 /*
@@ -400,7 +395,6 @@ static int timer_resume(struct sys_devic
 	if (is_hpet_enabled())
 		hpet_reenable();
 #endif
-	setup_pit_timer();
 	sec = get_cmos_time() + clock_cmos_diff;
 	sleep_length = (get_cmos_time() - sleep_start) * HZ;
 	write_seqlock_irqsave(&xtime_lock, flags);
diff --git a/arch/i386/kernel/timers/timer_pit.c b/arch/i386/kernel/timers/timer_pit.c
index b9b6bd5..44cbdf9 100644
--- a/arch/i386/kernel/timers/timer_pit.c
+++ b/arch/i386/kernel/timers/timer_pit.c
@@ -162,16 +162,3 @@ struct init_timer_opts __initdata timer_
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
