Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267536AbRGSLXX>; Thu, 19 Jul 2001 07:23:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267537AbRGSLXO>; Thu, 19 Jul 2001 07:23:14 -0400
Received: from [202.54.26.202] ([202.54.26.202]:48344 "EHLO hindon.hss.co.in")
	by vger.kernel.org with ESMTP id <S267536AbRGSLXA>;
	Thu, 19 Jul 2001 07:23:00 -0400
X-Lotus-FromDomain: HSS
From: alad@hss.hns.com
To: Brent Baccala <baccala@freesoft.org>
cc: linux-kernel@vger.kernel.org
Message-ID: <65256A8E.003EADF6.00@sandesh.hss.hns.com>
Date: Thu, 19 Jul 2001 16:27:38 +0530
Subject: Re: Do kernel threads need their own stack?
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing



If you are talking about kernel stack for the child... alloc_task_struct() does
that in do_fork()

--
Amol





Brent Baccala <baccala@freesoft.org> on 07/18/2001 01:46:27 PM

To:   linux-kernel@vger.kernel.org
cc:    (bcc: Amol Lad/HSS)

Subject:  Do kernel threads need their own stack?




Hi -

I'm experimenting with some code to track down stack overruns in the
kernel, and I've stumbled across some stuff in the i386 kernel_thread
code that strikes me as very suspicious.  This is 2.4.6.

First off, here's kernel_thread from arch/i386/kernel/process.c:


int kernel_thread(int (*fn)(void *), void * arg, unsigned long flags)
{
        long retval, d0;

        __asm__ __volatile__(
                "movl %%esp,%%esi\n\t"
                "int $0x80\n\t"         /* Linux/i386 system call */
                "cmpl %%esp,%%esi\n\t"  /* child or parent? */
                "je 1f\n\t"             /* parent - jump */

 ... stuff omitted ...

                "1:\t"
                :"=&a" (retval), "=&S" (d0)
                :"0" (__NR_clone), "i" (__NR_exit),
                 "r" (arg), "r" (fn),
                 "b" (flags | CLONE_VM)
                : "memory");
        return retval;
}

The register constraints make sure that the "a" register (eax) is
operand 0 and contains __NR_clone to start with.  The "b" register (ebx)
contains (flags | CLONE_VM).  We save the stack pointer to ESI and INT
80, which (combined with the __NR_clone in eax) lands us in sys_clone
(same file):

asmlinkage int sys_clone(struct pt_regs regs)
{
        unsigned long clone_flags;
        unsigned long newsp;

        clone_flags = regs.ebx;
        newsp = regs.ecx;
        if (!newsp)
                newsp = regs.esp;
        return do_fork(clone_flags, newsp, &regs, 0);
}

The first thing I notice is that this function refers not only to the
clone flags in ebx, but also to a "newsp" in ecx - and ecx went
completely unmentioned in kernel_thread()!  A disassembly of
kernel_thread shows that "arg" winds up in ecx before the system call,
so I guess this is what gets passed to do_fork(), where (I think) it
ultimately ends up being the child's stack pointer.

In the case of bdflush_init() (end of fs/buffer.c), what gets passed in
as "arg" is the address of a semaphore on the stack - the only variable
allocated by the function.  That means that the child's stack pointer
starts at the bottom of the parent's stack in bdflush_init() and grows
down from there.  And if the parent never goes deeper into its stack
than bdflush_init(), I guess it works - sort of.

Anyway, I'm confused.  My analysis might be wrong, since I don't spend
that much time in the Linux kernel, but bottom line - doesn't
kernel_thread() need to allocate stack space for the child?  I mean,
even if everything else is shared, doesn't the child at least need it's
own stack?

I need to stare at this more, but maybe somebody else can explain what's
going on here.  At the very least, I think kernel_thread() needs to
explicitly specify what goes into the ECX register, because it looks to
me like it's just the luck of the compiler's draw...

--
                                        -bwb

                                        Brent Baccala
                                        baccala@freesoft.org

==============================================================================
       For news from freesoft.org, subscribe to announce@freesoft.org:

mailto:announce-request@freesoft.org?subject=subscribe&body=subscribe
==============================================================================
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/




