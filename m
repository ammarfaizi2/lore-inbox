Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751163AbVKNPzn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751163AbVKNPzn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 10:55:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751164AbVKNPzn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 10:55:43 -0500
Received: from ojjektum.uhulinux.hu ([62.112.194.64]:26817 "EHLO
	ojjektum.uhulinux.hu") by vger.kernel.org with ESMTP
	id S1751163AbVKNPzm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 10:55:42 -0500
Date: Mon, 14 Nov 2005 16:55:24 +0100
From: Pozsar Balazs <pozsy@uhulinux.hu>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: start_kernel / local_irq_enable() can be very slow
Message-ID: <20051114155524.GF6457@ojjektum.uhulinux.hu>
References: <20051112155453.GC21291@ojjektum.uhulinux.hu> <20051113234451.73f2527b.akpm@osdl.org> <Pine.LNX.4.64.0511140740260.3263@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0511140740260.3263@g5.osdl.org>
User-Agent: Mutt/1.5.7i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > You could do something like:
> > 
> > int trace_irqs;
> > 
> > 	trace_irqs = 1;
> > 	local_irq_enble();
> > 	trace_irqs = 0;
> 
> Do "trace_irqs = 10" first.
> 
> > then, over in handle_IRQ_event():
> > 
> > 	if (trace_irqs)
> > 		print_symbol("calling %s\n", (unsigned long)action->handler);
> 
> And decrement it here somewhere.
> 
> If it's delayed by up to three seconds, it sounds like there's a _lot_ of 
> interrupts happening, and I don't think there's any point in showing all 
> of them.

Well, after using tons of printk's I found that the following is 
happening:
 - irqs get enabled, and the timer interrupt gets handled,
 - arch/i386/kernel/timer.c::timer_interrupt gets called,
 - which in turn calls cur_timer->mark_offset(), which is
 - arch/i386/kernel/timers/timer_pm.c::mark_offset_pmtmr(), where we 
   finally arrive to:
        /* compensate for lost ticks */
        if (lost >= 2)
                jiffies_64 += lost - 1;

So no irq storm here, everything works as it should, the jiffies gets 
updated as it should, that's why it _seems_ from printk's that it takes 
long. (And only 1 irq happens.)


The main question though remains: what takes up seconds on the kernel 
boot, and why is it so undeterministic how long it takes (sometimes just 
0.3s, sometimes even 3s)? (Something before timers get enabled.)


-- 
pozsy
