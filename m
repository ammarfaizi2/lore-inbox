Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132511AbRDKAzq>; Tue, 10 Apr 2001 20:55:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132503AbRDKAzg>; Tue, 10 Apr 2001 20:55:36 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:44048 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S132511AbRDKAzV>; Tue, 10 Apr 2001 20:55:21 -0400
Date: Tue, 10 Apr 2001 17:55:09 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: David Weinehall <tao@acc.umu.se>
cc: Andi Kleen <ak@suse.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        David Howells <dhowells@cambridge.redhat.com>,
        Andrew Morton <andrewm@uow.edu.au>, Ben LaHaise <bcrl@redhat.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] i386 rw_semaphores fix
In-Reply-To: <20010411021318.A21221@khan.acc.umu.se>
Message-ID: <Pine.LNX.4.31.0104101750320.15069-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 11 Apr 2001, David Weinehall wrote:
> >
> > Yes, and with CMPXCHG handler in the kernel it wouldn't be needed
> > (the other 686 optimizations like memcpy also work on 386)
>
> But the code would be much slower, and it's on 386's and similarly
> slow beasts you need every cycle you can get, NOT on a Pentium IV.

Note that the "fixup" approach is not necessarily very painful at all,
from a performance standpoint (either on 386 or on newer CPU's). It's not
really that hard to just replace the instruction in the "undefined
instruction"  handler by having strict rules about how to use the "xadd"
instruction.

For example, you would not actually fix up the xadd to be a function call
to something that emulates "xadd" itself on a 386. You would fix up the
whole sequence of "inline down_write()" with a simple call to an
out-of-line "i386_down_write()" function.

Note that down_write() on an old 386 is likely to be complicated enough
that you want to do it out-of-line anyway, so the code-path you take
(afetr the first time you've trapped on that particular location) would be
the one you would take for an optimized 386 kernel anyway. And similarly,
the restrictions you place on non-386-code to make it fixable are simple
enough that it probably shouldn't make a difference for performance on
modern chips.

		Linus



