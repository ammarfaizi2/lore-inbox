Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263779AbTEWGrw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 May 2003 02:47:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263790AbTEWGrw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 May 2003 02:47:52 -0400
Received: from granite.he.net ([216.218.226.66]:62214 "EHLO granite.he.net")
	by vger.kernel.org with ESMTP id S263779AbTEWGrs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 May 2003 02:47:48 -0400
Date: Fri, 23 May 2003 00:02:15 -0700
From: Greg KH <greg@kroah.com>
To: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI changes for 2.5.69
Message-ID: <20030523070215.GA9785@kroah.com>
References: <10536411604060@kroah.com> <10536411602454@kroah.com> <20030523070715.A5038@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030523070715.A5038@infradead.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 23, 2003 at 07:07:15AM +0100, Christoph Hellwig wrote:
> On Thu, May 22, 2003 at 03:06:01PM -0700, Greg KH wrote:
> > ChangeSet 1.1210, 2003/05/22 10:30:35-07:00, greg@kroah.com
> > 
> > PCI: add pci_get_dev() and pci_put_dev()
> > 
> > Move the PCI core to start using these, enabling proper reference counting
> > on struct pci_dev.
> > 
> > 
> >  drivers/pci/bus.c        |    2 +-
> >  drivers/pci/hotplug.c    |    2 +-
> >  drivers/pci/pci-driver.c |   41 +++++++++++++++++++++++++++++++++++++++++
> >  drivers/pci/probe.c      |   18 ++++++++++++++++++
> >  include/linux/pci.h      |    2 ++
> >  5 files changed, 63 insertions(+), 2 deletions(-)
> > 
> > 
> > diff -Nru a/drivers/pci/bus.c b/drivers/pci/bus.c
> > --- a/drivers/pci/bus.c	Thu May 22 14:50:44 2003
> > +++ b/drivers/pci/bus.c	Thu May 22 14:50:44 2003
> > @@ -92,7 +92,7 @@
> >  		if (!list_empty(&dev->global_list))
> >  			continue;
> >  
> > -		device_register(&dev->dev);
> > +		device_add(&dev->dev);
> 
> This doesn't match the patch description..

Yes it does.  "Move the PCI core to start..." describes exactly this
portion of the patch.  We have to change from device_register() to
device_add() if we want to grab a reference count on the pci device
before we register it with the driver core.  Which we do want to do,
because of the two stage process of creating and registering pci
devices.

> > +struct pci_dev *pci_get_dev (struct pci_dev *dev)
> 
> Please fix up to adhere Documentation/CodingStyle (hint: placement
> of the opening brace is wrong).

CodingStyle doesn't _explicitly_ say that this is not allowed :)

I'll fix it next set of pci patches...

> > +{
> > +	struct device *tmp;
> > +
> > +	if (!dev)
> > +		return NULL;
> 
> Does it make sense to allow NULL argument here?

Just being safe.  We can drop it if it really annoys you, but other
subsystems do the same thing.

greg k-h
