Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750798AbWGFUGE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750798AbWGFUGE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 16:06:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750800AbWGFUGE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 16:06:04 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:54422 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750798AbWGFUGD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 16:06:03 -0400
Date: Thu, 6 Jul 2006 13:06:39 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Dipankar Sarma <dipankar@in.ibm.com>, linux-kernel@vger.kernel.org,
       john stultz <johnstul@us.ibm.com>
Subject: Re: [PATCH] 2.6.17-rt1 : fix x86_64 oops
Message-ID: <20060706200639.GG1316@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20060628193256.GA4392@elte.hu> <20060628200247.GA7932@in.ibm.com> <20060629142442.GA11546@elte.hu> <20060629163236.GD1294@us.ibm.com> <20060629194145.GA2327@us.ibm.com> <20060629201144.GA24287@elte.hu> <20060703165750.GB3899@in.ibm.com> <20060704041519.GC16074@in.ibm.com> <20060704064307.GB2752@elte.hu> <20060704065024.GA5789@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060704065024.GA5789@elte.hu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 04, 2006 at 08:50:24AM +0200, Ingo Molnar wrote:
> 
> * Ingo Molnar <mingo@elte.hu> wrote:
> 
> > > Ingo, do you have a suspect ?
> > 
> > I suspect it's the patch below. That patch (from John) relaxes the 
> > affinities of IRQ threads: if there are /proc/irq/*/smp_affinity 
> > entries that have multiple bits set an IRQ thread is allowed to jump 
> > from one CPU to another while it is executing a IRQ-handler. It 
> > _should_ be fine but i'd not be surprised if that caused breakage ...
> 
> the patch below is against 2.6.17-rt5, does this solve the crashes?

And I also still get a segmentation fault when modprobing rcutorture
with this patch.  :-/

The segfault is bizarre -- it is in the module symbol-lookup code.  I get
the segfault regardless of what module parameters I specify, in fact,
it even shows up even if I comment out all the module parameters in
rcutorture.c.  Tiny modules, such as hello.c from "Linux Device Drivers",
work just fine -- but the size of rcutorture.ko is -way- below the
64k limit, and, as I mentioned, I get the oops even if I comment out
all of rcutorture's module parameters.

See oops below.

Any enlightenment available?

							Thanx, Paul

BUG: unable to handle kernel paging request at virtual address 75010000
 printing eip:
c0133941
*pde = 00000000
Oops: 0000 [#1]
PREEMPT SMP 
Modules linked in:
CPU:    0
EIP:    0060:[<c0133941>]    Not tainted VLI
EFLAGS: 00010297   (2.6.17-rt5-autokern1 #1) 
EIP is at lookup_symbol+0x16/0x3b
eax: ffffffff   ebx: c0345a5c   ecx: c0343e90   edx: c0343e98
esi: 75010000   edi: f8ded2a6   ebp: f1a61edc   esp: f1a61e98
ds: 007b   es: 007b   ss: 0068   preempt: 00000001
Process modprobe (pid: 3663, threadinfo=f1a60000 task=f12160d0 stack_left=7780 worst_left=-1)
Stack: f8df02d0 f8df1380 f8ded2a6 c013398c f8ded2a6 c03419f0 c0345a5c f8df02d0 
       f8df1380 0000008e 00000062 c01345b5 f8ded2a6 f1a61ed8 f1a61edc 00000001 
       00000000 f8dc2e31 f8df02d0 00000620 c0134b49 f8de2214 00000000 f8ded2a6 
Call Trace:
 [<c013398c>] __find_symbol+0x26/0x158 (16)
 [<c01345b5>] resolve_symbol+0x21/0x46 (32)
 [<c0134b49>] simplify_symbols+0x88/0x101 (36)
 [<c0135707>] load_module+0x5f0/0x913 (40)
 [<c0135a8e>] sys_init_module+0x41/0x1c5 (144)
 [<c0102a03>] syscall_call+0x7/0xb (24)
---------------------------
| preempt count: 00000001 ]
| 1-level deep critical section nesting:
----------------------------------------
.. [<c02f17f7>] .... _raw_spin_lock_irqsave+0xe/0x35
.....[<00000000>] ..   ( <= _stext+0x3feffd64/0x41)

Code: 43 83 c1 28 0f b7 42 30 39 c3 72 c7 31 d2 5b 89 d0 5e 5f 5d c3 57 56 53 8b 5c 24 18 8b 54 24 14 39 da 73 24 8b 72 04 8b 7c 24 10 <ac> ae 75 08 84 c0 75 f8 31 c0 eb 04 19 c0 0c 01 85 c0 89 d1 74 
EIP: [<c0133941>] lookup_symbol+0x16/0x3b SS:ESP 0068:f1a61e98

> 	Ingo
> 
> Index: linux-rt.q/kernel/irq/manage.c
> ===================================================================
> --- linux-rt.q.orig/kernel/irq/manage.c
> +++ linux-rt.q/kernel/irq/manage.c
> @@ -645,17 +645,24 @@ extern asmlinkage void __do_softirq(void
>  
>  static int curr_irq_prio = 49;
>  
> -static int do_irqd(void * __desc)
> +static void follow_irq_affinity(struct irq_desc *desc)
>  {
> -	struct sched_param param = { 0, };
> -	struct irq_desc *desc = __desc;
>  #ifdef CONFIG_SMP
> -	int irq = desc - irq_desc;
>  	cpumask_t mask;
>  
> -	mask = cpumask_of_cpu(any_online_cpu(irq_desc[irq].affinity));
> +	if (cpus_equal(current->cpus_allowed, desc->affinity))
> +		return;
> +	mask = cpumask_of_cpu(any_online_cpu(desc->affinity));
>  	set_cpus_allowed(current, mask);
>  #endif
> +}
> +
> +static int do_irqd(void * __desc)
> +{
> +	struct sched_param param = { 0, };
> +	struct irq_desc *desc = __desc;
> +
> +	follow_irq_affinity(desc);
>  	current->flags |= PF_NOFREEZE | PF_HARDIRQ;
>  
>  	/*
> @@ -674,13 +681,7 @@ static int do_irqd(void * __desc)
>  		local_irq_disable();
>  		__do_softirq();
>  		local_irq_enable();
> -#ifdef CONFIG_SMP
> -		/*
> -		 * Did IRQ affinities change?
> -		 */
> -		if (!cpus_equal(current->cpus_allowed, irq_desc[irq].affinity))
> -			set_cpus_allowed(current, irq_desc[irq].affinity);
> -#endif
> +		follow_irq_affinity(desc);
>  		schedule();
>  	}
>  	__set_current_state(TASK_RUNNING);
