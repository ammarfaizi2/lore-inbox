Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264001AbTAEIob>; Sun, 5 Jan 2003 03:44:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264010AbTAEIob>; Sun, 5 Jan 2003 03:44:31 -0500
Received: from smtp-out-4.wanadoo.fr ([193.252.19.23]:61907 "EHLO
	mel-rto4.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S264001AbTAEIoa>; Sun, 5 Jan 2003 03:44:30 -0500
Subject: Re: [RFC] irq handling code consolidation, second try (ppc part)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org, pazke@orbita1.ru, anton@samba.org
In-Reply-To: <Pine.LNX.4.44.0301040938480.5425-100000@home.transmeta.com>
References: <Pine.LNX.4.44.0301040938480.5425-100000@home.transmeta.com>
Content-Type: text/plain
Organization: 
Message-Id: <1041756963.645.43.camel@zion.wanadoo.fr>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0 
Date: 05 Jan 2003 09:56:03 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-01-04 at 18:41, Linus Torvalds wrote:
> On 4 Jan 2003, Benjamin Herrenschmidt wrote:
> > 
> > The "easy" way here to implement that is to make the irq_desc array larger than
> > NR_IRQs (or rather split NR_IRQs into NR_SYS_IRQS + NR_DYNAMIC_IRQS). The
> > additional "slots" could then easily be allocated/freed. Thus, keeping my
> > cardbus example, the cardbus driver can allocate a couple of slots (that is IRQ
> >  numbers) dynamically, and use it's own startup/shutdown/enable/disable/...
> > hooks for them, dealing itself with the cascade from the PCI irq.
> 
> Linearizing a space like this is always a bad idea, I think. 

I fully agree, I was just proposing a "simple" solution that would fit
in a feature-frozen kernel ;)

Note that if we go the full way abstracting interrupts, then the
interrupt "tree" should be separate from the device tree. The interrupt
"parent" of a device may not be (and is not in a whole lot of cases I
have to deal with on pmacs and embedded) the "bus" parent of a given
device.

I suppose there may be similar "issues" with x86 PCI chips routed to
legacy irqs, but then, I'm completely unfamiliar with the story of
interrupt routing on x86's...

on pmacs, all interrupts end up in a single interrupt controller located
in a "combo" ASIC along with other devices. This ASIC is a PCI device,
but is really the root of the interrupt tree just below the CPU itself,
regardless of the actual interrupt sources beeing located on other PCI
busses or not. On embedded, the design can be as funky as a HW designer
can imagine...

Do you think this is still 2.5 work ?

> It would be entirely possible to just add the irq routing information to 
> the "struct device" tree, and have a "dev_request_irq(dev, ...)", along 
> with a few helper functions like "pci_request_irq(pci_dev, ...)".
> 
> And the old "request_irq()" would just use the system root device as the 
> device.
> 
> 		Linus
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
-- 
Benjamin Herrenschmidt <benh@kernel.crashing.org>

