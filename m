Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289062AbSAUGE3>; Mon, 21 Jan 2002 01:04:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289069AbSAUGE1>; Mon, 21 Jan 2002 01:04:27 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:19789 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S289062AbSAUGDz>; Mon, 21 Jan 2002 01:03:55 -0500
To: Jeff Dike <jdike@karaya.com>
Cc: baccala@freesoft.org, linux-kernel@vger.kernel.org
Subject: Re: [uml-devel] new virtualization syscall to improve uml performance?
In-Reply-To: <200201210228.VAA04656@ccure.karaya.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 20 Jan 2002 23:00:53 -0700
In-Reply-To: <200201210228.VAA04656@ccure.karaya.com>
Message-ID: <m1hepggs4q.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Dike <jdike@karaya.com> writes:

> I wrote up my thoughts on secondary address spaces on the uml-devel list
> (http://www.geocrawler.com/lists/3/SourceForge/709/75/7527174/).  I'll try
> to be somewhat briefer here.

O.k. the summary pretty much matches what I was thinking.  If I get
deep into it I'll have to read that article.
 
> ebiederm@xmission.com said:
> > new_addr(); /* to get a secondary address space */ 
> 
> I asked Linus about this at the kernel summit last year, and he said he
> wanted a filesystem interface, not a set of new system calls.

I guess I can see that.

> So, my proposed interface (modulo the names, which I welcome improvements to):
> 
> Open of:
> /proc/mm - returns a file descriptor referring to a new, empty mm_struct
> /proc/self/mm - returns a file descriptor referring to current->mm
> /proc/<pid>/mm - returns a file descriptor referring to the mm of process <pid>
> 
> > int fmmap(int address_space, void *start, size_t length, int prot, 
> >          int flags, int fd, off_t offset); 
> > int fmunmap(int addresss_space, void *start, size_t length); 
> 
> My proposal for this is to extend mmap:
> 
> void *new_mmap(void *start, size_t length, int prot, int flags, 
>                int src_fd, off_t offset, int dest_fd);
> 
> The new thing is the addition of dest_fd, which refers to the object within
> which the new mapping is to be made.  dest_fd == -1 refers to the current
> address space.  I intend for dest_fd to be an address space descriptor, but
> it seems to make sense for it to be anything that supports mmap.

Currently that is only address spaces.
 
> munmap and mprotect would be similarly extended.

Right.
 
> > run_sandbox(int address_space, struct sandbox_params *params); /* to
> > start a sandbox */ 
> > And run_sandbox being the entry/exit point.
> 
> Are you saying that you'd call run_sandbox to switch address spaces and
> enter unprivileged mode, and when you re-enter privileged mode, the run_sandbox
> call returns in the original address space with a bunch of information in 
> params?

That is what I was thinking.
 
> If so, then
> 
> > The nice thing here is
> > that because they would share the same kernel stack/process most
> > registers can be left in registers.
> 
> is wrong.  You need to preserve two kernel contexts, so you need two kernel
> stacks.  

??? 
The run_sandbox idea is essentially what the current vm86 does except
a little more optimized...   I admit I left out a value for the
instruction pointer in the sandbox_params (which would necessarily be
address space dependent).

For whatever state run_sandbox would need to return to the original
address space it could simply stored on the kernel stack.  I really
don't see why you would need to kernel contexts.

> The run_sandbox context is obviously one.  The unprivileged code
> would also need to enter the kernel to fill in the sandbox params and force a 
> return from run_sandbox.  Also, depending on the arch, CPU traps run on the
> current kernel stack.

A trap or whatever is part of the return for the run_sandbox context.
The current vm86 system call already does something similar to this.
The 8 general purpose registers are saved and restored but the
floating point registers are passed through.  

The tricky addition would be having multiple address spaces per
process.

> Otherwise, I like this idea.

I still don't see why it takes two kernel stacks to pull this off.

> But, I don't like mixing the process privilege and address space ideas
> together like this.  UML, like i386, grabs the top of the address space
> for itself (it grabs 0xa0000000 - 0xc0000000), so user/kernel space transitions
> don't require an address space switch.  To require that a 
> privileged/unprivileged transition also switch address spaces will put a
> speed limit on UML system calls.

I will agree that it is sane for the run_sandbox command to work on
the current address space as well.  But I don't like the idea of an
implied mprotect.  As currently there isn't any hardware to implement
it and I don't see why anyone would make such hardware I think that
part should stay as two calls.

The only reason I can see for an implied mprotect is if executing the
mprotect keeps you from executing the run_sandbox command...

> That's why I like the idea of maps that are only available in privileged mode.
> Turning on some mappings seems a lot cheaper than a full address space switch.

Maybe I'm confused.  The only cost of an address space switch is the tlb flush
and reload cost. (granted that is significant for short code stretches).  But 
more modern architectures are implementing address space numbers or their
kin so they can keep multiple address spaces in the tlb at once.  With
address space numbers an address space switch is practically free.

The only performance hit I see is with the copy_to_user,
copy_from_user routines.

> Having said that, I like the address space switch to be available as an 
> option.  There are some UML applications (like honeypots) where having the
> UML kernel in a totally different address space would be very useful.
> 
> Somewhat unrelated, but another thing I've been thinking about is whether
> the process privilege idea could be used to implement strace.  One difficulty
> is that strace wants to record system calls, not nullify them as UML does.
> There doesn't seem to be any room for allowing the system call or signal
> handler to proceed in unprivileged mode.

Except by totally emulating it, which is fairly invasive, but it is
good for a real sandbox case where we want to make decisions.

I suspect there is some happy compromise case 

Eric

