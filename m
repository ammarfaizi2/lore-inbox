Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262216AbVGPD3v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262216AbVGPD3v (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Jul 2005 23:29:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262169AbVGPD0k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Jul 2005 23:26:40 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:64712 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S262193AbVGPD0X
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Jul 2005 23:26:23 -0400
Subject: [PATCH 2/7] new timeofday i386 arch specific changes, part 1 (v.
	B4)
From: john stultz <johnstul@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: George Anzinger <george@mvista.com>,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>,
       Christoph Lameter <clameter@sgi.com>, frank@tuxrocks.com,
       benh@kernel.crashing.org, Nishanth Aravamudan <nacc@us.ibm.com>
In-Reply-To: <1121484326.28999.3.camel@cog.beaverton.ibm.com>
References: <1121484326.28999.3.camel@cog.beaverton.ibm.com>
Content-Type: text/plain
Date: Fri, 15 Jul 2005 20:26:16 -0700
Message-Id: <1121484376.28999.4.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All,
	The conversion of i386 to use the new timeofday subsystem has been
split into 4 parts. This patch, the first of four, is just a simple
cleanup for the i386 arch in preperation of moving the the new timeofday
infrastructure. It simply moves some code from timer_pit.c to i8259.c.
	
It applies on top of my timeofday-core patch. This patch is part the
timeofday-arch-i386 patchset, so without the following parts it is not
expected to compile (although just this one should).
	
thanks
-john

linux-2.6.13-rc3_timeofday-arch-i386-part1_B4.patch
============================================
diff --git a/arch/i386/kernel/i8259.c b/arch/i386/kernel/i8259.c
--- a/arch/i386/kernel/i8259.c
+++ b/arch/i386/kernel/i8259.c
@@ -24,6 +24,7 @@
 #include <asm/apic.h>
 #include <asm/arch_hooks.h>
 #include <asm/i8259.h>
+#include <asm/i8253.h>
 
 #include <linux/irq.h>
 
@@ -399,6 +400,45 @@ void __init init_ISA_irqs (void)
 	}
 }
 
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
+
 void __init init_IRQ(void)
 {
 	int i;
diff --git a/arch/i386/kernel/timers/timer_pit.c b/arch/i386/kernel/timers/timer_pit.c
--- a/arch/i386/kernel/timers/timer_pit.c
+++ b/arch/i386/kernel/timers/timer_pit.c
@@ -162,43 +162,3 @@ struct init_timer_opts __initdata timer_
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
-
-static int timer_resume(struct sys_device *dev)
-{
-	setup_pit_timer();
-	return 0;
-}
-
-static struct sysdev_class timer_sysclass = {
-	set_kset_name("timer_pit"),
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


