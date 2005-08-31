Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964901AbVHaR1b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964901AbVHaR1b (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 13:27:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964902AbVHaR1b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 13:27:31 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:18398 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S964901AbVHaR1a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 13:27:30 -0400
Date: Wed, 31 Aug 2005 22:57:04 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: arjan@infradead.org, s0348365@sms.ed.ac.uk, kernel@kolivas.org,
       tytso@mit.edu, cfriesen@nortel.com, rlrevell@joe-job.com, trenn@suse.de,
       george@mvista.com, johnstul@us.ibm.com, akpm@osdl.org
Subject: [PATCH 3/3] Updated dynamic tick patches - Recover walltime upon wakeup
Message-ID: <20050831172704.GD4974@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <20050831165843.GA4974@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050831165843.GA4974@in.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 31, 2005 at 10:28:43PM +0530, Srivatsa Vaddagiri wrote:
> Following patches related to dynamic tick are posted in separate mails,
> for convenience of review. The first patch probably applies w/o dynamic
> tick consideration also.
> 
> Patch 3/3  -> Use lost tick information in dyn-tick time recovery 

This patch uses the lost tick information returned by mark_offset()
function in dyn-tick, to recover time.


---

 arch/i386/Kconfig                                                 |    0 
 linux-2.6.13-rc6-mm2-root/arch/i386/kernel/dyn-tick.c             |   11 ++++++--
 linux-2.6.13-rc6-mm2-root/arch/i386/kernel/time.c                 |   13 ++++++----
 linux-2.6.13-rc6-mm2-root/arch/i386/kernel/timers/timer_cyclone.c |    4 ++-
 linux-2.6.13-rc6-mm2-root/arch/i386/kernel/timers/timer_hpet.c    |    4 ++-
 linux-2.6.13-rc6-mm2-root/arch/i386/kernel/timers/timer_none.c    |    3 +-
 linux-2.6.13-rc6-mm2-root/arch/i386/kernel/timers/timer_pit.c     |    3 +-
 linux-2.6.13-rc6-mm2-root/arch/i386/kernel/timers/timer_pm.c      |    6 +++-
 linux-2.6.13-rc6-mm2-root/arch/i386/kernel/timers/timer_tsc.c     |   12 ++++++---
 linux-2.6.13-rc6-mm2-root/include/asm-i386/timer.h                |    2 -
 10 files changed, 40 insertions(+), 18 deletions(-)

diff -puN include/asm-i386/timer.h~drift_fix include/asm-i386/timer.h
--- linux-2.6.13-rc6-mm2/include/asm-i386/timer.h~drift_fix	2005-08-31 16:36:17.000000000 +0530
+++ linux-2.6.13-rc6-mm2-root/include/asm-i386/timer.h	2005-08-31 16:36:30.000000000 +0530
@@ -19,7 +19,7 @@
  */
 struct timer_opts {
 	char* name;
-	void (*mark_offset)(void);
+	int (*mark_offset)(void);
 	unsigned long (*get_offset)(void);
 	unsigned long long (*monotonic_clock)(void);
 	void (*delay)(unsigned long);
diff -puN arch/i386/kernel/time.c~drift_fix arch/i386/kernel/time.c
--- linux-2.6.13-rc6-mm2/arch/i386/kernel/time.c~drift_fix	2005-08-31 16:36:17.000000000 +0530
+++ linux-2.6.13-rc6-mm2-root/arch/i386/kernel/time.c	2005-08-31 16:36:30.000000000 +0530
@@ -253,7 +253,7 @@ EXPORT_SYMBOL(profile_pc);
  * timer_interrupt() needs to keep up the real-time clock,
  * as well as call the "do_timer()" routine every clocktick
  */
-static inline void do_timer_interrupt(int irq, struct pt_regs *regs)
+static inline void do_timer_interrupt(int irq, struct pt_regs *regs, int lost)
 {
 #ifdef CONFIG_X86_IO_APIC
 	if (timer_ack) {
@@ -271,7 +271,8 @@ static inline void do_timer_interrupt(in
 	}
 #endif
 
-	do_timer_interrupt_hook(regs);
+	if (!dyn_tick_enabled() || lost)
+		do_timer_interrupt_hook(regs);
 
 
 	if (MCA_bus) {
@@ -296,6 +297,8 @@ static inline void do_timer_interrupt(in
  */
 irqreturn_t timer_interrupt(int irq, void *dev_id, struct pt_regs *regs)
 {
+	int lost;
+
 	/*
 	 * Here we are in the timer irq handler. We just have irqs locally
 	 * disabled but we don't know if the timer_bh is running on the other
@@ -305,9 +308,9 @@ irqreturn_t timer_interrupt(int irq, voi
 	 */
 	write_seqlock(&xtime_lock);
 
-	cur_timer->mark_offset();
- 
-	do_timer_interrupt(irq, regs);
+	lost = cur_timer->mark_offset();
+
+	do_timer_interrupt(irq, regs, lost);
 
 	write_sequnlock(&xtime_lock);
 	return IRQ_HANDLED;
diff -puN arch/i386/kernel/dyn-tick.c~drift_fix arch/i386/kernel/dyn-tick.c
--- linux-2.6.13-rc6-mm2/arch/i386/kernel/dyn-tick.c~drift_fix	2005-08-31 16:36:17.000000000 +0530
+++ linux-2.6.13-rc6-mm2-root/arch/i386/kernel/dyn-tick.c	2005-08-31 16:36:30.000000000 +0530
@@ -92,7 +92,13 @@ void dyn_tick_interrupt(int irq, struct 
 
 	if (all_were_sleeping) {
 		/* Recover jiffies */
-		cur_timer->mark_offset();
+		if (irq) {
+			int lost;
+
+			lost = cur_timer->mark_offset();
+			if (lost)
+				do_timer(regs);
+		}
 		if (cpu_has_local_apic())
 			enable_pit_timer();
 	}
@@ -116,8 +122,7 @@ void dyn_tick_time_init(struct timer_opt
 {
 	spin_lock_init(&dyn_tick_lock);
 
-	if (strncmp(cur_timer->name, "tsc", 3) == 0 ||
-	    strncmp(cur_timer->name, "pmtmr", 3) == 0) {
+	if (strncmp(cur_timer->name, "pmtmr", 3) == 0) {
 		dyn_tick->state |= DYN_TICK_SUITABLE;
 		printk(KERN_INFO "dyn-tick: Found suitable timer: %s\n",
 		       cur_timer->name);
diff -puN arch/i386/kernel/timers/timer_cyclone.c~drift_fix arch/i386/kernel/timers/timer_cyclone.c
--- linux-2.6.13-rc6-mm2/arch/i386/kernel/timers/timer_cyclone.c~drift_fix	2005-08-31 16:36:17.000000000 +0530
+++ linux-2.6.13-rc6-mm2-root/arch/i386/kernel/timers/timer_cyclone.c	2005-08-31 16:36:30.000000000 +0530
@@ -45,7 +45,7 @@ static seqlock_t monotonic_lock = SEQLOC
 	} while (high != cyclone_timer[1]);
 
 
-static void mark_offset_cyclone(void)
+static int mark_offset_cyclone(void)
 {
 	unsigned long lost, delay;
 	unsigned long delta = last_cyclone_low;
@@ -101,6 +101,8 @@ static void mark_offset_cyclone(void)
 	 */
 	if (lost && abs(delay - delay_at_last_interrupt) > (900000/HZ))
 		jiffies_64++;
+
+	return 1;
 }
 
 static unsigned long get_offset_cyclone(void)
diff -puN arch/i386/kernel/timers/timer_hpet.c~drift_fix arch/i386/kernel/timers/timer_hpet.c
--- linux-2.6.13-rc6-mm2/arch/i386/kernel/timers/timer_hpet.c~drift_fix	2005-08-31 16:36:17.000000000 +0530
+++ linux-2.6.13-rc6-mm2-root/arch/i386/kernel/timers/timer_hpet.c	2005-08-31 16:36:30.000000000 +0530
@@ -96,7 +96,7 @@ static unsigned long get_offset_hpet(voi
 	return edx;
 }
 
-static void mark_offset_hpet(void)
+static int mark_offset_hpet(void)
 {
 	unsigned long long this_offset, last_offset;
 	unsigned long offset;
@@ -119,6 +119,8 @@ static void mark_offset_hpet(void)
 	this_offset = ((unsigned long long)last_tsc_high<<32)|last_tsc_low;
 	monotonic_base += cycles_2_ns(this_offset - last_offset);
 	write_sequnlock(&monotonic_lock);
+
+	return 1;
 }
 
 static void delay_hpet(unsigned long loops)
diff -puN arch/i386/kernel/timers/timer_none.c~drift_fix arch/i386/kernel/timers/timer_none.c
--- linux-2.6.13-rc6-mm2/arch/i386/kernel/timers/timer_none.c~drift_fix	2005-08-31 16:36:17.000000000 +0530
+++ linux-2.6.13-rc6-mm2-root/arch/i386/kernel/timers/timer_none.c	2005-08-31 16:36:30.000000000 +0530
@@ -1,9 +1,10 @@
 #include <linux/init.h>
 #include <asm/timer.h>
 
-static void mark_offset_none(void)
+static int mark_offset_none(void)
 {
 	/* nothing needed */
+	return 1;
 }
 
 static unsigned long get_offset_none(void)
diff -puN arch/i386/kernel/timers/timer_pit.c~drift_fix arch/i386/kernel/timers/timer_pit.c
--- linux-2.6.13-rc6-mm2/arch/i386/kernel/timers/timer_pit.c~drift_fix	2005-08-31 16:36:17.000000000 +0530
+++ linux-2.6.13-rc6-mm2-root/arch/i386/kernel/timers/timer_pit.c	2005-08-31 16:36:30.000000000 +0530
@@ -32,9 +32,10 @@ static int __init init_pit(char* overrid
 	return 0;
 }
 
-static void mark_offset_pit(void)
+static int mark_offset_pit(void)
 {
 	/* nothing needed */
+	return 1;
 }
 
 static unsigned long long monotonic_clock_pit(void)
diff -puN arch/i386/kernel/timers/timer_pm.c~drift_fix arch/i386/kernel/timers/timer_pm.c
--- linux-2.6.13-rc6-mm2/arch/i386/kernel/timers/timer_pm.c~drift_fix	2005-08-31 16:36:17.000000000 +0530
+++ linux-2.6.13-rc6-mm2-root/arch/i386/kernel/timers/timer_pm.c	2005-08-31 16:36:30.000000000 +0530
@@ -135,7 +135,7 @@ pm_good:
 	setup_pit_timer();
 
 	init_cpu_khz();
-	set_dyn_tick_max_skip( (0xFFFFFF / (286 * 1000000)) * 1024 * HZ );
+	set_dyn_tick_max_skip(((0xFFFFFF / 1000000) * 286 * HZ) >> 10);
 	return 0;
 }
 
@@ -156,7 +156,7 @@ static inline u32 cyc2us(u32 cycles)
  * this gets called during each timer interrupt
  *   - Called while holding the writer xtime_lock
  */
-static void mark_offset_pmtmr(void)
+static int mark_offset_pmtmr(void)
 {
 	u32 lost, delta, deltaus, offset_now;
 
@@ -182,6 +182,8 @@ static void mark_offset_pmtmr(void)
 	/* compensate for lost ticks */
 	if (lost >= 2)
 		jiffies_64 += lost - 1;
+
+	return lost;
 }
 
 static int pmtmr_resume(void)
diff -puN arch/i386/kernel/timers/timer_tsc.c~drift_fix arch/i386/kernel/timers/timer_tsc.c
--- linux-2.6.13-rc6-mm2/arch/i386/kernel/timers/timer_tsc.c~drift_fix	2005-08-31 16:36:17.000000000 +0530
+++ linux-2.6.13-rc6-mm2-root/arch/i386/kernel/timers/timer_tsc.c	2005-08-31 16:36:30.000000000 +0530
@@ -177,7 +177,7 @@ static inline void update_monotonic_base
 }
 
 #ifdef CONFIG_HPET_TIMER
-static void mark_offset_tsc_hpet(void)
+static int mark_offset_tsc_hpet(void)
 {
 	unsigned long long last_offset;
  	unsigned long offset, temp, hpet_current;
@@ -221,6 +221,8 @@ static void mark_offset_tsc_hpet(void)
 	delay_at_last_interrupt = hpet_current - offset;
 	ASM_MUL64_REG(temp, delay_at_last_interrupt,
 			hpet_usec_quotient, delay_at_last_interrupt);
+
+	return 1;
 }
 #endif
 
@@ -347,7 +349,7 @@ int recalibrate_cpu_khz(void)
 }
 EXPORT_SYMBOL(recalibrate_cpu_khz);
 
-static void mark_offset_tsc(void)
+static int mark_offset_tsc(void)
 {
 	unsigned long lost,delay;
 	unsigned long delta = last_tsc_low;
@@ -456,8 +458,12 @@ static void mark_offset_tsc(void)
 	 * between tsc and pit reads (as noted when
 	 * usec delta is > 90% # of usecs/tick)
 	 */
-	if (lost && abs(delay - delay_at_last_interrupt) > (900000/HZ))
+	if (lost && abs(delay - delay_at_last_interrupt) > (900000/HZ)) {
 		jiffies_64++;
+		lost++;
+	}
+
+	return 1;
 }
 
 static int __init init_tsc(char* override)
diff -puN arch/i386/Kconfig~drift_fix arch/i386/Kconfig

_



-- 


Thanks and Regards,
Srivatsa Vaddagiri,
Linux Technology Center,
IBM Software Labs,
Bangalore, INDIA - 560017
