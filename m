Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264132AbTEGRZE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 13:25:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264130AbTEGRZE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 13:25:04 -0400
Received: from chaos.analogic.com ([204.178.40.224]:61826 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S264132AbTEGRZA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 13:25:00 -0400
Date: Wed, 7 May 2003 13:40:00 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Jonathan Lundell <linux@lundell-bros.com>
cc: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: top stack (l)users for 2.5.69
In-Reply-To: <p05210601badeeb31916c@[207.213.214.37]>
Message-ID: <Pine.LNX.4.53.0305071323100.13049@chaos>
References: <20030507132024.GB18177@wohnheim.fh-wedel.de>
 <Pine.LNX.4.53.0305070933450.11740@chaos> <20030507135657.GC18177@wohnheim.fh-wedel.de>
 <Pine.LNX.4.53.0305071008080.11871@chaos> <p05210601badeeb31916c@[207.213.214.37]>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 May 2003, Jonathan Lundell wrote:

> At 10:16am -0400 5/7/03, Richard B. Johnson wrote:
> >Nope. Just don't steal thousands of CPU cycles to make something
> >"pretty". Obviously something called recursively with a 2k buffer
> >on the stack is going to break. However one has to actually
> >look at the code and determine the best (if any) way to reduce
> >stack usage. For instance, some persons may just "like" 0x400 for
> >the size of a temporary buffer when, in fact, 29 bytes are actually
> >used.
> >
> >FYI, one can make a module that will show the maximum amount
> >of stack ever used IFF the stack gets zeroed before use upon
> >kernel startup. Would this be useful or has it already been
> >done?
>
> There's at least one patch floating around to do that; we've used it
> to help track down some stack overflow problems.
>
> Does 2.5 use a separate interrupt stack? (Excuse my ignorance; I
> haven't been paying attention.) Total stack-page usage in the 2.4
> model, at any rate, is the sum of the task struct, the usage of any
> task-level thread (system calls, pretty much), any softirq (including
> the network protocol & routing handlers, and any netfilter modules),
> and some number of possibly-nested hard interrupts.
>
> That adds up.
>
> One thing that would help (aside from separate interrupt stacks)
> would be a guard page below the stack. That wouldn't require any
> physical memory to be reserved, and would provide positive indication
> of stack overflow without significant runtime overhead.
> --
> /Jonathan Lundell.
>

The kernel stack, at least for ix86, is only one, set upon startup
at 8192 bytes above a label called init_task_unit. The kernel must
have a separate stack and, contrary to what I've been reading on
this list, it can't have more kernel stacks than CPUs and, I don't
see a separate stack allocated for different CPUs. The kernel stack
must be separate from the user stack or else a user could blow up
the kernel by setting ESP to 0 and waiting for an interrupt, etc.

The kernel can only have one stack or else you can't get back to
the task that was interrupted or preempted. If the kernel was
designed like VMS, it could have multiple stacks, but this
would require that every interrupt produce a context switch.
In that case, the interrupted task will simply be rescheduled
at some later time, as in VAX/VMS. Linux, and other Unix's I've
observed, don't do this. The interrupted user's state is
saved, the kernel segments are set, the interrupt procedure
is called, then the reverse to back-out and return control to
the user that was interrupted. Yes the interrupt steals time
from the user so it might not be "fair". However, it is faster
on handling interrupts.

I don't know where the idea that the kernel had multiple stacks
came from. Recently some of the kernel has been revamped so
the kernel might be premptible. If this is correct, it's
definitely required to have a single stack so it can be
unwound all the way back to the first preemption or else
a waiting task will lose it's place in the queue and never
get scheduled (lots of activity on a Nth level stack, while
the loser in one a N-1th level stack.


Cheers,
Dick Johnson
Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.

