Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261452AbVFHR4x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261452AbVFHR4x (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 13:56:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261456AbVFHR4x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 13:56:53 -0400
Received: from mail.kroah.org ([69.55.234.183]:60340 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261452AbVFHR4m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 13:56:42 -0400
Date: Wed, 8 Jun 2005 10:56:02 -0700
From: Greg KH <gregkh@suse.de>
To: Andi Kleen <ak@suse.de>
Cc: Greg KH <gregkh@suse.de>, Jeff Garzik <jgarzik@pobox.com>,
       "David S. Miller" <davem@davemloft.net>, tom.l.nguyen@intel.com,
       roland@topspin.com, linux-pci@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] PCI: remove access to pci_[enable|disable]_msi() for drivers - take 2
Message-ID: <20050608175602.GA3846@kroah.com>
References: <20050607002045.GA12849@suse.de> <20050607202129.GB18039@kroah.com> <20050608133109.GQ23831@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050608133109.GQ23831@wotan.suse.de>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 08, 2005 at 03:31:09PM +0200, Andi Kleen wrote:
> On Tue, Jun 07, 2005 at 01:21:29PM -0700, Greg KH wrote:
> > Hm, here's an updated patch that should have fixed the errors I had in
> > my previous one where I wasn't disabling MSI for the devices that did
> > not want it enabled (note, my patch skips the hotplug and pcie driver
> > for now, those would have to be fixed if this patch goes on.)
> > 
> > However, now that I've messed around with the MSI-X logic in the IB
> > driver, I'm thinking that this whole thing is just pointless, and I
> > should just drop it and we should stick with the current way of enabling
> > MSI only if the driver wants it.  If you look at the logic in the mthca
> > driver you'll see what I mean.
> 
> The problem is then that we have to go through all drivers and
> add the ugly logic there. Isnt it better to do it by default?

No, the logic to enable MSI in a driver today is simple, and
straight-forward.  A single call to pci_enable_msi().  If instead the
driver wants to enable MSI-X, they call pci_enable_msix().  Contrast
that with the logic of:
	- if MSI is enabled, disable it for some devices.
	- if driver wants to enable MSI-X, do:
		pci_disable_msi();
		e = pci_enable_msix();	// which I think some people
					// said will always fail anyway
					// due to MSI being enabled
					// already.
		if (e)
			pci_enable_msi();

So, we do that, MSI-X is now more complex and harder to enable (and
that's the future for PCI devices from what people are saying.)

Anyway, I'm just repeating myself now...

thanks,

greg k-h
