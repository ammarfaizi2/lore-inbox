Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262023AbSLURKV>; Sat, 21 Dec 2002 12:10:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262067AbSLURKV>; Sat, 21 Dec 2002 12:10:21 -0500
Received: from bjl1.asuk.net.64.29.81.in-addr.arpa ([81.29.64.88]:8430 "EHLO
	bjl1.asuk.net") by vger.kernel.org with ESMTP id <S262023AbSLURKT>;
	Sat, 21 Dec 2002 12:10:19 -0500
Date: Sat, 21 Dec 2002 17:18:08 +0000
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Ulrich Drepper <drepper@redhat.com>, bart@etpmod.phys.tue.nl,
       davej@codemonkey.org.uk, hpa@transmeta.com, terje.eggestad@scali.com,
       matti.aarnio@zmailer.org, hugh@veritas.com, mingo@elte.hu,
       linux-kernel@vger.kernel.org
Subject: Re: Intel P6 vs P7 system call performance
Message-ID: <20021221171808.GA23577@bjl1.asuk.net>
References: <20021220233825.GA22232@bjl1.asuk.net> <Pine.LNX.4.44.0212201557230.2812-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0212201557230.2812-100000@home.transmeta.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> Yes, you can make the "clobbers %eax/%edx/%ecx" argument, but the fact is,
> we quite fundamentally need to save %edx/%ecx _anyway_.

On the kernel side, yes.  In the userspace trampoline, it's not required.

> but once we start using sysexit for the signal handler return path too, we
> will need to restore %edx and %ecx too, otherwise our restarted system
> call will have crap in the registers. I already wrote the code, but
> decided that as long as we don't do that kind of restarting, we shouldn't
> have the overhead in the trampoline. But basically the trampoline then
> will become
> 
> 	system_call_trampoline:
> 		pushfl
> 		pushl %ecx
> 		pushl %edx
> 		pushl %ebp
> 		movl %esp,%ebp
> 		syscall
> 	0:
> 		movl %esp,%ebp
> 		movl 4(%ebp),%edx
> 		movl 8(%ebp),%ecx
> 		syscall
> 
> 	restart:
> 		jmp 0b
> 	sysenter_return_point:
> 		popl %ebp
> 		popl %edx
> 		popl %ecx
> 		popfl
> 		ret

> see? So you _have_ to really save the arguments anyway, because you cannot
> do a sysexit-based system call restart otherwise. And once you save them,
> you might as well restore them too.
> 
> And since you have to restore them for system call restart anyway, you
> might as well just make it part of the calling convention.
>
> Yes, I'm thinking ahead. Sue me.

You're optimising the _rare_ case.

The correct [;)] trampoline looks like this:

 	system_call_trampoline:
 		pushl %ebp
		movl %esp,%ebp
 		sysenter
 	sysenter_return_point:
		popl %ebp
 		ret
 	sysenter_restart:
		popl %edx
		popl %ecx
		movl %esp,%ebp
 		sysenter

This is accompanied by changing this line in arch/i386/kernel/signal.c:

	regs->eip -= 2;

To this (best moved to an inline function):

	if (likely (regs->eip == sysenter_return_point)) {
		unsigned long * esp = (unsigned long *) regs->esp - 8;
		if (!access_ok(VERIFY_WRITE, esp, 8)
		    || __put_user(regs->edx, esp)
		    || __put_user(regs->ecx, esp+4)) {
			if (sig == SIGSEGV)
				ka->sa.sa_handler = SIG_DFL;
			force_sig(SIGSEGV, current);
		}
		regs->esp = (long) esp;
		regs->eip = sysenter_restart;
	} else {
		regs->eip -= 2;
	}

Thus the common case, system calls, are optimised.  The uncommon case,
signal interrupts system call, is penalised, though it's not a large
penalty.  (Much less than the gain from using sysexit!)  Which is more
common?

By the way, this works with the AMD syscall instruction too.
Then the trampoline is:

	system_call_trampoline:
		pushl %ebp
		movl %ecx,%ebp
		syscall
	syscall_return_point:
		popl %ebp
		ret
	syscall_restart:
		popl %edx
		popl %ebp
		syscall

Finally, there is no need to restore %ebp in the kernel sysexit/sysret
paths, because it will always be restored in the trampoline.  So you
save 1 memory access there too.

(ps. I have a question: why does your trampoline save & restore
the flags?)

-- Jamie
