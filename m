Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261426AbVBAS7g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261426AbVBAS7g (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 13:59:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261532AbVBAS7g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 13:59:36 -0500
Received: from mail.kroah.org ([69.55.234.183]:32721 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261426AbVBAS73 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 13:59:29 -0500
Date: Tue, 1 Feb 2005 10:58:59 -0800
From: Greg KH <greg@kroah.com>
To: Matthew Wilcox <matthew@wil.cx>
Cc: Brian King <brking@us.ibm.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Andi Kleen <ak@muc.de>, Paul Mackerras <paulus@samba.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [PATCH 1/1] pci: Block config access during BIST (resend)
Message-ID: <20050201185859.GA7174@kroah.com>
References: <20050113202354.GA67143@muc.de> <41ED27CD.7010207@us.ibm.com> <1106161249.3341.9.camel@localhost.localdomain> <41F7C6A1.9070102@us.ibm.com> <1106777405.5235.78.camel@gaston> <1106841228.14787.23.camel@localhost.localdomain> <41FA4DC2.4010305@us.ibm.com> <20050201072746.GA21236@kroah.com> <41FF9C78.2040100@us.ibm.com> <20050201154400.GC10088@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050201154400.GC10088@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 01, 2005 at 03:44:00PM +0000, Matthew Wilcox wrote:
> On Tue, Feb 01, 2005 at 09:12:56AM -0600, Brian King wrote:
> > Greg KH wrote:
> > >On Fri, Jan 28, 2005 at 08:35:46AM -0600, Brian King wrote:
> > >>+void pci_block_user_cfg_access(struct pci_dev *dev)
> > >>+{
> > >>+	unsigned long flags;
> > >>+
> > >>+	pci_save_state(dev);
> > >>+	spin_lock_irqsave(&pci_lock, flags);
> > >>+	dev->block_ucfg_access = 1;
> > >>+	spin_unlock_irqrestore(&pci_lock, flags);
> > >>+}
> > >>+EXPORT_SYMBOL(pci_block_user_cfg_access);
> > >
> > >
> > >EXPORT_SYMBOL_GPL() please?
> > 
> > Ok.
> 
> I'm not entirely convinced these should be GPL-only exports.  Basically,
> this is saying that any driver for a device that has this problem must be
> GPLd.  I think that's a firmer stance than Linus had in mind originally.

"originally"?  These are new functions added to the PCI core.  I think
that any driver that wants to use this functionality had better be
released under the GPL as what they are wanting to do is a "new" thing.

That's why I prefer all new exports to be marked _GPL.

thanks,

greg k-h
> > +void pci_unblock_user_cfg_access(struct pci_dev *dev)
> > +{
> > +	unsigned long flags;
> > +
> > +	spin_lock_irqsave(&pci_lock, flags);
> > +	dev->block_ucfg_access = 0;
> > +	spin_unlock_irqrestore(&pci_lock, flags);
> > +}
> 
> If we've done a write to config space while the adapter was blocked,
> shouldn't we replay those accesses at this point?

This has been discussed a lot already.  I think we might as well let the
thing fail in random and odd ways, as it's some pretty broken hardware
anyway that wants this functionality :)

thanks,

greg k-h
