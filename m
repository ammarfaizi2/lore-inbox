Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315275AbSGVOjP>; Mon, 22 Jul 2002 10:39:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315417AbSGVOjP>; Mon, 22 Jul 2002 10:39:15 -0400
Received: from node-209-133-23-217.caravan.ru ([217.23.133.209]:52753 "EHLO
	mail.tv-sign.ru") by vger.kernel.org with ESMTP id <S315275AbSGVOjO>;
	Mon, 22 Jul 2002 10:39:14 -0400
Message-ID: <3D3C1A6E.53F29011@tv-sign.ru>
Date: Mon, 22 Jul 2002 18:45:02 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Ingo Molnar <mingo@elte.hu>, george anzinger <george@mvista.com>
Subject: Re: [announce, patch, RFC] "big IRQ lock" removal, IRQ cleanups.
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

> > [...] To do this from irq.c means that it must exit with interrupts off
> > and the the low level code needs to keep them off till the irtn. [...]

> yes, we are very careful to keep irqs disabled in do_IRQ(), both before
> and after calling the handler.

Note that smp_xxx_interrupt() functions must be carefull
with preemt_{disable,enable} brackets.

For example, smp_invalidate_interrupt() may be preempted
after put_cpu(). Probably not big deal (it is return path),
but it is better to use preempt_enable_no_resched() here -
let ret_from_intr: do its job.

smp_{error,spurious,thermal}_interrupt() - all of them
use printk() without bumping preemt_count and have problem
after spin_unlock_irqrestore(&logbuf_lock, flags).

If these problems worth fixing, then preempt_stop (cli)
can be killed in entry.S:ret_from_intr(), yes? If i understand
correctly none of the irq handlers should return to low level
code with irq enabled.

P.S.

May I suggest somebody with good english fix
Documentation/preempt-locking.txt?
It states, that disabled interrupts prevents preemption.
Yes, but only in a sense, that the delivery of reschedule
interrupt is suppressed.

Process with irqs disabled and current->preempt_count == 0 can
be preempted (with interrupts enabled) after spin_lock/unlock etc.
Even in UP case preemption can happen while calling wake_up_...().

Oleg.
