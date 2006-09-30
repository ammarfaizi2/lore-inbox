Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751164AbWI3IqA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751164AbWI3IqA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Sep 2006 04:46:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751163AbWI3IqA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Sep 2006 04:46:00 -0400
Received: from smtp.osdl.org ([65.172.181.4]:50594 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751164AbWI3Ipo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Sep 2006 04:45:44 -0400
Date: Sat, 30 Sep 2006 01:45:24 -0700
From: Andrew Morton <akpm@osdl.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       Jim Gettys <jg@laptop.org>, John Stultz <johnstul@us.ibm.com>,
       David Woodhouse <dwmw2@infradead.org>,
       Arjan van de Ven <arjan@infradead.org>, Dave Jones <davej@redhat.com>
Subject: Re: [patch 18/23] dynticks: i386 arch code
Message-Id: <20060930014524.64b49016.akpm@osdl.org>
In-Reply-To: <20060929234440.865232000@cruncher.tec.linutronix.de>
References: <20060929234435.330586000@cruncher.tec.linutronix.de>
	<20060929234440.865232000@cruncher.tec.linutronix.de>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Sep 2006 23:58:37 -0000
Thomas Gleixner <tglx@linutronix.de> wrote:

> From: Ingo Molnar <mingo@elte.hu>
> 
> prepare i386 for dyntick: idle handler callbacks and IRQ callback.
> 
> Index: linux-2.6.18-mm2/arch/i386/kernel/nmi.c
> ===================================================================
> --- linux-2.6.18-mm2.orig/arch/i386/kernel/nmi.c	2006-09-30 01:41:10.000000000 +0200
> +++ linux-2.6.18-mm2/arch/i386/kernel/nmi.c	2006-09-30 01:41:19.000000000 +0200
> @@ -20,6 +20,7 @@
>  #include <linux/sysdev.h>
>  #include <linux/sysctl.h>
>  #include <linux/percpu.h>
> +#include <linux/kernel_stat.h>
>  #include <linux/dmi.h>
>  #include <linux/kprobes.h>
>  
> @@ -908,7 +909,7 @@ __kprobes int nmi_watchdog_tick(struct p
>  		touched = 1;
>  	}
>  
> -	sum = per_cpu(irq_stat, cpu).apic_timer_irqs;
> +	sum = per_cpu(irq_stat, cpu).apic_timer_irqs + kstat_irqs(0);

Why?

> ===================================================================
> --- linux-2.6.18-mm2.orig/arch/i386/kernel/process.c	2006-09-30 01:41:10.000000000 +0200
> +++ linux-2.6.18-mm2/arch/i386/kernel/process.c	2006-09-30 01:41:19.000000000 +0200
> @@ -178,24 +178,27 @@ void cpu_idle(void)
>  
>  	/* endless idle loop with no priority at all */
>  	while (1) {
> -		while (!need_resched()) {
> -			void (*idle)(void);
> +		if (!hrtimer_stop_sched_tick()) {
> +			while (!need_resched()) {

I don't see why hrtimer_stop_sched_tick() returns need_resched().  We
immediately reevaluate it anyway.  hrtimer_stop_sched_tick() could return 1.

> +				void (*idle)(void);
>  
> -			if (__get_cpu_var(cpu_idle_state))
> -				__get_cpu_var(cpu_idle_state) = 0;
> +				if (__get_cpu_var(cpu_idle_state))
> +					__get_cpu_var(cpu_idle_state) = 0;
>  
> -			rmb();
> -			idle = pm_idle;
> +				rmb();
> +				idle = pm_idle;
>  
> -			if (!idle)
> -				idle = default_idle;
> +				if (!idle)
> +					idle = default_idle;
>  
> -			if (cpu_is_offline(cpu))
> -				play_dead();
> +				if (cpu_is_offline(cpu))
> +					play_dead();
>  
> -			__get_cpu_var(irq_stat).idle_timestamp = jiffies;
> -			idle();
> +				__get_cpu_var(irq_stat).idle_timestamp = jiffies;
> +				idle();
> +			}
>  		}
> +		hrtimer_restart_sched_tick();
>  		preempt_enable_no_resched();
>  		schedule();
>  		preempt_disable();
> 

