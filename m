Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315783AbSGWXvO>; Tue, 23 Jul 2002 19:51:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316199AbSGWXvO>; Tue, 23 Jul 2002 19:51:14 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:20208 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S315783AbSGWXvL>;
	Tue, 23 Jul 2002 19:51:11 -0400
Message-ID: <3D3DEC8D.E2BD71CB@mvista.com>
Date: Tue, 23 Jul 2002 16:53:49 -0700
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Zwane Mwaikambo <zwane@linuxpower.ca>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] irqlock patch -G3. [was Re: odd memory corruption in 
 2.5.27?]
References: <Pine.LNX.4.44.0207240100150.2732-100000@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> 
> On Tue, 23 Jul 2002, george anzinger wrote:
> 
> > I just spent a month tracking down this issue.  It comes
> > down to the slab allocater using per cpu data structures and
> > protecting them with a combination of interrupt disables and
> > spin_locks.  Preemption is allowed (incorrectly) if
> > interrupts are off and preempt_count goes to zero on the
> > spin_unlock. [...]
> 
> > The proposed fix is to catch the attempted preemption in
> > preempt_schedule() and just return if the interrupt system
> > is off. [...]
> 
> this is most definitely not the correct fix ...
> 
> i'm quite convinced that the fix is to avoid illegal preemption, not to
> work it around.

I like this.  The only change I would make is to enable
interrupts in exit.c and entry.S where they are only enabled
under the debug condition now, (mostly I try to avoid
Heisenberg).  I really do like the ability to track down
this problem by just turing on the debug option.
> 
> i've written debugging code that caught and reported this slab.c bug
> within minutes. 

Yeah, its easy when you know what to look for :)

> The code detects the irqs-off condition in schedule(). You
> can find it my latest irqlock patchset, at:
> 
>    http://redhat.com/~mingo/remove-irqlock-patches/remove-irqlock-2.5.27-G3
> 
> it fixes this and other related bugs as well.
> 
> Changes in -G3:
> 
>  - slab.c needs to spin_unlock_no_resched(), instead of spin_unlock(). (It
>    also has to check for preemption in the right spot.) This should fix
>    the memory corruption.
> 
>  - irq_exit() needs to run softirqs if interrupts not active - in the
>    previous patch it ran them when preempt_count() was 0, which is
>    incorrect.
> 
>  - spinlock macros are updated to enable preemption after enabling
>    interrupts. Besides avoiding false positive warnings, this also
> 
>  - fork.c has to call scheduler_tick() with preemption disabled -
>    otherwise scheduler_tick()'s spin_unlock can preempt!
> 
>  - irqs_disabled() macro introduced.
> 
>  - [ all other local_irq_enable() or sti instances conditional on
>      CONFIG_DEBUG_IRQ_SCHEDULE are to fix false positive warnings. ]
> 
> Changes in -G0:
> 
>  - fix buggy in_softirq(). Fortunately the bug made the test broader,
>    which didnt result in algorithmical breakage, just suboptimal
>    performance.
> 
>  - move do_softirq() processing into irq_exit() => this also fixes the
>    softirq processing bugs present in apic.c IRQ handlers that did not
>    test for softirqs after irq_exit().
> 
>  - simplify local_bh_enable().
> 
> Changes in -F9:
> 
>  - replace all instances of:
> 
>         local_save_flags(flags);
>         local_irq_disable();
> 
>    with the shorter form of:
> 
>         local_irq_save(flags);
> 
>   about 30 files are affected by this change.
> 
> Changes in -F8:
> 
>  - preempt/hardirq/softirq count separation, cleanups.
> 
>  - skbuff.c fix.
> 
>  - use irq_count() in scheduler_tick()
> 
> Changes in -F3:
> 
>  - the entry.S cleanups/speedups by Oleg Nesterov.
> 
>  - a rather critical synchronize_irq() bugfix: if a driver frees an
>    interrupt that is still being probed then synchronize_irq() locks up.
>    This bug has caused a spurious boot-lockup on one of my testsystems,
>    ifconfig would lock up trying to close eth0.
> 
>  - remove duplicate definitions from asm-i386/system.h, this fixes
>    compiler warnings.
> 
>         Ingo

-- 
George Anzinger   george@mvista.com
High-res-timers: 
http://sourceforge.net/projects/high-res-timers/
Real time sched:  http://sourceforge.net/projects/rtsched/
Preemption patch:
http://www.kernel.org/pub/linux/kernel/people/rml
