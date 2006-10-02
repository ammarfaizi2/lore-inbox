Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965465AbWJBWDn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965465AbWJBWDn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 18:03:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965469AbWJBWDn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 18:03:43 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:10625 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S965465AbWJBWDl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 18:03:41 -0400
Subject: Re: [patch 03/23] GTOD: persistent clock support, i386
From: john stultz <johnstul@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>, Jim Gettys <jg@laptop.org>,
       David Woodhouse <dwmw2@infradead.org>,
       Arjan van de Ven <arjan@infradead.org>, Dave Jones <davej@redhat.com>
In-Reply-To: <20060930013612.92e12313.akpm@osdl.org>
References: <20060929234435.330586000@cruncher.tec.linutronix.de>
	 <20060929234439.158061000@cruncher.tec.linutronix.de>
	 <20060930013612.92e12313.akpm@osdl.org>
Content-Type: text/plain
Date: Mon, 02 Oct 2006 15:03:37 -0700
Message-Id: <1159826617.27968.22.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-09-30 at 01:36 -0700, Andrew Morton wrote:
> On Fri, 29 Sep 2006 23:58:22 -0000
> Thomas Gleixner <tglx@linutronix.de> wrote:
> 
> > persistent clock support: do proper timekeeping across suspend/resume,
> > i386 arch support.
> > 
> 
> This description implies that the patch implements something for i386

> >  arch/i386/kernel/apm.c  |   44 ---------------------------------------
> >  arch/i386/kernel/time.c |   54 +---------------------------------------------
> 
> but all it does is delete stuff.

Improved description included.


> I _assume_ that it switches i386 over to using the (undescribed) generic
> core, and it does that merely by implementing read_persistent_clock().
> 
> But I'd have expected to see some Kconfig change in there as well?

Since there is a generic weak read_persistent_clock function, all that
is needed is for an arch to implement the read_persistent_clock function
and remove its arch specific suspend/resume code.

> Does this implementation support all forms of persistent clock which are
> known to exist on i386 platforms?

Yep. It converts the read_cmos_clock() function, which covers legacy
CMOS and EFI clocks.

> If/when you issue new changelogs, please describe what has to be done to
> port other architectures over to use this overall framework.

Included below.

> Do ports for other architectures exist?

I made a quick attempt earlier and covered most of the arches. However,
I'm sort of wrapping this up w/ the generic time conversion (it was one
of the changes I dropped in the GTOD rework earlier this year). I was
going to re-add this later, but then Thomas started seeing resume
ordering issues w/ the dynticks patch, so I raised the patches again.

Updated patch below:

thanks
-john


Convert i386's read_cmos_clock to the read_persistent_clock interface 
and remove the arch specific suspend/resume code, as the generic 
timekeeping code will now handle it.

If you wish to convert your arch to the read_persistent_clock code:
1) Implement read_persistent_clock in your arch.
2) Kill off xtime and jiffies modification in arch specific
initialization and suspend/resume.


Signed-off-by: John Stultz <johnstul@us.ibm.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@elte.hu>
Signed-off-by: John Stultz <johnstul@us.ibm.com>
--

 apm.c  |   43 -------------------------------------------
 time.c |   55 ++-----------------------------------------------------
 2 files changed, 2 insertions(+), 96 deletions(-)

linux-2.6.18_timeofday-persistent-clock-i386_C7.patch
============================================
diff --git a/arch/i386/kernel/apm.c b/arch/i386/kernel/apm.c
index b42f2d9..e40e7ef 100644
--- a/arch/i386/kernel/apm.c
+++ b/arch/i386/kernel/apm.c
@@ -1153,28 +1153,6 @@ out:
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
@@ -1214,19 +1192,6 @@ static int suspend(int vetoable)
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
@@ -1235,7 +1200,6 @@ static int suspend(int vetoable)
 	restore_processor_state();
 
 	local_irq_disable();
-	set_time();
 	reinit_timer();
 
 	if (err == APM_NO_ERROR)
@@ -1265,11 +1229,6 @@ static void standby(void)
 
 	local_irq_disable();
 	device_power_down(PMSG_SUSPEND);
-	/* serialize with the timer interrupt */
-	write_seqlock(&xtime_lock);
-	/* If needed, notify drivers here */
-	get_time_diff();
-	write_sequnlock(&xtime_lock);
 	local_irq_enable();
 
 	err = set_system_power_state(APM_STATE_STANDBY);
@@ -1363,7 +1322,6 @@ static void check_events(void)
 			ignore_bounce = 1;
 			if ((event != APM_NORMAL_RESUME)
 			    || (ignore_normal_resume == 0)) {
-				set_time();
 				device_resume();
 				pm_send_all(PM_RESUME, (void *)0);
 				queue_event(event, NULL);
@@ -1379,7 +1337,6 @@ static void check_events(void)
 			break;
 
 		case APM_UPDATE_TIME:
-			set_time();
 			break;
 
 		case APM_CRITICAL_SUSPEND:
diff --git a/arch/i386/kernel/time.c b/arch/i386/kernel/time.c
index 58a2d55..e43fe9a 100644
--- a/arch/i386/kernel/time.c
+++ b/arch/i386/kernel/time.c
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
-
-	sec = ctime + clock_cmos_diff;
-	ts.tv_sec = sec;
-	ts.tv_nsec = 0;
-	do_settimeofday(&ts);
-	write_seqlock_irqsave(&xtime_lock, flags);
-	jiffies_64 += sleep_length;
-	write_sequnlock_irqrestore(&xtime_lock, flags);
 	touch_softlockup_watchdog();
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
@@ -387,10 +341,5 @@ void __init time_init(void)
 		return;
 	}
 #endif
-	ts.tv_sec = get_cmos_time();
-	ts.tv_nsec = (INITIAL_JIFFIES % HZ) * (NSEC_PER_SEC / HZ);
-
-	do_settimeofday(&ts);
-
 	time_init_hook();
 }



