Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317142AbSGSVrW>; Fri, 19 Jul 2002 17:47:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317148AbSGSVrW>; Fri, 19 Jul 2002 17:47:22 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:41720 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S317142AbSGSVrV>;
	Fri, 19 Jul 2002 17:47:21 -0400
Message-ID: <3D388965.59690A44@mvista.com>
Date: Fri, 19 Jul 2002 14:49:25 -0700
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>,
       Russell King <rmk@arm.linux.org.uk>,
       "David S. Miller" <davem@redhat.com>
Subject: Re: [announce, patch, RFC] "big IRQ lock" removal, IRQ cleanups.
References: <Pine.LNX.4.44.0207202235400.23137-100000@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> 
> the following patch, against 2.5.26:
> 
>   http://redhat.com/~mingo/remove-irqlock-patches/remove-irqlock-2.5.26-A2

I haven't applied the patch, but just looking at it, it
appears that you have removed the conditional call to
softirq on local_bh_enable().  Isn't this needed?

-g
> 
> is a work-in-progress massive cleanup of the IRQ subsystem. It's losely
> based on Linus' original idea and DaveM's original implementation, to fold
> our various irq, softirq and bh counters into the preemption counter.
> 
> with this approach it was possible:
> 
>  - to remove the 'big IRQ lock' on SMP - on which sti() and cli() relied.
> 
>  - to streamline/simplify arch/i386/kernel/irq.c significantly.
> 
>  - to simplify the softirq code.
> 
>  - to remove the preemption count increase/decrease code from the lowlevel
>    IRQ assembly code.
> 
>  - to speed up schedule() a bit.
> 
> sti() and cli() is gone forever, there is no more globally synchronizing
> irq-disabling capability. All code that relied on sti() and cli() and
> restore_flags() must use other locking mechanisms from now on (spinlocks
> and __cli()/__sti()).
> 
> obviously this patch breaks massive amounts of code, so only limited
> .configs are working at the moment, such as:
> 
>   http://redhat.com/~mingo/remove-irqlock-patches/config
> 
> otherwise the patch was developed and tested on SMP systems, and while the
> code is still a bit rough in places, the base IRQ code appears to be
> pretty robust and clean.
> 
> while it boots already so the worst is over, there is lots of work left:
> eg. to fix the serial layer to not use cli()/sti() and bhs ...
> 
> RMK, is there any chance to get your new serial layer into 2.5 sometime
> soon? ['soon' as in 'tomorrow' :-) ] That is perhaps one of the biggest
> kernel subsystems that make use of cli()/sti() currently. The rest is
> drivers mostly, which is still not unsignificant, but perhaps a bit easier
> to manage.
> 
>         Ingo
> 
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
