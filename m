Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317400AbSHOUTs>; Thu, 15 Aug 2002 16:19:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317404AbSHOUTs>; Thu, 15 Aug 2002 16:19:48 -0400
Received: from petasus.ch.intel.com ([143.182.124.5]:15809 "EHLO
	petasus.ch.intel.com") by vger.kernel.org with ESMTP
	id <S317400AbSHOUTq>; Thu, 15 Aug 2002 16:19:46 -0400
Message-ID: <EDC461A30AC4D511ADE10002A5072CAD0236DD9A@orsmsx119.jf.intel.com>
From: "Grover, Andrew" <andrew.grover@intel.com>
To: "'Patrick Mochel'" <mochel@osdl.org>
Cc: "'colpatch@us.ibm.com'" <colpatch@us.ibm.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
       linux-kernel@vger.kernel.org, Michael Hohnbaum <hohnbaum@us.ibm.com>,
       Greg KH <gregkh@us.ibm.com>, jgarzik@mandrakesoft.com
Subject: RE: [patch] PCI Cleanup
Date: Thu, 15 Aug 2002 13:23:19 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Patrick Mochel [mailto:mochel@osdl.org] 
> > ACPI needs access to PCI config space, and it doesn't have 
> a struct pci_dev
> > to pass to access functions. It doesn't look like your 
> patch exposes an
> > interface that 1) doesn't require a pci_dev and 2) 
> abstracts the PCI config
> > access method, does it?
> 
> I think your dependencies are backwards. IIRC, and based on a recent 
> conversation, ACPI needs to access PCI config space when ACPI finds a 
> _INI method for a device in the ACPI namespace. That assumes 
> that it can 
> access the root bus that the device is on. 
> 
> You don't have a PCI device because you haven't implement lockstep 
> enumeration yet in ACPI. With lockstep enumeration, you would 
> add devices 
> to the device tree and let the bus drivers initialize them. 
> With a bit a 
> glue, you would have a pointer to the PCI device correlating 
> to the ACPI 
> namespace object, and a pointer to the PCI bus on which each PCI 
> device/namespace object resides. 
> 
> To spell it out a bit more explicitly, you would start to 
> parse the ACPI
> namespace and find a Host/PCI bridge. You would tell the PCI 
> subsystem to
> probe for a device at that address. It would come back 
> successful, and you
> would obtain a pointer to that bridge device (and bus 
> object). For all the
> subordinate devices to that bridge, you then have access to the config
> space via a real struct pci_bus.

Yes, except that to find the host/pci bridge for bus 0, for example, I need
to run _INI on the device before I run _HID (which is the method that
returns the PNPID). _INI can theoretically access a bus 0 pci config
operation region.

People have mentioned to me that this is unpleasant and I agree, but the
ACPI spec *specifically* says that bus 0 pci config access is always
available.

That said, maybe it is better to keep ugliness caused by ACPI in the ACPI
driver, so if you want to have interfaces that depend on struct pci_dev or
pci_bus, fine, and the ACPI driver can generate a temporary one in order to
call the function. This completely violates the abstraction you are creating
but sssh we won't tell anyone. ;)

BTW this is not just a matter of spec compliance. Some machines actually
didn't work until this was implemented originally.

> If you remember, I sent you a patch that did most of this 
> about 5 months 
> ago. It's a bit out of date, and I guarantee that it doesn't apply 
> anymore. But the concept is the same: we should fix the 
> drivers, not hack 
> them to support a broken interface.

Is this the one that was on bkbits.net for a while? I liked a lot of what
you did with that, but I was so busy with other stuff I didn't get a chance
to pull it in before it got too stale... :(

Regards -- Andy
