Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290872AbSARXdu>; Fri, 18 Jan 2002 18:33:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290874AbSARXdj>; Fri, 18 Jan 2002 18:33:39 -0500
Received: from mnh-1-25.mv.com ([207.22.10.57]:42508 "EHLO ccure.karaya.com")
	by vger.kernel.org with ESMTP id <S290872AbSARXd2>;
	Fri, 18 Jan 2002 18:33:28 -0500
Message-Id: <200201182335.SAA05269@ccure.karaya.com>
X-Mailer: exmh version 2.0.2
To: linux-kernel@vger.kernel.org
Subject: Re: [uml-devel] new virtualization syscall to improve uml performance?
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 18 Jan 2002 18:35:53 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

baccala@freesoft.org said:
> First, kudos to everyone who worked on user mode linux. 

Thanks!

> Anyway, I was reading about the design of UML, and it seems to me that
> its performance could be improved by adding a split privilege concept
> to Linux processes.  A "normal" process would be "privileged".
> However, to support things like UML, a new syscall could put the
> process into "unprivileged" mode, which would cause any traps or
> faults (like syscalls or SEGVs) to drop the process into "privileged"
> mode at a controlled entry point.

This is an interesting idea.  All signals would have to drop you back into
privileged mode, and syscalls would invoke the SIGTRAP handler (I'm not
that fond of this, but it works and it's more or less the way syscall
interception is done now (the process SIGTRAP handler isn't called, but
the tracer is woken up with the child being sent a SIGTRAP)).

I was planning on adding a new slow syscall path (enabled with 
PTRACE_SIGSYSCALL or something) which delivers a SIGTRAP to the process and 
turns off PTRACE_SIGSYSCALL for the duration of the handler.

Your idea would result in basically the same code, but with a much more 
sensible interface to it.  Mine would add yet another wart to ptrace, making
it even more toadlike than it is now.  The notion of two process privilege
levels is much cleaner and more general.

> Adding an extra bit to the mmap/
> mprotect protection flags could specify memory mappings only
> accessible from privileged mode.

And this knocks off another problem.  This would allow UML to unmap kernel
text and data while in unprivileged mode without the huge performance penalty
it has now with mprotecting it by hand.

Though, since processes are normally in privileged mode, I would turn that
flag around and say that in unprivileged mode, only specially marked mappings
are available.

This possibly ties in well with something else I have planned.  By adding
an interface to create, manipulate, and destroy address spaces, it will
be possible for one thread to have a pool of address spaces available to it
which it can switch between as needed.  This will allow UML to have one
host thread per virtual processor (instead of one per UML thread, currently)
and one address space per UML thread, and switch the one host process from
address space to address space on each context switch.  This would solve
a bunch of UML problems in one shot.

Another thing I was trying to figure out how to do cleanly once this is 
working is putting the UML kernel in its own address space.  This would
give UML processes the full 3G address space they expect and make UML
completely invisible to them.  Of course, the problem is how do you switch
address spaces on every signal and system call.

Let's say there's a new system call, unprivilege(), and it optionally takes
an address space handle (which would be a file descriptor).  Then, any 
switch back to privileged mode would first switch back to that address space.
This seems clean to me.

One thing that's unclear to me is how you enter unprivileged mode in the
first place.  I guess you'd specify a procedure in the unprivilege() and
it would be called in unprivileged mode.

This looks like a very good idea to me and it seems like it would cleanly
solve a bunch of problems for UML.

				Jeff




