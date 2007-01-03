Return-Path: <linux-kernel-owner+w=401wt.eu-S1755049AbXACI6o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755049AbXACI6o (ORCPT <rfc822;w@1wt.eu>);
	Wed, 3 Jan 2007 03:58:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755051AbXACI6o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Jan 2007 03:58:44 -0500
Received: from smtp.nokia.com ([131.228.20.170]:51490 "EHLO
	mgw-ext11.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755050AbXACI6n convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Jan 2007 03:58:43 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: Any problem if softirq are done in a interrupt context (IRQ stack)?
Date: Wed, 3 Jan 2007 16:23:28 +0800
Message-ID: <1E9D602D891FA142A769E9EF164712EC355C3A@beebe101.NOE.Nokia.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Any problem if softirq are done in a interrupt context (IRQ stack)?
Thread-Index: AccvEHIwcBWZy3nVT3eW+sBBcK9ZUA==
From: <Zefang.Wang@nokia.com>
To: <linux-kernel@vger.kernel.org>
Cc: <Zefang.Wang@nokia.com>
X-OriginalArrivalTime: 03 Jan 2007 08:23:29.0341 (UTC) FILETIME=[72AF1ED0:01C72F10]
X-eXpurgate-Category: 1/0
X-eXpurgate-ID: 149371::070103102224-42EACBB0-39B0C502/0-0/0-1
X-Nokia-AV: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all!

Kernel version : 2.6.18
Arch : i386

With the following conditions,  it is possible that softirqs are
executed in a interrupt context rather than process one
1)   CONFIG_4KSTACKS  ----> ON
That means the dedicated IRQ stack is used for hardirq handler

2)   there exist some Hard IRQ which allows interupt enabled when its
handler being executed.
That means a possibility that a HARD IRQ handler is interrupted by
another one.

3)  CONFIG_LOCKDEP  ---> OFF
Instruction sti will be executed by local_irq_enable_in_hardirq()


Let's suppose the following situation.
1)  A process is running without local irq nor bottom half disabled.
2)  A hardware interrupt happened.
3)  After saving context in process kernel stack,   it switch to irq
stack. 
      But notice :  the preempt_count in irq stack will be zero, because
do_irq does not add HARDIRQ_OFFSET to the preept_count. 
      (anyone tell me the reason?)

	if (curctx != irqctx) {
		int arg1, arg2, ebx;

		/* build the stack frame on the IRQ stack */
		isp = (u32*) ((char*)irqctx + sizeof(*irqctx));
		irqctx->tinfo.task = curctx->tinfo.task;
		irqctx->tinfo.previous_esp = current_stack_pointer;

		/*
		 * Copy the softirq bits in preempt_count so that the
		 * softirq checks work in the hardirq context.
		 */
		irqctx->tinfo.preempt_count =
			(irqctx->tinfo.preempt_count & ~SOFTIRQ_MASK) |
			(curctx->tinfo.preempt_count & SOFTIRQ_MASK);


4)  then __do_irq is called, and handle_irq_event is called. Before
that,  local irq is enabled because the interrupt allow it.
5)  during the execution of the hardirq actions,  another hardware
(depth 2 interrurpt) interrupt happened.
6)  SAVE context,  and then hardirq handler,  during the handler,  some
softirq is marked
7)  when depth 2 interrrupt call irq_exit(),  surely do_softirq will be
called because in_interrupt return a FALSE.
     In this point, the stack is still irq stack.  

I don't know whether it cause some problem,  for example, if some
softirq need to make a flag in process control block.
Another problem is that softirq handling should have a lower prioirty
than hard irq, right?

Thanks for your attention and help.

Regards
Zefang

