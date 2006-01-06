Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752188AbWAFAhU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752188AbWAFAhU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 19:37:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752276AbWAFAhT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 19:37:19 -0500
Received: from smtp.osdl.org ([65.172.181.4]:136 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1752188AbWAFAhR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 19:37:17 -0500
Date: Thu, 5 Jan 2006 16:36:53 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Andrew Morton <akpm@osdl.org>
cc: Etienne Lorrain <etienne_lorrain@yahoo.fr>, linux-kernel@vger.kernel.org,
       Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Greg KH <greg@kroah.com>,
       David Woodhouse <dwmw2@infradead.org>, Dave Airlie <airlied@linux.ie>
Subject: Re: Re. 2.6.15-mm1
In-Reply-To: <20060105161514.19a4b36b.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0601051631190.3169@g5.osdl.org>
References: <20060105233131.25101.qmail@web26902.mail.ukl.yahoo.com>
 <20060105161514.19a4b36b.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 5 Jan 2006, Andrew Morton wrote:
> > 
> >  The only other strange thing is:
> > Jan  5 22:39:29 localhost kernel: PCI: Using IRQ router VIA [1106/3177] at
> > 0000:00:11.0
> > Jan  5 22:39:29 localhost kernel:
> > Jan  5 22:39:29 localhost kernel: PCI: IRQ 0 for device 0000:00:06.0 doesn't
> > match PIRQ mask - try pci=usepirqmask
> > Jan  5 22:39:29 localhost kernel: PCI: Sharing IRQ 5 with 0000:00:10.1
> > Jan  5 22:39:29 localhost kernel:
> > Jan  5 22:39:29 localhost kernel: PCI: IRQ 0 for device 0000:00:11.1 doesn't
> > match PIRQ mask - try pci=usepirqmask
> >  but it is not new with -mm1.
> 
> hm.  That warning was added by a john@deater.net four years ago.  Various
> PCI people cc'ed for suggestions, please.

That warning is totally bogus. It shouldn't be printed out at all when 
"newirq" is 0 (as in this case). 

Even for a non-zero newirq, I suspect that 99% of the time, 
"pci=usepirqmask" would end up causing more problems than it could ever 
solve.

But this diff would seem to be the minimal fix.

The other problems _look_ like they are -mm related, not in plain 2.6.15. 
Etienne, can you confirm?

			Linus
---
diff --git a/arch/i386/pci/irq.c b/arch/i386/pci/irq.c
index 19e6f48..ee8e016 100644
--- a/arch/i386/pci/irq.c
+++ b/arch/i386/pci/irq.c
@@ -846,7 +846,7 @@ static int pcibios_lookup_irq(struct pci
 	 * reported by the device if possible.
 	 */
 	newirq = dev->irq;
-	if (!((1 << newirq) & mask)) {
+	if (newirq && !((1 << newirq) & mask)) {
 		if ( pci_probe & PCI_USE_PIRQ_MASK) newirq = 0;
 		else printk(KERN_WARNING "PCI: IRQ %i for device %s doesn't match PIRQ mask - try pci=usepirqmask\n", newirq, pci_name(dev));
 	}
