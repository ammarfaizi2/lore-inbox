Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422800AbWI3ANL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422800AbWI3ANL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 20:13:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932360AbWI3AMo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 20:12:44 -0400
Received: from www.osadl.org ([213.239.205.134]:1428 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S932364AbWI3AD7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 20:03:59 -0400
Message-Id: <20060929234439.158061000@cruncher.tec.linutronix.de>
References: <20060929234435.330586000@cruncher.tec.linutronix.de>
Date: Fri, 29 Sep 2006 23:58:22 -0000
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Jim Gettys <jg@laptop.org>, John Stultz <johnstul@us.ibm.com>,
       David Woodhouse <dwmw2@infradead.org>,
       Arjan van de Ven <arjan@infradead.org>, Dave Jones <davej@redhat.com>
Subject: [patch 03/23] GTOD: persistent clock support, i386
Content-Disposition: inline;
	filename=linux-2.6.18-rc6_timeofday-persistent-clock-i386_C6.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: John Stultz <johnstul@us.ibm.com>

persistent clock support: do proper timekeeping across suspend/resume,
i386 arch support.

Signed-off-by: John Stultz <johnstul@us.ibm.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@elte.hu>
--
 arch/i386/kernel/apm.c  |   44 ---------------------------------------
 arch/i386/kernel/time.c |   54 +-----------------------------------------------
 2 files changed, 2 insertions(+), 96 deletions(-)

linux-2.6.18-rc6_timeofday-persistent-clock-i386_C6.patch
Index: linux-2.6.18-mm2/arch/i386/kernel/apm.c
===================================================================
--- linux-2.6.18-mm2.orig/arch/i386/kernel/apm.c	2006-09-30 01:41:14.000000000 +0200
+++ linux-2.6.18-mm2/arch/i386/kernel/apm.c	2006-09-30 01:41:15.000000000 +0200
@@ -234,7 +234,6 @@
 
 #include "io_ports.h"
 
-extern unsigned long get_cmos_time(void);
 extern void machine_real_restart(unsigned char *, int);
 
 #if defined(CONFIG_APM_DISPLAY_BLANK) && defined(CONFIG_VT)
@@ -1153,28 +1152,6 @@ out:
 	spin_unlock(&user_list_lock);
 }
 
-static void set_time(void)
-{
-	struct timespec ts;
-	if (got_clock_diff) {	/* Must know time zone in order to set clock */
-		ts.tv_sec = get_cmos_time() + clock_cmos_diff;
-		ts.tv_nsec = 0;
-		do_settimeofday(&ts);
-	} 
-}
-
-static void get_time_diff(void)
-{
-#ifndef CONFIG_APM_RTC_IS_GMT
-	/*
-	 * Estimate time zone so that set_time can update the clock
-	 */
-	clock_cmos_diff = -get_cmos_time();
-	clock_cmos_diff += get_seconds();
-	got_clock_diff = 1;
-#endif
-}
-
 static void reinit_timer(void)
 {
 #ifdef INIT_TIMER_AFTER_SUSPEND
@@ -1214,19 +1191,6 @@ static int suspend(int vetoable)
 	local_irq_disable();
 	device_power_down(PMSG_SUSPEND);
 
-	/* serialize with the timer interrupt */
-	write_seqlock(&xtime_lock);
-
-	/* protect against access to timer chip registers */
-	spin_lock(&i8253_lock);
-
-	get_time_diff();
-	/*
-	 * Irq spinlock must be dropped around set_system_power_state.
-	 * We'll undo any timer changes due to interrupts below.
-	 */
-	spin_unlock(&i8253_lock);
-	write_sequnlock(&xtime_lock);
 	local_irq_enable();
 
 	save_processor_state();
@@ -1235,7 +1199,6 @@ static int suspend(int vetoable)
 	restore_processor_state();
 
 	local_irq_disable();
-	set_time();
 	reinit_timer();
 
 	if (err == APM_NO_ERROR)
@@ -1265,11 +1228,6 @@ static void standby(void)
 
 	local_irq_disable();
 	device_power_down(PMSG_SUSPEND);
-	/* serialize with the timer interrupt */
-	write_seqlock(&xtime_lock);
-	/* If needed, notify drivers here */
-	get_time_diff();
-	write_sequnlock(&xtime_lock);
 	local_irq_enable();
 
 	err = set_system_power_state(APM_STATE_STANDBY);
@@ -1363,7 +1321,6 @@ static void check_events(void)
 			ignore_bounce = 1;
 			if ((event != APM_NORMAL_RESUME)
 			    || (ignore_normal_resume == 0)) {
-				set_time();
 				device_resume();
 				pm_send_all(PM_RESUME, (void *)0);
 				queue_event(event, NULL);
@@ -1379,7 +1336,6 @@ static void check_events(void)
 			break;
 
 		case APM_UPDATE_TIME:
-			set_time();
 			break;
 
 		case APM_CRITICAL_SUSPEND:
Index: linux-2.6.18-mm2/arch/i386/kernel/time.c
===================================================================
--- linux-2.6.18-mm2.orig/arch/i386/kernel/time.c	2006-09-30 01:41:14.000000000 +0200
+++ linux-2.6.18-mm2/arch/i386/kernel/time.c	2006-09-30 01:41:15.000000000 +0200
@@ -216,7 +216,7 @@ irqreturn_t timer_interrupt(int irq, voi
 }
 
 /* not static: needed by APM */
-unsigned long get_cmos_time(void)
+unsigned long read_persistent_clock(void)
 {
 	unsigned long retval;
 	unsigned long flags;
@@ -232,7 +232,7 @@ unsigned long get_cmos_time(void)
 
 	return retval;
 }
-EXPORT_SYMBOL(get_cmos_time);
+EXPORT_SYMBOL(read_persistent_clock);
 
 static void sync_cmos_clock(unsigned long dummy);
 
@@ -283,58 +283,19 @@ void notify_arch_cmos_timer(void)
 	mod_timer(&sync_cmos_timer, jiffies + 1);
 }
 
-static long clock_cmos_diff;
-static unsigned long sleep_start;
-
-static int timer_suspend(struct sys_device *dev, pm_message_t state)
-{
-	/*
-	 * Estimate time zone so that set_time can update the clock
-	 */
-	unsigned long ctime =  get_cmos_time();
-
-	clock_cmos_diff = -ctime;
-	clock_cmos_diff += get_seconds();
-	sleep_start = ctime;
-	return 0;
-}
-
 static int timer_resume(struct sys_device *dev)
 {
-	unsigned long flags;
-	unsigned long sec;
-	unsigned long ctime = get_cmos_time();
-	long sleep_length = (ctime - sleep_start) * HZ;
-	struct timespec ts;
-
-	if (sleep_length < 0) {
-		printk(KERN_WARNING "CMOS clock skew detected in timer resume!\n");
-		/* The time after the resume must not be earlier than the time
-		 * before the suspend or some nasty things will happen
-		 */
-		sleep_length = 0;
-		ctime = sleep_start;
-	}
 #ifdef CONFIG_HPET_TIMER
 	if (is_hpet_enabled())
 		hpet_reenable();
 #endif
 	setup_pit_timer();
 
-	sec = ctime + clock_cmos_diff;
-	ts.tv_sec = sec;
-	ts.tv_nsec = 0;
-	do_settimeofday(&ts);
-	write_seqlock_irqsave(&xtime_lock, flags);
-	jiffies_64 += sleep_length;
-	write_sequnlock_irqrestore(&xtime_lock, flags);
-	touch_softlockup_watchdog();
 	return 0;
 }
 
 static struct sysdev_class timer_sysclass = {
 	.resume = timer_resume,
-	.suspend = timer_suspend,
 	set_kset_name("timer"),
 };
 
@@ -360,12 +321,6 @@ extern void (*late_time_init)(void);
 /* Duplicate of time_init() below, with hpet_enable part added */
 static void __init hpet_time_init(void)
 {
-	struct timespec ts;
-	ts.tv_sec = get_cmos_time();
-	ts.tv_nsec = (INITIAL_JIFFIES % HZ) * (NSEC_PER_SEC / HZ);
-
-	do_settimeofday(&ts);
-
 	if ((hpet_enable() >= 0) && hpet_use_timer) {
 		printk("Using HPET for base-timer\n");
 	}
@@ -376,7 +331,6 @@ static void __init hpet_time_init(void)
 
 void __init time_init(void)
 {
-	struct timespec ts;
 #ifdef CONFIG_HPET_TIMER
 	if (is_hpet_capable()) {
 		/*
@@ -387,10 +341,6 @@ void __init time_init(void)
 		return;
 	}
 #endif
-	ts.tv_sec = get_cmos_time();
-	ts.tv_nsec = (INITIAL_JIFFIES % HZ) * (NSEC_PER_SEC / HZ);
-
-	do_settimeofday(&ts);
 
 	time_init_hook();
 }

--

