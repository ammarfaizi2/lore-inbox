Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030365AbVKCQC4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030365AbVKCQC4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 11:02:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030368AbVKCQC4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 11:02:56 -0500
Received: from palinux.external.hp.com ([192.25.206.14]:58080 "EHLO
	palinux.hppa") by vger.kernel.org with ESMTP id S1030365AbVKCQCz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 11:02:55 -0500
Date: Thu, 3 Nov 2005 09:02:52 -0700
From: Matthew Wilcox <matthew@wil.cx>
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: First steps towards making NO_IRQ a generic concept
Message-ID: <20051103160252.GA23749@parisc-linux.org>
References: <20051103144926.GV23749@parisc-linux.org> <20051103145118.GW23749@parisc-linux.org> <20051103154439.GA28190@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051103154439.GA28190@elte.hu>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 03, 2005 at 04:44:39PM +0100, Ingo Molnar wrote:
> > +	if (irq >= NR_IRQS)
> > +		return;
> 
> hm, why not start with the -1 value for PCI_NO_IRQ, instead of 0:
> 
> > +#define PCI_NO_IRQ             0
> 
> and be done with it.

There's a number of drivers which check "if (!irq) ...".  For example:

drivers/net/3c523.c:            if ((irq && irq != dev->irq) || 
drivers/net/atarilance.c:               if (!irq) {
drivers/net/cs89x0.c:           if (!dev->irq)
drivers/net/depca.c:                    if (!dev->irq) {
drivers/net/eexpress.c: if (!dev->irq || !irqrmap[dev->irq])
drivers/net/ewrk3.c:                            if (!dev->irq) {
drivers/net/ibmlana.c:          return (base != 0 || irq != 0) ? -ENXIO
: -ENODE
drivers/net/lasi_82596.c:       if (!dev->irq) {
drivers/net/ne-h8300.c: if (! dev->irq) {
drivers/net/ne.c:       if (! dev->irq) {
drivers/net/ni52.c:             if(!dev->irq)
drivers/net/ni65.c:                     if(!dev->irq)
drivers/net/pcnet32.c:  if (!dev->irq) {

... and that's just drivers/net, and that doesn't include other ways
for checking if irq is not 0, and doesn't include irqs referred to
under different names not including the string 'irq'.  Against that,
I know not all of these are PCI drivers.  So we need to spend some time
checking drivers for this assumption.

We also need to figure out what to do with non-PCI drivers.  Some of
them need more work than others to work with a -1 NO_IRQ.  There's also
plenty of janitorial work with people misusing the probe_irq_off()
interface.

> > - Move the definition of NO_IRQ from asm directories to 
> >   <linux/hardirq.h>. Individual architectures can still override it if 
> >   they want to, but all existing definitions were -1.
> 
> we shouldnt make it overridable just for the sake of it. If all arches 
> were fine with -1, it should be the generic value and there's no 
> override.

Fine with me.  I can take out the ifndef.

> plus, shouldnt this go into -mm first, since it clearly affects some 
> drivers? Why into Linus' tree immediately?

With the way I'm staging it, it shouldn't affect drivers.  The only
exception was the pcmcia driver that defined its own NO_IRQ macro.  So I
converted that one to the new preferred way to check the irq is unset.
