Return-Path: <linux-kernel-owner+w=401wt.eu-S1755059AbXACJWT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755059AbXACJWT (ORCPT <rfc822;w@1wt.eu>);
	Wed, 3 Jan 2007 04:22:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755060AbXACJWT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Jan 2007 04:22:19 -0500
Received: from mail.gmx.net ([213.165.64.20]:58530 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755059AbXACJWT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Jan 2007 04:22:19 -0500
X-Authenticated: #5039886
Date: Wed, 3 Jan 2007 10:22:14 +0100
From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
To: Zefang.Wang@nokia.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Any problem if softirq are done in a interrupt context (IRQ stack)?
Message-ID: <20070103092214.GA2628@atjola.homenet>
Mail-Followup-To: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>,
	Zefang.Wang@nokia.com, linux-kernel@vger.kernel.org
References: <1E9D602D891FA142A769E9EF164712EC355C3A@beebe101.NOE.Nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1E9D602D891FA142A769E9EF164712EC355C3A@beebe101.NOE.Nokia.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2007.01.03 16:23:28 +0800, Zefang.Wang@nokia.com wrote:
> Hello all!
> 
> Kernel version : 2.6.18
> Arch : i386
> 
> With the following conditions,  it is possible that softirqs are
> executed in a interrupt context rather than process one
> 1)   CONFIG_4KSTACKS  ----> ON
> That means the dedicated IRQ stack is used for hardirq handler
> 
> 2)   there exist some Hard IRQ which allows interupt enabled when its
> handler being executed.
> That means a possibility that a HARD IRQ handler is interrupted by
> another one.
> 
> 3)  CONFIG_LOCKDEP  ---> OFF
> Instruction sti will be executed by local_irq_enable_in_hardirq()
> 
> 
> Let's suppose the following situation.
> 1)  A process is running without local irq nor bottom half disabled.
> 2)  A hardware interrupt happened.
> 3)  After saving context in process kernel stack,   it switch to irq
> stack. 
>       But notice :  the preempt_count in irq stack will be zero, because
> do_irq does not add HARDIRQ_OFFSET to the preept_count. 
>       (anyone tell me the reason?)

Because irq_ctx_init() initializes the preempt count to HARDIRQ_OFFSET,
the value is already correct.

> 
> 	if (curctx != irqctx) {
> 		int arg1, arg2, ebx;
> 
> 		/* build the stack frame on the IRQ stack */
> 		isp = (u32*) ((char*)irqctx + sizeof(*irqctx));
> 		irqctx->tinfo.task = curctx->tinfo.task;
> 		irqctx->tinfo.previous_esp = current_stack_pointer;
> 
> 		/*
> 		 * Copy the softirq bits in preempt_count so that the
> 		 * softirq checks work in the hardirq context.
> 		 */
> 		irqctx->tinfo.preempt_count =
> 			(irqctx->tinfo.preempt_count & ~SOFTIRQ_MASK) |
> 			(curctx->tinfo.preempt_count & SOFTIRQ_MASK);
> 
> 
> 4)  then __do_irq is called, and handle_irq_event is called. Before
> that,  local irq is enabled because the interrupt allow it.
> 5)  during the execution of the hardirq actions,  another hardware
> (depth 2 interrurpt) interrupt happened.
> 6)  SAVE context,  and then hardirq handler,  during the handler,  some
> softirq is marked

Note that curctx is equal to irqctx in this case, so we stay with the
hardirq context and the irq_enter() in do_IRQ() does the right thing.
The preempt count is incremented to HARDIRQ_OFFSET+1.

> 7)  when depth 2 interrrupt call irq_exit(),  surely do_softirq will be
> called because in_interrupt return a FALSE.
>      In this point, the stack is still irq stack.

No, irq_exit() will decrement the preempt count back to HARDIRQ_OFFSET,
so in_interrupt() will return true.

And the irq_exit() call for the first irq will actually happen in
process context, so a) the hard irq context's preempt count will stay at
HARDIRQ_OFFSET and b) the hardirq count in the process context will go
back to 0 (it was raised to 1 by the initial irq_enter() call).

HTH
Björn
