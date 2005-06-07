Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261983AbVFGVDK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261983AbVFGVDK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Jun 2005 17:03:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261972AbVFGVDK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Jun 2005 17:03:10 -0400
Received: from cpe-24-93-172-51.neo.res.rr.com ([24.93.172.51]:23685 "EHLO
	neo.rr.com") by vger.kernel.org with ESMTP id S261983AbVFGVBx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Jun 2005 17:01:53 -0400
Date: Tue, 7 Jun 2005 16:58:00 -0400
From: Adam Belay <ambx1@neo.rr.com>
To: Karsten Keil <kkeil@suse.de>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Jeff Garzik <jgarzik@pobox.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fix tulip suspend/resume
Message-ID: <20050607205800.GB8300@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>,
	Karsten Keil <kkeil@suse.de>, Linus Torvalds <torvalds@osdl.org>,
	Andrew Morton <akpm@osdl.org>, Jeff Garzik <jgarzik@pobox.com>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20050606224645.GA23989@pingi3.kke.suse.de> <Pine.LNX.4.58.0506061702430.1876@ppc970.osdl.org> <20050607025054.GC3289@neo.rr.com> <20050607105552.GA27496@pingi3.kke.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050607105552.GA27496@pingi3.kke.suse.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 07, 2005 at 12:55:52PM +0200, Karsten Keil wrote:
> On Mon, Jun 06, 2005 at 10:50:55PM -0400, Adam Belay wrote:
> > On Mon, Jun 06, 2005 at 05:04:07PM -0700, Linus Torvalds wrote:
> > > 
> > > Jeff, 
> > >  this looks ok, but I'll leave the decision to you. Things like this often 
> > > break.
> > > 
> > > Andrew, maybe at least a few days in -mm to see if there's some outcry?
> > > 
> > > 		Linus
> > 
> > This patch is an improvement, but there may still be some issues.
> > Specifically, it looks to me like the the interrupt handler remains
> > registered.  This could cause some problems when another device is sharing
> > the interrupt because the tulip driver must read from a hardware register
> > to determine if it triggered the interrupt. When the hardware has been
> > physically powered off, things might not go well.
> 
> No, I also looked into this, it is not needed for the tulip driver, it
> detects that it has no access to the hardware (reading 0xffffffff) in the
> interrupt functions.

Hmm, doesn't look like it:

>	/* Let's see whether the interrupt really is for us */
>	csr5 = ioread32(ioaddr + CSR5);
>
>	if (tp->flags & HAS_PHY_IRQ) 
>	        handled = phy_interrupt (dev);
>    
>	if ((csr5 & (NormalIntr|AbnormalIntr)) == 0)
>		return IRQ_RETVAL(handled);

Upon reading the value 0xffffffff for csr5, the if statement would be false.
Maybe it bails out later or something, but really why risk it?  As Ben noted,
it's easy to have race conditions between power off and interrupt handler
routines.  Also, there is a transition delay between D0 and D3.  I prefer to
play it safe and call free_irq().

There are other reasons to use free_irq().  For example, if we want to
support runtime device suspends, leaving a stale interrupt handler may
subtract from the performance of other devices sharing that interrupt...
especially in this case, where it's making pci transactions and reading
back 0xffffffff.

> > 
> > I can't comment on the netdev class aspect of this routine, but following
> > a similar strategy to its original author, a fix might look like this:
> > 
> > --- a/drivers/net/tulip/tulip_core.c	2005-05-27 22:06:00.000000000 -0400
> > +++ b/drivers/net/tulip/tulip_core.c	2005-06-06 22:14:25.850846400 -0400
> > @@ -1759,7 +1759,12 @@
> >  	if (dev && netif_running (dev) && netif_device_present (dev)) {
> >  		netif_device_detach (dev);
> >  		tulip_down (dev);
> > -		/* pci_power_off(pdev, -1); */
> > +
> > +		pci_save_state(pdev);
> > +
> > +		free_irq(dev->irq, dev);
> > +		pci_disable_device(pdev);
> > +		pci_set_power_state(pdev, pci_choose_state(pdev, state));
> >  	}
> >  	return 0;
> >  }
> 
> Pavel told me, that pci_choose_state is not always safe, some cards maybe
> do only work with PCI_D3hot properly, so it's better to use this now.
> For my hardware it also seems to work with pci_choose_state.

I think it's ok.

pci_power_t pci_choose_state(struct pci_dev *dev, pm_message_t state)
{
	if (!pci_find_capability(dev, PCI_CAP_ID_PM))
		return PCI_D0;

	switch (state) {
	case 0: return PCI_D0;
	case 3: return PCI_D3hot;
	default:
		printk("They asked me for state %d\n", state);
		BUG();
	}
	return PCI_D0;
}

It just checks if PCI function supports the power management capability.  If
it does we go to D3hot, if not, we stay at D0.  So the only case where it
wouldn't go to D3hot is when the device can't physically make the transition
through the PCI PM mechanism.

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
> > +		pci_restore_state(pdev);
> > +
> 
> I think restoring the PCI config should be done always, not only if the
> device was in the up state, also powerup should be done.
> If not you will run into problems to use the device later.

Yeah, I think you're right.

Also, after looking at some other netdev suspend routines, it appears that
"netif_device_present" isn't necessary.  Jeff, is this correct?

Thanks,
Adam


How does this patch look:

--- a/drivers/net/tulip/tulip_core.c	2005-05-27 22:06:00.000000000 -0400
+++ b/drivers/net/tulip/tulip_core.c	2005-06-07 16:34:13.641177456 -0400
@@ -1756,11 +1756,19 @@
 {
 	struct net_device *dev = pci_get_drvdata(pdev);
 
-	if (dev && netif_running (dev) && netif_device_present (dev)) {
-		netif_device_detach (dev);
-		tulip_down (dev);
-		/* pci_power_off(pdev, -1); */
-	}
+	if (!dev)
+		return -EINVAL;
+
+	if (netif_running(dev))
+		tulip_down(dev);
+
+	netif_device_detach(dev);
+	pci_save_state(pdev);
+
+	free_irq(dev->irq, dev);
+	pci_disable_device(pdev);
+	pci_set_power_state(pdev, pci_choose_state(pdev, state));
+
 	return 0;
 }
 
@@ -1768,15 +1776,26 @@
 static int tulip_resume(struct pci_dev *pdev)
 {
 	struct net_device *dev = pci_get_drvdata(pdev);
+	int retval;
 
-	if (dev && netif_running (dev) && !netif_device_present (dev)) {
-#if 1
-		pci_enable_device (pdev);
-#endif
-		/* pci_power_on(pdev); */
-		tulip_up (dev);
-		netif_device_attach (dev);
+	if (!dev)
+		return -EINVAL;
+
+	pci_set_power_state(pdev, PCI_D0);
+	pci_restore_state(pdev);
+
+	pci_enable_device(pdev);
+
+	if ((retval = request_irq(dev->irq, &tulip_interrupt, SA_SHIRQ, dev->name, dev))) {
+		printk (KERN_ERR "tulip: request_irq failed in resume\n");
+		return retval;
 	}
+
+	netif_device_attach(dev);
+
+	if (netif_running(dev))
+		tulip_up(dev);
+
 	return 0;
 }
 
