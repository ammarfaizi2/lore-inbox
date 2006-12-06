Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1760245AbWLFGT0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760245AbWLFGT0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 01:19:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760244AbWLFGT0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 01:19:26 -0500
Received: from smtp.osdl.org ([65.172.181.25]:32985 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760242AbWLFGTZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 01:19:25 -0500
Date: Tue, 5 Dec 2006 22:19:13 -0800
From: Andrew Morton <akpm@osdl.org>
To: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
Cc: linux-ia64@vger.kernel.org,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Arjan van de Ven <arjan@infradead.org>
Subject: Re: [PATCH] CPEI gets warning at
 kernel/irq/migration.c:27/move_masked_irq()
Message-Id: <20061205221913.1ef416f9.akpm@osdl.org>
In-Reply-To: <4575212A.3020902@jp.fujitsu.com>
References: <4575212A.3020902@jp.fujitsu.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 05 Dec 2006 16:35:06 +0900
Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com> wrote:

> Hi,
> 
> While running my MCA test (hardware error injection) on 2.6.19,
> I got some warning like following:
> 
> > BUG: warning at kernel/irq/migration.c:27/move_masked_irq()
> >
> > Call Trace:
> >  [<a000000100013d20>] show_stack+0x40/0xa0
> >                                 sp=e00000006b2578d0 bsp=e00000006b2510b0
> >  [<a000000100013db0>] dump_stack+0x30/0x60
> >                                 sp=e00000006b257aa0 bsp=e00000006b251098
> >  [<a0000001000de430>] move_masked_irq+0xb0/0x240
> >                                 sp=e00000006b257aa0 bsp=e00000006b251070
> >  [<a0000001000de6a0>] move_native_irq+0xe0/0x180
> >                                 sp=e00000006b257aa0 bsp=e00000006b251040
> >  [<a00000010004ff50>] iosapic_end_level_irq+0x30/0xe0
> >                                 sp=e00000006b257aa0 bsp=e00000006b251020
> >  [<a0000001000d94d0>] __do_IRQ+0x170/0x400
> >                                 sp=e00000006b257aa0 bsp=e00000006b250fd8
> >  [<a0000001000116f0>] ia64_handle_irq+0x1b0/0x260
> >                                 sp=e00000006b257aa0 bsp=e00000006b250fa8
> >  [<a00000010000c3a0>] ia64_leave_kernel+0x0/0x280
> >                                 sp=e00000006b257aa0 bsp=e00000006b250fa8
> >  [<a000000100690cf0>] _spin_unlock_irqrestore+0x30/0x60
> >                                 sp=e00000006b257c70 bsp=e00000006b250f90
> 
> It comes from:
> 
> [kernel/irq/migration.c]
>   26         if (CHECK_IRQ_PER_CPU(desc->status)) {
>   27                 WARN_ON(1);
>   28                 return;
>   29         }
> 
> By putting some printk in kernel, I found that irqbalance is trying to
> move CPEI which is handled as PER_CPU irq. That's why.
> 
> CPEI(Corrected Platform Error Interrupt) is ia64 specific irq, is
> allowed to pin to particular processor which selected by the platform, and
> even it is PER_CPU but it has set_affinity handler (=iosapic_set_affinity)
> as same as other IO-SAPIC-level interrupts. (I don't know why, but
> I guess that there would be typical situation where the handler for
> migration is needed, such as hotplug - the processor going to be
> offline/hot-removed.)
> 
> To shut up this warning, there are 2 way at least:
>  a) fix CPEI stuff
>  b) prohibit setting affinity to PER_CPU irq
> 
> I'm not sure what stuff of CPEI need to be fixed, but I think that
> returning error to attempting move PER_CPU irq is useful for all
> applications since it will never work.
> 
> Following small patch takes b) style.
> It works, the warning disappeared and irqbalance still runs well.
> 
> Thanks,
> H.Seto
> 
> Signed-off-by: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
> 
> ---
>  kernel/irq/proc.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> Index: linux-2.6.19/kernel/irq/proc.c
> ===================================================================
> --- linux-2.6.19.orig/kernel/irq/proc.c
> +++ linux-2.6.19/kernel/irq/proc.c
> @@ -54,7 +54,8 @@ static int irq_affinity_write_proc(struc
>  	unsigned int irq = (int)(long)data, full_count = count, err;
>  	cpumask_t new_value, tmp;
> 
> -	if (!irq_desc[irq].chip->set_affinity || no_irq_affinity)
> +	if (!irq_desc[irq].chip->set_affinity || no_irq_affinity ||
> +				CHECK_IRQ_PER_CPU(irq_desc[irq].status))
>  		return -EIO;

It'd be nice if we could just teach the userspace balancer to not try to
move perpcu IRQs?

otoh, the patch is super-cheap.   Arjan?

