Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262202AbVAJLDH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262202AbVAJLDH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 06:03:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262205AbVAJLDG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 06:03:06 -0500
Received: from mx2.elte.hu ([157.181.151.9]:45955 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262202AbVAJLDB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 06:03:01 -0500
Date: Mon, 10 Jan 2005 12:02:52 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>,
       LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 2.6.10-mm2] Use the new preemption code [2/3] Resend
Message-ID: <20050110110252.GA1605@elte.hu>
References: <20050110013508.1.patchmail@tglx> <1105318406.17853.2.camel@tglx.tec.linutronix.de> <20050110010613.A5825@flint.arm.linux.org.uk> <1105319915.17853.8.camel@tglx.tec.linutronix.de> <20050110094624.A24919@flint.arm.linux.org.uk> <1105351977.3058.2.camel@lap02.tec.linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1105351977.3058.2.camel@lap02.tec.linutronix.de>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Thomas Gleixner <tglx@linutronix.de> wrote:

> > Are you sure ARM suffers from this race condition?  It sets preempt count
> > before enabling IRQs and doesn't use preempt_schedule().
> 
> There is no race for arm, but using the preempt_schedule() interface
> is the approach which Ingo suggested for common usage, but his x86
> implementation was racy, so I fixed this first before modifying arm to
> use the interface. Ingo pointed out that he will change it to
> preempt_schedule_irq, but I'm not religious about the name.

i wouldnt raise this issue if it was the name only, but there's more to
preempt_schedule_irq() than its name: it gets called with irqs off and
the scheduler returns with irqs off and with a guarantee that there is
no (irq-generated) pending preemption request for this task right now. 
I.e. the checks for need_resched can be skipped, and interrupts dont
have to be disabled to do a safe return-to-usermode (as done on some
architectures).

as far as i can see do_preempt_schedule() doesnt have these properties:
what it guarantees is that it avoids the preemption recursion via the
lowlevel code doing the PREEMPT_ACTIVE setting.

lets agree upon a single, common approach. I went for splitting up
preempt_schedule() into two variants: the 'synchronous' one (called
preempt_schedule()) is only called from syscall level and has no
repeat-preemption and hence stack-recursion worries. The 'asynchronous'
one (called preempt_schedule_irq()) is called from asynchronous contexts
(hardirq events) and is fully ready to deal with all the reentrancy
situations that may occur. It's careful about not re-enabling
interrupts, etc.

	Ingo
