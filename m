Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262242AbULQAfZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262242AbULQAfZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 19:35:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262309AbULQAfZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 19:35:25 -0500
Received: from gprs215-223.eurotel.cz ([160.218.215.223]:51078 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S262242AbULQAfI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 19:35:08 -0500
Date: Fri, 17 Dec 2004 01:34:43 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Greg KH <greg@kroah.com>
Cc: linux-pm@lists.osdl.org, kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@zip.com.au>
Subject: Re: Cleanup PCI power states
Message-ID: <20041217003443.GF25573@elf.ucw.cz>
References: <20041116130445.GA10085@elf.ucw.cz> <20041116155613.GA1309@kroah.com> <20041117120857.GA6952@openzaurus.ucw.cz> <20041124234057.GF4649@kroah.com> <20041125113913.GC1027@elf.ucw.cz> <20041217000629.GB11531@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041217000629.GB11531@kroah.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > Care to resend this, I seem to have lost them :(
> > 
> > Could this go to "after 2.6.10 tree", too? It is a helper that
> > converts system state into PCI state. We really do not want to have
> > this copied into every driver, because it will need to change when
> > system state gets type-checked / expanded to struct.
> 
> So this is how you want to switch stuff over?  Can you give me an
> example of how this will be used?

Yes. Some way to convert between system-state and pci-state is needed;
for now it only silences warning, but I guess it will get more complex
in future.

Example is here:

--- clean/drivers/net/e100.c	2004-10-01 00:30:15.000000000 +0200
+++ linux/drivers/net/e100.c	2004-11-14 23:36:46.000000000 +0100
@@ -2313,7 +2313,7 @@
 	pci_save_state(pdev, nic->pm_state);
 	pci_enable_wake(pdev, state, nic->flags & (wol_magic | e100_asf(nic)));
 	pci_disable_device(pdev);
-	pci_set_power_state(pdev, state);
+	pci_set_power_state(pdev, pci_choose_state(pdev, state));
 
 	return 0;
 }
@@ -2323,7 +2323,7 @@
 	struct net_device *netdev = pci_get_drvdata(pdev);
 	struct nic *nic = netdev_priv(netdev);
 
-	pci_set_power_state(pdev, 0);
+	pci_set_power_state(pdev, PCI_D0);
 	pci_restore_state(pdev, nic->pm_state);
 	e100_hw_init(nic);
 

> > --- clean/drivers/pci/pci.c	2004-10-01 00:30:16.000000000 +0200
> > +++ linux/drivers/pci/pci.c	2004-11-14 23:36:46.000000000 +0100
> > @@ -300,6 +300,30 @@
> >  }
> >  
> >  /**
> > + * pci_choose_state - Choose the power state of a PCI device
> > + * @dev: PCI device to be suspended
> > + * @state: target sleep state for the whole system
> > + *
> > + * Returns PCI power state suitable for given device and given system
> > + * message.
> > + */
> > +
> > +pci_power_t pci_choose_state(struct pci_dev *dev, u32 state)
> > +{
> > +	if (!pci_find_capability(dev, PCI_CAP_ID_PM))
> > +		return PCI_D0;
> > +
> > +	switch (state) {
> > +	case 0:	return PCI_D0;
> > +	case 2: return PCI_D2;
> > +	case 3: return PCI_D3hot;
> > +	default: BUG();
> > +	}
> > +}
> > +
> > +EXPORT_SYMBOL(pci_choose_state);
> 
> EXPORT_SYMBOL_GPL() perhaps?

Ugh, I do not have any strong feelings here, but I want nvidia etc to
use this one so that they implement driver model properly.

								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
