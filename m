Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317305AbSHOSUf>; Thu, 15 Aug 2002 14:20:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317306AbSHOSUf>; Thu, 15 Aug 2002 14:20:35 -0400
Received: from air-2.osdl.org ([65.172.181.6]:51417 "EHLO cherise.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S317305AbSHOSUe>;
	Thu, 15 Aug 2002 14:20:34 -0400
Date: Thu, 15 Aug 2002 11:28:51 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@cherise.pdx.osdl.net
To: "Grover, Andrew" <andrew.grover@intel.com>
cc: "'colpatch@us.ibm.com'" <colpatch@us.ibm.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
       <linux-kernel@vger.kernel.org>, Michael Hohnbaum <hohnbaum@us.ibm.com>,
       Greg KH <gregkh@us.ibm.com>, <jgarzik@mandrakesoft.com>,
       "Diefenbaugh, Paul S" <paul.s.diefenbaugh@intel.com>
Subject: RE: [patch] PCI Cleanup
In-Reply-To: <EDC461A30AC4D511ADE10002A5072CAD0236DD92@orsmsx119.jf.intel.com>
Message-ID: <Pine.LNX.4.44.0208151104170.1241-100000@cherise.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> ACPI needs access to PCI config space, and it doesn't have a struct pci_dev
> to pass to access functions. It doesn't look like your patch exposes an
> interface that 1) doesn't require a pci_dev and 2) abstracts the PCI config
> access method, does it?

I think your dependencies are backwards. IIRC, and based on a recent 
conversation, ACPI needs to access PCI config space when ACPI finds a 
_INI method for a device in the ACPI namespace. That assumes that it can 
access the root bus that the device is on. 

You don't have a PCI device because you haven't implement lockstep 
enumeration yet in ACPI. With lockstep enumeration, you would add devices 
to the device tree and let the bus drivers initialize them. With a bit a 
glue, you would have a pointer to the PCI device correlating to the ACPI 
namespace object, and a pointer to the PCI bus on which each PCI 
device/namespace object resides. 

To spell it out a bit more explicitly, you would start to parse the ACPI
namespace and find a Host/PCI bridge. You would tell the PCI subsystem to
probe for a device at that address. It would come back successful, and you
would obtain a pointer to that bridge device (and bus object). For all the
subordinate devices to that bridge, you then have access to the config
space via a real struct pci_bus.

There is no need to modify the PCI interface to support a fake device. The 
PCI driver needs to be able to add and probe for devices as dictated by 
someone else, but it's not that difficult.

If you remember, I sent you a patch that did most of this about 5 months 
ago. It's a bit out of date, and I guarantee that it doesn't apply 
anymore. But the concept is the same: we should fix the drivers, not hack 
them to support a broken interface.

	-pat

