Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263320AbTDSA3Z (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Apr 2003 20:29:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263324AbTDSA3Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Apr 2003 20:29:25 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:33748 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S263320AbTDSA3S
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Apr 2003 20:29:18 -0400
Subject: [PATCH] linux-2.5.67_lost-tick-fix_A3
From: john stultz <johnstul@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@digeo.com>,
       Mika =?ISO-8859-1?Q?Penttil=E4?= <mika.penttila@kolumbus.fi>
Content-Type: text/plain; charset=ISO-8859-1
Organization: 
Message-Id: <1050712853.21042.78.camel@w-jstultz2.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 18 Apr 2003 17:40:53 -0700
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All,
        This patch fixes a race in the timer_interrupt code caused by
detect_lost_tick(). Since we're doing lost-tick compensation outside
timer->mark_offset, time can pass between time-source reads which can
cause gettimeofday inconsistencies. 

This patch fixes the described race by removing detect_lost_tick() and
instead implementing the lost tick detection code inside mark_offset().

This version fixes a bug in the last release pointed out by Mika
Penttilä when HZ != 1000 in a corner-case, as well as fixes up some of
the code spacing. 

thanks
-john


diff -Nru a/arch/i386/kernel/time.c b/arch/i386/kernel/time.c
--- a/arch/i386/kernel/time.c	Fri Apr 18 17:34:04 2003
+++ b/arch/i386/kernel/time.c	Fri Apr 18 17:34:04 2003
@@ -228,41 +228,6 @@
 }
 
 /*
- * Lost tick detection and compensation
- */
-static inline void detect_lost_tick(void)
-{
-	/* read time since last interrupt */
-	unsigned long delta = timer->get_offset();
-	static unsigned long dbg_print;
-	
-	/* check if delta is greater then two ticks */
-	if(delta >= 2*(1000000/HZ)){
-
-		/*
-		 * only print debug info first 5 times
-		 */
-		/*
-		 * AKPM: disable this for now; it's nice, but irritating.
-		 */
-		if (0 && dbg_print < 5) {
-			printk(KERN_WARNING "\nWarning! Detected %lu "
-				"micro-second gap between interrupts.\n",
-				delta);
-			printk(KERN_WARNING "  Compensating for %lu lost "
-				"ticks.\n",
-				delta/(1000000/HZ)-1);
-			dump_stack();
-			dbg_print++;
-		}
-		/* calculate number of missed ticks */
-		delta = delta/(1000000/HZ)-1;
-		jiffies += delta;
-	}
-		
-}
-
-/*
  * This is the same as the above, except we _also_ save the current
  * Time Stamp Counter value at the time of the timer interrupt, so that
  * we later on can estimate the time of day more exactly.
@@ -278,7 +243,6 @@
 	 */
 	write_seqlock(&xtime_lock);
 
-	detect_lost_tick();
 	timer->mark_offset();
  
 	do_timer_interrupt(irq, NULL, regs);
diff -Nru a/arch/i386/kernel/timers/timer_cyclone.c b/arch/i386/kernel/timers/timer_cyclone.c
--- a/arch/i386/kernel/timers/timer_cyclone.c	Fri Apr 18 17:34:04 2003
+++ b/arch/i386/kernel/timers/timer_cyclone.c	Fri Apr 18 17:34:04 2003
@@ -18,6 +18,7 @@
 #include <asm/fixmap.h>
 
 extern spinlock_t i8253_lock;
+extern unsigned long jiffies;
 extern unsigned long calibrate_tsc(void);
 
 /* Number of usecs that the last interrupt was delayed */
@@ -46,6 +47,8 @@
 
 static void mark_offset_cyclone(void)
 {
+	unsigned long lost, delay;
+	unsigned long delta = last_cyclone_low;
 	int count;
 	unsigned long long this_offset, last_offset;
 
@@ -62,6 +65,15 @@
 	count |= inb(0x40) << 8;
 	spin_unlock(&i8253_lock);
 
+	/* lost tick compensation */
+	delta = last_cyclone_low - delta;	
+	delta /= (CYCLONE_TIMER_FREQ/1000000);
+	delta += delay_at_last_interrupt;
+	lost = delta/(1000000/HZ);
+	delay = delta%(1000000/HZ);
+	if (lost >= 2)
+		jiffies += lost-1;
+	
 	/* update the monotonic base value */
 	this_offset = ((unsigned long long)last_cyclone_high<<32)|last_cyclone_low;
 	monotonic_base += (this_offset - last_offset) & CYCLONE_TIMER_MASK;
@@ -70,6 +82,13 @@
 	/* calculate delay_at_last_interrupt */
 	count = ((LATCH-1) - count) * TICK_SIZE;
 	delay_at_last_interrupt = (count + LATCH/2) / LATCH;
+
+	/* catch corner case where tick rollover occured 
+	 * between cyclone and pit reads (as noted when 
+	 * usec delta is > 90% # of usecs/tick)
+	 */
+	if (abs(delay - delay_at_last_interrupt) > (900000/HZ)) 
+		jiffies++;
 }
 
 static unsigned long get_offset_cyclone(void)
diff -Nru a/arch/i386/kernel/timers/timer_tsc.c b/arch/i386/kernel/timers/timer_tsc.c
--- a/arch/i386/kernel/timers/timer_tsc.c	Fri Apr 18 17:34:04 2003
+++ b/arch/i386/kernel/timers/timer_tsc.c	Fri Apr 18 17:34:04 2003
@@ -21,6 +21,7 @@
 int tsc_disable __initdata = 0;
 
 extern spinlock_t i8253_lock;
+extern unsigned long jiffies;
 
 static int use_tsc;
 /* Number of usecs that the last interrupt was delayed */
@@ -117,6 +118,8 @@
 
 static void mark_offset_tsc(void)
 {
+	unsigned long lost,delay;
+	unsigned long delta = last_tsc_low;
 	int count;
 	int countmp;
 	static int count1 = 0;
@@ -161,6 +164,23 @@
 		}
 	}
 
+	/* lost tick compensation */
+	delta = last_tsc_low - delta;
+	{
+		register unsigned long eax, edx;
+		eax = delta;
+		__asm__("mull %2"
+		:"=a" (eax), "=d" (edx)
+		:"rm" (fast_gettimeoffset_quotient),
+		 "0" (eax));
+		delta = edx;
+	}
+	delta += delay_at_last_interrupt;
+	lost = delta/(1000000/HZ);
+	delay = delta%(1000000/HZ);
+	if (lost >= 2)
+		jiffies += lost-1;
+
 	/* update the monotonic base value */
 	this_offset = ((unsigned long long)last_tsc_high<<32)|last_tsc_low;
 	monotonic_base += cycles_2_ns(this_offset - last_offset);
@@ -169,6 +189,13 @@
 	/* calculate delay_at_last_interrupt */
 	count = ((LATCH-1) - count) * TICK_SIZE;
 	delay_at_last_interrupt = (count + LATCH/2) / LATCH;
+
+	/* catch corner case where tick rollover occured 
+	 * between tsc and pit reads (as noted when 
+	 * usec delta is > 90% # of usecs/tick)
+	 */
+	if (abs(delay - delay_at_last_interrupt) > (900000/HZ))
+		jiffies++;
 }
 
 static void delay_tsc(unsigned long loops)



