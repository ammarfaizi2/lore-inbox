Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751689AbWEaEpd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751689AbWEaEpd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 00:45:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751692AbWEaEpd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 00:45:33 -0400
Received: from mse2fe2.mse2.exchange.ms ([66.232.26.194]:50609 "EHLO
	mse2fe2.mse2.exchange.ms") by vger.kernel.org with ESMTP
	id S1751688AbWEaEpc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 00:45:32 -0400
Subject: Re: linux-2.6 x86_64 kgdb issue
From: Piet Delaney <piet@bluelane.com>
Reply-To: piet@bluelane.com
To: "Amit S. Kale" <amitkale@linsyssoft.com>,
       "Vladimir A. Barinov" <vbarinov@ru.mvista.com>,
       Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>
Cc: Piet Delaney <piet@bluelane.com>, kgdb-bugreport@lists.sourceforge.net,
       trini@kernel.crashing.org, linux-kernel@vger.kernel.org
In-Reply-To: <200605251207.27699.amitkale@linsyssoft.com>
References: <446E0B4B.9070003@ru.mvista.com>
	 <200605241240.05313.amitkale@linsyssoft.com> <4474A1D0.30807@ru.mvista.com>
	 <200605251207.27699.amitkale@linsyssoft.com>
Content-Type: text/plain
Organization: BlueLane Tech,
Date: Tue, 30 May 2006 21:45:27 -0700
Message-Id: <1149050728.26542.85.camel@piet2.bluelane.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4-3mdk 
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 31 May 2006 04:45:31.0770 (UTC) FILETIME=[0C3465A0:01C6846D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-05-25 at 12:07 +0530, Amit S. Kale wrote:
> On Wednesday 24 May 2006 23:41, Vladimir A. Barinov wrote:
> > Amit S. Kale wrote:
> > >Looking at this again:
> > >Call Trace:  {kgdb_notify}
> > >                    {notifier_call_chain}
> > >                    {do_stack_segment}
> > >                    {stack_segment}
> > >                      {io_outb}
> > >                      {kgdb_mem2hex}
> > >
> > >Why is io_outb being called from kgdb_mem2hex. kgdb_mem2hex refers to data
> > >directly and not through io_outb.
> > >
> > >Perhaps it's got something to do with iommu feature. Have you used "iommu"
> > > on kernel command line?
> >
> > I have iommu switched on, but disabling this lead to the same dump_stack
> > result.
> 
> This is confusing. Could you shed some light on this.
> 
> > But I've used earlier version of kgdb_8250.c and io_outb() was a
> > callback similar to kgdb_oiwrite() in kgdb-2.6.16.tar.bz2.
> > I merged the kgdb_8250.c from the kgdb-2.6.16.tar.bz2 and got the
> > dump_stack:
> >                     {notifier_call_chain}
> >                     {do_stack_segment}
> >                      {stack_segment}
> >                      {kgdb_mem2hex}
> >                     {kgdb_mem2hex}
> >
> >
> > Also I've used 2.6.10 with this stack exception behavior. In 2.6.16
> > patched with kgdb-2.6.16.tar.bz2 the behavior is so that the target
> > reboots after multiple steps and a "continue" command  in the end.
> 
> Now it looks like we have a stack overflow. It would result in a stack 
> exception. Stack overflow usually results in a complete breakdown of a kernel 
> since there is no stack to handle the stack exception itself. Processors upto 
> pentium used float their buses, which would be detected by the surrounding 
> hardware and cause a reset. I am not sure whether modern processors and/or 
> hardware does that.
> 
> >
> > Just want to note that in 2.6.10 kernel the stack exception doesn't
> > occur if CONFIG_64BIT in linux/kernel/kgdb.c is not defined.
> 
> CONFIG_64BIT probably requires more stack. That's why you see a stack 
> exception.

I added some debug info to the thread and got stack overflows; it was
trivial to double the size of the stack. I was saving a back trace of
the stack during at each preemption point (Ex: spinlock) to allow
me to see the context of the active holders of spinlocks. I configured
it with CONFIG_DEBUG_PREEMPT_AUDIT and enabled large stacks in:
------------------------------------------------------------------------
 			include/asm-i386/thread_info.h:
------------------------------------------------------------------------
#ifdef CONFIG_DEBUG_PREEMPT_AUDIT
#define THREAD_SIZE     (8192 * 2)
#else
#ifdef CONFIG_4KSTACKS
#define THREAD_SIZE         (4096)
#else
#define THREAD_SIZE         (8192)
#endif
#endif
-------------------------------------------------------------------------
All you really need to do is change THREAD_SIZE from 
(8192) to (8192 * 2). I didn't have any problems in i386.



> 
> Unfortunately x86_64 architecture doesn't provide any stack overflow debugging 
> mechanism. Perhaps you can implement a little code in kgdb_handle_exception, 
> which checks whether we are beyond 7168 bytes of stack usage on entry. If we 
> are, declare a panic indicating a possible stack overflow later.

I was getting stack overflows on the SPARC architecture when compiling
the kernel -O1 for kgdb/kdbx debugging. I allocated a hot physical page
for each CPU as it was brought on line and then mapped it on the fly
when we got a stack overflow. I then pushed out the register window that
caused the trap, and then continued with the normal panic path. 

 
Perhaps we should add a kgdb config menu option and #define
CONFIG_16KSTACKS to double the stack size so the kernel can be 
debugged with more context available. I'm currently using -O0 for 
the networking stack and -O1 for the rest of the kernel. Sounds like 
it would be helpful now for AMD64 targets.

-piet

> 
> -Amit
> 
> >
> > Vladimir
> >
> > >-Amit
> > >
> > >On Friday 19 May 2006 23:45, Vladimir A. Barinov wrote:
> > >>Hi All,
> > >>
> > >>I'm working with em64t dual xeon board and have a problems with kgdb
> > >>when SMP is on.
> > >>During step by step debugging I've got the error message and gdb server
> > >>lost connection
> > >>to the target (gdb log is attached)
> > >>
> > >>Putting simple printk() and dump_stack() into the kgdb_notify():
> > >>    .....
> > >>    if  (cmd ==  DIE_TRAP) {
> > >>        printk("DIE_TRAP, args->str=%s,
> > >>kgdb_may_fault=%d\n",args->str,kgdb_may_fault);
> > >>        dump_stack();
> > >>    }
> > >>    ......
> > >>
> > >>I've got trace:
> > >>DIE_TRAP, args->str=stack segment, kgdb_may_fault=1
> > >>Call Trace:  {kgdb_notify}
> > >>                    {notifier_call_chain}
> > >>                    {do_stack_segment}
> > >>                    {stack_segment}
> > >>                      {io_outb}
> > >>                      {kgdb_mem2hex}
> > >>
> > >>The stack exception occurs always at the same step during debugging in
> > >>kgdb_mem2hex().
> > >>I've attached patch that fixes this issue.  Could you please review, is
> > >>this patch appropriate
> > >>to the problem?
> > >>
> > >>Vladimir
> 
> 
> -------------------------------------------------------
> All the advantages of Linux Managed Hosting--Without the Cost and Risk!
> Fully trained technicians. The highest number of Red Hat certifications in
> the hosting industry. Fanatical Support. Click to learn more
> http://sel.as-us.falkag.net/sel?cmd=lnk&kid=107521&bid=248729&dat=121642
> _______________________________________________
> Kgdb-bugreport mailing list
> Kgdb-bugreport@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/kgdb-bugreport
-- 
---
piet@bluelane.com

