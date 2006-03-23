Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932549AbWCWDG6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932549AbWCWDG6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 22:06:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932154AbWCWDGh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 22:06:37 -0500
Received: from e34.co.us.ibm.com ([32.97.110.152]:36526 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S932140AbWCWDG3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 22:06:29 -0500
Date: Wed, 22 Mar 2006 20:06:26 -0700
From: john stultz <johnstul@us.ibm.com>
To: akpm@osdl.org
Cc: john stultz <johnstul@us.ibm.com>, linux-kernel@vger.kernel.org,
       george@wildturkeyranch.net, Steven Rostedt <rostedt@goodmis.org>,
       Thomas Gleixner <tglx@linutronix.de>,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>,
       Roman Zippel <zippel@linux-m68k.org>, Ingo Molnar <mingo@elte.hu>,
       Paul Mackerras <paulus@samba.org>
Message-Id: <20060323030625.19338.95899.sendpatchset@cog.beaverton.ibm.com>
In-Reply-To: <20060323030547.19338.95102.sendpatchset@cog.beaverton.ibm.com>
References: <20060323030547.19338.95102.sendpatchset@cog.beaverton.ibm.com>
Subject: [PATCH 6/10] Time: i386 Conversion - part 1: Move timer_pit.c to i8253.c
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	This patch is just a simple cleanup for the i386 arch in 
preparation of moving to the generic timeofday infrastructure. It 
simply moves the PIT initialization code, locks, and other code we want 
to keep from some code from timer_pit.c (which will be removed) to 
i8253.c.

thanks
-john

Signed-off-by: John Stultz <johnstul@us.ibm.com>

 Makefile           |    2 +-
 i8253.c            |   32 ++++++++++++++++++++++++++++++++
 time.c             |    5 -----
 timers/timer_pit.c |   13 -------------
 4 files changed, 33 insertions(+), 19 deletions(-)

linux-2.6.16_timeofday-arch-i386-part1_C1.patch
============================================
diff --git a/arch/i386/kernel/Makefile b/arch/i386/kernel/Makefile
index 65656c0..687a29b 100644
--- a/arch/i386/kernel/Makefile
+++ b/arch/i386/kernel/Makefile
@@ -7,7 +7,7 @@ extra-y := head.o init_task.o vmlinux.ld
 obj-y	:= process.o semaphore.o signal.o entry.o traps.o irq.o \
 		ptrace.o time.o ioport.o ldt.o setup.o i8259.o sys_i386.o \
 		pci-dma.o i386_ksyms.o i387.o dmi_scan.o bootflag.o \
-		quirks.o i8237.o topology.o
+		quirks.o i8237.o i8253.o topology.o
 
 obj-y				+= cpu/
 obj-y				+= timers/
diff --git a/arch/i386/kernel/i8253.c b/arch/i386/kernel/i8253.c
new file mode 100644
index 0000000..29cb2eb
--- /dev/null
+++ b/arch/i386/kernel/i8253.c
@@ -0,0 +1,32 @@
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
diff --git a/arch/i386/kernel/time.c b/arch/i386/kernel/time.c
index 9d30747..796e5fa 100644
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
