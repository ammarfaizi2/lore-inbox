Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751357AbVKAW3G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751357AbVKAW3G (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 17:29:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751360AbVKAW3G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 17:29:06 -0500
Received: from e31.co.us.ibm.com ([32.97.110.149]:27320 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751357AbVKAW3F
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 17:29:05 -0500
Subject: [RFC][PATCH 5/12] generic timeofday i386 arch specific changes,
	part 1
From: john stultz <johnstul@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Ingo Molnar <mingo@elte.hu>, Darren Hart <dvhltc@us.ibm.com>,
       Nishanth Aravamudan <nacc@us.ibm.com>,
       Frank Sorenson <frank@tuxrocks.com>,
       George Anzinger <george@mvista.com>,
       Roman Zippel <zippel@linux-m68k.org>,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>,
       Thomas Gleixner <tglx@linutronix.de>
In-Reply-To: <1130884065.27168.464.camel@cog.beaverton.ibm.com>
References: <1130883795.27168.457.camel@cog.beaverton.ibm.com>
	 <1130883849.27168.458.camel@cog.beaverton.ibm.com>
	 <1130883935.27168.461.camel@cog.beaverton.ibm.com>
	 <1130884000.27168.462.camel@cog.beaverton.ibm.com>
	 <1130884065.27168.464.camel@cog.beaverton.ibm.com>
Content-Type: text/plain
Date: Tue, 01 Nov 2005 14:29:01 -0800
Message-Id: <1130884141.27168.467.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All,
	The conversion of i386 to use the generic timeofday subsystem has been
split into 6 parts. This patch, the first of six, is just a simple
cleanup for the i386 arch in preparation of moving the the generic
timeofday infrastructure. It simply moves some code from timer_pit.c to
i8253.c.
	
It applies on top of my timeofday-core patch. This patch is part the
timeofday-arch-i386 patchset, so without the following parts it is not
expected to compile.

thanks
-john

 Makefile           |    2 -
 i8253.c            |   57 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 time.c             |    6 -----
 timers/timer_pit.c |   13 ------------
 4 files changed, 58 insertions(+), 20 deletions(-)

linux-2.6.14-rc5-mm1_timeofday-arch-i386-part1_B9.patch
============================================
diff --git a/arch/i386/kernel/Makefile b/arch/i386/kernel/Makefile
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
--- /dev/null
+++ b/arch/i386/kernel/i8253.c
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
diff --git a/arch/i386/kernel/time.c b/arch/i386/kernel/time.c
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
--- a/arch/i386/kernel/timers/timer_pit.c
+++ b/arch/i386/kernel/timers/timer_pit.c
@@ -161,16 +161,3 @@ struct init_timer_opts __initdata timer_
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


