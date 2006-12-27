Return-Path: <linux-kernel-owner+w=401wt.eu-S964781AbWL0R3w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964781AbWL0R3w (ORCPT <rfc822;w@1wt.eu>);
	Wed, 27 Dec 2006 12:29:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964776AbWL0R3w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Dec 2006 12:29:52 -0500
Received: from homer.mvista.com ([63.81.120.158]:55729 "EHLO
	dwalker1.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751301AbWL0R3s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Dec 2006 12:29:48 -0500
Message-Id: <20061227172828.998757000@mvista.com>
User-Agent: quilt/0.45-1
Date: Wed, 27 Dec 2006 09:28:29 -0800
From: Daniel Walker <dwalker@mvista.com>
To: mingo@elte.hu
CC: linux-kernel@vger.kernel.org
CC: Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH -rt] disconnect warp check from hrtimers
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

These calls were getting inconsistent wrt. the xtime_lock. The xtime_lock should
be held when doing the warp check update, and interrupts should be off.

In some places the warp update was getting called twice, once under the xtime_lock
then again right outside the xtime_lock.

Signed-Off-By: Daniel Walker <dwalker@mvista.com>

---
 include/linux/hrtimer.h |    2 +-
 kernel/hrtimer.c        |    2 --
 kernel/time/ntp.c       |    2 ++
 kernel/timer.c          |    1 +
 4 files changed, 4 insertions(+), 3 deletions(-)

Index: linux-2.6.19/include/linux/hrtimer.h
===================================================================
--- linux-2.6.19.orig/include/linux/hrtimer.h
+++ linux-2.6.19/include/linux/hrtimer.h
@@ -262,7 +262,7 @@ static inline ktime_t hrtimer_cb_get_tim
  * is expired in the next softirq when the clock was advanced.
  * (we still call the warp-check debugging code)
  */
-static inline void clock_was_set(void) { warp_check_clock_was_changed(); }
+static inline void clock_was_set(void) { }
 static inline void hrtimer_clock_notify(void) { }
 
 /*
Index: linux-2.6.19/kernel/hrtimer.c
===================================================================
--- linux-2.6.19.orig/kernel/hrtimer.c
+++ linux-2.6.19/kernel/hrtimer.c
@@ -452,8 +452,6 @@ static void retrigger_next_event(void *a
  */
 void clock_was_set(void)
 {
-	warp_check_clock_was_changed();
-
 	/* Retrigger the CPU local events everywhere */
 	on_each_cpu(retrigger_next_event, NULL, 0, 1);
 }
Index: linux-2.6.19/kernel/time/ntp.c
===================================================================
--- linux-2.6.19.orig/kernel/time/ntp.c
+++ linux-2.6.19/kernel/time/ntp.c
@@ -116,6 +116,7 @@ void second_overflow(void)
 			 */
 			time_interpolator_update(-NSEC_PER_SEC);
 			time_state = TIME_OOP;
+			warp_check_clock_was_changed();
 			clock_was_set();
 			printk(KERN_NOTICE "Clock: inserting leap second "
 					"23:59:60 UTC\n");
@@ -131,6 +132,7 @@ void second_overflow(void)
 			 */
 			time_interpolator_update(NSEC_PER_SEC);
 			time_state = TIME_WAIT;
+			warp_check_clock_was_changed();
 			clock_was_set();
 			printk(KERN_NOTICE "Clock: deleting leap second "
 					"23:59:59 UTC\n");
Index: linux-2.6.19/kernel/timer.c
===================================================================
--- linux-2.6.19.orig/kernel/timer.c
+++ linux-2.6.19/kernel/timer.c
@@ -1162,6 +1162,7 @@ static int timekeeping_resume(struct sys
 	clock->cycle_last = clocksource_read(clock);
 	clock->error = 0;
 	timekeeping_suspended = 0;
+	warp_check_clock_was_changed();
 	write_sequnlock_irqrestore(&xtime_lock, flags);
 
 	hrtimer_notify_resume();
--
