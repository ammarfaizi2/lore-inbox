Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288109AbSAUUVA>; Mon, 21 Jan 2002 15:21:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288121AbSAUUUn>; Mon, 21 Jan 2002 15:20:43 -0500
Received: from mnh-1-12.mv.com ([207.22.10.44]:263 "EHLO ccure.karaya.com")
	by vger.kernel.org with ESMTP id <S288109AbSAUUU1>;
	Mon, 21 Jan 2002 15:20:27 -0500
Message-Id: <200201212021.PAA03213@ccure.karaya.com>
X-Mailer: exmh version 2.0.2
To: ebiederm@xmission.com (Eric W. Biederman)
Cc: baccala@freesoft.org, linux-kernel@vger.kernel.org
Subject: Re: [uml-devel] new virtualization syscall to improve uml performance? 
In-Reply-To: Your message of "20 Jan 2002 23:00:53 MST."
             <m1hepggs4q.fsf@frodo.biederman.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 21 Jan 2002 15:21:57 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ebiederm@xmission.com said:
> For whatever state run_sandbox would need to return to the original
> address space it could simply stored on the kernel stack.  I really
> don't see why you would need to kernel contexts.

Yeah, it didn't occur to me until later that the run_sandbox state could
be stored without occupying a kernel stack.

Unless I'm missing something, the implementation of run_sandbox would be
that it stores the privileged context away somewhere, restores the 
unprivileged context (which would then have to be a full register set),
and returns to userspace.  So, the privileged context couldn't be on the
kernel stack.  It would have to be in (or hanging off) the task structure
or something.

> The tricky addition would be having multiple address spaces per
> process. 

It's not multiple address spaces per process so much as it is treating
addresses as objects completely separate from processes, and processes
can switch between them as they see fit.  So, by opening up some other
process's /proc/<pid>/mm and switching to it (assuming permissions were OK),
you could invade that address space.  You would immediately segfault or 
something because your registers would be all wrong, but the switch itself
would work fine.

> But I don't like the idea of an implied mprotect.  As currently there
> isn't any hardware to implement it and I don't see why anyone would
> make such hardware I think that part should stay as two calls.

Hardware isn't the issue.  Atomicity is.  I want the UML kernel to disappear
when it switches to userspace, just as the native kernel does.  In order to
do this, the unprivilege-ing and unmapping of the UML kernel have to happen
in the same system call.  Similarly, the remapping has to happen at the same
time as the return from unprivilege().  That's why I like the idea of having
(say) MAP_UNPRIV mappings be the only ones available in unprivileged mode.

> The only cost of an address space switch is the tlb flush and reload
> cost. (granted that is significant for short code stretches).  But
> more modern architectures are implementing address space numbers or
> their kin so they can keep multiple address spaces in the tlb at once.
>  With address space numbers an address space switch is practically
> free.

You may be right.  I'm not an expert on this.

I'd like to keep these two ideas separate since they seem separately useful,
but still have them interact where it makes sense (i.e. creating an unprivileged
context in a different address space).

> The only performance hit I see is with the copy_to_user,
> copy_from_user routines. 

Yeah, but that wouldn't be much of an issue for UML since, if necessary, it 
can do a virt_to_phys and grab data from physical memory, which will be in 
its address space.

> Except by totally emulating it, which is fairly invasive, but it is
> good for a real sandbox case where we want to make decisions. 

Yeah, it's perfect for UML.  The reason I'm interested in strace is that if
this can be demonstrated to cleanly replace pieces of ptrace, I think it
will have an automatic fan club.

I don't see why you can't allow an unprivileged context to just continue,
so the system call will proceed or the signal will be delivered, which would
be fine for strace (at least starting the process from scratch, not sure what
to do about attaching to a running process).

To me, this is suggesting an fcntl/ptrace-like interface for performing 
various operations on unprivileged contexts:

status = unprivilege(UNPRIV_CREATE, sp, proc, arg, context) - would create a 
	new unprivileged context running proc(arg) on the stack pointed to by 
	sp, very similar to clone.  context is a buffer large enough to hold 
	the userspace state of the context.  This will return immediately with
	the context filled in.

We have forward compatibility issues with the size of that context buffer
potentially needing to grow as registers are added, and old binaries overflowing
their static small buffers.  So, we have a call to ask how big the buffer
should be:

size = unprivilege(UNPRIV_BUFSIZE)

status = unprivilege(UNPRIV_RUN, context) - runs the unprivileged context 
	contained in the context buffer.  Returns some kind of status when
	the context makes a system call or receives a signal.  The context
	buffer also contains information about the event that prompted the
	return.  Maybe add some flags to indicate that we're only interested
	in some types of events.

status = unprivilege(UNPRIV_CANCEL, context) - cancels the pending event that 
	caused the return to privileged context.  The system call doesn't
	happen or the signal isn't delivered.  Returns as UNPRIV_RUN does.

UML do something like this:

size = unprivilege(UNPRIV_BUFSIZE);
context = kmalloc(size);
/* proc is a little stub that branches into userspace */
status = unprivilege(UNPRIV_CREATE, sp, proc, arg, context);

/* Start it going */
unprivilege(UNPRIV_RUN, context);
while(1){
	/* read the system call or signal out of context and either run the
	 * system call in UML or handle the signal
	 */

	/* cancel the syscall or signal */
	unprivilege(UNPRIV_CANCEL, context);
}

strace would do pretty much the same thing, except it would call UNPRIV_RUN
instead of UNPRIV_CANCEL in the loop.

What do you think about this?

				Jeff

