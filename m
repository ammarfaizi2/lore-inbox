Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964857AbWKDHxU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964857AbWKDHxU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Nov 2006 02:53:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964869AbWKDHxU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Nov 2006 02:53:20 -0500
Received: from gate.crashing.org ([63.228.1.57]:58553 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S964857AbWKDHxU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Nov 2006 02:53:20 -0500
Subject: lib/iomap.c mmio_{in,out}s* vs. __raw_* accessors
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jgarzik@pobox.com>, Andrew Morton <akpm@osdl.org>,
       "David S. Miller" <davem@davemloft.net>,
       Paul Mackerras <paulus@samba.org>
Content-Type: text/plain
Date: Sat, 04 Nov 2006 18:52:41 +1100
Message-Id: <1162626761.28571.14.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm implementing an optional mecanism that some platforms can use on
powerpc to hook the various MMIO and PIO operations (to handle things
ranging from iSeries-like MMIO via HyperVisor stuff to platform specific
errata on the PCI bus).

When that mecanism is enabled, I stop using arch/powerpc's iomap
implementation and fallback instead on the generic one in lib/iomap.c
since by using the standard accessors, it will directly benefit from the
hooks.

However, I noticed the following:

static inline void mmio_insb(void __iomem *addr, u8 *dst, int count)
{
        while (--count >= 0) {
                u8 data = __raw_readb(addr);
                *dst = data;
                dst++;
        }
}

etc...

The problem is that the current implementation, at least on powerpc, of
the "raw" accessors is to both not swap _and_ have no barriers.

I don't want to dig back out the big discussion we had about in-order
vs. "relaxed" IO operations and my proposed document about it that's
currently sitting in limbo mostly due to apparent lack of interest to
fix the issue on other parts than mine (that's ok though, I'm not
complaining, I'll come back and push when I get some more time and moti
vation for it :)

However, there is some issue here which I think is that the "raw"
accessors are badly defined.

In fact, I would be very very very much in favor of, instead of the
above, defining a set of:

readsb, readsw, readsl, readsq
writesb, writesw, writesl, writesq

And have lib/iomap.c use those. That has several benefits, though two
pop off the top of my mind at the moment:

 - Consistent naming, which is very useful, especially with my new
hookable mecanism where I generate things with macros :) But still,
appart from that, consistent naming is I think a big bonus to the users
of those APIs.

 - The arch is responsible from implementing them, exactly like the
others readb...q, writeb....q, inb...l, outb...l, and thus is in precise
control of which barriers are necessary, while still being able to use
the generic iomap because it's handy and avoids having to re-implement
everything duplicate.

Now, of course, currently no arch implement them :-)

So I'd like to propose that we do that. I can put together a "default"
implementation that everybody uses based on __raw (assuming that works
fine for a lot of archs) and have powerpc do it's "correct" one.

Oh, also, the insb...insl etc.. versions of those are generally not
strongly types (buffer is a void *) while the iomap are (buffer is a
pointer to the native type of the operation: u8...u32). What do you guys
prefer ? I tend to personally prefer void * for IO related bits but I
wouldn't fight for that one.

Cheers,
Ben.


