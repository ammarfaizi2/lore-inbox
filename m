Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261728AbVGFFqq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261728AbVGFFqq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 01:46:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261381AbVGFFqp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 01:46:45 -0400
Received: from b3162.static.pacific.net.au ([203.143.238.98]:34437 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S261784AbVGFD62 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 23:58:28 -0400
Subject: Re: [PATCH] [19/48] Suspend2 2.1.9.8 for 2.6.12:
	510-version-specific-mac.patch
From: Nigel Cunningham <ncunningham@cyclades.com>
Reply-To: ncunningham@cyclades.com
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.61.0507052145470.2149@montezuma.fsmlabs.com>
References: <11206164411926@foobar.com>
	 <Pine.LNX.4.61.0507052145470.2149@montezuma.fsmlabs.com>
Content-Type: text/plain
Organization: Cycades
Message-Id: <1120622393.4860.22.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Wed, 06 Jul 2005 13:59:54 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

I've just noticed that all the subject lines are off by one. Sorry.
Shall I repost with it right this time?

Regarding this x86_64 patch, I haven't been able to test x86_64 support
yet (no hardware here), so I'm sure you're right about all the things.
I've really just parroted what swsusp does in its lowlevel code, since
saving and restoring cpu state is one thing we do the same way.

Will apply changes.

Regards,

Nigel

On Wed, 2005-07-06 at 13:53, Zwane Mwaikambo wrote:
> On Wed, 6 Jul 2005, Nigel Cunningham wrote:
> 
> > +	/*
> > +	 * eflags
> > +	 */
> > +	asm volatile ("pushfl ; popl (%0)" : "=m" (suspend2_saved_context.eflags));
> 
> To be future proof you probably want to do pushfq/popq
> 
> > +
> > +	/*
> > +	 * control registers 
> > +	 */
> > +	asm volatile ("movl %%cr0, %0" : "=r" (suspend2_saved_context.cr0));
> > +	asm volatile ("movl %%cr2, %0" : "=r" (suspend2_saved_context.cr2));
> > +	asm volatile ("movl %%cr3, %0" : "=r" (suspend2_saved_context.cr3));
> > +	asm volatile ("movl %%cr4, %0" : "=r" (suspend2_saved_context.cr4));
> 
> I guess we don't have to worry about %cr8 for now?
> 
> > + * a little clearer, but it needs to be inlined because we won't have a
> > + * stack when we get here (so we can't push a return address).
> > + */
> > +static inline void restore_processor_context(void)
> > +{
> > +	/*
> > +	 * first restore %ds, so we can access our data properly
> > +	 */
> > +	//asm volatile ("movw %0, %%ds" :: "r" ((u16)__KERNEL_DS));
> > +	
> > +	__flush_tlb_global(); /* INLINE? */
> > +
> > +	asm volatile ("movl	$24, %eax");
> > +	asm volatile ("movl	%eax, %ds");
> 
> Shouldn't that be KERNEL_DS?
> 
> > +	asm volatile ("pushl %0 ; popfl" :: "m" (suspend2_saved_context.eflags));
> 
> pushq/popfq?
> 
> > +	save_and_set_irq_affinity();
> > +	
> > +	c_loops_per_jiffy_ref[_smp_processor_id()] = current_cpu_data.loops_per_jiffy;
> > +#ifndef CONFIG_SMP
> > +	cpu_khz_ref = cpu_khz;
> > +	c_loops_per_jiffy_ref[_smp_processor_id()] = loops_per_jiffy;
> > +#endif
> > +	
> > +	/* We want to run from swsusp_pg_dir, since swsusp_pg_dir is stored in constant
> > +	 * place in memory 
> > +	 */
> > +
> > +        __asm__( "movl %%ecx,%%cr3\n" ::"c"(__pa(swsusp_pg_dir)));
> 
> This looks like it depends on the swsusp_pg_dir being in lower 32bit 
> address space, shouldn't it be a movq %%rcx?
> 
-- 
Evolution.
Enumerate the requirements.
Consider the interdependencies.
Calculate the probabilities.
Be amazed that people believe it happened. 

