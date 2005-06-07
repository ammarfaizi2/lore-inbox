Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261206AbVFGEB6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261206AbVFGEB6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Jun 2005 00:01:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261228AbVFGEB6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Jun 2005 00:01:58 -0400
Received: from peabody.ximian.com ([130.57.169.10]:29357 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S261206AbVFGEBx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Jun 2005 00:01:53 -0400
Subject: Re: [PATCH] fix tulip suspend/resume
From: Adam Belay <abelay@novell.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Karsten Keil <kkeil@suse.de>,
       Andrew Morton <akpm@osdl.org>, Jeff Garzik <jgarzik@pobox.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1118115278.6850.48.camel@gaston>
References: <20050606224645.GA23989@pingi3.kke.suse.de>
	 <Pine.LNX.4.58.0506061702430.1876@ppc970.osdl.org>
	 <20050607025054.GC3289@neo.rr.com>  <1118115278.6850.48.camel@gaston>
Content-Type: text/plain
Date: Mon, 06 Jun 2005 23:58:01 -0400
Message-Id: <1118116682.3245.45.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-06-07 at 13:34 +1000, Benjamin Herrenschmidt wrote:
> > This patch is an improvement, but there may still be some issues.
> > Specifically, it looks to me like the the interrupt handler remains
> > registered.  This could cause some problems when another device is sharing
> > the interrupt because the tulip driver must read from a hardware register
> > to determine if it triggered the interrupt. When the hardware has been
> > physically powered off, things might not go well.
> > 
> > I can't comment on the netdev class aspect of this routine, but following
> > a similar strategy to its original author, a fix might look like this:
> 
> Don't like it, see below.
> 
> > @@ -1768,12 +1773,19 @@
> >  static int tulip_resume(struct pci_dev *pdev)
> >  {
> >  	struct net_device *dev = pci_get_drvdata(pdev);
> > +	int retval;
> >  
> >  	if (dev && netif_running (dev) && !netif_device_present (dev)) {
> > -#if 1
> > -		pci_enable_device (pdev);
> > -#endif
> > -		/* pci_power_on(pdev); */
> > +		pci_set_power_state(pdev, PCI_D0);
> 
> Oh well... you are turning power back on ... but you don't know if you
> _can_ ... what if your parent bridge has been disabled in some way ? Or
> the clock generation on the bus stopped already ?

We don't support PCI bus power management, so we don't have any idea
what the parent is doing.  Also, we don't have a pci bridge driver (one
that uses "struct pci_driver" to handle bridge resumes properly.  I'm
working on these issues.  I also have some changes in mind for the PM
model to make it more friendly to the power dependency problem.  So in
short, I think this is fine for now, as every other driver is doing it
incorrectly, and in general it is working ok for suspend and resume.
They're all broken in this respect, and we need to gradually fix them.
But first we need the infrastructure to make this possible.

I haven't decided yet, but we could probably hide much of this inside
pci_set_power_state().

> 
> I think the kernel should warn & disable the IRQ if that happens
> (basically you should return NOT_HANDLED)
> 
> > +		pci_restore_state(pdev);
> > +
> > +		pci_enable_device(pdev);
> > +
> > +		if ((retval = request_irq(dev->irq, &tulip_interrupt, SA_SHIRQ, dev->name, dev))) {
> > +			printk (KERN_ERR "tulip: request_irq failed in resume\n");
> > +			return retval;
> > +		}
> > +		
> >  		tulip_up (dev);
> >  		netif_device_attach (dev);
> >  	}
> 
> Also, isn't that racy vs. the code in suspend() anyway ? You need to
> make sure you program your chip not to issue any interrupt and
> synchronize proerly, then just "ignore" (don't handle) interrupts coming
> in as they should not be for you.

Yeah, that's exactly what I had in mind.  As I understand, tulip_down
does tells the chip not to issue interrupts.  Then we unregister the
interrupt handler before powering down the device to avoid any issues
with shared interrupts.  The best way of ignoring interrupts is to
unregister the handler.  Do you still see a race condition?

Thanks,
Adam


