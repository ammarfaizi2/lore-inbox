Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315370AbSGUXlI>; Sun, 21 Jul 2002 19:41:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315279AbSGUXlI>; Sun, 21 Jul 2002 19:41:08 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:47093 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S315370AbSGUXlG>;
	Sun, 21 Jul 2002 19:41:06 -0400
Message-ID: <3D3B4734.244BBE2A@mvista.com>
Date: Sun, 21 Jul 2002 16:43:48 -0700
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Oleg Nesterov <oleg@tv-sign.ru>
CC: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
Subject: Re: [announce, patch, RFC] "big IRQ lock" removal, IRQ cleanups.
References: <3D39A48C.C0863416@tv-sign.ru>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Nesterov wrote:
> 
> Hello.
> 
> > - to remove the preemption count increase/decrease code from the lowlevel
> >   IRQ assembly code.

IMHO this is unwise as the system NEEDS to exit to user (or
system) space when preempt_count is zero with a garuntee
that TIF_NEED_RESCHED is 0.  To do this from irq.c means
that it must exit with interrupts off and the the low level
code needs to keep them off till the irtn.  But this is
where we test TIF_NEED_RESCHED, and if it is set, schedule()
is called and should be called with preempt_count != 0, to
avoid stack overflow interrupt loops.  And, schedule()
returns with the interrupt system on (even if we, unwisely,
call it with it off).  
> 
> So do_IRQ() can start with preempt_count == 0.
> Suppose another cpu sets TIF_NEED_RESCHED flag
> at the same time.
> 
> spin_lock(&desc->lock) sets preempt_count == 1.
> Before calling handle_IRQ_event() (which adds IRQ_OFFSET
> to preempt_count), do_IRQ() does spin_unlock(&desc->lock)
> and falls into schedule().
> 
> Am I missed something?

Nope, you got it right.
> 
> It seems to me that call to irq_enter() must be shifted
> from handle_IRQ_event() to do_IRQ().

Even then...
> 
> Oleg.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
George Anzinger   george@mvista.com
High-res-timers: 
http://sourceforge.net/projects/high-res-timers/
Real time sched:  http://sourceforge.net/projects/rtsched/
Preemption patch:
http://www.kernel.org/pub/linux/kernel/people/rml
