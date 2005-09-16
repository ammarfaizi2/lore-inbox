Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750845AbVIPUe5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750845AbVIPUe5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 16:34:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751261AbVIPUe5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 16:34:57 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:47778
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1750845AbVIPUe4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 16:34:56 -0400
Date: Fri, 16 Sep 2005 13:34:53 -0700 (PDT)
Message-Id: <20050916.133453.130025195.davem@davemloft.net>
To: ecashin@coraid.com
Cc: linux-kernel@vger.kernel.org, jmacbaine@gmail.com
Subject: Re: aoe fails on sparc64
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <87u0glxhfw.fsf@coraid.com>
References: <3afbacad0508310630797f397d@mail.gmail.com>
	<87u0glxhfw.fsf@coraid.com>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ed L Cashin <ecashin@coraid.com>
Date: Fri, 16 Sep 2005 09:36:51 -0400

> I've been working with Jim MacBaine, and he reports that the patch
> below gets rid of the problem.  I don't know why.  When I test
> le64_to_cpup by itself, it works as expected.

This reminds me of a known UltraSPARC chip bug.  There is a bug
wherein if you do a 64-bit endianness swapped load instruction, it
only endian swaps within each 32-bit word, not throughout the entire
64-bit word as it should.

But this is weird, because the errata description for this chip bug
says that it only applies to the deprecated 32-bit mode "ldd/std"
instructions, whereas the compiler emits the 64-bit "ldx/stx"
instructions for sparc64 kernel builds.

So, first, let's sanity check the ___arch__swab64p() implementation:

#include <stdlib.h>
#include <stdio.h>

#define ASI_PL			0x88 /* Primary, implicit, l-endian	*/

typedef unsigned long __u64;

static __inline__ __u64 ___arch__swab64p(const __u64 *addr)
{
	__u64 ret;

	__asm__ __volatile__ ("ldxa [%1] %2, %0"
			      : "=r" (ret)
			      : "r" (addr), "i" (ASI_PL));
	return ret;
}

int main(void)
{
	unsigned long tval = 0x123456789abcdef0;
	unsigned long *p, v;

	p = &tval;
	v = ___arch__swab64p(p);
	printf("%016lx --> %016lx\n",
	       tval, v);
	exit(0);
}

Running this on my Ultra-IIIi workstation (this chip doesn't have
said errata) gives the desired result:

davem@sunset:~/src/GIT/sparc-2.6$ gcc -m64 -O2 -o x x.c
davem@sunset:~/src/GIT/sparc-2.6$ ./x
123456789abcdef0 --> f0debc9a78563412
davem@sunset:~/src/GIT/sparc-2.6$

So it looks sane.  Let's try this on a chip that has the errata:

? ./x
123456789abcdef0 --> f0debc9a78563412
? 

That's fine too, so this isn't what is causing the problems.

Wait, I think I see the problem.  Is that "&id[100<<1]" pointer
aligned properly on a 64-bit boundary?  I bet it isn't, and the
sparc64 unaligned load/store trap handler doesn't check whether one of
the endian swapping load/store attributes are being used.

Looking at the assembler generated for aoecmd.s, it isn't aligned:

	add	%l1, 236, %g2
 ...
	ldxa [%g2] 136, %g7

That's aligned on a 4-byte boundary, but not an 8-byte one.

So this is what the bug is.
