Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265711AbSL1Usd>; Sat, 28 Dec 2002 15:48:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265754AbSL1Usc>; Sat, 28 Dec 2002 15:48:32 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:24334 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S265711AbSL1Us3>; Sat, 28 Dec 2002 15:48:29 -0500
Date: Sat, 28 Dec 2002 12:50:53 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Jeff Dike <jdike@karaya.com>
cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] Allow UML kernel to run in a separate host address space
In-Reply-To: <200212282024.PAA03372@ccure.karaya.com>
Message-ID: <Pine.LNX.4.44.0212281227510.25566-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 28 Dec 2002, Jeff Dike wrote:
> 
> > What are the semantics the host code wants/needs, 
> 
> 1 - Multiple address spaces per process
> 2 - Ability to make a child switch between address spaces
> 3 - Ability to manipulate a child's address space (i.e. mmap, munmap, mprotect
>     on an address space which is not current->mm)

Well, #3 falls under "ptrace()" as far as I'm concerned, I don't really 
want to expose things through /proc (or /dev, which is even _worse_).

We used to have things that could be done with /proc/<pid>/mem, and it was 
a total security disaster. It was removed in the 2.3.x series because of 
that.

As to #1, that certainly shouldn't be a problem at all. We already do it
temporarily internally inside the kernel for execve() setup and for things
liek lazy TLB switching for kernel threads, and there's nothing keeping us
from having multiple "struct mm_struct" per process. The only issue is 
what the interfaces should be to create one (/dev/mm is right _out_), and 
how to switch them around sanely.

Having a 

	int fd = create_mm();

system call is certainly not wrong per se (but thinking that it should be
done using a special file is wrong - we don't have /dev/pipe either). And 
creating that system call is trivial - but only worth it if there are good 
sane interfaces to switch mm's around and do interesting things with them.

Done right, it should be possible to have "posix_spawn()" etc done using 
something like that, ie

	/* Create new VM */
	int fd = create_mm();

	/* populate the dang thing.. */
	mmap_mm(fd, .. );

	/* start it up */
	clone_with_mm(fd, ...);

and the internal implementation should be perfectly trivial, since the 
kernel already largely works this way internally anyway (yeah, it is 
likely to need some re-organization of clone() to handle pre-created VM's 
etc, but that's nothing really fundamental).

> Beats me.  My first suggestion was to add another file descriptor argument
> to mmap et al which would represent the address space to be modified.  Alan
> didn't like that idea too much.

I do believe that fd's are a natural way to handle it, since it needs 
_some_ kind of handle, and the only generic handles the kernel has is a 
file descriptor. We could create a new kind of handle, but it would be 
likely to be just more complexity.

HOWEVER, the part I worry about is creating tons of new system calls that 
just duplicate existing ones by adding a "fd" argument. That part I really 
don't much like. Because if this were to really be a generic feature, it 
really wants pretty much _all_ system calls supported, ie things like

	fd = open(<mm,ptr>, flags, ...);

	retval = read(<mm,ptr>..

to allow the user to not just mmap but generally "take the guise of" any 
other mm for the duration of the system call.

Which really means that I _think_ the right approach would be to literally 
have a "indirect-system-call-using-this-mm" system call, which does 
something like

	asmlinkage sys_mm_indirect(int fd, struct syscall_descriptor_block *user_args)
	{
		struct mm_struct *old_mm;
		struct syscall_descriptor_block args;

		if (memcpy_from_user(&args, user_args, sizeof(args)))
			return -EFAULT;

		mm = get_fd_mm(fd);
		old_mm = current->mm;
		current->mm = mm;
		switch_mm(mm);

		arch_do_syscall(&args);

		current->mm = old_mm;
		switch_mm(old_mm);
		put_mm(mm);
	}

which allows _any_ system call to be made for that mm.

		Linus

