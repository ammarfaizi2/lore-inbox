Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265919AbTF3WSx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jun 2003 18:18:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265920AbTF3WSx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jun 2003 18:18:53 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:3223 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S265919AbTF3WSs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jun 2003 18:18:48 -0400
Subject: [PATCH SET - 1/3] linux-2.5.73_rename-timer_A1
From: john stultz <johnstul@us.ibm.com>
To: Andrew Morton <akpm@digeo.com>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <1057011774.28320.340.camel@w-jstultz2.beaverton.ibm.com>
References: <1057011774.28320.340.camel@w-jstultz2.beaverton.ibm.com>
Content-Type: text/plain
Organization: 
Message-Id: <1057011840.28319.342.camel@w-jstultz2.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 30 Jun 2003 15:24:01 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	This patch is a modification to your rename-timer patch in 2.5.73-mm2
which renames the bad "timer" variable to "cur_timer" and moves externs
to the .h files. This revision removes the dependency on the
lost-tick-speedstep-fix patch, allowing these changes to land first. 
Please consider for inclusion in your tree.

thanks
-john

 arch/i386/kernel/io_apic.c      |    2 +-
 arch/i386/kernel/time.c         |   29 +++++++++++++----------------
 arch/i386/kernel/timers/timer.c |    6 ------
 arch/i386/lib/delay.c           |    2 +-
 include/asm-i386/timer.h        |   12 ++++++++++++
 5 files changed, 27 insertions(+), 24 deletions(-)



diff -Nru a/arch/i386/kernel/io_apic.c b/arch/i386/kernel/io_apic.c
--- a/arch/i386/kernel/io_apic.c	Mon Jun 30 13:38:44 2003
+++ b/arch/i386/kernel/io_apic.c	Mon Jun 30 13:38:44 2003
@@ -35,6 +35,7 @@
 #include <asm/io.h>
 #include <asm/smp.h>
 #include <asm/desc.h>
+#include <asm/timer.h>
 
 #include <mach_apic.h>
 
@@ -2052,7 +2053,6 @@
  */
 static inline void check_timer(void)
 {
-	extern int timer_ack;
 	int pin1, pin2;
 	int vector;
 
diff -Nru a/arch/i386/kernel/time.c b/arch/i386/kernel/time.c
--- a/arch/i386/kernel/time.c	Mon Jun 30 13:38:44 2003
+++ b/arch/i386/kernel/time.c	Mon Jun 30 13:38:44 2003
@@ -80,8 +80,7 @@
 spinlock_t i8253_lock = SPIN_LOCK_UNLOCKED;
 EXPORT_SYMBOL(i8253_lock);
 
-extern struct timer_opts timer_none;
-struct timer_opts* timer = &timer_none;
+struct timer_opts *cur_timer = &timer_none;
 
 /*
  * This version of gettimeofday has microsecond resolution
@@ -93,14 +92,14 @@
 	unsigned long usec, sec;
 
 	do {
+		unsigned long lost;
+
 		seq = read_seqbegin(&xtime_lock);
 
-		usec = timer->get_offset();
-		{
-			unsigned long lost = jiffies - wall_jiffies;
-			if (lost)
-				usec += lost * (1000000 / HZ);
-		}
+		usec = cur_timer->get_offset();
+		lost = jiffies - wall_jiffies;
+		if (lost)
+			usec += lost * (1000000 / HZ);
 		sec = xtime.tv_sec;
 		usec += (xtime.tv_nsec / 1000);
 	} while (read_seqretry(&xtime_lock, seq));
@@ -126,7 +125,7 @@
 	 * wall time.  Discover what correction gettimeofday() would have
 	 * made, and then undo it!
 	 */
-	tv->tv_nsec -= timer->get_offset() * NSEC_PER_USEC;
+	tv->tv_nsec -= cur_timer->get_offset() * NSEC_PER_USEC;
 	tv->tv_nsec -= (jiffies - wall_jiffies) * TICK_NSEC;
 
 	while (tv->tv_nsec < 0) {
@@ -180,7 +179,7 @@
  */
 unsigned long long monotonic_clock(void)
 {
-	return timer->monotonic_clock();
+	return cur_timer->monotonic_clock();
 }
 EXPORT_SYMBOL(monotonic_clock);
 
@@ -189,7 +188,8 @@
  * timer_interrupt() needs to keep up the real-time clock,
  * as well as call the "do_timer()" routine every clocktick
  */
-static inline void do_timer_interrupt(int irq, void *dev_id, struct pt_regs *regs)
+static inline void do_timer_interrupt(int irq, void *dev_id,
+					struct pt_regs *regs)
 {
 #ifdef CONFIG_X86_IO_APIC
 	if (timer_ack) {
@@ -259,7 +259,7 @@
 	 */
 	write_seqlock(&xtime_lock);
 
-	timer->mark_offset();
+	cur_timer->mark_offset();
  
 	do_timer_interrupt(irq, NULL, regs);
 
@@ -301,16 +301,13 @@
 
 device_initcall(time_init_device);
 
-
 void __init time_init(void)
 {
-	
 	xtime.tv_sec = get_cmos_time();
 	wall_to_monotonic.tv_sec = -xtime.tv_sec;
 	xtime.tv_nsec = (INITIAL_JIFFIES % HZ) * (NSEC_PER_SEC / HZ);
 	wall_to_monotonic.tv_nsec = -xtime.tv_nsec;
 
-
-	timer = select_timer();
+	cur_timer = select_timer();
 	time_init_hook();
 }
diff -Nru a/arch/i386/kernel/timers/timer.c b/arch/i386/kernel/timers/timer.c
--- a/arch/i386/kernel/timers/timer.c	Mon Jun 30 13:38:44 2003
+++ b/arch/i386/kernel/timers/timer.c	Mon Jun 30 13:38:44 2003
@@ -3,12 +3,6 @@
 #include <linux/string.h>
 #include <asm/timer.h>
 
-/* list of externed timers */
-extern struct timer_opts timer_pit;
-extern struct timer_opts timer_tsc;
-#ifdef CONFIG_X86_CYCLONE_TIMER
-extern struct timer_opts timer_cyclone;
-#endif
 /* list of timers, ordered by preference, NULL terminated */
 static struct timer_opts* timers[] = {
 #ifdef CONFIG_X86_CYCLONE_TIMER
diff -Nru a/arch/i386/lib/delay.c b/arch/i386/lib/delay.c
--- a/arch/i386/lib/delay.c	Mon Jun 30 13:38:44 2003
+++ b/arch/i386/lib/delay.c	Mon Jun 30 13:38:44 2003
@@ -25,7 +25,7 @@
 
 void __delay(unsigned long loops)
 {
-	timer->delay(loops);
+	cur_timer->delay(loops);
 }
 
 inline void __const_udelay(unsigned long xloops)
diff -Nru a/include/asm-i386/timer.h b/include/asm-i386/timer.h
--- a/include/asm-i386/timer.h	Mon Jun 30 13:38:44 2003
+++ b/include/asm-i386/timer.h	Mon Jun 30 13:38:44 2003
@@ -25,4 +25,16 @@
 /* Modifiers for buggy PIT handling */
 
 extern int pit_latch_buggy;
+
+extern struct timer_opts *cur_timer;
+extern int timer_ack;
+
+/* list of externed timers */
+extern struct timer_opts timer_none;
+extern struct timer_opts timer_pit;
+extern struct timer_opts timer_tsc;
+#ifdef CONFIG_X86_CYCLONE_TIMER
+extern struct timer_opts timer_cyclone;
+#endif
+
 #endif



