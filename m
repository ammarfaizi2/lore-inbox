Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751155AbVLCExu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751155AbVLCExu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Dec 2005 23:53:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751183AbVLCExt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Dec 2005 23:53:49 -0500
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:22415 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751155AbVLCExt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Dec 2005 23:53:49 -0500
Subject: Re: copy_from_user/copy_to_user question
From: Steven Rostedt <rostedt@goodmis.org>
To: Robert Hancock <hancockr@shaw.ca>
Cc: Vinay Venkataraghavan <raghavanvinay@yahoo.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <4391121D.9080305@shaw.ca>
References: <5fv0G-3kS-11@gated-at.bofh.it> <5fvam-3vP-9@gated-at.bofh.it>
	 <43910731.4090404@shaw.ca> <1133580225.4894.29.camel@localhost.localdomain>
	 <4391121D.9080305@shaw.ca>
Content-Type: text/plain
Date: Fri, 02 Dec 2005 23:53:45 -0500
Message-Id: <1133585625.4894.70.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-12-02 at 21:33 -0600, Robert Hancock wrote:
> Steven Rostedt wrote:
> > Nope, the kernel is always locked into memory.  If you take a page fault
> > from the kernel world, you will crash and burn. The kernel is never
> > "swapped out".  So if you are in kernel mode, going into do_page_fault
> > in arch/i386/mm/fault.c there is no path to swap a page in.  Even the
> > vmalloc_fault only handles a page not in the page global descriptor of
> > the current task.  But if this page is not mapped somewhere in memory
> > (not swapped out), you will get a kernel oops.
> > 
> > Kernel memory may never be swapped out. What happens if an interrupt
> > tries to use such memory. How does it handle sleeping?
> > 
> > Just change copy_to_user into memcopy, and see how long your system
> > stays up and running.  Do it on a machine that you don't need to worry
> > about rogue applications.  It won't last very long.
> 
> Yes, kernel memory is never swapped out. But my point is merely that as 
> far as I know there is no special handling in the copy_to/from_user 
> functions to handle the case where the userspace memory is swapped out, 
> and therefore this would not be an issue for accessing the memory 
> directly. Obviously this is not something that one should actually do, 
> since access faults are not trapped and on some architectures or 
> configurations it won't work at all.

Quite the contrary, it does handle the case for swapped out memory.

Lets take a look at it, shall we?

copy_to/from_user boils down to __copy_user in arch/i386/lib/usercopy.c:

#define __copy_user(to,from,size)					\
do {									\
	int __d0, __d1, __d2;						\
	__asm__ __volatile__(						\
		"	cmp  $7,%0\n"					\
		"	jbe  1f\n"					\
		"	movl %1,%0\n"					\
		"	negl %0\n"					\
		"	andl $7,%0\n"					\
		"	subl %0,%3\n"					\
		"4:	rep; movsb\n"					\
		"	movl %3,%0\n"					\
		"	shrl $2,%0\n"					\
		"	andl $3,%3\n"					\
		"	.align 2,0x90\n"				\
		"0:	rep; movsl\n"					\
		"	movl %3,%0\n"					\
		"1:	rep; movsb\n"					\
		"2:\n"							\
		".section .fixup,\"ax\"\n"				\
		"5:	addl %3,%0\n"					\
		"	jmp 2b\n"					\
		"3:	lea 0(%3,%0,4),%0\n"				\
		"	jmp 2b\n"					\
		".previous\n"						\
		".section __ex_table,\"a\"\n"				\
		"	.align 4\n"					\
		"	.long 4b,5b\n"					\
		"	.long 0b,3b\n"					\
		"	.long 1b,2b\n"					\
		".previous"						\
		: "=&c"(size), "=&D" (__d0), "=&S" (__d1), "=r"(__d2)	\
		: "3"(size), "0"(size), "1"(to), "2"(from)		\
		: "memory");						\
} while (0)


Take a look at the __ex_table. It adds the following addresses:

label 4, label 5, 
label 0, label 3, 
label 1, label 2.

Now lets see if we take a page fault at any of the labels 4, 0, or 1.
(where the copies actually are).

In do_page_fault in arch/i386/mm/fault.c

	if (!down_read_trylock(&mm->mmap_sem)) {
		if ((error_code & 4) == 0 &&
		    !search_exception_tables(regs->eip))
			goto bad_area_nosemaphore;
		down_read(&mm->mmap_sem);
	}

The error_code & 4 == 0 is true when we are in the kernel (which we
are).  And here's the difference between memcpy and copy_user.  The
search_exception_tables!  If this were to fail (as it would in memcpy)
we would just die here (jumping to bad_area_nosemaphore).  But lets now
look at search_exception_tables.

search_exception_tables is defined in kernel/extable.c, and the entries
to the table are in include/asm-i386/uaccess.h:

struct exception_table_entry
{
	unsigned long insn, fixup;
};

Remember those labels? Well the linker puts them into this table sorted,
by insn, so here we now have:

insn = label 4, fixup = label 5,
insn = label 0, fixup = label 3,
insn = label 1, fixup = label 2.
  (but sorted with all other exceptions)

The search_exception_tables does a binary search of all these sorted
exceptions, looking for the address where the exception took place.
Which would be at either label 4, 0 or 1, any of which would be found in
this table.

Then this would continue happily along and swap back in the pages (just
as if it was in user land) and return to the point it left off and
continue.

What's the fixup for in that table??  Well lets look at do_page_fault in
the case that this actually fails and goes to bad_area.  We don't want
to oops the kernel for some misbehavior of an application.

In usermode we would just SIGSEGV, but we are in kernel mode. So we
would drop down to fix_exception called by do_page_fault.

fix_exception in arch/i386/mm/extable.c has the following code.

	fixup = search_exception_tables(regs->eip);
	if (fixup) {
		regs->eip = fixup->fixup;
		return 1;
	}

So it once again searches the exception table for the bad address, which
we find. And say this happened at label 4, we set our new eip to 
label 5, so when we return from this exception, we jump to label 5 which
is really in the .fixup section (not actually after the code of label 4)

So lets take a look at this code again:

		"	cmp  $7,%0\n"					\
		"	jbe  1f\n"					\
		"	movl %1,%0\n"					\
		"	negl %0\n"					\
		"	andl $7,%0\n"					\
		"	subl %0,%3\n"					\
		"4:	rep; movsb\n"					\

We take an exception here (no page) and in fact, it is a bad
memory location!  So we go to do_page_fault, that eventually calls 
fixup_exception which puts the eip to label 5 (so we now jump there)


		"	movl %3,%0\n"					\
		"	shrl $2,%0\n"					\
		"	andl $3,%3\n"					\
		"	.align 2,0x90\n"				\
		"0:	rep; movsl\n"					\
		"	movl %3,%0\n"					\
		"1:	rep; movsb\n"					\
		"2:\n"							\
		".section .fixup,\"ax\"\n"				\

We jump to label 5 and add what we didn't write and then jump to
label 2 above.  This is really in the fixup section, so these 
jumps are really jumping around in the code and they are not
as close as this looks.

label 2 above just exits, so the copy_user here now returns the
number of bytes that were not copied!

		"5:	addl %3,%0\n"					\
		"	jmp 2b\n"					\
		"3:	lea 0(%3,%0,4),%0\n"				\
		"	jmp 2b\n"					\
		".previous\n"						\
		".section __ex_table,\"a\"\n"				\
		"	.align 4\n"					\
		"	.long 4b,5b\n"					\
		"	.long 0b,3b\n"					\
		"	.long 1b,2b\n"					\

Pretty neat eh?

-- Steve


