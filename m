Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751176AbVKUW3Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751176AbVKUW3Z (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 17:29:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751179AbVKUW3Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 17:29:25 -0500
Received: from smtp.osdl.org ([65.172.181.4]:30381 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751176AbVKUW3Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 17:29:24 -0500
Date: Mon, 21 Nov 2005 14:28:59 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: Paul Mackerras <paulus@samba.org>, Ingo Molnar <mingo@elte.hu>,
       Matthew Wilcox <matthew@wil.cx>, David Howells <dhowells@redhat.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Russell King <rmk@arm.linux.org.uk>, Ian Molton <spyro@f2s.com>
Subject: Re: [PATCH 4/5] Centralise NO_IRQ definition
In-Reply-To: <1132610802.26560.44.camel@gaston>
Message-ID: <Pine.LNX.4.64.0511211418391.13959@g5.osdl.org>
References: <E1Ee0G0-0004CN-Az@localhost.localdomain> 
 <24299.1132571556@warthog.cambridge.redhat.com>  <20051121121454.GA1598@parisc-linux.org>
  <Pine.LNX.4.64.0511211047260.13959@g5.osdl.org>  <20051121190632.GG1598@parisc-linux.org>
  <Pine.LNX.4.64.0511211124190.13959@g5.osdl.org>  <20051121194348.GH1598@parisc-linux.org>
  <Pine.LNX.4.64.0511211150040.13959@g5.osdl.org>  <20051121211544.GA4924@elte.hu>
  <17282.15177.804471.298409@cargo.ozlabs.ibm.com> 
 <Pine.LNX.4.64.0511211339450.13959@g5.osdl.org> <1132610802.26560.44.camel@gaston>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 22 Nov 2005, Benjamin Herrenschmidt wrote:
> 
> > On all PC hardware, having a zero in the PCI irq register basically means 
> > that no irq is enabled. That's a _fact_. It's a fact however much you may 
> > not like it. It's how the hardware comes up, and it's how the BIOS leaves 
> > it. So "0" absolutely does mean "not allocated". 
> 
> It's not the case on various non-x86 architectures, not the case in the
> PCI spec neither.

So?

The point is, we have to handle the 0 on a PC architecture _anyway_.

The PCI spec does NOT MATTER. The 0 case is a _fact_. 

If the PCI spec said that the world was flat, would that make a 
difference? No. 

The fact is, we need to pick some value for "No irq", and that value needs 
translation. I claim that 0 is superior, because
 - we know it works on the biggest hardware base
 - it's de facto what pretty much all of the current source code _does_ 
   anyway
 - it's easier to test for, and more importantly it allows the most 
   natural source code syntax with fewer mistakes.
 - it requires no more translation than any other value, including -1.

These are all just undeniable facts. 

In contrast, the PCI spec gives us a 8-bit value that is _known_ to not be 
sufficient anyway: (a) it has no "undefined" value at all, although one is 
clearly needed (and on PC's, 0 _is_ that value) and (b) it's really too 
small to cover the possible interrupt sources anyway (ie big machines 
already tend to have more than 256 interrupts).

So you could just make the ppc PCI probing do

	dev->irq = PCI_IRQ_BASE + node->intrs[0].line;

and suddenly 0 works equally well for you as it does on a regular PC. 

Notice? Magic. Suddenly "0" means "No irq" on ppc too.

		Linus
