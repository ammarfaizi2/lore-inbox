Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265009AbUFGTRU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265009AbUFGTRU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jun 2004 15:17:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265007AbUFGTRT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jun 2004 15:17:19 -0400
Received: from [213.146.154.40] ([213.146.154.40]:62421 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S265010AbUFGTPW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jun 2004 15:15:22 -0400
Subject: Re: [PATCH 2.4] jffs2 aligment problems
From: David Woodhouse <dwmw2@infradead.org>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Linus Torvalds <torvalds@osdl.org>, Thomas Gleixner <tglx@linutronix.de>,
       Greg Weeks <greg.weeks@timesys.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20040607174147.I28526@flint.arm.linux.org.uk>
References: <40C484F9.20504@timesys.com>
	 <200406071736.53101.tglx@linutronix.de>
	 <Pine.LNX.4.58.0406070900010.6162@ppc970.osdl.org>
	 <20040607174147.I28526@flint.arm.linux.org.uk>
Content-Type: text/plain
Date: Mon, 07 Jun 2004 20:14:03 +0100
Message-Id: <1086635643.29255.46.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.8 (1.5.8-3.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-06-07 at 17:41 +0100, Russell King wrote:
> > Pleas fix jffs2 to use the proper "get_unaligned()"/"put_unaligned()"
> > instead.

> I'll let you have a bun fight with dwmw2 and networking people over
> this.  I'm standing well clear. 8)

S'fine by me. I already added get_unaligned() to the flash drivers years
ago -- it's actually those, not JFFS2 itself which needs it. Alan
insisted I remove it on the basis that much of our network code is
similarly broken anyway; an arch without fixups is dead in the water
whatever happens.

Admittedly it's not _entirely_ stupid in the network code, because a
direct load is often a lot faster than the byte-wise load emitted by
get_unaligned(). If alignment is the common case, it makes some sense to
optimise that and take the trap only occasionally.

But with uClinux being merged (many uClinux arches can't fix up
alignment at all), I think we should revisit that decision.

Anything which _could_ be unaligned should be marked as such, even if we
do have two levels ('possibly unaligned', 'probably unaligned') where
the latter behaves purely as an optimisation on most arches, just like
our current get_unaligned() does.

Or in fact since the ratio between the speeds of the inline and the trap
version varies wildly from arch to arch, and hence the point at which it
becomes more efficient just to use the current get_unaligned() varies --
perhaps we should have 'get_unaligned(ptr, probability)' and let the
arch code decide where the threshold should be. It's not that hard to
make it go away completely given __builtin_constant_p(probability) and
some preprocessor macros.

-- 
dwmw2

