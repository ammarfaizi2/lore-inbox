Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261474AbTCGKR7>; Fri, 7 Mar 2003 05:17:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261479AbTCGKR7>; Fri, 7 Mar 2003 05:17:59 -0500
Received: from packet.digeo.com ([12.110.80.53]:12680 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S261474AbTCGKRz>;
	Fri, 7 Mar 2003 05:17:55 -0500
Date: Fri, 7 Mar 2003 02:28:29 -0800
From: Andrew Morton <akpm@digeo.com>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] protect 'action' in show_interrupts
Message-Id: <20030307022829.7868dda2.akpm@digeo.com>
In-Reply-To: <Pine.LNX.4.50.0303070502400.18716-100000@montezuma.mastecende.com>
References: <Pine.LNX.4.50.0303062358130.17080-100000@montezuma.mastecende.com>
	<20030306222328.14b5929c.akpm@digeo.com>
	<Pine.LNX.4.50.0303070221470.18716-100000@montezuma.mastecende.com>
	<20030306233517.68c922f9.akpm@digeo.com>
	<Pine.LNX.4.50.0303070502400.18716-100000@montezuma.mastecende.com>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 07 Mar 2003 10:28:24.0176 (UTC) FILETIME=[4875AF00:01C2E494]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zwane Mwaikambo <zwane@linuxpower.ca> wrote:
>
> This patch protects a critical section in show_interrupts against 
> removal of 'action' during traversal of the handlers. All the 
> architectures in one swoop.

Thanks for doing this.

> ...
> --- linux-2.5.64/arch/i386/kernel/irq.c	5 Mar 2003 05:08:03 -0000	1.1.1.1
> +++ linux-2.5.64/arch/i386/kernel/irq.c	7 Mar 2003 09:04:43 -0000
>  static void register_irq_proc (unsigned int irq);
> @@ -135,6 +135,7 @@
>  {
>  	int i, j;
>  	struct irqaction * action;
> +	unsigned long flags;
>  
>  	seq_printf(p, "           ");
>  	for (j=0; j<NR_CPUS; j++)
> @@ -156,11 +157,17 @@
>  					     kstat_cpu(j).irqs[i]);
>  #endif
>  		seq_printf(p, " %14s", irq_desc[i].handler->typename);
> +		spin_lock_irqsave(&irq_desc[i].lock, flags);
> +		if (!action)
> +			goto unlock;
> +		seq_printf(p, "  %s", action->name);
 
Local variable `action' could be pointing at freed memory by now.  We need to
reload it inside the lock.  Or just hold the lock across the entire loop.

