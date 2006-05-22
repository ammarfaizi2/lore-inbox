Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750919AbWEVPHX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750919AbWEVPHX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 11:07:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750920AbWEVPHW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 11:07:22 -0400
Received: from smtp.osdl.org ([65.172.181.4]:12995 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750919AbWEVPHW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 11:07:22 -0400
Date: Mon, 22 May 2006 08:06:51 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Rogier Wolff <R.E.Wolff@BitWizard.nl>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Russell King <rmk+lkml@arm.linux.org.uk>, Andrew Morton <akpm@osdl.org>,
       Andreas Mohr <andi@rhlx01.fht-esslingen.de>, florin@iucha.net,
       linux-kernel@vger.kernel.org, linux@dominikbrodowski.net
Subject: Re: pcmcia oops on 2.6.17-rc[12]
In-Reply-To: <20060522115046.GA23074@bitwizard.nl>
Message-ID: <Pine.LNX.4.64.0605220751380.3697@g5.osdl.org>
References: <20060423192251.GD8896@iucha.net> <20060423150206.546b7483.akpm@osdl.org>
 <20060508145609.GA3983@rhlx01.fht-esslingen.de> <20060508084301.5025b25d.akpm@osdl.org>
 <20060508163453.GB19040@flint.arm.linux.org.uk> <1147730828.26686.165.camel@localhost.localdomain>
 <Pine.LNX.4.64.0605151459140.3866@g5.osdl.org> <1147734026.26686.200.camel@localhost.localdomain>
 <20060522115046.GA23074@bitwizard.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 22 May 2006, Rogier Wolff wrote:
> 
> The question I'm stuck with is: When is it valid to ask for a non-shared
> IRQ, and get back a shared one. 
> 
> Drivers that know that they don't work well if they are called by the
> "other" interrupt?

No.

For example, on certain 16-bit PCMCIA setups, the PCMCIA controller may 
have just one interrupt. It may even have that interrupt exclusively, but 
the point is, it has _one_. One interrupt shared for both doing not just 
card interrupts, but also for PCMCIA CSC interrupts.

In that situation, once the card has been inserted (and powerup etc has 
happened), the only interrupts you'll get is actually the interrupts for 
the card. So everything is fine.

BUT A PCMCIA DRIVER STILL MUST NOT ASK FOR A NON-SHARED IRQ.

Because the irq will still be registered by the PCMCIA layer, and the 
PCMCIA layer will check whether the interrupt was due to a CSC when the 
card was removed, for example.

So there's basically never any valid reason to ask for a nonshared irq.

> I happen to know (ISA) hardware that CANNOT share an interrupt

Not necessarily true, since ISA cards have been known to be able to share 
an interrupt with the proper pull-down resistors. It was even common for 
serial cards.

Perhaps more importantly, not relevant for PCMCIA.  There is no PCMCIA 
hardware that cannot share an interrupt, for reasons outlines above.

There might be really bad hardware that doesn't even have an interrupt 
status register so you can't tell if an interrupt happened from that card 
or not, making it hard to write a driver that can handle "spurious" 
interrupts (in the case of real sharing), but that sounds pretty damn 
unlikely.

		Linus
