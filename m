Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751478AbWGMAaA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751478AbWGMAaA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 20:30:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751481AbWGMAaA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 20:30:00 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:15512 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751478AbWGMAaA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 20:30:00 -0400
Subject: [RFC][PATCH] Kill i386 references to xtime
From: john stultz <johnstul@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Roman Zippel <zippel@linux-m68k.org>, Ingo Molnar <mingo@elte.hu>,
       Thomas Gleixner <tglx@linutronix.de>, mikpe@it.uu.se
In-Reply-To: <1152749914.11963.33.camel@localhost.localdomain>
References: <1152749914.11963.33.camel@localhost.localdomain>
Content-Type: text/plain
Date: Wed, 12 Jul 2006 17:29:57 -0700
Message-Id: <1152750597.11963.43.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All,
	Just another cleanup patch from the C3 timekeeping tree (which you can
find here: http://sr71.net/~jstultz/tod/ ) I wanted to RFC.

This patch kills all xtime references in i386 and replaces them with
proper settimeofday()/gettimeofday() calls.

I'm not sure the APM changes are 100% right, as that code is very
muddled (take the i8253_lock before calling reinit_timer, which would
take the i8253_lock again and hang if it weren't ifdef'ed out!).

Anyway, testing, feedback or comments would be appreciated!

thanks
-john

 apm.c  |   17 +++++------------
 time.c |   26 +++++++++++++++-----------
 2 files changed, 20 insertions(+), 23 deletions(-)

linux-2.6.18-rc1_timeofday-i386-xtime-removal_C3.patch
============================================
diff --git a/arch/i386/kernel/apm.c b/arch/i386/kernel/apm.c
index 8591f2f..95dfa7c 100644
--- a/arch/i386/kernel/apm.c
+++ b/arch/i386/kernel/apm.c
@@ -1154,9 +1154,11 @@ out:
 
 static void set_time(void)
 {
+	struct timespec ts;
 	if (got_clock_diff) {	/* Must know time zone in order to set clock */
-		xtime.tv_sec = get_cmos_time() + clock_cmos_diff;
-		xtime.tv_nsec = 0; 
+		ts.tv_sec = get_cmos_time() + clock_cmos_diff;
+		ts.tv_nsec = 0;
+		do_settimeofday(&ts);
 	} 
 }
 
@@ -1232,13 +1234,8 @@ static int suspend(int vetoable)
 	restore_processor_state();
 
 	local_irq_disable();
-	write_seqlock(&xtime_lock);
-	spin_lock(&i8253_lock);
-	reinit_timer();
 	set_time();
-
-	spin_unlock(&i8253_lock);
-	write_sequnlock(&xtime_lock);
+	reinit_timer();
 
 	if (err == APM_NO_ERROR)
 		err = APM_SUCCESS;
@@ -1365,9 +1362,7 @@ static void check_events(void)
 			ignore_bounce = 1;
 			if ((event != APM_NORMAL_RESUME)
 			    || (ignore_normal_resume == 0)) {
-				write_seqlock_irq(&xtime_lock);
 				set_time();
-				write_sequnlock_irq(&xtime_lock);
 				device_resume();
 				pm_send_all(PM_RESUME, (void *)0);
 				queue_event(event, NULL);
@@ -1383,9 +1378,7 @@ static void check_events(void)
 			break;
 
 		case APM_UPDATE_TIME:
-			write_seqlock_irq(&xtime_lock);
 			set_time();
-			write_sequnlock_irq(&xtime_lock);
 			break;
 
 		case APM_CRITICAL_SUSPEND:
diff --git a/arch/i386/kernel/time.c b/arch/i386/kernel/time.c
index 8705c0f..1e14ba6 100644
--- a/arch/i386/kernel/time.c
+++ b/arch/i386/kernel/time.c
@@ -288,7 +288,7 @@ static int timer_resume(struct sys_devic
 	unsigned long flags;
 	unsigned long sec;
 	unsigned long sleep_length;
-
+	struct timespec ts;
 #ifdef CONFIG_HPET_TIMER
 	if (is_hpet_enabled())
 		hpet_reenable();
@@ -296,9 +296,11 @@ static int timer_resume(struct sys_devic
 	setup_pit_timer();
 	sec = get_cmos_time() + clock_cmos_diff;
 	sleep_length = (get_cmos_time() - sleep_start) * HZ;
+
+	ts.tv_sec = sec;
+	ts.tv_nsec = 0;
+	do_settimeofday(&ts);
 	write_seqlock_irqsave(&xtime_lock, flags);
-	xtime.tv_sec = sec;
-	xtime.tv_nsec = 0;
 	jiffies_64 += sleep_length;
 	wall_jiffies += sleep_length;
 	write_sequnlock_irqrestore(&xtime_lock, flags);
@@ -334,10 +336,11 @@ extern void (*late_time_init)(void);
 /* Duplicate of time_init() below, with hpet_enable part added */
 static void __init hpet_time_init(void)
 {
-	xtime.tv_sec = get_cmos_time();
-	xtime.tv_nsec = (INITIAL_JIFFIES % HZ) * (NSEC_PER_SEC / HZ);
-	set_normalized_timespec(&wall_to_monotonic,
-		-xtime.tv_sec, -xtime.tv_nsec);
+	struct timespec ts;
+	ts.tv_sec = get_cmos_time();
+	ts.tv_nsec = (INITIAL_JIFFIES % HZ) * (NSEC_PER_SEC / HZ);
+
+	do_settimeofday(&ts);
 
 	if ((hpet_enable() >= 0) && hpet_use_timer) {
 		printk("Using HPET for base-timer\n");
@@ -349,6 +352,7 @@ static void __init hpet_time_init(void)
 
 void __init time_init(void)
 {
+	struct timespec ts;
 #ifdef CONFIG_HPET_TIMER
 	if (is_hpet_capable()) {
 		/*
@@ -359,10 +363,10 @@ void __init time_init(void)
 		return;
 	}
 #endif
-	xtime.tv_sec = get_cmos_time();
-	xtime.tv_nsec = (INITIAL_JIFFIES % HZ) * (NSEC_PER_SEC / HZ);
-	set_normalized_timespec(&wall_to_monotonic,
-		-xtime.tv_sec, -xtime.tv_nsec);
+	ts.tv_sec = get_cmos_time();
+	ts.tv_nsec = (INITIAL_JIFFIES % HZ) * (NSEC_PER_SEC / HZ);
+
+	do_settimeofday(&ts);
 
 	time_init_hook();
 }


