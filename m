Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265895AbUA3ERS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jan 2004 23:17:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266470AbUA3ERS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jan 2004 23:17:18 -0500
Received: from mail.shareable.org ([81.29.64.88]:12672 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S265895AbUA3ERN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jan 2004 23:17:13 -0500
Date: Fri, 30 Jan 2004 04:17:08 +0000
From: Jamie Lokier <jamie@shareable.org>
To: Ulrich Drepper <drepper@redhat.com>
Cc: john stultz <johnstul@us.ibm.com>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH] linux-2.6.2-rc2_vsyscall-gtod_B1.patch
Message-ID: <20040130041708.GA2816@mail.shareable.org>
References: <1075344395.1592.87.camel@cog.beaverton.ibm.com> <401894DA.7000609@redhat.com> <20040129132623.GB13225@mail.shareable.org> <40194B6D.6060906@redhat.com> <20040129191500.GA1027@mail.shareable.org> <4019A5D2.7040307@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4019A5D2.7040307@redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ulrich Drepper wrote:
> > As this is x86, can't the syscall routines in Glibc call directly
> > without a PLT entry?
> 
> No, since this is just an ordinary jump through the PLT.  That the
> target DSO is synthesized is irrelevant.  It's ld.so which needs the PIC
> setup, not the called DSO.

I have not explained well.  Please read carefully, as I am certain no
indirect jumps on the userspace side are needed, including the one
currently in libc.

It is possible to compile, assemble and link a shared library with
-fno-PIC on x86, and this does work.  I just tested it to make sure.
Furthermore, the "prelink" program is effective on these libraries.

If you assemble calls into the kernel in Glibc with the instruction
"call __kernel_vsyscall", i.e. NOT "call __kernel_vsyscall@PLT", then
the address in the instruction is patched at run time to be a direct
(not indirect) jump to the kernel entry point.  The address is
retrieved from the kernel vDSO.

Generally you do not use the non-PIC form of "call" in a shared
library, because it causes the page containing the instruction to be
dirtied in each instance of the program.  If done for all "call"
instructions in a whole library this is wasteful in time and memory.

However, for the syscall stubs, if they are placed close together,
then they may fit in one or two pages, and that keeps the dirtying to
a minimum.  Even better is to place the stubs just after libc's PLT,
so the dirty pages are the same.

This converts the indirect jump in libc to the kernel entry point to a
direct jump.

> > With prelinking, because the vdso is always
> > located at the same address, there isn't even a dirty page overhead to
> > using non-PIC in this case.
> 
> But this isn't true.  The address can change.  There are already two
> flavors (normal and 4G/4G) and there will probably be more.  Ingo would
> have to comment on that.

I'm talking about the "prelink" program.  When you run "prelink" on a
libc.so which has direct jump instructions as described above, is
patches the libc.so file to contain the address of the kernel entry
point at the time "prelink" was run.

If this libc.so is loaded onto a kernel with the same address for
__kernel_vsyscall, then the run time linker does not need to alter the
address, and does not dirty the pages containing direct jumps to that
address.

If this libc.so is loaded onto a kernel with a different vsyscall
address, the run time linker patches the jumps as described above.  So
it always works, but loads faster on the kernel it is optimised for.

> > If you have to use a PLT entry it is.  If you can do it without a PLT,
> > direct jump to the optimised syscall address is fastest.
> 
> A direct jump is hardcoding the information which is exactly what should
> be avoided.

I think you misunderstood.  The direct jump is to an address resolved
at load time by the run time linker, or at preprocessing time by
"preload".  On x86 both of these work.

> > Being Glibc, you could always tweak ld.so to only look at the last one
> > if this were really a performance issue.  Btw, every syscall used by
> > the program requires at least one symbol lookup, usually over the
> > whole search path, anyway.
> 
> The symbol for the syscall stub in libc is looked up, yes, but nothing
> else.  I fail to see the relevence.  You cannot say that since a call
> already requires N ns it is OK for it to take 2*N ns.

If you run "preload" it takes 0 ns: these addresses are fixed into
ld.so and the symbols are not looked up at load time.

However if you don't care to depend on that, other optimisations to
ld.so are possible too.

> > I hear what you're saying.  These are the things which bother me:
> > 
> >    1. There are already three indirect jumps to make a syscall.
> >       (PLT to libc function, indirect jump to vsyscall entry, indirect
> >       jump inside kernel).  Another is not necessary (in fact two of
> >       those aren't necessary either), why add more?
> 
> Because they are all at different level and to abstract out different
> things.

The abstractions are good.  However indirect jumps are not required
for three out of four of those abstractions, because ld.so and prelink
can both resolve addresses in direct jumps; ld.so at load time, and
prelink at preprocessing time.  This is nothing fancy.

> >    2. Table makes the stub for all syscalls slower.
> 
> Not as much as any other acceptable solution.  The vdso code is compiled
> for a given address and therefore the memory loads can use absolute
> addresses.

> For x86 we have to handle in the same binary old kernels and kernels
> where the vDSO is at a different address than the stock kernel.  This
> means the computation of the address consists of several step.  Get the
> vDSO address (passed up in the auxiliary vector), adding the magic
> offset, and then jumping.

This is my thesis: system calls do not require _any_ indirect jumps in
libc or in the user space part of the kernel stub, with no dirty
pages, and the symbol table lookups can be eliminated.

Because I am sure you don't agree :) this is how to implement it:

  1. ld.so gets the vDSO address from the auxiliary vector, and then
     includes the vDSO in the list of symbol tables to search.  If
     there is no vDSO (due to running on an old kernel without one), then
     it is simply omitted.

  2. The vDSO offers __kernel_vsyscall, the general syscall entry point,
     and may offer any other __kernel_* symbols for optimised
     syscalls.  E.g. __kernel_gettimeofday is defined.

  3. After the vDSO in the search list are weak aliases from
     __kernel_* to __kernel_vsyscall (for each syscall mentioned in libc).

  4. After the vDSO is a definition of __kernel_vsyscall, which
     does int80.  It's exactly the same as the kernel's int80 stub.
     This is the code which will be run if we're running on an old kernel
     without a vDSO.

One way to place the symbols from 3. and 4. after the vDSO in the
search list is to arrange that ld.so places the vDSO before libc.so.
There are a few other ways to do it.

  5. Glib's syscall stubs should look a lot like this example:

         movl 0x10(%esp),%edx
         movl 0x0c(%esp),%ecx
         movl 0x08(%esp),%ebx
         movl $3,%eax
         call __kernel_read

1-5 together implement system calls using direct call instructions (a
minor run time improvement over current Glibc, at the cost of some
load time overhead) and also supports optimised system calls in a
future compatible way.  Add to this:

  6. Group all small routines in libc.so which call __kernel_*
     together, and locate them as close as possible to the PLT section.

That minimises the run time footprint.

  7. Make "prelink" aware of the vDSO dependency.

  8. Add the prelink signature to the kernel's vDSO object.

  9. Run "prelink", even if only on libc.so or on a sub-library which
     contains the system call stubs.

That totally eliminates the load time symbol lookups for these kernel
functions.

Once these changes are made to Glibc, it will automatically take
advantage of any future vsyscall optimisations in the kernel _and_
system calls will be a little bit faster than they are now.

-- Jamie
