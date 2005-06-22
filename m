Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262910AbVFVJAX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262910AbVFVJAX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 05:00:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262843AbVFVJAR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 05:00:17 -0400
Received: from mx1.elte.hu ([157.181.1.137]:11998 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262871AbVFVIxr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 04:53:47 -0400
Date: Wed, 22 Jun 2005 10:52:58 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: Stas Sergeev <stsp@aknet.ru>, linux-kernel@vger.kernel.org
Subject: [patch] i8253-i8259A-lock-cleanup
Message-ID: <20050622085258.GA27208@elte.hu>
References: <42B8D9FF.1070000@aknet.ru> <20050621203624.0e2f48f9.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050621203624.0e2f48f9.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andrew Morton <akpm@osdl.org> wrote:

> Adding ifdefs around #includes is a bit unsightly - it also increases 
> the possibility that the build will break when .configs are changed.
> 
> Is it not possible to find an appropriate arch-specific header file 
> for the declaration?

just to avoid duplication of effort - here's what i had in the -RT tree 
for months. Against git-curr. Build and boot-tested on x86.

	Ingo

-----

introduce proper declarations for i8253_lock and i8259A_lock.

Signed-off-by: Ingo Molnar <mingo@elte.hu>

 arch/i386/kernel/apic.c                  |    2 +-
 arch/i386/kernel/apm.c                   |    5 ++---
 arch/i386/kernel/io_apic.c               |    2 +-
 arch/i386/kernel/time.c                  |    5 ++++-
 arch/i386/kernel/timers/timer_cyclone.c  |    4 ++--
 arch/i386/kernel/timers/timer_pit.c      |    4 +---
 arch/i386/kernel/timers/timer_tsc.c      |    3 +--
 arch/i386/mach-voyager/voyager_basic.c   |    2 +-
 arch/x86_64/kernel/io_apic.c             |    1 -
 drivers/ide/legacy/hd.c                  |    4 +++-
 drivers/input/gameport/gameport.c        |    3 ++-
 drivers/input/joystick/analog.c          |    4 +++-
 include/asm-i386/i8253.h                 |    6 ++++++
 include/asm-i386/mach-default/do_timer.h |    1 +
 include/asm-x86_64/io_apic.h             |    2 ++
 15 files changed, 30 insertions(+), 18 deletions(-)

Index: arch/i386/kernel/apic.c
===================================================================
--- arch/i386/kernel/apic.c.orig
+++ arch/i386/kernel/apic.c
@@ -34,6 +34,7 @@
 #include <asm/desc.h>
 #include <asm/arch_hooks.h>
 #include <asm/hpet.h>
+#include <asm/i8253.h>
 
 #include <mach_apic.h>
 
@@ -857,7 +858,6 @@ fake_ioapic_page:
  */
 static unsigned int __init get_8254_timer_count(void)
 {
-	extern spinlock_t i8253_lock;
 	unsigned long flags;
 
 	unsigned int count;
Index: arch/i386/kernel/apm.c
===================================================================
--- arch/i386/kernel/apm.c.orig
+++ arch/i386/kernel/apm.c
@@ -228,10 +228,10 @@
 #include <asm/system.h>
 #include <asm/uaccess.h>
 #include <asm/desc.h>
+#include <asm/i8253.h>
 
 #include "io_ports.h"
 
-extern spinlock_t i8253_lock;
 extern unsigned long get_cmos_time(void);
 extern void machine_real_restart(unsigned char *, int);
 
@@ -1168,8 +1168,7 @@ static void get_time_diff(void)
 static void reinit_timer(void)
 {
 #ifdef INIT_TIMER_AFTER_SUSPEND
-	unsigned long	flags;
-	extern spinlock_t i8253_lock;
+	unsigned long flags;
 
 	spin_lock_irqsave(&i8253_lock, flags);
 	/* set the clock to 100 Hz */
Index: arch/i386/kernel/io_apic.c
===================================================================
--- arch/i386/kernel/io_apic.c.orig
+++ arch/i386/kernel/io_apic.c
@@ -37,6 +37,7 @@
 #include <asm/smp.h>
 #include <asm/desc.h>
 #include <asm/timer.h>
+#include <asm/i8259.h>
 
 #include <mach_apic.h>
 
@@ -1565,7 +1566,6 @@ void print_all_local_APICs (void)
 
 void /*__init*/ print_PIC(void)
 {
-	extern spinlock_t i8259A_lock;
 	unsigned int v;
 	unsigned long flags;
 
Index: arch/i386/kernel/time.c
===================================================================
--- arch/i386/kernel/time.c.orig
+++ arch/i386/kernel/time.c
@@ -68,7 +68,8 @@
 
 #include "io_ports.h"
 
-extern spinlock_t i8259A_lock;
+#include <asm/i8259.h>
+
 int pit_latch_buggy;              /* extern */
 
 #include "do_timer.h"
@@ -83,6 +84,8 @@ extern unsigned long wall_jiffies;
 
 DEFINE_SPINLOCK(rtc_lock);
 
+#include <asm/i8253.h>
+
 DEFINE_SPINLOCK(i8253_lock);
 EXPORT_SYMBOL(i8253_lock);
 
Index: arch/i386/kernel/timers/timer_cyclone.c
===================================================================
--- arch/i386/kernel/timers/timer_cyclone.c.orig
+++ arch/i386/kernel/timers/timer_cyclone.c
@@ -17,9 +17,9 @@
 #include <asm/io.h>
 #include <asm/pgtable.h>
 #include <asm/fixmap.h>
-#include "io_ports.h"
+#include <asm/i8253.h>
 
-extern spinlock_t i8253_lock;
+#include "io_ports.h"
 
 /* Number of usecs that the last interrupt was delayed */
 static int delay_at_last_interrupt;
Index: arch/i386/kernel/timers/timer_pit.c
===================================================================
--- arch/i386/kernel/timers/timer_pit.c.orig
+++ arch/i386/kernel/timers/timer_pit.c
@@ -15,9 +15,8 @@
 #include <asm/smp.h>
 #include <asm/io.h>
 #include <asm/arch_hooks.h>
+#include <asm/i8253.h>
 
-extern spinlock_t i8259A_lock;
-extern spinlock_t i8253_lock;
 #include "do_timer.h"
 #include "io_ports.h"
 
@@ -166,7 +165,6 @@ struct init_timer_opts __initdata timer_
 
 void setup_pit_timer(void)
 {
-	extern spinlock_t i8253_lock;
 	unsigned long flags;
 
 	spin_lock_irqsave(&i8253_lock, flags);
Index: arch/i386/kernel/timers/timer_tsc.c
===================================================================
--- arch/i386/kernel/timers/timer_tsc.c.orig
+++ arch/i386/kernel/timers/timer_tsc.c
@@ -24,6 +24,7 @@
 #include "mach_timer.h"
 
 #include <asm/hpet.h>
+#include <asm/i8253.h>
 
 #ifdef CONFIG_HPET_TIMER
 static unsigned long hpet_usec_quotient;
@@ -35,8 +36,6 @@ static inline void cpufreq_delayed_get(v
 
 int tsc_disable __initdata = 0;
 
-extern spinlock_t i8253_lock;
-
 static int use_tsc;
 /* Number of usecs that the last interrupt was delayed */
 static int delay_at_last_interrupt;
Index: arch/i386/mach-voyager/voyager_basic.c
===================================================================
--- arch/i386/mach-voyager/voyager_basic.c.orig
+++ arch/i386/mach-voyager/voyager_basic.c
@@ -30,6 +30,7 @@
 #include <linux/irq.h>
 #include <asm/tlbflush.h>
 #include <asm/arch_hooks.h>
+#include <asm/i8253.h>
 
 /*
  * Power off function, if any
@@ -182,7 +183,6 @@ voyager_timer_interrupt(struct pt_regs *
 		 * and swiftly introduce it to something sharp and
 		 * pointy.  */
 		__u16 val;
-		extern spinlock_t i8253_lock;
 
 		spin_lock(&i8253_lock);
 		
Index: arch/x86_64/kernel/io_apic.c
===================================================================
--- arch/x86_64/kernel/io_apic.c.orig
+++ arch/x86_64/kernel/io_apic.c
@@ -1064,7 +1064,6 @@ void print_all_local_APICs (void)
 
 void __apicdebuginit print_PIC(void)
 {
-	extern spinlock_t i8259A_lock;
 	unsigned int v;
 	unsigned long flags;
 
Index: drivers/ide/legacy/hd.c
===================================================================
--- drivers/ide/legacy/hd.c.orig
+++ drivers/ide/legacy/hd.c
@@ -156,11 +156,13 @@ else \
 
 
 #if (HD_DELAY > 0)
+
+#include <asm/i8253.h>
+
 unsigned long last_req;
 
 unsigned long read_timer(void)
 {
-        extern spinlock_t i8253_lock;
 	unsigned long t, flags;
 	int i;
 
Index: drivers/input/gameport/gameport.c
===================================================================
--- drivers/input/gameport/gameport.c.orig
+++ drivers/input/gameport/gameport.c
@@ -61,12 +61,13 @@ static void gameport_disconnect_port(str
 
 #if defined(__i386__)
 
+#include <asm/i8253.h>
+
 #define DELTA(x,y)      ((y)-(x)+((y)<(x)?1193182/HZ:0))
 #define GET_TIME(x)     do { x = get_time_pit(); } while (0)
 
 static unsigned int get_time_pit(void)
 {
-	extern spinlock_t i8253_lock;
 	unsigned long flags;
 	unsigned int count;
 
Index: drivers/input/joystick/analog.c
===================================================================
--- drivers/input/joystick/analog.c.orig
+++ drivers/input/joystick/analog.c
@@ -140,12 +140,14 @@ struct analog_port {
  */
 
 #ifdef __i386__
+
+#include <asm/i8253.h>
+
 #define GET_TIME(x)	do { if (cpu_has_tsc) rdtscl(x); else x = get_time_pit(); } while (0)
 #define DELTA(x,y)	(cpu_has_tsc ? ((y) - (x)) : ((x) - (y) + ((x) < (y) ? CLOCK_TICK_RATE / HZ : 0)))
 #define TIME_NAME	(cpu_has_tsc?"TSC":"PIT")
 static unsigned int get_time_pit(void)
 {
-        extern spinlock_t i8253_lock;
         unsigned long flags;
         unsigned int count;
 
Index: include/asm-i386/i8253.h
===================================================================
--- /dev/null
+++ include/asm-i386/i8253.h
@@ -0,0 +1,6 @@
+#ifndef __ASM_I8253_H__
+#define __ASM_I8253_H__
+
+extern spinlock_t i8253_lock;
+
+#endif	/* __ASM_I8253_H__ */
Index: include/asm-i386/mach-default/do_timer.h
===================================================================
--- include/asm-i386/mach-default/do_timer.h.orig
+++ include/asm-i386/mach-default/do_timer.h
@@ -1,6 +1,7 @@
 /* defines for inline arch setup functions */
 
 #include <asm/apic.h>
+#include <asm/i8259.h>
 
 /**
  * do_timer_interrupt_hook - hook into timer tick
Index: include/asm-x86_64/io_apic.h
===================================================================
--- include/asm-x86_64/io_apic.h.orig
+++ include/asm-x86_64/io_apic.h
@@ -217,4 +217,6 @@ extern int assign_irq_vector(int irq);
 
 void enable_NMI_through_LVT0 (void * dummy);
 
+extern spinlock_t i8259A_lock;
+
 #endif
