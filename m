Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932425AbVKUTGg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932425AbVKUTGg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 14:06:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932428AbVKUTGg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 14:06:36 -0500
Received: from palinux.external.hp.com ([192.25.206.14]:30442 "EHLO
	palinux.hppa") by vger.kernel.org with ESMTP id S932425AbVKUTGf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 14:06:35 -0500
Date: Mon, 21 Nov 2005 12:06:32 -0700
From: Matthew Wilcox <matthew@wil.cx>
To: Linus Torvalds <torvalds@osdl.org>
Cc: David Howells <dhowells@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Russell King <rmk@arm.linux.org.uk>, Ian Molton <spyro@f2s.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH 4/5] Centralise NO_IRQ definition
Message-ID: <20051121190632.GG1598@parisc-linux.org>
References: <E1Ee0G0-0004CN-Az@localhost.localdomain> <24299.1132571556@warthog.cambridge.redhat.com> <20051121121454.GA1598@parisc-linux.org> <Pine.LNX.4.64.0511211047260.13959@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0511211047260.13959@g5.osdl.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 21, 2005 at 10:55:24AM -0800, Linus Torvalds wrote:
> Quite frankly, if we change [PCI_]NO_IRQ to -1, there's almost certainly 
> going to be a lot of drivers breaking.

There's only one driver using NO_IRQ today (outside of architectures
which define NO_IRQ to -1, that is).  So *this* series of patches should
break nothing.  The next series of patches should find all the PCI
drivers assuming dev->irq == 0 means no interrupt, and then we try to
break drivers by getting rid of PCI_NO_IRQ.

> This is not theory: a _lot_ of real-life PCI devices very much think that 
> irq 0 means "disabled". Not even just in drivers - in actual _hardware_. 
> When you write 0 to the irq number for irq routers, they disable that 
> line. So the "zero as NO_IRQ" is more than just a "several drivers think 
> that is how it is", it's how a lot of hardware actually works.

That's a common misreading of the PCI spec -- it actually says the
opposite.  Interrupt Pin works as you've described.  But what we're
concerned with is Interrupt Line, and PCI 2.3 has the following to say
in a footnote:

	43 For x86 based PCs, the values in this register correspond to
	IRQ numbers (0-15) of the standard dual 8259 configuration. The
	value 255 is defined as meaning "unknown" or "no connection" to
	the interrupt controller. Values between 15 and 254 are reserved.

It's just that Linux doesn't bother to read Interrupt Line if Interrupt
Pin is 0, and thus leaves the interrupt value at 0 (since the struct was
memset).

Really, this patch brings x86 back into compliance with what the
BIOS does ;-)
