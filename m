Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262824AbUKRRzN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262824AbUKRRzN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 12:55:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261611AbUKRRxx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 12:53:53 -0500
Received: from ns.suse.de ([195.135.220.2]:35714 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261853AbUKRRvs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 12:51:48 -0500
Date: Thu, 18 Nov 2004 17:33:09 +0100
From: Andi Kleen <ak@suse.de>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Cc: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Intel thermal monitor for x86_64 (updated)
Message-ID: <20041118163309.GK17532@wotan.suse.de>
References: <Pine.LNX.4.61.0411180652330.7187@musoma.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0411180652330.7187@musoma.fsmlabs.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 18, 2004 at 08:49:47AM -0700, Zwane Mwaikambo wrote:
> diff -u -p -B -r1.1.1.1 mce.h
> --- linux-2.6.10-rc1-mm5/include/asm-x86_64/mce.h	11 Nov 2004 17:21:48 -0000	1.1.1.1
> +++ linux-2.6.10-rc1-mm5/include/asm-x86_64/mce.h	18 Nov 2004 13:18:38 -0000
> @@ -64,4 +64,16 @@ struct mce_log { 
>  #define MCE_GET_LOG_LEN      _IOR('M', 2, int)
>  #define MCE_GETCLEAR_FLAGS   _IOR('M', 3, int)
>  
> +#define MCE_EXTENDED_BANK	20

But better use a higher bank (128 or somesuch). It wouldn't surprise
me if Intel did something similar to their MCE architecture as 
they did for their performance counters, and then 20 banks 
in the hardware would be quite possible.

> +	static cpumask_t logged_cpus;
> +	static unsigned long next_check[NR_CPUS];

Use per cpu data for this. 

> +
> +	ack_APIC_irq();
> +
> +	irq_enter();
> +	cpu = smp_processor_id();
> +	if (time_before(jiffies, next_check[cpu]))
> +		goto done;
> +
> +	next_check[cpu] = jiffies + HZ*10;
> +	memset(&m, 0, sizeof(m));
> +	m.cpu = cpu;
> +	m.bank = MCE_THERMAL_BANK;
> +	rdtscll(m.tsc);
> +	rdmsrl(MSR_IA32_THERM_STATUS, m.status);
> +	if (m.status & 0x1) {
> +		printk(KERN_EMERG
> +			"CPU%d: Temperature above threshold, cpu clock throttled\n", m.cpu);
> +		add_taint(TAINT_MACHINE_CHECK);
> +	} else {
> +		printk(KERN_EMERG "CPU%d: Temperature/speed normal\n", m.cpu);
> +	}
> +
> +	/* Only log the first overheat condition, these can be spurious whilst
> +	 * the Thermal Control Circuitry attempts to drop the temperature.
> +	 */
> +	if (!cpu_isset(m.cpu, logged_cpus)) {
> +		cpu_set(m.cpu, logged_cpus);
> +		mce_log(&m);
> +	}

Does the comment match the code? I guess you mean the following
events after the first can be bogus.

It seems a bit bogus to printk but not log for known spurious 
conditions.

Also the next_check logic should already handle this I guess,
becaumse I assume the temperature dropping won't take
that long.  So I guess it would be best to drop that 
and if it's still a problem use a longer next_check timeout
of several seconds.

Rest looks good.

-Andi
