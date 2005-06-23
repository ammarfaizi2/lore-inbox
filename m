Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261994AbVFWDBU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261994AbVFWDBU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 23:01:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261933AbVFWDBU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 23:01:20 -0400
Received: from fmr20.intel.com ([134.134.136.19]:10676 "EHLO
	orsfmr005.jf.intel.com") by vger.kernel.org with ESMTP
	id S261994AbVFWDA0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 23:00:26 -0400
Subject: [PATCH] add suspend/resume for timer
From: Shaohua Li <shaohua.li@intel.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: akpm <akpm@osdl.org>, Pavel Machek <pavel@ucw.cz>
Content-Type: text/plain
Date: Thu, 23 Jun 2005 11:09:46 +0800
Message-Id: <1119496186.3325.1.camel@linux-hp.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
The timers lack .suspend/.resume methods. Because of this, jiffies got a
big compensation after a S3 resume. And then softlockup watchdog reports
an oops. This occured with HPET enabled, but it's also possible for
other timers.
I know Linux will introduce a new timer core system, but it maybe take a
long time, so I send this patch to fix bugs at hand. If the new timer
system will be merged soon, please ignore this one.

Thanks,
Shaohua

Signed-off-by: Shaohua Li<shaohua.li@intel.com>

---

 linux-2.6.12-mm1-root/arch/i386/kernel/time.c              |   10 ++++
 linux-2.6.12-mm1-root/arch/i386/kernel/timers/timer_hpet.c |   14 ++++++
 linux-2.6.12-mm1-root/arch/i386/kernel/timers/timer_pit.c  |   27 -------------
 linux-2.6.12-mm1-root/arch/i386/kernel/timers/timer_pm.c   |    9 ++++
 linux-2.6.12-mm1-root/arch/i386/kernel/timers/timer_tsc.c  |   14 ++++++
 linux-2.6.12-mm1-root/include/asm-i386/timer.h             |    3 +
 6 files changed, 50 insertions(+), 27 deletions(-)

diff -puN include/asm-i386/timer.h~last_tick_fix include/asm-i386/timer.h
--- linux-2.6.12-mm1/include/asm-i386/timer.h~last_tick_fix	2005-06-22 10:02:05.000000000 +0800
+++ linux-2.6.12-mm1-root/include/asm-i386/timer.h	2005-06-22 10:02:05.000000000 +0800
@@ -1,6 +1,7 @@
 #ifndef _ASMi386_TIMER_H
 #define _ASMi386_TIMER_H
 #include <linux/init.h>
+#include <linux/pm.h>
 
 /**
  * struct timer_ops - used to define a timer source
@@ -23,6 +24,8 @@ struct timer_opts {
 	unsigned long long (*monotonic_clock)(void);
 	void (*delay)(unsigned long);
 	unsigned long (*read_timer)(void);
+	int (*suspend)(pm_message_t state);
+	int (*resume)(void);
 };
 
 struct init_timer_opts {
diff -puN arch/i386/kernel/timers/timer_hpet.c~last_tick_fix arch/i386/kernel/timers/timer_hpet.c
--- linux-2.6.12-mm1/arch/i386/kernel/timers/timer_hpet.c~last_tick_fix	2005-06-22 10:02:05.000000000 +0800
+++ linux-2.6.12-mm1-root/arch/i386/kernel/timers/timer_hpet.c	2005-06-23 10:29:51.294011992 +0800
@@ -177,6 +177,19 @@ static int __init init_hpet(char* overri
 	return 0;
 }
 
+static int hpet_resume(void)
+{
+	write_seqlock(&monotonic_lock);
+	/* Assume this is the last mark offset time */
+	rdtsc(last_tsc_low, last_tsc_high);
+
+	if (hpet_use_timer)
+		hpet_last = hpet_readl(HPET_T0_CMP) - hpet_tick;
+	else
+		hpet_last = hpet_readl(HPET_COUNTER);
+	write_sequnlock(&monotonic_lock);
+	return 0;
+}
 /************************************************************/
 
 /* tsc timer_opts struct */
@@ -187,6 +200,7 @@ static struct timer_opts timer_hpet __ca
 	.monotonic_clock =	monotonic_clock_hpet,
 	.delay = 		delay_hpet,
 	.read_timer = 		read_timer_tsc,
+	.resume	=		hpet_resume,
 };
 
 struct init_timer_opts __initdata timer_hpet_init = {
diff -puN arch/i386/kernel/timers/timer_pit.c~last_tick_fix arch/i386/kernel/timers/timer_pit.c
--- linux-2.6.12-mm1/arch/i386/kernel/timers/timer_pit.c~last_tick_fix	2005-06-22 10:02:05.000000000 +0800
+++ linux-2.6.12-mm1-root/arch/i386/kernel/timers/timer_pit.c	2005-06-22 10:02:05.000000000 +0800
@@ -177,30 +177,3 @@ void setup_pit_timer(void)
 	outb(LATCH >> 8 , PIT_CH0);	/* MSB */
 	spin_unlock_irqrestore(&i8253_lock, flags);
 }
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
diff -puN arch/i386/kernel/timers/timer_tsc.c~last_tick_fix arch/i386/kernel/timers/timer_tsc.c
--- linux-2.6.12-mm1/arch/i386/kernel/timers/timer_tsc.c~last_tick_fix	2005-06-22 10:02:05.000000000 +0800
+++ linux-2.6.12-mm1-root/arch/i386/kernel/timers/timer_tsc.c	2005-06-23 10:31:13.379533096 +0800
@@ -544,6 +544,19 @@ static int __init init_tsc(char* overrid
 	return -ENODEV;
 }
 
+static int tsc_resume(void)
+{
+	write_seqlock(&monotonic_lock);
+	/* Assume this is the last mark offset time */
+	rdtsc(last_tsc_low, last_tsc_high);
+#ifdef CONFIG_HPET_TIMER
+	if (is_hpet_enabled() && hpet_use_timer)
+		hpet_last = hpet_readl(HPET_COUNTER);
+#endif
+	write_sequnlock(&monotonic_lock);
+	return 0;
+}
+
 #ifndef CONFIG_X86_TSC
 /* disable flag for tsc.  Takes effect by clearing the TSC cpu flag
  * in cpu/common.c */
@@ -574,6 +587,7 @@ static struct timer_opts timer_tsc = {
 	.monotonic_clock = monotonic_clock_tsc,
 	.delay = delay_tsc,
 	.read_timer = read_timer_tsc,
+	.resume	= tsc_resume,
 };
 
 struct init_timer_opts __initdata timer_tsc_init = {
diff -puN arch/i386/kernel/timers/timer_pm.c~last_tick_fix arch/i386/kernel/timers/timer_pm.c
--- linux-2.6.12-mm1/arch/i386/kernel/timers/timer_pm.c~last_tick_fix	2005-06-22 10:02:05.000000000 +0800
+++ linux-2.6.12-mm1-root/arch/i386/kernel/timers/timer_pm.c	2005-06-23 10:31:54.412295168 +0800
@@ -186,6 +186,14 @@ static void mark_offset_pmtmr(void)
 	}
 }
 
+static int pmtmr_resume(void)
+{
+	write_seqlock(&monotonic_lock);
+	/* Assume this is the last mark offset time */
+	offset_tick = read_pmtmr();
+	write_sequnlock(&monotonic_lock);
+	return 0;
+}
 
 static unsigned long long monotonic_clock_pmtmr(void)
 {
@@ -247,6 +255,7 @@ static struct timer_opts timer_pmtmr = {
 	.monotonic_clock 	= monotonic_clock_pmtmr,
 	.delay 			= delay_pmtmr,
 	.read_timer 		= read_timer_tsc,
+	.resume			= pmtmr_resume,
 };
 
 struct init_timer_opts __initdata timer_pmtmr_init = {
diff -puN arch/i386/kernel/time.c~last_tick_fix arch/i386/kernel/time.c
--- linux-2.6.12-mm1/arch/i386/kernel/time.c~last_tick_fix	2005-06-22 10:02:05.000000000 +0800
+++ linux-2.6.12-mm1-root/arch/i386/kernel/time.c	2005-06-22 10:09:58.000000000 +0800
@@ -380,6 +380,7 @@ void notify_arch_cmos_timer(void)
 
 static long clock_cmos_diff, sleep_start;
 
+static struct timer_opts *last_timer;
 static int timer_suspend(struct sys_device *dev, pm_message_t state)
 {
 	/*
@@ -388,6 +389,10 @@ static int timer_suspend(struct sys_devi
 	clock_cmos_diff = -get_cmos_time();
 	clock_cmos_diff += get_seconds();
 	sleep_start = get_cmos_time();
+	last_timer = cur_timer;
+	cur_timer = &timer_none;
+	if (last_timer->suspend)
+		last_timer->suspend(state);
 	return 0;
 }
 
@@ -401,6 +406,7 @@ static int timer_resume(struct sys_devic
 	if (is_hpet_enabled())
 		hpet_reenable();
 #endif
+	setup_pit_timer();
 	sec = get_cmos_time() + clock_cmos_diff;
 	sleep_length = (get_cmos_time() - sleep_start) * HZ;
 	write_seqlock_irqsave(&xtime_lock, flags);
@@ -410,6 +416,10 @@ static int timer_resume(struct sys_devic
 	jiffies += sleep_length;
 	wall_jiffies += sleep_length;
 	touch_softlockup_watchdog();
+	if (last_timer->resume)
+		last_timer->resume();
+	cur_timer = last_timer;
+	last_timer = NULL;
 	return 0;
 }
 
_


