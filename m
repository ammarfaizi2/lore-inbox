Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751005AbVHKObL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751005AbVHKObL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 10:31:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751019AbVHKObL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 10:31:11 -0400
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:995 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1750995AbVHKObL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 10:31:11 -0400
Subject: Re: Need help in understanding  x86  syscall
From: Steven Rostedt <rostedt@goodmis.org>
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
Cc: linux-kernel@vger.kernel.org, Ukil a <ukil_a@yahoo.com>, 7eggert@gmx.de
In-Reply-To: <Pine.LNX.4.61.0508110954360.14541@chaos.analogic.com>
References: <4Ae73-6Mm-5@gated-at.bofh.it> <E1E3DJm-0000jy-0B@be1.lrz>
	 <Pine.LNX.4.61.0508110954360.14541@chaos.analogic.com>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Thu, 11 Aug 2005 10:31:01 -0400
Message-Id: <1123770661.17269.59.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-08-11 at 10:04 -0400, linux-os (Dick Johnson) wrote:
> Every interrupt software, or hardware, results in the branched
> procedure being executed with the interrupts OFF. That's why
> one of the first instructions in the kernel entry for a syscall
> is 'sti' to turn them back on. Look at entry.S, line 182. This
> occurs any time a trap occurs as well (Page 26-168, i486
> Programmer's reference manual). FYI, this is helpful when
> designing/debugging complex interrupt-service routines since
> you can execute the interrupt with a software 'INT' instruction
> (with the correct offset from the IRQ you are using). The software
> doesn't 'know' where the interrupt came from, HW or SW.

I'm looking at 2.6.13-rc6-git1 line 182 of entry.S and I don't see it.
Must be a different kernel.

According to the documentation that I was looking at, a trap in x86 does
_not_ turn off interrupts.

In arch/i386/kernel/traps.c: trap_init

  set_system_gate(SYSCALL_VECTOR,&system_call);

(where SYSCALL_VECTOR is of course 0x80).

This sets up a trap:

static void __init set_system_gate(unsigned int n, void *addr)
{
	_set_gate(idt_table+n,15,3,addr,__KERNEL_CS);
}


since type 15 makes this a trap (3 gives it user access).  Also looking
at the code that it will call:

ENTRY(system_call)
        pushl %eax                      # save orig_eax
        SAVE_ALL
        GET_THREAD_INFO(%ebp)
                                        # system call tracing in operation
        /* Note, _TIF_SECCOMP is bit number 8, and so it needs testw and not testb */
        testw $(_TIF_SYSCALL_TRACE|_TIF_SYSCALL_AUDIT|_TIF_SECCOMP),TI_flags(%ebp)
        jnz syscall_trace_entry
        cmpl $(nr_syscalls), %eax
        jae syscall_badsys
syscall_call:
        call *sys_call_table(,%eax,4)
        movl %eax,EAX(%esp)             # store the return value
syscall_exit:
        cli                             # make sure we don't miss an interrupt
                                        # setting need_resched or sigpending
                                        # between sampling and the iret



I don't see a sti here.

-- Steve


