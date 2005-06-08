Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262120AbVFHGkE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262120AbVFHGkE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 02:40:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262121AbVFHGkD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 02:40:03 -0400
Received: from mx2.suse.de ([195.135.220.15]:21703 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S262120AbVFHGjn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 02:39:43 -0400
Date: Wed, 8 Jun 2005 08:39:40 +0200
From: Karsten Keil <kkeil@suse.de>
To: Adam Belay <ambx1@neo.rr.com>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Jeff Garzik <jgarzik@pobox.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fix tulip suspend/resume
Message-ID: <20050608063940.GA31237@pingi3.kke.suse.de>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>,
	Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
	Jeff Garzik <jgarzik@pobox.com>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20050606224645.GA23989@pingi3.kke.suse.de> <Pine.LNX.4.58.0506061702430.1876@ppc970.osdl.org> <20050607025054.GC3289@neo.rr.com> <20050607105552.GA27496@pingi3.kke.suse.de> <20050607205800.GB8300@neo.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050607205800.GB8300@neo.rr.com>
Organization: SuSE Linux AG
X-Operating-System: Linux 2.6.8-24.10-default i686
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 07, 2005 at 04:58:00PM -0400, Adam Belay wrote:
> On Tue, Jun 07, 2005 at 12:55:52PM +0200, Karsten Keil wrote:
> > On Mon, Jun 06, 2005 at 10:50:55PM -0400, Adam Belay wrote:
> > > On Mon, Jun 06, 2005 at 05:04:07PM -0700, Linus Torvalds wrote:
> > > > 
> > > > Jeff, 
> > > >  this looks ok, but I'll leave the decision to you. Things like this often 
> > > > break.
> > > > 
> > > > Andrew, maybe at least a few days in -mm to see if there's some outcry?
> > > > 
> > > > 		Linus
> > > 
> > > This patch is an improvement, but there may still be some issues.
> > > Specifically, it looks to me like the the interrupt handler remains
> > > registered.  This could cause some problems when another device is sharing
> > > the interrupt because the tulip driver must read from a hardware register
> > > to determine if it triggered the interrupt. When the hardware has been
> > > physically powered off, things might not go well.
> > 
> > No, I also looked into this, it is not needed for the tulip driver, it
> > detects that it has no access to the hardware (reading 0xffffffff) in the
> > interrupt functions.
> 
> Hmm, doesn't look like it:
> 
> >	/* Let's see whether the interrupt really is for us */
> >	csr5 = ioread32(ioaddr + CSR5);
> >
> >	if (tp->flags & HAS_PHY_IRQ) 
> >	        handled = phy_interrupt (dev);
> >    
> >	if ((csr5 & (NormalIntr|AbnormalIntr)) == 0)
> >		return IRQ_RETVAL(handled);
> 
> Upon reading the value 0xffffffff for csr5, the if statement would be false.
> Maybe it bails out later or something, but really why risk it?  As Ben noted,
> it's easy to have race conditions between power off and interrupt handler
> routines.  Also, there is a transition delay between D0 and D3.  I prefer to
> play it safe and call free_irq().

Yes it test later for 0xffffffff, but you are right, freeing the IRQ would
be safer.
...
> > 
> > I think restoring the PCI config should be done always, not only if the
> > device was in the up state, also powerup should be done.
> > If not you will run into problems to use the device later.
> 
> Yeah, I think you're right.
> 
> Also, after looking at some other netdev suspend routines, it appears that
> "netif_device_present" isn't necessary.  Jeff, is this correct?
> 
> Thanks,
> Adam
> 
> 
> How does this patch look:

Looks OK and also work on my HW.

Andrew, can you please take this updated version, it is much cleaner and
safer, because it handle the IRQ correctly.

> 
> --- a/drivers/net/tulip/tulip_core.c	2005-05-27 22:06:00.000000000 -0400
> +++ b/drivers/net/tulip/tulip_core.c	2005-06-07 16:34:13.641177456 -0400
> @@ -1756,11 +1756,19 @@
>  {
>  	struct net_device *dev = pci_get_drvdata(pdev);
>  
> -	if (dev && netif_running (dev) && netif_device_present (dev)) {
> -		netif_device_detach (dev);
> -		tulip_down (dev);
> -		/* pci_power_off(pdev, -1); */
> -	}
> +	if (!dev)
> +		return -EINVAL;
> +
> +	if (netif_running(dev))
> +		tulip_down(dev);
> +
> +	netif_device_detach(dev);
> +	pci_save_state(pdev);
> +
> +	free_irq(dev->irq, dev);
> +	pci_disable_device(pdev);
> +	pci_set_power_state(pdev, pci_choose_state(pdev, state));
> +
>  	return 0;
>  }
>  
> @@ -1768,15 +1776,26 @@
>  static int tulip_resume(struct pci_dev *pdev)
>  {
>  	struct net_device *dev = pci_get_drvdata(pdev);
> +	int retval;
>  
> -	if (dev && netif_running (dev) && !netif_device_present (dev)) {
> -#if 1
> -		pci_enable_device (pdev);
> -#endif
> -		/* pci_power_on(pdev); */
> -		tulip_up (dev);
> -		netif_device_attach (dev);
> +	if (!dev)
> +		return -EINVAL;
> +
> +	pci_set_power_state(pdev, PCI_D0);
> +	pci_restore_state(pdev);
> +
> +	pci_enable_device(pdev);
> +
> +	if ((retval = request_irq(dev->irq, &tulip_interrupt, SA_SHIRQ, dev->name, dev))) {
> +		printk (KERN_ERR "tulip: request_irq failed in resume\n");
> +		return retval;
>  	}
> +
> +	netif_device_attach(dev);
> +
> +	if (netif_running(dev))
> +		tulip_up(dev);
> +
>  	return 0;
>  }
>  

-- 
Karsten Keil
SuSE Labs
ISDN development
