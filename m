Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266887AbUFYXHV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266887AbUFYXHV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jun 2004 19:07:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266888AbUFYXHV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jun 2004 19:07:21 -0400
Received: from mail.dif.dk ([193.138.115.101]:10403 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S266887AbUFYXG6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jun 2004 19:06:58 -0400
Date: Sat, 26 Jun 2004 01:05:48 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: John Cherry <cherry@osdl.org>
Cc: "J.A. Magallon" <jamagallon@able.es>,
       Linux-Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: gcc-3.4.1 and -Winline
In-Reply-To: <1088175248.4344.6.camel@cherrybomb.pdx.osdl.net>
Message-ID: <Pine.LNX.4.56.0406260054520.30639@jjulnx.backbone.dif.dk>
References: <20040624234455.GA4058@werewolf.able.es>
 <1088175248.4344.6.camel@cherrybomb.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Jun 2004, John Cherry wrote:

> "J.A. Magallon" wrote:
> >
> > This are the warnings I get with gcc-3.4.1 CVS, when building
> 2.6.7-mm2.
> > Just for if some is really serious, ie, something that does not work
> if
> > compiled out-of-line (but I suppose I had noticed ;) ).
> > Or if it origins a huge performace penalty.
> [...]
> >
> >   CC      arch/i386/kernel/timers/timer_tsc.o
> > arch/i386/kernel/timers/timer_tsc.c: In function `mark_offset_tsc':
> > arch/i386/kernel/timers/timer_tsc.c:30: warning: inlining failed in
> call to \
> > 'cpufreq_delayed_get': function body not available \
> > arch/i386/kernel/timers/timer_tsc.c:248: warning: called from here
> [... more warnings deleted for brevity ...]
>
> Well, gcc 3.2.2 with -Winline does not complain, but interestingly
> enough sparse does (at least in the above case and some others):
>
>   CHECK   arch/i386/kernel/timers/timer_tsc.c
> arch/i386/kernel/timers/timer_tsc.c:30:39: warning: marked inline, but without a definition
>
> Basically this is a case of having:
>         #1:     static inline void foo(void); /* forward decl without body */
>         ...
>         #2:     void bar(void) { foo(); } /* function using the inline */
>         ...
>         #3:     static inline void foo(void) { return; } /* actual inline def. */
> in the above order.
>
> I have not looked at resulting .o file with gcc 3.2.2, but would not be too
> surprised if it also silently just ignores the "inline" in lines #1 and #3 above.
>
> There are obviously two trivial fixes above, either just remove the inline (making
> foo a normal static function) or reorder #2 and #3.
>

I see the same thing here with gcc 3.4.0.
Here's a patch to reorder timer_tsc.c so gcc 3.4 does not fail to inline
and thus fix the warning
"arch/i386/kernel/timers/timer_tsc.c:30: warning: inlining failed in call
to 'cpufreq_delayed_get': function body not available"

Patch is against 2.6.7-mm2

Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

--- linux-2.6.7-mm2-orig/arch/i386/kernel/timers/timer_tsc.c	2004-06-16 07:19:42.000000000 +0200
+++ linux-2.6.7-mm2/arch/i386/kernel/timers/timer_tsc.c	2004-06-26 01:04:26.000000000 +0200
@@ -1,6 +1,10 @@
 /*
  * This code largely moved from arch/i386/kernel/time.c.
  * See comments there for proper credits.
+ *
+ * 2004-06-25    Jesper Juhl
+ *      moved mark_offset_tsc below cpufreq_delayed_get to avoid gcc 3.4
+ *      failing to inline.
  */

 #include <linux/spinlock.h>
@@ -70,7 +74,6 @@ static inline unsigned long long cycles_
 	return (cyc * cyc2ns_scale) >> CYC2NS_SCALE_FACTOR;
 }

-
 static int count2; /* counter for mark_offset_tsc() */

 /* Cached *multiplier* to convert TSC counts to microseconds.
@@ -152,119 +155,6 @@ unsigned long long sched_clock(void)
 	return cycles_2_ns(this_offset);
 }

-
-static void mark_offset_tsc(void)
-{
-	unsigned long lost,delay;
-	unsigned long delta = last_tsc_low;
-	int count;
-	int countmp;
-	static int count1 = 0;
-	unsigned long long this_offset, last_offset;
-	static int lost_count = 0;
-
-	write_seqlock(&monotonic_lock);
-	last_offset = ((unsigned long long)last_tsc_high<<32)|last_tsc_low;
-	/*
-	 * It is important that these two operations happen almost at
-	 * the same time. We do the RDTSC stuff first, since it's
-	 * faster. To avoid any inconsistencies, we need interrupts
-	 * disabled locally.
-	 */
-
-	/*
-	 * Interrupts are just disabled locally since the timer irq
-	 * has the SA_INTERRUPT flag set. -arca
-	 */
-
-	/* read Pentium cycle counter */
-
-	rdtsc(last_tsc_low, last_tsc_high);
-
-	spin_lock(&i8253_lock);
-	outb_p(0x00, PIT_MODE);     /* latch the count ASAP */
-
-	count = inb_p(PIT_CH0);    /* read the latched count */
-	count |= inb(PIT_CH0) << 8;
-
-	/*
-	 * VIA686a test code... reset the latch if count > max + 1
-	 * from timer_pit.c - cjb
-	 */
-	if (count > LATCH) {
-		outb_p(0x34, PIT_MODE);
-		outb_p(LATCH & 0xff, PIT_CH0);
-		outb(LATCH >> 8, PIT_CH0);
-		count = LATCH - 1;
-	}
-
-	spin_unlock(&i8253_lock);
-
-	if (pit_latch_buggy) {
-		/* get center value of last 3 time lutch */
-		if ((count2 >= count && count >= count1)
-		    || (count1 >= count && count >= count2)) {
-			count2 = count1; count1 = count;
-		} else if ((count1 >= count2 && count2 >= count)
-			   || (count >= count2 && count2 >= count1)) {
-			countmp = count;count = count2;
-			count2 = count1;count1 = countmp;
-		} else {
-			count2 = count1; count1 = count; count = count1;
-		}
-	}
-
-	/* lost tick compensation */
-	delta = last_tsc_low - delta;
-	{
-		register unsigned long eax, edx;
-		eax = delta;
-		__asm__("mull %2"
-		:"=a" (eax), "=d" (edx)
-		:"rm" (fast_gettimeoffset_quotient),
-		 "0" (eax));
-		delta = edx;
-	}
-	delta += delay_at_last_interrupt;
-	lost = delta/(1000000/HZ);
-	delay = delta%(1000000/HZ);
-	if (lost >= 2) {
-		jiffies_64 += lost-1;
-
-		/* sanity check to ensure we're not always losing ticks */
-		if (lost_count++ > 100) {
-			printk(KERN_WARNING "Losing too many ticks!\n");
-			printk(KERN_WARNING "TSC cannot be used as a timesource.  \n");
-			printk(KERN_WARNING "Possible reasons for this are:\n");
-			printk(KERN_WARNING "  You're running with Speedstep,\n");
-			printk(KERN_WARNING "  You don't have DMA enabled for your hard disk (see hdparm),\n");
-			printk(KERN_WARNING "  Incorrect TSC synchronization on an SMP system (see dmesg).\n");
-			printk(KERN_WARNING "Falling back to a sane timesource now.\n");
-
-			clock_fallback();
-		}
-		/* ... but give the TSC a fair chance */
-		if (lost_count > 25)
-			cpufreq_delayed_get();
-	} else
-		lost_count = 0;
-	/* update the monotonic base value */
-	this_offset = ((unsigned long long)last_tsc_high<<32)|last_tsc_low;
-	monotonic_base += cycles_2_ns(this_offset - last_offset);
-	write_sequnlock(&monotonic_lock);
-
-	/* calculate delay_at_last_interrupt */
-	count = ((LATCH-1) - count) * TICK_SIZE;
-	delay_at_last_interrupt = (count + LATCH/2) / LATCH;
-
-	/* catch corner case where tick rollover occured
-	 * between tsc and pit reads (as noted when
-	 * usec delta is > 90% # of usecs/tick)
-	 */
-	if (lost && abs(delay - delay_at_last_interrupt) > (900000/HZ))
-		jiffies_64++;
-}
-
 static void delay_tsc(unsigned long loops)
 {
 	unsigned long bclock, now;
@@ -426,6 +316,117 @@ core_initcall(cpufreq_tsc);
 static inline void cpufreq_delayed_get(void) { return; }
 #endif

+static void mark_offset_tsc(void)
+{
+	unsigned long lost,delay;
+	unsigned long delta = last_tsc_low;
+	int count;
+	int countmp;
+	static int count1 = 0;
+	unsigned long long this_offset, last_offset;
+	static int lost_count = 0;
+
+	write_seqlock(&monotonic_lock);
+	last_offset = ((unsigned long long)last_tsc_high<<32)|last_tsc_low;
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
+	rdtsc(last_tsc_low, last_tsc_high);
+
+	spin_lock(&i8253_lock);
+	outb_p(0x00, PIT_MODE);     /* latch the count ASAP */
+
+	count = inb_p(PIT_CH0);    /* read the latched count */
+	count |= inb(PIT_CH0) << 8;
+
+	/*
+	 * VIA686a test code... reset the latch if count > max + 1
+	 * from timer_pit.c - cjb
+	 */
+	if (count > LATCH) {
+		outb_p(0x34, PIT_MODE);
+		outb_p(LATCH & 0xff, PIT_CH0);
+		outb(LATCH >> 8, PIT_CH0);
+		count = LATCH - 1;
+	}
+
+	spin_unlock(&i8253_lock);
+
+	if (pit_latch_buggy) {
+		/* get center value of last 3 time lutch */
+		if ((count2 >= count && count >= count1)
+		    || (count1 >= count && count >= count2)) {
+			count2 = count1; count1 = count;
+		} else if ((count1 >= count2 && count2 >= count)
+			   || (count >= count2 && count2 >= count1)) {
+			countmp = count;count = count2;
+			count2 = count1;count1 = countmp;
+		} else {
+			count2 = count1; count1 = count; count = count1;
+		}
+	}
+
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
+	if (lost >= 2) {
+		jiffies_64 += lost-1;
+
+		/* sanity check to ensure we're not always losing ticks */
+		if (lost_count++ > 100) {
+			printk(KERN_WARNING "Losing too many ticks!\n");
+			printk(KERN_WARNING "TSC cannot be used as a timesource.  \n");
+			printk(KERN_WARNING "Possible reasons for this are:\n");
+			printk(KERN_WARNING "  You're running with Speedstep,\n");
+			printk(KERN_WARNING "  You don't have DMA enabled for your hard disk (see hdparm),\n");
+			printk(KERN_WARNING "  Incorrect TSC synchronization on an SMP system (see dmesg).\n");
+			printk(KERN_WARNING "Falling back to a sane timesource now.\n");
+
+			clock_fallback();
+		}
+		/* ... but give the TSC a fair chance */
+		if (lost_count > 25)
+			cpufreq_delayed_get();
+	} else
+		lost_count = 0;
+	/* update the monotonic base value */
+	this_offset = ((unsigned long long)last_tsc_high<<32)|last_tsc_low;
+	monotonic_base += cycles_2_ns(this_offset - last_offset);
+	write_sequnlock(&monotonic_lock);
+
+	/* calculate delay_at_last_interrupt */
+	count = ((LATCH-1) - count) * TICK_SIZE;
+	delay_at_last_interrupt = (count + LATCH/2) / LATCH;
+
+	/* catch corner case where tick rollover occured
+	 * between tsc and pit reads (as noted when
+	 * usec delta is > 90% # of usecs/tick)
+	 */
+	if (lost && abs(delay - delay_at_last_interrupt) > (900000/HZ))
+		jiffies_64++;
+}

 static int __init init_tsc(char* override)
 {


--
Jesper Juhl <juhl-lkml@dif.dk>

