Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965757AbWKDXyt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965757AbWKDXyt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Nov 2006 18:54:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965755AbWKDXys
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Nov 2006 18:54:48 -0500
Received: from smtp.osdl.org ([65.172.181.4]:44256 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965756AbWKDXyr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Nov 2006 18:54:47 -0500
Date: Sat, 4 Nov 2006 15:52:57 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: Russell King <rmk+lkml@arm.linux.org.uk>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jgarzik@pobox.com>, Andrew Morton <akpm@osdl.org>,
       "David S. Miller" <davem@davemloft.net>,
       Paul Mackerras <paulus@samba.org>
Subject: Re: lib/iomap.c mmio_{in,out}s* vs. __raw_* accessors
In-Reply-To: <1162678639.28571.63.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0611041544030.25218@g5.osdl.org>
References: <1162626761.28571.14.camel@localhost.localdomain> 
 <20061104140559.GC19760@flint.arm.linux.org.uk> <1162678639.28571.63.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 5 Nov 2006, Benjamin Herrenschmidt wrote:
> 
> I'm tempted to remove those mmio_* things from iomap.c completely. I
> need to check who uses them, but in all cases, I don't see what they do
> in iomap.c, it's not their place.

I don't think you understand the point. The point is that a lot of the 
tests for whether something is MMIO or PIO can be done _once_, instead of 
doing it for every access.

> Versions that would transparently use MMIO or PIO would make sense.

No, they would be idiotic, because we already have those. If you want to 
use MMIO or PIO transparently one access at a time, YOU SHOULD NOT USE THE 
"STRING" VERSION. You should just use "ioread8()" or something like that. 

That _is_ the single-access-does-MMIO-or-PIO-transparently function!

> A pure MMIO implementation doesn't, that has to be arch specific. It makes
> the generic iomap suddently non-portable in some ways.

Whaa? I really don't see what's wrong with the one that is in lib/iomap.c. 
But if you want to do your own, go ahead and do so - the whole point of 
lib/iomap.c is to be a library that can be used by architectures that can 
use the generic functionality. It's all hidden behind 
CONFIG_GENERIC_IOMAP.

In other words, this whole thread makes absolutely _zero_ sense. Either 
you use those functions or you don't. Trying to change them would be 
insane.

> So I think we need to make sure all archs grow readsb,sw,sl etc... and
> just have iomap use those for the "transparent" versions.

Again, totally insane. If you don't want to use GENERIC_IOMAP, don't. But 
don't force other architectures to follow that path to insanity.

So, in short:
 (a) if the generic library doesn't work for you, stop using it

 (b) the whole _point_ of the "repeat" instructions is to avoid doing the 
     same tests over and over again for an iomem address that won't 
     change, so doing them in the individual accessor functions would be 
     _crazy_.

 (c) if you want to add #IO barriers to that thing, again, do it _around_ 
     the repeat string, not in the individual accesses. If you need them 
     on an individual access basis, you're probably better off doing your 
     own version altogether.

Please explain what is so wrong with the current setup, and please explain 
why you'd want to break the obvious "check the address only once!" rule 
that makes sense for _any_ architecture that has separate #PIO and #MMIO 
address spaces.

			Linus
