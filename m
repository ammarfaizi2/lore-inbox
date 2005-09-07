Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932067AbVIGTtN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932067AbVIGTtN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Sep 2005 15:49:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932229AbVIGTtN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Sep 2005 15:49:13 -0400
Received: from smtp.istop.com ([66.11.167.126]:57252 "EHLO smtp.istop.com")
	by vger.kernel.org with ESMTP id S932067AbVIGTtM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Sep 2005 15:49:12 -0400
From: Daniel Phillips <phillips@istop.com>
To: jan.kiszka@googlemail.com
Subject: Re: RFC: i386: kill !4KSTACKS
Date: Wed, 7 Sep 2005 15:52:27 -0400
User-Agent: KMail/1.8
Cc: Bill Davidsen <davidsen@tmr.com>, linux-kernel@vger.kernel.org
References: <20050904145129.53730.qmail@web50202.mail.yahoo.com> <431F2760.5060904@tmr.com> <58d0dbf10509071054175e82ff@mail.gmail.com>
In-Reply-To: <58d0dbf10509071054175e82ff@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509071552.27543.phillips@istop.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Is there a technical reason ("hard to implement" is a practical reason)
> > why all stacks need to be the same size?
>
> Because of
>
> static inline struct thread_info *current_thread_info(void)
> {
>         struct thread_info *ti;
>         __asm__("andl %%esp,%0; ":"=r" (ti) : "" (~(THREAD_SIZE - 1)));
>         return ti;
> }
> [include/asm-i386/thread_info.h]
>
> which assumes that it can "round down" the stack pointer and then will
> find the thread_info of the current context there. Only works for
> identically sized stacks. Note that this function is heavily used in
> the kernel, either directly or indirectly. You cannot avoid it.
>
> My current assessment regarding differently sized threads for
> ndiswrapper: not feasible with vanilla kernels.

If so, it is not because of this.  It just means you have to go back to the 
idea of switching back to the original stack when the Windows driver calls 
into the ndis API.  (It must have been way too late last night when I claimed 
the second stack switch wasn't necessary.)

Other issues:

  - Use a semaphore to serialize access to a single ndis stack... any
    spinlock or interrupt state issues?  (I didn't notice any.)

  - Copy parameters across the stack switch - a little tricky, but far from
    the trickiest bit of glue in the kernel

  - Preempt - looks like it has to be disabled from switching to the ndis
    stack to switching back because of the thread_info problem

  - It is best for Linux when life is a little hard for binary-only drivers,
    but not completely impossible.  When the smoke clears, ndis wrapper will
    be slightly slower than before and we will be slightly closer to having
    some native drivers.  In the meantime, keeping the thing alive without
    impacting core is an interesting puzzle.

Regards,

Daniel
