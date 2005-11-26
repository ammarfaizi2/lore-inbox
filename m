Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964798AbVKZOyW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964798AbVKZOyW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Nov 2005 09:54:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964795AbVKZOyV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Nov 2005 09:54:21 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:24510 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S964794AbVKZOyT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Nov 2005 09:54:19 -0500
Date: Sat, 26 Nov 2005 15:54:25 +0100
From: Ingo Molnar <mingo@elte.hu>
To: john stultz <johnstul@us.ibm.com>
Cc: lkml <linux-kernel@vger.kernel.org>, Darren Hart <dvhltc@us.ibm.com>,
       Nishanth Aravamudan <nacc@us.ibm.com>,
       Frank Sorenson <frank@tuxrocks.com>,
       George Anzinger <george@mvista.com>,
       Roman Zippel <zippel@linux-m68k.org>,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>,
       Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 5/13] Time: i386 Conversion - part 1: Move timer_pit.c to i8253.c
Message-ID: <20051126145425.GG12999@elte.hu>
References: <20051122013515.18537.76463.sendpatchset@cog.beaverton.ibm.com> <20051122013548.18537.97737.sendpatchset@cog.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051122013548.18537.97737.sendpatchset@cog.beaverton.ibm.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -1.5
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-1.5 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	1.3 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


- clean up timeofday-arch-i386-part1.patch

Signed-off-by: Ingo Molnar <mingo@elte.hu>

 arch/i386/kernel/i8253.c |   29 +++++++++++++++++------------
 1 files changed, 17 insertions(+), 12 deletions(-)

Index: linux/arch/i386/kernel/i8253.c
===================================================================
--- linux.orig/arch/i386/kernel/i8253.c
+++ linux/arch/i386/kernel/i8253.c
@@ -2,12 +2,12 @@
  * i8253.c  8253/PIT functions
  *
  */
-#include <linux/init.h>
-#include <linux/jiffies.h>
+#include <linux/clocksource.h>
 #include <linux/spinlock.h>
+#include <linux/jiffies.h>
 #include <linux/sysdev.h>
-#include <linux/clocksource.h>
 #include <linux/module.h>
+#include <linux/init.h>
 
 #include <asm/delay.h>
 #include <asm/i8253.h>
@@ -34,6 +34,7 @@ void setup_pit_timer(void)
 static int timer_resume(struct sys_device *dev)
 {
 	setup_pit_timer();
+
 	return 0;
 }
 
@@ -50,19 +51,20 @@ static struct sys_device device_timer = 
 static int __init init_timer_sysfs(void)
 {
 	int error = sysdev_class_register(&timer_sysclass);
+
 	if (!error)
 		error = sysdev_register(&device_timer);
+
 	return error;
 }
 
 device_initcall(init_timer_sysfs);
 
-
-/* Since the PIT overflows every tick, its not very useful
+/*
+ * Since the PIT overflows every tick, its not very useful
  * to just read by itself. So use jiffies to emulate a free
- * running counter.
+ * running counter:
  */
-
 static cycle_t pit_read(void)
 {
 	unsigned long flags, seq;
@@ -85,6 +87,7 @@ static cycle_t pit_read(void)
 			count = LATCH - 1;
 		}
 		spin_unlock_irqrestore(&i8253_lock, flags);
+
 		jifs = jiffies_64;
 	} while (read_seqretry(&xtime_lock, seq));
 
@@ -95,21 +98,23 @@ static cycle_t pit_read(void)
 }
 
 static struct clocksource clocksource_pit = {
-	.name = "pit",
+	.name	= "pit",
 	.rating = 110,
-	.read = pit_read,
-	.mask = (cycle_t)-1,
-	.mult = 0,
-	.shift = 20,
+	.read	= pit_read,
+	.mask	= (cycle_t)-1,
+	.mult	= 0,
+	.shift	= 20,
 };
 
 static int __init init_pit_clocksource(void)
 {
+	/* TODO: bogus limit of 4 CPUs? --mingo */
 	if (num_possible_cpus() > 4) /* PIT does not scale! */
 		return 0;
 
 	clocksource_pit.mult = clocksource_hz2mult(CLOCK_TICK_RATE, 20);
 	register_clocksource(&clocksource_pit);
+
 	return 0;
 }
 module_init(init_pit_clocksource);
