Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262792AbSKNTLU>; Thu, 14 Nov 2002 14:11:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262486AbSKNTLT>; Thu, 14 Nov 2002 14:11:19 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:43269 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S262792AbSKNTLS>; Thu, 14 Nov 2002 14:11:18 -0500
Date: Thu, 14 Nov 2002 11:17:47 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andrea Arcangeli <andrea@suse.de>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Christoph Hellwig <hch@infradead.org>,
       Leif Sawyer <lsawyer@gci.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: FW: i386 Linux kernel DoS
In-Reply-To: <20021114190014.GQ31697@dualathlon.random>
Message-ID: <Pine.LNX.4.44.0211141112480.4989-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 14 Nov 2002, Andrea Arcangeli wrote:
> 
> actually TF should cleared implicitly in the do_debug or it could get
> the single step trap before you can clear TF explicitly in the entry.S.

But that's fine. Getting a single step trap in the kernel is not a 
problem: the trap will clear TF/NT on the "recursive" kernel entry, and on 
the recursive "iret" nothing bad will happen. 

Remember: what is on the _stack_ doesn't matter. The only thing that 
matters is what is actually in the EFLAGS register itself.

> but it's certainly zerocost to clear it explicitly there too just to
> remeber it's one of the bits not cleared implicitly in hardware when
> entering via lcall.  However in 2.5 it seems the clear_TF in do_debug is
> still missing.

No, do_debug() already does

        /* Mask out spurious TF errors due to lazy TF clearing */
        if (condition & DR_STEP) {
                if ((regs->xcs & 3) == 0)
                        goto clear_TF;

which will make sure that we only get _one_ of these spurious (and 
harmless) TF traps if somebody tries to mess with us.

So that is correct (and your patch is _not_ correct - it's not right
checking what the EIP value is, since it doesn't matter. In fact, I think
you could quite validly have "big" EIP values in user space by just
creating interesting code segments).

			Linus

