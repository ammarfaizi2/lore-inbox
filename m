Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751158AbWI3IpK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751158AbWI3IpK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Sep 2006 04:45:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751163AbWI3Iob
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Sep 2006 04:44:31 -0400
Received: from smtp.osdl.org ([65.172.181.4]:22434 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751158AbWI3IoX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Sep 2006 04:44:23 -0400
Date: Sat, 30 Sep 2006 01:40:53 -0700
From: Andrew Morton <akpm@osdl.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       Jim Gettys <jg@laptop.org>, John Stultz <johnstul@us.ibm.com>,
       David Woodhouse <dwmw2@infradead.org>,
       Arjan van de Ven <arjan@infradead.org>, Dave Jones <davej@redhat.com>
Subject: Re: [patch 14/23] clockevents: drivers for i386
Message-Id: <20060930014053.5dc9624f.akpm@osdl.org>
In-Reply-To: <20060929234440.404341000@cruncher.tec.linutronix.de>
References: <20060929234435.330586000@cruncher.tec.linutronix.de>
	<20060929234440.404341000@cruncher.tec.linutronix.de>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Sep 2006 23:58:33 -0000
Thomas Gleixner <tglx@linutronix.de> wrote:

> From: Thomas Gleixner <tglx@linutronix.de>
> 
> add clockevent drivers for i386: lapic (local) and PIT (global).
> Update the timer IRQ to call into the PIT driver's event handler
> and the lapic-timer IRQ to call into the lapic clockevent driver.
> 

What's the story on other clock sources?  hpet, pm-timer?

> --- linux-2.6.18-mm2.orig/arch/i386/kernel/apic.c	2006-09-30 01:41:11.000000000 +0200
> +++ linux-2.6.18-mm2/arch/i386/kernel/apic.c	2006-09-30 01:41:18.000000000 +0200
> @@ -25,6 +25,7 @@
>  #include <linux/kernel_stat.h>
>  #include <linux/sysdev.h>
>  #include <linux/cpu.h>
> +#include <linux/clockchips.h>
>  #include <linux/module.h>
>  
>  #include <asm/atomic.h>
> @@ -70,6 +71,23 @@ static inline void lapic_enable(void)
>   */
>  int apic_verbosity;
>  
> +static unsigned int calibration_result;
> +
> +static void lapic_next_event(unsigned long delta, struct clock_event *evt);
> +static void lapic_timer_setup(int mode, struct clock_event *evt);
> +
> +static struct clock_event lapic_clockevent = {
> +	.name = "lapic",
> +	.capabilities = CLOCK_CAP_NEXTEVT | CLOCK_CAP_PROFILE
> +#ifdef CONFIG_SMP
> +			| CLOCK_CAP_UPDATE
> +#endif

I can't work out why this is SMP-only.  Please add changelog information
or, better, a comment explaining this.

> -static void __devinit setup_APIC_timer(unsigned int clocks)
> +static void lapic_timer_setup(int mode, struct clock_event *evt)
>  {
>  	unsigned long flags;
>  
>  	local_irq_save(flags);
> +	__setup_APIC_LVTT(calibration_result, mode != CLOCK_EVT_PERIODIC);
> +	local_irq_restore(flags);
> +}
>  
> -	/*
> -	 * Wait for IRQ0's slice:
> -	 */
> -	wait_timer_tick();
> -	wait_timer_tick();

For what reason was setup_APIC_timer() "Waiting for IRQ0's slice" and why
is it safe to remove that?

> +#ifdef CONFIG_HIGH_RES_TIMERS
> +		printk("Disabling NO_HZ and high resolution timers "
> +		       "due to timer broadcasting\n");
> +		for_each_possible_cpu(cpu)
> +			per_cpu(lapic_events, cpu).capabilities &=
> +				~CLOCK_CAP_NEXTEVT;
> +#endif

I think you mean "due to lack of timer broadcasting"?

No comment, no changelog entry -> I don't understand why this code is here.

>   *
>   */
> -#include <linux/clocksource.h>
> +#include <linux/clockchips.h>
>  #include <linux/spinlock.h>
>  #include <linux/jiffies.h>
>  #include <linux/sysdev.h>
> @@ -19,19 +19,63 @@
>  DEFINE_SPINLOCK(i8253_lock);
>  EXPORT_SYMBOL(i8253_lock);
>  
> -void setup_pit_timer(void)
> +static void init_pit_timer(int mode, struct clock_event *evt)

No. `mode' is not an integer.  It has type `enum you_forgot_to_give_it_a_name'.

In several places the timer code is using enums as integers - basically
using them as a glorified #define.

This loses the main advantages of enums: readability.  They permit the
reader to say "ah, that's a clock event type" instead of "oh, thats an
integer".

Please give those enums a name, and use it everywhere, rather than relying
upon implicit conversion to `int'.

(C sucks)

> +{
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&i8253_lock, flags);
> +
> +	switch(mode) {
> +	case CLOCK_EVT_PERIODIC:
> +		/* binary, mode 2, LSB/MSB, ch 0 */
> +		outb_p(0x34, PIT_MODE);
> +		udelay(10);
> +		outb_p(LATCH & 0xff , PIT_CH0);	/* LSB */
> +		outb(LATCH >> 8 , PIT_CH0);	/* MSB */
> +		break;
> +
> +	case CLOCK_EVT_ONESHOT:
> +	case CLOCK_EVT_SHUTDOWN:
> +		/* One shot setup */
> +		outb_p(0x38, PIT_MODE);
> +		udelay(10);
> +		break;
> +	}
> +	spin_unlock_irqrestore(&i8253_lock, flags);
> +}
> +
> +static void pit_next_event(unsigned long delta, struct clock_event *evt)
>  {
>  	unsigned long flags;
>  
>  	spin_lock_irqsave(&i8253_lock, flags);
> -	outb_p(0x34,PIT_MODE);		/* binary, mode 2, LSB/MSB, ch 0 */
> -	udelay(10);
> -	outb_p(LATCH & 0xff , PIT_CH0);	/* LSB */
> -	udelay(10);
> -	outb(LATCH >> 8 , PIT_CH0);	/* MSB */
> +	outb_p(delta & 0xff , PIT_CH0);	/* LSB */
> +	outb(delta >> 8 , PIT_CH0);	/* MSB */
>  	spin_unlock_irqrestore(&i8253_lock, flags);
>  }
>  
> +struct clock_event pit_clockevent = {
> +	.name		= "pit",
> +	.capabilities	= CLOCK_CAP_TICK | CLOCK_CAP_PROFILE | CLOCK_CAP_UPDATE
> +#ifndef CONFIG_SMP
> +			| CLOCK_CAP_NEXTEVT
> +#endif

Again, the CONFIG_SMP conditionality is a complete mystery to this reader.


