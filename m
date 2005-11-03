Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030371AbVKCQUl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030371AbVKCQUl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 11:20:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030372AbVKCQUk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 11:20:40 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:31972 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1030371AbVKCQUj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 11:20:39 -0500
Date: Thu, 3 Nov 2005 17:20:59 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Matthew Wilcox <matthew@wil.cx>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: First steps towards making NO_IRQ a generic concept
Message-ID: <20051103162059.GA495@elte.hu>
References: <20051103144926.GV23749@parisc-linux.org> <20051103145118.GW23749@parisc-linux.org> <20051103154439.GA28190@elte.hu> <20051103160252.GA23749@parisc-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051103160252.GA23749@parisc-linux.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.4
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Matthew Wilcox <matthew@wil.cx> wrote:

> On Thu, Nov 03, 2005 at 04:44:39PM +0100, Ingo Molnar wrote:
> > > +	if (irq >= NR_IRQS)
> > > +		return;
> > 
> > hm, why not start with the -1 value for PCI_NO_IRQ, instead of 0:
> > 
> > > +#define PCI_NO_IRQ             0
> > 
> > and be done with it.
> 
> There's a number of drivers which check "if (!irq) ...".  For example:
> 
> drivers/net/3c523.c:            if ((irq && irq != dev->irq) || 
> drivers/net/atarilance.c:               if (!irq) {
> drivers/net/cs89x0.c:           if (!dev->irq)
> drivers/net/depca.c:                    if (!dev->irq) {
> drivers/net/eexpress.c: if (!dev->irq || !irqrmap[dev->irq])
> drivers/net/ewrk3.c:                            if (!dev->irq) {
> drivers/net/ibmlana.c:          return (base != 0 || irq != 0) ? -ENXIO
> : -ENODE
> drivers/net/lasi_82596.c:       if (!dev->irq) {
> drivers/net/ne-h8300.c: if (! dev->irq) {
> drivers/net/ne.c:       if (! dev->irq) {
> drivers/net/ni52.c:             if(!dev->irq)
> drivers/net/ni65.c:                     if(!dev->irq)
> drivers/net/pcnet32.c:  if (!dev->irq) {
> 
> ... and that's just drivers/net, and that doesn't include other ways
> for checking if irq is not 0, and doesn't include irqs referred to
> under different names not including the string 'irq'.  Against that,
> I know not all of these are PCI drivers.  So we need to spend some time
> checking drivers for this assumption.
> 
> We also need to figure out what to do with non-PCI drivers.  Some of 
> them need more work than others to work with a -1 NO_IRQ.  There's 
> also plenty of janitorial work with people misusing the 
> probe_irq_off() interface.

ok, understood. I'm wondering, why is there any need to do a PCI_NO_IRQ?  
Why not just a generic NO_IRQ. It's not like we can or want to make them 
different in the future. The interrupt vector number is a generic thing 
that attaches to the platform via request_irq() - there is nothing 'PCI' 
about it. So the PCI layer shouldnt pretend it has its own IRQ 
abstraction - the two are forcibly joined. The same goes for 
pci_valid_irq() - we should only have valid_irq(). Am i missing 
anything?

> > plus, shouldnt this go into -mm first, since it clearly affects some 
> > drivers? Why into Linus' tree immediately?
> 
> With the way I'm staging it, it shouldn't affect drivers.  The only 
> exception was the pcmcia driver that defined its own NO_IRQ macro.  So 
> I converted that one to the new preferred way to check the irq is 
> unset.

ok. Your transition path looks safe to me.

	Ingo
