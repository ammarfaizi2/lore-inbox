Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261492AbVELLpt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261492AbVELLpt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 May 2005 07:45:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261498AbVELLpt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 May 2005 07:45:49 -0400
Received: from ns2.suse.de ([195.135.220.15]:27302 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S261492AbVELLpd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 May 2005 07:45:33 -0400
Date: Thu, 12 May 2005 13:45:32 +0200
From: Andi Kleen <ak@suse.de>
To: Jan Beulich <JBeulich@novell.com>
Cc: ak@suse.de, linux-kernel@vger.kernel.org, discuss@x86-64.org
Subject: Re: [PATCH] adjust x86-64 watchdog tick calculation
Message-ID: <20050512114532.GC15690@wotan.suse.de>
References: <s2832159.056@emea1-mh.id2.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s2832159.056@emea1-mh.id2.novell.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 12, 2005 at 10:27:09AM +0200, Jan Beulich wrote:
> (Note: Patch also attached because the inline version is certain to get
> line wrapped.)

Can you please only attach it then?

> 
> Get the x86-64 watchdog tick calculation into a state where it can also
> be used with nmi_hz other than 1Hz. Also do not turn on the watchdog by
> default (as is already done on i386).

I already fixed this some time ago by using the same code as i386.

That is what is in the current tree:
        wrmsr(MSR_K7_PERFCTR0, -(cpu_khz/nmi_hz*1000), -1);

But I guess your version will work with a higher frequency, right?	

-Andi

> 
> Signed-off-by: Jan Beulich <jbeulich@novell.com>
> 
> diff -Npru linux-2.6.12-rc4.base/arch/x86_64/kernel/nmi.c linux-2.6.12-rc4/arch/x86_64/kernel/nmi.c
> --- linux-2.6.12-rc4.base/arch/x86_64/kernel/nmi.c	2005-05-11 17:27:54.848855552 +0200
> +++ linux-2.6.12-rc4/arch/x86_64/kernel/nmi.c	2005-05-11 17:50:36.257889920 +0200
> @@ -57,7 +57,7 @@ static unsigned int lapic_nmi_owner;
>  int nmi_active;		/* oprofile uses this */
>  int panic_on_timeout;
>  
> -unsigned int nmi_watchdog = NMI_DEFAULT;
> +unsigned int nmi_watchdog = NMI_NONE;
>  static unsigned int nmi_hz = HZ;
>  unsigned int nmi_perfctr_msr;	/* the MSR to reset in NMI handler */
>  
> @@ -325,7 +325,7 @@ static void setup_k7_watchdog(void)
>  		| K7_NMI_EVENT;
>  
>  	wrmsr(MSR_K7_EVNTSEL0, evntsel, 0);
> -	wrmsrl(MSR_K7_PERFCTR0, -((u64)cpu_khz*1000) / nmi_hz);
> +	wrmsrl(MSR_K7_PERFCTR0, -((u64)cpu_khz * 1000 / nmi_hz));
>  	apic_write(APIC_LVTPC, APIC_DM_NMI);
>  	evntsel |= K7_EVNTSEL_ENABLE;
>  	wrmsr(MSR_K7_EVNTSEL0, evntsel, 0);
> @@ -404,7 +404,7 @@ void nmi_watchdog_tick (struct pt_regs *
>  		alert_counter[cpu] = 0;
>  	}
>  	if (nmi_perfctr_msr)
> -		wrmsr(nmi_perfctr_msr, -(cpu_khz/nmi_hz*1000), -1);
> +		wrmsrl(nmi_perfctr_msr, -((u64)cpu_khz * 1000 / nmi_hz));
>  }
>  
>  static int dummy_nmi_callback(struct pt_regs * regs, int cpu)
> 
> 

> (Note: Patch also attached because the inline version is certain to get
> line wrapped.)
> 
> Get the x86-64 watchdog tick calculation into a state where it can also
> be used with nmi_hz other than 1Hz. Also do not turn on the watchdog by
> default (as is already done on i386).
> 
> Signed-off-by: Jan Beulich <jbeulich@novell.com>
> 
> diff -Npru linux-2.6.12-rc4.base/arch/x86_64/kernel/nmi.c linux-2.6.12-rc4/arch/x86_64/kernel/nmi.c
> --- linux-2.6.12-rc4.base/arch/x86_64/kernel/nmi.c	2005-05-11 17:27:54.848855552 +0200
> +++ linux-2.6.12-rc4/arch/x86_64/kernel/nmi.c	2005-05-11 17:50:36.257889920 +0200
> @@ -57,7 +57,7 @@ static unsigned int lapic_nmi_owner;
>  int nmi_active;		/* oprofile uses this */
>  int panic_on_timeout;
>  
> -unsigned int nmi_watchdog = NMI_DEFAULT;
> +unsigned int nmi_watchdog = NMI_NONE;
>  static unsigned int nmi_hz = HZ;
>  unsigned int nmi_perfctr_msr;	/* the MSR to reset in NMI handler */
>  
> @@ -325,7 +325,7 @@ static void setup_k7_watchdog(void)
>  		| K7_NMI_EVENT;
>  
>  	wrmsr(MSR_K7_EVNTSEL0, evntsel, 0);
> -	wrmsrl(MSR_K7_PERFCTR0, -((u64)cpu_khz*1000) / nmi_hz);
> +	wrmsrl(MSR_K7_PERFCTR0, -((u64)cpu_khz * 1000 / nmi_hz));
>  	apic_write(APIC_LVTPC, APIC_DM_NMI);
>  	evntsel |= K7_EVNTSEL_ENABLE;
>  	wrmsr(MSR_K7_EVNTSEL0, evntsel, 0);
> @@ -404,7 +404,7 @@ void nmi_watchdog_tick (struct pt_regs *
>  		alert_counter[cpu] = 0;
>  	}
>  	if (nmi_perfctr_msr)
> -		wrmsr(nmi_perfctr_msr, -(cpu_khz/nmi_hz*1000), -1);
> +		wrmsrl(nmi_perfctr_msr, -((u64)cpu_khz * 1000 / nmi_hz));
>  }
>  
>  static int dummy_nmi_callback(struct pt_regs * regs, int cpu)

