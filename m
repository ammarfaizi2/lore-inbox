Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312559AbSCYUT2>; Mon, 25 Mar 2002 15:19:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312543AbSCYUTM>; Mon, 25 Mar 2002 15:19:12 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:16403 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S312559AbSCYUSq>; Mon, 25 Mar 2002 15:18:46 -0500
Message-ID: <3C9F85BC.7CCA42B7@zip.com.au>
Date: Mon, 25 Mar 2002 12:17:00 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Kevin Pedretti <ktpedre@sandia.gov>
CC: kernelnewbies@nl.linux.org, linux-kernel@vger.kernel.org
Subject: Re: do_exit() and lock_kernel() semantics
In-Reply-To: <3C9F7993.7050205@sandia.gov>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kevin Pedretti wrote:
> 
> Hello,
>     do_exit() does a lock_kernel() before it destroys the dying
> processes mm context (sets task_struct->mm to NULL in 2.4 and &init_mm
> in 2.2).  Does lock_kernel() somehow disable interrupts?  It doesn't
> look like it does.

Nope.

> Is there anyway from an interrupt context to check if a process is still
> alive (not exiting) and prevent it from exiting until the ISR is over?

See kernel/timer.c:count_active_tasks().  It does
read_lock(&task_list_lock) to pin everything down
while it walks the task list in an interrupt.

And you're in luck - tasklist_lock is exported to modules.

>  I guess if lock_kernel disables interrupts globally and waits for
> inprogress interrupts to complete, then this isn't a problem.
> 
> More detail:
> The reason I ask is that I'm working on/modifying a set of modules that
> accesses user space from interrupt context.  I know this is not a good
> thing to do generally, but for performance reasons the original author
> wanted to copy directly into a mlocked user space buffer from a network
> receive interrupt.  Since the buffer is mlocked, it is always guaranteed
> to be there and no page faults will happen (right??? I'm new at this).
>  Thus, for each receive we have to convert the virt address of the
> user-land receive buffer to a physical address (in the kernel region)
> before doing the memcpy (copy_to_user doesn't work from interrupt
> context).

That sounds sane.  Pin the user pages, set up a kernel virtual
mapping of them.  You can't rely on userspace having performed
the mlock of course; you'll need to pin the pages in-kernel.
Probably you can just use map_user_kiobuf().

>   This all seems to work fine in practice.  However, it seems
> to me that there is a race that can happen if a process is in the middle
> of dying and a receive interrupt happens.  task->mm can be set to
> NULL/init_mm out from under me while doing a receive (e.g. on another cpu).
> 

I guess that if you've pinned the pages, then you're safe even
if the task exits - the pages won't be going away.  But your
interrupt will need to deal with the kiovec, not the process mm.

This could end up meaning that your final page_cache_release()
happens in interrupt context.  We may have a problem with that
if the page is still on the global LRU.  See the thread
starting at http://www.uwsg.iu.edu/hypermail/linux/kernel/0202.0/1157.html

-
