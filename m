Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262642AbUKXNQY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262642AbUKXNQY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 08:16:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262647AbUKXNPX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 08:15:23 -0500
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:48788 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S262642AbUKXNCG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 08:02:06 -0500
Subject: Suspend 2 merge: 20/51: Timer freezer (experimental).
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1101292194.5805.180.camel@desktop.cunninghams>
References: <1101292194.5805.180.camel@desktop.cunninghams>
Content-Type: text/plain
Message-Id: <1101295693.5805.268.camel@desktop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Wed, 24 Nov 2004 23:58:23 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's experimental support for freezing timers. It doesn't really
freeze them, but rather reschedules the call for a little later. One
issue I need to think about is staggering the invocations at resume
time, as some of the per CPU timer code seeks to do.

There is debugging code in here so that when it's used (it's off by
default at the moment), and a timer that needs to be no_freeze holds up
I/O, the user can find out what it is. Other code allows the timer
freezer to be disabled on the fly (so you don't have to reboot because
of this).

(This could replace the patches above for MCE checking and slab
reaping).

diff -ruN 550-timer-freezer-old/drivers/block/ll_rw_blk.c
550-timer-freezer-new/drivers/block/ll_rw_blk.c
--- 550-timer-freezer-old/drivers/block/ll_rw_blk.c	2004-11-24
17:55:30.776567832 +1100
+++ 550-timer-freezer-new/drivers/block/ll_rw_blk.c	2004-11-24
17:23:36.145077968 +1100
@@ -254,6 +254,7 @@
 
 	q->unplug_timer.function = blk_unplug_timeout;
 	q->unplug_timer.data = (unsigned long)q;
+	q->unplug_timer.no_freeze = 1;
 
 	/*
 	 * by default assume old behaviour and bounce for any highmem page
diff -ruN 550-timer-freezer-old/drivers/input/serio/i8042.c
550-timer-freezer-new/drivers/input/serio/i8042.c
--- 550-timer-freezer-old/drivers/input/serio/i8042.c	2004-11-24
09:52:58.000000000 +1100
+++ 550-timer-freezer-new/drivers/input/serio/i8042.c	2004-11-24
17:23:36.154076600 +1100
@@ -1039,6 +1039,7 @@
 	dbg_init();
 
 	init_timer(&i8042_timer);
+	i8042_timer.no_freeze = 1;
 	i8042_timer.function = i8042_timer_func;
 
 	if (i8042_platform_init())
diff -ruN 550-timer-freezer-old/include/linux/timer.h
550-timer-freezer-new/include/linux/timer.h
--- 550-timer-freezer-old/include/linux/timer.h	2004-11-03
21:54:17.000000000 +1100
+++ 550-timer-freezer-new/include/linux/timer.h	2004-11-24
17:23:36.169074320 +1100
@@ -19,6 +19,8 @@
 	unsigned long data;
 
 	struct tvec_t_base_s *base;
+
+	int no_freeze;
 };
 
 #define TIMER_MAGIC	0x4b87ad6e
diff -ruN 550-timer-freezer-old/kernel/timer.c
550-timer-freezer-new/kernel/timer.c
--- 550-timer-freezer-old/kernel/timer.c	2004-11-24 17:55:30.863554608
+1100
+++ 550-timer-freezer-new/kernel/timer.c	2004-11-24 17:55:22.021898744
+1100
@@ -31,6 +31,7 @@
 #include <linux/time.h>
 #include <linux/jiffies.h>
 #include <linux/cpu.h>
+#include <linux/suspend.h>
 #include <linux/syscalls.h>
 
 #include <asm/uaccess.h>
@@ -429,6 +430,9 @@
  */
 #define INDEX(N) (base->timer_jiffies >> (TVR_BITS + N * TVN_BITS)) &
TVN_MASK
 
+#define FN_CACHE_SIZE 15
+static void * recent_fns[FN_CACHE_SIZE];
+
 static inline void __run_timers(tvec_base_t *base)
 {
 	struct timer_list *timer;
@@ -463,7 +467,23 @@
 			smp_wmb();
 			timer->base = NULL;
 			spin_unlock_irq(&base->lock);
-			fn(data);
+			if (unlikely(test_suspend_state(SUSPEND_TIMER_FREEZER_ON) &&
(!timer->no_freeze))) {
+				int shown = 0, i, copy_start = 0;
+				for (i = 0; i < FN_CACHE_SIZE; i++)
+					if (fn == recent_fns[i]) {
+						shown = i + 1;
+						copy_start = i;
+						break;
+					}
+				for (i = copy_start; i < (FN_CACHE_SIZE - 1); i++)
+					recent_fns[i] = recent_fns[i+1];
+				recent_fns[FN_CACHE_SIZE - 1] = fn;
+				if (!shown) {
+					printk("Timed call of %p delayed while freezer on.\n", fn);
+				}
+				mod_timer(timer, jiffies + HZ);
+			} else
+				fn(data);
 			spin_lock_irq(&base->lock);
 			goto repeat;
 		}
diff -ruN 550-timer-freezer-old/net/sched/sch_generic.c
550-timer-freezer-new/net/sched/sch_generic.c
--- 550-timer-freezer-old/net/sched/sch_generic.c	2004-11-24
09:53:13.000000000 +1100
+++ 550-timer-freezer-new/net/sched/sch_generic.c	2004-11-24
17:23:36.189071280 +1100
@@ -210,6 +210,7 @@
 	init_timer(&dev->watchdog_timer);
 	dev->watchdog_timer.data = (unsigned long)dev;
 	dev->watchdog_timer.function = dev_watchdog;
+	dev->watchdog_timer.no_freeze = 1;
 }
 
 void __netdev_watchdog_up(struct net_device *dev)


