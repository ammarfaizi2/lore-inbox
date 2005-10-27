Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751060AbVJ0PTG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751060AbVJ0PTG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Oct 2005 11:19:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751058AbVJ0PTG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Oct 2005 11:19:06 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:6289 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751062AbVJ0PTF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Oct 2005 11:19:05 -0400
To: OBATA Noboru <noboru.obata.ar@hitachi.com>
Cc: fastboot@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [Fastboot] [KDUMP] pending interrupts problem
References: <20051027.165027.97297370.noboru.obata.ar@hitachi.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Thu, 27 Oct 2005 09:18:32 -0600
In-Reply-To: <20051027.165027.97297370.noboru.obata.ar@hitachi.com> (OBATA
 Noboru's message of "Thu, 27 Oct 2005 16:50:27 +0900 (JST)")
Message-ID: <m13bmnc7jr.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OBATA Noboru <noboru.obata.ar@hitachi.com> writes:

> Hi all,
>
> I'm having a problem in kdump on a Pentium 4 box when using SMP
> kernel as the second (dump capturing) kernel.  Although the use
> of SMP kernel as the second kernel is discouraged in
> Documentation/kdump/kdump.txt, I hope discussing the problem
> here will benefit users in the future.

The problem with SMP is simply the additional cpus.  maxcpus=1
is good enough.

Are you using the version in the -mm tree?

We have recently put in code changes so the new kernel comes
up in apic mode and there is less work done by the crashing kernel.

I don't know if this will affect your problem but it is a good place to start.

> I tracked down the problem to write a small module (attached)
> that can reproduce the problem.
>
> How to reproduce:
>
>     - Configure both the first and the second kernels to be
>       CONFIG_SMP=y
>     - Boot the first kernel with "maxcpus=1"
>     - Run "insmod pending-IPI.ko" to oops the second kernel
>
> The module makes IPI (Inter-Processor Interrupt) pending upon a
> crash.  This is done by:
>
>     - Disable local interrupts.
>     - Send IPI to CPU#0.
>     - Call panic().
>
> What happens in the second kernel is that it receives the
> pending IPI at the first local_irq_enable() in init/main.c, and
> the IPI handler calls the uninitialized function pointer
> call_data->func in arch/i386/kernel/smp.c.
>
> One way to solve this problem is to implement some blocking
> mechanism in the IPI handler so that it prevents itself from
> calling the uninitialized pointer.

Or simply initializing the pointer to NULL and testing to
see if the IPI handler has been initialized.  Weird but
doable.  

...

Looking at the code it appears this problem is specific to
SMP kernels (the IPI code only appears there), call_data
is already initialized to NULL before use.  So it should
just be a matter of returning acking the irq and returning
if call_data is not set.

> But pending interrupts on other vectors may cause another
> problem.  They would cause misrouted IRQs, which are now
> addressed by "irqpoll" kernel parameter.  But I'm not sure this
> solves all the problems.

The irqs should not be misrouted.  They simply come at an unexpected
time.

> So another way to solve this problem is to clear all such
> pending interrupts before booting the second kernel.  

No.  The second kernel gets to cope, because we cannot
do anything reliable in the crashed kernel.

> This is
> more challenging because the pending status (IRR bits ON) in a
> local APIC can only be cleared by the acceptance of the
> interrupt by CPU core (See section 8.8.4 in "IA-32 Intel(R)
> Architecture Software Developer's Manual Vol.3").  That is, we
> need to enable the interrupt somewhere in a crashed kernel to
> clear the pending status.

No. There is no benefit to doing that in the crashed kernel over
doing it in the new kernel.  We just need to figure out how to
make the kernel as robust as possible.

> Any other ideas to deal with pending interrupts?

Interrupts are hard but it may make sense to disable bus masters,
and interrupts and reset as many busses as possible when the
system is coming up.

> OBATA Noboru (noboru.obata.ar@hitachi.com)
>
> /* pending-IPI.c - Panic a kernel with IPI pending  */
>
> #include <linux/config.h>
> #include <linux/module.h>
> #include <linux/smp.h>
>
> int init_module(void)
> {
> 	local_irq_disable();
>
> 	apic_wait_icr_idle();
> 	apic_write_around(APIC_ICR2, SET_APIC_DEST_FIELD(1));
> 	apic_write_around(APIC_ICR, (APIC_DM_FIXED
> 				     | APIC_DEST_LOGICAL | 0xfb));
>
> 	panic("pending-IPI: Bye-bye.");
>
> 	return 0;
> }
>
> MODULE_LICENSE("GPL");
> MODULE_AUTHOR("OBATA Noboru <noboru.obata.ar@hitachi.com>");
> MODULE_DESCRIPTION("Panic a kernel with IPI pending");


This looks like a good test case.

Eric
