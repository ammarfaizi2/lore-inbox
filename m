Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319149AbSHTDGM>; Mon, 19 Aug 2002 23:06:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319150AbSHTDGM>; Mon, 19 Aug 2002 23:06:12 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:48786 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S319149AbSHTDGC>;
	Mon, 19 Aug 2002 23:06:02 -0400
Subject: [RFC][PATCH] linux_2-4-20-pre3_timer-changes_A1
From: john stultz <johnstul@us.ibm.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 19 Aug 2002 19:53:53 -0700
Message-Id: <1029812033.947.253.camel@cog>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan, all
	Here is the backport of my 2.5 timer changes/cleanups. Basically it
splits the TSC and PIT timer code into their own files, then creates an
abstract interface (struct timer_ops) to use them. This should aid in
adding new timers (cyclone, ACPI,etc) as well as just help cleaning up
the time code.  I have further cleanups planned, but want to keep the
changes understandable for now. Compiles and boots, but handle with
care.

Let me know what you think. 

thanks
-john

diff -Nru a/arch/i386/kernel/Makefile b/arch/i386/kernel/Makefile
--- a/arch/i386/kernel/Makefile	Mon Aug 19 19:52:28 2002
+++ b/arch/i386/kernel/Makefile	Mon Aug 19 19:52:28 2002
@@ -14,11 +14,13 @@
 
 O_TARGET := kernel.o
 
-export-objs     := mca.o mtrr.o msr.o cpuid.o microcode.o i386_ksyms.o time.o
+export-objs     := mca.o mtrr.o msr.o cpuid.o microcode.o i386_ksyms.o \
+				time.o timer_pit.o
 
 obj-y	:= process.o semaphore.o signal.o entry.o traps.o irq.o vm86.o \
 		ptrace.o i8259.o ioport.o ldt.o setup.o time.o sys_i386.o \
-		pci-dma.o i386_ksyms.o i387.o bluesmoke.o dmi_scan.o
+		pci-dma.o i386_ksyms.o i387.o bluesmoke.o dmi_scan.o \
+		timer.o timer_pit.o timer_tsc.o
 

 ifdef CONFIG_PCI
diff -Nru a/arch/i386/kernel/time.c b/arch/i386/kernel/time.c
--- a/arch/i386/kernel/time.c	Mon Aug 19 19:52:28 2002
+++ b/arch/i386/kernel/time.c	Mon Aug 19 19:52:28 2002
@@ -51,6 +51,7 @@
 #include <asm/mpspec.h>
 #include <asm/uaccess.h>
 #include <asm/processor.h>
+#include <asm/timer.h>
 
 #include <linux/mc146818rtc.h>
 #include <linux/timex.h>
@@ -65,202 +66,16 @@
 #include <linux/irq.h>
 

-unsigned long cpu_khz;	/* Detected as we calibrate the TSC */
-
-/* Number of usecs that the last interrupt was delayed */
-static int delay_at_last_interrupt;
-
-static unsigned long last_tsc_low; /* lsb 32 bits of Time Stamp Counter */
-
-/* Cached *multiplier* to convert TSC counts to microseconds.
- * (see the equation below).
- * Equal to 2^32 * (1 / (clocks per usec) ).
- * Initialized in time_init.
- */
-unsigned long fast_gettimeoffset_quotient;
 
 extern rwlock_t xtime_lock;
 extern unsigned long wall_jiffies;
 
 spinlock_t rtc_lock = SPIN_LOCK_UNLOCKED;
 
-static inline unsigned long do_fast_gettimeoffset(void)
-{
-	register unsigned long eax, edx;
-
-	/* Read the Time Stamp Counter */
-
-	rdtsc(eax,edx);
-
-	/* .. relative to previous jiffy (32 bits is enough) */
-	eax -= last_tsc_low;	/* tsc_low delta */
-
-	/*
-         * Time offset = (tsc_low delta) * fast_gettimeoffset_quotient
-         *             = (tsc_low delta) * (usecs_per_clock)
-         *             = (tsc_low delta) * (usecs_per_jiffy / clocks_per_jiffy)
-	 *
-	 * Using a mull instead of a divl saves up to 31 clock cycles
-	 * in the critical path.
-         */
-
-	__asm__("mull %2"
-		:"=a" (eax), "=d" (edx)
-		:"rm" (fast_gettimeoffset_quotient),
-		 "0" (eax));
-
-	/* our adjusted time offset in microseconds */
-	return delay_at_last_interrupt + edx;
-}
-
-#define TICK_SIZE tick
-
-spinlock_t i8253_lock = SPIN_LOCK_UNLOCKED;
-
-EXPORT_SYMBOL(i8253_lock);
 
 extern spinlock_t i8259A_lock;
 
-#ifndef CONFIG_X86_TSC
-
-/* This function must be called with interrupts disabled 
- * It was inspired by Steve McCanne's microtime-i386 for BSD.  -- jrs
- * 
- * However, the pc-audio speaker driver changes the divisor so that
- * it gets interrupted rather more often - it loads 64 into the
- * counter rather than 11932! This has an adverse impact on
- * do_gettimeoffset() -- it stops working! What is also not
- * good is that the interval that our timer function gets called
- * is no longer 10.0002 ms, but 9.9767 ms. To get around this
- * would require using a different timing source. Maybe someone
- * could use the RTC - I know that this can interrupt at frequencies
- * ranging from 8192Hz to 2Hz. If I had the energy, I'd somehow fix
- * it so that at startup, the timer code in sched.c would select
- * using either the RTC or the 8253 timer. The decision would be
- * based on whether there was any other device around that needed
- * to trample on the 8253. I'd set up the RTC to interrupt at 1024 Hz,
- * and then do some jiggery to have a version of do_timer that 
- * advanced the clock by 1/1024 s. Every time that reached over 1/100
- * of a second, then do all the old code. If the time was kept correct
- * then do_gettimeoffset could just return 0 - there is no low order
- * divider that can be accessed.
- *
- * Ideally, you would be able to use the RTC for the speaker driver,
- * but it appears that the speaker driver really needs interrupt more
- * often than every 120 us or so.
- *
- * Anyway, this needs more thought....		pjsg (1993-08-28)
- * 
- * If you are really that interested, you should be reading
- * comp.protocols.time.ntp!
- */
-
-static unsigned long do_slow_gettimeoffset(void)
-{
-	int count;
-
-	static int count_p = LATCH;    /* for the first call after boot */
-	static unsigned long jiffies_p = 0;
-
-	/*
-	 * cache volatile jiffies temporarily; we have IRQs turned off. 
-	 */
-	unsigned long jiffies_t;
-
-	/* gets recalled with irq locally disabled */
-	spin_lock(&i8253_lock);
-	/* timer count may underflow right here */
-	outb_p(0x00, 0x43);	/* latch the count ASAP */
-
-	count = inb_p(0x40);	/* read the latched count */
-
-	/*
-	 * We do this guaranteed double memory access instead of a _p 
-	 * postfix in the previous port access. Wheee, hackady hack
-	 */
- 	jiffies_t = jiffies;
-
-	count |= inb_p(0x40) << 8;
-	
-        /* VIA686a test code... reset the latch if count > max + 1 */
-        if (count > LATCH) {
-                outb_p(0x34, 0x43);
-                outb_p(LATCH & 0xff, 0x40);
-                outb(LATCH >> 8, 0x40);
-                count = LATCH - 1;
-        }
-	
-	spin_unlock(&i8253_lock);
-
-	/*
-	 * avoiding timer inconsistencies (they are rare, but they happen)...
-	 * there are two kinds of problems that must be avoided here:
-	 *  1. the timer counter underflows
-	 *  2. hardware problem with the timer, not giving us continuous time,
-	 *     the counter does small "jumps" upwards on some Pentium systems,
-	 *     (see c't 95/10 page 335 for Neptun bug.)
-	 */
-
-/* you can safely undefine this if you don't have the Neptune chipset */
-
-#define BUGGY_NEPTUN_TIMER
-
-	if( jiffies_t == jiffies_p ) {
-		if( count > count_p ) {
-			/* the nutcase */
-
-			int i;
-
-			spin_lock(&i8259A_lock);
-			/*
-			 * This is tricky when I/O APICs are used;
-			 * see do_timer_interrupt().
-			 */
-			i = inb(0x20);
-			spin_unlock(&i8259A_lock);
-
-			/* assumption about timer being IRQ0 */
-			if (i & 0x01) {
-				/*
-				 * We cannot detect lost timer interrupts ... 
-				 * well, that's why we call them lost, don't we? :)
-				 * [hmm, on the Pentium and Alpha we can ... sort of]
-				 */
-				count -= LATCH;
-			} else {
-#ifdef BUGGY_NEPTUN_TIMER
-				/*
-				 * for the Neptun bug we know that the 'latch'
-				 * command doesnt latch the high and low value
-				 * of the counter atomically. Thus we have to 
-				 * substract 256 from the counter 
-				 * ... funny, isnt it? :)
-				 */
-
-				count -= 256;
-#else
-				printk("do_slow_gettimeoffset(): hardware timer problem?\n");
-#endif
-			}
-		}
-	} else
-		jiffies_p = jiffies_t;
-
-	count_p = count;
-
-	count = ((LATCH-1) - count) * TICK_SIZE;
-	count = (count + LATCH/2) / LATCH;
-
-	return count;
-}
-
-static unsigned long (*do_gettimeoffset)(void) = do_slow_gettimeoffset;
-
-#else
-
-#define do_gettimeoffset()	do_fast_gettimeoffset()
-
-#endif
+struct timer_opts* timer;
 
 /*
  * This version of gettimeofday has microsecond resolution
@@ -272,7 +87,7 @@
 	unsigned long usec, sec;
 
 	read_lock_irqsave(&xtime_lock, flags);
-	usec = do_gettimeoffset();
+	usec = timer->get_offset();
 	{
 		unsigned long lost = jiffies - wall_jiffies;
 		if (lost)
@@ -300,7 +115,7 @@
 	 * wall time.  Discover what correction gettimeofday() would have
 	 * made, and then undo it!
 	 */
-	tv->tv_usec -= do_gettimeoffset();
+	tv->tv_usec -= timer->get_offset();
 	tv->tv_usec -= (jiffies - wall_jiffies) * (1000000 / HZ);
 
 	while (tv->tv_usec < 0) {
@@ -461,8 +276,6 @@
 #endif
 }
 
-static int use_tsc;
-
 /*
  * This is the same as the above, except we _also_ save the current
  * Time Stamp Counter value at the time of the timer interrupt, so that
@@ -481,34 +294,7 @@
 	 */
 	write_lock(&xtime_lock);
 
-	if (use_tsc)
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
-	
-		/* read Pentium cycle counter */
-
-		rdtscl(last_tsc_low);
-
-		spin_lock(&i8253_lock);
-		outb_p(0x00, 0x43);     /* latch the count ASAP */
-
-		count = inb_p(0x40);    /* read the latched count */
-		count |= inb(0x40) << 8;
-		spin_unlock(&i8253_lock);
-
-		count = ((LATCH-1) - count) * TICK_SIZE;
-		delay_at_last_interrupt = (count + LATCH/2) / LATCH;
-	}
+	timer->mark_offset();
  
 	do_timer_interrupt(irq, NULL, regs);
 
@@ -560,82 +346,6 @@
 
 static struct irqaction irq0  = { timer_interrupt, SA_INTERRUPT, 0, "timer", NULL, NULL};
 
-/* ------ Calibrate the TSC ------- 
- * Return 2^32 * (1 / (TSC clocks per usec)) for do_fast_gettimeoffset().
- * Too much 64-bit arithmetic here to do this cleanly in C, and for
- * accuracy's sake we want to keep the overhead on the CTC speaker (channel 2)
- * output busy loop as low as possible. We avoid reading the CTC registers
- * directly because of the awkward 8-bit access mechanism of the 82C54
- * device.
- */
-
-#define CALIBRATE_LATCH	(5 * LATCH)
-#define CALIBRATE_TIME	(5 * 1000020/HZ)
-
-static unsigned long __init calibrate_tsc(void)
-{
-       /* Set the Gate high, disable speaker */
-	outb((inb(0x61) & ~0x02) | 0x01, 0x61);
-
-	/*
-	 * Now let's take care of CTC channel 2
-	 *
-	 * Set the Gate high, program CTC channel 2 for mode 0,
-	 * (interrupt on terminal count mode), binary count,
-	 * load 5 * LATCH count, (LSB and MSB) to begin countdown.
-	 */
-	outb(0xb0, 0x43);			/* binary, mode 0, LSB/MSB, Ch 2 */
-	outb(CALIBRATE_LATCH & 0xff, 0x42);	/* LSB of count */
-	outb(CALIBRATE_LATCH >> 8, 0x42);	/* MSB of count */
-
-	{
-		unsigned long startlow, starthigh;
-		unsigned long endlow, endhigh;
-		unsigned long count;
-
-		rdtsc(startlow,starthigh);
-		count = 0;
-		do {
-			count++;
-		} while ((inb(0x61) & 0x20) == 0);
-		rdtsc(endlow,endhigh);
-
-		last_tsc_low = endlow;
-
-		/* Error: ECTCNEVERSET */
-		if (count <= 1)
-			goto bad_ctc;
-
-		/* 64-bit subtract - gcc just messes up with long longs */
-		__asm__("subl %2,%0\n\t"
-			"sbbl %3,%1"
-			:"=a" (endlow), "=d" (endhigh)
-			:"g" (startlow), "g" (starthigh),
-			 "0" (endlow), "1" (endhigh));
-
-		/* Error: ECPUTOOFAST */
-		if (endhigh)
-			goto bad_ctc;
-
-		/* Error: ECPUTOOSLOW */
-		if (endlow <= CALIBRATE_TIME)
-			goto bad_ctc;
-
-		__asm__("divl %2"
-			:"=a" (endlow), "=d" (endhigh)
-			:"r" (endlow), "0" (0), "1" (CALIBRATE_TIME));
-
-		return endlow;
-	}
-
-	/*
-	 * The CTC wasn't reliable: we got a hit on the very first read,
-	 * or the CPU was so fast/slow that the quotient wouldn't fit in
-	 * 32 bits..
-	 */
-bad_ctc:
-	return 0;
-}
 
 void __init time_init(void)
 {
@@ -671,34 +381,8 @@
  
  	dodgy_tsc();
  	
-	if (cpu_has_tsc) {
-		unsigned long tsc_quotient = calibrate_tsc();
-		if (tsc_quotient) {
-			fast_gettimeoffset_quotient = tsc_quotient;
-			use_tsc = 1;
-			/*
-			 *	We could be more selective here I suspect
-			 *	and just enable this for the next intel chips ?
-			 */
-			x86_udelay_tsc = 1;
-#ifndef do_gettimeoffset
-			do_gettimeoffset = do_fast_gettimeoffset;
-#endif
-
-			/* report CPU clock rate in Hz.
-			 * The formula is (10^6 * 2^32) / (2^32 * 1 / (clocks/us)) =
-			 * clock/second. Our precision is about 100 ppm.
-			 */
-			{	unsigned long eax=0, edx=1000;
-				__asm__("divl %2"
-		       		:"=a" (cpu_khz), "=d" (edx)
-        	       		:"r" (tsc_quotient),
-	                	"0" (eax), "1" (edx));
-				printk("Detected %lu.%03lu MHz processor.\n", cpu_khz / 1000, cpu_khz % 1000);
-			}
-		}
-	}
-
+	timer = select_timer();
+	
 #ifdef CONFIG_VISWS
 	printk("Starting Cobalt Timer system clock\n");
 
diff -Nru a/arch/i386/kernel/timer.c b/arch/i386/kernel/timer.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/arch/i386/kernel/timer.c	Mon Aug 19 19:52:28 2002
@@ -0,0 +1,28 @@
+#include <linux/kernel.h>
+
+#include <asm/timer.h>
+
+/*list of externed timers*/
+extern struct timer_opts timer_pit;
+extern struct timer_opts timer_tsc;
+
+/*list of timers, ordered by preference*/
+struct timer_opts* timers[] = {
+	&timer_tsc,
+	&timer_pit
+};
+
+#define NR_TIMERS (sizeof(timers)/sizeof(timers[0]))
+
+/* iterates through the list of timers, returning the first 
+ * one that initializes successfully.
+ */
+struct timer_opts* select_timer(void)
+{
+	int i;
+	for(i=0; i < NR_TIMERS; i++)
+		if(timers[i]->init())
+			return timers[i];
+	panic("select_timer: Cannot find a suitable timer\n");
+	return 0;
+}
diff -Nru a/arch/i386/kernel/timer_pit.c b/arch/i386/kernel/timer_pit.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/arch/i386/kernel/timer_pit.c	Mon Aug 19 19:52:28 2002
@@ -0,0 +1,164 @@
+#include <linux/spinlock.h>
+#include <linux/module.h>
+#include <asm/timer.h>
+#include <asm/io.h>
+
+/*fwd declarations*/
+int init_pit(void);
+void mark_offset_pit(void);
+unsigned long get_offset_pit(void);
+
+/*tsc timer_opts struct*/
+struct timer_opts timer_pit = {
+	init: init_pit, 
+	mark_offset: mark_offset_pit, 
+	get_offset: get_offset_pit
+};
+
+
+extern spinlock_t i8259A_lock;
+spinlock_t i8253_lock = SPIN_LOCK_UNLOCKED;
+EXPORT_SYMBOL(i8253_lock);
+
+
+int init_pit(void)
+{
+	return 1;
+}
+
+void mark_offset_pit(void)
+{
+	/*nothing needed*/
+}
+
+
+/* This function must be called with interrupts disabled 
+ * It was inspired by Steve McCanne's microtime-i386 for BSD.  -- jrs
+ * 
+ * However, the pc-audio speaker driver changes the divisor so that
+ * it gets interrupted rather more often - it loads 64 into the
+ * counter rather than 11932! This has an adverse impact on
+ * do_gettimeoffset() -- it stops working! What is also not
+ * good is that the interval that our timer function gets called
+ * is no longer 10.0002 ms, but 9.9767 ms. To get around this
+ * would require using a different timing source. Maybe someone
+ * could use the RTC - I know that this can interrupt at frequencies
+ * ranging from 8192Hz to 2Hz. If I had the energy, I'd somehow fix
+ * it so that at startup, the timer code in sched.c would select
+ * using either the RTC or the 8253 timer. The decision would be
+ * based on whether there was any other device around that needed
+ * to trample on the 8253. I'd set up the RTC to interrupt at 1024 Hz,
+ * and then do some jiggery to have a version of do_timer that 
+ * advanced the clock by 1/1024 s. Every time that reached over 1/100
+ * of a second, then do all the old code. If the time was kept correct
+ * then do_gettimeoffset could just return 0 - there is no low order
+ * divider that can be accessed.
+ *
+ * Ideally, you would be able to use the RTC for the speaker driver,
+ * but it appears that the speaker driver really needs interrupt more
+ * often than every 120 us or so.
+ *
+ * Anyway, this needs more thought....		pjsg (1993-08-28)
+ * 
+ * If you are really that interested, you should be reading
+ * comp.protocols.time.ntp!
+ */
+
+unsigned long get_offset_pit(void)
+{
+	int count;
+
+	static int count_p = LATCH;    /* for the first call after boot */
+	static unsigned long jiffies_p = 0;
+
+	/*
+	 * cache volatile jiffies temporarily; we have IRQs turned off. 
+	 */
+	unsigned long jiffies_t;
+
+	/* gets recalled with irq locally disabled */
+	spin_lock(&i8253_lock);
+	/* timer count may underflow right here */
+	outb_p(0x00, 0x43);	/* latch the count ASAP */
+
+	count = inb_p(0x40);	/* read the latched count */
+
+	/*
+	 * We do this guaranteed double memory access instead of a _p 
+	 * postfix in the previous port access. Wheee, hackady hack
+	 */
+ 	jiffies_t = jiffies;
+
+	count |= inb_p(0x40) << 8;
+	
+        /* VIA686a test code... reset the latch if count > max + 1 */
+        if (count > LATCH) {
+                outb_p(0x34, 0x43);
+                outb_p(LATCH & 0xff, 0x40);
+                outb(LATCH >> 8, 0x40);
+                count = LATCH - 1;
+        }
+	
+	spin_unlock(&i8253_lock);
+
+	/*
+	 * avoiding timer inconsistencies (they are rare, but they happen)...
+	 * there are two kinds of problems that must be avoided here:
+	 *  1. the timer counter underflows
+	 *  2. hardware problem with the timer, not giving us continuous time,
+	 *     the counter does small "jumps" upwards on some Pentium systems,
+	 *     (see c't 95/10 page 335 for Neptun bug.)
+	 */
+
+/* you can safely undefine this if you don't have the Neptune chipset */
+
+#define BUGGY_NEPTUN_TIMER
+
+	if( jiffies_t == jiffies_p ) {
+		if( count > count_p ) {
+			/* the nutcase */
+
+			int i;
+
+			spin_lock(&i8259A_lock);
+			/*
+			 * This is tricky when I/O APICs are used;
+			 * see do_timer_interrupt().
+			 */
+			i = inb(0x20);
+			spin_unlock(&i8259A_lock);
+
+			/* assumption about timer being IRQ0 */
+			if (i & 0x01) {
+				/*
+				 * We cannot detect lost timer interrupts ... 
+				 * well, that's why we call them lost, don't we? :)
+				 * [hmm, on the Pentium and Alpha we can ... sort of]
+				 */
+				count -= LATCH;
+			} else {
+#ifdef BUGGY_NEPTUN_TIMER
+				/*
+				 * for the Neptun bug we know that the 'latch'
+				 * command doesnt latch the high and low value
+				 * of the counter atomically. Thus we have to 
+				 * substract 256 from the counter 
+				 * ... funny, isnt it? :)
+				 */
+
+				count -= 256;
+#else
+				printk("do_slow_gettimeoffset(): hardware timer problem?\n");
+#endif
+			}
+		}
+	} else
+		jiffies_p = jiffies_t;
+
+	count_p = count;
+
+	count = ((LATCH-1) - count) * TICK_SIZE;
+	count = (count + LATCH/2) / LATCH;
+
+	return count;
+}
diff -Nru a/arch/i386/kernel/timer_tsc.c b/arch/i386/kernel/timer_tsc.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/arch/i386/kernel/timer_tsc.c	Mon Aug 19 19:52:28 2002
@@ -0,0 +1,209 @@
+#include <linux/spinlock.h>
+#include <linux/init.h>
+
+#include <asm/timer.h>
+#include <asm/io.h>
+
+/*fwd declarations*/
+int init_tsc(void);
+void mark_offset_tsc(void);
+unsigned long get_offset_tsc(void);
+
+/*tsc timer_opts struct*/
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
+unsigned long cpu_khz;	/* Detected as we calibrate the TSC */
+
+/* # usecs that the last interrupt was delayed */
+static int delay_at_last_interrupt;
+
+static unsigned long last_tsc_low; /* lsb 32 bits of Time Stamp Counter */
+
+/* Cached *multiplier* to convert TSC counts to microseconds.
+ * (see the equation below).
+ * Equal to 2^32 * (1 / (clocks per usec) ).
+ * Initialized in time_init.
+ */
+unsigned long fast_gettimeoffset_quotient;
+
+
+
+#define CALIBRATE_LATCH	(5 * LATCH)
+#define CALIBRATE_TIME	(5 * 1000020/HZ)
+
+/* ------ Calibrate the TSC ------- 
+ * Return 2^32 * (1 / (TSC clocks per usec)) for do_fast_gettimeoffset().
+ * Too much 64-bit arithmetic here to do this cleanly in C, and for
+ * accuracy's sake we want to keep the overhead on the CTC speaker (channel 2)
+ * output busy loop as low as possible. We avoid reading the CTC registers
+ * directly because of the awkward 8-bit access mechanism of the 82C54
+ * device.
+ */
+
+static unsigned long __init calibrate_tsc(void)
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
+	 */
+	outb(0xb0, 0x43);			/* binary, mode 0, LSB/MSB, Ch 2 */
+	outb(CALIBRATE_LATCH & 0xff, 0x42);	/* LSB of count */
+	outb(CALIBRATE_LATCH >> 8, 0x42);	/* MSB of count */
+
+	{
+		unsigned long startlow, starthigh;
+		unsigned long endlow, endhigh;
+		unsigned long count;
+
+		rdtsc(startlow,starthigh);
+		count = 0;
+		do {
+			count++;
+		} while ((inb(0x61) & 0x20) == 0);
+		rdtsc(endlow,endhigh);
+
+		last_tsc_low = endlow;
+
+		/* Error: ECTCNEVERSET */
+		if (count <= 1)
+			goto bad_ctc;
+
+		/* 64-bit subtract - gcc just messes up with long longs */
+		__asm__("subl %2,%0\n\t"
+			"sbbl %3,%1"
+			:"=a" (endlow), "=d" (endhigh)
+			:"g" (startlow), "g" (starthigh),
+			 "0" (endlow), "1" (endhigh));
+
+		/* Error: ECPUTOOFAST */
+		if (endhigh)
+			goto bad_ctc;
+
+		/* Error: ECPUTOOSLOW */
+		if (endlow <= CALIBRATE_TIME)
+			goto bad_ctc;
+
+		__asm__("divl %2"
+			:"=a" (endlow), "=d" (endhigh)
+			:"r" (endlow), "0" (0), "1" (CALIBRATE_TIME));
+
+		return endlow;
+	}
+
+	/*
+	 * The CTC wasn't reliable: we got a hit on the very first read,
+	 * or the CPU was so fast/slow that the quotient wouldn't fit in
+	 * 32 bits..
+	 */
+bad_ctc:
+	return 0;
+}
+
+
+
+int init_tsc(void)
+{
+	if (cpu_has_tsc) {
+		unsigned long tsc_quotient = calibrate_tsc();
+		if (tsc_quotient) {
+			fast_gettimeoffset_quotient = tsc_quotient;
+			use_tsc = 1;
+			/*
+			 *	We could be more selective here I suspect
+			 *	and just enable this for the next intel chips ?
+			 */
+			x86_udelay_tsc = 1;
+
+			/* report CPU clock rate in Hz.
+			 * The formula is (10^6 * 2^32) / (2^32 * 1 / (clocks/us)) =
+			 * clock/second. Our precision is about 100 ppm.
+			 */
+			{	unsigned long eax=0, edx=1000;
+				__asm__("divl %2"
+		       		:"=a" (cpu_khz), "=d" (edx)
+        	       		:"r" (tsc_quotient),
+	                	"0" (eax), "1" (edx));
+				printk("Detected %lu.%03lu MHz processor.\n", cpu_khz / 1000, cpu_khz % 1000);
+			}
+			return 1;
+		}
+	}
+	return 0;
+}
+
+
+
+
+void mark_offset_tsc(void)
+{
+	int count;
+	/*
+	 * It is important that these two operations happen almost at
+	 * the same time. We do the RDTSC stuff first, since it's
+	 * faster. To avoid any inconsistencies, we need interrupts
+	 * disabled locally.
+	 */
+
+	/*
+	 * Interrupts are just disabled locally since the timer irq
+	 * has the SA_INTERRUPT flag set. -arca
+	 */
+
+	/* read Pentium cycle counter */
+	rdtscl(last_tsc_low);
+
+	spin_lock(&i8253_lock);
+	outb_p(0x00, 0x43);     /* latch the count ASAP */
+
+	count = inb_p(0x40);    /* read the latched count */
+	count |= inb(0x40) << 8;
+	spin_unlock(&i8253_lock);
+
+	count = ((LATCH-1) - count) * TICK_SIZE;
+	delay_at_last_interrupt = (count + LATCH/2) / LATCH;
+}
+
+unsigned long get_offset_tsc(void)
+{
+	register unsigned long eax, edx;
+
+	/* Read the Time Stamp Counter */
+
+	rdtsc(eax,edx);
+
+	/* .. relative to previous jiffy (32 bits is enough) */
+	eax -= last_tsc_low;	/* tsc_low delta */
+
+	/*
+         * Time offset = (tsc_low delta) * fast_gettimeoffset_quotient
+         *             = (tsc_low delta) * (usecs_per_clock)
+         *             = (tsc_low delta) * (usecs_per_jiffy / clocks_per_jiffy)
+	 *
+	 * Using a mull instead of a divl saves up to 31 clock cycles
+	 * in the critical path.
+         */
+
+	__asm__("mull %2"
+		:"=a" (eax), "=d" (edx)
+		:"rm" (fast_gettimeoffset_quotient),
+		 "0" (eax));
+
+	/* our adjusted time offset in microseconds */
+	return delay_at_last_interrupt + edx;
+}
diff -Nru a/include/asm-i386/timer.h b/include/asm-i386/timer.h
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/include/asm-i386/timer.h	Mon Aug 19 19:52:28 2002
@@ -0,0 +1,13 @@
+
+#ifndef _ASMi386_TIMER_H
+#define _ASMi386_TIMER_H
+
+struct timer_opts{
+	int (*init)(void);
+	void (*mark_offset)(void);
+	unsigned long (*get_offset)(void);
+};
+
+#define TICK_SIZE tick
+struct timer_opts* select_timer(void);
+#endif

