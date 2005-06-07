Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261773AbVFGDhW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261773AbVFGDhW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Jun 2005 23:37:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261797AbVFGDhW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Jun 2005 23:37:22 -0400
Received: from gate.crashing.org ([63.228.1.57]:64143 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261773AbVFGDhA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Jun 2005 23:37:00 -0400
Subject: Re: [PATCH] fix tulip suspend/resume
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Adam Belay <abelay@novell.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Karsten Keil <kkeil@suse.de>,
       Andrew Morton <akpm@osdl.org>, Jeff Garzik <jgarzik@pobox.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050607025054.GC3289@neo.rr.com>
References: <20050606224645.GA23989@pingi3.kke.suse.de>
	 <Pine.LNX.4.58.0506061702430.1876@ppc970.osdl.org>
	 <20050607025054.GC3289@neo.rr.com>
Content-Type: text/plain
Date: Tue, 07 Jun 2005 13:34:37 +1000
Message-Id: <1118115278.6850.48.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> This patch is an improvement, but there may still be some issues.
> Specifically, it looks to me like the the interrupt handler remains
> registered.  This could cause some problems when another device is sharing
> the interrupt because the tulip driver must read from a hardware register
> to determine if it triggered the interrupt. When the hardware has been
> physically powered off, things might not go well.
> 
> I can't comment on the netdev class aspect of this routine, but following
> a similar strategy to its original author, a fix might look like this:

Don't like it, see below.

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

Oh well... you are turning power back on ... but you don't know if you
_can_ ... what if your parent bridge has been disabled in some way ? Or
the clock generation on the bus stopped already ?

I think the kernel should warn & disable the IRQ if that happens
(basically you should return NOT_HANDLED)

> +		pci_restore_state(pdev);
> +
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

Also, isn't that racy vs. the code in suspend() anyway ? You need to
make sure you program your chip not to issue any interrupt and
synchronize proerly, then just "ignore" (don't handle) interrupts coming
in as they should not be for you.

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
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

