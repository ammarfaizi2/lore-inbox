Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932229AbVIGU2P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932229AbVIGU2P (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Sep 2005 16:28:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932239AbVIGU2P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Sep 2005 16:28:15 -0400
Received: from wproxy.gmail.com ([64.233.184.196]:40326 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932229AbVIGU2O convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Sep 2005 16:28:14 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=googlemail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=cGZC9t6IbXcE5r8GveECTNzhT6knhcrzeu8F/ST5JsPLrKF684mwKHTgObkuWkohyC/WHFK4lY/+0nVzO3fT7+K6kcvHZeIy1te0KGjY0L756kZdQj2yDGBt+1pvLeC3brPEBU6EEdLqByLzhzIQhT9oKsNpUPfmG9rvkGBwKa4=
Message-ID: <58d0dbf105090713283aa455e8@mail.gmail.com>
Date: Wed, 7 Sep 2005 22:28:12 +0200
From: Jan Kiszka <jan.kiszka@googlemail.com>
Reply-To: jan.kiszka@googlemail.com
To: Daniel Phillips <phillips@istop.com>
Subject: Re: RFC: i386: kill !4KSTACKS
Cc: Bill Davidsen <davidsen@tmr.com>, linux-kernel@vger.kernel.org
In-Reply-To: <200509071552.27543.phillips@istop.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050904145129.53730.qmail@web50202.mail.yahoo.com>
	 <431F2760.5060904@tmr.com> <58d0dbf10509071054175e82ff@mail.gmail.com>
	 <200509071552.27543.phillips@istop.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2005/9/7, Daniel Phillips <phillips@istop.com>:
> > > Is there a technical reason ("hard to implement" is a practical reason)
> > > why all stacks need to be the same size?
> >
> > Because of
> >
> > static inline struct thread_info *current_thread_info(void)
> > {
> >         struct thread_info *ti;
> >         __asm__("andl %%esp,%0; ":"=r" (ti) : "" (~(THREAD_SIZE - 1)));
> >         return ti;
> > }
> > [include/asm-i386/thread_info.h]
> >
> > which assumes that it can "round down" the stack pointer and then will
> > find the thread_info of the current context there. Only works for
> > identically sized stacks. Note that this function is heavily used in
> > the kernel, either directly or indirectly. You cannot avoid it.
> >
> > My current assessment regarding differently sized threads for
> > ndiswrapper: not feasible with vanilla kernels.
> 
> If so, it is not because of this.  It just means you have to go back to the
> idea of switching back to the original stack when the Windows driver calls
> into the ndis API.  (It must have been way too late last night when I claimed
> the second stack switch wasn't necessary.)

That alone doesn't help. You would also have to disable at least bh
while windows functions are being executed, otherwise the scheduler
may crash when trying to switch to some other task. Even worse with 4K
stacks: take a look at how do_IRQ works, the common interrupt entry
point. It calls current_thread_info, thus expects to preempt normal
kernel stacks. So, should we execute Windows driver code with IRQs
off? I don't think so.

> 
> Other issues:
> 
>   - Use a semaphore to serialize access to a single ndis stack... any
>     spinlock or interrupt state issues?  (I didn't notice any.)

Too simple approach. You cannot deny that two or more functions of
ndiswrapper or the windows driver are being executed concurrently.

> 
>   - Copy parameters across the stack switch - a little tricky, but far from
>     the trickiest bit of glue in the kernel
> 
>   - Preempt - looks like it has to be disabled from switching to the ndis
>     stack to switching back because of the thread_info problem
> 
>   - It is best for Linux when life is a little hard for binary-only drivers,
>     but not completely impossible.  When the smoke clears, ndis wrapper will
>     be slightly slower than before and we will be slightly closer to having
>     some native drivers.  In the meantime, keeping the thing alive without
>     impacting core is an interesting puzzle.

Ndiswrapper is already slower than native drivers are, also due to
horribly implemented Windows drivers btw (the ndis model itself isn't
that bad, though).

After all the issues coming up, I'm even more convinced that any
effort on stack switching is better spent on moving ndiswrapper to
userspace - also expensive but safer in many ways.

Jan
