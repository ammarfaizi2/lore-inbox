Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262416AbULQAH0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262416AbULQAH0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 19:07:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262693AbULQAHZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 19:07:25 -0500
Received: from mail.kroah.org ([69.55.234.183]:63201 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262416AbULQAGv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 19:06:51 -0500
Date: Thu, 16 Dec 2004 16:06:29 -0800
From: Greg KH <greg@kroah.com>
To: Pavel Machek <pavel@ucw.cz>, linux-pm@lists.osdl.org
Cc: kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@zip.com.au>
Subject: Re: Cleanup PCI power states
Message-ID: <20041217000629.GB11531@kroah.com>
References: <20041116130445.GA10085@elf.ucw.cz> <20041116155613.GA1309@kroah.com> <20041117120857.GA6952@openzaurus.ucw.cz> <20041124234057.GF4649@kroah.com> <20041125113913.GC1027@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041125113913.GC1027@elf.ucw.cz>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 25, 2004 at 12:39:13PM +0100, Pavel Machek wrote:
> Hi!
> 
> > > > > This is step 0 before adding type-safety to PCI layer... It introduces
> > > > > constants and uses them to clean driver up. I'd like this to go in
> > > > > now, so that I can convert drivers during 2.6.10... Please apply,
> > > > 
> > > > The tree is in "bugfix only" mode right now.  Changes like this need to
> > > > wait for 2.6.10 to come out before I can send it upward.
> > > > 
> > > > So, care to hold on to it for a while?  Or I can add it to my "to apply
> > > > after 2.6.10 comes out" tree, which will mean it will end up in the -mm
> > > > releases till that happens.
> > > 
> > > I think I'd prefer visibility of "to apply after 2.6.10" tree... Thanks,
> > 
> > Care to resend this, I seem to have lost them :(
> 
> Could this go to "after 2.6.10 tree", too? It is a helper that
> converts system state into PCI state. We really do not want to have
> this copied into every driver, because it will need to change when
> system state gets type-checked / expanded to struct.

So this is how you want to switch stuff over?  Can you give me an
example of how this will be used?

> --- clean/drivers/pci/pci.c	2004-10-01 00:30:16.000000000 +0200
> +++ linux/drivers/pci/pci.c	2004-11-14 23:36:46.000000000 +0100
> @@ -300,6 +300,30 @@
>  }
>  
>  /**
> + * pci_choose_state - Choose the power state of a PCI device
> + * @dev: PCI device to be suspended
> + * @state: target sleep state for the whole system
> + *
> + * Returns PCI power state suitable for given device and given system
> + * message.
> + */
> +
> +pci_power_t pci_choose_state(struct pci_dev *dev, u32 state)
> +{
> +	if (!pci_find_capability(dev, PCI_CAP_ID_PM))
> +		return PCI_D0;
> +
> +	switch (state) {
> +	case 0:	return PCI_D0;
> +	case 2: return PCI_D2;
> +	case 3: return PCI_D3hot;
> +	default: BUG();
> +	}
> +}
> +
> +EXPORT_SYMBOL(pci_choose_state);

EXPORT_SYMBOL_GPL() perhaps?

thanks,

greg k-h
