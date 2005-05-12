Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261383AbVELKAT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261383AbVELKAT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 May 2005 06:00:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261384AbVELKAT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 May 2005 06:00:19 -0400
Received: from mailfe01.swip.net ([212.247.154.1]:26778 "EHLO swip.net")
	by vger.kernel.org with ESMTP id S261383AbVELKAK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 May 2005 06:00:10 -0400
X-T2-Posting-ID: jLUmkBjoqvly7NM6d2gdCg==
Subject: Re: [PATCH] adjust x86-64 watchdog tick calculation
From: Alexander Nyberg <alexn@telia.com>
To: Jan Beulich <JBeulich@novell.com>
Cc: discuss@x86-64.org, linux-kernel@vger.kernel.org, ak@suse.de
In-Reply-To: <s2832159.057@emea1-mh.id2.novell.com>
References: <s2832159.057@emea1-mh.id2.novell.com>
Content-Type: text/plain
Date: Thu, 12 May 2005 12:00:08 +0200
Message-Id: <1115892008.918.7.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

tor 2005-05-12 klockan 10:27 +0200 skrev Jan Beulich:
> (Note: Patch also attached because the inline version is certain to get
> line wrapped.)
> 
> Get the x86-64 watchdog tick calculation into a state where it can also
> be used with nmi_hz other than 1Hz. Also do not turn on the watchdog by
> default (as is already done on i386).
> 

Why shouldn't the watchdog be turned on by default? It's an extremely
useful debugging aid and it's not like it fires NMIs often (the nmi_hz
is far from reality).

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


