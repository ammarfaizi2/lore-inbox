Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264210AbTEGTsy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 15:48:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264221AbTEGTsy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 15:48:54 -0400
Received: from chaos.analogic.com ([204.178.40.224]:10115 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S264210AbTEGTsv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 15:48:51 -0400
Date: Wed, 7 May 2003 16:04:19 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Roland Dreier <roland@topspin.com>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: top stack (l)users for 2.5.69
In-Reply-To: <52n0hyo85x.fsf@topspin.com>
Message-ID: <Pine.LNX.4.53.0305071547060.13869@chaos>
References: <20030507132024.GB18177@wohnheim.fh-wedel.de>
 <Pine.LNX.4.53.0305070933450.11740@chaos> <20030507135657.GC18177@wohnheim.fh-wedel.de>
 <Pine.LNX.4.53.0305071008080.11871@chaos> <p05210601badeeb31916c@[207.213.214.37]>
 <Pine.LNX.4.53.0305071323100.13049@chaos> <52k7d2pqwm.fsf@topspin.com>
 <Pine.LNX.4.53.0305071424290.13499@chaos> <52bryeppb3.fsf@topspin.com>
 <Pine.LNX.4.53.0305071523010.13724@chaos> <52n0hyo85x.fsf@topspin.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 May 2003, Roland Dreier wrote:

>     Roland> Right.  Now think about where the kernel stack for the
>     Roland> process that is sleeping in the kernel is kept.
>
>     Richard> It's the kernel, of course. The scheduler runs in the
>     Richard> kernel under the kernel stack, with the kernel data. It
>     Richard> has nothing to do with the original user once the user
>     Richard> sleeps. The user's context was saved, the kernel was set
>     Richard> up, and the kernel will schedule other tasks until the
>     Richard> sleep time or the sleep_on even is complete.  At that
>     Richard> time, (or thereafter), the kernel will schedule the
>     Richard> previously sleeping task, its context will be restored,
>     Richard> and it continues execution.
>
>     Richard> The context of a task (see entry.S) is completely defined
>     Richard> by its registers, including the hidden part of the
>     Richard> segments (selectors) that define privilege.
>
> I'll try one more time.  Let's say a user process makes a system call
> and enters the kernel.  That system call goes through a few function
> calls in the kernel (which each push something on the kernel stack for
> that process).  Finally, the kernel has to sleep to sleep to service
> the system call (let's say it's a blocking read() waiting for some
> data to arrive on a socket).
>
> OK, now the scheduler runs, and another user process starts and makes
> its own system call, which also goes to sleep.
>
> Now say the data the original process was waiting for arrives.  The
> scheduler wakes up that process, which is in the kernel, and it
> finishes servicing the read.  This means it now returns through the
> chain of kernel function calls before returning to user space.  Each
> return in kernel space has to pop some stuff off the stack, and it
> better not get mixed up with the second process's kernel stack.
>
> That's (one reason) why each process needs its own kernel stack.
>


But no! Not at all. The context of a user does not need to be saved
on the stack, and in fact, isn't. It's saved in a task structure
that was created when the original task was born. The pointer to
that task structure is called 'current' in the kernel. It's in
the kernel's data space, and everything necessary to put that
task back together is in that structure.

Context switching is usually not done by pushing all the registers
onto a stack, then later popping them back. That's not the way
it works.

When a caller executes int 0x80, this is a software interrupt,
called a 'trap'. It enters the trap handler on the kernel stack,
with the segment selectors set up as defined for that trap-handler.
It happens because software told hardware what to do ahead of time.
Software doesn't do it during the trap event. In the trap handler,
no context switch normally occurs. This is so that the kernel can
perform privileged tasks upon behalf of the caller without the
overhead of a context switch. However, all the user's registers
are saved and the kernel's data selector(s) are set so that they
can access the kernel data and the user's data (the user-mode
pointers for file/IO work, etc.). This happens in the context of
the user, but the privilege of the kernel. If the kernel-mode
function needs to sleep, the user's registers have already been
saved it its "current" structure. The kernel is free to find
some other task to load from the run queue and switch to that
task (see switch_to()).

Cheers,
Dick Johnson
Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.

