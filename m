Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131973AbRDJTmu>; Tue, 10 Apr 2001 15:42:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131974AbRDJTml>; Tue, 10 Apr 2001 15:42:41 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:44816 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S131973AbRDJTm3>; Tue, 10 Apr 2001 15:42:29 -0400
Date: Tue, 10 Apr 2001 12:42:07 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: David Howells <dhowells@cambridge.redhat.com>
cc: Andrew Morton <andrewm@uow.edu.au>, Ben LaHaise <bcrl@redhat.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] i386 rw_semaphores fix
In-Reply-To: <11851.986925762@warthog.cambridge.redhat.com>
Message-ID: <Pine.LNX.4.31.0104101229150.13071-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 10 Apr 2001, David Howells wrote:
>
> Here's a patch that fixes RW semaphores on the i386 architecture. It is very
> simple in the way it works.

XADD only works on Pentium+.

That's no problem if we make this SMP-specific - I doubt anybody actually
uses SMP on i486's even if the machines exist, as I think they all had
special glue logic that Linux would have trouble with anyway. But the
advantages of being able to use one generic kernel that works on plain UP
i386 machines as well as SMP P6+ machines is big enough that I would want
to be able to say "CONFIG_X86_GENERIC" + "CONFIG_SMP".

Even if it would be noticeably slower (ie a fallback to a spinlock might
be perfectly ok).

If you do this, I woul dsuggest having asm-i386/{rwsem.h|rwsem-xadd.h},
and just having a

	#ifndef CONFIG_XADD
	#include <asm/rwsem.h>
	#else
	#include <asm/rwsem-xadd.h>
	#endif

(And adding "CONFIG_XADD" to the list of generated optimization
configuration options in arch/i386/config.in, of course).

That way we don't make the semaphore.h file even more unreadable.


		Linus


