Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266842AbTADMub>; Sat, 4 Jan 2003 07:50:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266848AbTADMub>; Sat, 4 Jan 2003 07:50:31 -0500
Received: from smtp-out-2.wanadoo.fr ([193.252.19.254]:1773 "EHLO
	mel-rto2.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S266842AbTADMua>; Sat, 4 Jan 2003 07:50:30 -0500
Subject: Re: [RFC] irq handling code consolidation, second try (ppc part)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrey Panin <pazke@orbita1.ru>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
In-Reply-To: <20030104115910.GF10477@pazke>
References: <20030104115910.GF10477@pazke>
Content-Type: text/plain
Organization: 
Message-Id: <1041685293.641.17.camel@zion.wanadoo.fr>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0 
Date: 04 Jan 2003 14:01:33 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-01-04 at 12:59, Andrey Panin wrote:
> Hi all, 
> 
> attached patch is a second try of IRQ handling code consolidation.
> This is a ppc specific patch (compiled successfuly).
> 
> Beware, this patch removes some old(?) and crappy code:
> 	- irq_kmalloc(), irq_kfree() removed. If ppc need to register
> 	  irqs early, it should use setup_irq() as all decent people do :))
> 	- request_irq() with NULL handler argument == free_irq(), does
> 	  anyone use this kludge ?
> 

After a quick look, things look fine some of this old PPC crap should indeed
be killed now.

There's something else I would like to implement one of these days, and your
consolidation work makes it easier (except for archs that won't use it...).
Basically, I want some (few and rare enough though) drivers to be able
to define interrupt controllers and thus create their own IRQs.

The typical example for which I need that is cardbus. I need the cardbus
controller on PCI to be seen as a real cascaded controller, that is I want
devices below it (either PCI or PCMCIA) calls to request/free/enable/disable_irq
for their to be caught by the cardbus driver.
This is the only sane way to properly enable/disable bridging of the
interrupt upon request from the driver. Without that, I still can frequent
lockups with various pcmcia cards when inserted/removed due to IRQ line
beeing stuck down on slot shutdown or other crappy things happening
typically with legacy PCMCIA stuffs (ATA is a good example of crappy behaviour).

The "easy" way here to implement that is to make the irq_desc array larger than
NR_IRQs (or rather split NR_IRQs into NR_SYS_IRQS + NR_DYNAMIC_IRQS). The
additional "slots" could then easily be allocated/freed. Thus, keeping my
cardbus example, the cardbus driver can allocate a couple of slots (that is IRQ
 numbers) dynamically, and use it's own startup/shutdown/enable/disable/...
hooks for them, dealing itself with the cascade from the PCI irq. (Of course,
this is not for systems using cardbus routed to legacy IRQs, but for systems
like PPC where the PCI irq is mux'ing both the device IRQs and the controller
own IRQ).

Ben.


