Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261276AbVFDHSb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261276AbVFDHSb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Jun 2005 03:18:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261277AbVFDHSb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Jun 2005 03:18:31 -0400
Received: from lyle.provo.novell.com ([137.65.81.174]:39549 "EHLO
	lyle.provo.novell.com") by vger.kernel.org with ESMTP
	id S261276AbVFDHSX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Jun 2005 03:18:23 -0400
Date: Sat, 4 Jun 2005 00:18:03 -0700
From: Greg KH <gregkh@suse.de>
To: Grant Grundler <grundler@parisc-linux.org>
Cc: tom.l.nguyen@intel.com, linux-pci@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org, roland@topspin.com, davem@davemloft.net
Subject: Re: pci_enable_msi() for everyone?
Message-ID: <20050604071803.GA13684@suse.de>
References: <20050603224551.GA10014@kroah.com> <20050604013112.GB16999@colo.lackof.org> <20050604064821.GC13238@suse.de> <20050604070537.GB8230@colo.lackof.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050604070537.GB8230@colo.lackof.org>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 04, 2005 at 01:05:37AM -0600, Grant Grundler wrote:
> On Fri, Jun 03, 2005 at 11:48:21PM -0700, Greg KH wrote:
> > > One complication is some drivers will want to register a different
> > > IRQ handler depending on if MSI is enabled or not.
> > 
> > That's fine, they can always check the device capabilities and do that.
> 
> Can you be more specific?
> Maybe a short chunk of psuedo code?

Hm, here's a possible function to do it (typed into my email client, not
compiled, no warranties, etc...):

/* returns 1 if device is in MSI mode, 0 otherwise */
int pci_in_msi_mode(struct pci_dev *dev)
{
	int pos;
	u16 control;

	pos = pci_find_capability(dev, PCI_CAP_ID_MSI);
	if (!pos)
		return 0;
	pci_read_config_word(dev, msi_control_reg(pos), &control);
	if (control & PCI_MSI_FLAGS_ENABLE);
		return 1;
	return 0;
}

> > > If MSI is enabled (and usable), then some MMIO reads can be omitted.
> > > I've posted a patch for tg3 driver:
> > > 	ftp://ftp.parisc-linux.org/patches/diff-2.6.10-tg3_MSI-03
> > > 
> > > (Just an example! It was not accepted because of buggy HW
> > >  though it worked great on the HW I have access to.)
> > > 
> > > drivers/infiniband/hw/mthca driver is another example.
> > 
> > But it doesn't do that yet either ;)
> 
> Sorry - only uses different IRQ handlers for MSI-X support.
> But it could do something different for MSI IRQ handlers as well.

Sure.

> > > How can the driver know which IRQ handlers to register?
> > 
> > Same as always, use the dev->irq field like they do today.
> 
> I think you misunderstood my question.
> The driver uses dev->irq as a "token" to register *some* IRQ handler.
> If the driver wants to register "tg3_irq_nommioread()" for the
> MSI case and "tg3_irq()" for Line Based IRQ case, how would the
> driver know which IRQ handler it should register?
> 
> The arch IRQ support knows the difference and currently returns
> that status in the pci_msi_enable() call.

If you use the above function, then you can tell the difference and
register different irq handlers if you wish.

The main point being is that the pci_enable_msi() function would not
have to be explicitly called by your driver, it would have already been
taken care of earlier by the PCI core.  That's what I want to do and am
wondering if there would be any bad side affects to it.

thanks,

greg k-h
