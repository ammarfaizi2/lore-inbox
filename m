Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135256AbREBTaD>; Wed, 2 May 2001 15:30:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135497AbREBT3x>; Wed, 2 May 2001 15:29:53 -0400
Received: from smtp-rt-6.wanadoo.fr ([193.252.19.160]:10230 "EHLO
	caroubier.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S135256AbREBT3r>; Wed, 2 May 2001 15:29:47 -0400
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: <paulus@samba.org>, <linux-kernel@vger.kernel.org>
Subject: Re: isa_read/write not available on ppc - solution suggestions ??
Date: Wed, 2 May 2001 21:28:40 +0200
Message-Id: <20010502192840.23233@smtp.wanadoo.fr>
In-Reply-To: <15087.23739.557487.505172@argo.ozlabs.ibm.com.au>
In-Reply-To: <15087.23739.557487.505172@argo.ozlabs.ibm.com.au>
X-Mailer: CTM PowerMail 3.0.8 <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> I would suggest the opposite approach instead: make the PPC just support
>> isa_readx/isa_writex instead.
>
>We can certainly do that, no problem.
>
>BUT that won't get a token ring pcmcia card working in the newer
>powerbooks, such as the titanium G4 powerbook, because the PCI host
>bridge doesn't map any cpu addresses to the bottom 16MB of PCI memory
>space.  This is not a problem as far as pcmcia cards are concerned -
>the pcmcia stuff just picks an appropriate address (typically in the
>range 0x90000000 - 0x9fffffff) and sets the pcmcia/cardbus bridge to
>map that to the card.  But it means that the physical addresses for
>the card's memory space will be above the 16MB point, so it is
>essential to do the ioremap.

What about isa_ioremap ? Result from it is a token passed to
isa_readx/isa_writex and the arch side can be implemented with a
couple of #defines on x86. 

It's easy to change I beleive, and it paves the way for archs to
add a notion of "token" in the high bits (as we _know_ an ISA address
is small). Those token can be used by arch to route to proper PCI
bus when several host bridges exist, to route to PCMCIA when the
PCMCIA uses it's own "ISA" memory space like on PPC, etc...

Later on, we can see things like

ulong pci_get_bus_isa_base(int busno);

And the same for PCMCIA & whatever 16 bits busses that can exist on
embedded hardware.

That way, support for multiple busses (either real ISA, embedded custom
busses using legacy devices, several PCI hosts with ISA bridges, ...)
can be implemented very easily. In most case adjusting the drivers
probe code.

I'd like to see the same kind of things for IOs in fact but that's
another debate ;)

Regards,
Ben.

