Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281818AbRKQU1s>; Sat, 17 Nov 2001 15:27:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281820AbRKQU1j>; Sat, 17 Nov 2001 15:27:39 -0500
Received: from [217.9.226.246] ([217.9.226.246]:39810 "HELO
	merlin.xternal.fadata.bg") by vger.kernel.org with SMTP
	id <S281818AbRKQU11>; Sat, 17 Nov 2001 15:27:27 -0500
To: Linus Torvalds <torvalds@transmeta.com>
Cc: jh@suse.cz, linux-kernel@vger.kernel.org
Subject: Re: i386 flags register clober in inline assembly
In-Reply-To: <87y9l58pb5.fsf@fadata.bg>
	<200111171920.fAHJKjJ01550@penguin.transmeta.com>
From: Momchil Velikov <velco@fadata.bg>
In-Reply-To: <200111171920.fAHJKjJ01550@penguin.transmeta.com>
Date: 17 Nov 2001 22:24:28 +0200
Message-ID: <87r8qx6t8j.fsf@fadata.bg>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Linus" == Linus Torvalds <torvalds@transmeta.com> writes:

Linus> (Example code:

Linus> atomic_sub_and_test:
Linus> 	__asm__ __volatile__(
Linus> 		LOCK "subl %2,%0; sete %1"
Linus> 		:"=m" (v->counter), "=qm" (c)
Linus> 		:"ir" (i), "m" (v->counter) : "memory");

Linus> Where we first get the value we _really_ want in ZF in eflags, then we
Linus> use "sete" to move it to a register, and then gcc will end up generating
Linus> code to test that register by hand, so the end result is usually
Linus> something like:

Linus> #APP
Linus>         lock ; decl 20(%edi); sete %al
Linus> #NO_APP
Linus>         testb   %al, %al
Linus>         je      .L1570

Linus> even though what we'd _want_ is really

Linus> 	lock ; decl 20(%edi)
Linus> 	jne .L1570

Linus> which is not only smaller and faster, but is often _really_ faster
Linus> because at least some Intel CPU's will forward the flags values to the
Linus> branch prediction stuff, and going through a register dependency will
Linus> add non-forwarded state and thus extra cycles.

Linus> So I would personally _really_ really like for some way to expose the
Linus> internal gcc

Linus> 	"(set (cc0) ..asm..)"

Linus> construct, together with some way of setting the cc_status.flags.

Linux> From what I can tell, all the x86 machine description already uses "cc0"
Linus> together with the notion of comparing it to zero (either signed or
Linus> unsigned), so something like this _might_ just work

Linus> 	unsigned long result;
Linus> 	asm volatile(
Linus> 		LOCK "decl %m"
Linus> 		:"+m" (v->counter),
Linus> 		 "=cc" (result)
Linus> 		: :"memory");
Linus> 	if (result > 0)		/* "jnb" */
Linus> 		...

Linus> which would be wonderful, and would expand to

Linus> 	(set (cc0) ..asm..)
Linus> 	(set (pc)
Linus> 		(if_then_else (gtu (cc0) (const_int 0))
Linus> 			(label_ref (match_operand ..
Linus> 			(pc))

Indeed, with pattern like:
(define_insn "*ja"
  [(set (pc)
        (if_then_else (gtu (match_operand:CC 0 "" "") (const_int 0))
                      (label_ref (match_operand 1 "" ""))
		      (pc)))]
  ""
  "ja ..."
  ...)

Linus> Which _should_ just automatically give us

Linus> 	lock ; decl ..
Linus> 	ja ..

Linus> which is exactly what we want.

Regards,
-velco
