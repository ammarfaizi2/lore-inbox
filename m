Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750974AbWHXJO0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750974AbWHXJO0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 05:14:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750975AbWHXJO0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 05:14:26 -0400
Received: from madara.hpl.hp.com ([192.6.19.124]:34242 "EHLO madara.hpl.hp.com")
	by vger.kernel.org with ESMTP id S1750966AbWHXJOZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 05:14:25 -0400
Date: Thu, 24 Aug 2006 02:04:09 -0700
From: Stephane Eranian <eranian@hpl.hp.com>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 17/18] 2.6.17.9 perfmon2 patch for review: modified x86_64 files
Message-ID: <20060824090409.GB3252@frankl.hpl.hp.com>
Reply-To: eranian@hpl.hp.com
References: <200608230806.k7N8689P000540@frankl.hpl.hp.com> <p73k64z7oh6.fsf@verdi.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <p73k64z7oh6.fsf@verdi.suse.de>
User-Agent: Mutt/1.4.1i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: eranian@hpl.hp.com
X-HPL-MailScanner: Found to be clean
X-HPL-MailScanner-From: eranian@frankl.hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi,

On Wed, Aug 23, 2006 at 12:09:25PM +0200, Andi Kleen wrote:
> Stephane Eranian <eranian@frankl.hpl.hp.com> writes:
> 
> In general this stuff would be much easier to review if you
> really split it into logical pieces: this means not modified/new,
> but one patch doing one thing. Then the hooks could be reviewed
> together with the code.
> 

Yes, I think that would be nice but it is very hard to generate 
such patches from the source tree that I have now. I would have to
manually edit the new/mod patches to group things based on
functionalities.


> > @@ -934,6 +935,7 @@ void setup_threshold_lvt(unsigned long l
> >  void smp_local_timer_interrupt(struct pt_regs *regs)
> >  {
> >  	profile_tick(CPU_PROFILING, regs);
> > + 	pfm_handle_switch_timeout();
> 
> It is still unclear why you can't use an ordinary add_timer() ?
> 

The hook is used to decrement a timeout value used for event set switching.
Set switching is upported for both per-thread and system-wide contexts. For
per-thread, the timeout must be "saved/restored" when the thread is context
switched. The timeout must be handled in the context of the monitored thread.
I am not sure add_timer() is a good fit for this. The add_timer looks good but
del_timer() does not as  for an active timer, it would need to return the
leftover duration so it can be reactivated via a new add_timer() on context
switch in.

> >  #include <asm/atomic.h>
> > @@ -589,6 +590,8 @@ void __init init_IRQ(void)
> >  	/* IPI vectors for APIC spurious and error interrupts */
> >  	set_intr_gate(SPURIOUS_APIC_VECTOR, spurious_interrupt);
> >  	set_intr_gate(ERROR_APIC_VECTOR, error_interrupt);
> > +
> > + 	pfm_vector_init();
> 
> I think I would prefer those to be expanded here so it's all in one place.
> 

Done.

> >  		put_cpu();
> >  	}
> > +	pfm_exit_thread(me);
> >  }
> >  
> >  void flush_thread(void)
> > @@ -462,6 +464,8 @@ int copy_thread(int nr, unsigned long cl
> >  	asm("mov %%es,%0" : "=m" (p->thread.es));
> >  	asm("mov %%ds,%0" : "=m" (p->thread.ds));
> >  
> > +	pfm_copy_thread(p);
> > +
> 
> AFAIK there was some work in -mm* for generic notifiers for exit/copy hooks. Can those
> be used?
> 
I have not yet looked at the -mm* tree.

> 
> >  	if (unlikely(test_tsk_thread_flag(me, TIF_IO_BITMAP))) {
> >  		p->thread.io_bitmap_ptr = kmalloc(IO_BITMAP_BYTES, GFP_KERNEL);
> >  		if (!p->thread.io_bitmap_ptr) {
> > @@ -532,6 +536,10 @@ static noinline void __switch_to_xtra(st
> >  		 */
> >  		memset(tss->io_bitmap, 0xff, prev->io_bitmap_max);
> >  	}
> > +
> > +	if (test_tsk_thread_flag(next_p, TIF_PERFMON)
> > +	    || test_tsk_thread_flag(prev_p, TIF_PERFMON))
> > +		pfm_ctxsw(prev_p, next_p);
> >  }
> >  
> >  /*
> > @@ -620,13 +628,12 @@ __switch_to(struct task_struct *prev_p, 
> >  	unlazy_fpu(prev_p);
> >  	write_pda(kernelstack,
> >  		  task_stack_page(next_p) + THREAD_SIZE - PDA_STACKOFFSET);
> > -
> > -	/*
> > -	 * Now maybe reload the debug registers and handle I/O bitmaps
> > -	 */
> > -	if (unlikely((task_thread_info(next_p)->flags & _TIF_WORK_CTXSW))
> > -	    || test_tsk_thread_flag(prev_p, TIF_IO_BITMAP))
> > -		__switch_to_xtra(prev_p, next_p, tss);
> > +  	/*
> > + 	 * Now maybe reload the debug registers and handle I/O bitmaps
> > +  	 */
> > + 	if (unlikely((task_thread_info(next_p)->flags & _TIF_WORK_CTXSW)
> > + 	    || (task_thread_info(prev_p)->flags & _TIF_WORK_CTXSW)))
> > + 		__switch_to_xtra(prev_p, next_p, tss);
> 
> 
> This should be a separate patch for once (creating _TIF_WORK_CTXSW)

The _TIF_WORK_CTXSW is already in a separate patch which you have accepted
into your tree if I recall. It was part of the TIF_DEBUG/TIF_IO_BITMAP patch.
Unless you are repeating the first point you have at the top of this message
about group by functionality.

> >  
> >  	return prev_p;
> >  }
> > diff -urp linux-2.6.17.9.base/arch/x86_64/kernel/signal.c linux-2.6.17.9/arch/x86_64/kernel/signal.c
> > --- linux-2.6.17.9.base/arch/x86_64/kernel/signal.c	2006-08-18 09:26:24.000000000 -0700
> > +++ linux-2.6.17.9/arch/x86_64/kernel/signal.c	2006-08-21 03:37:46.000000000 -0700
> > @@ -24,6 +24,7 @@
> >  #include <linux/stddef.h>
> >  #include <linux/personality.h>
> >  #include <linux/compiler.h>
> > +#include <linux/perfmon.h>
> >  #include <asm/ucontext.h>
> >  #include <asm/uaccess.h>
> >  #include <asm/i387.h>
> > @@ -493,6 +494,8 @@ void do_notify_resume(struct pt_regs *re
> >  		clear_thread_flag(TIF_SINGLESTEP);
> >  	}
> >  
> > +	pfm_handle_work(current);
> 
> At least the if () should be expanded, and most likely it wants
> merging with other flags too similar to the context switch (if (any work) { check which work })
> In separate patches again please.
> 
The situation is a little bit more complicated here. The pfm_handle_work()
can be invoked for one of 3 reasons:
  - BLOCK: we want to block the thread before it returns to user on its
           way back from a PMU interrupt. Why is this useful? As a consequence
	   of a counter overflow, the sampling buffer may be full at which
	   point monitoring stops and a user level notification is generated.
	   In this situation and when a tool is monitoring another thread, it
	   may be interesting to block that thread to avoid blind spots. This
	   is never systematic and must be requested. It only works when
	   non-self monitoring. By default, the monitored thread keeps on
	   running with monitoring turned off. Depending on the measurement
	   and workload, you may want to block to avoid blind spot or you want
	   to keep caches/TLB warm.

  - RESET: we need to reset the counters. This is needed when monitoring
	   another thread. You cannot remotely update the PMU of a thread unless
	   it is OFF any CPU.

  - ZOMBIE: Monitoring must be stoped and resources must be freed. This is the
	    case when a tool is monitoring another thread and the tool dies
	    first. At that time, the context is still attached to the monitored
	    thread. We cannot easily and synchronously stopped the other
	    thread on the exit path of the tool. Instead we use the 
	    TIF_NOTIFY_RESUME mechanism to force the monitored thread to cleanup
	    itself.

to get to pfm_handle_work(), we set TIF_NOTIFY_RESUME. Once in pfm_handle_work()
with the context properly locked, we check the reason for coming here. To mimic,
what we do with TIF flags in __switch_to(). I would have to add 3 new TIF flags.
The TIF_PERFMON flag means something different. When you come to notify_resume()
for a signal in a monitored thread, you may not need to go into pfm_handle_work().
But what is sure, is that if you do not have TIF_PERFMON set you never need to
get into pfm_handle_work(). So one thing I could do if to check for TIF_PERFMON
to miinize the number of useless calls to pfm_handle_work().

> 
> > +
> >  	/* deal with pending signal delivery */
> >  	if (thread_info_flags & _TIF_SIGPENDING)
> >  		do_signal(regs,oldset);
> > Only in linux-2.6.17.9/arch/x86_64: perfmon
> > diff -urp linux-2.6.17.9.base/include/asm-x86_64/hw_irq.h linux-2.6.17.9/include/asm-x86_64/hw_irq.h
> > --- linux-2.6.17.9.base/include/asm-x86_64/hw_irq.h	2006-08-18 09:26:24.000000000 -0700
> > +++ linux-2.6.17.9/include/asm-x86_64/hw_irq.h	2006-08-21 03:37:46.000000000 -0700
> > @@ -67,6 +67,7 @@ struct hw_interrupt_type;
> >   * sources per level' errata.
> >   */
> >  #define LOCAL_TIMER_VECTOR	0xef
> > +#define LOCAL_PERFMON_VECTOR	0xee
> >  
> >  /*
> >   * First APIC vector available to drivers: (vectors 0x30-0xee)
> > @@ -74,7 +75,7 @@ struct hw_interrupt_type;
> >   * levels. (0x80 is the syscall vector)
> >   */
> >  #define FIRST_DEVICE_VECTOR	0x31
> > -#define FIRST_SYSTEM_VECTOR	0xef   /* duplicated in irq.h */
> > +#define FIRST_SYSTEM_VECTOR	0xee   /* duplicated in irq.h */
> 
> We still had one up free iirc so there is no need to move the system vectors.
> 
Done.

Thanks for your useful feedback. I am slowly going through all your messages.

-- 
-Stephane
