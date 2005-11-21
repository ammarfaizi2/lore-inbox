Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750949AbVKUT7g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750949AbVKUT7g (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 14:59:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750948AbVKUT7g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 14:59:36 -0500
Received: from smtp.osdl.org ([65.172.181.4]:11139 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750778AbVKUT7f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 14:59:35 -0500
Date: Mon, 21 Nov 2005 11:59:05 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Matthew Wilcox <matthew@wil.cx>
cc: David Howells <dhowells@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Russell King <rmk@arm.linux.org.uk>, Ian Molton <spyro@f2s.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH 4/5] Centralise NO_IRQ definition
In-Reply-To: <20051121194348.GH1598@parisc-linux.org>
Message-ID: <Pine.LNX.4.64.0511211150040.13959@g5.osdl.org>
References: <E1Ee0G0-0004CN-Az@localhost.localdomain>
 <24299.1132571556@warthog.cambridge.redhat.com> <20051121121454.GA1598@parisc-linux.org>
 <Pine.LNX.4.64.0511211047260.13959@g5.osdl.org> <20051121190632.GG1598@parisc-linux.org>
 <Pine.LNX.4.64.0511211124190.13959@g5.osdl.org> <20051121194348.GH1598@parisc-linux.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 21 Nov 2005, Matthew Wilcox wrote:
> > 
> > 	if (!dev->irq)
> > 		return;
> > 
> > (whatever, made up). And that having NO_IRQ be anything but 0 is thus 
> > fundamentally broken.
> 
> The idea was to give them something better to use instead of this.

Why?

The above is obvious even to a non-programmer. There _is_ no better thing 
from a clarity standpoint.

> The only relevant thing I found with google was
> http://www.microsoft.com/whdc/archive/pciirq.mspx

Look at, for example, any cardbus controller. The way to disable 
generation of the legacy interrupt? Write an irq value of 0 to the 
interrupt control register.

Or check out the irq routers in arch/i386/pci/irq.c. Every _single_ one of 
them does the same. Zero means disabled.

The point I'm trying to make is that there already _is_ a special bit 
pattern that means "no irq", and it's what

 - the kernel has used for the last 14 years
 - is the easiest and most logical one to test for
 - real hardware uses

so why not just use it?

Anybody who says that

	if (!dev->irq)
		return;

isn't logical is just on drugs. It's logical _and_ readable. More so than 
any alternative, especially as any alternative will always have the 
problem that some people will write the above _anyway_.

If you make NO_IRQ be something else than 0, for safety you should also 
make the irq thing be a structure so that the test against zero (which is 
special, as _defined_ by the C language) won't work.

At which point you might as well just do something like

	struct interrupt_descriptor {
		unsigned int nr:31;
		unsigned int valid:1;
	};

and then people can just say

	if (!dev->irq.valid)
		return;

instead, which is also readable, and where you simply cannot do the old 
"if (!dev->irq)" at all.

The fact is, 0 _is_ special. Not just for hardware, but because 0 has a 
magical meaning as "false" in the C language.

			Linus
