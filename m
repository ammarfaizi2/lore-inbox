Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262466AbTCIEdS>; Sat, 8 Mar 2003 23:33:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262470AbTCIEdS>; Sat, 8 Mar 2003 23:33:18 -0500
Received: from chii.cinet.co.jp ([61.197.228.217]:52096 "EHLO
	yuzuki.cinet.co.jp") by vger.kernel.org with ESMTP
	id <S262466AbTCIEcy>; Sat, 8 Mar 2003 23:32:54 -0500
Date: Sun, 9 Mar 2003 13:42:59 +0900
From: Osamu Tomita <tomita@cinet.co.jp>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] PC-9800 subarch. support for 2.5.64-ac3 (20/20) timer
Message-ID: <20030309044259.GU1231@yuzuki.cinet.co.jp>
References: <20030309035245.GA1231@yuzuki.cinet.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030309035245.GA1231@yuzuki.cinet.co.jp>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the patch to support NEC PC-9800 subarchitecture
against 2.5.64-ac3. (20/20)

Support difference of timer, using mach-* scheme.
 - Change CLOCK_TICK_RATE from constant to variable.
   Some PC98 can select base clock at boottime.
 - Replace calibrate_tsc function using anoter time counter on PC98.
   Because PIT channel2 on notebook PC98 is stopped.

Regards,
Osamu Tomita


diff -Nru linux-2.5.63/arch/i386/kernel/timers/timer_pit.c linux98-2.5.63/arch/i386/kernel/timers/timer_pit.c
--- linux-2.5.63/arch/i386/kernel/timers/timer_pit.c	2003-02-25 04:05:41.000000000 +0900
+++ linux98-2.5.63/arch/i386/kernel/timers/timer_pit.c	2003-03-04 14:58:59.000000000 +0900
@@ -16,9 +16,13 @@
 extern spinlock_t i8259A_lock;
 extern spinlock_t i8253_lock;
 #include "do_timer.h"
+#include "io_ports.h"
+
+static int count_p; /* counter in get_offset_pit() */
 
 static int init_pit(void)
 {
+	count_p = LATCH;
 	return 0;
 }
 
@@ -77,7 +81,6 @@
 {
 	int count;
 	unsigned long flags;
-	static int count_p = LATCH;    /* for the first call after boot */
 	static unsigned long jiffies_p = 0;
 
 	/*
@@ -87,9 +90,9 @@
 
 	spin_lock_irqsave(&i8253_lock, flags);
 	/* timer count may underflow right here */
-	outb_p(0x00, 0x43);	/* latch the count ASAP */
+	outb_p(0x00, PIT_MODE);	/* latch the count ASAP */
 
-	count = inb_p(0x40);	/* read the latched count */
+	count = inb_p(PIT_CH0);	/* read the latched count */
 
 	/*
 	 * We do this guaranteed double memory access instead of a _p 
@@ -97,13 +100,13 @@
 	 */
  	jiffies_t = jiffies;
 
-	count |= inb_p(0x40) << 8;
+	count |= inb_p(PIT_CH0) << 8;
 	
         /* VIA686a test code... reset the latch if count > max + 1 */
         if (count > LATCH) {
-                outb_p(0x34, 0x43);
-                outb_p(LATCH & 0xff, 0x40);
-                outb(LATCH >> 8, 0x40);
+                outb_p(0x34, PIT_MODE);
+                outb_p(LATCH & 0xff, PIT_CH0);
+                outb(LATCH >> 8, PIT_CH0);
                 count = LATCH - 1;
         }
 	
diff -Nru linux-2.5.63/arch/i386/kernel/timers/timer_tsc.c linux98-2.5.63/arch/i386/kernel/timers/timer_tsc.c
--- linux-2.5.63/arch/i386/kernel/timers/timer_tsc.c	2003-02-25 04:05:37.000000000 +0900
+++ linux98-2.5.63/arch/i386/kernel/timers/timer_tsc.c	2003-03-04 14:39:42.000000000 +0900
@@ -14,6 +14,9 @@
 /* processor.h for distable_tsc flag */
 #include <asm/processor.h>
 
+#include "io_ports.h"
+#include "mach_timer.h"
+
 int tsc_disable __initdata = 0;
 
 extern spinlock_t i8253_lock;
@@ -24,6 +27,8 @@
 
 static unsigned long last_tsc_low; /* lsb 32 bits of Time Stamp Counter */
 
+static int count2; /* counter for mark_offset_tsc() */
+
 /* Cached *multiplier* to convert TSC counts to microseconds.
  * (see the equation below).
  * Equal to 2^32 * (1 / (clocks per usec) ).
@@ -64,7 +69,7 @@
 {
 	int count;
 	int countmp;
-	static int count1=0, count2=LATCH;
+	static int count1 = 0;
 	/*
 	 * It is important that these two operations happen almost at
 	 * the same time. We do the RDTSC stuff first, since it's
@@ -82,10 +87,10 @@
 	rdtscl(last_tsc_low);
 
 	spin_lock(&i8253_lock);
-	outb_p(0x00, 0x43);     /* latch the count ASAP */
+	outb_p(0x00, PIT_MODE);     /* latch the count ASAP */
 
-	count = inb_p(0x40);    /* read the latched count */
-	count |= inb(0x40) << 8;
+	count = inb_p(PIT_CH0);    /* read the latched count */
+	count |= inb(PIT_CH0) << 8;
 	spin_unlock(&i8253_lock);
 
 	if (pit_latch_buggy) {
@@ -127,26 +132,11 @@
  * device.
  */
 
-#define CALIBRATE_LATCH	(5 * LATCH)
 #define CALIBRATE_TIME	(5 * 1000020/HZ)
 
 unsigned long __init calibrate_tsc(void)
 {
-       /* Set the Gate high, disable speaker */
-	outb((inb(0x61) & ~0x02) | 0x01, 0x61);
-
-	/*
-	 * Now let's take care of CTC channel 2
-	 *
-	 * Set the Gate high, program CTC channel 2 for mode 0,
-	 * (interrupt on terminal count mode), binary count,
-	 * load 5 * LATCH count, (LSB and MSB) to begin countdown.
-	 *
-	 * Some devices need a delay here.
-	 */
-	outb(0xb0, 0x43);			/* binary, mode 0, LSB/MSB, Ch 2 */
-	outb_p(CALIBRATE_LATCH & 0xff, 0x42);	/* LSB of count */
-	outb_p(CALIBRATE_LATCH >> 8, 0x42);       /* MSB of count */
+	mach_prepare_counter();
 
 	{
 		unsigned long startlow, starthigh;
@@ -154,10 +144,7 @@
 		unsigned long count;
 
 		rdtsc(startlow,starthigh);
-		count = 0;
-		do {
-			count++;
-		} while ((inb(0x61) & 0x20) == 0);
+		mach_countup(&count);
 		rdtsc(endlow,endhigh);
 
 		last_tsc_low = endlow;
@@ -273,6 +260,8 @@
 	cpufreq_register_notifier(&time_cpufreq_notifier_block, CPUFREQ_TRANSITION_NOTIFIER);
 #endif
 
+	count2 = LATCH; /* initialize counter for mark_offset_tsc() */
+
 	if (cpu_has_tsc) {
 		unsigned long tsc_quotient = calibrate_tsc();
 		if (tsc_quotient) {
diff -Nru linux/include/asm-i386/mach-default/mach_timer.h linux98/include/asm-i386/mach-default/mach_timer.h
--- linux/include/asm-i386/mach-default/mach_timer.h	1970-01-01 09:00:00.000000000 +0900
+++ linux98/include/asm-i386/mach-default/mach_timer.h	2003-03-04 15:39:44.000000000 +0900
@@ -0,0 +1,46 @@
+/*
+ *  include/asm-i386/mach-default/mach_timer.h
+ *
+ *  Machine specific calibrate_tsc() for generic.
+ *  Split out from timer_tsc.c by Osamu Tomita <tomita@cinet.co.jp>
+ */
+/* ------ Calibrate the TSC ------- 
+ * Return 2^32 * (1 / (TSC clocks per usec)) for do_fast_gettimeoffset().
+ * Too much 64-bit arithmetic here to do this cleanly in C, and for
+ * accuracy's sake we want to keep the overhead on the CTC speaker (channel 2)
+ * output busy loop as low as possible. We avoid reading the CTC registers
+ * directly because of the awkward 8-bit access mechanism of the 82C54
+ * device.
+ */
+#ifndef _MACH_TIMER_H
+#define _MACH_TIMER_H
+
+#define CALIBRATE_LATCH	(5 * LATCH)
+
+static inline void mach_prepare_counter(void)
+{
+       /* Set the Gate high, disable speaker */
+	outb((inb(0x61) & ~0x02) | 0x01, 0x61);
+
+	/*
+	 * Now let's take care of CTC channel 2
+	 *
+	 * Set the Gate high, program CTC channel 2 for mode 0,
+	 * (interrupt on terminal count mode), binary count,
+	 * load 5 * LATCH count, (LSB and MSB) to begin countdown.
+	 *
+	 * Some devices need a delay here.
+	 */
+	outb(0xb0, 0x43);			/* binary, mode 0, LSB/MSB, Ch 2 */
+	outb_p(CALIBRATE_LATCH & 0xff, 0x42);	/* LSB of count */
+	outb_p(CALIBRATE_LATCH >> 8, 0x42);       /* MSB of count */
+}
+
+static inline void mach_countup(unsigned long *count)
+{
+	do {
+		*count++;
+	} while ((inb(0x61) & 0x20) == 0);
+}
+
+#endif /* !_MACH_TIMER_H */
diff -Nru linux-2.5.64/include/asm-i386/mach-pc9800/do_timer.h linux98-2.5.64/include/asm-i386/mach-pc9800/do_timer.h
--- linux-2.5.64/include/asm-i386/mach-pc9800/do_timer.h	1970-01-01 09:00:00.000000000 +0900
+++ linux98-2.5.64/include/asm-i386/mach-pc9800/do_timer.h	2003-03-05 13:37:30.000000000 +0900
@@ -0,0 +1,82 @@
+/* defines for inline arch setup functions */
+
+#include <asm/apic.h>
+
+/**
+ * do_timer_interrupt_hook - hook into timer tick
+ * @regs:	standard registers from interrupt
+ *
+ * Description:
+ *	This hook is called immediately after the timer interrupt is ack'd.
+ *	It's primary purpose is to allow architectures that don't possess
+ *	individual per CPU clocks (like the CPU APICs supply) to broadcast the
+ *	timer interrupt as a means of triggering reschedules etc.
+ **/
+
+static inline void do_timer_interrupt_hook(struct pt_regs *regs)
+{
+	do_timer(regs);
+/*
+ * In the SMP case we use the local APIC timer interrupt to do the
+ * profiling, except when we simulate SMP mode on a uniprocessor
+ * system, in that case we have to call the local interrupt handler.
+ */
+#ifndef CONFIG_X86_LOCAL_APIC
+	x86_do_profile(regs);
+#else
+	if (!using_apic_timer)
+		smp_local_timer_interrupt(regs);
+#endif
+}
+
+
+/* you can safely undefine this if you don't have the Neptune chipset */
+
+#define BUGGY_NEPTUN_TIMER
+
+/**
+ * do_timer_overflow - process a detected timer overflow condition
+ * @count:	hardware timer interrupt count on overflow
+ *
+ * Description:
+ *	This call is invoked when the jiffies count has not incremented but
+ *	the hardware timer interrupt has.  It means that a timer tick interrupt
+ *	came along while the previous one was pending, thus a tick was missed
+ **/
+static inline int do_timer_overflow(int count)
+{
+	int i;
+
+	spin_lock(&i8259A_lock);
+	/*
+	 * This is tricky when I/O APICs are used;
+	 * see do_timer_interrupt().
+	 */
+	i = inb(0x00);
+	spin_unlock(&i8259A_lock);
+	
+	/* assumption about timer being IRQ0 */
+	if (i & 0x01) {
+		/*
+		 * We cannot detect lost timer interrupts ... 
+		 * well, that's why we call them lost, don't we? :)
+		 * [hmm, on the Pentium and Alpha we can ... sort of]
+		 */
+		count -= LATCH;
+	} else {
+#ifdef BUGGY_NEPTUN_TIMER
+		/*
+		 * for the Neptun bug we know that the 'latch'
+		 * command doesn't latch the high and low value
+		 * of the counter atomically. Thus we have to 
+		 * substract 256 from the counter 
+		 * ... funny, isnt it? :)
+		 */
+		
+		count -= 256;
+#else
+		printk("do_slow_gettimeoffset(): hardware timer problem?\n");
+#endif
+	}
+	return count;
+}
diff -Nru linux/include/asm-i386/mach-pc9800/mach_timer.h linux98/include/asm-i386/mach-pc9800/mach_timer.h
--- linux/include/asm-i386/mach-pc9800/mach_timer.h	1970-01-01 09:00:00.000000000 +0900
+++ linux98/include/asm-i386/mach-pc9800/mach_timer.h	2003-03-04 15:43:29.000000000 +0900
@@ -0,0 +1,31 @@
+/*
+ *  include/asm-i386/mach-pc9800/mach_timer.h
+ *
+ *  Machine specific calibrate_tsc() for PC-9800.
+ *  Written by Osamu Tomita <tomita@cinet.co.jp>
+ */
+/* ------ Calibrate the TSC ------- 
+ * PC-9800:
+ *  CTC cannot be used because some models (especially
+ *  note-machines) may disable clock to speaker channel (#1)
+ *  unless speaker is enabled.  We use ARTIC instead.
+ */
+#ifndef _MACH_TIMER_H
+#define _MACH_TIMER_H
+
+#define CALIBRATE_LATCH	(5 * 307200/HZ) /* 0.050sec * 307200Hz = 15360 */
+
+static inline void mach_prepare_counter(void)
+{
+	/* ARTIC can't be stopped nor reset. So we wait roundup. */
+	while (inw(0x5c));
+}
+
+static inline void mach_countup(unsigned long *count)
+{
+	do {
+		*count = inw(0x5c);
+	} while (*count < CALIBRATE_LATCH);
+}
+
+#endif /* !_MACH_TIMER_H */
diff -Nru linux/include/asm-i386/timex.h linux98/include/asm-i386/timex.h
--- linux/include/asm-i386/timex.h	2002-02-14 18:09:15.000000000 +0900
+++ linux98/include/asm-i386/timex.h	2002-02-14 23:58:57.000000000 +0900
@@ -9,11 +9,15 @@
 #include <linux/config.h>
 #include <asm/msr.h>
 
+#ifdef CONFIG_X86_PC9800
+   extern int CLOCK_TICK_RATE;
+#else
 #ifdef CONFIG_MELAN
 #  define CLOCK_TICK_RATE 1189200 /* AMD Elan has different frequency! */
 #else
 #  define CLOCK_TICK_RATE 1193180 /* Underlying HZ */
 #endif
+#endif
 
 #define CLOCK_TICK_FACTOR	20	/* Factor of both 1000000 and CLOCK_TICK_RATE */
 #define FINETUNE ((((((long)LATCH * HZ - CLOCK_TICK_RATE) << SHIFT_HZ) * \
diff -Nru linux-2.5.63/kernel/timer.c linux98-2.5.63/kernel/timer.c
--- linux-2.5.63/kernel/timer.c	2003-02-25 04:05:41.000000000 +0900
+++ linux98-2.5.63/kernel/timer.c	2003-03-04 15:13:37.000000000 +0900
@@ -437,8 +437,13 @@
 /*
  * Timekeeping variables
  */
+#ifdef CONFIG_X86_PC9800
+unsigned long tick_usec; 			/* ACTHZ   period (usec) */
+unsigned long tick_nsec;			/* USER_HZ period (nsec) */
+#else
 unsigned long tick_usec = TICK_USEC; 		/* ACTHZ   period (usec) */
 unsigned long tick_nsec = TICK_NSEC(TICK_USEC);	/* USER_HZ period (nsec) */
+#endif
 
 /* The current time */
 struct timespec xtime __attribute__ ((aligned (16)));
