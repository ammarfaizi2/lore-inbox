Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261924AbTCaXcA>; Mon, 31 Mar 2003 18:32:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261930AbTCaXcA>; Mon, 31 Mar 2003 18:32:00 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:51863 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S261924AbTCaXbe>; Mon, 31 Mar 2003 18:31:34 -0500
Subject: [PATCH] linux-2.5.66_monotonic-clock_A4
From: john stultz <johnstul@us.ibm.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@digeo.com>,
       Andi Kleen <ak@suse.de>, Joel Becker <Joel.Becker@oracle.com>
Content-Type: text/plain
Organization: 
Message-Id: <1049153714.972.224.camel@w-jstultz2.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 31 Mar 2003 15:35:15 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, all, 

	As promised here is the next rev of monotonic-clock, which uses its own
rwlock for atomic access to monotonic_base and the values used to
calculate last_offset. Thanks to Andi for the suggestion. I've also
added a few code cleanups for better readability. 

Once again, this patch which written with the advice of Joel Becker,
addresses a problem with the hangcheck-timer. The basic problem is that
the hangcheck-timer code (Required for Oracle) needs a accurate hard
clock which can be used to detect OS stalls that would cause  system
time to skew. However, currently they are using get_cycles() to fetch
the cpu's TSC register, thus this does not work on systems w/o a synced
TSC.  I've worked with Joel and others to implement the
monotonic_clock() interface. Some of the major considerations made when
writing this patch were:
o Needs to be able to return accurate time in the absence of 
  multiple timer interrupts 
o Needs to be abstracted out from the hardware 
o Avoids impacting gettimeofday() performance 

This interface returns a unsigned long long representing the number of 
nanoseconds that has passed since time_init().

Please consider for inclusion. 

thanks
-john


diff -Nru a/arch/i386/kernel/time.c b/arch/i386/kernel/time.c
--- a/arch/i386/kernel/time.c	Mon Mar 31 15:16:43 2003
+++ b/arch/i386/kernel/time.c	Mon Mar 31 15:16:43 2003
@@ -138,6 +138,17 @@
 	clock_was_set();
 }
 
+/* monotonic_clock(): returns # of nanoseconds passed since time_init()
+ *		Note: This function is required to return accurate
+ *		time even in the absence of multiple timer ticks.
+ */
+unsigned long long monotonic_clock(void)
+{
+	return timer->monotonic_clock();
+}
+EXPORT_SYMBOL(monotonic_clock);
+
+
 /*
  * In order to set the CMOS clock precisely, set_rtc_mmss has to be
  * called 500 ms after the second nowtime has started, because when
diff -Nru a/arch/i386/kernel/timers/timer_cyclone.c b/arch/i386/kernel/timers/timer_cyclone.c
--- a/arch/i386/kernel/timers/timer_cyclone.c	Mon Mar 31 15:16:43 2003
+++ b/arch/i386/kernel/timers/timer_cyclone.c	Mon Mar 31 15:16:43 2003
@@ -28,27 +28,46 @@
 #define CYCLONE_MPMC_OFFSET 0x51D0
 #define CYCLONE_MPCS_OFFSET 0x51A8
 #define CYCLONE_TIMER_FREQ 100000000
-
+#define CYCLONE_TIMER_MASK (((u64)1<<40)-1) /* 40 bit mask */
 int use_cyclone = 0;
 
 static u32* volatile cyclone_timer;	/* Cyclone MPMC0 register */
-static u32 last_cyclone_timer;
+static u32 last_cyclone_low;
+static u32 last_cyclone_high;
+static unsigned long long monotonic_base;
+static rwlock_t monotonic_lock = RW_LOCK_UNLOCKED;
+
+/* helper macro to atomically read both cyclone counter registers */
+#define read_cyclone_counter(low,high) \
+	do{ \
+		high = cyclone_timer[1]; low = cyclone_timer[0]; \
+	} while (high != cyclone_timer[1]);
+
 
 static void mark_offset_cyclone(void)
 {
 	int count;
+	unsigned long long this_offset, last_offset;
+
+	write_lock(&monotonic_lock);
+	last_offset = ((unsigned long long)last_cyclone_high<<32)|last_cyclone_low;
+	
 	spin_lock(&i8253_lock);
-	/* quickly read the cyclone timer */
-	if(cyclone_timer)
-		last_cyclone_timer = cyclone_timer[0];
+	read_cyclone_counter(last_cyclone_low,last_cyclone_high);
 
-	/* calculate delay_at_last_interrupt */
+	/* read values for delay_at_last_interrupt */
 	outb_p(0x00, 0x43);     /* latch the count ASAP */
 
 	count = inb_p(0x40);    /* read the latched count */
 	count |= inb(0x40) << 8;
 	spin_unlock(&i8253_lock);
 
+	/* update the monotonic base value */
+	this_offset = ((unsigned long long)last_cyclone_high<<32)|last_cyclone_low;
+	monotonic_base += (this_offset - last_offset) & CYCLONE_TIMER_MASK;
+	write_unlock(&monotonic_lock);
+
+	/* calculate delay_at_last_interrupt */
 	count = ((LATCH-1) - count) * TICK_SIZE;
 	delay_at_last_interrupt = (count + LATCH/2) / LATCH;
 }
@@ -64,7 +83,7 @@
 	offset = cyclone_timer[0];
 
 	/* .. relative to previous jiffy */
-	offset = offset - last_cyclone_timer;
+	offset = offset - last_cyclone_low;
 
 	/* convert cyclone ticks to microseconds */	
 	/* XXX slow, can we speed this up? */
@@ -74,6 +93,27 @@
 	return delay_at_last_interrupt + offset;
 }
 
+static unsigned long long monotonic_clock_cyclone(void)
+{
+	u32 now_low, now_high;
+	unsigned long long last_offset, this_offset, base;
+	unsigned long long ret;
+
+	/* atomically read monotonic base & last_offset */
+	read_lock_irq(&monotonic_lock);
+	last_offset = ((unsigned long long)last_cyclone_high<<32)|last_cyclone_low;
+	base = monotonic_base;
+	read_unlock_irq(&monotonic_lock);
+
+	/* Read the cyclone counter */
+	read_cyclone_counter(now_low,now_high);
+	this_offset = ((unsigned long long)now_high<<32)|now_low;
+
+	/* convert to nanoseconds */
+	ret = base + ((this_offset - last_offset)&CYCLONE_TIMER_MASK);
+	return ret * (1000000000 / CYCLONE_TIMER_FREQ);
+}
+
 static int __init init_cyclone(char* override)
 {
 	u32* reg;	
@@ -194,5 +234,6 @@
 	.init = init_cyclone, 
 	.mark_offset = mark_offset_cyclone, 
 	.get_offset = get_offset_cyclone,
+	.monotonic_clock =	monotonic_clock_cyclone,
 	.delay = delay_cyclone,
 };
diff -Nru a/arch/i386/kernel/timers/timer_none.c b/arch/i386/kernel/timers/timer_none.c
--- a/arch/i386/kernel/timers/timer_none.c	Mon Mar 31 15:16:43 2003
+++ b/arch/i386/kernel/timers/timer_none.c	Mon Mar 31 15:16:43 2003
@@ -16,6 +16,11 @@
 	return 0;
 }
 
+static unsigned long long monotonic_clock_none(void)
+{
+	return 0;
+}
+
 static void delay_none(unsigned long loops)
 {
 	int d0;
@@ -34,5 +39,6 @@
 	.init =		init_none, 
 	.mark_offset =	mark_offset_none, 
 	.get_offset =	get_offset_none,
+	.monotonic_clock =	monotonic_clock_none,
 	.delay = delay_none,
 };
diff -Nru a/arch/i386/kernel/timers/timer_pit.c b/arch/i386/kernel/timers/timer_pit.c
--- a/arch/i386/kernel/timers/timer_pit.c	Mon Mar 31 15:16:43 2003
+++ b/arch/i386/kernel/timers/timer_pit.c	Mon Mar 31 15:16:43 2003
@@ -31,6 +31,11 @@
 	/* nothing needed */
 }
 
+static unsigned long long monotonic_clock_pit(void)
+{
+	return 0;
+}
+
 static void delay_pit(unsigned long loops)
 {
 	int d0;
@@ -145,5 +150,6 @@
 	.init =		init_pit, 
 	.mark_offset =	mark_offset_pit, 
 	.get_offset =	get_offset_pit,
+	.monotonic_clock = monotonic_clock_pit,
 	.delay = delay_pit,
 };
diff -Nru a/arch/i386/kernel/timers/timer_tsc.c b/arch/i386/kernel/timers/timer_tsc.c
--- a/arch/i386/kernel/timers/timer_tsc.c	Mon Mar 31 15:16:43 2003
+++ b/arch/i386/kernel/timers/timer_tsc.c	Mon Mar 31 15:16:43 2003
@@ -24,6 +24,38 @@
 static int delay_at_last_interrupt;
 
 static unsigned long last_tsc_low; /* lsb 32 bits of Time Stamp Counter */
+static unsigned long last_tsc_high; /* msb 32 bits of Time Stamp Counter */
+static unsigned long long monotonic_base;
+static rwlock_t monotonic_lock = RW_LOCK_UNLOCKED;
+
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
+ */
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
 
 /* Cached *multiplier* to convert TSC counts to microseconds.
  * (see the equation below).
@@ -61,11 +93,32 @@
 	return delay_at_last_interrupt + edx;
 }
 
+static unsigned long long monotonic_clock_tsc(void)
+{
+	unsigned long long last_offset, this_offset, base;
+	
+	/* atomically read monotonic base & last_offset */
+	read_lock_irq(&monotonic_lock);
+	last_offset = ((unsigned long long)last_tsc_high<<32)|last_tsc_low;
+	base = monotonic_base;
+	read_unlock_irq(&monotonic_lock);
+
+	/* Read the Time Stamp Counter */
+	rdtscll(this_offset);
+
+	/* return the value in ns */
+	return base + cycles_2_ns(this_offset - last_offset);
+}
+
 static void mark_offset_tsc(void)
 {
 	int count;
 	int countmp;
 	static int count1=0, count2=LATCH;
+	unsigned long long this_offset, last_offset;
+	
+	write_lock(&monotonic_lock);
+	last_offset = ((unsigned long long)last_tsc_high<<32)|last_tsc_low;
 	/*
 	 * It is important that these two operations happen almost at
 	 * the same time. We do the RDTSC stuff first, since it's
@@ -80,7 +133,7 @@
 	
 	/* read Pentium cycle counter */
 
-	rdtscl(last_tsc_low);
+	rdtsc(last_tsc_low, last_tsc_high);
 
 	spin_lock(&i8253_lock);
 	outb_p(0x00, 0x43);     /* latch the count ASAP */
@@ -103,6 +156,12 @@
 		}
 	}
 
+	/* update the monotonic base value */
+	this_offset = ((unsigned long long)last_tsc_high<<32)|last_tsc_low;
+	monotonic_base += cycles_2_ns(this_offset - last_offset);
+	write_unlock(&monotonic_lock);
+
+	/* calculate delay_at_last_interrupt */
 	count = ((LATCH-1) - count) * TICK_SIZE;
 	delay_at_last_interrupt = (count + LATCH/2) / LATCH;
 }
@@ -301,6 +360,7 @@
 	                	"0" (eax), "1" (edx));
 				printk("Detected %lu.%03lu MHz processor.\n", cpu_khz / 1000, cpu_khz % 1000);
 			}
+			set_cyc2ns_scale(cpu_khz/1000);
 			return 0;
 		}
 	}
@@ -334,5 +394,6 @@
 	.init =		init_tsc,
 	.mark_offset =	mark_offset_tsc, 
 	.get_offset =	get_offset_tsc,
+	.monotonic_clock =	monotonic_clock_tsc,
 	.delay = delay_tsc,
 };
diff -Nru a/drivers/char/hangcheck-timer.c b/drivers/char/hangcheck-timer.c
--- a/drivers/char/hangcheck-timer.c	Mon Mar 31 15:16:43 2003
+++ b/drivers/char/hangcheck-timer.c	Mon Mar 31 15:16:43 2003
@@ -78,11 +78,13 @@
 static struct timer_list hangcheck_ticktock =
 		TIMER_INITIALIZER(hangcheck_fire, 0, 0);
 
+extern unsigned long long monotonic_clock(void);
+
 static void hangcheck_fire(unsigned long data)
 {
 	unsigned long long cur_tsc, tsc_diff;
 
-	cur_tsc = get_cycles();
+	cur_tsc = monotonic_clock();
 
 	if (cur_tsc > hangcheck_tsc)
 		tsc_diff = cur_tsc - hangcheck_tsc;
@@ -98,7 +100,7 @@
 		}
 	}
 	mod_timer(&hangcheck_ticktock, jiffies + (hangcheck_tick*HZ));
-	hangcheck_tsc = get_cycles();
+	hangcheck_tsc = monotonic_clock();
 }
 
 
@@ -108,10 +110,10 @@
 	       VERSION_STR, hangcheck_tick, hangcheck_margin);
 
 	hangcheck_tsc_margin = hangcheck_margin + hangcheck_tick;
-	hangcheck_tsc_margin *= HZ;
-	hangcheck_tsc_margin *= current_cpu_data.loops_per_jiffy;
+	hangcheck_tsc_margin *= 1000000000;
+
 
-	hangcheck_tsc = get_cycles();
+	hangcheck_tsc = monotonic_clock();
 	mod_timer(&hangcheck_ticktock, jiffies + (hangcheck_tick*HZ));
 
 	return 0;
diff -Nru a/include/asm-i386/timer.h b/include/asm-i386/timer.h
--- a/include/asm-i386/timer.h	Mon Mar 31 15:16:43 2003
+++ b/include/asm-i386/timer.h	Mon Mar 31 15:16:43 2003
@@ -14,6 +14,7 @@
 	int (*init)(char *override);
 	void (*mark_offset)(void);
 	unsigned long (*get_offset)(void);
+	unsigned long long (*monotonic_clock)(void);
 	void (*delay)(unsigned long);
 };
 



