Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262676AbSJJAOl>; Wed, 9 Oct 2002 20:14:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262692AbSJJAOl>; Wed, 9 Oct 2002 20:14:41 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:3787 "EHLO e35.co.us.ibm.com")
	by vger.kernel.org with ESMTP id <S262676AbSJJAOY>;
	Wed, 9 Oct 2002 20:14:24 -0400
Subject: [PATCH] linux-2.5.41_timer-changes_A4 (3/3 - integration)
From: john stultz <johnstul@us.ibm.com>
To: Linus Torvalds <torvalds@transmeta.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Dave Jones <davej@suse.de>, george anzinger <george@mvista.com>,
       lkml <linux-kernel@vger.kernel.org>, greg kh <greg@kroah.com>,
       Patrick Mochel <mochel@osdl.org>
In-Reply-To: <1034208761.7591.1360.camel@cog>
References: <1034208695.21965.1356.camel@cog> 
	<1034208761.7591.1360.camel@cog>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 09 Oct 2002 17:13:38 -0700
Message-Id: <1034208819.21964.1364.camel@cog>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, All,

        This is the final part 3 of 3 of my timer-change patch. Part 3
integrates the moved code (from part 2) into the new infrastructure
(from part 1). 

Please apply,

thanks
-john

diff -Nru a/arch/i386/Makefile b/arch/i386/Makefile
--- a/arch/i386/Makefile	Wed Oct  9 17:08:33 2002
+++ b/arch/i386/Makefile	Wed Oct  9 17:08:33 2002
@@ -53,7 +53,7 @@
 
 libs-y 					+= arch/i386/lib/
 core-y					+= arch/i386/kernel/ arch/i386/mm/ \
-					   arch/i386/$(MACHINE)/
+					   arch/i386/$(MACHINE)/ arch/i386/kernel/timers/
 drivers-$(CONFIG_MATH_EMULATION)	+= arch/i386/math-emu/
 drivers-$(CONFIG_PCI)			+= arch/i386/pci/
 
diff -Nru a/arch/i386/kernel/time.c b/arch/i386/kernel/time.c
--- a/arch/i386/kernel/time.c	Wed Oct  9 17:08:33 2002
+++ b/arch/i386/kernel/time.c	Wed Oct  9 17:08:33 2002
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
diff -Nru a/arch/i386/kernel/timers/Makefile b/arch/i386/kernel/timers/Makefile
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/arch/i386/kernel/timers/Makefile	Wed Oct  9 17:08:33 2002
@@ -0,0 +1,10 @@
+#
+# Makefile for x86 timers
+#
+
+obj-y := timer.o
+
+obj-y += timer_tsc.o
+obj-y += timer_pit.o
+
+include $(TOPDIR)/Rules.make
diff -Nru a/arch/i386/kernel/timers/timer.c b/arch/i386/kernel/timers/timer.c
--- a/arch/i386/kernel/timers/timer.c	Wed Oct  9 17:08:33 2002
+++ b/arch/i386/kernel/timers/timer.c	Wed Oct  9 17:08:33 2002
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
diff -Nru a/arch/i386/kernel/timers/timer_pit.c b/arch/i386/kernel/timers/timer_pit.c
--- a/arch/i386/kernel/timers/timer_pit.c	Wed Oct  9 17:08:33 2002
+++ b/arch/i386/kernel/timers/timer_pit.c	Wed Oct  9 17:08:33 2002
@@ -1,3 +1,28 @@
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
+extern spinlock_t i8259A_lock;
+extern spinlock_t i8253_lock;
+#include "do_timer.h"
+
+static int init_pit(void)
+{
+	return 1;
+}
+
+static void mark_offset_pit(void)
+{
+	/* nothing needed */
+}
+
 
 /* This function must be called with interrupts disabled 
  * It was inspired by Steve McCanne's microtime-i386 for BSD.  -- jrs
@@ -31,7 +56,7 @@
  * comp.protocols.time.ntp!
  */
 
-static unsigned long do_slow_gettimeoffset(void)
+static unsigned long get_offset_pit(void)
 {
 	int count;
 
@@ -94,4 +119,10 @@
 	return count;
 }
 
-static unsigned long (*do_gettimeoffset)(void) = do_slow_gettimeoffset;
+
+/* tsc timer_opts struct */
+struct timer_opts timer_pit = {
+	init: init_pit, 
+	mark_offset: mark_offset_pit, 
+	get_offset: get_offset_pit
+};
diff -Nru a/arch/i386/kernel/timers/timer_tsc.c b/arch/i386/kernel/timers/timer_tsc.c
--- a/arch/i386/kernel/timers/timer_tsc.c	Wed Oct  9 17:08:33 2002
+++ b/arch/i386/kernel/timers/timer_tsc.c	Wed Oct  9 17:08:33 2002
@@ -1,3 +1,19 @@
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
+extern int x86_udelay_tsc;
+extern spinlock_t i8253_lock;
+
+static int use_tsc;
 /* Number of usecs that the last interrupt was delayed */
 static int delay_at_last_interrupt;
 
@@ -10,7 +26,7 @@
  */
 unsigned long fast_gettimeoffset_quotient;
 
-static inline unsigned long do_fast_gettimeoffset(void)
+static unsigned long get_offset_tsc(void)
 {
 	register unsigned long eax, edx;
 
@@ -39,36 +55,35 @@
 	return delay_at_last_interrupt + edx;
 }
 
+static void mark_offset_tsc(void)
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
@@ -83,7 +98,6 @@
 #define CALIBRATE_LATCH	(5 * LATCH)
 #define CALIBRATE_TIME	(5 * 1000020/HZ)
 
-#ifdef CONFIG_X86_TSC
 static unsigned long __init calibrate_tsc(void)
 {
        /* Set the Gate high, disable speaker */
@@ -148,7 +162,6 @@
 bad_ctc:
 	return 0;
 }
-#endif /* CONFIG_X86_TSC */
 

 #ifdef CONFIG_CPU_FREQ
@@ -196,26 +209,22 @@
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
+static int init_tsc(void)
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
@@ -239,9 +248,6 @@
 			 *	and just enable this for the next intel chips ?
 			 */
 			x86_udelay_tsc = 1;
-#ifndef do_gettimeoffset
-			do_gettimeoffset = do_fast_gettimeoffset;
-#endif
 
 			/* report CPU clock rate in Hz.
 			 * The formula is (10^6 * 2^32) / (2^32 * 1 / (clocks/us)) =
@@ -257,6 +263,17 @@
 #ifdef CONFIG_CPU_FREQ
 			cpufreq_register_notifier(&time_cpufreq_notifier_block, CPUFREQ_TRANSITION_NOTIFIER);
 #endif
+			return 1;
 		}
 	}
-#endif /* CONFIG_X86_TSC */
+	return 0;
+}
+
+/************************************************************/
+
+/* tsc timer_opts struct */
+struct timer_opts timer_tsc = {
+	init: init_tsc, 
+	mark_offset: mark_offset_tsc, 
+	get_offset: get_offset_tsc
+};
diff -Nru a/include/asm-i386/timer.h b/include/asm-i386/timer.h
--- a/include/asm-i386/timer.h	Wed Oct  9 17:08:33 2002
+++ b/include/asm-i386/timer.h	Wed Oct  9 17:08:33 2002
@@ -9,6 +9,6 @@
 	/* called by gettimeofday. returns # ms since the last timer interrupt */
 	unsigned long (*get_offset)(void);
 };
-
+#define TICK_SIZE (tick_nsec / 1000)
 struct timer_opts* select_timer(void);
 #endif

