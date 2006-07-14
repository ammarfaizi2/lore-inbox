Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161093AbWGNLpR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161093AbWGNLpR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 07:45:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161094AbWGNLpQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 07:45:16 -0400
Received: from cantor2.suse.de ([195.135.220.15]:29155 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1161093AbWGNLpP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 07:45:15 -0400
From: Andi Kleen <ak@suse.de>
To: Keith Owens <kaos@sgi.com>
Subject: Re: x86_64 kernel stack organization
Date: Fri, 14 Jul 2006 13:42:42 +0200
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org
References: <16644.1152860423@kao2.melbourne.sgi.com>
In-Reply-To: <16644.1152860423@kao2.melbourne.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607141342.42937.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 14 July 2006 09:00, Keith Owens wrote:
> I could not find a document that described the x86_64 kernel stack
> organization so I wrote this one.  Sending to lkml for a sanity check
> before doing a patch against linux/Documentation, plus trying to get
> answers to some questions.

It contains too much implementation detail. Will likely outdate quickly.
Better shorten at least by 50% 

Also I'm not sure it is that useful to describe the hardware architecture
here (like ISTs). That is well documented in the Intel/AMD manuals
and a serious kernel programmer should read these anyways. Just add
a one line reference.
 
> x86_64 page size (PAGE_SIZE) is 4K.
> 
> Like all other architectures, x86_64 has a kernel stack for every
> active thread.  These thread stacks are THREAD_SIZE (2*PAGE_SIZE) big.
> These stacks contain useful data as long as a thread is alive or a
> zombie, no matter whether the thread is in user space or in the kernel.
> 
> In addition to the per thread stacks, there are specialized stacks
> associated with each cpu.  These stacks are only used while the kernel
> is in control on that cpu, when a cpu returns to user space the
> specialized stacks contain no useful data.  The main cpu stacks is

are

> * Interrupt stack.  IRQSTACKSIZE (4*PAGE_SIZE).
> 
>   Used for external hardware interrupts.  If this is the first external
>   hardware interrupt (i.e. not a nested hardware interrupt) then the
>   kernel switches from the current task to the interrupt stack.  Like
>   the split thread and interrupt stacks on i386 (with CONFIG_4KSTACKS),

It is the other way round - x86-64 was first, i386 copied the scheme.

>   this gives more room for kernel interrupt processing without having
>   to increase the size of every per thread stack.
> 
>   The interrupt stack is also used when processing a softirq.  Unlike
>   the hardware interrupt code which allows nested interrupts, softirq
>   processing unconditionally switches to using the interrupt stack.
>   Soft irqs cannot be nested.
> 
> Switching to the kernel interrupt stack is done by software, allowing
> the kernel to decide when to switch.

Among all the irrelevant detail you left out the crucial points: 
The hardware interrupt frame is still written on the original stack.
x86-64 redzones (allows compiler access stack pointer) have to be 
disabled by a compiler option because of that. And ISTs are not used for 
normal interrupt stacks because they don't nest.

> x86_64 also has a feature which 

That should be all removed.

> The currently assigned IST stacks are :-

We call them exception stacks which they are.

> * STACKFAULT_STACK.  EXCEPTION_STKSZ (PAGE_SIZE).
> 
>   Used for interrupt 12 - Stack Fault Exception (#SS).
> 
>   Question: Why use an IST for this event instead of the normal
>   hardware interrupt stack?  Is this an attempt to detect kernel stack
>   overflow?  AFAICT it is ineffective, x86_64 does not check segment
>   limits in 64bit mode.

Stackfault happens for more cases than just stack segment limit checking.

>   Question: The kernel code allows for DEBUG_STKSZ to be different from
>   EXCEPTION_STKSZ, but currently they are the same value.  This
>   prevents debug interrupts from being nested.
>   Hardware debug events 
>   cannot be nested, but software debug interrupts have the potential to
>   be nested.  Macro paranoid adjusts the TSS entry by EXCEPTION_STKSZ
>   which only allows one level of debug interrupt.  Is this intentional?
>   I note that http://lkml.org/lkml/2006/5/10/22 tries to address this.

Revisiting that is on my todo list.  I still maintain it's more a kprobes
bug than a real feature though.


-Andi
