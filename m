Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265008AbUFGTXS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265008AbUFGTXS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jun 2004 15:23:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265013AbUFGTXS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jun 2004 15:23:18 -0400
Received: from fw.osdl.org ([65.172.181.6]:56786 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265008AbUFGTXK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jun 2004 15:23:10 -0400
Date: Mon, 7 Jun 2004 12:22:57 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: David Woodhouse <dwmw2@infradead.org>
cc: Russell King <rmk+lkml@arm.linux.org.uk>,
       Thomas Gleixner <tglx@linutronix.de>,
       Greg Weeks <greg.weeks@timesys.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.4] jffs2 aligment problems
In-Reply-To: <1086635643.29255.46.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.58.0406071218240.1637@ppc970.osdl.org>
References: <40C484F9.20504@timesys.com>  <200406071736.53101.tglx@linutronix.de>
  <Pine.LNX.4.58.0406070900010.6162@ppc970.osdl.org> 
 <20040607174147.I28526@flint.arm.linux.org.uk> <1086635643.29255.46.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 7 Jun 2004, David Woodhouse wrote:
> > > Pleas fix jffs2 to use the proper "get_unaligned()"/"put_unaligned()"
> > > instead.
> 
> > I'll let you have a bun fight with dwmw2 and networking people over
> > this.  I'm standing well clear. 8)
> 
> S'fine by me. I already added get_unaligned() to the flash drivers years
> ago -- it's actually those, not JFFS2 itself which needs it. Alan
> insisted I remove it on the basis that much of our network code is
> similarly broken anyway; an arch without fixups is dead in the water
> whatever happens.

I don't see it as a correctness issue, I see it as a performance issue.

Yes, the old ARM chips that can't do unaligned accesses and can't even 
trap on them probably have a number of cases where they literally do the 
wrong thing, and I think most people will say "tough luck, don't do that 
then". 

But get_unaligned() makes sense quite apart from that usage too. Notably, 
many architectures can cheaply do unaligned accesses when they are known 
to be unaligned, but take thousands of cycles to fix up traps. Alpha comes 
to mind, and this was actually what "get_unaligned()" was really designed 
for.

> Anything which _could_ be unaligned should be marked as such, even if we
> do have two levels ('possibly unaligned', 'probably unaligned') where
> the latter behaves purely as an optimisation on most arches, just like
> our current get_unaligned() does.

Right now we might as well consider the "get_unaligned()" to be a "quite 
possibly unaligned" as opposed to "this just _might_ be unaligned".

That's the current usage pattern anyway. Nothing really _guarantees_ that 
unaligned accesses are marked with "get_unaligned()", but the unaligned 
fixup is at least supposed to be _rare_.

Put another way: imagine if the unaligned handler did a printk(). That 
shouldn't flood the logs under normal load.

			Linus
