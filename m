Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262000AbTEMQHO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 12:07:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262015AbTEMQHA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 12:07:00 -0400
Received: from ns.suse.de ([213.95.15.193]:54791 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262000AbTEMQFg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 12:05:36 -0400
Date: Tue, 13 May 2003 18:18:20 +0200 (CEST)
From: Bernhard Kaindl <bk@suse.de>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: Jeff Dike <jdike@karaya.com>, Matthew Grant <grantma@anathoth.gen.nz>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] Fix -EPERM returned by kernel_thead() if traced...
In-Reply-To: <200305122200_MC3-1-3890-B10A@compuserve.com>
Message-ID: <Pine.LNX.4.44.0305131703080.30209-100000@wotan.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 May 2003, Chuck Ebbert wrote:
> Bernhard Kaindl wrote:
>
> > -     task_lock(task);
> > -     if (task->ptrace) {
> > -             task_unlock(task);
> > -             return -EPERM;
> > -     }
> > -
> >       old_task_dumpable = task->task_dumpable;
> > +     /* prevent ptrace_attach() on the new task: */
> >       task->task_dumpable = 0;
> > -     task_unlock(task);
>
>   Is it safe to remove the task_lock()?

Yes. After checking, I came to this conclusion:

- the only place were we need to have the task_dumpable flag being 0
  is the *child* task which is created by do_fork() as the result
  of calling arch_kernel_thread().

- the parent task, which only requests the creation of a kernel thread
  but itself does not change itself into one with this call does not even
  need to set task_dumpable to 0 for itself, it's just the easyest way
  to set the task_dumpable = 0 copied to the new task:

  Just to show it, in do_fork(), there is this code at the very beginning:

        retval = -ENOMEM;
        p = alloc_task_struct();
        if (!p)
                goto fork_out;

======> *p = *current;

   This allocates a new task_struct for the skeleton of the new task
   and copies the whole task_struct from the parent (*current) to the
   new task_struct (*p), which also copies current->task_dumpable to
   p->task_dumpable.

   So the new task_struct p has task_dumpable set to the same value
   as current had at this time. And as task_dumpable is never changed
   for with another base than current, task_dumpable cannot change
   behind do_fork() is running. So it's 0 here and 0 for p->task_dumpable.

As said, doing task_dumpable = 0 in the parent before the clone() call
in arch_kernel_thread is only the easyest way to set it.

It's not the best way, because in theory, a tracer could try to attach
to the partent while he is executing arch_kernel_thread and before he
has restored task_dumpable to his old value.

During this time window, such tracer would be wrongly rejected from the
call to ptrace_attach() because withing this window, also the parent has
task_dumpable set to 0, not only the child.

The only clean way to fix this remaining side effect is to create a new
clone_flag (say CLONE_KERNEL) which is used by kernel_thread() to tell
do_fork() (or better copy_flags() within do_fork) to set p->task_dumpable
to 0 (only for the child)

I have not done this yet, but to have all cases covered,
it's the most sane way to do it.

> >  So I really have to assume that CLONE_PTRACE is never passed
> >  to create a kernel thread. If you are paranoid, you could just
> >  unmask it in kernel_thread() if you want.
>
>   I would mask it if it's a possible problem.  Someone might
> try to pass that option in future code...

Sure, no problem, it's easy and protects against such possible future
brain-dead uses of kernel_thread()... But OTOH, the only place where
this would be sufficent to create an exploit would be kmod, and I hope
nobody who does not know what he is doing will mess with it...

Ok, let's see. If nobody protests against adding CLONE_KERNEL support
to copy_flags() to set p->dumpable to 0, I would prepare a patch with
it.

Bernd

