Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751201AbVKTDn4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751201AbVKTDn4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Nov 2005 22:43:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751202AbVKTDn4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Nov 2005 22:43:56 -0500
Received: from mail20.syd.optusnet.com.au ([211.29.132.201]:53226 "EHLO
	mail20.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1751201AbVKTDnz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Nov 2005 22:43:55 -0500
From: Con Kolivas <kernel@kolivas.org>
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Subject: Re: [PATCH] i386 no idle hz - aka dynticks v051118-1
Date: Sun, 20 Nov 2005 14:43:30 +1100
User-Agent: KMail/1.8.3
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       ck@vds.kolivas.org, tony@atomide.com
References: <200511182322.11222.kernel@kolivas.org> <Pine.LNX.4.61.0511191237020.20310@montezuma.fsmlabs.com>
In-Reply-To: <Pine.LNX.4.61.0511191237020.20310@montezuma.fsmlabs.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511201443.30859.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 20 Nov 2005 07:58, Zwane Mwaikambo wrote:
> It may be a little hard to see my comments as i've re-attached the patch
> inline as i couldn't reply-to properly (it was an attachment).

My bad sorry I'm addicted to a graphical MUA. The best I can do is inline the 
attachment. I could probably cut and paste but I'm afraid of mangling the 
patch.

> @@ -932,6 +933,9 @@ void (*wait_timer_tick)(void) __devinitd
>
>  #define APIC_DIVISOR 16
>
> +static u32 apic_timer_val;
>
> __read_mostly ?

Yeah I like that idea.

> +void dyn_tick_interrupt(int irq, struct pt_regs *regs)
> +{
> +	int all_were_sleeping = 0;
> +	int cpu = smp_processor_id();
> +
> +	if (!cpu_isset(cpu, nohz_cpu_mask))
> +		return;
> +
> +	spin_lock(dyn_tick_lock);
>
> This is going to cause contention problems for things like
> smp_call_function since all processors will be calling back to
> dyn_tick_interrupt.

Hmm got any ideas?

> +	if (cpus_equal(nohz_cpu_mask, cpu_online_map))
> +		all_were_sleeping = 1;
> +	cpu_clear(cpu, nohz_cpu_mask);
> +
> +	if (all_were_sleeping) {
> +		/* Recover jiffies */
> +		if (irq) {
>
> Perhaps simply call the 'irq' parameter as in_irq as right now it seems to
> mean anything between irq or vector and somewhat confusing.

Do you mean not pass the irq variables and just check for if (in_irq()) ?

> @@ -1190,15 +1191,19 @@ static inline void ioapic_register_intr(
>  		if ((trigger == IOAPIC_AUTO && IO_APIC_irq_trigger(irq)) ||
>  				trigger == IOAPIC_LEVEL)
>  			irq_desc[vector].handler = &ioapic_level_type;
> -		else
> +		else if (vector)
>  			irq_desc[vector].handler = &ioapic_edge_type;
> +		else
> +			irq_desc[vector].handler = IOAPIC_EDGE_TYPE_IRQ0;
>
> Please at least be explicit and not hide things behind #defines
>
> if (vector == 0)
> 	irq_desc[vector].handler = &ioapic_edge_type_irq0

Well ioapic_edge_type_irq0 doesn't exist on !CONFIG_NO_IDLE_HZ and this was a 
way of avoiding ifdefs in this .c file. I'll think about it again.

>  DEFINE_PER_CPU(irq_cpustat_t, irq_stat) ____cacheline_maxaligned_in_smp;
>  EXPORT_PER_CPU_SYMBOL(irq_stat);
> @@ -76,6 +77,8 @@ fastcall unsigned int do_IRQ(struct pt_r
>  	}
>  #endif
>
> +	dyn_tick_interrupt(irq, regs);
>
> This looks like it might contribute quite some contention in the irq fast
> path.

Might or is certain to? I don't really have hardware to test this hypothesis 
(nor do I know how) so I'd like to know how likely you think it is, and if 
there is some obvious way to improve this?

Thanks very much for your comments!

Cheers,
Con
