Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265974AbSKIP1W>; Sat, 9 Nov 2002 10:27:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265975AbSKIP1W>; Sat, 9 Nov 2002 10:27:22 -0500
Received: from host194.steeleye.com ([66.206.164.34]:45583 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S265974AbSKIP1V>; Sat, 9 Nov 2002 10:27:21 -0500
Message-Id: <200211091533.gA9FXuW02017@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: Greg KH <greg@kroah.com>
cc: Matthew Wilcox <willy@debian.org>, "Adam J. Richter" <adam@yggdrasil.com>,
       andmike@us.ibm.com, hch@lst.de, James.Bottomley@SteelEye.com,
       linux-kernel@vger.kernel.org, mochel@osdl.org,
       parisc-linux@lists.parisc-linux.org
Subject: Re: [parisc-linux] Untested port of parisc_device to generic device 
 interface
In-Reply-To: Message from Greg KH <greg@kroah.com> 
   of "Fri, 08 Nov 2002 22:03:42 PST." <20021109060342.GA7798@kroah.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 09 Nov 2002 10:33:56 -0500
From: "J.E.J. Bottomley" <James.Bottomley@steeleye.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

First off, lets remember that this discussion started over two different, but 
related, problem sets.  One was the DMA api and the other was the device model.

As far as the DMA API goes, consistent memory allocation has always annoyed me 
because there are three separate cases

1. machine is consistent, consistent allocation always succeeds (unless we're 
out of memory)

2. machine is fully inconsistent, consistent allocation always fails.

3. Machine is partially consistent.  consistent allocation may fail because 
we're out of consistent memory so we have to fall back to the old.

What I'd like is an improvement to the DMA API where drivers can advertise 
levels of conformance (I only work with consistent memory or I work correctly 
with any dma'able memory and do all the sync points), and where all the sync 
point stuff optimises out for a machine architecture which is recognisably 
fully consistent at compile time.

Ok, I'll get off my soapbox now.  I never quite recovered from the awful 
#ifdef mess that doing the above correctly for the parisc introduced into the 
53c700 driver...

As far as the device model goes:

greg@kroah.com said:
> No, lets start pulling stuff out of pci_dev and relying on struct
> device.  The reason this hasn't happened yet is no one has been
> willing to break all of the PCI drivers, yet. 

I'd like to see that.  It's always annoyed me that my MCA machines have to 
bounce highmem just because they don't have a pci_dev to put the bounce mask 
in.

> The SCSI people are being drug kicking and screaming into it,
> _finally_ now (hell, SCSI is still not using the updated PCI
> interface, those people _never_ update their drivers if they can avoid
> it.)

That't not entirely fair.  Most of the unbroken drivers in the tree (those 
with active 2.5 maintainers) are using the up to date pci/dma interface.  The 
mid layer is `sort of' using the device api.

Where I'd like to see the device model go for SCSI is:

- we have a device node for every struct scsi_device (even unattached ones)

- unattached devices are really minimal entities with as few resources 
allocated as we can get away with, so we can have lazy attachment more easily.

- on attachment, the device node gets customised by the attachment type (and 
remember, we can have more than one attachment).

- whatever the permanent `name' field for the device is going to be needs to 
be writeable from user level, that way it can eventually be determined by the 
user level and simply written there as a string (rather than having all the 
wwn fallback cruft in the mid-layer).

- Ultimately, I'd like us to dump the host/channel/target numbering scheme in 
favour of the unique device node name (we may still number them in the 
mid-layer for convenience) so that we finesse the FC mapping problems---FC 
devices can embed the necessary identification in the target strings.

- Oh, and of course, we move to a hotplug/coldplug model where the root device 
is attached in initramfs and everything else is discovered in user space from 
the boot process.

> Patches for this stuff are going to be happening for quite some time
> now, don't despair.

> And they are greatly appreciated, and welcomed from everyone :) 

As far as extending the generic device model goes, I'll do it for the MCA bus. 
 I have looked at doing it previously, but giving the MCA bus a struct pci_dev 
is a real pain because of the underlying assumptions when one of these exists 
in an x86 machine.

But, while were on the subject of sorting out the device model abstraction, 
does the `power' node entry really belong at the top level?  It serves no 
purpose for something like a legacy MCA bus.

James


