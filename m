Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261448AbSLUABY>; Fri, 20 Dec 2002 19:01:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261495AbSLUABX>; Fri, 20 Dec 2002 19:01:23 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:23826 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S261448AbSLUABW>; Fri, 20 Dec 2002 19:01:22 -0500
Date: Fri, 20 Dec 2002 16:09:50 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Jamie Lokier <lk@tantalophile.demon.co.uk>
cc: Ulrich Drepper <drepper@redhat.com>, <bart@etpmod.phys.tue.nl>,
       <davej@codemonkey.org.uk>, <hpa@transmeta.com>,
       <terje.eggestad@scali.com>, <matti.aarnio@zmailer.org>,
       <hugh@veritas.com>, <mingo@elte.hu>, <linux-kernel@vger.kernel.org>
Subject: Re: Intel P6 vs P7 system call performance
In-Reply-To: <20021220233825.GA22232@bjl1.asuk.net>
Message-ID: <Pine.LNX.4.44.0212201557230.2812-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 20 Dec 2002, Jamie Lokier wrote:
>
> %ebx/%edi/%esi are preserved across sysenter/sysexit, whereas
> %ecx/%edx are call-clobbered registers in the i386 function call ABI.
>
> This is not a coincidence.

Yes, you can make the "clobbers %eax/%edx/%ecx" argument, but the fact is,
we quite fundamentally need to save %edx/%ecx _anyway_.

The reason is system call restarting and signal handling. You don't see it
right now, because the system call restart mechanism doesn't actually use
"sysexit" at all, but that's because the current implementation is only
the minimal possible implementation.

The way we do signal handling right now, we always punt to the "old" code,
ie the return path that will eventually return with an "iret".

And that old code will restore _all_ registers, including %ecx and %edx.
So when we return after a restart to the restart handler, %ecx and %edx
will have their original values, which is why restarting works right now.

The "iret" will trash "%ebp", simply because we fake out the whole %ebp
saving to get the six-argument case right. That's why we have to have that
extra complicated restart sequence:

	0:
		movl %esp,%ebp
		syscall
	restart:
		jmp 0b

but once we start using sysexit for the signal handler return path too, we
will need to restore %edx and %ecx too, otherwise our restarted system
call will have crap in the registers. I already wrote the code, but
decided that as long as we don't do that kind of restarting, we shouldn't
have the overhead in the trampoline. But basically the trampoline then
will become

	system_call_trampoline:
		pushfl
		pushl %ecx
		pushl %edx
		pushl %ebp
		movl %esp,%ebp
		syscall
	0:
		movl %esp,%ebp
		movl 4(%ebp),%edx
		movl 8(%ebp),%ecx
		syscall

	restart:
		jmp 0b
	sysenter_return_point:
		popl %ebp
		popl %edx
		popl %ecx
		popfl
		ret

see? So you _have_ to really save the arguments anyway, because you cannot
do a sysexit-based system call restart otherwise. And once you save them,
you might as well restore them too.

And since you have to restore them for system call restart anyway, you
might as well just make it part of the calling convention.

Yes, I'm thinking ahead. Sue me.

			Linus

