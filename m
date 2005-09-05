Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932367AbVIEIUA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932367AbVIEIUA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 04:20:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932366AbVIEIUA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 04:20:00 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:40580 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S932369AbVIEIT7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 04:19:59 -0400
Date: Mon, 5 Sep 2005 13:49:35 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Nishanth Aravamudan <nacc@us.ibm.com>, Con Kolivas <kernel@kolivas.org>,
       linux-kernel@vger.kernel.org, akpm@osdl.org,
       ck list <ck@vds.kolivas.org>
Subject: Re: [PATCH 1/3] dynticks - implement no idle hz for x86
Message-ID: <20050905081935.GB7924@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <20050831165843.GA4974@in.ibm.com> <200509031801.09069.kernel@kolivas.org> <20050903090650.B26998@flint.arm.linux.org.uk> <200509031814.49666.kernel@kolivas.org> <20050904201054.GA4495@us.ibm.com> <20050905070053.GA7329@in.ibm.com> <20050905084425.B24051@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050905084425.B24051@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 05, 2005 at 08:44:25AM +0100, Russell King wrote:
> Exactly where it is.  It's there because of the problem you allude to
> above - it's there to catch up system time.  Any generic code can't
> answer the question "how much time has passed since we disabled the
> timer" without additional information.
> 
> However, we could change "handler" to be a function pointer which
> returns the number of missed ticks instead, and then updates the
> kernels time and tick keeping.  That would probably be more efficient.

This is precisely what I have done. I have made cur_timer->mark-offset() to 
return the lost ticks and update wall-time from the callee, which
can be either timer_interrupt handler or in dyn-tick case the dyn-tick
code (I have called it dyn_tick_interrupt) which is called before processing 
_any_ interrupt. If ARM had a timer_opts equivalent we could have followed 
the same approach i.e remove 'handler' member and call dyn_tick_interrupt 
as first step in __do_irq/do_IRQ to process whatever it wants (recover wall 
time, start PIT timer in case of x86 etc). This is the definition of 
dyn_tick_interrupt that I have in my patch:


~~~~~~~~~~~~~


asm-i386/dyn-tick.h:

#ifdef CONFIG_NO_IDLE_HZ

extern void dyn_tick_interrupt(int irq, struct pt_regs *regs);

#else

static inline void dyn_tick_interrupt(int irq, struct pt_regs *regs)
{
}

#endif

And dyn_tick_interrupt is coded as:


arch/i386/kernel/dyn-tick.c:

void dyn_tick_interrupt(int irq, struct pt_regs *regs)
{
       int all_were_sleeping = 0;
       int cpu = smp_processor_id();

       if (!cpu_isset(cpu, nohz_cpu_mask))
               return;

       spin_lock(&dyn_tick_lock);

       if (cpus_equal(nohz_cpu_mask, cpu_online_map))
               all_were_sleeping = 1;
       cpu_clear(cpu, nohz_cpu_mask);

       if (all_were_sleeping) {
               /* Recover jiffies */
                if (irq) {
                        int lost;

                        lost = cur_timer->mark_offset();
                        if (lost)
                                do_timer(regs);
                }
                if (cpu_has_local_apic())
                        enable_pit_timer();
       }

       spin_unlock(&dyn_tick_lock);

       if (cpu_has_local_apic())
               /* Fixme: Needs to be more accurate */
               reprogram_apic_timer(1);
       else
               reprogram_pit_timer(1);

       conditional_run_local_timers();

       /* Fixme: Enable NMI watchdog */
}


~~~~~~~~~~~

Considering that ARM does not have any of that timer_opts structure,
could you call into INT_OS_TIMER handler from dyn_tick_interrupt? AFAICS,
INT_OS_TIMER handler and dyn_tick->handler is same ..



-- 


Thanks and Regards,
Srivatsa Vaddagiri,
Linux Technology Center,
IBM Software Labs,
Bangalore, INDIA - 560017
