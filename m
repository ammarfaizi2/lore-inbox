Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261234AbUCDAMw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 19:12:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261300AbUCDAMw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 19:12:52 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:24716 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S261234AbUCDAMe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 19:12:34 -0500
Subject: [RFC][PATCH] linux-2.6.4-pre1_vsyscall-gtod_B3-part1 (1/3)
From: john stultz <johnstul@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Andrea Arcangeli <andrea@suse.de>, Andi Kleen <ak@suse.de>,
       Ulrich Drepper <drepper@redhat.com>, Jamie Lokier <jamie@shareable.org>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       Wim Coekaerts <wim.coekaerts@oracle.com>,
       Joel Becker <Joel.Becker@oracle.com>, Chris McDermott <lcm@us.ibm.com>
In-Reply-To: <1078359081.10076.191.camel@cog.beaverton.ibm.com>
References: <1078359081.10076.191.camel@cog.beaverton.ibm.com>
Content-Type: text/plain
Message-Id: <1078359137.10076.193.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Wed, 03 Mar 2004 16:12:18 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All,
	This patch renames variables in timer_cyclone.c and timer_tsc.c to
avoid conflicts in the global namespace. This allows the renamed
variables to be used in the vsyscall-gtod implementation, and is a
pre-requisite for the vsyscall-gtod_B3-part2 patch. 

thanks
-john

diff -Nru a/arch/i386/kernel/timers/timer_cyclone.c b/arch/i386/kernel/timers/timer_cyclone.c
--- a/arch/i386/kernel/timers/timer_cyclone.c	Mon Mar  1 13:15:32 2004
+++ b/arch/i386/kernel/timers/timer_cyclone.c	Mon Mar  1 13:15:32 2004
@@ -21,18 +21,17 @@
 extern spinlock_t i8253_lock;
 
 /* Number of usecs that the last interrupt was delayed */
-static int delay_at_last_interrupt;
+int cyclone_delay_at_last_interrupt;
 
 #define CYCLONE_CBAR_ADDR 0xFEB00CD0
 #define CYCLONE_PMCC_OFFSET 0x51A0
 #define CYCLONE_MPMC_OFFSET 0x51D0
 #define CYCLONE_MPCS_OFFSET 0x51A8
-#define CYCLONE_TIMER_FREQ 100000000
 #define CYCLONE_TIMER_MASK (((u64)1<<40)-1) /* 40 bit mask */
 int use_cyclone = 0;
 
-static u32* volatile cyclone_timer;	/* Cyclone MPMC0 register */
-static u32 last_cyclone_low;
+u32* volatile cyclone_timer;	/* Cyclone MPMC0 register */
+u32 last_cyclone_low;
 static u32 last_cyclone_high;
 static unsigned long long monotonic_base;
 static seqlock_t monotonic_lock = SEQLOCK_UNLOCKED;
@@ -57,7 +56,7 @@
 	spin_lock(&i8253_lock);
 	read_cyclone_counter(last_cyclone_low,last_cyclone_high);
 
-	/* read values for delay_at_last_interrupt */
+	/* read values for cyclone_delay_at_last_interrupt */
 	outb_p(0x00, 0x43);     /* latch the count ASAP */
 
 	count = inb_p(0x40);    /* read the latched count */
@@ -67,7 +66,7 @@
 	/* lost tick compensation */
 	delta = last_cyclone_low - delta;	
 	delta /= (CYCLONE_TIMER_FREQ/1000000);
-	delta += delay_at_last_interrupt;
+	delta += cyclone_delay_at_last_interrupt;
 	lost = delta/(1000000/HZ);
 	delay = delta%(1000000/HZ);
 	if (lost >= 2)
@@ -78,16 +77,16 @@
 	monotonic_base += (this_offset - last_offset) & CYCLONE_TIMER_MASK;
 	write_sequnlock(&monotonic_lock);
 
-	/* calculate delay_at_last_interrupt */
+	/* calculate cyclone_delay_at_last_interrupt */
 	count = ((LATCH-1) - count) * TICK_SIZE;
-	delay_at_last_interrupt = (count + LATCH/2) / LATCH;
+	cyclone_delay_at_last_interrupt = (count + LATCH/2) / LATCH;
 
 
 	/* catch corner case where tick rollover occured 
 	 * between cyclone and pit reads (as noted when 
 	 * usec delta is > 90% # of usecs/tick)
 	 */
-	if (lost && abs(delay - delay_at_last_interrupt) > (900000/HZ))
+	if (lost && abs(delay - cyclone_delay_at_last_interrupt) > (900000/HZ))
 		jiffies_64++;
 }
 
@@ -96,7 +95,7 @@
 	u32 offset;
 
 	if(!cyclone_timer)
-		return delay_at_last_interrupt;
+		return cyclone_delay_at_last_interrupt;
 
 	/* Read the cyclone timer */
 	offset = cyclone_timer[0];
@@ -109,7 +108,7 @@
 	offset = offset/(CYCLONE_TIMER_FREQ/1000000);
 
 	/* our adjusted time offset in microseconds */
-	return delay_at_last_interrupt + offset;
+	return cyclone_delay_at_last_interrupt + offset;
 }
 
 static unsigned long long monotonic_clock_cyclone(void)
diff -Nru a/arch/i386/kernel/timers/timer_tsc.c b/arch/i386/kernel/timers/timer_tsc.c
--- a/arch/i386/kernel/timers/timer_tsc.c	Mon Mar  1 13:15:32 2004
+++ b/arch/i386/kernel/timers/timer_tsc.c	Mon Mar  1 13:15:32 2004
@@ -33,7 +33,7 @@
 
 static int use_tsc;
 /* Number of usecs that the last interrupt was delayed */
-static int delay_at_last_interrupt;
+int tsc_delay_at_last_interrupt;
 
 static unsigned long last_tsc_low; /* lsb 32 bits of Time Stamp Counter */
 static unsigned long last_tsc_high; /* msb 32 bits of Time Stamp Counter */
@@ -104,7 +104,7 @@
 		 "0" (eax));
 
 	/* our adjusted time offset in microseconds */
-	return delay_at_last_interrupt + edx;
+	return tsc_delay_at_last_interrupt + edx;
 }
 
 static unsigned long long monotonic_clock_tsc(void)
@@ -223,7 +223,7 @@
 		 "0" (eax));
 		delta = edx;
 	}
-	delta += delay_at_last_interrupt;
+	delta += tsc_delay_at_last_interrupt;
 	lost = delta/(1000000/HZ);
 	delay = delta%(1000000/HZ);
 	if (lost >= 2) {
@@ -248,15 +248,15 @@
 	monotonic_base += cycles_2_ns(this_offset - last_offset);
 	write_sequnlock(&monotonic_lock);
 
-	/* calculate delay_at_last_interrupt */
+	/* calculate tsc_delay_at_last_interrupt */
 	count = ((LATCH-1) - count) * TICK_SIZE;
-	delay_at_last_interrupt = (count + LATCH/2) / LATCH;
+	tsc_delay_at_last_interrupt = (count + LATCH/2) / LATCH;
 
 	/* catch corner case where tick rollover occured 
 	 * between tsc and pit reads (as noted when 
 	 * usec delta is > 90% # of usecs/tick)
 	 */
-	if (lost && abs(delay - delay_at_last_interrupt) > (900000/HZ))
+	if (lost && abs(delay - tsc_delay_at_last_interrupt) > (900000/HZ))
 		jiffies_64++;
 }
 
@@ -308,7 +308,7 @@
 	monotonic_base += cycles_2_ns(this_offset - last_offset);
 	write_sequnlock(&monotonic_lock);
 
-	/* calculate delay_at_last_interrupt */
+	/* calculate tsc_delay_at_last_interrupt */
 	/*
 	 * Time offset = (hpet delta) * ( usecs per HPET clock )
 	 *             = (hpet delta) * ( usecs per tick / HPET clocks per tick)
@@ -316,9 +316,9 @@
 	 * Where,
 	 * hpet_usec_quotient = (2^32 * usecs per tick)/HPET clocks per tick
 	 */
-	delay_at_last_interrupt = hpet_current - offset;
-	ASM_MUL64_REG(temp, delay_at_last_interrupt,
-			hpet_usec_quotient, delay_at_last_interrupt);
+	tsc_delay_at_last_interrupt = hpet_current - offset;
+	ASM_MUL64_REG(temp, tsc_delay_at_last_interrupt,
+			hpet_usec_quotient, tsc_delay_at_last_interrupt);
 }
 #endif
 
diff -Nru a/include/asm-i386/timer.h b/include/asm-i386/timer.h
--- a/include/asm-i386/timer.h	Mon Mar  1 13:15:32 2004
+++ b/include/asm-i386/timer.h	Mon Mar  1 13:15:32 2004
@@ -20,6 +20,7 @@
 };
 
 #define TICK_SIZE (tick_nsec / 1000)
+#define CYCLONE_TIMER_FREQ 100000000
 
 extern struct timer_opts* select_timer(void);
 extern void clock_fallback(void);


