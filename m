Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932122AbVHMBhA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932122AbVHMBhA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 21:37:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932123AbVHMBhA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 21:37:00 -0400
Received: from mail21.syd.optusnet.com.au ([211.29.133.158]:16283 "EHLO
	mail21.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S932122AbVHMBg7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 21:36:59 -0400
From: Con Kolivas <kernel@kolivas.org>
To: ck@vds.kolivas.org, vatsa@in.ibm.com
Subject: Re: [ck] [PATCH] dynamic-tick patch modified for SMP
Date: Sat, 13 Aug 2005 11:35:45 +1000
User-Agent: KMail/1.8.2
Cc: tony@atomide.com, tuukka.tikkanen@elektrobit.com, akpm@osdl.org,
       johnstul@us.ibm.com, linux-kernel@vger.kernel.org, ak@muc.de,
       schwidefsky@de.ibm.com, george@mvista.com
References: <20050812201946.GA5327@in.ibm.com>
In-Reply-To: <20050812201946.GA5327@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508131135.46558.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 13 Aug 2005 06:19, Srivatsa Vaddagiri wrote:
> Hi,
> 	Here's finally the SMP changes that I had promised. The patch
> breaks the earlier restriction that all CPUs have to be idle before
> cutting of timers and now allows each idle CPU to skip ticks independent
> of others. The patch is against 2.6.13-rc6 and applies on top of Con's
> patch maintained here:

Great! Thanks.


> @@ -431,6 +425,7 @@ static void mark_offset_tsc(void)
>  	if (lost >= 2) {
>  		jiffies_64 += lost-1;
>
> +#ifndef CONFIG_NO_IDLE_HZ
>  		/* sanity check to ensure we're not always losing ticks */
>  		if (lost_count++ > 100) {
>  			printk(KERN_WARNING "Losing too many ticks!\n");
> @@ -446,6 +441,7 @@ static void mark_offset_tsc(void)
>  		/* ... but give the TSC a fair chance */
>  		if (lost_count > 25)
>  			cpufreq_delayed_get();
> +#endif

Is this sanity check also required when !dynticks_enabled() ? If so it would 
be better to be just if (!dynticks_enabled())


> 21:43:36.000000000 +0530 @@ -1157,6 +1157,7 @@ next:
>
>  static struct hw_interrupt_type ioapic_level_type;
>  static struct hw_interrupt_type ioapic_edge_type;
> +static struct hw_interrupt_type ioapic_edge_type_irq0;

This handler is redundant in !CONFIG_NO_IDLE_HZ ? If it is, as it appears to 
be, this is unnecessary extra code below in !CONFIG_NO_IDLE_HZ adding unused 
branches.

> @@ -1168,15 +1169,19 @@ static inline void ioapic_register_intr(
>  		if ((trigger == IOAPIC_AUTO && IO_APIC_irq_trigger(irq)) ||
>  				trigger == IOAPIC_LEVEL)
>  			irq_desc[vector].handler = &ioapic_level_type;
> -		else
> +		else if (vector)
>  			irq_desc[vector].handler = &ioapic_edge_type;
> +		else
> +			irq_desc[vector].handler = &ioapic_edge_type_irq0;
>  		set_intr_gate(vector, interrupt[vector]);
>  	} else	{
>  		if ((trigger == IOAPIC_AUTO && IO_APIC_irq_trigger(irq)) ||
>  				trigger == IOAPIC_LEVEL)
>  			irq_desc[irq].handler = &ioapic_level_type;
> -		else
> +		else if (irq)
>  			irq_desc[irq].handler = &ioapic_edge_type;
> +		else
> +			irq_desc[irq].handler = &ioapic_edge_type_irq0;
>  		set_intr_gate(vector, interrupt[irq]);
>  	}
>  }
> @@ -1288,7 +1293,7 @@ static void __init setup_ExtINT_IRQ0_pin
>  	 * The timer IRQ doesn't have to know that behind the
>  	 * scene we have a 8259A-master in AEOI mode ...
>  	 */
> -	irq_desc[0].handler = &ioapic_edge_type;
> +	irq_desc[0].handler = &ioapic_edge_type_irq0;
>
>  	/*
>  	 * Add it to the IO-APIC irq-routing table:
> @@ -2014,6 +2019,18 @@ static struct hw_interrupt_type ioapic_l
>  	.set_affinity 	= set_ioapic_affinity,
>  };
>
> +/* Needed to disable PIT interrupts when all CPUs sleep */
> +static struct hw_interrupt_type ioapic_edge_type_irq0 = {
> +	.typename 	= "IO-APIC-edge-irq0",
> +	.startup 	= startup_edge_ioapic,
> +	.shutdown 	= shutdown_edge_ioapic,
> +	.enable 	= unmask_IO_APIC_irq,
> +	.disable 	= mask_IO_APIC_irq,
> +	.ack 		= ack_edge_ioapic,
> +	.end 		= end_edge_ioapic,
> +	.set_affinity 	= set_ioapic_affinity,
> +};


Otherwise, looks good!

Cheers,
Con
