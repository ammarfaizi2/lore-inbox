Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275453AbTHMUDa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 16:03:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275426AbTHMUDV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 16:03:21 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:34021 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S275369AbTHMUDI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 16:03:08 -0400
Subject: [RFC] linux-2.4.22-rc2_monotonic-clock_A0
From: john stultz <johnstul@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Joel Becker <Joel.Becker@oracle.com>
Content-Type: text/plain
Organization: 
Message-Id: <1060804889.10738.1573.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 13 Aug 2003 13:01:33 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All, 

	This patch is a back port of the monotonic_clock() function from 2.5.
It was originally written along with Joel Becker to provide a
monotonically increasing counter which will increment properly even if
several minutes of interrupts have been lost. This patch is a
prerequisite for Oracle's hangcheck-timer patch.  The patch was
generated against 2.4.22-rc2, and I hope to submit it for inclusion in
2.4.23-pre. 

Please let me know if you have any comments or feedback. 

thanks
-john

diff -Nru a/arch/i386/kernel/time.c b/arch/i386/kernel/time.c
--- a/arch/i386/kernel/time.c	Tue Aug 12 18:52:53 2003
+++ b/arch/i386/kernel/time.c	Tue Aug 12 18:52:53 2003
@@ -71,6 +71,8 @@
 static int delay_at_last_interrupt;
 
 static unsigned long last_tsc_low; /* lsb 32 bits of Time Stamp Counter */
+static unsigned long last_tsc_high; /* msb 32 bits of Time Stamp Counter */
+static unsigned long long monotonic_base;
 
 /* Cached *multiplier* to convert TSC counts to microseconds.
  * (see the equation below).
@@ -84,6 +86,35 @@
 
 spinlock_t rtc_lock = SPIN_LOCK_UNLOCKED;
 
+/* convert from cycles(64bits) => nanoseconds (64bits)
+ *  basic equation:
+ *		ns = cycles / (freq / ns_per_sec)
+ *		ns = cycles * (ns_per_sec / freq)
+ *		ns = cycles * (10^9 / (cpu_mhz * 10^6))
+ *		ns = cycles * (10^3 / cpu_mhz)
+ *
+ *	Then we use scaling math (suggested by george@mvista.com) to get:
+ *		ns = cycles * (10^3 * SC / cpu_mhz) / SC
+ *		ns = cycles * cyc2ns_scale / SC
+ *
+ *	And since SC is a constant power of two, we can convert the div
+ *  into a shift.   
+ *			-johnstul@us.ibm.com "math is hard, lets go shopping!"
+*/
+static unsigned long cyc2ns_scale; 
+#define CYC2NS_SCALE_FACTOR 10 /* 2^10, carefully chosen */
+
+static inline void set_cyc2ns_scale(unsigned long cpu_mhz)
+{
+	cyc2ns_scale = (1000 << CYC2NS_SCALE_FACTOR)/cpu_mhz;
+}
+
+static inline unsigned long long cycles_2_ns(unsigned long long cyc)
+{
+	return (cyc * cyc2ns_scale) >> CYC2NS_SCALE_FACTOR;
+}
+
+
 static inline unsigned long do_fast_gettimeoffset(void)
 {
 	register unsigned long eax, edx;
@@ -113,6 +144,20 @@
 	return delay_at_last_interrupt + edx;
 }
 
+static unsigned long long monotonic_clock_tsc(void)
+{
+	unsigned long long last_offset, this_offset;
+	last_offset = ((unsigned long long)last_tsc_high<<32)|last_tsc_low;
+
+	/* Read the Time Stamp Counter */
+	rdtscll(this_offset);
+
+	/* return the value in ns */
+	return  monotonic_base + cycles_2_ns(this_offset - last_offset);
+}
+
+
+
 #define TICK_SIZE tick
 
 spinlock_t i8253_lock = SPIN_LOCK_UNLOCKED;
@@ -265,6 +310,14 @@
 #define CYCLONE_MPMC_OFFSET 0x51D0
 #define CYCLONE_MPCS_OFFSET 0x51A8
 #define CYCLONE_TIMER_FREQ 100000000
+#define CYCLONE_TIMER_MASK (((u64)1<<40)-1) /*40 bit mask*/
+
+/* helper macro to atomically read both cyclone counter registers */
+#define read_cyclone_counter(low,high) \
+	do{ \
+		high = cyclone_timer[1]; low = cyclone_timer[0]; \
+	} while (high != cyclone_timer[1]);
+
 
 int use_cyclone = 0;
 int __init cyclone_setup(char *str) 
@@ -274,16 +327,18 @@
 }
 
 static u32* volatile cyclone_timer;	/* Cyclone MPMC0 register */
-static u32 last_cyclone_timer;
+static u32 last_cyclone_low;
+static u32 last_cyclone_high;
 
 static inline void mark_timeoffset_cyclone(void)
 {
 	int count;
-	unsigned long delta = last_cyclone_timer;
+	unsigned long delta = last_cyclone_low;
+	unsigned long long this_offset, last_offset;
+	last_offset = ((unsigned long long)last_cyclone_high<<32)|last_cyclone_low;
+
 	spin_lock(&i8253_lock);
-	/* quickly read the cyclone timer */
-	if(cyclone_timer)
-		last_cyclone_timer = cyclone_timer[0];
+	read_cyclone_counter(last_cyclone_low,last_cyclone_high);
 
 	/* calculate delay_at_last_interrupt */
 	outb_p(0x00, 0x43);     /* latch the count ASAP */
@@ -293,7 +348,7 @@
 	spin_unlock(&i8253_lock);
 
 	/*lost tick compensation*/
-	delta = last_cyclone_timer - delta;
+	delta = last_cyclone_low - delta;
 	if(delta > loops_per_jiffy+2000){
 		delta = (delta/loops_per_jiffy)-1;
 		jiffies += delta;
@@ -301,6 +356,10 @@
                
 	count = ((LATCH-1) - count) * TICK_SIZE;
 	delay_at_last_interrupt = (count + LATCH/2) / LATCH;
+
+	/* update the monotonic base value */
+	this_offset = ((unsigned long long)last_cyclone_high<<32)|last_cyclone_low;
+	monotonic_base += (this_offset - last_offset) & CYCLONE_TIMER_MASK;
 }
 
 static unsigned long do_gettimeoffset_cyclone(void)
@@ -314,7 +373,7 @@
 	offset = cyclone_timer[0];
 
 	/* .. relative to previous jiffy */
-	offset = offset - last_cyclone_timer;
+	offset = offset - last_cyclone_low;
 
 	/* convert cyclone ticks to microseconds */	
 	/* XXX slow, can we speed this up? */
@@ -324,6 +383,22 @@
 	return delay_at_last_interrupt + offset;
 }
 
+unsigned long long monotonic_clock_cyclone(void)
+{
+	u32 now_low, now_high; 
+	unsigned long long last_offset, this_offset;
+	unsigned long long ret;
+	
+	read_cyclone_counter(now_low,now_high);
+	
+	last_offset = ((unsigned long long)last_cyclone_high<<32)|last_cyclone_low;
+	this_offset = ((unsigned long long)now_high<<32)|now_low;
+	
+	ret = monotonic_base + ((this_offset - last_offset)&CYCLONE_TIMER_MASK);
+	ret = ret * (1000000000 / CYCLONE_TIMER_FREQ);
+	return ret;
+}
+
 static void __init init_cyclone_clock(void)
 {
 	u32* reg;	
@@ -657,6 +732,8 @@
 	if(use_cyclone)
 		mark_timeoffset_cyclone();
 	else if (use_tsc) {
+		unsigned long long this_offset, last_offset;
+		last_offset = ((unsigned long long)last_tsc_high<<32)|last_tsc_low;
 		/*
 		 * It is important that these two operations happen almost at
 		 * the same time. We do the RDTSC stuff first, since it's
@@ -671,7 +748,7 @@
 	
 		/* read Pentium cycle counter */
 
-		rdtscl(last_tsc_low);
+		rdtsc(last_tsc_low, last_tsc_high);
 
 		spin_lock(&i8253_lock);
 		outb_p(0x00, 0x43);     /* latch the count ASAP */
@@ -704,6 +781,10 @@
 
 		count = ((LATCH-1) - count) * TICK_SIZE;
 		delay_at_last_interrupt = (count + LATCH/2) / LATCH;
+
+		/* update the monotonic base value */
+		this_offset = ((unsigned long long)last_tsc_high<<32)|last_tsc_low;
+		monotonic_base += cycles_2_ns(this_offset - last_offset);
 	}
 
 	do_timer_interrupt(irq, NULL, regs);
@@ -712,6 +793,21 @@
 
 }
 
+unsigned long long monotonic_clock(void)
+{
+	unsigned long long ret;
+	read_lock(&xtime_lock);
+	if(use_cyclone)
+		ret = monotonic_clock_cyclone();
+	else if(use_tsc)
+		ret = monotonic_clock_tsc();
+	else
+		ret = 0;
+	read_unlock(&xtime_lock);
+	return ret;
+}
+EXPORT_SYMBOL(monotonic_clock);
+
 /* not static: needed by APM */
 unsigned long get_cmos_time(void)
 {
@@ -901,6 +997,7 @@
 	                	"0" (eax), "1" (edx));
 				printk("Detected %lu.%03lu MHz processor.\n", cpu_khz / 1000, cpu_khz % 1000);
 			}
+			set_cyc2ns_scale(cpu_khz/1000);
 		}
 	}
 




