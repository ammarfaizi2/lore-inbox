Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281821AbRKQUlJ>; Sat, 17 Nov 2001 15:41:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281822AbRKQUlA>; Sat, 17 Nov 2001 15:41:00 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:2573 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S281821AbRKQUko>; Sat, 17 Nov 2001 15:40:44 -0500
Date: Sat, 17 Nov 2001 21:40:41 +0100
From: Jan Hubicka <jh@suse.cz>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: jh@suse.cz, linux-kernel@vger.kernel.org
Subject: Re: i386 flags register clober in inline assembly
Message-ID: <20011117214041.D3789@atrey.karlin.mff.cuni.cz>
In-Reply-To: <87y9l58pb5.fsf@fadata.bg> <200111171920.fAHJKjJ01550@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200111171920.fAHJKjJ01550@penguin.transmeta.com>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 	unsigned long result;
> 	asm volatile(
> 		LOCK "decl %m"
> 		:"+m" (v->counter),
> 		 "=cc" (result)
> 		: :"memory");
> 	if (result > 0)		/* "jnb" */
> 		...
> 
> which would be wonderful, and would expand to
> 
> 	(set (cc0) ..asm..)
> 	(set (pc)
> 		(if_then_else (gtu (cc0) (const_int 0))
> 			(label_ref (match_operand ..
> 			(pc))
> 
> Which _should_ just automatically give us
> 
> 	lock ; decl ..
> 	ja ..
> 
> which is exactly what we want.
> 
> I know this used to be impossible in gcc, because the x86 didn't
> actually track the flags values, and conditional jumps were really a
> _combination_ of the conditional and the jump, and splitting it up so
> that the conditional would be in an asm was thus not possible.
> 
> But I think gcc makes cc0 explicit on x86 these days, and that the above
> kind of setup might be possible today, no?
Actually the main dificulty I see is storing cc0 to variable.  CC0 is hard
register and pretty strange one - you can't move it, you can't spill.  Using
the syntax above you can easilly make cc0 from asm statement to span another
cc0 set resulting in incorrect code or compiler crash.
(the code generator may insert any code in between statements as it don't
know he can't clobber cc0. In fact this is happening in from of if
construct as deffered stack deallocators are flushed).

If i386 were IA-64 this would be possible as their flags behave more regularry,
but in i386 way I don't see easy trick how to get this (or something
equivalent) working.  Maybe someone do have idea how to get around, but I was
thinking about this some time ago too and failed to find feasible sollution.

Honza
> 
> 		Linus
