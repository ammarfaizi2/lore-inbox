Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261184AbTD1QYQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Apr 2003 12:24:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261188AbTD1QYQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Apr 2003 12:24:16 -0400
Received: from user72.209.42.38.dsli.com ([209.42.38.72]:64139 "EHLO
	nolab.conman.org") by vger.kernel.org with ESMTP id S261184AbTD1QYN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Apr 2003 12:24:13 -0400
Date: Mon, 28 Apr 2003 12:36:30 -0400 (EDT)
From: Mark Grosberg <mark@nolab.conman.org>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFD] Combined fork-exec syscall.
In-Reply-To: <Pine.LNX.4.53.0304280855240.16444@chaos>
Message-ID: <Pine.BSO.4.44.0304281219420.22115-100000@kwalitee.nolab.conman.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 28 Apr 2003, Richard B. Johnson wrote:

> The Unix API provides execve(), fexecve(), execv(), execle(),
> execl(), execvp(), and execlp() for what you call 'exec'. So
> there is no 'fork and exec' as you state.

I'm well aware of this.

> The kernel provides one system call, execve(). All of the
> other functional changes are done with 'C' wrappers in the

As I am of this.

> 'C' runtime library. To make a generic fork-exec, would require
> that this code, or its functionality, be moved into the kernel.

And why pray tell could the kernel not supply a nexecve() and then C
wrappers be used to get the various versions?

> To save some processing time, most knowledgeable software
> engineers would use vfork(). This leaves the major time,
> the time necessary to load the new application into the
> new address space and begin its execution. This time could

I am also aware of vfork(). I've been using UNIX back when the mashey
shell was around.

The point of my system call is:

  (1) Save the extra overhead of vfork() and exec(). A single system
      call would still be faster.

  (2) Avoid the resulting file descriptor manipulations for setting
      up pipelines (dup's and closes).

  (3) Avoid having to do any execution of the child. vfork() shares the
      address space but there is still overhead in doing the setup of
      vfork().

And maybe on your 797.90 BogoMips super fast machine the extra syscall
doesn't matter. But on my current server hardware (16.59 BogoMIPS) it is a
savings. So either:

  (1) Buy me a new server so the syscall overhead isn't such a big deal
  (2) Go bother somebody else

There _are_ people you know who do run Linux on embedded devices where CPU
clocks are slow and saving several system calls could be a big deal.

I am not *just* talking about two syscalls here, I am also taking about
dup's and closes.

> be tens of milliseconds or even hundreds if the application
> is on a CD, floppy, a disk that hasn't been accessed yet,

I suppose you have never heard of demand paging in a
binary? Maybe you should give me a kernel lesson on that.

> You can measure the time for a system call by executing
> getpid() or something similar. It is in the noise compared
> to the time necessary to execute a program. Further, we

On what hardware? On what CPU architecture? And if you have 100 users
slamming away at their shells all day, that noise adds up.

> it can't be verified. What will be verified, though, is
> the increase in size of the kernel.

Then what about the sendfile() API! It's totally just a speed hack and a
simple mmap()/write() would probably be just as fast and is POSIX
compliant.

sendfile() just contributes to kernel bloat. It bloats every vfsops
structure and all the implementations are taking up valuable non-pageable
kernel space. So let's get rid of sendfile!

>     case 0:
>         if(*type == (char)'r')
>         {
>             dup2(file->pfd[1], STDOUT_FILENO);
>             (void)close(file->pfd[0]);

Two syscalls saved.

>         signal(SIGINT, SIG_IGN);
>         signal(SIGQUIT, SIG_IGN);

Two more saved (signal dispositions wouldn't be copied over, like in
exec).

>         execve(args[0], args, __environ);
>         exit(EXIT_FAILURE);

One more saved here.

Although there are ways around this, this code does *NOT* inform the
parent of the failure to load a process which could be different from the
real process returning EXIT_FAILURE.

> Clearly, some additional, non-generic, processing has to
> occur after the fork() and before execve(). For instance,
> in the parent it is mandatory that the file descriptor that
> is not being accessed by the parent be closed just as it

Ahem. So lets look at my original proposal which replaced the entire set
of fd's with a new set. So thats 5 system calls saved over your
implementation. Five transitions between user mode and kernel mode.

> system. That's why Unix breaks these functions into little
> pieces (primitives) so the writer has control over the

I'm not saying get rid of the primitives. I am saying that a fork-followed
by exec() where the file descriptor map is the only thing changed is such
a common operation that it should be built into the kernel as a single
syscall to save the overhead of calling the primitives.

> Reducing the number of lines of code may be a good thing.
> However, the proper place for that is in the 'C' library,
> not the kernel.

I am not talking about reducing the number of lines? Can you read my
original post please. We are talking about the overhead of syscalls!

> Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).

Linux version 2.0.39 on an i486sx machine (16.59 BogoMIPS) and usually 5-6
active users at any instant (plus a dozen services).


