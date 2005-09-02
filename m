Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751505AbVIBPq2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751505AbVIBPq2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 11:46:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751508AbVIBPq2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 11:46:28 -0400
Received: from mail15.syd.optusnet.com.au ([211.29.132.196]:19665 "EHLO
	mail15.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1751505AbVIBPq1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 11:46:27 -0400
From: Con Kolivas <kernel@kolivas.org>
To: vatsa@in.ibm.com
Subject: [PATCH 3/3] dyntick - Recover walltime upon wakeup
Date: Sat, 3 Sep 2005 01:46:11 +1000
User-Agent: KMail/1.8.2
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, ck list <ck@vds.kolivas.org>
References: <20050831165843.GA4974@in.ibm.com> <200509030143.57782.kernel@kolivas.org> <200509030145.18368.kernel@kolivas.org>
In-Reply-To: <200509030145.18368.kernel@kolivas.org>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_DPHGDQ0KJRLLWRu"
Message-Id: <200509030146.11874.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_DPHGDQ0KJRLLWRu
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Con
---



--Boundary-00=_DPHGDQ0KJRLLWRu
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="dyntick-Recover_walltime_upon_wakeup.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="dyntick-Recover_walltime_upon_wakeup.patch"


This patch uses the lost tick information returned by mark_offset()
function in dyn-tick, to recover time.

Code by Srivatsa Vaddagiri <vatsa@in.ibm.com>

Index: linux-2.6.13-mm1/arch/i386/kernel/dyn-tick.c
===================================================================
--- linux-2.6.13-mm1.orig/arch/i386/kernel/dyn-tick.c	2005-09-03 01:11:54.000000000 +1000
+++ linux-2.6.13-mm1/arch/i386/kernel/dyn-tick.c	2005-09-03 01:12:11.000000000 +1000
@@ -91,7 +91,13 @@ void dyn_tick_interrupt(int irq, struct 
 
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
Index: linux-2.6.13-mm1/arch/i386/kernel/time.c
===================================================================
--- linux-2.6.13-mm1.orig/arch/i386/kernel/time.c	2005-09-03 01:11:54.000000000 +1000
+++ linux-2.6.13-mm1/arch/i386/kernel/time.c	2005-09-03 01:12:11.000000000 +1000
@@ -250,7 +250,7 @@ EXPORT_SYMBOL(profile_pc);
  * timer_interrupt() needs to keep up the real-time clock,
  * as well as call the "do_timer()" routine every clocktick
  */
-static inline void do_timer_interrupt(int irq, struct pt_regs *regs)
+static inline void do_timer_interrupt(int irq, struct pt_regs *regs, int lost)
 {
 #ifdef CONFIG_X86_IO_APIC
 	if (timer_ack) {
@@ -268,7 +268,8 @@ static inline void do_timer_interrupt(in
 	}
 #endif
 
-	do_timer_interrupt_hook(regs);
+	if (!dyn_tick_enabled() || lost)
+		do_timer_interrupt_hook(regs);
 
 
 	if (MCA_bus) {
@@ -293,6 +294,8 @@ static inline void do_timer_interrupt(in
  */
 irqreturn_t timer_interrupt(int irq, void *dev_id, struct pt_regs *regs)
 {
+	int lost;
+
 	/*
 	 * Here we are in the timer irq handler. We just have irqs locally
 	 * disabled but we don't know if the timer_bh is running on the other
@@ -302,9 +305,9 @@ irqreturn_t timer_interrupt(int irq, voi
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
Index: linux-2.6.13-mm1/arch/i386/kernel/timers/timer_cyclone.c
===================================================================
--- linux-2.6.13-mm1.orig/arch/i386/kernel/timers/timer_cyclone.c	2005-09-03 01:11:54.000000000 +1000
+++ linux-2.6.13-mm1/arch/i386/kernel/timers/timer_cyclone.c	2005-09-03 01:12:11.000000000 +1000
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
Index: linux-2.6.13-mm1/arch/i386/kernel/timers/timer_hpet.c
===================================================================
--- linux-2.6.13-mm1.orig/arch/i386/kernel/timers/timer_hpet.c	2005-09-03 01:11:54.000000000 +1000
+++ linux-2.6.13-mm1/arch/i386/kernel/timers/timer_hpet.c	2005-09-03 01:12:11.000000000 +1000
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
Index: linux-2.6.13-mm1/arch/i386/kernel/timers/timer_none.c
===================================================================
--- linux-2.6.13-mm1.orig/arch/i386/kernel/timers/timer_none.c	2005-09-03 01:11:54.000000000 +1000
+++ linux-2.6.13-mm1/arch/i386/kernel/timers/timer_none.c	2005-09-03 01:12:11.000000000 +1000
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
Index: linux-2.6.13-mm1/arch/i386/kernel/timers/timer_pit.c
===================================================================
--- linux-2.6.13-mm1.orig/arch/i386/kernel/timers/timer_pit.c	2005-09-03 01:11:54.000000000 +1000
+++ linux-2.6.13-mm1/arch/i386/kernel/timers/timer_pit.c	2005-09-03 01:12:11.000000000 +1000
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
Index: linux-2.6.13-mm1/arch/i386/kernel/timers/timer_pm.c
===================================================================
--- linux-2.6.13-mm1.orig/arch/i386/kernel/timers/timer_pm.c	2005-09-03 01:12:11.000000000 +1000
+++ linux-2.6.13-mm1/arch/i386/kernel/timers/timer_pm.c	2005-09-03 01:12:11.000000000 +1000
@@ -135,7 +135,7 @@ pm_good:
 	setup_pit_timer();
 
 	init_cpu_khz();
-	set_dyn_tick_max_skip((0xFFFFFF / (286 * 1000000)) * 1024 * HZ);
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
Index: linux-2.6.13-mm1/arch/i386/kernel/timers/timer_tsc.c
===================================================================
--- linux-2.6.13-mm1.orig/arch/i386/kernel/timers/timer_tsc.c	2005-09-03 01:11:54.000000000 +1000
+++ linux-2.6.13-mm1/arch/i386/kernel/timers/timer_tsc.c	2005-09-03 01:12:11.000000000 +1000
@@ -175,7 +175,7 @@ static inline void update_monotonic_base
 }
 
 #ifdef CONFIG_HPET_TIMER
-static void mark_offset_tsc_hpet(void)
+static int mark_offset_tsc_hpet(void)
 {
 	unsigned long long last_offset;
  	unsigned long offset, temp, hpet_current;
@@ -219,6 +219,8 @@ static void mark_offset_tsc_hpet(void)
 	delay_at_last_interrupt = hpet_current - offset;
 	ASM_MUL64_REG(temp, delay_at_last_interrupt,
 			hpet_usec_quotient, delay_at_last_interrupt);
+
+	return 1;
 }
 #endif
 
@@ -345,7 +347,7 @@ int recalibrate_cpu_khz(void)
 }
 EXPORT_SYMBOL(recalibrate_cpu_khz);
 
-static void mark_offset_tsc(void)
+static int mark_offset_tsc(void)
 {
 	unsigned long lost,delay;
 	unsigned long delta = last_tsc_low;
@@ -438,8 +440,12 @@ static void mark_offset_tsc(void)
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
Index: linux-2.6.13-mm1/include/asm-i386/timer.h
===================================================================
--- linux-2.6.13-mm1.orig/include/asm-i386/timer.h	2005-09-03 01:11:54.000000000 +1000
+++ linux-2.6.13-mm1/include/asm-i386/timer.h	2005-09-03 01:12:11.000000000 +1000
@@ -19,7 +19,7 @@
  */
 struct timer_opts {
 	char* name;
-	void (*mark_offset)(void);
+	int (*mark_offset)(void);
 	unsigned long (*get_offset)(void);
 	unsigned long long (*monotonic_clock)(void);
 	void (*delay)(unsigned long);

--Boundary-00=_DPHGDQ0KJRLLWRu--
