Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262569AbUAOV4M (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jan 2004 16:56:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262458AbUAOV4M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jan 2004 16:56:12 -0500
Received: from chaos.analogic.com ([204.178.40.224]:64386 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262569AbUAOV4D
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jan 2004 16:56:03 -0500
Date: Thu, 15 Jan 2004 16:59:08 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Justin Pryzby <justinpryzby@users.sourceforge.net>
cc: sank saraph <sank_kernel@computermail.net>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: help project
In-Reply-To: <20040115205542.GA5149@andromeda>
Message-ID: <Pine.LNX.4.53.0401151657020.21514@chaos>
References: <20040113144551.00C2D7263@sitemail.everyone.net>
 <20040115205542.GA5149@andromeda>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The way VAX/VMS did a fast-boot was called "overlay".
It was used to save only "known" processes because they
were easiest. Basically, a few pages in the kernel
were allocated to load some code. The code attached
an interrupt (exception vector) and, therefore got
control. The code wrote everything in physical memory
to a file. It didn't allow any additional paging
or swapping at that time so the swap and page files
were preserved. It was not necessary to write all
the file-buffers, etc., to the output devices because
they were preserved by preserving physical memory.
The overlay file was written with a direct-write so
it didn't require the file-buffers.

Upon boot, the system opened and read the overlay file.
This was done after all hardware was initialized,
all drivers installed, etc., but before the page-file(s)
or swap-file(s) were opened and dirtied. If the
executive determined that the system had been shut-down
to be rebooted in the overlay mode, it would then allocate
some RAM, relocate some reloader software there, then
jump to that software. That software would read the
overlay file into physical RAM, replacing everything
including the software and buffers in the I/O drivers
that ran the disks. It had to do this in several steps
because each of the writes to the final location(s) needed
to be written there with the interrupts off so the state
wouldn't get corrupted.

Eventually, everything was overwritten to be in exactly
the same state as it had been when the overlay-file was
written, with all of the hardware initialized and ready
to go. The loader code executes a return from interrupt
which enables everything, and the machine resumes from
where it was when it was shut down.

DECNET (network) connections, of course, were not preserved.
This is actually easier than saving the state of an
individual task (process). The problem with tasks is the
state of everything it interfaces with may have changed.
For example, certainly the time has changed. Also, network
IP addresses and ports. Even files... It's a big problem.

That's why  "process migration" is really just some
remote procedure-calls on some other system. One of those
remote tasks can be the parent, coordinating task, of course.
There is nothing stopping it from copying it's executable, and
some file-data representing its current state to another
cooperating system and starting execution there. The new
child then tells its parent on the other system to quit.
It then becomes the new parent and process migration has
occurred. The parent can send tasks to be accomplished
to any of the cooperating systems and, some of the tasks
might even be to build computers, load operating systems,
and replicate.... Eventually there is no need for humans
anymore.


On Thu, 15 Jan 2004, Justin Pryzby wrote:

> I have a similar interest: I want to be able to take a process, save its
> state to a file, reboot, and reload the process.  Possibly on a
> different machine.  I hope you realize that there are _lots_ of points
> of failure, things like file deletion.  You should look at the mosix
> clustering project; they save the userspace state of a process, and
> transfer that across the network, and have system calls run on the
> remote host, which has all the arch-specific stuff.  A process ("task")
> is defined by a task_struct, in include/linux/sched.h., but that
> definition is not at all self-contained.  See
> [http://www.clarkson.edu/~pryzbyj/task/struct-task_struct.html] for some
> work I did to convince myself of this.  (I've given up on that
> document).  In short, there's no good way of doing this .. mosix saves
> the user context easily enough, but, sadly, saving the kernel stuff is,
> at best, extremely tedious.  Let me know if you come up with anything
> else.
>
> Justin
> On Tue, Jan 13, 2004 at 06:45:51AM -0800, sank saraph wrote:
> > Hello all,
> >                   I am currently working on the project ???Process Migration???
> > I want to save all the context, memory address space. So that it is
> > transferred to remote node & resume that process.
> >                 So how can I save the context of process?
> > Thanks in advanced ???.
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> >
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

Cheers,
Dick Johnson
Penguin : Linux version 2.4.24 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


