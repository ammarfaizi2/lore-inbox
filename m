Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264007AbTJOSoH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Oct 2003 14:44:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263937AbTJOSnN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Oct 2003 14:43:13 -0400
Received: from mail.kroah.org ([65.200.24.183]:22967 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263938AbTJOSmR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Oct 2003 14:42:17 -0400
Date: Wed, 15 Oct 2003 11:41:04 -0700
From: Greg KH <greg@kroah.com>
To: Matthew Wilcox <willy@debian.org>
Cc: Linus Torvalds <torvalds@osdl.org>, "David S. Miller" <davem@redhat.com>,
       Jeff Garzik <jgarzik@pobox.com>, linux-pci@atrey.karlin.mff.cuni.cz,
       netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pci_get_slot()
Message-ID: <20031015184104.GA22373@kroah.com>
References: <20031015183213.GG16535@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031015183213.GG16535@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 15, 2003 at 07:32:13PM +0100, Matthew Wilcox wrote:
> 
> Hi Linus.
> 
> tg3.c has a bug where it can find the wrong 5704 peer on a machine with
> PCI domains.  The problem is that pci_find_slot() can't distinguish
> whether it has the correct domain or not.

The check of:
	if (dev->bus->number == bus && dev->devfn == devfn)
in pci_find_slot() doesn't check for the domain?

> 
> This patch fixes that problem by introducing pci_get_slot() and converts
> tg3 to use it.  It also fixes another problem where tg3 wouldn't find
> a peer on function 7 (0 to <8, not 0 to <7).

Ah, nice.  After telling you I would not accept this patch right now,
until after 2.6.0 comes out, you send it to Linus.  Really appreciate
that...

Anyway, is there any other way you can fix this in the tg3 driver only
for right now?  I agree adding the pci function is "cleaner", but a bit
late for right now.

>  /**
> + * pci_get_slot - locate PCI device for a given PCI slot
> + * @bus: PCI bus on which desired PCI device resides
> + * @devfn: encodes number of PCI slot in which the desired PCI 
> + * device resides and the logical device number within that slot 
> + * in case of multi-function devices.
> + *
> + * Given a PCI bus and slot/function number, the desired PCI device 
> + * is located in the list of PCI devices.
> + * If the device is found, its reference count is increased and this
> + * function returns a pointer to its data structure.  The caller must
> + * decrement the reference count by calling pci_dev_put().
> + * If no device is found, %NULL is returned.
> + */
> +struct pci_dev * pci_get_slot(struct pci_bus *bus, unsigned int devfn)
> +{
> +	struct list_head *tmp;
> +	struct pci_dev *dev;
> +
> +	WARN_ON(in_interrupt());
> +	spin_lock(&pci_bus_lock);
> +
> +	list_for_each(tmp, &bus->children) {
> +		dev = pci_dev_b(tmp);
> +		if (dev->devfn == devfn)
> +			goto out;
> +	}
> +
> +	dev = NULL;
> + out:
> +	pci_dev_get(dev);
> +	spin_unlock(&pci_bus_lock);
> +	return dev;
> +}

How does this differ from pci_find_slot()?  (becides the pci_dev_get()
call)?  pci_find_slot() asks for the bus number, which can be determined
from the pci_bus structure, right?

thanks,

greg k-h
