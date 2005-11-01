Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965003AbVKAJN1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965003AbVKAJN1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 04:13:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965008AbVKAJN1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 04:13:27 -0500
Received: from mail4.hitachi.co.jp ([133.145.228.5]:51408 "EHLO
	mail4.hitachi.co.jp") by vger.kernel.org with ESMTP id S965003AbVKAJN0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 04:13:26 -0500
Date: Tue, 01 Nov 2005 18:13:19 +0900 (JST)
Message-Id: <20051101.181319.92587627.noboru.obata.ar@hitachi.com>
To: ebiederm@xmission.com
Cc: fastboot@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [Fastboot] [KDUMP] pending interrupts problem
From: OBATA Noboru <noboru.obata.ar@hitachi.com>
In-Reply-To: <m13bmnc7jr.fsf@ebiederm.dsl.xmission.com>
References: <m13bmnc7jr.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Oct 2005, Eric W. Biederman wrote:
> 
> OBATA Noboru <noboru.obata.ar@hitachi.com> writes:
> 
> > What happens in the second kernel is that it receives the
> > pending IPI at the first local_irq_enable() in init/main.c, and
> > the IPI handler calls the uninitialized function pointer
> > call_data->func in arch/i386/kernel/smp.c.
> >
> > One way to solve this problem is to implement some blocking
> > mechanism in the IPI handler so that it prevents itself from
> > calling the uninitialized pointer.
> 
> Or simply initializing the pointer to NULL and testing to
> see if the IPI handler has been initialized.  Weird but
> doable.  

As I replied in the other thread, your patch has solved the
problem.  Thank you.

> > But pending interrupts on other vectors may cause another
> > problem.  They would cause misrouted IRQs, which are now
> > addressed by "irqpoll" kernel parameter.  But I'm not sure this
> > solves all the problems.
> 
> The irqs should not be misrouted.  They simply come at an unexpected
> time.

Okay, I guess the irqs are not misrouted because kdump does not
touch the IO-APIC routing table, and the second kernel will
build the same one.

> > So another way to solve this problem is to clear all such
> > pending interrupts before booting the second kernel.  
> 
> No.  The second kernel gets to cope, because we cannot
> do anything reliable in the crashed kernel.

Well, I first thought that restoring the hardware status back to
normal before booting the second kernel is better because it may
require fewer changes on the kernel core code.

But now I'm getting the idea what kdump is trying to do.  Kdump
wants to do less in the crashed kernel, and solve problems in
the second kernel.

> > /* pending-IPI.c - Panic a kernel with IPI pending  */
> >
> > #include <linux/config.h>
> > #include <linux/module.h>
> > #include <linux/smp.h>
> >
> > int init_module(void)
> > {
> > 	local_irq_disable();
> >
> > 	apic_wait_icr_idle();
> > 	apic_write_around(APIC_ICR2, SET_APIC_DEST_FIELD(1));
> > 	apic_write_around(APIC_ICR, (APIC_DM_FIXED
> > 				     | APIC_DEST_LOGICAL | 0xfb));
> >
> > 	panic("pending-IPI: Bye-bye.");
> >
> > 	return 0;
> > }
> >
> > MODULE_LICENSE("GPL");
> > MODULE_AUTHOR("OBATA Noboru <noboru.obata.ar@hitachi.com>");
> > MODULE_DESCRIPTION("Panic a kernel with IPI pending");
> 
> 
> This looks like a good test case.

I think we need more test cases, especially the cases that focus
on "status" of hardware, to make kdump more reliable.  Kdump
should recover from all possible status of supported hardware.

Is anyone working on developing such test cases for kdump?

Regards,

-- 
OBATA Noboru (noboru.obata.ar@hitachi.com)

