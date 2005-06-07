Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261602AbVFGK4I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261602AbVFGK4I (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Jun 2005 06:56:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261813AbVFGK4I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Jun 2005 06:56:08 -0400
Received: from ns2.suse.de ([195.135.220.15]:2995 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S261602AbVFGKzz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Jun 2005 06:55:55 -0400
Date: Tue, 7 Jun 2005 12:55:52 +0200
From: Karsten Keil <kkeil@suse.de>
To: Adam Belay <ambx1@neo.rr.com>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Jeff Garzik <jgarzik@pobox.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fix tulip suspend/resume
Message-ID: <20050607105552.GA27496@pingi3.kke.suse.de>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>,
	Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
	Jeff Garzik <jgarzik@pobox.com>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20050606224645.GA23989@pingi3.kke.suse.de> <Pine.LNX.4.58.0506061702430.1876@ppc970.osdl.org> <20050607025054.GC3289@neo.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050607025054.GC3289@neo.rr.com>
Organization: SuSE Linux AG
X-Operating-System: Linux 2.6.8-24.10-default i686
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 06, 2005 at 10:50:55PM -0400, Adam Belay wrote:
> On Mon, Jun 06, 2005 at 05:04:07PM -0700, Linus Torvalds wrote:
> > 
> > Jeff, 
> >  this looks ok, but I'll leave the decision to you. Things like this often 
> > break.
> > 
> > Andrew, maybe at least a few days in -mm to see if there's some outcry?
> > 
> > 		Linus
> 
> This patch is an improvement, but there may still be some issues.
> Specifically, it looks to me like the the interrupt handler remains
> registered.  This could cause some problems when another device is sharing
> the interrupt because the tulip driver must read from a hardware register
> to determine if it triggered the interrupt. When the hardware has been
> physically powered off, things might not go well.

No, I also looked into this, it is not needed for the tulip driver, it
detects that it has no access to the hardware (reading 0xffffffff) in the
interrupt functions.

> 
> I can't comment on the netdev class aspect of this routine, but following
> a similar strategy to its original author, a fix might look like this:
> 
> --- a/drivers/net/tulip/tulip_core.c	2005-05-27 22:06:00.000000000 -0400
> +++ b/drivers/net/tulip/tulip_core.c	2005-06-06 22:14:25.850846400 -0400
> @@ -1759,7 +1759,12 @@
>  	if (dev && netif_running (dev) && netif_device_present (dev)) {
>  		netif_device_detach (dev);
>  		tulip_down (dev);
> -		/* pci_power_off(pdev, -1); */
> +
> +		pci_save_state(pdev);
> +
> +		free_irq(dev->irq, dev);
> +		pci_disable_device(pdev);
> +		pci_set_power_state(pdev, pci_choose_state(pdev, state));
>  	}
>  	return 0;
>  }

Pavel told me, that pci_choose_state is not always safe, some cards maybe
do only work with PCI_D3hot properly, so it's better to use this now.
For my hardware it also seems to work with pci_choose_state.

> @@ -1768,12 +1773,19 @@
>  static int tulip_resume(struct pci_dev *pdev)
>  {
>  	struct net_device *dev = pci_get_drvdata(pdev);
> +	int retval;
>  
>  	if (dev && netif_running (dev) && !netif_device_present (dev)) {
> -#if 1
> -		pci_enable_device (pdev);
> -#endif
> -		/* pci_power_on(pdev); */
> +		pci_set_power_state(pdev, PCI_D0);
> +		pci_restore_state(pdev);
> +

I think restoring the PCI config should be done always, not only if the
device was in the up state, also powerup should be done.
If not you will run into problems to use the device later.

> +		pci_enable_device(pdev);
> +
> +		if ((retval = request_irq(dev->irq, &tulip_interrupt, SA_SHIRQ, dev->name, dev))) {
> +			printk (KERN_ERR "tulip: request_irq failed in resume\n");
> +			return retval;
> +		}
> +		
>  		tulip_up (dev);
>  		netif_device_attach (dev);
>  	}
> 
> I don't have this hardware, so any testing would be appreciated.
> 
> Thanks,
> Adam
> 
> 
> P.S.: I noticed this function in the tulip driver:
> 
> static void tulip_set_power_state (struct tulip_private *tp,
> 				   int sleep, int snooze)
> {
> 	if (tp->flags & HAS_ACPI) {
> 		u32 tmp, newtmp;
> 		pci_read_config_dword (tp->pdev, CFDD, &tmp);
> 		newtmp = tmp & ~(CFDD_Sleep | CFDD_Snooze);
> 		if (sleep)
> 			newtmp |= CFDD_Sleep;
> 		else if (snooze)
> 			newtmp |= CFDD_Snooze;
> 		if (tmp != newtmp)
> 			pci_write_config_dword (tp->pdev, CFDD, newtmp);
> 	}
> 
> }
> 
> Currently we aren't using CFDD_Sleep.  Should we call this in suspend?  It
> could be important if the hardware doesn't support PCI PM.  I don't really
> have any specifications or information about the hardware, so I'm at a loss
> here.

-- 
Karsten Keil
SuSE Labs
ISDN development
