Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261609AbSLERLt>; Thu, 5 Dec 2002 12:11:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261907AbSLERLt>; Thu, 5 Dec 2002 12:11:49 -0500
Received: from jurassic.park.msu.ru ([195.208.223.243]:10500 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id <S261609AbSLERLs>; Thu, 5 Dec 2002 12:11:48 -0500
Date: Thu, 5 Dec 2002 20:19:07 +0300
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: James Bottomley <James.Bottomley@steeleye.com>
Cc: mj@ucw.cz, linux-kernel@vger.kernel.org, mochel@osdl.org
Subject: Re: [BKPATCH] allow pci primary peer busses to have parents
Message-ID: <20021205201907.A721@jurassic.park.msu.ru>
References: <ink@jurassic.park.msu.ru> <200212051533.gB5FXTN02203@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200212051533.gB5FXTN02203@localhost.localdomain>; from James.Bottomley@steeleye.com on Thu, Dec 05, 2002 at 09:33:29AM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 05, 2002 at 09:33:29AM -0600, James Bottomley wrote:
> ink@jurassic.park.msu.ru said:
> > isa/pnp stuff. This will be absolutely required if DMA operations are
> > moved from pci_dev to the generic device. 
> 
> Well, we are moving in this direction.  I've already done the conversion for 
> MCA.  Marc Zyngier has done it for EISA.  I believe someone is looking at PnP 
> ISA.  ISA, as a non-probe'able bus fits into the legacy bus scheme anyway.

Nice to know. :-)
Current approach with initcalls doesn't work - basically, only architecture
specific code knows what bus types are primary and therefore should be
initialized first. IOW, it would be good to have something like you've
suggested for PCI for any bus type:

XXX_bus_init(struct device *parent, int busnum)

> > The `sysdata' arg already contains info about parent host-to-pci
> > controller on many platforms. I don't think that we need to duplicate
> > it with another one. I was thinking about something like this instead
> > of `sysdata': 
> 
> That's PCI specific.

Actually it isn't. It just happens to be that sysdata == pci_controller
on pci-based machines. However, these structures have very little to
do with PCI - it's all about IOMMUs, various address ranges and other
host-specific data.

>  We need a coherent tree in the generic model.  To do 
> this, the PCI parent information has to be available just using the struct 
> device, without having to cast it to pci_dev and look at pci specific fields.

Of course.

> This is a simplification requirement for machines whose IOMMUs lie on other 
> bus types above the PCI busses.

That's why I suggested `io_controller' name, but I can live with just
`sysdata' as well. :-)

> You have to be able to walk up the device 
> tree until you find the IOMMU.  Since you're sharing the implementation with 
> the non-PCI busses, you need to be able to do this in a generic manner.

Right, but walking up the entire tree every time is rather painful.
Things like pci^H^H^Hdma_map_{single,sg} are supposed to be fast, so I'd
like to gather IOMMU and other info directly from struct device * passed
as argument to these functions.

Ivan.
