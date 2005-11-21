Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932415AbVKUSz5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932415AbVKUSz5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 13:55:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932451AbVKUSz5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 13:55:57 -0500
Received: from smtp.osdl.org ([65.172.181.4]:5859 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932415AbVKUSz5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 13:55:57 -0500
Date: Mon, 21 Nov 2005 10:55:24 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Matthew Wilcox <matthew@wil.cx>
cc: David Howells <dhowells@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Russell King <rmk@arm.linux.org.uk>, Ian Molton <spyro@f2s.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH 4/5] Centralise NO_IRQ definition
In-Reply-To: <20051121121454.GA1598@parisc-linux.org>
Message-ID: <Pine.LNX.4.64.0511211047260.13959@g5.osdl.org>
References: <E1Ee0G0-0004CN-Az@localhost.localdomain>
 <24299.1132571556@warthog.cambridge.redhat.com> <20051121121454.GA1598@parisc-linux.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 21 Nov 2005, Matthew Wilcox wrote:
>
> On Mon, Nov 21, 2005 at 11:12:36AM +0000, David Howells wrote:
> > Matthew Wilcox <matthew@wil.cx> wrote:
> > 
> > > +#define NO_IRQ			((unsigned int)(-1))
> > 
> > Should this be wrapped with #ifndef?
> 
> *sigh*.  The one piece of feedback I got on the last series was from
> Ingo, and he asked that I *not* wrap it with ifndef.  So, no.

Quite frankly, if we change [PCI_]NO_IRQ to -1, there's almost certainly 
going to be a lot of drivers breaking.

On x86, 0 has been the lack of IRQ since basically forever, in one form or 
another (for devices, that is - there _is_ a timer irq 0, but that's set 
up separately).

Which means that I'd _much_ prefer to other architectures to just follow 
suit.

So for an architecture where irq0 is a valid physical interrupt for a 
device, why not just translate that "real irq 0" into some other thing? 
Much less likely to break anything.

In fact, it could be as simple as setting the high bit for any valid 
interrupt, and then just masking it out in request_irq() and friends. Do 
something like

	#define PCI_IRQ_VALID_MASK	(1u << 31)

and then if the physical irq is 0, just or in that VALID mask, turning the 
interrupt into a non-zero, and then when registering it, just and it away 
again..

This is not theory: a _lot_ of real-life PCI devices very much think that 
irq 0 means "disabled". Not even just in drivers - in actual _hardware_. 
When you write 0 to the irq number for irq routers, they disable that 
line. So the "zero as NO_IRQ" is more than just a "several drivers think 
that is how it is", it's how a lot of hardware actually works.

		Linus

