Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751351AbWAKEOc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751351AbWAKEOc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 23:14:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751354AbWAKEOc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 23:14:32 -0500
Received: from mail.kroah.org ([69.55.234.183]:11728 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751351AbWAKEOb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 23:14:31 -0500
Date: Tue, 10 Jan 2006 17:26:25 -0800
From: Greg KH <greg@kroah.com>
To: Shaohua Li <shaohua.li@intel.com>
Cc: Matthew Wilcox <matthew@wil.cx>, Andrew Morton <akpm@osdl.org>,
       linux-pci <linux-pci@atrey.karlin.mff.cuni.cz>,
       lkml <linux-kernel@vger.kernel.org>,
       Rajesh Shah <rajesh.shah@intel.com>
Subject: Re: [PATCH 1/2]MSI(X) save/restore for suspend/resume
Message-ID: <20060111012625.GA29108@kroah.com>
References: <1135649077.17476.14.camel@sli10-desk.sh.intel.com> <20060103231304.56e3228b.akpm@osdl.org> <1136422680.30655.1.camel@sli10-desk.sh.intel.com> <20060110202841.GZ19769@parisc-linux.org> <1136942240.5750.35.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1136942240.5750.35.camel@sli10-desk.sh.intel.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 11, 2006 at 09:17:19AM +0800, Shaohua Li wrote:
> On Tue, 2006-01-10 at 13:28 -0700, Matthew Wilcox wrote:
> > On Thu, Jan 05, 2006 at 08:58:00AM +0800, Shaohua Li wrote:
> > > +	if ((pos = pci_find_capability(dev, PCI_CAP_ID_MSIX)) <= 0 ||
> > > +		dev->no_msi)
> > 
> > No assignments within conditionals, please.
> Ok.
> 
> > 	pos = pci_find_capability(dev, PCI_CAP_ID_MSIX);
> > 	if (pos <= 0 || dev->no_msi)
> > 
> > >  	u32		saved_config_space[16]; /* config space saved at suspend time */
> > > +	void		*saved_cap_space[PCI_CAP_ID_MAX + 1]; /* ext config space saved at suspend time */
> > >  	struct bin_attribute *rom_attr; /* attribute descriptor for sysfs ROM entry */
> > ...
> > >  #define  PCI_CAP_ID_MSIX	0x11	/* MSI-X */
> > > +#define PCI_CAP_ID_MAX		PCI_CAP_ID_MSIX
> > >  #define PCI_CAP_LIST_NEXT	1	/* Next capability in the list */
> > 
> > Rather than taking all this space in the pci_dev structure (even
> > without CONFIG_PM), how about:
> > 
> > struct pci_cap_saved_state {
> > 	struct pci_cap_saved_state *next;
> > 	char cap_nr;
> > 	char data[0];
> > }
> > 
> > and then just add:
> > 
> > 	struct pci_cap_saved_state *saved_cap_space;
> > 
> > to the struct pci_dev?  One pointer, rather than (currently!) 12.
> > That's an 88 byte saving per PCI device on 64-bit machines!
> It's not that big, right? This will make things a little complex. How
> about just define saved_cap_space[] with CONFIG_PM configured? Anyway,
> if you insist on less space, I'm happy to change it.

A pointer to the structure is much nicer, I'd recommend doing it that
way.

thanks,

greg k-h
