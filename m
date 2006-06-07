Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932371AbWFGT3D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932371AbWFGT3D (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jun 2006 15:29:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932204AbWFGT3D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jun 2006 15:29:03 -0400
Received: from sccrmhc12.comcast.net ([63.240.77.82]:43696 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S932371AbWFGT3B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jun 2006 15:29:01 -0400
Date: Wed, 7 Jun 2006 12:31:51 -0700
From: Deepak Saxena <dsaxena@plexity.net>
To: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>
Cc: dwalker@mvista.com, James Perkins <james.perkins@windriver.com>,
       mlachwani@mvista.com, khilman@mvista.com, linux-kernel@vger.kernel.org
Subject: [PATCH-rt] Make clock_events API more SOC friendly
Message-ID: <20060607193151.GA16812@plexity.net>
Reply-To: dsaxena@plexity.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: Plexity Networks
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


SOCs often have multiple timers that behave the exact way, where
the only difference is the base address of the register bank. In
these cases, it would be nice to have a single function shared
across timers instead of one per timer. For this to work properly,
all clock_event function pointers need to take a priv pointer with
timer-specific context information.

Signed-off-by: Deepak Saxena <dsaxena@plexity.net>

---

Note: Not compile tested yet...just want to make sure this OK with
folks before I start implementing support on my ARM boards. X86 just
ignores the priv pointer.

Index: linux-2.6-rt/arch/i386/kernel/apic.c
===================================================================
--- linux-2.6-rt.orig/arch/i386/kernel/apic.c
+++ linux-2.6-rt/arch/i386/kernel/apic.c
@@ -992,12 +992,12 @@ static void __setup_APIC_LVTT(unsigned i
 		apic_write_around(APIC_TMICT, clocks/APIC_DIVISOR);
 }
 
-static void lapic_next_event(unsigned long evt)
+static void lapic_next_event(unsigned long evt, void *priv)
 {
 	apic_write_around(APIC_TMICT, evt);
 }
 
-static void lapic_timer_setup(int mode)
+static void lapic_timer_setup(int mode, void *priv)
 {
 	unsigned long flags;
 
Index: linux-2.6-rt/arch/i386/kernel/i8253.c
===================================================================
--- linux-2.6-rt.orig/arch/i386/kernel/i8253.c
+++ linux-2.6-rt/arch/i386/kernel/i8253.c
@@ -21,7 +21,7 @@
 DEFINE_RAW_SPINLOCK(i8253_lock);
 EXPORT_SYMBOL(i8253_lock);
 
-static void init_pit_timer(int mode)
+static void init_pit_timer(int mode, void *priv)
 {
 	unsigned long flags;
 
@@ -42,7 +42,7 @@ static void init_pit_timer(int mode)
 	spin_unlock_irqrestore(&i8253_lock, flags);
 }
 
-static void pit_next_event(unsigned long evt)
+static void pit_next_event(unsigned long evt, void *priv)
 {
 	unsigned long flags;
 
Index: linux-2.6-rt/include/linux/clockchips.h
===================================================================
--- linux-2.6-rt.orig/include/linux/clockchips.h
+++ linux-2.6-rt/include/linux/clockchips.h
@@ -79,11 +79,11 @@ struct clock_event {
 	unsigned long min_delta_ns;
 	u32 mult;
 	u32 shift;
-	void (*set_next_event)(unsigned long evt);
-	void (*set_mode)(int mode);
+	void (*set_next_event)(unsigned long evt, void *priv);
+	void (*set_mode)(int mode, void *priv);
 	int (*suspend)(void);
 	int (*resume)(void);
-	void (*event_handler)(struct pt_regs *regs);
+	void (*event_handler)(struct pt_regs *regs, void *priv);
 	void (*start_event)(void *priv);
 	void (*end_event)(void *priv);
 	unsigned int irq;
Index: linux-2.6-rt/kernel/time/clockevents.c
===================================================================
--- linux-2.6-rt.orig/kernel/time/clockevents.c
+++ linux-2.6-rt/kernel/time/clockevents.c
@@ -85,7 +85,7 @@ static irqreturn_t timer_interrupt(int i
 	if (evt->start_event)
 		evt->start_event(evt->priv);
 
-	evt->event_handler(regs);
+	evt->event_handler(regs, evt->priv);
 
 	if (evt->end_event)
 		evt->end_event(evt->priv);
@@ -345,7 +345,7 @@ static int setup_event(struct event_desc
 	descr->real_caps = caps;
 	descr->mode = CLOCK_EVT_STARTUP;
 	if (evt->set_mode)
-		evt->set_mode(CLOCK_EVT_STARTUP);
+		evt->set_mode(CLOCK_EVT_STARTUP, evt->priv);
 	printk(KERN_INFO "Event source %s installed with caps set: %02x\n",
 	       descr->event->name, descr->real_caps);
 
@@ -508,7 +508,8 @@ int clockevents_init_next_event(void)
 		return 0;
 
 	if (sources->nextevt->set_mode)
-		sources->nextevt->set_mode(CLOCK_EVT_ONESHOT);
+		sources->nextevt->set_mode(CLOCK_EVT_ONESHOT,
+					   sources->nextevt->priv);
 
 	return 1;
 }
@@ -533,7 +534,7 @@ int clockevents_set_next_event(ktime_t e
 	clc = clc >> sources->nextevt->shift;
 #endif
 
-	sources->nextevt->set_next_event(clc);
+	sources->nextevt->set_next_event(clc, sources->nextevt->priv);
 
 	hrtimer_trace(expires, clc);
 


-- 
Deepak Saxena - dsaxena@plexity.net - http://www.plexity.net

In the end, they will not say, "those were dark times,"  they will ask
"why were their poets silent?" - Bertold Brecht
