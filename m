Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281809AbRKQT0a>; Sat, 17 Nov 2001 14:26:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281812AbRKQT0V>; Sat, 17 Nov 2001 14:26:21 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:7181 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S281809AbRKQT0C>; Sat, 17 Nov 2001 14:26:02 -0500
From: Linus Torvalds <torvalds@transmeta.com>
Date: Sat, 17 Nov 2001 11:20:45 -0800
Message-Id: <200111171920.fAHJKjJ01550@penguin.transmeta.com>
To: jh@suse.cz, linux-kernel@vger.kernel.org
Subject: Re: i386 flags register clober in inline assembly
Newsgroups: linux.dev.kernel
In-Reply-To: <20011117161436.B23331@atrey.karlin.mff.cuni.cz>
In-Reply-To: <87y9l58pb5.fsf@fadata.bg>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20011117161436.B23331@atrey.karlin.mff.cuni.cz> you write:
>
>They don't need to be. On i386, the flags are (partly for historical reasons) clobbered
>by default.

However, this is one area where I would just be tickled pink if gcc were
to allow asm's to return status in eflags, even if that means that we
need to fix all our existing asms.

We have some really _horrid_ code where we use operations that
intrinsically set the flag bits, and we actually want to use them.
Using things like cmpxchg, and atomic decrement-and-test-with-zero have
these horrid asm statements that have to move the eflags value (usually
just one bit) into a register, so that we can tell gcc where it is.

(Example code:

atomic_sub_and_test:
	__asm__ __volatile__(
		LOCK "subl %2,%0; sete %1"
		:"=m" (v->counter), "=qm" (c)
		:"ir" (i), "m" (v->counter) : "memory");

Where we first get the value we _really_ want in ZF in eflags, then we
use "sete" to move it to a register, and then gcc will end up generating
code to test that register by hand, so the end result is usually
something like:

#APP
        lock ; decl 20(%edi); sete %al
#NO_APP
        testb   %al, %al
        je      .L1570

even though what we'd _want_ is really

	lock ; decl 20(%edi)
	jne .L1570

which is not only smaller and faster, but is often _really_ faster
because at least some Intel CPU's will forward the flags values to the
branch prediction stuff, and going through a register dependency will
add non-forwarded state and thus extra cycles.

So I would personally _really_ really like for some way to expose the
internal gcc

	"(set (cc0) ..asm..)"

construct, together with some way of setting the cc_status.flags.

>From what I can tell, all the x86 machine description already uses "cc0"
together with the notion of comparing it to zero (either signed or
unsigned), so something like this _might_ just work

	unsigned long result;
	asm volatile(
		LOCK "decl %m"
		:"+m" (v->counter),
		 "=cc" (result)
		: :"memory");
	if (result > 0)		/* "jnb" */
		...

which would be wonderful, and would expand to

	(set (cc0) ..asm..)
	(set (pc)
		(if_then_else (gtu (cc0) (const_int 0))
			(label_ref (match_operand ..
			(pc))

Which _should_ just automatically give us

	lock ; decl ..
	ja ..

which is exactly what we want.

I know this used to be impossible in gcc, because the x86 didn't
actually track the flags values, and conditional jumps were really a
_combination_ of the conditional and the jump, and splitting it up so
that the conditional would be in an asm was thus not possible.

But I think gcc makes cc0 explicit on x86 these days, and that the above
kind of setup might be possible today, no?

		Linus
