Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424634AbWKPVYl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424634AbWKPVYl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Nov 2006 16:24:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424639AbWKPVYl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Nov 2006 16:24:41 -0500
Received: from smtp.osdl.org ([65.172.181.4]:38851 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1424634AbWKPVYk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Nov 2006 16:24:40 -0500
Date: Thu, 16 Nov 2006 13:20:58 -0800
From: Andrew Morton <akpm@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Thomas Gleixner <tglx@timesys.com>, Alan Stern <stern@rowland.harvard.edu>,
       LKML <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>,
       john stultz <johnstul@us.ibm.com>, David Miller <davem@davemloft.net>,
       Arjan van de Ven <arjan@infradead.org>, Andi Kleen <ak@suse.de>
Subject: Re: [patch] cpufreq: mark cpufreq_tsc() as core_initcall_sync
Message-Id: <20061116132058.4c541bde.akpm@osdl.org>
In-Reply-To: <20061116201531.GA31469@elte.hu>
References: <1163707250.10333.24.camel@localhost.localdomain>
	<20061116201531.GA31469@elte.hu>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Nov 2006 21:15:32 +0100
Ingo Molnar <mingo@elte.hu> wrote:

> 
> * Thomas Gleixner <tglx@timesys.com> wrote:
> 
> > [PATCH] cpufreq: make the transition_notifier chain use SRCU
> > (b4dfdbb3c707474a2254c5b4d7e62be31a4b7da9)
> > 
> > breaks cpu frequency notification users, which register the callback 
> > on core_init level. Interestingly enough the registration survives the 
> > uninitialized head, but the registered user is lost by:
> 
> i have hit this bug in -rt (it caused a lockup) and have fixed it - 
> forgot to send it upstream. Find the patch below.
> 
> 	Ingo
> 
> ---------------->
> From: Ingo Molnar <mingo@elte.hu>
> Subject: [patch] cpufreq: mark cpufreq_tsc() as core_initcall_sync
> 
> init_cpufreq_transition_notifier_list() should execute first, which is a 
> core_initcall, so mark cpufreq_tsc() core_initcall_sync.

That's not a terribly useful changelog.  What bug is being fixed.  What
does "first" mean?

> Signed-off-by: Ingo Molnar <mingo@elte.hu>
> 
> --- linux.orig/arch/x86_64/kernel/tsc.c
> +++ linux/arch/x86_64/kernel/tsc.c
> @@ -138,7 +138,11 @@ static int __init cpufreq_tsc(void)
>  	return 0;
>  }
>  
> -core_initcall(cpufreq_tsc);
> +/*
> + * init_cpufreq_transition_notifier_list() should execute first,
> + * which is a core_initcall, so mark this one core_initcall_sync:
> + */
> +core_initcall_sync(cpufreq_tsc);

Would prefer that we not use the _sync levels.  They're there as a
synchronisation for MULTITHREAD_PROBE and might disappear at any time.

