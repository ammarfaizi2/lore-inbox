Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966245AbWKNSJA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966245AbWKNSJA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 13:09:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966247AbWKNSJA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 13:09:00 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:9682 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S966245AbWKNSI7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 13:08:59 -0500
From: ebiederm@xmission.com (Eric W. Biederman)
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@osdl.org>,
       "Zhang, Yanmin" <yanmin_zhang@linux.intel.com>,
       LKML <linux-kernel@vger.kernel.org>,
       "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
       Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [patch] ia64: use generic_handle_irq()
References: <1163495289.4311.68.camel@ymzhang-perf.sh.intel.com>
	<20061114020517.2222dd08.akpm@osdl.org>
	<20061114124638.GA12848@elte.hu>
Date: Tue, 14 Nov 2006 11:08:12 -0700
In-Reply-To: <20061114124638.GA12848@elte.hu> (Ingo Molnar's message of "Tue,
	14 Nov 2006 13:46:38 +0100")
Message-ID: <m14pt1lx4j.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar <mingo@elte.hu> writes:

> * Andrew Morton <akpm@osdl.org> wrote:
>
>> On Tue, 14 Nov 2006 17:08:10 +0800
>> "Zhang, Yanmin" <yanmin_zhang@linux.intel.com> wrote:
>> 
>> > I got an oops when booting 2.6.19-rc5-mm1 on my ia64 machine.
>> > 
>> > 
>> > The root cause is that some irq_chip variables, especially ia64_msi_chip,
>> > initiate their memeber end to point to NULL. __do_IRQ doesn't check
>> > if irq_chip->end is null and just calls it after processing the interrupt.
>> > 
>> > As irq_chip->end is called at many places, so I fix it by reinitiating
>> > irq_chip->end to dummy_irq_chip.end, e.g., a noop function.
>> > 
>> > Below patch against 2.6.19-rc5-mm1 fixes it.
>> > 
>> > Signed-off-by: Zhang Yanmin <yanmin.zhang@intel.com>
>> > 
>> > ---
>> > 
>> > --- linux-2.6.19-rc5-mm1/kernel/irq/chip.c 2006-11-14 14:16:16.000000000
> +0800
>> > +++ linux-2.6.19-rc5-mm1_fix/kernel/irq/chip.c 2006-11-14 14:14:25.000000000
> +0800
>> > @@ -233,6 +233,8 @@ void irq_chip_set_defaults(struct irq_ch
>> >  		chip->shutdown = chip->disable;
>> >  	if (!chip->name)
>> >  		chip->name = chip->typename;
>> > +	if (!chip->end)
>> > +		chip->end = dummy_irq_chip.end;
>> >  }
>> >  
>> 
>> The same bug should be hitting in mainline, shouldn't it?
>
> correct.
>
> this bug comes from a 'mixed' IRQ setup on ia64: half of it is still 
> old-style, half of it (the MSI stuff) is new-style irqchip code. But the 
> ia64 lowlevel code unconditionally calls __do_IRQ(), which is a bug.

Now that we hare half converted yes it is a bug.

> the genirq code has all the right helpers for such a mixed situation: so 
> a better fix might be the one below: use generic_handle_irq() instead of 
> unconditionally calling into __do_IRQ(). But i have not tested it - 
> Yanmin, can you confirm this too fixes your bug?
>
> similarly, any architecture that makes use of the new generic MSI 
> infrastructure should not be calling __do_IRQ() directly. (but i'm not 
> aware of any other besides ia64 - i386 and x86_64 is now fully irq-chip 
> converted.)
>
> Eric, do you agree?
>

This is true in practice.  It isn't necessarily true, as all of irq_chip
structures are arch specific.  It would be silly to start using msi interrupts
without converting to genirq though.  So I think this covers it for ia64.

Your patch only fixes 2 spots and there is a third in irq_ia64.c that
needs to be fixed as well.  At least in linus's tree.

>
> Index: linux/arch/ia64/kernel/irq.c
> ===================================================================
> --- linux.orig/arch/ia64/kernel/irq.c
> +++ linux/arch/ia64/kernel/irq.c
> @@ -197,7 +197,7 @@ void fixup_irqs(void)
>  			struct pt_regs *old_regs = set_irq_regs(NULL);
>  
>  			vectors_in_migration[irq]=0;
> -			__do_IRQ(irq);
> +			generic_handle_irq(irq);
>  			set_irq_regs(old_regs);
>  		}
>  	}
> Index: linux/arch/ia64/kernel/irq_ia64.c
> ===================================================================
> --- linux.orig/arch/ia64/kernel/irq_ia64.c
> +++ linux/arch/ia64/kernel/irq_ia64.c
> @@ -186,7 +186,7 @@ ia64_handle_irq (ia64_vector vector, str
>  			ia64_setreg(_IA64_REG_CR_TPR, vector);
>  			ia64_srlz_d();
>  
> -			__do_IRQ(local_vector_to_irq(vector));
> +			generic_handle_irq(local_vector_to_irq(vector));
>  
>  			/*
>  			 * Disable interrupts and send EOI:
