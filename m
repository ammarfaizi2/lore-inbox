Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319131AbSHNAKq>; Tue, 13 Aug 2002 20:10:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319146AbSHNAKp>; Tue, 13 Aug 2002 20:10:45 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:58354 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S319131AbSHNAKm>;
	Tue, 13 Aug 2002 20:10:42 -0400
Subject: [RFC] timer-changes_A0
From: john stultz <johnstul@us.ibm.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: lkml <linux-kernel@vger.kernel.org>, george anzinger <george@mvista.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 13 Aug 2002 16:58:57 -0700
Message-Id: <1029283137.4692.119.camel@cog>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Alan, 
	I was looking over the changes you made in your -ac tree to the timer
code, and I was inspired to further go through and try to just clean up,
rename, and just move around a bit of code in arch/i386/kernel/time.c. 

Hopefully it should lead to more flexibility in adding different clocks
to use for do_gettimeoffset. Although I do want to split it up more,
where you have clock_tsc.c, clock_pit.c, clock_cyclone.c etc. Each one
implementing init_clock_xxxx, mark_timeoffset_xxxx, and
do_gettimeoffset_xxxx (possibly probing functions too?).  But for now I
just kept it all in time.c 

Anyway, all of this is completely untested (i just made sure it
compiled), but I just wanted some feedback as to weather I should keep
on working in this direction, or hold off and try this for 2.5 instead.

thanks
-john


diff -Nru a/arch/i386/kernel/time.c b/arch/i386/kernel/time.c
--- a/arch/i386/kernel/time.c	Tue Aug 13 16:44:26 2002
+++ b/arch/i386/kernel/time.c	Tue Aug 13 16:44:26 2002
@@ -11,11 +11,11 @@
  *      fixed 500 ms bug at call to set_rtc_mmss, fixed DS12887
  *      precision CMOS clock update
  * 1996-05-03    Ingo Molnar
- *      fixed time warps in do_[slow|fast]_gettimeoffset()
+ *      fixed time warps in do_gettimeoffset_[tsc|pit]()
  * 1997-09-10	Updated NTP code according to technical memorandum Jan '96
  *		"A Kernel Model for Precision Timekeeping" by Dave Mills
  * 1998-09-05    (Various)
- *	More robust do_fast_gettimeoffset() algorithm implemented
+ *	More robust do_gettimeoffset_tsc() algorithm implemented
  *	(works with APM, Cyrix 6x86MX and Centaur C6),
  *	monotonic gettimeofday() with fast_get_timeoffset(),
  *	drift-proof precision TSC calibration on boot
@@ -69,6 +69,7 @@
 /* Number of usecs that the last interrupt was delayed */
 static int delay_at_last_interrupt;
 
+static int use_tsc;
 static unsigned long last_tsc_low; /* lsb 32 bits of Time Stamp Counter */
 
 /* Cached *multiplier* to convert TSC counts to microseconds.
@@ -76,14 +77,49 @@
  * Equal to 2^32 * (1 / (clocks per usec) ).
  * Initialized in time_init.
  */
-unsigned long fast_gettimeoffset_quotient;
+unsigned long gettimeoffset_tsc_quotient;
 
 extern rwlock_t xtime_lock;
 extern unsigned long wall_jiffies;
 
+#define TICK_SIZE tick
+
 spinlock_t rtc_lock = SPIN_LOCK_UNLOCKED;
+spinlock_t i8253_lock = SPIN_LOCK_UNLOCKED;
+extern spinlock_t i8259A_lock;
 
-static inline unsigned long do_fast_gettimeoffset(void)
+static inline void mark_timeoffset_tsc(void)
+{
+	int count;
+
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
+
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
+static inline unsigned long do_gettimeoffset_tsc(void)
 {
 	register unsigned long eax, edx;
 
@@ -95,7 +131,7 @@
 	eax -= last_tsc_low;	/* tsc_low delta */
 
 	/*
-         * Time offset = (tsc_low delta) * fast_gettimeoffset_quotient
+         * Time offset = (tsc_low delta) * gettimeoffset_tsc_quotient
          *             = (tsc_low delta) * (usecs_per_clock)
          *             = (tsc_low delta) * (usecs_per_jiffy / clocks_per_jiffy)
 	 *
@@ -105,20 +141,20 @@
 
 	__asm__("mull %2"
 		:"=a" (eax), "=d" (edx)
-		:"rm" (fast_gettimeoffset_quotient),
+		:"rm" (gettimeoffset_tsc_quotient),
 		 "0" (eax));
 
 	/* our adjusted time offset in microseconds */
 	return delay_at_last_interrupt + edx;
 }
 
-#define TICK_SIZE tick
 
-spinlock_t i8253_lock = SPIN_LOCK_UNLOCKED;
-
-extern spinlock_t i8259A_lock;
 
 #ifndef CONFIG_X86_TSC
+static inline void mark_timeoffset_pit(void)
+{
+}
+
 
 /* This function must be called with interrupts disabled 
  * It was inspired by Steve McCanne's microtime-i386 for BSD.  -- jrs
@@ -152,7 +188,7 @@
  * comp.protocols.time.ntp!
  */
 
-static unsigned long do_slow_gettimeoffset(void)
+static unsigned long do_gettimeoffset_pit(void)
 {
 	int count;
 
@@ -236,7 +272,7 @@
 
 				count -= 256;
 #else
-				printk("do_slow_gettimeoffset(): hardware timer problem?\n");
+				printk("do_gettimeoffset_pit(): hardware timer problem?\n");
 #endif
 			}
 		}
@@ -251,14 +287,50 @@
 	return count;
 }
 
-static unsigned long (*do_gettimeoffset)(void) = do_slow_gettimeoffset;
-
+static unsigned long (*do_gettimeoffset)(void) = do_gettimeoffset_pit;
+static void (*mark_timeoffset)(void) = mark_timeoffset_pit;
 #else
 
-#define do_gettimeoffset()	do_fast_gettimeoffset()
+#define do_gettimeoffset()	do_gettimeoffset_tsc()
+#define mark_timeoffset()	mark_timeoffset_tsc()
+
+#endif
 
+/*fwd dec for init_clock_tsc*/
+static unsigned long __init calibrate_tsc(void);
+
+static inline void init_clock_tsc(void)
+{
+	extern int x86_udelay_tsc;
+	unsigned long tsc_quotient = calibrate_tsc();
+	if (tsc_quotient) {
+		gettimeoffset_tsc_quotient = tsc_quotient;
+		use_tsc = 1;
+		/*
+		 *	We could be more selective here I suspect
+		 *	and just enable this for the next intel chips ?
+		 */
+		x86_udelay_tsc = 1;
+#ifndef do_gettimeoffset
+		do_gettimeoffset = do_gettimeoffset_tsc;
 #endif
 
+		/* report CPU clock rate in Hz.
+		 * The formula is (10^6 * 2^32) / (2^32 * 1 / (clocks/us)) =
+		 * clock/second. Our precision is about 100 ppm.
+		 */
+		{	unsigned long eax=0, edx=1000;
+			__asm__("divl %2"
+    	   		:"=a" (cpu_khz), "=d" (edx)
+  	   			:"r" (tsc_quotient),
+          	    "0" (eax), "1" (edx));
+			printk("Detected %lu.%03lu MHz processor.\n", cpu_khz / 1000, cpu_khz % 1000);
+		}
+			
+	}
+}
+
+
 /*
  * This version of gettimeofday has microsecond resolution
  * and better than microsecond precision on fast x86 machines with TSC.
@@ -396,7 +468,7 @@
 	if (timer_ack) {
 		/*
 		 * Subtle, when I/O APICs are used we have to ack timer IRQ
-		 * manually to reset the IRR bit for do_slow_gettimeoffset().
+		 * manually to reset the IRR bit for do_gettimeoffset_pit().
 		 * This will also deassert NMI lines for the watchdog if run
 		 * on an 82489DX-based system.
 		 */
@@ -458,7 +530,6 @@
 #endif
 }
 
-static int use_tsc;
 
 /*
  * This is the same as the above, except we _also_ save the current
@@ -467,7 +538,6 @@
  */
 static void timer_interrupt(int irq, void *dev_id, struct pt_regs *regs)
 {
-	int count;
 
 	/*
 	 * Here we are in the timer irq handler. We just have irqs locally
@@ -478,35 +548,8 @@
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
- 
+	mark_timeoffset();
+		
 	do_timer_interrupt(irq, NULL, regs);
 
 	write_unlock(&xtime_lock);
@@ -558,7 +601,7 @@
 static struct irqaction irq0  = { timer_interrupt, SA_INTERRUPT, 0, "timer", NULL, NULL};
 
 /* ------ Calibrate the TSC ------- 
- * Return 2^32 * (1 / (TSC clocks per usec)) for do_fast_gettimeoffset().
+ * Return 2^32 * (1 / (TSC clocks per usec)) for do_gettimeoffset_tsc().
  * Too much 64-bit arithmetic here to do this cleanly in C, and for
  * accuracy's sake we want to keep the overhead on the CTC speaker (channel 2)
  * output busy loop as low as possible. We avoid reading the CTC registers
@@ -634,9 +677,16 @@
 	return 0;
 }
 
+enum clock_type {CLOCK_PIT, CLOCK_TSC};
+enum clock_type select_clock(void)
+{
+	if(cpu_has_tsc)
+		return CLOCK_TSC;
+	return CLOCK_PIT;
+}
+
 void __init time_init(void)
 {
-	extern int x86_udelay_tsc;
 	
 	xtime.tv_sec = get_cmos_time();
 	xtime.tv_usec = 0;
@@ -668,32 +718,12 @@
  
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
+	switch(select_clock()){
+		case CLOCK_TSC:
+			init_clock_tsc();
+			break;
+		case CLOCK_PIT:
+			break;
 	}
 
 #ifdef CONFIG_VISWS


