Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261256AbUKNIQ7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261256AbUKNIQ7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Nov 2004 03:16:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261258AbUKNIQ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Nov 2004 03:16:59 -0500
Received: from mail-ex.suse.de ([195.135.220.2]:38867 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261256AbUKNIQ4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Nov 2004 03:16:56 -0500
Date: Sun, 14 Nov 2004 09:16:49 +0100
From: Andi Kleen <ak@suse.de>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Cc: Andi Kleen <ak@suse.de>, Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] Intel thermal monitor for x86_64
Message-ID: <20041114081649.GA16795@wotan.suse.de>
References: <Pine.LNX.4.61.0411130629190.3062@musoma.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0411130629190.3062@musoma.fsmlabs.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 13, 2004 at 11:36:47AM -0700, Zwane Mwaikambo wrote:
> Patch adds support for notification of overheating conditions on intel 
> x86_64 processors. Tested on EM64T, test booted on AMD64.
> 
> Hardware courtesy of Intel Corporation

Did you actually execute the code by faking/forcing such a event? 

>  
> +#if defined(CONFIG_X86_MCE_INTEL)
> +ENTRY(thermal_interrupt)
> +	apicinterrupt THERMAL_APIC_VECTOR,smp_thermal_interrupt
> +#endif

Cleaner would be probably to add a weak dummy smp_thermal_interrupt
in traps.c and drop all the ifdefs.

> +
> +asmlinkage void smp_thermal_interrupt(void)
> +{
> +	u64 status;
> +
> +	ack_APIC_irq();
> +
> +	irq_enter();
> +	rdmsrl(MSR_IA32_THERM_STATUS, status);
> +	if (status & 0x1) {
> +		cpu_set(smp_processor_id(), cpu_thermal_status);
> +		add_taint(TAINT_MACHINE_CHECK);

Maybe this should be made a different taint bit? 

> +	} else {
> +		cpu_clear(smp_processor_id(), cpu_thermal_status);
> +	}
> +
> +	if (time_after(jiffies, next_thermal_check))
> +		tasklet_schedule(&thermal_tasklet);

I think there is actually a better way to do this (sorry for telling
you late, but I also only realized it later). Can you just make
the thermal APIC interrupt non NMI? Then the normal locking rules
apply and printk should work directly. 

Also can you at least additionally log an synthetic event using mce_log() ?
This way someone collecting these log entries centrally get its it 
all in the same log file. 

-Andi
