Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261747AbULNXTT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261747AbULNXTT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 18:19:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261759AbULNXSr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 18:18:47 -0500
Received: from mail-relay-4.tiscali.it ([213.205.33.44]:16359 "EHLO
	mail-relay-4.tiscali.it") by vger.kernel.org with ESMTP
	id S261747AbULNXRD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 18:17:03 -0500
Date: Wed, 15 Dec 2004 00:16:49 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Pavel Machek <pavel@suse.cz>
Cc: Zwane Mwaikambo <zwane@arm.linux.org.uk>, Con Kolivas <kernel@kolivas.org>,
       linux-kernel@vger.kernel.org
Subject: Re: USB making time drift [was Re: dynamic-hz]
Message-ID: <20041214231649.GR16322@dualathlon.random>
References: <20041213002751.GP16322@dualathlon.random> <Pine.LNX.4.61.0412121817130.16940@montezuma.fsmlabs.com> <20041213112853.GS16322@dualathlon.random> <20041213124313.GB29426@atrey.karlin.mff.cuni.cz> <20041213125844.GY16322@dualathlon.random> <20041213191249.GB1052@elf.ucw.cz> <20041214023651.GT16322@dualathlon.random> <20041214095939.GC1063@elf.ucw.cz> <20041214152558.GB16322@dualathlon.random> <20041214220239.GA19221@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041214220239.GA19221@elf.ucw.cz>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 14, 2004 at 11:02:39PM +0100, Pavel Machek wrote:
> How much drift do you see?

huge drift, minutes per hour or similar.

> I have machine with UHCI here, and am using usb most of the time
> (bluetooth for gprs connection), and did not notice too bad
> drift. ntpdate does some adjustment each time I connect to the
> network, but it 

Could be it happens only with my usb chipset or only with the adsl modem
with the usermode driver.

You can just write the proggy doing iopl cli/sti in a loop (keeping irqs
off for 3/4msec a few times per second like my usb modem does), you
should be able to see the drift in any machine without requiring an adsl
modem.

This was the status of my last attempt to fix it a few weeks ago. Patch
fixes a few unrelated bits. But the core of the below patch is actually
wrong, previous code did the right thing even if this works better in
practice. so I had not much motivation to extract the good bits until I
find the source of the big screwup in system time.

I probably should do any further debugging with an userspace simulation
(i.e. the iopl + cli/sti in a loop) within qemu.

--- sp1/arch/i386/kernel/timers/timer_tsc.c.~1~	2004-04-04 08:08:48.000000000 +0200
+++ sp1/arch/i386/kernel/timers/timer_tsc.c	2004-11-22 06:01:21.725371368 +0100
@@ -39,6 +39,7 @@ static unsigned long last_tsc_low; /* ls
 static unsigned long last_tsc_high; /* msb 32 bits of Time Stamp Counter */
 static unsigned long long monotonic_base;
 static seqlock_t monotonic_lock = SEQLOCK_UNLOCKED;
+static int report_lost_ticks; /* command line option */
 
 /* convert from cycles(64bits) => nanoseconds (64bits)
  *  basic equation:
@@ -69,8 +70,6 @@ static inline unsigned long long cycles_
 }
 
 
-static int count2; /* counter for mark_offset_tsc() */
-
 /* Cached *multiplier* to convert TSC counts to microseconds.
  * (see the equation below).
  * Equal to 2^32 * (1 / (clocks per usec) ).
@@ -153,11 +152,12 @@ unsigned long long sched_clock(void)
 
 static void mark_offset_tsc(void)
 {
-	unsigned long lost,delay;
+	unsigned long ticks;
 	unsigned long delta = last_tsc_low;
-	int count;
-	int countmp;
-	static int count1 = 0;
+	unsigned int count;
+	unsigned int countmp;
+	static unsigned int count1 = 0, count2 = LATCH;
+
 	unsigned long long this_offset, last_offset;
 	static int lost_count = 0;
 	
@@ -175,12 +175,11 @@ static void mark_offset_tsc(void)
 	 * has the SA_INTERRUPT flag set. -arca
 	 */
 	
-	/* read Pentium cycle counter */
-
-	rdtsc(last_tsc_low, last_tsc_high);
 
 	spin_lock(&i8253_lock);
-	outb_p(0x00, PIT_MODE);     /* latch the count ASAP */
+
+	/* read Pentium cycle counter and latch the count ASAP */
+	rdtsc(last_tsc_low, last_tsc_high); outb_p(0x00, PIT_MODE);
 
 	count = inb_p(PIT_CH0);    /* read the latched count */
 	count |= inb(PIT_CH0) << 8;
@@ -198,7 +197,7 @@ static void mark_offset_tsc(void)
 
 	spin_unlock(&i8253_lock);
 
-	if (pit_latch_buggy) {
+	if (unlikely(pit_latch_buggy)) {
 		/* get center value of last 3 time lutch */
 		if ((count2 >= count && count >= count1)
 		    || (count1 >= count && count >= count2)) {
@@ -223,11 +222,10 @@ static void mark_offset_tsc(void)
 		 "0" (eax));
 		delta = edx;
 	}
-	delta += delay_at_last_interrupt;
-	lost = delta/(1000000/HZ);
-	delay = delta%(1000000/HZ);
-	if (lost >= 2) {
-		jiffies_64 += lost-1;
+	//delta += delay_at_last_interrupt;
+	ticks = delta/(1000000/HZ);
+	if (unlikely(ticks >= 2)) {
+		jiffies_64 += ticks-1;
 
 		/* sanity check to ensure we're not always losing ticks */
 		if (lost_count++ > 100) {
@@ -241,6 +239,20 @@ static void mark_offset_tsc(void)
 
 			clock_fallback();
 		}
+
+		{
+			static u64 last_lost_tick;
+			if (last_lost_tick <= jiffies_64) {
+				printk(KERN_WARNING "Compensate %ld timer tick(s)\n", ticks-1);
+				dump_stack();
+				if  (report_lost_ticks)
+					/* max 1 per sec */
+					last_lost_tick = jiffies_64 + HZ;
+				else
+					/* force dump of lost ticks information not more than 1 per day */
+					last_lost_tick = jiffies_64 + 60*60*24*HZ;
+			}
+		}
 	} else
 		lost_count = 0;
 	/* update the monotonic base value */
@@ -248,16 +260,14 @@ static void mark_offset_tsc(void)
 	monotonic_base += cycles_2_ns(this_offset - last_offset);
 	write_sequnlock(&monotonic_lock);
 
+	/* Some i8253 clones hold the LATCH value visible
+	   momentarily as they flip back to zero */
+	if (unlikely(count == LATCH))
+		count--;
+
 	/* calculate delay_at_last_interrupt */
 	count = ((LATCH-1) - count) * TICK_SIZE;
 	delay_at_last_interrupt = (count + LATCH/2) / LATCH;
-
-	/* catch corner case where tick rollover occured 
-	 * between tsc and pit reads (as noted when 
-	 * usec delta is > 90% # of usecs/tick)
-	 */
-	if (lost && abs(delay - delay_at_last_interrupt) > (900000/HZ))
-		jiffies_64++;
 }
 
 static void delay_tsc(unsigned long loops)
@@ -433,8 +443,6 @@ static int __init init_tsc(char* overrid
  	 *	moaned if you have the only one in the world - you fix it!
  	 */
 
-	count2 = LATCH; /* initialize counter for mark_offset_tsc() */
-
 	if (cpu_has_tsc) {
 		unsigned long tsc_quotient;
 #ifdef CONFIG_HPET_TIMER
@@ -502,7 +510,12 @@ static int __init tsc_setup(char *str)
 #endif
 __setup("notsc", tsc_setup);
 
-
+static int __init report_lost_ticks_setup(char *str)
+{
+	report_lost_ticks = 1;
+	return 1;
+}
+__setup("report_lost_ticks", report_lost_ticks_setup);
 
 /************************************************************/
 
--- sp1/arch/i386/kernel/irq.c.~1~	2004-11-21 02:37:25.000000000 +0100
+++ sp1/arch/i386/kernel/irq.c	2004-11-22 07:03:15.140846408 +0100
@@ -217,14 +217,16 @@ inline void synchronize_irq(unsigned int
 int handle_IRQ_event(unsigned int irq,
 		struct pt_regs *regs, struct irqaction *action)
 {
-	int status = 1;	/* Force the "do bottom halves" bit */
+	int status = 0;
 	int retval = 0;
 
 	TRIG_EVENT(irq_entry_hook, irq, regs, !(user_mode(regs)));
-	if (!(action->flags & SA_INTERRUPT))
-		local_irq_enable();
-
 	do {
+		if (action->flags & SA_INTERRUPT)
+			local_irq_disable();
+		else
+			local_irq_enable();
+
 		status |= action->flags;
 		retval |= action->handler(irq, action->dev_id, regs);
 		action = action->next;
