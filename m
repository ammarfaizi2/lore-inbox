Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261262AbVFDGwK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261262AbVFDGwK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Jun 2005 02:52:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261276AbVFDGwJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Jun 2005 02:52:09 -0400
Received: from lyle.provo.novell.com ([137.65.81.174]:22396 "EHLO
	lyle.provo.novell.com") by vger.kernel.org with ESMTP
	id S261262AbVFDGvp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Jun 2005 02:51:45 -0400
Date: Fri, 3 Jun 2005 23:51:26 -0700
From: Greg KH <gregkh@suse.de>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: tom.l.nguyen@intel.com, linux-pci@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org, roland@topspin.com, davem@davemloft.net,
       Michael Chan <mchan@broadcom.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: pci_enable_msi() for everyone?
Message-ID: <20050604065126.GD13238@suse.de>
References: <20050603224551.GA10014@kroah.com> <42A0E4B4.3050309@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42A0E4B4.3050309@pobox.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 03, 2005 at 07:16:04PM -0400, Jeff Garzik wrote:
> Greg KH wrote:
> >In talking with a few people about the MSI kernel code, they asked why
> >we can't just do the pci_enable_msi() call for every pci device in the
> >system (at somewhere like pci_enable_device() time or so).  That would
> >let all drivers and devices get the MSI functionality without changing
> >their code, and probably make the api a whole lot simpler.
> 
> Agreed.
> 
> And now is a good time to make changes, before bunches of drivers start 
> using pci_enable_msi().  I am preparing such a change for the AHCI 
> driver (see attached), which will be the standard SATA interface on most 
> new motherboards.

Yes, roll that pci_intx() into the core and have it do the
pci_disable_msi() also if needed would be what I am thinking of.

> >Now I know the e1000 driver would have to specifically disable MSI for
> >some of their broken versions, and possibly some other drivers might
> >need this, but the downside seems quite small.
> 
> tg3 needs to deal with some broken system chipsets as well.  See
> tg3_test_msi(), which I would eventually prefer to eliminate in favor of 
> PCI quirks and such.

Ok, that's fine.

> An API note of warning though...   IMO eventually different drivers are 
> going to want different behavior from pci_enable_device().  IDE already 
> hacks around this, as Alan was required to do a while ago (IDE has a 
> weird PCI BAR setup sometimes, requiring care during enabling).
> 
> Longer term, I think we will need a
> 
> 	pci_enable(info on what to enable)
> 
> so that drivers can specify ahead of time "don't enable PIO, only MMIO", 
> "don't enable MMIO, only PIO", "don't use MSI", etc.  and add a 
> pci_disable() to undo all of that.

Yes, I agree, but let's start with baby steps :)

> The more we add singleton functions like pci_enable_msi(), 
> pci_set_master(), etc. the more I wish for a single function that 
> handled all those details at one atomic point.  There is a lot of 
> standard patterns that are hand-coded into every PCI driver's probe 
> functions.

Also agreed.

thanks,

greg k-h
