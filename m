Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261456AbSJACiD>; Mon, 30 Sep 2002 22:38:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261457AbSJACiC>; Mon, 30 Sep 2002 22:38:02 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:49042 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S261456AbSJAChT>; Mon, 30 Sep 2002 22:37:19 -0400
Subject: [PATCH] linux-2.5.39_timer-changes_A3 (3/3 - integration)
From: john stultz <johnstul@us.ibm.com>
To: Linus Torvalds <torvalds@transmeta.com>, Dave Jones <davej@suse.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, george anzinger <george@mvista.com>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <1033439791.1013.71.camel@cog>
References: <1033439675.1013.64.camel@cog>  <1033439791.1013.71.camel@cog>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 30 Sep 2002 19:38:19 -0700
Message-Id: <1033439899.1013.79.camel@cog>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, Dave, all,

	This is the final part 3 of 3 of my timer-change patch. Part 3
integrates the moved code (from part 2) into the new infrastructure
(from part 1). 

Please apply,

thanks
-john

diff -Nru a/arch/i386/kernel/Makefile b/arch/i386/kernel/Makefile
--- a/arch/i386/kernel/Makefile	Mon Sep 30 19:22:01 2002
+++ b/arch/i386/kernel/Makefile	Mon Sep 30 19:22:01 2002
@@ -9,7 +9,7 @@
 obj-y	:= process.o semaphore.o signal.o entry.o traps.o irq.o vm86.o \
 		ptrace.o i8259.o ioport.o ldt.o setup.o time.o sys_i386.o \
 		pci-dma.o i386_ksyms.o i387.o bluesmoke.o dmi_scan.o \
-		bootflag.o
+		bootflag.o timer.o timer_tsc.o timer_pit.o
 
 obj-y				+= cpu/
 obj-$(CONFIG_X86_BIOS_REBOOT)	+= reboot.o
diff -Nru a/arch/i386/kernel/time.c b/arch/i386/kernel/time.c
--- a/arch/i386/kernel/time.c	Mon Sep 30 19:22:01 2002
+++ b/arch/i386/kernel/time.c	Mon Sep 30 19:22:01 2002
@@ -53,6 +53,7 @@
 #include <asm/mpspec.h>
 #include <asm/uaccess.h>
 #include <asm/processor.h>
+#include <asm/timer.h>
 
 #include <linux/mc146818rtc.h>
 #include <linux/timex.h>
@@ -78,18 +79,10 @@
 
 spinlock_t rtc_lock = SPIN_LOCK_UNLOCKED;
 
-
-#define TICK_SIZE (tick_nsec / 1000)
-
 spinlock_t i8253_lock = SPIN_LOCK_UNLOCKED;
 EXPORT_SYMBOL(i8253_lock);
 
-#ifndef CONFIG_X86_TSC
-#else
-
-#define do_gettimeoffset()	do_fast_gettimeoffset()
-
-#endif
+struct timer_opts* timer;
 
 /*
  * This version of gettimeofday has microsecond resolution
@@ -101,7 +94,7 @@
 	unsigned long usec, sec;
 
 	read_lock_irqsave(&xtime_lock, flags);
-	usec = do_gettimeoffset();
+	usec = timer->get_offset();
 	{
 		unsigned long lost = jiffies - wall_jiffies;
 		if (lost)
@@ -129,7 +122,7 @@
 	 * wall time.  Discover what correction gettimeofday() would have
 	 * made, and then undo it!
 	 */
-	tv->tv_usec -= do_gettimeoffset();
+	tv->tv_usec -= timer->get_offset();
 	tv->tv_usec -= (jiffies - wall_jiffies) * (1000000 / HZ);
 
 	while (tv->tv_usec < 0) {
@@ -295,7 +288,7 @@
 	 */
 	write_lock(&xtime_lock);
 
-	
+	timer->mark_offset();
  
 	do_timer_interrupt(irq, NULL, regs);
 
@@ -345,6 +338,7 @@
 	return mktime(year, mon, day, hour, min, sec);
 }
 
+/* XXX this driverfs stuff should probably go elsewhere later -john */
 static struct sys_device device_i8253 = {
 	.name		= "rtc",
 	.id		= 0,
@@ -368,5 +362,6 @@
 	xtime.tv_nsec = 0;
 

+	timer = select_timer();
 	time_init_hook();
 }
diff -Nru a/arch/i386/kernel/timer.c b/arch/i386/kernel/timer.c
--- a/arch/i386/kernel/timer.c	Mon Sep 30 19:22:01 2002
+++ b/arch/i386/kernel/timer.c	Mon Sep 30 19:22:01 2002
@@ -2,11 +2,17 @@
 #include <asm/timer.h>
 
 /* list of externed timers */
-/* eg: extern struct timer_opts timer_XXX*/;
+#ifndef CONFIG_X86_TSC
+extern struct timer_opts timer_pit;
+#endif
+extern struct timer_opts timer_tsc;
 
 /* list of timers, ordered by preference */
 struct timer_opts* timers[] = {
-	/* eg: &timer_XXX */
+	&timer_tsc
+#ifndef CONFIG_X86_TSC
+	,&timer_pit
+#endif
 };
 
 #define NR_TIMERS (sizeof(timers)/sizeof(timers[0]))
diff -Nru a/arch/i386/kernel/timer_pit.c b/arch/i386/kernel/timer_pit.c
--- a/arch/i386/kernel/timer_pit.c	Mon Sep 30 19:22:01 2002
+++ b/arch/i386/kernel/timer_pit.c	Mon Sep 30 19:22:01 2002
@@ -1,3 +1,41 @@
+/*
+ * This code largely moved from arch/i386/kernel/time.c.
+ * See comments there for proper credits.
+ */
+
+#include <linux/spinlock.h>
+#include <linux/module.h>
+#include <linux/device.h>
+#include <asm/timer.h>
+#include <asm/io.h>
+
+/* fwd declarations */
+int init_pit(void);
+void mark_offset_pit(void);
+unsigned long get_offset_pit(void);
+
+/* tsc timer_opts struct */
+struct timer_opts timer_pit = {
+	init: init_pit, 
+	mark_offset: mark_offset_pit, 
+	get_offset: get_offset_pit
+};
+
+
+extern spinlock_t i8259A_lock;
+extern spinlock_t i8253_lock;
+#include "do_timer.h"
+
+int init_pit(void)
+{
+	return 1;
+}
+
+void mark_offset_pit(void)
+{
+	/* nothing needed */
+}
+
 
 /* This function must be called with interrupts disabled 
  * It was inspired by Steve McCanne's microtime-i386 for BSD.  -- jrs
@@ -31,7 +69,7 @@
  * comp.protocols.time.ntp!
  */
 
-static unsigned long do_slow_gettimeoffset(void)
+unsigned long get_offset_pit(void)
 {
 	int count;
 
@@ -93,5 +131,3 @@
 
 	return count;
 }
-
-static unsigned long (*do_gettimeoffset)(void) = do_slow_gettimeoffset;
diff -Nru a/arch/i386/kernel/timer_tsc.c b/arch/i386/kernel/timer_tsc.c
--- a/arch/i386/kernel/timer_tsc.c	Mon Sep 30 19:22:01 2002
+++ b/arch/i386/kernel/timer_tsc.c	Mon Sep 30 19:22:01 2002
@@ -1,3 +1,33 @@
+/*
+ * This code largely moved from arch/i386/kernel/time.c.
+ * See comments there for proper credits.
+ */
+
+#include <linux/spinlock.h>
+#include <linux/init.h>
+#include <linux/timex.h>
+
+#include <asm/timer.h>
+#include <asm/io.h>
+
+/* fwd declarations */
+int init_tsc(void);
+void mark_offset_tsc(void);
+unsigned long get_offset_tsc(void);
+
+/* tsc timer_opts struct */
+struct timer_opts timer_tsc = {
+	init: init_tsc, 
+	mark_offset: mark_offset_tsc, 
+	get_offset: get_offset_tsc
+};
+
+
+/************************************************************/
+extern int x86_udelay_tsc;
+extern spinlock_t i8253_lock;
+
+static int use_tsc;
 /* Number of usecs that the last interrupt was delayed */
 static int delay_at_last_interrupt;
 
@@ -10,7 +40,7 @@
  */
 unsigned long fast_gettimeoffset_quotient;
 
-static inline unsigned long do_fast_gettimeoffset(void)
+unsigned long get_offset_tsc(void)
 {
 	register unsigned long eax, edx;
 
@@ -39,36 +69,35 @@
 	return delay_at_last_interrupt + edx;
 }
 
+void mark_offset_tsc(void)
+{
+	int count;
+	/*
+	 * It is important that these two operations happen almost at
+	 * the same time. We do the RDTSC stuff first, since it's
+	 * faster. To avoid any inconsistencies, we need interrupts
+	 * disabled locally.
+	 */
 
-
-if (use_tsc)
-	{
-		/*
-		 * It is important that these two operations happen almost at
-		 * the same time. We do the RDTSC stuff first, since it's
-		 * faster. To avoid any inconsistencies, we need interrupts
-		 * disabled locally.
-		 */
-
-		/*
-		 * Interrupts are just disabled locally since the timer irq
-		 * has the SA_INTERRUPT flag set. -arca
-		 */
+	/*
+	 * Interrupts are just disabled locally since the timer irq
+	 * has the SA_INTERRUPT flag set. -arca
+	 */
 	
-		/* read Pentium cycle counter */
+	/* read Pentium cycle counter */
 
-		rdtscl(last_tsc_low);
+	rdtscl(last_tsc_low);
 
-		spin_lock(&i8253_lock);
-		outb_p(0x00, 0x43);     /* latch the count ASAP */
+	spin_lock(&i8253_lock);
+	outb_p(0x00, 0x43);     /* latch the count ASAP */
 
-		count = inb_p(0x40);    /* read the latched count */
-		count |= inb(0x40) << 8;
-		spin_unlock(&i8253_lock);
+	count = inb_p(0x40);    /* read the latched count */
+	count |= inb(0x40) << 8;
+	spin_unlock(&i8253_lock);
 
-		count = ((LATCH-1) - count) * TICK_SIZE;
-		delay_at_last_interrupt = (count + LATCH/2) / LATCH;
-	}
+	count = ((LATCH-1) - count) * TICK_SIZE;
+	delay_at_last_interrupt = (count + LATCH/2) / LATCH;
+}
 

 /* ------ Calibrate the TSC ------- 
@@ -83,7 +112,6 @@
 #define CALIBRATE_LATCH	(5 * LATCH)
 #define CALIBRATE_TIME	(5 * 1000020/HZ)
 
-#ifdef CONFIG_X86_TSC
 static unsigned long __init calibrate_tsc(void)
 {
        /* Set the Gate high, disable speaker */
@@ -148,7 +176,6 @@
 bad_ctc:
 	return 0;
 }
-#endif /* CONFIG_X86_TSC */
 

 #ifdef CONFIG_CPU_FREQ
@@ -196,26 +223,22 @@
 #endif
 

-
-#ifdef CONFIG_X86_TSC
-	extern int x86_udelay_tsc;
-#endif
-
-/*
- * If we have APM enabled or the CPU clock speed is variable
- * (CPU stops clock on HLT or slows clock to save power)
- * then the TSC timestamps may diverge by up to 1 jiffy from
- * 'real time' but nothing will break.
- * The most frequent case is that the CPU is "woken" from a halt
- * state by the timer interrupt itself, so we get 0 error. In the
- * rare cases where a driver would "wake" the CPU and request a
- * timestamp, the maximum error is < 1 jiffy. But timestamps are
- * still perfectly ordered.
- * Note that the TSC counter will be reset if APM suspends
- * to disk; this won't break the kernel, though, 'cuz we're
- * smart.  See arch/i386/kernel/apm.c.
- */
-#ifdef CONFIG_X86_TSC
+int init_tsc(void)
+{
+	/*
+	 * If we have APM enabled or the CPU clock speed is variable
+	 * (CPU stops clock on HLT or slows clock to save power)
+	 * then the TSC timestamps may diverge by up to 1 jiffy from
+	 * 'real time' but nothing will break.
+	 * The most frequent case is that the CPU is "woken" from a halt
+	 * state by the timer interrupt itself, so we get 0 error. In the
+	 * rare cases where a driver would "wake" the CPU and request a
+	 * timestamp, the maximum error is < 1 jiffy. But timestamps are
+	 * still perfectly ordered.
+	 * Note that the TSC counter will be reset if APM suspends
+	 * to disk; this won't break the kernel, though, 'cuz we're
+	 * smart.  See arch/i386/kernel/apm.c.
+	 */
  	/*
  	 *	Firstly we have to do a CPU check for chips with
  	 * 	a potentially buggy TSC. At this point we haven't run
@@ -239,9 +262,6 @@
 			 *	and just enable this for the next intel chips ?
 			 */
 			x86_udelay_tsc = 1;
-#ifndef do_gettimeoffset
-			do_gettimeoffset = do_fast_gettimeoffset;
-#endif
 
 			/* report CPU clock rate in Hz.
 			 * The formula is (10^6 * 2^32) / (2^32 * 1 / (clocks/us)) =
@@ -257,6 +277,8 @@
 #ifdef CONFIG_CPU_FREQ
 			cpufreq_register_notifier(&time_cpufreq_notifier_block, CPUFREQ_TRANSITION_NOTIFIER);
 #endif
+			return 1;
 		}
 	}
-#endif /* CONFIG_X86_TSC */
+	return 0;
+}
diff -Nru a/include/asm-i386/timer.h b/include/asm-i386/timer.h
--- a/include/asm-i386/timer.h	Mon Sep 30 19:22:01 2002
+++ b/include/asm-i386/timer.h	Mon Sep 30 19:22:01 2002
@@ -9,6 +9,6 @@
 	/* called by gettimeofday. returns # ms since the last timer interrupt */
 	unsigned long (*get_offset)(void);
 };
-
+#define TICK_SIZE (tick_nsec / 1000)
 struct timer_opts* select_timer(void);
 #endif

