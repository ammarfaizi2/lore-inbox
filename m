Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264878AbSLQQ5G>; Tue, 17 Dec 2002 11:57:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264944AbSLQQ5G>; Tue, 17 Dec 2002 11:57:06 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:2571 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S264878AbSLQQ5F>; Tue, 17 Dec 2002 11:57:05 -0500
Date: Tue, 17 Dec 2002 09:06:06 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Ulrich Drepper <drepper@redhat.com>
cc: Dave Jones <davej@codemonkey.org.uk>, Ingo Molnar <mingo@elte.hu>,
       <linux-kernel@vger.kernel.org>, <hpa@transmeta.com>
Subject: Re: Intel P6 vs P7 system call performance
In-Reply-To: <3DFF023E.6030401@redhat.com>
Message-ID: <Pine.LNX.4.44.0212170858510.2702-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 17 Dec 2002, Ulrich Drepper wrote:
>
> The problem with the current solution is the instruction set of the x86.
>  In your test code you simply use call 0xfffff000 and it magically work.
>  But this is only the case because your program is linked statically.

Yeah, it's not very convenient. I didn't find any real alternatives,
though, and you can always just put 0xfffff000 in memory or registers and
jump to that. In fact, I suspect that if you actually want to use it in
glibc, then at least in the short term that's what you need to do anyway,
sinc eyou probably don't want to have a glibc that only works with very
recent kernels.

So I was actually assuming that the glibc code would look more like
something like this:

	old_fashioned:
		int $0x80
		ret

	unsigned long system_call_ptr = old_fashioned;

	/* .. startup .. */
	if (kernel_version > xxx)
		system_call_ptr = 0xfffff000;


	/* ... usage ... */
		call *system_call_ptr;

since you cannot depend on the 0xfffff000 on older kernels anyway..

> Instead I've changed the syscall handling to effectve do
>
>    pushl %ebp
>    movl $0xfffff000, %ebp
>    call *%ebp
>    popl %ebp

The above will work, but then you'd have limited yourself to a binary that
_only_ works on new kernels. So I'd suggest the memory indirection
instead.

		Linus

