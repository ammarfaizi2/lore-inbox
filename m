Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317473AbSHOUqx>; Thu, 15 Aug 2002 16:46:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317482AbSHOUqx>; Thu, 15 Aug 2002 16:46:53 -0400
Received: from air-2.osdl.org ([65.172.181.6]:6106 "EHLO cherise.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S317473AbSHOUqR>;
	Thu, 15 Aug 2002 16:46:17 -0400
Date: Thu, 15 Aug 2002 13:54:54 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@cherise.pdx.osdl.net
To: "Grover, Andrew" <andrew.grover@intel.com>
cc: linux-kernel@vger.kernel.org
Subject: RE: [patch] PCI Cleanup
In-Reply-To: <EDC461A30AC4D511ADE10002A5072CAD0236DD9A@orsmsx119.jf.intel.com>
Message-ID: <Pine.LNX.4.44.0208151334070.1241-100000@cherise.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[ cc list trimmed ]

> > To spell it out a bit more explicitly, you would start to 
> > parse the ACPI
> > namespace and find a Host/PCI bridge. You would tell the PCI 
> > subsystem to
> > probe for a device at that address. It would come back 
> > successful, and you
> > would obtain a pointer to that bridge device (and bus 
> > object). For all the
> > subordinate devices to that bridge, you then have access to the config
> > space via a real struct pci_bus.
> 
> Yes, except that to find the host/pci bridge for bus 0, for example, I need
> to run _INI on the device before I run _HID (which is the method that
> returns the PNPID). _INI can theoretically access a bus 0 pci config
> operation region.

Side question: if you can't run _HID, how do you know it's a PCI bridge? 
Or, if you can't run _HID, is there any way to determine that it's a 
Host/PCI bridge?

> People have mentioned to me that this is unpleasant and I agree, but the
> ACPI spec *specifically* says that bus 0 pci config access is always
> available.

I thought it was just the root bus that a device was on: either bus 0, or 
the bus specified by _BBN. For most systems it will be bus 0. 

> That said, maybe it is better to keep ugliness caused by ACPI in the ACPI
> driver, so if you want to have interfaces that depend on struct pci_dev or
> pci_bus, fine, and the ACPI driver can generate a temporary one in order to
> call the function. This completely violates the abstraction you are creating
> but sssh we won't tell anyone. ;)

Actually, there shouldn't be much magic involved, if any at all. 

The idea behind the patch I sent you before went something like this:

The ACPI namespace parser starts scans the namespace, before any PCI 
config access has been determined. This won't get you very many objects, 
because you won't be able to scan behind the bridges. 

You take that list and start adding devices to the device tree. This uses 
some new interfaces that allow you to tell the bus drivers that a bridge 
or device exists at a specific address. 

When you add a bridge, the bus driver will scan behind it. For each device 
it finds, it calls platform_notify(), which you will implement. This can 
then scan the namespace behind that object, and find more child objects, 
and add them into the device tree. 

There is some implicit recursion in that in the way I described it. It 
doesn't have to, though I don't remember exactly what I did. 

So, for bus 0, you don't have to wait and find it. You can hardcode it in 
there, and tell the system to look for it when you first start up. This is 
basically what the x86 arch code does: it assumes there is a bus 0 and 
starts scanning behind it. 

You'd do the same thing, which sounds like a step backward. But, with the 
lockstep process, you would get to do everything you need to do. Right?

> > If you remember, I sent you a patch that did most of this 
> > about 5 months 
> > ago. It's a bit out of date, and I guarantee that it doesn't apply 
> > anymore. But the concept is the same: we should fix the 
> > drivers, not hack 
> > them to support a broken interface.
> 
> Is this the one that was on bkbits.net for a while? I liked a lot of what
> you did with that, but I was so busy with other stuff I didn't get a chance
> to pull it in before it got too stale... :(

Yes, that's the one. It's on my short list of things to update, which is 
long enough as it is. :/

	-pat

