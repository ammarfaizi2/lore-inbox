Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267506AbRGRRWu>; Wed, 18 Jul 2001 13:22:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267509AbRGRRWj>; Wed, 18 Jul 2001 13:22:39 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:10511 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S267506AbRGRRW2>; Wed, 18 Jul 2001 13:22:28 -0400
Date: Wed, 18 Jul 2001 10:21:42 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Julian Anastasov <ja@ssi.bg>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: cpuid_eax damages registers (2.4.7pre7)
In-Reply-To: <Pine.LNX.4.10.10107181910510.23130-100000@l>
Message-ID: <Pine.LNX.4.33.0107181014590.883-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 18 Jul 2001, Julian Anastasov wrote:
>
> gcc version egcs-2.91.66 19990314/Linux (egcs-1.1.2 release)

Ok. That has been considered a "stable" gcc for a long time.

We should try to find a work-around.

> >  - do a "make arch/i386/kernel/setup.s" both ways, and show what
> >    squash_the_stupid_serial_number() looks like.
>
> 	Both with "a" and "0" (zero) gcc shows same output in setup.s
> (using cpuid_eax):

Ok.

Can you try to do the following in the cpuid_xxx() functions:
 - remove the dummy reads (ie leave just the one register in the asm that
   we're actually interested in)
 - add explicit clobbers for the other registers

So, for example, cpuid_eax() would be roughly

	unsigned int eax;
	asm("cpuid"
		:"=a" (eax)
		:"0" (level)
		:"bx","cx","dx");
	return eax;

(and for the others, you can't really clobber "ax" because it's an input,
so you'd have to leave that as just a "=a" (eax) and hope that gcc gets
that output right.

> 	lock ; btrl $18,12(%ebx)
> #NO_APP
> 	xorl %eax,%eax
> #APP
> 	cpuid					<<<-- cpuid_eax
> #NO_APP
> 	movl %eax,8(%ebx)			<<<-- oops

Yes, the above is very definitely a bug in gcc. Oh, well..

> 	Even by using cpuid(...) replacement the registers are not
> preserved but instead of ebx, the arg "c" is in ebp and the oops does not
> occur:

They don't have ot be preserved per se - gcc just knows that they are
modified, and because gcc doesn't care about the value it just won't use
it.

> 	After fixing this with cpuid() I can work perfectly with this
> kernel on network activity (45K packets/sec), SMP. So, only cpuid_xxx are
> suspected for now.

The current asms for cpuid_xxx() are correct. The fact that gcc generates
bad code for this case implies that it might happen somewhere else too,
but as egcs-2.91.66 is fairly well tested it may indeed be that this is
the only case where that actually happens.

> I don't preserve the oopses but I can do it if ..

No, your generated assembly is clear enough evidence of what is going on.
Thanks. If you could try the clobber approach, that would be good.

		Linus

