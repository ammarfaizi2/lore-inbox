Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261907AbSJJS3B>; Thu, 10 Oct 2002 14:29:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261939AbSJJS3B>; Thu, 10 Oct 2002 14:29:01 -0400
Received: from 12-231-242-11.client.attbi.com ([12.231.242.11]:62221 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S261907AbSJJS2n>;
	Thu, 10 Oct 2002 14:28:43 -0400
Date: Thu, 10 Oct 2002 11:30:18 -0700
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Cc: johnstul@us.ibm.com
Subject: Re: [PATCH] i386 timer changes for 2.5.41
Message-ID: <20021010183017.GD25871@kroah.com>
References: <20021010182652.GA25871@kroah.com> <20021010182756.GB25871@kroah.com> <20021010182938.GC25871@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021010182938.GC25871@kroah.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.750   -> 1.751  
#	include/asm-i386/timer.h	1.1     -> 1.2    
#	arch/i386/kernel/timers/timer.c	1.1     -> 1.2    
#	  arch/i386/Makefile	1.19    -> 1.20   
#	arch/i386/kernel/time.c	1.17    -> 1.18   
#	arch/i386/kernel/timers/timer_pit.c	1.18    -> 1.19   
#	arch/i386/kernel/timers/timer_tsc.c	1.18    -> 1.19   
#	               (new)	        -> 1.1     arch/i386/kernel/timers/Makefile
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/10/10	johnstul@us.ibm.com	1.751
# i386 timer core: intergrate the new timer code to use the two different timer files.
# --------------------------------------------
#
diff -Nru a/arch/i386/Makefile b/arch/i386/Makefile
--- a/arch/i386/Makefile	Thu Oct 10 11:21:10 2002
+++ b/arch/i386/Makefile	Thu Oct 10 11:21:10 2002
@@ -53,7 +53,7 @@
 
 libs-y 					+= arch/i386/lib/
 core-y					+= arch/i386/kernel/ arch/i386/mm/ \
-					   arch/i386/$(MACHINE)/
+					   arch/i386/$(MACHINE)/ arch/i386/kernel/timers/
 drivers-$(CONFIG_MATH_EMULATION)	+= arch/i386/math-emu/
 drivers-$(CONFIG_PCI)			+= arch/i386/pci/
 
diff -Nru a/arch/i386/kernel/time.c b/arch/i386/kernel/time.c
--- a/arch/i386/kernel/time.c	Thu Oct 10 11:21:10 2002
+++ b/arch/i386/kernel/time.c	Thu Oct 10 11:21:10 2002
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
@@ -275,8 +268,6 @@
 #endif
 }
 
-static int use_tsc;
-
 /*
  * This is the same as the above, except we _also_ save the current
  * Time Stamp Counter value at the time of the timer interrupt, so that
@@ -284,8 +275,6 @@
  */
 void timer_interrupt(int irq, void *dev_id, struct pt_regs *regs)
 {
-	int count;
-
 	/*
 	 * Here we are in the timer irq handler. We just have irqs locally
 	 * disabled but we don't know if the timer_bh is running on the other
@@ -295,7 +284,7 @@
 	 */
 	write_lock(&xtime_lock);
 
-	
+	timer->mark_offset();
  
 	do_timer_interrupt(irq, NULL, regs);
 
@@ -345,6 +334,7 @@
 	return mktime(year, mon, day, hour, min, sec);
 }
 
+/* XXX this driverfs stuff should probably go elsewhere later -john */
 static struct sys_device device_i8253 = {
 	.name		= "rtc",
 	.id		= 0,
@@ -368,5 +358,6 @@
 	xtime.tv_nsec = 0;
 
 
+	timer = select_timer();
 	time_init_hook();
 }
diff -Nru a/arch/i386/kernel/timers/Makefile b/arch/i386/kernel/timers/Makefile
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/arch/i386/kernel/timers/Makefile	Thu Oct 10 11:21:10 2002
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
--- a/arch/i386/kernel/timers/timer.c	Thu Oct 10 11:21:10 2002
+++ b/arch/i386/kernel/timers/timer.c	Thu Oct 10 11:21:10 2002
@@ -2,11 +2,15 @@
 #include <asm/timer.h>
 
 /* list of externed timers */
-/* eg: extern struct timer_opts timer_XXX*/;
+extern struct timer_opts timer_pit;
+extern struct timer_opts timer_tsc;
 
 /* list of timers, ordered by preference, NULL terminated */
 static struct timer_opts* timers[] = {
-	/* eg: &timer_XXX */
+	&timer_tsc,
+#ifndef CONFIG_X86_TSC
+	&timer_pit,
+#endif
 	NULL,
 };
 
diff -Nru a/arch/i386/kernel/timers/timer_pit.c b/arch/i386/kernel/timers/timer_pit.c
--- a/arch/i386/kernel/timers/timer_pit.c	Thu Oct 10 11:21:10 2002
+++ b/arch/i386/kernel/timers/timer_pit.c	Thu Oct 10 11:21:10 2002
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
+	return 0;
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
+	.init =		init_pit, 
+	.mark_offset =	mark_offset_pit, 
+	.get_offset =	get_offset_pit,
+};
diff -Nru a/arch/i386/kernel/timers/timer_tsc.c b/arch/i386/kernel/timers/timer_tsc.c
--- a/arch/i386/kernel/timers/timer_tsc.c	Thu Oct 10 11:21:10 2002
+++ b/arch/i386/kernel/timers/timer_tsc.c	Thu Oct 10 11:21:10 2002
@@ -1,3 +1,20 @@
+/*
+ * This code largely moved from arch/i386/kernel/time.c.
+ * See comments there for proper credits.
+ */
+
+#include <linux/spinlock.h>
+#include <linux/init.h>
+#include <linux/timex.h>
+#include <linux/errno.h>
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
 
@@ -10,7 +27,7 @@
  */
 unsigned long fast_gettimeoffset_quotient;
 
-static inline unsigned long do_fast_gettimeoffset(void)
+static unsigned long get_offset_tsc(void)
 {
 	register unsigned long eax, edx;
 
@@ -39,36 +56,35 @@
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
@@ -83,7 +99,6 @@
 #define CALIBRATE_LATCH	(5 * LATCH)
 #define CALIBRATE_TIME	(5 * 1000020/HZ)
 
-#ifdef CONFIG_X86_TSC
 static unsigned long __init calibrate_tsc(void)
 {
        /* Set the Gate high, disable speaker */
@@ -148,7 +163,6 @@
 bad_ctc:
 	return 0;
 }
-#endif /* CONFIG_X86_TSC */
 
 
 #ifdef CONFIG_CPU_FREQ
@@ -196,26 +210,22 @@
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
@@ -239,9 +249,6 @@
 			 *	and just enable this for the next intel chips ?
 			 */
 			x86_udelay_tsc = 1;
-#ifndef do_gettimeoffset
-			do_gettimeoffset = do_fast_gettimeoffset;
-#endif
 
 			/* report CPU clock rate in Hz.
 			 * The formula is (10^6 * 2^32) / (2^32 * 1 / (clocks/us)) =
@@ -257,6 +264,17 @@
 #ifdef CONFIG_CPU_FREQ
 			cpufreq_register_notifier(&time_cpufreq_notifier_block, CPUFREQ_TRANSITION_NOTIFIER);
 #endif
+			return 0;
 		}
 	}
-#endif /* CONFIG_X86_TSC */
+	return -ENODEV;
+}
+
+/************************************************************/
+
+/* tsc timer_opts struct */
+struct timer_opts timer_tsc = {
+	.init =		init_tsc,
+	.mark_offset =	mark_offset_tsc, 
+	.get_offset =	get_offset_tsc,
+};
diff -Nru a/include/asm-i386/timer.h b/include/asm-i386/timer.h
--- a/include/asm-i386/timer.h	Thu Oct 10 11:21:10 2002
+++ b/include/asm-i386/timer.h	Thu Oct 10 11:21:10 2002
@@ -16,5 +16,7 @@
 	unsigned long (*get_offset)(void);
 };
 
+#define TICK_SIZE (tick_nsec / 1000)
+
 extern struct timer_opts* select_timer(void);
 #endif
