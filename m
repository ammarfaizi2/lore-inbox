Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281726AbRLAVjW>; Sat, 1 Dec 2001 16:39:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281707AbRLAVjM>; Sat, 1 Dec 2001 16:39:12 -0500
Received: from mail.xmailserver.org ([208.129.208.52]:14604 "EHLO
	mail.xmailserver.org") by vger.kernel.org with ESMTP
	id <S281732AbRLAVi4>; Sat, 1 Dec 2001 16:38:56 -0500
Date: Sat, 1 Dec 2001 13:49:29 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Manfred Spraul <manfred@colorfullife.com>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] task_struct colouring ...
In-Reply-To: <000901c17a51$62526070$010411ac@local>
Message-ID: <Pine.LNX.4.40.0112011336250.1696-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 1 Dec 2001, Manfred Spraul wrote:

> >
> > 2) Code clarity
> >
> I really liked Ben's idea of an include file with macros for asm access to the current pointer.
> That was a major improvement for the code clarity. IMHO a patch that changes current
> should introduce such a file.
>
> >       unsigned long tskb = __get_free_pages(GFP_KERNEL, 1), tsk;
> >      tsk = tskb | ((tskb >> 13) & 0x00000060) | SMP_CACHE_BYTES;
> >      *(unsigned long *) tskb = tsk;
>
> You only colour 2 bits (offset 32, 64 or 96 - all within one cacheline on P 4) - I doubt that this
> helps a lot. And you do not colour the stack top - all processes sleeping in accept() will still
> have their wait queues at the same cache colour. And if you use more bits, you risk
> stack overflows.

32, 64, 96 and 128
Anyway it's clear that this is a 32 cache line size setup and that such
magic numbers have to change accounding to cache line size and
associativity level.
True that with CPUs with 7 or more bits for cache line size we're going to
be subject of stack overflow.
More then increasing stack allocation i'd rather prefer to allocate two
items ( like your patch ) 1) the task_struct from a slab 2) the stack with
__get_free_pages().
What I do not really like is storing pointers inside global CPU registers,
at least until the perf difference will justify it ( we'll see ).
The stack jittering is quite easy to implement in arch/??/kernel/process.c
and another couple of fixes.
I'll try slab task struct allocation + stack base pointer indirection.





- Davide



