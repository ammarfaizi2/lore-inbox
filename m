Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315417AbSGVO4y>; Mon, 22 Jul 2002 10:56:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315430AbSGVO4y>; Mon, 22 Jul 2002 10:56:54 -0400
Received: from mx1.elte.hu ([157.181.1.137]:63137 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S315417AbSGVO4y>;
	Mon, 22 Jul 2002 10:56:54 -0400
Date: Mon, 22 Jul 2002 16:58:55 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: linux-kernel@vger.kernel.org, george anzinger <george@mvista.com>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: [patch] big IRQ lock removal, 2.5.27-D9
In-Reply-To: <3D3C1A6E.53F29011@tv-sign.ru>
Message-ID: <Pine.LNX.4.44.0207221650140.11103-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 22 Jul 2002, Oleg Nesterov wrote:

> Note that smp_xxx_interrupt() functions must be carefull
> with preemt_{disable,enable} brackets.
> 
> For example, smp_invalidate_interrupt() may be preempted
> after put_cpu(). Probably not big deal (it is return path),
> but it is better to use preempt_enable_no_resched() here -
> let ret_from_intr: do its job.

i solved it slightly differently: added a new put_cpu_no_resched() macro.

> smp_{error,spurious,thermal}_interrupt() - all of them
> use printk() without bumping preemt_count and have problem
> after spin_unlock_irqrestore(&logbuf_lock, flags).

fixed this - all these IRQ vector paths must use irq_enter()/irq_exit()  
pairs.

> If these problems worth fixing, then preempt_stop (cli) can be killed in
> entry.S:ret_from_intr(), yes? If i understand correctly none of the irq
> handlers should return to low level code with irq enabled.

yes, it can be removed, and i did this.

> May I suggest somebody with good english fix
> Documentation/preempt-locking.txt?
> It states, that disabled interrupts prevents preemption.
> Yes, but only in a sense, that the delivery of reschedule
> interrupt is suppressed.
> 
> Process with irqs disabled and current->preempt_count == 0 can
> be preempted (with interrupts enabled) after spin_lock/unlock etc.
> Even in UP case preemption can happen while calling wake_up_...().

added such a section to preempt-locking.txt.

this and the other changes can be found at:

   http://redhat.com/~mingo/remove-irqlock-patches/remove-irqlock-2.5.27-D9

is anything else missing?

	Ingo

