Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264679AbSL1XZc>; Sat, 28 Dec 2002 18:25:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264711AbSL1XZc>; Sat, 28 Dec 2002 18:25:32 -0500
Received: from mnh-1-07.mv.com ([207.22.10.39]:28933 "EHLO ccure.karaya.com")
	by vger.kernel.org with ESMTP id <S264679AbSL1XZb>;
	Sat, 28 Dec 2002 18:25:31 -0500
Message-Id: <200212282337.SAA04085@ccure.karaya.com>
X-Mailer: exmh version 2.0.2
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] Allow UML kernel to run in a separate host address space 
In-Reply-To: Your message of "Sat, 28 Dec 2002 12:50:53 PST."
             <Pine.LNX.4.44.0212281227510.25566-100000@home.transmeta.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 28 Dec 2002 18:37:46 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

torvalds@transmeta.com said:
> On Sat, 28 Dec 2002, Jeff Dike wrote:
> 
> > 3 - Ability to manipulate a child's address space (i.e. mmap, munmap,
> > mprotect on an address space which is not current->mm)
>
> Well, #3 falls under "ptrace()" as far as I'm concerned,

Not exactly.  UML needs to be able to fiddle an address space that has no
process in it (swapout, COWing, maybe a few other things).  

UML has two relevant processes, one which runs userspace, and one which runs 
the kernel and ptraces the userspace process.   The kernel process creates
an address space per UML process, and makes the userspace process switch
between them during a UML context switch.  So, when there's swapping going
on, pages need to be unmapped from UML processes, and thus from the 
corresponding host address spaces.

> Which really means that I _think_ the right approach would be to
> literally  have a "indirect-system-call-using-this-mm" system call,
> which does  something like
>
> 	asmlinkage sys_mm_indirect(int fd, struct syscall_descriptor_block
> *user_args)
> 	{
> 		struct mm_struct *old_mm;
> 		struct syscall_descriptor_block args;
>
> 		if (memcpy_from_user(&args, user_args, sizeof(args)))
> 			return -EFAULT;
>
> 		mm = get_fd_mm(fd);
> 		old_mm = current->mm;
> 		current->mm = mm;
> 		switch_mm(mm);
>
> 		arch_do_syscall(&args);
>
> 		current->mm = old_mm;
> 		switch_mm(old_mm);
> 		put_mm(mm);
> 	} 

Hmmm, I wasn't planning on going that far, but this certainly works for UML,
as long as there is also PTRACE_SWITCH_MM to make a child jump from one mm
to another.

The calls to switch_mm() are needed when the system call is going to modify
data within the address space, but not if it's going to change mappings,
correct?

If those will cause a noticable performance hit, would it be OK to special-case
syscalls which don't need it?

 		if(!dont_need_no_stinkin_switch_mm[args.syscall])
			switch_mm(mm);

 		arch_do_syscall(&args);

 		current->mm = old_mm;
 		if(!dont_need_no_stinkin_switch_mm[args.syscall])
 			switch_mm(old_mm);

Sorry about the double negative, but it seems easiest to sparsely populate
an array with system calls that really don't want the switch_mm().

				Jeff

