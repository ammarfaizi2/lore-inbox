Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315758AbSGWXei>; Tue, 23 Jul 2002 19:34:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318238AbSGWXei>; Tue, 23 Jul 2002 19:34:38 -0400
Received: from node-209-133-23-217.caravan.ru ([217.23.133.209]:30734 "EHLO
	mail.tv-sign.ru") by vger.kernel.org with ESMTP id <S315758AbSGWXeg>;
	Tue, 23 Jul 2002 19:34:36 -0400
Message-ID: <3D3DE984.A6FEA4CB@tv-sign.ru>
Date: Wed, 24 Jul 2002 03:40:53 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: linux-kernel@vger.kernel.org
Subject: Re: [patch] big IRQ lock removal, 2.5.27-G0
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

I can't understand the preempt_count() check in irq_exit()
and local_bh_enable(). Did you meant irq_count() instead?
I beleive preempt_disable() should not disable soft interrupts.

In local_bh_enable() it is probably unneeded at all, because
nested local_bh_disable() is rare (i think), and do_softirq()
checks in_interrupt().

Now suppose preempt_count() & PREEMPT_MASK == 0.

Then local_bh_enable() has a small preemptible window between
__local_bh_enable() and do_softirq()->local_irq_save(flags).
It is only latency problem.

But in irq_exit() case interrupt context may be preempted
while doing wakeup_softirqd(cpu) after __local_bh_enable()
in do_softirq().

So i suggest something like this pseudo code:

__preempt_hack(offset)
{
        barrier();
        preempt_count() -= offset
#ifdef  CONFIG_PREEMPT
                        - 1
#endif
        ;
}

irq_exit()
{
        __preempt_hack(HARDIRQ_OFFSET);
        if (unlikely(!irq_count() &&
                        softirq_pending(smp_processor_id())))
                do_softirq();
        preempt_enable_no_resched();
}

local_bh_enable()
{
        __preempt_hack(SOFTIRQ_OFFSET);
        if (unlikely(!irq_count() &&
                        softirq_pending(smp_processor_id())))
                do_softirq();
        preempt_enable();
}

Or just add extra preempt_disable() in both functions to kill
terrible __preempt_hack().

Sorry, i have no remove-irqlock patches applied, so can't
suggest diff.

Oleg.
