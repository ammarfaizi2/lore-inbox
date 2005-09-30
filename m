Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932503AbVI3As0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932503AbVI3As0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 20:48:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932482AbVI3As0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 20:48:26 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:30885 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S932471AbVI3AsF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 20:48:05 -0400
Subject: [RFC][PATCH 5/11] generic timeofday i386 arch specific changes,
	part 1
From: john stultz <johnstul@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Darren Hart <dvhltc@us.ibm.com>, Nishanth Aravamudan <nacc@us.ibm.com>,
       Frank Sorenson <frank@tuxrocks.com>,
       Thomas Gleixner <tglx@linutronix.de>,
       George Anzinger <george@mvista.com>,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>,
       Roman Zippel <zippel@linux-m68k.org>
In-Reply-To: <1128041188.8195.317.camel@cog.beaverton.ibm.com>
References: <1128040851.8195.307.camel@cog.beaverton.ibm.com>
	 <1128040939.8195.310.camel@cog.beaverton.ibm.com>
	 <1128041052.8195.312.camel@cog.beaverton.ibm.com>
	 <1128041118.8195.314.camel@cog.beaverton.ibm.com>
	 <1128041188.8195.317.camel@cog.beaverton.ibm.com>
Content-Type: text/plain
Date: Thu, 29 Sep 2005 17:48:02 -0700
Message-Id: <1128041282.8195.319.camel@cog.beaverton.ibm.com>
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
i8259.c.
	
It applies on top of my timeofday-core patch. This patch is part the
timeofday-arch-i386 patchset, so without the following parts it is not
expected to compile (although just this one should).
	

thanks
-john

 i8259.c            |   40 ++++++++++++++++++++++++++++++++++++++++
 time.c             |    1 -
 timers/timer_pit.c |   13 -------------
 3 files changed, 40 insertions(+), 14 deletions(-)

linux-2.6.14-rc2_timeofday-arch-i386-part1_B6.patch
============================================
diff --git a/arch/i386/kernel/i8259.c b/arch/i386/kernel/i8259.c
--- a/arch/i386/kernel/i8259.c
+++ b/arch/i386/kernel/i8259.c
@@ -23,6 +23,7 @@
 #include <asm/apic.h>
 #include <asm/arch_hooks.h>
 #include <asm/i8259.h>
+#include <asm/i8253.h>
 
 #include <io_ports.h>
 
@@ -396,6 +397,45 @@ void __init init_ISA_irqs (void)
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
diff --git a/arch/i386/kernel/time.c b/arch/i386/kernel/time.c
--- a/arch/i386/kernel/time.c
+++ b/arch/i386/kernel/time.c
@@ -404,7 +404,6 @@ static int timer_resume(struct sys_devic
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


