Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261741AbVGGC2w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261741AbVGGC2w (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 22:28:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262305AbVGFT7O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 15:59:14 -0400
Received: from mx1.elte.hu ([157.181.1.137]:48570 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262253AbVGFQZD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 12:25:03 -0400
Date: Wed, 6 Jul 2005 18:24:57 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Realtime Preemption, 2.6.12, Beginners Guide?
Message-ID: <20050706162457.GA24728@elte.hu>
References: <200507061257.36738.s0348365@sms.ed.ac.uk> <20050706133124.GA19467@elte.hu> <200507061655.45801.s0348365@sms.ed.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200507061655.45801.s0348365@sms.ed.ac.uk>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Alistair John Strachan <s0348365@sms.ed.ac.uk> wrote:

> > (generally i try to mark every message in the -RT kernel that signals
> > some sort of anomaly with a 'BUG:' prefix - that makes it easy to do a
> > 'dmesg | grep BUG:' to find out whether anything bad is going on. All
> > other messages should be benign.)
> 
> Okay, I've got multiple other BUG: messages within 2-3 minutes of 
> booting that highlight problems in areas other than ACPI. Are they 
> useful to you?

yeah, please send them too - typically it's the first message that 
matters most (especially if the system crashes - which isnt the case 
here) - but sometimes the other ones are independent.

> > yes, this is a problem. You can probably work it around by disabling
> > ACPI, but it would be better to debug and fix it. The message was
> > generated because the kernel spent too much time [more than 10 seconds]
> > in acpi_processor_idle(), and the softlockup-thread (which runs at
> > SCHED_FIFO prio 99) was not scheduled for that amount of time. [or it
> > thought it was not scheduled.] Was there any suspend/resume activity
> > while you got that message?
> 
> No, this is during bootup that it occurs. Suspend and resume do work 
> and are compiled in on my laptop, but were never utilised.

was there a 10 seconds delay during bootup for such a message to be 
generated? Nothing should delay the softlockup threads. (but maybe their 
initial timekeeping is somehow impacted.)

> I've got a pair of nearly identical traces that highlight a 2645us 
> latency in smp_apic_timer_interrupt. I don't know how the trace is 
> formatted, so I can't tell if it occurred before or after this 
> function call. I also can't see how a ~1000us latency translates to a 
> ~2600us latency in the trace.
> 
> Since both traces were under 6K each, and I think the list limit is 
> higher, I risked it and have attached both.

thanks. They do show a real regression. softirq--3 got woken up at 
timestamp 1us:

  <idle>-0     0dnh2    1us : try_to_wake_up <softirq--3> (69 8c)

then we return from the (presumably timer) interrupt at timestamp 3us:

  <idle>-0     0dnh.    3us < (608)

( '<' in the trace signals return activity - can happen for syscalls and 
for interrupts.)

but the ACPI code is busy going to sleep:

  <idle>-0     0dn..    3us : acpi_hw_register_write (acpi_set_register)
  <idle>-0     0dn..    4us : acpi_hw_low_level_write (acpi_hw_register_write)
  <idle>-0     0dn..    4us+: acpi_os_write_port (acpi_hw_low_level_write)
  <idle>-0     0dn..    7us!: acpi_hw_low_level_write (acpi_hw_register_write)
  <idle>-0     0dnh. 2645us : smp_apic_timer_interrupt (c0252485 0 0)

and doesnt return for another 2638 microseconds!

the bug is probably that the ACPI code became interruptible when we 
introduced the IRQ soft-flag. This is clearly visible from the "d" flag:

                 _------=> CPU#
                / _-----=> irqs-off
               | / _----=> need-resched
               || / _---=> hardirq/softirq
               ||| / _--=> preempt-depth
               |||| /
               |||||     delay
   cmd     pid ||||| time  |   caller
      \   /    |||||   \   |   /
  <idle>-0     0dn..    3us : acpi_hw_register_write (acpi_set_register)
    /-----------^
 here

small 'd' means the soft IRQ-flag was disabled. Capital 'D' means that 
the CPU's irq-flag got disabled too. The ACPI code, when it prepares to 
sleep, has to disable direct interrupts too, otherwise the above 
scenario may occur. If a timer interrupt hits the ACPI code in that 
small window where it has already checked for need_resched(), but has 
not gone to sleep yet (so it cannot react to the timer IRQ by waking 
up), then we lose the wakeup.

could you try the patch below (or the -51-05 patch that i just 
uploaded), does it fix this latency?

	Ingo

Index: linux/arch/i386/kernel/process.c
===================================================================
--- linux.orig/arch/i386/kernel/process.c
+++ linux/arch/i386/kernel/process.c
@@ -211,7 +211,7 @@ EXPORT_SYMBOL_GPL(cpu_idle_wait);
  */
 static void mwait_idle(void)
 {
-	local_irq_enable();
+	raw_local_irq_enable();
 
 	if (!need_resched() && !need_resched_delayed()) {
 		set_thread_flag(TIF_POLLING_NRFLAG);
Index: linux/drivers/acpi/processor_idle.c
===================================================================
--- linux.orig/drivers/acpi/processor_idle.c
+++ linux/drivers/acpi/processor_idle.c
@@ -179,14 +179,14 @@ static void acpi_processor_idle (void)
 	 * Interrupts must be disabled during bus mastering calculations and
 	 * for C2/C3 transitions.
 	 */
-	local_irq_disable();
+	raw_local_irq_disable();
 
 	/*
 	 * Check whether we truly need to go idle, or should
 	 * reschedule:
 	 */
 	if (unlikely(need_resched())) {
-		local_irq_enable();
+		raw_local_irq_enable();
 		return;
 	}
 
@@ -248,7 +248,7 @@ static void acpi_processor_idle (void)
 		 *      issues (e.g. floppy DMA transfer overrun/underrun).
 		 */
 		if (pr->power.bm_activity & cx->demotion.threshold.bm) {
-			local_irq_enable();
+			raw_local_irq_enable();
 			next_state = cx->demotion.state;
 			goto end;
 		}
@@ -272,7 +272,7 @@ static void acpi_processor_idle (void)
 		if (pm_idle_save)
 			pm_idle_save();
 		else
-			safe_halt();
+			raw_safe_halt();
 		/*
                  * TBD: Can't get time duration while in C1, as resumes
 		 *      go to an ISR rather than here.  Need to instrument
@@ -291,7 +291,7 @@ static void acpi_processor_idle (void)
 		/* Get end time (ticks) */
 		t2 = inl(acpi_fadt.xpm_tmr_blk.address);
 		/* Re-enable interrupts */
-		local_irq_enable();
+		raw_local_irq_enable();
 		/* Compute time (ticks) that we were actually asleep */
 		sleep_ticks = ticks_elapsed(t1, t2) - cx->latency_ticks - C2_OVERHEAD;
 		break;
@@ -310,13 +310,13 @@ static void acpi_processor_idle (void)
 		/* Enable bus master arbitration */
 		acpi_set_register(ACPI_BITREG_ARB_DISABLE, 0, ACPI_MTX_DO_NOT_LOCK);
 		/* Re-enable interrupts */
-		local_irq_enable();
+		raw_local_irq_enable();
 		/* Compute time (ticks) that we were actually asleep */
 		sleep_ticks = ticks_elapsed(t1, t2) - cx->latency_ticks - C3_OVERHEAD;
 		break;
 
 	default:
-		local_irq_enable();
+		raw_local_irq_enable();
 		return;
 	}
 
@@ -392,7 +392,7 @@ end:
 	if (pm_idle_save)
 		pm_idle_save();
 	else
-		safe_halt();
+		raw_safe_halt();
 	return;
 }
 
Index: linux/include/asm-i386/system.h
===================================================================
--- linux.orig/include/asm-i386/system.h
+++ linux/include/asm-i386/system.h
@@ -469,8 +469,6 @@ struct alt_instr { 
 
 #include <linux/rt_irq.h>
 
-#define safe_halt()	do { local_irq_enable(); __asm__ __volatile__("hlt": : :"memory"); } while (0)
-
 /*
  * disable hlt during certain critical i/o operations
  */
