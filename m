Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <160057-212>; Sat, 13 Mar 1999 22:16:42 -0500
Received: by vger.rutgers.edu id <157429-215>; Sat, 13 Mar 1999 22:16:26 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:8766 "EHLO penguin.e-mind.com" ident: "NO-IDENT-SERVICE[2]") by vger.rutgers.edu with ESMTP id <157465-212>; Sat, 13 Mar 1999 22:12:23 -0500
Date: Sun, 14 Mar 1999 04:09:03 +0100 (CET)
From: Andrea Arcangeli <andrea@e-mind.com>
To: Ingo Molnar <mingo@chiara.csoma.elte.hu>
Cc: Andi Kleen <ak@muc.de>, linux-kernel@vger.rutgers.edu, Buddha Buck <bmbuck@acsu.buffalo.edu>, Colin McFadden <mcfadden@athenet.net>
Subject: [patch] recover losed timer interrupt using the TSC [Re: [patch] kstat change to see how much Linux SMP really scale well]
In-Reply-To: <Pine.LNX.4.05.9903131855070.17834-100000@laser.random>
Message-ID: <Pine.LNX.4.05.9903140351370.202-100000@laser.random>
X-Public-Key-URL: http://e-mind.com/~andrea/aa.asc
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-kernel@vger.rutgers.edu

On Sat, 13 Mar 1999, Andrea Arcangeli wrote:

>Infact people is starting to report that its machine clock is losing time.
>I am fixing it right now. I think I have just finised coding but I'll do

It's working now. I tested it with a cli(); mdelay(1000); sti(). While the
system was losing 1 sec without the patch, it now recovers the losed time
with the patch applyed.

Due the fast overflow of the low part of the TSC we can only recover
delays of the order of seconds (it also depends how much fast is your
CPU).

I also fixed a nice thing. I noticed that the quotient multiplier was
variable over reboot. So now I loop until I get the same value two times
and now I always get the same value that probably is the more relialable
(usually I get it after 5-20 tries).

Another thing I noticed is that in some places we are doing something
like:

	(value + DIVISOR/2) / DIVISOR

I can give to it a sense, but I think it's more wrong than right.

So finally here a preliminary patch against 2.2.3. I would ask to Buddha
and to Colin to try it out since they both was reporting that using SCSI
on their hardware they was losing time .... over the time.

As usual works fine here ;).

Index: arch/i386/kernel/time.c
===================================================================
RCS file: /var/cvs/linux/arch/i386/kernel/time.c,v
retrieving revision 1.1.2.8
diff -u -r1.1.2.8 time.c
--- time.c	1999/03/09 01:37:39	1.1.2.8
+++ linux/arch/i386/kernel/time.c	1999/03/14 02:43:37
@@ -76,6 +76,7 @@
 static unsigned long fast_gettimeoffset_quotient=0;
 
 extern rwlock_t xtime_lock;
+extern volatile unsigned long lost_ticks;
 
 static inline unsigned long do_fast_gettimeoffset(void)
 {
@@ -217,7 +218,7 @@
 	count_p = count;
 
 	count = ((LATCH-1) - count) * TICK_SIZE;
-	count = (count + LATCH/2) / LATCH;
+	count = count / LATCH;
 
 	return count;
 }
@@ -236,7 +237,6 @@
  */
 void do_gettimeofday(struct timeval *tv)
 {
-	extern volatile unsigned long lost_ticks;
 	unsigned long flags;
 	unsigned long usec, sec;
 
@@ -412,14 +412,48 @@
 static int use_tsc = 0;
 
 /*
+ * Using a bit better the TSC information now we are also able to recover
+ * from lost timer interrupts. -arca
+ */
+static inline void recover_lost_timer(unsigned long delta_cycles,
+				      int delay_usec)
+{
+	/*
+	 * The algorithm I invented to know if we losed an irq in the meantime
+	 * works this way:
+	 *
+	 *	- convert delta from cycles to usec
+	 *	- remove from the delta_usec the latency of the irqs
+	 *	- convert from usec to timer ticks
+	 *
+	 *				-arca
+	 */
+
+	register unsigned long delta_usec;
+
+	__asm__("mull %2"
+		:"=a" (delta_cycles), "=d" (delta_usec)
+		:"g" (fast_gettimeoffset_quotient), "0" (delta_cycles));
+	delta_usec -= delay_usec;
+	delta_usec /= 1000000/HZ;
+
+	if ((long) delta_usec > 1)
+	{
+		printk(KERN_DEBUG "lost ticks %lu\n", delta_usec - 1);
+
+		delta_usec -= 1;
+		lost_ticks += delta_usec;
+		jiffies += delta_usec;
+	}
+}
+
+/*
  * This is the same as the above, except we _also_ save the current
  * Time Stamp Counter value at the time of the timer interrupt, so that
  * we later on can estimate the time of day more exactly.
  */
 static void timer_interrupt(int irq, void *dev_id, struct pt_regs *regs)
 {
-	int count;
-
 	/*
 	 * Here we are in the timer irq handler. We just have irqs locally
 	 * disabled but we don't know if the timer_bh is running on the other
@@ -443,16 +477,24 @@
 		 * has the SA_INTERRUPT flag set. -arca
 		 */
 	
+		unsigned long old_cycles;
+		int old_delay, count;
+
 		/* read Pentium cycle counter */
-		__asm__("rdtsc" : "=a" (last_tsc_low) : : "edx");
+		__asm__("rdtsc" : "=a" (old_cycles) : : "edx");
 
 		outb_p(0x00, 0x43);     /* latch the count ASAP */
 
 		count = inb_p(0x40);    /* read the latched count */
+		old_cycles = xchg(&last_tsc_low, old_cycles);
 		count |= inb(0x40) << 8;
 
 		count = ((LATCH-1) - count) * TICK_SIZE;
-		delay_at_last_interrupt = (count + LATCH/2) / LATCH;
+		old_delay = delay_at_last_interrupt;
+		delay_at_last_interrupt = count / LATCH;
+
+		recover_lost_timer(last_tsc_low - old_cycles,
+				   delay_at_last_interrupt - old_delay);
 	}
  
 	do_timer_interrupt(irq, NULL, regs);
@@ -543,30 +585,40 @@
  * device.
  */
 
+/*
+ * To get a more safe quotient value (that it will be used forever) we
+ * try many times and we'll stop if we'll get the same value for two times
+ * consecutively. -arca
+ */
+
 #define CALIBRATE_LATCH	(5 * LATCH)
 #define CALIBRATE_TIME	(5 * 1000020/HZ)
 
 __initfunc(static unsigned long calibrate_tsc(void))
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
-	 */
-	outb(0xb0, 0x43);			/* binary, mode 0, LSB/MSB, Ch 2 */
-	outb(CALIBRATE_LATCH & 0xff, 0x42);	/* LSB of count */
-	outb(CALIBRATE_LATCH >> 8, 0x42);	/* MSB of count */
+	int i;
+	unsigned long last_quotient = -999992 /* be quiet compiler */;
 
+	for (i=0; i<300; i++)
 	{
 		unsigned long startlow, starthigh;
 		unsigned long endlow, endhigh;
 		unsigned long count;
 
+		/* Set the Gate high, disable speaker */
+		outb((inb(0x61) & ~0x02) | 0x01, 0x61);
+
+		/*
+		 * Now let's take care of CTC channel 2
+		 *
+		 * Set the Gate high, program CTC channel 2 for mode 0,
+		 * (interrupt on terminal count mode), binary count,
+		 * load 5 * LATCH count, (LSB and MSB) to begin countdown.
+		 */
+		outb(0xb0, 0x43);	/* binary, mode 0, LSB/MSB, Ch 2 */
+		outb(CALIBRATE_LATCH & 0xff, 0x42);	/* LSB of count */
+		outb(CALIBRATE_LATCH >> 8, 0x42);	/* MSB of count */
+
 		__asm__ __volatile__("rdtsc":"=a" (startlow),"=d" (starthigh));
 		count = 0;
 		do {
@@ -599,8 +651,16 @@
 			:"=a" (endlow), "=d" (endhigh)
 			:"r" (endlow), "0" (0), "1" (CALIBRATE_TIME));
 
-		return endlow;
+		if (i && last_quotient == endlow)
+		{
+			printk("calibrate_tsc: consistent quotient %lu "
+			       "found after %d tries\n", endlow, i);
+			return endlow;
+		}
+		last_quotient = endlow;
 	}
+
+	printk("calibrate_tsc: inconsistent quotient!\n");
 
 	/*
 	 * The CTC wasn't reliable: we got a hit on the very first read,
Index: kernel/sched.c
===================================================================
RCS file: /var/cvs/linux/kernel/sched.c,v
retrieving revision 1.1.2.18
diff -u -r1.1.2.18 sched.c
--- sched.c	1999/02/25 13:27:24	1.1.2.18
+++ linux/kernel/sched.c	1999/03/14 02:47:35
@@ -47,7 +47,7 @@
 
 unsigned securebits = SECUREBITS_DEFAULT; /* systemwide security settings */
 
-long tick = (1000000 + HZ/2) / HZ;	/* timer interrupt period */
+long tick = 1000000 / HZ;	/* timer interrupt period */
 
 /* The current time */
 volatile struct timeval xtime __attribute__ ((aligned (16)));
@@ -72,7 +72,7 @@
 long time_maxerror = NTP_PHASE_LIMIT;	/* maximum error (us) */
 long time_esterror = NTP_PHASE_LIMIT;	/* estimated error (us) */
 long time_phase = 0;		/* phase offset (scaled us) */
-long time_freq = ((1000000 + HZ/2) % HZ - HZ/2) << SHIFT_USEC;	/* frequency offset (scaled ppm) */
+long time_freq = (1000000 % HZ) << SHIFT_USEC;	/* frequency offset (scaled ppm) */
 long time_adj = 0;		/* tick adjust (scaled 1 / HZ) */
 long time_reftime = 0;		/* time at last adjustment (s) */
 
@@ -1299,15 +1299,13 @@
 static void update_wall_time(unsigned long ticks)
 {
 	do {
-		ticks--;
 		update_wall_time_one_tick();
-	} while (ticks);
-
-	if (xtime.tv_usec >= 1000000) {
-	    xtime.tv_usec -= 1000000;
-	    xtime.tv_sec++;
-	    second_overflow();
-	}
+		while (xtime.tv_usec >= 1000000) {
+			xtime.tv_usec -= 1000000;
+			xtime.tv_sec++;
+			second_overflow();
+		}
+	} while (--ticks);
 }
 
 static inline void do_process_times(struct task_struct *p,



Comments?

The local apic interrupt could be changed to do the same thing even if it
looks like to me really less important since if the machine is been
lockedup for a so long time you are just going sloww and so waiting some
jiffy more on a task is not a critical issue according to me (also
because the locked-up time usually is not useful to do real progress for 
the task).

Anyway to implement the same thing for the smp local irq I need to know
how to read the leach counter from the io-apic at the time of the TSC
read.

Andrea Arcangeli

PS. Time to sleep for me.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
