Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317765AbSGVSAk>; Mon, 22 Jul 2002 14:00:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317766AbSGVSAj>; Mon, 22 Jul 2002 14:00:39 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:40950 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S317765AbSGVSA3>;
	Mon, 22 Jul 2002 14:00:29 -0400
Message-ID: <3D3C48D7.4B36F14E@mvista.com>
Date: Mon, 22 Jul 2002 11:03:03 -0700
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Oleg Nesterov <oleg@tv-sign.ru>
CC: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
Subject: Re: [announce, patch, RFC] "big IRQ lock" removal, IRQ cleanups.
References: <3D3C1A6E.53F29011@tv-sign.ru>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Nesterov wrote:
> 
> Hello.
> 
> > > [...] To do this from irq.c means that it must exit with interrupts off
> > > and the the low level code needs to keep them off till the irtn. [...]
> 
> > yes, we are very careful to keep irqs disabled in do_IRQ(), both before
> > and after calling the handler.
> 
> Note that smp_xxx_interrupt() functions must be carefull
> with preemt_{disable,enable} brackets.
> 
> For example, smp_invalidate_interrupt() may be preempted
> after put_cpu(). Probably not big deal (it is return path),
> but it is better to use preempt_enable_no_resched() here -
> let ret_from_intr: do its job.
> 
> smp_{error,spurious,thermal}_interrupt() - all of them
> use printk() without bumping preemt_count and have problem
> after spin_unlock_irqrestore(&logbuf_lock, flags).
> 
> If these problems worth fixing, then preempt_stop (cli)
> can be killed in entry.S:ret_from_intr(), yes? 

I REALLY have a problem with this abstraction for cli.  I
think it just makes the code hard to read...
> If i understand
> correctly none of the irq handlers should return to low level
> code with irq enabled.

But schedule and signal code does return with interrupts
enabled, so a cli is still needed here.  Also at least some
of the trap code returns with interrupts enabled.
> 
> P.S.
> 
> May I suggest somebody with good english fix
> Documentation/preempt-locking.txt?
> It states, that disabled interrupts prevents preemption.
> Yes, but only in a sense, that the delivery of reschedule
> interrupt is suppressed.
> 
> Process with irqs disabled and current->preempt_count == 0 can
> be preempted (with interrupts enabled) after spin_lock/unlock etc.
> Even in UP case preemption can happen while calling wake_up_...().

This is really a bug and a fix is on the way.  Turning
interrupts off MUST disable preemption, but trying to
preempt from this state is so rare that the test will be in
preempt_schedule() rather than inline or an attempt to put
disable/enable code along with each cli/sti.

-- 
George Anzinger   george@mvista.com
High-res-timers: 
http://sourceforge.net/projects/high-res-timers/
Real time sched:  http://sourceforge.net/projects/rtsched/
Preemption patch:
http://www.kernel.org/pub/linux/kernel/people/rml
