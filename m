Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261234AbUG0J1R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261234AbUG0J1R (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 05:27:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261252AbUG0J0n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 05:26:43 -0400
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:65018 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S261234AbUG0J0R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 05:26:17 -0400
Date: Tue, 27 Jul 2004 05:29:47 -0400 (EDT)
From: Zwane Mwaikambo <zwane@fsmlabs.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>
Subject: [PATCH][2.6] Move PIT code to timer_pit
Message-ID: <Pine.LNX.4.58.0407270520060.23987@montezuma.fsmlabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Now that things got cleaned up a bit, there is no real reason why the pit
initialisation code has to be in i8259.c. Move it to it's final resting
place..

Signed-off-by: Zwane Mwaikambo <zwane@fsmlabs.com>

Index: linux-2.6.8-rc1-mm1-amd64/arch/i386/kernel/i8259.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.8-rc1-mm1/arch/i386/kernel/i8259.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 i8259.c
--- linux-2.6.8-rc1-mm1-amd64/arch/i386/kernel/i8259.c	14 Jul 2004 04:56:09 -0000	1.1.1.1
+++ linux-2.6.8-rc1-mm1-amd64/arch/i386/kernel/i8259.c	27 Jul 2004 09:23:10 -0000
@@ -4,7 +4,6 @@
 #include <linux/sched.h>
 #include <linux/ioport.h>
 #include <linux/interrupt.h>
-#include <linux/timex.h>
 #include <linux/slab.h>
 #include <linux/random.h>
 #include <linux/smp_lock.h>
@@ -12,6 +11,7 @@
 #include <linux/kernel_stat.h>
 #include <linux/sysdev.h>

+#include <asm/8253pit.h>
 #include <asm/atomic.h>
 #include <asm/system.h>
 #include <asm/io.h>
@@ -363,46 +363,6 @@ void __init init_ISA_irqs (void)
 	}
 }

-static void setup_timer(void)
-{
-	extern spinlock_t i8253_lock;
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
-
-static int timer_resume(struct sys_device *dev)
-{
-	setup_timer();
-	return 0;
-}
-
-static struct sysdev_class timer_sysclass = {
-	set_kset_name("timer"),
-	.resume	= timer_resume,
-};
-
-static struct sys_device device_timer = {
-	.id	= 0,
-	.cls	= &timer_sysclass,
-};
-
-static int __init init_timer_sysfs(void)
-{
-	int error = sysdev_class_register(&timer_sysclass);
-	if (!error)
-		error = sysdev_register(&device_timer);
-	return error;
-}
-
-device_initcall(init_timer_sysfs);
-
 void __init init_IRQ(void)
 {
 	int i;
@@ -434,7 +394,7 @@ void __init init_IRQ(void)
 	 * Set the clock to HZ Hz, we already have a valid
 	 * vector now:
 	 */
-	setup_timer();
+	setup_pit_timer();

 	/*
 	 * External FPU? Set up irq13 if so, for
Index: linux-2.6.8-rc1-mm1-amd64/arch/i386/kernel/timers/timer_pit.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.8-rc1-mm1/arch/i386/kernel/timers/timer_pit.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 timer_pit.c
--- linux-2.6.8-rc1-mm1-amd64/arch/i386/kernel/timers/timer_pit.c	14 Jul 2004 04:56:09 -0000	1.1.1.1
+++ linux-2.6.8-rc1-mm1-amd64/arch/i386/kernel/timers/timer_pit.c	27 Jul 2004 09:22:45 -0000
@@ -7,6 +7,9 @@
 #include <linux/module.h>
 #include <linux/device.h>
 #include <linux/irq.h>
+#include <linux/sysdev.h>
+#include <linux/timex.h>
+#include <asm/delay.h>
 #include <asm/mpspec.h>
 #include <asm/timer.h>
 #include <asm/smp.h>
@@ -156,3 +159,44 @@ struct timer_opts timer_pit = {
 	.monotonic_clock = monotonic_clock_pit,
 	.delay = delay_pit,
 };
+
+void setup_pit_timer(void)
+{
+	extern spinlock_t i8253_lock;
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
+	set_kset_name("timer"),
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
+
