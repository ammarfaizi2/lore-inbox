Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265043AbUFGUkw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265043AbUFGUkw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jun 2004 16:40:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265048AbUFGUkw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jun 2004 16:40:52 -0400
Received: from [213.146.154.40] ([213.146.154.40]:22999 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S265043AbUFGUkt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jun 2004 16:40:49 -0400
Subject: Re: [PATCH 2.4] jffs2 aligment problems
From: David Woodhouse <dwmw2@infradead.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>,
       Thomas Gleixner <tglx@linutronix.de>,
       Greg Weeks <greg.weeks@timesys.com>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.58.0406071218240.1637@ppc970.osdl.org>
References: <40C484F9.20504@timesys.com>
	 <200406071736.53101.tglx@linutronix.de>
	 <Pine.LNX.4.58.0406070900010.6162@ppc970.osdl.org>
	 <20040607174147.I28526@flint.arm.linux.org.uk>
	 <1086635643.29255.46.camel@localhost.localdomain>
	 <Pine.LNX.4.58.0406071218240.1637@ppc970.osdl.org>
Content-Type: text/plain
Date: Mon, 07 Jun 2004 21:39:31 +0100
Message-Id: <1086640771.29255.57.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.8 (1.5.8-3.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-06-07 at 12:22 -0700, Linus Torvalds wrote:
> I don't see it as a correctness issue, I see it as a performance issue.

In the case in question it's very much _not_ a performance issue. We're
writing a buffer to FLASH memory. The time it takes to read the word
from RAM is entirely lost in the noise compared with the time it takes
to write it to the flash.

Most of the time the buffer passed to the flash write routines will be
word-aligned. Occasionally it'll be unaligned but since there's a
distinct correlation between those arches on which we can't do fixups
and those machines on which flash is primary storage, putting
get_unaligned() in is a _correctness_ issue. And I don't care that it
might be slightly slower in the common case; as I said, it's in the
noise.

> Yes, the old ARM chips that can't do unaligned accesses and can't even 
> trap on them probably have a number of cases where they literally do the 
> wrong thing, and I think most people will say "tough luck, don't do that 
> then". 

Not just old ARM chips. Some new chips too; especially MMU-less ones.

> But get_unaligned() makes sense quite apart from that usage too. Notably, 
> many architectures can cheaply do unaligned accesses when they are known 
> to be unaligned, but take thousands of cycles to fix up traps. Alpha comes 
> to mind, and this was actually what "get_unaligned()" was really designed 
> for.

Yes. That's why I suggested we should have two forms -- for 'possibly'
and 'probably' unaligned.

> > Anything which _could_ be unaligned should be marked as such, even if we
> > do have two levels ('possibly unaligned', 'probably unaligned') where
> > the latter behaves purely as an optimisation on most arches, just like
> > our current get_unaligned() does.
> 
> Right now we might as well consider the "get_unaligned()" to be a "quite 
> possibly unaligned" as opposed to "this just _might_ be unaligned".

Yes. That's why I was told to remove our current get_unaligned() from
the flash drivers. I'm perfectly happy to put it back.


-- 
dwmw2

