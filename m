Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265607AbSKAEq4>; Thu, 31 Oct 2002 23:46:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265614AbSKAEq4>; Thu, 31 Oct 2002 23:46:56 -0500
Received: from momus.sc.intel.com ([143.183.152.8]:57071 "EHLO
	momus.sc.intel.com") by vger.kernel.org with ESMTP
	id <S265607AbSKAEqw>; Thu, 31 Oct 2002 23:46:52 -0500
Message-ID: <72B3FD82E303D611BD0100508BB29735046DFF6E@orsmsx102.jf.intel.com>
From: "Lee, Jung-Ik" <jung-ik.lee@intel.com>
To: "'Greg KH'" <greg@kroah.com>
Cc: "'linux-kernel'" <linux-kernel@vger.kernel.org>
Subject: RE: RFC: bare pci configuration access functions ?
Date: Thu, 31 Oct 2002 20:52:24 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Minor fix to the code.
A patch to a flying patch ;-)

Thanks,
J.I.
=====================================================
static struct pci_bus *get_pci_bus(s, b, d, f)
{
	struct pci_bus *bus;
	struct pci_dev *dev = pci_find_slot(s, b, d+f);

	if (dev && dev->bus)
		bus = dev->bus;
	else	// dup pci_bus w/ root & set bus->number=b
		bus = get_fake_pci_bus(b);

	return bus;
}

int pci_config_{read|write}(
#ifdef WANT_PCI_BUS_PARAM
		pci_bus, 
#endif
			s, b, d, f, w, size, v)
{
	struct pci_bus *bus;
#ifdef WANT_PCI_BUS_PARAM
	if (valid(pci_bus))
		bus = pci_bus;
	else
#endif
	bus = get_pci_bus(s, b, d, f);
	if (!bus)
		return error;

	switch (size) {
	case byte:
		ret = pci_bus_{read|write}_##size (bus, d+f, w, v);
		break;
	...
	}
	return ret;
}

EXPORT_SYMBOL(pci_config_{read|write});
> > 
> > > OK, if simple and pure pci config access is not possible in 
> > Linux land,
> > > let pci driver fake itself, not everyone else :)
> > > Just export the two APIs like 
> pci_config_{read|write}(s,b,d,f,s,v),
> > > or the ones in acpi driver. Hide the fake pci_bus 
> > manipulation in them. 
> > > This way is way better than having everyone fake pci driver ;-)
> > 
> > I agree.  But can we do this for all archs?  I don't know, and look
> > forward to your patch proving this will work.  Without all 
> > arch support
> > of this, I can't justify only exporting the functions for 
> > i386 and ia64.
> 
> How about the followings ?
> It's for all architecture.
> 
> thanks,
> J.I.
> 
> static struct pci_bus *get_pci_bus(s, b, d, f)
> {
> 	struct pci_bus *bus;
> 	struct pci_dev *dev = pci_find_slot(s, b, d+f);
> 
> 	if (dev && dev->bus)
> 		bus = dev->bus;
> 	else	// dup pci_bus w/ root & set bus->number=b
> 		bus = get_fake_pci_bus(b);
> 
> 	return bus;
> }
> 
> int pci_config_{read|write}(
> #ifdef WANT_PCI_BUS_PARAM
> 		pci_bus, 
> #endif
> 			s, b, d, f, w, size, v)
> {
> 	struct pci_bus *bus;
> #ifdef WANT_PCI_BUS_PARAM
> 	if (!valid(pci_bus))	// null or invalid
> #endif
> 	bus = get_pci_bus(s, b, d, f);
> 	if (!bus)
> 		return error;
> 
> 	switch (size) {
> 	case byte:
> 		ret = pci_bus_{read|write}_##size (bus, d+f, w, v);
> 		break;
> 	...
> 	}
> 
> 	return ret;
> }
> 
> EXPORT_SYMBOL(pci_config_{read|write});
> 
