Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289012AbSAUC2K>; Sun, 20 Jan 2002 21:28:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289007AbSAUC2A>; Sun, 20 Jan 2002 21:28:00 -0500
Received: from mnh-1-12.mv.com ([207.22.10.44]:21259 "EHLO ccure.karaya.com")
	by vger.kernel.org with ESMTP id <S289005AbSAUC15>;
	Sun, 20 Jan 2002 21:27:57 -0500
Message-Id: <200201210228.VAA04656@ccure.karaya.com>
X-Mailer: exmh version 2.0.2
To: ebiederm@xmission.com (Eric W. Biederman), baccala@freesoft.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: [uml-devel] new virtualization syscall to improve uml performance? 
In-Reply-To: Your message of "20 Jan 2002 17:28:15 MST."
             <m1lmesh7j4.fsf@frodo.biederman.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 20 Jan 2002 21:28:38 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I wrote up my thoughts on secondary address spaces on the uml-devel list
(http://www.geocrawler.com/lists/3/SourceForge/709/75/7527174/).  I'll try
to be somewhat briefer here.

ebiederm@xmission.com said:
> new_addr(); /* to get a secondary address space */ 

I asked Linus about this at the kernel summit last year, and he said he
wanted a filesystem interface, not a set of new system calls.

So, my proposed interface (modulo the names, which I welcome improvements to):

Open of:
/proc/mm - returns a file descriptor referring to a new, empty mm_struct
/proc/self/mm - returns a file descriptor referring to current->mm
/proc/<pid>/mm - returns a file descriptor referring to the mm of process <pid>

> int fmmap(int address_space, void *start, size_t length, int prot, 
>          int flags, int fd, off_t offset); 
> int fmunmap(int addresss_space, void *start, size_t length); 

My proposal for this is to extend mmap:

void *new_mmap(void *start, size_t length, int prot, int flags, 
               int src_fd, off_t offset, int dest_fd);

The new thing is the addition of dest_fd, which refers to the object within
which the new mapping is to be made.  dest_fd == -1 refers to the current
address space.  I intend for dest_fd to be an address space descriptor, but
it seems to make sense for it to be anything that supports mmap.

munmap and mprotect would be similarly extended.

> run_sandbox(int address_space, struct sandbox_params *params); /* to
> start a sandbox */ 
> And run_sandbox being the entry/exit point.

Are you saying that you'd call run_sandbox to switch address spaces and
enter unprivileged mode, and when you re-enter privileged mode, the run_sandbox
call returns in the original address space with a bunch of information in 
params?

If so, then

> The nice thing here is
> that because they would share the same kernel stack/process most
> registers can be left in registers.

is wrong.  You need to preserve two kernel contexts, so you need two kernel
stacks.  The run_sandbox context is obviously one.  The unprivileged code
would also need to enter the kernel to fill in the sandbox params and force a 
return from run_sandbox.  Also, depending on the arch, CPU traps run on the
current kernel stack.

Otherwise, I like this idea.

But, I don't like mixing the process privilege and address space ideas
together like this.  UML, like i386, grabs the top of the address space
for itself (it grabs 0xa0000000 - 0xc0000000), so user/kernel space transitions
don't require an address space switch.  To require that a 
privileged/unprivileged transition also switch address spaces will put a
speed limit on UML system calls.

That's why I like the idea of maps that are only available in privileged mode.
Turning on some mappings seems a lot cheaper than a full address space switch.

Having said that, I like the address space switch to be available as an 
option.  There are some UML applications (like honeypots) where having the
UML kernel in a totally different address space would be very useful.

Somewhat unrelated, but another thing I've been thinking about is whether
the process privilege idea could be used to implement strace.  One difficulty
is that strace wants to record system calls, not nullify them as UML does.
There doesn't seem to be any room for allowing the system call or signal
handler to proceed in unprivileged mode.

				Jeff

