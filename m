Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750996AbWD3G7V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750996AbWD3G7V (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Apr 2006 02:59:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751000AbWD3G7V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Apr 2006 02:59:21 -0400
Received: from smtp.osdl.org ([65.172.181.4]:29846 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750996AbWD3G7U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Apr 2006 02:59:20 -0400
Date: Sat, 29 Apr 2006 23:59:13 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Neil Brown <neilb@suse.de>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Stephen Hemminger <shemminger@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: better leve triggered IRQ management needed
In-Reply-To: <17492.21870.649828.686244@cse.unsw.edu.au>
Message-ID: <Pine.LNX.4.64.0604292343020.3690@g5.osdl.org>
References: <20060424114105.113eecac@localhost.localdomain>
 <1146345911.3302.36.camel@localhost.localdomain> <Pine.LNX.4.64.0604291453220.3701@g5.osdl.org>
 <17492.16811.469245.331326@cse.unsw.edu.au> <Pine.LNX.4.64.0604292204270.4616@g5.osdl.org>
 <17492.21870.649828.686244@cse.unsw.edu.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 30 Apr 2006, Neil Brown wrote:
> 
> The thing is: This is exactly what I am currently doing to solve the
> problem.

I'm not entirely surprised. As mentioned, the ELCR register _originally_ 
selected between EISA (level) and ISA (edge) interrupts.

But EISA (and later PCI) interrupts were not just level, they were level 
active _low_. While old ISA interrupts are edge-triggered, active _high_.

Which explains why it not only changes the trigger, but also the polarity.

Now, fast-forward a decade or two, and imagine that the world is 99% PCI, 
and nobody really has any devices that are _electrically_ ISA any more, 
but there are some legacy stuff that _looks_ like ISA. What would you do 
to simplify your life from a hw perspective?

I suspect that the thing to do is to internally just say that all 
interrupts are active low. There's no reason to _really_ have active high, 
because there are no real devices left that drive the irq line that way. 

Now, the _sane_ thing to do would be to also make all interrupts be 
level-triggered, and make the whole ELCR register be a total dummy 
register. But you can't really do that without being worried about 
breaking compatibility (for example, the timer interrupt is a 50% 
duty-cycle on/off thing, so it really _does_ end up being edge-triggered). 

So you leave the ELCR register mattering for a edge/level thing, but the 
polarity issue is just gone.

But then on _other_ southbridges, you'll have the old behaviour, and there 
simply is no way for the OS to know. Yeah, we could look at the 
nortbridge and southbridge combination, and perhaps know that some of them 
always have a "active low" polarity regardless of ELCR. But nobody even 
_documents_ these things, exactly because it's not supposed to matter.

So we're kind of screwed. We have to _act_ as if we still lived in the 
middle ages, and people still used edge-triggered active-high interrupts. 
Even when it's not necessarily the case any more..

Gaah.

That said, I'm surprised that the kernel doesn't set ELCR for you. If it 
sees a PCI device, it really should know that it's a PCI interrupt. I 
wonder if we should do the following.. (Does this automatically make it do 
the right thing on your machine?)

			Linus

---
diff --git a/arch/i386/pci/irq.c b/arch/i386/pci/irq.c
index 7323544..6e3eaef 100644
--- a/arch/i386/pci/irq.c
+++ b/arch/i386/pci/irq.c
@@ -881,6 +881,7 @@ static int pcibios_lookup_irq(struct pci
 	((!(pci_probe & PCI_USE_PIRQ_MASK)) || ((1 << irq) & mask)) ) {
 		DBG(" -> got IRQ %d\n", irq);
 		msg = "Found";
+		eisa_set_level_irq(newirq);
 	} else if (newirq && r->set && (dev->class >> 8) != PCI_CLASS_DISPLAY_VGA) {
 		DBG(" -> assigning IRQ %d", newirq);
 		if (r->set(pirq_router_dev, dev, pirq, newirq)) {
