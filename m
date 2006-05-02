Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932365AbWEBFLM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932365AbWEBFLM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 01:11:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932366AbWEBFLM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 01:11:12 -0400
Received: from mx1.suse.de ([195.135.220.2]:52686 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932365AbWEBFLL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 01:11:11 -0400
From: Neil Brown <neilb@suse.de>
To: Linus Torvalds <torvalds@osdl.org>
Date: Tue, 2 May 2006 15:10:50 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17494.59866.493671.504666@cse.unsw.edu.au>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Stephen Hemminger <shemminger@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: better leve triggered IRQ management needed
In-Reply-To: message from Linus Torvalds on Saturday April 29
References: <20060424114105.113eecac@localhost.localdomain>
	<1146345911.3302.36.camel@localhost.localdomain>
	<Pine.LNX.4.64.0604291453220.3701@g5.osdl.org>
	<17492.16811.469245.331326@cse.unsw.edu.au>
	<Pine.LNX.4.64.0604292204270.4616@g5.osdl.org>
	<17492.21870.649828.686244@cse.unsw.edu.au>
	<Pine.LNX.4.64.0604292343020.3690@g5.osdl.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday April 29, torvalds@osdl.org wrote:
> 
> That said, I'm surprised that the kernel doesn't set ELCR for you. If it 
> sees a PCI device, it really should know that it's a PCI interrupt. I 
> wonder if we should do the following.. (Does this automatically make it do 
> the right thing on your machine?)
> 
> 			Linus
> 
> ---
> diff --git a/arch/i386/pci/irq.c b/arch/i386/pci/irq.c
> index 7323544..6e3eaef 100644
> --- a/arch/i386/pci/irq.c
> +++ b/arch/i386/pci/irq.c
> @@ -881,6 +881,7 @@ static int pcibios_lookup_irq(struct pci
>  	((!(pci_probe & PCI_USE_PIRQ_MASK)) || ((1 << irq) & mask)) ) {
>  		DBG(" -> got IRQ %d\n", irq);
>  		msg = "Found";
> +		eisa_set_level_irq(newirq);
>  	} else if (newirq && r->set && (dev->class >> 8) != PCI_CLASS_DISPLAY_VGA) {
>  		DBG(" -> assigning IRQ %d", newirq);
>  		if (r->set(pirq_router_dev, dev, pirq, newirq)) {
> -

Yes, this helps.  It sets the offending IRQ to be level triggered, so
the wireless card works nicely.

My only concern is that dmesg contains:

[354446.223241] PCI: Using IRQ router PIIX/ICH [8086/7110] at 0000:00:07.0
[354446.223302] PCI: IRQ 0 for device 0000:00:04.0 doesn't match PIRQ mask - try
 pci=usepirqmask
[354446.223363] PCI: setting IRQ 0 as level-triggered
[354446.223401] PCI: Found IRQ 10 for device 0000:00:04.0
[354446.223446] PCI: Sharing IRQ 10 with 0000:00:04.1


Setting IRQ 0 to level-triggered doesn't seem healthy as it is the
timer interrupt.

It definitely gets IRQ 10 (the problematic one - 0:04 is the PCMCIA
controller) and IRQ 11 (which was already level-triggered).
e.g.


[354446.228016] PCI: setting IRQ 10 as level-triggered
[354446.228060] PCI: Found IRQ 10 for device 0000:00:04.0
[354446.228140] PCI: Sharing IRQ 10 with 0000:00:04.1
[354446.228218] PCI: Found IRQ 10 for device 0000:00:04.1
[354446.228268] PCI: Sharing IRQ 10 with 0000:00:04.0

A subsequent printout of the ELCR show the two bytes to be
 00 and 0c

representing IRQ10 and IRQ11 - so it seems the setting of IRQ-0 to
level triggered didn't have a lasting effect.

Maybe the eisa_set_level_irq should be passed 'irq' rather than
'newirq' ??

NeilBrown
