Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265570AbSKOCGe>; Thu, 14 Nov 2002 21:06:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265578AbSKOCGe>; Thu, 14 Nov 2002 21:06:34 -0500
Received: from [195.223.140.107] ([195.223.140.107]:39569 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S265570AbSKOCGd>;
	Thu, 14 Nov 2002 21:06:33 -0500
Date: Fri, 15 Nov 2002 03:13:08 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Christoph Hellwig <hch@infradead.org>,
       Leif Sawyer <lsawyer@gci.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: FW: i386 Linux kernel DoS
Message-ID: <20021115021308.GV31697@dualathlon.random>
References: <20021114190014.GQ31697@dualathlon.random> <Pine.LNX.4.44.0211141112480.4989-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0211141112480.4989-100000@penguin.transmeta.com>
User-Agent: Mutt/1.3.27i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 14, 2002 at 11:17:47AM -0800, Linus Torvalds wrote:
> 
> On Thu, 14 Nov 2002, Andrea Arcangeli wrote:
> > 
> > actually TF should cleared implicitly in the do_debug or it could get
> > the single step trap before you can clear TF explicitly in the entry.S.
> 
> But that's fine. Getting a single step trap in the kernel is not a 
> problem: the trap will clear TF/NT on the "recursive" kernel entry, and on 
> the recursive "iret" nothing bad will happen. 
> 
> Remember: what is on the _stack_ doesn't matter. The only thing that 

yes.

> matters is what is actually in the EFLAGS register itself.
> 
> > but it's certainly zerocost to clear it explicitly there too just to
> > remeber it's one of the bits not cleared implicitly in hardware when
> > entering via lcall.  However in 2.5 it seems the clear_TF in do_debug is
> > still missing.
> 
> No, do_debug() already does
> 
>         /* Mask out spurious TF errors due to lazy TF clearing */
>         if (condition & DR_STEP) {
>                 if ((regs->xcs & 3) == 0)
>                         goto clear_TF;
> 
> which will make sure that we only get _one_ of these spurious (and 
> harmless) TF traps if somebody tries to mess with us.
> 
> So that is correct (and your patch is _not_ correct - it's not right
> checking what the EIP value is, since it doesn't matter. In fact, I think
> you could quite validly have "big" EIP values in user space by just
> creating interesting code segments).

actually I just had to workaround that code for kgdb, and yes, vsyscalls
would run above PAGE_OFFSET too. OTOH now I don't see anymore the point
of the patch that I posted that is included in 2.4.20rc1, I wrongly
assumed that setting the TF would not guarantee DR_STEP to be set in
db6 (there would be no other reason for such patch) but according to the
manual this isn't the case, so 2.5 is correct and 2.4.20rc1 is overkill
and so I'll backout that patch too, that will avoid the ugly workaround
with kgdb too (that basically disabled such check on the eip as soon as
kgdb was started). If anybody can see a problem in backing out from 2.4
the patch I was suggesting for 2.5 please let me know. Thanks.

Andrea
