Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030421AbWHICaG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030421AbWHICaG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 22:30:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030422AbWHICaG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 22:30:06 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:12724 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1030421AbWHICaE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 22:30:04 -0400
Subject: [PATCH -mm] i386: Kill references to xtime
From: john stultz <johnstul@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>, sfr@canb.auug.org.au,
       Mikael Pettersson <mikpe@it.uu.se>, Ingo Molnar <mingo@elte.hu>
Content-Type: text/plain
Date: Tue, 08 Aug 2006 19:30:01 -0700
Message-Id: <1155090602.13030.93.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Time to get this in the pipe, hopefully for 2.6.19-rc1

Remove all references to xtime in i386 and replace them w/ 
get/set_timeofday(). Requires some ugly and uncertain changes to APM, 
but has been lightly tested to work.

Signed-off-by: John Stultz <johnstul@us.ibm.com>
Acked-by: Ingo Molnar <mingo@elte.hu>
Acked-by: Mikael Pettersson <mikpe@it.uu.se>


 apm.c  |   17 +++++------------
 time.c |   26 +++++++++++++++-----------
 2 files changed, 20 insertions(+), 23 deletions(-)

linux-2.6.18-rc4_timeofday-i386-xtime-removal_C5.patch
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
index edd00f6..6f333e7 100644
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


