Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264061AbUEXGgJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264061AbUEXGgJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 May 2004 02:36:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264066AbUEXGgJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 May 2004 02:36:09 -0400
Received: from mx2.elte.hu ([157.181.151.9]:23184 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S264061AbUEXGgF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 May 2004 02:36:05 -0400
Date: Mon, 24 May 2004 10:37:15 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Cc: rmk+lkml@arm.linux.org.uk, davidel@xmailserver.org
Subject: Re: scheduler: IRQs disabled over context switches
Message-ID: <20040524083715.GA24967@elte.hu>
References: <20040523174359.A21153@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040523174359.A21153@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.26.8-itk2 (ELTE 1.1) SpamAssassin 2.63 ClamAV 0.65
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Russell King <rmk+lkml@arm.linux.org.uk> wrote:

> The 2.6.6 scheduler disables IRQs across context switches, which is
> bad news for IRQ latency on ARM - to the point where 16550A FIFO UARTs
> to overrun.
> 
> I'm considering defining prepare_arch_switch & co as follows on ARM,
> so that we release IRQs over the call to context_switch().

> The question is... why are we keeping IRQs disabled over
> context_switch() in the first case?  Looking at the code, the only
> thing which is touched outside of the two tasks is rq->prev_mm.  Since
> runqueues are CPU- specific and we're holding at least one spinlock, I
> think the above is preempt safe and SMP safe.

historically x86 context-switching has been pretty fragile when done
with irqs enabled. (x86 has tons of legacy baggage, segments, etc.) It's
also slightly faster to do the context-switch in one atomic swoop. On
x86 we do this portion in like 1 usec so it's not a latency issue.

if on ARM context-switching latency gives you UART problems then you can
enables irqs via ARM-specific version of prepare_arch_switch() &
finish_arch_switch().

	Ingo
