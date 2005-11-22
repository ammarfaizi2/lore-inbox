Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964820AbVKVB0x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964820AbVKVB0x (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 20:26:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964821AbVKVB0x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 20:26:53 -0500
Received: from smtp.osdl.org ([65.172.181.4]:49369 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964820AbVKVB0x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 20:26:53 -0500
Date: Mon, 21 Nov 2005 17:26:08 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Paul Mackerras <paulus@samba.org>
cc: Ingo Molnar <mingo@elte.hu>, Matthew Wilcox <matthew@wil.cx>,
       David Howells <dhowells@redhat.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Russell King <rmk@arm.linux.org.uk>,
       Ian Molton <spyro@f2s.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 4/5] Centralise NO_IRQ definition
In-Reply-To: <17282.22077.670148.356981@cargo.ozlabs.ibm.com>
Message-ID: <Pine.LNX.4.64.0511211717030.13959@g5.osdl.org>
References: <E1Ee0G0-0004CN-Az@localhost.localdomain>
 <24299.1132571556@warthog.cambridge.redhat.com> <20051121121454.GA1598@parisc-linux.org>
 <Pine.LNX.4.64.0511211047260.13959@g5.osdl.org> <20051121190632.GG1598@parisc-linux.org>
 <Pine.LNX.4.64.0511211124190.13959@g5.osdl.org> <20051121194348.GH1598@parisc-linux.org>
 <Pine.LNX.4.64.0511211150040.13959@g5.osdl.org> <20051121211544.GA4924@elte.hu>
 <17282.15177.804471.298409@cargo.ozlabs.ibm.com> <Pine.LNX.4.64.0511211339450.13959@g5.osdl.org>
 <17282.22077.670148.356981@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 22 Nov 2005, Paul Mackerras wrote:
> 
> First, are you talking about the interrupt pin register or the
> interrupt line register?

Interrupt line. The interrupt pin is totally separate.

> Secondly, I would say that any driver that looks at either of those
> registers is broken.  Drivers should be looking at dev->irq, which is
> set up by platform code, and may be quite different from what is in
> the interrupt line register.

But that's part of the POINT, Paul.

The platform code needs to set up something in dev->irq. And we have 
_always_ had "dev->irq == 0" meaning "no irq".

So if PCI irq (the interrupt line register or whatever) 0 means something 
for you on PPC, then BY DEFINITION you should not have translated it into 
"dev->irq". But PPC did. Tough. Don't blame that mistake on me, or try to 
force that mistake on other architectures.

The fact that PPC screwed that up is a PPC problem, and it's a PPC problem 
from the very beginning, because the "dev->irq" value doesn't have to 
match the PCI irq at all.

On sparc, for example, "dev->irq" used to be some random cookie, if I 
remember correctly. But "0" still meant "unallocated".

So face it. PPC screwed up, and if it had just followed what the 
"dev->irq" meant on the regular x86 platforms, it wouldn't have needed 
that NO_IRQ in the first place.

The whole notion of needing "NO_IRQ" is broken. The way to test for not 
having an irq is "!dev->irq". Any architecture that uses NO_IRQ is just a 
bug waiting to happen, for any number of drivers. And for no good reason.

		Linus
