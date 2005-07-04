Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261425AbVGDHg3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261425AbVGDHg3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Jul 2005 03:36:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261412AbVGDHg3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Jul 2005 03:36:29 -0400
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:14543 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S261599AbVGDHYr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Jul 2005 03:24:47 -0400
Date: Mon, 4 Jul 2005 03:24:39 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@localhost.localdomain
Reply-To: rostedt@goodmis.org
To: "liyu@WAN" <liyu@ccoss.com.cn>
cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: the magic in do_page_fault() ???
In-Reply-To: <42C8C7EE.8040906@ccoss.com.cn>
Message-ID: <Pine.LNX.4.58.0507040308470.10498@localhost.localdomain>
References: <42C8C7EE.8040906@ccoss.com.cn>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 4 Jul 2005, liyu@WAN wrote:

>     in do_page_fault() (kernel 2.6.11.11) include one piece of code as
> follow:
>
>
>         if (!down_read_trylock(&mm->mmap_sem)) {
>         if ((error_code & 4) == 0 &&
>             !search_exception_tables(regs->eip))
>             goto bad_area_nosemaphore;
>         down_read(&mm->mmap_sem);
>     }
>
>
>     I think I can understand these operations on mm->mmap_sem and
> "error_code&4".
> but how "search_exception_tables(regs->eip)" work here?

This is pretty much linker magic :-)

Look at the code in copy_from_user and friends. It also gets quite
confusing on intel.  Down in the bowels you might get to a function/macro
like __copy_user.  This function is used to copy to and from a user space
program address that we can't trust.

Here you see three different linker sections:

We start in the normal .text section

		"	cmp  $7,%0\n"					\
		"	jbe  1f\n"					\
		"	movl %1,%0\n"					\
		"	negl %0\n"					\
		"	andl $7,%0\n"					\
		"	subl %0,%3\n"					\
labels 4 and 0 store the address of a bad read (we are reading from a user
address that might not be in memory either because it is swapped out, or
is just a bad memory location.  Can't trust those users ;-)

		"4:	rep; movsb\n"					\
		"	movl %3,%0\n"					\
		"	shrl $2,%0\n"					\
		"	andl $3,%3\n"					\
		"	.align 2,0x90\n"				\
		"0:	rep; movsl\n"					\
		"	movl %3,%0\n"					\
		"1:	rep; movsb\n"					\
		"2:\n"							\

The fixup section is what to do if it was a bad read, that is, it's not
swapped out, but the user sent us a bad address.

		".section .fixup,\"ax\"\n"				\
		"5:	addl %3,%0\n"					\
		"	jmp 2b\n"					\
		"3:	lea 0(%3,%0,4),%0\n"				\
		"	jmp 2b\n"					\
		".previous\n"						\

This adds to the exception table. On error at address of label 4 we jump
to label 5, on error at label 0 we jump to label 3 and so on.

		".section __ex_table,\"a\"\n"				\
		"	.align 4\n"					\
		"	.long 4b,5b\n"					\
		"	.long 0b,3b\n"					\
		"	.long 1b,2b\n"					\


The linker will put all sections of __ex_table together.  The function you
are wondering about "search_exception_tables" calls search_extable passing
in the address of the start of the __ex_table section and the end of that
section.  Then, if it finds an address in the section, it then returns
that entry of the table (the address,fixup pair).

Later down in do_page_fault, fixup_exception is called, and this will
again search the execption tables (this might be optimized better to do
the search once!), and if it finds the entry, it will then jump to the
fixup part of the code, and that will do what is expected if the user
passed in a bad address.


Hope this helps,


-- Steve

